Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05323390CAD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976324; cv=none; b=IjuzoXp147+ySnwMQjfakJPAaf9MuFRDvMkqNF7v9eUXEo850L/Nq5I+FdX+i0OJKNlPj6TjzRV1Wyw9k4HxJTtVY1vpzbbbJ1UcKUmrv/ECuH0eta85R88+yl3uUeRzrEQd1Vw16+KHLC2KlpqnMD7Lm73wq+xIGOUcHB48gPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976324; c=relaxed/simple;
	bh=GfeyZlawgfmfaO6tp/ivcJFbog5lFTaVg8vGVtF8gsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfHvYSujpcP9X7xt0Fg1C2bCb412f/p3eLEfl+ZWfGqfOI3afl6HgxCe3yrIfS0sx5beX5bjMk4K1rCBI0P2Ji+/8SCJC9n5SKVKah/V2+9ajKSQqsEqSHfTdIbAuHBu6+6EdfZHu3nikoAh5x59qJN3pJHuD6zKKdYHOxGVDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp/w3erz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp/w3erz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30931F00899;
	Wed,  9 Sep 2026 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976321;
	bh=HwErk/Ns6UgOh5Voq21ULAdxV5AcoVCj8p8J6s/R3Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qp/w3erzZIJpaPIo5YOpfYeVUX5RFdFPXwZh1F0GJ2PnHEYmc5GL26/fmCGvD9xZK
	 GB9PTwptFxEAimGCEPVSPgD3pe0Wr9CIJup/8w9xt/jlPYOYvFVpuE/Y+OjKXXgGat
	 Cuu/eZPbOiwN3jBP+HFB49qtsESWiGIPgosleDnB8+fx9G7h6yBUSCMUGZza3kZQTB
	 sdg/FBRsEgDu3l9shaOBqlrmsjlgDuxk3wiKL2T+eifgK9hAa8rEwrkV946qTkUlUq
	 pl6wwKPo3KqlElS59jzob+X6nzfI/gYAwOqMoYew7mRT0rCj2ggjhPoS+XfNjqw73S
	 OHj1nRY9/jIew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/6] l2tp: prevent possible tunnel refcount underflow
Date: Wed,  9 Sep 2026 13:51:54 -0400
Message-ID: <20260909175157.3360687-3-sashal@kernel.org>
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

[ Upstream commit 24256415d18695b46da06c93135f5b51c548b950 ]

When a session is created, it sets a backpointer to its tunnel. When
the session refcount drops to 0, l2tp_session_free drops the tunnel
refcount if session->tunnel is non-NULL. However, session->tunnel is
set in l2tp_session_create, before the tunnel refcount is incremented
by l2tp_session_register, which leaves a small window where
session->tunnel is non-NULL when the tunnel refcount hasn't been
bumped.

Moving the assignment to l2tp_session_register is trivial but
l2tp_session_create calls l2tp_session_set_header_len which uses
session->tunnel to get the tunnel's encap. Add an encap arg to
l2tp_session_set_header_len to avoid using session->tunnel.

If l2tpv3 sessions have colliding IDs, it is possible for
l2tp_v3_session_get to race with l2tp_session_register and fetch a
session which doesn't yet have session->tunnel set. Add a check for
this case.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Stable backport notes:

Keep this tree's per-tunnel and per-net session hash lists. Assign
session->tunnel immediately after taking the tunnel reference in both
registration branches, before publishing the session with
hlist_add_head_rcu(). Registration failures therefore leave the tunnel
pointer NULL and cannot release an unacquired tunnel reference. Retain
the explicit encapsulation argument to l2tp_session_set_header_len() and
all its callers. Omit the upstream collision-table lookup hunk because
this tree has no such table and publishes only initialized sessions.

Rename the existing l2tp_tunnel_dec_refcount() and
l2tp_session_dec_refcount() functions, declarations, exports and callers
to l2tp_tunnel_put() and l2tp_session_put(). Their implementations are
unchanged; no functions are added. This aligns the context adjacent to
the notification calls so af20e269f745 applies cleanly with a three-way
cherry-pick while retaining this tree's session lookup implementation.

Restore the stable tunnel socket sk_user_data assignment, validation
and destructor clearing removed by the earlier 4a4cd70369f1 backport.
The stable lookup, UDP receive and tunnel destruction paths still rely
on that association. The newer validation also passed a const socket
to the old non-const lookup and dropped a reference that this lookup
does not acquire. Retaining the stable socket relationship avoids that
compiler diagnostic and preserves the existing tunnel lifetime model.

