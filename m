Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0C43848F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244266; cv=none; b=P3sHYsIFyBEpZscYndBV5cakk6Bf9JxrR4uV3gmeQ/wcShbLeTybtq+MWQBlamXKOKZO479tWZa4tiNgjXCYxSou3LbUZCirwu3fX9aWSQtBg1yGo08ADUeVFjAy1eEEXq7uHokkgCFDkNXYjqSbjrQXa+xsVFoD7vK58XtA1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244266; c=relaxed/simple;
	bh=y1dmns9aZbfxPoXdcw4Ty1vhi+phYuXqgcWHjlPquo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKHJ360vgFCqbbb27GF6wb5hVhyqyMgSd4s2D6dL78LZm/slzRmnWZBxRulyFKMXZUZ+OLR4hIjSmgR7ZWs/SOhO/jMy2aCHBHPPOK35uPelNj+MUFRuqr+X/JW3F60u7ywte6j/Z1RihqI+72b5wuKsGzFy/LPjlrf/ChFcdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3r1l1ua; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3r1l1ua"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so41343305e9.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785244262; x=1785849062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kYkngR3zU/7J7Bh+e7YxqTUattKgmim551QQ/MGGdoI=;
        b=b3r1l1ua1IBbk0JqDvzv07Ur5Xz1j6jc0wq6GYk+oZpr7RW+jlpuKJsBUkzZxT9k4o
         ujZ+EDZl8D8N5R+J3Meh/zWJJDRUyguhTBdDO3vvfmua8adeMsk5kYacFGOdZ6n/X3dr
         x0uf2jnti+wUa14neDeTg32qtr1iDsoppBIbT3CRTplfQPt7ro1Y5xFP2B/o42BXKtyr
         S7XEfRCvI06Ok/gShMNGxHW1+rT7Jm3glq8Om6AFWuqHhfgzLykKRdf1aXcpqMz/QhgF
         wpZneUXh4mjv/Jtw4/4j+1gOFVZhd+fkKuROduzWgQCiw9EV+Eb2X78EHDi2/x9LINIC
         +jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244262; x=1785849062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYkngR3zU/7J7Bh+e7YxqTUattKgmim551QQ/MGGdoI=;
        b=da11bwyLQ9LtmdMF8dzXIky8FKnmUdmxi4gttO5X/bDZBbJyz8B4mSQggplJ/BmWVg
         X/RDEocnRfMVTMfGn5mvYibzLDmPrWP0fGDWdEUU8a2oCYH7arg16MbPzXIznTVBOQ9Q
         QTRiniNCnEt9bDSgJ0PHbobo9vkx75PATYxmk+1SK0sNlNZxHoYg5ZT8EXeGxVUNsrhs
         r+Qtnr/N5Mzv+iPnvN2/QGMEsDoZMzA0vbg0IycW7ipe+wmJEOTHnNctQIPx8RsyuCeJ
         2Ib+TEq/eAuGCP+WF9bcx/zt7g0VZHfug14WUPOIWW65jE9KNFjluiL26LmO51wPI4Hz
         A0yQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsMTWUUZDY5Wr8wWQw8QgNzS7pHxdLPqFkGTo0MjC0YomKI5Ve6aVBs1juaOjCJIys2tTJcAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+PZbLndZrnV1ZGKZY0k9hz9jR1GRIAS9BFEXRub1BBDXdFSBF
	ROEJtluOb330/hRmR//tes7J4dxAXUnT2go1HcyAHhpZe+mj+e+hyUNo
X-Gm-Gg: AR+sD13bI/Yki1R9Mi3+ob8rD6fd266OcNXjHJiRRjFBvNUXFmY3KmjRHC0fj+mbaVv
	5oHWZQzU9nBICJURD5u5DX5ONZWYqKGsc0PIeRghecSxzwrRL5dw6SZ5QG4hWx52O3+LkgBTeEc
	eR4hmyVIbZJv/jLoyLgTYPGNoDizr/mEu6sArnlrRG/sXezMAxRDFwNB1umYFvniOFlZ8gvr36V
	kiacJ4jPOTSErZ6zDuw3zkrHMXT4Z12HNrLbMRS4HVfNAtE3rOVFq4/zGXzdu2aNOqiyWUC/5U+
	dxxiE8i3HNbMLC68uD61puOHtK0ZswfMJMDXAOeK2Y3fHJRgBzGt9r8LVkzFIn0wrmBGZpF5LEb
	yrwETN9nzzYncxrnsdNGtvBaTXomG+wULnbMb97P284pHRMyMMgw87YwBmric/OK5sG/CcAG3up
	ZE4eufwwlTP/L4NZlP9STq//hM5FNojO58dPMPiQQaXYW8lIVarniMaHTGm3jlR6PzIA==
