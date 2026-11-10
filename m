Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331607;
	b=U/ZQuzTMSdqpZlXq9UJQ44ew9gHTVW2nfLlDYKzbLRZRbv+R96SFBVBpvOxsIIN3o/9Y
	 HhH5cFCLgJrEY1+8IOQpYKKKAXfdth9E/RcRr9tG1nR9fUHS3RAMO1+ODeTe9KNXq9EZ+
	 TFdhfzHsdyob8yND3TNRw88sVU7liKwhc0TBkuoIQpRL5fhy70G40+z6tXaC+oOK5B8S/
	 I2n/E7wg44+LF3Wht3OUKQ5mQwvjSLd8v1sEPgeSv8J0xMJysp91nA5WxySY3vHO5ty79
	 IHAehzhTJyxamWQH+IJSI44cN4jkXrYJT5Pm0Ko1XuWSzlA53RTTPmTeh77Z5/cdigg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MtNPY4OeG6Tl6D8nImJKqxMdfvQPJNn4v37rVIby1/I=;
	b=GkcQSt8N3zz+Mdks8aRmo1UefHMD0ZdOLmo2bEtme9yDzKTIACvevRfMe3nDaUT5ptJJ
	 oE7AaGp2SwHl00/RSN4dyig8D7bJW72MqUss3XIGg+E9yGP39PLVlLDEt4aXL1I7ctS2w
	 kVFWR2EUb/BMrqGW9uNZVObyOXxz0RxOVS0BiDcRCW+W5ujuSRPtZcfS3coaWYrwNoN6D
	 HoyJaLN8Mf8Kl8DQptV+gRaRNQ2TajmrhAMtVEA9vwaaLPuD9PZjuVMIKZ9RaGHK+vqW1
	 2HLYelcEcsYeykXTQ5VNfzWNVfr/S+sYCh9uFAPr910bheMEHnc9Q93gtj9DB7P3gdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mScFVI8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mScFVI8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB6F1F0089F;
	Tue, 10 Nov 2026 17:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331606;
	bh=MtNPY4OeG6Tl6D8nImJKqxMdfvQPJNn4v37rVIby1/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mScFVI8n8H9dFHNMfuxz7KGRNdrlmqNuJi/3d6gZWJHeIuc53CT4Lml+YrUREZ3Ds
	 E1518KPfe+PQDpWA/vvpekpyo0e1/gMkMaxvepsbP1IvtL/nu9fdkpwmhlYjpg25zl
	 qeyoJV4gnWrRqcHS+59Qzz/ZNvl7m4SmQN/tg/brMgVj4nLzsrGrkdUuYRidrD7xYF
	 x/eH2qROCs1oo7gtpBKskmvw1Hc25uFX7hziE5j2DCSHU+Sz+Lx7/8P2GYA/KWuHED
	 Jmti55YKThZd3hCGXemUlOAHeVZTq3eBsM+09A5ItNunhdgm91nqJKp1rnkk1dlu9u
	 LEftZkt/xiVDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrey Misiurov <andrey.misyrov@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbdev: core: Initialize modelist in framebuffer_alloc()
Date: Tue, 10 Nov 2026 12:26:44 -0500
Message-ID: <20261110172619.2916167-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062202-failed-5.10-0c9cb9321cb3@kernel.org>
References: <20261107062202-failed-5.10-0c9cb9321cb3@kernel.org>
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
[ sashal: adjusted framebuffer_alloc() context due to the missing info->blank initialization ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbsysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 65dae05fff8e6..30798dc64aa89 100644
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

