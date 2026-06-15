Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD83E3172
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540253; cv=none; b=EuQ8/0RUCVzCT+mkon8KGb6HN0mJ8XMNTnOd8UETRZ6u1oSPzsU30hywwB1pm4/m0Y0OywM0fPLXaPJCZdQZzyidOc2L6bA1OBFYjDeqQ5hFdHOQGKNWMiPZH3DA9c1/syelZHB2cVJjp2HvI76AA5f+TbsIUGc3c5sRwlZ13PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540253; c=relaxed/simple;
	bh=g0ioa68U7ZEIJ74ouQqs01lSXDzPaRKGg3h51u6uh78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f24TJLcchROqUrQGHVkfaWIV+19krSjAOgKM2VE11mQMJ5FDQUGEnXwvn4u4tTABuFqhrw7ajqfvRx3hIF8/bC+o1zgmdbhKymo455WQObpnVQYmCxDGiUXIF8gIcxI6wpqbCX1Oz/VonLSGTAJC27R18NNhaG37pxY80/Lp0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1TTJ9WO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1TTJ9WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3F91F00A3A;
	Mon, 15 Jun 2026 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540252;
	bh=THFOqtpPGEuY7XJ3AXGm/LTAaE5h49FxuyjRk8aqMqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m1TTJ9WOiAx48pILIMID6+jjEvqQio66BEaCuMosiuZ0DKvHkt1HMWi0xXVqBtT62
	 cf0/YQZmNTRJzfkMeZ0T86vkkwS+mHRgrv7S/enE7fr2gn1H1buoQPCN032O8tNwFq
	 Hh7hAtbux1UHIf5c5i+GqfnsbsPOwjA3gGoRHKX5YmL8RUil2mmn73VgVUT07MOMeP
	 GEbN+tCxdMVNjOk7tUNTogcfN2+zicdWGaqodnANt+whhe2j6ctxYdpnYuGulDF5Sf
	 6bBBIc6slnB5F6J2/pc6N13gz7KVS++tjyrBCJqbbdf06heGGoDWDscLDB6hir9LNv
	 erGZ6k6L+rv4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davide Ornaghi <d.ornaghi97@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] netfilter: nft_fib: fix stale stack leak via the OIFNAME register
Date: Mon, 15 Jun 2026 12:17:29 -0400
Message-ID: <20260615161729.2239291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061543-grumble-playset-f6ba@gregkh>
References: <2026061543-grumble-playset-f6ba@gregkh>
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
index edec5c8f59ac84..31a96aaeccec53 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -122,7 +122,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		fl4.saddr = get_saddr(iph->daddr);
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 
 	if (fib_lookup(nft_net(pkt), &fl4, &res, FIB_LOOKUP_IGNORE_LINKSTATE))
 		return;
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index a89ce0fbfe4b12..da4a35c20f1017 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -193,7 +193,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		}
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 	rt = (void *)ip6_route_lookup(nft_net(pkt), &fl6, pkt->skb,
 				      lookup_flags);
 	if (rt->dst.error)
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 0f17ace9722765..7a92a5e5508fdf 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -107,6 +107,12 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
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

