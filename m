Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0A4D954D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775023; cv=none; b=aOnVO2i5SSeB6TmqqaqdI77ndCdRVtYtOfl45i2CqV4QtmA07YRqIfT1z4YbLZpzSAUPtHbtPH8U5WWXy8itWsyUl8yMr8VZOqpg2J9iQlg0iobcdQJO6qPsyzA/CVOSyaTBCgUOXd+4YsaHIpGAwTqa8O73V3AYff4jYKjZQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775023; c=relaxed/simple;
	bh=3c0aSQWF+XnDZu4ZhVm1iUcV7parx//Qr4XJaDO85vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IysXvQcC53IjoFJTut1UkCBwvd3yaC6QWe+R908WCZ/p7V3ZaGGNee3niLQW30iUTC8G2+lWRwMjvH0+ezEE18HjrNAdpxE9rcs3T9cx65OAmOIswZfyORXlrv1HvxDjxPhAs+j9SX3YB2IkIV6xA9EUvOIrrC1i2PdQyjwuObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Bb3AYd5g; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Bb3AYd5g"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so2293075a12.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790775005; x=1791379805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/BGr7qHoZTTc/P8U4m780akRMs0WL3llDH+1sNO9cM=;
        b=Bb3AYd5gqEQMVA8TkyZXiKOQ1WatM+UWzqwCOLnJef0+A/prs+zidUOZjOlIVtckNU
         pW6C6dZ7rjmnZTwqUg6XyRmzGQAev0wEzLBxfamp7oPqEocg1jVueC4dWzC766rxmyc8
         a4dCax/WhPpc8p87WSMF+gRFnnNMYrH4g+Wc+fTiA/4FSmidboz9FTRtP8VWXJhgh3Kq
         aedBtLLwxzMzZxiyJEnS8rxrACvClwreEsN0Gmhd6Ey7OxNnYUdK+TO2+Ms1eIZoYaGX
         XxPSojO1eVSG4trPPIOEjqo1g3Lp7KxdYh16hHoTNyPzoa4kDgzAl+tlVXc2hek7C9hU
         KzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775005; x=1791379805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d/BGr7qHoZTTc/P8U4m780akRMs0WL3llDH+1sNO9cM=;
        b=Y54X4g2ahwcr4VDqtJkLISAEpCjbPZybZ9yiLhWeIpVT6/FPiNS2hg72AdAYNUvSUa
         xuNFVQ3FREOId8+jLfv7e2SMl35t6mjkjbYE18cR9QlqXSECzaAxW5tRYoFhpfFzHkAh
         B7hCoeJOz/uuAoOHw1Qn7YLY2BszEHK8r3nKo7xff8eIVMgHe9M7bNv8Se4hBH08up/C
         AJWM24ze1d1Cfbcx1tGCvOecyRj0R+zBxhOqDeNsJv2W/jP2WolsiQaxnqyJRRdsUbV3
         ldNw5vAIQVWyB/shO2N7dXJXjH7emjK04dsYD/ZTIN8Xp4f9t8bmJC75lQ+TBzGs8E7x
         3ZpA==
X-Forwarded-Encrypted: i=1; AKwUvBwo6+RbdG92XckqFEbbJFLuAGUILUQ15+piRe+XXKoitSsQp+y6OM4o9ds21ctFwV4xLRAFgfo=@vger.kernel.org
X-Gm-Message-State: AFuF++lb+5oSBnNNRWcWgsBpCVbii/vsl33beIYssmFLBGDJek7lfPDQ
	ysOThXBnq39qp6s0vL48N2EBqD3JNXIIlDfsd4SAxfsaJSmbxjPwefoQgOq2AJrMvi5N
