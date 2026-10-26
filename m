Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.0
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044308;
	b=THaVNw+VVwo3DFQo+MV23bwtHLbhCFYADef1j8LFcRCMgz2oqNH12EKHZmEDkipQ6wKO
	 Ibt6dHvResjo464UBdeemVZoIO7BjdVlQ8PHxKRPOHzea4KYZ8AaOaLx8Emlb5HeIFrOv
	 p+pncSsdXEBwxPMrRRcLAaFDHvw1qwgwBHemEuOYQ80QHXOLdWeQJeGsnCTq3GJczr2V0
	 tF/YR/ZEBmGMgWkQdrjyufXuH2SClqLp4i/SWeR3Fb3qA9NacpANTUg6ewHuaqgy7KpOn
	 Xdq4OT2B6cH5bbwPcE7FQcp9SbFvXPd5Yx7QbHFI6AgGZkvapjwdmTPtsax4WH00yvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lt5+IIOEQntNwj4k8ixyv60ZFra3k7uwj0Sn4JHHT+4=;
	b=ON5rTq5o9HeNytjEXWuB+Ydm3I4zmjHfUGpFrYtLLGfNHs0phIxn7lqulP9rjY3odnNK
	 BugITyGxizfR9qDURtnBH/Y/ngZSYzsIV8qyHdTyxlwhUtlEdcfSNC0pP4lmIeo++e5ZK
	 55nFihkDcbM6N/Y3VqV5cK0KlJZ8OrC3sfYVXxsuNSwOwWX+0YY1Zx7E1Rlv8NYVTUssL
	 nYYP2NxhS3gFo02pB4XMPY7CSQ/6XMNCFuTyquh7CghMUgHp2DGjc6DVdcFRl77p3XpHi
	 dev9gTCb6/qE8fjsrOkfOEHum65AppNtQhBWmZde1kGDTiKU5fWm+QX0Ce+PKMxmiVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D2YtkdlV;
	arc=none smtp.remote-ip=74.125.229.0
