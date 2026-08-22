Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207DD3B0AE4
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787387062; cv=none; b=tsFMjCvG8vsV/FRrg41faQ+UHzBS0ElbfOD7wxA2W1DKgB73h/qs5jNrEtJAdH0+pSdI1aO+6KoW3MvNDCcnCAm3IDmt3RioH5wth1TCSHHtoYIAH2Ja7awQNqUAWXyIrdtFBdmfXa1HN/JJwzfKG6thXIU+cFA1SrmFIIwzidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787387062; c=relaxed/simple;
	bh=66bwsqGoZY2SW/jphzhvgZ+avvq/szUuUy5MGb8bDGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY4YV4Un0QLpuj55goBrZdnOvSISyua+oY2lz3eCetbkz5NmQuvM/v1af0m1ehAJ2FSgl6TIrHvoSZC6MVtl3XigyHJNYEItdGXMXeGyAiW0AjtM4Y/yZsHJwNKvhEwIgr3lTo/bLpuYg8pPNS7Bs7W78+FZ6svajEM+xOXruuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=D06606po; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="D06606po"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ced3386430so17805715ad.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787387053; x=1787991853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLqEBnU4ANxhLP1M4XaWVcjKHOYNHVFJO+h7KFQ53Lk=;
        b=D06606poXCp/OlTEcvtmU6rzUjr8a0DB5iCXei0JmiCUkcz5gpoiB4HundMDLJw7Qi
         s5voWlJmp70nGBr8R5Uu/Bpq6+1NQM0nONl8Ge9Pqe0ct0itXoSEa5uBe6ii8iDcRQrq
         PlKhAVK8XSj7y9S5ohCD2vrNTe0VCfFwuMdYA5wj+rV+2mwbthvKmOyIXTGM7qiBfBm8
         xXmb4jDWs3xcKo7VIHFjFMf4DwvaRc/XGeMH75NO6lDKWouHymQTRqpKUyOdPt7Q+CGy
         zFvBei9RjqWqO0StIm2do42G76kETJtOmYLJxZBxZIaTe2jWVGenZvtt8H53GYwRt1Lk
         cMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787387053; x=1787991853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLqEBnU4ANxhLP1M4XaWVcjKHOYNHVFJO+h7KFQ53Lk=;
        b=Y/gI+xGhYOMTiC0lvvT72zL/iLnQAbp92Mu0Z1hxL7nxw6VGUzRr8QGuvr14KcX2nB
         vIDvon9pTyQntffRopRMQK6u0opcANNBVeb/Rc34M7gaokiVugiL2hj0FXuwD8bouxmU
         31O1gz9hI83En6ZNCFbxSrNlQD9mQYjKvUJkZHLUSIkvwM7Qr5cDy3pO5ydQNoOLrC5+
         3hJKgLji6yYo40YfNNpcrQOcBk6jQG/4ldOw5y5cv0cbq6uO6q2IPuzewRNZwqpI/XVe
         NCjjql9cW4sXusWYppLm+OsN/YFfCvP6FBy3n3eYFMdnsXijsM9MotGCxvD04mGfCdu/
         JfbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGxr0ib7AhD0CO9CZA1HsHvnmv8mUF201LJScdEEfl35qY+2/iMLrk45gHojNAXxJSLipKZt0=@vger.kernel.org
X-Gm-Message-State: AFuF++l4ck6lCNYFZETKlNxZ+Xf+Ma6EY2lftDTHz8U7KjZWk6Y4xue2
	z6LHUe31U4qLudpiQJ62tZr+EbGdLbBUZLj29xmIqPr5o2PxNvLAj4eVGneeLpmDrwuF
