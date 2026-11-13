Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588060;
	b=Rdzk1F1KmMsJse0Rp2QkO0cSBi6z2Gbp/HFMErwroh0iK+swwgrCFjIhbU7IQ9ED/jot
	 U7lNibeyeLASmvR1pCdirSI1eK+w3J5mQhBxWAse4ansXu9REXp8AZ92opKZ8/OlvZowk
	 eW8TtVbl1MBiObJDnx5LeKc/DlOcveNGcUv2g6XeDYn7Ob6Atlmb2NNgFOMam90ZzTz0Y
	 8lWu8pakV6DcryH14Ischesm/OD0xHZCVxh5JtrdLpxnDb4m3wsQUVcb4DsokdmZ5jg84
	 /R2P6/Ztrl0sebEjeeIhT4PKYRkzkQxG3O3t0+aAlw0srT9WgodAdNsnKUSc4wLE98w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588060;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o6lmapeQlS9x/gXBpGYE0aCxc6IaBwa8yng/lPkOKyE=;
	b=ax6GShBK9fPupGbcmYWlPC5XwOotG5VeerkFrsJwTOmLsYz4orhEHl55FnAiKDD8iIfb
	 0T05FACv8nN9BVi7fQew5K6sgmUJVfOVr/FU7+q1ifwF9UlOYXnwDzEaYWty/u5XWTga+
	 sZtJj30M7dbuQPZ4dp3uQnBghfjaGy5bqD1kaomu4XaLt/Qn8IP8qJ7Nv3UDfabBiEOkl
	 g+Ji8XZ7jzfPp1joMBg8e8q3Ve8gYZJJZcotbTRpAo2GdtlfLLTC5/0JIEIhUwDVPwedn
	 X/lqmseYF318tQTzcVDhg35EsEuLSg1gu21oC+lNZdSYaoJh6qj0lcnPCmscbogyl+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSMmFO65;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA42606E230
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSMmFO65
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E289E1F000C6;
	Fri, 13 Nov 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588060;
	bh=o6lmapeQlS9x/gXBpGYE0aCxc6IaBwa8yng/lPkOKyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nSMmFO65WweGQDjXPZVIUH+60L/+uSRGk4Kv1W860TSXyhMavLKRYbyZItR/9yxaY
	 ErbmdL/Uj0neXMVCVPmbsq47kwIQd4Zyj+MYQD5btH375pDnqBgI5Arkq4hkdt29hQ
	 NwgxuBvHc1nKidLSflZ0GonC8ep1ZTioklmf/4z9sSWNEM2oLQzcQxzeimhsV/MK0f
	 oWIbNjtNjrIrz0dyrGFDa4HxLMjYBuZ0DsPHjnZIc2HFrNWxS5oV8eaxnhdjMmqclp
	 8fqmUVzg44pKz9xXknv/VGYi7vinzz3roIbAty1MoDZszCJQ5ZiNbAjsc1jqpzKNln
	 TMHB4EaU/qguA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] fbdev: kyro: Use devm_ioremap_wc() for screen mem
Date: Fri, 13 Nov 2026 11:40:56 -0500
Message-ID: <20261113164024.2109768-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113164024.2109768-1-sashal@kernel.org>
References: <20261107062153-failed-5.10-d3bc005a6294@kernel.org>
 <20261113164024.2109768-1-sashal@kernel.org>
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