Stable-dep-of: af20e269f745 ("net: l2tp: do not propagate multicast notification errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_core.c    | 48 +++++++++++++++++++++--------------------
 net/l2tp/l2tp_core.h    |  7 +++---
 net/l2tp/l2tp_debugfs.c |  8 +++----
 net/l2tp/l2tp_eth.c     |  6 +++---
 net/l2tp/l2tp_ip.c      |  4 ++--
 net/l2tp/l2tp_ip6.c     |  4 ++--
 net/l2tp/l2tp_netlink.c | 40 ++++++++++++++++++----------------
 net/l2tp/l2tp_ppp.c     | 41 ++++++++++++++++++-----------------
 8 files changed, 82 insertions(+), 76 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 0f48d7fece498..7584c2f40f687 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -164,7 +164,7 @@ static void l2tp_session_free(struct l2tp_session *session)
 {
 	trace_free_session(session);
 	if (session->tunnel)
-		l2tp_tunnel_dec_refcount(session->tunnel);
+		l2tp_tunnel_put(session->tunnel);
 	kfree(session);
 }
 
@@ -186,12 +186,12 @@ void l2tp_tunnel_inc_refcount(struct l2tp_tunnel *tunnel)
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_inc_refcount);
 
-void l2tp_tunnel_dec_refcount(struct l2tp_tunnel *tunnel)
+void l2tp_tunnel_put(struct l2tp_tunnel *tunnel)
 {
 	if (refcount_dec_and_test(&tunnel->ref_count))
 		l2tp_tunnel_free(tunnel);
 }
-EXPORT_SYMBOL_GPL(l2tp_tunnel_dec_refcount);
+EXPORT_SYMBOL_GPL(l2tp_tunnel_put);
 
 void l2tp_session_inc_refcount(struct l2tp_session *session)
 {
@@ -199,12 +199,12 @@ void l2tp_session_inc_refcount(struct l2tp_session *session)
 }
 EXPORT_SYMBOL_GPL(l2tp_session_inc_refcount);
 
-void l2tp_session_dec_refcount(struct l2tp_session *session)
+void l2tp_session_put(struct l2tp_session *session)
 {
 	if (refcount_dec_and_test(&session->ref_count))
 		l2tp_session_free(session);
 }
-EXPORT_SYMBOL_GPL(l2tp_session_dec_refcount);
+EXPORT_SYMBOL_GPL(l2tp_session_put);
 
 /* Lookup a tunnel. A new reference is held on the returned tunnel. */
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id)
@@ -380,11 +380,13 @@ int l2tp_session_register(struct l2tp_session *session,
 			}
 
 		l2tp_tunnel_inc_refcount(tunnel);
+		session->tunnel = tunnel;
 		hlist_add_head_rcu(&session->global_hlist, g_head);
 
 		spin_unlock_bh(&pn->l2tp_session_hlist_lock);
 	} else {
 		l2tp_tunnel_inc_refcount(tunnel);
+		session->tunnel = tunnel;
 	}
 
 	hlist_add_head_rcu(&session->hlist, head);
