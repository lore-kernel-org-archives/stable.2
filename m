Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586894;
	b=44J8va/bNVsDeRxMJx+w90HNszc+m6sT5a+y1b0zYtbwl9htH+OaxwCgSPX6BFX4dCsc
	 E0KtEwsgwJsQIbTfqo5K27GC+qd5j1YFrEkhzArTFslIoCyZTpe3Lmn98LijBca+4GHTd
	 vXXTkObxOKQRXe+jicUBf6B/Jo3MkMS/CDvyAMqivnvtnOdg7SxpPZ5I2cMywhflsbpOw
	 LXmZUwCOh4dM77h2gqf0H/yIHh4H+oBhLCnrEQoGEmu6EOSJtWMkrxLgxzZ6vNgXdE95l
	 jH6MkN9CbsL86qJ8s+0bCKeaseZV9zriu2/tXNCDICSdX3skoRo9dbXFuVf++ZsYQow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o6lmapeQlS9x/gXBpGYE0aCxc6IaBwa8yng/lPkOKyE=;
	b=yizUD9tVxAefoKfnxrCZbGLl607ZBvNG9YzB1bT4eok9JaMSWlcuWYA9ZmikjnL80hHZ
	 /RuMB9PdFzQSTN6N5n6cKZOJuHAheZ6XaRZVRBuIF3Evhy/KvkWjySq/HG5J0z6MOH5iP
	 CvxWpgpk3hRYvsHC29hCITuaal8tk8HKIvUcB8L/IYAbsAzK0Pnikx9A8xJ6DinIXgOj+
	 lpPwN+n7FTPBKoR6RSlj/bZJ1dQpeyBImnd/9/9SE/o4GDm9DfA9eAunk4ISWGDujEdgD
	 6sJKpuPWCDVyU01V/kJdJQdt0ltRpPsHS2HRw7PWlzPMSZqv/86rOOZcbSYd0ZmCcVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l00oJE1o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A715606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l00oJE1o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937CC1F000C5;
	Fri, 13 Nov 2026 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586894;
	bh=o6lmapeQlS9x/gXBpGYE0aCxc6IaBwa8yng/lPkOKyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l00oJE1okep0rAgwgVetSSsXVHWZLGFNgifjkmxJbodZmxDB5rF8/U8gru+Spe89a
	 H5toW9i7qgwAqQmdSPC8zdBMypB3k6Y9g+yO8qYxabT24NgvaL1Fo/LB8wOlw8zlQO
	 61MkQhUoRqRJkBV/cBf4ZZjpIpobvU7Saz1PZyjKKvNpoA0Xn1jybGFnlxFZ9YrW1y
	 wnHMiO0ab5k7iTaIX6SEgTGt81rjfshmkZ7wVpGf1gEtKxSBBxusfznBRaDBtqMxdK
	 4+qJRkmdDxKeFhkW8blrLechuRJFxI3un3Ld4o4FJNKuLifewubFgfMSYk/gBaYMiv
	 KX0ML87IuImOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] fbdev: kyro: Use devm_ioremap_wc() for screen mem
Date: Fri, 13 Nov 2026 11:21:30 -0500
Message-ID: <20261113162056.2010577-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113162056.2010577-1-sashal@kernel.org>
References: <20261107060509-failed-5.15-d3bc005a6294@kernel.org>
 <20261113162056.2010577-1-sashal@kernel.org>
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

From: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>

[ Upstream commit 32dfb6112ea3ca143636832cd34234f2be4830bb ]

Replace the manual pci_ioremap_wc() call for mapping screen memory with the
device-managed devm_ioremap_wc() variant.

This simplifies the driver's resource management by ensuring the memory is
automatically unmapped when the driver detaches from the device.

Signed-off-by: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Stable-dep-of: d3bc005a6294 ("fbdev: kyro: Release WC setup on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/kyro/fbdev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 7441d48faea77..b298e9a1b4510 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -718,7 +718,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!currentpar->regbase)
 		goto out_free_fb;
 
-	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
+	info->screen_base = devm_ioremap_wc(&pdev->dev, kyro_fix.smem_start,
+					    kyro_fix.smem_len);
 	if (!info->screen_base)
 		goto out_free_fb;
 
@@ -756,7 +757,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_unmap;
+		goto out_free_fb;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -767,8 +768,6 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-out_unmap:
-	iounmap(info->screen_base);
 out_free_fb:
 	framebuffer_release(info);
 
@@ -790,8 +789,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	deviceInfo.ulNextFreeVidMem = 0;
 	deviceInfo.ulOverlayOffset = 0;
 
-	iounmap(info->screen_base);
-
 	arch_phys_wc_del(par->wc_cookie);
 
 	unregister_framebuffer(info);
-- 
2.53.0

