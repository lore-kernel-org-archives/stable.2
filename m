Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812E456E19
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039828; cv=none; b=MOWQkiyx3ZX7vDv8JtAuQE2Tol0eF4osaZF2QsfLm5/4cpEMc5eJ2YCYStF3vREta99Iw2BeL4F1DpC3LSxGHqPL3AMXkrST76OO7ef+KT23wvrYMpsnUPMcHUhGbdWtOouB2xXJvDEHHtPhy4hq62P9Fha8+Ta47Ko9M5+OmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039828; c=relaxed/simple;
	bh=Ag9OCBgqECWTHwbj4X6Fd8CyCKvJzwkKNHrwq+KI9po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBY1XrESOcNRZgkULnwRNjGwPtUKmAHeY6hwUHxnpjOD6Zr6osOqCpUNtLEwlVVYC8MyNdHoGp7YgRhzMIQHzfjg/leE3UsG4P47oA1Coq59vDcCzLpddek/0AIwsWjXHe6Pk6ipMUdrucYxn0xP8rKl0sfG8pbLzcUloshiEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/iWTpwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/iWTpwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDAC1F00893;
	Thu, 10 Sep 2026 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039825;
	bh=eu0FE5cLo7ihkSuggZwIEMhuJ+UFlQyok7DLxTzoP4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/iWTpwkqmY2y2Dii+dSGK9YCkzbspEX2iM/7RtvP2CScQ40mThEA4atk49LNjVu/
	 AvG9LZ54I1Hzdbhw1RYbA4Toy6OOzC5j80BYmPX8wxAmKzqiZDloW/ct61QCwkXo9V
	 objkG6nKQwZCn/wfayhb5goJf86OluDfrMS2QWog9DKq1EkhUMK+hEKHIXpIoebcPW
	 GpkmZWjDR7iw4MmYPUir0vcCSiQEn15k7+1Sm+QmQJKAIG5kuNm+vTWDXpD811Ypey
	 0u+gYocduc7hZSHWJsol7kFZ+EGaXZXXR/WXcInq+874Qt2T74GptZLkkQ3Fy7cCsS
	 wAfql5vZnr19w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()
Date: Thu, 10 Sep 2026 07:30:23 -0400
Message-ID: <20260910113023.62881-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090828-angling-karate-5de5@gregkh>
References: <2026090828-angling-karate-5de5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit cc7cd2a9228175c975f62ad56ed7c767701cb4fa ]

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
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260901113031.161610-1-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/sm750fb/sm750.c       | 2 +-
 drivers/staging/sm750fb/sm750.h       | 2 +-
 drivers/staging/sm750fb/sm750_accel.c | 6 ++----
 drivers/staging/sm750fb/sm750_accel.h | 4 +---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 94a83ec342827..05b00ba542fbe 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -275,7 +275,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
+				      image->data, 0,
 				      base, pitch, Bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index aff69661c8e62..a693d9f1d0d5e 100644
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
index 44b9e3fe3a41d..37217a496ba75 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -300,8 +300,6 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
  * sm750_hw_imageblit
  * @accel: Acceleration device data
  * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
- *	      and -ive mean button up
  * @startBit: Mono data can start at any bit in a byte, this value should be
  *	      0 to 7
  * @dBase: Address of destination: offset in frame buffer
@@ -316,7 +314,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 startBit, u32 dBase, u32 dPitch,
 		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fColor, u32 bColor, u32 rop2)
 {
@@ -405,7 +403,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 			write_dpPort(accel, *(unsigned int *)ajRemain);
 		}
 
-		pSrcbuf += srcDelta;
+		pSrcbuf += ulBytesPerScan;
 	}
 
 	return 0;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 2c79cb730a0a6..df48ed57a054e 100644
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
2.53.0

