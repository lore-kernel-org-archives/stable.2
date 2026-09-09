Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DCD44C662
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939912; cv=none; b=ilFXqE8O/zMmKovutTBerxZCLtiLvbuBBYTJyLwunCFtukkBIX84RaYV8ktEyyNsQAYvCtk8SUqxeJr8psC8ElHRgeaP0sRQwlWuSrwGSTR2QMyMFZvFu8wovM3RK4KYurJdlVbRRjoHMlWyGTpOXS7GsSVHttiajJ44nykKLWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939912; c=relaxed/simple;
	bh=yVEP+3GkL35VJVuIwqYuEO5WEVHZjx04XefECuT04t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdLIcGC4nyEMmGycLIT1+W/IluVJpR9gKCaC3GzYidWc5rFc1Y5gT6V8C7aYb28oS5fjuHVrEAsNRyADP8WEvDXHVs7V5azpPh8NX+lCIQqEoCjX5DHgrjFLIyTXLi1Epg/tnM1XR1NEYypAdTNu378mfZT7pFe1FtuGQgcpT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=n52nl+S4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="n52nl+S4"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso6841464a91.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788939910; x=1789544710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cfle/33DhJaHpZirsUEVX2vPd7lYd6/QJCyoGwAPahM=;
        b=n52nl+S4eezyxYiG2vQVGL9l956i066STyEAQ3t8Fyc8oAulIpfhTVUUEoWAi+Ef+f
         tNsa9zxkNC6yT3sYb8IvGsB0tRnuwE3J26acPQFQmkvJNxHQiKzRGW+ruM5hnZb+wu31
         foYgi08MTh+xmbSJXolHmtnZxRAXaKIo2L3myc3Cu3bQmUStGOdEOTfeoo81eV+wYgGE
         qwc1/lfAIoIkh8pj3bRDcqpLEAtRr3KGRI/OTxKzyKM2xgVaGbEEEv2UnN35YcdA8uqU
         UcSZvgG/xi27Li+Ly0Ll/ohZpMRWSHNlz6ww2DaVxocvmLZ1kMBnNMEMNGAyrWYyzIU5
         xa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939910; x=1789544710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cfle/33DhJaHpZirsUEVX2vPd7lYd6/QJCyoGwAPahM=;
        b=tOe3JWdzhPi6WT3u1kFylvOQeMWn4+AFqY42ULHW6cHVEEGhKjTN+M10IYtyuEe32I
         /LZvoOpSosEUwLPmU6V0zkrvvOaHdCjfbUS7qu+GAGnyG/TefCnlamDNweEkYjIudrI2
         xeX9i/+3hS4K37z/BWB8xxMURxQtYB8/Edi4tiahkc61HdDJAxNHWHmrkEsgykL0u0U2
         acy3fCJ9XGssgb2OlnnoRErTgOLvcJ7Fk8x1R53U/39DKRk5GlaqqRrQOyXywuMDnHfg
         T2hmEKeqgwr8x8bxcQghzNuPbDdcXsWC2UVhhX97S4hDGhgpjJjFV0811WAw4dhSyF3v
         vJXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw758u7YBRrJ1jGTMuiktCj67WoueoyCrs18FkRtznp02E1COxiD7S/mB4g1h+PAEpJzJ68YWY=@vger.kernel.org
X-Gm-Message-State: AFuF++l1Lg629q+/f4qwUiSK5v1xIwFQbfiRobQjOZPugkRh58fV7G04
	Ma8dRfJAau7KsQpWixyuZyNdQHxycBShhjxnPH5dnN0HLtibpM2hqktZDbSkK3eHGnWc
X-Gm-Gg: AYBFou2TaSZimBLt7DKP32/zOUOVho17nOwn/WxJBKS5XQ6LOUyILaS9CW1RKzlAybs
	qf5IyaEBLwzqVbEzZPmz1RNxdj2RlfamNzKVrxG6aosJko9tcB578/g9f58LP0e/Z3Lugmwojcs
	JuxrN+/VeYEeuMNGQmtX6MOEd3QYTuZAnmY+wMvV3cBWpKrCY4Xb9uJ1UhYBno14mIwXDXofUsM
	x3HspCye+4CX8k92l4P8cUNgmZZhtWf2RrIV6O06vGUzuggSsptzRGc3wkXAZOQwiBsHDKdGpxe
	7a0rzVGoLc78IEpfsRBgAEOB69G+aroUPN/BptUdQgMcmcJbGr+zusZeAlHGBxbLq+zEwqN46er
	gLWQYQTQ31rCHKHJNcT1YBCsMRpgu+/cc8t56NjBSWBweK9yQ9GIJ55CBawS88tDBcKMplK9bFS
	6MfeGLdhDWJBl9E12G5y/Pp2z3su+pAG8EOhjIgkE5uFbUfgqdk6F0YxZnoStE+jvqBlui0WTt2
	hfPZuJZE284n6ib76gh83uX4mwwdg==
X-Received: by 2002:a17:90a:d610:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39b2613259fmr49954285a91.7.1788939910014;
        Wed, 09 Sep 2026 00:45:10 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm36300085a91.0.2026.09.09.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:45:09 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	linux-afs@lists.infradead.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v4 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Wed,  9 Sep 2026 07:44:58 +0000
