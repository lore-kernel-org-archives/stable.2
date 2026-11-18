Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011689;
	b=LnUnmJC2ClL9U7wids6VL3eTb4xoY35xjfYutPjWl4p3r+gUaeuTNnvTlVtPjroVL3xW
	 nMXuTlST8IUybgVYMl040MZoL+sb5Qn4T4rNNK6jDH8KfNX3yRf83K2udz3lH28ZK9h1+
	 N88zv03XUDD6h8BmfkzB9ALqBcCadSUdTeLig488LepvqI3o0CxMGFG77xT4r8ThsvcuU
	 GCnQGUWuZhhbZFKrWFye4sdjrG947vMieWaZlmbBWuRBgJOSiY9LIAVO9hOGttCnvicl5
	 LO8wgCZ+iaxJfNKMPiVSQU8jSoH4SltVjVPwxFwSy4G4OICBfCof5HJ/UxOo6pxVR0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011689;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=nFXqbRa1OhelbFVhcjizOVyRIMqDJEhst38NtKslZYw=;
	b=sEcEdyWOGftY2pEJ2pR1PabWTll5Ou2T7oimjz54nzknc7evcTb2ZVrJKGafPGBluD9y
	 bak8iRvmgMATOlZOBPrK+sK7GsxazXTJrOIGPK9t/7y2/dOVsC+mLnY+l3IeFuiDshdt+
	 3u3qBioAk4Ipzdf2wR92aBaSQf4EqUIDzi8yyh6pshDbTUZhNZmS++N9rkteJAYc7/g58
	 qbRyZnDIZxNO9V7RZhGTshDQ1MDvehnOWjiymizU+riX3+lFvl/FTQD18WYZ4DZUQe7on
	 OZt4TGAwGQXAvr3L5TQ0q0a5kGD4DGnHRLVAFCufuAduqDahNkBcdvJfJ7oojIOqpmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=SJqmsQ0u;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B0606A338;
	Wed, 18 Nov 2026 14:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86B0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=SJqmsQ0u
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d794e;
	Wed, 18 Nov 2026 22:21:20 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gpio: aspeed: Fix potential coprocessor bank map leak
Date: Wed, 18 Nov 2026 22:21:19 +0800
Message-ID: <20261118-324f82bd41-gpio-aspeed-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa1ef08970203a1kunma113d6ec1a11e7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhlDVk9JQk5IHkpDS0IeHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=SJqmsQ0uS+5cKunv2Q1gw3yeNHJ31mxKPRdWXq42AJzPd8YIz2EVvhnTxBVEcxUfVaTPpWWa4ycF5OoU6bX9WixaC5ZQsjaZuLFRNZRto9hgJnPvL51ERYHphi3h/5Cc74atzmTdvvdHfxkp5HtkOusdvtPWu0TCavL3cOxlgso=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=nFXqbRa1OhelbFVhcjizOVyRIMqDJEhst38NtKslZYw=;
	h=date:mime-version:subject:message-id:from;

The coprocessor bank map is allocated lazily but is never freed when
the GPIO controller is removed. Its only owner is the device-managed
GPIO private data.

Register a cleanup action before adding the GPIO chip, so removal frees
the map after removing the chip and before freeing its owner.

This issue was found by our static analysis tool under development.

Fixes: a7ca13826e47 ("gpio: aspeed: Add interfaces for co-processor to grab GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/gpio/gpio-aspeed.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index dc53b2decb66..bb30bbf8c60b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1300,6 +1300,13 @@ static const struct of_device_id aspeed_gpio_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 
+static void aspeed_gpio_free_copro_bankmap(void *data)
+{
+	struct aspeed_gpio *gpio = data;
+
+	kfree(gpio->cf_copro_bankmap);
+}
+
 static int aspeed_gpio_probe(struct platform_device *pdev)
 {
 	struct gpio_irq_chip *girq;
@@ -1364,6 +1371,10 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 				gpio->config->llops->reg_bank_get(gpio, (i << 5), reg_rdata);
 	}
 
+	rc = devm_add_action_or_reset(&pdev->dev, aspeed_gpio_free_copro_bankmap, gpio);
+	if (rc)
+		return rc;
+
 	if (gpio->config->llops->privilege_init)
 		gpio->config->llops->privilege_init(gpio);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
