Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1D3264C3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766873; cv=none; b=aYJWXjCMzGCs/9hLtfU9EoRBfYdJAPVY385LKg4Hvcuh3rpExaPLHyx9Rjag/Un9onBn4rMCCcuVEkD4PIo+aV5bOyQESpJ1KP+UJ56m1rfNLrbdaSNW1GuT7AFCYr6u76P7ar2MTY8rzMLntohGkKL/rIcK3BYHhNDjXWFbtDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766873; c=relaxed/simple;
	bh=jdY/mLDLJo4Owzjzj8Ga11IjFapVoycUBQi5KivC1do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLuwijzk/7vyj5JBZ9QUUYdyKPI8pAl1ckh47fQcPUD7VBFpRZKWNSk36wNb1rLCyTNXy2fWIyqkn3hIjhjvY2UI3TFqPS80+MLAkooxj70ggnmqNxDYkrDFXx2lUZnFwjGhF29j1dMwvWFSqUP5QmkPUD7Wa5u6zJjtklXSIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8pI7g7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8pI7g7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9CE1F000FF;
	Wed, 30 Sep 2026 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766871;
	bh=N7Ns2TqCsIQtq/QMI+VEcul+d5aZiWnBAU09FEMbeyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O8pI7g7w/5NssQZP3botEERKKzw1plCrUChWl1l/wrDrsNwWdQBeh6BOYCJa2fo/e
	 T28qLCCuq4IBKnLubAU8fWQaiw6aC4oY1nPzafHKRyGb7GRHgfiT5dOjefd7y3PR/W
	 z4o/xJs0r3QfqPAQAmcBpHdDphBEROPiVN5bzWFyEwwbWx+UouUuFh6zLtAVzPcrPv
	 2Zu0++dRrQHMU4fC7/gjHsc0xeM3oJi0819sqTtN8Gs6IermV0UQ+UIlNK2aZa5G4y
	 JZzq3vZ427YQcvoND1+D4+K6wVU+JYR9eUvxOnDaJQq2Zu/58GpxBu78GgHOoJarhf
	 TUWpkHsHb7Shw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net/packet: defer vmalloc TX_RING free until skbs finish
Date: Wed, 30 Sep 2026 07:14:27 -0400
Message-ID: <20260930111429.1208354-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092950-granite-ambush-90a1@gregkh>
References: <2026092950-granite-ambush-90a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 992cc9f94ca924089a506ba9b327caa9af797529 ]

AF_PACKET TX_RING skbs keep a raw pointer to their ring frame. The skb
page references preserve page-backed ring blocks after pg_vec is freed,
but they do not preserve a vmalloc mapping.

tpacket_destruct_skb() currently drops the pending reference before
writing the timestamp and TP_STATUS_AVAILABLE to the frame. Move the
decrement after those stores. The smp_wmb() in __packet_set_status()
orders the frame stores before the decrement.

Also recheck pending TX frames under pg_vec_lock before non-closing
ring replacement, so a racing send cannot add a pending skb between
the initial check and the ring swap.

Ring allocation can produce a mixture of page-backed and vmalloc-backed
blocks. Allocate deferred-work storage during TX ring setup when the
first vmalloc-backed block is encountered, and keep its pointer in the
pg_vec allocation header. If allocation fails, return -ENOMEM from ring
setup. On socket close, a non-NULL pointer identifies a vmalloc-backed
vector without a scan. If TX skbs remain, defer the whole vector to
system_long_wq.

After pg_vec is detached, a late destructor can skip the pending
decrement. Use socket write-memory accounting as the deferred lifetime
gate instead: an skb remains charged through its final sock_wfree(),
after all ring-frame accesses. The delayed work retains a socket
reference and reschedules itself until no TX skbs remain.

Move pending_refcnt release to packet_sock_destruct() so late skb
destructors and deferred cleanup can safely use it after
packet_release(). Page-backed teardown remains synchronous, and no lock
is added to the TX completion hot path.

Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260721015824.45829-1-kylebot@openai.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Link: https://patch.msgid.link/20260816235646.76500-1-kylebot@openai.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Backport to 6.6:

