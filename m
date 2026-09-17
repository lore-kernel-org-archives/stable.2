Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE7370ADA
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608799; cv=none; b=r+VIJFQXqsIMNGuHn2dtnuiYwEAbAlLCtsxyIWOUWzmdKReudQLDrfErl9et9IdbVfrWYcFXaOQaUUmzVS+F5EaE3c6weBh48wR6tbdnLbCMc7rNy6gDJ4NIOEWubsLAd3qhOfmnmpjuBcLPZ0r3JLMCGg6rHeQ2YrXikuSX13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608799; c=relaxed/simple;
	bh=WXiutYh6nzVy/iChdF9LmVaWwXkixhSVjSFXHBFgSMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRyLUAbWXHQAc2DW6QROQecPwPm4jGNC+ySibwKxXPJY22HhYRTrs8hfOPDaCTruoXOqO/3iCxfwtqc0giMznLDtptGUn8PjQ13kCP0chUzfs3VfB8RjgwD4Nz6imYUsVNQ3GbeXCZNi0mj9WN2oIfrnX00pIhaEKZPRD8lb6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9MDLQoG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9MDLQoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4984B1F0089A;
	Thu, 17 Sep 2026 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608797;
	bh=mCsw2L7DGTJzzvfI17mAVXLdjhv6eMkimbzCJbwtjRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C9MDLQoGDyQ70FFUjED8jGfvcasJt8M9PIGNdNw+SgmyC/afthpQ17PCGH0vV5iAn
	 eSoiNwsIApVqkQBBrI4jLH0Cqw9GE2l8TuBK4qsPra5FEYibjAUtn82S30ZBcSVses
	 5+HVVILkp5HnX+5OhtZ/teEJw/DpG6DYUHhARMTYJIRtSxTRPOomYEw+CPYGL4M6m3
	 Bsiv7eaty8TTa1wd44C9B7UvR/Uja8F6ER/5OCj0lLzbId+3K9FFIJNfvnimtJWJ2W
	 R3UNWqqQDXVUpVPEeAhhYw3RNTqsFrj3RQ0w/jzxAXtJlfqEq8Pd+in5sF7DsBQwS/
	 ghHIDFxxOSAnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] netfilter: cttimeout: detach dataplane timeout policy and repurpose refcount
Date: Wed, 16 Sep 2026 21:33:12 -0400
Message-ID: <20260917013313.3594807-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917013313.3594807-1-sashal@kernel.org>
References: <2026091646-antonym-acid-ca2a@gregkh>
 <20260917013313.3594807-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 7d6a9cdb8d3a51d9cfe546a09a518ab3d2671549 ]

Add a refcount for struct nf_ct_timeout which is used by ct extension to
set the custom ct timeout policy, this tells us that the ct timeout is
being used by a conntrack entry. When the last conntrack entry drops the
refcount on the ct timeout, the ct timeout is released.

Remove the refcount for control plane which controls if the ruleset
refers to the timeout policy. After this update, it is possible to
remove the ct timeout policy from nfnetlink_cttimeout immediately.
This is for simplicity not to handle two refcounts on a single object.

Remove nf_queue_nf_hook_drop(): a packet sitting in nfqueue will just
hold a reference to the nf_ct_timeout object until packet is reinjected,
since this is part of the ct extension, this will be released by the
time the conntrack is freed.

nf_ct_untimeout() is still called to clean up in a best effort basis:
the ct timeout on existing entries gets removed when the ct timeout goes
away, but as long as the iptables ruleset still refers to the ct timeout
through a template, new conntracks may keep attaching it and extend its
lifetime until the rule is removed.

nf_ct_untimeout() is not called anymore from module removal path, this
is unlikely to find timeouts give module refcount is bumped, and the new
refcount already tracks the ct timeout policy use so it is released when
unused.

