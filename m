Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582252;
	b=t/yaEcrzGChgIattz/VW04xVsUY2eqPKeMFImFMjkHYP0tLtmkcX0dBBQVpWM97Ctb2d
	 qZ+Ck+TKVx7i2Y4Nxa4f0/cp+yrLYRN1xkKrDsvZ4qLKw7ZJnyrdbjP0GqMebSAmgY9lc
	 G0YOD9YioGL9k67bXXNlwKKhoRHsX3GM1Q1XmFEN8EgSdaUGkJc38nKY2aw1Upa6k2Yby
	 /yLNLauW0dPbWWcUNoDrkaCMsdUOuVtf+OtDXe8iRgIYb1rT9mIYrITF87Yrsi17q8DAH
	 TlDefT/7VKWisutggR2GsHxuorNiuoR0cgYAqjBF9sM26bDOlH4iWKM12n5UVZJ/WmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QIFgBmxdjwD1Xz+Y7mOtn9rJDtSSs1uKA+vETQXZJ0w=;
	b=1dyLhjSqwYMXx//YtXA235//WVNY+onZUXKiD9OBvct3zhy7g8dLyxXNh6QBu8nG/SUM
	 ANT/Gh5ME3c56zLGeZUKf7XniG0tF1+xcVFK+Myq2VDR/1Uyg+/pgHxfVmLwftzli2qbd
	 sH2qjCirNpdbFnHBoh88lDGxKv5aEuAV5r54fP3z1O3iEQ+YTvwdtXuN9yKrE0Y9UaDCl
	 CnU1WuIOuwTM12bKLapagewa+GA1jNXmZqeJMGDWqGmYjinqztdocjvVEIEKOz846fTTT
	 nNtjCRIwbjSl09IP0+9CB0Suv1NquVaaILj7zUa4ckN5KqgQOSFQxBsgxV1Pdz9XVfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I/s3Rrrn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85740606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/s3Rrrn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AD81F000C4;
	Fri, 13 Nov 2026 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582252;
	bh=QIFgBmxdjwD1Xz+Y7mOtn9rJDtSSs1uKA+vETQXZJ0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/s3RrrnJc4iJUJRTdZuani6QcnbTvJZxDeS2mtfpKP7a0QQE+oYGb7Zy8UDJZMib
	 inVStym+2Ygbqbq6mYPZeam5Uhzqn16naHksGMnr2OXdn1I1mZUtXR+p8//dS568bX
	 w4Nl0cq4qbliL3tcyVwpWS07ikx0OC4VKZDWxJtNM2wpXSjJdN5svHGGd2nMtxAzLl
	 yYuHaxX69YTBBSG1nqfe0mxnAxFyjAdRy4x8LqRBsmpb/dsWXY2MpPv7lhojB7HElO
	 AoRPcvdbVJ5SLMSOQa/kyofuhM6NxvY7Y5xQO5S8aniz2uCAOn4axaFBOwBmmjw4H+
	 xkPgrWGODsN1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] fbdev: kyro: Use devm_ioremap() for mmio registers
Date: Fri, 13 Nov 2026 10:04:08 -0500
Message-ID: <20261113150328.1846150-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053413-failed-6.6-d3bc005a6294@kernel.org>
References: <20261107053413-failed-6.6-d3bc005a6294@kernel.org>
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
index 868b028d12348..9bfed90c7f563 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -718,13 +718,14 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -772,8 +773,6 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 out_unmap:
 	iounmap(info->screen_base);
-out_unmap_regs:
-	iounmap(currentpar->regbase);
 out_free_fb:
 	framebuffer_release(info);
 
@@ -796,7 +795,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	deviceInfo.ulOverlayOffset = 0;
 
 	iounmap(info->screen_base);
-	iounmap(par->regbase);
 
 	arch_phys_wc_del(par->wc_cookie);
 
-- 
2.53.0

