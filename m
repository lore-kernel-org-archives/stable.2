Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960160;
	b=rz9bzAXwTXhK7t5OPn+OssgnauVDOWb/vVqSIuURFSvUN0bWGBxsOw6UeA1MOkEOO7nz
	 /PD6y8JP+O8nkQl7XbyRA2Dy8wVF9Etq/QnUE8oxv+/PS6oXo5Zr+508gboNUCR2nrI6I
	 4pV+qQrcUo1OjMpg94zegHyI1bkZ5H4C7CsO87+I7SUmtI+5s7dbZIq+f9fNK9z/WJnCo
	 /OW1X5iK6LXjJaVxZ2SL4ysNPwVxTdojFvuRadTo6I8Y43FAdtul9d2/HvS79YSRcSacU
	 FFHcBTD0RNZndvFUbH95XIJCANkqMBknQBBGrtoyz2lwOL7sTXqca1vkm607VweomJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960160;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=UyJWl2uA6m3CFpjuIB2GUtlXc5VzHgLs8vfay/LWEBk=;
	b=ANVwakvX+i/BTVwNA6G6/nWyrab1a4dtgPVDTFDJssNICKNoP9DOypkZy0mNw/IKEY6m
	 mwdl/0iXh4PfDSFRDlblPkvGFyCaEi9fX21ammZqZakvrwTj1TwQbTYmSgFdkc0znooPD
	 kHbNKwXO6wON071ztPdTz79N6ILOi2t1AElvGh80y6/4wkwWmo1PiS1jpFhu+sUfyO4Wc
	 xXE4BcESxQ93mFfR6AKGDU9hMwY+CZ0rP/FaG+Arx6NFVXSgL6sZiO5xjHsZss9IFrH5b
	 VH3bBj0ScHRwpXQze27HtBq32LDfwhPlKqw4N28CPXSU1l74GDW5ppnJSfFQATRoviw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Ba7wGxdV;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69236606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69236606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Ba7wGxdV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794960160; x=1826496160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UyJWl2uA6m3CFpjuIB2GUtlXc5VzHgLs8vfay/LWEBk=;
  b=Ba7wGxdVyZAkervh7DLKPAXoQNQp/EBvKEkYnfyoqj3RxZw48WDQvscV
   H+dC+vbmG6btAA9mjaIxq/10zKHO/Xr9B8xEhcrlqeBmQ19st2/QUWYpB
   wuT1BAmlvzT6vz+6O0J9oi4epY7y7UXJMkR7ypGDss3nooq3Lq4NREUdP
   7dVIzXUH8ugZjR+Ofa016rYwA9lnmnX9AMDoYOaH8FXWBuJkxSEpRaPqL
   5tKIgUuiIIQc1G68UgJUxD9fVGlv5kajCWtrMLjndhZv500t8FOLFhzlD
   lBSyS0FSWQZdy2tPNDGGJP13VClgFb2MBe88FanQUJ9O+6QgLsuqiQOYU
   A==;
X-CSE-ConnectionGUID: RfYzO3eVQ82qRkSbTFNiMQ==
X-CSE-MsgGUID: 82jqDC7tTNqzcQMSGjsa0Q==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="33929564"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:02:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:3966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 2fc61b30-b34f-489c-8e74-d2997e09c67b; Wed, 18 Nov 2026 00:02:39 +0000 (UTC)
X-Farcaster-Flow-ID: 2fc61b30-b34f-489c-8e74-d2997e09c67b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 00:02:39 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 00:02:39 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 5.10.y 1/2] netfilter: nft_ct: expectation timeouts are passed in milliseconds
Date: Wed, 18 Nov 2026 00:02:22 +0000
Message-ID: <20261118000221.493214-2-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118000221.493214-1-mkbund@amazon.com>
References: <20261118000221.493214-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
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
index 5e4ea0f800d2..a17357e4a59a 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1181,11 +1181,23 @@ struct nft_ct_expect_obj {
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
@@ -1221,8 +1233,11 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
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
@@ -1242,7 +1257,7 @@ static int nft_ct_expect_obj_dump(struct sk_buff *skb,
 	if (nla_put_be16(skb, NFTA_CT_EXPECT_L3PROTO, htons(priv->l3num)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_L4PROTO, priv->l4proto) ||
 	    nla_put_be16(skb, NFTA_CT_EXPECT_DPORT, priv->dport) ||
-	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, priv->timeout) ||
+	    nla_put_u32(skb, NFTA_CT_EXPECT_TIMEOUT, jiffies_to_msecs(priv->timeout)) ||
 	    nla_put_u8(skb, NFTA_CT_EXPECT_SIZE, priv->size))
 		return -1;
 
@@ -1292,7 +1307,7 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
 		          &ct->tuplehash[!dir].tuple.src.u3,
 		          &ct->tuplehash[!dir].tuple.dst.u3,
 		          priv->l4proto, NULL, &priv->dport);
-	exp->timeout.expires = jiffies + priv->timeout * HZ;
+	exp->timeout.expires = jiffies + priv->timeout;
 
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;

base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
-- 
2.50.1

