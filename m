Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382EE46A607;
	Tue,  4 Aug 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855389; cv=none; b=soGHzPNegd0FIcJwjp2e28TPZOnC9bQNhefFd9andeSkgJjJTOo6Ehp81icV8OuHfg5CvFEN+MSEroccsDLEVzt5geK8ZfF/JXmQCQJJ8l9MvERXxyjw0gIXZHx+04dBjVNJj7rK9UKjz9vCgqnISOdQUbfVLE0yW6wlSzmr6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855389; c=relaxed/simple;
	bh=G8AQuawFH1bb49rZ1Mc9YB2h6/WXYx6qel0iSLf9Zis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oLLCK7CVpVPjF61igAvxSNAKUX+l7JtAjWFEI9fAUV1JOUlrirfu/OJgDs0/GJ7TNXSiRG18c+JfPsr3JUnXbE5w/dCJ+BFyAt7Y+0OIccXoErH6nwW05D5UGRS6FSIQ+9M1G/Q0yIUWy0+u3SGNFeHj1ORpBNUigoyilUzplLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnfnyI_XFq8RplAA--.12054S3;
	Tue, 04 Aug 2026 22:56:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBXyM2G_XFqFFKJAw--.18278S2;
	Tue, 04 Aug 2026 22:56:06 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org,
	r-rivera-matos@ti.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] power: supply: bq256xx: drain usb_work before freeing the charger
Date: Tue,  4 Aug 2026 14:55:11 +0000
Message-Id: <20260804145511.103470-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBXyM2G_XFqFFKJAw--.18278S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?zXCYfgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1+2rKgwZbUJoZLd1K+vX+HY6thFd2cGMvnkHTL9dfkgmDO
	2kpSfiCVE4veLEz8xT2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxZryDXr47GrW3GFWkJF15WrX_yoW5Cr1rp3
	98CFn8Cr4kZFW8GFWqqF1kZa48K3WftrW5Ar1fJ34YvrnxGw1Dta48tFs0g3yxJFyrZr40
	y3y7tay7uay5CrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU

The USB-PHY notifier queues usb_work, whose handler calls
power_supply_changed(bq->charger). The reset devm action only unregisters
the notifier and was registered before the power supplies, so devm frees
bq->charger on unwind before the action runs; a usb_work still queued can
then dereference it.

Register the reset action after the power supplies, so it unregisters
the notifiers and drains usb_work before the supplies are released.
Initialize usb_work and obtain the PHY references before registering
the notifiers, so the worker cannot run before the supplies exist.

Found by static analysis.

Fixes: 32e4978bb920 ("power: supply: bq256xx: Introduce the BQ256XX charger driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

 drivers/power/supply/bq256xx_charger.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 5a6634fde8..43e1da849d 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -896,6 +896,8 @@ static void bq256xx_charger_reset(void *data)
 
 	if (!IS_ERR_OR_NULL(bq->usb3_phy))
 		usb_unregister_notifier(bq->usb3_phy, &bq->usb_nb);
+
+	cancel_work_sync(&bq->usb_work);
 }
 
 static int bq256xx_set_charger_property(struct power_supply *psy,
@@ -1721,24 +1723,12 @@ static int bq256xx_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, bq256xx_charger_reset, bq);
-	if (ret)
-		return ret;
+	INIT_WORK(&bq->usb_work, bq256xx_usb_work);
+	bq->usb_nb.notifier_call = bq256xx_usb_notifier;
 
 	/* OTG reporting */
 	bq->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-	if (!IS_ERR_OR_NULL(bq->usb2_phy)) {
-		INIT_WORK(&bq->usb_work, bq256xx_usb_work);
-		bq->usb_nb.notifier_call = bq256xx_usb_notifier;
-		usb_register_notifier(bq->usb2_phy, &bq->usb_nb);
-	}
-
 	bq->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
-	if (!IS_ERR_OR_NULL(bq->usb3_phy)) {
-		INIT_WORK(&bq->usb_work, bq256xx_usb_work);
-		bq->usb_nb.notifier_call = bq256xx_usb_notifier;
-		usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
-	}
 
 	ret = bq256xx_power_supply_init(bq, &psy_cfg, dev);
 	if (ret) {
@@ -1746,6 +1736,17 @@ static int bq256xx_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	/* Register after the power supplies so devm runs it first. */
+	ret = devm_add_action_or_reset(dev, bq256xx_charger_reset, bq);
+	if (ret)
+		return ret;
+
+	if (!IS_ERR_OR_NULL(bq->usb2_phy))
+		usb_register_notifier(bq->usb2_phy, &bq->usb_nb);
+
+	if (!IS_ERR_OR_NULL(bq->usb3_phy))
+		usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						bq256xx_irq_handler_thread,

-- 
2.34.1

