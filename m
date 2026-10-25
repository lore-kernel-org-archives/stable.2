Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792908558;
	b=XKCOqddK8+dXzNEHA0YK5uRb/6MjDtJt3qJ32w9PM/czjqRmT2sebqRY+/pYlgRGPkx1
	 BC8QnPsS7+ksO0OS2GsMYmDw2ICP8BPS1gZ4y29kIlAKtiN/laz1muFkn9mUD1T6aQPnV
	 qzn4oaJbTaRmOGsA7Qxl1OK5EBaoWVM4pKOxsiNQS6ZlSQ/TTh39Nq4eb6y3BoUS27LCh
	 6DW1mQX+6o7sW616eeVQTZWmjkJIDT0vo0QihhVRZ+U206NKmEMdpBmmNJuuGjrrS53vp
	 28I9GL2my/0ahd1TpFDuAHJGpGdUTwoqTudw/UzH+QIvWur5Ob7gJw9IAKibuNTPc4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792908558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=Sfzi/7/w3SaIV07IDVIi4Dx7aYnputtbbmUJJqGHnco=;
	b=UCA6Z/SuJdoVFi7Jj4lnI334YTH/gjVQyMhfrZ86gS2Mv+Iw4ZbvTBdfw3oe7iIeur49
	 YGeuKS4Uccs851ugkSxRK3XAZS4mr8rGHQ0pJjMtUPyoltiDgGlzlroG3d5NwDTsmHDb9
	 lGhqheL0Ad6TIMmy3IE/rD89o/TjadcH6lPZWx4M5wBnrOqDIp49W+8dIxvU+VDlfZvJO
	 u2NDkgYaHblyuRGSE/qTcYn26VUMqttwAv1YlMc6ys5e8QBMXUImFAgMBJ4d8KNjzWwpD
	 U1KSGO3a0ymUgmAtkaAAuuWn/ZQvO1ONHf367hnh704aVQ19jxl9oSiXku6ahM6i5Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QrixxMzW;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B81606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 06:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B81606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QrixxMzW
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e93f266d20so34299405ad.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 23:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792908557; x=1793513357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sfzi/7/w3SaIV07IDVIi4Dx7aYnputtbbmUJJqGHnco=;
        b=QrixxMzWiF1a1hD6Qmd2sQp4ufgavYBOYMWNIcXVTbpJS6uZFRsfRBUZWbongdMTvM
         4PkuqKXjp4bZdIJh4o+dIQSJ5RiYuLIwz/Pg5xhHvlNzjsC1thjlYgb3uVzyUvQUk3qQ
         +CjJ0nhr/auvCqbXIiDLjOXU+H/yq3kbNSaBMA00NW0TvqCGBGJ7FJ5q2jPz81w8fIL4
         acb32Acpi5HwM+TfYEfuoTlbHTl06O85izEC47HpQxiZ4SDvRUzZdz8kI8Z4GfUlKH/p
         ZgPw9kq8dGbYemm8H5p6FjZrrsdChFQNa+XlEw/wqZzfH3cBVH8ZqSYOOGhzLfbFZgPn
         6XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792908557; x=1793513357;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sfzi/7/w3SaIV07IDVIi4Dx7aYnputtbbmUJJqGHnco=;
        b=YApsrEvfdwH8rAHKiPA4gTXPranx9jhvXHcxIMOM/Jxbl+hQbfUT6fFRXj15IFf+RB
         Hy9UjjXOJUw9/QlBFSLvGyFK1sHzVkzAIglK6CnPu3Ipb9hiQy9LV+3Sg0nv+VD9fee3
         zErixSleGsv0kNmMvZtpQ/iuR5alr6y6g/K/UcsTEp05vUMp5n7Xj8iemZhXJsP5v5JD
         c/X2pjZylAYX0Fqhq+h+SJRC8aPwt5q33yR+hhIxINe+d9VSPpBg/I7MwAlz4S81x8EA
         fD9VMVO5ZoHuhljFE1Ml/CGKHaYkLuca3/y1JBFBpAMcbv4xzQ9YwRHMwU3l4tBGNMUC
         8esw==
