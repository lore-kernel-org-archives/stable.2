Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793168491;
	b=XwJRERkXIBqgoQWBbyN5f2RmvzWkdTEh3BmLAJ+oG9nLruE4qz36tKeMTIy9FtD8Qs98
	 TGKxURxqO27ypjdglzzlWIfhH8KucktSqbh+avONncbyYjC+jZDXbiqrjA/810hlHcXmv
	 fUMySd1akBTBJAWifyUXl6DQcEev/sAsr6XJmupIgzQIwgngnySRFFqNd57fHhyNElw64
	 WBm2X3qSsn0Ak1U/8ro2/XU+XFXgymwtBXknDl/fQyEKIWLahaB2cXwaKDZ+jKwQMeYkw
	 VEMrq67cOAIKT974xk17oYSC8xMitLZAFcznTZrOLe6vbME/jKpVqiF8yYTKreLnHaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793168491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/05ZaCRLQ9lx6QfXSfycpdBANncM/d6CKhfzXQZzHNE=;
	b=ZQ7VE0DnCPYbWiXrn7NOfx4ul34uGiaJDL4JmHyHH2Z6xGLijtJIU7P95Ts7jvnY1MJH
	 4vRJrI6VLFqFtEl1IHC6jMlJC2Ssa2srbsflMBHW8O5msnfxvl+Kn7DQa+huTn9lAzQYE
	 wgWhmENZSGrfQr9mPyruxHtaMxBKUEPHYpSN/7GaO9DJPrr2rHzgMy9X4bPDfR4u6dUNa
	 ePoJnIxWIttx5VJpXLBnlY7RZsg5MVKeesDfpTcIPSkEFhXD4uP6sv0j0zy4UGRl/yLqO
	 wNSd4aGyAD3nMoKm8YzVJM+gJ8qUnY6Bu/o6GW8pOkYuyJQuWsgBDDX1+IVjvkoMTmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hOlg+nA/";
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8D606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 06:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1F8D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOlg+nA/
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e61817b178so1923275ad.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793168490; x=1793773290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/05ZaCRLQ9lx6QfXSfycpdBANncM/d6CKhfzXQZzHNE=;
        b=hOlg+nA/4j3I+dum72siK93wRo/zZ5R0RYTABviO0iUbEAPzLR1Cn34yl1rcxDv97W
         u6sO2IoTkPGl4Jg67O5IQCEC3OXgZFKcL3YLDqfg9+Csvg2pw/EijY9vfpOPmRxSYpy8
         v0ElFL5/4xliuJZdTng6X8aCZ8GEi0sfl2DQdFPnD6QO3ZHEZepapdAC2kS+vLHW8C/X
         3CnQEOqinnayZ0ydRKNX1+BkSQ4iDh3097DIQp9VZ0rRyQBKgcH8M6AkNtK8uYQGowkw
         spxxCmzFxggsJ1SjimGPxJu4Bu1t5bHpn9679QGR9+OlSh4OnO3mDlUBCedmdiu9C0NF
         rYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793168490; x=1793773290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/05ZaCRLQ9lx6QfXSfycpdBANncM/d6CKhfzXQZzHNE=;
        b=S3pCg5bY/egHiLGWtvYO121bf6fp6Yejn/vPJ8D435DtjFttimPaGyxOTA6FdAy7xh
         vI4AwgDd/41jwtFT7deZE3k5JaF50eEWLLbTp53N7m908ctK0i8WvesGyJWzRmSLnBiY
         VAtpCY2d+KqIpGq2T8YcUC2b0Fe+miUqD3wqBFmhSb2xQghyj0k9S11m0poPK47BfqbE
         acnCj5uNSMa8Eg0eTIFYRdRHgpfixLUyMEs01lXH8Spj2AwPyPPvQLV61M/R8TCorT+k
         o3KNKp7LkgffXfpelJgt8SCGRRBOLe++aCzpa4BsFcxfnC6ja1GFD7WRobV5MiSTajGI
         UYpw==
X-Forwarded-Encrypted: i=1; AKwUvBxDKcBWPiITLBUW4yDZk6r+K/6oF1bNmpKcu52rCeLFi4HmNjmhHxxw0h3Jd+CuR7tbxAKTUY8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqDk2/TK5o/UkZZ7BAfO3rnREnLOWsXzJtrhjwQ1HcsUcWFjrf
	BKf19OS+4CkzhM7x5DcMeiP9jQ3sWKpGec8RF9cseApm2pVGS5ExoAN3
