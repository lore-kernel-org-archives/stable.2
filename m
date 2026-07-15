Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797843C1989
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150808; cv=none; b=D+FXlaksc4GtQqgl+uR+M2+s8rcTNbJyShSWdR/0YkZTGpcsebcsWsTtcXj3Avn/0aFmEThQW0SDGRaQG9riJS+0V+27f7ZcZaQZ6IA+hYgohBVCgkMr6N08GvHLTWq1rBY5Fm8JUA0aKZr0HYkZL5QIyn4t/WN5pmarTqqpo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150808; c=relaxed/simple;
	bh=TERAh0X///3fZnL8pKWttR9b3q0pP26cV4iCHEUbM9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6hJk2oJy0Shqih4cIfIxclN2jm40Zg7SpG7nYCGBv1+Ba8CyzmYM0EvuwleVjr4DkLoL2dGZn+CrjlRjLCQpWtHxy9LOfleeqy3b0I6q9D/uMZdJuQfawWOsSVw9Dq4K4t8NH6fG+YXVQWLRdVHzPyr20PPFX77lGnsz2I8IXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os3mwWy7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os3mwWy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D151F00A3D;
	Wed, 15 Jul 2026 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150806;
	bh=KQ7lsdzBDCmvxkZo7jbIgyVfltjCf4Eozg6yzvqXz4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=os3mwWy7YhJGK6jZbSjPqiyfdbTXMFTvFXnup3drc/CBUZEW8HsS6lKyy12s371V8
	 lmHlkM3l9W+lkbWJgHmTbIlGrgxJgU0Dssy9uidLJyQfmCY43t7Je0i/UWYHGDLM4B
	 gufqzm65vxkVrW3VovrEHMktztJ+EXL5bqK+/79aMKTpL9S8HOGI4AfS4pETwvaWIz
	 d8RDTk3ZjUsLZHVYv5Wd9HpBpsON/MeGWgp40RzNnDYkbZ+mZOdiPd+Nt+/vt5dEEC
	 mY1b0oPuRXes3kuDZy4aXRMH5XZ3e2IVngfzYvr+RM8wl5eR0pWVEkA5UGJ0ZZw9pB
	 YEGD1v+KsxCZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	stable@kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Wed, 15 Jul 2026 17:26:43 -0400
Message-ID: <20260715212643.278587-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715212643.278587-1-sashal@kernel.org>
References: <2026071307-pointy-oven-47d3@gregkh>
 <20260715212643.278587-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siwei Zhang <oss@fourdim.xyz>

[ Upstream commit 6fef032af0092ed5ccb767239a9ac1bc38c08a40 ]

l2cap_sock_new_connection_cb() returned l2cap_pi(sk)->chan after
release_sock(parent). Once the parent lock is dropped the newly
enqueued child socket sk is reachable via the accept queue, so another
task can accept and free it before the callback dereferences sk,
resulting in a use-after-free.

Rework the ->new_connection() op so the core, rather than the callback,
owns the child channel's lifetime. The op now receives a pre-allocated
new_chan and returns an errno instead of allocating and returning a
channel. l2cap_new_connection() allocates the child channel and links
it into the conn list via __l2cap_chan_add() before invoking the
callback, so the conn-list reference keeps the channel alive once
release_sock(parent) exposes the socket to other tasks.

Channel configuration that was duplicated in l2cap_sock_init() and the
various new_connection callbacks is consolidated into
l2cap_chan_set_defaults(), which now inherits from the parent channel
when one is supplied.

Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_core.c")
Cc: stable@kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/l2cap.h |  10 ++--
 net/bluetooth/6lowpan.c       |  18 +-----
 net/bluetooth/l2cap_core.c    |  78 ++++++++++++++++++++-----
 net/bluetooth/l2cap_sock.c    | 103 ++++++++++++++++------------------
 net/bluetooth/smp.c           |  27 ++-------
 5 files changed, 127 insertions(+), 109 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index bf23edb0283874..98153484ebf433 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -614,7 +614,8 @@ struct l2cap_chan {
 struct l2cap_ops {
 	char			*name;
 
-	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
+	int			(*new_connection)(struct l2cap_chan *chan,
+						  struct l2cap_chan *new_chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err);
@@ -878,9 +879,10 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
 	return (seq + 1) % (chan->tx_win_max + 1);
 }
 
-static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan *chan)
+static inline int l2cap_chan_no_new_connection(struct l2cap_chan *chan,
+					       struct l2cap_chan *new_chan)
 {
-	return NULL;
+	return -EOPNOTSUPP;
 }
 
 static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -956,7 +958,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
