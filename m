Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973129;
	b=F76JijU2u7aRHUIecIJbZ6Ds7WWTA164lV761K2mKLxpteVUYWXqlpk4c5qfXkohuz5Q
	 gO7GpPf6bGNCBJR8SMdOVmgckg94r7Bp/C1JlbiYJSFtUt50/1FQ9MQxCapk+6WW2UtyG
	 +OF9KrLIQ6V6cSP+LBHL/ZZeqAI0B4IKazksREPf0et9oI9pocg1Rvic5pqlFaHCqtRDr
	 7YsHSXJU9680S/tJguPskhFhjMszpF7POiNGsbLu5MQAGAsQ8kyBK89D84iRZz4GaGkSL
	 dNfrQt9ROSYo3730gleB7rZjWKDYAM4FZxVaZp10Zn8kl5zmzWny5lx7xI3w4UhqOTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T1XZ1WfHH7XnOv0sWlDb4paoPJtD91jpUpFHrBDh51s=;
	b=jor8Ivoq8PFEqGdLPR9CYKMkrgxqFGcwIwcudKtHOH+ObxoeabrNvQ9+MmN472Qdhev5
	 rvn4knRsB8bwWoC03fz+bribORDpjtR8iVx0tzR+VNwGAORvlOvJB/mGnoZPIZupw4Pbp
	 DK/86UIgt73Pgmq0W26q2ecHPyIWGjPs5EHxsMiI6Q5gWcETmTDSCd31Fp0Ipkuotop5x
	 aw0vC52sXoIwGDhqNclsbeweIkF2YLJdzOaduKhpe/QNbrue9sZOUcZkdDfTBhQtyN34T
	 jQxQGmpUxvqXMIyDzTt0+jCznhihfng2Mpk0HYy7urJV6G/l5gWWQel7nrVyvZ0mtoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NHCbz66H;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D0606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD8D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NHCbz66H
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so1730540eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792973128; x=1793577928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1XZ1WfHH7XnOv0sWlDb4paoPJtD91jpUpFHrBDh51s=;
        b=NHCbz66H380hLDe36iJ3YyizU2wTxHQ+sK8vl+yKeiJN8/DjTGde+YR9MLqjB6kIgZ
         I+IfDdfzG1iQZ+SkJu/jOBCgxll2hH9RyTjZsYh4JoBPpLcrT4h9UyWv79O/fLk5zM65
         GGJ3rhPKPzsJKKhaaYyNBPTyrjBIUZaw2EGP6AgLFK0ocdHs630f99fSl9Pj88ezI2Zv
         6LN70Evdyt+8e81Pgsp2kBKxF4jE7muUAW2FglveSpbHpPzoGNWmDghUGb97R3kyPjZn
         4ppQeuWyLQ4zykkxUCLRKrG2VNuCwo/UqNDL1daLK3CLOO46nOdzLEN0BMPgGVZvGZpD
         7TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792973128; x=1793577928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1XZ1WfHH7XnOv0sWlDb4paoPJtD91jpUpFHrBDh51s=;
        b=doRzRg/JnjKAGqBi5MzAQAWUpyjeDHVlrzJE5ztNNpfSnkfktMyNTAOPxq101MZhXM
         LOCwERCxom5TIGZeM5TAAiOEfIR61mopMxABBVvXwJAYfvEcOGZaPNh0ki188Gvv+2Xg
         OUd0A340LCQV4wLhW21DnJplcWK6lwsbYp7Mb5iK9s3ZaZIUXv2d2BdnaFmh39gFxlq3
         YclcGRkGP5NwQH6UQikattKUaVJI/qF9eIAKMr2o/9ffElNod1cfPk1bf7N/t0icteK/
         97HkOIBaFMiYLMj2oWRj9rwxlpN1lVMt4jcfber3Ouxp2nAR9aYuXpMo6kkHMKQb7eDJ
         L7QQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgQ8/i4XoFQgvKMwgy1GmvSpOK+egGi5znMJYLksNTZ0uUa4FhAQuxdaF1ooqOzXPQ56rg7k4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5AH/reWtPPOHxVWIDQpT/GMID2AvYcTXihZTrXINtIgaJZ+SS
	NljFsbLuprvdYhmAwkk00si3XNtdmcARPioDDGPxgfhbVoFNw1qVe4vs
