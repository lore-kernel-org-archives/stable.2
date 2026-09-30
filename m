Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226B4F391E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781000; cv=none; b=i1hcWmUsrTfaLR0ZbZWafKCKxvCVaCZOXlqyJ5ztAjFRt38Wdyt3ThIbWAe2T+Ynl/6c4b3jFiPEJbiXNN6dTFLw5DL1k4H2Qw0XuZx1THv4J9efXo0cmYLaWSzy9xUqvxH9wi6jX3urSPCLO9ivth0sFHQXKDYZ90SzbKcRbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781000; c=relaxed/simple;
	bh=0I4wz7OukuYAVg4G2aSuGDIG44XzdCL9ZYfyTXM5uck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAVXO0mX6vTZMAnPUBfXeAGTbeDBViIpPp7+VUsweo1dgiGbk3z51sc7pRQmJPdU8XiRSGw5VizXxbZs1y1LhikEIYk3WcLZ9NMLbghd/8n5gaEDw3bd5ypd8QN3vonVpDD2YOY+irRe3R0HSD/o1ZP/bz2ivDT+nH6iC9im4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7hi8AQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7hi8AQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E391F00898;
	Wed, 30 Sep 2026 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780990;
	bh=p5dQASa73SmZRRPVbabl0RgsxPoaj4lT3kVwB0WtQy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d7hi8AQjLU+K/PVv/pAUY2F14ybfMnoeUh7dB/7N44DGCbyxT479j/44cF0YzNzgz
	 VL1JWakodYWL9oncIxTbVMTYcCkx58LgRnUpztlHyttMSWr95zlN1K33HhnYHjN1zm
	 NpQfX6qJLdrwBsuSC6RDqJCVPn1OhYG3iDVtFp8/ThdEfunjj9YKtz4salENFHF1Hn
	 4cpyEIXucY65o4cZc9kdQcLwS97L6VC/ipZZxL26Le3B+E29tGu0b4Df6rHRN6/5Eg
	 bbQEbl5FLPwqK85nZE2zCU11DUxJquXRunmNjtfU2o9amj6lV0KFAf9IIT5tNF0I4p
	 bERapLNdy/fVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net/packet: defer vmalloc TX_RING free until skbs finish
Date: Wed, 30 Sep 2026 11:09:46 -0400
Message-ID: <20260930150947.2353841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092952-contents-unworn-2736@gregkh>
References: <2026092952-contents-unworn-2736@gregkh>
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

Backport preparation for 9518405613863 on Linux 5.15:

Keep sk_refcnt_debug_release() in packet_release(), while moving only
packet_free_pending() to the final socket destructor. Use struct_size()
with kzalloc(), plain container_of(), and an unannotated flexible array
for interfaces that this branch provides. Retain the upstream deferred
TX-ring cleanup functions without adding any further functions.

Prepare the target's zerocopy completion interface by replacing the
ubuf_info callback pointer with an ops pointer and updating every existing
producer and consumer, keeping their callback implementations unchanged.
Use SKBFL_DONT_ORPHAN for MSG_ZEROCOPY so skb_orphan_frags() no longer
depends on the nouarg helper that the target removes; include the flag in
SKBFL_ALL_ZEROCOPY when clearing zerocopy state.

Pass the existing socket cookie to skb_setup_tx_timestamp() and update
all its callers, preserving timestamp semantics while avoiding a merge
conflict adjacent to the target's removal of skb_zcopy_set_nouarg().
Provide the explicit-flags kzalloc_obj() macro and the upstream debug
assertion macro used by the target, without importing unrelated newer
allocation or socket timestamp machinery.

