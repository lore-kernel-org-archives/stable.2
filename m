Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0938C2C3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975527; cv=none; b=CSNR+nflNYVUTQg5m4MThP6LZRrIkT+rr+GvEsiiKbAmWMGTCqJPE5kePGtsRLI/1i3PidljsrIWRCLwumfMQeT16ENM8F1WapLAGBxVJmgoWieDnfpZYhBTY3m2kw1wpNTul5FA8Cz9hLXh0mJskM3G8moS9wS6zlJQMVmXuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975527; c=relaxed/simple;
	bh=8ezstaecmio+1s9pNOIMGuxBQMoAGxgj42kj+0ifVQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6fc/DpCfk4aFXYnYwLJ134NIQJ0lIfjDw2mYJHxGQNwODdApTeKipHHefTGRNVUMxpbhbjtSLicIIwRXbb+uQMCJB3zeArM7w9jQ24GtgEEZqJXxKYG+nD7VR5Cxk7QQjj79IwyFDha1MS8umIWVmoOIlUrD9szEPkQLOGJyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJthlrSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJthlrSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196C81F000FF;
	Wed,  9 Sep 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975524;
	bh=2XGaAYGD5lXfb3QuGDRD6R1asWZvuuJ9FKDZNNTtaGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJthlrSheQauUUVD91oU0Ot8eLzr2R+YoqZoCJrKpfO3hVqLLw/xLc5KrC3Mz7Dw8
	 8BHnseUBa+LFbSEAJ72kkvtzEWSAYmTr2NU6tDgJVUVLTZ9Lub/tHBCuPAcb1oZ7ZI
	 bq2G/0ZKmHXRIcmYDizgAKupUbyJPnnAa2aT1lYIMLI6IdQ1cURIEAQ2//npsYb3An
	 MEy/XTCNZfi99uhIMm8SMrqisuplqJv0WtZBrQrLdP/7owRL2yVKn4Jl7QeQnUeUi+
	 pHTxxi8ThSVOxrwtxbjhNAA+Xwbc+Gro+71v2jo3ZSXq/9LqV9h1E4KGT22mcjoiMQ
	 CRdN90CV34RkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Glenn Judd <gmj@meta.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] net/mlx5e: do not HW-GRO coalesce small frames
Date: Wed,  9 Sep 2026 13:38:41 -0400
Message-ID: <20260909173841.3322091-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909173841.3322091-1-sashal@kernel.org>
References: <2026090309-detergent-handgrip-7f4e@gregkh>
 <20260909173841.3322091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Glenn Judd <gmj@meta.com>

[ Upstream commit e2466392a0b8496000e12181cb1ee1535eb0da25 ]

When hardware GRO (SHAMPO) coalesces a small IPv4/TCP segment that was
padded up to the 60-byte minimum Ethernet frame, the trailing padding is
folded into the merged payload causing padding to be delivered
to the user as payload.

Detecting and reproducing the issue: the selftest
tools/testing/selftests/drivers/net/gro.py subtest
hw_ipv4_data_lrg_1byte sends {100, 1} expecting to receive {101}.
In current code, it receives {106} (100 + 1 payload + 5 pad) instead.

This patch avoids giving the user padding as payload by simply not
coalescing small packets (which fails the subtest; the same approach
and behavior as sw gro). This gains code simplicity at the cost of
more computation (passing an extra skb up the stack) for small packets
that could be coalesced.

The threshold is chosen as ETH_ZLEN + 2 * VLAN_HLEN. This is the largest
frame that may still contain minimum-frame padding (+ 2 VLAN tags), so
anything larger is safe to consider for coalesce. (We do not include
ETH_FCS_LEN in that threshold computation as netdev_fix_features()
drops NETIF_F_GRO_HW whenever NETIF_F_RXFCS is set, so retained FCS
can't reach this path.)

Fixes: 92552d3abd32 ("net/mlx5e: HW_GRO cqe handler implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Glenn Judd <gmj@meta.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260816064259.3279548-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 74a93d82de17e..eaa5d6c83a828 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2363,6 +2363,11 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 
 	data_offset = wqe_offset & (page_size - 1);
 	page_idx = wqe_offset >> rq->mpwqe.page_shift;
+	if (unlikely(cqe_bcnt <= ETH_ZLEN + 2 * VLAN_HLEN)) {
+		match = false;
+		flush = true;
+	}
+
 	if (*skb &&
 	    !(match && mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt,
 							 page_size))) {
-- 
2.53.0