X-Gm-Gg: AYBFou2dIsKvi5x9I1MpSr7iL4/GRMgKXumtFgJUhbGE2NYdDskxw9WiDEPmBkDkBQA
	f5NUOVvTjxdQcCMNiD9Nnzf7Bcaj/JfcIT/Hhm2uPSIz8LqU8xyDGOkngk6wHazl8xnCB+3cz4o
	JYVCYZbpS5pOVNa7RzY4Ost85zTRm3P/lqxf3Fc0+r3Ffj+eg1Pn0sP1zE9lHeBmMMTSL3xcUrs
	Ga/X0L//dmcVXDltlWTTcnlmJRvT4ZZ7UtGbPHfaU7+kJHqyPApzPLnQD3P9K2N3koaUOv4OM5r
	GdWpjXSWuKz56QwOaFtM/rv3Yjay0hTxuRHTw9LsrQ+us+8CsCHtHORHGsbXSihD/cIaL07Oacm
	qHWq/UFdHGPUNERJLYBud7nwnnIMGxM4Jx+ekXhMsyKBqO2G1qMNeB7uvOPi1Vb5EXJ1/Ta35p5
	rlbIuA4iZ+b1vL9v96Yc+CL/NiOVzYApBokGIqkaSZ1u5rnwRvO8DyzSgC8ck/z3iuRtM+IZsiY
	tS9Fe/TRpVRAwzsur3PwU7iDoJ2oA==
X-Received: by 2002:a05:6a20:a107:b0:3da:b761:80c0 with SMTP id adf61e73a8af0-3de9e69d036mr1421110637.14.1790775005164;
        Wed, 30 Sep 2026 06:30:05 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7d9f1574esm913931a12.2.2026.09.30.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:30:04 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: zihanx@nebusec.ai,
	horms@kernel.org,
	kees@kernel.org,
	ernestas.k@iconn-networks.com,
	leitao@debian.org,
	tim.bird@sony.com,
	shuangpeng.kernel@gmail.com,
	luoxuanqiang@kylinos.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v13 1/2] llc: release unaccepted listener child sockets
Date: Wed, 30 Sep 2026 13:29:41 +0000
Message-ID: <1878b0954c763cf23bb99d7d09118eaae4588c45.1790688018.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790688018.git.zihanx@nebusec.ai>
References: <cover.1790688018.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track each passive-open child until it is accepted or released. Child
sockets created for listener traffic are released when setup fails or when
the connection indication is discarded before accept().

Keep socket, SAP, and netdevice references alive through asynchronous child
cleanup. Hold the receive device while packets wait in the listener backlog.
Drop receives for out-of-service children that remain visible to RCU
lookups during SAP removal.

Defer listener frame processing while the listener is owned by userspace.
Create children and update the accept backlog when the listener backlog is
drained, serializing those updates with accept().

Release an unaccepted child as soon as the connection state machine moves it
out of a data-accepting state, so a peer disconnect cannot keep an unusable
child in the listener accept queue.

Synchronously stop LLC timers before releasing SAP and device references.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

---
changes in v13:
  - Remove a queued connection indication when an unaccepted child is
    released, so DISC/OOS teardown cannot leave a stale accept entry.
  - Keep child, SAP, netdevice, timer, and listener references paired
    across accept, failure, close, and asynchronous cleanup.
  - v12 Link: https://lore.kernel.org/all/cover.1790255682.git.zihanx@nebusec.ai/
---
 include/net/llc_conn.h |  12 ++
 net/llc/af_llc.c       |  35 +++-
 net/llc/llc_conn.c     | 395 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 409 insertions(+), 33 deletions(-)

diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index e1a302696..778e5e6c0 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -6,12 +6,18 @@
  * 		 2001, 2002 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  */
 #include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <net/llc_if.h>
 #include <net/sock.h>
 #include <linux/llc.h>
 
 #define LLC_EVENT                1
 #define LLC_PACKET               2
+#define LLC_LISTENER_FRAME       3
+
+#define LLC_INCOMING_NONE        0
+#define LLC_INCOMING_PENDING     1
+#define LLC_INCOMING_QUEUED      2
 
 #define LLC2_P_TIME               2
 #define LLC2_ACK_TIME             1
@@ -72,6 +78,9 @@ struct llc_sock {
 					      received and caused sending FRMR.
 					      Used for resending FRMR */
 	u32		    cmsg_flags;
+	atomic_t	    incoming_state;
+	struct sock	    *incoming_listener;
+	struct work_struct incoming_work;
 	struct hlist_node   dev_hash_node;
 };
 