-void l2cap_chan_set_defaults(struct l2cap_chan *chan);
+void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 1d4577dcfb4cc2..e2196cf4f6f70d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -631,7 +631,7 @@ static struct l2cap_chan *chan_create(void)
 	if (!chan)
 		return NULL;
 
-	l2cap_chan_set_defaults(chan);
+	l2cap_chan_set_defaults(chan, NULL);
 
 	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
@@ -744,21 +744,6 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 	ifup(dev->netdev);
 }
 
-static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
-{
-	struct l2cap_chan *chan;
-
-	chan = chan_create();
-	if (!chan)
-		return NULL;
-
-	chan->ops = pchan->ops;
-
-	BT_DBG("chan %p pchan %p", chan, pchan);
-
-	return chan;
-}
-
 static void unregister_dev(struct lowpan_btle_dev *dev)
 {
 	struct hci_dev *hdev = READ_ONCE(dev->hdev);
@@ -900,7 +885,6 @@ static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
 
 static const struct l2cap_ops bt_6lowpan_chan_ops = {
 	.name			= "L2CAP 6LoWPAN channel",
-	.new_connection		= chan_new_conn_cb,
 	.recv			= chan_recv_cb,
 	.close			= chan_close_cb,
 	.state_change		= chan_state_change_cb,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3426eedf20ad96..333051c9024733 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -519,7 +519,10 @@ void l2cap_chan_put(struct l2cap_chan *c)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_put);
 
-void l2cap_chan_set_defaults(struct l2cap_chan *chan)
+/* Initialise @chan with default values, inheriting from the parent channel
+ * @pchan when it is given.
+ */
+void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan)
 {
 	chan->fcs  = L2CAP_FCS_CRC16;
 	chan->max_tx = L2CAP_DEFAULT_MAX_TX;
@@ -533,6 +536,31 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
 	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
 
+	if (pchan) {
+		BT_DBG("chan %p pchan %p", chan, pchan);
+
+		chan->chan_type = pchan->chan_type;
+		chan->imtu = pchan->imtu;
+		chan->omtu = pchan->omtu;
+		chan->mode = pchan->mode;
+		chan->fcs = pchan->fcs;
+		chan->max_tx = pchan->max_tx;
+		chan->tx_win = pchan->tx_win;
+		chan->tx_win_max = pchan->tx_win_max;
+		chan->sec_level = pchan->sec_level;
+		chan->conf_state = pchan->conf_state;
+		chan->flags = pchan->flags;
+		chan->tx_credits = pchan->tx_credits;
+		chan->rx_credits = pchan->rx_credits;
+
+		if (chan->chan_type == L2CAP_CHAN_FIXED) {
+			chan->scid = pchan->scid;
+			chan->dcid = pchan->scid;
+		}
+
+		return;
+	}
+
 	chan->conf_state = 0;
 	set_bit(CONF_NOT_COMPLETE, &chan->conf_state);
 
@@ -3955,6 +3983,38 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
+/* Allocate and initialise a channel for an incoming connection.
+ *
+ * The channel inherits its configuration from @pchan and is linked into @conn
+ * before ->new_connection() runs, so the conn list reference keeps it alive if
+ * the callback exposes it (e.g. via the socket accept queue) before this
+ * returns. The l2cap_chan_create() reference is taken over by the subsystem on
+ * success and dropped here on failure.
+ */
+static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
+					       struct l2cap_chan *pchan)
+{
+	struct l2cap_chan *chan;
+
+	chan = l2cap_chan_create();
+	if (!chan)
+		return NULL;
+
+	l2cap_chan_set_defaults(chan, pchan);
+	chan->ops = pchan->ops;
+
+	__l2cap_chan_add(conn, chan);
+
+	if (pchan->ops->new_connection &&
+	    pchan->ops->new_connection(pchan, chan) < 0) {
+		l2cap_chan_del(chan, 0);
+		l2cap_chan_put(chan);
+		return NULL;
+	}
+
+	return chan;
+}
+
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
 {
@@ -4001,7 +4061,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan)
 		goto response;
 
