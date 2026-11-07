Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049518;
	b=fUlFIUBVtaiOHIdAVmuarewuvwNt2wULp+a+wEpnp+T0S9vnlBam6kF0+sBFq/s1RUw7
	 ejf4qtoiC7KY8ShorpRBVJFXy2jHklhiZYjIqW+FVN9152rTxNT7bEPDzDbrduCOZgkqf
	 KT4Tf9xvVrcXu6qRZ0X6rD809byLKG8W613T//zX/T2pdTt14qrRVryRh1G6TRrmVPjoY
	 xhRMTOlW46Im0PChtHLRn48c6kum1kQuQN3oUOYNZtcH8+sKztX5Gfo9dxIf3wAu5E5Pg
	 6FUAWonDVTlzQlQI945e2lWEWqDnmCnjrPBRTTPV9xfM6LA1NTJKSZ7EkBxHoRc925A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049518;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9BTfds+GgSjvZ+OIj64fVhhv2DCrCPpQ3cQuVX+IPgE=;
	b=zZB2B8w1ko/mlsm8z3jSzkvJgm/07RtBkybPdvFwHG9vq5si5skVhUeJGkC6L+CDBaFj
	 aUgrwHlMdpb13f+57Zirmho6wIhbd7RZVMTPklHRs3nqOzsqrsmMIhSqvuYOqxT0YxIt1
	 JgRpwqSrQA8pqM9/q/9BINtx+lOICL3GN2SwfSP8CugAZUEa/5DnPFW947CzKuOg/ste0
	 QFcIHu3Yw3SNM6czCVKxrfO8sGZBDOCCg+AxomteSIQo+kNdkCYLclpf/rB+25OT3jgoU
	 UqzrqgPO94r8HIUrez7Ktfi0yDGFw4r7ffi6mZZ/7I3tr3bnCKS4khc8QCJNSFwwLqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfIKWKtf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8136606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfIKWKtf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253B11F0089F;
	Sat,  7 Nov 2026 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049517;
	bh=9BTfds+GgSjvZ+OIj64fVhhv2DCrCPpQ3cQuVX+IPgE=;
	h=From:To:Cc:Subject:Date;
	b=kfIKWKtfw217f056XsMJTmUjpe77i9TzQCMK5lfWYxVnZgY+S3ErJuqS78GWcHBna
	 TDqchylqJ+KLyLcaiFJR3r8DXCcl+o5/hxQMNueveNFxEq2qj2H6SiNAjptc3/YAPY
	 edlmy/+IMXoa4HJ+7pzmi8XiY2SZJKjWWaecWgz8hX9uywmM9Xici/kZMn4VX+6tpN
	 9NprWKShOBPsgidqaQWPaWBKMuPg9BEQvU3fHxvlc2WJNdVYACiaYMMcD5B8owJaEk
	 oE2iCSlaj52/WtDdwinElO9u5AMZXHFWEpjJ0zprGVKxZQsJwvZeCINnBaG7qv3N3g
	 I0mwEVGOFbebQ==
From: Sasha Levin <sashal@kernel.org>
To: andrey.misyrov@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: core: Initialize modelist in framebuffer_alloc()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:15 -0500
Message-ID: <20261107060515-failed-5.15-0c9cb9321cb3@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0c9cb9321cb3863b52bdea4b8ae5a27705762c9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060515-failed-5.15-0c9cb9321cb3@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




