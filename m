Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15021D4606;
	Mon, 21 Sep 2026 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955918; cv=none; b=S5hn3wTQYrWQKDVcX28V+68iO8u+vwxuMPQGJhayn0nBAoanJaalTIfvkTIg5m4baTAppGmqpRnQ0YVt8B90W3xdzxTPkTca09BbxkPK/GyW1nNIIx5oSX2uT/Pajk3COenZytrxNkJfPcSpZ8FZmqyKck476ZZZGhFzdZuqLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955918; c=relaxed/simple;
	bh=0xZC6XpIVsQ2dS0wiqNwg6yx839FWSJ3i/hxlGabAPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b1CP8mnXny5/pCOdXhUlH4/WVgzxkKExQveGiPcgHwG0W7caJcfe7l65po0OiAfZBRPerfNJlK8HQhySMiIOgNsTLh/aUEODudVihyHcNvOEbiuZIsUQZDuUKbUtnHzcgvFyf/ge7o3wv+WGQWJVPRhB/GgaZYc4OIy3FcmGuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=A+zT8h0d; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="A+zT8h0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8d
	uZ0PDljIuHJwrD+tPi+wEqDcSEi5hndbcMRu3p6IU=; b=A+zT8h0dXjmMz7yDas
	+jpGIhsglw6kJ3r0qa//5H+xbahOU+sBfGATUInNERN5lApVa6GiSFtbyg6JK+Lm
	ffTnwtYeFSnVU7OdNP6+HQGzlRmsi3uGAgWAORlK8Pb3qSpL5N3kSk9gg0f6mClX
	MwUeZxCbSzE1Q0w8ReUXcjwEU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnH8wIj7BqSCOmBg--.28307S2;
	Mon, 21 Sep 2026 09:57:30 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	lorenzo.bianconi@oss.qualcomm.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: stmmac: request the MDIO reset GPIO only once
Date: Mon, 21 Sep 2026 09:57:27 +0800
Message-Id: <20260921015727.2643540-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnH8wIj7BqSCOmBg--.28307S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw1rXr15Zw45JF43Cr13twb_yoW7Kr1kp3
	y5Zay5JrykZr1xtw4kJw48ZF9Ykay3tr45Wa109rWSkw45trWYqr1ftry5XFy7trWDWa4a
	gw18CF1UuF4qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uo5lnUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQqsg2qwjwqHJQAA3x

From: Linkui Xiao <xiaolinkui@kylinos.cn>

stmmac_mdio_reset() calls devm_gpiod_get_optional() every time it runs.
A GPIO line can only be requested once, so from the second call on
gpiod_request_commit() returns -EBUSY. devm_gpiod_get_optional() only
turns -ENOENT into NULL, hence the error is passed straight back and
stmmac_mdio_reset() bails out before pulsing "snps,reset" and before
running the STE101P MDC workaround.

The first call, made by of_mdiobus_register(), succeeds, so the failure
is only visible later on: every resume that does not use WoL goes
through stmmac_resume() -> stmmac_mdio_reset(), and that caller ignores
the return value, so the PHY silently stays un-reset.

