Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582253;
	b=TlArcknUtxutdWX2cTYvXTxfjHPHER9k7LB2EdUSmEq6NMdHI7hU/V01YvY4wYzKW+36
	 F4Tjw7aSkoJ+C92DZoIwc82Ul8uEDIMOscQTgCe9Y9AQog/LnGDPoqX4YeFNfb0s/hpFB
	 yAlsVfFFD9YhmkmG78eeiXfTVoDg0+mjcymw9WAVuoODK0e6hi1k01nJqrp+mny02WVRF
	 06Bfkl0M5m8wAeZi+GxhXFE7Mzt2G0j5dgzeGkrdcIwAjqpVa0Z/V2kuji/sRHlTSJ9Nn
	 Rieef6DtAgYyfuEyKC6WC5WfU+IizJH0q97ZytZXsqZRfzBuFU86AkZ5r1SMuSXmuBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582253;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/BAbbz1y3Q6HPZDyvsh9KT1eC5aJVM/60A/b/X2gPQY=;
	b=K12o27/JZXJ0A7cW4lUlBpdjkJe3fjwiFmY+1Tbz4M2UW6yD6y2ApLnTIOnia/ifvPT7
	 t55cZ2CQug1RtjAXnyPYHEYOT0D0J7+AZZwuXYrkqiHyBZ61ktmgreCf++p2jJ9sNLDIm
	 z8XYHN4I4Cyzhge/fIc5T535ZxujMLqatmWSN3nDBDfXSmVFq7YjYP4fFB+aYRX0Zcq1j
	 eBfq52uyL2j0KS4QHrwSEkYGudvnuloGpIykmmKMsXOXKLlp7cKM4gIvEV7nscdrDYOrj
	 yhBAP3+xkkLwfxYe5XUr9w6Qrg232ig6tyjVRquxieNcancDKttMewrzdodgf2GOtxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QA2ASgvI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D73606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QA2ASgvI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B881F000C5;
	Fri, 13 Nov 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582252;
	bh=/BAbbz1y3Q6HPZDyvsh9KT1eC5aJVM/60A/b/X2gPQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QA2ASgvIshM77K6eN+rUZMkBwaZ0xIE0qUyxJzttxTBi3RZc8sJOU9R+fxRZ3Gb7/
	 CONuMQNvyqel86fbgXBnMuDCo8Ldji9bQPQCXgzEOvdKEzWb6YT0wfBLCki7Ngcdol
	 uzmns9G3tdDe+IUzUVqROFfq1NkkoF22YFz+kAVCGFZk3fXKA8pmM9dRGMmPVWCFa1
	 074XxUSXVGTGrJHRoX2cQb6ipa6fPKzUYOL7QVngfTjN5Xq7u48VNUbLirQqtvzSQd
	 Um+CWSfQqdq3YrARM/MfsG7zCZ2PTNTMvTk56F+aN5knFIKF4VgAeAnQauGVoDjY6E
	 Uxs60oBMSUDWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] fbdev: kyro: Use devm_ioremap_wc() for screen mem
Date: Fri, 13 Nov 2026 10:04:09 -0500
Message-ID: <20261113150328.1846150-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113150328.1846150-1-sashal@kernel.org>
References: <20261107053413-failed-6.6-d3bc005a6294@kernel.org>
 <20261113150328.1846150-1-sashal@kernel.org>
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
index 9bfed90c7f563..06bdacf0211a1 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -723,7 +723,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!currentpar->regbase)
 		goto out_free_fb;
 
-	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
+	info->screen_base = devm_ioremap_wc(&pdev->dev, kyro_fix.smem_start,
+					    kyro_fix.smem_len);
 	if (!info->screen_base)
 		goto out_free_fb;
 
@@ -760,7 +761,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_unmap;
+		goto out_free_fb;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -771,8 +772,6 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-out_unmap:
-	iounmap(info->screen_base);
 out_free_fb:
 	framebuffer_release(info);
 
@@ -794,8 +793,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	deviceInfo.ulNextFreeVidMem = 0;
 	deviceInfo.ulOverlayOffset = 0;
 
-	iounmap(info->screen_base);
-
 	arch_phys_wc_del(par->wc_cookie);
 
 	unregister_framebuffer(info);
-- 
2.53.0