@@ -94,6 +103,9 @@ struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
 			  struct proto *prot, int kern);
 void llc_sk_stop_all_timers(struct sock *sk, bool sync);
 void llc_sk_free(struct sock *sk);
+void llc_release_incoming_sock(struct sock *sk);
+bool llc_accept_incoming_sock(struct sock *sk);
+void llc_release_incoming_children(struct sock *sk);
 
 void llc_sk_reset(struct sock *sk);
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b0447c33d..6a72a8a60 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -27,6 +27,7 @@
 #include <net/llc_sap.h>
 #include <net/llc_pdu.h>
 #include <net/llc_conn.h>
+#include <net/llc_c_st.h>
 #include <net/tcp_states.h>
 
 /* remember: uninitialized global data is zeroed because its in .bss */
@@ -194,6 +195,7 @@ static int llc_ui_create(struct net *net, struct socket *sock, int protocol,
  */
 static int llc_ui_release(struct socket *sock)
 {
+	struct llc_sap *sap = NULL;
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
 
@@ -206,19 +208,27 @@ static int llc_ui_release(struct socket *sock)
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
+	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
+	if (sk->sk_state == TCP_LISTEN)
+		sock_set_flag(sk, SOCK_DEAD);
 	if (!sock_flag(sk, SOCK_ZAPPED)) {
-		struct llc_sap *sap = llc->sap;
+		sap = llc->sap;
 
 		/* Hold this for release_sock(), so that llc_backlog_rcv()
 		 * could still use it.
 		 */
 		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
+		llc_release_incoming_children(sk);
 		release_sock(sk);
-		llc_sap_put(sap);
 	} else {
+		llc_release_incoming_children(sk);
 		release_sock(sk);
 	}
+	/* Keep timer callbacks from using the SAP or device after they are put. */
+	llc_sk_stop_all_timers(sk, true);
+	if (sap)
+		llc_sap_put(sap);
 	netdev_put(llc->dev, &llc->dev_tracker);
 	sock_put(sk);
 	sock_orphan(sk);
@@ -489,6 +499,9 @@ static int llc_ui_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		goto out;
 	if (unlikely(sk->sk_type != SOCK_STREAM))
 		goto out;
+	rc = -EINVAL;
+	if (unlikely(sk->sk_state == TCP_LISTEN))
+		goto out;
 	rc = -EALREADY;
 	if (unlikely(sock->state == SS_CONNECTING))
 		goto out;
@@ -718,10 +731,19 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 		llc_sk(sk)->laddr.lsap);
 	skb = skb_dequeue(&sk->sk_receive_queue);
 	rc = -EINVAL;
-	if (!skb->sk)
+	if (!skb || !skb->sk || skb->sk == sk)
 		goto frees;
-	rc = 0;
 	newsk = skb->sk;
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	if (!llc_accept_incoming_sock(newsk)) {
+		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+		    LLC_INCOMING_NONE)
+			llc_release_incoming_sock(newsk);
+		release_sock(newsk);
+		rc = -ECONNABORTED;
+		goto frees;
+	}
+	rc = 0;
 	/* attach connection to a new socket. */
 	llc_ui_sk_init(newsock, newsk);
 	sock_reset_flag(newsk, SOCK_ZAPPED);
@@ -734,11 +756,12 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 
 	/* put original socket back into a clean listen state. */
 	sk->sk_state = TCP_LISTEN;
-	sk_acceptq_removed(sk);
 	dprintk("%s: ok success on %02X, client on %02X\n", __func__,
 		llc_sk(sk)->addr.sllc_sap, newllc->daddr.lsap);
+	release_sock(newsk);
 frees:
-	kfree_skb(skb);
+	if (skb)
+		kfree_skb(skb);
 out:
 	release_sock(sk);
 	return rc;
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50..349a7c5b9 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void llc_incoming_sock_work(struct work_struct *work);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -69,6 +70,15 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		goto out_skb_put;
 	}
 