The descriptor used to be requested exactly once: stmmac_mdio_reset()
resolved "snps,reset-gpio" itself and cached the GPIO number in
stmmac_mdio_bus_data::reset_gpio, and commit ae26c1c6cb9b ("stmmac: fix
PHY reset during resume") relies on that cache to reuse the line on
every call. commit 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in
stmmac_mdio_reset") replaced it with a devm_gpiod_get_optional() that
caches nothing, so the request is repeated on every call and fails from
the second one on.

Parse the whole reset description, the GPIO and "snps,reset-delays-us",
in stmmac_mdio_register() at probe time, and keep it in struct
stmmac_priv. This is where devm-gpiod is meant to be used: the line is
acquired with the device and released with it, and any failure to
acquire it is reported during probe instead of being ignored by
stmmac_resume(). stmmac_mdio_reset() then only pulses the cached line,
with the delays that were read once and for all at probe time.

The request and the delays are still gated on
mdio_bus_data->needs_reset, which is the condition that installs the
reset callback, and on the device using DT. stmmac_mdio_reset()
itself no longer looks at the device tree at all: where the
description is absent the cached descriptor is NULL and the delays
are all zero, so the pulse is a no-op, just as the of_node check used
to make it.

Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v3:
- Read "snps,reset-delays-us" in stmmac_mdio_register() as well, so that
  the whole reset description is parsed in one place. (Lorenzo Bianconi)
- Drop the CONFIG_OF/of_node check from stmmac_mdio_reset(), which no
  longer needs it now that nothing is parsed there: the callback does not
  look at the device tree at all.

Changes in v2:
- Do not request the GPIO from stmmac_mdio_reset(); request it once in
  stmmac_mdio_register() at probe time instead. (Maxime Chevallier)

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 46 +++++++++----------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..2bb68e8b6274 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -25,6 +25,7 @@
 #include <net/xdp.h>
 #include <uapi/linux/bpf.h>
 
+struct gpio_desc;
 struct stmmac_pcs;
 
 struct stmmac_resources {
@@ -287,6 +288,8 @@ struct stmmac_priv {
 
 	unsigned int pause_time;
 	struct mii_bus *mii;
+	struct gpio_desc *mdio_reset_gpio;
+	u32 mdio_reset_delays[3];
 
 	struct stmmac_pcs *integrated_pcs;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index afe98ff5bdcb..cf768afd9237 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -384,33 +384,16 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	unsigned int mii_address = priv->hw->mii.addr;
 
-#ifdef CONFIG_OF
-	if (priv->device->of_node) {
-		struct gpio_desc *reset_gpio;
-		u32 delays[3] = { 0, 0, 0 };
+	if (priv->mdio_reset_delays[0])
+		msleep(DIV_ROUND_UP(priv->mdio_reset_delays[0], 1000));
 
-		reset_gpio = devm_gpiod_get_optional(priv->device,
-						     "snps,reset",
-						     GPIOD_OUT_LOW);
-		if (IS_ERR(reset_gpio))
-			return PTR_ERR(reset_gpio);
+	gpiod_set_value_cansleep(priv->mdio_reset_gpio, 1);
+	if (priv->mdio_reset_delays[1])
+		msleep(DIV_ROUND_UP(priv->mdio_reset_delays[1], 1000));
 
-		device_property_read_u32_array(priv->device,
-					       "snps,reset-delays-us",
-					       delays, ARRAY_SIZE(delays));
-
-		if (delays[0])
-			msleep(DIV_ROUND_UP(delays[0], 1000));
-
-		gpiod_set_value_cansleep(reset_gpio, 1);
-		if (delays[1])
-			msleep(DIV_ROUND_UP(delays[1], 1000));
-
-		gpiod_set_value_cansleep(reset_gpio, 0);
-		if (delays[2])
-			msleep(DIV_ROUND_UP(delays[2], 1000));
-	}
-#endif
+	gpiod_set_value_cansleep(priv->mdio_reset_gpio, 0);
+	if (priv->mdio_reset_delays[2])
+		msleep(DIV_ROUND_UP(priv->mdio_reset_delays[2], 1000));
 
 	/* This is a workaround for problems with the STE101P PHY.
 	 * It doesn't complete its reset until at least one clock cycle
@@ -608,6 +591,19 @@ int stmmac_mdio_register(struct net_device *ndev)
 	if (!mdio_bus_data)
 		return 0;
 
+	if (mdio_bus_data->needs_reset && dev_of_node(priv->device)) {
+		priv->mdio_reset_gpio =
+			devm_gpiod_get_optional(priv->device, "snps,reset",
+						GPIOD_OUT_LOW);
+		if (IS_ERR(priv->mdio_reset_gpio))
+			return PTR_ERR(priv->mdio_reset_gpio);
+
+		device_property_read_u32_array(priv->device,
+					       "snps,reset-delays-us",
+					       priv->mdio_reset_delays,
+					       ARRAY_SIZE(priv->mdio_reset_delays));
+	}
+
 	stmmac_mdio_bus_config(priv);
 
 	new_bus = mdiobus_alloc();
-- 
2.25.1

