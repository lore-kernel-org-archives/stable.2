Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E346EF79
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391382; cv=none; b=hglddzm7XMYWNC76RSfREyob4KqUBLHw1tVrbmQoOfZPCPgtGqnsoMrQK8DJgzCnsLlzq8pPnAAZ9m17AHojp0M6l2vZGE/Wb0tTrZ/O8rqcuN3Hui5WDj/s9++ECjLefHSUfmP3/LH6rBFg24oitxJ52U9XOMoNWM0yPBTiY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391382; c=relaxed/simple;
	bh=K7NzQZF8k2EX5z1yRQsQ0MW/2CyWxyNl/b58em0+70o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5QFbYb3hHXa/OsIT/JPeuuTosPo8pa2hn/SHuGKq0I8134AqHUp5wbJWefr0gt/6yoK4rwXFsigCiBuvox3tEOF5pQNWG7YgdbaGssGeDH17mkGvxUnxkR6jyjE3U1YQ6217/wUWnQsyEAHwUFJK++kQ19Eo36UjKRE4sT82OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=c6uWv12K; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="c6uWv12K"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so2028473a91.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789391379; x=1789996179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfUjM+PYTr4356Xaoi7C8Eq7NyO1PouppXVS3eSNKcE=;
        b=c6uWv12K5Yd9Xgy6kGyAm5n6KFAk1ZI/sdhvpVFg7Q9sq3Zcmg89Q56vY0CFwF9YZQ
         eFaWCqD6nEFruEDGN3pCz9oUjkO3UBY0CnWvhUZDOqfqoynYkj38gZqtseiax05zNYOP
         P4cW00yJ9+ksTRXOS6WhQm2f6bb34qoKsixRwgJYvNpoDmk2ZO00eFq8zv+uiGmfDMGW
         3frohVErMUCC3v91ZhMx+f22gHO8s8MVA9ZmOzAh4+XcKAwgj9Df1ByQAOTqixNhckfm
         sNsnX8zmnJWud0AJcp63f02p89tZrCqDmuQo3Vsve+UwsowtaSnH7lfd8HVCydMM0peK
         GLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391379; x=1789996179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mfUjM+PYTr4356Xaoi7C8Eq7NyO1PouppXVS3eSNKcE=;
        b=LGHoUg++3w2vpj2TEKPK8+o4IlJW2YFI5gdD/5Anouxysia0z5T1L34d6vhEQTkNDt
         aGjs55UOWUlAJDQ7KM9MaSCqKxzoiX1/zQd67be5WyArIhXHmOQv68EuzmJpZJ+jE8dI
         pb4VWflEGgOgFeLZbv+yF42GrO1Dq6sLfjUd80bge3WMug1a3oxn1MmUT8pjLvqZaTVp
         suDbGnM1tHIQLo6FQVOfw/lxQcp6uUey1kbVhX9WLrLOFYtH4DZMGRdP/JkYGEf0SDUM
         WjDGP1JzG19DAU0AbB9JOhTx67ThwpizM2EhmKyxV55sbbNW11VdJLZKjZKf8p7apIZw
         5+YQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcoIL6PWfDNXNaW/WocVhWr4tvOOcISyv6oQXKlfwp/9h8QTUeLPJu44v2kG+wBd8A7xNgFrg=@vger.kernel.org
X-Gm-Message-State: AFuF++mKkXfSExSZWdIsb5SbyVmdyyDrn6VP4Pb1c6upElCikSDVMCtt
	X07y0MMxzVM0QvsPC2UdtmuiNqJXIl3UZ/RDHDspTqDMoBKGRjs64KWw3q/D4/kjo6JJ
X-Gm-Gg: AYBFou3ZE7hCI3LDaU59lsoMOoRjVeIcwPWVXU6pwSOC9V0VyY4mC4h5bwpywKFn4ou
	GpkcELKSF8F4kPQixkiDEZufbeYCw99WZCMhLWv9tLapCHUWU7xsXJKriuu8w51uPSEJs70B9jI
	OIUdCS2BmeUZtWRPzjtRMaLr7B1evnSUcesEu1MC587tgDfbLuSfbVzWnsoy0bIyEYKibFfy1ih
	/32BACoUpE2mw3NNYuICaRmUN5oZ8PfTffOKk/L88KoaDUXMd9j3bPt6vZOLymGtf9IudWhFsdf
	w/Zt1PoZ9zPPnFGzB/aRoq0llHun8HIc472Mjnauxt/fz9YuIh0awbQC4Qk8kczP+N0K+jVvk1C
	Hm2UpqwAFXQ+VZBUVS3gjw7FxG/9lw/uAYg+kONKqVEhyyrwgbRAJmgnj/3a6khNJFhc7BRjpgb
	mRgiWZFyfRPpfD8bXikkgdzNTeYcXU7OnAjMDiJL09AuVuwHGRWrQ8WDvWvDkrUHCBuchbU0aap
	XMTQse5Uwxexwbx+phJH+AMES4U0gRL+W7bSJzH
X-Received: by 2002:a17:90b:3c0c:b0:39d:f317:44cd with SMTP id 98e67ed59e1d1-39df3174fcemr3305326a91.14.1789391379318;
        Mon, 14 Sep 2026 06:09:39 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e5c630sm23116689a91.6.2026.09.14.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:09:38 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: zihanx@nebusec.ai,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v5 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Mon, 14 Sep 2026 13:09:12 +0000
Message-ID: <d38b683f6d583cbbc23ee149b50b15b6e4efc567.1789273347.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789273347.git.zihanx@nebusec.ai>
References: <cover.1789273347.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_encap_rcv() moves encapsulated UDP packets onto the local
RxRPC queue without preserving UDP receive-buffer accounting. A
local AF_RXRPC service such as the AFS callback listener can then
be flooded until that queue grows without bound.