+	/*
+	 * An unaccepted child that leaves a data-accepting state cannot be
+	 * delivered by accept(). Release it before processing the indication.
+	 */
+	if (unlikely(atomic_read(&llc->incoming_state) ==
+		     LLC_INCOMING_QUEUED &&
+		     llc_data_accept_state(READ_ONCE(llc->state))))
+		llc_release_incoming_sock(skb->sk);
+
 	switch (ev->ind_prim) {
 	case LLC_DATA_PRIM:
 		skb_get(skb);
@@ -87,7 +97,18 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 * Can't be sock_queue_rcv_skb, because we have to leave the
 		 * skb->sk pointing to the newly created struct sock in
 		 * llc_conn_handler. -acme
+		 *
+		 * A connection indication belongs on the listener. If sk and
+		 * skb->sk are the same socket, queueing it would later make
+		 * accept() lock that socket against itself.
 		 */
+		if (sk == skb->sk ||
+		    atomic_read(&llc_sk(skb->sk)->incoming_state) !=
+		    LLC_INCOMING_PENDING)
+			break;
+		sock_hold(skb->sk);
+		atomic_set(&llc_sk(skb->sk)->incoming_state,
+			   LLC_INCOMING_QUEUED);
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
 		sk->sk_state_change(sk);
@@ -755,37 +776,257 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 					     struct llc_addr *saddr,
 					     struct llc_addr *daddr)
 {
-	struct sock *newsk = llc_sk_alloc(sock_net(sk), sk->sk_family, GFP_ATOMIC,
-					  sk->sk_prot, 0);
-	struct llc_sock *newllc, *llc = llc_sk(sk);
+	struct llc_sock *llc = llc_sk(sk);
+	struct llc_sock *newllc;
+	struct sock *newsk;
 
+	newsk = llc_sk_alloc(sock_net(sk), sk->sk_family, GFP_ATOMIC,
+			     sk->sk_prot, 0);
 	if (!newsk)
-		goto out;
+		return NULL;
+
 	newllc = llc_sk(newsk);
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
-	dev_hold(dev);
+	newllc->incoming_listener = sk;
+	atomic_set(&newllc->incoming_state, LLC_INCOMING_PENDING);
+	INIT_WORK(&newllc->incoming_work, llc_incoming_sock_work);
+	sock_hold(sk);
+	netdev_hold(dev, &newllc->dev_tracker, GFP_ATOMIC);
+	/* Lock the child before publishing it in the SAP hash. */
+	bh_lock_sock_nested(newsk);
 	llc_sap_add_socket(llc->sap, newsk);
-out:
+
 	return newsk;
 }
 
