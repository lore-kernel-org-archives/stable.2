Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4EA356748;
	Sun, 20 Sep 2026 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789883310; cv=none; b=G9tYGBOgdifqzrwzroGKMDWk9esvB106URLIznkJeZykeQu//KtSuWBJGwSo80zB+6yti3ljvRscSJgjQLcCLLczFov8SFXRwvUs26EC+a7LtV/9e5y8rKpLwK51StHx/oMbVQwsb/f2QQQdC+e4Eo1x+ofP+f46raghGF/k+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789883310; c=relaxed/simple;
	bh=hXcXwB5qKvjy4yfU3TBUAP1GYhCqF9sbdZbOkL4gKUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oMGWxDOWaVhE+zDb38qJUnZM4QlFu4azhzqHF/zLcoJxVKhgdC8mcYwCMNEos5n5RP+NbsymefA80E0xh+IESDRSgNaT2BS99uYdhS3Rc0ydPdcGuJnhjqLCGLGFJDkJw4xyQAFxzYhPrfvpw6vMLovffQnsAqgRDKM5rhwTHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nkKW5prF; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nkKW5prF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z3
	+Fx9EZEE+VQ2/YVvwLsbnZUCmzfjGk9Iv40ZT2s+o=; b=nkKW5prFP4eZ4hKYBY
	OxqKTBzPbriILyLcLBPOsdnB3Ael6YuXSjDjjBhMGTQlGyamj2wJlgdl481EDZ5J
	uUqImrus8zyMQ9F94kRV2/faxn/ofvEoey4MsTWwbFr+y3VvciDZLZ/32auEQnDC
	1DfHJp5ph9NBsXkmDGea0TGtY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3v_VZc69qjRGcAA--.48413S2;
	Sun, 20 Sep 2026 13:47:05 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: request the MDIO reset GPIO only once
Date: Sun, 20 Sep 2026 13:47:03 +0800
Message-Id: <20260920054703.1897755-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD3v_VZc69qjRGcAA--.48413S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWxKrWUKFW7Jr48Gw17ZFb_yoWruw4Up3
	y3Zay5ArykJr4xtw4kJw48ZF9Ykay3tr4Uuw109rWS9a1DKrWavr1Sqry5ZFy7KrWDWFya
	qr18uF1Uua1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYiiDUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRl5UGqvc1kKygAA32

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

Request the GPIO in stmmac_mdio_register(), at probe time, and keep the
descriptor in struct stmmac_priv. This is where devm-gpiod is meant to be
used: the line is acquired with the device and released with it, and any
failure to acquire it is reported during probe instead of being ignored
by stmmac_resume(). stmmac_mdio_reset() then only pulses the cached line.

The request is still gated on mdio_bus_data->needs_reset, which is the
condition that installs the reset callback, and on the device using DT,
as the reset itself is.

Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v2:
- Do not request the GPIO from stmmac_mdio_reset(); request it once in
  stmmac_mdio_register() at probe time instead. (Maxime Chevallier)

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..986fb43db45f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -25,6 +25,7 @@
 #include <net/xdp.h>
 #include <uapi/linux/bpf.h>
 
+struct gpio_desc;
 struct stmmac_pcs;
 
 struct stmmac_resources {
@@ -287,6 +288,7 @@ struct stmmac_priv {
 
 	unsigned int pause_time;
 	struct mii_bus *mii;
+	struct gpio_desc *mdio_reset_gpio;
 
 	struct stmmac_pcs *integrated_pcs;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index afe98ff5bdcb..346f93f86abe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -386,15 +386,8 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 
 #ifdef CONFIG_OF
 	if (priv->device->of_node) {
-		struct gpio_desc *reset_gpio;
 		u32 delays[3] = { 0, 0, 0 };
 
-		reset_gpio = devm_gpiod_get_optional(priv->device,
-						     "snps,reset",
-						     GPIOD_OUT_LOW);
-		if (IS_ERR(reset_gpio))
-			return PTR_ERR(reset_gpio);
-
 		device_property_read_u32_array(priv->device,
 					       "snps,reset-delays-us",
 					       delays, ARRAY_SIZE(delays));
@@ -402,11 +395,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 		if (delays[0])
 			msleep(DIV_ROUND_UP(delays[0], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 1);
+		gpiod_set_value_cansleep(priv->mdio_reset_gpio, 1);
 		if (delays[1])
 			msleep(DIV_ROUND_UP(delays[1], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 0);
+		gpiod_set_value_cansleep(priv->mdio_reset_gpio, 0);
 		if (delays[2])
 			msleep(DIV_ROUND_UP(delays[2], 1000));
 	}
@@ -608,6 +601,14 @@ int stmmac_mdio_register(struct net_device *ndev)
 	if (!mdio_bus_data)
 		return 0;
 
+	if (mdio_bus_data->needs_reset && dev_of_node(priv->device)) {
+		priv->mdio_reset_gpio =
+			devm_gpiod_get_optional(priv->device, "snps,reset",
+						GPIOD_OUT_LOW);
+		if (IS_ERR(priv->mdio_reset_gpio))
+			return PTR_ERR(priv->mdio_reset_gpio);
+	}
+
 	stmmac_mdio_bus_config(priv);
 
 	new_bus = mdiobus_alloc();
-- 
2.25.1

