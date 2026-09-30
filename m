Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862934F4047
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777158; cv=none; b=HJk7KVBU8d2cE5I/R3aniuG6/1Nb7ClpXvv3B4WS8jkISjBj6dSSIDz7D5XC3Kdbz3vX9yVboM1A9jD9Lb8RzCBT/MSpGNhHsyu1nhBILDEvwIjfehD4wWLkO7IrRVPBGiy2vqXjl9/GD2fDpzvqutQFlgI0IV/oHOTmrOFeNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777158; c=relaxed/simple;
	bh=EtqDjWUH+HHzfAaRflqEsxi+JLrJR17IWwjdTdPohOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/DBRtyL1eh+eW6rG1K2Z6OCH2mn/ORvmi9siLdvaybQqx3mepcrEeTIBqU7/ZKfRaMAZ0p77EL4i1J1e/uKM+1TwYM9pGzeSXVnM7h5CmRuh1Xrasamk16qVoZb/cOR1Tp0oWksPhgkQK4ydbItkOu90CaLeyDujO0Y7b0DFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKcnQxfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKcnQxfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D1C1F008A1;
	Wed, 30 Sep 2026 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790777143;
	bh=u9RjcnhCUqTPBos3taHIoEJttvEN/N4TGAhhV3/5F8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKcnQxfl0buZOa16zPh7r2zNmGQSSGOtJipkD/WyVDhZHpr5hzXv2/ZnhpbEt+fWe
	 nMCbufDpEVIGZIHHe5bSrXfroAZTlfSwtKPsGRJkmTBsr4M/L5eRXbQGN/n1OuMH09
	 IswjatQiVBo/r2aikFQoqC6lOEyyCn52YHMxvIIHclwSMVoSMscrmLAjPk2vdPmE8B
	 PKhr6gg4g7KlsX9VKYIw7MR6Sosn/lT3d30OQ0FZzsSLYtw5Vfbbjz1Qs0sd/GK1fK
	 AfJlrzfpFP57QXCythuwcRANXZSphJLVQ/im3xMu7lW51NSrQ5rAG/4/jHh6fdha/n
	 iNSwTmaXTDv5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net/packet: defer vmalloc TX_RING free until skbs finish
Date: Wed, 30 Sep 2026 10:05:39 -0400
Message-ID: <20260930140540.1824859-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092951-await-radiator-1fb3@gregkh>
References: <2026092951-await-radiator-1fb3@gregkh>
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

Backport preparation for 9518405613863d0bf0700927a21367f5942cf058 on 6.1:

Keep sk_refcnt_debug_release() in packet_release(), but move pending-count
storage release to packet_sock_destruct() as upstream requires. Allocate
the vector header with kzalloc(struct_size(...)) and omit __counted_by,
which this tree does not provide.

The unmodified target also needs interfaces absent from 6.1. Adapt the
ubuf_info operations-table conversion from 7ab4f16f9e244 ("net: extend
ubuf_info callback to ops structure"), preserving all existing callback
implementations and updating every producer and consumer. Change the
existing skb_setup_tx_timestamp() helper and all callers to pass the
sockcm_cookie, retaining the same timestamp flags and behavior. Supply
the two-argument kzalloc_obj() macro used by both dependency and target
in terms of the existing kzalloc(). No additional functions beyond those
already introduced by this dependency are added.

These preparations preserve the deferred-ring lifetime fix and allow the
unmodified target to merge without conflicts on the stable tree.

Stable-dep-of: 951840561386 ("packet: use ubuf_info completion for TX_RING packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c                   |   2 +-
 drivers/net/tun.c                   |   2 +-
 drivers/net/xen-netback/common.h    |   2 +
 drivers/net/xen-netback/interface.c |   2 +-
 drivers/net/xen-netback/netback.c   |   6 +-
 drivers/vhost/net.c                 |   6 +-
 include/linux/skbuff.h              |  18 +++--
 include/linux/slab.h                |   3 +
 include/net/sock.h                  |   5 +-
 io_uring/notif.c                    |   6 +-
 net/can/raw.c                       |   2 +-
 net/core/skbuff.c                   |   9 ++-
 net/ipv4/raw.c                      |   2 +-
 net/ipv6/raw.c                      |   2 +-
 net/packet/af_packet.c              | 103 ++++++++++++++++++++++++----
 15 files changed, 140 insertions(+), 30 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 15ab71f5288ac..92f91ab063cb4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -747,7 +747,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		skb_zcopy_init(skb, msg_control);
 	} else if (msg_control) {
 		struct ubuf_info *uarg = msg_control;
-		uarg->callback(NULL, uarg, false);
+		uarg->ops->complete(NULL, uarg, false);
 	}
 
 	dev_queue_xmit(skb);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 6e021a7caa07a..2a6f4941538a5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1913,7 +1913,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		skb_zcopy_init(skb, msg_control);
 	} else if (msg_control) {
 		struct ubuf_info *uarg = msg_control;
-		uarg->callback(NULL, uarg, false);
+		uarg->ops->complete(NULL, uarg, false);
 	}
 
 	skb_reset_network_header(skb);
diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index 1fcbd83f7ff2e..d671bac10b045 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -391,6 +391,8 @@ bool xenvif_rx_queue_tail(struct xenvif_queue *queue, struct sk_buff *skb);
 void xenvif_carrier_on(struct xenvif *vif);
 
 /* Callback from stack when TX packet can be released */
+extern const struct ubuf_info_ops xenvif_ubuf_ops;
+
 void xenvif_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *ubuf,
 			      bool zerocopy_success);
 
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index fc3bb63b9ac3e..888b546a1500d 100644
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
index 0d51c900c5538..e3d8ab1e6cd26 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1167,7 +1167,7 @@ static int xenvif_handle_frag_list(struct xenvif_queue *queue, struct sk_buff *s
 	uarg = skb_shinfo(skb)->destructor_arg;
 	/* increase inflight counter to offset decrement in callback */
 	atomic_inc(&queue->inflight_packets);
-	uarg->callback(NULL, uarg, true);
+	uarg->ops->complete(NULL, uarg, true);
 	skb_shinfo(skb)->destructor_arg = NULL;
 
 	/* Fill the skb with the new (local) frags. */
@@ -1323,6 +1323,10 @@ void xenvif_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *ubuf_base,
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
index a6f966864252a..695b09be7f5ad 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -421,6 +421,10 @@ static void vhost_zerocopy_callback(struct sk_buff *skb,
 	rcu_read_unlock_bh();
 }
 
+static const struct ubuf_info_ops vhost_ubuf_ops = {
+	.complete = vhost_zerocopy_callback,
+};
+
 static inline unsigned long busy_clock(void)
 {
 	return local_clock() >> 10;
@@ -922,7 +926,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 			vq->heads[nvq->upend_idx].len = VHOST_DMA_IN_PROGRESS;
 			ubuf->ctx = nvq->ubufs;
 			ubuf->desc = nvq->upend_idx;
-			ubuf->ubuf.callback = vhost_zerocopy_callback;
+			ubuf->ubuf.ops = &vhost_ubuf_ops;
 			ubuf->ubuf.flags = SKBFL_ZEROCOPY_FRAG;
 			refcount_set(&ubuf->ubuf.refcnt, 1);
 			msg.msg_control = &ctl;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c5a2b0f6516c7..5ab013ecb5946 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -531,6 +531,13 @@ enum {
 #define SKBFL_ALL_ZEROCOPY	(SKBFL_ZEROCOPY_FRAG | SKBFL_PURE_ZEROCOPY | \
 				 SKBFL_DONT_ORPHAN | SKBFL_MANAGED_FRAG_REFS)
 
+struct ubuf_info;
+
+struct ubuf_info_ops {
+	void (*complete)(struct sk_buff *, struct ubuf_info *,
+			 bool zerocopy_success);
+};
+
 /*
  * The callback notifies userspace to release buffers when skb DMA is done in
  * lower device, the skb last reference should be 0 when calling this.
@@ -540,8 +547,7 @@ enum {
  * The desc field is used to track userspace buffer index.
  */
 struct ubuf_info {
-	void (*callback)(struct sk_buff *, struct ubuf_info *,
-			 bool zerocopy_success);
+	const struct ubuf_info_ops *ops;
 	refcount_t refcnt;
 	u8 flags;
 };
@@ -1652,6 +1658,8 @@ static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
 }
 #endif
 
+extern const struct ubuf_info_ops msg_zerocopy_ubuf_ops;
+
 struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 				       struct ubuf_info *uarg);
 
@@ -1747,13 +1755,13 @@ static inline void *skb_zcopy_get_nouarg(struct sk_buff *skb)
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
@@ -1767,7 +1775,7 @@ static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
 
 	if (uarg) {
 		if (!skb_zcopy_is_nouarg(skb))
-			uarg->callback(skb, uarg, zerocopy_success);
+			uarg->ops->complete(skb, uarg, zerocopy_success);
 
 		skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
 	}
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0abdc47ac72e8..14f09270c2f75 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -699,6 +699,9 @@ static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
 	return kmalloc(size, flags | __GFP_ZERO);
 }
 