@@ -698,7 +700,8 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 		if (!session->lns_mode && !session->send_seq) {
 			trace_session_seqnum_lns_enable(session);
 			session->send_seq = 1;
-			l2tp_session_set_header_len(session, tunnel->version);
+			l2tp_session_set_header_len(session, tunnel->version,
+						    tunnel->encap);
 		}
 	} else {
 		/* No sequence numbers.
@@ -719,7 +722,8 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 		if (!session->lns_mode && session->send_seq) {
 			trace_session_seqnum_lns_disable(session);
 			session->send_seq = 0;
-			l2tp_session_set_header_len(session, tunnel->version);
+			l2tp_session_set_header_len(session, tunnel->version,
+						    tunnel->encap);
 		} else if (session->send_seq) {
 			pr_debug_ratelimited("%s: recv data has no seq numbers when required. Discarding.\n",
 					     session->name);
@@ -863,7 +867,7 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	session = l2tp_tunnel_get_session(tunnel, session_id);
 	if (!session || !session->recv_skb) {
 		if (session)
-			l2tp_session_dec_refcount(session);
+			l2tp_session_put(session);
 
 		/* Not found? Pass to userspace to deal with */
 		pr_debug_ratelimited("%s: no session found (%u/%u). Passing up.\n",
@@ -873,12 +877,12 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 
 	if (tunnel->version == L2TP_HDR_VER_3 &&
 	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr)) {
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 		goto invalid;
 	}
 
 	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 0;
 
@@ -1166,6 +1170,7 @@ static void l2tp_tunnel_destruct(struct sock *sk)
 	/* Remove hooks into tunnel socket */
 	write_lock_bh(&sk->sk_callback_lock);
 	sk->sk_destruct = tunnel->old_sk_destruct;
+	sk->sk_user_data = NULL;
 	write_unlock_bh(&sk->sk_callback_lock);
 
 	/* Call the original destructor */
@@ -1271,10 +1276,10 @@ static void l2tp_tunnel_del_work(struct work_struct *work)
 
 	l2tp_tunnel_remove(tunnel->l2tp_net, tunnel);
 	/* drop initial ref */
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 	/* drop workqueue ref */
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 }
 
 /* Create a socket for the tunnel, if one isn't set up by
@@ -1447,8 +1452,6 @@ EXPORT_SYMBOL_GPL(l2tp_tunnel_create);
 static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
 				enum l2tp_encap_type encap)
 {
-	struct l2tp_tunnel *tunnel;
-
 	if (!net_eq(sock_net(sk), net))
 		return -EINVAL;
 
@@ -1462,11 +1465,8 @@ static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
 	    (encap == L2TP_ENCAPTYPE_IP && sk->sk_protocol != IPPROTO_L2TP))
 		return -EPROTONOSUPPORT;
 
-	tunnel = l2tp_sk_to_tunnel(sk);
-	if (tunnel) {
-		l2tp_tunnel_dec_refcount(tunnel);
+	if (sk->sk_user_data)
 		return -EBUSY;
-	}
 
 	return 0;
 }
@@ -1505,10 +1505,12 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 	ret = l2tp_validate_socket(sk, net, tunnel->encap);
 	if (ret < 0)
 		goto err_inval_sock;
+	rcu_assign_sk_user_data(sk, tunnel);
 	write_unlock_bh(&sk->sk_callback_lock);
 
 	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
 		struct udp_tunnel_sock_cfg udp_cfg = {
+			.sk_user_data = tunnel,
 			.encap_type = UDP_ENCAP_L2TPINUDP,
 			.encap_rcv = l2tp_udp_encap_recv,
 			.encap_destroy = l2tp_udp_encap_destroy,
@@ -1574,14 +1576,15 @@ void l2tp_session_delete(struct l2tp_session *session)
 	if (session->session_close)
 		(*session->session_close)(session);
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 }
 EXPORT_SYMBOL_GPL(l2tp_session_delete);
 
 /* We come here whenever a session's send_seq, cookie_len or
  * l2specific_type parameters are set.
  */
-void l2tp_session_set_header_len(struct l2tp_session *session, int version)
+void l2tp_session_set_header_len(struct l2tp_session *session, int version,
+				 enum l2tp_encap_type encap)
 {
 	if (version == L2TP_HDR_VER_2) {
 		session->hdr_len = 6;
@@ -1590,7 +1593,7 @@ void l2tp_session_set_header_len(struct l2tp_session *session, int version)
 	} else {
 		session->hdr_len = 4 + session->cookie_len;
 		session->hdr_len += l2tp_get_l2specific_len(session);
-		if (session->tunnel->encap == L2TP_ENCAPTYPE_UDP)
+		if (encap == L2TP_ENCAPTYPE_UDP)
 			session->hdr_len += 4;
 	}
 }
@@ -1604,7 +1607,6 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 	session = kzalloc(sizeof(*session) + priv_size, GFP_KERNEL);
 	if (session) {
 		session->magic = L2TP_SESSION_MAGIC;
-		session->tunnel = tunnel;
 
 		session->session_id = session_id;
 		session->peer_session_id = peer_session_id;
@@ -1640,7 +1642,7 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 			memcpy(&session->peer_cookie[0], &cfg->peer_cookie[0], cfg->peer_cookie_len);
 		}
 
