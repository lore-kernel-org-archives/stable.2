Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960160;
	b=oeVPiW9zMti9LDC35Il4liyW1gtvrSa2i5TnI5JV4+HZl+k+SClweDT7h9B6GqTxq1rS
	 FKdSciNE041lp6FQgUXAqIGyn/SA+mSm1kdCBVJOQT0UiAZcIseb6y+3Mq2TlR+K2Sz4q
	 TAZz70EuhAbnHuC85wQ7V+PmTkjy9dEjWEsN5prvmkA8Dk+GgsbAe/1+RMGtD60/ralVJ
	 kbveumIdD6Ufz9+YayOpUiEMiHaZxbvBAB6Ji1KOsjpEHGhqNG6xhVN5O4I364HOyItbf
	 tVi2dFT85zedi9t3A22mKmhj57JvSJnOJqwHNocjcxs5rfH/s3SgXb+VDlxUDSsd5bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960160;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=UecGHd28pyKfC80lXkDmMaxvmQF4bflAXD36uT1UP0Y=;
	b=f/D6HyIKGuMqVx9tSFQKGhQ3hXw8M5NnFLH4uJTFXCDVrqpQnkcdfnClpFi14VjizA50
	 ZE5K/vA2v4VnlkO1nhRK6pzac90N/hAMpeNoZD9HRs5XjFZC4a1Gl9XZPVJV94/8bujDY
	 X9cHIXqOml0NhsliIKeOWMIjYfNWdo5cZlPS21jRhWnsAZe+nnhWVXtUj6snNE6C0oAqW
	 Mo2kzTvmPkcv3+cv1PaSO4R5fymGK4bdK36WdNNUHRuymdYb/H9J4GPyK2yYgNwxW1EXz
	 1+cJctuGTohYCxHzLf6G3diL8fECFpBz80/YizgW4/hYnkRMPPwtisOtf4ZBB+QtRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=IMOhahhH;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27A606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D27A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=IMOhahhH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794960160; x=1826496160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UecGHd28pyKfC80lXkDmMaxvmQF4bflAXD36uT1UP0Y=;
  b=IMOhahhHC3cMSvuHty61LfSDLX38sISna7JpWB47HYR4fRm8IxyRldtS
   nS5uGvv51ZOdLOjUvp1bmyMBR0bw8aaYqJxNkYkdfRpA1nr/tWGt7D+dI
   4NVx2mZuPMoG7jPGpid0izCYY6vUvhYkANXEmrtfMM3ukRQYR88zZXQ7b
   IuTzKpmP6qFpJzc2DElhAyRzpL3G0pmX+VUJcEaTpO/Dyk72k32EoflpL
   /orUNPHReeIEv8vbS22jkGxPhXcutajAHzSzXvvuM1GMx3Lc5dHX37aQD
   Hdcp7Hh1KdtdTWfGBu8o1PtdBqIyFVZtyJxTEdtf6SDHp5DHoYsrIzu66
   w==;
X-CSE-ConnectionGUID: tZrfFmuJR9OeExtobXiQDQ==
X-CSE-MsgGUID: dd0ICBjTS1WuqDTL7vteFg==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34213990"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:02:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:3966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id ef87d0a0-9f24-4a0c-9815-88f647135dc3; Wed, 18 Nov 2026 00:02:39 +0000 (UTC)
X-Farcaster-Flow-ID: ef87d0a0-9f24-4a0c-9815-88f647135dc3
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
CC: Pablo Neira Ayuso <pablo@netfilter.org>, Jaeyeong Lee
	<iostreampy@proton.me>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 5.10.y 2/2] netfilter: nft_ct: move custom expectation support to helper