X-Gm-Gg: AYBFou047KGhE2DWcZebxVTG1YoBPpQrMRBSUA5hKZHQfQwvQJynR0UTpTw5qJ4rOhC
	uEflAqwV9m4SUx0uPAedF7MbdhlGR8DbAbFzxCwHzrEQoK+H3oJypCrrM8kXSVVL5S+YH4jBRkW
	wyzl6tlQHxOuZCHMvdUWTmG3sxeXfSWUXxEuXv9gnq6YuXJ6sBVHwkLjO1ybON8qwG5Ocs157Dn
	hfQwdlyGFF1GO0/ncwwzKH3iGHVML2mMWySWBcVr3BakfxgE+Vo/nZYOSmICOxR3GNyiTPqUJlw
	CWZdxHSN6FtDOzOsW/15THN5gKIsxDRQhVJxStFy38CtQt5aB2gfWELghCQjDF+/GSpDQGYOzVb
	2WWJ7PskmQc1q4PypsR19kXKUaqfarsSb2NogcU5ldy0x6ZNyZwuPeCRYBoJvr21siqihtXyn+0
	196VZx2p0IPWhbS3+DXjmz9VFKOK6o60OiR7dPTozW+Q8PY+K4meAYeH8pb+oEW7TyTCPFM/G8g
	KakqTLppHaSzDEYOcdtAsVfib2Cd8KHwqNRaprVY2daCN33KAIZrYjMqngm9IdwUchHu5RLpK5m
	tuSvA8aZjTaa0GR2ha3QVb+9tp/fxoGTZAlBsLGSrAZ9WGEgzb4=
X-Received: by 2002:a17:903:324d:b0:2e8:3d48:4d8d with SMTP id d9443c01a7336-2eaffb1868bmr15283205ad.0.1793168490216;
        Tue, 27 Oct 2026 23:21:30 -0700 (PDT)
Received: from LAPTOP-QJLDGQ2L.localdomain ([112.224.179.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c33917sm17992275ad.48.2026.10.27.23.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 23:21:29 -0700 (PDT)
From: Boyan Liu <yymhvert@gmail.com>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+4a4f9998e2b4b490@bugs.sh,
	Boyan Liu <yymhvert@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: sd_zbc: cap zone report count by buffer size
Date: Wed, 28 Oct 2026 14:16:51 +0800
Message-ID: <20261028061651.110435-1-yymhvert@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sd_zbc_report_zones() limits descriptor parsing to the requested zone
count and the device-reported ZONE LIST LENGTH, but not to the number of
descriptors that fit in the allocated report buffer. A malicious or
malfunctioning device can report an oversized length and cause
out-of-bounds reads while the descriptors are parsed:

    BUG: KASAN: slab-out-of-bounds in sd_zbc_report_zones (drivers/scsi/sd_zbc.c:256)
    Read of size 8 at addr ffff88802c8d2610 by task kworker/u8:2/37
    Call Trace:
     sd_zbc_report_zones (drivers/scsi/sd_zbc.c:256)
     blk_revalidate_disk_zones (block/blk-zoned.c:2354)
     sd_zbc_revalidate_zones (drivers/scsi/sd_zbc.c:566)
     sd_revalidate_disk (drivers/scsi/sd.c:3898)
     sd_probe (drivers/scsi/sd.c:4101)

Cap the descriptor count with min3() over the remaining requested zones,
the device-reported count, and max_in_buf derived from buflen. This
matches nvme_ns_report_zones() and preserves iteration over reports
that require multiple commands.

Fixes: d41003513e61 ("block: rework zone reporting")
Cc: stable@vger.kernel.org
Reported-by: co+4a4f9998e2b4b490@bugs.sh
Signed-off-by: Boyan Liu <yymhvert@gmail.com>
---
 drivers/scsi/sd_zbc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 56e455fb5add..6a2644a67849 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -222,7 +222,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	sector_t lba = sectors_to_logical(sdkp->device, sector);
-	unsigned int nr, i;
+	unsigned int nr, i, max_in_buf;
 	unsigned char *buf;
 	u64 zone_length, start_lba;
 	size_t offset, buflen = 0;
@@ -241,13 +241,16 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	if (!buf)
 		return -ENOMEM;
 
+	max_in_buf = (buflen - 64) / 64;
+
 	while (zone_idx < nr_zones && lba < sdkp->capacity) {
 		ret = sd_zbc_do_report_zones(sdkp, buf, buflen, lba, true);
 		if (ret)
 			goto out;
 
 		offset = 0;
-		nr = min(nr_zones, get_unaligned_be32(&buf[0]) / 64);
+		nr = min3(nr_zones - zone_idx,
+			  get_unaligned_be32(&buf[0]) / 64, max_in_buf);
 		if (!nr)
 			break;
 
-- 
2.43.0

