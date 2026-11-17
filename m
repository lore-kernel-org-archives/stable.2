Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957799;
	b=ag+Su5f5N23SBJtrZSvsQKkdjrDSnLewxIzeqU+7B+NXouqIgepj+6c1mzsT1qMJ43SD
	 zxIAoue4mrDBvxhvLwRULk8gCfk/xNu67u9FVWbGg460A/fW52bDffsqGdqMjT7hqq2XU
	 /vPe1cAYaAbDC0UsZVIw/y2tJ3f2A0rUWBammm7lwbcshT/bwaNAUYsPcoMFExPhtfHXZ
	 SCx28Wb3rZYX4n+91metJfVGtrC+SGvAoNf3KgFlPNvdTvQX/T885r/qokPI0qMcBQqYC
	 OmA/sAt8SoPkOV/ATYlgMbl3ZpLE+457epwLqXLrbYNvGhIOgIfpPniffw2TymzSt0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957799;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=JSDG24vRsB9LMQ76l7t9/TVkpHL5U7qXXa6HU3bpKzA=;
	b=W6zDL2JmU/ST/50yWlRZFis9aojgeIedIe2pykNbl9xsgBUAT1Qjs4WN8v+IeqVndP2j
	 XCHIUv37Ug8DhpWej4Ji1O7PPUirZiTpkTt3akx9s9Ype8M3nQJBSgNVmaOT5O4hgjVuy
	 L362bfTPUX732xqF1qFigBfYRpxk75gUe0YD7TS7Ply1JdlaAna+7k8KoPhFbW32BFmlz
	 BBstlpOxh/LZRq/4uT300rm/KjLpuPQ8+MUuzcn1STXFvGJr/R5sQW0wemPpkXjURWcdE
	 JQ+0ShPBsQ1EHh4WVPDFHGhb5rCRx18Ucpz7+XEwfAeufo6N0DeLi4vs+17fmTvO5+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HoEJG7HU;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD370606A894
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD370606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HoEJG7HU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794957798; x=1826493798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JSDG24vRsB9LMQ76l7t9/TVkpHL5U7qXXa6HU3bpKzA=;
  b=HoEJG7HURTBwwR/vsQAoAp6TAMypCdBC+ognAZNcytWKO/STZtcnP9j/
   VVgIqWHA0o5Z8MqjtQjFBbIH96lbN206fzmIxvOVXMNa25Sp7tTuMzKOK
   aRJ8FCFyGqyKRrO6Dq+9lxkpfbpbu2rrPLtim7E7+/+ioNbohJpVb3rRn
   WkHnhYLht1RIYkZ6ion8e5Qjlrt93R1yWTTjBx5VevNk6vBfOk4Hptwgq
   OidbwtCq5FiYTohe+WNKj9UO6ZG9+myzklR0CJIyeOVOaK2T+BtMUZIz4
   OO79S4/yMX89PzD35wnMPVB81GRC1DAmEiweo8gpxVsBGOAyfuCHC+m2F
   g==;
X-CSE-ConnectionGUID: edZ8gfNNRVqNE+5igBw1bA==
X-CSE-MsgGUID: m58NZ0ibTPCHuVcdkkzh4g==
X-IronPort-AV: E=Sophos;i="6.27,218,1787011200"; 
   d="scan'208";a="34459554"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:23:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1072]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id 90884354-cee8-48a5-9bf3-b16e0fabdce2; Tue, 17 Nov 2026 23:23:18 +0000 (UTC)
X-Farcaster-Flow-ID: 90884354-cee8-48a5-9bf3-b16e0fabdce2
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
CC: Pablo Neira Ayuso <pablo@netfilter.org>, Jaeyeong Lee
	<iostreampy@proton.me>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.18.y 2/2] netfilter: nft_ct: move custom expectation support to helper
Date: Tue, 17 Nov 2026 23:23:07 +0000
Message-ID: <20261117232211.stolba-3679da4ad8be-linux-6.18.y-v1-2@amazon.com>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 3679da4ad8be84cddaf40bc307fef1fe13e051ff ]

