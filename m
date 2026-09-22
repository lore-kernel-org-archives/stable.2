Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644956C64C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095737; cv=none; b=rWq7WW8I0ThV5U1LQOfDQlDFLXaN70wCv5TB5e3gd2L7I/B5soEe8krtoAj1hDpp3/hw4nW5YsK+a0Nfxv32OKL6JmcHeSZrjuxqBXXZq7RnFcpePekgXSg7XgdFjdqVDVMPM9qB4qExblqHdvaHx4Q/WHQFvxxIb+d9X7265L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095737; c=relaxed/simple;
	bh=CYrYgAqOSROrhalKZJBKaJiMSY74VUVUKbaWMFI+m+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRQPizbHGFI0Y25abtjVeN6AZ3x8sstjj9lEm6CoNLduOxfzz1YqwLeWXQAk02XhsHhywl06E/KKm1XQbTo3/izNygtf494EAboiwClSGZsXrD2Ukf8UpmBsWspQXcizcT0CZMVIO+4Abgma7HcCebAsUAreVGjdMh5v3ywm3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGtoLsvO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGtoLsvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB3A1F0089A;
	Tue, 22 Sep 2026 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095731;
	bh=5pJ8UuNk9COsYOYNQJcpgYLIzE/p3Pr1q3tqUo+umxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SGtoLsvOFCu4Er5GLRONvJmDgoKOrurQCOObHSMnjY2O4uC2pl8HasQPRR8b1mdMR
	 PKzIFZ96mbP99XON7Xgn/KAfKNqaC+Co+0UMZwhQCGp1CyH6eXEDJC4vqx0cBhWKgc
	 MjMhVT7Z34SxpioQWTuSYilUZkG3/emvHwusnOj98/RYbaHqF1IVNVqzmTPgTyn7FK
	 eoijY6lnxoio7v/wH17srPdwbbnbj+te0ef+UQ45E5pn2QsXz3A1Ble9Xt2rdPZqel
	 evJ02xgIo453kh89tbps4X7gXsqhbKvhFSLNcdqTa8uf+nJN8QElakTPoLd/JFMyMC
	 A+cRU4fGzqTlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] block: add a ->free_disk method
Date: Tue, 22 Sep 2026 12:48:47 -0400
Message-ID: <20260922164848.3125553-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164848.3125553-1-sashal@kernel.org>
References: <2026092239-justify-dizzy-3fd4@gregkh>
 <20260922164848.3125553-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 76792055c4c8b2472ca1ae48e0ddaf8497529f08 ]

Add a method to notify the driver that the gendisk is about to be freed.
This allows drivers to tie the lifetime of their private data to that of
the gendisk and thus deal with device removal races without expensive
synchronization and boilerplate code.

A new flag is added so that ->free_disk is only called after a successful
call to add_disk, which significantly simplifies the error handling path
during probing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20220215094514.3828912-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

Backport notes for 5.15:
- Keep GD_ADDED alongside struct gendisk in include/linux/genhd.h;
  this tree has not merged genhd.h into blkdev.h.
- Fold in the ms_block lifetime conversion from e2efa0796607e so that
  target 90af7fde083e applies unchanged before put_disk() in msb_remove().
  Reuse the existing msb_disk_release() as the free_disk callback instead
  of introducing a new function. Drop the old open/release callbacks and
  usage_count; the gendisk reference now protects msb_data until final
  release. Preserve the 5.15 request-queue cleanup and probe error paths.

