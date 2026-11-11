Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368876;
	b=IDn/EMH+nbixboSj9CWXLvDO+/oymUbmZWQl1eqGiG76gLA/OZXASRTpm4oXd10VenaS
	 osAqXbr5JVOhxvGnwfVTuJTWxQX7udNqT/eww7aR1Y2hc3ZNaq/kv1ms98qkN86oZOMpI
	 9zwBJUbUwmEfyqL/quXeQ8noX7+PA78w6k5BXP+mvqq537QOmIE3TymWvosPhYXciTTF1
	 UZ7sC/wmj9JNpgUm9u1QELN8vMazyGdW5y8n2MuRwf6Fe2S/shYSpvP43IrTbUk3OoDZi
	 NhixIqhmXFmVKm5LWWLlQ9aQAdy9q6qL3bpY+bA8DmqB6bQBClxnTLihcC2aCJ94k3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bdd8KG9dLPLhNsavVbJ9EWX4QvvTw8de9KZ574raOvk=;
	b=fn65Qfwd0zi8TpEstB49d6mtH1yIvOUyceyYNuWONFdzfq0EymkKf7SGkUTCw/lDtxt1
	 +FTVe87Ixs9/js4AuVSUcevoDV83E0YfhW70DxoieI01KR3LSBWY1LCAUZECe6Ixrm2Z2
	 hq5jF2EKRpBkFcn3k39ZTvWVY5Dz2ZKLl9qrZNfNut+innHF19L1VfAeKJS/1Za/Cir9K
	 JDPsgERW5Yzt6H+gpPDfY2wW3JRldJ+clltygenA98EGdnUh6R5gc4MTuqRAdLQ6G8sPg
	 GbDXm/kNnZ4Sl0ZfUiENlTkm2esoX9AgkYWs9D2wVdzsQc42mEvBNvsntZohmumI7Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOBXT7gk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC54606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOBXT7gk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8F51F00A03;
	Wed, 11 Nov 2026 03:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368876;
	bh=bdd8KG9dLPLhNsavVbJ9EWX4QvvTw8de9KZ574raOvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IOBXT7gkBQpuYG4HicJxWV5r3Uf5iVSnHBPU2Obr5VqoU/ilvB4/wGVL0NenOUuZc
	 GrVIqt2kpe+0O4kOz5HKh8TE4ibJWlD973CXsHAEiVQGAgN0zOUul9qLQnzxyjckej
	 mGQbdWsvitXkVOJQoTzVxFkPlqAxVfIpH935rb+d+awHLN49dOZ0BnwlXhyxE7ynNC
	 5VdjQxyifg1DerFGxiSqya74lTU/CjETf3pr0NOQgCOkUOFB9trn4AX2e8e6n/G42s
	 hwaTBbu2to/cMjpatZH2WW+6JIQsZzOe9rRaxmkmJxhNvOpZpQDUtmoTajDzzBgZ0+
	 xQOX8DlPqIjBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henning Schild <henning.schild@siemens.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] leds: simatic-ipc-leds-gpio: Move two extra gpio pins into another table
Date: Tue, 10 Nov 2026 22:47:51 -0500
Message-ID: <20261111034412.921658-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034412.921658-1-sashal@kernel.org>
References: <20261107054744-failed-6.1-9523698252fd@kernel.org>
 <20261111034412.921658-1-sashal@kernel.org>
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

From: Henning Schild <henning.schild@siemens.com>

[ Upstream commit 799c0197aa5f732cefa8ca6285bd611b5cf45996 ]

There are two special pins needed to init the LEDs. We used to have them
at the end of the gpiod_lookup table to give to "leds-gpio". A cleaner
way is to have a dedicated table for the special pins.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230524124628.32295-3-henning.schild@siemens.com
Stable-dep-of: 9523698252fd ("platform/x86: simatic-ipc: fix platform device leak on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 28 ++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index 1a1cfdad62185..0f1fde44e8d99 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -16,6 +16,7 @@
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 
 static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
+static struct gpiod_lookup_table *simatic_ipc_led_gpio_table_extra;
 
 static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 	.dev_id = "leds-gpio",
@@ -26,6 +27,13 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
 		{} /* Terminating entry */
@@ -41,10 +49,17 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	},
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {
+	.dev_id = NULL, /* Filled during initialization */
+	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
 		{} /* Terminating entry */
-	}
+	},
 };
 
 static const struct gpio_led simatic_ipc_gpio_leds[] = {
@@ -66,6 +81,7 @@ static struct platform_device *simatic_leds_pdev;
 static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 {
 	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
+	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table_extra);
 	platform_device_unregister(simatic_leds_pdev);
 
 	return 0;
@@ -74,6 +90,7 @@ static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 {
 	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
 	struct gpio_desc *gpiod;
 	int err;
 
@@ -82,12 +99,14 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
 			return -ENODEV;
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
+		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_127e_extra;
 		break;
 	case SIMATIC_IPC_DEVICE_227G:
 		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
 			return -ENODEV;
 		request_module("gpio-f7188x");
 		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
+		simatic_ipc_led_gpio_table_extra = &simatic_ipc_led_gpio_table_227g_extra;
 		break;
 	default:
 		return -ENODEV;
@@ -103,8 +122,11 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	simatic_ipc_led_gpio_table_extra->dev_id = dev_name(dev);
+	gpiod_add_lookup_table(simatic_ipc_led_gpio_table_extra);
+
 	/* PM_BIOS_BOOT_N */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, GPIOD_OUT_LOW);
+	gpiod = gpiod_get_index(dev, NULL, 6, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		err = PTR_ERR(gpiod);
 		goto out;
@@ -112,7 +134,7 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 	gpiod_put(gpiod);
 
 	/* PM_WDT_OUT */
-	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, GPIOD_OUT_LOW);
+	gpiod = gpiod_get_index(dev, NULL, 7, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod)) {
 		err = PTR_ERR(gpiod);
 		goto out;
-- 
2.53.0