Originally, the ct expectation support called nf_ct_helper_ext_add() for
confirmed conntracks, which is invalid, triggering a splat. This was
fixed by commit 1710eb913bdc ("netfilter: nft_ct: skip expectations for
confirmed conntrack") which restricted it to unconfirmed conntracks.

However, early insertion of expectations into the expectations list when
the conntrack is unconfirmed leads to stale entries pointing to the
wrong hlist_head through .pprev due to ct extension reallocation.

Commit 7c9664351980 ("netfilter: move nat hlist_head to nf_conn") moved
the nat hlist_head to nf_conn for this reason:

     1. ...
     2. When reallocation of extension area occurs we need to fixup the
        bysource hash head via hlist_replace_rcu.

I'd rather not increase the size of the struct nf_conn for this feature
has very limited scope: only one expectation can be created at a time
given expect_clash() will make nf_ct_expect_related() reports EBUSY.
For this reason, relax nf_ct_expect_related() not to drop packets in
case expectation creation fails, therefore, expectation creation becomes
best effort.

To address this issue, add an internal ct helper and attach it to the
conntrack entry to streamline the custom ct expectation support with
existing ct helpers.

Expose a new nf_conntrack_helper_release() function to release the
internal helper that is allocated and attached to the conntrack entry to
create the custom expectations. The nft_ct module removal always waits
for rcu grace period, then the NULL helper callback is observed after
this.

This patch also restricts the creation of expectations to different
helpers other than this custom helper that is created for this type of
expectations.

Fixes: 857b46027d6f ("netfilter: nft_ct: add ct expectations support")
Reported-by: Jaeyeong Lee <iostreampy@proton.me>
Link: https://patch.msgid.link/20260715144755.00ea7dfcd9f@proton.me
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ - ac46f3f35b6e ("netfilter: nf_conntrack_helper: add refcounting from
    datapath") is not backported because it reworks helper lifetime
    around a datapath ct_refcnt in 9 files, so one static nft_ct_expect
    helper is unhelped at nft_ct module exit.
  - d4beefc90a66 ("netfilter: nft_ct: support expectation creation for
    natted flows") is not backported because it adds expectation support
    for NATed flows, so the moved expectation code has no NAT
    follow-master part.
  - Context differs due to commit: 6031487d4e27 ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 include/net/netfilter/nf_conntrack_helper.h |   1 +
 net/netfilter/nf_conntrack_helper.c         |  20 ++--
 net/netfilter/nft_ct.c                      | 100 +++++++++++++++-----
 3 files changed, 89 insertions(+), 32 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
index 24cf3d2d9745..5b76fa57fd76 100644
--- a/include/net/netfilter/nf_conntrack_helper.h
+++ b/include/net/netfilter/nf_conntrack_helper.h
@@ -105,6 +105,7 @@ void nf_ct_helper_init(struct nf_conntrack_helper *helper,
 
 int nf_conntrack_helper_register(struct nf_conntrack_helper *);
 void nf_conntrack_helper_unregister(struct nf_conntrack_helper *);
+void nf_conntrack_helper_release(struct nf_conntrack_helper *);
 
 int nf_conntrack_helpers_register(struct nf_conntrack_helper *, unsigned int);
 void nf_conntrack_helpers_unregister(struct nf_conntrack_helper *,
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 2cef826e20fb..17538e3382dd 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -425,6 +425,18 @@ static bool expect_iter_me(struct nf_conntrack_expect *exp, void *data)
 	return this == me;
 }
 
+void nf_conntrack_helper_release(struct nf_conntrack_helper *me)
+{
+	nf_ct_expect_iterate_destroy(expect_iter_me, me);
+	nf_ct_iterate_destroy(unhelp, me);
+
+	/* nf_ct_iterate_destroy() does an unconditional synchronize_rcu() as
+	 * last step, this ensures rcu readers of exp->helper are done.
+	 * No need for another synchronize_rcu() here.
+	 */
+}
+EXPORT_SYMBOL_GPL(nf_conntrack_helper_release);
+
 void nf_conntrack_helper_unregister(struct nf_conntrack_helper *me)
 {
 	mutex_lock(&nf_ct_helper_mutex);
@@ -437,13 +449,7 @@ void nf_conntrack_helper_unregister(struct nf_conntrack_helper *me)
 	 */
 	synchronize_rcu();
 
-	nf_ct_expect_iterate_destroy(expect_iter_me, me);
-	nf_ct_iterate_destroy(unhelp, me);
-
-	/* nf_ct_iterate_destroy() does an unconditional synchronize_rcu() as
-	 * last step, this ensures rcu readers of exp->helper are done.
-	 * No need for another synchronize_rcu() here.
-	 */
+	nf_conntrack_helper_release(me);
 }
 EXPORT_SYMBOL_GPL(nf_conntrack_helper_unregister);
 
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 4687fc244eaf..87de920ead03 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1228,6 +1228,65 @@ static int nft_ct_expect_timeout_get(const struct nlattr *attr, u32 *val)
 	return 0;
 }
 
+struct nft_ct_expect_data {
+	struct nft_ct_expect_obj	obj;
+	enum ip_conntrack_dir		dir;
+};
+
+static int ct_expect_help(struct sk_buff *skb, unsigned int protoff,
+			  struct nf_conn *ct, enum ip_conntrack_info ctinfo)
+{
+	enum ip_conntrack_dir dir = CTINFO2DIR(ctinfo);
+	struct nft_ct_expect_data *expect_data;
+	struct nf_conntrack_expect *exp;
+	int ret = NF_ACCEPT;
+	u16 l3num;
+
+	if (nf_ct_is_confirmed(ct))
+		return NF_ACCEPT;
+
+	expect_data = nfct_help_data(ct);
+	if (!expect_data)
+		return NF_ACCEPT;
+
+	if (expect_data->dir != dir)
+		return NF_ACCEPT;
+
+	exp = nf_ct_expect_alloc(ct);
+	if (!exp)
+		return NF_DROP;
+
+	if (expect_data->obj.l3num == NFPROTO_INET)
+		l3num = nf_ct_l3num(ct);
+	else
+		l3num = expect_data->obj.l3num;
+
+	nf_ct_expect_init(exp, NF_CT_EXPECT_CLASS_DEFAULT, l3num,
+			  &ct->tuplehash[!dir].tuple.src.u3,
+			  &ct->tuplehash[!dir].tuple.dst.u3,
+			  expect_data->obj.l4proto, NULL, &expect_data->obj.dport);
+	exp->timeout += expect_data->obj.timeout;
+
+	if (nf_ct_expect_related(exp, 0) != 0)
+		ret = NF_ACCEPT;
+
+	nf_ct_expect_put(exp);
+
+	return ret;
+}
+
+static const struct nf_conntrack_expect_policy nft_ct_expect_helper_policy = {
+	.max_expected	= NF_CT_EXPECT_MAX_CNT,
+};
+
+/* No need to register this helper, this is internal. */
+static struct nf_conntrack_helper nft_ct_expect_helper = {
+	.name		= "nft_ct_expect",
+	.me		= THIS_MODULE,
+	.expect_policy	= &nft_ct_expect_helper_policy,
+	.help		= ct_expect_help,
+};
+
 static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 				  const struct nlattr * const tb[],
 				  struct nft_object *obj)
@@ -1235,6 +1294,8 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 	struct nft_ct_expect_obj *priv = nft_obj_data(obj);
 	int err;
 
+	NF_CT_HELPER_BUILD_BUG_ON(sizeof(struct nft_ct_expect_data));
+
 	if (!tb[NFTA_CT_EXPECT_L4PROTO] ||
 	    !tb[NFTA_CT_EXPECT_DPORT] ||
 	    !tb[NFTA_CT_EXPECT_TIMEOUT] ||
@@ -1280,7 +1341,7 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 }
 
 static void nft_ct_expect_obj_destroy(const struct nft_ctx *ctx,
-				       struct nft_object *obj)
+				      struct nft_object *obj)
 {
 	nf_ct_netns_put(ctx->net, ctx->family);
 }
@@ -1305,11 +1366,9 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
 				   const struct nft_pktinfo *pkt)
 {
 	const struct nft_ct_expect_obj *priv = nft_obj_data(obj);
-	struct nf_conntrack_expect *exp;
+	struct nft_ct_expect_data *expect_data;
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn_help *help;
-	enum ip_conntrack_dir dir;
-	u16 l3num = priv->l3num;
 	struct nf_conn *ct;
 
 	ct = nf_ct_get(pkt->skb, &ctinfo);
@@ -1317,38 +1376,28 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
 		regs->verdict.code = NFT_BREAK;
 		return;
 	}
