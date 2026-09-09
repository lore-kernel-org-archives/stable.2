Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0EB37F313
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975993; cv=none; b=McO9R5uQkpqBmIYmsrEF/XN8poxjs0JbeyqKrBIYFH40rffLnrkN4fXQi5Tf1JSnAVFzZ9BfIsZFnzY7Ws+Q49pLzm4ISO9n6m4HoAKUEU3nlpBJAQGK8Yd5zRt0FRYb1733EWQqPvTTC+loZEuEtHrWnYZazY3WKMxjOBVROAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975993; c=relaxed/simple;
	bh=KilJEYecFtlqVu/E5PIAyaS3TY/NPu0t284VHtj1eMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUmADGzI6SPIZvtk1LoGW76X+mI54v81Mg1A0JxTbCh1dXBMUpTdAuL7m6Z4WvWrXFRiQHCyVpHGhAhZ8jZR5ZxHhg6ZLPzjiizpG4XtfMFQ84zP1JoOwSgC3nhLwxhY586L0G07h8KaEwiTF1xaziSo6V/Q4DB3xDq0N0VQ0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKbnq4vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKbnq4vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADF31F00893;
	Wed,  9 Sep 2026 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975992;
	bh=CGWjVTSU3vjsx5A7tG9KHDXDrpN1rjixlBQOpo/Cepg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HKbnq4vqx7Biz9wJhgh/J90G59OrR4VgmC8sicXD7tFt0rbT7vNFarouXKtOLjCtn
	 xdWALEifBAUhqUGtSj1PJhETRSyQ7Og3gVJizCK7ezNxO0VvWVPKU+Uw0thyiUnuCe
	 Ndy5o54l69ku6GKRp6IMti7Z3buoRAYuVMXpjQgMuxIUa4R7JJw338Tm3OonrcW2ty
	 ccT76H1A3j5i7HS5vfLuYiSdO+WSVhixf8FIlhgqcdE2+CajlMSNP4Y90o4HA33tTG
	 HSsnacGS5T58/U842GD103FwVl+qST6eQMMke/xzeWOTlm+K3ntOSnfFSiVbjjRYvj
	 gI3BjrgpqLfkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] net/mlx5e: SHAMPO, Drop rx_gro_match_packets counter
Date: Wed,  9 Sep 2026 13:46:27 -0400
Message-ID: <20260909174629.3343707-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909174629.3343707-1-sashal@kernel.org>
References: <2026090309-herbicide-eaten-1f09@gregkh>
 <20260909174629.3343707-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit 16f448d47a86825a421fc1211336454c42c5254f ]

After modifying rx_gro_packets to be more accurate, the
rx_gro_match_packets counter is redundant.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20240603212219.1037656-11-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e2466392a0b8 ("net/mlx5e: do not HW-GRO coalesce small frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst       | 5 -----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c              | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c           | 3 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h           | 2 --
 4 files changed, 12 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index f69ee1ebee010..b7fbdabca9e9c 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -202,11 +202,6 @@ the software port.
        hardware-accelerated GRO.
      - Informative
 
-   * - `rx[i]_gro_match_packets`
-     - Number of received packets processed using hardware-accelerated GRO that
-       met the flow table match criteria.
-     - Informative
-
    * - `rx[i]_gro_large_hds`
      - Number of receive packets using hardware-accelerated GRO that have large
        headers that require additional memory to be allocated.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 962531e9d5ec3..4ec68388fe7cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2370,8 +2370,6 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 		goto mpwrq_cqe_out;
 	}
 
-	stats->gro_match_packets += match;
-
 	if (*skb && (!match || !(mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt)))) {
 		match = false;
 		mlx5e_shampo_flush_skb(rq, cqe, match);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 1c69244e00d75..22040ef1c5f84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -136,7 +136,6 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_skbs) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_match_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_large_hds) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_ecn_mark) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_removed_vlan_packets) },
@@ -338,7 +337,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_gro_packets             += rq_stats->gro_packets;
 	s->rx_gro_bytes               += rq_stats->gro_bytes;
 	s->rx_gro_skbs                += rq_stats->gro_skbs;
-	s->rx_gro_match_packets       += rq_stats->gro_match_packets;
 	s->rx_gro_large_hds           += rq_stats->gro_large_hds;
 	s->rx_ecn_mark                += rq_stats->ecn_mark;
 	s->rx_removed_vlan_packets    += rq_stats->removed_vlan_packets;
@@ -1988,7 +1986,6 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_skbs) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_match_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_large_hds) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, ecn_mark) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, removed_vlan_packets) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 477c547dcc04a..c2397871c5dbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -149,7 +149,6 @@ struct mlx5e_sw_stats {
 	u64 rx_gro_packets;
 	u64 rx_gro_bytes;
 	u64 rx_gro_skbs;
-	u64 rx_gro_match_packets;
 	u64 rx_gro_large_hds;
 	u64 rx_mcast_packets;
 	u64 rx_ecn_mark;
@@ -348,7 +347,6 @@ struct mlx5e_rq_stats {
 	u64 gro_packets;
 	u64 gro_bytes;
 	u64 gro_skbs;
-	u64 gro_match_packets;
 	u64 gro_large_hds;
 	u64 mcast_packets;
 	u64 ecn_mark;
-- 
2.53.0

