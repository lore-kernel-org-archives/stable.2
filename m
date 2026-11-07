Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050525;
	b=GMPB+ZiAkoqBCMdpy8mE9GvSKV/CFY6LZ0vsjsYUV7Glg8PfjEBaphE/R7LlGOWL+iOA
	 7pV0bvtbmdaC0qG1jnJjyxRlOhyWnKrP9Rl10AIfjhmv/o57aeklksNIXKGCdZ2rCQ9nP
	 01naheEdIwSiPo9m+ebMGDksMiBsBxSHxESj3HpA1/O2OKtHNzdcujx3wkpyr0tJawIP9
	 W3vAjqB8I6MimofTJ0RbEGo2gGwUbP4kL9YlNjGTyM8In5EB4sT6qex8+mqtjzDpWKAOl
	 haJtHCV5NPL922d/qBcnaizjEPIeThBn2M5NlU5KCore76KnlMmmfTq4yTk3gX73wnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BoLCSx7BFm8QZA2vPBvkGcyh7l0vVhTN9jNafZk/iW4=;
	b=vTIjAKxz4QFC6Nm0T4jmjtDCpxra/9661WnDu3Mb8Xe1amr6YCwZUtQYGLsw2NrLRgkJ
	 Y6nQrUA2VhBdHPt+Owu0vhM9p2zO9GVeL30DGIr2ux1GSpofsA+CiP5p5nunyJac4DtYF
	 PfhAroCU89+YcCY4Pu7u3Sb+FVnvhGwQv8vrjWGUWtuXFk8weyyUW/oPxHwM+fWkETGav
	 18/n0/YPGNG9n9XHR4eAU6sz1PGJMueJfholWv4CqDZKmBZ8Q1jK7qLBz6hPI5knKLMw+
	 HYfBwWi2YXE9APXp3d45lbLrWnO6laSl3DvbuhNJDUVclw1AKuaVseuVcC5aIv9g2/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8ID9Q+9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8ID9Q+9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FF11F0089F;
	Sat,  7 Nov 2026 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050524;
	bh=BoLCSx7BFm8QZA2vPBvkGcyh7l0vVhTN9jNafZk/iW4=;
	h=From:To:Cc:Subject:Date;
	b=A8ID9Q+9seOB7xGZtQX8fvOTD3OTegsHixElQhhfANY0IYJQivMHkDXsaF9E9vLcx
	 xaPRgngcnfpvK7mqCQZ3P6qXuK/cFzZRZKjhDajku/oeRMVjm9xDmlVyIrSzxiNkK0
	 KaspgBII6tMtQkPLqyMOUP7pYXqAJf7t23oQaYrM4um2g6VXvInKJIHBT/vFT04iBK
	 YtXeYg8y5+PefGtP1wATOTR8uRikLbrZZHm/Q+3an60mg+fNDdlFRfXFBRtriY6Og6
	 hBzQtW6xF2F97DUg4Jk1zqgYCaRkuU4eZdAmXXPArxU3WzTRvGxjufgVJx4ysXmtZn
	 TpLqxRq/kwlPg==
From: Sasha Levin <sashal@kernel.org>
To: andrey.misyrov@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: core: Initialize modelist in framebuffer_alloc()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:03 -0500
Message-ID: <20261107062202-failed-5.10-0c9cb9321cb3@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0c9cb9321cb3863b52bdea4b8ae5a27705762c9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062202-failed-5.10-0c9cb9321cb3@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0c9cb9321cb3863b52bdea4b8ae5a27705762c9e Mon Sep 17 00:00:00 2001
From: Andrey Misiurov <andrey.misyrov@gmail.com>
Date: Mon, 12 Oct 2026 19:53:38 +0200
Subject: [PATCH] fbdev: core: Initialize modelist in framebuffer_alloc()

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
---
 drivers/video/fbdev/core/fb_info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fb_info.c b/drivers/video/fbdev/core/fb_info.c
index 52f9bd2c5417a..05988a936bebb 100644
--- a/drivers/video/fbdev/core/fb_info.c
+++ b/drivers/video/fbdev/core/fb_info.c
@@ -43,6 +43,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	info->device = dev;
 	info->fbcon_rotate_hint = -1;
 	info->blank = FB_BLANK_UNBLANK;
+	INIT_LIST_HEAD(&info->modelist);
 
 #if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	mutex_init(&info->bl_curve_mutex);
-- 
2.53.0