Allocate the ring-vector header with kzalloc(struct_size(...)), since
kzalloc_flex is unavailable. Provide the explicit-GFP kzalloc_obj macro
used by this change and the target's deferred-allocation relocation.

Prepare for 951840561386 ("packet: use ubuf_info completion for TX_RING
packets") by adapting the ubuf_info operations conversion from
7ab4f16f9e244 across all existing users. Retain existing callback function
names and the stable vhost completion refcount check.

Make skb_setup_tx_timestamp take the existing sockcm_cookie and update
all callers, preserving 6.6 timestamp behavior. This supplies unchanged
context next to the target's skb_zcopy_set_nouarg removal without pulling
in newer socket priority, mark, or timestamp behavior.

These interface preparations let the unmodified target cherry-pick
cleanly. No functions beyond those in the original dependency are added.

Stable-dep-of: 951840561386 ("packet: use ubuf_info completion for TX_RING packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c                   |   2 +-
 drivers/net/tun.c                   |   2 +-
 drivers/net/xen-netback/common.h    |   5 +-
 drivers/net/xen-netback/interface.c |   2 +-
 drivers/net/xen-netback/netback.c   |  11 ++-
 drivers/vhost/net.c                 |   6 +-
 include/linux/skbuff.h              |  19 ++---
 include/linux/slab.h                |   7 ++
 include/net/sock.h                  |   5 +-
 io_uring/notif.c                    |  14 +++-
 net/can/raw.c                       |   2 +-
 net/core/skbuff.c                   |  14 ++--
 net/ipv4/raw.c                      |   2 +-
 net/ipv6/raw.c                      |   2 +-
 net/packet/af_packet.c              | 103 ++++++++++++++++++++++++----
 15 files changed, 153 insertions(+), 43 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5f01c875e49ee..fdd754b302510 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -754,7 +754,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		skb_zcopy_init(skb, msg_control);
 	} else if (msg_control) {
 		struct ubuf_info *uarg = msg_control;
-		uarg->callback(NULL, uarg, false);
+		uarg->ops->complete(NULL, uarg, false);
 	}
 
 	dev_queue_xmit(skb);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 98711c4e12d1c..29a6945119193 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1924,7 +1924,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		skb_zcopy_init(skb, msg_control);
 	} else if (msg_control) {
 		struct ubuf_info *uarg = msg_control;
-		uarg->callback(NULL, uarg, false);
+		uarg->ops->complete(NULL, uarg, false);
 	}
 
 	skb_reset_network_header(skb);
diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index 1fcbd83f7ff2e..17421da139f2b 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -390,9 +390,8 @@ bool xenvif_rx_queue_tail(struct xenvif_queue *queue, struct sk_buff *skb);
 
 void xenvif_carrier_on(struct xenvif *vif);
 