Message-ID: <ca1d010bc963319d4167b8e985b5afac5912f6da.1788878590.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788878590.git.zihanx@nebusec.ai>
References: <cover.1788878590.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_encap_rcv() moves encapsulated UDP packets onto the local
RxRPC queue without preserving UDP receive-buffer accounting. A local
AF_RXRPC service such as the AFS callback listener can therefore be
flooded with RxRPC-shaped UDP packets until the local queue grows
without bound and consumes large amounts of memory.

Reaccount encapsulated packets against the UDP socket before queueing
them on the RxRPC local queue and drop packets once the socket rcvbuf
limit is reached. Orphan PACKET skbs when the I/O thread dequeues
them so UDP ownership does not follow those packets onto call or
connection queues. Error-queue skbs keep their existing destructor.
Clear sk_user_data under RCU protection and release the socket only
after the local queues are purged.

sk_forward_alloc is not atomic. UDP already serialises it with
sk->sk_receive_queue.lock; take that lock around the charge in
rxrpc_encap_rcv() and around skb_orphan() in the I/O thread. The I/O
thread uses spin_lock_bh() so a concurrent BH encap_rcv() cannot
update the same counter. The skbs stay on the RxRPC local queue, not
the UDP receive queue.

Fixes: 446b3e14525b ("rxrpc: Move packet reception processing into I/O thread")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v4:
  - serialise UDP rmem charge/uncharge with sk->sk_receive_queue.lock
  - use spin_lock() in encap_rcv() (BH) and spin_lock_bh() around
    skb_orphan() in the I/O thread
  - do not enqueue encapsulated skbs on the UDP receive queue
  - orphan only PACKET skbs charged in encap_rcv(); leave error-queue
    skb ownership alone
  - restore the unshare -Urn reproducer and document the AFS callback
    listener
  - add the privileged pin/FIFO hog commands used to record the panic
  - clarify the recorded panic is a downstream OOM after
    privileged pin/FIFO hog, not the unshare-only flood
  - include the full OOM Mem-Info in the cover crash log
  - v3 Link: https://lore.kernel.org/all/cover.1788539302.git.zihanx@nebusec.ai/
changes in v3:
  - orphan the skb when the I/O thread dequeues it from the local
    queue so UDP rmem ownership does not follow packets onto
    call/conn queues
  - mention both io_thread.c and local_object.c in the cover opening
  - do not describe the recorded panic as a complete non-root-only
    reproducer; the flood is unprivileged but I/O-thread starvation
    used privileged steps
  - attribute the OOM to skbuff growth rather than incoming-call
    setup
  - describe the recorded panic as a downstream OOM in
    rxrpc_reject_packet()/sock_alloc_send_pskb after I/O-thread
    contention, not as an allocation at the encap_rcv enqueue site
  - note that cgroup.freeze does not stop krxrpcio; the crash still
    shows that kthread allocating, and the CPU pin plus SCHED_FIFO
    hog are the steps that slowed it
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
  - document the actual local flood command instead of a generic
    unshare invocation
  - v1 Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebusec.ai/

 net/rxrpc/io_thread.c    | 37 +++++++++++++++++++++++++++++++++++--
 net/rxrpc/local_object.c |  8 ++++++--
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index dc5184a2fa9d1..415b05f5e2b47 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -13,6 +13,22 @@ static int rxrpc_input_packet_on_conn(struct rxrpc_connection *conn,
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
 /*
  * handle data received on the local endpoint
  * - may be called in interrupt context
@@ -41,8 +57,6 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	if (skb->tstamp == 0)
 		skb->tstamp = ktime_get_real();
 
-	skb->mark = RXRPC_SKB_MARK_PACKET;
-	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	rx_queue = &local->rx_queue;
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
 	if (rxrpc_inject_rx_delay ||
@@ -52,6 +66,22 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	}
 #endif
 
+	spin_lock(&udp_sk->sk_receive_queue.lock);
+	if (atomic_read(&udp_sk->sk_rmem_alloc) >= READ_ONCE(udp_sk->sk_rcvbuf) ||
+	    !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
+		spin_unlock(&udp_sk->sk_receive_queue.lock);
+		sk_drops_inc(udp_sk);
+		kfree_skb(skb);
+		return 0;
+	}
+
+	skb->dev = NULL;
+	skb_set_owner_r(skb, udp_sk);
+	spin_unlock(&udp_sk->sk_receive_queue.lock);
+	skb_dst_force(skb);
+
+	skb->mark = RXRPC_SKB_MARK_PACKET;
+	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	skb_queue_tail(rx_queue, skb);
 	wake_up_process(io_thread);
 	return 0;
@@ -471,6 +501,9 @@ int rxrpc_io_thread(void *data)
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
index 169f9dfdaa77f..6604f9f952660 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -437,8 +437,8 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	if (socket) {
 		local->socket = NULL;
 		kernel_sock_shutdown(socket, SHUT_RDWR);
-		socket->sk->sk_user_data = NULL;
-		sock_release(socket);
+		rcu_assign_sk_user_data(socket->sk, NULL);
+		synchronize_rcu();
 	}
 
 	/* At this point, there should be no more packets coming in to the
@@ -448,6 +448,10 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
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