X-Gm-Gg: AR+sD122OBU/wxWrtGMko9GQWx8eZbtDfUPJMoeYGl6OQD3adLwq5CMwYiImoGB0u80
	wElqbc1D0/4++UrLg7Pq6yGCqJI9kGBXwkzzpXvXQq7UBL8qvPzJ9PG+xVLPfrVbvboyAPEuBRf
	Fi864rBIQgojDqDZk0s3ni4lg9FSK3FqfOYTfR9eo+RgwAoOMMIiSQcfFiPjrVK6TvJTG0WyOXn
	Gr/gAXpesQCIg3qNabbLSVBwsjha7XtLe02Gy3Y01JBlVK+lFXDIx8GzIrwXBV9D8eikovBoeeA
	y/q11RdIrAX/RtpxtldNOazEQaHdmbVOUJfKWgbIwxm2BVLSEA6H7k8Wf2MOP6ChK/r47DYy4N2
	csPxzy4l7EINn0IukJIOTY1n+JH3uvBmTOWeSgbqdS8zMMhWIkkkpjQbD10nVilKNpUjLfoMTW+
	48ODa7waXdcvotgKkjhM3crgEXh8bcIEMnWdgTFOk7vd88CapeUX28Upu9rzxzpWnADz3/fTVwt
	o8ggUNxlkD8VUU=
X-Received: by 2002:a17:902:d48a:b0:2ca:6d87:cda0 with SMTP id d9443c01a7336-2d64af8a933mr214082995ad.6.1787387052816;
        Sat, 22 Aug 2026 01:24:12 -0700 (PDT)
Received: from gmail.com ([115.192.250.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768f1379sm2647875ad.82.2026.08.22.01.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:24:12 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v5 1/2] llc: fix listener child socket leaks before passive open completes
Date: Sat, 22 Aug 2026 08:23:53 +0000
Message-ID: <20260822082354.3109-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260822082354.3109-1-zihanx@nebusec.ai>
References: <20260822082354.3109-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_handler() creates and publishes a child whenever a listener
matches a packet. A non-SABME frame never completes the passive open, so
the child remains in the SAP tables, keeps its device reference, and
cannot be returned by accept().

Create children only for SABME commands. Handle the listener's required
DM replies directly, using the packet source address, and do not run the
listener through the connection state machine.

Keep SABME children in the SAP tables during the passive open so that
established lookup continues to select them. Track children until the
connection indication is queued for accept(), and release any child that
fails before then, including direct and backlog failures and listener
close. Reject redirected packets after the listener leaves TCP_LISTEN.

The child socket lock is acquired with bottom halves disabled whenever
the cleanup or backlog path runs in process context.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---

Notes (llc-reroll-v5):
    changes in v5:
      - Make listener child cleanup unconditional so queued children are also
        released if the socket leaves TCP_LISTEN before close.
      - Serialize process-context child cleanup and backlog dispatch with bottom
        halves disabled, avoiding child-lock acquisition races with LLC receive
        and timer paths.
      - Drop packets redirected through a pending child after its listener is no
        longer listening, and release children left out of service instead of
        dispatching them.
      - Split the LLC_CONN_OUT_OF_SVC lower-bound check into a separate patch.
      - v4 Link: https://lore.kernel.org/all/20260814185843.4748-1-zihanx@nebusec.ai/
    changes in v4:
      - Create a passive-open child only for SABME and generate listener-side DM
        replies directly for non-SABME commands.
      - Use an atomic incoming-child lifecycle and serialize pending-child lookup,
        backlog processing, rollback, and listener close with the child lock.
      - Keep immediate SAP publication for passive-open tuple matching, but release
        unaccepted children on direct and backlog failures and on listener close.
      - Defer final incoming-child cleanup to workqueue context so timer
        synchronization does not run in the receive softirq path.
      - Add an LLC state lower-bound check before state-table dispatch.
      - v3 Link: https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/
    changes in v3:
      - Drop the unused llc_conn_handler() local rc variable reported in review.
      - Rebase the numbered patch and cover onto commit
        ede76849012e45ffb2193ad110b42027eec02c5c.
      - v2 Link: https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
    changes in v2:
      - Rework the fix to preserve the existing passive-open tuple matching
        semantics instead of deferring child publication until LLC_CONN_PRIM.
      - Track listener-created children pending publication to accept(), and roll
        them back on every earlier failure or drop path.
      - Cover the original non-SABME leak and SABME paths which fail before
        LLC_CONN_PRIM, including backlog enqueue and backlog drop failures.
      - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the earliest
        locally visible root-cause fact.
      - Clarify panic_on_oom crash evidence and packetdrill selection.
      - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

 include/net/llc_conn.h |  13 +-
 net/llc/af_llc.c       |   9 +-
 net/llc/llc_conn.c     | 263 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 269 insertions(+), 16 deletions(-)

diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index e1a302696723..9acda0a6f069 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -6,6 +6,7 @@
  * 		 2001, 2002 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  */
 #include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <net/llc_if.h>
 #include <net/sock.h>
 #include <linux/llc.h>
@@ -13,6 +14,10 @@
 #define LLC_EVENT                1
 #define LLC_PACKET               2
 
+#define LLC_INCOMING_NONE        0
+#define LLC_INCOMING_PENDING     1
+#define LLC_INCOMING_QUEUED      2
+
 #define LLC2_P_TIME               2
 #define LLC2_ACK_TIME             1
 #define LLC2_REJ_TIME             3
@@ -72,6 +77,9 @@ struct llc_sock {
 					      received and caused sending FRMR.
 					      Used for resending FRMR */
 	u32		    cmsg_flags;
+	atomic_t	    incoming_state;
+	struct sock	    *incoming_listener;
+	struct work_struct incoming_work;
 	struct hlist_node   dev_hash_node;
 };
 
@@ -93,7 +101,10 @@ static __inline__ char llc_backlog_type(struct sk_buff *skb)
 struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
 			  struct proto *prot, int kern);
 void llc_sk_stop_all_timers(struct sock *sk, bool sync);
