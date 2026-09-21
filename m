Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112794A0139;
	Mon, 21 Sep 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999127; cv=none; b=C8cxNokcyMTDKcA4xhgeLyGtuWFUm0gTPcBH1FLS41KviZt0r9HcyGCwWKGc96Lxl3LcDwrcdvJsynX9V1qcQNsrvypxLjL+7pE/RsW5jyz6VAw7CwFwPpQ0qWWQr6gzkwtHZEnODN9EFWDJbrCX9xCNwC605rM6ayXUwy4/Fuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999127; c=relaxed/simple;
	bh=THpSRXzLzNF65kA5k6YgmRSnVbUWk8l6krfhI9QSfgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPoEecFkcfnrdZjUit3EMtlm1o0ij+1rYtCHrcXSvLBGdI1/DyNET/nTSsHSktbbfO6H+WlgTtmLNgjhLw9TE2NWmcwR87hozqtUrB/JPSSnhxSkN4KR9Q4gBlFvkd1KtRKe8O49XK6v4L3YtGfvdP9AiEPFyQ/xJJmnA7/gxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZJ4A9DHy; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZJ4A9DHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ez
	yjvcjHnU8bsyuDFh4e4QIqzX8lLzZewGB28BdVIsQ=; b=ZJ4A9DHyVWeOVgvWbX
	SQ9fRseiZitjjvZsJRy0vgOPvPYK4I4A2fSw7+Isykg0xhImtaQWk6orSkYK66wu
	PxNG9vEiBNQoqNSf6yBUF3YXTamAJDNvhfhfcrFh5fkANSSVg0y197cqefnaoe+Y
	WmsS7GG7L1lk796eI84fvtd94=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33wG+N7FqH9M7Bw--.62914S2;
	Mon, 21 Sep 2026 21:57:18 +0800 (CST)
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
Subject: [PATCH net v3 1/2] net: stmmac: ethtool: ignore inapplicable per-queue coalesce fields
Date: Mon, 21 Sep 2026 21:57:15 +0800
Message-Id: <20260921135716.218420-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33wG+N7FqH9M7Bw--.62914S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4DtFyxZF4Dury7Kry5twb_yoW7Jw47p3
	yUCFZavw1kJrW2yw1kAF40kFy5trs3tFZ7XFyxt34Fka1fCry5Xry5tryUKFnFkrWkZrWY
	gFWjq39ru398XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnmRUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqR8E2mqxN7-cjgAA3p

From: Linkui Xiao <xiaolinkui@kylinos.cn>

rx_queues_to_use and tx_queues_to_use are independent: dwmac-intel uses
6 RX and 4 TX channels on TGL and EHL, and snps,rx-queues-to-use and
snps,tx-queues-to-use are parsed separately, so a queue index can exist
in one direction only. include/linux/ethtool.h documents the parameters
of the missing side as inapplicable and asks set_per_queue_coalesce() to
ignore them, but __stmmac_set_coalesce() validates both directions for
every index while __stmmac_get_coalesce() reports the inapplicable ones
as zero.

ethtool implements --per-queue by reading the current settings of every
queue in the mask and sending them back with only the requested fields
overwritten, so the zeroed fields are fed straight back into the setter:

  - on an RX-only index the test for both TX fields being zero rejects
    the request, so per-queue RX coalescing cannot be changed at all;
  - on a TX-only index rx_coalesce_usecs is zero, stmmac_usec2riwt()
    returns zero and the MIN_DMA_RIWT test rejects the request, so
    per-queue TX coalescing cannot be changed at all.

On an RX-only index the TX test rejects the request after the RX block
has already called stmmac_rx_watchdog() and stored rx_riwt[] and
rx_coal_frames[], so the driver reports -EINVAL with the hardware half
reprogrammed.  The roll-back that ethtool_set_per_queue_coalesce() runs
for the queues it has already changed then trips over the same test and
cannot restore them.  On a TX-only index the rx_riwt range check fails
before anything is written, but the request is still rejected and the
TX settings are never stored.

Validate and apply only the side that the queue index actually has, and
move the TX checks in front of the RX block so that a request is either
applied completely or rejected without touching the device.

Fixes: db2f2842e6f5 ("net: stmmac: add per-queue TX & RX coalesce ethtool support")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v2:
- Trim the comment in front of the TX checks to one line; the reasoning
  belongs in the changelog. (Andrew Lunn)
- Link: https://lore.kernel.org/all/20260920015647.1783574-1-xiaolinkui@126.com/

Changes in v3:
- Only run the TX checks when the index carries a TX ring, and the rx_riwt
  range check only when it carries an RX ring. Moving the checks alone
  rejected per-queue RX coalescing on an RX-only index and broke the
  ethtool core rollback for it. (Sashiko review)
- Reword the subject and changelog to describe the direction-aware
  validation.

 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 35 +++++++++++++------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 154cc0c7623d..fed648a9f784 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -837,6 +837,8 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 	struct stmmac_priv *priv = netdev_priv(dev);
 	bool all_queues = false;
 	unsigned int rx_riwt;
+	bool has_rx;
+	bool has_tx;
 	u32 max_cnt;
 	u32 rx_cnt;
 	u32 tx_cnt;
@@ -850,7 +852,20 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 	else if (queue >= max_cnt)
 		return -EINVAL;
 
-	if (priv->use_riwt) {
+	has_rx = all_queues || queue < rx_cnt;
+	has_tx = all_queues || queue < tx_cnt;
+
+	/* An index can be RX-only or TX-only; ignore the missing side. */
+	if (has_tx &&
+	    ec->tx_coalesce_usecs == 0 && ec->tx_max_coalesced_frames == 0)
+		return -EINVAL;
+
+	if (has_tx &&
+	    (ec->tx_coalesce_usecs > STMMAC_MAX_COAL_TX_TICK ||
+	     ec->tx_max_coalesced_frames > STMMAC_TX_MAX_FRAMES))
+		return -EINVAL;
+
+	if (has_rx && priv->use_riwt) {
 		rx_riwt = stmmac_usec2riwt(ec->rx_coalesce_usecs, priv);
 
 		if ((rx_riwt > MAX_DMA_RIWT) || (rx_riwt < MIN_DMA_RIWT))
@@ -866,7 +881,7 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 				priv->rx_coal_frames[i] =
 					ec->rx_max_coalesced_frames;
 			}
-		} else if (queue < rx_cnt) {
+		} else {
 			priv->rx_riwt[queue] = rx_riwt;
 			stmmac_rx_watchdog(priv, priv->ioaddr,
 					   rx_riwt, queue);
@@ -875,14 +890,6 @@ static int __stmmac_set_coalesce(struct net_device *dev,
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
 
@@ -892,7 +899,7 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 			priv->tx_coal_timer[i] =
 				ec->tx_coalesce_usecs;
 		}
-	} else if (queue < tx_cnt) {
+	} else if (has_tx) {
 		priv->tx_coal_frames[queue] =
 			ec->tx_max_coalesced_frames;
 		priv->tx_coal_timer[queue] =
-- 
2.25.1

