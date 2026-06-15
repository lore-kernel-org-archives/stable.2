Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062440FDB6
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545041; cv=none; b=iXq8PkCaBBSQgR8HsRXYltWsDwabZaAJnoF/Ay7HLHbywFR5RYDXGtsEowj2LyJcdnhPWUm9xzjb9pNVDGbMpElPmqBXy4PgX6rR6vht5LGARHDdVUtuBZ7usoGPALELmL3m9yD7VKdDMQcntbtJnupcwOr5PXTBXpwrukl+VXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545041; c=relaxed/simple;
	bh=zz23/PweprY6M6EdKHWBG6eAfqhkGOk82FJviZpKkWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgF8uz+FMUBR21IQxtTY06GaRpEzUWXrjFCptICpuZgVhA1IcHqgcGK5BS2wG4sBp/V+N+wgcoVagvdYnJ7jHFgHO0PMA/j38uNw9sfK6cIu6Vnj3kb4oFtqvD5GYNGzL2pWForAztQmh6FTtE8/L6oLz6D/iKCD7aSJhyS6mQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqO7iN6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqO7iN6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64261F000E9;
	Mon, 15 Jun 2026 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781545040;
	bh=LV3G/yHeHozmnHhkcEMAzksakmjXxAfXrxtfLWo5Rfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DqO7iN6hzo4hmduIcN3Cv1XfMUaGf+pv795z7KEPnkEpDiIay9ocJytENak7H8Y2c
	 ovgcEBf8wyL/yyP1UyJ1v+HgL09hbTxjk41JPToxMpkuqGaCBYGsW45O1pJxcfhsjC
	 VFHzGkDx99L/neORtfSYuNc1QWBTqUvN2MSzCAGgCrIsHSk0w6TQIIh/+wIdyyZBKY
	 NGpbefwmVVpfF1T/BK/BVW6e9yrSxajuK9AoNyxX0ljTw0xX2zXyG/EqaCn9Lc6YMl
	 /8Lcg/AGRTaM/AeA5Ex+DdJW+2pohdgMcj2iZCS4czrF3yNRkLO2xE1A1MnwgKIJXU
	 caGFWQQy4aowA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davide Ornaghi <d.ornaghi97@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] netfilter: nft_fib: fix stale stack leak via the OIFNAME register
Date: Mon, 15 Jun 2026 13:37:18 -0400
Message-ID: <20260615173718.2302669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061544-juicy-dispatch-14c9@gregkh>
References: <2026061544-juicy-dispatch-14c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davide Ornaghi <d.ornaghi97@gmail.com>

[ Upstream commit ab185e0c4fb82dfba6fb86f8271e06f931d9c64c ]

For NFT_FIB_RESULT_OIFNAME the destination register is declared with
len = IFNAMSIZ (four 32-bit registers), but on the lookup-fail,
RTN_LOCAL and oif-mismatch paths nft_fib{4,6}_eval() only writes one
register via "*dest = 0". The remaining three registers are left as
whatever was on the stack in nft_do_chain()'s struct nft_regs, and a
downstream expression that loads the register span can leak that
uninitialised kernel stack to userspace.

The NFTA_FIB_F_PRESENT existence check has the same shape: it is only
meaningful for NFT_FIB_RESULT_OIF, yet it was accepted for any result type
while the eval stores a single byte via nft_reg_store8(), leaving the rest
of the declared span stale.

Fix both:

 - replace the bare "*dest = 0" in the eval with nft_fib_store_result(),
   which strscpy_pad()s the whole IFNAMSIZ for OIFNAME (and is already
   used on the other early-return path), and

 - restrict NFTA_FIB_F_PRESENT to NFT_FIB_RESULT_OIF and declare its
   destination as a single u8, so the marked span matches the one byte
   the eval writes.

Fixes: f6d0cbcf09c5 ("netfilter: nf_tables: add fib expression")
Suggested-by: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org
Signed-off-by: Davide Ornaghi <d.ornaghi97@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ kept the tree's existing `ip6_route_lookup`/`rt6_info` machinery (missing `fib6_lookup` refactor) and changed only `*dest = 0;` to `nft_fib_store_result(dest, priv, NULL)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/nft_fib_ipv4.c | 2 +-
 net/ipv6/netfilter/nft_fib_ipv6.c | 2 +-
 net/netfilter/nft_fib.c           | 6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 273b64e3f2f926..37d948d64f77c8 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -118,7 +118,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		fl4.saddr = get_saddr(iph->daddr);
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 
 	if (fib_lookup(nft_net(pkt), &fl4, &res, FIB_LOOKUP_IGNORE_LINKSTATE))
 		return;
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index b7e543d4d57be3..a8343877fdf7fd 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -189,7 +189,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		}
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 	rt = (void *)ip6_route_lookup(nft_net(pkt), &fl6, pkt->skb,
 				      lookup_flags);
 	if (rt->dst.error)
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 1fd4b2054e8f75..6b4dc8d9eb6794 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -105,6 +105,12 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 	}
 
+	if (priv->flags & NFTA_FIB_F_PRESENT) {
+		if (priv->result != NFT_FIB_RESULT_OIF)
+			return -EINVAL;
+		len = sizeof(u8);
+	}
+
 	err = nft_parse_register_store(ctx, tb[NFTA_FIB_DREG], &priv->dreg,
 				       NULL, NFT_DATA_VALUE, len);
 	if (err < 0)
-- 
2.53.0