Fixes: 50978462300f ("netfilter: add cttimeout infrastructure for fine timeout tuning")
Fixes: 7e0b2b57f01d ("netfilter: nft_ct: add ct timeout support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

This dependency is deliberately narrowed for the 5.15 backport of
fec9b1de0d02 ("netfilter: cttimeout: prevent UAF during module unload").
The target only needs the common timeout hook and the synchronize_net()
module-exit context; it does not depend on the dataplane refcount redesign.

Fold in the timeout hook representation from 7afa38831aee2
("netfilter: cttimeout: use option structure"), with the __rcu annotations
from 6976890e8998. Convert the existing hook users and provider together,
and retain synchronize_net() from this dependency. Leave per-net
unregistration in its existing position so the target applies unchanged
and moves it after hook withdrawal and the reader grace period.

Drop the separate policy allocation, dataplane refcount, conntrack-free,
and nftables/xtables queue-handling hunks. These require newer lifetime
infrastructure and are unnecessary for the target. Keep the 5.15 extension
destructors, policy ownership and module references. No functions are
added.

Also correct the existing nfct_timeout_freelist traversal to use
free_head, matching the member used to link and unlink its entries.
Using head computes the wrong ctnl_timeout address during teardown.

[ sashal: Reduced backport -- upstream 7d6a9cdb8d3a5 touches 6 file(s), this
  backport carries 3. Not backported here:
  net/netfilter/nf_conntrack_core.c
  net/netfilter/nft_ct.c
  net/netfilter/xt_CT.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: fec9b1de0d02 ("netfilter: cttimeout: prevent UAF during module unload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_timeout.h |  8 +++--
 net/netfilter/nf_conntrack_timeout.c         | 31 ++++++++------------
 net/netfilter/nfnetlink_cttimeout.c          | 15 ++++++----
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_timeout.h b/include/net/netfilter/nf_conntrack_timeout.h
index 1fe6b634a6ff4..b78786dbf0c61 100644
--- a/include/net/netfilter/nf_conntrack_timeout.h
+++ b/include/net/netfilter/nf_conntrack_timeout.h
@@ -113,8 +113,12 @@ static inline void nf_ct_destroy_timeout(struct nf_conn *ct)
 #endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
 #ifdef CONFIG_NF_CONNTRACK_TIMEOUT
-extern struct nf_ct_timeout *(*nf_ct_timeout_find_get_hook)(struct net *net, const char *name);
-extern void (*nf_ct_timeout_put_hook)(struct nf_ct_timeout *timeout);
+struct nf_ct_timeout_hooks {
+	struct nf_ct_timeout *(*timeout_find_get)(struct net *net, const char *name);
+	void (*timeout_put)(struct nf_ct_timeout *timeout);
+};
+
+extern const struct nf_ct_timeout_hooks __rcu *nf_ct_timeout_hook;
 #endif
 
 #endif /* _NF_CONNTRACK_TIMEOUT_H */
diff --git a/net/netfilter/nf_conntrack_timeout.c b/net/netfilter/nf_conntrack_timeout.c
index 14387e0b80088..37873248c2a7d 100644
--- a/net/netfilter/nf_conntrack_timeout.c
+++ b/net/netfilter/nf_conntrack_timeout.c
@@ -22,12 +22,8 @@
 #include <net/netfilter/nf_conntrack_l4proto.h>
 #include <net/netfilter/nf_conntrack_timeout.h>
 
-struct nf_ct_timeout *
-(*nf_ct_timeout_find_get_hook)(struct net *net, const char *name) __read_mostly;
-EXPORT_SYMBOL_GPL(nf_ct_timeout_find_get_hook);
-
-void (*nf_ct_timeout_put_hook)(struct nf_ct_timeout *timeout) __read_mostly;
-EXPORT_SYMBOL_GPL(nf_ct_timeout_put_hook);
+const struct nf_ct_timeout_hooks __rcu *nf_ct_timeout_hook __read_mostly;
+EXPORT_SYMBOL_GPL(nf_ct_timeout_hook);
 
 static int untimeout(struct nf_conn *ct, void *timeout)
 {
@@ -48,31 +44,30 @@ EXPORT_SYMBOL_GPL(nf_ct_untimeout);
 
 static void __nf_ct_timeout_put(struct nf_ct_timeout *timeout)
 {
-	typeof(nf_ct_timeout_put_hook) timeout_put;
+	const struct nf_ct_timeout_hooks *h = rcu_dereference(nf_ct_timeout_hook);
 
-	timeout_put = rcu_dereference(nf_ct_timeout_put_hook);
-	if (timeout_put)
-		timeout_put(timeout);
+	if (h)
+		h->timeout_put(timeout);
 }
 
 int nf_ct_set_timeout(struct net *net, struct nf_conn *ct,
 		      u8 l3num, u8 l4num, const char *timeout_name)
 {
-	typeof(nf_ct_timeout_find_get_hook) timeout_find_get;
+	const struct nf_ct_timeout_hooks *h;
 	struct nf_ct_timeout *timeout;
 	struct nf_conn_timeout *timeout_ext;
 	const char *errmsg = NULL;
 	int ret = 0;
 
 	rcu_read_lock();
-	timeout_find_get = rcu_dereference(nf_ct_timeout_find_get_hook);
-	if (!timeout_find_get) {
+	h = rcu_dereference(nf_ct_timeout_hook);
+	if (!h) {
 		ret = -ENOENT;
 		errmsg = "Timeout policy base is empty";
 		goto out;
 	}
 
-	timeout = timeout_find_get(net, timeout_name);
+	timeout = h->timeout_find_get(net, timeout_name);
 	if (!timeout) {
 		ret = -ENOENT;
 		pr_info_ratelimited("No such timeout policy \"%s\"\n",
@@ -119,15 +114,15 @@ EXPORT_SYMBOL_GPL(nf_ct_set_timeout);
 void nf_ct_destroy_timeout(struct nf_conn *ct)
 {
 	struct nf_conn_timeout *timeout_ext;
-	typeof(nf_ct_timeout_put_hook) timeout_put;
+	const struct nf_ct_timeout_hooks *h;
 
 	rcu_read_lock();
-	timeout_put = rcu_dereference(nf_ct_timeout_put_hook);
+	h = rcu_dereference(nf_ct_timeout_hook);
 
-	if (timeout_put) {
+	if (h) {
 		timeout_ext = nf_ct_timeout_find(ct);
 		if (timeout_ext) {
-			timeout_put(timeout_ext->timeout);
+			h->timeout_put(timeout_ext->timeout);
 			RCU_INIT_POINTER(timeout_ext->timeout, NULL);
 		}
 	}
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 654ec445e7277..9eef304bd699e 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -618,7 +618,7 @@ static void __net_exit cttimeout_net_exit(struct net *net)
 
 	nf_ct_untimeout(net, NULL);
 
-	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_freelist, head) {
+	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_freelist, free_head) {
 		list_del(&cur->free_head);
 
 		if (refcount_dec_and_test(&cur->refcnt))
@@ -634,6 +634,11 @@ static struct pernet_operations cttimeout_ops = {
 	.size   = sizeof(struct nfct_timeout_pernet),
 };
 
+static const struct nf_ct_timeout_hooks hooks = {
+	.timeout_find_get = ctnl_timeout_find_get,
+	.timeout_put = ctnl_timeout_put,
+};
+
 static int __init cttimeout_init(void)
 {
 	int ret;
@@ -648,8 +653,7 @@ static int __init cttimeout_init(void)
 			"nfnetlink.\n");
 		goto err_out;
 	}
-	RCU_INIT_POINTER(nf_ct_timeout_find_get_hook, ctnl_timeout_find_get);
-	RCU_INIT_POINTER(nf_ct_timeout_put_hook, ctnl_timeout_put);
+	RCU_INIT_POINTER(nf_ct_timeout_hook, &hooks);
 	return 0;
 
 err_out:
@@ -662,9 +666,8 @@ static void __exit cttimeout_exit(void)
 	nfnetlink_subsys_unregister(&cttimeout_subsys);
 
 	unregister_pernet_subsys(&cttimeout_ops);
-	RCU_INIT_POINTER(nf_ct_timeout_find_get_hook, NULL);
-	RCU_INIT_POINTER(nf_ct_timeout_put_hook, NULL);
-	synchronize_rcu();
+	RCU_INIT_POINTER(nf_ct_timeout_hook, NULL);
+	synchronize_net();
 }
 
 module_init(cttimeout_init);
-- 
2.53.0