+static int llc_conn_rcv_listener(struct sock *sk, struct sk_buff *skb,
+			       struct llc_addr *saddr,
+			       struct llc_addr *daddr)
+{
+	struct sock *newsk;
+	int rc = 0;
+
+	local_bh_disable();
+	newsk = __llc_lookup_established(llc_sk(sk)->sap, saddr, daddr,
+					 dev_net(skb->dev));
+	if (newsk) {
+		sock_put(newsk);
+		goto drop;
+	}
+	if (sk_acceptq_is_full(sk))
+		goto drop;
+
+	newsk = llc_create_incoming_sock(sk, skb->dev, saddr, daddr);
+	if (!newsk)
+		goto drop;
+	sk_acceptq_added(sk);
+	if (!skb_set_owner_sk_safe(skb, newsk)) {
+		if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING)
+			llc_release_incoming_sock(newsk);
+		bh_unlock_sock(newsk);
+		goto drop;
+	}
+
+	rc = llc_conn_rcv(sk, skb);
+	if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+	    LLC_INCOMING_PENDING)
+		llc_release_incoming_sock(newsk);
+	bh_unlock_sock(newsk);
+	local_bh_enable();
+	return rc;
+
+drop:
+	kfree_skb(skb);
+	local_bh_enable();
+	return rc;
+}
+
+static void llc_incoming_sock_work(struct work_struct *work)
+{
+	struct net_device *dev;
+	struct sock *listener;
+	struct llc_sock *llc;
+	struct llc_sap *sap;
+	struct sock *sk;
+
+	llc = container_of(work, struct llc_sock, incoming_work);
+	sk = &llc->sk;
+	sap = llc->sap;
+	lock_sock(sk);
+	sock_orphan(sk);
+	release_sock(sk);
+	llc_sk_stop_all_timers(sk, true);
+	dev = llc->dev;
+	llc->dev = NULL;
+	listener = xchg(&llc->incoming_listener, NULL);
+	netdev_put(dev, &llc->dev_tracker);
+	llc_sk_free(sk);
+	llc_sap_put(sap);
+	if (listener) {
+		lock_sock(listener);
+		sk_acceptq_removed(listener);
+		release_sock(listener);
+		sock_put(listener);
+	}
+}
+
+static void llc_remove_incoming_skb(struct sock *sk)
+{
+	struct sk_buff *skb, *next;
+	struct sk_buff_head purge;
+	struct sock *listener;
+	unsigned long flags;
+
+	listener = READ_ONCE(llc_sk(sk)->incoming_listener);
+	if (!listener)
+		return;
+
+	__skb_queue_head_init(&purge);
+	spin_lock_irqsave(&listener->sk_receive_queue.lock, flags);
+	skb_queue_walk_safe(&listener->sk_receive_queue, skb, next) {
+		if (skb->sk != sk)
+			continue;
+		__skb_unlink(skb, &listener->sk_receive_queue);
+		__skb_queue_tail(&purge, skb);
+	}
+	spin_unlock_irqrestore(&listener->sk_receive_queue.lock, flags);
+	__skb_queue_purge(&purge);
+}
+
+void llc_release_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+	int incoming_state;
+
+	incoming_state = atomic_xchg(&llc->incoming_state,
+				     LLC_INCOMING_NONE);
+	if (incoming_state == LLC_INCOMING_NONE)
+		return;
+
+	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
+	if (incoming_state == LLC_INCOMING_QUEUED) {
+		llc_remove_incoming_skb(sk);
+		sock_put(sk);
+	}
+	llc_sap_hold(llc->sap);
+	llc_sap_remove_socket(llc->sap, sk);
+	schedule_work(&llc->incoming_work);
+}
+
+bool llc_accept_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+	struct sock *listener;
+
+	if (unlikely(llc_data_accept_state(READ_ONCE(llc->state)))) {
+		llc_release_incoming_sock(sk);
+		return false;
+	}
+
+	if (atomic_cmpxchg(&llc->incoming_state, LLC_INCOMING_QUEUED,
+			   LLC_INCOMING_NONE) != LLC_INCOMING_QUEUED)
+		return false;
+
+	listener = xchg(&llc->incoming_listener, NULL);
+	if (listener) {
+		sk_acceptq_removed(listener);
+		sock_put(listener);
+	}
+	sock_put(sk);
+	return true;
+}
+
+void llc_release_incoming_children(struct sock *sk)
+{
+	struct sk_buff *skb;
+	struct sock *child;
+
+	local_bh_disable();
+	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+		child = skb->sk;
+
+		if (child && child != sk) {
+			bh_lock_sock_nested(child);
+			if (atomic_read(&llc_sk(child)->incoming_state) !=
+			    LLC_INCOMING_NONE)
+				llc_release_incoming_sock(child);
+			bh_unlock_sock(child);
+		}
+		kfree_skb(skb);
+	}
+	local_bh_enable();
+}
+
 void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 {
+	struct net_device *backlog_dev = NULL;
+	struct sock *newsk = NULL, *sk;
+	bool newsk_lookup_ref = false;
 	struct llc_addr saddr, daddr;
-	struct sock *sk;
+	bool listener_frame = false;
+	bool newsk_locked = false;
 
 	llc_pdu_decode_sa(skb, saddr.mac);
 	llc_pdu_decode_ssap(skb, &saddr.lsap);
 	llc_pdu_decode_da(skb, daddr.mac);
 	llc_pdu_decode_dsap(skb, &daddr.lsap);
 
+lookup:
 	sk = __llc_lookup(sap, &saddr, &daddr, dev_net(skb->dev));
 	if (!sk)
 		goto drop;
 
+	if (atomic_read(&llc_sk(sk)->incoming_state) ==
+	    LLC_INCOMING_PENDING) {
+		newsk = sk;
+		bh_lock_sock(newsk);
+		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+		    LLC_INCOMING_PENDING) {
+			bh_unlock_sock(newsk);
+			sock_put(newsk);
+			newsk = NULL;
+			goto lookup;
+		}
+		sk = llc_sk(newsk)->incoming_listener;
+		sock_hold(sk);
+		newsk_lookup_ref = true;
+		bh_unlock_sock(newsk);
+	}
+
 	bh_lock_sock(sk);
