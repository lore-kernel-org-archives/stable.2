Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA68407CEF
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525921; cv=none; b=WolzD5ONEiG63YGgJpOEMcmtimFPNGS2H74BivdYV80n1zP53erZvN5vmMhMlWFJ1DqipO3NaHJ/ctpFaK/HJ78vaEQ7AR5QMow6LzUdHD0EGeZTPSUd2IkhrU1Pgi/Mqk0ScVsGxPqwP0d5+Wl6YJhC2O4Cmyo12/J2jh0d6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525921; c=relaxed/simple;
	bh=awPtPRR679trHMOixSViUVMMV40tE+zJAY3taoTQ68Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amLEDo7B9pN+1AlyczOQUc2/+AAb7FxLZuzaxK8PzO9BAq095u/wcwzF4r3K64hdRxIReArv38Hg45Pb8wd94/APL1SFsIuYG2JASaDe42SfX7T1ysBaYZGDw9qcrxcwsOqFNs87/46RM5w1yvUhwClkvjCX39F9AkgIuCwmBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYNDjAiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYNDjAiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0711F00A3E;
	Wed, 12 Aug 2026 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525919;
	bh=5NhrEA2/QcWGekjlAkxjVHOXrmpEpNvrd+YdZwMrSSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYNDjAiLuwdCXZ+84EHd/bwEVPzYsTA/AGXQa/+VOCdgj3E6ZQYCjFOmkpnObRbBH
	 5UMDggTpJSaTLasKUvO/6ZXnkeHIegg+aKMXBCpflPqwGRL+ELvaPMWvxE4aVQsNHh
	 PhWz+ZxY7OpkPf/ut0lMPezR/lfmpoy08ZgJQCrwbCgN0QYAHl57PYAq1OOFQ30m92
	 z2q2ovhzvPGYbJNvMECGpYYIgZzOIf7jTER7UoiVo4DgFoviIGdzuzGKz1zfffYFL1
	 na2+EoV4A18enaL45RiGL+6m2wYDOcRzlOS0VEXjrJPve5jnPORIx5VzJJUgr5JP0w
	 KcL5Oib6zTb9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] scsi: scsi_debug: Rename zone type constants
Date: Wed, 12 Aug 2026 05:11:52 -0400
Message-ID: <20260812091153.1357339-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812091153.1357339-1-sashal@kernel.org>
References: <2026080556-overlap-everybody-5524@gregkh>
 <20260812091153.1357339-1-sashal@kernel.org>
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
index 7cfc6db817634..ad4cea4e14848 100644
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
@@ -2681,7 +2681,7 @@ static struct sdeb_zone_state *zbc_zone(struct sdebug_dev_info *devip,
 
 static inline bool zbc_zone_is_conv(struct sdeb_zone_state *zsp)
 {
-	return zsp->z_type == ZBC_ZONE_TYPE_CNV;
+	return zsp->z_type == ZBC_ZTYPE_CNV;
 }
 
 static void zbc_close_zone(struct sdebug_dev_info *devip,
@@ -2780,7 +2780,7 @@ static void zbc_inc_wp(struct sdebug_dev_info *devip,
 	if (zbc_zone_is_conv(zsp))
 		return;
 
-	if (zsp->z_type == ZBC_ZONE_TYPE_SWR) {
+	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		zsp->z_wp += num;
 		if (zsp->z_wp >= zend)
 			zbc_set_zone_full(devip, zsp);
@@ -2847,7 +2847,7 @@ static int check_zbc_access_params(struct scsi_cmnd *scp,
 		return 0;
 	}
 
-	if (zsp->z_type == ZBC_ZONE_TYPE_SWR) {
+	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		/* Writes cannot cross sequential zone boundaries */
 		if (zsp_end != zsp) {
 			mk_sense_buffer(scp, ILLEGAL_REQUEST,
@@ -4913,14 +4913,14 @@ static int sdebug_device_create_zones(struct sdebug_dev_info *devip)
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

