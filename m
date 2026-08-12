Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97322AE48
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493390; cv=none; b=HYShE9WHO6Hb4Vv1qMmOhWKrR2hfzFp95cOge5X6wPnAq8kTdYCEX3Q5Q8MAf+mwcBAqZPK3PHbY5byrv5Vmz/gZiOwQqg9jdOUBywmqGguACXb/7kXeb2qVXlPd3NCEpuoQuk7nbeB9wmSHQwHxh6CrioPLu/Re7NUV5xKMKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493390; c=relaxed/simple;
	bh=OTpFGITWVKsOn/MIgPD+dDGB+kS32A0t42DjYgLNAkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnB4ZSM32Pb02elHisS5NsknrqPDmvmrjDxhxGPZqx0kGegtz2MmQ2bqev7Kxx0I6BT8IUUZBaOlihCQQp1P4dyhj8DVlwd4/ASgZJLsVt6u+8VYvZMmfMlfqFBCYmpry9PDm+5q9DxrGQ3fypBglpH3k37FLezhBPenX3SKksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4vofuLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4vofuLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5321F00A3F;
	Wed, 12 Aug 2026 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493389;
	bh=bgnzC0wvx+ZzwUV176NbWSN6SCo5pc5/Tw/dOCD/aS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4vofuLehScGbJk8cgQehbz3xGuk7XSZrgyC/i6nzPxPHzbjnnU7e46q6tbfdQwrH
	 bGMtdpJPtSiIcyZAPQNPbdVxOyvkkDXw/LGuDoZ8QqfscQGXAx71lXZZB5Uzzmwu1Z
	 uLrIGUqCe2DvUNX/GEmVWCDrVaWa9x+6fD044a4u5T7mI5lupjEZi2ucgaGehiM6Rr
	 teGeHBFs3d8eQjy2WZQCy1iXz96XgBs1IAlXpdzKVlLKrXopFT95G0w+zsZ6NRQ18w
	 7zXNvKUAPev8BGIS/r/AmM0LR7vdWWE63uaFM0CGq/3osKJxs15IzthOC8/Hf1b49G
	 jimNyAerX5N5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] scsi: scsi_debug: Rename zone type constants
Date: Tue, 11 Aug 2026 20:09:40 -0400
Message-ID: <20260812000941.4158732-5-sashal@kernel.org>
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit 35dbe2b9a7b0c92777c855c6a2cca8390f4c166b ]

Rename the scsi_debug zone type constants to prevent a conflict with the
ZBC_ZONE_TYPE_GAP constant from include/scsi/scsi_proto.h.

Link: https://lore.kernel.org/r/20220421183023.3462291-9-bvanassche@acm.org
Cc: Douglas Gilbert <dgilbert@interlog.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
[ bvanassche: Extracted these changes from a larger patch ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 93dde0bf2f39 ("scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_debug.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 591df0a91057e..e39675649bae6 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -250,9 +250,9 @@ static const char *sdebug_version_date = "20200710";
 
 /* Zone types (zbcr05 table 25) */
 enum sdebug_z_type {
-	ZBC_ZONE_TYPE_CNV	= 0x1,
-	ZBC_ZONE_TYPE_SWR	= 0x2,
-	ZBC_ZONE_TYPE_SWP	= 0x3,
+	ZBC_ZTYPE_CNV	= 0x1,
+	ZBC_ZTYPE_SWR	= 0x2,
+	ZBC_ZTYPE_SWP	= 0x3,
 };
 
 /* enumeration names taken from table 26, zbcr05 */
@@ -2682,7 +2682,7 @@ static struct sdeb_zone_state *zbc_zone(struct sdebug_dev_info *devip,
 
 static inline bool zbc_zone_is_conv(struct sdeb_zone_state *zsp)
 {
-	return zsp->z_type == ZBC_ZONE_TYPE_CNV;
+	return zsp->z_type == ZBC_ZTYPE_CNV;
 }
 
 static void zbc_close_zone(struct sdebug_dev_info *devip,
@@ -2781,7 +2781,7 @@ static void zbc_inc_wp(struct sdebug_dev_info *devip,
 	if (zbc_zone_is_conv(zsp))
 		return;
 
-	if (zsp->z_type == ZBC_ZONE_TYPE_SWR) {
+	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		zsp->z_wp += num;
 		if (zsp->z_wp >= zend)
 			zbc_set_zone_full(devip, zsp);
@@ -2848,7 +2848,7 @@ static int check_zbc_access_params(struct scsi_cmnd *scp,
 		return 0;
 	}
 
-	if (zsp->z_type == ZBC_ZONE_TYPE_SWR) {
+	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		/* Writes cannot cross sequential zone boundaries */
 		if (zsp_end != zsp) {
 			mk_sense_buffer(scp, ILLEGAL_REQUEST,
@@ -4934,14 +4934,14 @@ static int sdebug_device_create_zones(struct sdebug_dev_info *devip)
 		zsp->z_start = zstart;
 
 		if (i < devip->nr_conv_zones) {
-			zsp->z_type = ZBC_ZONE_TYPE_CNV;
+			zsp->z_type = ZBC_ZTYPE_CNV;
 			zsp->z_cond = ZBC_NOT_WRITE_POINTER;
 			zsp->z_wp = (sector_t)-1;
 		} else {
 			if (devip->zmodel == BLK_ZONED_HM)
-				zsp->z_type = ZBC_ZONE_TYPE_SWR;
+				zsp->z_type = ZBC_ZTYPE_SWR;
 			else
-				zsp->z_type = ZBC_ZONE_TYPE_SWP;
+				zsp->z_type = ZBC_ZTYPE_SWP;
 			zsp->z_cond = ZC1_EMPTY;
 			zsp->z_wp = zsp->z_start;
 		}
-- 
2.53.0

