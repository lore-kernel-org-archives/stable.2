Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A006136351;
	Sun, 20 Sep 2026 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789869491; cv=none; b=cNqzL55TXEP4IVmb5XFMBVu0ebs9nx4qLQYSYYtUHk7jNJopRF2zXXb3BLXiynFwuyULIv5JDc43WxYSedtUQYmpNQ2G5X1pR7W/qiFetRZqRmseSAZNz2J8NnpuljD9aGICtxLdtxYsXnbFPwZwRdHnJCJr0+T2L01ClpoVLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789869491; c=relaxed/simple;
	bh=RynWf+ycvz/614Z6i1qDdDyF+cF+xX0O8F9MXIoYKfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JbasvG7Xdw2gbnp0yLrGdCoiru/BW9+nb57LLDpCPWnW6T2N+t+zNXbsCE03xtDJ4jiOJdEo9L4DwmQacyYHQJyWft//sa++KTxJbZrth0KIt5b5Y2xqhNh3PTvtTNS981pUJ3akucrARgkvseQjRDcVoV2kh+Jyhv4YqFn5++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nftXmSBU; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nftXmSBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+v
	6Ogc6DkBmfW9b1qTeS9HFa7GSrGEaaQ+ja18fLYqY=; b=nftXmSBUbsQJP8qUu0
	oq37b/Dpis8u4uo2xudKpK4XhffAim0/Kk3uY9a1xP1wpKsuoX1a/tAdoTzO1tdm
	zP9R31lLUdT5VifsnozTqp8dX1RZvejJlFkvawQQ4CW+opB5SS9KRfh6UT+f2cIy
	kNO3TNNMJfv5SIy9wVz4GpZuI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3P_5hPa9qPX6OAA--.56399S2;
	Sun, 20 Sep 2026 09:56:50 +0800 (CST)
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
Subject: [PATCH net v2] net: stmmac: ethtool: validate TX coalesce before reprogramming RX
Date: Sun, 20 Sep 2026 09:56:47 +0800
Message-Id: <20260920015647.1783574-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgD3P_5hPa9qPX6OAA--.56399S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4xXrW7XFW8uF1rtrWrZrb_yoW5GF4Dp3
	yrGFZavryDtr43Jw1kJw48WFy5t397tFZxXw18Jasa9F4rGFWYqr1aqryrWFnFkrWxZrW3
	Kr4qv39rua98A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYzuZUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlALtxGqvPWKglAAA3R

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
v2:
- Trim the comment in front of the TX checks to one line; the reasoning
  belongs in the changelog. (Andrew Lunn)

 .../ethernet/stmicro/stmmac/stmmac_ethtool.c   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 154cc0c7623d..e06d05c3b4c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -850,6 +850,16 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 	else if (queue >= max_cnt)
 		return -EINVAL;
 
+	/* Check TX parameters before applying any RX setting */
+
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
 
@@ -875,14 +885,6 @@ static int __stmmac_set_coalesce(struct net_device *dev,
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

