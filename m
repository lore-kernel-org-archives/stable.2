Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349927;
	b=ngwXf65ZXh+9iTvffdKCFMYo6unkMJYEzgz0NgwTdfuH4CDPvpdoaHh/yWkjgEx3+wLj
	 sDOrPJDR5DUb9L32WMXFQv8kjBz9cyCrgKVwVTBTAzoym24kiTdQwmvS7rX52c/FQMe7B
	 N6gharty4bnTGR2euTv8thT9FcwM+cfxwyE8z97p3ERxaYFUQ437SEZki/+BlCHOWp3Fw
	 lnJq+GbZ4n7rnNmRqFQwbytIh3gpBC1kUyvYx//mr6PNttu5FVpm9Ccf3kn16HSj6AAWj
	 4DFAERwgWamvrYMFtFZ0gQUuBgp0kfFQ0oUMMRrFszOEipezD5acoW5b6ufd77fFuhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349927;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zKTO28F57W33PZtmg0ScjR3EzHs8Wp3bOl0FDporkmo=;
	b=3N1bwA6kkNdLDsRCBsnacut8x8E1IX01jl9BalTZouEM6VW0/rKddT3aYdSJONyuEV9H
	 j5Ai0r+nFxPecWw3BlRZKl0SDnGzktv9nw1fmqGJQyidX1zYtAvrIvOZfXHOdJ03Gp2Wc
	 HSb/zx7gqZS0SUHZuZ21VAL2pj3yPHNS9Kc1PiPmN3o6ZCy2UQbhW4pjUZ+9Yp1NgomTf
	 /IrIQW+O/nSx1A7AgZJiHleTpp+nEZLYgZ1yTxcThdjEiaaDNce87uoOOUK3Vd/krZLLn
	 e9ZumXpshBcJSwMvFe1swP3lbpKT2AYCPqJjWa+y2gLe8eQ+hvgA89tTlmu0qMseyVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmmzLEvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96379606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmmzLEvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D59C1F008A2;
	Tue, 10 Nov 2026 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349927;
	bh=zKTO28F57W33PZtmg0ScjR3EzHs8Wp3bOl0FDporkmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmmzLEvOeHClN/nBntOKIawSHEKnn/ewYkdr+DZLxERgOXzFIcAeHmY5+MCOYLtTO
	 MFf+nBWBs+K3mf4I3EsuMn3w/9oCzKk6iVJlWO0yMSOoBs/oRMvj8hMIx0pSUJsHyd
	 uR6Wl/AJwtyNKw5qqSn1qrKO4jYvmHVU7p/+QmoneabHCTMi1nMwVAo/rHCBaaPj4I
	 rp5Z85rtACIZ53y6p3X1HYha8tkz9UBonRPD0cE9X6pre3FgbYFq8ut04JBgI2f1yy
	 WQC4CeJDi6IU8DjPRiKWpBVqoy/jTlllPdMiIANSu6DLs9wBiI7hs7N8/Jt5bxGHBc
	 LXeCErZB41Paw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] bnxt_en: Refactor some basic ring setup and adjustment logic
Date: Tue, 10 Nov 2026 17:32:03 -0500
Message-ID: <20261110222955.4046112-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051234-failed-6.18-78731b46967e@kernel.org>
References: <20261107051234-failed-6.18-78731b46967e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit ceee35e5674aa84cf9e504c2a9dae4587511556c ]

Refactor out the basic code that trims the default rings, sets up and
adjusts XDP TX rings and CP rings.  There is no change in behavior.
This is to prepare for the next bug fix patch.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20260331065138.948205-2-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 78731b46967e ("bnxt_en: don't leave an XDP program installed when the open fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 53 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  5 +-
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 602b97d00e9ae..8ef1d9d2f1355 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13000,6 +13000,21 @@ static int bnxt_tx_nr_rings_per_tc(struct bnxt *bp)
 	return bp->num_tc ? bp->tx_nr_rings / bp->num_tc : bp->tx_nr_rings;
 }
 
