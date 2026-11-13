Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586893;
	b=3qZml+wFVTVsBLobARGMFeE94x2fwI13Ffoif3ZF1CrHvkgQwAt16+Tizzlc+idKULze
	 GvUWKkyJLC8+bZ8Zv9szya6MMxq1pRP5snHOu7LFML7n0Zhe30lr3COoe5hm7gI9pUMO5
	 zl70ha8dQFzo7+R1uY203QPeJqvMvS85gL5ogQosrzRX+0TrZ00Ju7y2YiSuYHtaBZzYb
	 AdnmJ5fzNwVS0z+++jzNIJkZmHnbV+N5l63G/ClJRMsbZIVmmsgbRUC/jjpqXqziHi/IF
	 sJsphxhUZ8H/2oXNsnfPoLyU8tkJ5+O7W/mjBh5OCK/BaPhg+5vyiS1DpReCcOjCutQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O+qYVAnFfn+Nzjp0W1p4js/IvrOSHVTxwtru5vHHvqk=;
	b=5YA/AKtT8J41GOJ2+CPLTYMik9syGFJgmEcZ4QzsN1uWHvtPTtQ+e95JD/XP3OBAnDpU
	 2uuq63zK8BLCzY6Yb8SNPohRT2moBXSzv7RsvBDeuaYOV8SvGYBlozUI+oG4dUKQd1PWx
	 43aO6zdaiElihc3INc9W/uWOwXkVQyn7xc511ATl/UUJrwpXqTEKjqSQiEJD9NBQ/SwKS
	 McwJeLiujoxY5LfKCv+QcmlcxcII4gQkMUmZJT3VXVKHpH8sg5IVRgwflDCP0jCAHyaQu
	 YIOqacMJCGZ2DYoZlifkDW/1ih/vwgUEZYnYy//Is5tfuaz0v+NP4Cmu/Ball6hKzDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp68TBnC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE23606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp68TBnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72BE1F000C4;
	Fri, 13 Nov 2026 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586893;
	bh=O+qYVAnFfn+Nzjp0W1p4js/IvrOSHVTxwtru5vHHvqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zp68TBnCv+CqeINnK+rU5Icm+QL8EJp9A0wG9hWzU5vAlkFOnwMs3q6+e0qghR88y
	 25oK1EqPhP55pKBJjoU7QeM9+fWKYMKufTC5QZiSUZhpRcHpoVkW70XBDlfeeiVykQ
	 U++4a0Dk+o7K4fbueUT3887f2uNhAiajEkhvAI7ENlIP2ybZhqmBX2xwcPtF+ba/Nx
	 eF6DoAz3hxKiND5Yj1T0Vc28+XtLtjh7MLdVkA4uVVjSLl0PtMSEgmHdOYmfHQSvOd
	 uK7gZ+6167x0bjyUMoQ2JlZtIFEEvfKBR1ESmy3V8vB8rF4G8dbEcDOW0bz8hTcu5d
	 e5ILOV3Aitdlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] fbdev: kyro: Use devm_ioremap() for mmio registers
Date: Fri, 13 Nov 2026 11:21:29 -0500
Message-ID: <20261113162056.2010577-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060509-failed-5.15-d3bc005a6294@kernel.org>
References: <20261107060509-failed-5.15-d3bc005a6294@kernel.org>
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