-		l2tp_session_set_header_len(session, tunnel->version);
+		l2tp_session_set_header_len(session, tunnel->version, tunnel->encap);
 
 		refcount_set(&session->ref_count, 1);
 
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index a88e070b431d8..1d5dbe2017296 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -214,9 +214,9 @@ static inline void *l2tp_session_priv(struct l2tp_session *session)
 
 /* Tunnel and session refcounts */
 void l2tp_tunnel_inc_refcount(struct l2tp_tunnel *tunnel);
-void l2tp_tunnel_dec_refcount(struct l2tp_tunnel *tunnel);
+void l2tp_tunnel_put(struct l2tp_tunnel *tunnel);
 void l2tp_session_inc_refcount(struct l2tp_session *session);
-void l2tp_session_dec_refcount(struct l2tp_session *session);
+void l2tp_session_put(struct l2tp_session *session);
 
 /* Tunnel and session lookup.
  * These functions take a reference on the instances they return, so
@@ -261,7 +261,8 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb);
 
 /* Transmit path helpers for sending packets over the tunnel socket. */
-void l2tp_session_set_header_len(struct l2tp_session *session, int version);
+void l2tp_session_set_header_len(struct l2tp_session *session, int version,
+				 enum l2tp_encap_type encap);
 int l2tp_xmit_skb(struct l2tp_session *session, struct sk_buff *skb);
 
 /* Pseudowire management.
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index 4595b56d175d9..9890e898ee2ec 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -44,7 +44,7 @@ static void l2tp_dfs_next_tunnel(struct l2tp_dfs_seq_data *pd)
 {
 	/* Drop reference taken during previous invocation */
 	if (pd->tunnel)
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 
 	pd->tunnel = l2tp_tunnel_get_nth(pd->net, pd->tunnel_idx);
 	pd->tunnel_idx++;
@@ -54,7 +54,7 @@ static void l2tp_dfs_next_session(struct l2tp_dfs_seq_data *pd)
 {
 	/* Drop reference taken during previous invocation */
 	if (pd->session)
-		l2tp_session_dec_refcount(pd->session);
+		l2tp_session_put(pd->session);
 
 	pd->session = l2tp_session_get_nth(pd->tunnel, pd->session_idx);
 	pd->session_idx++;
@@ -109,11 +109,11 @@ static void l2tp_dfs_seq_stop(struct seq_file *p, void *v)
 	 * or l2tp_dfs_next_tunnel().
 	 */
 	if (pd->session) {
-		l2tp_session_dec_refcount(pd->session);
+		l2tp_session_put(pd->session);
 		pd->session = NULL;
 	}
 	if (pd->tunnel) {
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 		pd->tunnel = NULL;
 	}
 }
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 1f41d2f3b8c4e..5d45b2cc2aab0 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -311,7 +311,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 	if (rc < 0) {
 		rtnl_unlock();
 		l2tp_session_delete(session);
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 		free_netdev(dev);
 
 		return rc;
@@ -322,14 +322,14 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 
 	rtnl_unlock();
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	__module_get(THIS_MODULE);
 
 	return 0;
 
 err_sess_dev:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 	free_netdev(dev);
 err_sess:
 	kfree(session);
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 41a74fc84ca13..cbbc313ba226c 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -152,7 +152,7 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 		goto discard_sess;
 
 	l2tp_recv_common(session, skb, ptr, optr, 0, skb->len);
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 0;
 
@@ -185,7 +185,7 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 	return sk_receive_skb(sk, skb, 1);
 
 discard_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 	goto discard;
 
 discard_put:
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index e282b91b396c7..429f752122afe 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -165,7 +165,7 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 		goto discard_sess;
 
 	l2tp_recv_common(session, skb, ptr, optr, 0, skb->len);
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 0;
 
@@ -198,7 +198,7 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 	return sk_receive_skb(sk, skb, 1);
 
 discard_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 	goto discard;
 
 discard_put:
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index e27e00cb16c6b..1ba8eb6d8e8ae 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -62,7 +62,7 @@ static struct l2tp_session *l2tp_nl_session_get(struct genl_info *info)
 		tunnel = l2tp_tunnel_get(net, tunnel_id);
 		if (tunnel) {
 			session = l2tp_tunnel_get_session(tunnel, session_id);
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_tunnel_put(tunnel);
 		}
 	}
 
@@ -249,7 +249,7 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 	}
 	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
 				 L2TP_CMD_TUNNEL_CREATE);
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 out:
 	return ret;
