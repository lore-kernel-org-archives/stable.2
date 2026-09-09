Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C32D9EDC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976325; cv=none; b=bu+1W9UliP5rmfpAxSv+gcv4c2k63Pa3yMhoB9h1VdBYuYw171dyecs4+yuFgHl4tfw4imepjyMAaYBNyfJJfFl7ITJBA09kMtmH1ZX5ZFNoaIZNXce2jLeeOYT/4oIys/KtcAwXnyKdbAnYw5Ko5LrLxIPTeGRjwbqTHKPB818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976325; c=relaxed/simple;
	bh=3eKD41mSTTRi4aCQ/Y5urp1U5gSxXvKFGwU/NS4hVeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqvRLkgany3YC6Kp6+Y/fhE19XW+JEIBHjIVWV5vfl4J0BWYu0a5Gumnct3Fl2xFtTYL1K+/CuQBNeir6ScFZSki+ZxtpmzWMhe4IDibLQbP7b7Ig+AvVGlzGH/JW9p1RzTq0N46Hsea4sMCc56d/mOOaThUy9z4jMHwQ6L1JGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUc5t58+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUc5t58+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A901F00898;
	Wed,  9 Sep 2026 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976323;
	bh=tD2mNvqIxiIW3ynb7bmhAZN9qLuP3nLWR3VPjwjpDmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WUc5t58+trtymfaNJsF6WxwVNQnLZPcL1NiXJS5Nvt2PVh3xbdBHTL27KMeZ0D6yT
	 YQF8J4Kx0EMTZGaNRh8ZdGmFgBZmHXsUSP+EVbXQBtlOGc76UFM+5eEysgiJwrLw4J
	 jfNOuNKgenALkS108ZIz37PCph6K6hn4vc2XiptadCwmBd4+dewaYvkLeWA2Mch7SI
	 x1euIpYylMLjOK7bNHgnt1DuyPIFKHzpQDSFfN9snCYHtGI8/4SeMsMQ46leeH8GhE
	 rIUjEV01fORokormMnzAOXQl4w4nj4fh+JbslwIHIiBU732oZmsSBcJLYWVtm4J0QH
	 rQ70Pp64H/Ufw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/6] l2tp: improve tunnel/session refcount helpers
Date: Wed,  9 Sep 2026 13:51:56 -0400
Message-ID: <20260909175157.3360687-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909175157.3360687-1-sashal@kernel.org>
References: <2026090341-mustiness-pedicure-fa05@gregkh>
 <20260909175157.3360687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Chapman <jchapman@katalix.com>

[ Upstream commit abe7a1a7d0b69e63b1bca5f9531023a52336784f ]

l2tp_tunnel_inc_refcount and l2tp_session_inc_refcount wrap
refcount_inc. They add no value so just use the refcount APIs directly
and drop l2tp's helpers. l2tp already uses refcount_inc_not_zero
anyway.

Rename l2tp_tunnel_dec_refcount and l2tp_session_dec_refcount to
l2tp_tunnel_put and l2tp_session_put to better match their use pairing
various _get getters.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Stable backport notes:

Keep this tree's session hash lists, synchronous session deletion, and
sk_user_data tunnel socket association. Its l2tp_sk_to_tunnel() does not
acquire a reference, so omit upstream puts in the socket destruction and
validation paths. Omit hunks for the absent session collision tables and
session deletion worker; no functions are added.

The earlier 24256415d186 backport already renamed the release helpers and
most callers to l2tp_tunnel_put() and l2tp_session_put(). Convert the three
old session release calls introduced by the intervening d93b8a63f011
backport in Ethernet/PPP setup error paths to l2tp_session_put(), avoiding
references to a helper that no longer exists.

Remove the two increment wrappers and their declarations/exports, using
refcount_inc() at all callers, including the stable-only session lookup
and registration paths. Reference acquisition and release ordering are
unchanged. Retain the stable netlink lookup APIs; af20e269f745 applies
cleanly with a three-way cherry-pick.

