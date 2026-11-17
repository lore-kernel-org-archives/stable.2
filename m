Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959579;
	b=IxOuUeMj3VqVPPGQdfMg0kJdzgy348osyvKnwykWyAECjXyBVF8Ozn8FhPmaHBcKj8y5
	 Bkk3ZeAIAsd8ohrTu+1aE7LoVpT9fvYLFOtUFpcsFjHo43A5573PEqvP4CEGMvZ2LUgwW
	 NmGo17QZuW+ZJgB5FTsM9m0r8oPLjavb5ZLPowcLJ4rNZtA9AYvywHKiIohux9QGuY8oS
	 RmCGfKdfKwcdArtfg7WB0yc10zQ/aNeI353AF+gKpgmDelDZHJJmBE7GgmBLGbxVM/d/b
	 fK/StWI3hSL3k/J23xukH8qE5POvcE+qyP88d79tvKKpxwSi4cksx/R51n8J0mZWxeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959579;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=9v2Fut+BdgS5HIRNiBVlCEl4ojLDGMGwDg2dU2sNmt8=;
	b=jnewBQmzgFZzEvfdfs42wHnI1Ve0T6YimgsHjdnFvewpejF6Riw0TdmE6pqKMgG5S8eM
	 Hp5+1aOcHxIzhRWtk+S+JnY4PFKMzb+uFuJX0qv1l/hhnTH8bKr1/onuGEPrDPusGYWH5
	 +zBXss5eQG7vQPNix4PKgzgOQW3kOsQ+KaxhR5FJb/ty6Cbbg2b3s//zpdc3wyqtO/Y+V
	 jU8QU6mQ5cQw8GlbKQQv61u8xA6Za12JgJnKugb5DLBTWCDv7PfQizP0SeQfuLMCbgQ3B
	 8JLyiCkQ9ZiSIdvbamE7yJwZvMl0qSHYzTQIvfYF6665OsgxH8wpaqNLepx39I3h+Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=W2zPv66b;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F3606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D7F3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=W2zPv66b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794959579; x=1826495579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9v2Fut+BdgS5HIRNiBVlCEl4ojLDGMGwDg2dU2sNmt8=;
  b=W2zPv66b8rUR5yF3MjzFY9YAk7wLWRaOMxnm122B7IZkLnsnirs4de8j
   LuTnYDkaOLEfQrymKWsJpMarvg2HY6MX47v8ciGxw4G3tVaZLywkAxSER
   wmqFZwqZY/l7Gi4sIXSbaXM+UOWqY/cx3w21jJkAbY5Aw1oGgh4E3dccb
   x50UsZ6qYF0BE1KXOM9hp9Jr1yD/s5DRfMLF0uvSBalvI68yYEN64x8Ym
   n0cT5fpYEwg8SgJYnxHaPUPg+q5DallN8WpRKOGg0+EKtzZobovBdnXd8
   JEVMt1AD4TUW+NM8NYq4UWu1ZfbUwvhmF3vB8l+1dkQ2EVSOrx3PbP0VB
   g==;
X-CSE-ConnectionGUID: V60lEtobQKSdi9unUCINxw==
X-CSE-MsgGUID: nL7RIXvnQaSJrg+iHD0qmA==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34242074"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:52:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:30526]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.141:2525] with esmtp (Farcaster)
 id 0208262f-002e-4c49-a7a0-c1bd3fce9032; Tue, 17 Nov 2026 23:52:58 +0000 (UTC)
X-Farcaster-Flow-ID: 0208262f-002e-4c49-a7a0-c1bd3fce9032
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:52:58 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:52:58 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.1.y 1/2] netfilter: nft_ct: expectation timeouts are passed in milliseconds
Date: Tue, 17 Nov 2026 23:52:47 +0000
Message-ID: <20261117235246.984294-2-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261117235246.984294-1-mkbund@amazon.com>
References: <20261117235246.984294-1-mkbund@amazon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 6fb421bd07f156cdf0cdede062d31f1c21def326 ]

Userspace passes '5000' in case user asks for 5 seconds.

Allowing for sub-second expectation lifetimes makes sense to me. so
fix up the kernel side instead of munging nft to send a value rounded
up to next second.

Also note that this violates nft convention of passing integers in
network byte order, but we can't change this anymore.

Fixes: 857b46027d6f ("netfilter: nft_ct: add ct expectations support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 3679da4ad8be ("netfilter: nft_ct: move custom expectation support to helper")
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 net/netfilter/nft_ct.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index f789c6c8f146..fbe83e879654 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1229,11 +1229,23 @@ struct nft_ct_expect_obj {
 	u32		timeout;
 };
 
+static int nft_ct_expect_timeout_get(const struct nlattr *attr, u32 *val)
+{
+	unsigned long jiffies_val = msecs_to_jiffies(nla_get_u32(attr));
+
+	if (jiffies_val > UINT_MAX)
+		return -ERANGE;
+
+	*val = jiffies_val;
+	return 0;
+}
+
 static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 				  const struct nlattr * const tb[],
 				  struct nft_object *obj)
 {
 	struct nft_ct_expect_obj *priv = nft_obj_data(obj);
+	int err;
 
 	if (!tb[NFTA_CT_EXPECT_L4PROTO] ||
 	    !tb[NFTA_CT_EXPECT_DPORT] ||
@@ -1269,8 +1281,11 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
+	err = nft_ct_expect_timeout_get(tb[NFTA_CT_EXPECT_TIMEOUT], &priv->timeout);
+	if (err)
+		return err;
+
 	priv->dport = nla_get_be16(tb[NFTA_CT_EXPECT_DPORT]);
-	priv->timeout = nla_get_u32(tb[NFTA_CT_EXPECT_TIMEOUT]);
 	priv->size = nla_get_u8(tb[NFTA_CT_EXPECT_SIZE]);
 
 	return nf_ct_netns_get(ctx->net, ctx->family);
@@ -1290,7 +1305,7 @@ static int nft_ct_expect_obj_dump(struct sk_buff *skb,
 	if (nla_put_be16(skb, NFTA_CT_EXPECT_L3PROTO, htons(priv->l3num)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_L4PROTO, priv->l4proto) ||
 	    nla_put_be16(skb, NFTA_CT_EXPECT_DPORT, priv->dport) ||
-	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, priv->timeout) ||
+	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, jiffies_to_msecs(priv->timeout)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_SIZE, priv->size))
 		return -1;
 
@@ -1340,7 +1355,7 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
 		          &ct->tuplehash[!dir].tuple.src.u3,
 		          &ct->tuplehash[!dir].tuple.dst.u3,
 		          priv->l4proto, NULL, &priv->dport);
-	exp->timeout += priv->timeout * HZ;
+	exp->timeout += priv->timeout;
 
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.50.1