Stable-dep-of: 951840561386 ("packet: use ubuf_info completion for TX_RING packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c                   |   2 +-
 drivers/net/tun.c                   |   2 +-
 drivers/net/xen-netback/common.h    |   1 +
 drivers/net/xen-netback/interface.c |   2 +-
 drivers/net/xen-netback/netback.c   |   6 +-
 drivers/vhost/net.c                 |   6 +-
 include/linux/net.h                 |   6 ++
 include/linux/skbuff.h              |  25 ++++---
 include/linux/slab.h                |   3 +
 include/net/sock.h                  |   5 +-
 net/can/raw.c                       |   2 +-
 net/core/skbuff.c                   |   9 ++-
 net/ipv4/raw.c                      |   2 +-
 net/ipv6/raw.c                      |   2 +-
 net/packet/af_packet.c              | 103 ++++++++++++++++++++++++----
 15 files changed, 144 insertions(+), 32 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 3a91972485cc3..72f7df47d58d9 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -733,7 +733,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		skb_zcopy_init(skb, msg_control);
 	} else if (msg_control) {
 		struct ubuf_info *uarg = msg_control;
-		uarg->callback(NULL, uarg, false);
+		uarg->ops->complete(NULL, uarg, false);
 	}
 
 	dev_queue_xmit(skb);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 88a4004464aba..08699f23ae153 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1909,7 +1909,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		skb_zcopy_init(skb, msg_control);
 	} else if (msg_control) {
 		struct ubuf_info *uarg = msg_control;
-		uarg->callback(NULL, uarg, false);
+		uarg->ops->complete(NULL, uarg, false);
 	}
 
 	skb_reset_network_header(skb);
diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index f315bddacba3f..79081b742d860 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -393,6 +393,7 @@ void xenvif_carrier_on(struct xenvif *vif);
 /* Callback from stack when TX packet can be released */
 void xenvif_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *ubuf,
 			      bool zerocopy_success);
