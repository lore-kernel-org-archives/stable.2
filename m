Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FC379C4A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976016; cv=none; b=qM3o2XdW5c2FcIW2nHAbd5vHR6FOMqjexpsd6beVIyiPbQ+ZTGNzwDJKIkL4WYwuZybT/3QYwmGefmeYU6jHemDS+hL/tRMUcebJ9jmaitO5JmOJ8h+Nd4eG4/v+35uAex3bTYaoQ4bleXhORrlMv68cWRg/HlpaETxvA4Fop3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976016; c=relaxed/simple;
	bh=VnYL33m8cHCPyyRDU/odRgMqj6kRvyIMHn19kOfWx1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtIWSB+B3A7uMdlngoXbdzEceYMbFJh3CWNDUZ9w4E+2ncVAGXPQYbIFSJvgCxVe7oPrLQZBmNMa0DS1a6FznOVzq1ANS+uYa1UzOS/1fZAzU6AyQzPIjRo9GbfNA74mmfX9O0VBRa9BBK8JevJYLNRVLyaddzH6hyvLRFSo0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZQf4XwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZQf4XwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6731F00893;
	Wed,  9 Sep 2026 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976014;
	bh=5aC9qH5DQkd9LS1CR9JDcvMjnz1hJuZVxKYmHjanoYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AZQf4XwGb4w+UqyaMfbrz1rFOBtoIDyvVSbuU9h3ws4AwfAVDFNM8CYT2coG/ZfDx
	 nbll6aN3TIFF8Q8ngyO8zPIGvkiNu0JhTWkU/SZNQE8keyUp2AzKacao1R7cX32v2H
	 td43ZnDDOyASsLwL2yXa60Ezw6SEGWdbSjt+oEKFUj4fdPtUsB1XS9HPBANOaS+gLA
	 XJV8AilXbV+jPHWK1jW88t7Tp5Pzl2xuLDfyFKTVHXd2R+7pePdZcoioqprJ8DH3GA
	 0TPFPSR9+7YJXx5ydb0N0hBjvAxHYLsf2S9DOSKMkaOjUhFPEn71AWdfJVOk5mbn0l
	 Tn+846O6w03oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] net/mlx5e: SHAMPO, Always calculate page size
Date: Wed,  9 Sep 2026 13:46:49 -0400
Message-ID: <20260909174650.3344905-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909174650.3344905-1-sashal@kernel.org>
References: <2026090309-herbicide-eaten-1f09@gregkh>
 <20260909174650.3344905-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit dff1c3164a69284ac9fedb1c25d4c008139e9fb8 ]

Adapt the rx path in SHAMPO mode to calculate page size based on
configured page_shift when dealing with payload data.

This is necessary as an upcoming patch will add support for using
different page sizes.

This change has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260223204155.1783580-9-tariqt@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: e2466392a0b8 ("net/mlx5e: do not HW-GRO coalesce small frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 34 ++++++++++++-------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 4ec68388fe7cd..19dc7ccfdcb7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1989,11 +1989,14 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 			   struct mlx5e_frag_page *frag_page,
 			   u32 data_bcnt, u32 data_offset)
 {
+	u32 page_size = BIT(rq->mpwqe.page_shift);
+
 	net_prefetchw(skb->data);
 
 	do {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - data_offset, data_bcnt);
+		u32 pg_consumed_bytes = min_t(u32, page_size - data_offset,
+					      data_bcnt);
 		unsigned int truesize = pg_consumed_bytes;
 
 		frag_page->frags++;
@@ -2015,6 +2018,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
+	u32 page_size = BIT(rq->mpwqe.page_shift);
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
@@ -2058,9 +2062,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		linear_hr = skb_headroom(skb);
 		linear_data_len = headlen;
 		linear_frame_sz = MLX5_SKB_FRAG_SZ(skb_end_offset(skb));
-		if (unlikely(frag_offset >= PAGE_SIZE)) {
+		if (unlikely(frag_offset >= page_size)) {
 			frag_page++;
-			frag_offset -= PAGE_SIZE;
+			frag_offset -= page_size;
 		}
 	}
 
@@ -2072,7 +2076,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
 		pg_consumed_bytes =
-			min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+			min_t(u32, page_size - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -2109,7 +2113,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		nr_frags_free = old_nr_frags - sinfo->nr_frags;
 		if (unlikely(nr_frags_free)) {
 			frag_page -= nr_frags_free;
-			truesize -= (nr_frags_free - 1) * PAGE_SIZE +
+			truesize -= (nr_frags_free - 1) * page_size +
 				ALIGN(pg_consumed_bytes,
 				      BIT(rq->mpwqe.log_stride_sz));
 		}
@@ -2311,15 +2315,16 @@ mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
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
@@ -2343,18 +2348,19 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
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
 	struct mlx5e_mpw_info *wi;
 	struct mlx5_wq_ll *wq;
+	u32 data_offset;
+	u32 page_idx;
 
 	wi = mlx5e_get_mpw_info(rq, wqe_id);
 	wi->consumed_strides += cstrides;
@@ -2370,7 +2376,11 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 		goto mpwrq_cqe_out;
 	}
 
-	if (*skb && (!match || !(mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt)))) {
+	data_offset = wqe_offset & (page_size - 1);
+	page_idx = wqe_offset >> rq->mpwqe.page_shift;
+	if (*skb &&
+	    !(match && mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt,
+							 page_size))) {
 		match = false;
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 	}
-- 
2.53.0