-void llc_sk_free(struct sock *sk);
+void llc_sk_free(struct sock *sk, bool sync);
+void llc_release_incoming_sock(struct sock *sk);
+void llc_accept_incoming_sock(struct sock *sk);
+void llc_release_incoming_children(struct sock *sk);
 
 void llc_sk_reset(struct sock *sk);
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b0447c33dbf0..7d246d4d281b 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -196,6 +196,7 @@ static int llc_ui_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
+	bool listener;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -206,6 +207,9 @@ static int llc_ui_release(struct socket *sock)
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
+	listener = sk->sk_state == TCP_LISTEN;
+	if (listener)
+		sock_set_flag(sk, SOCK_DEAD);
 	if (!sock_flag(sk, SOCK_ZAPPED)) {
 		struct llc_sap *sap = llc->sap;
 
@@ -214,16 +218,18 @@ static int llc_ui_release(struct socket *sock)
 		 */
 		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
+		llc_release_incoming_children(sk);
 		release_sock(sk);
 		llc_sap_put(sap);
 	} else {
+		llc_release_incoming_children(sk);
 		release_sock(sk);
 	}
 	netdev_put(llc->dev, &llc->dev_tracker);
 	sock_put(sk);
 	sock_orphan(sk);
 	sock->sk = NULL;
-	llc_sk_free(sk);
+	llc_sk_free(sk, true);
 out:
 	return 0;
 }
@@ -722,6 +728,7 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 		goto frees;
 	rc = 0;
 	newsk = skb->sk;
+	llc_accept_incoming_sock(newsk);
 	/* attach connection to a new socket. */
 	llc_ui_sk_init(newsock, newsk);
 	sock_reset_flag(newsk, SOCK_ZAPPED);
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54..8120ecd46ace 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void llc_incoming_sock_work(struct work_struct *work);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -88,6 +89,11 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 * skb->sk pointing to the newly created struct sock in
 		 * llc_conn_handler. -acme
 		 */
+		if (sk != skb->sk &&
+		    atomic_read(&llc_sk(skb->sk)->incoming_state) ==
+		    LLC_INCOMING_PENDING)
+			atomic_set(&llc_sk(skb->sk)->incoming_state,
+				   LLC_INCOMING_QUEUED);
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
 		sk->sk_state_change(sk);
