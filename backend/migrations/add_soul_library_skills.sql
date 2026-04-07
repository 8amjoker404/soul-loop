-- Run once on existing databases that predate `soul_library.skills`.
-- New installs should use `soul_loop_db.sql` which already includes this column.

ALTER TABLE `soul_library`
ADD COLUMN `skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT ('{}') CHECK (json_valid(`skills`));
