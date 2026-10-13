Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9E519933
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902950; cv=none; b=PagSCCoQ3heoBj2hemUZWvYocajCNH3xp+Oi4es7H5+AU65ySsUMkUvtu5UKW3nHWpb9qLvRxvPEIqr8uIn2SPEgvczZhBnge43CEwCWJsZ3qkxv9VJkhq6D/3lX/TfusUBFMJI+ibn02RY6e6P+Zu5SD4K+SzFaKJXfbopnBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902950; c=relaxed/simple;
	bh=FGELUFKiRgGmjRXG9ZNRMDRTQujo3AWjtDRV2VvwgC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPp+euRRGCdKeY1mzf7wyqgIYyZQlDiWyh7+vu8RWbQ3FPUwbWpZsLtaets1YitkZnFv+iJwMU65NeeM9f2bWuFke71yEl/0wGxNu6PVOg1tfE9TYr0lfJmcmsWn4FbmVw181cRxuOmqx8hRZM7R47STN3VAKhQcyS+bdOM9ZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVZ8PWr9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVZ8PWr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04E81F000FF;
	Tue, 13 Oct 2026 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902949;
	bh=V+kM9VjcwERlk4jnt1/u4/EdkY/pAOm0HXXKcRGLdAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WVZ8PWr9e+WYXzJpv36oJUZholE+vdMVCy7N9lVC14uxJqxWij905UKAFf4fn6kGN
	 ouHtaX31OtGNCexF+6+XTEvri9sqzbT0EWOT4NwpLXJJKK8TlzfTjsgiAXDTb1SIgO
	 DzUFA8cDuiUExu8la6I3jmsAF0LFL6at0zq5RVaXMBqyeKDS+TOfTmEHlK4FUHxD2y
	 SmpYNIBlC7oT4kS0SjMbkJID8MJNldGU6eKWCzRIaFQzNL9HZC3N5KK2lrs5QbvU0C
	 PoYISa/JvfymYJc0mI/MiREPtN0PuAuIBLZPwQVUHqTZ281i21C+62Zzue/dqxufb0
	 35ljKC1sI0/1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] net: mana: refactor mana_get_strings() and mana_get_sset_count() to use switch
Date: Tue, 13 Oct 2026 10:49:06 -0400
Message-ID: <20261013143851.3960965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101213-empirical-glancing-002d@gregkh>
References: <2026101213-empirical-glancing-002d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>

[ Upstream commit d52f80731055ee43b36bf60088679aca97a484da ]

Refactor mana_get_strings() and mana_get_sset_count() from if/else to
switch statements in preparation for adding ethtool private flags
support which requires handling ETH_SS_PRIV_FLAGS.

No functional change.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Link: https://patch.msgid.link/20260729063347.3388035-2-dipayanroy@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 259c4a519100 ("net: mana: reserve RX buffer headroom to fix forwarding performance")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/microsoft/mana/mana_ethtool.c    | 75 ++++++++++++-------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 881df597d7f9c..3531abfdaf433 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -138,53 +138,70 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
 
-	if (stringset != ETH_SS_STATS)
+	switch (stringset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(mana_eth_stats) +
+		       ARRAY_SIZE(mana_phy_stats) +
+		       ARRAY_SIZE(mana_hc_stats)  +
+		       num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+	default:
 		return -EINVAL;
-
-	return ARRAY_SIZE(mana_eth_stats) + ARRAY_SIZE(mana_phy_stats) + ARRAY_SIZE(mana_hc_stats) +
-			num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+	}
 }
 
-static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
+static void mana_get_strings_stats(struct mana_port_context *apc, u8 **data)
 {
-	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
 	int i, j;
 
-	if (stringset != ETH_SS_STATS)
-		return;
 	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++)
-		ethtool_puts(&data, mana_eth_stats[i].name);
+		ethtool_puts(data, mana_eth_stats[i].name);
 
 	for (i = 0; i < ARRAY_SIZE(mana_hc_stats); i++)
-		ethtool_puts(&data, mana_hc_stats[i].name);
+		ethtool_puts(data, mana_hc_stats[i].name);
 
 	for (i = 0; i < ARRAY_SIZE(mana_phy_stats); i++)
-		ethtool_puts(&data, mana_phy_stats[i].name);
+		ethtool_puts(data, mana_phy_stats[i].name);
 
 	for (i = 0; i < num_queues; i++) {
-		ethtool_sprintf(&data, "rx_%d_packets", i);
-		ethtool_sprintf(&data, "rx_%d_bytes", i);
-		ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
-		ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
-		ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
-		ethtool_sprintf(&data, "rx_%d_pkt_len0_err", i);
+		ethtool_sprintf(data, "rx_%d_packets", i);
+		ethtool_sprintf(data, "rx_%d_bytes", i);
+		ethtool_sprintf(data, "rx_%d_xdp_drop", i);
+		ethtool_sprintf(data, "rx_%d_xdp_tx", i);
+		ethtool_sprintf(data, "rx_%d_xdp_redirect", i);
+		ethtool_sprintf(data, "rx_%d_pkt_len0_err", i);
 		for (j = 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
-			ethtool_sprintf(&data, "rx_%d_coalesced_cqe_%d", i, j + 2);
+			ethtool_sprintf(data,
+					"rx_%d_coalesced_cqe_%d",
+					i,
+					j + 2);
 	}
 
 	for (i = 0; i < num_queues; i++) {
-		ethtool_sprintf(&data, "tx_%d_packets", i);
-		ethtool_sprintf(&data, "tx_%d_bytes", i);
-		ethtool_sprintf(&data, "tx_%d_xdp_xmit", i);
-		ethtool_sprintf(&data, "tx_%d_tso_packets", i);
-		ethtool_sprintf(&data, "tx_%d_tso_bytes", i);
-		ethtool_sprintf(&data, "tx_%d_tso_inner_packets", i);
-		ethtool_sprintf(&data, "tx_%d_tso_inner_bytes", i);
-		ethtool_sprintf(&data, "tx_%d_long_pkt_fmt", i);
-		ethtool_sprintf(&data, "tx_%d_short_pkt_fmt", i);
-		ethtool_sprintf(&data, "tx_%d_csum_partial", i);
-		ethtool_sprintf(&data, "tx_%d_mana_map_err", i);
+		ethtool_sprintf(data, "tx_%d_packets", i);
+		ethtool_sprintf(data, "tx_%d_bytes", i);
+		ethtool_sprintf(data, "tx_%d_xdp_xmit", i);
+		ethtool_sprintf(data, "tx_%d_tso_packets", i);
+		ethtool_sprintf(data, "tx_%d_tso_bytes", i);
+		ethtool_sprintf(data, "tx_%d_tso_inner_packets", i);
+		ethtool_sprintf(data, "tx_%d_tso_inner_bytes", i);
+		ethtool_sprintf(data, "tx_%d_long_pkt_fmt", i);
+		ethtool_sprintf(data, "tx_%d_short_pkt_fmt", i);
+		ethtool_sprintf(data, "tx_%d_csum_partial", i);
+		ethtool_sprintf(data, "tx_%d_mana_map_err", i);
+	}
+}
+
+static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		mana_get_strings_stats(apc, &data);
+		break;
+	default:
+		break;
 	}
 }
 
-- 
2.53.0

