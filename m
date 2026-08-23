Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A53845CB;
	Sun, 23 Aug 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787480332; cv=none; b=GZjw9nu6WcgMkIzSRqfgzHmjf4nS9nrn+lRz22CTH+jnbrpgIG1TJFvhTg10B2dwYn/fWFb0bGxitQs1DavFdB24XEfUjyEQ0gYI7DINhCEpI6Lhe0VnFKAMI583yNYT280ZkrxUN2xIwmuwgYUrim9YA/qVgV6IiIrIS9IAW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787480332; c=relaxed/simple;
	bh=UCkzaPhSGO4ZVsnknrA2AhJpOIQPs7yYIg1k0JB+Rxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SqGBVdzbzaxetVOZkaUcP6yJD//9HHCqCuMNP99qmhaFxq06ct4QpoouPzbJtFpJXljwLPZZmVx7XjYoTuM/XSaI10WQtdhlTfB/gvBVzASYJeiYwZxXTGr6l1Yg2Eay9U3kDoG+GgtFDo7BBZywB9KPuxxZb5KSUv8en8KzKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOoJ/TnI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOoJ/TnI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 804A2C2BCB8;
	Sun, 23 Aug 2026 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787480331;
	bh=UCkzaPhSGO4ZVsnknrA2AhJpOIQPs7yYIg1k0JB+Rxw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kOoJ/TnIl3mns11ANZUBrNPY5p/hxtOgh9KLoLt/eJKF3aVWH8ghNGH/qAnIX4qHY
	 GuW2UZOez6T37i2w2+gnBvrKft0APouV4k4sbZaviWNACcoHZVum1OVa0t6FI3Nshs
	 CNBJw3rq2Tc8syycCcrIJqJLQcz8Q8TE5BB5gIzOLrJNXyrgliiFhaZ+fsq4s/UYpZ
	 lOUgX23XIZO8qVKXNweXdWH+0EE7xvUstGltsNXTIMfK2XqaeNKz4D0989USgQBsP0
	 24LHyOqPIggP3Y9PyRv2aygWEwGuN91uiygnvFFnzAbr0Ye+kHcBtPtPS+pNhPNLt/
	 IQtCsEonPm08Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B55C5DF97;
	Sun, 23 Aug 2026 10:18:51 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 23 Aug 2026 12:18:46 +0200
Subject: [PATCH] mfd: wcd934x: set DMA mask on parent to silence "DMA mask
 not set"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-wcd-dma-v1-1-95e44a315ccf@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyNj3fLkFN2U3ETdpBQzI8PUVGNLCwtzJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tACVF4qVrAAAA
X-Change-ID: 20260823-wcd-dma-bd621ee39887
To: Lee Jones <lee@kernel.org>, Thomas Tai <thomas.tai@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=+yZV0yAzUP//COgwea2L7HsDDH8oBkgszVtJRU6JO78=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqiskJtyAhDlPxeiHVZWm51nydba6sUveI5NDd6
 1VGzK6kJ+qJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaorJCQAKCRBgAj/E00kg
 cmTkEADEeY4NllOg/3iSQJ708Hp/0muay7InorawmJzkvi1Foivu8zScHDsfxuL09oxEl/q59iG
 s3BRCI9SZeSrA69UnAQnnnCuf/JE/Y1KmEO4ODvmjb0jU2T0987mu9QiNCNUm/5B9ajno3z4iCN
 K405jXYHiGU/LebT4RKDpKlaG3qmRRGgIudR27oLJkKSyG8QC0qEloge2WoGWEaPtsrqbQg5NzI
 6mfPIvg+dnKgTZ/Piz9cqVCPtBQiQFKnQ+R7suQ8VtqeDJQlLDyJyInHpvpwJyNvuifCpCFVn6g
 mKOKS0wYkUgE5gA7aAJh4eosXj7b+lL5PJ6cTYISuRBpQkTuIuRDXWOQnymSAmC8A0O0w8vssEF
 8aTMdcwx6XSzHr+gU9zIcMTEbLP5EMBXSXgC+tsqmBb0aGxk3vzOa/oMKgKbJLe/2SokI2tlxXa
 ZE2t4cOE5oF5iIL7tCyIBjRFDB0bmWmFbYAYFxhkXA6XS5hZjp44s3thrv3pU3TDmyWyJgGPzld
 puhLOv4n9EB2tPbUNFFCRoBXB823eeZCgXzxzJvYI295o8ndkbYhJhl6hiY+zcI4Cvweqetq+wN
 WxwP3b3p/h8izpKNYl6nu7CQzDE7Uwc1XOvWql2beM+OVA8l76EgSDcrS5/c2hWhA8IXIYBiruR
 0xhPPQH40bxRY7Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The wcd934x MFD parent (a slim_device) never initializes its
dma_mask/coherent_dma_mask. When the DT-aware children pass through
of_dma_configure() this triggers the "DMA mask not set" warning for
each child.

Cc: stable@vger.kernel.org
Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
Assisted-by: tencent:hy3
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/mfd/wcd934x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 3c3080e8c8cf7..70ee13791d52b 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019, Linaro Limited
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/wcd934x/registers.h>
 #include <linux/mfd/wcd934x/wcd934x.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -212,16 +213,21 @@ static int wcd934x_slim_status(struct slim_device *sdev,
 static int wcd934x_slim_probe(struct slim_device *sdev)
 {
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct wcd934x_ddata *ddata;
 	struct gpio_desc *reset_gpio;
 	int ret;
 
+	if (!dev->dma_mask) {
+		dev->dma_mask = &dev->coherent_dma_mask;
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	}
+
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return	-ENOMEM;
 
 	ddata->irq = of_irq_get(np, 0);
 	if (ddata->irq < 0)
 		return dev_err_probe(ddata->dev, ddata->irq,
 				     "Failed to get IRQ\n");

---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260823-wcd-dma-bd621ee39887

Best regards,
--  
David Heidelberg <david@ixit.cz>


