Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029742;
	b=BnCGQpVpHVhORQ8v/YI3YUtzmCkg7lWKRfgvfcm7QEVSpJL9t/b9+oPpVcuBrqTLBM97
	 z4eQTBveKcMUPulkYFgjVKrErE+436XhsQjzfhlT4cmfkpe6P+d6Ypd2knu8c64fGvUIz
	 5J8GlEGFkEEosp2UhP2vBMcJmQSD83fBfGKQsGsXlRSrPy6wy7YQg0BFMI35wGUnJeYuk
	 QINZolq8KXKVDlWJ+JPbSYeUZRmsaeF72XAFk7twZy7hCNT1aSWi2bVSmldXKdmcqLcuf
	 mFneOpunNED50qPuBVrYspyLTJekdwW7pIJc1XLop96/sFGQu43ow7LkgOYiD96M16g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HsJcoE+tcg++lXHusmJ7l3VcG6mAANy+njpMsw2MDrY=;
	b=iziROfRfVcsdXvd/+qRtwo3ZN6INV1FF4beRtxMSRgLt4iXRFIUwzeMWaIosOXLNYReM
	 FU8c8rhoUf0z0JP02unVaL4UZjHBQ6icRGkA07duGWN1VDtbTuW9mAR5b0YWTIQuEN1li
	 2Moub/LqnZU0yLXYcn+6JI94tX63RWN9WX3wkE5n8rO+hL3QYAeN0kD6P1TYWelDEN7Oo
	 ZfiBBCujX+3fuOtxHEMzZfamYgNuAjb+tjpS1+1J0yf/fWm5s1QFjXsws/ndY1hjTtzzz
	 xBVUrDsltRKgaS+kRj7sTT9Ts1t9/yoGNzZG+4wvcsi/+SAV/80xzciiktT53lQ+jMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="R/7VtgIM";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEF606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93EEF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R/7VtgIM
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35c76e9614aso5074809eec.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029741; x=1793634541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsJcoE+tcg++lXHusmJ7l3VcG6mAANy+njpMsw2MDrY=;
        b=R/7VtgIMVUPjS3JNQbeOlGQ1HwUljc1QN/3FRshRpSijhV4BIopmB7prNof/3ppYEM
         J93Eiq75HlvCBMK1nH7ibCTOoXhq42H3kjKrt/ogOanLUSp2ug9qdj6amvozq54QT2Nd
         UX7OlbfPTz7npVbIW8wzVhmDEkIywkba6ZPxFb+aNY5gq4gtq9TgZ7eSmKHSNek9sKkW
         ZeMoLFf3F5+zKz9YJuSjd7RAH76U+cYx5rKK7zVg+zINSmK7oUzkrzd2uSlXHMhs2bAk
         VgwzpXP+uhkZoVqA6Y9SVVMwSHWd4r+9GstoXSEQL/eh2zgin76BnAV4YUL4GsgQDF82
         b12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029741; x=1793634541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsJcoE+tcg++lXHusmJ7l3VcG6mAANy+njpMsw2MDrY=;
        b=qVo07AB8eRfmX1E1qEsp6yMMfWvdJ9nb+yK3R1QCYBNPLI5pvsgoznVDepUUQIC301
         C5TeTPTUpwGBcRxzRiVUzo+stUR4Z+/LrFPkQqkpa20a0H2FHExLmo0J2klAc25saH2Z
         2vVGMWy2amRypIViCgzpOjKnSxjnmPA63nZid4ATsUjiadA5TXqknVIq1umAeDM30bKD
         ClkMB2Iay/a8Yr//15noiHGeQ8qQpb9d15cKMwWxENrDM5fYpyHhKjec/FFYqsO98nDj
         G5JidKRgStoQ6QJrqzjPMM6R1wWIZc+m3xdY5tp7wJy/1Td1xheW/X29H19KAjheejh1
         nhpA==
X-Forwarded-Encrypted: i=1; AKwUvBxBviZJMaAi6hZvgVBIbvcRla0ikDnkopRPSDlQF1GOgRPFjbcAShLCXe6dyTQ/2jtFKH3Yk+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcbeCCmuOcKtPIJTSSuSRO+gFT0XdIJxHjRCUFkn/xlkMRfbie
	PXIa6x70hxXe5UNecjbIw/CPNCMaMcmBhbCGmBFrct3FKNKIjbcefrRJ
