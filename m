Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196D1419A4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856299; cv=none; b=MWYcOjlMJtwBOb2EtTMsNaNsDBJjzc1AL6a1MdgmcppnR2eAsFykAhSAnWZat9M5qAlgk6onAV1TNyeok3alb4MjPNzdme2khnlReIauVhDrwNQwK0DRjSZEqpkPDsaJEOZASZaewj7d4BR7C5FbyQJXVLADMPg7uUM+yMdVOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856299; c=relaxed/simple;
	bh=F173nmeLKMLgddLG2DX5XCkh3HGLEgUq1VvPGSXzVqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx6CZaPqVMUQRBaynEBQjFkR/PbR3ka/MhrK2ZXsMolUk6nloajJrYctF7soGZt1CPJOIieamJ299byFb12nmwA/yda+S/Sc2W1RU/lZh6OCUARDMiqT2a3bCqfIdG3SjvI+qfUmC1PqlQM8PFYzz4t2qSmfsq3M/JLVKZlR47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moxrIC4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moxrIC4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229E01F00A3E;
	Fri, 24 Jul 2026 01:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856297;
	bh=q7uGdOc8dv2y1Zf1XWtg+Dg59OUg31bewtT6jv9h/K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=moxrIC4L+db8L/ggxihDEEHCocIKnJUei3QXSEMPxGNYyWKqhFpVu0wxov2ZoXAyq
	 66ZRohqGNLHBL9axHqcGso3IPuppgPTeXKAaNUBkey0LZftGD0kVFKGz9prgTr/x2x
	 G44SVjhRwTQLzUDC5IO1oyMIkfFsuLaM81DeleUMUsLbmxshRgMpG8D2gh87wibIVQ
	 TEIPRpg6k6/GX2lROJr+mxieHkryM0ANulqeneEiayNCfpVkFd8Kl36CwQduvTZ/cR
	 a5dNE5vouL6zWi6b/xP0+odrbZOONHgvZmpYOZ4eCKbxwxbTFpsEzdYnamGS3VDjpG
	 cO8MkrGit1j1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeremy Sowden <jeremy@azazel.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/7] netfilter: bitwise: rename some boolean operation functions
Date: Thu, 23 Jul 2026 21:24:49 -0400
Message-ID: <20260724012453.3832653-3-sashal@kernel.org>
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

From: Jeremy Sowden <jeremy@azazel.net>

[ Upstream commit a12143e6084c502fc3cfaa8b717bffc8c14cf806 ]

