Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329257;
	b=dZ0V1cy+bfY5Skf8UEYS857jptr5FqWb8ALhyIo4+MSIxXX1KZ050kwfC/6lIr8D+0CX
	 mCxF1Fdgsw353xuI1NA82HP1Av9PPlnUyHKZkjNIux8maPWjdcJDTs+lVZ/CpzBCMhiLs
	 B0E/tKFihI/THFC18vYFbO0cwb2SuFRrhUJKPY2IMdnSDwYSSom4sufV4tuQuyDXbz+MA
	 6Ke59r48AMAzVQ3Em1aFJqyk8vd5eIw+Pyl40kGQPjTohYpTvJMUrmBxxXBARLe979E+g
	 +gf48GNmTrraM3dJV6BvHYhPLCt9n3MHe7wRNdlx6Agd+evaYXxyVBxIx5ChGAbtQOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329257;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qlRRqlbknyHO1nvlgTd4Wu3onu0nXW0aDxjWvamrdd4=;
	b=juDcKUOCxptHPvBPnaze8nQwHf79ff7fw5y4HMsHR8JvyNt8WuXqTcCM+K+MNnTTf47I
	 kEFnWrAFPsr5GlPH0mylnGA3nMML0Z+6AKCpILcYfiJJcziSKE6yUXVo/HexvHs+LZibd
	 sMdciVuLw6nQ+lvEiOVt00eLooyQ/oteZ8vl+gPnvqU40t37w0y6lN/nK/hY6wezAfI3M
	 wlVlK2VfgqfPWfVptpbLeNpRdzcr0X0PHtX8018iyBij/xn+fjgKQyjTEy3zO/3Jdo18O
	 XRV9AQJYbdEWzE0Sijyqr3f6dlVbltyjI5Udix2ihyXVBFkoErfcVnAFPQisWVxGoDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+Nm8oEz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DE606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+Nm8oEz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE03F1F008A2;
	Tue, 10 Nov 2026 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329256;
	bh=qlRRqlbknyHO1nvlgTd4Wu3onu0nXW0aDxjWvamrdd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P+Nm8oEzGYNcS4YJRcqpu1nUvI4pK4ZGad5w41vTuleEhs8ohTbeD7WePrYfzvcx9
	 uMWVcWogOeO75cXSOPbqRT9NTHvVMvrQJFWGeIBc6XSIFN2la+hGeQCsABhxXErFrT
	 jpOas0A8F/sheI4ysMTMwjwcf3hTvUttaS26isxerN/E0KoVeJ1Cpe+D4vplyA181Z
	 WG2tg4DjW/XEM023ztNePoDAagCIGXJRuMugo4WBjNLe6LEIv3ZF42h+o1mambdBLI
	 ZRS9OYYKqcRfE/j4RVzfHtj21EpQ7jmqOKbuzNw/YnT2Bgk7SHF6x8UOzqTU2NTueb
	 epl70XgZ24c9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrey Misiurov <andrey.misyrov@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fbdev: core: Initialize modelist in framebuffer_alloc()
Date: Tue, 10 Nov 2026 11:47:34 -0500
Message-ID: <20261110164652.2530368-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052154-failed-6.12-0c9cb9321cb3@kernel.org>
References: <20261107052154-failed-6.12-0c9cb9321cb3@kernel.org>
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

From: Andrey Misiurov <andrey.misyrov@gmail.com>

[ Upstream commit 0c9cb9321cb3863b52bdea4b8ae5a27705762c9e ]

framebuffer_alloc() returns zeroed memory, so info->modelist starts out
with NULL next and prev pointers. The list head is initialized only
later, by fb_videomode_to_modelist() or by do_register_framebuffer().

The "fix potential memory leak" commits listed below added
fb_destroy_modelist(&info->modelist) to the probe error paths of s3fb,
tdfxfb, tridentfb, i740fb and carminefb. These paths can run before
the list head is initialized:

 - s3fb, tdfxfb, tridentfb and i740fb call fb_videomode_to_modelist()
   only after a successful EDID read, and tridentfb can also hit the
   error path on an ioremap() or kmalloc() failure before that;
 - carminefb jumps to the error path when fb_find_mode() fails, before
   its fb_videomode_to_modelist() call.

fb_destroy_modelist() then dereferences the NULL head. Reproduced on
Debian 12 (6.1.180) by binding s3fb to a VGA device without EDID and
forcing fb_alloc_cmap() to fail:

  s3fb 0000:00:03.0: cannot allocate colormap
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:fb_destroy_modelist+0x10/0x80
  Call Trace:
   s3_pci_probe.cold+0x12b/0x2bf [s3fb]
   local_pci_probe+0x41/0x80
   pci_device_probe+0xc3/0x240
   really_probe+0xde/0x380
   __driver_probe_device+0x84/0x150
   driver_probe_device+0x1f/0x90
   __driver_attach+0xce/0x1c0
   bus_for_each_dev+0x87/0xd0
   bus_add_driver+0x1ae/0x200
   driver_register+0x89/0xe0
   do_one_initcall+0x59/0x220
   do_init_module+0x4a/0x1f0

Initialize the list head in framebuffer_alloc(), so info->modelist is
always a valid, possibly empty, list and fb_destroy_modelist() is safe
on every error path. Keep the lazy initialization in
do_register_framebuffer(), as drivers that embed struct fb_info rather
than calling framebuffer_alloc() still depend on it.

Fixes: 3b0ed04bc852 ("fbdev: s3fb: fix potential memory leak in s3_pci_probe()")
Fixes: bb019d755366 ("fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()")
Fixes: 7a35ec619d9a ("fbdev: tridentfb: fix potential memory leak in trident_pci_probe()")
Fixes: 5936063409af ("fbdev: i740fb: fix potential memory leak in i740fb_probe()")
Fixes: 6fcca16a2b19 ("fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: Adjusted context to place the addition after fbcon_rotate_hint because info->blank initialization is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fb_info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fb_info.c b/drivers/video/fbdev/core/fb_info.c
index 4847ebe50d7d7..9b36361bda6e2 100644
--- a/drivers/video/fbdev/core/fb_info.c
+++ b/drivers/video/fbdev/core/fb_info.c
@@ -42,6 +42,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 
 	info->device = dev;
 	info->fbcon_rotate_hint = -1;
+	INIT_LIST_HEAD(&info->modelist);
 
 #if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	mutex_init(&info->bl_curve_mutex);
-- 
2.53.0

