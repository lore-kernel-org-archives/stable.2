Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79347440629
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789911331; cv=none; b=ZBBD+o4du6ORVVdaf7YNMCOOLEs9HFDodkLtkuKvLBj3uxP7HMB9VqJzHHIPTQZoinDolYDrl1wTOScMK+TEDHm+h1fnGHYjUrOELaey1axKDFLgmJ/n2dzZrjkN3nAdyVKa41Zh3q99I/xiWZP6C4db7dR4vnzkAzL0J0LQwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789911331; c=relaxed/simple;
	bh=3iG6jTxUYt6uMSWcaY/lGU7H13sEiS+EvsA9qqzXJwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YARR7lf6nS4nUoWQc/RSuQDedc5V118mvOm5EkwgDXH/0gNHtxjok/ykiyNQiAlDi8l65/jf4D+U2rWONHFBk3h6hg7Z2lkpoQiFjGbPtk2DmOjPMhbKKuMyrivQ7OfN/lwG47YP1L63ypr+CbCW4qDS4d0K5t5CWH2Ze9fAPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ML1o52Np; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ML1o52Np"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1570983a91.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789911326; x=1790516126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MaHXWIZW0sheVfPp5xn3JPHXEIBfwImhATkqPGJowRo=;
        b=ML1o52NpIcOywaBBzsNHjOWoXgnz4T3OvquYmRJXQtf2RRK7MJaAVGpbmoDrsv1Eyc
         a6w/DvtcnOlVuV5VCtcZ92BUuqoZomK9DpTIvxsAXsa3vyA1Kx8URK3omxAWGAvYFUT+
         Pc2qjuKCzsdDrngcvwGLxCRc6aJeRFOsi3QcCd35Jv2MQkJfvtR7bMTm0PamE1dOuztl
         552PGGmDt61Iadise0oEYtovkgAtSn3S+Eo0qunPXkk4spCRE4bTQ/J4TgUycSaAzWLJ
         cHTkl/g9mFANxo3uexal5Vv3ltYN4LlFJbsIZt8ERrYzrZu06Wn4ggm7rbxwl6pV+HVy
         xLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789911326; x=1790516126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MaHXWIZW0sheVfPp5xn3JPHXEIBfwImhATkqPGJowRo=;
        b=0iVtG+rO1lwwjTl8V2x04+aVi6L5kywOgXocqWRnbqG1vd1ErOqpLg1nAsV1/R+kwk
         8jfsk0Lom75kc3Xn2rlXyRYhK4YVA+h/jCLBi10F0eHJs1JDGBkTh5Qt1oiCBFV+4y5q
         siq19rvHhVV71xr08PJvpuvIC/qFtdSjWxx/bW8QhmwVeDsXMfTRTkvq0EqxOr0V8fgK
         1wwAoCK9w6sysAYKYYw2Q6+YP7i3x1YDT+E8OaoT8SKglbCbazdBYUYO1RT/7aTsL/1y
         sY8wJB7Baq27rxQ6kagYfoMVGVvaWWgRJoVlKdKPZLUspnuNRUlGN2rv/i4RdYBmlUje
         tHvw==
X-Forwarded-Encrypted: i=1; AKwUvByNb9eIVoWyho8RilsI43d7kTMfdeiGVg3t2Dy0KeLT93SDt6lKcuDsQlyfaL2SULixei/exuM=@vger.kernel.org
X-Gm-Message-State: AFuF++lC4QCUdY/JcikqHHd6zBgfm5lXZd9mcl+Lp+wrNVHP4fT6bmJ7
	1UiQuc71SVYomheMkSxltfg7aZik2rou+cz+QatacwEDGRNrUwibI87JXojcrHX94CsJ
