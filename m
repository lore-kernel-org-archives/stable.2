Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960016;
	b=DopOSfk5Yl2WSOIAjgwr8yZv8bDig9oDG6XSpi6zJ3qqOtDcs0i5nfA9IrVpxrRKMATT
	 vcT6xYFcEnZuYuZ1SFfetylv5HxL3gJFtjz1D+aQu+2VjQrxOCGPnS9txUkpkT7PrK3mF
	 RQu2mMI5gP5ihgcV1DH+AfRj+oKr3PEGcmwjt7Iw6JvOlcimm5DwIXQ/aa4D316//esAV
	 lPkiKCosk7RIHRv+yVfq6ZqmkhY22OqDDVeFB/WGDtftGjYEijsXuUe4ic9hgWHgwIwPS
	 gi3MdIVYKcW0gG9dabnuFe8FNLYdrENPe6wBIrnx7+EImwo/Rtkl0MN09vGj2P+G7EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960016;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=nSN+SS/xWEmX0uluH00n+7Fo09oiXXY4X9iDNZHNqAY=;
	b=SADbQ7PmUN3s9j2ZC4EIUu9jwQ6xmqKZXbCxKP0fKyKzeyH//7QOhrsYf9Lxc/y3Bnrg
	 nsvhhvB+yCCsdSAhE29rvLVtrLju+aOpTG/m3D5MWZlaL2sxNioQNO0nLDN+iV4X7yKLV
	 bSiPtFHbsUrBSeqGVoF4SKfmtpMj9vKpoSNbQMf/NYXwvFsD3QXrHJZWqQz4e3Kt6lLPA
	 DS0Dtw5ubUKIhQsmdiSdT1wUP10d/EVdZJ6f+vy+n1mjPK3JTwZlXSbfrrvzBPAmOICsw
	 BzWqGS+C47cZ6KUU5AvhCJJD1D0YTlSn/rwc9dWDKiFNlWPTvMJElE0Y1gDA+xvDZxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=eZRBbHM6;
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523B606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7523B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=eZRBbHM6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794960016; x=1826496016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nSN+SS/xWEmX0uluH00n+7Fo09oiXXY4X9iDNZHNqAY=;
  b=eZRBbHM6O9RFhAdZ9dmBc0JNzacrmGhEBwFlBW38TcANoC2EXYvuh6tl
   WmbaXXolm+jFzsIBXRKkxBzY9OP6WEYrISnN5pIGARX6empzoZye+AkLY
   HyqH0NVBtYYz3TuaoHMJg7cI0YNAc3+ZiC3UgLJXyrrPnSLrecT1WcwGM
   kwqjpzsy9gdp67QEgq4tuHNP8Mf8mHSGy9jlnowa9DhD1v4dtWQKf18Z7
   Rm5rdBY4ipHVGi06usYl5M5UCZpm0qLsVsszaUrU7IODEvNR+vf92s/SB
   cLBk1O4Nyb+Fx/mejZdFMCHuxg6oX5igQlxINJJyFWiDGCS4gapDZyGRH
   Q==;
X-CSE-ConnectionGUID: tWD7gFe0Rx67ONRE05NWrw==
X-CSE-MsgGUID: S8EOl67cRy+HYpzMInPzBA==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34389915"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:00:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:1890]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.141:2525] with esmtp (Farcaster)
 id ee4580d5-1023-4ce4-a87d-ac70adcf245a; Wed, 18 Nov 2026 00:00:15 +0000 (UTC)
X-Farcaster-Flow-ID: ee4580d5-1023-4ce4-a87d-ac70adcf245a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 00:00:15 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 00:00:15 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 5.15.y 1/2] netfilter: nft_ct: expectation timeouts are passed in milliseconds
Date: Wed, 18 Nov 2026 00:00:01 +0000
Message-ID: <20261118000000.835231-2-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118000000.835231-1-mkbund@amazon.com>
References: <20261118000000.835231-1-mkbund@amazon.com>
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
[ b8b09dc2bf35 ("netfilter: nf_conntrack_expect: use conntrack GC to
  reap expectations") is not backported because it replaces the
  expectation timer with GC reaping in 9 files, so timer_list expires is
  set, and mod_timer_pending() after insert. ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 net/netfilter/nft_ct.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 4e723257f356..af58d86b0783 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1184,11 +1184,23 @@ struct nft_ct_expect_obj {
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
@@ -1224,8 +1236,11 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
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
@@ -1245,7 +1260,7 @@ static int nft_ct_expect_obj_dump(struct sk_buff *skb,
 	if (nla_put_be16(skb, NFTA_CT_EXPECT_L3PROTO, htons(priv->l3num)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_L4PROTO, priv->l4proto) ||
 	    nla_put_be16(skb, NFTA_CT_EXPECT_DPORT, priv->dport) ||
-	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, priv->timeout) ||
+	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, jiffies_to_msecs(priv->timeout)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_SIZE, priv->size))
 		return -1;
 
@@ -1295,7 +1310,7 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
 		          &ct->tuplehash[!dir].tuple.src.u3,
 		          &ct->tuplehash[!dir].tuple.dst.u3,
 		          priv->l4proto, NULL, &priv->dport);
-	exp->timeout.expires = jiffies + priv->timeout * HZ;
+	exp->timeout.expires = jiffies + priv->timeout;
 
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;

base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
-- 
2.50.1

