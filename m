Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2905057ED98
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971254; cv=none; b=uReKGqEYX3+0vk1OfqIagSORL6b86Kr3NKNiMx4gG8YjOmNa8LpLMPktVGx8m/TDxF6UnltCRERg6l05BCYurI4nHiX9f8+d/nZV7rY8dloMEiFDPCfxdqNA1ONC7PGstvyG+LHWgsdANNk0eZGE+F4D0LAhdtlc2vFCbCeVorc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971254; c=relaxed/simple;
	bh=veu+BI5Ueoz6s4BwiKh2E1GQ5AfL3XReM26QNY4MQbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jE3y8j27Ds2rOVkxaQ6ZB8hJYaCKOpNrtupL364OHpAb94mRcFcSUMnlUE2d5UJdioUxhF7Fy3ADhBGTiuUwoO31mnUsdO7FcUVSOhX8A3tCE9SyWbosbtsm4vHq2F0hdmhf33g0DlU2dM9Z0SyZPqwVGfYaLstFCNiZkvrLEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/fnthoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/fnthoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412B01F00893;
	Wed,  9 Sep 2026 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971253;
	bh=CrEQm4JY0e58aSJFObvWTHnqKd7tjpKVQp+YKvjE6v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/fnthoOSDLT2D3wD6tHTa+8W6NZCw8tP0XW6bSbmi9IP90MG3TpIzCkBpHFjmkDh
	 N2qMo+XQ24MpgUu3/B7Nakn0QjfDHVnfKOzccmkM0TLK5vfRvZNVt/QLp9GP/rNGzO
	 80Ntw959eQJXrsFcq0aGXYFsXeMi01VbLxoy6DcDJymn6E6Lg4fW0b6EW5i+j1Av9O
	 l61yjKhKXiM7On53ks6whAR9VuuBXN4JH+NdWFoUgPDm1EbCurZoDfLSpNlS5bSuh0
	 WxAwoJXkeVi886jFBgA3ldf/O9H5GOLWReRmIkrlQGDNe7uMoIUXohdNtulh3wWh89
	 eS8ZD9Jo+9FiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net: dsa: realtek: keep variant reference in realtek_priv
Date: Wed,  9 Sep 2026 12:27:28 -0400
Message-ID: <20260909162729.2986277-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090349-lake-barista-93d3@gregkh>
References: <2026090349-lake-barista-93d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Angelo Daros de Luca <luizluca@gmail.com>

[ Upstream commit 4667a1db2f550d23e01ba655fce331196ead6e92 ]

Instead of copying values from the variant, we can keep a reference in
realtek_priv.

This is a preliminary change for sharing code betwen interfaces. It will
allow to move most of the probe into a common module while still allow
code specific to each interface to read variant fields.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: fb58b6a696b3 ("net: dsa: realtek: use gpiod_set_value_cansleep for reset GPIO")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  4 +---
 drivers/net/dsa/realtek/realtek-smi.c  | 10 ++++------
 drivers/net/dsa/realtek/realtek.h      |  5 ++---
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b9..a0ba3fc4dc7c8 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -183,9 +183,7 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 	priv->dev = &mdiodev->dev;
 	priv->chip_data = (void *)priv + sizeof(*priv);
 
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
+	priv->variant = var;
 	priv->ops = var->ops;
 
 	priv->write_reg_noack = realtek_mdio_write;
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index ff13563059c50..52c0f5b6de90f 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -45,7 +45,7 @@
 
 static inline void realtek_smi_clk_delay(struct realtek_priv *priv)
 {
-	ndelay(priv->clk_delay);
+	ndelay(priv->variant->clk_delay);
 }
 
 static void realtek_smi_start(struct realtek_priv *priv)
@@ -208,7 +208,7 @@ static int realtek_smi_read_reg(struct realtek_priv *priv, u32 addr, u32 *data)
 	realtek_smi_start(priv);
 
 	/* Send READ command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_read);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_read);
 	if (ret)
 		goto out;
 
@@ -249,7 +249,7 @@ static int realtek_smi_write_reg(struct realtek_priv *priv,
 	realtek_smi_start(priv);
 
 	/* Send WRITE command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_write);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_write);
 	if (ret)
 		goto out;
 
@@ -446,9 +446,7 @@ static int realtek_smi_probe(struct platform_device *pdev)
 
 	/* Link forward and backward */
 	priv->dev = dev;
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
+	priv->variant = var;
 	priv->ops = var->ops;
 
 	priv->setup_interface = realtek_smi_setup_mdio;
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 4fa7c6ba874a5..0cf66b97c0e64 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -58,9 +58,8 @@ struct realtek_priv {
 	struct mii_bus		*bus;
 	int			mdio_addr;
 
-	unsigned int		clk_delay;
-	u8			cmd_read;
-	u8			cmd_write;
+	const struct realtek_variant *variant;
+
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
 	struct irq_domain	*irqdomain;
-- 
2.53.0