X-Received: by 2002:a05:600c:5295:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-496c6439ef7mr27416195e9.14.1785244262298;
        Tue, 28 Jul 2026 06:11:02 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c4443396sm87852245e9.0.2026.07.28.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:11:01 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()
Date: Tue, 28 Jul 2026 18:10:50 +0500
Message-ID: <20260728131050.37032-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sm750_hw_imageblit() advances its monochrome source pointer by
src_delta per scanline, and computes the correct rounded-up stride
internally as:

        bytes_per_scan = (width + start_bit + 7) / 8;

Its only caller, lynxfb_ops_imageblit(), instead passed src_delta as
image->width >> 3. For widths not a multiple of 8 this under-counted
the stride, so the source pointer fell further behind the real
per-scanline layout on every line, corrupting the rendered image.

Rather than just fixing the caller's calculation, remove src_delta
as a parameter entirely and have sm750_hw_imageblit() advance by the
bytes_per_scan it already computes for itself. There has only ever
been one caller, and that caller was passing an out-of-sync
derivative of the same width/start_bit values sm750_hw_imageblit()
already has, so keeping stride as a separate parameter served no
purpose beyond letting the two calculations drift apart, which is
exactly what happened here.

Rounding up, rather than down, is the direction consistent with the
rest of the fbdev core: struct fb_image mono bitmap data (the same
image->data this driver receives) is walked elsewhere with byte
strides derived from a ceiling division of width by 8. The generic
mono bit iterator in drivers/video/fbdev/core/fb_imageblit.h advances
scanlines with "iter->data += BITS_TO_BYTES(iter->width)", and
BITS_TO_BYTES() (include/linux/bitops.h) is a ceiling division.
sm750_hw_imageblit()'s own "(width + start_bit + 7) / 8" is that same
ceiling division with an added start_bit offset, so the caller's
">> 3" (floor) was the one calculation out of step with how this data
layout is handled everywhere else.

Found by code review of sm750_hw_imageblit()'s internal stride
calculation against what its only caller was passing in, and
confirmed with a clean -Werror build. I do not have this hardware,
so this has not been exercised at runtime on real sm750 silicon.

Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to staging")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
v3: Added the version notes below, which Dan pointed out were
    missing from v2. Added Cc: stable@vger.kernel.org, flagged by
    Greg's patch-bot since the Fixes: tag targets an old (2015)
    commit. Added the rounding-direction justification Dan asked
    about, citing fb_imageblit.h's BITS_TO_BYTES() as the existing
    kernel-wide convention for this same struct fb_image layout.
    Moved the "no hardware" disclosure from an email reply into the
    commit message itself, per Dan's request.
v2: Added a Fixes tag. Moved the src_delta calculation into
    sm750_hw_imageblit() itself and dropped it as a parameter, per
    Dan Carpenter's review.

 drivers/staging/sm750fb/sm750.c       | 2 +-
 drivers/staging/sm750fb/sm750.h       | 2 +-
 drivers/staging/sm750fb/sm750_accel.c | 6 ++----
 drivers/staging/sm750fb/sm750_accel.h | 4 +---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e..da0b497 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -261,7 +261,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
+				      image->data, 0,
 				      base, pitch, bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e..83229fe 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -73,7 +73,7 @@ struct lynx_accel {
 			   u32 rop2);
 
 	int (*de_imageblit)(struct lynx_accel *accel, const char *p_srcbuf,
-			    u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+			    u32 start_bit, u32 d_base, u32 d_pitch,
 			    u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 			    u32 height, u32 f_color, u32 b_color, u32 rop2);
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0316ea6..bac9a20 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -288,8 +288,6 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
  * sm750_hw_imageblit
  * @accel: Acceleration device data
  * @src_buf: pointer to start of source buffer in system memory
- * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
- *	      and -ive mean button up
  * @start_bit: Mono data can start at any bit in a byte, this value should be
  *	      0 to 7
  * @dest_base: Address of destination: offset in frame buffer
@@ -304,7 +302,7 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
-		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
+		       u32 start_bit, u32 dest_base, u32 dest_pitch,
 		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fg_color, u32 bg_color, u32 rop2)
 {
@@ -395,7 +393,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 			write_dp_port(accel, *(unsigned int *)remain);
 		}
 
-		src_buf += src_delta;
+		src_buf += bytes_per_scan;
 	}
 
 	return 0;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index d15a40c..4f609d6 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -220,8 +220,6 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 /**
  * sm750_hw_imageblit
  * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
- *>-----      and -ive mean button up
  * @startBit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
  * @dBase: Address of destination: offset in frame buffer
@@ -236,7 +234,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 startBit, u32 dBase, u32 dPitch,
 		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fColor, u32 bColor, u32 rop2);
 
-- 
2.55.0
