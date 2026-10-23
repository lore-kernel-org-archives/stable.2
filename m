Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777911;
	b=tTnUZDUhwUoiKksVvjX03JxS8JZEKhA0npzwSvpt1WUErX3uOBD+qXGue0DM17Bq9cA6
	 gx1q9Ll5+M6Y4Tj0ir+GNnDQbSOrncAsw8OnPA0keNzh1ljtlF8d8IM6HvVHCb54nmBK7
	 DSSF1eh710Sk003EGtRQKua1jWu7igLvQpjoW1vhgtYedD2xSTkccYwvzqiw4/qU3nJuG
	 pPIIODrg4RR7SEyf5BQLbe2o9y4sL0gkwg/7n/OvCz/KTdm5oHrbQvm+vO+59RhO2P4gF
	 UFGfhgz32I0ms0KD67R+7LfekrzibNcOFJaPihEqe0ynuXG2Rc/SqiwAfCZp2QGXk/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7wwANjuDtZeTrIYJO8YoDGwetOTDKqWw0CaiXm+A6RE=;
	b=vr5nnxiFtylBRQoluioHIpGZq/ptaW3PWLE+vSt2YOLadpwKUnmQ8WNtcRDP0wS8RvTG
	 k4eY2BkRGqsVP+l2hzwKLnKNAtUC4ElEdeONQUWRvzus115ZMRjd8Cs61675Sc3HFsqFT
	 9wuAINS7l9BqgbCc+F2Vuhz7ZEZ03ejt/WBQKo4+xtk2R4hWGzcpSDqxmvfvn6X8ab8cL
	 EVaKnRlmN1ARJm04hP2Ox3mlJ70F9vNXAjUYtSsAI3KdeIq26QOVIcaSHklCgXPut3x8h
	 a9w118xCtXYHT5msgDm1Qpjn06Uf7GCEH4avlG+wMTUNX1aKgXcWh2f90As+I9emEsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KeN1mHlU;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E14606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E14606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KeN1mHlU
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-185fd3a4ca3so1047797c88.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792777910; x=1793382710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wwANjuDtZeTrIYJO8YoDGwetOTDKqWw0CaiXm+A6RE=;
        b=KeN1mHlUE8H65mhqBFxPDjAG6SEA3nwST8Mc8fzc+ILmzrxXNLUzhLHAeC85poJFLa
         quV0YF5rE55k4WkIsNGxOT1aHSkPGtL7zMVPeGsh0zwDayyAHWAyFTuA+ZzJ1qr7CaJ8
         bLsmdSsXV1D0RZY8B7iZiajKfokJcj9zkcexZk2DPVANmTwQ44bePkUtlAvEsUbLktJ9
         omgOjWUQ5BKQMXONQtpD3K1BeatmQSTPtWeu5eIwfk+mUYyYOuEUzEId8oqciiXKRUXb
         U0uQL0eX667yZjF9NsuSsqRGjfCgMSHYrGdRznQRK2SiMMDXKi59nWjLV0BntKQP+79w
         NhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777910; x=1793382710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wwANjuDtZeTrIYJO8YoDGwetOTDKqWw0CaiXm+A6RE=;
        b=Xn1DfxnR7DD+rVdip5sXh8LhLwM6b5Zhot8BHBBdz0U9hg9KQNDOZ7kblO1ifUDfRb
         qxM+wteW7lbBLq/LX5NUf5qujboAYTrqtBBEfpu6t0jOs75SrEEB23Vy2HWydSXhH3fw
         02QT5wr0srNTl827RuKYw4TarSsg9j4D71OltTpZLRwU86FqEm8azBCHOeoulCMLQUq9
         txJkVH83fvG/TqqOe6nPD6imRl/7K6Xrjyo3XyA9rgSr7MXmImYF3/2EUkp4098ImovX
         woBBxpf0TR4VV2KqmjIauOdqwDq2faBhw9bEGoATw2vFDtL+kWkHQqXLiwyddvtrGCEy
         bHKw==
X-Forwarded-Encrypted: i=1; AKwUvBywqN5hmO0+45YayWNIXsdO2rdstVi+u6MxY1i3CL7KFw9WISecLFF6Mh7KZk46jkAKXoyt+Kk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGqOxqZ8mZpviPfFI4gHSnRjtRhOKq7LS/L1DIc0d9ZYRDP3y7
	pl0TYb85VV3gB5TRJ+mn1TKzxtiw3bMvje2ZjAsIzbKfqMPUwbUKyD7c