In the next patch we add support for doing AND, OR and XOR operations
directly in the kernel, so rename some functions and an enum constant
related to mask-and-xor boolean operations.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: d07955dd34ec ("netfilter: nft_fib: reject fib expression on the netdev egress hook")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter/nf_tables.h | 10 ++++---
 net/netfilter/nft_bitwise.c              | 34 ++++++++++++------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 557d57671cb517..d189eb427ab3c2 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -541,16 +541,20 @@ enum nft_immediate_attributes {
 /**
  * enum nft_bitwise_ops - nf_tables bitwise operations
  *
- * @NFT_BITWISE_BOOL: mask-and-xor operation used to implement NOT, AND, OR and
- *                    XOR boolean operations
+ * @NFT_BITWISE_MASK_XOR: mask-and-xor operation used to implement NOT, AND, OR
+ *                        and XOR boolean operations
  * @NFT_BITWISE_LSHIFT: left-shift operation
  * @NFT_BITWISE_RSHIFT: right-shift operation
  */
 enum nft_bitwise_ops {
-	NFT_BITWISE_BOOL,
+	NFT_BITWISE_MASK_XOR,
 	NFT_BITWISE_LSHIFT,
 	NFT_BITWISE_RSHIFT,
 };
+/*
+ * Old name for NFT_BITWISE_MASK_XOR.  Retained for backwards-compatibility.
+ */
+#define NFT_BITWISE_BOOL NFT_BITWISE_MASK_XOR
 
 /**
  * enum nft_bitwise_attributes - nf_tables bitwise expression netlink attributes
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index d8adee26ff0230..5b96f5a490ddaa 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -25,8 +25,8 @@ struct nft_bitwise {
 	struct nft_data		data;
 };
 
-static void nft_bitwise_eval_bool(u32 *dst, const u32 *src,
-				  const struct nft_bitwise *priv)
+static void nft_bitwise_eval_mask_xor(u32 *dst, const u32 *src,
+				      const struct nft_bitwise *priv)
 {
 	unsigned int i;
 
@@ -68,8 +68,8 @@ void nft_bitwise_eval(const struct nft_expr *expr,
 	u32 *dst = &regs->data[priv->dreg];
 
 	switch (priv->op) {
-	case NFT_BITWISE_BOOL:
-		nft_bitwise_eval_bool(dst, src, priv);
+	case NFT_BITWISE_MASK_XOR:
+		nft_bitwise_eval_mask_xor(dst, src, priv);
 		break;
 	case NFT_BITWISE_LSHIFT:
 		nft_bitwise_eval_lshift(dst, src, priv);
@@ -90,8 +90,8 @@ static const struct nla_policy nft_bitwise_policy[NFTA_BITWISE_MAX + 1] = {
 	[NFTA_BITWISE_DATA]	= { .type = NLA_NESTED },
 };
 
-static int nft_bitwise_init_bool(struct nft_bitwise *priv,
-				 const struct nlattr *const tb[])
+static int nft_bitwise_init_mask_xor(struct nft_bitwise *priv,
+				     const struct nlattr *const tb[])
 {
 	struct nft_data_desc mask = {
 		.type	= NFT_DATA_VALUE,
@@ -186,7 +186,7 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_BITWISE_OP]) {
 		priv->op = ntohl(nla_get_be32(tb[NFTA_BITWISE_OP]));
 		switch (priv->op) {
-		case NFT_BITWISE_BOOL:
+		case NFT_BITWISE_MASK_XOR:
 		case NFT_BITWISE_LSHIFT:
 		case NFT_BITWISE_RSHIFT:
 			break;
@@ -194,12 +194,12 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 			return -EOPNOTSUPP;
 		}
 	} else {
-		priv->op = NFT_BITWISE_BOOL;
+		priv->op = NFT_BITWISE_MASK_XOR;
 	}
 
 	switch(priv->op) {
-	case NFT_BITWISE_BOOL:
-		err = nft_bitwise_init_bool(priv, tb);
+	case NFT_BITWISE_MASK_XOR:
+		err = nft_bitwise_init_mask_xor(priv, tb);
 		break;
 	case NFT_BITWISE_LSHIFT:
 	case NFT_BITWISE_RSHIFT:
@@ -210,8 +210,8 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 	return err;
 }
 
-static int nft_bitwise_dump_bool(struct sk_buff *skb,
-				 const struct nft_bitwise *priv)
+static int nft_bitwise_dump_mask_xor(struct sk_buff *skb,
+				     const struct nft_bitwise *priv)
 {
 	if (nft_data_dump(skb, NFTA_BITWISE_MASK, &priv->mask,
 			  NFT_DATA_VALUE, priv->len) < 0)
@@ -248,8 +248,8 @@ static int nft_bitwise_dump(struct sk_buff *skb, const struct nft_expr *expr)
 		return -1;
 
 	switch (priv->op) {
-	case NFT_BITWISE_BOOL:
-		err = nft_bitwise_dump_bool(skb, priv);
+	case NFT_BITWISE_MASK_XOR:
+		err = nft_bitwise_dump_mask_xor(skb, priv);
 		break;
 	case NFT_BITWISE_LSHIFT:
 	case NFT_BITWISE_RSHIFT:
@@ -269,7 +269,7 @@ static int nft_bitwise_offload(struct nft_offload_ctx *ctx,
 	const struct nft_bitwise *priv = nft_expr_priv(expr);
 	struct nft_offload_reg *reg = &ctx->regs[priv->dreg];
 
-	if (priv->op != NFT_BITWISE_BOOL)
+	if (priv->op != NFT_BITWISE_MASK_XOR)
 		return -EOPNOTSUPP;
 
 	if (memcmp(&priv->xor, &zero, sizeof(priv->xor)) ||
@@ -405,7 +405,7 @@ nft_bitwise_fast_dump(struct sk_buff *skb, const struct nft_expr *expr)
 		return -1;
 	if (nla_put_be32(skb, NFTA_BITWISE_LEN, htonl(sizeof(u32))))
 		return -1;
-	if (nla_put_be32(skb, NFTA_BITWISE_OP, htonl(NFT_BITWISE_BOOL)))
+	if (nla_put_be32(skb, NFTA_BITWISE_OP, htonl(NFT_BITWISE_MASK_XOR)))
 		return -1;
 
 	data.data[0] = priv->mask;
@@ -500,7 +500,7 @@ nft_bitwise_select_ops(const struct nft_ctx *ctx,
 		return &nft_bitwise_ops;
 
 	if (tb[NFTA_BITWISE_OP] &&
-	    ntohl(nla_get_be32(tb[NFTA_BITWISE_OP])) != NFT_BITWISE_BOOL)
+	    ntohl(nla_get_be32(tb[NFTA_BITWISE_OP])) != NFT_BITWISE_MASK_XOR)
 		return &nft_bitwise_ops;
 
 	return &nft_bitwise_fast_ops;
-- 
2.53.0

