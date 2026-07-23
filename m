Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883EC39524B
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825665; cv=none; b=HZYh0PmPr1SsfLeJ9m2E7ohji7ks1Z+BdZXguoyR6Y0SfkUsHtaPPJ0C++iBmaIDrubaLXX75g7a+JKtlO3keC3bARBU7jhFWkiGaNyhDMIe2waGNe9T4uhObPTYYa8Bv08iK85v9XVT30l1AX8QH/TAE/kjC1OTZ/ZXVYoH2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825665; c=relaxed/simple;
	bh=FflLKKUeF2IJAmHm9dpRD4wRW3OPH965950QZnG84Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPyhu0p/6kcxJ3FeLcTSrJOuKeBKfIACBt/M3rN77RlXncRtYrUpMDCUnrtFM5qZcUz7b3vVYqsFwCV/b0v31XFz46hCDNBxVLjE8YbHTjhWjAwOL845ewcJx7MMSoRWqoszDr1c05eUQCPixqFW1qz2fVwYnKKAHT696LGcpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LklllUHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LklllUHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC401F00ACA;
	Thu, 23 Jul 2026 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825664;
	bh=yIMlYsKk8weA3GABQXSDgE285Xppf6cs32XrfdiWiCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LklllUHBGUoxFd+B8Av1S22kIQ0C25duM2/GjmZWIS48wuwj+GsEVQmDjPN+jxiqM
	 fILHyHpcghH2rSObuadqIEDVwvZ9kfmFfhUszcsjprarqyZ+5uc/JU9jIV3zJmASGQ
	 KsDXAo4mqeaQKziKQkDNSgEoUHx6TUWwLOc4TZpXrEaYzt49oyXGbNOQczEGPNHD5W
	 b6G0cDq9CHhObFBIWlQjAN0rqqDt7nPegFTEDVSZuzdzxVetYx+/4Pl/70e9rzj/jk
	 F4CuudvS3zSM/hqnMk2nD6zmqOqUrFjgDLTw3mjIvhgoyBagMZzeFDiEqwd5rLX96H
	 BZAa7SJojxmKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] netfilter: nft_fib: reject fib expression on the netdev egress hook
Date: Thu, 23 Jul 2026 12:54:19 -0400
Message-ID: <20260723165419.3390514-4-sashal@kernel.org>
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
index cf76733d9c0e36..7b2a0a031c4b4f 100644
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