+	if (!newsk_lookup_ref &&
+	    unlikely(READ_ONCE(llc_sk(sk)->state) == LLC_CONN_OUT_OF_SVC))
+		goto drop_unlock;
+	if (unlikely(sk->sk_state == TCP_LISTEN &&
+		     sock_flag(sk, SOCK_DEAD) &&
+		     !newsk_lookup_ref))
+		goto drop_unlock;
+	if (newsk_lookup_ref) {
+		bh_lock_sock_nested(newsk);
+		newsk_locked = true;
+		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+		    LLC_INCOMING_PENDING)
+			goto retry_unlock;
+		if (unlikely(sk->sk_state != TCP_LISTEN ||
+			     sock_flag(sk, SOCK_DEAD))) {
+			llc_release_incoming_sock(newsk);
+			goto drop_unlock;
+		}
+	}
+	/* SAP unhash is RCU; a torn-down socket may still be looked up. */
+	if (newsk &&
+	    READ_ONCE(llc_sk(newsk)->state) == LLC_CONN_OUT_OF_SVC) {
+		llc_release_incoming_sock(newsk);
+		goto drop_unlock;
+	}
+	/* Keep a queued indication accounted until accept() or close. */
+	if (!newsk &&
+	    atomic_read(&llc_sk(sk)->incoming_state) == LLC_INCOMING_QUEUED &&
+	    READ_ONCE(llc_sk(sk)->state) == LLC_CONN_OUT_OF_SVC)
+		goto drop_unlock;
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,11 +1036,22 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
+		if (!newsk) {
+			if (sock_owned_by_user(sk)) {
+				skb_orphan(skb);
+				llc_set_backlog_type(skb, LLC_LISTENER_FRAME);
+				listener_frame = true;
+				goto enqueue;
+			}
+			llc_conn_rcv_listener(sk, skb, &saddr, &daddr);
+			goto out;
+		}
+		if (!skb_set_owner_sk_safe(skb, newsk)) {
+			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
 			goto drop_unlock;
-		skb_set_owner_r(skb, newsk);
+		}
 	} else {
 		/*
 		 * Can't be skb_set_owner_r, this will be done at the
@@ -813,18 +1065,45 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
+enqueue:
+	if (!sock_owned_by_user(sk)) {
 		llc_conn_rcv(sk, skb);
-	else {
+		if (newsk &&
+		    atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING)
+			llc_release_incoming_sock(newsk);
+	} else {
 		dprintk("%s: adding to backlog...\n", __func__);
-		llc_set_backlog_type(skb, LLC_PACKET);
-		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
+		if (!listener_frame)
+			llc_set_backlog_type(skb, LLC_PACKET);
+		backlog_dev = skb->dev;
+		netdev_hold(backlog_dev, NULL, GFP_ATOMIC);
+		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {
+			netdev_put(backlog_dev, NULL);
+			if (newsk &&
+			    atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
 			goto drop_unlock;
+		}
 	}
 out:
+	if (newsk_locked)
+		bh_unlock_sock(newsk);
 	bh_unlock_sock(sk);
 	sock_put(sk);
+	if (newsk_lookup_ref)
+		sock_put(newsk);
 	return;
+retry_unlock:
+	bh_unlock_sock(newsk);
+	newsk_locked = false;
+	bh_unlock_sock(sk);
+	sock_put(sk);
+	sock_put(newsk);
+	newsk = NULL;
+	newsk_lookup_ref = false;
+	goto lookup;
 drop:
 	kfree_skb(skb);
 	return;
@@ -850,29 +1129,89 @@ static atomic_t llc_sock_nr;
  */
 static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
-	int rc = 0;
+	struct net_device *backlog_dev = NULL;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *child = skb->sk;
+	struct llc_addr saddr, daddr;
+	struct llc_sock *childllc;
+	bool child_locked = false;
+	int incoming_state;
+	int rc = 0;
 
-	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
-			rc = llc_conn_rcv(sk, skb);
-		else
-			goto out_kfree_skb;
+	if (llc_backlog_type(skb) == LLC_LISTENER_FRAME) {
+		backlog_dev = skb->dev;
+		if (unlikely(child || sk->sk_state != TCP_LISTEN ||
+			     sock_flag(sk, SOCK_DEAD)))
+			goto drop;
+		llc_pdu_decode_sa(skb, saddr.mac);
+		llc_pdu_decode_ssap(skb, &saddr.lsap);
+		llc_pdu_decode_da(skb, daddr.mac);
+		llc_pdu_decode_dsap(skb, &daddr.lsap);
+		rc = llc_conn_rcv_listener(sk, skb, &saddr, &daddr);
+		goto out;
+	} else if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
+		backlog_dev = skb->dev;
+		if (child && child != sk) {
+			local_bh_disable();
+			bh_lock_sock_nested(child);
+			child_locked = true;
+		}
+		if (child && child != sk) {
+			childllc = llc_sk(child);
+			incoming_state = atomic_read(&childllc->incoming_state);
+
+			if (incoming_state == LLC_INCOMING_PENDING) {
+				if (sock_flag(sk, SOCK_DEAD) ||
+				    sk->sk_state != TCP_LISTEN ||
+				    READ_ONCE(childllc->state) == LLC_CONN_OUT_OF_SVC) {
+					llc_release_incoming_sock(child);
+					goto drop;
+				}
+				rc = llc_conn_rcv(sk, skb);
+				if (atomic_read(&childllc->incoming_state) ==
+				    LLC_INCOMING_PENDING)
+					llc_release_incoming_sock(child);
+			} else if (incoming_state == LLC_INCOMING_QUEUED) {
+				/* Keep the indication accounted until accept() or close. */
+				if (READ_ONCE(childllc->state) == LLC_CONN_OUT_OF_SVC)
+					goto drop;
+				rc = llc_conn_rcv(child, skb);
+			} else {
+				goto drop;
+			}
+		} else {
+			if (likely(llc->state > 1)) /* not closed */
+				rc = llc_conn_rcv(sk, skb);
+			else
+				goto drop;
+		}
 	} else if (llc_backlog_type(skb) == LLC_EVENT) {
 		/* timer expiration event */
-		if (likely(llc->state > 1))  /* not closed */
+		if (likely(llc->state > 1)) /* not closed */
 			rc = llc_conn_state_process(sk, skb);
 		else
-			goto out_kfree_skb;
+			goto drop;
 	} else {
 		printk(KERN_ERR "%s: invalid skb in backlog\n", __func__);
-		goto out_kfree_skb;
+		goto drop;
 	}
 out:
