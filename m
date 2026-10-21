Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585005;
	b=e47YTe1xhdYQPtKCPfbccGaoRSa2bXzCEGXd4iAK0p5/CZEGS7fwQuG9IqvN6CxJpsZr
	 zlwYlikvvQdIhAQH51FsFBQjmnh3hkFBoXboD9iheMIk95MKPspTbUYzTOb7/t0WJWHbq
	 qa47lnt5Ohs9MwNNKAJt9kEngONcd/1qn735mw1/83Fw765MjBfZRuIttjTA0rmUNLihV
	 EK6uCqKRsj2rm2Eq0uwGD65MD2v0WN/GcGkjSLQBlvG14jZsjCRpLnJfXnR181JbAAmJw
	 m6dG4NEyCPa+ZcEE0m6iZQfpax6h+TRK/wiUGim3r/20SOiwo/9yFOxZFJMD5qe54yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WhNgb12bmkpmtNiDfvB9a1bGebOiAzBKY22qKyemjR4=;
	b=cIJt+zl++xqdYb8Bnif+9ouG1xjL2LtoBQLwoFS9Xf4peo9Km+o33VyT8+4OYU5CR2Hy
	 /lzz5h77Ao3fGqNvcDcGy1u3mVq94nIBEWGzGXYEFKtaMUoTqf3rrcPOCZcS0Nqj4KcY0
	 7SVXwGNMi0TBzXcdiBHkmnVDK/fsrPLbU+Tbrfhxty0nODTZ2on34E8BPI/k/NWYfwa7l
	 83uDZP2XPw7knZXVM3e8nIFtiSiyilY5HJZsaGVqrGVmxc1ve5H3MKtEntMFSdv3RuxCM
	 Mm9laMwuYWACQNtgl9D/JYVQUOPnWbko07Zd/2nj5ZveGaZmAQ5wMuuP212Ev15FyLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaXHEf0y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4060A6F72;
	Wed, 21 Oct 2026 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaXHEf0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C260E1F000C5;
	Wed, 21 Oct 2026 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792585005;
	bh=WhNgb12bmkpmtNiDfvB9a1bGebOiAzBKY22qKyemjR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VaXHEf0y8d+f0YELTloNrW7Y/82Vbp9IaGc/JFlu0Q3AzpFU7ahYiQLRAu3l8KY8r
	 Mi1VAzUg5sMlwWmwWjOw8dtImHy5MdKDu1G7jFPbxqTB70Zu531mwUycohkZgvoTR/
	 ZmHLO21q8pwfzEvnuCr9nF7sl8Sj42c/iziz+4Lj4yQCeFwCdUl2hGAbTJXOEtfEm+
	 bQNpJf9mjxG30CQ4NJcHEPS432r7Uvxc/NZIFPK0EUqfzkMoyvwqsTE9PZ/GI5U2u1
	 UZZfw9TF6GssDtrUtFV9TaytbhW9bBDDhs+M+bIgS9W98j7lCsYRA0T0INvKvoR3pE
	 /OkYsP03H+37A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 25/28] mfd: mt6397: Manage IRQ domain lifecycle with devres
Date: Wed, 21 Oct 2026 12:09:47 +0000
Message-ID: <20261021121245.3111563-25-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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

mt6397_irq_init() and mt6358_irq_init() create chip->irq_domain with
irq_domain_create_linear() before registering the parent interrupt via
devm_request_threaded_irq().  If devm_mfd_add_devices() fails in
mt6397_probe(), irq_domain_remove() is called before devres frees the
threaded IRQ and without disposing child IRQ mappings, allowing an
in-flight interrupt handler or late IRQ lookup to dereference the
removed domain.  Conversely, when the driver is unbound, the IRQ
mappings and domain are never removed at all.

Register a devres action immediately after irq_domain_create_linear() to
dispose all mapped hardware interrupts and remove chip->irq_domain so
that the domain is torn down after child MFD devices and the managed IRQ
handler have been released on both probe failure and unbind.

