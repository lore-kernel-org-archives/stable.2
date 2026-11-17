Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957798;
	b=oXswkHfDGdyeOsZUK2kOMugJknf6pRz+fTUImWuAolC23My028VFJgs0tpdb+AXuCP4Z
	 zA8187KaUXEEiN+qPHud547A39OLqfZouHBBA0EwOOryxso2DX58V+GMY7XylcmRfVQZ6
	 UlgFhF/+zIYTb6vA6PpkjY8Reolgy8ABOZj6i5+xJdBCI/9+q1jpg00WvskeFJC+yxPnZ
	 SgIrPZIB81HUOqWMvSWZMiBTn4H+8zgGvgkifTj5uHeps7Pt/MCfFkOIv6SriEIMdbsQU
	 lu9ISR/W/T+oUBU86ndiYSLKBQMcOAMFpp7lGTiXIcMAKi33oIBneJK3Li12sebTk1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957798;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Pf3vjdzLJiQW7c/7UNBE06vc3y4sVUGvguXxo+4FX28=;
	b=GIhhqt385NFoBxjgRBqnVzHJ6Uy4XoBsUZzIs5KNuhzPN+gpB89eDC+N3DocB7HlVS/t
	 8tr5KFxVkOaFXon75lbcF7EmdsqxIy6hf7gFN1aaT9RCHD6jJG7j3NPMXNhuZ1lb3+4z/
	 X6UxMclQIbhOJl0FgyRu+RvPba58j6F37gV1r61ay/JzR2ONhKVLARC93roXRJyqH6l73
	 IBbA7PxQs6SjwaaGf4TsrhJV79vIsxwOAu/AOzncbCgSn7WXMoL0lu9qWk69RV5gQpbDP
	 wXDfPmDjuN6EsvBDNrTxsNY2TmvibVEgOxekumVPlwcGHSOMlbeWg/HMGjfasRqd49g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=DLEcWwGG;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC2606A880
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66DC2606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=DLEcWwGG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794957798; x=1826493798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pf3vjdzLJiQW7c/7UNBE06vc3y4sVUGvguXxo+4FX28=;
  b=DLEcWwGGUdk85J1PPo1E1rw8dPzCTlwmtLYq6M8cCsDDfV2D+moazPDC
   /lnTPB+PbwYOTvhB5kNta1skpmoNM7ZG1jt7H5ggDjBUYc6Ev1FNJp4wf
   KE6HJBxPJ1XgTtAR8m2UbXIFhTzIyftEcmGS+J1ReZwje1G3VKBxYYNUJ
   pPdsfLf6e/1xkprHh1ZyumtbJLsdxBFsYC7utKc9QRYzv4q3JLnSyONfM
   klSdoKl1U3l4es9eOfoxbWLHcj1QmcATmwiy8CnZg2ST68OcvF/mZ97z8
   y25KMObZYIrXbg0880Ok6rFI9yogvE81s5F7UkGgp9jbjNE4SDcYs1tE2
   A==;
X-CSE-ConnectionGUID: Vl6S03XAQKibU5hfrTa7wA==
X-CSE-MsgGUID: tFUvKMliTLCpTykBrawNag==
X-IronPort-AV: E=Sophos;i="6.27,218,1787011200"; 
   d="scan'208";a="34313107"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:23:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1072]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id e6777825-ce2f-4c4b-b5b3-9da027269a88; Tue, 17 Nov 2026 23:23:17 +0000 (UTC)
X-Farcaster-Flow-ID: e6777825-ce2f-4c4b-b5b3-9da027269a88
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:23:17 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:23:17 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.18.y 1/2] netfilter: nft_ct: expectation timeouts are passed in milliseconds
Date: Tue, 17 Nov 2026 23:23:06 +0000
Message-ID: <20261117232211.stolba-3679da4ad8be-linux-6.18.y-v1-1@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261117232211.stolba-3679da4ad8be-linux-6.18.y-v1-0@amazon.com>
References: <20261117232211.stolba-3679da4ad8be-linux-6.18.y-v1-0@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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
index 11d99778216f..4687fc244eaf 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1217,11 +1217,23 @@ struct nft_ct_expect_obj {
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
@@ -1257,8 +1269,11 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
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
@@ -1278,7 +1293,7 @@ static int nft_ct_expect_obj_dump(struct sk_buff *skb,
 	if (nla_put_be16(skb, NFTA_CT_EXPECT_L3PROTO, htons(priv->l3num)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_L4PROTO, priv->l4proto) ||
 	    nla_put_be16(skb, NFTA_CT_EXPECT_DPORT, priv->dport) ||
-	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, priv->timeout) ||
+	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, jiffies_to_msecs(priv->timeout)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_SIZE, priv->size))
 		return -1;
 
@@ -1328,7 +1343,7 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
 		          &ct->tuplehash[!dir].tuple.src.u3,
 		          &ct->tuplehash[!dir].tuple.dst.u3,
 		          priv->l4proto, NULL, &priv->dport);
-	exp->timeout += priv->timeout * HZ;
+	exp->timeout += priv->timeout;
 
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;

base-commit: fd7cfd39c88596fec816639ad83cbf3e9d316372
-- 
2.50.1

