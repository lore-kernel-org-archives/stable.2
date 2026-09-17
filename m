Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5B4E06C6;
	Thu, 17 Sep 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649781; cv=none; b=gm65gnK/oQ6SYux62DOvYFqnb4rqr31UIyE153zNFaHLjeZcqZ8ne8n5AxC1jWgHCh3zBcGVJXtd5ayCyJWaWBXb7cdVlT3bV8r9O20fdL3/0cVXH1vK3BhXsB5DZML3jDGbuJ58Fh37EsHzK1WUUMCqp2JBHQRUL/MnKR8Q3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649781; c=relaxed/simple;
	bh=lVvkric4bqsjm9teFQ57eswVhdVnbnIoi61jxqHHKt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDtqQsKM0Uku2S6BtmDsT+1Cm8f18+HbcdIYjX8pw+jgviO/2SmTNQIp0fKgYldzm7EXbKPUwKE0O89qU9HtE4Whw6U2MrLLzE3ZsNFWjKdXuRM3LcM+98out+B75suwGpLFVEFtGJBPxU9bw2z/88wc/xEQ3leR5bx+A96Vx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UpCd+nEF; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UpCd+nEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xj
	vrR6q3G+2JmmkCKiYy4LR76MiqgTrB4foZPd0p2Zg=; b=UpCd+nEFMsKK4Opo4v
	hfoPaKkZ2gCgDaMK1q704AZyxZV110Dc+WrViDOlgo5OrLSxt4hoMrCW8e7G9Jkm
	mbKPn8MoAGuPGuf+LTNjO4sYD+u9IZxTI5RIlulwxL9qY9NKoIW8FcOJhzUbZ4OW
	G7PzNXdJS/A4C0QFw94Ew309U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn_8Qj46tqab0kBg--.26898S2;
	Thu, 17 Sep 2026 20:54:59 +0800 (CST)
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
Subject: [PATCH net] net: stmmac: request the MDIO reset GPIO only once
Date: Thu, 17 Sep 2026 20:54:57 +0800
Message-Id: <20260917125457.1353718-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_8Qj46tqab0kBg--.26898S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW8XFyfWr1ruFWUCry8Zrb_yoWrJr45p3
	y7Zay5Ar1kJr4xXw4kJw48ZF98Aay3tr4UGw1I93yS9F4UtrWYvryaqFy5ZFy7KryUuFya
	qr4Uu3WDu3WvyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYiiDUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlQOGXWqr4yNcaQAA35

From: Linkui Xiao <xiaolinkui@kylinos.cn>

stmmac_mdio_reset() calls devm_gpiod_get_optional() every time it runs.
A GPIO line can only be requested once per consumer, so from the second
call on gpiod_request_commit() returns -EBUSY. devm_gpiod_get_optional()
only turns -ENOENT into NULL, hence the error is passed straight back
and stmmac_mdio_reset() bails out before pulsing "snps,reset" and before
running the STE101P MDC workaround.

The first call, made by mdiobus_register(), succeeds, so the failure is
only visible later on: every resume that does not use WoL goes through
stmmac_resume() -> stmmac_mdio_reset() and returns without resetting the
PHY. Boards needing a hard PHY reset after power down then come back
with a dead or badly negotiated link, and nothing reports it because
both callers ignore the return value.

The descriptor used to be cached in stmmac_mdio_bus_data::reset_gpio so
that it was requested exactly once. Commit ae26c1c6cb9b ("stmmac: fix
PHY reset during resume") relies on that cache to reuse the line on
every call. Dropping the cache removed the protection without replacing
it and reintroduced the very bug it had been fixed for.

Cache the descriptor in struct stmmac_priv instead and only look it up
while it is still unknown. It is devm-managed against the platform
device, so it stays valid for the whole lifetime of the driver.

Fixes: 7e770b252a62 ("net: stmmac: drop the reset GPIO from struct stmmac_mdio_bus_data")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 20 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

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
index afe98ff5bdcb..5f99d7db39f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -389,11 +389,21 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 		struct gpio_desc *reset_gpio;
 		u32 delays[3] = { 0, 0, 0 };
 
-		reset_gpio = devm_gpiod_get_optional(priv->device,
-						     "snps,reset",
-						     GPIOD_OUT_LOW);
-		if (IS_ERR(reset_gpio))
-			return PTR_ERR(reset_gpio);
+		/* Request the reset line only once and reuse the descriptor
+		 * afterwards. A second request of the very same line makes
+		 * gpiolib fail with -EBUSY, which devm_gpiod_get_optional()
+		 * passes through because it only filters out -ENOENT. The
+		 * reset would then abort early and leave the PHY un-reset.
+		 */
+		if (!priv->mdio_reset_gpio) {
+			priv->mdio_reset_gpio =
+				devm_gpiod_get_optional(priv->device,
+							"snps,reset",
+							GPIOD_OUT_LOW);
+			if (IS_ERR(priv->mdio_reset_gpio))
+				return PTR_ERR(priv->mdio_reset_gpio);
+		}
+		reset_gpio = priv->mdio_reset_gpio;
 
 		device_property_read_u32_array(priv->device,
 					       "snps,reset-delays-us",
-- 
2.25.1