X-Gm-Gg: AYBFou3UnEAZ9asBZW/U9FarfuvZ5Ee6L0eShuGp8wzoo6CFR4PY04iHlbaXu00T54u
	IExRuv8yVUdz3sbtI5u17EvKh+QTSnWCwEULajhwVBJpi5RjwuWWT4H4Ofhl+iIp1iLewpp+0FU
	38mbjqVuc7AmHOK0rlAnC4XeYEfuqdsddHYHm+aFdTb6DnVpmCaUmB/w/DrT4hPvldG+l0cifNi
	09JyHQLy66Y6cnlCItvjZZG2JAO9t8cYTVycJFEvkwgtn4D4BVSpvioIj4AGprhKzB/w1IQQgHN
	M9whrjOEjBfeSQSSeoXLJBX+WD5Zwq8uvXQBMR/cD5WTEkx1PYzCw8zYTsDM4F0apDtDp0JN3qf
	ucv3tcx3fz0sx/OHm6BodCtKv4SGPEOBGXSJQUk2NG61CcM4h8lk/D8Lzr709NWcGW8OXJaoMf6
	+A06I7aRbrElZYF8idea9/pdlNRzz+fSLaLvj0dhReLD8M/hkOcC0l3xCF43YB7eRhebSt2MdBY
	JWZzeZt/7a9ICEnrafEDZxxG1k4vg==
X-Received: by 2002:a05:6a20:4393:b0:3dd:a00a:7ac6 with SMTP id adf61e73a8af0-3dda00a9e68mr7794672637.51.1789911325981;
        Sun, 20 Sep 2026 06:35:25 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm2122055a12.6.2026.09.20.06.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:35:24 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: zihanx@nebusec.ai,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v10 1/1] llc: fix listener child socket leaks
Date: Sun, 20 Sep 2026 13:35:07 +0000
Message-ID: <24d93c5373c725a4fe9d72ee534fd3f0fb7ef7ac.1789824800.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789824800.git.zihanx@nebusec.ai>
References: <cover.1789824800.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_handler() used to create and publish a child socket for every
frame that matched a listening socket. Non-SABME frames never complete a
passive open, leaving the child in the SAP tables with its device
reference held and no path to accept().

Valid SABME frames could also accumulate without accounting for the
listener's accept backlog. A state-machine failure could strand a
published child, while listener teardown could free its connection
indication skb without releasing the child and its device reference.

Create children only for SABME commands. Answer DISC and other P=1
commands directly from the listener and drop the remaining non-SABME
frames. Defer child creation for listener-owned packets until backlog
admission succeeds, roll back children when passive-open processing
fails, and release queued children during listener teardown after freeing
their indication skbs.

Serialize child publication and teardown with the socket lock, including
bottom-half exclusion for process-context teardown. Reject stale or
out-of-service lookup results before state-table dispatch while keeping a
pending SABME child hashed until passive-open processing completes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v10:
  - Fix SABME child rollback on direct and backlog state-machine failure.
  - Defer child creation for listener-owned packets until backlog
    admission succeeds, and enforce sk_max_ack_backlog accounting.
  - Release queued child sockets during listener teardown after freeing
    their indication skbs, including bottom-half-safe child locking.
  - Serialize child publication and packet processing with the child
    socket lock and reject stale or out-of-service lookup results.
  - Keep the llc_ui_accept() NULL-dereference concern out of scope as a
    separate issue.
  - v9 Link: https://lore.kernel.org/all/5d2eb4eae5248b37f14ae713a9c0ad1c6f1fedd3/
changes in v9:
  - Simplify the fix to cover only the non-SABME listener leak:
    create children only for SABME, answer DISC and P=1 commands with
    a DM response addressed to the source address decoded from the packet,
    and drop all other non-SABME frames without running the listener state
    machine.
  - Remove the incoming_state / workqueue / child-list lifecycle rewrite.
  - Keep the existing SABME child lifecycle unchanged.
  - Leave accept-queue accounting and llc_ui_accept() unchanged; related
    feedback is outside this non-SABME-only fix.
  - Treat unbounded SABME child allocation as a separate issue; v9 does not
    claim to fix SABME flooding.
  - Explicitly document the disposition of the three earlier review points:
    v9 does not change accept-queue accounting or llc_ui_accept(), and does
    not address unbounded SABME child allocation.
  - v8 Link: https://lore.kernel.org/all/abc8b115321dbd417b8491d9e51f1988998ff50e.1788707641.git.zihanx@nebusec.ai/
