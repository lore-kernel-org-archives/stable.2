Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503C390603
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975992; cv=none; b=BgmDuoYQNvlKVXznNwrAGcX/ILD2P41CO5qEgg9/Ajt6QbLCYcDbUI55uRnlvK2wdExSjLIfV2m/AZAfjlzwLe4aGWbBbIigqeoNbaouJmBF62y7M7yEyIsbRd9PDsyhQGLM7zvc7syOkNTvhMafsFcphHNv+dsjwJzdo2Z9eAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975992; c=relaxed/simple;
	bh=mmoEGWe0nb0kbqk0J5Z1IHJwfQN9OctEU4uc8u4uT8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXAmRgmfKkeSZPB8F0zdXesz5xO8c8mOciTYhBAPbk1EpxPwIN7DflclOH7GvvV1d6d+xvE8YbDwGr2v4lLPheWefgykneJgMiMTrGF4YN/Joy0YVhtq9biHRkXMJgq5l3Zinw32AdBd/M14KBoiwv0k4WDzCtq3xDyJbyOtHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEWeLa+t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEWeLa+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F1A1F000FF;
	Wed,  9 Sep 2026 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975991;
	bh=ii9+3T4sEeTGj1lPdPdPVGt84+ctov1jpJMiMLz1s0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEWeLa+tRQ2CoZZsTCK52frG2MgQnF1EgdmtFsBHVqRTPogSEXITAGuOinkqUK50R
	 3qkVvtGWU7GD/Mt7ckr0mfbi2WxJjXI6Th/amERBcigOliK6CjZxvRKXPIhTXGmDmX
	 NiXXga0kJfc7UK8uAtwbaVVun/mMCGDlL04soCP1Nb4j9YqijCSePfFD1FYO/sqV5x
	 KpoIom5/iR5vqyO8zwnHmJUr1S7kxE/3rafxskNG334mATYpdNJjR7e3B9h/SUwrBd
	 mszqeSKym3OVCfJiUBXwk0ZuZymlmdWkxHunL2ZiTN6ITXOC50mT0/y39Tz2oWFhzG
	 xSTCk0mKN0N6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] net/mlx5e: SHAMPO, Specialize mlx5e_fill_skb_data()
Date: Wed,  9 Sep 2026 13:46:26 -0400
Message-ID: <20260909174629.3343707-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090309-herbicide-eaten-1f09@gregkh>
References: <2026090309-herbicide-eaten-1f09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit d34d7d1973c4d1125c430a9612d97bfc10cf6382 ]

mlx5e_fill_skb_data() used to have multiple callers. But after the XDP
multibuf refactoring from commit 2cb0e27d43b4 ("net/mlx5e: RX, Prepare
non-linear striding RQ for XDP multi-buffer support") the SHAMPO code
path is the only caller.

Take advantage of this and specialize the function:
- Drop the redundant check.
- Assume that data_bcnt is > 0. This is needed in a downstream patch.

Rename the function as well to make things clear.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Suggested-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20240603212219.1037656-8-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e2466392a0b8 ("net/mlx5e: do not HW-GRO coalesce small frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1d586451900b8..962531e9d5ec3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1985,21 +1985,16 @@ const struct mlx5e_rx_handlers mlx5e_rx_handlers_rep = {
 #endif
 
 static void
-mlx5e_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
-		    struct mlx5e_frag_page *frag_page,
-		    u32 data_bcnt, u32 data_offset)
+mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
+			   struct mlx5e_frag_page *frag_page,
+			   u32 data_bcnt, u32 data_offset)
 {
 	net_prefetchw(skb->data);
 
-	while (data_bcnt) {
+	do {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
 		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - data_offset, data_bcnt);
-		unsigned int truesize;
-
-		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
-			truesize = pg_consumed_bytes;
-		else
-			truesize = ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
+		unsigned int truesize = pg_consumed_bytes;
 
 		frag_page->frags++;
 		mlx5e_add_skb_frag(rq, skb, frag_page->page, data_offset,
@@ -2008,7 +2003,7 @@ mlx5e_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 		data_bcnt -= pg_consumed_bytes;
 		data_offset = 0;
 		frag_page++;
-	}
+	} while (data_bcnt);
 }
 
 static struct sk_buff *
@@ -2407,10 +2402,12 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	}
 
 	if (likely(head_size)) {
-		struct mlx5e_frag_page *frag_page;
+		if (data_bcnt) {
+			struct mlx5e_frag_page *frag_page;
 
-		frag_page = &wi->alloc_units.frag_pages[page_idx];
-		mlx5e_fill_skb_data(*skb, rq, frag_page, data_bcnt, data_offset);
+			frag_page = &wi->alloc_units.frag_pages[page_idx];
+			mlx5e_shampo_fill_skb_data(*skb, rq, frag_page, data_bcnt, data_offset);
+		}
 	}
 
 	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
-- 
2.53.0