Stable-dep-of: 90af7fde083e ("memstick: ms_block: destroy io_queue workqueue on removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c                    |  5 ++++
 drivers/memstick/core/ms_block.c | 47 +++++---------------------------
 drivers/memstick/core/ms_block.h |  1 -
 include/linux/blkdev.h           |  1 +
 include/linux/genhd.h            |  1 +
 5 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 717234acee49c..19cd50af5930c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -529,6 +529,7 @@ int device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk_update_readahead(disk);
 	disk_add_events(disk);
+	set_bit(GD_ADDED, &disk->state);
 	return 0;
 
 out_unregister_bdi:
@@ -1136,6 +1137,10 @@ static void disk_release(struct device *dev)
 	xa_destroy(&disk->part_tbl);
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
+
+	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
+		disk->fops->free_disk(disk);
+
 	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 7e02bb33577bd..0486bbb10e44d 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1947,22 +1947,6 @@ static void msb_io_work(struct work_struct *work)
 static DEFINE_IDR(msb_disk_idr); /*set of used disk numbers */
 static DEFINE_MUTEX(msb_disk_lock); /* protects against races in open/release */
 
-static int msb_bd_open(struct block_device *bdev, fmode_t mode)
-{
-	struct gendisk *disk = bdev->bd_disk;
-	struct msb_data *msb = disk->private_data;
-
-	dbg_verbose("block device open");
-
-	mutex_lock(&msb_disk_lock);
-
-	if (msb && msb->card)
-		msb->usage_count++;
-
-	mutex_unlock(&msb_disk_lock);
-	return 0;
-}
-
 static void msb_data_clear(struct msb_data *msb)
 {
 	kfree(msb->boot_page);
@@ -1973,31 +1957,16 @@ static void msb_data_clear(struct msb_data *msb)
 	msb->card = NULL;
 }
 
-static int msb_disk_release(struct gendisk *disk)
+static void msb_disk_release(struct gendisk *disk)
 {
 	struct msb_data *msb = disk->private_data;
 
 	dbg_verbose("block device release");
 	mutex_lock(&msb_disk_lock);
-
-	if (msb) {
-		if (msb->usage_count)
-			msb->usage_count--;
-
-		if (!msb->usage_count) {
-			disk->private_data = NULL;
-			idr_remove(&msb_disk_idr, msb->disk_id);
-			put_disk(disk);
-			kfree(msb);
-		}
-	}
+	idr_remove(&msb_disk_idr, msb->disk_id);
 	mutex_unlock(&msb_disk_lock);
-	return 0;
-}
 
-static void msb_bd_release(struct gendisk *disk, fmode_t mode)
-{
-	msb_disk_release(disk);
+	kfree(msb);
 }
 
 static int msb_bd_getgeo(struct block_device *bdev,
@@ -2101,10 +2070,9 @@ static void msb_start(struct memstick_dev *card)
 }
 
 static const struct block_device_operations msb_bdops = {
-	.open    = msb_bd_open,
-	.release = msb_bd_release,
-	.getgeo  = msb_bd_getgeo,
-	.owner   = THIS_MODULE
+	.owner		= THIS_MODULE,
+	.getgeo		= msb_bd_getgeo,
+	.free_disk	= msb_disk_release,
 };
 
 static const struct blk_mq_ops msb_mq_ops = {
@@ -2152,7 +2120,6 @@ static int msb_init_disk(struct memstick_dev *card)
 	set_capacity(msb->disk, capacity);
 	dbg("Set total disk size to %lu sectors", capacity);
 
-	msb->usage_count = 1;
 	msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
 	if (!msb->io_queue) {
 		rc = -ENOMEM;
@@ -2241,7 +2208,7 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
-	msb_disk_release(msb->disk);
+	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
 
diff --git a/drivers/memstick/core/ms_block.h b/drivers/memstick/core/ms_block.h
index 122e1a8a8bd5b..7058f9aefeb92 100644
--- a/drivers/memstick/core/ms_block.h
+++ b/drivers/memstick/core/ms_block.h
@@ -143,7 +143,6 @@ struct ms_boot_page {
 } __packed;
 
 struct msb_data {
-	unsigned int			usage_count;
 	struct memstick_dev		*card;
 	struct gendisk			*disk;
 	struct request_queue		*queue;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 60e4d426fda87..a098e650c7d64 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1859,6 +1859,7 @@ struct block_device_operations {
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
 	int (*set_read_only)(struct block_device *bdev, bool ro);
+	void (*free_disk)(struct gendisk *disk);
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ccad6b4b5d289..83b11fa71af8e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -132,6 +132,7 @@ struct gendisk {
 #define GD_READ_ONLY			1
 #define GD_DEAD				2
 #define GD_NATIVE_CAPACITY		3
+#define GD_ADDED			4
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
-- 
2.53.0