-/* Callback from stack when TX packet can be released */
-void xenvif_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *ubuf,
-			      bool zerocopy_success);
+/* Callbacks from stack when TX packet can be released */
+extern const struct ubuf_info_ops xenvif_ubuf_ops;
 
 static inline pending_ring_idx_t nr_pending_reqs(struct xenvif_queue *queue)
 {
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index acf310e58f7e2..fe038c1cc3f80 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -590,7 +590,7 @@ int xenvif_init_queue(struct xenvif_queue *queue)
 
 	for (i = 0; i < MAX_PENDING_REQS; i++) {
 		queue->pending_tx_info[i].callback_struct = (struct ubuf_info_msgzc)
-			{ { .callback = xenvif_zerocopy_callback },
+			{ { .ops = &xenvif_ubuf_ops },
 			  { { .ctx = NULL,
 			      .desc = i } } };
 		queue->grant_tx_handle[i] = NETBACK_INVALID_HANDLE;
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index fab361a250d60..4c41a106dcd4d 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1156,7 +1156,7 @@ static int xenvif_handle_frag_list(struct xenvif_queue *queue, struct sk_buff *s
 	uarg = skb_shinfo(skb)->destructor_arg;
 	/* increase inflight counter to offset decrement in callback */
 	atomic_inc(&queue->inflight_packets);
-	uarg->callback(NULL, uarg, true);
+	uarg->ops->complete(NULL, uarg, true);
 	skb_shinfo(skb)->destructor_arg = NULL;
 
 	/* Fill the skb with the new (local) frags. */
@@ -1278,8 +1278,9 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
 	return work_done;
 }
 
-void xenvif_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *ubuf_base,
-			      bool zerocopy_success)
+static void xenvif_zerocopy_callback(struct sk_buff *skb,
+				     struct ubuf_info *ubuf_base,
+				     bool zerocopy_success)
 {
 	unsigned long flags;
 	pending_ring_idx_t index;
@@ -1312,6 +1313,10 @@ void xenvif_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *ubuf_base,
 	xenvif_skb_zerocopy_complete(queue);
 }
 
+const struct ubuf_info_ops xenvif_ubuf_ops = {
+	.complete = xenvif_zerocopy_callback,
+};
+
 static inline void xenvif_tx_dealloc_action(struct xenvif_queue *queue)
 {
 	struct gnttab_unmap_grant_ref *gop;
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 2953ab6e0c1d1..e7ffe63cf1055 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -422,6 +422,10 @@ static void vhost_zerocopy_callback(struct sk_buff *skb,
 	rcu_read_unlock_bh();
 }
 
+static const struct ubuf_info_ops vhost_ubuf_ops = {
+	.complete = vhost_zerocopy_callback,
+};
+
 static inline unsigned long busy_clock(void)
 {
 	return local_clock() >> 10;
@@ -923,7 +927,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 			vq->heads[nvq->upend_idx].len = VHOST_DMA_IN_PROGRESS;
 			ubuf->ctx = nvq->ubufs;
 			ubuf->desc = nvq->upend_idx;
-			ubuf->ubuf.callback = vhost_zerocopy_callback;
+			ubuf->ubuf.ops = &vhost_ubuf_ops;
 			ubuf->ubuf.flags = SKBFL_ZEROCOPY_FRAG;
 			refcount_set(&ubuf->ubuf.refcnt, 1);
 			msg.msg_control = &ctl;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1a91645fa2497..347800c8384af 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -522,6 +522,11 @@ enum {
 #define SKBFL_ALL_ZEROCOPY	(SKBFL_ZEROCOPY_FRAG | SKBFL_PURE_ZEROCOPY | \
 				 SKBFL_DONT_ORPHAN | SKBFL_MANAGED_FRAG_REFS)
 
+struct ubuf_info_ops {
+	void (*complete)(struct sk_buff *, struct ubuf_info *,
+			 bool zerocopy_success);
+};
+
 /*
  * The callback notifies userspace to release buffers when skb DMA is done in
  * lower device, the skb last reference should be 0 when calling this.
@@ -531,8 +536,7 @@ enum {
  * The desc field is used to track userspace buffer index.
  */
 struct ubuf_info {
-	void (*callback)(struct sk_buff *, struct ubuf_info *,
-			 bool zerocopy_success);
+	const struct ubuf_info_ops *ops;
 	refcount_t refcnt;
 	u8 flags;
 };
@@ -1665,14 +1669,13 @@ static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
 }
 #endif
 
+extern const struct ubuf_info_ops msg_zerocopy_ubuf_ops;
+
 struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 				       struct ubuf_info *uarg);
 
 void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
 
-void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
-			   bool success);
-
 int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 			    struct sk_buff *skb, struct iov_iter *from,
 			    size_t length);
