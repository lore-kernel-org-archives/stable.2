Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2415581E3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874389; cv=none; b=l6Z0n9713fejbmns8q0g0s2sIBWxEBib+m0u8AnBmRxw+8Hskl2L+/IVG8ULDBY5PrhPszh5l6I5uRqmuiDYshE1Jj3d7U3y465C28tTLPcw1iqkqLBChU6hfwQNa/rHmxudg7rX8eo0ixzXx0MAo74Vca6pqK+3HQUbunxj4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874389; c=relaxed/simple;
	bh=J1tJE2KD7sB2AukWctxbLBweCHPvbmMXVYqj1BLboZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3WbVUTa+bGSKwFzy1uTge7JMnoOfff+tgEOxW9/UY4VOgGl44+D33R5pkka8r0CZZGdghmFG9QZawLBkSZxvVih/HTyr1lLU/vX7kO8CIbSQFOzqw6HTtJH6QlE6ONGWFXSzPGs9iYf+d8mljyy7a5i2TkWZ9GRsd306qc61bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7471F00A3E;
	Tue,  8 Sep 2026 13:33:03 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] block: simplify the disk_force_media_change interface
Date: Tue,  8 Sep 2026 09:32:56 -0400
Message-ID: <20260908133259.2325197-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-engross-lapped-120b@gregkh>
References: <2026090327-engross-lapped-120b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit ab6860f62bfe329e11e5b5b7295b673c9c3a62d0 ]

Hard code the events to DISK_EVENT_MEDIA_CHANGE as that is the only
useful use case, and drop the superfluous return value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Message-Id: <20230811100828.1897174-9-hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 7e9a46004b47 ("block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/disk-events.c    | 15 ++++-----------
 drivers/block/loop.c   |  6 +++---
 include/linux/blkdev.h |  2 +-
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index 450c2cbe23d56..c25b67c190a6c 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -294,25 +294,18 @@ EXPORT_SYMBOL(bdev_check_media_change);
  * @disk: the disk which will raise the event
  * @events: the events to raise
  *
- * Generate uevents for the disk. If DISK_EVENT_MEDIA_CHANGE is present,
- * attempt to free all dentries and inodes and invalidates all block
+ * Should be called when the media changes for @disk.  Generates a uevent
+ * and attempts to free all dentries and inodes and invalidates all block
  * device page cache entries in that case.
- *
- * Returns %true if DISK_EVENT_MEDIA_CHANGE was raised, or %false if not.
  */
-bool disk_force_media_change(struct gendisk *disk, unsigned int events)
+void disk_force_media_change(struct gendisk *disk)
 {
-	disk_event_uevent(disk, events);
-
-	if (!(events & DISK_EVENT_MEDIA_CHANGE))
-		return false;
-
+	disk_event_uevent(disk, DISK_EVENT_MEDIA_CHANGE);
 	inc_diskseq(disk);
 	if (__invalidate_device(disk->part0, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			disk->disk_name);
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	return true;
 }
 EXPORT_SYMBOL_GPL(disk_force_media_change);
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e3e5d533a7eca..a12a67947c682 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -598,7 +598,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		goto out_err;
 
 	/* and ... switch */
-	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
+	disk_force_media_change(lo->lo_disk);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
@@ -1063,7 +1063,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
 
-	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
+	disk_force_media_change(lo->lo_disk);
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
@@ -1167,7 +1167,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	if (!release)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 
-	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
+	disk_force_media_change(lo->lo_disk);
 
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
 		int err;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index de013fc37ef83..e57b6e77b3757 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -773,7 +773,7 @@ static inline int bdev_read_only(struct block_device *bdev)
 }
 
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
-bool disk_force_media_change(struct gendisk *disk, unsigned int events);
+void disk_force_media_change(struct gendisk *disk);
 
 void add_disk_randomness(struct gendisk *disk) __latent_entropy;
 void rand_initialize_disk(struct gendisk *disk);
-- 
2.53.0

