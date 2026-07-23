Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DF625
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836727; cv=none; b=P9khCPvKvgXvRWkudNg5W28BZab2YKrQKBgsnh1RMD4W2q04I5OMAslQ8gwtJoIPOuVwYmCSM8vSSImN15MxeDwx+143s8/zRZOGylj07JObumdvo39WcHGurblFGoQDZQOmKy9UGJHhn6GuvK6vuegAoNYsLfaUg+2fzzG3Nbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836727; c=relaxed/simple;
	bh=zKXiG+NOuUBWru1xhh6YSSO9XksVJIWPezO5YjIKULU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cuww2csQz3ikmmn7sAI7EUT4bUVC7+8j51RUj9HKPV5iPdHS/FMJT2Y69uOusNfc8RyPSVtTW0S+2qjMYzRVXhXnfrluC2RXxKi1Y5r1OvR38azhL9dIYWYKjQXd5baP39zswpF7lgN0mGIqKcyUjdohTvelsJO50XGzwr9esdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G954pAfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G954pAfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE63A1F000E9;
	Thu, 23 Jul 2026 19:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836725;
	bh=L748N8fhDFC3UNoGl+bMAjx4anwXwXVWw2tszLhUNdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G954pAfPKxF2KkhN9tuagWwkmx878Ca4uhcOFYJwCQa4HT/T++wTucft1DnPfb5L8
	 z+HiLR6KcXkOojksbchVpLdwBI7MJEFh8gVeTM8T7Bkj97iiN1qdSZWFwhxUlhjaEB
	 FvlyYh91gVYYrst1EpLR4LZ28GD5waEbx18PukvQR0KTX17iY9uoDTWsIsw3ucOKsZ
	 o9fwAnlkQxLqK2ynC7NGKlgEIiukl1XDoyH84M2UTjM4ehyhBxfIeHaBQszNaZpyAr
	 ygmt5sqUc4+Hjo7ex/htmUZG0P50dj1cu9bU8aIHqsKNT4rNLa9V0Drd35ZJaqXrky
	 j9tUDGUQUQw5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] netfilter: nf_tables: Remove unused nft_reduce_is_readonly()
Date: Thu, 23 Jul 2026 15:58:40 -0400
Message-ID: <20260723195842.3683768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072054-folic-tartly-6b52@gregkh>
References: <2026072054-folic-tartly-6b52@gregkh>
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
index a1f828efc9e3de..ca1e40803074d6 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1851,11 +1851,6 @@ static inline u64 nft_net_tstamp(const struct net *net)
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