Reaccount each encapsulated skb against the UDP socket before
queueing it and drop packets once sk_rcvbuf is exhausted. Orphan
PACKET skbs when the I/O thread dequeues them so UDP ownership
does not follow those packets onto call or connection queues.
Error-queue skbs keep their destructor. Clear sk_user_data under
RCU and release the socket only after the local queues are purged.

The kernel UDP tunnel never sized sk_rcvbuf, so it would stay at
sysctl_rmem_default (about 208KiB). That is smaller than one advertised
RxRPC receive window of ordinary DATA, so a compliant peer filling
rxrpc_rx_window_size packets could be dropped with no
EXCEEDS_WINDOW ACK. Set sk_rcvbuf from one ordinary-DATA window:
rxrpc_rx_window_size * SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2, plus 25%
for ACKs, extra calls and ICMP, clamped to [sysctl_rmem_default,
sysctl_rmem_max]. The * 2 covers typical 2-4KiB incoming UDP skb
truesize. Do not size from rxrpc_rx_mtu (jumbo 46). DATA admission
leaves one ordinary packet of rmem so ICMP/error-queue skbs can
still be queued while a DATA flood is at the cap.

Dropped packets increment UDP_MIB_RCVBUFERRORS and UDP_MIB_INERRORS
and use SKB_DROP_REASON_SOCKET_RCVBUFF. Clear skb->dev and drop the
dst, matching the ordinary UDP enqueue path.

sk_forward_alloc is not atomic. UDP serialises it with
sk->sk_receive_queue.lock; take that lock around the charge in
rxrpc_encap_rcv() and around skb_orphan() in the I/O thread. The
I/O thread uses spin_lock_bh() so a concurrent BH encap_rcv()
cannot update the same counter. The skbs stay on the RxRPC local
queue, not the UDP receive queue.

Fixes: 446b3e14525b ("rxrpc: Move packet reception processing into I/O thread")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
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

 net/rxrpc/io_thread.c    | 61 ++++++++++++++++++++++++++++++++++++++--
 net/rxrpc/local_object.c | 15 ++++++++--
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index dc5184a2fa9d1..c77241b12f597 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -7,12 +7,48 @@
 
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
+static void rxrpc_encap_rcv_drop(struct sock *udp_sk, struct sk_buff *skb)
+{
+	struct net *net = sock_net(udp_sk);
+
+	sk_drops_inc(udp_sk);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (skb->protocol == htons(ETH_P_IPV6)) {
+		__UDP6_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
+		__UDP6_INC_STATS(net, UDP_MIB_INERRORS);
+	} else
+#endif
+	{
+		__UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
+		__UDP_INC_STATS(net, UDP_MIB_INERRORS);
+	}
+	sk_skb_reason_drop(udp_sk, skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
+}
+
 /*
  * handle data received on the local endpoint
  * - may be called in interrupt context
@@ -28,6 +64,8 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	struct sk_buff_head *rx_queue;
 	struct rxrpc_local *local = rcu_dereference_sk_user_data(udp_sk);
 	struct task_struct *io_thread;
+	unsigned int headroom;
+	unsigned int rcvbuf;
 
 	if (unlikely(!local)) {
 		kfree_skb(skb);
@@ -41,8 +79,6 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	if (skb->tstamp == 0)
 		skb->tstamp = ktime_get_real();
 
-	skb->mark = RXRPC_SKB_MARK_PACKET;
-	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	rx_queue = &local->rx_queue;
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
 	if (rxrpc_inject_rx_delay ||
@@ -52,6 +88,24 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	}
 #endif
 
+	rcvbuf = READ_ONCE(udp_sk->sk_rcvbuf);
+	headroom = SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2;
+	spin_lock(&udp_sk->sk_receive_queue.lock);
+	if ((unsigned int)atomic_read(&udp_sk->sk_rmem_alloc) +
+	    skb->truesize + headroom >= rcvbuf ||
+	    !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
+		spin_unlock(&udp_sk->sk_receive_queue.lock);
+		rxrpc_encap_rcv_drop(udp_sk, skb);
+		return 0;
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
@@ -471,6 +525,9 @@ int rxrpc_io_thread(void *data)
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
index 169f9dfdaa77f..2f93891e841ab 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -166,6 +166,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	struct udp_port_cfg udp_conf = {0};
 	struct task_struct *io_thread;
 	struct sock *usk;
+	u32 rcvbuf;
 	int ret;
 
 	_enter("%p{%d,%d}",
@@ -198,6 +199,12 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 
 	/* set the socket up */
 	usk = local->socket->sk;
+	/* One advertised ordinary-DATA window, not jumbo-max. */
+	rcvbuf = rxrpc_rx_window_size * SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2;
+	rcvbuf += rcvbuf / 4;
+	rcvbuf = clamp(rcvbuf, READ_ONCE(sysctl_rmem_default),
+		       READ_ONCE(sysctl_rmem_max));
+	WRITE_ONCE(usk->sk_rcvbuf, rcvbuf);
 	usk->sk_error_report = rxrpc_error_report;
 
 	switch (srx->transport.family) {
@@ -437,8 +444,8 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	if (socket) {
 		local->socket = NULL;
 		kernel_sock_shutdown(socket, SHUT_RDWR);
-		socket->sk->sk_user_data = NULL;
-		sock_release(socket);
+		rcu_assign_sk_user_data(socket->sk, NULL);
+		synchronize_rcu();
 	}
 
 	/* At this point, there should be no more packets coming in to the
@@ -448,6 +455,10 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
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

