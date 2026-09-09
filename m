Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488B3B7742
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981462; cv=none; b=HBbI73Gx/BAQj27iRRRp68pVZNey7+FMxToqKO9rwJHt3lxBM3Nin7wxC/pOWgCZZGrQHqWbd6aboQHz6GAnaNJsYDDc9iGo55MiKyY8WeNmx1WPivjWHetkJ/yaiWj1Op/ZM2ylFLDU0QUvVwf3b5uc2Cjf5A4IwSx4K5yNdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981462; c=relaxed/simple;
	bh=+TxIDqopvT6g9mVXaL2tNqdmb53sIHHe9/UYvz/sRAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLwyH+rw3NLyXjKafRab9xT9ECDkhfzNH5yj701JhwEb+XbEZUocZZqkSnajm4y5wvOoSGbFi9tVTS0rv+SbLbQTRCLQPxM/BFW4bRhKfpZOzEP+us/r7CNTeLNb1ATAAnBAfbnORQtPLU+9/3R6W4Z3RlcG9iLDxOhh2OMv1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRMuodu5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRMuodu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401581F000FF;
	Wed,  9 Sep 2026 19:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981460;
	bh=jyaDfhpVggCwXSOC3MGodz5OQywug122kdSEWMW4FgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jRMuodu5lS9j3Z8MlmpksibDD8aBrxKFMJrCBWbIQOvq4no6ifepvmboiUTUxay1i
	 O7xjiXI0IoHLQwLXDarlowsKugdB/zy/AARyBN5lrPh+yL31x9YztIxxsSnKpUJIXW
	 im+9yZOhgCzwJVkMkIF5HcC7PVIhn/KgfileKy0bBSI9pxCTr+DgcRMKLEUWCtr5sk
	 bE3eGJD2xfc5xkQer+CbxOLVpPqskvaV6sVrjYK7hJ4KBinipywVlGJKZtBJQhB17J
	 su6w5scaSX9Hr/W8fHvhTcIKKJsZmbA3lzLT5AxONk4z51OhEMfF9jaL1yHjAza58Z
	 wpFE9Rp/W2g5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net/mlx5e: SHAMPO, Drop rx_gro_match_packets counter
Date: Wed,  9 Sep 2026 15:17:37 -0400
Message-ID: <20260909191738.3557825-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090310-fax-kindred-5230@gregkh>
References: <2026090310-fax-kindred-5230@gregkh>
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

Stable dependency adaptation for e2466392a0b8496000e12181cb1ee1535eb0da25:

Omit the counters.rst hunk because the mlx5 documentation directory does
not exist in this 6.1 tree. Keep the counter removal in the driver.

Align the existing SHAMPO receive handler with the target's patch context:
move the data-offset and page-index calculations below the error/filler
checks, derive the page size from rq->mpwqe.page_shift, pass it to the
existing space-check helper, and use the equivalent match/space predicate.
SHAMPO uses regular order-0 pages here, so the page size and GRO limits
remain unchanged. No functions are added. The newer GRO counter-accounting
changes are outside this dependency; the small-frame fix remains in the
target commit.

[ sashal: Reduced backport -- upstream 16f448d47a868 touches 4 file(s), this
  backport carries 3. Not backported here:
  Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e2466392a0b8 ("net/mlx5e: do not HW-GRO coalesce small frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 22 +++++++++++--------
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  3 ---
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  2 --
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 75934d0f144cc..4dea95dc5f62e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2051,15 +2051,16 @@ mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
 	rq->hw_gro_data->skb = NULL;
 }
 
-static bool
-mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb, u16 data_bcnt)
+static bool mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb,
+					      u16 data_bcnt,
+					      u32 page_size)
 {
 	int nr_frags = skb_shinfo(skb)->nr_frags;
 
-	if (PAGE_SIZE >= GRO_LEGACY_MAX_SIZE)
+	if (page_size >= GRO_LEGACY_MAX_SIZE)
 		return skb->len + data_bcnt <= GRO_LEGACY_MAX_SIZE;
 	else
-		return PAGE_SIZE * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
+		return page_size * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
 }
 
 static void
@@ -2081,19 +2082,20 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	u16 header_index	= mlx5e_shampo_get_cqe_header_index(rq, cqe);
 	u32 wqe_offset		= be32_to_cpu(cqe->shampo.data_offset);
 	u16 cstrides		= mpwrq_get_cqe_consumed_strides(cqe);
-	u32 data_offset		= wqe_offset & (PAGE_SIZE - 1);
 	u32 cqe_bcnt		= mpwrq_get_cqe_byte_cnt(cqe);
 	u16 wqe_id		= be16_to_cpu(cqe->wqe_id);
-	u32 page_idx		= wqe_offset >> PAGE_SHIFT;
 	u16 head_size		= cqe->shampo.header_size;
 	struct sk_buff **skb	= &rq->hw_gro_data->skb;
 	bool flush		= cqe->shampo.flush;
 	bool match		= cqe->shampo.match;
+	u32 page_size = BIT(rq->mpwqe.page_shift);
 	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_rx_wqe_ll *wqe;
 	union mlx5e_alloc_unit *au;
 	struct mlx5e_mpw_info *wi;
 	struct mlx5_wq_ll *wq;
+	u32 data_offset;
+	u32 page_idx;
 
 	wi = mlx5e_get_mpw_info(rq, wqe_id);
 	wi->consumed_strides += cstrides;
@@ -2109,9 +2111,11 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 		goto mpwrq_cqe_out;
 	}
 
-	stats->gro_match_packets += match;
-
-	if (*skb && (!match || !(mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt)))) {
+	data_offset = wqe_offset & (page_size - 1);
+	page_idx = wqe_offset >> rq->mpwqe.page_shift;
+	if (*skb &&
+	    !(match && mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt,
+							 page_size))) {
 		match = false;
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 5db4fd40fe8b8..9087601057b1a 100644
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
@@ -339,7 +338,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_gro_packets             += rq_stats->gro_packets;
 	s->rx_gro_bytes               += rq_stats->gro_bytes;
 	s->rx_gro_skbs                += rq_stats->gro_skbs;
-	s->rx_gro_match_packets       += rq_stats->gro_match_packets;
 	s->rx_gro_large_hds           += rq_stats->gro_large_hds;
 	s->rx_ecn_mark                += rq_stats->ecn_mark;
 	s->rx_removed_vlan_packets    += rq_stats->removed_vlan_packets;
@@ -1950,7 +1948,6 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_skbs) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_match_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_large_hds) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, ecn_mark) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, removed_vlan_packets) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 52a67efafcd37..61448e23943f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -147,7 +147,6 @@ struct mlx5e_sw_stats {
 	u64 rx_gro_packets;
 	u64 rx_gro_bytes;
 	u64 rx_gro_skbs;
-	u64 rx_gro_match_packets;
 	u64 rx_gro_large_hds;
 	u64 rx_mcast_packets;
 	u64 rx_ecn_mark;
@@ -346,7 +345,6 @@ struct mlx5e_rq_stats {
 	u64 gro_packets;
 	u64 gro_bytes;
 	u64 gro_skbs;
-	u64 gro_match_packets;
 	u64 gro_large_hds;
 	u64 mcast_packets;
 	u64 ecn_mark;
-- 
2.53.0

