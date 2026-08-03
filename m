Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0669397323
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744768; cv=none; b=oPHkieP/DF4NbN4LVGEm2++zIDBllFwQRMlIOYHBGykKp6LbiH0deYT5ZMzrNvhDBf8843tt6KLPj7QEMnPzbEvQ09BFJowzRbulzAZG3mR/bfSG96jAo/mShn4UJ6SD7xX10VXwZC6coV7PqaW82qezEXAM31T5xAtlRK9PTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744768; c=relaxed/simple;
	bh=xfEsl/VYVgy94mp39ejvrHTJ0IgJNdaRbGWnXkMPjas=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LgC4FBonYcNDjetPIrOYFxXSSn5qU9CTDgHa60FX20pDpx7wAsTmbSSp2nq7Gni8x40rcit+wAdtzBfOL0BsXC4ph111erY7846IsPgf9BTeRcCKxn2xxIgxdo7qCXYunsdyD1OuGWkH5vrAuXppu03LCQV4qXfHR8qSNbOjAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjyeYXgw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjyeYXgw"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so3301576a12.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785744764; x=1786349564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nfFsOevCiVpElPiIPf6rs46MR3hTgS81+rov2AShn4U=;
        b=gjyeYXgwB9BpgTYe4QUgLsza7jjR3npNQI8NK9GMIwLzEz1Rt7hjlYtlh10PHPYd+Y
         rhaiCqCNf17jeYQ+vrtAQOfbTklXQFO8wQL93oV9DU0uEIcTjNESyE+dxWmZMT2d/gSj
         M4CphbvZMDi9nSBJ66keY6RQsfHv8L3fj318O3UTmMXYBE+vQwlQhr1qzfjtPpVR18Z3
         qaQhSolw03Afd6OAyD05jo7omKqaAqVPhRuD62yKddB89Sgf3u5SAe2Rs6XXRq54IRHf
         S6G8EyVgRdkve6b67c69y5Xy3n6k8b+ZUc5x149JgFzfVI23l4yCeEZ1NoLhxfUOupiS
         aqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785744764; x=1786349564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nfFsOevCiVpElPiIPf6rs46MR3hTgS81+rov2AShn4U=;
        b=SUfR4EdiQefxxk2d6ZwbiKzO+Ia/FYVCAil3or+hdQPAFXmnKAuufvFwX4zEsUml3W
         nRXOczda7CUK0ZIv7MkkOCFTWUFgtrGKZfxnYAWhayOZvxw3/RUEaGiONCKbwr5AvO/2
         YQV1VaF4HE/fNzrckoGoa+7CGhk+jfDrAFcpPZvkgDyxt1huqkFnDVdq/1hj8a0G1+wd
         HHJynf8ifyqvj3tCbd0xh+mgKF0//WYyt5VGxj97ytHKOXRV19Qx/evv4r5Rjrxlha38
         4PAJi/h41KFm2op3wY4BbsvGIYABQ4lq35XMRoCDzz0nTBQqc/wpWgMcJDBAvFv6+YFe
         4KDA==
X-Forwarded-Encrypted: i=1; AHgh+RpjKnbh2p4amLDvtpY4EPZGOGLI7e8bm1PAhpMeFV40/b4fxm1LTp4RcColF1rhEwvHrzEC6Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwApYNiDzZ0XPPxoH3lP3MtW4Prc8sHmoFL0xBLSbe8lVetz0RL
	xHFQSDanIFEb8fN3ED/rteU2XN2CFdLeoD1SyBwq5lrCmm9E0wbpwbCr
X-Gm-Gg: AR+sD11Jb0sFk2aVqSWH8xPP1wqs9HLfz0iCWjh+tSm618F9BaU4wMFFdyaEcoZwWb4
	oWnfp6BXGfHqxIBA2W/LVSkeoanFtPylojEMBE/KQz2TPwI6Jj5fwyROpEryhQ3QtedhQ4GSJ3j
	BmxE1kxlFANJ5XKzQLDMHxZhX3oCy7ZghBCP/mqEuFqgBuc3qQ01GQlQlORStzCFtWfvS34CzGT
	FXzI6RrEhS7k7qAgyzXjQgjOFY7QXJv/4T3e56bG7P3o0CvLoSqgda2tgPdJyU+xOEfP1WKPXEH
	UiYaXGjVOscvp3uiZnTNo2XPb6PYRW0UubCLAXLzjSw+6/33x7gOySuD3EW8d7n4HuLNNPQDkvc
	um6J8XwYFWMVrPl/zzoXg4esLQWKNlO3WIj3gBF4dos5c28ad2cNvMFu6PzLtNuBfJwR420fyrB
	i/rPjU/ClMuyfBp88vZRrzs8K1RW0z+i+5iIxy1WS6ikCru92A+IPrei4dGCDjLO7yVZNJQ8fC
X-Received: by 2002:a05:6402:52c2:b0:698:ac05:5b2f with SMTP id 4fb4d7f45d1cf-6a0a7c60fc5mr6458723a12.4.1785744763864;
        Mon, 03 Aug 2026 01:12:43 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c660f6fsm5019414a12.25.2026.08.03.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 01:12:43 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: alexevgmart@gmail.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10/5.15] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon,  3 Aug 2026 11:12:28 +0300
