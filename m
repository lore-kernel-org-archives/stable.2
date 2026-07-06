Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2B3A7595
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354653; cv=none; b=W9Ao+kHuml67xXfxRj0p97YKHJ9egc/OHW9CA+Vhhm+cf6J8x8jmf0yTUgb5L8nBtz1vhqiXJA7dRqhmW8L19o+BeXzhfk70PCkGIoFESoCyQTJzQfmZNuXEY23CAmdOf1mzw9dAPoCTwHJynMK98GVv5ihtKspUBZ6d4dj8oeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354653; c=relaxed/simple;
	bh=ww6lIWGqon9ltCE6mo0ciN1wMO1MrO3FXa9+7rxtG9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ta9DJgBJiz5H2T3ieOW4OW5msr/alzwGA9vU3Q/M4OrieLYwWse+elropfDn3b1lDqf1ZOsdivQUEzISZ+M5cG5VhMMg3tCeZSwfDKx6lzWQ7BLIWqLEQn74IEgLgWtvG7GDDyFidAsGPpDCXGXt2YXRMwC8AMzd3fRN5RxYI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MCvV9lBc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MCvV9lBc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=DnUQ7xqngB7ltpwKd6wuyVZHXfqWSlaOeWxQxVJmfC8=; b=MCvV9lBctrSSNVNyHP944gtXZH
	g+PRC5gxo503aFbKeXb/jUMLS9DDlH7MxwmUgSxjzsQsB4w1yma+PpbxM4hHAmV9//mL1p62VWTKb
	u4ibbm+CpNWEQG2pWX9zwBOkQ7hFz0klEr32/fO99M5iGZAJnYwYwV0ZHuRpq0rcIGdTqZHsMJwBh
	Vgc8F9f0dQNANBIG4DDNxTSFDgDslIxDKNsG12XKwH9NPZ/pdH/iWRaZuTOj3OvzolpfzQYVMhbEe
	cASFuv5nNmd1oA/m8rdl4DTmZSgPP/J8/H2W3wkoevV8DnWwmHJEkK2PR7M7LXNkvahn1WcUkbpCG
	lWrsiddQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	Marco Scardovi <scardracs@disroot.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 3/3] gpio: rockchip: fix generic IRQ chip leak on remove
Date: Mon,  6 Jul 2026 18:17:13 +0200
Message-ID: <20260706161713.2676365-4-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706161713.2676365-1-heiko@sntech.de>
References: <20260706161713.2676365-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Scardovi <scardracs@disroot.org>

[ Upstream commit 1c1e0fc88d6ef65bf15d517853251f75ab9d18c3 ]

The driver allocates domain generic chips using
irq_alloc_domain_generic_chips() during probe. However, on driver
remove/teardown, the generic chips are not automatically freed when the
IRQ domain is removed because the domain flags do not include
IRQ_DOMAIN_FLAG_DESTROY_GC.

This causes both the domain generic chips structure and the associated
generic chips to be leaked. Additionally, the generic chips remain on
the global gc_list and may later be visited by generic IRQ chip suspend,
resume, or shutdown callbacks after the GPIO bank has been removed,
potentially resulting in a use-after-free and kernel crash.

Fix the resource leak by explicitly calling
irq_domain_remove_generic_chips() before removing the IRQ domain in
rockchip_gpio_remove().

Fixes: 936ee2675eee ("gpio/rockchip: add driver for rockchip gpio")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
Link: https://patch.msgid.link/20260607230504.35392-2-scardracs@disroot.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpio/gpio-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 0a93c74933f0..9c419625c753 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -792,8 +792,10 @@ static void rockchip_gpio_remove(struct platform_device *pdev)
 	struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
 
 	irq_set_chained_handler_and_data(bank->irq, NULL, NULL);
-	if (bank->domain)
+	if (bank->domain) {
+		irq_domain_remove_generic_chips(bank->domain);
 		irq_domain_remove(bank->domain);
+	}
 	gpiochip_remove(&bank->gpio_chip);
 }
 
-- 
2.53.0