@@ -765,27 +771,153 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
+	newllc->incoming_listener = sk;
+	atomic_set(&newllc->incoming_state, LLC_INCOMING_PENDING);
+	INIT_WORK(&newllc->incoming_work, llc_incoming_sock_work);
+	sock_hold(sk);
 	dev_hold(dev);
 	llc_sap_add_socket(llc->sap, newsk);
 out:
 	return newsk;
 }
 
+static void llc_incoming_sock_work(struct work_struct *work)
+{
+	struct llc_sock *llc = container_of(work, struct llc_sock,
+						    incoming_work);
+	struct sock *sk = &llc->sk;
+	struct sock *listener = llc->incoming_listener;
+
+	lock_sock(listener);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+	llc_sk_free(sk, false);
+	sock_orphan(sk);
+	release_sock(sk);
+	llc_sk_stop_all_timers(sk, true);
+	release_sock(listener);
+	dev_put(llc->dev);
+	llc->dev = NULL;
+	sock_put(sk);
+	sock_put(listener);
+}
+
+void llc_release_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (atomic_xchg(&llc->incoming_state, LLC_INCOMING_NONE) ==
+	    LLC_INCOMING_NONE)
+		return;
+
+	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
+	sock_hold(sk);
+	llc_sap_remove_socket(llc->sap, sk);
+	schedule_work(&llc->incoming_work);
+}
+
+void llc_accept_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (atomic_xchg(&llc->incoming_state, LLC_INCOMING_NONE) !=
+	    LLC_INCOMING_NONE)
+		sock_put(llc->incoming_listener);
+}
+
+void llc_release_incoming_children(struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+		struct sock *newsk = skb->sk;
+
+		if (newsk && newsk != sk) {
+			bh_lock_sock_nested(newsk);
+			if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+			    LLC_INCOMING_NONE)
+				llc_release_incoming_sock(newsk);
+			bh_unlock_sock(newsk);
+		}
+		kfree_skb(skb);
+	}
+	local_bh_enable();
+}
+
+/*
+ * This mirrors the ADM-state DM actions, but a listener has no peer
+ * address in llc->daddr yet.
+ */
+static void llc_conn_send_dm_rsp(struct llc_sap *sap, struct sk_buff *skb,
+				 struct llc_addr *saddr, u8 f_bit)
+{
+	struct sk_buff *nskb;
+	int rc;
+
+	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, 0);
+	if (!nskb)
+		return;
+
+	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
+			    saddr->lsap, LLC_PDU_RSP);
+	llc_pdu_init_as_dm_rsp(nskb, f_bit);
+	rc = llc_mac_hdr_init(nskb, skb->dev->dev_addr, saddr->mac);
+	if (unlikely(rc))
+		kfree_skb(nskb);
+	else
+		dev_queue_xmit(nskb);
+}
+
 void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_addr saddr, daddr;
