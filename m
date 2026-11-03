Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700364;
	b=DakIM3m7aBYjf5P0eW6GwJoTRXJ/WfEigb1t7BL9AtPB+QNu95bcefsIgvkUwr4f1ps3
	 zpwkY54IyNsnL4Rt5MTd44EYzQSYDYQNdV0bODVJeaSwdm+/xWjZiMEnbNB85Pi8IW3Mh
	 GWha4zSp4eeubF2lu2RKsZVJIxHRXEkfCpKe/3qE1KBk6tMQ/3Dbje+tVhTqcY/wp4tOE
	 sMyfsx1Dg9DIXnX6KjDvhan+PFMBzKmMSh5rntcU35zmz/3Z6JqaxAqZoNV04DUn8rFuZ
	 RfOX65jVzEG64hQIqZ3qFMVcEXR62afBmz5S+jCEHyRbRpveSa2oGMqzBxLetSwUVYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700364;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=BtBRNez46TKw4TBESp0cqsBs/EyjJMCNFLl5tvfMv4c=;
	b=0y0Sra13zOxQdHn/KlipkWu3/ZUw6+P7CET5qo4kpZjhUTmAl9N6aLAe5xUKQF+Y7PrV
	 1mQvDBnRZyVw+mU0GLqc4CKJ1CG3VUF8FG2vMCrDW6SgcIrWpKeoYEumUW/ZmON+rRF5G
	 MIjnecwEbyEo+WC5QHbUU4i+wGwfjAHMqJDYilPYP+jSufc9O0Tbqo06MExvr5FWmUOOJ
	 4BZG7n+s8yjQWdaATjsUqGSOuZtxiysnKLD+aJUSMThFvmuNcCYjAulug2f+W59GfzEe/
	 oQSMSNFVMG42lGr0kZ2TW1f8DJKMCyf+krwM+XsLgW0yn9vGYL6z8mwOgohl8OhZZhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A86606A834;
	Tue,  3 Nov 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A86606A834
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnOJkBsulqf3w7AA--.2834S2;
	Tue, 03 Nov 2026 18:05:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: atmel: Release the HSMC clock on legacy init failure
Date: Tue,  3 Nov 2026 10:06:02 +0000
Message-Id: <20261103100602.1310416-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAAnOJkBsulqf3w7AA--.2834S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy8uFy7GF17Cr1DWF47CFg_yoW5Zw4xpF
	W2qay7Gw1UXF4fuFsrKa1UJFyFqFZ7KayUCws3Ga42vw1FvryqqF1F9FyFqFW5GFWSvw43
	Xa17t3WUCFyrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
	yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEAA2rpnOFgzgAAse

When atmel_hsmc_nand_controller_legacy_init() fails after acquiring the
NFC clock with of_clk_get(), the error paths return without dropping the
clock reference.  For failures after clk_prepare_enable(), the clock is
also left enabled.  The caller returns the error without running the
controller removal path, so the reference and the enable count are both
leaked.

Add error unwinding that disables the clock when it was prepared and
always puts the reference.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 26 ++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 0bdbcbb50d94..f798ac7b9c51 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2185,7 +2185,7 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 	if (ret) {
 		dev_err(dev, "Failed to enable the HSMC clock (err = %d)\n",
 			ret);
-		goto out;
+		goto out_put_clk;
 	}
 
 	nc->irq = of_irq_get(nand_np, 0);
@@ -2194,20 +2194,20 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get IRQ number (err = %d)\n",
 				ret);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	ret = of_address_to_resource(nfc_np, 0, &res);
 	if (ret) {
 		dev_err(dev, "Invalid or missing NFC IO resource (err = %d)\n",
 			ret);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	iomem = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(iomem)) {
 		ret = PTR_ERR(iomem);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	regmap_conf.name = "nfc-io";
@@ -2217,20 +2217,20 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 		ret = PTR_ERR(nc->io);
 		dev_err(dev, "Could not create NFC IO regmap (err = %d)\n",
 			ret);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	ret = of_address_to_resource(nfc_np, 1, &res);
 	if (ret) {
 		dev_err(dev, "Invalid or missing HSMC resource (err = %d)\n",
 			ret);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	iomem = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(iomem)) {
 		ret = PTR_ERR(iomem);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	regmap_conf.name = "smc";
@@ -2240,24 +2240,30 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 		ret = PTR_ERR(nc->base.smc);
 		dev_err(dev, "Could not create NFC IO regmap (err = %d)\n",
 			ret);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	ret = of_address_to_resource(nfc_np, 2, &res);
 	if (ret) {
 		dev_err(dev, "Invalid or missing SRAM resource (err = %d)\n",
 			ret);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	nc->sram.virt = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(nc->sram.virt)) {
 		ret = PTR_ERR(nc->sram.virt);
-		goto out;
+		goto out_disable_clk;
 	}
 
 	nc->sram.dma = res.start;
 
+	goto out;
+
+out_disable_clk:
+	clk_disable_unprepare(nc->clk);
+out_put_clk:
+	clk_put(nc->clk);
 out:
 	of_node_put(nfc_np);
 
-- 
2.34.1

