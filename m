Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5438E11A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976322; cv=none; b=l6+2Cz5KCb9eYVbYVxQ0G8YoLoi4Ru+GMMvqhMMSOd8ywSDHE0If/4YYt/fiK3BKyXsrG1huO9G1TWiCLu2x63Us9Ob7x+YrS8jiA5bRhCtBa02bFP8VXJYdjhgJ8MduFsR1CfJJYF0TzQyuVo9xTfuO6n08WcHKzHqp8TeeYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976322; c=relaxed/simple;
	bh=KAQEZbrf2IQpKl8FSvBTVQ3NG+gpiO7NBEz4wD8Npmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJJta9K/rgp41GNXLaqHTWlVFSbqJP6RO6StoDbku3ppnWftJdOoR50O0R4+ZRFIqd8Lo41RQqTEhgXAjK3QWkX5cODaS0FXo+qgAWTeKIeqPk89zDDR8mo1hb0Nj7dm6kvciYiY2RZqIuhBi69emNnkiifFChm2IZQQZtN9v78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkBLHIKr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkBLHIKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DD11F00898;
	Wed,  9 Sep 2026 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976320;
	bh=n8AeSPsEMIN+XrtulXVWcOJtQraUY9L9xZ9H0P5VeTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nkBLHIKr5tmK7HyU2kAoKZy5MnlAs4ag6+u0cGs1Dinj4BfPcUHBX2uyKfyqNYPS1
	 A6OsrPx4cWFZWq9IVSD5zRSppmf34zed4u6/cM/EXC6Ssw3I/4Z/Mxb9iljLP0waHw
	 ZudCL7hjq4QUx1RTOWzKwjoulMIkrbQ5/WBEaBC5qXo3vQrKZyOlcEz3sGPB91QNLL
	 gHSBxFw0XR1k0y+j9vvR+EdxPU/kUgDqLfNpXPxYXHeukWzHVmJE9GUUeuX1fpqOkL
	 82l0r9vI4I+wCJ2HIKrHH2yCHuPfCuCXzVqfkZIKPd9jA+gp9MPf5DPAOaI44dSB9i
	 tKebbaZiVUPlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] l2tp: refactor ppp socket/session relationship
Date: Wed,  9 Sep 2026 13:51:53 -0400
Message-ID: <20260909175157.3360687-2-sashal@kernel.org>
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

[ Upstream commit c5cbaef992d6420d8bcebea1b1fcc23302a67c57 ]

Each l2tp ppp session has an associated pppox socket. l2tp_ppp uses
the session's pppox socket refcount to manage session lifetimes; the
pppox socket holds a ref on the session which is dropped by the socket
destructor. This complicates session cleanup.

Given l2tp sessions are refcounted, it makes more sense to reverse
this relationship such that the session keeps the socket alive, not
the other way around. So refactor l2tp_ppp to have the session hold a
ref on its socket while it references it. When the session is closed,
it drops its socket ref when it detaches from its socket. If the
socket is closed first, it initiates the closing of its session, if
one is attached. The socket/session can then be freed asynchronously
when their refcounts drop to 0.

Use the session's session_close callback to detach the pppox socket
since this will be done on the work queue together with the rest of
the session cleanup via l2tp_session_delete.

Also, since l2tp_ppp uses the pppox socket's sk_user_data, use the rcu
sk_user_data access helpers when accessing it and set the socket's
SOCK_RCU_FREE flag to have pppox sockets freed by rcu.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: af20e269f745 ("net: l2tp: do not propagate multicast notification errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 94 +++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 55 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 2e856a83a7506..f25b9c0c198a2 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -119,7 +119,6 @@ struct pppol2tp_session {
 	struct mutex		sk_lock;	/* Protects .sk */
 	struct sock __rcu	*sk;		/* Pointer to the session PPPoX socket */
 	struct sock		*__sk;		/* Copy of .sk, for cleanup */
-	struct rcu_head		rcu;		/* For asynchronous release */
 };
 
 static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb);
@@ -147,20 +146,16 @@ static inline struct l2tp_session *pppol2tp_sock_to_session(struct sock *sk)
 	if (!sk)
 		return NULL;
 
-	sock_hold(sk);
-	session = (struct l2tp_session *)(sk->sk_user_data);
-	if (!session) {
-		sock_put(sk);
-		goto out;
-	}
-	if (WARN_ON(session->magic != L2TP_SESSION_MAGIC)) {
-		session = NULL;
-		sock_put(sk);
-		goto out;
+	rcu_read_lock();
+	session = rcu_dereference_sk_user_data(sk);
+	if (session && refcount_inc_not_zero(&session->ref_count)) {
+		rcu_read_unlock();
+		WARN_ON_ONCE(session->magic != L2TP_SESSION_MAGIC);
+		return session;
 	}
+	rcu_read_unlock();
 
-out:
-	return session;
+	return NULL;
 }
 
 /*****************************************************************************
@@ -307,12 +302,12 @@ static int pppol2tp_sendmsg(struct socket *sock, struct msghdr *m,
 	l2tp_xmit_skb(session, skb);
 	local_bh_enable();
 
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 
 	return total_len;
 
 error_put_sess:
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 error:
 	return error;
 }
@@ -366,12 +361,12 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	l2tp_xmit_skb(session, skb);
 	local_bh_enable();
 
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 
 	return 1;
 
 abort_put_sess:
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 abort:
 	/* Free the original skb */
 	kfree_skb(skb);
