Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0537BE81
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825664; cv=none; b=f4e3+9erCRnAJX1UoH1GFTvszY8nsZe2Xa+UKNJF6fXKUKZul8UWIBkf5KZqnrULAoR2XctWspVb4QCxLSgjWNBhh1uFzC9nm/jK9/TV+IVabNJKeAzVNNwKBGRpZehct+4ICXH4rCjaPW/HnYGYEHVTUIVvir3L8fhiKkfRg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825664; c=relaxed/simple;
	bh=S8L2GJcL+G1zCgSBQorvwP7LE4jm2Ea8pwiP5cEl98A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGJqLAUSr0P8s2sbedXZY7SDLRZJjDnzp1zNjwsa28xIXp0m+j8VcC+6um1WYm1NFijHFp3uNY8x/ekDuLpa+Bnn0X7RcKAL7db9PknqbN/Tt5Rh1xEuzHUk1VVgiQQwgjCceiKhmF7tZi6wsNFACFKzfAmHEBqdrkUMZpKYBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmT4BBA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmT4BBA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D931F00A3A;
	Thu, 23 Jul 2026 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825662;
	bh=EseC2OmATwLsiEWECfVj1sNS0D1j6tamsZb1hxmbKnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PmT4BBA2ILYw9rrtzXItBbLwlh1dl8bmSdgEkLEu9XkfCDaby6xBoNhGYMEMlONTE
	 XHcfWH31g7M4tOMqg+27AOOCw3ZLlG58ueOk+YMx32uxv/EArlpkfZZ8BiowyxiZut
	 J+2T8TH3kTCrjgwwE10VSHzsWg9nep99B8PmN+k05mMNEHB4n3QZjI/sMepfiONh5l
	 qj9BcyKzCJRk3BWxxqBSKq85EJKteGUw2sdgBdrv1FI9ndMk6lk87B9+RkqqqhM3VV
	 tD/LNya63Lp6xxbTUyZdeP2DTXEwKMYoUmBCZKgDqn/QD17CJcrPU57EJPWjrSVPQd
	 i9ExHK6xWtabw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] netfilter: nf_tables: Remove unused nft_reduce_is_readonly()
Date: Thu, 23 Jul 2026 12:54:17 -0400
Message-ID: <20260723165419.3390514-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723165419.3390514-1-sashal@kernel.org>
References: <2026072054-unseemly-confident-8b8e@gregkh>
 <20260723165419.3390514-1-sashal@kernel.org>
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
index 36964b86d336dd..92ddecba6d6690 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1954,11 +1954,6 @@ static inline u64 nft_net_tstamp(const struct net *net)
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

