Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504449;
	b=jQkptZtnhl7RapEs7lsXtuF4BoPflgggG4u1wihWdaiv086JbBAo13prNZqCzbnSiwGf
	 wqIt6zS4lVCvc4H3leIpeiI0cNwghYPBVmLMa4QLm57ABx5ro483UKnVO2hSbfCXRRVtU
	 DehYcktnRr6mBcT1X2TGZB/InkXMMiOD/uyZ9F/wsQ7Hs3ENO8BnzN95PzqJqbVDG7Pu8
	 5b8jzpNEeodm7QzLMgIEMBhMqmIqvWYP7sAamXeZrLlNHwqXdshvteupOxTbQ5HRFpLbO
	 lsxcbMxGSAItNNlXzuDsiPYsoomI2Ar48sQtAo9dLBeSF8RDutc+aWJ5zDRMuaEnDOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YDGA8ZSyX5z/Kiu56SCk+wCYQR+ueD7vxm9nV/hrI8M=;
	b=tSL1DeyC+353OnlEHH9Ir4qzq+LKM/0wSwLu/R2dcNYdclUW2QZ0MGTd/bfRQCkCLFH6
	 tCACM3vo9BbcQdr3qkyKD38hrg0yGGUaGzSxDD1rT889d2t/aG15aQdh5NkMhwFsr731B
	 VEoO0OZUkHqu/G3vRzGObvNkQpe0EVJawvWHIgoQqXEfpGsUjQkB1j8YyWqTkSMbtyVDK
	 4cxYgWdb/FxCyv/NtJnqQjsLFaFy477uILpxHVQIg/MvD8GCyXWPb8qSkOzxNkeV2jV8i
	 SZOPtAiNXrsFeyjVOM2OgA3thA/2cg7TPQhlFa26BKencXiBzfwUcFurVMMzKmg2ZnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZgDNyd8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD85606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZgDNyd8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1AD1F000C4;
	Thu, 12 Nov 2026 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504449;
	bh=YDGA8ZSyX5z/Kiu56SCk+wCYQR+ueD7vxm9nV/hrI8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZgDNyd8drYoPvDybZlIe++IMhZvvDkiCyqn/5wlsfzExD5fY3eprIY26KmCgM2tt
	 RsS5qjnBc93i6zqEiv1BTJCsrkrDTn8qoW8SGEwMIVvg1SExTs2dI92fVNRhF7G79R
	 O/iMoxFZQq+mTAw+Hut6XYwRFS/XtfZftJUJ980HuSpBYndMEIVQC5vG+LKGcUg4UT
	 ZjxFB5U7r4Y5wHXs/PiVXiRWh4re+T4WG3IAitb+af8YcUpAEPa/p13x4BCvYrE9th
	 4xgThxEdBhhaEbiBrcMrNBRu10ElammM63vKmt0OAhpsqtWTlxSy7XQOsHXqN9Lf9I
	 cU3njNIph1bIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] fbdev: kyro: Use devm_ioremap() for mmio registers
Date: Thu, 12 Nov 2026 12:27:25 -0500
Message-ID: <20261112172618.3072183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052152-failed-6.12-d3bc005a6294@kernel.org>
References: <20261107052152-failed-6.12-d3bc005a6294@kernel.org>
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
index cf6062210c8bb..c026600d5963b 100644
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