changes in v8:
  - Reject a connection indication whose skb->sk is the listener itself
    so accept() cannot lock_sock_nested() the socket it already holds,
    and drop the extra QUEUED reference only when it was taken.
  - Drop the extra QUEUED hold from the incoming_children close walk,
    matching the receive-queue walk.
  - Do not run the connection state machine on a released incoming child
    from the listener backlog; leftover in-service child frames run on
    that child under its lock.
  - Limit out-of-service tests on the receive path to incoming children
    and to a looked-up child already marked out of service. SAP unhash
    is RCU, so drop that later lookup instead of indexing the state
    table with state 0. This is not a generic llc_conn_service bounds
    check.
  - Do not nested-lock a QUEUED child on itself in llc_backlog_rcv().
  - Sort the new locals in llc_release_incoming_children() reverse
    xmas tree.
  - Describe the original /proc/net/llc/socket leak evidence as the
    wc -l count (0 then 100 leftover entries). No raw proc table from
    that run was kept.
  - Decode the remaining OOM frames against a rebuilt 6.12.74 vmlinux;
    leftover lockdep, sanitizer, and do_pte_missing frames still show
    original offsets.
  - Keep this as the listener child leak and lifecycle fix only. The
    listen(2) accept-queue bound raised against v7 is independent of the
    leak and is not included here.
  - v7 Link: https://lore.kernel.org/all/cover.1788414881.git.zihanx@nebusec.ai/
changes in v7:
  - Drop the companion LLC_CONN_OUT_OF_SVC bounds patch due to overlap with
    Kees Cook's net-next series:
    https://lore.kernel.org/all/20260901210300.i.590-kees@kernel.org/
  - That series also covers the connect(2) +1 return and rejecting
    out-of-service states before table lookup, as raised in review of
    v6 2/2:
    https://lore.kernel.org/all/20260902010052.2297527-1-kuba@kernel.org/
  - Keep only the listener child leak fix for net.
  - Fix reverse-xmas-tree local ordering in llc_conn_handler() and
    llc_incoming_sock_work(), align the atomic_cmpxchg() continuation,
    and add matching braces on the backlog retry if/else.
  - Release a PENDING child when llc_conn_handler() sees a redirected
    packet for a TCP_LISTEN socket that is already SOCK_DEAD, instead of
    dropping the packet and leaving that cleanup only to close().
  - Keep the init_net CAP_NET_RAW/CAP_NET_ADMIN reproducer; PF_LLC is
    rejected outside init_net, so unshare -Urn cannot express this path.
  - Spell out that the crash PoC is DISC-only, include poc-sabme.c for
    the accept and close paths, and restore the full OOM panic so the
    leftover /proc/net/llc/socket leak is described next to that log.
  - Do not tear down an already pending child when a redirected frame
    fails sk_add_backlog(); drop that frame only.
  - Track incoming children on the listener and release leftover PENDING
    sockets from that list on close(), instead of relying only on
    sk_receive_queue, backlog drain, or a later SOCK_DEAD packet.
  - Stop taking the listener lock in llc_incoming_sock_work(); the child
    already holds the listener, and teardown no longer interleaves with
    llc_ui_release()'s llc_sk_free().
  - Hold a child socket reference on handshake skbs with
    skb_set_owner_sk_safe(), so kfree_skb() cannot race asynchronous
    teardown through sock_rfree().
  - Finish sock_orphan() and the device put in llc_incoming_sock_work()
    before llc_sk_free(), so those steps do not run after its sock_put().
  - Keep the v1 lore Link on its own line, before the numbered-patch
    diffstat.
  - Include the original leak-only leftover /proc/net/llc/socket count
    next to the later panic_on_oom log.
  - v6 Link: https://lore.kernel.org/all/cover.1787752861.git.zihanx@nebusec.ai/
