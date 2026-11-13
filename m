Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588059;
	b=tVZ1tjAmrERqMIRnGaok3byVbVm/UfejTUUPKymRWd4AP+Me0bHpUN15Ah6C4lw/7yIU
	 wVsasZStzM9br66wAXYW09jXB8MPHQzfaq0Cic5NaI2+Ff8iIIcDFq/BGFJ2ouW2EmiNs
	 B67e+j/Fg1QkcU+kbaZlfQDwyEa5wNgJosyoHZUnCvwRHW05f3Ug3o7O21kM/AjclTVF2
	 6COESnaLD/wMgGvB/gvReugxQ1TROdPQrJWW0srjNDTGW3oFWQIp4TznauWvdbet9E7El
	 Ecq+ksPNdWozbU5VWjOFOLWfrEtirSON0vG3xeemTJktZh7wlPVZCB/vdywHCPKo6kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588059;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O+qYVAnFfn+Nzjp0W1p4js/IvrOSHVTxwtru5vHHvqk=;
	b=jlU/5jDn/M+v1Fn8KNdgu8crgi19DJw+w347EgENTUqtU9ETrtufkV6RmC+5bRgkzmCh
	 EqSuzVAreqTJRn+fSfIj5Aw7Y79gmTpmzkFwmkeoo1QMOrurztcJ+KqG8iigIzZgImhRl
	 swe364NFs+Aji5PGeo2cl72iqMzEgbpEMjvJ8G+MKYSNYv6AmFPcxAaTBK4ZC1DIfWg8c
	 +QsTwvQ9uluPhr0tPMQLaUYwQa3eGxOkGhWx3EEGJXJS5DL33dEm7vAJvlCREEASMU4/j
	 FV77V63gDwyUPBT7SnrS0kBGEvVLtUc8wuhsIRKjI4YSCqNQ70cQoJHUQ8ASorZP/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8RHQ9xa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C257B606E230
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8RHQ9xa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295861F000C4;
	Fri, 13 Nov 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588059;
	bh=O+qYVAnFfn+Nzjp0W1p4js/IvrOSHVTxwtru5vHHvqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n8RHQ9xaD2Ajx4eDzJG5NY+kXr3oPEz6S4RnoUwBHeoad49Ed8O8rQlViNWqBSdNu
	 mriidH1r1XhV9zPE63fsvv5dXTkVxbyJH61MsKD2e6njia1tdwBZSxr6nrPhehuPDI
	 /Nsc9LusnyjHY+E1SRG2D12T1TQ8JCg+/JbqeS1OJ49E4vsdIufowbcpfaVVSFK70F
	 OnkhNwR4ELWFcNrqZZmmqlornp0aNGPL6hfeEZtvj3y2XFnUzkWGTRJ9dSsY7t2i/i
	 XGPZ/AB3kpLevsVdk5CmUkZoFE6j7BSmKfvDAzk/zlx3l1bmq4esPdQMk31Ujj0QRP
	 IQT+5ggWVpTAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] fbdev: kyro: Use devm_ioremap() for mmio registers
Date: Fri, 13 Nov 2026 11:40:55 -0500
Message-ID: <20261113164024.2109768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062153-failed-5.10-d3bc005a6294@kernel.org>
References: <20261107062153-failed-5.10-d3bc005a6294@kernel.org>
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
index 4979339dbc008..7441d48faea77 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -713,13 +713,14 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -768,8 +769,6 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 out_unmap:
 	iounmap(info->screen_base);
-out_unmap_regs:
-	iounmap(currentpar->regbase);
 out_free_fb:
 	framebuffer_release(info);
 
@@ -792,7 +791,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	deviceInfo.ulOverlayOffset = 0;
 
 	iounmap(info->screen_base);
-	iounmap(par->regbase);
 
 	arch_phys_wc_del(par->wc_cookie);
 
-- 
2.53.0

