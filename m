Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959206;
	b=BJO10KBe1x6Yx9YxN/loTtrHnWvWw+fgTYfk3/AYUArgGxZKqwsIaGpKh0lBFSK3LEo9
	 hw8dpJ6ov24j6j+TBEuuxETmbWKfcPsebpKPwkRgi5efZDnzqvkmy6nj8v60sfvZQEDpG
	 Hanx68nAB+n9O2ZqHWZraplS0Vcsb+fiFSJgjUAOK8Vnujho1nj0GHFhviXCP9Og77bNn
	 IgiNKdqaSOu7FmcoOMz/o9NEpJEvApn/Bw+RepcNsv8wnFS5HZQjIJoj3/td4qApxTwAC
	 4W/SuaS9v4CuPUyA4+dUGKnDAd3J0rNdHCqWYUwQw+KRdmrNGWNyhneNGvjEIXxDYsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959206;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=9qAWZK0hKE+8PFO+BwnTcoztvBQjHFF9dUSJndvdzhQ=;
	b=a+hSIKQpE/eMpXNyQ+dh07uH5EYBdxb3bAOzWO6OQ6KGHy+/G+uph3tnE3U7S8BHFUu8
	 gnMGfmbS/EbVMupHG8pw4kvlt/itknsGu8UMDEDfDG9DPMtaaI2oXAS3C2EQvqjo03ZYn
	 wvObXLMkpm1ax+vacXoWSd69u6+rVpotAqIeGq22tHBuhGYf1H6mrahI+CGltry24f78W
	 AHNGvmnUcPlcCmuzhrtPxbCVqqNv7TxaZ7KA4LwEMgdZXqGpvi/K9mrkCsBI6NKr9Dx8P
	 FYBX0Flh9nrvqKJ4NJbifDTtCFD+6cBJZKtBoc6VoNf+pxIGwHgLKUBEeV2rpvI4tyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=J+AcjquV;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E220606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E220606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=J+AcjquV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794959206; x=1826495206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qAWZK0hKE+8PFO+BwnTcoztvBQjHFF9dUSJndvdzhQ=;
  b=J+AcjquVf71nltbNWbmfcho3K6yPRSiPZHn9oxQIGSWREbvyrhuyBFDd
   Wcclsr1vbZ144brZoUiIKwbeK+u0cYW6ReI8CzoxdEPBB1cfbh6Su7Mj+
   VaPd/il6eclVpqkFVdkvXwwcw3oNF+NHFPgqLl8xXYz+njOs0YoV7IDUv
   q0v/KTq9UPR2P1WSIgJvE5ccYftlzq4Cl67o5Kali3E2AOfxjKimb8lDu
   +rVELJUeX5AW7T/4yrmeAm80oHsEWjJ7qii4AUNv+IB9mRNGLvtYNs+dS
   2Hnh18J998uax3/Uz8etqteRxizGwEkx86t3YzFBY71ZCLXBlVtcntRjT
   w==;
X-CSE-ConnectionGUID: X9ZyAQVoR3qcF1LzeAMRUQ==
X-CSE-MsgGUID: xgii77gQT5muuVscqUsZxw==
X-IronPort-AV: E=Sophos;i="6.27,218,1787011200"; 
   d="scan'208";a="34212842"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:46:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:15432]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id c79dff3b-d695-4180-b864-7cf251cc19fa; Tue, 17 Nov 2026 23:46:44 +0000 (UTC)
X-Farcaster-Flow-ID: c79dff3b-d695-4180-b864-7cf251cc19fa
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:46:44 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:46:44 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.12.y 1/2] netfilter: nft_ct: expectation timeouts are passed in milliseconds
Date: Tue, 17 Nov 2026 23:46:32 +0000
Message-ID: <20261117234631.165899-2-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261117234631.165899-1-mkbund@amazon.com>
References: <20261117234631.165899-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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
index 07a879f66fab..206cfa2734c6 100644
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

base-commit: b869a5313cbfe7102873d3de318ddb68675146d0
-- 
2.50.1