Date: Wed, 18 Nov 2026 00:02:23 +0000
Message-ID: <20261118000221.493214-3-mkbund@amazon.com>
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
  - b8b09dc2bf35 ("netfilter: nf_conntrack_expect: use conntrack GC to
    reap expectations") is not backported because it replaces the
    expectation timer with GC reaping in 9 files, so timer_list expires
    is set, and mod_timer_pending() after insert.
  - ace53fdc262f ("netfilter: conntrack: remove
    __nf_ct_unconfirmed_destroy") is not backported because it reworks
    unconfirmed conntrack teardown in conntrack core, so the release
    helper keeps this branch's final synchronize_rcu().
  - Context differs due to commit: 6031487d4e27 ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 include/net/netfilter/nf_conntrack_helper.h |   1 +
 net/netfilter/nf_conntrack_helper.c         |  20 ++--
 net/netfilter/nft_ct.c                      | 107 +++++++++++++++-----
 3 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
index 37f0fbefb060..a85c1a80f109 100644
--- a/include/net/netfilter/nf_conntrack_helper.h
+++ b/include/net/netfilter/nf_conntrack_helper.h
@@ -105,6 +105,7 @@ void nf_ct_helper_init(struct nf_conntrack_helper *helper,
 
 int nf_conntrack_helper_register(struct nf_conntrack_helper *);
 void nf_conntrack_helper_unregister(struct nf_conntrack_helper *);
+void nf_conntrack_helper_release(struct nf_conntrack_helper *);
 
 int nf_conntrack_helpers_register(struct nf_conntrack_helper *, unsigned int);
 void nf_conntrack_helpers_unregister(struct nf_conntrack_helper *,
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 24f3f8d5e699..5ce70eb904d2 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -456,6 +456,18 @@ static bool expect_iter_me(struct nf_conntrack_expect *exp, void *data)
 	return this == me;
 }
 
+void nf_conntrack_helper_release(struct nf_conntrack_helper *me)
+{
+	nf_ct_expect_iterate_destroy(expect_iter_me, me);
+	nf_ct_iterate_destroy(unhelp, me);
+
+	/* Maybe someone has gotten the helper already when unhelp above.
+	 * So need to wait it.
+	 */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(nf_conntrack_helper_release);
+
 void nf_conntrack_helper_unregister(struct nf_conntrack_helper *me)
 {
 	mutex_lock(&nf_ct_helper_mutex);
@@ -468,13 +480,7 @@ void nf_conntrack_helper_unregister(struct nf_conntrack_helper *me)
 	 */
 	synchronize_rcu();
 
-	nf_ct_expect_iterate_destroy(expect_iter_me, me);
-	nf_ct_iterate_destroy(unhelp, me);
-
-	/* Maybe someone has gotten the helper already when unhelp above.
-	 * So need to wait it.
-	 */
-	synchronize_rcu();
+	nf_conntrack_helper_release(me);
 }
 EXPORT_SYMBOL_GPL(nf_conntrack_helper_unregister);
 
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index a17357e4a59a..f947c95b6b22 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1192,6 +1192,72 @@ static int nft_ct_expect_timeout_get(const struct nlattr *attr, u32 *val)
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
+	/* nf_ct_expect_insert() arms the timer from the helper policy,
+	 * whose timeout is zero. Set the object's timeout once inserted,
+	 * with BH off so the timer cannot fire on this CPU in between.
+	 */
+	local_bh_disable();
+	if (nf_ct_expect_related(exp, 0) != 0)
+		ret = NF_ACCEPT;
+	else
+		mod_timer_pending(&exp->timeout,
+				  jiffies + expect_data->obj.timeout);
+	local_bh_enable();
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
@@ -1199,6 +1265,8 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 	struct nft_ct_expect_obj *priv = nft_obj_data(obj);
 	int err;
 
+	NF_CT_HELPER_BUILD_BUG_ON(sizeof(struct nft_ct_expect_data));
+
 	if (!tb[NFTA_CT_EXPECT_L4PROTO] ||
 	    !tb[NFTA_CT_EXPECT_DPORT] ||
 	    !tb[NFTA_CT_EXPECT_TIMEOUT] ||
@@ -1244,7 +1312,7 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 }
 
 static void nft_ct_expect_obj_destroy(const struct nft_ctx *ctx,
-				       struct nft_object *obj)
+				      struct nft_object *obj)
 {
 	nf_ct_netns_put(ctx->net, ctx->family);
 }
@@ -1269,11 +1337,9 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
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
@@ -1281,38 +1347,28 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
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
-	exp->timeout.expires = jiffies + priv->timeout;
 
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
@@ -1392,6 +1448,7 @@ static void __exit nft_ct_module_exit(void)
 	nft_unregister_obj(&nft_ct_helper_obj_type);
 	nft_unregister_expr(&nft_notrack_type);
 	nft_unregister_expr(&nft_ct_type);
+	nf_conntrack_helper_release(&nft_ct_expect_helper);
 }
 
 module_init(nft_ct_module_init);
-- 
2.50.1