X-Gm-Gg: AYBFou1gPtUqgQeeTYDYcZHvYkLZTS1HVvT46hvw48dlN3NtvTKeoowgUlDyoarQAyY
	5DXe0oXJXKoGOzEII62tbgTkb+bTlem9+OLYJCamEKmmnOZIdbpTb6lADrRTJZKjSk/aeRObQR8
	5c/u7B4Tlt7Whvj/hvNOl6g7520UvBwl7qW/GOqWkcB8nryn0ir1/qiFFqamPrT0A4X3vQIepxc
	ll7pOuaDx9KRiNYbY/MJDvULYZ9VWH5IaZmFuiOdCJTEOagSiQk25+zBFqgP/Pcbi4gOHXdOHO2
	cofyzZH1/WBrnY5CIc2t2YVNagZKKj+G2mccC18p999kDPYn5KjYtG9i1xH4mi27IIoQz+BFk98
	RJwq2NIfDmirkpgc/mgifAmIVhNb8nAIjkE0etVrHNmZLVs6Yvvrz2JWbjHAAZ1ez7P3iKH2AnG
	rdiLfqehsCHvAyCj2Mm8Fl7KifYzksaBS4RgBl7JmRjSmJum4A3QXfMSuVn7a2kk6KuK6jFifoc
	YiRyCbXcMipi4gVLSz0bgB8s3/vGZhKTrhQUeQKbNJIW5kSkxJw1cBm81w62BKQyjNuAKYcUIdw
	5HOlCI8=
X-Received: by 2002:a05:7022:3f07:b0:144:fa57:c617 with SMTP id a92af1059eb24-19935dd7f53mr9109408c88.34.1792973127715;
        Sun, 25 Oct 2026 17:05:27 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm26698531c88.4.2026.10.25.17.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 17:05:27 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	mtsai@redhat.com,
	colyli@suse.de,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] block: fix discard alignment for non-power-of-two granularities
Date: Mon, 26 Oct 2026 00:05:11 +0000
Message-ID: <20261026000511.73371-1-dennylin0707@gmail.com>
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

bio_discard_limit() uses round_up() and round_down(), which require a
power-of-two alignment. However, discard_granularity need not be a power
of two. For example, dm-thin supports data block sizes that are arbitrary
multiples of 64 KiB and advertises the block size as its granularity.

With a 192 KiB granularity, discarding one complete block at offset
384 KiB is split into 128 KiB and 64 KiB bios. Neither covers a complete
thin block, so dm-thin ignores both and the mapping remains allocated.

Use sector_div() to find the distance to the next granularity boundary,
and rounddown() to align the maximum bio size. This handles non-power-of-
two granularities while preserving the alignment for power-of-two ones.

Fixes: 9b15d109a6b2 ("block: improve discard bio alignment in __blkdev_issue_discard()")
Reported-by: Ming-Hung Tsai <mtsai@redhat.com>
Link: https://lore.kernel.org/r/CALjSBEvjbiGDVewuapWKhGDtaxZwcn4=22raUiBEOyj22rY7-g@mail.gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 block/blk-lib.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 688bc67cbf73..e0de5bb4d969 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -13,26 +13,25 @@
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
-	sector_t granularity_aligned_sector;
+	unsigned int remainder;
 
 	if (bdev_is_partition(bdev))
 		sector += bdev->bd_start_sect;
 
-	granularity_aligned_sector =
-		round_up(sector, discard_granularity >> SECTOR_SHIFT);
+	remainder = sector_div(sector, discard_granularity >> SECTOR_SHIFT);
 
 	/*
 	 * Make sure subsequent bios start aligned to the discard granularity if
 	 * it needs to be split.
 	 */
-	if (granularity_aligned_sector != sector)
-		return granularity_aligned_sector - sector;
+	if (remainder)
+		return (discard_granularity >> SECTOR_SHIFT) - remainder;
 
 	/*
 	 * Align the bio size to the discard granularity to make splitting the bio
 	 * at discard granularity boundaries easier in the driver if needed.
 	 */
-	return round_down(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT;
+	return rounddown(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT;
 }
 
 struct bio *blk_alloc_discard_bio(struct block_device *bdev,
-- 
2.43.0

