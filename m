Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D8233928
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493388; cv=none; b=ka9CsKhnEvKZgXouWoby9gKfGp/LajKrz9xmsIviP7PxPJwakbZ5wfzwxFIGmk44ck80kKIC1PcnY8VC4rURU2aLg/TyZtzh2HT7H+OMFrBEXKw89r4pr9iu2ydV51GVYVsSZMUFHtCZV1tDXXjz8WBqC+oBBhrfJ2+HR6BeDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493388; c=relaxed/simple;
	bh=/eyXE0xCrWAJgd4+a3mRsCwTg8uCtm1+Q5GJIi9Jt7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWMlG13kmgrNraJqz1sE+/tzbqzdboiUsJ2wMVrVDWYfqFPExdujL6dSeIt8XIABnOCkk75nJmcvyxdUbBng0mH7MOStclGErhOz9Yp1RuU16oij2cB3ZW3cVjwEjKyUz1HKBIzoUqHQa6jBDwGAHVHHDnyEJokSUx635p4fIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nfk20h4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nfk20h4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904A91F00A3D;
	Wed, 12 Aug 2026 00:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493387;
	bh=vITnqdc5cba1qag7AEWaoXwbEnOYlqsUiKOvr40nEKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nfk20h4iMC95gouHFppM3CQk5zO/gGljNcLkaBJ+XcKtInJXV6xnt3ka8uYaigV+d
	 Fq3OFT3iUsmhlRRpBAuXk6VaDzJZOxIrgcc2VSTMQkwK6lfVLpAWEj02pKwBn+BnkT
	 uQ8atAuU9s2AjM2Z93+AkKz9IBBYOrCsvV9o4V3xFvQUGPe/gO0+R9UnjjXYoYj+QW
	 zxAfVznmcYYYWKeIMTzXMzAR1uFM/h05mhs1Bn4reSMwmOo9EIyWnUIX0ZPoHFjBtk
	 o1z79rbWziKef9UDEXcIKr7O+wJL3tIeLMb+rb/GjAUr3sLeneuIfnN4LMc26rFJTS
	 PMOPyYBZLpa7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] scsi: sd: sd_zbc: Introduce struct zoned_disk_info
Date: Tue, 11 Aug 2026 20:09:38 -0400
Message-ID: <20260812000941.4158732-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812000941.4158732-1-sashal@kernel.org>
References: <2026080556-pancake-criteria-119e@gregkh>
 <20260812000941.4158732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 628617be8968e575ca0a0637fb227f8a990cb2f7 ]

Deriving the meaning of the nr_zones, rev_nr_zones, zone_blocks and
rev_zone_blocks member variables requires careful analysis of the source
code. Make the meaning of these member variables easier to understand by
introducing struct zoned_disk_info.