@@ -279,7 +279,7 @@ static int l2tp_nl_cmd_tunnel_delete(struct sk_buff *skb, struct genl_info *info
 
 	l2tp_tunnel_delete(tunnel);
 
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 out:
 	return ret;
@@ -307,7 +307,7 @@ static int l2tp_nl_cmd_tunnel_modify(struct sk_buff *skb, struct genl_info *info
 	ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
 				 tunnel, L2TP_CMD_TUNNEL_MODIFY);
 
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 out:
 	return ret;
@@ -478,12 +478,12 @@ static int l2tp_nl_cmd_tunnel_get(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto err_nlmsg_tunnel;
 
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 	return genlmsg_unicast(net, msg, info->snd_portid);
 
 err_nlmsg_tunnel:
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 err_nlmsg:
 	nlmsg_free(msg);
 err:
@@ -504,10 +504,10 @@ static int l2tp_nl_cmd_tunnel_dump(struct sk_buff *skb, struct netlink_callback
 		if (l2tp_nl_tunnel_send(skb, NETLINK_CB(cb->skb).portid,
 					cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					tunnel, L2TP_CMD_TUNNEL_GET) < 0) {
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_tunnel_put(tunnel);
 			goto out;
 		}
-		l2tp_tunnel_dec_refcount(tunnel);
+		l2tp_tunnel_put(tunnel);
 
 		ti++;
 	}
@@ -639,12 +639,12 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 		if (session) {
 			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
 						  L2TP_CMD_SESSION_CREATE);
-			l2tp_session_dec_refcount(session);
+			l2tp_session_put(session);
 		}
 	}
 
 out_tunnel:
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 out:
 	return ret;
 }
@@ -669,7 +669,7 @@ static int l2tp_nl_cmd_session_delete(struct sk_buff *skb, struct genl_info *inf
 		if (l2tp_nl_cmd_ops[pw_type] && l2tp_nl_cmd_ops[pw_type]->session_delete)
 			l2tp_nl_cmd_ops[pw_type]->session_delete(session);
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 out:
 	return ret;
@@ -690,8 +690,10 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 		session->recv_seq = nla_get_u8(info->attrs[L2TP_ATTR_RECV_SEQ]);
 
 	if (info->attrs[L2TP_ATTR_SEND_SEQ]) {
+		struct l2tp_tunnel *tunnel = session->tunnel;
+
 		session->send_seq = nla_get_u8(info->attrs[L2TP_ATTR_SEND_SEQ]);
-		l2tp_session_set_header_len(session, session->tunnel->version);
+		l2tp_session_set_header_len(session, tunnel->version, tunnel->encap);
 	}
 
 	if (info->attrs[L2TP_ATTR_LNS_MODE])
@@ -703,7 +705,7 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	ret = l2tp_session_notify(&l2tp_nl_family, info,
 				  session, L2TP_CMD_SESSION_MODIFY);
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 out:
 	return ret;
@@ -814,14 +816,14 @@ static int l2tp_nl_cmd_session_get(struct sk_buff *skb, struct genl_info *info)
 
 	ret = genlmsg_unicast(genl_info_net(info), msg, info->snd_portid);
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return ret;
 
 err_ref_msg:
 	nlmsg_free(msg);
 err_ref:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 err:
 	return ret;
 }
@@ -844,7 +846,7 @@ static int l2tp_nl_cmd_session_dump(struct sk_buff *skb, struct netlink_callback
 		session = l2tp_session_get_nth(tunnel, si);
 		if (!session) {
 			ti++;
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_tunnel_put(tunnel);
 			tunnel = NULL;
 			si = 0;
 			continue;
@@ -853,11 +855,11 @@ static int l2tp_nl_cmd_session_dump(struct sk_buff *skb, struct netlink_callback
 		if (l2tp_nl_session_send(skb, NETLINK_CB(cb->skb).portid,
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					 session, L2TP_CMD_SESSION_GET) < 0) {
-			l2tp_session_dec_refcount(session);
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_session_put(session);
+			l2tp_tunnel_put(tunnel);
 			break;
 		}
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 
 		si++;
 	}
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index f25b9c0c198a2..1d17e523b254b 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -302,12 +302,12 @@ static int pppol2tp_sendmsg(struct socket *sock, struct msghdr *m,
 	l2tp_xmit_skb(session, skb);
 	local_bh_enable();
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return total_len;
 
 error_put_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 error:
 	return error;
 }
@@ -361,12 +361,12 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	l2tp_xmit_skb(session, skb);
 	local_bh_enable();
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 1;
 
 abort_put_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 abort:
 	/* Free the original skb */
 	kfree_skb(skb);
@@ -402,7 +402,7 @@ static void pppol2tp_session_close(struct l2tp_session *session)
 		sock_put(ps->__sk);
 
 		/* drop ref taken when we referenced socket via sk_user_data */
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 	}
 }
 
