Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DA36F8EF
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790438548; cv=none; b=acWXnaU86ooYf2OWsy6Pb4yuuipUilsK0mqDqtVRZYKWt8jptvVRAmpp0UovX3nGwEqpnvHmCJHYrIX/GhF+23ldN643asJTXbOwh2LCpvjMH1Eck7lZVYDSfh5w6mpZCaER+vjevYTQDA3SUwq5WRSKti9QG7kEethwWNs5zDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790438548; c=relaxed/simple;
	bh=Q8rrfl9uzxg5BsBKmhSIKYc4+X7CHhstnHUhApwz62c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz/rnqtahmJ71Izvn7j4wuQqspct4sV3Hxb3zgv2/ekL/33bKePwOWam39hodOxby4GYGP6RDjHI4MModXCR+nrxbGWzcbcVz/aDTZ4gKO2fs7Ka7ImY868prHc9uwE2umi6NNnQELFm7IoB6P15pOVA7lNllzr9VL1wUfz41QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=GmpiQedz; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="GmpiQedz"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so956595a91.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790438546; x=1791043346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VP5FvClOS/wtmhLyj2bxBgJAwktRlmBKPUQLZDuieYo=;
        b=GmpiQedzhrfq+xIaGxvHb080UDc7YauTZoVRefB+REXP/6qKx7KY8d+bwKoHWO08Nc
         eaf/t3lOI/8VyrWdv9kwjF1rx0ewMNJ1r7Dp9yyLLjE9ZvwMkWF2kErBvuwz5cpyb0WD
         zpsw5N9DWHonPJqjnl3wOHOQG7lwjNwHe7caJkLyeuaYA/eeQke7ex7xONdpAEx2pmCV
         khWhBNxKeCebGMH4ZWkxbb28vSblt1I4aExsgjlbWuN2RxFfz9d+PxZ/y5oI/nkc+gIl
         xbCLGYA+F7XbCzhhNLRtkYEoahahx0wqO530iWATw24fFWxGObWjw7ALaT8KwtG9KYy4
         Rhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790438546; x=1791043346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VP5FvClOS/wtmhLyj2bxBgJAwktRlmBKPUQLZDuieYo=;
        b=j9nyDXdHVoHvtVaEUUDDLiTiU50n+CFoqQIWUrw9Jlkj52/OW7ixQCaIWlahCZcRyl
         Bc4YsOq4HB391i16Y6vh4+uLnG4tWa7eJpMXv9gqyGu6DIflpmMXZaBJr3eQmJOBxmdG
         JR36kZlU4SRip54zWlla7EQBHFuLr+R53Yyi140LSPQ2U06XgiCRTZspvXQVZpsHtYth
         8vT1sbHyPqrLO/7no92/LbU8BYJnzuNkzVkJFVqWnzFmz05Gy58mPYjlAPHM+xEqdl1G
         3rndrZbpa1uZVV+lswwe7bOHumgZ+38Gia07aQXMxCHV5pKbEmpRxafJWDPzpgcjEZDW
         l5fw==
X-Forwarded-Encrypted: i=1; AKwUvBwSxycJKi1lKjtGbYjHmakD8jugm9aI6k050AfHsd9ZuVfbBYl5ea8XfViyZmKEma06PxKYC3g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnbFk01a0DvJ4Tz/T+pvBkjJn/plKoxE+l6HTvIWCeLLlESsyK
	8Zw7eJwkq22Ahjxe+I3zLR40NecinKtLxU9LK+crmRwp42q3IkTjI30AeCU0ONzHrurk
