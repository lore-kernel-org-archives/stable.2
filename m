Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433991;
	b=QmbZmC51UTw46+4FQpV97rdteUlB7T3yGqgFEVpK0q1NTM/p5OCJYIAKP+QDdaqsCEoY
	 evb/vXkWpj2aq9GVCMrDsUgmLUWPv4ZOAHTHnWuxew0oAi0np7MdMTDXHOQS+TZzoVB5D
	 aXOAuct8pCSs/fpfvbjnw2D96iXGpsEQ0KGyFdJO2CH5BmPDob0/qmrNg9m86ctqylPU+
	 YBPkprKoXRhYoqvi1jwOi4oQfgbGZOKiakklxC1hIXohStsh81F96xr6cWUcP61L50Fjl
	 OM530yBRP4yQ61mAfXs3vq2bY3mFIX9ctZMNmmh3K90MQDl0nxKtEekvLn1U+lV5tnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=if/+0+pFnNU6k0PCEw4KVoy6ZadNyLU8ILGbmz3mIQI=;
	b=nWwmOH6+gJ2F7W981OKJIDq4ShypOsMxCD4GqkLm0+piSxd8BE0LFYbf+m5yBJofQfmg
	 VCda0auXSlctXK+DX69Dyl1UPVl3olUnoN5XByAtfFiXvT6YRT2sHLUsfKssike/AN3TU
	 mQnaAujRV/8+8zPITlBcDhV3N6wWRV4P/DvAJpby+kACEmBw5mVrF6yHUs1oheB57vfWR
	 7Sm3DcFDQOsSCHgawY523o0o1a8gCYdb7RE9CM8089lPEQWNKXPeepwq/HftvNjl2ZAHX
	 ZyEcZ7p8pyv8X/3VZy/IaFibIzcmuS5tsN09QC+lsGW/O6CoCt01P9ygHzOcPqzKYhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCkLQYD2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D0606A33B;
	Wed, 11 Nov 2026 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCkLQYD2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEC01F00A06;
	Wed, 11 Nov 2026 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794433991;
	bh=if/+0+pFnNU6k0PCEw4KVoy6ZadNyLU8ILGbmz3mIQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TCkLQYD2wxm/SVXZdhDspHY9KM2fXi3kUefod6ZsVx1SMgHexvi502AKjsKY6llOF
	 a0hJSKD11kEG4/KLoG0Z0KmfL9p89gvFahAcV6h0QoQBKSpWKoErgaod5eQW4e0XXX
	 LbELG9NJkgnGwoGFswsKK5A22eixZlYfGh7CxzsJzGnXywv6fUSun0+mXUay1uZpUd
	 hkI6LUz9TUXrd+ahltkwvAr06dRlpXYz6ap1JE/AdlZWM4oSmbLadVcGzkvEvbXOWd
	 yVPdCxHGEhkx5Gac5Q7H5AGQDNQHCAZ3dJSohe5qxkg6RgHW6ZsQ4dnvWv/nBFFeOw
	 SmqcSUJ3ikpRg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] pinctrl: nuvoton: ma35: Unmap reg_base and release clock on probe error
Date: Wed, 11 Nov 2026 21:51:46 +0000
Message-ID: <20261111215256.1982044-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
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
propagate errors from ma35_get_bank_data() in ma35_pinctrl_get_soc_data().

Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-2046e6c6-45d1-42d4-ae9f-27fac33b07e7
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 36 ++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index a79ebf4be2c3..408927ab19da 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -555,6 +555,22 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
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
@@ -563,6 +579,10 @@ static int ma35_get_bank_data(struct ma35_pin_bank *bank)
 	if (!bank->reg_base)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(bank->dev, ma35_bank_iounmap, bank);
+	if (ret)
+		return ret;
+
 	bank->irq = fwnode_irq_get(bank->fwnode, 0);
 
 	bank->nr_pins = MA35_GPIO_PORT_MAX;
@@ -572,10 +592,12 @@ static int ma35_get_bank_data(struct ma35_pin_bank *bank)
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
@@ -583,7 +605,7 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
 	struct fwnode_handle *child;
 	struct ma35_pin_ctrl *ctrl;
 	struct ma35_pin_bank *bank;
-	int i, id = 0;
+	int i, id = 0, ret;
 
 	ctrl = pctl->ctrl;
 	ctrl->nr_banks = MA35_GPIO_BANK_MAX;
@@ -603,8 +625,12 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
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
2.56.0.567.gdb80ae8cd5-goog

