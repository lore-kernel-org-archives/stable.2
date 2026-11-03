Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732363;
	b=cMwPtdEqym1H+/Vgs3tvd4dlxG5E9OyYmfSQ4utMoMWLNbJOCmgt7xThw0XAb3V1dff0
	 KUk1Ipu9CCYgdII+RGkBJGruE9yxQy7BPUMlwAaBbDNBU4nTFvBAwQxX9r6WlFTiwMq/K
	 aVBILO/XT6d9nh/Oki/YG42PUebI49o2QYp1Sq0LQfbpR5NfhzGokGEHyFkp7SkNnWaeV
	 jtoHn8FQQp6+VOf8jmbsQFawrDXRPsFag8WR0ay1a/RKMszzD+qvj5JS2tE1/jIdwas7T
	 QyXgChrYu4zpe4U1JEBRaOQxLWDhBfoXosn7eMQGc0yw0VQjtoeLKXJK1lLtUP9PcYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=31+P6AMFeIVlhmQscpLB4qy/vx9LUkvE2yKWF6dd1So=;
	b=gFoL3Ewcpp6V85ovP/ZwtQXqpRVBC8pxSyKtgS+WtK5sYKAhacd5+OQJMNqLn7kKFG62
	 mTBR8sbOdvhISJj77VD8mJP4FRBNnz2VfPPUHVIXiBm29VO2bnU5PXdV4sx732ElHhVYn
	 c0RoEsCJ779wLTiYkk+9zrB9CFU56qZSgIja94oBwN5iwz3byJy3SpBLuWZTPdVLH6u3+
	 Wo/Be0ZtPZpx2EADW2HMKkNb9KxsPdSZ5DN9uROW7t2Skqt6C/diyqLz/LZsEBAJkbGA/
	 Cr8iMirtx9hXYG27afR0RSJ4NXRtPYdPhv1HKghWL/kikN3S28m2auDP3Qd+s+w4FWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wQHtwz1p;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A07606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A07606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wQHtwz1p
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso479348eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732362; x=1794337162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=31+P6AMFeIVlhmQscpLB4qy/vx9LUkvE2yKWF6dd1So=;
        b=wQHtwz1p7ctJP+IopmWMaKe+YCjn74fJHc4vqJ82D+qPHg2Jle3Vjj2p5l525YJIX8
         XAtHT1MpzXlCaPNmbMF+5hJvrl+edDN7I324Ac8/pIaeetciJ+Gjnl+/pDbMrcV/b30h
         hZClwTnK6HbY7a5DjWg/doIYJdcKHf508roQulOMj+fqNj43d89FeYnybFTZhr5kTkPc
         714Y2QDP/TWGF5gYwtMxcHSDzPb7ZSBsprFACcDEw/Dr1vkHWv6VNcxH5j9BnzkrGX+U
         B2NIlvaxq755/fC0sKk5DLcx1oXFcb8wue46nisaBYaPZcPr5Ic9ZKL7Xj+7DOy1HsOp
         3r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732362; x=1794337162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31+P6AMFeIVlhmQscpLB4qy/vx9LUkvE2yKWF6dd1So=;
        b=irHfJe56xfNZ14OZiiKhXH/Of/g2wK9UsSdXKlnudJEyt8ZqPldqV+gRq+gspnUW3d
         ikRfpnYsVF1angHw74O/MzkKJhnQgYRTdtG6cZoA1+mUwFgQB1oYpAyyck539xRMpfbg
         6DC4deG2aMPqqqyGfv0CYc4vSmBQ4uI10+cg8qZJqMJrIureCfVkL9yrDEmwr4pxNUbT
         88ulHOAs7JB7h1OpcSDmabm3UNCeunmHWeI9oD/DoT+bSyxUpBaHTR29BWEAqxiGL4Um
         WzqMdUovA1h443hp8hsAoWntPu2eWZLPGPlAotBi3bUB4bLnGtR/3/X8JCntIDGbXUVS
         omLA==
X-Forwarded-Encrypted: i=1; AKwUvByVVP73uIzro57q0IdUqhl4V+K/8rBTKPOV4DmcIdE0KxpFGMVdCWnNQFL3vyADEN8vvAMfx5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8ZOKt+i6pO/w2NNMrBMZYwK4PDKBbehfUrzMgKudwmik9uFqf
	BmR2LmtvtpIK2uLI6auZe/jxV2A3EHXHw1coR31kl7VimwArLYkfJk43