X-Gm-Gg: AYBFou1J0B+SSLyYwStQ43PL4udWzgiQ5TiKV/+2EgyNe8uUSiFazRe2xF7ONoU+kLw
	jMD4lYjekvmNv9JbTdj8gtWaFxYrTV3uYXeBYl73wVT/CLz/+yBz3z2GI2kN52qvUFy8uvYmnk0
	JjdbYwEgXRP3IhDPKIYpQcWZhc4vpRU/7/5Jk6aT43J8ljB4adSH8PtFh/dR8rP5GOSI6MKM1RD
	LOJYlNKdzOIUyCnpmAAs0sWSaaH+2oi4AdMtWEH2lO8u58ssIhDPmeiE/hnZTVF7Q+61nrTr32w
	Rxe8MTBzNYS+mpaJ++dWUDAIO+nzKaGeqayv8VhLV6L7x3jXmeIduzL49r8tIdsnxNFFxhMSxr5
	m8I1m/Dsz/7lvnNFY/7fVlnbvxrPxmsDeiCEdOqIHLjClD/yBDlAMU0DDYDtIlCzNjPcWmOqXSD
	XZYXShUKvHW4os2/b73onHq8Teqep5D8+drgBzbGHAqd8YNfJUN8GM7a/p7BgQGhggV7gyoCXNk
	c+wB4wIV7BLBVyF07KO8M6sTx28272eyMbLW8/OeHSaTC8guuvWqkWExFHwqk3gMI/cLZAaG7hN
	qJJ4L+grPBVTCl6fd4HjhNyvUU+P
X-Received: by 2002:a05:7301:514a:b0:359:3460:bc1c with SMTP id 5a478bee46e88-369e8492c25mr10432744eec.12.1793029740452;
        Mon, 26 Oct 2026 08:49:00 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f44bd644sm18151012eec.15.2026.10.26.08.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:48:59 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	co+b0df61d49532b2ee@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Mon, 26 Oct 2026 08:46:05 -0700
Message-ID: <20261026154604.579823-2-bestswngs@gmail.com>
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

FBIOPUT_VSCREENINFO can supply a virtual width large enough to
overflow get_line_length()'s int multiplication and bypass the
video-memory limit, allowing fbcon to write past the framebuffer. The
offset additions can also wrap, while an excessive videomemorysize
module parameter can be truncated when PAGE_ALIGN() is assigned to
unsigned int.

Limit virtual geometry and offsets to 8192 x 8192 and cap video
memory at 512 MiB, keeping the stride, framebuffer-size, and generic
fbdev drawing calculations within their destination types.

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

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: <co+b0df61d49532b2ee@bugs.sh>
Suggested-by: Helge Deller <deller@gmx.de>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mode
  support while bounding all generic fbdev drawing calculations.
- Cap videomemorysize at 512 MiB.
- Keep the existing arithmetic types now that all inputs are bounded.

 drivers/video/fbdev/vfb.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bd..de40ba8c3 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -31,6 +31,9 @@
      */
 
 #define VIDEOMEMSIZE	(1*1024*1024)	/* 1 MB */
+#define MAX_VIDEOMEMSIZE	(512 * 1024 * 1024)
+#define MAX_XRES		8192
+#define MAX_YRES		8192
 
 static void *videomemory;
 static u_long videomemorysize = VIDEOMEMSIZE;
@@ -159,6 +162,14 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
+	if (var->xres_virtual > MAX_XRES ||
+	    var->yres_virtual > MAX_YRES)
+		return -EINVAL;
+
+	if (var->xoffset > MAX_XRES - var->xres ||
+	    var->yoffset > MAX_YRES - var->yres)
+		return -EINVAL;
+
 	if (var->xres_virtual < var->xoffset + var->xres)
 		var->xres_virtual = var->xoffset + var->xres;
 	if (var->yres_virtual < var->yoffset + var->yres)
@@ -434,9 +445,13 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	if (videomemorysize > MAX_VIDEOMEMSIZE)
+		return -EINVAL;
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0
