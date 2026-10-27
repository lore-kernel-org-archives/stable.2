Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117391;
	b=FywbYBUHO7wRd+V+psWXNorQtZHYaAxo2IQgIb/SyvOnkwxXPhTO4IWM5xESi5xpKyzM
	 d6RM2uGoNxHK/b2iZ0LWL00TCvbivKHyWGLLP5+zw5TosCfxFdYPECeuAwYnJOcZcac1H
	 iTJtpRxdm3pX5/ZbGmDpBCJE4JvP1wwHf1FowDxOf7DvgTwr9CkLnYkA5Z2pL2CMvNkWj
	 6LHiAyHDSBa0YKoe5XRX9dwuzXL6pgi0LTXZVILwKQyUafP5/cGKyWpbPBFKY5z0fTf79
	 W24yz1xRHbG5ACJeNMrs/ttsF14Mui4yUQQWAzqzCcNDju8SHtJr7WmenSz6jHSXizA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zXxn2I5xRz6x8frUdiRRQE7jhrWj+wttl0bEoQMCRfs=;
	b=DkeXNCR6qXN9Ir0zjJlEM7PB1KB65D/agu4SAeL/uZXo1uONnriIunTTT0T/wGdkgACY
	 eZ5UXyVr3ixsHQup7EfXmugPTcxpm+9RQ/Cr6WyKCyedMCSDYedkyUxPoCm/4nw9tGoxv
	 xnIe387Eb5dNHniNlFS1kVtj1lxmZJv+d/hm10lCqjqMNPjpEkRFQaDZ7VL788VDlJMYx
	 4CHewXMzRPNHZQYcoiIZQeMKb6vyWaNRv+Uj7PEamvRItl1AAeWKntTcwlfmWXk/a+yvL
	 5VVlicnPFh/gqbSIOh7NPhmIpnZHxkrV0oGphnDM36ulbVOLINedPba+pTYpGly2Ryw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zF3ihAUz;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E5606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727E5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zF3ihAUz
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so34579eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117390; x=1793722190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zXxn2I5xRz6x8frUdiRRQE7jhrWj+wttl0bEoQMCRfs=;
        b=zF3ihAUzXf8793o6L+4QfNxIyt7f+13AIXnDYsk7gzSuy+4xL0fzt9p9lf3HEzXuM5
         qHU/hijXmCeOGtpwK2JXmMpkP3fNEQYZ1OQw2el+ubMKdUVFE7EsutNErbR/r/9JXVXp
         mMlw3MubtOyB7eAfF6nHNoxQDK3JarQM2lKMkH2sna7MvF9MP4JDICX2s38DpdMSeFCE
         1kDMz2vrztRfnTkgtj2jqCf716FuVBMsWxFrtMnOf4xjjFhJa+csbQ1t9VwJh5aVj63/
         DhpZNQWV3xsgEZkc4/WPBbRJNTm66g+hY0eLtIdjNlm3TJOShzIO1QtZybQ1R/rUKOqy
         3TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117390; x=1793722190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zXxn2I5xRz6x8frUdiRRQE7jhrWj+wttl0bEoQMCRfs=;
        b=RSs71FF7ucjpCjXcg6ZsWZuXduZ3TZgdQ+Xfy8v/6J2MkUR2r13l4xAf8HFac2V4kI
         AzhYSyVk5wJlKdgpaXY85B/QtXJQfHez+vArbbALKQkL1UZ0dyhQmL0kHG9RH2jkQHxu
         w1lrvnr6h3f8LhQwNm+HtZvFZ7Gj8/mZWqWberDE3h+lfKpwUFwJdT13RM8SeMFtL1vb
         iqc5OrHcqwAOIutNW0fgYCVzFLQk68J67S/lwCkMHslOwVH76TkPVhMB6ViYrQ+8Y/UI
         Ek1IoEA8ndjYB8eLO1eYkSToIGvWE/8vc0FA9vmMnyIk+AUpB2xJopfdrAKFkUG0QLkU
         I+OQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8nL/7lMrWpn2kb14sC6LHfpX7gdtds1uHRaicG8o4MsVeQrTbFfDgPpYrSha6emw1CivXzXY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjFWyxS3ycthVFYnrgsXMXlRtxgF+OjdHwrhhem1kzQhnOt7nV
	WW+WD29kjS3iYie2tJh3Ny/ohinU5tpL97di8RnLEoAv5VPyE4AzuiDyr69gT28GB86Xmw==
