Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121426;
	b=PXQMVmSKUDXeDdWgQPu4JHDmgEMIbUkkqrV9A7Ma8rVJFlxxJSKu+OtWyfq0PQIe6l+I
	 gI6PrAa5q3I7cEWpdkqAoMplXw+sgihDoQK+yXTs3mw/7Yyvc3KtMRPCqNwCNgGue8Ja5
	 9LVQdgK/ONo+qmPWh1t+BtonZHoS2eS/3nZ1OkDNVJTxdCBbfEguk+2CrM9RdGjNJINOJ
	 D5OwzRZkSZNWbwkkIEk0311QoRYRzRjGa5xZFntGyaQJ9zFKPPrm03hAXU2MILbF2eyUj
	 K7fhlIvYaLQnoui/a+iLBVpeIsvasCTV0rED0oz/3ZuuVjjY2JrP97ZGYAzDkSB35GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121426;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4Jk6hEm+YwaQOhSSylQGgh8n3OtPN2XBtH7k3BqcGbw=;
	b=L8F3/9IxpYvTKmwQP8KIJyb3n1H5UWGSEVJMUWw3fdNXlNv1sTT5TbZC3ECYYWHJw1JJ
	 lVQpbPJ7fZXbTjs3/fLktXjS2gERB6+jpEmNSdUq1zRP/47Xrq5+r1hThZIhgkBJjNMAA
	 jGsrj6jp9g5/F0DT8QBK+rZ/dnO+5DN8/wc3GUJoY/mgfcAXrzCTFQ53Xlr5zW4y1t389
	 3Z5R/kMAXcCw7/Pbn3z/YsvA9TsE+SqPlFwxKUmNxO7eFPcz4LhmlqNpoOtlKO+Pzi2+q
	 yzd6oYe4fb31ZF1OJBmw/KUfn8bLVFATYDCmXu/TchGQph7ehzGyKvWcFym85SsY2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YipC8ORm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F93606A337;
	Thu, 19 Nov 2026 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YipC8ORm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB45F1F000C4;
	Thu, 19 Nov 2026 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121426;
	bh=4Jk6hEm+YwaQOhSSylQGgh8n3OtPN2XBtH7k3BqcGbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YipC8ORmiaVhQ3lZqCyI/Gc0wDEJ9FqegleCSV+edZuc55cYHYDXSUzhvGuhIpoIa
	 tmTUbmHuj6spwmLX4dCyjJqBQQS9DGpaB1PkgW6dcIjIJCIRWwWjlrJukUOpP3D3jX
	 odCN8xaR8n4+mToxLn6IF3E/4r+v7bny258OIgjZIuS9nwayPcxtudTILvdUYqBLMc
	 bR/QtCoDSry0WPTqCl80bByfwVwWUEN7npzD9TaUMnQ7zAz/ehD0GQ5hKu1IQyeb1U
	 adbu1fif+3sxeLeKCjpfk19lAdDhBinULdljcLncqrCfjocvWNpyqV9ItzYyyzusrV
	 AYZcxBYisUEvQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 01/12] pinctrl: nuvoton: ma35: Unmap reg_base and release clock on probe error
Date: Thu, 19 Nov 2026 20:48:57 +0000
Message-ID: <20261119205013.2563811-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
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

v1 => v2: Explicitly include the I/O mapping header for iounmap()

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 37 ++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index a79ebf4be2c3..bfa743db8b13 100644
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
@@ -555,6 +556,22 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
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
@@ -563,6 +580,10 @@ static int ma35_get_bank_data(struct ma35_pin_bank *bank)
 	if (!bank->reg_base)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(bank->dev, ma35_bank_iounmap, bank);
+	if (ret)
+		return ret;
+
 	bank->irq = fwnode_irq_get(bank->fwnode, 0);
 
 	bank->nr_pins = MA35_GPIO_PORT_MAX;
@@ -572,10 +593,12 @@ static int ma35_get_bank_data(struct ma35_pin_bank *bank)
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
@@ -583,7 +606,7 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
 	struct fwnode_handle *child;
 	struct ma35_pin_ctrl *ctrl;
 	struct ma35_pin_bank *bank;
-	int i, id = 0;
+	int i, id = 0, ret;
 
 	ctrl = pctl->ctrl;
 	ctrl->nr_banks = MA35_GPIO_BANK_MAX;
@@ -603,8 +626,12 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
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
2.56.1.750.gf70dc682cf-goog