X-Gm-Gg: AYBFou2VsrOpvJ6ymHTVRG1dVScv48ec2p/06IeR34KceJEsRot4JGkC5NM69zj7PiJ
	/r0r70zcIgU4VMy1R8pLHT+1LvE3pV4cfpCAMZg3BbUS7IJ7g3eUKe1SFX37cQ5kE3kLJOXED2g
	+2yr1uXRGARvd0D54R7GXPpcGwS5HY/YuysFeYDDWbv5fL9+atoltvaaEsPO/Rts4iYaUPWQjUb
	w6E+57XH1lhOmU3BfwRVIUZ35F8gk62fL/dunBQJYYecIjDTVupTm2Z6iUWLbYHmaQ+wnZD7JPl
	w8Dx5lHaBwP7lJBbXnAZwQScgoQKHh8E6vECZyitsfHU/3PFh4Jl79LbJ9kpoauSqLjeKqcTrnt
	u1OnYTnTOMmqQg8AhDfTCHTOoliAGGKWk6Ykwu5yBRJdJD3qWb/PBk7WjTaN4krEX3aLY2rnbTy
	pNlLSrlbIj/F1zgP1Z02YVy1nqclHAUoTAxZrxvQ1rF1F1k6oujxvjHYQF88cT2UKLaI2ubJUeN
	LpDvZumPlKUg90HG+99K/0aILCM0g==
X-Received: by 2002:a17:90b:380a:b0:3a0:be2d:3853 with SMTP id 98e67ed59e1d1-3a0be2d3c4emr4591237a91.8.1790438545632;
        Sat, 26 Sep 2026 09:02:25 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm10449199a91.6.2026.09.26.09.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:02:24 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v7 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Sat, 26 Sep 2026 16:02:06 +0000
Message-ID: <f2f46bb2d18375b2f02548cadb8d024d164bb020.1790427022.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790427022.git.zihanx@nebusec.ai>
References: <cover.1790427022.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_encap_rcv() queues encapsulated UDP packets on the RxRPC local
queue without charging them to the UDP socket. If the I/O thread cannot
keep up, the queue can therefore grow without bound.

Charge each packet against the tunnel socket before queueing it, while
holding sk_receive_queue.lock, and drop it when socket rmem or protocol
memory accounting fails. Size the socket from the advertised RxRPC
receive window, retain headroom for control and error packets, and
refresh the cap when the window grows without shrinking an existing
buffer. The lock also serializes sk_forward_alloc updates with the
destructor path.

Orphan charged PACKET skbs under the same lock when the I/O thread
dequeues them. Keep the existing destructor for error skbs, clear
skb->dev, drop the dst, and account drops with the corresponding UDP
statistics and reasons.

Since skb_set_owner_r() does not hold a socket reference, clear
sk_user_data under RCU and release the socket only after purging the
local queues.

Fixes: 446b3e14525b ("rxrpc: Move packet reception processing into I/O thread")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v7:
  - Rebase the fix onto net/main at a7bfaba4823e.
  - v6 Link: https://lore.kernel.org/all/cover.1789608557.git.zihanx@nebusec.ai/
changes in v6:
  - refresh the tunnel socket receive-buffer cap when
    rxrpc_rx_window_size increases, without shrinking an existing
    socket
  - distinguish socket receive-buffer exhaustion from protocol memory
    accounting failures in the drop reason and UDP statistics
  - cap the window-derived value at sysctl_rmem_max and only grow an
    existing sk_rcvbuf; avoid the unexported sysctl_rmem_default
  - v5 Link: https://lore.kernel.org/all/cover.1789273347.git.zihanx@nebusec.ai/
changes in v5:
  - size the tunnel sk_rcvbuf to one advertised window of ordinary
    DATA (RXRPC_JUMBO(1)), doubled for typical 2-4KiB skb truesize,
    plus 25% for ACKs/ICMP, capped by sysctl_rmem_max
  - leave ICMP/error-queue headroom in the DATA rmem check
  - count UDP RCVBUFERRORS/INERRORS and drop with
    SKB_DROP_REASON_SOCKET_RCVBUFF
  - drop the dst instead of skb_dst_force(); keep skb->dev = NULL
  - refresh the cover crash log from the latest unfixed net/main
    run; record the panic as a sender-path OOM, not an I/O-thread
    allocation
  - note that sk_rcvbuf is sized at socket open and is not updated
    if rxrpc_rx_window_size later changes
  - v4 Link: https://lore.kernel.org/all/cover.1788878590.git.zihanx@nebusec.ai/