@@ -4019,8 +4079,6 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	chan->psm  = psm;
 	chan->dcid = scid;
 
-	__l2cap_chan_add(conn, chan);
-
 	dcid = chan->scid;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
@@ -4889,7 +4947,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan) {
 		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
@@ -4904,8 +4962,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
 
-	__l2cap_chan_add(conn, chan);
-
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
@@ -5114,7 +5170,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(conn, pchan);
 		if (!chan) {
 			result = L2CAP_CR_LE_NO_MEM;
 			continue;
@@ -5129,8 +5185,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
 
-		__l2cap_chan_add(conn, chan);
-
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
 		/* Init response */
@@ -7401,14 +7455,12 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			goto next;
 
 		l2cap_chan_lock(pchan);
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(conn, pchan);
 		if (chan) {
 			bacpy(&chan->src, &hcon->src);
 			bacpy(&chan->dst, &hcon->dst);
 			chan->src_type = bdaddr_src_type(hcon);
 			chan->dst_type = dst_type;
-
-			__l2cap_chan_add(conn, chan);
 		}
 
 		l2cap_chan_unlock(pchan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3e9b27d3a61032..47f0d5dcbb7f39 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -45,7 +45,8 @@ static struct bt_sock_list l2cap_sk_list = {
 static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern);
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
@@ -1240,6 +1241,23 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+/* Release the sock's ref on chan and clear the pointer so that the ref is
+ * dropped exactly once even if both l2cap_sock_kill() and
+ * l2cap_sock_destruct() run. Setting chan->data to NULL first stops any other
+ * task from dereferencing the now-dead sock pointer.
+ */
+static void l2cap_sock_put_chan(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+	if (!chan)
+		return;
+
+	chan->data = NULL;
+	l2cap_pi(sk)->chan = NULL;
+	l2cap_chan_put(chan);
+}
+
 /* Kill socket (only if zapped and orphan)
  * Must be called on unlocked socket, with l2cap channel lock.
  */
@@ -1250,13 +1268,9 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
-	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
-	 * sock pointer.
-	 */
-	l2cap_pi(sk)->chan->data = NULL;
-	/* Kill poor orphan */
+	l2cap_sock_put_chan(sk);
 
-	l2cap_chan_put(l2cap_pi(sk)->chan);
+	/* Kill poor orphan */
 	sock_set_flag(sk, SOCK_DEAD);
 	sock_put(sk);
 }
@@ -1499,12 +1513,13 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	}
 }
 
-static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
+static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
+					struct l2cap_chan *new_chan)
 {
 	struct sock *sk, *parent = chan->data;
 
 	if (!parent)
-		return NULL;
+		return -EINVAL;
 
 	lock_sock(parent);
 
@@ -1512,25 +1527,28 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
 		release_sock(parent);
-		return NULL;
+		return -ENOBUFS;
 	}
 
 	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
-			      GFP_ATOMIC, 0);
+			      GFP_ATOMIC, 0, new_chan);
 	if (!sk) {
 		release_sock(parent);
-		return NULL;
-        }
+		return -ENOMEM;
+	}
 
 	bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
 
 	l2cap_sock_init(sk, parent);
 
+	/* The conn list reference taken by l2cap_new_connection() keeps new_chan
+	 * alive once release_sock() lets another task free this socket.
+	 */
 	bt_accept_enqueue(parent, sk, false);
 
 	release_sock(parent);
 
-	return l2cap_pi(sk)->chan;
+	return 0;
 }
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -1828,10 +1846,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 
 	BT_DBG("sk %p", sk);
 
-	if (l2cap_pi(sk)->chan) {
-		l2cap_pi(sk)->chan->data = NULL;
-		l2cap_chan_put(l2cap_pi(sk)->chan);
-	}
+	l2cap_sock_put_chan(sk);
 
 	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
 		kfree_skb(rx_busy->skb);
