Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9F53D0AC
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871310; cv=none; b=cNMgIsxGvggLbiAPii+aOAd7yipUnTpXuMCVI/MbpRNRdbluSb7nGuJTwZ+rPz8skac2wIwjy59JaF40nqYU9V9QF5y3ej9tFyAvmYkSOwO4XnMrrBihT7l6XjcKZxFXhzYZgl2YryyguwQ6kGaasF538MCAXZFompeyE6wIt30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871310; c=relaxed/simple;
	bh=es0gva3SthDIl2VTFDbHfpBtaIP4AkNELizsP2gxCLY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UYzSbAl7Mo81iClkYiVNz3aoPfOX9vyCr/67W+wX8DUWePz+E88u4rjAEPqHfBn4bggquUyLKT5juKfuD/rBMO2KJ6QzadKBN3SsqaLJIvwoMWtUriCero5NB2dW75caQyv7niEwB8nYrtd/g6Snv4bHyJikhWi9MTl/u/GF6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mFoeYeDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mFoeYeDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9F31F00A3A;
	Tue,  8 Sep 2026 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788871309;
	bh=wUinrSW8dPqSZyIxmE22DA+j8omD7kTe45R3ewGQOl8=;
	h=Subject:To:Cc:From:Date;
	b=mFoeYeDv/FUOc+e/AMctPaK/Z4CnDxKpggpQZSjacUvKjX5ZnlHtXasWStdrl4f2V
	 /I/ARyO6++2yWSsEU1TwVODZgBBuJywXLmK9k14Ik/5hAih6k6RDqC6CX5gJ9jv8yK
	 umgnD2I8ZdM1dRA7SbgQ371BmO7HQJACXCXE9ed0=
Subject: FAILED: patch "[PATCH] staging: sm750fb: fix mono image source stride mismatch in" failed to apply to 5.15-stable tree
To: meatuni001@gmail.com,error27@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:41:31 +0200
Message-ID: <2026090831-duress-clone-7908@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cc7cd2a9228175c975f62ad56ed7c767701cb4fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090831-duress-clone-7908@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc7cd2a9228175c975f62ad56ed7c767701cb4fa Mon Sep 17 00:00:00 2001
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 1 Sep 2026 16:30:31 +0500
Subject: [PATCH] staging: sm750fb: fix mono image source stride mismatch in
 lynxfb_ops_imageblit()

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

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 039e2033f84e..8b93bfeb217b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -252,7 +252,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
+				      image->data, 0,
 				      base, pitch, bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 89a61bf80779..fd1cf9eb5797 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -64,7 +64,7 @@ struct lynx_accel {
 			   u32 rop2);
 
 	int (*de_imageblit)(struct lynx_accel *accel, const char *p_srcbuf,
-			    u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+			    u32 start_bit, u32 d_base, u32 d_pitch,
 			    u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 			    u32 height, u32 f_color, u32 b_color, u32 rop2);
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0316ea69d009..bac9a209899c 100644
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
index 617885431661..efceefaaafb0 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -220,8 +220,6 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 /**
  * sm750_hw_imageblit
  * @src_buf: pointer to start of source buffer in system memory
- * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
- *>-----      and -ive mean button up
  * @start_bit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
  * @dest_base: Address of destination: offset in frame buffer
@@ -236,7 +234,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
-		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
+		       u32 start_bit, u32 dest_base, u32 dest_pitch,
 		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fg_color, u32 bg_color, u32 rop2);
 

