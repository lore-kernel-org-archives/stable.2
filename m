Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531384;
	b=VQ9I5H40gab1pVS1M2Dzn1ICd876cJHedoLECflEEJNqsb8mxW5qijANjDFod2ZZje2K
	 dZOlGTqYkzHm1oeMCQfbiDZ1Xk4gLA3H4oejsHlxyAotrzuLL5rU67R2Y10wcJ+9/uMwX
	 0NfTodMQzdPR9umr6F4U2iYfuBwORchlDH5xCTchRdHIV8ttDz0uUC8KEoS59MlpASO0u
	 auft8krrrJV3OZQNAPGSXsXL1lIcngmtaTpJb1qr1WfwC0oWo96/V+LaPBvV+JvEqRA8h
	 32awok9Q3qCNYlMvfEWV5ic3S9pZ0cIULqn133K2vxfttcI5fzfbcXuc6EDac/mwC2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CtRGBfCvPjk6NMUwk6EELxmj4aN2F/fvH5mMHwm0bys=;
	b=F7Rm4V4rHwwPlPri1nKWF8aXTjc/214XyjgAewa/iHmacLkubyrrRhqg4aCV7lZSAipZ
	 TgY1fzUPgzZORbYj3CuG4na0EI7x/q+We1H20Rthts1sK+reUwl+7ffHT6os/H4+3urSC
	 3RCiFoDiI964YxYPu+jXqPBtTsTxGZ3JyZzkwIghRrDL7/IuefHsbdNZUVJOQ24s2Ujru
	 Wp0HlRmOmlvwgKRuITqKrFOXic/EustryxHWLNaObEIfOc0kIk7JSrZV3ApmyqGvVVzFY
	 RmEy/vZ707oIj5x01FoCVy9tLP/IpvFZGefUr7eJeQPVVDje8YszpO7A1nWMJA/4/Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jU4YwV6e;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B49606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58B49606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jU4YwV6e
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so410988a91.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794531383; x=1795136183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtRGBfCvPjk6NMUwk6EELxmj4aN2F/fvH5mMHwm0bys=;
        b=jU4YwV6etKf8umE12U/D8ulvXvMFFk+wVQjTZKhg8yB4tuEr3cGD/RHs+s18XN4nyu
         UXTkAeqNrsRPCSx3BsOQeMLuDMG6sfaH8eC6QKINMRcr1epCtDlf7GvhmxBIsXHzTk9+
         tImPdyFkqB+PRDhwRTRqFlS90dCTQVr+Wnwa7aHZeyQNlf308fXtlTo6nPOHJXBDjEet
         WVz/KepZuzbdjes+qitSxLKPRufrachLMbALur0VTLDmuS2wrvvJQEgyE3ISSPHjUow2
         r93LC7GxvaRl4LiLzmwAdutBqGLclM8zhIIdfxdKbg2Rsyx0me4Jh/Mk761IQ+VxPknj
         BbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531383; x=1795136183;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CtRGBfCvPjk6NMUwk6EELxmj4aN2F/fvH5mMHwm0bys=;
        b=PRf/9umbFeeHJJC54Orwxt/MaIPP+SnhaQh9tfWm7oS4/LYoHglmHRAfav9TEMGqQd
         Wi5xrTjqpWhbXL2v0tueR/8hm6s5w+tpCkNLFeDGxGo9z35VoPiBGATpf2CZaZHITeKg
         MBEkrqvYQmuEG+jQP9Ln5b13VsxLVnrc/n0iT29WcKVLKDx805rwc0R80qw4ecwC90kU
         SylMnqmVuxmkBq4OncBWUDT0e0YtXG5H90zhM9yzj59DnrZm+KRGbe0FALPW5Vt4xYVK
         5fwIypEFTpPwT1Tw5i9gtP6I9l9ydezYQBm1QG2K3nQWT3uKZYX+tAePpeROGHUuxc7+
         EDaw==
X-Forwarded-Encrypted: i=1; AL+hErEyjP7En1yNvIOh76EYWFfowdQk7hD6Qjxt8DBhp/s650roDzYaXYVv5nLM0kBbo0dmSPzG6+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z98Dur2UbyBn3WN3tVTgtb6zQ4xh4Yuqxj+VQAQ7GwVFZ8vIqfb
	AFL3mw9I3QRvNvBiAQ2t4AdpdrgdVjXPvzzfxuNuEdE77Ah7TRFngmhm
