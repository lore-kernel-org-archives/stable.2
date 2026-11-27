Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788376;
	b=GW7ZumckcF56YpA/XJTpF3kUT69BIjhxg5PLS3esI0KV6uxJdzKKqMbK0DVjpsRaYr+P
	 s5y3KrYvlzwewYq5EQEVH5FDn1gP8eM4WqAY92h6EordefoyvGCMK9S6TZQDI0Ua1l7tk
	 eJ/f5t9liDjvKQ2sxQhsy+UZY5Ln0Ic996nR4KjazoE9KdtTDvJHNsg6mcd5/n3Oztk12
	 uMsM6S+w5Td22jp010ODx5Z7gxOeoBBYb+smUYYWZc34zX+3Z06UHHVsGzyKyKUwxYpa4
	 zYWbUXTPNrT6cPJlMICNc6m9xPWBg+gKIifaQxMmHr/xNdCJjd32dhBmCWU0x+6iU/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788376;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5Zvdk3CdQxsP/RSVJbHVVKWhftM/yGouoDXH42tVofI=;
	b=Q02L3BHgKPikFefzJSBUo4lMwGNAWaep6e5mlfX7GjKuMgPGI9WihjdGbNUADyAg1KIv
	 zBzIr8FyzNiihP1bQrzSWZL8rGYkTV59MCsH76US3cl9LsxsiT5STuHOss/IPgfsiYz1i
	 ZMWA5ewXCH/XKhVw1oniEoFvt997otol/6ytoE8gfCJxsYLoBH2NtVh3GjzjvL6qosM6u
	 oY6r11H+Uh6tvQHpxG8ygeT3Y7WDiVq1vO1+4/TwWiWiM/RvIhFKjfcixj+Kp5V0hPRwG
	 2Te1eBqqrZ+Xy3tVJuzuwwQ2bBgcUUXmhc2h/+en6V4KkVAUjQ4+/3F0YgPS5EC1CXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLYx+yIQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D88606A324;
	Fri, 27 Nov 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLYx+yIQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E98C1F008A0;
	Fri, 27 Nov 2026 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788375;
	bh=5Zvdk3CdQxsP/RSVJbHVVKWhftM/yGouoDXH42tVofI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KLYx+yIQS4RZ8jtOMe6bGlK48BE1lNA7Fu7knRil0Q7TC3Lsb3SIPE0Tpas6NxLHn
	 bEbgD5V171ErYdbfnrX3Ji0pAXNIqBYXkuDtwSYsDm/mklsr1uu3vlMWBQsr6koBew
	 ui5MSbuJ7uhITvPICCnJ6x4h8KetesFXMKv27qgetB0hGmEfWNLXYHpXTWZIYTZdKD
	 QhLBrQ6iC/bJ+Xf7FI4oSNpQwALa5CMLI6kbTucdwoLRzNeW5oEFQ2Yuuj7i/u0Kox
	 l6yD2NOvRKhHN723JwP4jQNkS8vNalNg28xIeuDYFB7ovmgLgYkwNWoNaOUZomb0Pz
	 touF/VliKfFbA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 01/12] pinctrl: nuvoton: ma35: Unmap reg_base and release clock on probe error
Date: Fri, 27 Nov 2026 14:04:49 +0000
Message-ID: <20261127140602.2790001-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

ma35_get_bank_data() maps bank->reg_base via fwnode_iomap() and acquires
and enables bank->clk via of_clk_get() and clk_prepare_enable(), neither
of which is devres-managed.  If of_clk_get() or clk_prepare_enable()
fails, bank->reg_base is leaked, and ma35_pinctrl_get_soc_data() ignores
the error and continues probing with an uninitialised bank.

Register devm cleanup actions for bank->reg_base and bank->clk, and
propagate errors from ma35_get_bank_data() in
ma35_pinctrl_get_soc_data().

Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-2046e6c6-45d1-42d4-ae9f-27fac33b07e7
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 37 ++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index 564ec0aa4287..872769db244b 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -11,6 +11,7 @@
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
+#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -556,6 +557,22 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 	return 0;
 }
 
+static void ma35_bank_iounmap(void *data)
+{
+	struct ma35_pin_bank *bank = data;
+
+	iounmap(bank->reg_base);
+	bank->reg_base = NULL;
+}
+
+static void ma35_bank_clk_release(void *data)
+{
+	struct ma35_pin_bank *bank = data;
+
+	clk_disable_unprepare(bank->clk);
+	clk_put(bank->clk);
+}
+
 static int ma35_get_bank_data(struct ma35_pin_bank *bank)
 {
 	int ret;
@@ -564,6 +581,10 @@ static int ma35_get_bank_data(struct ma35_pin_bank *bank)
 	if (!bank->reg_base)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(bank->dev, ma35_bank_iounmap, bank);
+	if (ret)
+		return ret;
+
 	bank->irq = fwnode_irq_get(bank->fwnode, 0);
 
 	bank->nr_pins = MA35_GPIO_PORT_MAX;
@@ -573,10 +594,12 @@ static int ma35_get_bank_data(struct ma35_pin_bank *bank)
 		return PTR_ERR(bank->clk);
 
 	ret = clk_prepare_enable(bank->clk);
-	if (ret)
+	if (ret) {
 		clk_put(bank->clk);
+		return ret;
+	}
 
-	return ret;
+	return devm_add_action_or_reset(bank->dev, ma35_bank_clk_release, bank);
 }
 
 static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_device *pdev)
@@ -584,7 +607,7 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
 	struct fwnode_handle *child;
 	struct ma35_pin_ctrl *ctrl;
 	struct ma35_pin_bank *bank;
-	int i, id = 0;
+	int i, id = 0, ret;
 
 	ctrl = pctl->ctrl;
 	ctrl->nr_banks = MA35_GPIO_BANK_MAX;
@@ -604,8 +627,12 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
 		bank->fwnode = child;
 		bank->regmap = pctl->regmap;
 		bank->dev = &pdev->dev;
-		if (!ma35_get_bank_data(bank))
-			bank->valid = true;
+		ret = ma35_get_bank_data(bank);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+		bank->valid = true;
 		id++;
 	}
 	return 0;
-- 
2.56.1.839.g22a8290db9-goog

