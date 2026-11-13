Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584239;
	b=pUNucIKMf6fXLAGR5fDkItzabh+JKjDrvwiGZ7hemkJbL/8aywVuHw95duBFSTOPcWyI
	 xhZo0fIz8MUw+JYTh5ngu/MKoFcrSDh5R8s0s0+c2ymh69Csj7P6esnFm5k5pNpTOqnG1
	 CCy7S5fAQwQR40sULHbtPmRMYxE2HZ+hpPdj4Z4vq0/0r3ELLBY/WME/91Sr6qz8LM8Xr
	 vO7ZhTYZN+D37gGhqonmd5Tx5hURkL+KVAPxm1shU6JLaOsjVbTQYMru9ENlMkh3cG6N/
	 n5FqyddyH74xGaz75wRyTDjxw4P4Of8+m9+b+wc0TtTBfHwVGYwjmAAQGoUYIiZ22Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ogbSSvVPbIEZwrUSVEqo/PT+Km6hfidoD4MkDi/X/6w=;
	b=JAs6mE/KUAh5FrEy0BcolmXmFoXvwapxBNcGDSr6Tm9zDccCmNFQnsmSeD1NazvNhzMf
	 GUIE9RKSFiCxx5DrTgkLHppUM3EW2FHTBUvuSZuUCw0F4m2G8XfKTwf6+G9bbFRLGU1wQ
	 3Z8EIvVX2YCHnBgamULkzLPPV0rjLgDvz9tQNZRdg5hi6Tb/IDV6kFkfzajRikBHR8pf4
	 FT46SKHpvMnYEgO+x4mURnE5v7wZPWa9+IVNFTPMdEFrcMa8L4l1WtKjJkY0CRW9VNEO4
	 gDlZzbSL8iKCYA+ToMdY48K2f+yHqDpY654oMZA5r1+mYFSliKEzLZXh7etpP8Scdng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp1L8fX4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259C606A335
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp1L8fX4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA11F000C5;
	Fri, 13 Nov 2026 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584238;
	bh=ogbSSvVPbIEZwrUSVEqo/PT+Km6hfidoD4MkDi/X/6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zp1L8fX4xn8NcGY5lGWxcZZuR+cLZh+bEqiuG4vrXlsQGrUoV62uYsx7T4nL1Emlw
	 F/VJ5PZtmdV3miRUTHKjZdxfBbbnXbH3h5wehOxAlaAUM0aLuZ/lRNxJ0B2JTcgbEg
	 4mFMaFbzERBRWljQHh5jS6h4lB6NelrIBOfbzjTUzK0gHXBhFY0qqu+ViAatJQ96h6
	 vRrYGFbF7Er6R4sHCFpRA6OnLpNtFK/O820AojIiW+HzqYoCXTaFxNXulcPahXPBC5
	 Ive5cmFeDhXkpZGg0R8IxqpBf7eY+obCw1bJLHfbJj7hkldOUdUGB0F+saZk8ZMvDr
	 b5BhLBBC3+s3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] fbdev: kyro: Use devm_ioremap_wc() for screen mem
Date: Fri, 13 Nov 2026 10:37:15 -0500
Message-ID: <20261113153600.1932437-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113153600.1932437-1-sashal@kernel.org>
References: <20261107054747-failed-6.1-d3bc005a6294@kernel.org>
 <20261113153600.1932437-1-sashal@kernel.org>
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
index 38c78956b7375..4a3928a525122 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -725,7 +725,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!currentpar->regbase)
 		goto out_free_fb;
 
-	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
+	info->screen_base = devm_ioremap_wc(&pdev->dev, kyro_fix.smem_start,
+					    kyro_fix.smem_len);
 	if (!info->screen_base)
 		goto out_free_fb;
 
@@ -763,7 +764,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_unmap;
+		goto out_free_fb;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -774,8 +775,6 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-out_unmap:
-	iounmap(info->screen_base);
 out_free_fb:
 	framebuffer_release(info);
 
@@ -797,8 +796,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	deviceInfo.ulNextFreeVidMem = 0;
 	deviceInfo.ulOverlayOffset = 0;
 
-	iounmap(info->screen_base);
-
 	arch_phys_wc_del(par->wc_cookie);
 
 	unregister_framebuffer(info);
-- 
2.53.0

