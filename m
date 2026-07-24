Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB053115AE
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856299; cv=none; b=TRyZLV/MItUCzHaV29ZckBZjgJdZeg7Em1SIySPI1vsS/yp8MYXtAV5xPCUx/koj/TRz1ojH9jTLpBYi6qOux4NhhDY4DsGis7MExN5UdQUUT20GPHxCZfOtdSmTOv2mj3zLPDV6pXLcHkrbsLYREX1MVCdJTipdWlV/2frs+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856299; c=relaxed/simple;
	bh=sNPQYCYG3h2B+1DfEt8HHlnot3YWliNXSKk28Y1qehw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZuaRvH8kncyN3EOnK4qjO3/y9W5FeT56QcbXkSOhGP1oA4xCc9lJWuoq5DduytdlJmb2gSFpwwUwKTMI3OYBdo0hOBhExGGM/FP14m968qu3Gif+X+hdA2iCyYSMAopF5RoJMfSESY5Ay/WLBNJ3OA6xf7hmQpLXzSEEw/ZxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4LMerYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4LMerYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60401F000E9;
	Fri, 24 Jul 2026 01:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856298;
	bh=qhTNnBFZoEtPc3ou4jVtlRWAV2heFopIamgJm4mUWss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4LMerYOvwaEHLxrLoeyMtDuzyBlm/7G7ZkFhpeUS+/OG4YfnygJRsxFqU//3soVb
	 oeveq2SUo22N2dR1P8PB55Lz4dpsuiIOej13Sm32WNteNcq2/g9EKAwYJare5psDGQ
	 +lNMwt1Un6LbSd3/UDpKkZTxyNI7GBe/U/epNKSkbcxjzn+o+j7tND6lxEcMW58NYO
	 3V117YvB88UC8TjWT9BOl/iqySH5yZ8c9RTvf2Qa3vrtrENmpIiwe0tbas6rODI+Jh
	 baKKtAg2ocSyqVyp4EjfhwPSiH91AI2GCBgjg4/wce5sAIwaywNp1ZNJcQ5VdHkO1u
	 L4M8C49RF2iAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/7] netfilter: nf_tables: Remove unused nft_reduce_is_readonly()
Date: Thu, 23 Jul 2026 21:24:50 -0400
Message-ID: <20260724012453.3832653-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724012453.3832653-1-sashal@kernel.org>
References: <2026072054-refresh-tumble-391b@gregkh>
 <20260724012453.3832653-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit bf6788742b8d6c73de441e088a71de7154f0d4aa ]

Since commit 9e539c5b6d9c ("netfilter: nf_tables: disable expression
reduction infra") this is unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: d07955dd34ec ("netfilter: nft_fib: reject fib expression on the netdev egress hook")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 486b345a0241ae..e0b6c328d53776 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1773,11 +1773,6 @@ static inline u64 nft_net_tstamp(const struct net *net)
 #define __NFT_REDUCE_READONLY	1UL
 #define NFT_REDUCE_READONLY	(void *)__NFT_REDUCE_READONLY
 
-static inline bool nft_reduce_is_readonly(const struct nft_expr *expr)
-{
-	return expr->ops->reduce == NFT_REDUCE_READONLY;
-}
-
 void nft_reg_track_update(struct nft_regs_track *track,
 			  const struct nft_expr *expr, u8 dreg, u8 len);
 void nft_reg_track_cancel(struct nft_regs_track *track, u8 dreg, u8 len);
-- 
2.53.0

