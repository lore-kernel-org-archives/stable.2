Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959550;
	b=oBl75DN9pnBFOvPYxoYQi1+eCNE5nEuCF/vjKk+XeEvuh8OtE8H1mYS+MiHihr3AIk/k
	 n0cPc/GJixhHYRZcLA1qwLshP2wKW18XXnFRD/b7FzKDQFyN/7DZrZqmnT5P3pvBKAuqe
	 PLE4/ffopuwqVjCXJxH2gyUguYwCofPCwNMj1R/9K6KJHLii1mUxR0MCpxpF1u1oJO2Ib
	 OiWk7M4+j5bNp0p4WZbh1eFv0Gm+Q4OC5eDDx0lILySfcv1c8bl/qqGcKbmKDUmDw15g6
	 pavTP4W7Gg704CrmFJccFeLEVFlrXq00N552momw0tG7Pimf+pVNdbgk1Lm5yCmBnUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959550;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=oWkSB2ShHnqVygwDWqcRrxzRCFGN1dAXAkhLbD5y+bo=;
	b=TfFg0J2n93Ye4rFaIR6n4JRh53PdwsZhTOYSh0tRbj7l2A4WkMzYGuZVg0+w+kXVaxdb
	 EvYIH5WsD3bVxSsm3CBHVsP7UodJ6PzsoY4wDlWOlLrm/ugOIyRvsDNDQ1jMANVNdTjjZ
	 sAN0Z4iegR7gJeLZaN7VSMmH5Fq7fWGOxwBLTzpRyMD4MJa3H3vVsddexIDSdoG8gU9Go
	 mP8Fx6jlefXide7UT9NxvcU/AIiHLxvRmtlj6HJ5k4Xb2G4+HswQzPy1rmPZ5W7fV3VCJ
	 K0bVqPKtqOer9oMjW58HRUHTAGwdHecZsBKf+1SVtTry8hjpIQZxF2EAqpWOysp+Pvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=T2JrYvWz;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25F606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D25F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=T2JrYvWz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794959549; x=1826495549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWkSB2ShHnqVygwDWqcRrxzRCFGN1dAXAkhLbD5y+bo=;
  b=T2JrYvWzjS62LQQ4Ez9NKwbaffnkV+MIpCh+03XAZHeW+6pWdeSDnNZ6
   9BIIRs4VZmNJqwI3KX6hDQOYWimHVqrm+4U7ooF4NwkFmH/llvH+sJfvH
   9HZH+kuDpIT3HbhPPciRExjUloHiZM0lPTnh1De5BV61URACAdduk4xlE
   YAnsY8UJKDVNQp2bhcUd84TuKdOws1lYxNNIn+sRLwg28wFBDxaYMKV9l
   2fdI3IibLvk7LCnmYOcXdE9wI6X798ub3Rg6xP3RLprVIp5WJyQlgSdho
   5APj3GDMsMKk4jJwWkZqD8nshyvs/eCsrdrptCJ7sW/lAVwdFVPKLsKau
   A==;
X-CSE-ConnectionGUID: ATdLT+KMSea8uzACvhmUhA==
X-CSE-MsgGUID: zFIHElDEQsm7osa0FE30pg==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34242039"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:52:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:26829]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id 9ef97c0c-bdc5-49fb-ab67-7362ddc8e56e; Tue, 17 Nov 2026 23:52:28 +0000 (UTC)
X-Farcaster-Flow-ID: 9ef97c0c-bdc5-49fb-ab67-7362ddc8e56e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:52:28 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:52:28 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.6.y 1/2] netfilter: nft_ct: expectation timeouts are passed in milliseconds
Date: Tue, 17 Nov 2026 23:52:15 +0000
Message-ID: <20261117235214.366021-2-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261117235214.366021-1-mkbund@amazon.com>
References: <20261117235214.366021-1-mkbund@amazon.com>
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
index 3a4f5c4da0e3..13e47c7b4278 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1198,11 +1198,23 @@ struct nft_ct_expect_obj {
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
@@ -1238,8 +1250,11 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
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
@@ -1259,7 +1274,7 @@ static int nft_ct_expect_obj_dump(struct sk_buff *skb,
 	if (nla_put_be16(skb, NFTA_CT_EXPECT_L3PROTO, htons(priv->l3num)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_L4PROTO, priv->l4proto) ||
 	    nla_put_be16(skb, NFTA_CT_EXPECT_DPORT, priv->dport) ||
-	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, priv->timeout) ||
+	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, jiffies_to_msecs(priv->timeout)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_SIZE, priv->size))
 		return -1;
 
@@ -1309,7 +1324,7 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
 		          &ct->tuplehash[!dir].tuple.src.u3,
 		          &ct->tuplehash[!dir].tuple.dst.u3,
 		          priv->l4proto, NULL, &priv->dport);
-	exp->timeout += priv->timeout * HZ;
+	exp->timeout += priv->timeout;
 
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.50.1