changes in v6:
  - Hold a reference for children queued for accept() and release it when they
    are dequeued, while retaining SAP publication so tuple lookup still finds
    a pending child before the passive open completes.
  - Make direct receive, backlog, accept-queue, and listener-close cleanup
    symmetric, with bottom-half-disabled child locking in process context.
  - Keep the LLC_CONN_OUT_OF_SVC lower-bound check in its separate patch and
    use the ADM state boundary consistently.
  - v5 Link: https://lore.kernel.org/all/20260822082354.3109-1-zihanx@nebusec.ai/
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
  - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the
    earliest commit that introduced the child publication behavior.
  - Clarify panic_on_oom crash evidence and packetdrill selection.
  - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/
 net/llc/llc_conn.c | 162 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 149 insertions(+), 13 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54c..b942ad9c46e99 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void __llc_sk_free(struct sock *sk, bool sync);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -90,6 +91,8 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 */
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
+		if (sk->sk_state == TCP_LISTEN)
+			sk_acceptq_added(sk);
 		sk->sk_state_change(sk);
 		break;
 	case LLC_DISC_PRIM:
@@ -765,16 +768,88 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
-	dev_hold(dev);
+	netdev_hold(dev, &newllc->dev_tracker, GFP_ATOMIC);
+	/* Serialize packets that can find the child after it is hashed. */
+	bh_lock_sock_nested(newsk);
 	llc_sap_add_socket(llc->sap, newsk);
 out:
 	return newsk;
 }
 
+static struct sock *llc_create_incoming_sock_from_skb(struct sock *sk,
+						      struct sk_buff *skb)
+{
+	struct llc_addr saddr, daddr;
+
+	llc_pdu_decode_sa(skb, saddr.mac);
+	llc_pdu_decode_ssap(skb, &saddr.lsap);
+	llc_pdu_decode_da(skb, daddr.mac);
+	llc_pdu_decode_dsap(skb, &daddr.lsap);
+
+	return llc_create_incoming_sock(sk, skb->dev, &saddr, &daddr);
+}
+
+static bool llc_sk_unhashed(const struct sock *sk)
+{
+	return hlist_nulls_unhashed_lockless(&sk->sk_nulls_node);
+}
+
+static void llc_release_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	local_bh_disable();
+	bh_lock_sock_nested(sk);
+	llc->state = LLC_CONN_OUT_OF_SVC;
+	llc_sap_remove_socket(llc->sap, sk);
+	bh_unlock_sock(sk);
+	local_bh_enable();
+	netdev_put(llc->dev, &llc->dev_tracker);
+	sock_orphan(sk);
+	/* llc_sk_free() drops the allocation reference. */
+	llc_sk_free(sk);
+}
+
+static void llc_abort_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	/* The passive-open child is still locked by its creator. */
+	llc->state = LLC_CONN_OUT_OF_SVC;
+	llc_sap_remove_socket(llc->sap, sk);
+	bh_unlock_sock(sk);
+	netdev_put(llc->dev, &llc->dev_tracker);
+	sock_orphan(sk);
+	/* No child timer is armed before passive-open setup completes. */
+	__llc_sk_free(sk, false);
+}
+
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
+	struct sock *newsk = NULL;
 	struct sock *sk;
+	int rc;
 
 	llc_pdu_decode_sa(skb, saddr.mac);
 	llc_pdu_decode_ssap(skb, &saddr.lsap);
@@ -786,6 +861,10 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		goto drop;
 
 	bh_lock_sock(sk);
+	if (unlikely(llc_sk_unhashed(sk)))
+		goto drop_unlock;
+	if (unlikely(llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC))
+		goto drop_unlock;
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,11 +874,26 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
+		if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+			if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
+				u8 f_bit;
+
+				llc_pdu_decode_pf_bit(skb, &f_bit);
+				llc_conn_send_dm_rsp(sap, skb, &saddr, f_bit);
+			} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk,
+								       skb)) {
+				llc_conn_send_dm_rsp(sap, skb, &saddr, 1);
+			}
 			goto drop_unlock;