[ sashal: Reduced backport -- upstream abe7a1a7d0b69 touches 8 file(s), this
  backport carries 5. Not backported here:
  net/l2tp/l2tp_debugfs.c
  net/l2tp/l2tp_ip6.c
  net/l2tp/l2tp_ip.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: af20e269f745 ("net: l2tp: do not propagate multicast notification errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_core.c    | 26 +++++++-------------------
 net/l2tp/l2tp_core.h    |  2 --
 net/l2tp/l2tp_eth.c     |  4 ++--
 net/l2tp/l2tp_netlink.c |  2 +-
 net/l2tp/l2tp_ppp.c     |  8 ++++----
 5 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 7584c2f40f687..d48dbe3461861 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -180,12 +180,6 @@ struct l2tp_tunnel *l2tp_sk_to_tunnel(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(l2tp_sk_to_tunnel);
 
-void l2tp_tunnel_inc_refcount(struct l2tp_tunnel *tunnel)
-{
-	refcount_inc(&tunnel->ref_count);
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_inc_refcount);
-
 void l2tp_tunnel_put(struct l2tp_tunnel *tunnel)
 {
 	if (refcount_dec_and_test(&tunnel->ref_count))
@@ -193,12 +187,6 @@ void l2tp_tunnel_put(struct l2tp_tunnel *tunnel)
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_put);
 
-void l2tp_session_inc_refcount(struct l2tp_session *session)
-{
-	refcount_inc(&session->ref_count);
-}
-EXPORT_SYMBOL_GPL(l2tp_session_inc_refcount);
-
 void l2tp_session_put(struct l2tp_session *session)
 {
 	if (refcount_dec_and_test(&session->ref_count))
@@ -256,7 +244,7 @@ struct l2tp_session *l2tp_tunnel_get_session(struct l2tp_tunnel *tunnel,
 	rcu_read_lock_bh();
 	hlist_for_each_entry_rcu(session, session_list, hlist)
 		if (session->session_id == session_id) {
-			l2tp_session_inc_refcount(session);
+			refcount_inc(&session->ref_count);
 			rcu_read_unlock_bh();
 
 			return session;
@@ -277,7 +265,7 @@ struct l2tp_session *l2tp_session_get(const struct net *net, u32 session_id)
 	rcu_read_lock_bh();
 	hlist_for_each_entry_rcu(session, session_list, global_hlist)
 		if (session->session_id == session_id) {
-			l2tp_session_inc_refcount(session);
+			refcount_inc(&session->ref_count);
 			rcu_read_unlock_bh();
 
 			return session;
@@ -298,7 +286,7 @@ struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth)
 	for (hash = 0; hash < L2TP_HASH_SIZE; hash++) {
 		hlist_for_each_entry_rcu(session, &tunnel->session_hlist[hash], hlist) {
 			if (++count > nth) {
-				l2tp_session_inc_refcount(session);
+				refcount_inc(&session->ref_count);
 				rcu_read_unlock_bh();
 				return session;
 			}
@@ -325,7 +313,7 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 	for (hash = 0; hash < L2TP_HASH_SIZE_2; hash++) {
 		hlist_for_each_entry_rcu(session, &pn->l2tp_session_hlist[hash], global_hlist) {
 			if (!strcmp(session->ifname, ifname)) {
-				l2tp_session_inc_refcount(session);
+				refcount_inc(&session->ref_count);
 				rcu_read_unlock_bh();
 
 				return session;
@@ -379,13 +367,13 @@ int l2tp_session_register(struct l2tp_session *session,
 				goto err_tlock_pnlock;
 			}
 
-		l2tp_tunnel_inc_refcount(tunnel);
+		refcount_inc(&tunnel->ref_count);
 		session->tunnel = tunnel;
 		hlist_add_head_rcu(&session->global_hlist, g_head);
 
 		spin_unlock_bh(&pn->l2tp_session_hlist_lock);
 	} else {
-		l2tp_tunnel_inc_refcount(tunnel);
+		refcount_inc(&tunnel->ref_count);
 		session->tunnel = tunnel;
 	}
 
@@ -1559,7 +1547,7 @@ void l2tp_tunnel_delete(struct l2tp_tunnel *tunnel)
 {
 	if (!test_and_set_bit(0, &tunnel->dead)) {
 		trace_delete_tunnel(tunnel);
-		l2tp_tunnel_inc_refcount(tunnel);
+		refcount_inc(&tunnel->ref_count);
 		queue_work(l2tp_wq, &tunnel->del_work);
 	}
 }
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 1d5dbe2017296..090f184053a61 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -213,9 +213,7 @@ static inline void *l2tp_session_priv(struct l2tp_session *session)
 }
 
 /* Tunnel and session refcounts */
-void l2tp_tunnel_inc_refcount(struct l2tp_tunnel *tunnel);
 void l2tp_tunnel_put(struct l2tp_tunnel *tunnel);
-void l2tp_session_inc_refcount(struct l2tp_session *session);
 void l2tp_session_put(struct l2tp_session *session);
 
 /* Tunnel and session lookup.
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 7d350ed218772..d13e3d0593bd9 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -293,7 +293,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 
 	spriv = l2tp_session_priv(session);
 
-	l2tp_session_inc_refcount(session);
+	refcount_inc(&session->ref_count);
 
 	rtnl_lock();
 
@@ -332,7 +332,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 	l2tp_session_put(session);
 	free_netdev(dev);
 err_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 err:
 	return rc;
 }
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 1ba8eb6d8e8ae..9967c7d68e53d 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -241,7 +241,7 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 	if (ret < 0)
 		goto out;
 
-	l2tp_tunnel_inc_refcount(tunnel);
+	refcount_inc(&tunnel->ref_count);
 	ret = l2tp_tunnel_register(tunnel, net, &cfg);
 	if (ret < 0) {
 		kfree(tunnel);
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index f219bc992fb9f..e18faafbc6336 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -658,7 +658,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 			if (error < 0)
 				return ERR_PTR(error);
 
-			l2tp_tunnel_inc_refcount(tunnel);
+			refcount_inc(&tunnel->ref_count);
 			error = l2tp_tunnel_register(tunnel, net, &tcfg);
 			if (error < 0) {
 				kfree(tunnel);
@@ -763,13 +763,13 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 
 		pppol2tp_session_init(session);
 		ps = l2tp_session_priv(session);
-		l2tp_session_inc_refcount(session);
+		refcount_inc(&session->ref_count);
 
 		mutex_lock(&ps->sk_lock);
 		error = l2tp_session_register(session, tunnel);
 		if (error < 0) {
 			mutex_unlock(&ps->sk_lock);
-			l2tp_session_dec_refcount(session);
+			l2tp_session_put(session);
 			goto end;
 		}
 
@@ -867,7 +867,7 @@ static int pppol2tp_session_create(struct net *net, struct l2tp_tunnel *tunnel,
 	return 0;
 
 err_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 err:
 	return error;
 }
-- 
2.53.0

