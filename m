Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488E311973
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856301; cv=none; b=nJGiyP1vINKAjGKB5gokVGYhB9gE4Uano+qm4iw9B6r68seL4GBurFq78lIcOXHDF9pGSebwY9M3VQQkXNm9gjZPARBgxIeoddSQUQ0yZtRYk91Xkx4m7lErKooT4NjGPd77ioR7MliONusy/1bKtl6DyL6GNJ0OzWJnRW5ncLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856301; c=relaxed/simple;
	bh=M9jHo6qT1i/PEAUcLFp5mnumkG/W4tuPZoGxIT+Uywc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUOxOsJa+jLIZ5OGIjQ2bdJbKG4nfFE/aWXjP1PQRp4R3fWiIZKfI6oPgyjLn1zynPQe0/cpDuvv7UvcD05q/EEte6wFd3T3w1zaIv/nzBMrcDLK2Skrsps6QvhMHJgEpHpTy6VD8+6HF5B8HLbWqShMqzT6dL8ZcflxRvR1UZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE7r1NbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE7r1NbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8BB1F00A3A;
	Fri, 24 Jul 2026 01:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856299;
	bh=jhb3eigDqzCWV2kB4WuUg64QcCCvrBR4mRx5r745Eus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fE7r1NbB2EUyuGqbyLJvmhibKMcOfnYB07rd1gtm83WBVefMzRanvYamOxJnHplIu
	 8IT9Bz+Zbqe8scWhLX+x2M4Dz8lrPxBJZd0hZMD0QRMPFdnlmFUdsWhtxV/8Gi2pQw
	 6hxd4j8SryQbjHIRguXota7cBmKsygczAlcGCnyWz+5OtlqaXzUjIya3C8SAd6iWGr
	 bREnrU756dbbi9Lybn/lPBzyQBev0cp16iPEvWvVUk/xOwDxN7QOF4lhlGqoyi8qE/
	 4fs3s8Rn5PMH9qtO9lVq3tvNU9dUogAgxvGUsOZosB2zDf1aAaZaCXQ9uyYlVm8q5e
	 Bd5viaQBfTTaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Georg Pfuetzenreuter <georg.pfuetzenreuter@suse.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/7] netfilter: nft_objref: validate objref and objrefmap expressions
Date: Thu, 23 Jul 2026 21:24:51 -0400
Message-ID: <20260724012453.3832653-5-sashal@kernel.org>
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

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit f359b809d54c6e3dd1d039b97e0b68390b0e53e4 ]

Referencing a synproxy stateful object from OUTPUT hook causes kernel
crash due to infinite recursive calls:

BUG: TASK stack guard page was hit at 000000008bda5b8c (stack is 000000003ab1c4a5..00000000494d8b12)
[...]
Call Trace:
 __find_rr_leaf+0x99/0x230
 fib6_table_lookup+0x13b/0x2d0
 ip6_pol_route+0xa4/0x400
 fib6_rule_lookup+0x156/0x240
 ip6_route_output_flags+0xc6/0x150
 __nf_ip6_route+0x23/0x50
 synproxy_send_tcp_ipv6+0x106/0x200
 synproxy_send_client_synack_ipv6+0x1aa/0x1f0
 nft_synproxy_do_eval+0x263/0x310
 nft_do_chain+0x5a8/0x5f0 [nf_tables
 nft_do_chain_inet+0x98/0x110
 nf_hook_slow+0x43/0xc0
 __ip6_local_out+0xf0/0x170
 ip6_local_out+0x17/0x70
 synproxy_send_tcp_ipv6+0x1a2/0x200
 synproxy_send_client_synack_ipv6+0x1aa/0x1f0
[...]

Implement objref and objrefmap expression validate functions.

Currently, only NFT_OBJECT_SYNPROXY object type requires validation.
This will also handle a jump to a chain using a synproxy object from the
OUTPUT hook.

Now when trying to reference a synproxy object in the OUTPUT hook, nft
will produce the following error:

synproxy_crash.nft: Error: Could not process rule: Operation not supported
  synproxy name mysynproxy
  ^^^^^^^^^^^^^^^^^^^^^^^^

Fixes: ee394f96ad75 ("netfilter: nft_synproxy: add synproxy stateful object support")
Reported-by: Georg Pfuetzenreuter <georg.pfuetzenreuter@suse.com>
Closes: https://bugzilla.suse.com/1250237
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: d07955dd34ec ("netfilter: nft_fib: reject fib expression on the netdev egress hook")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_objref.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index a789ff9463c3a7..35d8042464b300 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -22,6 +22,35 @@ static void nft_objref_eval(const struct nft_expr *expr,
 	obj->ops->eval(obj, regs, pkt);
 }
 
+static int nft_objref_validate_obj_type(const struct nft_ctx *ctx, u32 type)
+{
+	unsigned int hooks;
+
+	switch (type) {
+	case NFT_OBJECT_SYNPROXY:
+		if (ctx->family != NFPROTO_IPV4 &&
+		    ctx->family != NFPROTO_IPV6 &&
+		    ctx->family != NFPROTO_INET)
+			return -EOPNOTSUPP;
+
+		hooks = (1 << NF_INET_LOCAL_IN) | (1 << NF_INET_FORWARD);
+
+		return nft_chain_validate_hooks(ctx->chain, hooks);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int nft_objref_validate(const struct nft_ctx *ctx,
+			       const struct nft_expr *expr)
+{
+	struct nft_object *obj = nft_objref_priv(expr);
+
+	return nft_objref_validate_obj_type(ctx, obj->ops->type->type);
+}
+
 static int nft_objref_init(const struct nft_ctx *ctx,
 			   const struct nft_expr *expr,
 			   const struct nlattr * const tb[])
@@ -93,6 +122,7 @@ static const struct nft_expr_ops nft_objref_ops = {
 	.activate	= nft_objref_activate,
 	.deactivate	= nft_objref_deactivate,
 	.dump		= nft_objref_dump,
+	.validate	= nft_objref_validate,
 	.reduce		= NFT_REDUCE_READONLY,
 };
 
@@ -197,6 +227,14 @@ static void nft_objref_map_destroy(const struct nft_ctx *ctx,
 	nf_tables_destroy_set(ctx, priv->set);
 }
 
+static int nft_objref_map_validate(const struct nft_ctx *ctx,
+				   const struct nft_expr *expr)
+{
+	const struct nft_objref_map *priv = nft_expr_priv(expr);
+
+	return nft_objref_validate_obj_type(ctx, priv->set->objtype);
+}
+
 static struct nft_expr_type nft_objref_type;
 static const struct nft_expr_ops nft_objref_map_ops = {
 	.type		= &nft_objref_type,
@@ -207,6 +245,7 @@ static const struct nft_expr_ops nft_objref_map_ops = {
 	.deactivate	= nft_objref_map_deactivate,
 	.destroy	= nft_objref_map_destroy,
 	.dump		= nft_objref_map_dump,
+	.validate	= nft_objref_map_validate,
 	.reduce		= NFT_REDUCE_READONLY,
 };
 
-- 
2.53.0

