Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B9479868;
	Thu, 17 Sep 2026 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650826; cv=none; b=loJPxZgSA7Ke1g9vUTqbn5Zje7/+uD2i3/bSfKgPSoyc/4mevz5NxFnTQGtdMhtvBjd3zB7cl4B1v1PWdOAlm2kUxokwsQV0l4UKzIko7HWBSoP2UY+8pwh71stvo83c+HSITGWGNm2olWiuXeEcnwui1FYEqIR99qLdhWHDgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650826; c=relaxed/simple;
	bh=AsIX/9dM1yA7XH5iU69igPdBuumeRN44Fa0t2k7vTjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dr3BI9WhuiXC4HPajYEJ2x+gCQfOfRLoksRgPdEeQcw7+d+G5w50Gj+vfhAA1V1zTkbn2TUUTWpdamz5GbqEbJX8USSN1uhW1McBeBn/x36XzEgEKUbnZ+PLGe/EXDvrR2A2+hAHPKFJqyBJWMeL6cCzYKbYzC/ewquLiUCMUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QpfbabbT; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QpfbabbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0K
	czUTT4pZjvn6++/hJJmxB3shK0qpHFg6zLRVauhpc=; b=QpfbabbTZkCwDzEnji
	P/YGDYIXN2PHrAgiAiifICcVq8iZQ9BQhbU62wexvvBsuAp19SfTzgsddgzyjcnU
	Plv5P7acDWSt/qMyUOXfn3FGFo7PU4qy1G+d/X+PHwbtLKIlZlNupp5WvWZR2x4p
	GbVMHykVRFKu6bV8TNr2m8SOo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3N1VF56tq0unFHw--.22915S2;
	Thu, 17 Sep 2026 21:12:39 +0800 (CST)
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
Subject: [PATCH net] net: stmmac: ethtool: validate TX coalesce before reprogramming RX
Date: Thu, 17 Sep 2026 21:12:35 +0800
Message-Id: <20260917131235.1360959-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3N1VF56tq0unFHw--.22915S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4xXrW7XFW8uF1rtrWrZrb_yoW5XryDpr
	WkGFZavryDJr43Jw1DJw48uFy5t397tFZxX348J34fuF45GFyFqr1aqryrWFnFkrWxZrWa
	gr4qva4Dua98A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYzuZUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlQeQZ2qr50eIyQAA3F

From: Linkui Xiao <xiaolinkui@kylinos.cn>

__stmmac_set_coalesce() applies the RX part of the request first and
only afterwards checks the TX parameters. The RX path already calls
stmmac_rx_watchdog() and stores rx_riwt[] and rx_coal_frames[], so when
the TX check rejects the request the driver returns -EINVAL after having
silently changed the hardware. A following ethtool -c then reports the
new RX values even though the command failed.

This became easy to hit once the per-queue interface was added.
__stmmac_get_coalesce() reports tx-usecs and tx-frames as 0 for a queue
index that is RX-only, and ethtool applies per-queue coalesce by reading
the current values first and sending them straight back. The next set is
therefore guaranteed to trip the test for both TX fields being zero,
right after the RX watchdog has been reprogrammed.

Move both TX checks in front of the RX block so a request is either
applied completely or rejected without touching the device.

Fixes: db2f2842e6f5 ("net: stmmac: add per-queue TX & RX coalesce ethtool support")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 154cc0c7623d..325db062f72a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -850,6 +850,19 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 	else if (queue >= max_cnt)
 		return -EINVAL;
 
+	/* Check the TX parameters before anything is applied: the RX part
+	 * below already writes to the hardware, so rejecting the request
+	 * afterwards would leave the device with only half of the settings
+	 * the caller asked for while reporting a failure.
+	 */
+	if (ec->tx_coalesce_usecs == 0 &&
+	    ec->tx_max_coalesced_frames == 0)
+		return -EINVAL;
+
+	if (ec->tx_coalesce_usecs > STMMAC_MAX_COAL_TX_TICK ||
+	    ec->tx_max_coalesced_frames > STMMAC_TX_MAX_FRAMES)
+		return -EINVAL;
+
 	if (priv->use_riwt) {
 		rx_riwt = stmmac_usec2riwt(ec->rx_coalesce_usecs, priv);
 
@@ -875,14 +888,6 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 		}
 	}
 
-	if ((ec->tx_coalesce_usecs == 0) &&
-	    (ec->tx_max_coalesced_frames == 0))
-		return -EINVAL;
-
-	if ((ec->tx_coalesce_usecs > STMMAC_MAX_COAL_TX_TICK) ||
-	    (ec->tx_max_coalesced_frames > STMMAC_TX_MAX_FRAMES))
-		return -EINVAL;
-
 	if (all_queues) {
 		int i;
 
-- 
2.25.1

