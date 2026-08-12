Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9395403123
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525919; cv=none; b=oKg7tw5G2VJ1ba2In4ULQe96/gQYh/Ji/oTfS0tvd/0X7fvwScVW14gCr1ZwQeO0Kl2vbgre+S8vT+mKEuQb0WUDC1+JF6hly3MM0QjakWbJgixudMXheqkW2piDZK9k21dcum3YBQ3K42exFLOaoFU1nFzPmduqq+52q2L5Hz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525919; c=relaxed/simple;
	bh=DpsnMYqKvcZ9xc/6NOXmLg9nPCSm9DQnqVqfnIvouI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfmn33Q++J8l/CXc6zmDD6re0gDJU2fZkBO6VuG6YZtvUxX3/2T4YZOO59s0L/KB3nFGk0alqTLUXYdSnIhPfJwS+gYx2ky6Ab72NGawYAHYK02+aeDAJpZg4kVRb5S0LB7Q9iyA+2wEVa1AjtN784pYJ1TS8xP/guIODR6M8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho/qP+7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho/qP+7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AD21F00A3D;
	Wed, 12 Aug 2026 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525917;
	bh=61m0uf2Wd8DOQ2fORsmXIMYuFgm51ytuL5Si+y8pPow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ho/qP+7z+KF8tkx9fq+L9w6tkh+iBgllxdfWJT6sGd+YT11PbzF6yrBGsVTt5YSg5
	 IY0m0XQkEdxJrxkjMLscmPYAhzoBo+/FLKR9PqFAReZDKVb7ZjKNaT0q1iKczH07fD
	 ZcWUPN5dyabTlnIx6A3kMXw43eqmYpBNG9HFeVV/4sJFoDPTe9RzIgKpA1bq9vcOe1
	 QxZ5C/VhHr55cIqhDZCWr3Rsn4N+iuQkpt+l6ani1ZlS2DBK/haffcxn83vqJWBZyp
	 kd53W2H+QoDkwCDpDUlNFWFDf9RxzDsvJUhe88E7nZKNYFgQI9iLV+uI1m21f2rj/8
	 uaKxOMt45gjyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] scsi: sd: sd_zbc: Use logical blocks as unit when querying zones
Date: Wed, 12 Aug 2026 05:11:50 -0400
Message-ID: <20260812091153.1357339-2-sashal@kernel.org>
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
index 012f5dedef171..5f905d13b911d 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -224,7 +224,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	sector_t capacity = logical_to_sectors(sdkp->device, sdkp->capacity);
+	sector_t lba = sectors_to_logical(sdkp->device, sector);
 	unsigned int nr, i;
 	unsigned char *buf;
 	size_t offset, buflen = 0;
@@ -235,7 +235,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		/* Not a zoned device */
 		return -EOPNOTSUPP;
 
-	if (!capacity)
+	if (!sdkp->capacity)
 		/* Device gone or invalid */
 		return -ENODEV;
 
@@ -243,9 +243,8 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	if (!buf)
 		return -ENOMEM;
 
-	while (zone_idx < nr_zones && sector < capacity) {
-		ret = sd_zbc_do_report_zones(sdkp, buf, buflen,
-				sectors_to_logical(sdkp->device, sector), true);
+	while (zone_idx < nr_zones && lba < sdkp->capacity) {
+		ret = sd_zbc_do_report_zones(sdkp, buf, buflen, lba, true);
 		if (ret)
 			goto out;
 
@@ -263,7 +262,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			zone_idx++;
 		}
 
-		sector += sd_zbc_zone_sectors(sdkp) * i;
+		lba += sdkp->zone_blocks * i;
 	}
 
 	ret = zone_idx;
-- 
2.53.0

