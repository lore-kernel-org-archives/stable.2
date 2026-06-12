Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F4370D69
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291238; cv=none; b=JE2h4FlERZiyaOUyp78jWZvoGnAsKxbtZkUut8tBO4ky66U1ALCptr8o3FE2fVDvbZqenhK3agWp+lN81JqrJhZC2ZOlYwHaohgX12MvgZ9P2gP9dM4ASnU4tWK/AUMDdiVqHoex5JQxKtkfQxK/OwJCXjENuTDRPg6gMntWycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291238; c=relaxed/simple;
	bh=Sar5I2jXsCBO87QJtEHl8hn6/4LSqHsQ0aABWG8/nbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kshHWqXH1ERwN4IcZgFDlclf+MXRZEVYeTQfwTrL8qIbnyq9jlmrZQUsY8rPGwZequ3xSjRfJL2qLrXrCGsprVAsq0UTC1dDxWdaSvoi7gXB7/l52Kyuny8A97rXTFNRxNaa/eG30a/cHyZhrkB78iTYbC6VZc0bUDtG+wPPIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pr4+RmUv; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pr4+RmUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781291237; x=1812827237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bzSb67xfGfnxnFaIX6eA/HbvgLHwyeqVJ4XT5KXEjKQ=;
  b=Pr4+RmUvdETR3hgv7pFRo3EY9xdnU07igDqHg+r589M258FNECp9hl6K
   qhkkC8hcVqDbhv4rRvx97L7aNyDUkOcu2ALMNs6AdC8QH8iXsG5JRzU3A
   veWrDRoZ4/6WL381s+lnigyJTU0AiP3DDbKb0G8YonStuWXDADCvYX6T+
   0rdp5thhYRzwfBJAC5UOvJ0Ndg8On9PJORnltT5hyeebjXHBlC3uv6BgP
   hyKBSTLW8NVm73eYis4H7EuDm7TXO54xgMzzYfgoUfYDnIawU7tcYSBEm
   MzNhf/11dlPF1f+51tL4mHJhfTkyxfEx6w1YsgebJwHVFzVtdm/062Bub
   w==;
X-CSE-ConnectionGUID: UuXWHlfZTUymowYIO8iBQg==
X-CSE-MsgGUID: Ac3HC3tnRh6E5yvPYegK1w==
X-IronPort-AV: E=Sophos;i="6.24,201,1774310400"; 
   d="scan'208";a="21671577"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 19:07:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:27938]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.192:2525] with esmtp (Farcaster)
 id 4ac9138c-7111-484c-8e38-f01b8dda8ce4; Fri, 12 Jun 2026 19:07:16 +0000 (UTC)
X-Farcaster-Flow-ID: 4ac9138c-7111-484c-8e38-f01b8dda8ce4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 12 Jun 2026 19:07:16 +0000
Received: from dev-dsk-mkbund-2b-ce767ba1.us-west-2.amazon.com (10.169.40.81)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 12 Jun 2026 19:07:15 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.12.y] netfilter: ctnetlink: ensure safe access to master conntrack
Date: Fri, 12 Jun 2026 19:07:05 +0000
Message-ID: <20260612190705.909607-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit bffcaad9afdfe45d7fc777397d3b83c1e3ebffe5 ]

Holding reference on the expectation is not sufficient, the master
conntrack object can just go away, making exp->master invalid.

To access exp->master safely:

- Grab the nf_conntrack_expect_lock, this gets serialized with
  clean_from_lists() which also holds this lock when the master
  conntrack goes away.

- Hold reference on master conntrack via nf_conntrack_find_get().
  Not so easy since the master tuple to look up for the master conntrack
  is not available in the existing problematic paths.

This patch goes for extending the nf_conntrack_expect_lock section
to address this issue for simplicity, in the cases that are described
below this is just slightly extending the lock section.

The add expectation command already holds a reference to the master
conntrack from ctnetlink_create_expect().

However, the delete expectation command needs to grab the spinlock
before looking up for the expectation. Expand the existing spinlock
section to address this to cover the expectation lookup. Note that,
the nf_ct_expect_iterate_net() calls already grabs the spinlock while
iterating over the expectation table, which is correct.

The get expectation command needs to grab the spinlock to ensure master
conntrack does not go away. This also expands the existing spinlock
section to cover the expectation lookup too. I needed to move the
netlink skb allocation out of the spinlock to keep it GFP_KERNEL.

For the expectation events, the IPEXP_DESTROY event is already delivered
under the spinlock, just move the delivery of IPEXP_NEW under the
spinlock too because the master conntrack event cache is reached through
exp->master.

While at it, add lockdep notations to help identify what codepaths need
to grab the spinlock.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ fix timer_delete -> del_timer in diff context lines since 8fa7292
("treewide: Switch/rename to timer_delete[_sync]()") landed in 6.15 ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>

diff --git a/include/net/netfilter/nf_conntrack_core.h b/include/net/netfilter/nf_conntrack_core.h
--- a/include/net/netfilter/nf_conntrack_core.h
+++ b/include/net/netfilter/nf_conntrack_core.h
@@ -83,6 +83,11 @@ void nf_conntrack_lock(spinlock_t *lock);
 
 extern spinlock_t nf_conntrack_expect_lock;
 