+/* Allocate a zeroed object using its variable or type. */
+#define kzalloc_obj(obj, flags) kzalloc(sizeof(obj), (flags))
+
 /**
  * kzalloc_node - allocate zeroed memory from a particular memory node.
  * @size: how many bytes of memory are required.
diff --git a/include/net/sock.h b/include/net/sock.h
index 9fe621f985740..38f75e0b37c33 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2879,9 +2879,10 @@ static inline void sock_tx_timestamp(struct sock *sk, __u16 tsflags,
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
index 4bfef10161fa0..1c2f11d7693a7 100644
--- a/io_uring/notif.c
+++ b/io_uring/notif.c
@@ -45,6 +45,10 @@ static void io_uring_tx_zerocopy_callback(struct sk_buff *skb,
 	}
 }
 
+static const struct ubuf_info_ops io_ubuf_ops = {
+	.complete = io_uring_tx_zerocopy_callback,
+};
+
 struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx)
 	__must_hold(&ctx->uring_lock)
 {
@@ -65,7 +69,7 @@ struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx)
 	nd = io_notif_to_data(notif);
 	nd->account_pages = 0;
 	nd->uarg.flags = SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
-	nd->uarg.callback = io_uring_tx_zerocopy_callback;
+	nd->uarg.ops = &io_ubuf_ops;
 	nd->zc_report = nd->zc_used = nd->zc_copied = false;
 	refcount_set(&nd->uarg.refcnt, 1);
 	return notif;
diff --git a/net/can/raw.c b/net/can/raw.c
index c54d3b8ee2152..0bd9a529636f3 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -892,7 +892,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb->mark = sk->sk_mark;
 	skb->tstamp = sockc.transmit_time;
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	err = can_send(skb, ro->loopback);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4585f7c2af4cf..653016405c895 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1309,7 +1309,7 @@ static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size)
 		return NULL;
 	}
 
-	uarg->ubuf.callback = msg_zerocopy_callback;
+	uarg->ubuf.ops = &msg_zerocopy_ubuf_ops;
 	uarg->id = ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
 	uarg->len = 1;
 	uarg->bytelen = size;
@@ -1335,7 +1335,7 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 		u32 bytelen, next;
 
 		/* there might be non MSG_ZEROCOPY users */
-		if (uarg->callback != msg_zerocopy_callback)
+		if (uarg->ops != &msg_zerocopy_ubuf_ops)
 			return NULL;
 
 		/* realloc only when socket is locked (TCP, UDP cork),
@@ -1458,6 +1458,11 @@ void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
 }
 EXPORT_SYMBOL_GPL(msg_zerocopy_callback);
 
+const struct ubuf_info_ops msg_zerocopy_ubuf_ops = {
+	.complete = msg_zerocopy_callback,
+};
+EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
+
 void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
 {
 	struct sock *sk = skb_from_uarg(uarg_to_msgzc(uarg))->sk;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 1fcc4426361df..0247e134ee90d 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -361,7 +361,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 7b17f1b2a6128..bb67f43eb7bdf 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -622,7 +622,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 538fc4075292d..acf78fd6bb543 100644
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
@@ -1396,6 +1397,8 @@ static void packet_sock_destruct(struct sock *sk)
 	WARN_ON(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
 
+	packet_free_pending(pkt_sk(sk));
+
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		pr_err("Attempt to release alive packet socket: %p\n", sk);
 		return;
@@ -2127,7 +2130,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
@@ -2595,11 +2598,11 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		__u32 ts;
 
 		ph = skb_zcopy_get_nouarg(skb);
-		packet_dec_pending(&po->tx_ring);
 
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
+		packet_dec_pending(&po->tx_ring);
 		complete(&po->skb_completion);
 	}
 
@@ -2654,7 +2657,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
 	skb->tstamp = sockc->transmit_time;
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
 	skb_reserve(skb, hlen);
@@ -3129,7 +3132,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_free;
 	}
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	if (!vnet_hdr.gso_type && (len > dev->mtu + reserve + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
@@ -3259,7 +3262,6 @@ static int packet_release(struct socket *sock)
 	/* Purge queues */
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	packet_free_pending(po);
 	sk_refcnt_debug_release(sk);
 
 	sock_put(sk);
@@ -4395,11 +4397,26 @@ static const struct vm_operations_struct packet_mmap_ops = {
 	.close	=	packet_mm_close,
 };
 
+struct packet_pg_vec {
+	struct packet_pg_vec_free *deferred;
+	unsigned int order;
+	unsigned int len;
+	struct pgv pg_vec[];
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
@@ -4410,7 +4427,46 @@ static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
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
@@ -4438,20 +4494,36 @@ static char *alloc_one_pg_vec_page(unsigned long order)
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
@@ -4534,7 +4606,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 		err = -ENOMEM;
 		order = get_order(req->tp_block_size);
-		pg_vec = alloc_pg_vec(req, order);
+		pg_vec = alloc_pg_vec(req, order, tx_ring);
 		if (unlikely(!pg_vec))
 			goto out;
 		switch (po->tp_version) {
@@ -4586,6 +4658,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
 	if (closing || atomic_long_read(&po->mapped) == 0) {
+		if (tx_ring && !closing && packet_read_pending(rb))
+			goto out_unlock;
+
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4607,6 +4682,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 			pr_err("packet_mmap: vma is busy: %ld\n",
 			       atomic_long_read(&po->mapped));
 	}
+out_unlock:
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
@@ -4628,7 +4704,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
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

