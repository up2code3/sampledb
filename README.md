## Tables and Models

```
users
  id
  email (unique, not null)
  username (unique, not null)
  timestamps

artists
  id
  name (not null, indexed)
  timestamps

entries
  id
  user_id      (FK → users, not null)
  artist_id    (FK → artists, not null)
  title        (not null, indexed)
  bpm          (integer ≥ 0, nullable allowed)
  key          (string, e.g., "A minor")
  year         (integer, not null)
  notes        (text)
  video_url    (string, optional)
  timestamps

samples  (self-referential join: entries <-> entries)
  id
  sampler_entry_id  (FK → entries, not null)
  sampled_entry_id  (FK → entries, not null)
  timestamps
  unique [sampler_entry_id, sampled_entry_id]  // sample relations must be unique
  check  sampler_entry_id ≠ sampled_entry_id   // a song can't sample itself

sample_segments  (timestamped sample moments within songs)
  id
  sample_id   (FK → samples, not null)
  start_time  (integer, not null, in seconds)
  timestamps

comments
  id
  user_id   (FK → users, not null)
  entry_id  (FK → entries, not null)
  body      (text, not null)
  timestamps
```


## Associations

```
User
  has_many :entries
  has_many :comments

Artist
  has_many :entries

Entry
  belongs_to :user
  belongs_to :artist
  has_many :comments, dependent: :destroy

  # Sampling (relationships)

  # The song doing the sampling
  has_many :samples_used,
           class_name: "Sample",
           foreign_key: :sampler_entry_id,
           dependent: :destroy
  has_many :sampled_entries,
           through: :samples_used,
           source: :sampled_entry

  # The song being sampled
  has_many :sampled_by,
           class_name: "Sample",
           foreign_key: :sampled_entry_id,
           dependent: :destroy
  has_many :sampled_by_entries,
           through: :sampled_by,
           source: :sampler_entry

Comment
  belongs_to :user
  belongs_to :entry

Sample
  belongs_to :sampler_entry, class_name: "Entry"
  belongs_to :sampled_entry, class_name: "Entry"
  has_many :sample_segments, dependent: :destroy

SampleSegment
  belongs_to :sample
```

## Constraints & Validations

```
Database-Level Constraints
--------------------------
- NOT NULL constraints on required fields
- Foreign key constraints for all associations
- Unique index on [:sampler_entry_id, :sampled_entry_id] in samples table
- CHECK constraints:
    - bpm >= 0
    - sampler_entry_id <> sampled_entry_id (no self-sampling)
    - start_time >= 0

Model-Level Validations
------------------------
Presence:
  - Entry.title → required
  - Entry.user → must belong to a user
  - Entry.artist → must belong to an artist
  - SampleSegment.start_time → required

Numericality:
  - Entry.bpm → must be a number ≥ 0 (allow_nil: true)
  - SampleSegment.start_time → must be a number ≥ 0

Custom:
  - Prevent sampling entries from the future
    (i.e., sampled_entry.year must be ≤ sampler_entry.year)

Optional:
  - Video URL → (Possible future validation for format)
```