+static inline void lockdep_nfct_expect_lock_held(void)
+{
+	lockdep_assert_held(&nf_conntrack_expect_lock);
+}
+
 /* ctnetlink code shared by both ctnetlink and nf_conntrack_bpf */
 
 static inline void __nf_ct_set_timeout(struct nf_conn *ct, u64 timeout)
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -237,6 +237,8 @@ void nf_ct_expect_event_report(enum ip_conntrack_expect_events event,
 	struct nf_ct_event_notifier *notify;
 	struct nf_conntrack_ecache *e;
 
+	lockdep_nfct_expect_lock_held();
+
 	rcu_read_lock();
 	notify = rcu_dereference(net->ct.nf_conntrack_event_cb);
 	if (!notify)
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -51,6 +51,7 @@ void nf_ct_unlink_expect_report(struct nf_conntrack_expect *exp,
 	struct net *net = nf_ct_exp_net(exp);
 	struct nf_conntrack_net *cnet;
 
+	lockdep_nfct_expect_lock_held();
 	WARN_ON(!master_help);
 	WARN_ON(timer_pending(&exp->timeout));
 
@@ -118,6 +119,8 @@ nf_ct_exp_equal(const struct nf_conntrack_tuple *tuple,
 
 bool nf_ct_remove_expect(struct nf_conntrack_expect *exp)
 {
+	lockdep_nfct_expect_lock_held();
+
 	if (del_timer(&exp->timeout)) {
 		nf_ct_unlink_expect(exp);
 		nf_ct_expect_put(exp);
@@ -177,6 +180,8 @@ nf_ct_find_expectation(struct net *net,
 	struct nf_conntrack_expect *i, *exp = NULL;
 	unsigned int h;
 
+	lockdep_nfct_expect_lock_held();
+
 	if (!cnet->expect_count)
 		return NULL;
 
@@ -459,6 +464,8 @@ static inline int __nf_ct_expect_check(struct nf_conntrack_expect *expect,
 	unsigned int h;
 	int ret = 0;
 
+	lockdep_nfct_expect_lock_held();
+
 	if (!master_help) {
 		ret = -ESHUTDOWN;
 		goto out;
@@ -515,8 +522,9 @@ int nf_ct_expect_related_report(struct nf_conntrack_expect *expect,
 
 	nf_ct_expect_insert(expect);
 
-	spin_unlock_bh(&nf_conntrack_expect_lock);
 	nf_ct_expect_event_report(IPEXP_NEW, expect, portid, report);
+	spin_unlock_bh(&nf_conntrack_expect_lock);
+
 	return 0;
 out:
 	spin_unlock_bh(&nf_conntrack_expect_lock);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3332,31 +3332,37 @@ static int ctnetlink_get_expect(struct sk_buff *skb,
 	if (err < 0)
 		return err;
 
+	skb2 = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb2)
+		return -ENOMEM;
+
+	spin_lock_bh(&nf_conntrack_expect_lock);
 	exp = nf_ct_expect_find_get(info->net, &zone, &tuple);
-	if (!exp)
+	if (!exp) {
+		spin_unlock_bh(&nf_conntrack_expect_lock);
+		kfree_skb(skb2);
 		return -ENOENT;
+	}
 
 	if (cda[CTA_EXPECT_ID]) {
 		__be32 id = nla_get_be32(cda[CTA_EXPECT_ID]);
 
 		if (id != nf_expect_get_id(exp)) {
 			nf_ct_expect_put(exp);
+			spin_unlock_bh(&nf_conntrack_expect_lock);
+			kfree_skb(skb2);
 			return -ENOENT;
 		}
 	}
 
-	skb2 = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!skb2) {
-		nf_ct_expect_put(exp);
-		return -ENOMEM;
-	}
-
 	rcu_read_lock();
 	err = ctnetlink_exp_fill_info(skb2, NETLINK_CB(skb).portid,
 				      info->nlh->nlmsg_seq, IPCTNL_MSG_EXP_NEW,
 				      exp);
 	rcu_read_unlock();
 	nf_ct_expect_put(exp);
+	spin_unlock_bh(&nf_conntrack_expect_lock);
+
 	if (err <= 0) {
 		kfree_skb(skb2);
 		return -ENOMEM;
@@ -3403,22 +3409,26 @@ static int ctnetlink_del_expect(struct sk_buff *skb,
 		if (err < 0)
 			return err;
 
+		spin_lock_bh(&nf_conntrack_expect_lock);
+
 		/* bump usage count to 2 */
 		exp = nf_ct_expect_find_get(info->net, &zone, &tuple);
-		if (!exp)
+		if (!exp) {
+			spin_unlock_bh(&nf_conntrack_expect_lock);
 			return -ENOENT;
+		}
 
 		if (cda[CTA_EXPECT_ID]) {
 			__be32 id = nla_get_be32(cda[CTA_EXPECT_ID]);
 
 			if (id != nf_expect_get_id(exp)) {
 				nf_ct_expect_put(exp);
+				spin_unlock_bh(&nf_conntrack_expect_lock);
 				return -ENOENT;
 			}
 		}
 
 		/* after list removal, usage count == 1 */
-		spin_lock_bh(&nf_conntrack_expect_lock);
 		if (del_timer(&exp->timeout)) {
 			nf_ct_unlink_expect_report(exp, NETLINK_CB(skb).portid,
 						   nlmsg_report(info->nlh));