changes in v4:
  - serialise UDP rmem charge/uncharge with sk->sk_receive_queue.lock
  - use spin_lock() in encap_rcv() (BH) and spin_lock_bh() around
    skb_orphan() in the I/O thread
  - do not enqueue encapsulated skbs on the UDP receive queue
  - orphan only PACKET skbs charged in encap_rcv(); leave error-queue
    skb ownership alone
  - restore the unprivileged namespace reproducer and document the
    AFS callback listener
  - clarify in the cover that the recorded panic is a downstream OOM
    after extra I/O-thread contention, not the unprivileged flood
    alone
  - include the full OOM Mem-Info in the cover crash log
  - v3 Link: https://lore.kernel.org/all/cover.1788539302.git.zihanx@nebusec.ai/
changes in v3:
  - orphan the skb when the I/O thread dequeues it from the local
    queue so UDP rmem ownership does not follow packets onto
    call/conn queues
  - mention both io_thread.c and local_object.c in the cover opening
  - distinguish the unprivileged flood from extra steps used to
    record the panic
  - attribute the OOM to skbuff growth rather than incoming-call
    setup
  - describe the recorded panic as a downstream OOM after I/O-thread
    contention, not as an allocation at the encap_rcv enqueue site
  - v2 Link: https://lore.kernel.org/all/cover.1785339953.git.zihanx@nebusec.ai/
changes in v2:
  - switch the drop path from atomic_inc(&udp_sk->sk_drops) to
    sk_drops_inc(udp_sk)
  - retarget Fixes to 446b3e14525b, the first boundary where encap_rcv
    queued the skb onto local->rx_queue for later I/O-thread consumption
  - rebase onto current net/main
  - refresh the cover crash log from an unfixed 7.3.0-rc1+ net/main run
    and include the decoded stack
  - explain in the cover why packetdrill was not used
  - document the actual flood command in the cover
  - v1 Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebusec.ai/
---
 net/rxrpc/ar-internal.h  |  1 +
 net/rxrpc/io_thread.c    | 77 ++++++++++++++++++++++++++++++++++++++--
 net/rxrpc/local_object.c | 24 +++++++++++--
 3 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab9..b079ec98aaa74 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1323,6 +1323,7 @@ void rxrpc_send_version_request(struct rxrpc_local *local,
  * local_object.c
  */
 void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set);
+void rxrpc_adjust_rcvbuf(struct sock *sk);
 struct rxrpc_local *rxrpc_lookup_local(struct net *, const struct sockaddr_rxrpc *);
 struct rxrpc_local *rxrpc_get_local(struct rxrpc_local *, enum rxrpc_local_trace);
 struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *, enum rxrpc_local_trace);
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index dc5184a2fa9d1..fa6cfd603548b 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -7,12 +7,55 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <net/udp.h>
+
 #include "ar-internal.h"
 
 static int rxrpc_input_packet_on_conn(struct rxrpc_connection *conn,
 				      struct sockaddr_rxrpc *peer_srx,
 				      struct sk_buff *skb);
 