@@ -433,7 +433,7 @@ static int pppol2tp_release(struct socket *sock)
 	if (session) {
 		l2tp_session_delete(session);
 		/* drop ref taken by pppol2tp_sock_to_session */
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 	}
 
 	release_sock(sk);
@@ -674,7 +674,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 
 		/* Error if socket is not prepped */
 		if (!tunnel->sock) {
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_tunnel_put(tunnel);
 			return ERR_PTR(-ENOENT);
 		}
 	}
@@ -824,8 +824,8 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 			l2tp_tunnel_delete(tunnel);
 	}
 	if (drop_refcnt)
-		l2tp_session_dec_refcount(session);
-	l2tp_tunnel_dec_refcount(tunnel);
+		l2tp_session_put(session);
+	l2tp_tunnel_put(tunnel);
 	release_sock(sk);
 
 	return error;
@@ -976,7 +976,7 @@ static int pppol2tp_getname(struct socket *sock, struct sockaddr *uaddr,
 
 	error = len;
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 end:
 	return error;
 }
@@ -1025,12 +1025,12 @@ static int pppol2tp_tunnel_copy_stats(struct pppol2tp_ioc_stats *stats,
 		return -EBADR;
 
 	if (session->pwtype != L2TP_PWTYPE_PPP) {
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 		return -EBADR;
 	}
 
 	pppol2tp_copy_stats(stats, &session->stats);
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 0;
 }
@@ -1178,7 +1178,8 @@ static int pppol2tp_session_setsockopt(struct sock *sk,
 			po->chan.hdrlen = val ? PPPOL2TP_L2TP_HDR_SIZE_SEQ :
 				PPPOL2TP_L2TP_HDR_SIZE_NOSEQ;
 		}
-		l2tp_session_set_header_len(session, session->tunnel->version);
+		l2tp_session_set_header_len(session, session->tunnel->version,
+					    session->tunnel->encap);
 		break;
 
 	case PPPOL2TP_SO_LNSMODE:
@@ -1247,7 +1248,7 @@ static int pppol2tp_setsockopt(struct socket *sock, int level, int optname,
 		err = pppol2tp_session_setsockopt(sk, session, optname, val);
 	}
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 end:
 	return err;
 }
@@ -1368,7 +1369,7 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	err = 0;
 
 end_put_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 end:
 	return err;
 }
@@ -1395,7 +1396,7 @@ static void pppol2tp_next_tunnel(struct net *net, struct pppol2tp_seq_data *pd)
 {
 	/* Drop reference taken during previous invocation */
 	if (pd->tunnel)
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 
 	for (;;) {
 		pd->tunnel = l2tp_tunnel_get_nth(net, pd->tunnel_idx);
@@ -1405,7 +1406,7 @@ static void pppol2tp_next_tunnel(struct net *net, struct pppol2tp_seq_data *pd)
 		if (!pd->tunnel || pd->tunnel->version == 2)
 			return;
 
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 	}
 }
 
@@ -1413,7 +1414,7 @@ static void pppol2tp_next_session(struct net *net, struct pppol2tp_seq_data *pd)
 {
 	/* Drop reference taken during previous invocation */
 	if (pd->session)
-		l2tp_session_dec_refcount(pd->session);
+		l2tp_session_put(pd->session);
 
 	pd->session = l2tp_session_get_nth(pd->tunnel, pd->session_idx);
 	pd->session_idx++;
@@ -1471,11 +1472,11 @@ static void pppol2tp_seq_stop(struct seq_file *p, void *v)
 	 * or pppol2tp_next_tunnel().
 	 */
 	if (pd->session) {
-		l2tp_session_dec_refcount(pd->session);
+		l2tp_session_put(pd->session);
 		pd->session = NULL;
 	}
 	if (pd->tunnel) {
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 		pd->tunnel = NULL;
 	}
 }
-- 
2.53.0

