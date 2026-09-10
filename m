Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131858E2D4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067331; cv=none; b=Gqw1NgUWK3BN2ZbK0VsdX6X9aBzBsNFt+yozzY58anOF3y8D8NaekEsK/FpNj6JCkyi2zYzcykA65cIb7GSELZ94GbW1MSEDW59LsE9m2JqoJWrU1dlzH3+xMqSkKphIyL/03eA474G8+dptETRTH/9Afyd1WONs+AFQsnOWLWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067331; c=relaxed/simple;
	bh=EDtsoMA453PyERhf9e0EccAnQ8jaLdzk28PxBXaXwOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+A0Fxk3iS0kLCUO+10ogfzNG2UQNbnyx6J+oW/IoFluhxNSLm1XO/XiK9FLjXaX6sdgPwBVstzgOnyZwzTpSi6ZVEI6WhOFaOUokCC2rJwKAhYtPw9aBT2mN3AxeJQPmh3XGjCb2IgfGJIW0XVE63p+qt3tDbCjEoA3ui1Vy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZEOUm2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZEOUm2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF8F1F00893;
	Thu, 10 Sep 2026 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067329;
	bh=I2ivnX3HnvtjA1JlzKhnALuVzqjIvjkOMjRN2qsYhZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZZEOUm2cicOYTqtEyAz34fIvpoSY7g1cEPwD1RMIdpPfwFgkmYUumFEPkR7SNzU9f
	 ZIPib4tvZcwDMd0l1PcyE2jF3Agqz9ie540EvYjC6y1xvc1nw6uk5v0CFGgw+B3KbT
	 T91nhGmBFI/D0bafiBCi2zTQDXuLcPBOye60GBgiNUH6mGFbdliOs6cnD7X/b8TYgd
	 GUJTYzl+0Mz1PDm6eSGn1eYWdSEAGvgsuUYYnD9hVUYrCnfcipQZ9fAmgrDF+bhqe7
	 HzJiFAJmA14bEdO8xJkObp0dlWrEbQ6IHcw0ptf5eNHqMeojr/oKnyZ3ooCox6JBW9
	 ogyoHFaduytHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/7] block: rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART
Date: Thu, 10 Sep 2026 15:08:41 -0400
Message-ID: <20260910190846.1453814-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190846.1453814-1-sashal@kernel.org>
References: <2026090834-voyage-donut-60bd@gregkh>
 <20260910190846.1453814-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 46e7eac647b34ed4106a8262f8bedbb90801fadd ]

The GENHD_FL_NO_PART_SCAN controls more than just partitions canning,
so rename it to GENHD_FL_NO_PART.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20211122130625.1136848-7-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

Adapt the dependency for 5.10 and prepare for 3f9c7a108c0e
("block: flag zoned disks with GENHD_FL_NO_PART"):

Keep the loop_set_status() block-device assignment and the native-capacity
and exclusive-write event flags, which are still needed on this branch.
Drop the n64cart hunk because that driver does not exist in 5.10.

Move the existing register_disk() definition below __device_add_disk(),
with a forward declaration, and align the device-number comment with
upstream.  This preserves the existing registration logic while allowing
the target's three-way cherry-pick to insert its zoned-disk check in
__device_add_disk(), before partition scanning.  No functions are added.

Make ext_range report one for GENHD_FL_NO_PART disks, as expected by the
target, while retaining disk_max_parts() for other disks.  Keep the
existing partition allocation limits and extended device-number handling.