Message-ID: <20260803081228.729246-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siwei Zhang <oss@fourdim.xyz>

commit 6fef032af0092ed5ccb767239a9ac1bc38c08a40 upstream.

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
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-64557
 include/net/bluetooth/l2cap.h | 10 ++--
 net/bluetooth/6lowpan.c       | 18 +------
 net/bluetooth/l2cap_core.c    | 78 ++++++++++++++++++++++-----
 net/bluetooth/l2cap_sock.c    | 99 +++++++++++++++++------------------
 net/bluetooth/smp.c           | 27 +++-------
 5 files changed, 127 insertions(+), 105 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index beb690a162ff..dcb315112ed1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -653,7 +653,8 @@ struct l2cap_chan {
 struct l2cap_ops {
 	char			*name;
 
-	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
+	int			(*new_connection)(struct l2cap_chan *chan,
+						  struct l2cap_chan *new_chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err);
@@ -912,9 +913,10 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
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
@@ -989,7 +991,7 @@ int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
-void l2cap_chan_set_defaults(struct l2cap_chan *chan);
+void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9424d153f323..147b09f03c23 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -631,7 +631,7 @@ static struct l2cap_chan *chan_create(void)
 	if (!chan)
 		return NULL;
 
-	l2cap_chan_set_defaults(chan);
+	l2cap_chan_set_defaults(chan, NULL);
 
 	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
 	chan->mode = L2CAP_MODE_LE_FLOWCTL;
@@ -743,21 +743,6 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
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
 static void delete_netdev(struct work_struct *work)
 {
 	struct lowpan_btle_dev *entry = container_of(work,
@@ -879,7 +864,6 @@ static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
 
 static const struct l2cap_ops bt_6lowpan_chan_ops = {
 	.name			= "L2CAP 6LoWPAN channel",
-	.new_connection		= chan_new_conn_cb,
 	.recv			= chan_recv_cb,
 	.close			= chan_close_cb,
 	.state_change		= chan_state_change_cb,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 196b3bdca264..61a06b394c07 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -540,7 +540,10 @@ void l2cap_chan_put(struct l2cap_chan *c)
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
@@ -554,6 +557,31 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
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
 
@@ -4193,6 +4221,38 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
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
 static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 					struct l2cap_cmd_hdr *cmd,
 					u8 *data, u8 rsp_code, u8 amp_id)
@@ -4241,7 +4301,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan)
 		goto response;
 
@@ -4260,8 +4320,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	chan->dcid = scid;
 	chan->local_amp_id = amp_id;
 
-	__l2cap_chan_add(conn, chan);
-
 	dcid = chan->scid;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
@@ -5976,7 +6034,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(conn, pchan);
 	if (!chan) {
 		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
@@ -5991,8 +6049,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
 
-	__l2cap_chan_add(conn, chan);
-
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
@@ -6195,7 +6251,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(conn, pchan);
 		if (!chan) {
 			result = L2CAP_CR_LE_NO_MEM;
 			continue;
@@ -6210,8 +6266,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
 
-		__l2cap_chan_add(conn, chan);
-
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
 		/* Init response */
@@ -8497,14 +8551,12 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
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
index 0b51c3e0f469..77a80fb17eb7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -44,7 +44,8 @@ static struct bt_sock_list l2cap_sk_list = {
 static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern);
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
@@ -1227,6 +1228,23 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
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
@@ -1237,9 +1255,9 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
-	/* Kill poor orphan */
+	l2cap_sock_put_chan(sk);
 
-	l2cap_chan_put(l2cap_pi(sk)->chan);
+	/* Kill poor orphan */
 	sock_set_flag(sk, SOCK_DEAD);
 	sock_put(sk);
 }
@@ -1483,12 +1501,13 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
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
 
@@ -1496,25 +1515,28 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
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
@@ -1791,10 +1813,7 @@ static void l2cap_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
-	if (l2cap_pi(sk)->chan) {
-		l2cap_pi(sk)->chan->data = NULL;
-		l2cap_chan_put(l2cap_pi(sk)->chan);
-	}
+	l2cap_sock_put_chan(sk);
 
 	if (l2cap_pi(sk)->rx_busy_skb) {
 		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
@@ -1825,30 +1844,12 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
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
@@ -1874,7 +1875,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 			chan->mode = L2CAP_MODE_BASIC;
 		}
 
-		l2cap_chan_set_defaults(chan);
+		l2cap_chan_set_defaults(chan, NULL);
 	}
 
 	/* Default config options */
@@ -1891,10 +1892,10 @@ static struct proto l2cap_proto = {
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
@@ -1903,16 +1904,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
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
@@ -1922,6 +1914,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -1936,10 +1929,16 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
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
index 85bd00479a74..1f8561112ec1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3228,34 +3228,19 @@ static const struct l2cap_ops smp_chan_ops = {
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
@@ -3326,7 +3311,7 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 
 	l2cap_add_scid(chan, cid);
 
-	l2cap_chan_set_defaults(chan);
+	l2cap_chan_set_defaults(chan, NULL);
 
 	if (cid == L2CAP_CID_SMP) {
 		u8 bdaddr_type;
-- 
2.43.0

