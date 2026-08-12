Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24C404BE3
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525919; cv=none; b=toGRFSZirYHyHtycu/edJZbFsyOyZv0WVvI+a8AuSxsQxrVAYhy8yNuYfo8grlECB4RmQaq6b8crm9q4r9PMsQ6yj6Uz1sUTh8N6nKOm21V0QqNxRAbiYkL0YCoBnsUrAkbL0hQcn7q2GEsMeoccIQiyyl/6Um9F8MCBvLUujWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525919; c=relaxed/simple;
	bh=k99AyxeRKYK0ewTGTtEa2ZvsqKtuoQMRmUrlvblrwx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyK/qwLkKf2ZDqJX5KHdTQb8FhT6EdZ0X/CgyKhGxFFQkYZlEHcC+3DFjsgjjNf3Kf8edKkQ1f4O34LBjVJBg6g1XwAbX+pk73vSG0TkGQ6EG5DvK6ChbJzn7ibxezMl2l6YIwbp0sF9QtPeSR10dbXqn1GLR8P2FalWKoY9kU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRcLPsj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRcLPsj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C9C1F000E9;
	Wed, 12 Aug 2026 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525916;
	bh=JV5dChv4xGt9cJGEAhppQIzJ/lTBd9hIvPSi30WGP10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QRcLPsj8AxmXavFNb7lwHTbgtBwdw09o4TrdI8WnaXrGG45ZSQAcI9zJyuQbl3u40
	 YWkmTi4LKTdRRZ+nGvYUKwCs9PHIgTlwvg9O1KB7Qfs+DeOyO1qPeoy9lJJy2f0W8O
	 dOryj1heg4ztzfGzaiEbVmhvydv/dBPFPWwQ4xovZoqPZhcQgYrVizaA7I7m00top1
	 bAYHphSf4MbpQ4+sAbDh1BWhrb6/uuzsa0KSeVgnmznb0U6OYo1ZYHFTuQrAulo2CB
	 IAMEK68T2oq7ryyOZCMtkRuUETvEm40TFDfke5NdnGLfmQCsUn4vqIg4ZvNDCnzu9j
	 cQ0VPmcnj1rzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] scsi: sd: sd_zbc: Improve source code documentation
Date: Wed, 12 Aug 2026 05:11:49 -0400
Message-ID: <20260812091153.1357339-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080556-overlap-everybody-5524@gregkh>
References: <2026080556-overlap-everybody-5524@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit aa96bfb4caff59c93f0637092efe3a714cab0fe6 ]

Add several kernel-doc headers. Declare input arrays const. Specify the
array size in function declarations.

Link: https://lore.kernel.org/r/20220421183023.3462291-2-bvanassche@acm.org
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 93dde0bf2f39 ("scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.h     |  5 ++--
 drivers/scsi/sd_zbc.c | 55 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index b59136c4125ba..33cc01f98c6a0 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -217,7 +217,7 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 #ifdef CONFIG_BLK_DEV_ZONED
 
 void sd_zbc_release_disk(struct scsi_disk *sdkp);
-int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
+int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE]);
 int sd_zbc_revalidate_zones(struct scsi_disk *sdkp);
 blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 					 unsigned char op, bool all);
@@ -233,8 +233,7 @@ blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 
 static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
 
-static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
-				    unsigned char *buf)
+static inline int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 {
 	return 0;
 }
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 9b5dca0b6cf9a..012f5dedef171 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -20,6 +20,12 @@
 
 #include "sd.h"
 
+/**
+ * sd_zbc_get_zone_wp_offset - Get zone write pointer offset.
+ * @zone: Zone for which to return the write pointer offset.
+ *
+ * Return: offset of the write pointer from the start of the zone.
+ */
 static unsigned int sd_zbc_get_zone_wp_offset(struct blk_zone *zone)
 {
 	if (zone->type == ZBC_ZONE_TYPE_CONV)
@@ -44,7 +50,21 @@ static unsigned int sd_zbc_get_zone_wp_offset(struct blk_zone *zone)
 	}
 }
 
-static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
+/**
+ * sd_zbc_parse_report - Parse a SCSI zone descriptor
+ * @sdkp: SCSI disk pointer.
+ * @buf: SCSI zone descriptor.
+ * @idx: Index of the zone relative to the first zone reported by the current
+ *	sd_zbc_report_zones() call.
+ * @cb: Callback function pointer.
+ * @data: Second argument passed to @cb.
+ *
+ * Return: Value returned by @cb.
+ *
+ * Convert a SCSI zone descriptor into struct blk_zone format. Additionally,
+ * call @cb(blk_zone, @data).
+ */
+static int sd_zbc_parse_report(struct scsi_disk *sdkp, const u8 buf[64],
 			       unsigned int idx, report_zones_cb cb, void *data)
 {
 	struct scsi_device *sdp = sdkp->device;
@@ -189,6 +209,17 @@ static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
 	return logical_to_sectors(sdkp->device, sdkp->zone_blocks);
 }
 
+/**
+ * sd_zbc_report_zones - SCSI .report_zones() callback.
+ * @disk: Disk to report zones for.
+ * @sector: Start sector.
+ * @nr_zones: Maximum number of zones to report.
+ * @cb: Callback function called to report zone information.
+ * @data: Second argument passed to @cb.
+ *
+ * Called by the block layer to iterate over zone information. See also the
+ * disk->fops->report_zones() calls in block/blk-zoned.c.
+ */
 int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
@@ -276,6 +307,10 @@ static int sd_zbc_update_wp_offset_cb(struct blk_zone *zone, unsigned int idx,
 	return 0;
 }
 
+/*
+ * An attempt to append a zone triggered an invalid write pointer error.
+ * Reread the write pointer of the zone(s) in which the append failed.
+ */
 static void sd_zbc_update_wp_offset_workfn(struct work_struct *work)
 {
 	struct scsi_disk *sdkp;
@@ -584,7 +619,7 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
  * sd_zbc_check_capacity - Check the device capacity
  * @sdkp: Target disk
  * @buf: command buffer
- * @zblocks: zone size in number of blocks
+ * @zblocks: zone size in logical blocks
  *
  * Get the device zone size and check that the device capacity as reported
  * by READ CAPACITY matches the max_lba value (plus one) of the report zones
@@ -679,6 +714,11 @@ static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)
 	swap(sdkp->zones_wp_offset, sdkp->rev_wp_offset);
 }
 
+/*
+ * Call blk_revalidate_disk_zones() if any of the zoned disk properties have
+ * changed that make it necessary to call that function. Called by
+ * sd_revalidate_disk() after the gendisk capacity has been set.
+ */
 int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 {
 	struct gendisk *disk = sdkp->disk;
@@ -757,7 +797,16 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	return ret;
 }
 
-int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
+/**
+ * sd_zbc_read_zones - Read zone information and update the request queue
+ * @sdkp: SCSI disk pointer.
+ * @buf: 512 byte buffer used for storing SCSI command output.
+ *
+ * Read zone information and update the request queue zone characteristics and
+ * also the zoned device information in *sdkp. Called by sd_revalidate_disk()
+ * before the gendisk capacity has been set.
+ */
+int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 {
 	struct gendisk *disk = sdkp->disk;
 	struct request_queue *q = disk->queue;
-- 
2.53.0