[ sashal: Reduced backport -- upstream 46e7eac647b34 touches 5 file(s), this
  backport carries 4. Not backported here:
  drivers/block/n64cart.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 3f9c7a108c0e ("block: flag zoned disks with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c            | 137 +++++++++++++++++++++------------------
 drivers/block/loop.c     |   8 +--
 drivers/mmc/core/block.c |   4 +-
 include/linux/genhd.h    |  13 ++--
 4 files changed, 85 insertions(+), 77 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 01a7b81eca751..fef31a2f50a80 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -690,67 +690,7 @@ static void disk_scan_partitions(struct gendisk *disk)
 }
 
 static void register_disk(struct device *parent, struct gendisk *disk,
-			  const struct attribute_group **groups)
-{
-	struct device *ddev = disk_to_dev(disk);
-	struct disk_part_iter piter;
-	struct hd_struct *part;
-	int err;
-
-	ddev->parent = parent;
-
-	dev_set_name(ddev, "%s", disk->disk_name);
-
-	/* delay uevents, until we scanned partition table */
-	dev_set_uevent_suppress(ddev, 1);
-
-	if (groups) {
-		WARN_ON(ddev->groups);
-		ddev->groups = groups;
-	}
-	if (device_add(ddev))
-		return;
-	if (!sysfs_deprecated) {
-		err = sysfs_create_link(block_depr, &ddev->kobj,
-					kobject_name(&ddev->kobj));
-		if (err) {
-			device_del(ddev);
-			return;
-		}
-	}
-
-	/*
-	 * avoid probable deadlock caused by allocating memory with
-	 * GFP_KERNEL in runtime_resume callback of its all ancestor
-	 * devices
-	 */
-	pm_runtime_set_memalloc_noio(ddev, true);
-
-	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
-	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
-
-	if (disk->flags & GENHD_FL_HIDDEN)
-		return;
-
-	disk_scan_partitions(disk);
-
-	/* announce disk after possible partitions are created */
-	dev_set_uevent_suppress(ddev, 0);
-	kobject_uevent(&ddev->kobj, KOBJ_ADD);
-
-	/* announce possible partitions */
-	disk_part_iter_init(&piter, disk, 0);
-	while ((part = disk_part_iter_next(&piter)))
-		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
-	disk_part_iter_exit(&piter);
-
-	if (disk->queue->backing_dev_info->dev) {
-		err = sysfs_create_link(&ddev->kobj,
-			  &disk->queue->backing_dev_info->dev->kobj,
-			  "bdi");
-		WARN_ON(err);
-	}
-}
+			  const struct attribute_group **groups);
 
 /**
  * __device_add_disk - add disk information to kernel list
@@ -780,7 +720,12 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	if (register_queue)
 		elevator_init_mq(disk->queue);
 
-	/* minors == 0 indicates to use ext devt from part0 and should
+	/*
+	 * If the driver provides an explicit major number it also must provide
+	 * the number of minors numbers supported, and those will be used to
+	 * setup the gendisk.
+	 *
+	 * minors == 0 indicates to use ext devt from part0 and should
 	 * be accompanied with EXT_DEVT flag.  Make sure all
 	 * parameters make sense.
 	 */
@@ -806,7 +751,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		 * and don't bother scanning for partitions either.
 		 */
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
-		disk->flags |= GENHD_FL_NO_PART_SCAN;
+		disk->flags |= GENHD_FL_NO_PART;
 	} else {
 		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
 		struct device *dev = disk_to_dev(disk);
@@ -834,6 +779,69 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	blk_integrity_add(disk);
 }
 
+static void register_disk(struct device *parent, struct gendisk *disk,
+			  const struct attribute_group **groups)
+{
+	struct device *ddev = disk_to_dev(disk);
+	struct disk_part_iter piter;
+	struct hd_struct *part;
+	int err;
+
+	ddev->parent = parent;
+
+	dev_set_name(ddev, "%s", disk->disk_name);
+
+	/* delay uevents, until we scanned partition table */
+	dev_set_uevent_suppress(ddev, 1);
+
+	if (groups) {
+		WARN_ON(ddev->groups);
+		ddev->groups = groups;
+	}
+	if (device_add(ddev))
+		return;
+	if (!sysfs_deprecated) {
+		err = sysfs_create_link(block_depr, &ddev->kobj,
+					kobject_name(&ddev->kobj));
+		if (err) {
+			device_del(ddev);
+			return;
+		}
+	}
+
+	/*
+	 * avoid probable deadlock caused by allocating memory with
+	 * GFP_KERNEL in runtime_resume callback of its all ancestor
+	 * devices
+	 */
+	pm_runtime_set_memalloc_noio(ddev, true);
+
+	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
+	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
+
+	if (disk->flags & GENHD_FL_HIDDEN)
+		return;
+
+	disk_scan_partitions(disk);
+
+	/* announce disk after possible partitions are created */
+	dev_set_uevent_suppress(ddev, 0);
+	kobject_uevent(&ddev->kobj, KOBJ_ADD);
+
+	/* announce possible partitions */
+	disk_part_iter_init(&piter, disk, 0);
+	while ((part = disk_part_iter_next(&piter)))
+		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
+	disk_part_iter_exit(&piter);
+
+	if (disk->queue->backing_dev_info->dev) {
+		err = sysfs_create_link(&ddev->kobj,
+			  &disk->queue->backing_dev_info->dev->kobj,
+			  "bdi");
+		WARN_ON(err);
+	}
+}
+
 void device_add_disk(struct device *parent, struct gendisk *disk,
 		     const struct attribute_group **groups)
 
