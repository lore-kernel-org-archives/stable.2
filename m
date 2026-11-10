Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319909;
	b=qasuwUe/tiMy9IS5F+WL+9VG1sAMChepj5N4UMAydDSlJnSMHb6+lLPI8m4ns5w5GvSQ
	 kwdWBjcHkvjjXrfDTT0z/3U6hDgY3grXN2uz4s4K3NztXRvD3ndG+iKn7xQPAFnoH00Lp
	 uFUnlWwXy61FQnt2/MuMb0wz7H8d9eD2cPvXCa7X6bl5p1UrjIPImmhro/ioXWjZC4Ttp
	 4e1bb+fEPLFmhigPuixKcnZMSbAt/RZCT/k8PDVFLl/7um023XhJbEbYF7B2vJbeTUq6x
	 qVOQfR8d/iR/7o15Mp+4B+1Ch/Np4+LyzA+l204MOl+9yVs+LyICi5KXGasjcz7uHGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YMeeK3UljxNCCCbQRdJnFJr6NZgQrKqshNVKy7fLC+Q=;
	b=WvCHfw3pxa2g1UJZUvs/NvPmrnxBaRAihC/nrqSDdtC0RfN3WWGR+X+AFuv8z0EeIUsK
	 kPeE6AVk3LxlS75zNlZ2ECN+cl7vYmvTjvFsLBMazRN6ocZEYHdGvUynT2zg57IVBwcgn
	 qf4Ek4FgqHYTYX6u28LEAYxkCAnsCMwFSmb246AdzrFk/eIs/D8UnSjRtO4Yq7cJZ0XhT
	 YbH2UcSgOBNjsMajsztBLvQVbXTAVpeVzOp5ctS0V26DLdasTUZZFabFV82Apv9ioz4UT
	 UelBykq+/MP2OtHUJdDJSyGRxEwYUk3/yEOSgHgVrdC5QuZp7qt2YTAT5TBV6bQYkmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Loh2Azhv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FC606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Loh2Azhv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0181F0089F;
	Tue, 10 Nov 2026 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319908;
	bh=YMeeK3UljxNCCCbQRdJnFJr6NZgQrKqshNVKy7fLC+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Loh2AzhvhPWGc8eddZG4dGVcdpPQuNo6KWJtFWhyg6zS+98Tkq/DDJnzNTm/IRgcM
	 bLjzinWvgJdXeTEk1lcS5FOxS9sOYyiOc1Kcdu/UPlhoyid7Wc9eZqN7EmGoVrRHoe
	 Mm4OmXeV8aZ589Ehey+PIv44biO1s2eNpEKp1eucJmjdKDbjRniTcAxv+3FeNTfW71
	 XoPLd3fDb5pwW/UchewPCAtoI1eV2pgyBlt2JMybz6iNyr1X+3tjvoqDZz1pb3haMw
	 uQ6avQjYZW0SulFe5EpC2cXP8Yfoafs1w20puwy0kFmvhkQqEyuuN81K0grFwzQ/Kh
	 C1Re+/gAteYBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
	Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mfd: wcd934x: Replace legacy gpio interface for gpiod
Date: Tue, 10 Nov 2026 09:11:44 -0500
Message-ID: <20261110141054.1839848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061653-failed-5.10-b296be1dc008@kernel.org>
References: <20261107061653-failed-5.10-b296be1dc008@kernel.org>
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
index bb889a1cd9423..d725e7fca392b 100644
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
@@ -212,7 +211,8 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct wcd934x_ddata *ddata;
-	int reset_gpio, ret;
+	struct gpio_desc *reset_gpio;
+	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -223,13 +223,6 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
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
@@ -260,9 +253,13 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
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

