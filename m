Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A9406838;
	Thu, 11 Jun 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183498; cv=none; b=DN6RC8dOMRUYSkIoh56n/Tqs9o2ZfrvYqMNKdlY0Rz4AlXEHWoLSFssQCz4D4ZH1ySOiHX3y8ZfimYPH7rMKiZDtipHwMuWUeUAKJUvhSTXwocisFCrT9zM0JE6LZqK/hAPGlX342Bdj+pwumquFoatlHs/UaHS/kpQU595L/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183498; c=relaxed/simple;
	bh=XvDNXVE8wPcG4YCZ6QKcbDbrDHp+TptY9m7r6oBE9SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiowiMzID/ZKdlKgWijiv4FM7CCgBV3MMC5GMfloAHg8UYInIsi3ZXpDVcJWZHStV6hahIZrIVHDRpk/sEAxZl02RlhqWEgbR2iE9/EVLRXUupJJK2ebgZtduGFzjIXkodcf/0PvvunJnx9XX1X8ol+Vv1NHSqKddFs1dJ1+S+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowABnvhH7sypqjEwWEw--.24501S2;
	Thu, 11 Jun 2026 21:11:25 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	neil.armstrong@linaro.org,
	khilman@baylibre.com
Cc: jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: dwc3: meson-g12a: fix refcount leak in dwc3_meson_g12a_resume()
Date: Thu, 11 Jun 2026 21:11:21 +0800
Message-ID: <20260611131121.81784-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnvhH7sypqjEwWEw--.24501S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW8KrWDtr45GF4DCFW7Jwb_yoW8Zry7pa
	1Uu343AF18Ar4ftF4UAF45u3Z3A39FkFW5GFWIkwn3Zw1Syw45Xry7KFyrWFsYkFZ5tFyF
	kr47W3WrZF4DGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ2fUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkPA2oqhtGFfAABst

If dwc3_meson_g12a_resume() succeeds in calling
reset_control_reset(), an internal triggered_count reference is
acquired. If any later step fails (usb_init, phy_init,
phy_power_on, regulator_enable, or usb_post_init), the function
returns the error without rearming the reset control. This leaks
the reference and leaves the reset control in a triggered state,
causing future reset_control_reset() calls to incorrectly return
early as if already reset.

Add an error path that calls reset_control_rearm() to balance
the reference before returning the error.

Cc: stable@vger.kernel.org
Fixes: 5b0ba0caaf3a ("usb: dwc3: meson-g12a: refactor usb init")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 55e144ba8cfc..4d611c08e8a4 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -907,35 +907,39 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-		return ret;
+		goto err_rearm;
 
 	/* Init PHYs */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_init(priv->phys[i]);
 		if (ret)
-			return ret;
+			goto err_rearm;
 	}
 
 	/* Set PHY Power */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_power_on(priv->phys[i]);
 		if (ret)
-			return ret;
+			goto err_rearm;
 	}
 
 	if (priv->vbus && priv->otg_phy_mode == PHY_MODE_USB_HOST) {
 		ret = regulator_enable(priv->vbus);
 		if (ret)
-			return ret;
+			goto err_rearm;
 	}
 
 	if (priv->drvdata->usb_post_init) {
 		ret = priv->drvdata->usb_post_init(priv);
 		if (ret)
-			return ret;
+			goto err_rearm;
 	}
 
 	return 0;
+
+err_rearm:
+	reset_control_rearm(priv->reset);
+	return ret;
 }
 
 static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
-- 
2.50.1 (Apple Git-155)

