Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BD37BE7E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975525; cv=none; b=hdqp308ftnn2eXf+g8cQCruhAPwDIvONb7lzNli4d1fKcLTR2eSHk0pRmiokYRLUWnk4J7bXJ6oJ001pWfxuUIiEYna9VJAocpeKrzNWXQHKPcI/jEBjlvJGQTiX3uXzFRdIPyhH6/HwD+3CzKAv+QXzeKmLxmMKl5YYSxjSupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975525; c=relaxed/simple;
	bh=u8Ze/J/hsftPZS4eL2/gQqFnYrMr40PpLSeZ5VUXmqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F16CgHryVHCS3Ijq+H2QoSdqEq2ZPs9NGgWtd2htG1VrAJm1yWieaQABOkC4t5Vp2Edo9kKaHpHfe4HNfsfRZEUa/okDV5bp22q2vk7DZpNcp/EQcujU2tVlJOxvNhitEsN6YAoLnPQWBHtJU2orYktBQ+eJ00gTnwAPnsN1vp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsIjvynT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsIjvynT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2944D1F00893;
	Wed,  9 Sep 2026 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975523;
	bh=murOahk+YsSUwd4aQvz9tRTGWbU4EPSUdMogXhKkE6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fsIjvynTyXRzDvne8eh5CYRFR31X/TIqhxAhujDcFyfKkVZdAAJ632oMGyu+aGNVH
	 JXjaYSrLH4dtYAMOkcBCvmqeYcYi/HVEUVC1fkZXWYv51Umd+HgqlFC20YSf7kvSJp
	 ETQoeHSKUEfgDZJVtyM8UxDKwXIRKzItz9Ur6lPfJ0tkbv+cnXjJFe3Djhr4RdBo2B
	 X4o6E1qvTTgMBGDM0HZwHvnHoXtV0u2DfdS8xVsur9+6KIGqD/NSu7AGq8Pmp0sJz2
	 z+vHNYwea2ZZcxmW7lai8pLY1vi7+g5IpeP7mdP0199eQTsSjPkPsmlhFOKoJSNY4q
	 9IMx/weoBH8Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] net/mlx5e: SHAMPO, Always calculate page size
Date: Wed,  9 Sep 2026 13:38:40 -0400
Message-ID: <20260909173841.3322091-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090309-detergent-handgrip-7f4e@gregkh>
References: <2026090309-detergent-handgrip-7f4e@gregkh>
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
index 4eb1150e71547..74a93d82de17e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1983,11 +1983,14 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
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
 
 		mlx5e_add_skb_frag(rq, skb, frag_page, data_offset,
@@ -2008,6 +2011,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
+	u32 page_size = BIT(rq->mpwqe.page_shift);
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
@@ -2051,9 +2055,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
 
@@ -2065,7 +2069,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
 		pg_consumed_bytes =
-			min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+			min_t(u32, page_size - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -2102,7 +2106,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
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
 
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
@@ -2328,18 +2333,19 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
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
@@ -2355,7 +2361,11 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
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