Fixes: 6df8dd5c185b ("mfd: Add support for the MediaTek MT6397 PMIC")
Closes: https://sashiko.dev/#/bug/linux-b296fbe4-6e83-40c0-91c7-2c31e8d226d0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/mt6358-irq.c  | 17 ++++++++++++++++-
 drivers/mfd/mt6397-core.c |  4 +---
 drivers/mfd/mt6397-irq.c  | 16 +++++++++++++++-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
index 74cf20843044..c747cae909ea 100644
--- a/drivers/mfd/mt6358-irq.c
+++ b/drivers/mfd/mt6358-irq.c
@@ -224,6 +224,17 @@ static const struct irq_domain_ops mt6358_irq_domain_ops = {
 	.xlate = irq_domain_xlate_twocell,
 };
 
+static void mt6358_irq_domain_remove(void *data)
+{
+	struct mt6397_chip *chip = data;
+	struct pmic_irq_data *irqd = chip->irq_data;
+
+	for (unsigned int hwirq = 0; hwirq < irqd->num_pmic_irqs; hwirq++)
+		irq_dispose_mapping(irq_find_mapping(chip->irq_domain, hwirq));
+
+	irq_domain_remove(chip->irq_domain);
+}
+
 int mt6358_irq_init(struct mt6397_chip *chip)
 {
 	int i, j, ret;
@@ -279,13 +290,17 @@ int mt6358_irq_init(struct mt6397_chip *chip)
 		return -ENODEV;
 	}
 
+	ret = devm_add_action_or_reset(chip->dev, mt6358_irq_domain_remove,
+				       chip);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL,
 					mt6358_irq_handler, IRQF_ONESHOT,
 					mt6358_irq_chip.name, chip);
 	if (ret) {
 		dev_err(chip->dev, "Failed to register IRQ=%d, ret=%d\n",
 			chip->irq, ret);
-		irq_domain_remove(chip->irq_domain);
 		return ret;
 	}
 
diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 9ec951996588..e94e37cba249 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -395,10 +395,8 @@ static int mt6397_probe(struct platform_device *pdev)
 	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
 				   pmic_core->cells, pmic_core->cell_size,
 				   NULL, 0, pmic->irq_domain);
-	if (ret) {
-		irq_domain_remove(pmic->irq_domain);
+	if (ret)
 		dev_err(&pdev->dev, "failed to add child devices: %d\n", ret);
-	}
 
 	return ret;
 }
diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index 5d2e5459f744..58645dbd8095 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -169,6 +169,16 @@ static int mt6397_irq_pm_notifier(struct notifier_block *notifier,
 	return NOTIFY_DONE;
 }
 
+static void mt6397_irq_domain_remove(void *data)
+{
+	struct mt6397_chip *chip = data;
+
+	for (int hwirq = 0; hwirq < MT6397_IRQ_NR; hwirq++)
+		irq_dispose_mapping(irq_find_mapping(chip->irq_domain, hwirq));
+
+	irq_domain_remove(chip->irq_domain);
+}
+
 int mt6397_irq_init(struct mt6397_chip *chip)
 {
 	int ret;
@@ -223,13 +233,17 @@ int mt6397_irq_init(struct mt6397_chip *chip)
 		return -ENOMEM;
 	}
 
+	ret = devm_add_action_or_reset(chip->dev, mt6397_irq_domain_remove,
+				       chip);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL,
 					mt6397_irq_thread, IRQF_ONESHOT,
 					"mt6397-pmic", chip);
 	if (ret) {
 		dev_err(chip->dev, "failed to register irq=%d; err: %d\n",
 			chip->irq, ret);
-		irq_domain_remove(chip->irq_domain);
 		return ret;
 	}
 
-- 
2.56.0.218.g1ec904b173-goog

