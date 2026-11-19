Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121478;
	b=kUDD/4gTUCy/Ld5GhPPSJxF6cl3Goyd+Cuz32GRUn16x7rPQq4RqpuJ9pSKJQTuCrPfK
	 HwBJSe8XwzXUkL1zHKhrVy3iLIQR7URQIHY304cAeCCG62AoerwYQT8iW5F8lhsnNHZh8
	 ir365g6jMUswAZxprHqcusXCZHrGQxNHgB+zxSlPeP4FV7+/bgo5STSIh6Mjs/wtzCMNM
	 0bw5J2p6JgMreKQzzS2yuCbCj9byOq+fn5QR/n8IuARUjAeR307Pa9eGEJ/fy3YKSVBVS
	 eZDsiblv1kcIjnqTmeQ2GNYOL5CqzkRc7z8c6Q5ovovVe93LBj75EDfnIZPfLiaTyvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2/xhsmajeOTWb9TKDJR/qiksAhZWeEjLp5YMMU353/g=;
	b=dSwfkmWRedQI5kxdZpQqa8mQjn0FvUA2yNwDlag/eYA2LClz1Z2JwVVvxIAboY4/9dP4
	 3aYlxKcvxqlq7zFDQtBTcXppNJ9OHDnCcwRH1fklekUFAT6P562uVsJX1LNc0eoWspIml
	 jYF4lqU84yMH9bLLLR6L9ADdRIpzZwoPRHIxIrxevaQOyb91n5VaaGc/FymQogWQZ+M3X
	 e4WoZq1iVuoBHsZxhtiDkhamEPkuycrtQeR5NII3GVpW4KCmldPoJ1mV1UTiB3JD4JvvG
	 hSPXVhJPI6zDKmRPjYIJj0HmamjNxPaYAes9jvc3U43AjX3vPlxJJ2SRgmF3gqgvqWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PV4qyeKo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B827606A337;
	Thu, 19 Nov 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PV4qyeKo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF4B1F000C4;
	Thu, 19 Nov 2026 20:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121477;
	bh=2/xhsmajeOTWb9TKDJR/qiksAhZWeEjLp5YMMU353/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PV4qyeKoMQS3aDNLmBQ/LvHdDXPOF8bb14HpuXjHSb5psK1uBZjKpCjDERXg1bcsQ
	 seMu+5GhBo6NKKAd+YjadpKDSfZSRM1I5L7ljIQLV73v7IyxW1a4VniVmd/nEvYmbo
	 SA1ISzGvchk7LjPXIFEkK/v3tHg/IgPbz5lFNJaDLc+68vsZOIGV2N/ppOV4FiRgt5
	 WR+fqTb4KR2wJwBRNB54E1A2yCeoH0Hay7cm1vLwxQw6a7R/2mqjaAeuxuHRhKijVz
	 sk32dTXv/hHKD3JH6s0X4IqXPMOrPLzBkUd1+gXQadlb+Rl46LplsHsdDMubtlEyFT
	 SIyM0DHosEeOw==
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
	jordan_hargrave@dell.com,
	tomer.maimon@nuvoton.com,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 08/12] pinctrl: nuvoton: npcm7xx: Fix fwnode_irq_get() error check in npcm7xx_gpio_of()
Date: Thu, 19 Nov 2026 20:49:04 +0000
Message-ID: <20261119205013.2563811-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
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
negative error codes are stored in pctrl->gpio_bank[id].irq and passed
as large unsigned IRQ numbers when registering the GPIO chip instead of
aborting or deferring probe.

Check for ret < 0 and propagate the error code, matching the NPCM8XX
driver.

Fixes: 693c9ecd8326 ("pinctrl: nuvoton: Reduce use of OF-specific APIs")
Closes: https://sashiko.dev/#/bug/linux-95c9d7d3-32bb-4f4e-ab7f-84872957de4f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Rebase onto pinctrl for-next, dropping manual fwnode_handle_put()
   now handled by __free(fwnode_handle)

 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 3e763a097b91..72480603ce6b 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1871,10 +1871,9 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 		fwnode_handle_put(args.fwnode);
 
 		ret = fwnode_irq_get(child, 0);
-		if (!ret) {
-			dev_err(dev, "No IRQ for GPIO bank %u\n", id);
-			return -EINVAL;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "No IRQ for GPIO bank %u\n", id);
 		pctrl->gpio_bank[id].irq = ret;
 		pctrl->gpio_bank[id].irqbase = id * NPCM7XX_GPIO_PER_BANK;
 		pctrl->gpio_bank[id].pinctrl_id = args.args[0];
-- 
2.56.1.750.gf70dc682cf-goog

