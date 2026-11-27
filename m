Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788413;
	b=Bm5bO5Yi02/SLM2wvI4hDlDiiIcF3lFDLDF1NKPhvHMpdN/k8R7opf2+5Z2rDczI8cjy
	 DKkHkQdx5haURBDafSCOSxY8jAXYJ0OQ5RdeEKQSWnn7EInK3vJmplKUdTYkrYavZE4Kd
	 JHnvDuNgACYpa2HsEcG7xOb4oeaIC08kChlFgX4pEcwY+96EudPfHiMcO9l8NGzeMzxxH
	 TK0B23/X+7Cq+RscCc2ltM/nP7ZpZJPqvf/S/NG8nDKB6GF2xEvshcPVwktsm66/SIwNc
	 vEA9c4olSyb1kCydlJFLu485q0IMATeTMk1YtMDLYwqwWXv1r0WPK+0lS4jJu6TKL7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788413;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b3QBz+aegQrt01l7VTRnuNY+RfHIeGxGfCG2oZRvtFo=;
	b=ji3+pWgNf19dgG/Jzga9HIeXmJQw1J8f4+Xuvy11RUckFJJSImlGsli6AvYzLFWMZRBs
	 KtLvNONcdO3yfWk9G3w3+Ys/KkrD9MbuBelRRyIKuv0CjuIVABq8xAkeHSJ7XqslAk4Od
	 zmwxrmB1bJuM4ztH6TFvYajwpP+SBxDW8mSptNiM2hKBTiANILsy4tke+nHchEAZE8DPB
	 D4B1ui8+eeTM7/4KCi7nmiRG4k2LhvkocXDi2IbsNqRTO8OkBb3QsxGX50+G5nKIr5SBC
	 ViD0BFYYcMMEQDxSgjoqv2Q27m6tcQFp1HGzoTR4efqf45vU5Wj4+OGI4GBqmfb0apw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zj1i5W4Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD546606A337;
	Fri, 27 Nov 2026 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zj1i5W4Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0EB1F0089A;
	Fri, 27 Nov 2026 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788413;
	bh=b3QBz+aegQrt01l7VTRnuNY+RfHIeGxGfCG2oZRvtFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zj1i5W4Y/dg12S8AQc2m82FMuai8HTzI5EM5YkF4iXK16Zed7Dc0FvFT3lVmr/kwy
	 rCIDVlSwYdkoqPgH9u7tE0kAVJKZ2ScgPd/my7c7cYNYTbE7Y2jxk98bb9k11SHOLq
	 5yJbwgnP4vbOtA/i50Ki77MwBYoY9spM0u/8qLrUt9qlGT1he8jtXFW9MIFQriXXBn
	 +b2i/3DbF06X+2KY5LrShfKF9EtO31AqHe7ejWABjT+tvzZ7gsJBh2hMZ2zrHic2iT
	 +FOFHrnG+KY1wFX+40x9dRLcweAJ3Bg8n6Ggh4hcy3tmtvaMOj0Nbk0Nda4e6KfDpx
	 zveEyY4/IebSA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Linus Walleij <linusw@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	jordan_hargrave@dell.com,
	tomer.maimon@nuvoton.com,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 06/12] pinctrl: nuvoton: Unmap GPIO bank registers on error in NPCM7xx and NPCM8xx
Date: Fri, 27 Nov 2026 14:04:54 +0000
Message-ID: <20261127140602.2790001-7-lee@kernel.org>
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

npcm7xx_gpio_of() and npcm8xx_gpio_fw() map each GPIO bank's registers
via unmanaged fwnode_iomap() without unmapping them if a subsequent step
in the loop, pinctrl registration, or GPIO registration fails.

Register a devres action after each fwnode_iomap() call so the bank
mappings are released automatically on probe failure or device teardown.

Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
Fixes: acf4884a5717 ("pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-cf83b9c0-f3a2-4dc8-95a0-af6fafb6d092
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 13 +++++++++++++
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 2eb7782b90a6..08eb9aca36b8 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -7,6 +7,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/generic.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -1821,6 +1822,13 @@ static const struct pinctrl_desc npcm7xx_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
+static void npcm7xx_gpio_iounmap(void *data)
+{
+	struct npcm7xx_gpio *bank = data;
+
+	iounmap(bank->base);
+}
+
 static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 {
 	struct gpio_generic_chip_config config;
@@ -1835,6 +1843,11 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 		if (!pctrl->gpio_bank[id].base)
 			return -EINVAL;
 
+		ret = devm_add_action_or_reset(dev, npcm7xx_gpio_iounmap,
+					       &pctrl->gpio_bank[id]);
+		if (ret)
+			return ret;
+
 		config = (struct gpio_generic_chip_config) {
 			.dev = dev,
 			.sz = 4,
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index dc76ad9e58e6..40315e89b839 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -7,6 +7,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/generic.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -2453,6 +2454,13 @@ static int npcmgpio_add_pin_ranges(struct gpio_chip *chip)
 				      bank->chip.gc.ngpio);
 }
 
+static void npcm8xx_gpio_iounmap(void *data)
+{
+	struct npcm8xx_gpio *bank = data;
+
+	iounmap(bank->base);
+}
+
 static int npcm8xx_gpio_fw(struct npcm8xx_pinctrl *pctrl)
 {
 	struct gpio_generic_chip_config config;
@@ -2467,6 +2475,11 @@ static int npcm8xx_gpio_fw(struct npcm8xx_pinctrl *pctrl)
 		if (!pctrl->gpio_bank[id].base)
 			return dev_err_probe(dev, -ENXIO, "fwnode_iomap id %d failed\n", id);
 
+		ret = devm_add_action_or_reset(dev, npcm8xx_gpio_iounmap,
+					       &pctrl->gpio_bank[id]);
+		if (ret)
+			return ret;
+
 		config = (struct gpio_generic_chip_config) {
 			.dev = dev,
 			.sz = 4,
-- 
2.56.1.839.g22a8290db9-goog

