Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF92439341
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789232015; cv=none; b=D93cE+jGUUsZI8zfe4IxnYYQ2lToEjvl7ACzptprBjt9Ozq7Astt641Kub9QllbGDV8pX42T+CBylaH5ObS9fBDFjUuZ2JdQyRyoniWUZRT3WpwRsx69D79NYdpNYOJta5dGI6ACT2HTMsvxCFjPSr8nN7LHtRsNYtM8YoHXPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789232015; c=relaxed/simple;
	bh=CyZ+wRTv1vIAKrqoIFsovZCTxpZs1MpCacIyScmvP4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+kil2o2gCQippC8AbupUEV4/lEUuPq6ElcVFWw7VoFkF5goBFOO6SL+O3ESyAo8w3gKAfWqjnUmrz/NnjEwmaLRj4YJ7Q5udKok67N9CD50nhQPGzbEFnExppv49r6qbD/qeWg/VHKwx7C+nd2PR9Q14aJhCgjshPeszGnhurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=kAHfo1hJ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="kAHfo1hJ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so455650a91.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789232012; x=1789836812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmnVyR1UBi6OqqthmqlN2O4hpIy7YDRf9qXHJ0j6VeU=;
        b=kAHfo1hJ3pfwyyLLftdPS6ssWElRaew7Q+FQsfaVKTUZioE6Bs2g7eoKqvSPAXI5dm
         D6Aiih2ViIWdAf3VEiQKSa5pwBPLTGnYgWHfd+btiWCPXA6RBi4sygp3eeYMHu4Innc5
         ByyH+zOXd9rySEraT+bc+N0rYAwyJILcWxbcEo99Pg1rHNvo9SjqcfiT6bC7KsSHQhWQ
         CeDAkrUyHsQT7oFspaiDd0LcMkuOJpY1930xvL/pidroYYKW3U8QT0GD7DSmWBHku7cF
         g8rEWaIFElz7WYL08o2wHcw7irPPyJDE6Lyumfk3riWqYBYq2Nq2Tgr+YHb3D2oUc+tJ
         RMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789232012; x=1789836812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmnVyR1UBi6OqqthmqlN2O4hpIy7YDRf9qXHJ0j6VeU=;
        b=FnrED4N9oBad4dIFuxY4fWvFN4SlaX2uKXnd/tQGOjmbfo8pVthv7vzBWywzWbpZuW
         isWN+InPc5RcjaWi9Sc0zQGt79xT7eF81WVbCZGH7ueVX6ru92qfVOg4zjr/y2q4vW1M
         L5ApSlAB64T3rCKdQsYiln+BtM8ZFWibH4JBNmIB+nS4de1/lBQoIXS8aP2CAh9TwoKX
         Y71tAtmpoCCgJ5PWAAv8cZJv9BxZhmeaA4itLmxq8WM1kI4los6Iq+SupdOI9+jwRTTD
         zdkSKA9DNa+mH/DDx1+sIUmDPx/onX1mQS386LrOCiTgAoeaszQ4NG1QvNHScOE8fl3H
         Jehg==
X-Forwarded-Encrypted: i=1; AKwUvByPCcQuJWVTYQD4Gl4v4IW37G9GCsZYMyg3dtyjcDViVE+vbufjf8I/I2jVO3feUie8WldKxiE=@vger.kernel.org
X-Gm-Message-State: AFuF++l43Isx2QsR5ziyWeIi++v92bSTcT/Mi5QHXAe8BmM55G5OQkV1
	RXRsbrHaZApry8yE9o2aFfJNNAgmi0/uX7mfZCfCg1uoWM8GGHu9wQYDEbRJnq0wHrfR
