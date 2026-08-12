Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE22309AA
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493387; cv=none; b=SpEtaj7Gghq5qEOD2Eb4dMpXBdjAE013G8belRI14hcBCD5rOEUgqdOMWkFYDNWwT1iiCuwzG8ggL0jgQYsmjfkD9Fuzo5J4C29X6+1oAMi4eNiWU7ZPVodXRg8Ec9Hq/PAHnz9Tm1DcoCsVxn+kxcEzteHj7dCzmBrbsny96zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493387; c=relaxed/simple;
	bh=em0xP1Iq6tOgaCzidYiGRN1YZPWgqRawZdl97HfXL1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSbpgbJnKewMWNyCMz0KY3751iq0ZoG0zMQtTHhS7pTgZJIvKCWeGV+AfgS2JSDDIg6hzNXdhAuUP3xJchJ+kpjzCoWRxoenhOq6HPO3v/rpfQCQU1JqreLEvnuwKDkRBc+jdnr5qeFFi/oTdaWzH5JlEFg3E+9G20px1k5qxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMnSsVyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMnSsVyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AF81F00A3E;
	Wed, 12 Aug 2026 00:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493386;
	bh=rSMApqQIWqu5CAbaXavpTRQmHwefSpiCd3LIwCeOWGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VMnSsVyKiiMSNSjCWrK41MW/LCGpZc048rBqw02G6g9RXZNcYWzUFzB71DubyzPlN
	 hJ9C7nuLz4vJ7OVDoKjyayCB9r2p6j49oWisBlVphVuqHfyGktCduz4iq4rt0Oz3wV
	 jEQ7mvHBkyCbr15qZERzhdTOm+zTFdMTjk3ZlbxyXm55n4EBmDZQPuPcMmW99u9cDo
	 WG77MiWWyNpjfS9rPXN/qi5ppD7EJ6ATEBLBiGlZjjCDQYzCdhpSLmHp9k+TIn4Tyj
	 SNz6Hd/YCeEFRt8w8f9WH52RWOnayNNWY2HttE3CNkOExkMJtLRNEEC3JVR8q60766
	 sF6yURMAGAxEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] scsi: sd: sd_zbc: Use logical blocks as unit when querying zones
Date: Tue, 11 Aug 2026 20:09:37 -0400
Message-ID: <20260812000941.4158732-2-sashal@kernel.org>
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

[ Upstream commit 43af5da09efb8abe450ec859d3063adeb7d1eb54 ]

When querying zones, track the position in logical blocks instead of in
sectors. This change slightly simplifies sd_zbc_report_zones().

Link: https://lore.kernel.org/r/20220421183023.3462291-4-bvanassche@acm.org
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
[ bvanassche: extracted this change from a larger patch ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 93dde0bf2f39 ("scsi: scsi_debug: Fix REPORT ZONES alloc_len underflow OOB write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd_zbc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index d9508332f9db2..f59e88a7862ae 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -223,7 +223,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	sector_t capacity = logical_to_sectors(sdkp->device, sdkp->capacity);
+	sector_t lba = sectors_to_logical(sdkp->device, sector);
 	unsigned int nr, i;
 	unsigned char *buf;
 	size_t offset, buflen = 0;
@@ -234,7 +234,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		/* Not a zoned device */
 		return -EOPNOTSUPP;
 
-	if (!capacity)
+	if (!sdkp->capacity)
 		/* Device gone or invalid */
 		return -ENODEV;
 
@@ -242,9 +242,8 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	if (!buf)
 		return -ENOMEM;
 
-	while (zone_idx < nr_zones && sector < capacity) {
-		ret = sd_zbc_do_report_zones(sdkp, buf, buflen,
-				sectors_to_logical(sdkp->device, sector), true);
+	while (zone_idx < nr_zones && lba < sdkp->capacity) {
+		ret = sd_zbc_do_report_zones(sdkp, buf, buflen, lba, true);
 		if (ret)
 			goto out;
 
@@ -262,7 +261,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			zone_idx++;
 		}
 
-		sector += sd_zbc_zone_sectors(sdkp) * i;
+		lba += sdkp->zone_blocks * i;
 	}
 
 	ret = zone_idx;
-- 
2.53.0