Link: https://lore.kernel.org/r/20220421183023.3462291-5-bvanassche@acm.org
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 93dde0bf2f39 ("scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.h     | 22 +++++++++++++++----
 drivers/scsi/sd_zbc.c | 49 ++++++++++++++++++++-----------------------
 2 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 33cc01f98c6a0..6e93800d6e76b 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -67,6 +67,20 @@ enum {
 	SD_ZERO_WS10_UNMAP,	/* Use WRITE SAME(10) with UNMAP */
 };
 
+/**
+ * struct zoned_disk_info - Specific properties of a ZBC SCSI device.
+ * @nr_zones: number of zones.
+ * @zone_blocks: number of logical blocks per zone.
+ *
+ * This data structure holds the ZBC SCSI device properties that are retrieved
+ * twice: a first time before the gendisk capacity is known and a second time
+ * after the gendisk capacity is known.
+ */
+struct zoned_disk_info {
+	u32		nr_zones;
+	u32		zone_blocks;
+};
+
 struct scsi_disk {
 	struct scsi_driver *driver;	/* always &sd_template */
 	struct scsi_device *device;
@@ -74,10 +88,10 @@ struct scsi_disk {
 	struct gendisk	*disk;
 	struct opal_dev *opal_dev;
 #ifdef CONFIG_BLK_DEV_ZONED
-	u32		nr_zones;
-	u32		rev_nr_zones;
-	u32		zone_blocks;
-	u32		rev_zone_blocks;
+	/* Updated during revalidation before the gendisk capacity is known. */
+	struct zoned_disk_info	early_zone_info;
+	/* Updated during revalidation after the gendisk capacity is known. */
+	struct zoned_disk_info	zone_info;
 	u32		zones_optimal_open;
 	u32		zones_optimal_nonseq;
 	u32		zones_max_open;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index f59e88a7862ae..c41cfbaf8c63e 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -181,7 +181,7 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
 	 * sure that the allocated buffer can always be mapped by limiting the
 	 * number of pages allocated to the HBA max segments limit.
 	 */
-	nr_zones = min(nr_zones, sdkp->nr_zones);
+	nr_zones = min(nr_zones, sdkp->zone_info.nr_zones);
 	bufsize = roundup((nr_zones + 1) * 64, SECTOR_SIZE);
 	bufsize = min_t(size_t, bufsize,
 			queue_max_hw_sectors(q) << SECTOR_SHIFT);
@@ -205,7 +205,7 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
  */
 static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
 {
-	return logical_to_sectors(sdkp->device, sdkp->zone_blocks);
+	return logical_to_sectors(sdkp->device, sdkp->zone_info.zone_blocks);
 }
 
 /**
@@ -261,7 +261,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			zone_idx++;
 		}
 
-		lba += sdkp->zone_blocks * i;
+		lba += sdkp->zone_info.zone_blocks * i;
 	}
 
 	ret = zone_idx;
@@ -319,14 +319,14 @@ static void sd_zbc_update_wp_offset_workfn(struct work_struct *work)
 	sdkp = container_of(work, struct scsi_disk, zone_wp_offset_work);
 
 	spin_lock_irqsave(&sdkp->zones_wp_offset_lock, flags);
-	for (zno = 0; zno < sdkp->nr_zones; zno++) {
+	for (zno = 0; zno < sdkp->zone_info.nr_zones; zno++) {
 		if (sdkp->zones_wp_offset[zno] != SD_ZBC_UPDATING_WP_OFST)
 			continue;
 
 		spin_unlock_irqrestore(&sdkp->zones_wp_offset_lock, flags);
 		ret = sd_zbc_do_report_zones(sdkp, sdkp->zone_wp_update_buf,
 					     SD_BUF_SIZE,
-					     zno * sdkp->zone_blocks, true);
+					     zno * sdkp->zone_info.zone_blocks, true);
 		spin_lock_irqsave(&sdkp->zones_wp_offset_lock, flags);
 		if (!ret)
 			sd_zbc_parse_report(sdkp, sdkp->zone_wp_update_buf + 64,
@@ -393,7 +393,7 @@ blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 		break;
 	default:
 		wp_offset = sectors_to_logical(sdkp->device, wp_offset);
-		if (wp_offset + nr_blocks > sdkp->zone_blocks) {
+		if (wp_offset + nr_blocks > sdkp->zone_info.zone_blocks) {
 			ret = BLK_STS_IOERR;
 			break;
 		}
@@ -524,7 +524,7 @@ static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,
 		break;
 	case REQ_OP_ZONE_RESET_ALL:
 		memset(sdkp->zones_wp_offset, 0,
-		       sdkp->nr_zones * sizeof(unsigned int));
+		       sdkp->zone_info.nr_zones * sizeof(unsigned int));
 		break;
 	default:
 		break;
@@ -674,16 +674,16 @@ static void sd_zbc_print_zones(struct scsi_disk *sdkp)
 	if (!sd_is_zoned(sdkp) || !sdkp->capacity)
 		return;
 
-	if (sdkp->capacity & (sdkp->zone_blocks - 1))
+	if (sdkp->capacity & (sdkp->zone_info.zone_blocks - 1))
 		sd_printk(KERN_NOTICE, sdkp,
 			  "%u zones of %u logical blocks + 1 runt zone\n",
-			  sdkp->nr_zones - 1,
-			  sdkp->zone_blocks);
+			  sdkp->zone_info.nr_zones - 1,
+			  sdkp->zone_info.zone_blocks);
 	else
 		sd_printk(KERN_NOTICE, sdkp,
 			  "%u zones of %u logical blocks\n",
-			  sdkp->nr_zones,
-			  sdkp->zone_blocks);
+			  sdkp->zone_info.nr_zones,
+			  sdkp->zone_info.zone_blocks);
 }
 
 static int sd_zbc_init_disk(struct scsi_disk *sdkp)
@@ -710,10 +710,8 @@ static void sd_zbc_clear_zone_info(struct scsi_disk *sdkp)
 	kfree(sdkp->zone_wp_update_buf);
 	sdkp->zone_wp_update_buf = NULL;
 
-	sdkp->nr_zones = 0;
-	sdkp->rev_nr_zones = 0;
-	sdkp->zone_blocks = 0;
-	sdkp->rev_zone_blocks = 0;
+	sdkp->early_zone_info = (struct zoned_disk_info){ };
+	sdkp->zone_info = (struct zoned_disk_info){ };
 
 	mutex_unlock(&sdkp->rev_mutex);
 }
@@ -740,8 +738,8 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 {
 	struct gendisk *disk = sdkp->disk;
 	struct request_queue *q = disk->queue;
-	u32 zone_blocks = sdkp->rev_zone_blocks;
-	unsigned int nr_zones = sdkp->rev_nr_zones;
+	u32 zone_blocks = sdkp->early_zone_info.zone_blocks;
+	unsigned int nr_zones = sdkp->early_zone_info.nr_zones;
 	u32 max_append;
 	int ret = 0;
 	unsigned int flags;
@@ -772,14 +770,14 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	 */
 	mutex_lock(&sdkp->rev_mutex);
 
-	if (sdkp->zone_blocks == zone_blocks &&
-	    sdkp->nr_zones == nr_zones &&
+	if (sdkp->zone_info.zone_blocks == zone_blocks &&
+	    sdkp->zone_info.nr_zones == nr_zones &&
 	    disk->queue->nr_zones == nr_zones)
 		goto unlock;
 
 	flags = memalloc_noio_save();
-	sdkp->zone_blocks = zone_blocks;
-	sdkp->nr_zones = nr_zones;
+	sdkp->zone_info.zone_blocks = zone_blocks;
+	sdkp->zone_info.nr_zones = nr_zones;
 	sdkp->rev_wp_offset = kvcalloc(nr_zones, sizeof(u32), GFP_KERNEL);
 	if (!sdkp->rev_wp_offset) {
 		ret = -ENOMEM;
@@ -794,8 +792,7 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	sdkp->rev_wp_offset = NULL;
 
 	if (ret) {
-		sdkp->zone_blocks = 0;
-		sdkp->nr_zones = 0;
+		sdkp->zone_info = (struct zoned_disk_info){ };
 		sdkp->capacity = 0;
 		goto unlock;
 	}
@@ -881,8 +878,8 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
 		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
 
-	sdkp->rev_nr_zones = nr_zones;
-	sdkp->rev_zone_blocks = zone_blocks;
+	sdkp->early_zone_info.nr_zones = nr_zones;
+	sdkp->early_zone_info.zone_blocks = zone_blocks;
 
 	return 0;
 
-- 
2.53.0