+	if (child_locked) {
+		bh_unlock_sock(child);
+		local_bh_enable();
+	}
+	if (backlog_dev)
+		netdev_put(backlog_dev, NULL);
 	return rc;
-out_kfree_skb:
+drop:
+	if (child_locked) {
+		bh_unlock_sock(child);
+		local_bh_enable();
+	}
 	kfree_skb(skb);
-	goto out;
+	if (backlog_dev)
+		netdev_put(backlog_dev, NULL);
+	return rc;
 }
 
 /**
@@ -905,6 +1244,8 @@ static void llc_sk_init(struct sock *sk)
 	llc->k  = 2;   /* tx win size, will adjust dynam */
 	llc->rw = 128; /* rx win size (opt and equal to
 			* tx_win of remote LLC) */
+	atomic_set(&llc->incoming_state, LLC_INCOMING_NONE);
+	llc->incoming_listener = NULL;
 	skb_queue_head_init(&llc->pdu_unack_q);
 	sk->sk_backlog_rcv = llc_backlog_rcv;
 }
@@ -967,7 +1308,7 @@ void llc_sk_free(struct sock *sk)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
-	llc->state = LLC_CONN_OUT_OF_SVC;
+	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
 	/* Stop all (possibly) running timers */
 	llc_sk_stop_all_timers(sk, true);
 #ifdef DEBUG_LLC_CONN_ALLOC
-- 
2.43.0

