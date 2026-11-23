Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458782;
	b=BjgIy/xln/pz6fJPdnp4Ckwrw5TDzFMjeSWBBs1K51iAaEzyGcWDelQdcDmx3ykVfbOe
	 uN8uYcr+WLqu5qSYVnkKgqYS2ow/7lVdtcwJbkLJESuODWPMQDioQ91DfDM0iAC9Da7MW
	 E7+zxy1XTJxNbR4y9gMdolX+dQVTbNlr8cvXAmicFI4RWe4F8zh3jQFzI0t/0vdfnvjfg
	 mVokpDMBLkowv6jMvRyeWqV1SSoIqe3k/eOcg7yvSNyVp8hNzzmRyhnbu3QJfZvxyUXDP
	 DzBC4AgQcd4NsvRmyXBinqzITBvE9aIkcgpZMWOr1AmflAZ4eEZaNhIN+5Oqh5LNBmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U1MSPx3VfyoIifR48nEATYANkG7RJJfwnA8zIXFxovA=;
	b=Tft08Z24JTMFUC1vHCN0tb8UZz9e0U8AQNcihl/BBMLfcYBAk1Cr4UIFFpmAPalWa/b+
	 Ey0kKvlxZGwjGRzQFpowuJQpGxUnzLxI0vahME3QFJY8xQleESwfu+aZj9eZP8pCndXm7
	 Ws+8U9Rj2ov3okDaCvaRYjbdHp2ucr0z755Lt0CyUxnNPa52uTJloGJUSAXaJ/0ILGFt0
	 /V/aKkdNNmmFt7qnxBgXCFLS7e+akRgoY0zd2eHNdbGGpytrJ0A/jeUH2bMxDjWRHOd0/
	 q7yItvVN9V04Gcv/Fbbion3GYELBaVVOSjhreQRCG4ovy2tjpqp7pkCKx/6PCZ8r3fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxHbG4Qj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D74606A31A;
	Mon, 23 Nov 2026 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxHbG4Qj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD83A1F000C4;
	Mon, 23 Nov 2026 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458781;
	bh=U1MSPx3VfyoIifR48nEATYANkG7RJJfwnA8zIXFxovA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YxHbG4QjoBEKcii62/p3xWuNgfK5sV5ywr53zd7ByLM327S1//TTe0j61atw+hNzP
	 l7BX91cdgPODL6eKAUZQIVWJ38hyog4Ez9fGDgucWrQY2CtQs6kAaLKM1ZBUaKHbMM
	 hjZKaJ7mWvsJ6q9tjUZ/OhkFr3eR+w0qVmHkKs446j4jx/OyJsGm3ObXtf6fGRPwOq
	 +clCPN8Hhd9YZPplHL3Dvo6XSCQdBJH4gkeiHV5HTZyEfq7zJV1JSVc7yHLHdQI8d/
	 56nHAguwU8BaPBUeddkHI/PvGvdrgLLUqP7h2HtqaJawFEolx0h9wrSqggaeD+TKZu
	 xeuwW0rqFxbwA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Fengping Yu <fengping.yu@mediatek.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] Input: mt6779-keypad - enable keypad clock before programming registers
Date: Mon, 23 Nov 2026 18:31:14 +0000
Message-ID: <20261123183200.3900004-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mt6779_keypad_pdrv_probe() writes the debounce and matrix selection
registers over MMIO before acquiring and enabling the "kpd" clock via
devm_clk_get_enabled().

When the keypad clock is gated off at boot or its clock provider defers
probe, accessing unclocked keypad MMIO registers can trigger a bus abort
or silently drop the configuration writes.

Acquire and enable the "kpd" clock before accessing the keypad
registers.

Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
Closes: https://sashiko.dev/#/bug/linux-fc15622a-407a-48b2-88db-195cdb311dbf
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/keyboard/mt6779-keypad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index 60e6ad97cf59..a9f62f02439e 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -195,6 +195,10 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
 
 	input_set_capability(keypad->input_dev, EV_MSC, MSC_SCAN);
 
+	keypad->clk = devm_clk_get_enabled(&pdev->dev, "kpd");
+	if (IS_ERR(keypad->clk))
+		return PTR_ERR(keypad->clk);
+
 	regmap_write(keypad->regmap, MTK_KPD_DEBOUNCE,
 		     (debounce * (1 << 5)) & MTK_KPD_DEBOUNCE_MASK);
 
@@ -208,10 +212,6 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
 	regmap_update_bits(keypad->regmap, MTK_KPD_SEL, MTK_KPD_SEL_COL,
 			   MTK_KPD_SEL_COLMASK(keypad->n_cols));
 
-	keypad->clk = devm_clk_get_enabled(&pdev->dev, "kpd");
-	if (IS_ERR(keypad->clk))
-		return PTR_ERR(keypad->clk);
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
2.56.1.750.gf70dc682cf-goog