@@ -382,28 +377,31 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
  * Session (and tunnel control) socket create/destroy.
  *****************************************************************************/
 
-static void pppol2tp_put_sk(struct rcu_head *head)
-{
-	struct pppol2tp_session *ps;
-
-	ps = container_of(head, typeof(*ps), rcu);
-	sock_put(ps->__sk);
-}
-
 /* Really kill the session socket. (Called from sock_put() if
  * refcnt == 0.)
  */
 static void pppol2tp_session_destruct(struct sock *sk)
 {
-	struct l2tp_session *session = sk->sk_user_data;
-
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
+}
 
-	if (session) {
-		sk->sk_user_data = NULL;
-		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return;
+static void pppol2tp_session_close(struct l2tp_session *session)
+{
+	struct pppol2tp_session *ps;
+
+	ps = l2tp_session_priv(session);
+	mutex_lock(&ps->sk_lock);
+	ps->__sk = rcu_dereference_protected(ps->sk,
+					     lockdep_is_held(&ps->sk_lock));
+	RCU_INIT_POINTER(ps->sk, NULL);
+	mutex_unlock(&ps->sk_lock);
+	if (ps->__sk) {
+		/* detach socket */
+		rcu_assign_sk_user_data(ps->__sk, NULL);
+		sock_put(ps->__sk);
+
+		/* drop ref taken when we referenced socket via sk_user_data */
 		l2tp_session_dec_refcount(session);
 	}
 }
@@ -433,30 +431,13 @@ static int pppol2tp_release(struct socket *sock)
 
 	session = pppol2tp_sock_to_session(sk);
 	if (session) {
-		struct pppol2tp_session *ps;
-
 		l2tp_session_delete(session);
-
-		ps = l2tp_session_priv(session);
-		mutex_lock(&ps->sk_lock);
-		ps->__sk = rcu_dereference_protected(ps->sk,
-						     lockdep_is_held(&ps->sk_lock));
-		RCU_INIT_POINTER(ps->sk, NULL);
-		mutex_unlock(&ps->sk_lock);
-		call_rcu(&ps->rcu, pppol2tp_put_sk);
-
-		/* Rely on the sock_put() call at the end of the function for
-		 * dropping the reference held by pppol2tp_sock_to_session().
-		 * The last reference will be dropped by pppol2tp_put_sk().
-		 */
+		/* drop ref taken by pppol2tp_sock_to_session */
+		l2tp_session_dec_refcount(session);
 	}
 
 	release_sock(sk);
 
-	/* This will delete the session context via
-	 * pppol2tp_session_destruct() if the socket's refcnt drops to
-	 * zero.
-	 */
 	sock_put(sk);
 
 	return 0;
@@ -495,6 +476,7 @@ static int pppol2tp_create(struct net *net, struct socket *sock, int kern)
 		goto out;
 
 	sock_init_data(sock, sk);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	sock->state  = SS_UNCONNECTED;
 	sock->ops    = &pppol2tp_ops;
@@ -532,6 +514,7 @@ static void pppol2tp_session_init(struct l2tp_session *session)
 	struct pppol2tp_session *ps;
 
 	session->recv_skb = pppol2tp_recv;
+	session->session_close = pppol2tp_session_close;
 	if (IS_ENABLED(CONFIG_L2TP_DEBUGFS))
 		session->show = pppol2tp_show;
 
@@ -820,12 +803,13 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
-	sk->sk_user_data = session;
+	sock_hold(sk);
+	rcu_assign_sk_user_data(sk, session);
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);
 
 	/* Keep the reference we've grabbed on the session: sk doesn't expect
-	 * the session to disappear. pppol2tp_session_destruct() is responsible
+	 * the session to disappear. pppol2tp_session_close() is responsible
 	 * for dropping it.
 	 */
 	drop_refcnt = false;
@@ -992,7 +976,7 @@ static int pppol2tp_getname(struct socket *sock, struct sockaddr *uaddr,
 
 	error = len;
 
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 end:
 	return error;
 }
@@ -1263,7 +1247,7 @@ static int pppol2tp_setsockopt(struct socket *sock, int level, int optname,
 		err = pppol2tp_session_setsockopt(sk, session, optname, val);
 	}
 
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 end:
 	return err;
 }
@@ -1384,7 +1368,7 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	err = 0;
 
 end_put_sess:
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 end:
 	return err;
 }
-- 
2.53.0

