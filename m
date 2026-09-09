Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB9584974
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972295; cv=none; b=JEDOXnpHMkaK36a246asjRnpdnqok0lrU5N/5ENSsW0TyOuf6zNxT0QwvIKFs35K2ljE6IDQlc9LWXGA5gvm/DwUOA2br/14XhJxTZiIGESOiqqX96sG8TUvr1bpSeKOocCubzBSQU6cjUYFok1yI4oyNsdUmSOfblEPrcHNWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972295; c=relaxed/simple;
	bh=pS7ic5ek8Lg2WdUNYNRhYKt/TNqvEruXunN3d5+Ot3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byLURdpOErCmq/EP1Y8g3Wr7MqePXR9VcEIFGFDO2Cnsa0+9AYc8HXuUWfbrHuMwBxxz2wGxZ3igIQHGNGjoTZjhGcSTpHcPQx/1RiYV3C+oKzGODGe7Oni9vw3Pd9P6QWh/tvU6+Wmp9J2VT8ZVQjggpeoZMgtXFAg3BaFgFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAD7ngz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAD7ngz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5F61F000FF;
	Wed,  9 Sep 2026 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972293;
	bh=/y1EdMv5Lnq0HugeNmj6hI24cHt1wegSRJ9dP+YOi5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IAD7ngz5ge4DzLiWMAvZoQBpKhHB3zuFZxHSTZwosNt7umjxPkt5k7mVKgimQLQGm
	 Xe6wt5BBEpg4xFLRQjyIACLuF1EJ7AMn62/RzTnDKbaIWG0q9vA9oN8hM2EQRaYZDx
	 LlHXEvF7uscovO52mDyTF52G1vu5GgKDZsKGqzk+ThEADwr5iNPRcWR98SuJWXactj
	 EHUSNVSXVXc22oW9pKdlyzAwTvMgvG7bgRAm60Gv/8rci1w9KwtLkiGRKprEdd95a/
	 wM7/wHFGd7BSUhN1vMEgpZcPF+oBestnP0lV0VKFGeU20+Xj811spX7OzeGG1E6oAR
	 dddgZGXMi5u9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net: dsa: realtek: keep variant reference in realtek_priv
Date: Wed,  9 Sep 2026 12:44:48 -0400
Message-ID: <20260909164449.3071383-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-cucumber-busload-765a@gregkh>
References: <2026090350-cucumber-busload-765a@gregkh>
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
index 5a8fe707ca25e..aefb734e6f006 100644
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
index 1b447d96b9c46..c07c99bf1cd1e 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -46,7 +46,7 @@
 
 static inline void realtek_smi_clk_delay(struct realtek_priv *priv)
 {
-	ndelay(priv->clk_delay);
+	ndelay(priv->variant->clk_delay);
 }
 
 static void realtek_smi_start(struct realtek_priv *priv)
@@ -209,7 +209,7 @@ static int realtek_smi_read_reg(struct realtek_priv *priv, u32 addr, u32 *data)
 	realtek_smi_start(priv);
 
 	/* Send READ command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_read);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_read);
 	if (ret)
 		goto out;
 
@@ -250,7 +250,7 @@ static int realtek_smi_write_reg(struct realtek_priv *priv,
 	realtek_smi_start(priv);
 
 	/* Send WRITE command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_write);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_write);
 	if (ret)
 		goto out;
 
@@ -447,9 +447,7 @@ static int realtek_smi_probe(struct platform_device *pdev)
 
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

