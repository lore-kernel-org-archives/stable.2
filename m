Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504450;
	b=COYAOMJ30wCefJAi7x4I1yH7SWVLhp+76niFfjjuCqhf5lEKiRJqMXE6K5hGxqH87Bsl
	 PKLHtKBzUtGQD4oYtHet9iu/2yzV6Hgh1ghLlfMGKLneTOc5J4aWrAuFDOxsssGw4S8ZV
	 gTXvNtSQqT2eGSWmS7GmBgNoZcCxgODrOWfyEnv5KnkZRdTTt8NC3K49MyMbxoGzhrwXY
	 hlD8r2BeKLNwjXHcjFeHF/K45aNsDFErB4f6SYks5NgGOfTjZGOSk+hq+xEzsDWzskohT
	 ByrLCZyVmNeV1oIsu+jS4fGDZ7AALLcX/jzNZ+PNxpkBjR94vwcZHyDQGmJjYGkUPsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uJo3NHUzqQJ87f1P9lPePgwGH00gtAJME7I/oXh23ww=;
	b=ZNnMquXe4uLIOrlCqHOVWbKWjGvCgXDMM5eVJ/Z8Zu9N2CqffDvz3e/2jB9Hq11kb2+g
	 81bGejGQiOf4M/A4X4JROzAG9+jai+CQfJ3vWIta9KoDUrP9QOQxOyADUkIl3UwHsh5tM
	 Uj7kKukNlgZAVmLU6ZfvAkkaC7zQQRNNJj4VI77HX3M78l9nTUr2fBf0qAnO8IXq6XRfR
	 lzg12+LSaRrZ4fAfMK4rILOspROHVHIj1zgYew1/Ebn77MwGplrmPc9S3gt+0tr0671FJ
	 ITXQTG4ckButTpKww/TLUOgskGFv0crEF1aWZ8XOeRqZr5nXyilMtDZJU5e3Y7RkjkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFootqex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E76606A337
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFootqex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95C01F000C7;
	Thu, 12 Nov 2026 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504450;
	bh=uJo3NHUzqQJ87f1P9lPePgwGH00gtAJME7I/oXh23ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VFootqexysAfB8LnXerRGUFdg9aCWUfx6viGFfl5mH8u/5zq5yTman6EAtu1TjMNH
	 IscZwhi3f3KzZGOMRIYCzInJyjCrdPzsfp7Gs0amTyTC7WF44hxjAIUfloIDPJLsKc
	 Jk861QV6XnsYvYa7mQtMfZfB3uqs/SORZTD1MgPKWpPkQ/I6okHEgIikVQX7hGy0p+
	 kyu9W4GqV3DyBlx3f96L0iGTyBQqPNSoG1JS81SxHSqIqkvI86CNnBqxyqcJV7UW7S
	 OsOnCoKsBQ9xdA3C/IPYP3nEDTFtUf8rqdhsy0dIVmxJWA1BMzfNRwJZGz2B6K2P3q
	 dEH7jjZTUG7DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] fbdev: kyro: Use devm_ioremap_wc() for screen mem
Date: Thu, 12 Nov 2026 12:27:26 -0500
Message-ID: <20261112172618.3072183-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112172618.3072183-1-sashal@kernel.org>
References: <20261107052152-failed-6.12-d3bc005a6294@kernel.org>
 <20261112172618.3072183-1-sashal@kernel.org>
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
index c026600d5963b..c387bdb1e515f 100644
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