-		skb_set_owner_r(skb, newsk);
+		} else if (!sock_owned_by_user(sk)) {
+			if (sk_acceptq_is_full(sk))
+				goto drop_unlock;
+			newsk = llc_create_incoming_sock(sk, skb->dev, &saddr,
+							 &daddr);
+			if (!newsk)
+				goto drop_unlock;
+			skb_set_owner_r(skb, newsk);
+		}
 	} else {
 		/*
 		 * Can't be skb_set_owner_r, this will be done at the
@@ -813,9 +907,15 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
-		llc_conn_rcv(sk, skb);
-	else {
+	if (!sock_owned_by_user(sk)) {
+		rc = llc_conn_rcv(sk, skb);
+		if (unlikely(rc) && newsk) {
+			llc_abort_incoming_sock(newsk);
+			goto out;
+		}
+		if (newsk)
+			bh_unlock_sock(newsk);
+	} else {
 		dprintk("%s: adding to backlog...\n", __func__);
 		llc_set_backlog_type(skb, LLC_PACKET);
 		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
@@ -852,12 +952,28 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *newsk = NULL;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
-			rc = llc_conn_rcv(sk, skb);
-		else
+		if (unlikely(sk->sk_state == TCP_LISTEN)) {
+			if (llc_sk_unhashed(sk))
+				goto out_kfree_skb;
+			if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb))
+				goto out_kfree_skb;
+			if (sk_acceptq_is_full(sk))
+				goto out_kfree_skb;
+			newsk = llc_create_incoming_sock_from_skb(sk, skb);
+			if (!newsk)
+				goto out_kfree_skb;
+			skb_set_owner_r(skb, newsk);
+		} else if (unlikely(llc->state <= 1)) {
 			goto out_kfree_skb;
+		}
+		rc = llc_conn_rcv(sk, skb);
+		if (unlikely(rc) && newsk)
+			llc_abort_incoming_sock(newsk);
+		else if (newsk)
+			bh_unlock_sock(newsk);
 	} else if (llc_backlog_type(skb) == LLC_EVENT) {
 		/* timer expiration event */
 		if (likely(llc->state > 1))  /* not closed */
@@ -964,18 +1080,38 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
  *	Frees a LLC socket
  */
 void llc_sk_free(struct sock *sk)
+{
+	__llc_sk_free(sk, true);
+}
+
+static void __llc_sk_free(struct sock *sk, bool sync)
 {
 	struct llc_sock *llc = llc_sk(sk);
+	struct sk_buff *skb;
 
 	llc->state = LLC_CONN_OUT_OF_SVC;
 	/* Stop all (possibly) running timers */
-	llc_sk_stop_all_timers(sk, true);
+	llc_sk_stop_all_timers(sk, sync);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
 		skb_queue_len(&llc->pdu_unack_q),
 		skb_queue_len(&sk->sk_write_queue));
 #endif
-	skb_queue_purge(&sk->sk_receive_queue);
+	/* Pending accept indications do not hold a reference to their child. */
+	if (sk->sk_state == TCP_LISTEN) {
+		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+			struct sock *newsk = skb->sk;
+
+			if (newsk && newsk != sk)
+				sk_acceptq_removed(sk);
+			/* sock_rfree() still needs skb->sk to charge the child. */
+			kfree_skb(skb);
+			if (newsk && newsk != sk)
+				llc_release_incoming_sock(newsk);
+		}
+	} else {
+		skb_queue_purge(&sk->sk_receive_queue);
+	}
 	skb_queue_purge(&sk->sk_write_queue);
 	skb_queue_purge(&llc->pdu_unack_q);
 #ifdef LLC_REFCNT_DEBUG
-- 
2.55.0.windows.3