@@ -1242,7 +1250,8 @@ static ssize_t disk_ext_range_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n", disk_max_parts(disk));
+	return sprintf(buf, "%d\n",
+		       (disk->flags & GENHD_FL_NO_PART) ? 1 : disk_max_parts(disk));
 }
 
 static ssize_t disk_removable_show(struct device *dev,
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3db4dad0d072a..e11e25a799aba 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1165,7 +1165,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	if (partscan)
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
 
 	/* Grab the block_device to prevent its destruction after we
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
@@ -1291,7 +1291,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	mutex_lock(&loop_ctl_mutex);
 	lo->lo_flags = 0;
 	if (!part_shift)
-		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+		lo->lo_disk->flags |= GENHD_FL_NO_PART;
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&loop_ctl_mutex);
 
@@ -1410,7 +1410,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (!err && (lo->lo_flags & LO_FLAGS_PARTSCAN) &&
 	     !(prev_lo_flags & LO_FLAGS_PARTSCAN)) {
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
 		bdev = lo->lo_device;
 		partscan = true;
 	}
@@ -2154,7 +2154,7 @@ static int loop_add(struct loop_device **l, int i)
 	 * userspace tools. Parameters like this in general should be avoided.
 	 */
 	if (!part_shift)
-		disk->flags |= GENHD_FL_NO_PART_SCAN;
+		disk->flags |= GENHD_FL_NO_PART;
 	disk->flags |= GENHD_FL_EXT_DEVT;
 	atomic_set(&lo->lo_refcnt, 0);
 	lo->lo_number		= i;
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e5506c793b6bd..51b43895e3a2d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2411,8 +2411,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	set_disk_ro(md->disk, md->read_only || default_ro);
 	md->disk->flags = GENHD_FL_EXT_DEVT;
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
-		md->disk->flags |= GENHD_FL_NO_PART_SCAN
-				   | GENHD_FL_SUPPRESS_PARTITION_INFO;
+		md->disk->flags |= GENHD_FL_NO_PART |
+				   GENHD_FL_SUPPRESS_PARTITION_INFO;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4b22bfd9336e1..30e1841630b1f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -111,15 +111,15 @@ struct hd_struct {
  * ``GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE`` (0x0100): event polling is
  * blocked whenever a writer holds an exclusive lock.
  *
- * ``GENHD_FL_NO_PART_SCAN`` (0x0200): partition scanning is disabled.
- * Used for loop devices in their default settings and some MMC
- * devices.
+ * ``GENHD_FL_NO_PART`` (0x0200): partition support is disabled.
+ * The kernel will not scan for partitions from add_disk, and users
+ * can't add partitions manually.
  *
  * ``GENHD_FL_HIDDEN`` (0x0400): the block device is hidden; it
  * doesn't produce events, doesn't appear in sysfs, and doesn't have
  * an associated ``bdev``.
  * Implies ``GENHD_FL_SUPPRESS_PARTITION_INFO`` and
- * ``GENHD_FL_NO_PART_SCAN``.
+ * ``GENHD_FL_NO_PART``.
  * Used for multipath devices.
  */
 #define GENHD_FL_REMOVABLE			0x0001
@@ -131,7 +131,7 @@ struct hd_struct {
 #define GENHD_FL_EXT_DEVT			0x0040
 #define GENHD_FL_NATIVE_CAPACITY		0x0080
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
-#define GENHD_FL_NO_PART_SCAN			0x0200
+#define GENHD_FL_NO_PART			0x0200
 #define GENHD_FL_HIDDEN				0x0400
 
 enum {
@@ -236,8 +236,7 @@ static inline int disk_max_parts(struct gendisk *disk)
 
 static inline bool disk_part_scan_enabled(struct gendisk *disk)
 {
-	return disk_max_parts(disk) > 1 &&
-		!(disk->flags & GENHD_FL_NO_PART_SCAN);
+	return disk_max_parts(disk) > 1 && !(disk->flags & GENHD_FL_NO_PART);
 }
 
 static inline dev_t disk_devt(struct gendisk *disk)
-- 
2.53.0

