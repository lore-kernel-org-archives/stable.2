Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1174286D60
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608797; cv=none; b=rTZChirpxNz2AvWkjvxlFSFLP0kp3iDa7vhIqvGCIXoOZMIkYK2/gFV9m87JnvK+XVx8qVIp1ZYTUIpUU00FPShMRGIx4cd/2XqtpzGx3zyt1ItFe4DGducHk5cLhLGOmnx14KzCMU4ikst/y6R+FC0GuFxnp0N3w/vGLZFwXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608797; c=relaxed/simple;
	bh=InpPe4PF4B6CpUk1FnLJaAb7MVQ+Me6WmKGb/90El5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WncCfEp/i6NrKcJnG/UGTtk67d8wmJ9TC9qaTj1+Swa7XhiIu1fd5CGpVO1aBJPxhFGrFKTkeApnRS3YcgZOZvCUIiZKIZXP9DT8eHFQN4HAFM+cgQ7xNGMXQ48b5iNzY2wiuykd7fqmQ2Osk2PkIAtriaujXET0GU8eM7vM7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USXh3eDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USXh3eDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3091F000FF;
	Thu, 17 Sep 2026 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608795;
	bh=kH9Z4su4t3YaShbUys1CxUZBDQGuerqZgTjXg6KctY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USXh3eDkUkx3Hwvj1IRxz404BOCDZjyqLUlv1aWZOmRf6EzjvByS4tu2zXZA5JILC
	 AFfua/IjKqa/bONQ3W4+ibtyl+5CqJkFW0375Dk2YiEJRaPzRT+aB7M8VMuYHM/Dsf
	 5AxOVMNL+TO31hPraqE3OvbGZ0aFJ+vf8zlIJl5AnM5l8Szi6C1DtAhwrcpurWoIcw
	 YEw6CpeWBorXAlyyavsGsUYemPsAw/MCqPaB3mmEr1MBAqb6eJpZoY8f3/D08ZmcNY
	 3brA0x1vZmzuuBztu6ilDWeJGhqRZuHV4aHHSPC4Fs+8NSPuB5lZitqdWCb6nkF6hv
	 eS+VMzKVB6mRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] netfilter: cttimeout: decouple unlink and free on netns destruction
Date: Wed, 16 Sep 2026 21:33:09 -0400
Message-ID: <20260917013313.3594807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091646-antonym-acid-ca2a@gregkh>
References: <2026091646-antonym-acid-ca2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 78222bacfca97cb18505df1ba5f3591864498a7e ]

Make it so netns pre_exit unlinks the objects from the pernet list, so
they cannot be found anymore.

netns core issues a synchronize_rcu() before calling the exit hooks so
any the time the exit hooks run unconfirmed nf_conn entries have been
free'd or they have been committed to the hashtable.

The exit hook still tags unconfirmed entries as dying, this can
now be removed in a followup change.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: fec9b1de0d02 ("netfilter: cttimeout: prevent UAF during module unload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_timeout.h |  8 ------
 net/netfilter/nfnetlink_cttimeout.c          | 30 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_timeout.h b/include/net/netfilter/nf_conntrack_timeout.h
index 16e024ca15875..1fe6b634a6ff4 100644
--- a/include/net/netfilter/nf_conntrack_timeout.h
+++ b/include/net/netfilter/nf_conntrack_timeout.h
@@ -18,14 +18,6 @@ struct nf_ct_timeout {
 	char			data[];
 };
 
-struct ctnl_timeout {
-	struct list_head	head;
-	struct rcu_head		rcu_head;
-	refcount_t		refcnt;
-	char			name[CTNL_TIMEOUT_NAME_MAX];
-	struct nf_ct_timeout	timeout;
-};
-
 struct nf_conn_timeout {
 	struct nf_ct_timeout __rcu *timeout;
 };
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index c57673d499be7..2a241ed20edd2 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -33,8 +33,19 @@
 
 static unsigned int nfct_timeout_id __read_mostly;
 
+struct ctnl_timeout {
+	struct list_head	head;
+	struct rcu_head		rcu_head;
+	refcount_t		refcnt;
+	char			name[CTNL_TIMEOUT_NAME_MAX];
+	struct nf_ct_timeout	timeout;
+
+	struct list_head	free_head;
+};
+
 struct nfct_timeout_pernet {
 	struct list_head	nfct_timeout_list;
+	struct list_head	nfct_timeout_freelist;
 };
 
 MODULE_LICENSE("GPL");
@@ -578,10 +589,24 @@ static int __net_init cttimeout_net_init(struct net *net)
 	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(net);
 
 	INIT_LIST_HEAD(&pernet->nfct_timeout_list);
+	INIT_LIST_HEAD(&pernet->nfct_timeout_freelist);
 
 	return 0;
 }
 
+static void __net_exit cttimeout_net_pre_exit(struct net *net)
+{
+	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(net);
+	struct ctnl_timeout *cur, *tmp;
+
+	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_list, head) {
+		list_del_rcu(&cur->head);
+		list_add(&cur->free_head, &pernet->nfct_timeout_freelist);
+	}
+
+	/* core calls synchronize_rcu() after this */
+}
+
 static void __net_exit cttimeout_net_exit(struct net *net)
 {
 	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(net);
@@ -590,8 +615,8 @@ static void __net_exit cttimeout_net_exit(struct net *net)
 	nf_ct_unconfirmed_destroy(net);
 	nf_ct_untimeout(net, NULL);
 
-	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_list, head) {
-		list_del_rcu(&cur->head);
+	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_freelist, head) {
+		list_del(&cur->free_head);
 
 		if (refcount_dec_and_test(&cur->refcnt))
 			kfree_rcu(cur, rcu_head);
@@ -600,6 +625,7 @@ static void __net_exit cttimeout_net_exit(struct net *net)
 
 static struct pernet_operations cttimeout_ops = {
 	.init	= cttimeout_net_init,
+	.pre_exit = cttimeout_net_pre_exit,
 	.exit	= cttimeout_net_exit,
 	.id     = &nfct_timeout_id,
 	.size   = sizeof(struct nfct_timeout_pernet),
-- 
2.53.0