X-Gm-Gg: AYBFou1tZnqsxdNx6veLBhkqaNCJPbihRy6S5538R8QIjZ0/qL6qWgckhszoNeZEmhq
	QZG4pyrsN27HTY9ISvvp+T8DeoZEplniE0Ed7qPJy0Qjkcweq2kvyYbnuP48kRrtcHiTg9P/dXf
	IR4KDH6KuJ6XaPQMjJOqD2UVmg5AlqOGzF0iCVPXZ7ZWD7gkWZvV4G9s6UMXH/g9Y7F5pClKe6f
	AilA+CHKbONSXMB3Ctk09V1zQg/awcuCM/r92jAG4E/Zvftq3UsjKQAHt2kiV1BmByyRJd3hjvy
	WiLDNi5QvvJEXZLvzTEJoOJWLx94yy+13aylmDwNVg/pQV3d+YHEEosPK3LvBG2DBs/ZDNB8cIk
	8T7UNP+nD+AybzWnxYEwfnf3ZtgWK8nlcaJaOnWi2fIRSS2sSxXo17MCs0CcEROWkiXtOhC/9La
	41ZkbQdNQGNAVkQegzFteOdmq10lFuN0O9tbb9l9/+sjv7dxOqkT6ippsdKMMoV/QeQCnFNEHHv
	iHL/xJEIeqgKso/s19Aow4RwjFjLBt9DkmC0MPEYILg048N5jpQGaUVzATOo+tdqOR0sd3903cK
	j96gQRDpqFMtmZgBO1ujo9HCaL/WfczERNEISnY6QdwDs9okUSJ4F77XR/XrzaTVkbx5I+Sh4s0
	SAlD15zShBHXksc3KC/LK2Z+EqORzuVHoZwf6jzI9V8BmqsMAxxelI4hycA0E3jbEd6XlsTMi3r
	adSPiOcxe6eMHe5jT9h6sO21XKYauvoSpLpDTvnx0h47ZJxx/TKfssfufKDIDudpkm+MA5oA3TR
	UK/ZCADnJoFcCaat3vHcM1i
X-Received: by 2002:a17:90a:d883:b0:3a4:b74a:795c with SMTP id 98e67ed59e1d1-3b1b09f3b50mr619305a91.16.1794531383375;
        Thu, 12 Nov 2026 16:56:23 -0800 (PST)
Received: from lenovo.localdomain (42-155-215-210.ipv4.nexon.net.au. [210.215.155.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c86asm2351735ad.23.2026.11.12.16.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:56:22 -0800 (PST)
From: Miro Kropacek <miro.kropacek@gmail.com>
To: deller@gmx.de
Cc: geert@linux-m68k.org,
	schmitzmic@gmail.com,
	lilinmao@kylinos.cn,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Miro Kropacek <miro.kropacek@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: atafb: Restrict SuperVidel handling to the Falcon
Date: Fri, 13 Nov 2026 10:56:16 +1000
Message-ID: <20261113005616.402721-1-miro.kropacek@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A framebuffer at 0xa0000000 or above is taken as being in SuperVidel
RAM. A TT with a VME graphics card such as the Nova has its framebuffer
there too, so in 8bpp it gets the Falcon palette registers instead of
the card's VGA DAC, and in 8, 16 and 32bpp the SuperBlitter, which it
does not have.

The SuperVidel exists only for the Falcon, so check for the Falcon video
hardware as well.

Fixes: 51df976c3268 ("fbdev: atafb: Add support for further video bit depths on atafb:external")
Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
Cc: stable@vger.kernel.org
Reported-by: Christian Zietz <czietz@gmx.net>
Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
---
 drivers/video/fbdev/atafb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index c32576cb1720..5d9265caa9ab 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2065,6 +2065,15 @@ static void st_ovsc_switch(void)
 
 #ifdef ATAFB_EXT
 
+/*
+ * Only a Falcon can have a SuperVidel; a TT with a VME graphics card can
+ * have its framebuffer in the same address range.
+ */
+static bool ext_is_supervidel(void)
+{
+	return ATARIHW_PRESENT(VIDEL_SHIFTER) && external_addr >= 0xa0000000;
+}
+
 static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 {
 	strcpy(fix->id, "Unknown Extern");
@@ -2083,8 +2092,7 @@ static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 		 * SuperVidel 8bpp chunky (fb in SV RAM) uses the Falcon palette
 		 */
 		int visual = (external_vgaiobase ||
-			      (external_depth == 8 &&
-			       external_addr >= 0xa0000000)) ?
+			      (external_depth == 8 && ext_is_supervidel())) ?
 					 FB_VISUAL_PSEUDOCOLOR :
 					 FB_VISUAL_STATIC_PSEUDOCOLOR;
 		switch (external_pmode) {
@@ -2181,7 +2189,7 @@ static int ext_encode_var(struct fb_var_screeninfo *var, struct atafb_par *par)
 		var->transp.offset = 24;
 		var->transp.length = 8;
 	} else if (external_pmode == FB_TYPE_PACKED_PIXELS &&
-		   external_depth == 8 && external_addr >= 0xa0000000) {
+		   external_depth == 8 && ext_is_supervidel()) {
 		/* SuperVidel 8bpp chunky: palette has 8 bits per channel.
 		 * Without this, fb_get_color_depth() sees length 0 and
 		 * fbcon falls back to its 2-color palette — the console
@@ -2245,7 +2253,7 @@ static int ext_setcolreg(unsigned int regno, unsigned int red,
 		return 0;
 	}
 	if (external_pmode == FB_TYPE_PACKED_PIXELS && external_depth == 8 &&
-	    external_addr >= 0xa0000000) {
+	    ext_is_supervidel()) {
 		/* SuperVidel native 8bpp chunky scans out via the Falcon
 		 * palette registers, honoring all 8 bits per channel
 		 */
@@ -3336,7 +3344,7 @@ static int __init atafb_probe(struct platform_device *pdev)
 		memset (screen_base, 0, external_len);
 
 		/* framebuffer in SV RAM: enable the SuperBlitter */
-		if (external_addr >= 0xa0000000 &&
+		if (ext_is_supervidel() &&
 		    ((external_pmode == FB_TYPE_PACKED_PIXELS &&
 		      external_depth == 8) ||
 		     (external_pmode == -1 &&
-- 
2.43.0

