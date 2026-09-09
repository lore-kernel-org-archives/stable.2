Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA55519AA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981463; cv=none; b=U6Awb6VFnMp/6Zbgiu7vltGR+IDoW5O3neBo1Ob14wP2VUqEMiej7QS3mRZZdnB2TwH6z6BTlEREh96P1ak7SrGhJ3UWJTWpp00Zi/aSWJYvYSsmCDXnVonsef3BWJD74ZIJeyUawoeGLrkq7lmtjYB5YBSegnCrxDbvewVngOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981463; c=relaxed/simple;
	bh=8w8Yhmf8DbAv9PG7gR6heZVI/dJFoOK9mcJ5tMU9Nms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLo06KZVzUciDn0CR8sjwleiJPPSF6i/Vty/q2H7WRfXg0P7WeV5p9YKdsiMrOHpQ0gPovprjPLveS1b6ykoext4SQ8+nS0FQrb9wQeqVWOgeWCuqEH1OKn4Y43a5rkWL9aW9O6iB/wpWnewJV7esEB8Ygf8tbsQbgUqkdp70GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITxcFurh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITxcFurh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A72E1F00898;
	Wed,  9 Sep 2026 19:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981461;
	bh=waNcgsC1Betk8+Y7IP0ov1EobyDG3OufZqfYw7V8fdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ITxcFurh1OQKAeV+jwW4WIq5cKvOijFk+s3h0RjN+Vy/aw2oZrVLtczKM5qr51AQB
	 damxKCNrgqaUC6l0aOXsf0DcUn+4B1eefbH0O4RBxgRtn/WLRzFgu7V8jRn5PU5T+A
	 3tTGYA+uTvpgjLNeBWxeEYYdRq+tqVzyGS17WGAnAJ4JNQTUDxysnKGmZa3AYJoZOb
	 cBGJ4iP+qAjHz/ewWz3NS4VwC18YISLnIuRENzUDyWz3OuNEcbmt0dfgXSF7BjLGou
	 CdLlTItyzuklkTSCPT9M3KdaaACKnaEQ7nAEFNc7+DYAQZJ/S7EGsliBCV+6LuvyZP
	 Cj7QP5rkUD+Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Glenn Judd <gmj@meta.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net/mlx5e: do not HW-GRO coalesce small frames
Date: Wed,  9 Sep 2026 15:17:38 -0400
Message-ID: <20260909191738.3557825-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909191738.3557825-1-sashal@kernel.org>
References: <2026090310-fax-kindred-5230@gregkh>
 <20260909191738.3557825-1-sashal@kernel.org>
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
index 4dea95dc5f62e..d46f94f7c8146 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2113,6 +2113,11 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 
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