X-Gm-Message-State: AFq9FYII5cQVkonlrHG3H4+Lzs35oQ6pmF6eVJ8BKY2yjuzxm+fXxFWe
	cJu5sMhNawubZVkqB2sMveRAu7O0vop8cXbiH7Kk/4rspo+YRQk3RB0zg+DhS8D6OmrpQrGTD3z
	i5YzfAKeBxL5NfaukTBeu8MKRT6YfCtWYWkLc7CBHghgzMmZ870zgN/8+P3aF9yTChnThi1njpJ
	/Ou+USN16V+0dUYlssBpm3Nxh4ZFwi+XA77SqOKpEpZuf3/sbK9Nrq8w1MTQ==
X-Received: from plblv3.prod.google.com ([2002:a17:903:2a83:b0:2e9:314a:fcc8])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2cb:b0:2e9:4bf3:37a5 with SMTP id d9443c01a7336-2ea9c864accmr31076525ad.58.1792908556694;
 Sat, 24 Oct 2026 23:09:16 -0700 (PDT)
Date: Sun, 25 Oct 2026 14:09:14 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025060914.1652636-1-stanleyjhu@google.com>
Subject: [PATCH 6.18.y] block: avoid potential deadlock on zone revalidation failure
From: Stanley Jhu <stanleyjhu@google.com>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Damien Le Moal <dlemoal@kernel.org>

commit 3dd63dba8f9cb6990a40af7ed66ee0159f475819 upstream.

If revalidating the zones of a zoned block device with
blk_revalidate_disk_zones() fails during a SCSI disk rescan, the following
lockdep splat is thrown:

[  347.251859] [  T11230] sda: failed to revalidate zones

[  347.261380] [  T11230] ======================================================
[  347.263882] [  T11230] WARNING: possible circular locking dependency detected
[  347.266353] [  T11230] 7.1.0+ #1194 Not tainted
[  347.268052] [  T11230] ------------------------------------------------------
[  347.270537] [  T11230] tcsh/11230 is trying to acquire lock:
[  347.272555] [  T11230] ffffffff8f91d400 (wq_pool_mutex){+.+.}-{4:4}, at: destroy_workqueue+0x15d/0x8d0
[  347.275914] [  T11230]
                          but task is already holding lock:
[  347.278646] [  T11230] ffff88812fa1bcc0 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x16/0x30
[  347.282503] [  T11230]
                          which lock already depends on the new lock.

[  347.286239] [  T11230]
                          the existing dependency chain (in reverse order) is:
[  347.289408] [  T11230]
                          -> #2 (&q->q_usage_counter(io)#5){++++}-{0:0}:
[  347.292437] [  T11230]        blk_alloc_queue+0x5ca/0x750
[  347.294379] [  T11230]        blk_mq_alloc_queue+0x14c/0x240
[  347.296375] [  T11230]        scsi_alloc_sdev+0x871/0xd10 [scsi_mod]
[  347.298619] [  T11230]        scsi_probe_and_add_lun+0x600/0xc50 [scsi_mod]
[  347.301056] [  T11230]        __scsi_scan_target+0x187/0x3b0 [scsi_mod]
[  347.303385] [  T11230]        scsi_scan_channel+0xf2/0x180 [scsi_mod]
[  347.305651] [  T11230]        scsi_scan_host_selected+0x20b/0x2d0 [scsi_mod]
[  347.308119] [  T11230]        do_scan_async+0x42/0x420 [scsi_mod]
[  347.310276] [  T11230]        async_run_entry_fn+0x94/0x5a0
[  347.312284] [  T11230]        process_one_work+0x8da/0x1690
[  347.314287] [  T11230]        worker_thread+0x5fe/0x1010
[  347.316216] [  T11230]        kthread+0x358/0x450
[  347.317675] [  T11230]        ret_from_fork+0x5b9/0x8e0
[  347.319181] [  T11230]        ret_from_fork_asm+0x11/0x20
[  347.320778] [  T11230]
                          -> #1 (fs_reclaim){+.+.}-{0:0}:
[  347.322890] [  T11230]        fs_reclaim_acquire+0xd5/0x120
[  347.324464] [  T11230]        __kmalloc_cache_node_noprof+0x39/0x620
[  347.326223] [  T11230]        init_rescuer+0x19b/0x560
[  347.327697] [  T11230]        workqueue_init+0x33b/0x6a0
[  347.329224] [  T11230]        kernel_init_freeable+0x2eb/0x600
[  347.330881] [  T11230]        kernel_init+0x1c/0x140
[  347.332334] [  T11230]        ret_from_fork+0x5b9/0x8e0
[  347.333847] [  T11230]        ret_from_fork_asm+0x11/0x20
[  347.335360] [  T11230]
                          -> #0 (wq_pool_mutex){+.+.}-{4:4}:
[  347.337510] [  T11230]        __lock_acquire+0xdea/0x2260
[  347.339030] [  T11230]        lock_acquire+0x187/0x2f0
[  347.340495] [  T11230]        __mutex_lock+0x1ab/0x2600
[  347.341464] [  T11230]        destroy_workqueue+0x15d/0x8d0
[  347.342485] [  T11230]        disk_free_zone_resources+0xd5/0x560
[  347.343577] [  T11230]        blk_revalidate_disk_zones+0x620/0xac7
[  347.344723] [  T11230]        sd_zbc_revalidate_zones+0x1dd/0x790 [sd_mod]
[  347.345938] [  T11230]        sd_revalidate_disk+0xc66/0x8e60 [sd_mod]
[  347.347112] [  T11230]        scsi_rescan_device+0x1f9/0x310 [scsi_mod]
[  347.348318] [  T11230]        store_rescan_field+0x19/0x20 [scsi_mod]
[  347.349507] [  T11230]        kernfs_fop_write_iter+0x3d2/0x5e0
[  347.350565] [  T11230]        vfs_write+0x469/0x1000
[  347.351484] [  T11230]        ksys_write+0x116/0x250
[  347.352403] [  T11230]        do_syscall_64+0xf0/0x6e0
[  347.353361] [  T11230]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  347.354533] [  T11230]
                          other info that might help us debug this:

[  347.356432] [  T11230] Chain exists of:
                            wq_pool_mutex --> fs_reclaim --> &q->q_usage_counter(io)#5

[  347.358919] [  T11230]  Possible unsafe locking scenario:

[  347.360307] [  T11230]        CPU0                    CPU1
[  347.361327] [  T11230]        ----                    ----
[  347.362340] [  T11230]   lock(&q->q_usage_counter(io)#5);
[  347.363344] [  T11230]                                lock(fs_reclaim);
[  347.364526] [  T11230]                                lock(&q->q_usage_counter(io)#5);
[  347.365968] [  T11230]   lock(wq_pool_mutex);
[  347.366811] [  T11230]
                           *** DEADLOCK ***

This happens because SCSI disk rescan is executed from a work context
and a failure of blk_revalidate_disk_zones() causes a call to
disk_free_zone_resources() which will free the disk zone write plug
workqueue.

Avoid this by delaying the destruction of the disk zone write plug
workqueue to disk_release(). Do this by introducing the function
disk_release_zone_resources() and using this new function from
disk_release(). This new function destroys the zone write plugs workqueue
and calls disk_free_zone_resources(), thus allowing to remove the call to
destroy_workqueue() from disk_free_zone_resources().
disk_alloc_zone_resources() is modified to not create the disk zone
write plug work queue if it already exists.

Fixes: a8f59e5a5dea ("block: use a per disk workqueue for zone write plugging")
Cc: stable@vger.kernek.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260701082155.1369996-1-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ stanleyjhu: 6.18.y has no zone write plug kthread worker and does not
  use WQ_PERCPU, so only the workqueue part applies:
  disk_alloc_zone_resources() reuses an existing workqueue,
  disk_free_zone_resources() drains it instead of destroying it, and
  the new disk_release_zone_resources() destroys it from
  disk_release(). ]
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
The upstream commit has a misspelled Cc: stable address
(stable@vger.kernek.org), so it was not picked up automatically.

 block/blk-zoned.c | 37 +++++++++++++++++++++++++++----------
 block/blk.h       |  4 ++--
 block/genhd.c     |  2 +-
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5c16cf96b97c..a7d3d2e002da 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1413,11 +1413,20 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 	if (!disk->zone_wplugs_pool)
 		goto free_hash;
 
-	disk->zone_wplugs_wq =
-		alloc_workqueue("%s_zwplugs", WQ_MEM_RECLAIM | WQ_HIGHPRI,
-				pool_size, disk->disk_name);
-	if (!disk->zone_wplugs_wq)
-		goto destroy_pool;
+	/*
+	 * We may already have a zone write plug workqueue as this function may
+	 * be called after disk_free_zone_resources(), which does not destroy
+	 * the workqueue (the zone write plugs workqueue is destroyed at
+	 * disk_release() time).
+	 */
+	if (!disk->zone_wplugs_wq) {
+		disk->zone_wplugs_wq =
+			alloc_workqueue("%s_zwplugs",
+					WQ_MEM_RECLAIM | WQ_HIGHPRI,
+					pool_size, disk->disk_name);
+		if (!disk->zone_wplugs_wq)
+			goto destroy_pool;
+	}
 
 	return 0;
 
@@ -1474,15 +1483,13 @@ static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
 	return nr_conv_zones;
 }
 
-void disk_free_zone_resources(struct gendisk *disk)
+static void disk_free_zone_resources(struct gendisk *disk)
 {
 	if (!disk->zone_wplugs_pool)
 		return;
 
-	if (disk->zone_wplugs_wq) {
-		destroy_workqueue(disk->zone_wplugs_wq);
-		disk->zone_wplugs_wq = NULL;
-	}
+	if (disk->zone_wplugs_wq)
+		drain_workqueue(disk->zone_wplugs_wq);
 
 	disk_destroy_zone_wplugs_hash_table(disk);
 
@@ -1501,6 +1508,16 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones = 0;
 }
 
+void disk_release_zone_resources(struct gendisk *disk)
+{
+	if (disk->zone_wplugs_wq) {
+		destroy_workqueue(disk->zone_wplugs_wq);
+		disk->zone_wplugs_wq = NULL;
+	}
+
+	disk_free_zone_resources(disk);
+}
+
 static inline bool disk_need_zone_resources(struct gendisk *disk)
 {
 	/*
diff --git a/block/blk.h b/block/blk.h
index 2810b4d086e6..179662b86899 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -499,7 +499,7 @@ static inline void ioc_clear_queue(struct request_queue *q)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_init_zone_resources(struct gendisk *disk);
-void disk_free_zone_resources(struct gendisk *disk);
+void disk_release_zone_resources(struct gendisk *disk);
 static inline bool bio_zone_write_plugging(struct bio *bio)
 {
 	return bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
@@ -552,7 +552,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 static inline void disk_init_zone_resources(struct gendisk *disk)
 {
 }
-static inline void disk_free_zone_resources(struct gendisk *disk)
+static inline void disk_release_zone_resources(struct gendisk *disk)
 {
 }
 static inline bool bio_zone_write_plugging(struct bio *bio)
diff --git a/block/genhd.c b/block/genhd.c
index bbcfbd1a363c..6ba0e22ce9df 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1308,7 +1308,7 @@ static void disk_release(struct device *dev)
 
 	disk_release_events(disk);
 	kfree(disk->random);
-	disk_free_zone_resources(disk);
+	disk_release_zone_resources(disk);
 	xa_destroy(&disk->part_tbl);
 
 	kobject_put(&disk->queue_kobj);
-- 
2.56.0.307.g5fe7bd680c-goog