-	dir = CTINFO2DIR(ctinfo);
 
 	help = nfct_help(ct);
-	if (!help)
-		help = nf_ct_helper_ext_add(ct, GFP_ATOMIC);
-	if (!help) {
-		regs->verdict.code = NF_DROP;
-		return;
-	}
-
-	if (help->expecting[NF_CT_EXPECT_CLASS_DEFAULT] >= priv->size) {
+	if (help) {
 		regs->verdict.code = NFT_BREAK;
 		return;
 	}
-	if (l3num == NFPROTO_INET)
-		l3num = nf_ct_l3num(ct);
 
-	exp = nf_ct_expect_alloc(ct);
-	if (exp == NULL) {
+	help = nf_ct_helper_ext_add(ct, GFP_ATOMIC);
+	if (!help) {
 		regs->verdict.code = NF_DROP;
 		return;
 	}
-	nf_ct_expect_init(exp, NF_CT_EXPECT_CLASS_DEFAULT, l3num,
-		          &ct->tuplehash[!dir].tuple.src.u3,
-		          &ct->tuplehash[!dir].tuple.dst.u3,
-		          priv->l4proto, NULL, &priv->dport);
-	exp->timeout += priv->timeout;
 
-	if (nf_ct_expect_related(exp, 0) != 0)
-		regs->verdict.code = NF_DROP;
+	expect_data = nfct_help_data(ct);
+	if (!expect_data) {
+		regs->verdict.code = NFT_BREAK;
+		return;
+	}
+	expect_data->obj = *priv;
+	expect_data->dir = CTINFO2DIR(ctinfo);
 
-	nf_ct_expect_put(exp);
+	rcu_assign_pointer(help->helper, &nft_ct_expect_helper);
 }
 
 static const struct nla_policy nft_ct_expect_policy[NFTA_CT_EXPECT_MAX + 1] = {
@@ -1428,6 +1477,7 @@ static void __exit nft_ct_module_exit(void)
 	nft_unregister_obj(&nft_ct_helper_obj_type);
 	nft_unregister_expr(&nft_notrack_type);
 	nft_unregister_expr(&nft_ct_type);
+	nf_conntrack_helper_release(&nft_ct_expect_helper);
 }
 
 module_init(nft_ct_module_init);
-- 
2.50.1