X-Gm-Gg: AYBFou1/N7eVw2jjbTEvfj1/4l8qyL3gPnYnzVAI9TVCNk+7e48haRQXv2+m2+YiZo3
	bifyYzF8+u6QQOFJ1jdixiac7nXwcA0ZCp15DQhpwbKawKZ2RU23F2pjx+XuXnKgcMqNC9TJVdP
	RnWhvhEkvXextZqEN03ALix51m1fx7LOGECs6QdJ/UXvFVSd+thH/jbB+Dbib+VZK3E4xdbcGNe
	1w9NPljyrPlzq4rGot0m0b7FfIM5H19Rq/PW0chdTH28oj/80KcUOOzIbcx25XyAmrLf+uGEggc
	HDmN1gJZWwNHze/h0g2ZkS9p5V5Xeg2oNvMyUNHzf13zLFyLNceenQkWj6xC1dlVbhj3/xZClJ0
	1AqVfU3IQ7xBvD2B6hvKWTXcIVxHO37wHleEWqO2nsy4/ycUn3lJAEykZRy8l+U1KK9GndinY+6
	dvtlbdRb++Wk1JrN/KVsqwQQfGUJNIt+VfuWM3c5wyXyeHEjqXKetiiDrIwcJEajVHW+6hPP/3f
	t2VxMlOCs7WgKcQ51dLcZ5itYB/ceeN8nB2FqOoC7xO2WwHHKExmDTjT9+gCNxY3v37KmC8YP1C
	HzxeJoD32dUN5HlhfsKHINrNw4sV
X-Received: by 2002:a05:7022:3b85:b0:187:efba:9ba2 with SMTP id a92af1059eb24-195c6f00fa6mr4412390c88.44.1792777910049;
        Fri, 23 Oct 2026 10:51:50 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ea25sm132988c88.5.2026.10.23.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:51:48 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	co+b0df61d49532b2ee@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Fri, 23 Oct 2026 10:51:29 -0700
Message-ID: <20261023175128.4127122-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

get_line_length() multiplies two int operands before assigning the
result to u_long. Setting xres_virtual to 0x8000000 at 32 bpp therefore
wraps the product to zero and bypasses vfb_check_var()'s video-memory
limit. fbcon can then clear margins with a zero line stride and write
past the vmalloc'ed framebuffer.

The xoffset + xres and yoffset + yres calculations can likewise wrap,
leaving an invalid offset in info->var after fb_pan_display() rejects
it. Subsequent fbcon drawing can then access far beyond the framebuffer.

Finally, PAGE_ALIGN(videomemorysize) was narrowed from unsigned long to
unsigned int. Values near or above 4 GiB could therefore allocate a much
smaller buffer than the size used for mode validation.

KASAN reports:

  BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
    drivers/video/fbdev/core/sysfillrect.c:24
  Write of size 8 at addr ffa0000001671000 by task poc/198
  sys_fillrect
    drivers/video/fbdev/core/sysfillrect.c:24
  bit_clear_margins
    drivers/video/fbdev/core/bitblit.c:247
  fbcon_clear_margins.constprop.0
    drivers/video/fbdev/core/fbcon.c:1410
  fbcon_switch
    drivers/video/fbdev/core/fbcon.c:2261
  redraw_screen
    drivers/tty/vt/vt.c:994
  fbcon_modechanged
    drivers/video/fbdev/core/fbcon.c:2693
  fbcon_update_vcs
    drivers/video/fbdev/core/fbcon.c:2732

Reject video-memory sizes whose aligned value is not representable by
the fbdev metadata. Check the offset additions for overflow. Compute the
line length and framebuffer size in u64, reject unrepresentable line
lengths, and check the total-size multiplication before comparing it
with the allocated video-memory size.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: <co+b0df61d49532b2ee@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/video/fbdev/vfb.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bd..84b0a937c 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -101,11 +101,11 @@ static const struct fb_ops vfb_ops = {
      *  Internal routines
      */
 
-static u_long get_line_length(int xres_virtual, int bpp)
+static u64 get_line_length(u32 xres_virtual, u32 bpp)
 {
-	u_long length;
+	u64 length;
 
-	length = xres_virtual * bpp;
+	length = (u64)xres_virtual * bpp;
 	length = (length + 31) & ~31;
 	length >>= 3;
 	return (length);
@@ -122,7 +122,8 @@ static u_long get_line_length(int xres_virtual, int bpp)
 static int vfb_check_var(struct fb_var_screeninfo *var,
 			 struct fb_info *info)
 {
-	u_long line_length;
+	u64 line_length, size;
+	u32 xres, yres;
 
 	/*
 	 *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
@@ -159,17 +160,23 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
-	if (var->xres_virtual < var->xoffset + var->xres)
-		var->xres_virtual = var->xoffset + var->xres;
-	if (var->yres_virtual < var->yoffset + var->yres)
-		var->yres_virtual = var->yoffset + var->yres;
+	if (check_add_overflow(var->xoffset, var->xres, &xres) ||
+	    check_add_overflow(var->yoffset, var->yres, &yres))
+		return -EINVAL;
+
+	if (var->xres_virtual < xres)
+		var->xres_virtual = xres;
+	if (var->yres_virtual < yres)
+		var->yres_virtual = yres;
 
 	/*
 	 *  Memory limit
 	 */
 	line_length =
 	    get_line_length(var->xres_virtual, var->bits_per_pixel);
-	if (line_length * var->yres_virtual > videomemorysize)
+	if (line_length > U32_MAX ||
+	    check_mul_overflow(line_length, (u64)var->yres_virtual, &size) ||
+	    size > videomemorysize)
 		return -ENOMEM;
 
 	/*
@@ -434,9 +441,13 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	if (videomemorysize > U32_MAX - (PAGE_SIZE - 1))
+		return -EINVAL;
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0

