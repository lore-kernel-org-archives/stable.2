Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584238;
	b=CX4UyDT+UBeeudlfLOUZlYImHrE3lOHllObyxM38WMfWgYtceZjZznGxcSlpEYObmvKL
	 yF7tovNNxCZ3nV5d5JVkuKjRo9kyUDarlAhdVMixwEzfHQiieHw5eMB43e7RAOgY1VsE8
	 Npp1eX9YEMBFxTP6/iVTfdkwWSOLJwyuRmac4dETjlRJ8zsaF5cnS5oRtmQzM/45mlSm2
	 9nt1kpv/aK5yevNAPih2w/Q9uiuimG5OfoN2q/os/R8PPQBvAzNVOGUMtLeH8zgNaa7Sz
	 Rw3gkcSFqK7kb4vOT9Ydm7TqfjzJ/QpMc8AyAk/s1Lms7DNWCjS1iVs6dcRHBu6eVEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584238;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KttKAsrDbIfjBz5d95/ZfNgcueUBSUGJk9Kn3C+RStI=;
	b=2KaPE5mvP9T/84Vj1SRNx24Tg9x3vNdEnQvWcVLVxvn2h8eDeCY6GrpJbO9d5wHmlw4O
	 frlfRFUtyWWjM30B0mXhAExKI2TwNFpBvIcDwVacG/cEEZcyrQ+oODApVSokP+a08Bqwc
	 inGU/NgiNaI0RcUozmLrjxe37jVuzDRify4Uq6O6FCW5E8kL4Sp1aY7DHFGSDZ5eWLTLL
	 wk2D2IUDltRMQ18sGVrra6OnHAw8cu23GhbIjQTeH8JLYpBSwExhQvn9rW1I2Wjc72OM1
	 2p2pRBHmSGkb1jrcSXZQ0brweTYgP9d8w7BDqVQeLxMxLgMA61tlJrVoCt861+RSZhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsU8wfE6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377E606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsU8wfE6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C811F000C4;
	Fri, 13 Nov 2026 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584238;
	bh=KttKAsrDbIfjBz5d95/ZfNgcueUBSUGJk9Kn3C+RStI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dsU8wfE6Jn/Di+oWmZTsqx2ol2TXyd+u24u9VvkY2vjnkdl2mMLefejfnIqZ7sFkS
	 wHNnSZ70rZHJzEGi07jmJpxGo3j+Gn3lFjFuHfcis3jGdZo2y/6wHC1EOE0ZkoRfIh
	 c+BxzrwQViEWeFxaa1WCx/KTWuu2eYJWD9cM4+/s9IckYrTczTUCgV6TI2Es0W8CZx
	 l8Q7W2AcjU0i8sJAgKtVsDSOvmjZEqIaWInm9qfAGJbLawHrUslPv9uGE8TpFHdj91
	 aqyZIE5GQq/DpfjKAK3NaFVQ8y2fu+AMfXpnvMR4I2FF9wt2Nc0SNsq7SAqjytmoCw
	 TD79KOCPnncMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] fbdev: kyro: Use devm_ioremap() for mmio registers
Date: Fri, 13 Nov 2026 10:37:14 -0500
Message-ID: <20261113153600.1932437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054747-failed-6.1-d3bc005a6294@kernel.org>
References: <20261107054747-failed-6.1-d3bc005a6294@kernel.org>
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

[ Upstream commit e0bf12a43243e6afc5a03fc55c58ec48aba48088 ]

Replace the manual ioremap() call for the MMIO registers with the
device-managed devm_ioremap() variant.

This simplifies the driver's resource management by ensuring the memory is
automatically unmapped when the driver detaches from the device.

Signed-off-by: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Stable-dep-of: d3bc005a6294 ("fbdev: kyro: Release WC setup on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/kyro/fbdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index f3e214397ea95..38c78956b7375 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -720,13 +720,14 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kyro_fix.mmio_len   = pci_resource_len(pdev, 1);
 
 	currentpar->regbase = deviceInfo.pSTGReg =
-		ioremap(kyro_fix.mmio_start, kyro_fix.mmio_len);
+		devm_ioremap(&pdev->dev, kyro_fix.mmio_start,
+			     kyro_fix.mmio_len);
 	if (!currentpar->regbase)
 		goto out_free_fb;
 
 	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
 	if (!info->screen_base)
-		goto out_unmap_regs;
+		goto out_free_fb;
 
 	if (!nomtrr)
 		currentpar->wc_cookie = arch_phys_wc_add(kyro_fix.smem_start,
@@ -775,8 +776,6 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 out_unmap:
 	iounmap(info->screen_base);
-out_unmap_regs:
-	iounmap(currentpar->regbase);
 out_free_fb:
 	framebuffer_release(info);
 
@@ -799,7 +798,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	deviceInfo.ulOverlayOffset = 0;
 
 	iounmap(info->screen_base);
-	iounmap(par->regbase);
 
 	arch_phys_wc_del(par->wc_cookie);
 
-- 
2.53.0