@@ -1760,13 +1763,13 @@ static inline void *skb_zcopy_get_nouarg(struct sk_buff *skb)
 static inline void net_zcopy_put(struct ubuf_info *uarg)
 {
 	if (uarg)
-		uarg->callback(NULL, uarg, true);
+		uarg->ops->complete(NULL, uarg, true);
 }
 
 static inline void net_zcopy_put_abort(struct ubuf_info *uarg, bool have_uref)
 {
 	if (uarg) {
-		if (uarg->callback == msg_zerocopy_callback)
+		if (uarg->ops == &msg_zerocopy_ubuf_ops)
 			msg_zerocopy_put_abort(uarg, have_uref);
 		else if (have_uref)
 			net_zcopy_put(uarg);
@@ -1780,7 +1783,7 @@ static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
 
 	if (uarg) {
 		if (!skb_zcopy_is_nouarg(skb))
-			uarg->callback(skb, uarg, zerocopy_success);
+			uarg->ops->complete(skb, uarg, zerocopy_success);
 
 		skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
 	}
diff --git a/include/linux/slab.h b/include/linux/slab.h
index a761cc3559f29..3fd79c6e85ea9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -721,6 +721,13 @@ static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
 	return kmalloc(size, flags | __GFP_ZERO);
 }
 
+/**
+ * kzalloc_obj - allocate a zeroed instance of a variable or type
+ * @P: variable or type to allocate
+ * @flags: the type of memory to allocate (see kmalloc)
+ */
+#define kzalloc_obj(P, flags) ((typeof(P) *)kzalloc(sizeof(P), flags))
+
 /**
  * kzalloc_node - allocate zeroed memory from a particular memory node.
  * @size: how many bytes of memory are required.
diff --git a/include/net/sock.h b/include/net/sock.h
index c1f129a532b20..e7517b7608cc9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2851,9 +2851,10 @@ static inline void sock_tx_timestamp(struct sock *sk, __u16 tsflags,
 	_sock_tx_timestamp(sk, tsflags, tx_flags, NULL);
 }
 
-static inline void skb_setup_tx_timestamp(struct sk_buff *skb, __u16 tsflags)
+static inline void skb_setup_tx_timestamp(struct sk_buff *skb,
+					  const struct sockcm_cookie *sockc)
 {
-	_sock_tx_timestamp(skb->sk, tsflags, &skb_shinfo(skb)->tx_flags,
+	_sock_tx_timestamp(skb->sk, sockc->tsflags, &skb_shinfo(skb)->tx_flags,
 			   &skb_shinfo(skb)->tskey);
 }
 
diff --git a/io_uring/notif.c b/io_uring/notif.c
index d3e703c37aba8..e8842327308f8 100644
--- a/io_uring/notif.c
+++ b/io_uring/notif.c
@@ -48,16 +48,24 @@ static void io_tx_ubuf_callback_ext(struct sk_buff *skb, struct ubuf_info *uarg,
 	io_tx_ubuf_callback(skb, uarg, success);
 }
 
+static const struct ubuf_info_ops io_ubuf_ops = {
+	.complete = io_tx_ubuf_callback,
+};
+
+static const struct ubuf_info_ops io_ubuf_ops_ext = {
+	.complete = io_tx_ubuf_callback_ext,
+};
+
 void io_notif_set_extended(struct io_kiocb *notif)
 {
 	struct io_notif_data *nd = io_notif_to_data(notif);
 
-	if (nd->uarg.callback != io_tx_ubuf_callback_ext) {
+	if (nd->uarg.ops != &io_ubuf_ops_ext) {
 		nd->account_pages = 0;
 		nd->zc_report = false;
 		nd->zc_used = false;
 		nd->zc_copied = false;
-		nd->uarg.callback = io_tx_ubuf_callback_ext;
+		nd->uarg.ops = &io_ubuf_ops_ext;
 		notif->io_task_work.func = io_notif_complete_tw_ext;
 	}
 }
@@ -80,7 +88,7 @@ struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx)
 
 	nd = io_notif_to_data(notif);
 	nd->uarg.flags = IO_NOTIF_UBUF_FLAGS;
-	nd->uarg.callback = io_tx_ubuf_callback;
+	nd->uarg.ops = &io_ubuf_ops;
 	refcount_set(&nd->uarg.refcnt, 1);
 	return notif;
 }
diff --git a/net/can/raw.c b/net/can/raw.c
index ad4b16476743a..7d51c8eae1b85 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -893,7 +893,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	err = can_send(skb, ro->loopback);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cfac251b003f7..80cc1de235016 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1561,7 +1561,7 @@ static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size)
 		return NULL;
 	}
 
-	uarg->ubuf.callback = msg_zerocopy_callback;
+	uarg->ubuf.ops = &msg_zerocopy_ubuf_ops;
 	uarg->id = ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
 	uarg->len = 1;
 	uarg->bytelen = size;
@@ -1587,7 +1587,7 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 		u32 bytelen, next;
 
 		/* there might be non MSG_ZEROCOPY users */
-		if (uarg->callback != msg_zerocopy_callback)
+		if (uarg->ops != &msg_zerocopy_ubuf_ops)
 			return NULL;
 
 		/* realloc only when socket is locked (TCP, UDP cork),
@@ -1698,8 +1698,8 @@ static void __msg_zerocopy_callback(struct ubuf_info_msgzc *uarg)
 	sock_put(sk);
 }
 
-void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
-			   bool success)
+static void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
+				  bool success)
 {
 	struct ubuf_info_msgzc *uarg_zc = uarg_to_msgzc(uarg);
 
@@ -1708,7 +1708,6 @@ void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
 	if (refcount_dec_and_test(&uarg->refcnt))
 		__msg_zerocopy_callback(uarg_zc);
 }
-EXPORT_SYMBOL_GPL(msg_zerocopy_callback);
 
 void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
 {
@@ -1722,6 +1721,11 @@ void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
 }
 EXPORT_SYMBOL_GPL(msg_zerocopy_put_abort);
 
+const struct ubuf_info_ops msg_zerocopy_ubuf_ops = {
+	.complete = msg_zerocopy_callback,
+};
+EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
+
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct msghdr *msg, int len,
 			     struct ubuf_info *uarg)
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index b670364630a13..d5ba473bb743c 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -363,7 +363,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 95d7dd7a4d048..9b2de5db4c08a 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -623,7 +623,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 116578fbd9a1c..773fea4f8b3ba 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -87,6 +87,7 @@
 #include <linux/errqueue.h>
 #include <linux/net_tstamp.h>
 #include <linux/percpu.h>
+#include <linux/workqueue.h>
 #ifdef CONFIG_INET
 #include <net/inet_common.h>
 #endif
@@ -1393,6 +1394,8 @@ static void packet_sock_destruct(struct sock *sk)
 	WARN_ON(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
 
+	packet_free_pending(pkt_sk(sk));
+
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		pr_err("Attempt to release alive packet socket: %p\n", sk);
 		return;
@@ -2123,7 +2126,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
@@ -2587,11 +2590,11 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		__u32 ts;
 
 		ph = skb_zcopy_get_nouarg(skb);
-		packet_dec_pending(&po->tx_ring);
 
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
+		packet_dec_pending(&po->tx_ring);
 		complete(&po->skb_completion);
 	}
 
@@ -2656,7 +2659,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
 	skb->tstamp = sockc->transmit_time;
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
 	skb_reserve(skb, hlen);
@@ -3131,7 +3134,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_free;
 	}
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	if (!vnet_hdr.gso_type && (len > dev->mtu + reserve + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
@@ -3261,7 +3264,6 @@ static int packet_release(struct socket *sock)
 	/* Purge queues */
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	packet_free_pending(po);
 
 	sock_put(sk);
 	return 0;
@@ -4411,11 +4413,26 @@ static const struct vm_operations_struct packet_mmap_ops = {
 	.close	=	packet_mm_close,
 };
 
+struct packet_pg_vec {
+	struct packet_pg_vec_free *deferred;
+	unsigned int order;
+	unsigned int len;
+	struct pgv pg_vec[] __counted_by(len);
+};
+
+struct packet_pg_vec_free {
+	struct delayed_work work;
+	struct sock *sk;
+	struct packet_pg_vec *vec;
+};
+
 static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
 			unsigned int len)
 {
+	struct packet_pg_vec *vec;
 	int i;
 
+	vec = container_of_const(pg_vec, struct packet_pg_vec, pg_vec[0]);
 	for (i = 0; i < len; i++) {
 		if (likely(pg_vec[i].buffer)) {
 			if (is_vmalloc_addr(pg_vec[i].buffer))
@@ -4426,7 +4443,46 @@ static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
 			pg_vec[i].buffer = NULL;
 		}
 	}
-	kfree(pg_vec);
+	kfree(vec->deferred);
+	kfree(vec);
+}
+
+static void packet_free_pg_vec_work(struct work_struct *work)
+{
+	struct packet_pg_vec_free *deferred;
+	struct packet_pg_vec *vec;
+	struct sock *sk;
+
+	deferred = container_of_const(to_delayed_work(work),
+				      struct packet_pg_vec_free, work);
+	vec = deferred->vec;
+	sk = deferred->sk;
+	if (sk_wmem_alloc_get(sk)) {
+		queue_delayed_work(system_long_wq, &deferred->work, 1);
+		return;
+	}
+
+	free_pg_vec(vec->pg_vec, vec->order, vec->len);
+	sock_put(sk);
+}
+
+static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
+				unsigned int order, unsigned int len)
+{
+	struct packet_pg_vec_free *deferred;
+	struct packet_pg_vec *vec;
+
+	vec = container_of_const(pg_vec, struct packet_pg_vec, pg_vec[0]);
+	deferred = vec->deferred;
+	if (!deferred || !sk_wmem_alloc_get(sk)) {
+		free_pg_vec(pg_vec, order, len);
+		return;
+	}
+
+	/* A detached ring's pending count can miss late skb destructors. */
+	deferred->sk = sk;
+	sock_hold(sk);
+	queue_delayed_work(system_long_wq, &deferred->work, 0);
 }
 
 static char *alloc_one_pg_vec_page(unsigned long order)
