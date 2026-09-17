Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67E4AEBD6
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639539; cv=none; b=DYRZsbRRx4EHwtpcljjajyZgGb5eGAGywlMpgE+SEc6WhxU/A/5AEXAOA2k1aVhejA/7OVVA9eoKXOdyzsepMWFJ+paMO9s+adkj5un929YwpvACXAgIVbrwmB2fimyy5Hu1uTcg9YPPGUzOtbh1oAVONP6wZYxQqhFSuw+1B+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639539; c=relaxed/simple;
	bh=/ZcoGQU7+HpSLRmFfBGWL0azsSfivXUGNCssuK3UNyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsZgjeEZpxjgzxcnnImrS8mjCJsj3yAqauUjvWIauTjMCwb6Lir9aQZcuaKd8n1xy+i8iAngCU+uwbhyVEv+tZYeQ/9n+2XWiXqbLW7Xx1KIDtGoaJvmKEy9+b/YbEtTUNbFXb77REhmYEdW9VCrUiyAm4HbY3sqNsLmRlgKXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=iF0sJQ6l; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="iF0sJQ6l"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398cb5615deso631947a91.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789639532; x=1790244332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/4WSHuLHoAStKDHNH/RtkvNpdrgiXRCApKgg1BxoNE=;
        b=iF0sJQ6leoPaWGdLghiLpHAyvGIcPGwvlESAHJ/LCseEe2ke3L3fnpg34xxig8SgAz
         5fBso/JdXmiWqJFPBrn1deh4H7Kk13P45HuhqvipD8MHdF0apOVtOJs+n+3q1QsOxMSr
         MGASUS3AE1klrpbBI3ewLwHxxCUikFt8mRtmeqvQ1IFbbVTBtK/GXc6FtK9lS7UMszGV
         5aPh9NncgxuToPmKl6UqrbbEWbtstCWrZowzrsjRShJmTXWBhUUSwVwZyeCS1/fKx0WR
         Qc1vq2IGwx4fYFRWZw9/2dGhyfiGSSDPPKai7Tu42IvZ+ZeE3hyyvyQRRvctVGKdG0Kj
         lwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789639532; x=1790244332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E/4WSHuLHoAStKDHNH/RtkvNpdrgiXRCApKgg1BxoNE=;
        b=WyVBkp4nYvu2bnaPLIRY3Ti9a5oQ4PAiJhFcUH7dAYLVwb93hDTj8QfDXC03grcHsu
         mEL0NDq5WSdEZuQzGTl2HsnBk8My2KNrwHEuAprOrWZ15brgiy86db3zVoVW3yomQVlb
         NNu55oE4Q2uYFUkQL14dFhsrGdoyHz/7CP4VErs7z7R8BG0JNS93+mMMYVFEqxiPsh9E
         Q1g9FKOYjfTHxzm5FbY1eM+LeJCZtJmHZMIJ3uX575/xK3vjTPbiyDZMd+oBWabHZTdY
         0koUHVrB/pGMujb7gXMOE5M5FZbTf4erVmLv9LJobZ56lzcrhmvpmsfdZBLcpMhhFjFt
         uFqA==
X-Forwarded-Encrypted: i=1; AKwUvBxElxGL0aMAYAa5W0qvfuFttIOldH23hFXTpBm6tbBEGSzslixMC4az5wBNBboolSN53TSOpIY=@vger.kernel.org
X-Gm-Message-State: AFuF++ms9ecopDlgTv29Xfd+a070KziGi6cRhc5b4Iw4d5ScGKzuMGAT
	OgqpKHohhCbmW3S/AIbzCLF+PCQhYjaEnD5POqL1IvzRtKiBOI7lDz5ZC+G94UBL7pNO
X-Gm-Gg: AYBFou24ZvcrD5aanOZw6uom7sIrYTIOu+xmboInLBpnCFSANbANIdVHNg6Z8CNhbW+
	8/7rzUrO1EkoV7t8w2b5y6Tpp1ZnnLZuazbjBESdJehjFZIxkzH2eI6Imb6r8iNDTwjCNwc4dFf
	pY5QsvsQSenoLzhIIkmtoImKIikwJ+ebJTpeS5DEkxScURceNDiTy9tq8ytQXE+VM+fJX72Aymh
	OCEjwD44/toCjfbQQLzXmPlpoQkOzDlVQ6eqgLrBBOTc6YwOgjHCfsmbNVbrhfLzscApQXTvtpU
	CX0ozo2X6xl0fe4JteOoEs9yhcryDqmo+XwbXzBDXy3sQC/ID1BYbf6dwZ196pOj8YJq6iCLEKS
	jDwa3swW7JoObCcsOyYtj53X4MA0J7JYQCJkqqRVh0DDjZvqHYyviLwgN6FE7HMoMjffr0HOSWA
	HmBVma168byb9JVeQgAJPA5e6HLQ5N9dCn2JbKWMJcN6HNCYsKzCN8qiEVrn8TDvLZWbGNC+MbS
	mAdfDjN1FMILxhwFsE0rw6aZp6K5l3XA51WvhPl
X-Received: by 2002:a17:90b:2f47:b0:39e:2f57:67c7 with SMTP id 98e67ed59e1d1-39e2f5848damr9551873a91.3.1789639531771;
        Thu, 17 Sep 2026 03:05:31 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e390c2984sm1019445a91.0.2026.09.17.03.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 03:05:30 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zihanx@nebusec.ai,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v6 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Thu, 17 Sep 2026 10:05:09 +0000
Message-ID: <fd9449f2d394828609e81f6178608ea91344bbfd.1789608558.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789608557.git.zihanx@nebusec.ai>
References: <cover.1789608557.git.zihanx@nebusec.ai>
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

