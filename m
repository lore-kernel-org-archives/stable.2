Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702558;
	b=oW6kXDT28wIqKHiMrA9kqzsLYpeKc4vG7BPVCyZhj3wMsC89T7rP/os5h2dkllnNJTbD
	 XnxTnkSeVDEuFI13T+HITjQ4OXVY8MpG1k0mXNxXQKLrlpA5xpsduVa1VN3hZN7IIYhXa
	 N0E8rrqQyj2GGQelD7yxr8qFmuiSESEEKKGH9RQQxypTPze6Xf4gA4aFHy/SomMRTl2Dd
	 RGxrRghcavRWCFAmiRV8xr9Co+jBm4c49s+ossPntQzvZvfrNdxR7kwYfZWHOBfOee1D5
	 LZCv53yted3uwzqMbThrt521qKvXi/blby+bNDGpwsiX0ZxrTx8J7XPaPgTyYxcZt6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702558;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Utk8d1BRt2/HG85jDbMHPQ3tb5+bNgE6B4vI9z4ICAM=;
	b=3LB4VGeRm8Wa4/QNkb0AFB3+hc/EdWqi8EQHNVx43YCfNFKwIf6lTKOMS+4ZbwnxHdLL
	 0eHPmpHAek+JkNsWcOCvqE8VxUCwUm4wZDEwzR6Luaa9H4aqOKyXNAukY1FVKNRluu7FI
	 x6rObJSfy/DvzuI8WCy4+NjXNscCxyMzrE7Jm64xC26UOb/eMfeJBwv/VUOuy+Fi+ypjO
	 SPDXLnKUIN7vpBMjOfLEL4jk0fDmxt6EwXPkwgxolLDoCX+O3HpIKrsvPAB1znoy+DMpb
	 L70DX8jJILfueRjmjGwsLv/Xg+yoaDhqE2rC++z1L72z2AVj2ZIuhBXvNLIU9eIc4rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926706077D9E;
	Tue,  3 Nov 2026 10:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 926706077D9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHFpeXuulqpcg7AA--.2830S2;
	Tue, 03 Nov 2026 18:42:32 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: broadcom: use devm_clk_get() in brcm_usb_phy_dvr_init()
Date: Tue,  3 Nov 2026 10:42:40 +0000
Message-Id: <20261103104240.1373792-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAHFpeXuulqpcg7AA--.2830S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4DtFy5KF4rKr1Duw4fAFb_yoW5XFW5pa
	yxJFWYkr4DCFW7Ka12qw1DZF1Fyw1IgayYkry8t3WS93W3Z348J3W0gr1FvF4ayrWkCws5
	Jry7Ka4xJ3WDCFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43Mx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_
	Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bOAw3UUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnIB7pQAAsZ

brcm_usb_phy_dvr_init() obtains the USB 2.0, USB 3.0 and suspend
clocks with of_clk_get_by_name() and clk_get().  Both take a reference
on the clock that the driver never releases: the error paths after the
lookups return without clk_put(), and brcm_usb_phy_remove() only
unregisters the sysfs group and the PM notifier.  clk_prepare_enable()
and clk_disable_unprepare() only change the prepare/enable counts and
do not drop the reference.

Use devm_clk_get() so that the references are dropped automatically on
probe failure and driver detach, and drop the now unused device node
argument.

Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index e606db489698..c0cb701e419a 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -401,14 +401,13 @@ static int brcm_usb_get_regs(struct platform_device *pdev,
 }
 
 static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
-				 struct brcm_usb_phy_data *priv,
-				 struct device_node *dn)
+				 struct brcm_usb_phy_data *priv)
 {
 	struct device *dev = &pdev->dev;
 	struct phy *gphy = NULL;
 	int err;
 
-	priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
+	priv->usb_20_clk = devm_clk_get(dev, "sw_usb");
 	if (IS_ERR(priv->usb_20_clk)) {
 		if (PTR_ERR(priv->usb_20_clk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
@@ -440,7 +439,7 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 		priv->phys[BRCM_USB_PHY_3_0].id = BRCM_USB_PHY_3_0;
 		phy_set_drvdata(gphy, &priv->phys[BRCM_USB_PHY_3_0]);
 
-		priv->usb_30_clk = of_clk_get_by_name(dn, "sw_usb3");
+		priv->usb_30_clk = devm_clk_get(dev, "sw_usb3");
 		if (IS_ERR(priv->usb_30_clk)) {
 			if (PTR_ERR(priv->usb_30_clk) == -EPROBE_DEFER)
 				return -EPROBE_DEFER;
@@ -453,7 +452,7 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 			return err;
 	}
 
-	priv->suspend_clk = clk_get(dev, "usb0_freerun");
+	priv->suspend_clk = devm_clk_get(dev, "usb0_freerun");
 	if (IS_ERR(priv->suspend_clk)) {
 		if (PTR_ERR(priv->suspend_clk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
@@ -542,7 +541,7 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	err = brcm_usb_phy_dvr_init(pdev, priv, dn);
+	err = brcm_usb_phy_dvr_init(pdev, priv);
 	if (err)
 		return err;
 
-- 
2.34.1

