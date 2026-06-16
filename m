Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4136F8F5
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620695; cv=none; b=DtPbSk0iDTQbdxzNmhzUBLl64j60MZFjHPOEbGJb/w2vhQaj9q8li11l2jxxkraC/fRUXK5Z4uMlG5bdVnRWqrY5vjMTBf2J5bIJtgTcl8zKnEIGQx5YgIWqOpo9uDFRwq7Thn5eG21PNcJgonOzHchhCr2GGB7vNKppdWlcnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620695; c=relaxed/simple;
	bh=G6WeaxFC7coc3mi7da2c15aCmzkL6y9OaDzjZLkJFF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVf4RdE+8ECrxvAVh8dmO720SKCKGbL8J19/b3R+RE9RnGWKS+UA/RzAwrXUXMQ2wzQyfHAiNrQ7ChHMylsBl5YP4bwYvSpyfCa/UK8EtH6q9yoYgSqfAPWAJMwl42KUrF3NTCoQrTus+f9HnBS5cVwqeXw5Yipv0yJAFCUx8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=tAi96LJX; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="tAi96LJX"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gfqND4Fy3z8qs;
	Tue, 16 Jun 2026 16:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
	s=20220412; t=1781620684;
	bh=L4HUsPuZdj6LV3uNElVOC/aB6ZtKXn8837uRKeGnUl0=;
	h=From:To:Cc:Subject:Date:From;
	b=tAi96LJXCg+fKOs6D1B1q64Pr4G70CxNuWQUFaWA9A+WDqf4Gc6eAM0ZBvGatjXId
	 /Fi1Xe8/4Riq0LXduefg3SJpl59vwyHZyJgfUd+f+gyQkrSU0unGCXKTy8Ux6MaaVL
	 nVEwf9VC6Ww+wNNTk90YNVNIVLor7B5oLju+kPPo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gfqN93F77zy0m;
	Tue, 16 Jun 2026 16:38:01 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Philippe Schenker <philippe.schenker@impulsing.ch>,
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
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: ti: icssg: guard PA stat lookups
Date: Tue, 16 Jun 2026 16:35:34 +0200
Message-ID: <20260616143642.1972071-1-dev@pschenker.ch>
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

Cc: danishanwar@ti.com
Cc: rogerq@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
---

 drivers/net/ethernet/ti/icssg/icssg_common.c | 48 +++++++++++---------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4..2dbb8f717de0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1628,28 +1628,34 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
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
+	if (emac->prueth->pa_stats) {
+		stats->rx_errors  +=
+				emac_get_stat_by_name(emac, "FW_RX_ERROR") +
+				emac_get_stat_by_name(emac, "FW_RX_EOF_SHORT_FRMERR") +
+				emac_get_stat_by_name(emac, "FW_RX_B0_DROP_EARLY_EOF") +
+				emac_get_stat_by_name(emac, "FW_RX_EXP_FRAG_Q_DROP") +
+				emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN");
+		stats->rx_dropped +=
+				emac_get_stat_by_name(emac, "FW_DROPPED_PKT") +
+				emac_get_stat_by_name(emac, "FW_INF_PORT_DISABLED") +
+				emac_get_stat_by_name(emac, "FW_INF_SAV") +
+				emac_get_stat_by_name(emac, "FW_INF_SA_DL") +
+				emac_get_stat_by_name(emac, "FW_INF_PORT_BLOCKED") +
+				emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
+				emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
+				emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
+				emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
+		stats->tx_dropped +=
+				emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
+				emac_get_stat_by_name(emac, "FW_TX_DROPPED_PACKET") +
+				emac_get_stat_by_name(emac, "FW_TX_TS_DROPPED_PACKET") +
+				emac_get_stat_by_name(emac, "FW_TX_JUMBO_FRM_CUTOFF");
+	}
 }
 EXPORT_SYMBOL_GPL(icssg_ndo_get_stats64);
 
-- 
2.54.0

base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
branch: fix-icssg_common-pa-stats-errors__master-7-1
