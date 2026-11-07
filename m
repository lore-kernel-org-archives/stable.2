Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046916;
	b=C34HAMTAWA7bRWskCrnIN+j/v6vDlD9RSLRXONNoGv6tZMF9IKQIw5EXEUTZ1TtHOhUc
	 KFnBsNK80CYc081vhr3h8mC5NcQ6rAgMbLcq/SqZ0ixKQikHvTjkKs6e5EqKG4Yg0vR28
	 zkA5BhBp68Q6aY50o0k90FHkXdNxt1uhVqEibl6nAo/DEEHnS0qETleupFt8zz++s4GCD
	 0vD7m0s9oY9SizGJpnW4iOxIRYN5JspdQlKrultn4J8dgiuWd/kPrKdx0Imqoz/R7TFiw
	 UWg8W4BP7yvrHkBgk1hDiMDiGny8a9AJGX19lHAIPrPVDU6EvMvfJ+UJkTAhO1NG4XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QFqDUyLvsoyIXvlhDFNkb3cdpDWZ9LfVnzSLt9HYSO0=;
	b=sgMtrMg3D66VbomVaI2balvvr5s7ASd47sPJlEBQOOI7M1BN99hRIIHk2z44MRSwTssU
	 lRzSVqkBdc6NmZz9iTG1qdT7HCCAC8/NGFz2GNxAQp++CZ5secSn72M0fhrxqP75xHEfp
	 /Qz1gUj1nnm54FKVbxhjA+ECdIzqk5vWoR+PiLlV4Kq6EEvQsLKyuRvXL/rikwlZrAqW9
	 nUr5kWGSzSl4SoicmEemqf54GIVY+xvr94HyV4NPe8207Z2a/zr3h0flRFZA5WjlVHiy/
	 l9pjvaLGajxs88AsAytNIGJjZLSETLv2PJga3ju+BQGHEsJ79ROr6wy1MdViPxH6msg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRD+J0XN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0F606D81B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRD+J0XN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B3C1F008A1;
	Sat,  7 Nov 2026 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046915;
	bh=QFqDUyLvsoyIXvlhDFNkb3cdpDWZ9LfVnzSLt9HYSO0=;
	h=From:To:Cc:Subject:Date;
	b=JRD+J0XNp7vcW16V0A0mAfVWHtWOnx1RqScbGdCEKzxycAk4ad8dYvI4ppJWdvqEI
	 Z4Jnr7/OnzOSbJAK+10uqi/RNCq59CatX97JK0b98jt2TNckKm2EKUBNl7C88gZSPR
	 0apliQyI8Wa1bOQmAiWRX3evgWeMcUd+IBZeZv1s1NEZYZu+A15SjAb/9ljzQwA9fV
	 WaY2fRpwaLmBPyleiq064eW6gX1LcomSCL9A3pN/UrB+dBweyoR9LNwDeO8t44AU1t
	 XLFbUoRDiuTVNyfTe8hLxN3v3ELwTthQuL6tPY56AEC2UEPqPMrikPYwAv6ZysnMu6
	 mYrfFEq9Yglsg==
From: Sasha Levin <sashal@kernel.org>
To: andrey.misyrov@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: core: Initialize modelist in framebuffer_alloc()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:54 -0500
Message-ID: <20261107052154-failed-6.12-0c9cb9321cb3@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0c9cb9321cb3863b52bdea4b8ae5a27705762c9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052154-failed-6.12-0c9cb9321cb3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




