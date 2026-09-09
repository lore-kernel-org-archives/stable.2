Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30913379C46
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975144; cv=none; b=eNHhXq2fG00VjK5y8CPNyNW1NNdQdooRy/XK7ALc70Orjbz+DkDwQJSRqaaflhnXhQkdGjFpGOcSkU3zkgFQDsIYMMODkjXSasXXjlBk80R1CN2OWXqVYRrx1BKpH5FMFiQVuzYLSE0ueD8XlUO/2eje4XK/Himhwhy2TLt1BOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975144; c=relaxed/simple;
	bh=Ae0ZlgKsO7EE3vcYjsTbwQrOKIj1UMbsO0kW7O8Xu5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9gYEt61N0wCFN97jQM/u5iaB+dMCxA+vK4ef/aRr9HdNB3bb5p312qAuQVsWkve7ekXmcsSWtdi3m+zo5GtqZ9ZBGmgj4hIIXh5N7e6OocioipvvB9HDE/5j5GKZozsqnQexEtRScqVdkzqVANfvhtVjqZmvKuEjhceLoZuwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4U+iDnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4U+iDnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B2D1F00893;
	Wed,  9 Sep 2026 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975142;
	bh=zfmRfOUZvurm8uCCx60ft2MdU9luG8Le4ffEmdhJieM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N4U+iDnQxKB5bkXyCt5oOciEletDl6ExgZCzM87jF8mg1xwX1CXKP6TYVT7Z+W+/9
	 i73S6kSWKYSiLaBwMSSEccydLLL8BAgcN2a9zsCoSNWXVy1sEgWc+Mwkya0CxujGvg
	 3D0ijE0N4Rco08GpOvnPyZuXP/Qe6q4e7EyhkalrcteFD1zXxmHb4s5mmwerMfYmAP
	 vp+tEA3qu7uUXK98jsli4mcdhIElErRFoiN+GDtJlg3LOyDJiGtUCsWhkURcoLld9x
	 3xuEt2iNmsSjI6HS4PkcD0fvPB5jfbFFBBvUJCv49M0g7DJmn4NWcQT9SpZs63Z3yG
	 2o1V6Ev4THixA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Glenn Judd <gmj@meta.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] net/mlx5e: do not HW-GRO coalesce small frames
Date: Wed,  9 Sep 2026 13:32:19 -0400
Message-ID: <20260909173219.3296914-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909173219.3296914-1-sashal@kernel.org>
References: <2026090308-macarena-speckled-769c@gregkh>
 <20260909173219.3296914-1-sashal@kernel.org>
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
index 8a61c958c5679..17b74a97138b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2401,6 +2401,11 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 
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

