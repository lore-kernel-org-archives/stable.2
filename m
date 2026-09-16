Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78A4B0E5F;
	Wed, 16 Sep 2026 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577165; cv=none; b=EOgsd+8jTxzDGvewv5A+ekgEArCXbCEWYHJ2VTw2ox/YxUm8a9bWbyRYQl2oCtVtC1EdTIF8t+77UlaBjPeIfH+YIoD0shOwgh23i+2uWZAbHN0YbyFGGtfeBKcLTMfCYdBovt8Ukl+Dc1cOLfKDKUHmT9kUku8O6Z4c5W6v7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577165; c=relaxed/simple;
	bh=LeJoH+bBSPRYaKKSXgX4MRiQuXVwfW4gihICRRMilaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GKj+cbdwDv49T22cYUigYX+taPicC/xYt8f7XC+Hl/vQj1STW5sECtMYfcwu7IT7WLdQI+VW9oEPbFDV6XLhjh4hsvIOEVy2/nk8GxhF1OK6yqO6zGQnxw5pEpMpnQv4GAmB44ncFzlNFUXaB/PkyHB8sjaHe78rwXF8xQbzmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABn0jy6x6pqIOZtCA--.22817S2;
	Thu, 17 Sep 2026 00:45:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: daniel@zonque.org
Cc: dbrownell@users.sourceforge.net,
	gregkh@linuxfoundation.org,
	haojian.zhuang@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	robert.jarzmik@free.fr,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: Fix transceiver leak in pxa_udc_probe()
Date: Wed, 16 Sep 2026 16:45:18 +0000
Message-Id: <20260916164518.2084871-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0jy6x6pqIOZtCA--.22817S2
X-Coremail-Antispam: 1UD129KBjvJXoW7try3urW7KrW8WF45Zr48tFb_yoW8tFWxpa
	nruayrtry5Aa93t393Jwn8ZF1rAF17tFyqkrWIyan5ua13Xr42yw45JFyaga18CFykW3y7
	tFsxtw4fCFWDur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQMA2qqpVhQ8wAAsS

When the device is probed from platform data instead of device tree,
pxa_udc_probe() takes a reference on the USB2 transceiver with
usb_get_phy(USB_PHY_TYPE_USB2). This reference is only released in
pxa_udc_remove(), but the error paths taken after the transceiver has
been acquired return directly: a failed D+ gpio lookup, a failed
devm_clk_get() or clk_prepare() call, a failed devm_request_irq() and
a failed usb_add_gadget_udc() or udc_enable() call all leak the
reference.

Route those error paths to the existing err label so that the
transceiver is put together with the clk_unprepare() cleanup. The put
is guarded by !of_have_populated_dt(), because in the device tree case
the reference is taken by devm_usb_get_phy_by_phandle() and released
by devres when the probe fails.

Fixes: 7fec3c25b773 ("USB: pxa27x_udc: add otg transceiver support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 1abea0d48c35..5f4f66e571f9 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2421,18 +2421,21 @@ static int pxa_udc_probe(struct platform_device *pdev)
 	if (IS_ERR(udc->gpiod)) {
 		dev_err(&pdev->dev, "Couldn't find or request D+ gpio : %ld\n",
 			PTR_ERR(udc->gpiod));
-		return PTR_ERR(udc->gpiod);
+		retval = PTR_ERR(udc->gpiod);
+		goto err;
 	}
 	if (udc->gpiod)
 		gpiod_direction_output(udc->gpiod, 0);
 
 	udc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(udc->clk))
-		return PTR_ERR(udc->clk);
+	if (IS_ERR(udc->clk)) {
+		retval = PTR_ERR(udc->clk);
+		goto err;
+	}
 
 	retval = clk_prepare(udc->clk);
 	if (retval)
-		return retval;
+		goto err;
 
 	udc->vbus_sensed = 0;
 
@@ -2471,6 +2474,8 @@ static int pxa_udc_probe(struct platform_device *pdev)
 		usb_unregister_notifier(udc->transceiver, &pxa27x_udc_phy);
 err:
 	clk_unprepare(udc->clk);
+	if (!of_have_populated_dt() && !IS_ERR_OR_NULL(udc->transceiver))
+		usb_put_phy(udc->transceiver);
 	return retval;
 }
 
-- 
2.34.1