@@ -4454,20 +4510,36 @@ static char *alloc_one_pg_vec_page(unsigned long order)
 	return NULL;
 }
 
-static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order)
+static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring)
 {
 	unsigned int block_nr = req->tp_block_nr;
+	struct packet_pg_vec *vec;
 	struct pgv *pg_vec;
 	int i;
 
-	pg_vec = kcalloc(block_nr, sizeof(struct pgv), GFP_KERNEL | __GFP_NOWARN);
-	if (unlikely(!pg_vec))
-		goto out;
+	vec = kzalloc(struct_size(vec, pg_vec, block_nr),
+		      GFP_KERNEL | __GFP_NOWARN);
+	if (unlikely(!vec))
+		return NULL;
+	vec->order = order;
+	vec->len = block_nr;
+	pg_vec = vec->pg_vec;
 
 	for (i = 0; i < block_nr; i++) {
 		pg_vec[i].buffer = alloc_one_pg_vec_page(order);
 		if (unlikely(!pg_vec[i].buffer))
 			goto out_free_pgvec;
+
+		if (tx_ring && !vec->deferred &&
+		    is_vmalloc_addr(pg_vec[i].buffer)) {
+			vec->deferred = kzalloc_obj(*vec->deferred,
+						    GFP_KERNEL | __GFP_NOWARN);
+			if (!vec->deferred)
+				goto out_free_pgvec;
+			vec->deferred->vec = vec;
+			INIT_DELAYED_WORK(&vec->deferred->work,
+					  packet_free_pg_vec_work);
+		}
 	}
 
 out:
@@ -4550,7 +4622,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 		err = -ENOMEM;
 		order = get_order(req->tp_block_size);
-		pg_vec = alloc_pg_vec(req, order);
+		pg_vec = alloc_pg_vec(req, order, tx_ring);
 		if (unlikely(!pg_vec))
 			goto out;
 		switch (po->tp_version) {
@@ -4602,6 +4674,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
 	if (closing || atomic_long_read(&po->mapped) == 0) {
+		if (tx_ring && !closing && packet_read_pending(rb))
+			goto out_unlock;
+
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4623,6 +4698,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 			pr_err("packet_mmap: vma is busy: %ld\n",
 			       atomic_long_read(&po->mapped));
 	}
+out_unlock:
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
@@ -4644,7 +4720,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 out_free_pg_vec:
 	if (pg_vec) {
 		bitmap_free(rx_owner_map);
-		free_pg_vec(pg_vec, order, req->tp_block_nr);
+		if (tx_ring && closing)
+			packet_free_tx_ring(sk, pg_vec, order, req->tp_block_nr);
+		else
+			free_pg_vec(pg_vec, order, req->tp_block_nr);
 	}
 out:
 	return err;
-- 
2.53.0

