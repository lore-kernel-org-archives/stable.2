Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319411;
	b=Ash3Xvvm/YXOSCTRrmFscJUjr6kaOCDjpT0UXstS20NABziNdJKI0RWoHNv6wtEMnW6Y
	 t5/g2r5D8wcxoPsmdzt2vEvPF4210RlTa75DJSBCrCpxVTyoCgXldaQPGoHDg4do0XWO6
	 Rsq/hzzbAzRVTnb5tVh9yHcN1nvBU0ozcwrDTCdc4K3u5vdqf923PMrac1JdZyIg+1xIn
	 ptJ3KeujYA7LRFtZERzW4CTeGM1AGIr18yxB4tl29xoDGJrNHzmDOxSoFQw8vSxf6gXbg
	 EfWtNPuZGlod5gdXmXAVqYkR08xfh1eizLhgXJEOidlznjJOvv+9oxbjr14JvAzJCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319411;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=39v0VkCJkQRJ2oDdZ+hc7Y0HH0dqGcznsK5ROwhlA0w=;
	b=1zW1GqiwMsNJ8WSTpsTsFmrkQW79TrHnBNo2mrj3TaWuX+CGlwCHGVL2pAGVR6WPqZLb
	 xUGdDyx5d6qYBm0Z/u9dBJfykhAo954OnBDntF4g3e3OMyibvYT/i2ybPK7uQC6yqgTw8
	 o5aTj43D4THwxzLGIAZ5mmq9KA7CLhefLmfVDe4P3i6ivqa54Od4Fy/SpjoPIPNzygZjj
	 LerZsHogvtBYBSBbanQ9Fglb7kc5BGJEJY2uir6Dc/eNScKamT6tO6q1MiAWs/ZVSA9Ar
	 1MpUVEsKkpb7ow9OIZX01d6I2qHdjL1VUekHjufXFnNhel1SQYpprE4ctrBudB/EOuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1T9f4rl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E57606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1T9f4rl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D251F0089F;
	Tue, 10 Nov 2026 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319410;
	bh=39v0VkCJkQRJ2oDdZ+hc7Y0HH0dqGcznsK5ROwhlA0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1T9f4rlGMTmjLGqjfn5PXe9DmP4CkWZ4we8YoVR4IUWpl2i9LVNasfGr27VYnLG2
	 kFO3j9mXHqCeqE4x8eVGGHV+fX3BANKBDVT8rMimAHrX3XfdTjZuuQC3FtcS4Ve7ao
	 LgGLspfynfv1uTfKR9OG1HbBrvEFBOlkgWcOIDeE+WzGPgk/Raabxjvn4BveSXAN0A
	 udROAq9R9Ld5ePSiVPtsbcE0PsX2GE+mLlwM3QHiBgOTboIUvBWEOWps0npIxIwx58
	 LcMLj2MiOLUazMNT7LR417P+ollimScX5hsziMKMPY6bL/1ACGrTbhrUoFr6UyyYde
	 3fdL3C0YY22mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
	Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mfd: wcd934x: Replace legacy gpio interface for gpiod
Date: Tue, 10 Nov 2026 09:03:27 -0500
Message-ID: <20261110140322.1823724-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060004-failed-5.15-b296be1dc008@kernel.org>
References: <20261107060004-failed-5.15-b296be1dc008@kernel.org>
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

From: Maíra Canal <maira.canal@usp.br>

[ Upstream commit 6a0ee2a61a31cae2ea0a86a4401d6a70a0be3be4 ]

Considering the current transition of the GPIO subsystem, remove all
dependencies of the legacy GPIO interface (linux/gpio.h and linux
/of_gpio.h) and replace it with the descriptor-based GPIO approach.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/YXDEBCiSnXYRQPXt@fedora
Stable-dep-of: b296be1dc008 ("mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/wcd934x.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 91584d408c7a1..ac84d45a31ef9 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -2,14 +2,13 @@
 // Copyright (c) 2019, Linaro Limited
 
 #include <linux/clk.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/wcd934x/registers.h>
 #include <linux/mfd/wcd934x/wcd934x.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
@@ -210,7 +209,8 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct wcd934x_ddata *ddata;
-	int reset_gpio, ret;
+	struct gpio_desc *reset_gpio;
+	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -221,13 +221,6 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 		return dev_err_probe(dev, ddata->irq,
 				     "Failed to get IRQ\n");
 
-	reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
-	if (reset_gpio < 0) {
-		dev_err(dev, "Failed to get reset gpio: err = %d\n",
-			reset_gpio);
-		return reset_gpio;
-	}
-
 	ddata->extclk = devm_clk_get(dev, "extclk");
 	if (IS_ERR(ddata->extclk)) {
 		dev_err(dev, "Failed to get extclk");
@@ -258,9 +251,13 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	 * SYS_RST_N shouldn't be pulled high during this time
 	 */
 	usleep_range(600, 650);
-	gpio_direction_output(reset_gpio, 0);
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				"Failed to get reset gpio: err = %ld\n", PTR_ERR(reset_gpio));
+	}
 	msleep(20);
-	gpio_set_value(reset_gpio, 1);
+	gpiod_set_value(reset_gpio, 1);
 	msleep(20);
 
 	ddata->dev = dev;
-- 
2.53.0

