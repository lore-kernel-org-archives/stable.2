Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221B375ADC
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836728; cv=none; b=tlMxAyuoeZ4C3R+3XjVKXMy8/rQU3CxbhNtdGjnAImcq9lU34yaDGfInPf62H3+IMX6n5E/hKV1DjWwZzz2So4v/uNYFOthMWVpOuNX87qpLnkvh3P8JsdXOvaKjICtxAeik8Bsxm75bOPYeu8lL5xNvfYwUXmnLJ9/RBRH2UV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836728; c=relaxed/simple;
	bh=tSVgSX4vOhP473ECENXwrDS8X2wXucTpW6PXlnjujos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNX9SldF94u6uOw3nlmuP8uinHd4k6hLmlNgBoO+SFRK90q9Ku4jezXtXOEOGFPS6z9W31RSHRxmW9PgDtNfqLncuxGT7LUXUmyxbJW/ceyyJDsZBbIZAbHcE8U9IpJAZiq/Zq9ZPfqALeuTVj4zjHmFfrADBMdWq4IMXbF583Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgCmO0tK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgCmO0tK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688471F00A3D;
	Thu, 23 Jul 2026 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836726;
	bh=WJz79Gh09nR+oQRAjPd/kqCFnh66vIQyWIahrBleKkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UgCmO0tKyOrKL7L2WANPaBcILK+4bqMtgpPDAMUwUU3zaIXcRBN4oZHlEx4sXtEPE
	 T/TYGKpmEhAsrMd0hmvYm2QKYCAkpZ9KR18ZCavw4kSABm1Xnul6KJm847v8O99czr
	 Z2EENJB9P8ZbiBmhaAQM5Dp+clI36SD1zdG93WpBQZxVt6M2boEb5GLYRUbGfzSR44
	 dnKSJtMLBxtNC/6aA1GvuPeC5qOajWaA3W4E9FgPi3LCybxfNL5mQB7iymVdeCJLFA
	 sjIXFfiVk7ZNoWffH6hyam+S7N11dMxKalvzAkhfCk168Bc9ZC4igK6/lZdBwiBjfu
	 eDkmhSshuC1jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] netfilter: nft_fib: reject fib expression on the netdev egress hook
Date: Thu, 23 Jul 2026 15:58:42 -0400
Message-ID: <20260723195842.3683768-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723195842.3683768-1-sashal@kernel.org>
References: <2026072054-folic-tartly-6b52@gregkh>
 <20260723195842.3683768-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>

[ Upstream commit d07955dd34ecae17d35d8c7d0a273a3fba653a8c ]

A fib expression in a netdev egress base chain dereferences nft_in(pkt),
NULL on the transmit path, causing a NULL pointer dereference at eval.
nft_fib_validate() masks the hook with NF_INET_* values, but netdev hook
numbers are a separate enum that aliases them (NF_NETDEV_EGRESS ==
NF_INET_LOCAL_IN), so an egress chain passes validation and then faults.

Add nft_fib_netdev_validate() that limits each result/flag to the netdev
hook where the device it reads exists: the input-device cases (OIF,
OIFNAME, ADDRTYPE with F_IIF) to ingress, the output-device case (ADDRTYPE
with F_OIF) to egress, ADDRTYPE with no device flag to both. Also restrict
nft_fib_validate() to NFPROTO_IPV4/IPV6/INET so its NF_INET_* masks are
not applied to another family's hooks.

Fixes: 42df6e1d221d ("netfilter: Introduce egress hook")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netfilter-devel/ajxsjcDOnwllMfoR@strlen.de/
Signed-off-by: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_fib.c        |  9 +++++++++
 net/netfilter/nft_fib_netdev.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 889a9cbc7071ca..016957296db29c 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -31,6 +31,15 @@ int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr)
 	const struct nft_fib *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	switch (ctx->family) {
+	case NFPROTO_IPV4:
+	case NFPROTO_IPV6:
+	case NFPROTO_INET:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
 	case NFT_FIB_RESULT_OIFNAME:
diff --git a/net/netfilter/nft_fib_netdev.c b/net/netfilter/nft_fib_netdev.c
index 3f3478abd84546..5774a754402780 100644
--- a/net/netfilter/nft_fib_netdev.c
+++ b/net/netfilter/nft_fib_netdev.c
@@ -50,6 +50,33 @@ static void nft_fib_netdev_eval(const struct nft_expr *expr,
 	regs->verdict.code = NFT_BREAK;
 }
 
+static int nft_fib_netdev_validate(const struct nft_ctx *ctx,
+				   const struct nft_expr *expr)
+{
+	const struct nft_fib *priv = nft_expr_priv(expr);
+	unsigned int hooks;
+
+	switch (priv->result) {
+	case NFT_FIB_RESULT_OIF:
+	case NFT_FIB_RESULT_OIFNAME:
+		hooks = (1 << NF_NETDEV_INGRESS);
+		break;
+	case NFT_FIB_RESULT_ADDRTYPE:
+		if (priv->flags & NFTA_FIB_F_IIF)
+			hooks = (1 << NF_NETDEV_INGRESS);
+		else if (priv->flags & NFTA_FIB_F_OIF)
+			hooks = (1 << NF_NETDEV_EGRESS);
+		else
+			hooks = (1 << NF_NETDEV_INGRESS) |
+				(1 << NF_NETDEV_EGRESS);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return nft_chain_validate_hooks(ctx->chain, hooks);
+}
+
 static struct nft_expr_type nft_fib_netdev_type;
 static const struct nft_expr_ops nft_fib_netdev_ops = {
 	.type		= &nft_fib_netdev_type,
@@ -57,7 +84,7 @@ static const struct nft_expr_ops nft_fib_netdev_ops = {
 	.eval		= nft_fib_netdev_eval,
 	.init		= nft_fib_init,
 	.dump		= nft_fib_dump,
-	.validate	= nft_fib_validate,
+	.validate	= nft_fib_netdev_validate,
 };
 
 static struct nft_expr_type nft_fib_netdev_type __read_mostly = {
-- 
2.53.0