+extern const struct ubuf_info_ops xenvif_zerocopy_ops;
 
 static inline pending_ring_idx_t nr_pending_reqs(struct xenvif_queue *queue)
 {
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index f20ddaaa24518..f1b1c7466892c 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -588,7 +588,7 @@ int xenvif_init_queue(struct xenvif_queue *queue)
 
 	for (i = 0; i < MAX_PENDING_REQS; i++) {
 		queue->pending_tx_info[i].callback_struct = (struct ubuf_info)
-			{ .callback = xenvif_zerocopy_callback,
+			{ .ops = &xenvif_zerocopy_ops,
 			  { { .ctx = NULL,
 			      .desc = i } } };
 		queue->grant_tx_handle[i] = NETBACK_INVALID_HANDLE;
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 12986da63d4cd..63b99c166d126 100644
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
@@ -1291,6 +1291,10 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
 	return work_done;
 }
 
+const struct ubuf_info_ops xenvif_zerocopy_ops = {
+	.complete = xenvif_zerocopy_callback,
+};
+
 void xenvif_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *ubuf,
 			      bool zerocopy_success)
 {
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 3d98af5045bbf..6687f92ab306b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -413,6 +413,10 @@ static void vhost_zerocopy_callback(struct sk_buff *skb,
 	rcu_read_unlock_bh();
 }
 
+static const struct ubuf_info_ops vhost_zerocopy_ops = {
+	.complete = vhost_zerocopy_callback,
+};
+
 static inline unsigned long busy_clock(void)
 {
 	return local_clock() >> 10;
@@ -912,7 +916,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 			ubuf = nvq->ubuf_info + nvq->upend_idx;
 			vq->heads[nvq->upend_idx].id = cpu_to_vhost32(vq, head);
 			vq->heads[nvq->upend_idx].len = VHOST_DMA_IN_PROGRESS;
-			ubuf->callback = vhost_zerocopy_callback;
+			ubuf->ops = &vhost_zerocopy_ops;
 			ubuf->ctx = nvq->ubufs;
 			ubuf->desc = nvq->upend_idx;
 			ubuf->flags = SKBFL_ZEROCOPY_FRAG;
diff --git a/include/linux/net.h b/include/linux/net.h
index 9054f17e4b631..db9fb9aff6362 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -242,6 +242,12 @@ struct socket *sock_from_file(struct file *file);
 #define		     sockfd_put(sock) fput(sock->file)
 int net_ratelimit(void);
 
+#if defined(CONFIG_DEBUG_NET)
+#define DEBUG_NET_WARN_ON_ONCE(cond) ((void)WARN_ON_ONCE(cond))
+#else
+#define DEBUG_NET_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
+#endif
+
 #define net_ratelimited_function(function, ...)			\
 do {								\
 	if (net_ratelimit())					\
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 24ceeab1b509f..f712cff74b7a1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -493,9 +493,19 @@ enum {
 	 * all frags to avoid possible bad checksum
 	 */
 	SKBFL_SHARED_FRAG = BIT(1),
+
+	SKBFL_DONT_ORPHAN = BIT(3),
 };
 
 #define SKBFL_ZEROCOPY_FRAG	(SKBFL_ZEROCOPY_ENABLE | SKBFL_SHARED_FRAG)
+#define SKBFL_ALL_ZEROCOPY	(SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN)
+
+struct ubuf_info;
+
+struct ubuf_info_ops {
+	void (*complete)(struct sk_buff *, struct ubuf_info *,
+			 bool zerocopy_success);
+};
 
 /*
  * The callback notifies userspace to release buffers when skb DMA is done in
@@ -506,8 +516,7 @@ enum {
  * The desc field is used to track userspace buffer index.
  */
 struct ubuf_info {
-	void (*callback)(struct sk_buff *, struct ubuf_info *,
-			 bool zerocopy_success);
+	const struct ubuf_info_ops *ops;
 	union {
 		struct {
 			unsigned long desc;
@@ -542,6 +551,7 @@ void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
 
 void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
 			   bool success);
+extern const struct ubuf_info_ops msg_zerocopy_ubuf_ops;
 
 int skb_zerocopy_iter_dgram(struct sk_buff *skb, struct msghdr *msg, int len);
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
@@ -1558,13 +1568,13 @@ static inline void *skb_zcopy_get_nouarg(struct sk_buff *skb)
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
@@ -1578,9 +1588,9 @@ static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
 
 	if (uarg) {
 		if (!skb_zcopy_is_nouarg(skb))
-			uarg->callback(skb, uarg, zerocopy_success);
+			uarg->ops->complete(skb, uarg, zerocopy_success);
 
-		skb_shinfo(skb)->flags &= ~SKBFL_ZEROCOPY_FRAG;
+		skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
 	}
 }
 
@@ -2949,8 +2959,7 @@ static inline int skb_orphan_frags(struct sk_buff *skb, gfp_t gfp_mask)
 {
 	if (likely(!skb_zcopy(skb)))
 		return 0;
-	if (!skb_zcopy_is_nouarg(skb) &&
-	    skb_uarg(skb)->callback == msg_zerocopy_callback)
+	if (skb_shinfo(skb)->flags & SKBFL_DONT_ORPHAN)
 		return 0;
 	return skb_copy_ubufs(skb, gfp_mask);
 }
diff --git a/include/linux/slab.h b/include/linux/slab.h
index c13f785c62dad..45e1e3305651a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -738,6 +738,9 @@ static inline void *kzalloc(size_t size, gfp_t flags)
 	return kmalloc(size, flags | __GFP_ZERO);
 }
 
+/* Allocate one zeroed object with explicit GFP flags. */
+#define kzalloc_obj(P, flags) kzalloc(sizeof(P), flags)
+
 /**
  * kzalloc_node - allocate zeroed memory from a particular memory node.
  * @size: how many bytes of memory are required.
diff --git a/include/net/sock.h b/include/net/sock.h
index 2b13a41cd99a9..96ed35cae63da 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2766,9 +2766,10 @@ static inline void sock_tx_timestamp(struct sock *sk, __u16 tsflags,
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
 
diff --git a/net/can/raw.c b/net/can/raw.c
index ffbb622f88422..c5953685fe985 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -847,7 +847,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb->mark = sk->sk_mark;
 	skb->tstamp = sockc.transmit_time;
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	err = can_send(skb, ro->loopback);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 01e7f091f6aae..c0878a4a2fb7b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1192,12 +1192,12 @@ struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size)
 		return NULL;
 	}
 
-	uarg->callback = msg_zerocopy_callback;
+	uarg->ops = &msg_zerocopy_ubuf_ops;
 	uarg->id = ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
 	uarg->len = 1;
 	uarg->bytelen = size;
 	uarg->zerocopy = 1;
-	uarg->flags = SKBFL_ZEROCOPY_FRAG;
+	uarg->flags = SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
 	refcount_set(&uarg->refcnt, 1);
 	sock_hold(sk);
 
@@ -1334,6 +1334,11 @@ void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
 }
 EXPORT_SYMBOL_GPL(msg_zerocopy_callback);
 
+const struct ubuf_info_ops msg_zerocopy_ubuf_ops = {
+	.complete = msg_zerocopy_callback,
+};
+EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
+
 void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
 {
 	struct sock *sk = skb_from_uarg(uarg)->sk;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index dbfc9301a1fc1..c1d2d69f45618 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -360,7 +360,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index c3719e5ac89fc..a2d082ad6145a 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -627,7 +627,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 447c29d942e9e..a39f2e64e554c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -86,6 +86,7 @@
 #include <linux/errqueue.h>
 #include <linux/net_tstamp.h>
 #include <linux/percpu.h>
+#include <linux/workqueue.h>
 #ifdef CONFIG_INET
 #include <net/inet_common.h>
 #endif
@@ -1359,6 +1360,8 @@ static void packet_sock_destruct(struct sock *sk)
 	WARN_ON(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
 
+	packet_free_pending(pkt_sk(sk));
+
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		pr_err("Attempt to release alive packet socket: %p\n", sk);
 		return;
@@ -2089,7 +2092,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->mark = sk->sk_mark;
 	skb->tstamp = sockc.transmit_time;
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
@@ -2555,11 +2558,11 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		__u32 ts;
 
 		ph = skb_zcopy_get_nouarg(skb);
-		packet_dec_pending(&po->tx_ring);
 
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
+		packet_dec_pending(&po->tx_ring);
 		complete(&po->skb_completion);
 	}
 
@@ -2614,7 +2617,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->priority = po->sk.sk_priority;
 	skb->mark = po->sk.sk_mark;
 	skb->tstamp = sockc->transmit_time;
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
 	skb_reserve(skb, hlen);
@@ -3088,7 +3091,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_free;
 	}
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	if (!vnet_hdr.gso_type && (len > dev->mtu + reserve + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
@@ -3218,7 +3221,6 @@ static int packet_release(struct socket *sock)
 	/* Purge queues */
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	packet_free_pending(po);
 	sk_refcnt_debug_release(sk);
 
 	sock_put(sk);
@@ -4357,11 +4359,26 @@ static const struct vm_operations_struct packet_mmap_ops = {
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
 
+	vec = container_of(pg_vec, struct packet_pg_vec, pg_vec[0]);
 	for (i = 0; i < len; i++) {
 		if (likely(pg_vec[i].buffer)) {
 			if (is_vmalloc_addr(pg_vec[i].buffer))
@@ -4372,7 +4389,46 @@ static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
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
+	deferred = container_of(to_delayed_work(work),
+				struct packet_pg_vec_free, work);
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
+	vec = container_of(pg_vec, struct packet_pg_vec, pg_vec[0]);
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
@@ -4400,20 +4456,36 @@ static char *alloc_one_pg_vec_page(unsigned long order)
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
@@ -4496,7 +4568,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 		err = -ENOMEM;
 		order = get_order(req->tp_block_size);
-		pg_vec = alloc_pg_vec(req, order);
+		pg_vec = alloc_pg_vec(req, order, tx_ring);
 		if (unlikely(!pg_vec))
 			goto out;
 		switch (po->tp_version) {
@@ -4548,6 +4620,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
 	if (closing || atomic_long_read(&po->mapped) == 0) {
+		if (tx_ring && !closing && packet_read_pending(rb))
+			goto out_unlock;
+
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4569,6 +4644,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 			pr_err("packet_mmap: vma is busy: %ld\n",
 			       atomic_long_read(&po->mapped));
 	}
+out_unlock:
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
@@ -4590,7 +4666,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
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