-	struct sock *sk;
+	struct sock *sk, *newsk = NULL;
+	bool newsk_lookup_ref = false;
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
+	if (unlikely(sk->sk_state == TCP_LISTEN &&
+		     sock_flag(sk, SOCK_DEAD)))
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
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,10 +927,25 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
-			goto drop_unlock;
+		if (!newsk) {
+			if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+				if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
+					u8 f_bit;
+
+					llc_pdu_decode_pf_bit(skb, &f_bit);
+					llc_conn_send_dm_rsp(sap, skb, &saddr, f_bit);
+				} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk, skb)) {
+					llc_conn_send_dm_rsp(sap, skb, &saddr, 1);
+				}
+				goto drop_unlock;
+			}
+			newsk = llc_create_incoming_sock(sk, skb->dev, &saddr,
+							 &daddr);
+			if (!newsk)
+				goto drop_unlock;
+			bh_lock_sock_nested(newsk);
+			newsk_locked = true;
+		}
 		skb_set_owner_r(skb, newsk);
 	} else {
 		/*
@@ -813,18 +960,46 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
+	if (unlikely(llc_sk(skb->sk)->state < LLC_CONN_STATE_ADM)) {
+		if (newsk)
+			llc_release_incoming_sock(newsk);
+		else if (atomic_read(&llc_sk(sk)->incoming_state) !=
+			 LLC_INCOMING_NONE)
+			llc_release_incoming_sock(sk);
+		goto drop_unlock;
+	}
+	if (!sock_owned_by_user(sk)) {
 		llc_conn_rcv(sk, skb);
-	else {
+		if (newsk &&
+		    atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING)
+			llc_release_incoming_sock(newsk);
+	} else {
 		dprintk("%s: adding to backlog...\n", __func__);
 		llc_set_backlog_type(skb, LLC_PACKET);
-		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
+		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {
+			if (newsk)
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
@@ -852,12 +1027,53 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *newsk = skb->sk;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
+		if (newsk &&
+		    atomic_read(&llc_sk(newsk)->incoming_state) ==
+		    LLC_INCOMING_PENDING) {
+			local_bh_disable();
+			bh_lock_sock_nested(newsk);
+			if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+			    LLC_INCOMING_PENDING) {
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+				goto retry;
+			}
+			if (sock_flag(sk, SOCK_DEAD) ||
+			    sk->sk_state != TCP_LISTEN ||
+			    llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
+				llc_release_incoming_sock(newsk);
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+				goto out_kfree_skb;
+			}
 			rc = llc_conn_rcv(sk, skb);
-		else
+			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
+			bh_unlock_sock(newsk);
+			local_bh_enable();
+		} else if (newsk &&
+			   atomic_read(&llc_sk(newsk)->incoming_state) ==
+			   LLC_INCOMING_QUEUED) {
+			local_bh_disable();
+			bh_lock_sock_nested(newsk);
+			if (llc_sk(newsk)->state <= LLC_CONN_STATE_ADM) {
+				llc_release_incoming_sock(newsk);
+				bh_unlock_sock(newsk);
+				local_bh_enable();
+				goto out_kfree_skb;
+			}
+			rc = llc_conn_rcv(newsk, skb);
+			bh_unlock_sock(newsk);
+			local_bh_enable();
+		} else if (likely(llc->state > 1)) {
+			rc = llc_conn_rcv(sk, skb);
+		} else {
 			goto out_kfree_skb;
+		}
 	} else if (llc_backlog_type(skb) == LLC_EVENT) {
 		/* timer expiration event */
 		if (likely(llc->state > 1))  /* not closed */
@@ -870,6 +1086,24 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 out:
 	return rc;
+retry:
+	if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+	    LLC_INCOMING_QUEUED) {
+		local_bh_disable();
+		bh_lock_sock_nested(newsk);
+		if (llc_sk(newsk)->state > LLC_CONN_STATE_ADM)
+			rc = llc_conn_rcv(newsk, skb);
+		else {
+			llc_release_incoming_sock(newsk);
+			bh_unlock_sock(newsk);
+			local_bh_enable();
+			goto out_kfree_skb;
+		}
+		bh_unlock_sock(newsk);
+		local_bh_enable();
+		goto out;
+	}
+	goto out_kfree_skb;
 out_kfree_skb:
 	kfree_skb(skb);
 	goto out;
@@ -959,17 +1193,18 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
 
 /**
  *	llc_sk_free - Frees a LLC socket
- *	@sk: - socket to free
+ *	@sk: socket to free
+ *	@sync: whether to synchronously stop timers
  *
- *	Frees a LLC socket
+ *	Frees a LLC socket.
  */
-void llc_sk_free(struct sock *sk)
+void llc_sk_free(struct sock *sk, bool sync)
 {
 	struct llc_sock *llc = llc_sk(sk);
 
 	llc->state = LLC_CONN_OUT_OF_SVC;
 	/* Stop all (possibly) running timers */
-	llc_sk_stop_all_timers(sk, true);
+	llc_sk_stop_all_timers(sk, sync);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
 		skb_queue_len(&llc->pdu_unack_q),
-- 
2.43.0