X-Gm-Gg: AYBFou2XMKhzTYFusy9/lVMYms9grpiSfF1KprLVW1r1SngID4/wQOHBkBErH0oqJ1c
	JOuqR29kaqy+qRGM8GRv3KOoUu77gGU3hBJJ6pTAdiot5obD+sYT84Cb7m6A/1WqU3zWpLZgLuS
	vj22mYKWzoxq0QxLBn503F0c81mVKdJGFejU4l5ZsW5NCk+CojWNbxRyymla3oBRg0NRS3ZrwkI
	3krHbT1xrCfkyC1utmXTddmwZrmZ/1LMu9k2ordLg1lhfkwIPltKZa6CRatRoOac6/akJePI+Lf
	lKN2SgKdxzvmE/ZXJ0F0iYQ+IZKwN68gjhCj9Gdljc/t9wXT8F21SfrgorCaJzPhVNhqhbDqrxc
	oMlHfHGEunaj73XP+oz13IzkPd0rJnhJi2iOgZUPdgr0eKoz2QYf8UFt2ZEYrzzsQ/Yq+96y40/
	cL0mRiqE4wWkXiCcdmCrwAcskOGEtoM2bi1zcqIEqq9ZT9MwEFZgR7wP9wBLRnL03/IH/tWOhAS
	Cs5pnhiAvWHdvHhpO8A+cFH9BMBDg==
X-Received: by 2002:a17:90b:57c6:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-39dbbeb57a5mr6717852a91.7.1789232011503;
        Sat, 12 Sep 2026 09:53:31 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b21sm10907424a91.13.2026.09.12.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 09:53:30 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v9 1/1] llc: fix listener child socket leak on non-SABME frames
Date: Sat, 12 Sep 2026 16:53:05 +0000
Message-ID: <5d2eb4eae5248b37f14ae713a9c0ad1c6f1fedd3.1789216793.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789216793.git.zihanx@nebusec.ai>
References: <cover.1789216793.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_handler() creates a child socket for every frame that matches
a listening PF_LLC socket. llc_create_incoming_sock() publishes the
child in the SAP tables and takes a device reference before the frame
is known to be a passive-open request.

A listener-directed non-SABME frame does not queue an LLC_CONN_PRIM
indication, so accept() cannot return the child and closing the listener
does not reclaim it.
Repeating such frames, for example DISC commands with distinct source
addresses, can leak struct sock objects and device references and
eventually exhaust memory.

Create an incoming child only for a SABME command. Answer DISC commands
and other P=1 commands with a DM response addressed to the source address
decoded from the packet, because a listener has no peer in llc->daddr.
Drop other non-SABME frames. Do not dispatch non-SABME frames through the
listening socket's ADM state machine; its catch-all would move the listener
to LLC_CONN_OUT_OF_SVC.

The existing SABME child lifecycle is unchanged; this patch addresses
only the non-SABME path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
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

 net/llc/llc_conn.c | 53 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54c..4c2ca6b842516 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -771,6 +771,36 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	return newsk;
 }
 
+/**
+ *	llc_listener_send_dm - DM reply from a listening socket
+ *	@sap: SAP of the listener
+ *	@skb: received command
+ *	@saddr: source address decoded from @skb
+ *	@f_bit: final bit for the DM response
+ *
+ *	ADM would answer DISC and P=1 commands with DM, but a listener has no
+ *	peer in llc->daddr. Build the reply from the incoming frame instead.
+ */
+static void llc_listener_send_dm(struct llc_sap *sap, struct sk_buff *skb,
+				 const struct llc_addr *saddr, u8 f_bit)
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
@@ -795,11 +825,26 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
+		struct sock *newsk;
+
+		if (!llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+			newsk = llc_create_incoming_sock(sk, skb->dev, &saddr,
+							 &daddr);
+			if (!newsk)
+				goto drop_unlock;
+			skb_set_owner_r(skb, newsk);
+		} else {
+			/* Not a passive-open request. */
+			if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
+				u8 f_bit;
+
+				llc_pdu_decode_pf_bit(skb, &f_bit);
+				llc_listener_send_dm(sap, skb, &saddr, f_bit);
+			} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk, skb)) {
+				llc_listener_send_dm(sap, skb, &saddr, 1);
+			}
 			goto drop_unlock;
-		skb_set_owner_r(skb, newsk);
+		}
 	} else {
 		/*
 		 * Can't be skb_set_owner_r, this will be done at the
-- 
2.43.0

