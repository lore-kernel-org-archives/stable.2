Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169897;
	b=1yp6WfUZQGfA0I9Usdd2ii7BkP/mjlx89c0MzsbhaFL59/w3wIPwqEs1H5LJUF1wz+th
	 0CcWLffQpM325QMdgOs3QZuffOHZDGAOjIxK1ok7y56V9njCpVgm2Igxo/4HIdhbTM50H
	 9aBMEJ8Xcr81PonSd+2pKlF+5J+PiVanZU5lCMe6XHDulVSIOT1x1ozF6ed1S7GyUggfZ
	 TBGgZYi6II/acYm/FT3Aq0GFH5eibrFXT3skRzBTqfbYxRucPiFdPNev5u/FLGOf80CiF
	 5Rz31fk13jgSZZ8C5lxVel+HFYar9sEMfQdAdcteFpbr23N2pu6sC1PELmQ5tIJid8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0840EDq5sPqsJHKgUXXcqS6nB05CdxuLpexyxuNzBmU=;
	b=UFvwMmc3BvGrGJeoAyooNy1Z6+eXZbv4FLKwGEhEfZnw6dWMxfiLbUw+BpGdkJ7cMPQI
	 N61u3yi5Em40gDOtc7AB8wQkdZcXtVdi7nJOoCjyrwG6eLlA4gCRokOKrsSq8wLrLRz2J
	 nc6cuOiUzATuNuRlM0QJYlBHVcKLZVoZ79OlRoTWGErhk/3qgeBWDLMn0IVnU5uhIJQ6I
	 HFWFMTO+z1f1XmqYv822wcNsWdt1TdlW4tDapN+DBmLytR3qO3aZ1Zn4sSqX6hSbayXVs
	 Y0M/xzWwQCPRcvYbUh1pZ1WNUeVKG+KO0EuwVORk5f/aVADAgtDUwzLjRxuNesKTgzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UWDzhBg;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899C606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E899C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UWDzhBg
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-1397ad3d891so75205c88.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795169895; x=1795774695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0840EDq5sPqsJHKgUXXcqS6nB05CdxuLpexyxuNzBmU=;
        b=0UWDzhBgiZt5U/3N4EeZci/JkWF9eKwGJXsAHn33Vkruk3qem1UHqvfcGP6nWBvInq
         BdCARVy8qG6wx2oPff/jAo/jp2sEbNZLdW+aiXFbEcQvb+2WEqXLeca3fkfqaEXKAl5n
         lrgbH9EcwYkxXzc9HMRgG7npL0l+MYg5mlUyrqhOj3eUmlzNEcy7ln+bAP6DfG+rwxQU
         dsO1QW0R8k0RfLSX8CSqHIqkiai9v1pDGS9vIm2NPVZof7kmQaUntowQ99KIIV3Dqesi
         diGgYheEaF+iqiezAvbSE5xWM5zNHf3jCQGh4t/IW7lxv6XFNtuqqnqqO9UlxRCX7oQl
         s24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795169895; x=1795774695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0840EDq5sPqsJHKgUXXcqS6nB05CdxuLpexyxuNzBmU=;
        b=QWYi/UmmZAWEM3G77wewQDQqwepgj8xI54Xm0lw++tQgdZvgWgFYv6wzJcEOR5ZspE
         lL6GyIoZ7NHCUBLZRGsI71VaJxGhTljenQt0qqARQZcKx7XR2DREE4/Qr1iCAJw33baw
         EmU/vyUfefotBV3NmTrsHqo6SHPWgm5tzpm3Ai4JdH05DiDTyxV7/Q/SVVOdOHjPzUO0
         F0JbA2Pp5o72KxUeW4rN+VmyBtuq9h1f9xnzHXSawu7HTpa16xTYNfu9Q8lobPV6EwSq
         NaGc+JUdlBMnEQ3ZNgBqxHV4ItWWdLjq8KauFJWQwnzCojWuRUA+cRirb4PCQQcT8nzd
         hhjQ==
X-Forwarded-Encrypted: i=1; AL+hErEkzwRfHEu6xabD7zdlB7vsIVEpxkbnutMhdMfj2opftN+SMeQu0h8/qCaLV8gfDobGXAGUP60=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CGw1IKBU3Y/BU5ZiFtL3LMboNuIVeh4wMi4t9UXSR3bXlNNNL
	hA/HG5mnCNMpWts2Gj3uH3JqTvrYvPrRlquMOF1uQ4WGxPa0AeEUzPAT
X-Gm-Gg: AYBFou2ApJrzzhbJDxbQhGxdTwtiZVxQw/BgNdN1O/zbkCes2GmDxOVdyvhA3Mcb2oV
	Hcf526EF8682WPrSgCOObxRMJDsdHYGyUZIrCPILc3hbrxEfHY+hGZTHe6hU3vSgiiFjyipfXwz
	+8Hdb85gZ2VsUbrvvk2Zt4q0m54qbMIushddcOHlcG62bPpcQSCdp3jKFDNw0yPKb3FXPiySpUM
	JhZzv5Zfx9INiBC771ixTMzmrNhJSjx/ZiG0zqu9NIS7uaoDOjB/HSWjJ2weU+EIqEopkHvH3Ql
	92/Xu18ShVo2dYP1FbGoj7KUVB3KhU2UmulvB7FaWB/NBIB2WFEmWf6G6MFsHkdIG26CgL6Aqm4
	I9RBCgVG/7BEXga9HqKW+FKuXYYgiQpKJealHXz7WJm7Jo8hD2XAiWUAXQNcLclRGAFzsO0s4h/
	wdI1rprxoh57BJXo7VNKVMSitaF2paHr3olu+bbN9wLz9ZKWhrx6hkNOkdRyRPB//JmNoWNUVUD
	3NJ01xeDVjxHg9/X67w5hRtExiNRLPhjBF7j/RYIqYirY+EMmixFRYjrPUGAinpoeDKd6HDbNIH
	sO23G6p/4ohBXJCUPixeWLkjMqkpeeuVIErmuZlzUEe+ILItZxskfoStJKCGiK/SfEZgI9/hHFT
	6HX7y9zgY8+pCMa3fVpgit7jSDiuM4E2gIa64FQ==
X-Received: by 2002:a05:701b:2901:b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1b5567b315cmr2415345c88.4.1795169894971;
        Fri, 20 Nov 2026 02:18:14 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm5905170c88.15.2026.11.20.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:18:14 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	mtsai@redhat.com,
	stable@vger.kernel.org,
	dennylin0707@gmail.com,
	hch@lst.de
Subject: [PATCH v4] block: fix discard alignment for non-power-of-two granularities
Date: Fri, 20 Nov 2026 10:17:58 +0000
Message-ID: <20261120101758.45513-1-dennylin0707@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v4:
- Add Christoph Hellwig's Reviewed-by.

v3: https://lore.kernel.org/r/20261103185909.71843-1-dennylin0707@gmail.com

Changes in v3:
- Use div_u64_rem() instead of sector_div(), as suggested by Christoph
  Hellwig, so the input sector is not modified.
- Subtract the starting-sector remainder from the rounded maximum size
  instead of emitting a short initial bio, following Christoph's proposal.
- Include <linux/math64.h> explicitly and retain v2's zero-granularity guard.

Changes in v2:
- Handle zero discard_granularity before dividing. Leave unsupported
  discard handling to the bio submission path.

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

