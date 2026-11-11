Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434434;
	b=QFXj7gUYuPxheL07GQamaGEX6J55gL/eW5lOxD3Ay2e4zXoXOcm8IyGgZKVE4Hqkp2oq
	 XZSUyTn+W5bhkD0OePO8D934cFPwAgGRkL4U+nHXRJIrVNNMcSTLwmDtKs819aEKMi+7x
	 WBhLoVnnTeTxUeA+4Yyd/NV23W4y1Jtx6rst514FPcUpPb0HeTIUVed6KZ0Eo0s0fW06O
	 TX6cQ4DPSqQsaxplH1yA94AUoMC2BI92nLP7PCDdSztv5Akv/qtKmIUpOQNzLDO/yMyHY
	 lohuRXop4ko3L3LJPEZWH/nU7m0tRIJDlj6mX3VYHZTua04Z2Q8a8HbHC/XHI6DURUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sMow4GbZ3VvBLjiBina48O6/cSg+LRhs6gWMpwYdc/o=;
	b=SNa3NYAdNGrQuQiBtdSOrcaRuwiP0lrqA+eYImFydFY+c0zWhQd/QEc7mPnetQ1nUudR
	 f1XGpZYpwu7qRRLXLRzHHMHd9C2k0YwRTO3TZM5+P/I0o147L+G+IrQ0X9Cq3E7X2Sm9l
	 o8iMw5OX06PURXm9vCJBNPgkdK0XB+RvTr+DtxO1t/CSEzfMYFzGVE5xZlGEH0qd+I39W
	 /nXYvZt6oQ0Xl0kxXc7qSVSVZLpz2tmWafg6V+JRAmnPB+zwbsGjJQA6JSouLk5Goln22
	 VBoXz9REJyjsyv+MVMaF0XewnMrJnQ8imIbH/eX4vEfUH7Mf8u199nEywMX4hCDa2HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ917ztV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C6606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ917ztV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D661F00A06;
	Wed, 11 Nov 2026 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434433;
	bh=sMow4GbZ3VvBLjiBina48O6/cSg+LRhs6gWMpwYdc/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fJ917ztVT79RRDByrX9TuluFe5Z5Bj1d0G0kLaVDJM0FgdPQfmf/W7brkZf9k5T0B
	 t4QBCqEtGI48aIyGh2+M3BO8PK0kd0vQMAIi+o3S4nuh3OD+TKqOktEJNjLvSwI2Tw
	 6bsysCAYJEcfVtnsr2j7Yx5yYFrcu8SkbmtrmMzUA0tJ/w/4u71RyFuTKhRcV6GRz/
	 htPvzHfU24Of9o0WW6uiw6ONm86hxAd8GLe4fch5WLQgTp+WReN0B9DOS1NxmLMRub
	 pKbfCse7IhL20Hhzy1QdmDBIgkBqx19AMbM6+8lh6+JsKm7yN17dQiOpe5Z9fX9sUr
	 yxOegR4OGUBkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] PCI/pwrctrl: slot: Rename private struct and pointers for consistency
Date: Wed, 11 Nov 2026 17:00:30 -0500
Message-ID: <20261111220022.4081244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051332-failed-6.18-ee450e3a2d33@kernel.org>
References: <20261107051332-failed-6.18-ee450e3a2d33@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit e40d16e6c23994b28894179b87f9747edd63062a ]

Previously the pwrseq, tc9563, and slot pwrctrl drivers used different
naming conventions for their private data structs and pointers to them,
which makes patches hard to read.

Rename structs, variables, and functions to reduce boiler-plate and start
with "slot":

  struct pci_pwrctrl_slot_data      -> struct slot_pwrctrl
  struct pci_pwrctrl ctx            -> struct pci_pwrctrl pwrctrl
  pci_pwrctrl_slot_probe()          -> slot_pwrctrl_probe()
  pci_pwrctrl_slot_of_match[]       -> slot_pwrctrl_of_match[]
  pci_pwrctrl_slot_driver           -> slot_pwrctrl_driver
  devm_pci_pwrctrl_slot_power_off() -> devm_slot_pwrctrl_power_off()

No functional change intended.

[bhelgaas: move "slot" to beginning, also rename functions, etc]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260115-pci-pwrctrl-rework-v5-2-9d26da3ce903@oss.qualcomm.com
Stable-dep-of: ee450e3a2d33 ("PCI/pwrctrl: generic: Fix leaking array from of_regulator_bulk_get_all()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pwrctrl/slot.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d89..51de1eecdb26b 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -13,23 +13,23 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
-struct pci_pwrctrl_slot_data {
-	struct pci_pwrctrl ctx;
+struct slot_pwrctrl {
+	struct pci_pwrctrl pwrctrl;
 	struct regulator_bulk_data *supplies;
 	int num_supplies;
 };
 
-static void devm_pci_pwrctrl_slot_power_off(void *data)
+static void devm_slot_pwrctrl_power_off(void *data)
 {
-	struct pci_pwrctrl_slot_data *slot = data;
+	struct slot_pwrctrl *slot = data;
 
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
 
-static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
+static int slot_pwrctrl_probe(struct platform_device *pdev)
 {
-	struct pci_pwrctrl_slot_data *slot;
+	struct slot_pwrctrl *slot;
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	int ret;
@@ -53,7 +53,7 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
+	ret = devm_add_action_or_reset(dev, devm_slot_pwrctrl_power_off,
 				       slot);
 	if (ret)
 		return ret;
@@ -64,31 +64,31 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 				     "Failed to enable slot clock\n");
 	}
 
-	pci_pwrctrl_init(&slot->ctx, dev);
+	pci_pwrctrl_init(&slot->pwrctrl, dev);
 
-	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
+	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->pwrctrl);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
 
 	return 0;
 }
 
-static const struct of_device_id pci_pwrctrl_slot_of_match[] = {
+static const struct of_device_id slot_pwrctrl_of_match[] = {
 	{
 		.compatible = "pciclass,0604",
 	},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, pci_pwrctrl_slot_of_match);
+MODULE_DEVICE_TABLE(of, slot_pwrctrl_of_match);
 
-static struct platform_driver pci_pwrctrl_slot_driver = {
+static struct platform_driver slot_pwrctrl_driver = {
 	.driver = {
 		.name = "pci-pwrctrl-slot",
-		.of_match_table = pci_pwrctrl_slot_of_match,
+		.of_match_table = slot_pwrctrl_of_match,
 	},
-	.probe = pci_pwrctrl_slot_probe,
+	.probe = slot_pwrctrl_probe,
 };
-module_platform_driver(pci_pwrctrl_slot_driver);
+module_platform_driver(slot_pwrctrl_driver);
 
 MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
 MODULE_DESCRIPTION("Generic PCI Power Control driver for PCI Slots");
-- 
2.53.0

