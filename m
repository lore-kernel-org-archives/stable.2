Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330982;
	b=oNviECZyZGcQParKKbfdRZEBYyYXzHk5+VHWb2TQa+3h0JldR3/Cz7aRpLZhAHpum7be
	 YyZIeyd4DcA7WOarZt+HSHkZ2mdzlbO5LeljAlMIQsVAn1rFCru5oDlD1CRlcuh+zTq0r
	 gT6747/kTAOju/Ue79Wddq80s/JiL2n7hQYKbRNPzDpJedshDTWGCPXcWWhfTRdWPPmaO
	 Kv7J13uuvUj/NGFnVu1NolSFleh0b1QBaG+xo3FVR/ox5EAeDplrrwjXrKCQZvDqgmSKr
	 +yyOsXtFomuPDjQbA78U/HHzTjmmsZLFWwnN6QVhGbytROiedIj29P6R+5tU9Qkcx1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BLK2O9rXwgSZDWWqMNGjMZVTI3Xyd+pBgLOdNjiGy5s=;
	b=ZNa+MhJ7N+2r0P/u1XwFPyAnw4dPeg9NSTAyiE2aqBCYXDtShqiy/O4DnofDQSYecXT1
	 NmhNCmCFv5OTSvRPU48j0xtSnJWH64enn5nQg1yfhsxVNknoUEQZRTO8w9AzUZxhDjk2O
	 tjURhn5+WjA1IsnIlDLo7ooF8Doev94sFwYbKJSQBEaCBVMjb+eT9yL5CDdOC/KX3oC1c
	 tpmbupNnIKpUS2iz+LSDWXCSshMAkUVJ+U6513KGlE+0MZUB6vqF4lgpuyS6MPUbhrgkJ
	 oPnDvlOSccZKr0mMMsZf8tPYKQQ82p7GUq0KD2QwxH9dSdx890W7v20YakQmT2GfUSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClJkpr6r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1543606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClJkpr6r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEF81F0089F;
	Tue, 10 Nov 2026 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330981;
	bh=BLK2O9rXwgSZDWWqMNGjMZVTI3Xyd+pBgLOdNjiGy5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClJkpr6rUvA3u8Ve1UZxH6LSFVNAmWbJzxn4xsLihULEMFzSBAt4AAOaQugTSGvDP
	 lfNLm3xDCTZNyspoZl64JHJhyJzjg3C9DY+neu0anVNwzvSXZNe/0Ye3hDzS8Xtmq5
	 YoOps+SQ0rn35gVu2pzHqY7Ow4xYjZn7Hx5sqJMKNTYNHHGrLX8fRTK8pfeycGszqC
	 TQIqAKuS4cUlel4AmG1qeDk29DloyytFBC5Ij8igV/nFL2wVI5RFRtata701wk1WqT
	 TtU73JOX1ARskW6LW+b/4WjRNUPkubICE2NFkwi1J1kuWjfGfu54LjAo77Y9WKO6oD
	 kCMtZLBw33SkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrey Misiurov <andrey.misyrov@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fbdev: core: Initialize modelist in framebuffer_alloc()
Date: Tue, 10 Nov 2026 12:16:19 -0500
Message-ID: <20261110171545.2633383-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054753-failed-6.1-0c9cb9321cb3@kernel.org>
References: <20261107054753-failed-6.1-0c9cb9321cb3@kernel.org>
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
[ sashal: Applied the change to framebuffer_alloc() in its original location because the upstream file split is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbsysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 5ced9e5510c5d..ef6c3c45ba9e1 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -56,6 +56,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 
 	info->device = dev;
 	info->fbcon_rotate_hint = -1;
+	INIT_LIST_HEAD(&info->modelist);
 
 #if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	mutex_init(&info->bl_curve_mutex);
-- 
2.53.0

