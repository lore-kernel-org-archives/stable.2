Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B947532F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040549; cv=none; b=LyxsnUhklE8pAwst0amIf4YRKuLuohR2O8j3v21DCu46+zpcJD9Iur+o7vHBRh/HdyCI4zAu67sHWLH5HdYxCN3v+rKpLUrnmM/oa8KbPt7VJmHZjzRAcNAThm3stlRzCo+NorMiexlFHM1JyJAumMcsgS1/9lnaYwu962Er7KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040549; c=relaxed/simple;
	bh=n2cw8ccKh/5sZWgvROx6ttwtWpAomKak9sOtwxPUcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvOfBTrW/Pv2N9fAeny+TyFi4wOIyN8nAfnczy7ZVgOOHF3kpzdr446jtwu/1dCaCCdhAxjRqSg8qGdZUc+ApGcp0AkmHAJmMPjyQnh0CS46YYu5L27vx3cy5+38Di2oJ5j0MckuFgP08iD1GKFXpLzawiRtHbtnvNS9KZm5jak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+qNxiSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+qNxiSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50D71F00893;
	Thu, 10 Sep 2026 11:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040547;
	bh=1VIdwXE2Ep5bWwNjyOQRQrCtdFdwV54lJZ+5YV0mvAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d+qNxiSQ+p/6XMoyg3IZl9D/gVpqGuUA6gzIzH+T1fOdLjJcorGGnCBcazEAKTIGf
	 SZX9hYjk8d70dJOSL28hlpvDHzhH965JVT9HvjQEEzQN/yF3XJ21giifKKT7tSZonB
	 2ZCUQB1lYEhJS+e31POgD8HXlnIAdtCBji3gay+vmwkTurBwK9xxlrWRa7VHLdjA/R
	 Q1vy9A51u2Zt2oDgHSCX6QOZFtz/oN1FM5AxMCSirwChRXVmKIjEeR90IyV4N+81Mp
	 A8XV13J6mUbEOu9aD/Z67J+XoSx8Vzl549/tSLWEsLiLwgi+EZUZAYPwybhWwcB/FE
	 d/zxeoaFdMiMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()
Date: Thu, 10 Sep 2026 07:42:25 -0400
Message-ID: <20260910114225.89657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090829-wobbling-sterilize-72a1@gregkh>
References: <2026090829-wobbling-sterilize-72a1@gregkh>
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
index 7d64ba7a4a054..7397742043c17 100644
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

