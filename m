Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115E3A7F48
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240691; cv=none; b=jKNAsCXIYYAneOg7xjicYvh+Iv1GkvrUl41jFXEsXKf/JfwjJY1YOUZvlnIo4d1nw4+ZJPmcrUxCoc09PsA2FU2/wLqnmAwO4e9E4W9vbCI+vv55eZw1k+q3G5ICIjJSHH+VpVzzd8grM4Sy8krXIJmFN6MyHyKtcC90uxSxlSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240691; c=relaxed/simple;
	bh=uzymme1Pmsuxp7BPtK9dF4xWQnmxVdu2/CyD1JsN6xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3dnOm3g+oSrBQMCbOX4/WnH5k2+6MFUlR56HGeNpx9xFFdr3ULLig2zj94Tf2YKBjVStS1xramXAWN5NV7bwA30uSGYkFif5wtZPrAC6BdoOPxCQ5IFG4IAO/3hJfbaxTLb6ICeB7K/Do1KUCwjYFEmURq8u8qWXm/l+TaLP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTov5A5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTov5A5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9C11F00A3D;
	Tue, 28 Jul 2026 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240688;
	bh=tDA3SIv0bmeMotf/IEZRmFeA2ye0UgDANwHET8V7MWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mTov5A5tUhTYx30azd7rHrIEB4y+/5YQSJZ3/L6S+GVrx23B36zIO1/KYGWCFcpxg
	 r1eIcmv7iuP4YWzI3LNS2IbsaNh1gg3pVh+Alv9hZ+eUxeV2kcxdcfjaoXGsNp+XG7
	 /vlmODDi7KwOqe6FCqe3A7JT/C4c14ibHOfxrATUH731nAUARFqRsHHobtks7mXNra
	 zb+bgvCoYHhRHMDasUufYu052U8FhMDIxEx0njPvfAv5hvR54zAhJqGILLMHU8SlRp
	 kENa+pyaKKmT0UHjHqOyBE70hxKPL71W8llasvrJEEW7MDOsLlsHXV1W5vFIpDUwfa
	 xRbmrMi/tDGkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] gpio: tegra: do not call pinctrl for GPIO direction
Date: Tue, 28 Jul 2026 08:11:25 -0400
Message-ID: <20260728121125.3703669-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728121125.3703669-1-sashal@kernel.org>
References: <2026072047-produce-handgun-a695@gregkh>
 <20260728121125.3703669-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit d3e91a95b2b0fc6336dbf3ec90d831a1654d2720 ]

tegra_gpio_direction_input() and tegra_gpio_direction_output() already
program the GPIO controller direction registers directly. The additional
pinctrl_gpio_direction_input/output() calls do not add a Tegra pinctrl
operation, because the Tegra pinmux ops provide GPIO request/free
handling but no gpio_set_direction hook.

The extra call still enters the pinctrl core and takes pctldev->mutex.
Shared GPIO users can call the direction path while holding their
per-line spinlock, so this otherwise redundant pinctrl direction call can
sleep in an atomic context.

This was found by our static analysis tool and then confirmed by manual
review of tegra_gpio_probe(), the Tegra GPIO direction callbacks and the
Tegra pinctrl ops. The reviewed path has a default non-sleeping
struct gpio_chip while the direction callback still enters the pinctrl
mutex path.

A directed runtime validation kept the same non-sleeping chip registration
and drove:

  gpio_shared_proxy_direction_output()
  gpiod_direction_output_raw_commit()
  tegra_gpio_direction_output()
  pinctrl_gpio_direction_output()

Lockdep reported a sleep-in-atomic warning with the shared GPIO spinlock
held and pinctrl_get_device_gpio_range() plus tegra_gpio_direction_output()
on the stack.

Do not mark the whole chip as can_sleep to paper over this: can_sleep
describes whether get()/set() may sleep, and Tegra value access is MMIO.
Remove the redundant pinctrl direction calls and keep pinctrl involvement
in the existing request/free path.

Fixes: 11da90541283 ("gpio: tegra: Fix offset of pinctrl calls")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260619152439.1239561-1-runyu.xiao@seu.edu.cn
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-tegra.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 069ff5c33bd039..1846a2fb3b2eb6 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -174,18 +174,11 @@ static int tegra_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
-	int ret;
 
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 0);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_input(chip, offset);
-	if (ret < 0)
-		dev_err(tgi->dev,
-			"Failed to set pinctrl input direction of GPIO %d: %d",
-			 chip->base + offset, ret);
-
-	return ret;
+	return 0;
 }
 
 static int tegra_gpio_direction_output(struct gpio_chip *chip,
@@ -193,19 +186,12 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip,
 				       int value)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
-	int ret;
 
 	tegra_gpio_set(chip, offset, value);
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 1);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_output(chip, offset);
-	if (ret < 0)
-		dev_err(tgi->dev,
-			"Failed to set pinctrl output direction of GPIO %d: %d",
-			 chip->base + offset, ret);
-
-	return ret;
+	return 0;
 }
 
 static int tegra_gpio_get_direction(struct gpio_chip *chip,
-- 
2.53.0