@@ -1863,30 +1878,12 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 	BT_DBG("sk %p", sk);
 
 	if (parent) {
-		struct l2cap_chan *pchan = l2cap_pi(parent)->chan;
-
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->flags = bt_sk(parent)->flags;
 
-		chan->chan_type = pchan->chan_type;
-		chan->imtu = pchan->imtu;
-		chan->omtu = pchan->omtu;
-		chan->conf_state = pchan->conf_state;
-		chan->mode = pchan->mode;
-		chan->fcs  = pchan->fcs;
-		chan->max_tx = pchan->max_tx;
-		chan->tx_win = pchan->tx_win;
-		chan->tx_win_max = pchan->tx_win_max;
-		chan->sec_level = pchan->sec_level;
-		chan->flags = pchan->flags;
-		chan->tx_credits = pchan->tx_credits;
-		chan->rx_credits = pchan->rx_credits;
-
-		if (chan->chan_type == L2CAP_CHAN_FIXED) {
-			chan->scid = pchan->scid;
-			chan->dcid = pchan->scid;
-		}
-
+		/* Channel configuration is inherited from the parent by
+		 * l2cap_new_connection().
+		 */
 		security_sk_clone(parent, sk);
 	} else {
 		switch (sk->sk_type) {
@@ -1912,7 +1909,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 			chan->mode = L2CAP_MODE_BASIC;
 		}
 
-		l2cap_chan_set_defaults(chan);
+		l2cap_chan_set_defaults(chan, NULL);
 	}
 
 	/* Default config options */
@@ -1931,10 +1928,10 @@ static struct proto l2cap_proto = {
 };
 
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern)
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan)
 {
 	struct sock *sk;
-	struct l2cap_chan *chan;
 
 	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
 	if (!sk)
@@ -1945,16 +1942,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
 
-	chan = l2cap_chan_create();
-	if (!chan) {
-		sk_free(sk);
-		if (sock)
-			sock->sk = NULL;
-		return NULL;
-	}
-
-	l2cap_chan_hold(chan);
-
+	/* The sock takes ownership of the caller's reference on chan. */
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
@@ -1964,6 +1952,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -1978,10 +1967,16 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &l2cap_sock_ops;
 
-	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
-	if (!sk)
+	chan = l2cap_chan_create();
+	if (!chan)
 		return -ENOMEM;
 
+	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, chan);
+	if (!sk) {
+		l2cap_chan_put(chan);
+		return -ENOMEM;
+	}
+
 	l2cap_sock_init(sk, NULL);
 	bt_sock_link(&l2cap_sk_list, sk);
 	return 0;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6fabc76aa9d7c6..49e0e412c6c5bb 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3235,34 +3235,19 @@ static const struct l2cap_ops smp_chan_ops = {
 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
 };
 
-static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
+static inline int smp_new_conn_cb(struct l2cap_chan *chan,
+				  struct l2cap_chan *new_chan)
 {
-	struct l2cap_chan *chan;
-
-	BT_DBG("pchan %p", pchan);
-
-	chan = l2cap_chan_create();
-	if (!chan)
-		return NULL;
-
-	chan->chan_type	= pchan->chan_type;
-	chan->ops	= &smp_chan_ops;
-	chan->scid	= pchan->scid;
-	chan->dcid	= chan->scid;
-	chan->imtu	= pchan->imtu;
-	chan->omtu	= pchan->omtu;
-	chan->mode	= pchan->mode;
+	new_chan->ops = &smp_chan_ops;
 
 	/* Other L2CAP channels may request SMP routines in order to
 	 * change the security level. This means that the SMP channel
 	 * lock must be considered in its own category to avoid lockdep
 	 * warnings.
 	 */
-	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
-
-	BT_DBG("created chan %p", chan);
+	atomic_set(&new_chan->nesting, L2CAP_NESTING_SMP);
 
-	return chan;
+	return 0;
 }
 
 static const struct l2cap_ops smp_root_chan_ops = {
@@ -3333,7 +3318,7 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 
 	l2cap_add_scid(chan, cid);
 
-	l2cap_chan_set_defaults(chan);
+	l2cap_chan_set_defaults(chan, NULL);
 
 	if (cid == L2CAP_CID_SMP) {
 		u8 bdaddr_type;
-- 
2.53.0

