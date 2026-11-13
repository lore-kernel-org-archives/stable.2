Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586895;
	b=N4saTayO6os4iciTMx8L6v8QJLYTJ2ZQRiYtonzna6jyhQQA04WGna+Ry1ENYF1udtlg
	 7hsZ3ikIw9tWV8DqfRKRoIDA7f1Cq1QjluvhgZm3KEjlIUIA+HyVulPr/gW2buQfD8b+0
	 KQMQjRKWIEgbbKub6kbf1AgSh6zCkgJgKa86MeCm0bYrmP99TKdxA7BOQgXQBYkZ1Yfb3
	 7CMmUZaFVqCyURz/fU8ohqOoojkIFJHoVBNm5XWNHVXPTyB+xh5dUxtUNka7VwMX4etiB
	 UX4aGizuOHm9g97nc7oFUhoMkzR/ke56ZQ/GL/e5DXyKnTf1fe3l6u2tAot1kLdmeyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586895;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YaEfsfK5LgSmnrIQRxjnQRkkmMzr2bamiSdk176uE1U=;
	b=fsHj3YTqtTKhSLEUE1y5IZVA1lgSQY/x7sNJcK+RoxmSYSVLl59VFAqiVrKysGSFN4NH
	 lBhrjxq5FnVSv90TCY/Di+FUE3W1gXrqGMKCdXds/yh/X3NGTFT2KITpXRTe1nKN3BBU8
	 iDEpxEbZND9FrhUk8z8Qx5RJqUI3OdzSaVIDGy8Bj8J0uFU6kSOGl20rGRgAz0ELuownW
	 YvOaPPMOoSKPVcfdRcC6nJsclaQKa/WLvx1pbPscisxJYXzCcSPz+ACGeQsS/owtBgBWe
	 ZL8DO5xLlLrocpv7CgARYbMSC4LUSIOy6NO5Urh1nsfDXRcSh6Rg+5B7wdW1tkLkbHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bg4SVbYq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BE606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bg4SVbYq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535251F000CF;
	Fri, 13 Nov 2026 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586894;
	bh=YaEfsfK5LgSmnrIQRxjnQRkkmMzr2bamiSdk176uE1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bg4SVbYq0qrvm98wTuHVYJKA5CcVvcjIyvYtwka6OL+vY45I9K/Z5u9Rixbr2nvDu
	 wXBoYY8ERfcSA8Y7/HbKeycUQvCou/FiWo4FU8kBoB6ST+jk8ocjXRPUhWUgn1lmaK
	 T9yTk0SJCDbg6VtOnBvsjBPW7PNECzTmFb9zM9j+w5axJId4LH30LcZ+ITjpc9GETq
	 vPBlO4InTHKdKDpu1RY3lbchQDEO5YjafFpZAgLitl8mPGshr5zRGCY2jr+rIdlQMO
	 iQMPTtezmHTmSy+EPQDVREKA845pOVff7/M5gFn629/fUf73n6Ya4rQpqAzoTagrXi
	 HHFaXs4zWiCHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] fbdev: kyro: Release WC setup on registration failure
Date: Fri, 13 Nov 2026 11:21:31 -0500
Message-ID: <20261113162056.2010577-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113162056.2010577-1-sashal@kernel.org>
References: <20261107060509-failed-5.15-d3bc005a6294@kernel.org>
 <20261113162056.2010577-1-sashal@kernel.org>
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

