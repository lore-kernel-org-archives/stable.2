Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAD2D63E5
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775130; cv=none; b=tXa64kjdTKAOxcWNphOIqBktE6CkcPYK8L1fXWHT2qLv/pc5aZbe1pjGr80OrFyZ2xlv7prFl7oWLOzonRYHOP/g3RhMgsVyi3U2gxdRCFWNT31gZL+Sxrsw9CqZ0fldBbXUfCkeYEcv09YhTmSPr7nSHlJtd7H20JTCunFHCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775130; c=relaxed/simple;
	bh=yXhezKjx+yVwcCW5dSV5+wzQdX4affVXyHHOblT291E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RF9Z82saiIpPwZ9MxYEFKoxlP43n0BGxbOJFjjr2YBiZ2jHUI39SazN1VJN4lHtB/kp3P2Bub+3wYl+p5uBDM4R4YlS9Vckf3m2/HzdMKdfXHrHW6XfmRuo20H5yjo95hhJggld4IH2sDUVq9b42XfjftuSg1WRS3R7od7Xz/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=aTgDDw5t; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="aTgDDw5t"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ggwV80nyDzdD0;
	Thu, 18 Jun 2026 11:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
	s=20220412; t=1781775119;
	bh=afIfWS9qjU1M1kfgfbvSOJ4Gjss3OoSIyUxQqbcy0ow=;
	h=From:To:Cc:Subject:Date:From;
	b=aTgDDw5t6//RH1AMUvqKnMBCgHayW51WWLTsIFV27dLlz5s20wlA026e+sHPu6k2C
	 xMjGfOd5tkglpaL8awoGelbOdoQHNZhgc+hY3YzJ0RSzseiw6uZuC2998i62pbGzrB
	 f0QE/i0qSt6N4AAzKJwjPKYVcNQY//BUMhOyvIMw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ggwV662lLzjQb;
	Thu, 18 Jun 2026 11:31:58 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Philippe Schenker <philippe.schenker@impulsing.ch>,
	Simon Horman <horms@kernel.org>,
	danishanwar@ti.com,
	rogerq@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Carlier <devnexen@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Hao <haokexin@gmail.com>,
	Meghana Malladi <m-malladi@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ethernet: ti: icssg: guard PA stat lookups
Date: Thu, 18 Jun 2026 11:30:24 +0200
Message-ID: <20260618093037.3448858-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Philippe Schenker <philippe.schenker@impulsing.ch>

icssg_ndo_get_stats64() unconditionally calls emac_get_stat_by_name()
with FW PA stat names regardless of whether the PA stats block is
present on the hardware.  emac_get_stat_by_name() already guards the
PA stats lookup with `if (emac->prueth->pa_stats)`; when that pointer
is NULL the lookup falls through to netdev_err() and returns -EINVAL.
Because ndo_get_stats64 is polled regularly by the networking stack
this produces thousands of log entries of the form:

  icssg-prueth icssg1-eth end0: Invalid stats FW_RX_ERROR

A secondary consequence is that the int(-EINVAL) return value is
implicitly widened to a near-ULLONG_MAX unsigned value when accumulated
into the __u64 fields of rtnl_link_stats64, silently corrupting the
rx_errors, rx_dropped and tx_dropped counters reported by `ip -s link`.

Every other PA-aware code path in the driver is already guarded with
the same `if (emac->prueth->pa_stats)` check.  Apply the same guard
here.

Fixes: 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats")
Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
Reviewed-by: Simon Horman <horms@kernel.org>

Cc: danishanwar@ti.com
Cc: rogerq@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org

---

Changes in v2:
- Removed newline between Fixes tag and Signed-off-by
- Use return in if statement to guard so we get rid
  of the 80 char warnings.
- Added Simon's Reviewed-by. Thanks!

 drivers/net/ethernet/ti/icssg/icssg_common.c | 49 +++++++++++---------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4..d9af6419e032 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1628,28 +1628,35 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
 	stats->rx_over_errors = emac_get_stat_by_name(emac, "rx_over_errors");
 	stats->multicast      = emac_get_stat_by_name(emac, "rx_multicast_frames");
 
-	stats->rx_errors  = ndev->stats.rx_errors +
-			    emac_get_stat_by_name(emac, "FW_RX_ERROR") +
-			    emac_get_stat_by_name(emac, "FW_RX_EOF_SHORT_FRMERR") +
-			    emac_get_stat_by_name(emac, "FW_RX_B0_DROP_EARLY_EOF") +
-			    emac_get_stat_by_name(emac, "FW_RX_EXP_FRAG_Q_DROP") +
-			    emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN");
-	stats->rx_dropped = ndev->stats.rx_dropped +
-			    emac_get_stat_by_name(emac, "FW_DROPPED_PKT") +
-			    emac_get_stat_by_name(emac, "FW_INF_PORT_DISABLED") +
-			    emac_get_stat_by_name(emac, "FW_INF_SAV") +
-			    emac_get_stat_by_name(emac, "FW_INF_SA_DL") +
-			    emac_get_stat_by_name(emac, "FW_INF_PORT_BLOCKED") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
+	stats->rx_errors  = ndev->stats.rx_errors;
+	stats->rx_dropped = ndev->stats.rx_dropped;
 	stats->tx_errors  = ndev->stats.tx_errors;
-	stats->tx_dropped = ndev->stats.tx_dropped +
-			    emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
-			    emac_get_stat_by_name(emac, "FW_TX_DROPPED_PACKET") +
-			    emac_get_stat_by_name(emac, "FW_TX_TS_DROPPED_PACKET") +
-			    emac_get_stat_by_name(emac, "FW_TX_JUMBO_FRM_CUTOFF");
+	stats->tx_dropped = ndev->stats.tx_dropped;
+
+	if (!emac->prueth->pa_stats)
+		return;
+
+	stats->rx_errors  +=
+			emac_get_stat_by_name(emac, "FW_RX_ERROR") +
+			emac_get_stat_by_name(emac, "FW_RX_EOF_SHORT_FRMERR") +
+			emac_get_stat_by_name(emac, "FW_RX_B0_DROP_EARLY_EOF") +
+			emac_get_stat_by_name(emac, "FW_RX_EXP_FRAG_Q_DROP") +
+			emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN");
+	stats->rx_dropped +=
+			emac_get_stat_by_name(emac, "FW_DROPPED_PKT") +
+			emac_get_stat_by_name(emac, "FW_INF_PORT_DISABLED") +
+			emac_get_stat_by_name(emac, "FW_INF_SAV") +
+			emac_get_stat_by_name(emac, "FW_INF_SA_DL") +
+			emac_get_stat_by_name(emac, "FW_INF_PORT_BLOCKED") +
+			emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
+			emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
+			emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
+			emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
+	stats->tx_dropped +=
+			emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
+			emac_get_stat_by_name(emac, "FW_TX_DROPPED_PACKET") +
+			emac_get_stat_by_name(emac, "FW_TX_TS_DROPPED_PACKET") +
+			emac_get_stat_by_name(emac, "FW_TX_JUMBO_FRM_CUTOFF");
 }
 EXPORT_SYMBOL_GPL(icssg_ndo_get_stats64);
 
-- 
2.54.0

base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
branch: fix-icssg_common-pa-stats-errors__master-7-1
