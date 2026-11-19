Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121463;
	b=FsSAzGMdN4Nfk6k5cTZpqfbBQu8PFHpvBUPeB8UTpS/LvZHP1y9iUEeHr/643yM/Cmus
	 jCliS3zkkBQfS1D+iMQERn5bXN6gP6Trd2g/K+auitOe3Qe31zmABxWg4Oz2chhH2fwRH
	 C7NQBUQlvDtUE06hnjRidA/zNQs0jk2iWiJDMD40mkkAJgbdPREYdJlKt1ejxx9YzTj6c
	 Na6X53moZo3092z16xQt4EvClUzCJzwK5K+AWJONbtLpwyA+Kq3UFaMKHU67Xr+iEompE
	 7Zqj+2p0tT63JCM/HrKLz3mvrlBT8POFJcdGgK+uBV18pKzZC5Xxa4JfiR0hHruSZYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121463;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QbWtql6O9dsdj+f3UeXCGE3TcRnLIlq5aJ6I7jKlL3M=;
	b=YrJzr0ZEjEgjFISSoCTgHrlsHOeIrN1A41Sfs9dxx03JsQLeC4OKLehXoUEg5muTw8xK
	 j7+uyPm3r4vg5HTtpxr8VC5ReobMvUiWevsC+L+Nnx3aF0cq2MruqBfjRjxGFqY0IX2kf
	 /kRcSwU7SLToHvcc2LY5HBdBg+DF1J8wDWw0rpW9TG+iHfesiIF+Ov5c3010I+DjouoLT
	 X/27DCmtKwIyekKTaYuKo004qDcPMx8GvTAlj9qmGDMY1bBZlH5UyXmb64pkX4nkKU4Ne
	 J/pVVU0VMkfbjWoe2keD/F2Ttv8rz1jVoCHfBpJtPiK0jlqbqCoc2kQc0FRgs+ET3WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAkjDaQP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60987606A901;
	Thu, 19 Nov 2026 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAkjDaQP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18AF1F000C0;
	Thu, 19 Nov 2026 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121463;
	bh=QbWtql6O9dsdj+f3UeXCGE3TcRnLIlq5aJ6I7jKlL3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WAkjDaQPOTsnED1UchGELVgVCOIDqr3ZIDidC9ZmEG8ZTE1E4V48d8iY5EdvfrdRB
	 AjERRbuPXYlrz4H94aRB5M63DaFajOFdkSW127wW4bTp7qmwSot7rn75SA6/Q38aVd
	 4kNCJ7owL7nXo65IUSpFR/MmNWQRDu+f6f3h65vpIpfh75MHWYVo8+Xq4ePiSKv5la
	 rs/BPd+23qE6ZQzLJMy06PfDNpP3hsPoXL7dwOKNrnFUMs9gjX1HD1kRhUm4rI4N6C
	 16u5uVAxE4p8HzmzQBMBs39haJCfZvQiyUEUY3CmwejK6CyQe3yzKp7Qv/hfgTYkDE
	 ywwSUWVhF2KCQ==
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
	jordan_hargrave@dell.com,
	tomer.maimon@nuvoton.com,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 06/12] pinctrl: nuvoton: Unmap GPIO bank registers on error in NPCM7xx and NPCM8xx
Date: Thu, 19 Nov 2026 20:49:02 +0000
Message-ID: <20261119205013.2563811-7-lee@kernel.org>
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

v1 => v2:
 - New patch, releasing fwnode_iomap() mappings via devres (Sashiko)

 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 13 +++++++++++++
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 3a80948ac70f..3e763a097b91 100644
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
index 690ba8473bcc..f300c3cd924a 100644
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
2.56.1.750.gf70dc682cf-goog