+/*
+ * Drop UDP rmem ownership for packets charged in encap_rcv().
+ * sk_forward_alloc is serialised by sk_receive_queue.lock.
+ */
+static void rxrpc_skb_orphan_udp(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+
+	if (!sk)
+		return;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	skb_orphan(skb);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
+static void rxrpc_encap_rcv_drop(struct sock *udp_sk, struct sk_buff *skb,
+				 enum skb_drop_reason reason)
+{
+	struct net *net = sock_net(udp_sk);
+
+	sk_drops_inc(udp_sk);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (skb->protocol == htons(ETH_P_IPV6)) {
+		if (reason == SKB_DROP_REASON_SOCKET_RCVBUFF)
+			__UDP6_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
+		else
+			__UDP6_INC_STATS(net, UDP_MIB_MEMERRORS);
+		__UDP6_INC_STATS(net, UDP_MIB_INERRORS);
+	} else
+#endif
+	{
+		if (reason == SKB_DROP_REASON_SOCKET_RCVBUFF)
+			__UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
+		else
+			__UDP_INC_STATS(net, UDP_MIB_MEMERRORS);
+		__UDP_INC_STATS(net, UDP_MIB_INERRORS);
+	}
+	sk_skb_reason_drop(udp_sk, skb, reason);
+}
+
 /*
  * handle data received on the local endpoint
  * - may be called in interrupt context
@@ -28,6 +71,9 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	struct sk_buff_head *rx_queue;
 	struct rxrpc_local *local = rcu_dereference_sk_user_data(udp_sk);
 	struct task_struct *io_thread;
+	enum skb_drop_reason reason;
+	unsigned int headroom;
+	unsigned int rcvbuf;
 
 	if (unlikely(!local)) {
 		kfree_skb(skb);
@@ -41,8 +87,6 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	if (skb->tstamp == 0)
 		skb->tstamp = ktime_get_real();
 
-	skb->mark = RXRPC_SKB_MARK_PACKET;
-	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	rx_queue = &local->rx_queue;
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
 	if (rxrpc_inject_rx_delay ||
@@ -52,9 +96,35 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	}
 #endif
 
+	headroom = SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2;
+	spin_lock(&udp_sk->sk_receive_queue.lock);
+	rxrpc_adjust_rcvbuf(udp_sk);
+	rcvbuf = READ_ONCE(udp_sk->sk_rcvbuf);
+	if ((unsigned int)atomic_read(&udp_sk->sk_rmem_alloc) +
+	    skb->truesize + headroom >= rcvbuf) {
+		reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
+		goto drop;
+	}
+	if (!sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
+		reason = SKB_DROP_REASON_PROTO_MEM;
+		goto drop;
+	}
+
+	skb->dev = NULL;
+	skb_set_owner_r(skb, udp_sk);
+	spin_unlock(&udp_sk->sk_receive_queue.lock);
+	skb_dst_drop(skb);
+
+	skb->mark = RXRPC_SKB_MARK_PACKET;
+	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	skb_queue_tail(rx_queue, skb);
 	wake_up_process(io_thread);
 	return 0;
+
+drop:
+	spin_unlock(&udp_sk->sk_receive_queue.lock);
+	rxrpc_encap_rcv_drop(udp_sk, skb, reason);
+	return 0;
 }
 
 /*
@@ -471,6 +541,9 @@ int rxrpc_io_thread(void *data)
 		/* Distribute packets and errors. */
 		while ((skb = __skb_dequeue(&rx_queue))) {
 			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+			if (skb->mark == RXRPC_SKB_MARK_PACKET)
+				rxrpc_skb_orphan_udp(skb);
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
 				skb->priority = 0;
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 169f9dfdaa77f..f519a93059244 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -22,6 +22,19 @@
 
 static void rxrpc_local_rcu(struct rcu_head *);
 
+void rxrpc_adjust_rcvbuf(struct sock *sk)
+{
+	u32 rcvbuf, old_rcvbuf;
+
+	rcvbuf = READ_ONCE(rxrpc_rx_window_size) *
+		SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2;
+	rcvbuf += rcvbuf / 4;
+	rcvbuf = min_t(u32, rcvbuf, READ_ONCE(sysctl_rmem_max));
+	old_rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+	if (rcvbuf > old_rcvbuf)
+		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
+}
+
 /*
  * Handle an ICMP/ICMP6 error turning up at the tunnel.  Push it through the
  * usual mechanism so that it gets parsed and presented through the UDP
@@ -198,6 +211,9 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 
 	/* set the socket up */
 	usk = local->socket->sk;
+	spin_lock_bh(&usk->sk_receive_queue.lock);
+	rxrpc_adjust_rcvbuf(usk);
+	spin_unlock_bh(&usk->sk_receive_queue.lock);
 	usk->sk_error_report = rxrpc_error_report;
 
 	switch (srx->transport.family) {
@@ -437,8 +453,8 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	if (socket) {
 		local->socket = NULL;
 		kernel_sock_shutdown(socket, SHUT_RDWR);
-		socket->sk->sk_user_data = NULL;
-		sock_release(socket);
+		rcu_assign_sk_user_data(socket->sk, NULL);
+		synchronize_rcu();
 	}
 
 	/* At this point, there should be no more packets coming in to the
@@ -448,6 +464,10 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	rxrpc_purge_queue(&local->rx_delay_queue);
 #endif
 	rxrpc_purge_queue(&local->rx_queue);
+
+	if (socket)
+		sock_release(socket);
+
 	rxrpc_purge_client_connections(local);
 	page_frag_cache_drain(&local->tx_alloc);
 }
-- 
2.43.0