X-Gm-Gg: AYBFou3qKCFL/JBFArcnQigjOAs9VdxMeB+q7Yd1Y/zjaB1jIfNYh9tVRY3bMDYN7uM
	KCkldK0A/Da48hlt/VOwYPGtWGnDTcK/qqRC7OBFxcI+RxjU0i9Rw+h4Uy7gEHw2R8HVIBkNo8h
	1q1LMVxWyS3aUf8VUPSp532a5vBgcP+c3eVU0bT9PMgi7z5sz7PkUPJj6Xy7iHh8IDDJ+d5rUV1
	L578H01QtL67Tu7zICV9ErHAvf3mqbB5FoTP3+MXsclBhivFDs76FSy2AbCCVhCDhaPUFj+wHq0
	EitkKxQCX8UgOPgiIRP5CXvgPS9ET6EkX79kq/K6c3+xQP2QmOYeFsuI478BPFIIT0Pa4ChEotR
	5vC1CkErg3RqcsJ9xjz7MGGSURUUwQYgMMY+BHUorz4LaEPXfv0FXRwGpqPCh0Dhc/JgbNWbiuc
	ovlDcFjk0EUUWAT916VJT05fgK9jbfcYhmbiuLH2syzoKsL+V7bskmCBDaXMob4xvCotrMOWqre
	C0zwWarxzap9Ybp7yxatSzbKLUl0P8udeiB58H3DfNFceg9z8Msicx6aIr8QrKgUBsuONU6Xobn
	AKu5tKqjUn0dXoev3bBnvqolI3qy18XtoEeIldxXIU6iE5YB4nlRkFls
X-Received: by 2002:a05:7022:f50a:b0:149:50cb:2175 with SMTP id a92af1059eb24-1ac5cb1881bmr18974882c88.33.1793732362218;
        Tue, 03 Nov 2026 10:59:22 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c290sm747339c88.5.2026.11.03.10.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:59:21 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	mtsai@redhat.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v3] block: fix discard alignment for non-power-of-two granularities
Date: Tue,  3 Nov 2026 18:59:09 +0000
Message-ID: <20261103185909.71843-1-dennylin0707@gmail.com>
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

Use div_u64_rem() to find the starting sector's remainder without
modifying the sector. Round the maximum bio size down with rounddown()
and subtract the remainder so that the next bio starts on a granularity
boundary. This handles non-power-of-two granularities and avoids a small
initial bio when a large discard starts at an unaligned sector.

When discard is unsupported or disabled, discard_granularity can be zero.
Return BIO_MAX_SECTORS in that case so the existing bio submission checks
can handle unsupported discard requests without dividing by zero.

Fixes: 9b15d109a6b2 ("block: improve discard bio alignment in __blkdev_issue_discard()")
Reported-by: Ming-Hung Tsai <mtsai@redhat.com>
Link: https://lore.kernel.org/r/CALjSBEvjbiGDVewuapWKhGDtaxZwcn4=22raUiBEOyj22rY7-g@mail.gmail.com
Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v3:
- Use div_u64_rem() instead of sector_div(), as suggested by Christoph
  Hellwig, so the input sector is not modified.
- Subtract the starting-sector remainder from the rounded maximum size
  instead of emitting a short initial bio, following Christoph's proposal.
- Include <linux/math64.h> explicitly and retain v2's zero-granularity guard.

Changes in v2:
- Handle zero discard_granularity before dividing, as pointed out by
  Sashiko. Leave unsupported discard handling to the bio submission path.

v2: https://lore.kernel.org/r/20261026195131.46699-1-dennylin0707@gmail.com

 block/blk-lib.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 688bc67cbf7..e98aa483707 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -3,6 +3,7 @@
  * Functions related to generic helpers functions
  */
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
@@ -13,26 +14,25 @@
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
-	sector_t granularity_aligned_sector;
+	u32 unaligned_sectors;
+
+	if (!discard_granularity)
+		return BIO_MAX_SECTORS;
 
 	if (bdev_is_partition(bdev))
 		sector += bdev->bd_start_sect;
 
-	granularity_aligned_sector =
-		round_up(sector, discard_granularity >> SECTOR_SHIFT);
-
-	/*
-	 * Make sure subsequent bios start aligned to the discard granularity if
-	 * it needs to be split.
-	 */
-	if (granularity_aligned_sector != sector)
-		return granularity_aligned_sector - sector;
-
 	/*
-	 * Align the bio size to the discard granularity to make splitting the bio
-	 * at discard granularity boundaries easier in the driver if needed.
+	 * Align the bio size to the discard granularity to make splitting the
+	 * bio at discard granularity boundaries easier in the driver if needed.
+	 *
+	 * If the current sector is not aligned, shorten the range so that the
+	 * next one is aligned.
 	 */
-	return round_down(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT;
+	div_u64_rem(sector, discard_granularity >> SECTOR_SHIFT,
+		    &unaligned_sectors);
+	return (rounddown(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT) -
+		unaligned_sectors;
 }
 
 struct bio *blk_alloc_discard_bio(struct block_device *bdev,

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.50.1 (Apple Git-155)