X-Gm-Gg: AYBFou2wkpJP4D0FjeahObYNo1MwMahBo/S7lLO7TIUqDTsrQ+sQC5cX+9iPipK/ayi
	dTZ4VU8XrlLGNCe1nsbP3HBgENEiYKMyC24ueyKe9dMDXVf+F52kF7lw9nGOQX1A5MvTIde37PW
	wzTovMKlkXC0bT+eEf8cHLPRNtYohQ1Mdbk1NgX6iW01Tk6ghN6Psc3DTdLUMOBOMx/sttCSmWO
	EMRhs2dzFHrd4zmHTH/lLmcZeW9iSH4BoEbhYrKIM0Kf6v6CLGrkSKsfA+6nne/+jClji0gAK0M
	xqFqENNeU0i30Dmty6IASbvqWAjFXWxymttyn4FyqmVwT8m+jsUzD+7LbwHajONR1NRc+hvS6XG
	6tks8pkaXioIdpGeTl0inoLH5ocGcZU0U7sekNgLQFUp89VU1WHpfV2A3Wwuk6pijn0tw3QtjyW
	f5T7/BXWzidxbw814s5bVBSFV4+H+/frUuV9OHyx6S/oo5SOcMLSqRo/c0eOeAxvLT25OQmIdqA
	H4f2BJ3nAJ9RSzJ+mU24Cybxbq8M8YK31QjDw0n7qr5zv6uTLm55YOO3zUiHe2U2yXOJYNZ8D6+
	MCc15Mylxz8KHIt/4K3hrKeKrmfTEuE5ARRUrh03AUPiaP7wtRvxL7KsjOFrs46FboaqudJRDSA
	8fw==
X-Received: by 2002:a05:7301:d192:b0:353:7e33:664c with SMTP id 5a478bee46e88-369e8610eedmr14636189eec.37.1793117390413;
        Tue, 27 Oct 2026 09:09:50 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daa3a8sm43061239eec.16.2026.10.27.09.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:09:49 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	co+b0df61d49532b2ee@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Tue, 27 Oct 2026 09:09:14 -0700
Message-ID: <20261027160914.3787276-1-bestswngs@gmail.com>
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

Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
keeping the stride, framebuffer-size, and generic fbdev drawing
calculations within their destination types.

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
Changes in v3:
- Clamp visible and virtual resolutions and offsets instead of rejecting
  oversized requests.
- Clamp videomemorysize before PAGE_ALIGN() instead of rejecting it.
- Add unsigned suffixes to the limit constants.

Changes in v2:
- Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mode
  support while bounding all generic fbdev drawing calculations.
- Cap videomemorysize at 512 MiB.
- Keep the existing arithmetic types now that all inputs are bounded.

 drivers/video/fbdev/vfb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bdaed..deaa3e9c758d 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -31,6 +31,9 @@
      */
 
 #define VIDEOMEMSIZE	(1*1024*1024)	/* 1 MB */
+#define MAX_VIDEOMEMSIZE	(512UL * 1024 * 1024)
+#define MAX_XRES		8192U
+#define MAX_YRES		8192U
 
 static void *videomemory;
 static u_long videomemorysize = VIDEOMEMSIZE;
@@ -142,6 +145,10 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 		var->xres = 1;
 	if (!var->yres)
 		var->yres = 1;
+	var->xres = min(var->xres, MAX_XRES);
+	var->yres = min(var->yres, MAX_YRES);
+	var->xres_virtual = min(var->xres_virtual, MAX_XRES);
+	var->yres_virtual = min(var->yres_virtual, MAX_YRES);
 	if (var->xres > var->xres_virtual)
 		var->xres_virtual = var->xres;
 	if (var->yres > var->yres_virtual)
@@ -159,6 +166,9 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
+	var->xoffset = min(var->xoffset, MAX_XRES - var->xres);
+	var->yoffset = min(var->yoffset, MAX_YRES - var->yres);
+
 	if (var->xres_virtual < var->xoffset + var->xres)
 		var->xres_virtual = var->xoffset + var->xres;
 	if (var->yres_virtual < var->yoffset + var->yres)
@@ -434,9 +444,12 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	videomemorysize = min(videomemorysize, MAX_VIDEOMEMSIZE);
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0