+static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
+{
+	bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
+	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
+}
+
+static void bnxt_adj_tx_rings(struct bnxt *bp)
+{
+	/* Make adjustments if reserved TX rings are less than requested */
+	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	if (bp->tx_nr_rings_xdp)
+		bnxt_set_xdp_tx_rings(bp);
+}
+
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -13017,13 +13032,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (rc)
 		return rc;
 
-	/* Make adjustments if reserved TX rings are less than requested */
-	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
-	if (bp->tx_nr_rings_xdp) {
-		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
-		bp->tx_nr_rings += bp->tx_nr_rings_xdp;
-	}
+	bnxt_adj_tx_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -15515,11 +15524,19 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+void bnxt_set_cp_rings(struct bnxt *bp, bool sh)
+{
+	int tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+
+	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
+			       tx_cp + bp->rx_nr_rings;
+}
+
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	bool sh = false;
-	int rc, tx_cp;
+	int rc;
 
 	if (tc > bp->max_tc) {
 		netdev_err(dev, "Too many traffic classes requested: %d. Max supported is %d.\n",
@@ -15552,9 +15569,7 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 		bp->num_tc = 0;
 	}
 	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
-			       tx_cp + bp->rx_nr_rings;
+	bnxt_set_cp_rings(bp, sh);
 
 	if (netif_running(bp->dev))
 		return bnxt_open_nic(bp, true, false);
@@ -16616,6 +16631,15 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
 }
 
+static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
+{
+	if (sh)
+		bnxt_trim_dflt_sh_rings(bp);
+	else
+		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
+	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+}
+
 static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 {
 	int dflt_rings, max_rx_rings, max_tx_rings, rc;
@@ -16641,11 +16665,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		return rc;
 	bp->rx_nr_rings = min_t(int, dflt_rings, max_rx_rings);
 	bp->tx_nr_rings_per_tc = min_t(int, dflt_rings, max_tx_rings);
-	if (sh)
-		bnxt_trim_dflt_sh_rings(bp);
-	else
-		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
-	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+
+	bnxt_adj_dflt_rings(bp, sh);
 
 	avail_msix = bnxt_get_max_func_irqs(bp) - bp->cp_nr_rings;
 	if (avail_msix >= BNXT_MIN_ROCE_CP_RINGS) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1d17ffb7415e0..668d929ddb7de 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2987,6 +2987,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		     int tx_xdp);
 int bnxt_fw_init_one(struct bnxt *bp);
 bool bnxt_hwrm_reset_permitted(struct bnxt *bp);
+void bnxt_set_cp_rings(struct bnxt *bp, bool sh);
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc);
 struct bnxt_ntuple_filter *bnxt_lookup_ntp_filter_from_idx(struct bnxt *bp,
 				struct bnxt_ntuple_filter *fltr, u32 idx);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 7f60d7b9f5570..2dc9708fb63f6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -940,7 +940,6 @@ static int bnxt_set_channels(struct net_device *dev,
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
-	int tx_cp;
 
 	if (channel->other_count)
 		return -EINVAL;
@@ -1008,9 +1007,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	if (tcs > 1)
 		bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs + tx_xdp;
 
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = sh ? max_t(int, tx_cp, bp->rx_nr_rings) :
-			       tx_cp + bp->rx_nr_rings;
+	bnxt_set_cp_rings(bp, sh);
 
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 85cbeb35681c2..bebe37e139c94 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -384,7 +384,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 {
 	struct net_device *dev = bp->dev;
-	int tx_xdp = 0, tx_cp, rc, tc;
+	int tx_xdp = 0, rc, tc;
 	struct bpf_prog *old;
 
 	netdev_assert_locked(dev);
@@ -431,8 +431,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	}
 	bp->tx_nr_rings_xdp = tx_xdp;
 	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = max_t(int, tx_cp, bp->rx_nr_rings);
+	bnxt_set_cp_rings(bp, true);
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 
-- 
2.53.0