Received: from mail-dy2-f0.google.com (mail-dy2-f0.google.com [74.125.229.0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761BA606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 19:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 761BA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D2YtkdlV
Received: by mail-dy2-f0.google.com with SMTP id 5a478bee46e88-3117f9b9e64so505006eec.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793044307; x=1793649107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lt5+IIOEQntNwj4k8ixyv60ZFra3k7uwj0Sn4JHHT+4=;
        b=D2YtkdlVCDGqT/iZgKm4itlNOYiW4o6uFWvyGLGYTXjPAelbMQS2Pv18QOHavGVg+2
         ioK8NOehpDooXHPIbX8jkrkGbJckCdeOh60CmsswXjMvrcNBdMXOB/AZ8LG6ezgMfK/N
         7lUc8oS7m8KmfPNBxPTy6xjMOKDvHfDKSeRGVj19Uv+8grTzMLgweXy5xJFTNKGognr7
         zDOfA7MWebe+XHAlNEyCLcM1RNqx6EijjI/FNx+4qDAkWlWoST0H6Kk6FUtBSgvwVXFy
         /9ehPtbmsP3d61x9DZzzg50mAPfv9GtSsgNFGd6jOa+p5d+J3fc1HraVLcJEHSfT/5Ji
         b9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044307; x=1793649107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lt5+IIOEQntNwj4k8ixyv60ZFra3k7uwj0Sn4JHHT+4=;
        b=O6K5tpckCaAnkqDIwYoijZSNRjpL4QYug0Nto74r/1utS2YmB90yjVkZL0TAcQNZgk
         nu+a3Nafd5KxZinteaMYxXLfFS9ubCQCQobOrjmZ4zJlxNIue0l4YeHH6sO7Wwt1CgOz
         9gTFYHGKjandVv4fOaE9HFgBvWUmO23tw46aoqdv5EOm/ChcZvIthlc7YzYPVw6X4WRi
         2O6/ZHkdD2soDRGoaLqSvrvYSuGazDo3TVstZs3rfwZE+2k3Dc7EkYA8b6GnLzy83vmz
         8PSnFE/0T+xa4+OkyH2kROtYHr1mYcTjZxKu951yUAHN9tS4timRRlx8Eoe9NJCEFS4X
         N3Gw==
X-Forwarded-Encrypted: i=1; AKwUvBz8joNAsrBDWHC3jYM1jGXx3k3a1B5yvd5FT7CJUH4z5zq+jNv2oqsmXNKBIwvI+fCSBdlneSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu+DtJumcHOeJvyuY6arpg//TMf4HNyIXWcdHD0rTb/9DEFmgr
	PO37+raTOFEySnBqYXLYbDW9tDH/30vF+yIn2lfpfdgTdfaBl3SQ0rRj
X-Gm-Gg: AYBFou2GMQfC9L0PWgT8ZRyTw6Fskk3N7jl88JnoibpBGaYlI+NAqrhworzA88tetG2
	yKId470kfjEM0jHznBNt2k+6ye5NKqz/EVBJJYkzSoSrOQtnfYxB/jei2Tf7ZA+8oSO1BeFyo+Z
	Sj3kObHZ7UTkL8qV3dbvsVzJ2gcd3wfHgDIj5t11RLuVz0YH8lPG3Ikf93eAJwsfwsWyu7wD/Eb
	E+TounE3wXcaV4RacecSBa9WfqoHMxd5q5YUiCgFhbJWqMs4RY1GqEdy8BZhfhtgOp2sZwZzh7J
	e5U9tQ9ris7xnps+Rr1at5W1meNs3l2UvmgoL7rfmuDx2AbSydV7whTJ7lOIsdyr1PriZdpNbK4
	8Xk+R9XBajRMM1DH4t4FIF4zPhHmi2UTGYiNV6MJyrhGKiiVKARSzLILE16MSwh4Sdw/TdhmlNu
	k7K+gSusOheQ9noiDGJ2TyjG4JmPId1csv+TWgY2wITT4WOJCJ3fHtyAE8fjmfudxOEboIB2bs8
	rDVdAvjC8bO87/Lh5sF2qOgMQYx7gUBjaZ9EdODxvioSjzcXLCNLldIVHsif8gLfZ1ubqbmErcp
	diHLiz8=
X-Received: by 2002:a05:7022:102:b0:196:7590:8bed with SMTP id a92af1059eb24-1a3c3240338mr1258384c88.2.1793044307251;
        Mon, 26 Oct 2026 12:51:47 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm36573707c88.4.2026.10.26.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:51:46 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	mtsai@redhat.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] block: fix discard alignment for non-power-of-two granularities
Date: Mon, 26 Oct 2026 19:51:31 +0000
Message-ID: <20261026195131.46699-1-dennylin0707@gmail.com>
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

When discard is unsupported or disabled, discard_granularity can be zero.
Return BIO_MAX_SECTORS in that case so the existing bio submission checks
can handle unsupported discard requests without dividing by zero.

Fixes: 9b15d109a6b2 ("block: improve discard bio alignment in __blkdev_issue_discard()")
Reported-by: Ming-Hung Tsai <mtsai@redhat.com>
Link: https://lore.kernel.org/r/CALjSBEvjbiGDVewuapWKhGDtaxZwcn4=22raUiBEOyj22rY7-g@mail.gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Handle zero discard_granularity before dividing, as pointed out by
  Sashiko. Leave unsupported discard handling to the bio submission path.
 block/blk-lib.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 688bc67cbf73..5649e4d3b5bf 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -13,26 +13,28 @@
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
-	sector_t granularity_aligned_sector;
+	unsigned int remainder;
+
+	if (!discard_granularity)
+		return BIO_MAX_SECTORS;
 
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

