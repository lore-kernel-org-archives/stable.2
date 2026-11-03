Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700319;
	b=5fb8bQH1g4WkYtsVaZCu/YWi1G0xTsuxe657NI41H28jzrgDcfFJLtnJ/supNS3+evLJ
	 CYlJBJjHeoexmkeoFjG09w0pgiFOmIrYeX2aw+TN2a95O1RulSeGvRn0FhRhvsEsJ0bbc
	 aNOQWilkwAtiVj5NQ/l7CENnHLxA4MHSMsPcMI33DW3NFJCUgjhpETtIeheKwzBUhBQ8G
	 /8E+MwDnsLUDbmzvjlpnR5Umg9m0hO97f5kVm0AOhwhVDsN3jJeMH+h3zuPdSpkRbdP4z
	 dLXCnlMYm2xgpiCbJujIH18/m9eR0xVdnpz8qLKfiW424JGCXCH0iPMlKp/4Ld95mdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700319;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=ZYeZZrG9ZKN5BZOL0KcRfGjiqSQEn+PAKI/JApuA7Lo=;
	b=nUJ0uxTAqljwmcFT8XYQ/SO88Ljv5e1sKqIEWGVBIvGwjNi9eGe/gVMDwsHAcq/BU1lg
	 dI+jH33blpMT2rm2IpUtWHinEjI19KEjvEEh1KTMmPHYSXt+8wgpZA4dtzB9nQ/N6Hx6C
	 2gDEbsfP0AhwZfRKBmFR87AysOJPwnyV7Pw/X93IvOTdrSKJ204IshvL8NG7OkcAH7zve
	 WR0FrjO5unbn8LoPSlO7/Nk0edIe1DUOZCRsdQj1dSRPzSkcb6PhIAYZNxiLbRB2krXjq
	 0OVetdeCfn+TIjSZ9fbHw2OO3LRPFH0MzLJLVypjGfJD0lgEwTF0kT5SQHbUL+MSMcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5843606A327;
	Tue,  3 Nov 2026 10:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5843606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH0JHXselqA3s7AA--.6276S2;
	Tue, 03 Nov 2026 18:05:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] can: sun4i_can: Use devm_clk_get() for the CAN clock
Date: Tue,  3 Nov 2026 10:05:20 +0000
Message-Id: <20261103100520.1309743-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADH0JHXselqA3s7AA--.6276S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UGw18KF4Duw47Zr1UKFg_yoW8Gr48pF
	sYgFWrCrZrGF4Ygw4UJF4kZF1Yvw4Ika4xKr9Yka1Sv3Z3Ar18GFy5tFWUZFW8ZFWkGa1U
	ur4UtF18tFs8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8nNVPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgAAA2rpnIRixAAAs4

sun4ican_probe() obtains the CAN clock with of_clk_get(), but neither
the probe error paths nor sun4ican_remove() ever call clk_put(), so the
clock reference is leaked both when probing fails and when the driver is
unbound.

Use devm_clk_get() so that the reference is released with the device.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/can/sun4i_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index af52285d5a4e..9f5d31063b13 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -819,7 +819,6 @@ static void sun4ican_remove(struct platform_device *pdev)
 
 static int sun4ican_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct clk *clk;
 	struct reset_control *reset = NULL;
 	void __iomem *addr;
@@ -844,7 +843,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 		}
 	}
 
-	clk = of_clk_get(np, 0);
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to request clock\n");
 		err = -ENODEV;
-- 
2.34.1

