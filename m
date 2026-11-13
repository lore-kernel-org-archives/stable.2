Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588061;
	b=sRq/WNFGzeFl2zNOVhWRg6HbEgB3dUDJgCcaQqZn3X8I4Qt0ZaFp2ge7yI0Yg8J1eQZJ
	 VxcHW8p5Jg1ebpfGquNs4Wfc4sgcKVncQWpA9mzP8SKt59VlRpuxo9OY8FgW+hQ5kz5qH
	 Z7C+7AkMgwqkS+l+74xgOjlDxFeeHAvUIobY3qxJpKYsMBiUYMUN51NXYKzd8nMiHsGfJ
	 wkVbSjQmZ10d/i/IH2lPcZ/UijE6Kob3F2IWMXd439dcxyaSAGzdVRqFIpUBwW8rkRilB
	 y6Y7rY6MTXdBwB4i9TEwr74C0+zj65DnLgawBeEk9b2rgXc8Bn6TZtsU9dOWe1iQGnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588061;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YaEfsfK5LgSmnrIQRxjnQRkkmMzr2bamiSdk176uE1U=;
	b=h3HkBJe6XeImgzMsnFWfj7IziNNDKtKCdRi61/skWhwvmmBPzSjjMp6IV/jdAzY/kDPg
	 baEJ28nnjXFy8avx8Xrex0MyxD1JhBpawy2EfJiGmXqkHY5+eHLcoDRvpl4HZoPCKZX1t
	 6QbLFS0EYsMNUXJwC+pOLjQuL+Z8bMhworAHwgYbnAEP7aypTfTY9ccs/PwCQXcUFrIuA
	 0FWI8u4fbQ5jPddRUjgRRgjZzqNCm9N7oQ6H9E8Taw5zgG2FCoQEEwecNB1uPhv2VfBGx
	 ttNqneK4JZmI0LApWWSVvSXkyZZ2TUhdUAOb3LUwYbtei2E7k9ofu2uxmZ11+d5h/eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMpSvhfh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD26071ABB
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMpSvhfh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE551F000C4;
	Fri, 13 Nov 2026 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588061;
	bh=YaEfsfK5LgSmnrIQRxjnQRkkmMzr2bamiSdk176uE1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMpSvhfh/NFWeXT5cECkJ/nVDmOfug+BHsq0rVsu4F6+2PDCLRjYMvkNPveDTpw/p
	 SWv8x0srlPNNFOZrKBsckrhp7DwcyOh2BNJYfeq5v5LYxhjmzHxlq3Sl0Pv3ULjQt8
	 7DrZ+D/HJhpJLg/uKgo2frrbQK+0SCey1EoJRQD7LJQZYCa+VkuZbgwxbe3VXY1UwW
	 WwMnVTEPMiHDDJa07cJ6eWDQGgpVtXyU358Tu1orZVKA6HWAjz0rEIiPZm7t0gnrBf
	 yB07cGVagh4iGdAb4i4Ucwf8LhsWuwu3A7KqvU25CRVlv9ZPa+WNAS4WeVKD7FkrHa
	 4xnyTvNOnAXrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] fbdev: kyro: Release WC setup on registration failure
Date: Fri, 13 Nov 2026 11:40:57 -0500
Message-ID: <20261113164024.2109768-3-sashal@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit d3bc005a62945aec57059201092b12b7c955e5a7 ]

If register_framebuffer() fails, kyrofb_probe() frees the framebuffer
without releasing its write-combining range. Release the range before
freeing the framebuffer. Earlier failures still skip this cleanup.

The missing cleanup already exists in the initial Git import, before
the conversion from mtrr_add() to arch_phys_wc_add().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/kyro/fbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index b298e9a1b4510..c9f8875e34d91 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -757,7 +757,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_free_fb;
+		goto out_free_wc;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -768,6 +768,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+out_free_wc:
+	arch_phys_wc_del(currentpar->wc_cookie);
 out_free_fb:
 	framebuffer_release(info);
 
-- 
2.53.0

