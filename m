Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434029;
	b=gDbe7hlYQuctGDwcljmZvL/J9/W47hkGx+326kNZbR7SyFIIZpiEv7MFx0k+ht4DZmZ0
	 uc/ujQC1Oq/F/dsOR2i+8Y8Ilwu0nK0Fv8Ia5Morkf22ltukJXF3D84HpG/XI7cuS+e0s
	 R2c8K1yWBR4MGV61t0XQHL9WkYupPl+2emugc3lh0oRjRNER8Jp/1qSDCLH6Zy1S6d1ig
	 S2FTDccvz8R/aiGnJnY2E5f6bcqHXua8au75Fe/VQBNtMFQ1KdziI5U7Pvr6HItxX+dYa
	 25XCmTp4WBwoKwBseiK4918r9uPVBquLpq1wahcjo5JKri0nzwVu6WiIBZvFGx3QMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gbExqfingQo1Ed8SYTNsBzSSp4PBA3Al9x/EZXvEVK8=;
	b=4yZ4Ix2V+iQQ7oezMJcBsrjGEEBsgY90CZUoiB09D2BnRTuqYx6nJp/DfeYdXjnT+XSZ
	 MbNeAId+Mj2SaVuEL643+dGYcGr3tdMDlcFV+jzuwjF0Is8K52jyjVw0zrV3mkzZ5L1/S
	 vo0dy1R1EA5BoBoeSlUAzZXGhR0yBGGb17Vbb1yxcrTDMFwPmefO1FtCQca6hCKMWpbbd
	 +vkqmRXKizEd1e/icTefCpIuZrSpwgfbXUDWtw9NK5opaM04U8hBvGKRgErPQ6Zh9KYL6
	 waZDZLio5Iro2ULujay6qIKJT1/+bH0vL+afAt8vofRsVYbz9nl702zWpgrmH/iyTSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R7Gl/93D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAF606A327;
	Wed, 11 Nov 2026 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7Gl/93D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2111F00A05;
	Wed, 11 Nov 2026 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434029;
	bh=gbExqfingQo1Ed8SYTNsBzSSp4PBA3Al9x/EZXvEVK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7Gl/93DTvmW4Vr/YYv/SyBz3EDvlwIQTwzaAZpE+dRhu+A7AQqSJSc2tn106VLB0
	 vPcrhouNDXj8yW9embSr1SKu+p9ANmKUAZTVrsc/yth6YgKKA59TUDZHIjWGIfX+7X
	 vFkjUWsDsM/IBOO3IOgX8hCHx5u2TFB1UB0i5UaMGhaiAr9JIpr2Opu9v0IhvR+dlx
	 eQEW+VkHGYasXkub/rckft0+WwaDeh3X5opsNNkqWHAsywPxte8W+0GT9QG0KGXo90
	 ZcJFUVAtg2IZOBOXT+mU0hoJQYqPJAssu1GS54y2oC4+f8GVjVyVukaOcanf/47HF1
	 8rEZi5HSNyk1w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Linus Walleij <linusw@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	jordan_hargrave@dell.com,
	tomer.maimon@nuvoton.com,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] pinctrl: nuvoton: npcm7xx: Fix fwnode_irq_get() error check in npcm7xx_gpio_of()
Date: Wed, 11 Nov 2026 21:51:51 +0000
Message-ID: <20261111215256.1982044-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
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

Commit 693c9ecd8326 ("pinctrl: nuvoton: Reduce use of OF-specific APIs")
replaced irq_of_parse_and_map(), which returns 0 on failure, with
fwnode_irq_get(), which returns a negative errno on failure (including
-EPROBE_DEFER), while leaving the !ret check unchanged.  As a result,
negative error codes are stored in pctrl->gpio_bank[id].irq as large
unsigned values instead of aborting or deferring probe.

Check for ret < 0 and propagate the error code, matching the NPCM8XX
driver.

Fixes: 693c9ecd8326 ("pinctrl: nuvoton: Reduce use of OF-specific APIs")
Closes: https://sashiko.dev/#/bug/linux-95c9d7d3-32bb-4f4e-ab7f-84872957de4f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index e051ff141d6c..47cc3ef8ddfd 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1856,9 +1856,10 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 		}
 
 		ret = fwnode_irq_get(child, 0);
-		if (!ret) {
-			dev_err(dev, "No IRQ for GPIO bank %u\n", id);
-			return -EINVAL;
+		if (ret < 0) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret,
+					     "No IRQ for GPIO bank %u\n", id);
 		}
 		pctrl->gpio_bank[id].irq = ret;
 		pctrl->gpio_bank[id].irqbase = id * NPCM7XX_GPIO_PER_BANK;
-- 
2.56.0.567.gdb80ae8cd5-goog

