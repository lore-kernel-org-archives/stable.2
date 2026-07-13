Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98662441A6
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963866; cv=none; b=AYstFmX1y+6bApGjz+GI63O02tJoafglxqA8grIN9fkaZOPTJL5cj4CltRyh526puaqAPjBbfy/RZ1egijtvUWXEJ8+LiXWKNHktnZMXzNuTUks3ZEfgmcdAbvRlpMX5iYOa6jWy8gwmjcX71EVrMGBDbdo/mqfiGEQpzqTu8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963866; c=relaxed/simple;
	bh=VWs9bOtjE7uYn5vlYGK5qARfbYpiF5fWJzRowzE2zBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jxEjdl5AkdIDKAVPj2oF1IGgcRQQxhXFf2b6EQfxd00PWTRNlu3jvDFdaowZJdMDMUqle94xdFs6/8u7YPJwRt744rVP9Ja6PbOM2hA293fZUHtPmm/l4t0RDqjh/emTlJvmJSOtix9VzCYyCR1SsQ1+/Hz9I7UgrIB0zKLSVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j7fOmE8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j7fOmE8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9591F000E9;
	Mon, 13 Jul 2026 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783963864;
	bh=o1HR8XrbfHelIVFrs2b4dM9i3Qi0MIaBAmSYQNo1JU0=;
	h=Subject:To:Cc:From:Date;
	b=j7fOmE8IpHplq6UadvYgcWhB3ZngXHITMbuqQDt4Mbb65Ljx4aDo7fiyL1cyJVkfe
	 PqI1IFqZ6oiqng4mCWnUpOAyb1ovSJGGKIDf+WZoq/3hblesw8OxJJ0pq5RIDfygRu
	 7r7A/pwqVWs52I1PHMneuPjckBCpYZg69Gu748CE=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Fix use-after-free in" failed to apply to 6.1-stable tree
To: oss@fourdim.xyz,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 19:30:08 +0200
Message-ID: <2026071307-release-elongated-f82c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6fef032af0092ed5ccb767239a9ac1bc38c08a40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071307-release-elongated-f82c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6fef032af0092ed5ccb767239a9ac1bc38c08a40 Mon Sep 17 00:00:00 2001
From: Siwei Zhang <oss@fourdim.xyz>
Date: Mon, 29 Jun 2026 09:49:58 -0400
Subject: [PATCH] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()

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

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1640cc9bf83a..ef6ce1c20a4f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -617,7 +617,8 @@ struct l2cap_chan {
 struct l2cap_ops {
 	char			*name;
 
-	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
+	int			(*new_connection)(struct l2cap_chan *chan,
+						  struct l2cap_chan *new_chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err);
@@ -882,9 +883,10 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
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
@@ -961,7 +963,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
-void l2cap_chan_set_defaults(struct l2cap_chan *chan);
+void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index e7be18a3af33..d504a363a30f 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -632,7 +632,7 @@ static struct l2cap_chan *chan_create(void)
 	if (!chan)
 		return NULL;
 
-	l2cap_chan_set_defaults(chan);
+	l2cap_chan_set_defaults(chan, NULL);
 
 	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
@@ -745,21 +745,6 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
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
@@ -889,7 +874,6 @@ static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
 
 static const struct l2cap_ops bt_6lowpan_chan_ops = {
 	.name			= "L2CAP 6LoWPAN channel",
-	.new_connection		= chan_new_conn_cb,
 	.recv			= chan_recv_cb,
 	.close			= chan_close_cb,
 	.state_change		= chan_state_change_cb,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4ee3b9e30c65..519cd9552d86 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -522,7 +522,10 @@ void l2cap_chan_put(struct l2cap_chan *c)
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
@@ -536,6 +539,31 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
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
 
@@ -4024,6 +4052,38 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
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
@@ -4070,7 +4130,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan)
 		goto response;
 
@@ -4088,8 +4148,6 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	chan->psm  = psm;
 	chan->dcid = scid;
 
-	__l2cap_chan_add(conn, chan);
-
 	dcid = chan->scid;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
@@ -4972,7 +5030,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan) {
 		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
@@ -4987,8 +5045,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
 
-	__l2cap_chan_add(conn, chan);
-
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
@@ -5196,7 +5252,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(conn, pchan);
 		if (!chan) {
 			result = L2CAP_CR_LE_NO_MEM;
 			continue;
@@ -5211,8 +5267,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
 
-		__l2cap_chan_add(conn, chan);
-
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
 		/* Init response */
@@ -7492,14 +7546,12 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
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
index de56ca691afa..4058ff50cc27 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -43,7 +43,8 @@ static struct bt_sock_list l2cap_sk_list = {
 static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern);
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
@@ -1284,6 +1285,23 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
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
@@ -1294,13 +1312,9 @@ static void l2cap_sock_kill(struct sock *sk)
 
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
@@ -1543,12 +1557,13 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
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
 
@@ -1556,25 +1571,28 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
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
@@ -1871,10 +1889,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 
 	BT_DBG("sk %p", sk);
 
-	if (l2cap_pi(sk)->chan) {
-		l2cap_pi(sk)->chan->data = NULL;
-		l2cap_chan_put(l2cap_pi(sk)->chan);
-	}
+	l2cap_sock_put_chan(sk);
 
 	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
 		kfree_skb(rx_busy->skb);
@@ -1907,30 +1922,12 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
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
@@ -1956,7 +1953,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 			chan->mode = L2CAP_MODE_BASIC;
 		}
 
-		l2cap_chan_set_defaults(chan);
+		l2cap_chan_set_defaults(chan, NULL);
 	}
 
 	/* Default config options */
@@ -1975,10 +1972,10 @@ static struct proto l2cap_proto = {
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
@@ -1989,16 +1986,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
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
@@ -2008,6 +1996,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -2022,10 +2011,16 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
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
index 031d3022cb1e..c4470958b0d5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3201,34 +3201,19 @@ static const struct l2cap_ops smp_chan_ops = {
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
+	atomic_set(&new_chan->nesting, L2CAP_NESTING_SMP);
 
-	BT_DBG("created chan %p", chan);
-
-	return chan;
+	return 0;
 }
 
 static const struct l2cap_ops smp_root_chan_ops = {
@@ -3288,7 +3273,7 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 
 	l2cap_add_scid(chan, cid);
 
-	l2cap_chan_set_defaults(chan);
+	l2cap_chan_set_defaults(chan, NULL);
 
 	if (cid == L2CAP_CID_SMP) {
 		u8 bdaddr_type;

