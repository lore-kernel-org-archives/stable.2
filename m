Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45976346E6D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422506; cv=none; b=BWCineTrMFgOu89FQ9MX769pHH3LVtki8EVRLcpFjvgmGNoxh6W4aj0BEbwtasgrOFltnXUVHbrCWxYfAU6Qun9X0OittDb8GWkVo/hH5DFs8L4XDRWdmGt0Vgr3tF7rfg/nhHXA10xDYGREiAXdJFjFxCQ3HBsOklXHdiJoNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422506; c=relaxed/simple;
	bh=wOwgFPttteLWIPsiu6kTNiHyB+k+epRhQMr38sgXPbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5Zgscd7YR/CedlvntBevoTzVvCPBlqaxe4pmuKvM23CwRVuk8LcpIFuh2B6Od6CHE8HuA3spIWHoBeSZmXVDWI9AaAOpkhrmbJk1Sn6mr1H6O8XH7rSbD9Joov931xL3ZI/r4sLzdI6iZj1hiEK4zOSx//7H+fV+HFzdHo6phU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Lm8jQDPq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Lm8jQDPq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caced6038eso8685965ad.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788422503; x=1789027303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2jfBitlglUZeKM+lLh9bmoqGOt5hwGK3ifMJXv58Uw=;
        b=Lm8jQDPqMMwMy/3dAsTqx69AwkbwLMIGOwFdEjPD0BI+NREBAiaIVjcKpc6uceT2eZ
         ih+rALl8S+RWV7nDyimJ88S2WESMZvIK2Q6IxEr9yzDnOSvOOQHFQjlkGwe4BaviqW64
         6+n5CUYTK4trDRQOVm3zSh+W/6rfnZARpmp1PAsbgg4dEU0Nb8LetVr+y9xaIbSe2vSk
         bW8O9H14o899iz8T3j8j05EgAW7s9FssNpMmD2+tNI9EdZZdIaf1q2OMEZKswUwexFA1
         ip9HL0G9MJ0fhkCU1FstgRQHSY0g6i4QrqOZBNUA55WybR19M1I3gW7RnRgKJ8Un04GZ
         1xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422503; x=1789027303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2jfBitlglUZeKM+lLh9bmoqGOt5hwGK3ifMJXv58Uw=;
        b=mUhDgD0r0Tm8FSHyEHdGLC3lPeOBzIzS1ltckhGOruWV0zGxWbHuKFcPHNIxo7Mlgf
         vgjtbh2D/sHW9WD/veyvyLhu+GK3zoUUXrWsEbZUGC9NI7hlFmTFl7/HmgxRd+9pR1wH
         zcF+FM3KH7RVXqyYS/EDQwtIAPwW3EYiFnXPX8UgMaPvM5iSC27gks7VhFO2OOwatahP
         OUt5398KhJULrVrpOpBkKS0F72PSKtpag3jI8aD98ZdUXyjc2KN31JR1L/X4/IDFoPSx
         znEwE2U8WNqMZT0UaQeU6jE4mYBMUEvvEc7x9ffQEOhxsK3vu6YH3ZxEdlE7+XeYkEru
         /9JA==
X-Forwarded-Encrypted: i=1; AKwUvBw+cHtS1YltpryqlzWfFeDVA4zjJx/ekaheKU6x22MqsxONlv1MmX0D+VwvZ+FJc8rU2Q/mneI=@vger.kernel.org
X-Gm-Message-State: AFuF++me1squCWVGKaO/wEbcWmKYSL0x7dvLyK0WPVzZ04h/WGPhP/kA
	4O6Wgqdqpg/vdaTsQqIv7Idhd9YqCNW2QXacRNsyJVk9GqveiNauAG7soRy9vMmvSvzX
X-Gm-Gg: AYBFou3olN/2hKZkw6g8zBzP7NsJsFIgO1AYoH0SEHrHh5bX0r1uD0bkHd2q05KhJS5
	sJ7UEYho8s7y4RXuwZMdHMoq7yLBjPpfrGcNzivmny6sbZfTopFd2Elld8npXKx/YkO6Tf3oUD6
	R3yeAGqmRa3zWBg2ILeG5OBpMq/rKbUXAo1DuYG8jUEE2zp9dU6l0dkGk789/PFi20OEQfnGTq/
	0wEt+DgD4/C2gOOadVbiZmC5POqPI3IaWNPfajLWADCbTFtxdBtfxMMe0Z/OBxPitQ6PuNz/slf
	FId1jcSusNnWfBXJblAlmTixPKbscmvgXRiVMwFukLLx+P77FhqyKj/0iz8nyGY26mCEA/gkmgB
	FBPS2tg4DSQcxyjyt0MpRkqaC991ccyq+D9FnI8FqtIPiyC6lZtKQMPulDSwsMiOpb7qqdoLtVU
	NYrA4qSrudbE9gC83WVL03jUp/g2FVtsTMeBBwCOFbmieFF4WGht4VDm2Z1k4LcGHv3qqUK18Fv
	UHtE8qKNN33d0A2+do=
X-Received: by 2002:a17:902:f707:b0:2cf:6e5d:23e9 with SMTP id d9443c01a7336-2dafb0b191cmr38825695ad.14.1788422503029;
        Thu, 03 Sep 2026 01:01:43 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe0d062fsm6240295ad.5.2026.09.03.01.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:01:42 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v7 1/1] llc: fix listener child socket leaks before passive open completes
Date: Thu,  3 Sep 2026 08:01:24 +0000
Message-ID: <0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788414881.git.zihanx@nebusec.ai>
References: <cover.1788414881.git.zihanx@nebusec.ai>
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
close. Keep a listener-owned list of those children so close() can
release PENDING sockets that never reached the accept queue, instead of
relying only on later packets or backlog drain. Release pending children
for redirected packets after the listener leaves TCP_LISTEN or is marked
SOCK_DEAD. If a later redirected frame fails to enqueue on the listener
backlog, drop that frame only; do not tear down the already pending
child.

Handshake skbs keep a child socket reference with
skb_set_owner_sk_safe(). skb_set_owner_r() does not hold the socket, so
kfree_skb() on drop, accept-failure, and close paths could race
asynchronous teardown through sock_rfree().

Finish sock_orphan() and the device put before llc_sk_free(). That
helper already sock_put()s, so those steps must not run after its put
and rely only on the extra hold from llc_release_incoming_sock().

The child socket lock is acquired with bottom halves disabled whenever
the cleanup or backlog path runs in process context. Deferred child
teardown does not lock the listener; the child already holds a reference
to it until that work drops it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
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
  - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the earliest
    locally visible history carrying the same root-cause fact.
  - Clarify panic_on_oom crash evidence and packetdrill selection.
  - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

 include/net/llc_conn.h |  15 +-
 net/llc/af_llc.c       |  22 ++-
 net/llc/llc_conn.c     | 312 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 335 insertions(+), 14 deletions(-)

diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index e1a3026967234..4fb5dedd46c4b 100644
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
@@ -72,6 +77,11 @@ struct llc_sock {
 					      received and caused sending FRMR.
 					      Used for resending FRMR */
 	u32		    cmsg_flags;
+	atomic_t	    incoming_state;
+	struct sock	    *incoming_listener;
+	struct list_head    incoming_node;
+	struct list_head    incoming_children;
+	struct work_struct incoming_work;
 	struct hlist_node   dev_hash_node;
 };
 
@@ -93,7 +103,10 @@ static __inline__ char llc_backlog_type(struct sk_buff *skb)
 struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
 			  struct proto *prot, int kern);
 void llc_sk_stop_all_timers(struct sock *sk, bool sync);
-void llc_sk_free(struct sock *sk);
+void llc_sk_free(struct sock *sk, bool sync);
+void llc_release_incoming_sock(struct sock *sk);
+bool llc_accept_incoming_sock(struct sock *sk);
+void llc_release_incoming_children(struct sock *sk);
 
 void llc_sk_reset(struct sock *sk);
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b0447c33dbf09..e8054809cf0cf 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -27,6 +27,7 @@
 #include <net/llc_sap.h>
 #include <net/llc_pdu.h>
 #include <net/llc_conn.h>
+#include <net/llc_c_st.h>
 #include <net/tcp_states.h>
 
 /* remember: uninitialized global data is zeroed because its in .bss */
@@ -196,6 +197,7 @@ static int llc_ui_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
+	bool listener;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -206,6 +208,9 @@ static int llc_ui_release(struct socket *sock)
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
+	listener = sk->sk_state == TCP_LISTEN;
+	if (listener)
+		sock_set_flag(sk, SOCK_DEAD);
 	if (!sock_flag(sk, SOCK_ZAPPED)) {
 		struct llc_sap *sap = llc->sap;
 
@@ -214,16 +219,18 @@ static int llc_ui_release(struct socket *sock)
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
@@ -722,6 +729,17 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 		goto frees;
 	rc = 0;
 	newsk = skb->sk;
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM ||
+	    !llc_accept_incoming_sock(newsk)) {
+		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
+		    LLC_INCOMING_NONE)
+			llc_release_incoming_sock(newsk);
+		release_sock(newsk);
+		sock_put(newsk);
+		rc = -ECONNABORTED;
+		goto frees;
+	}
 	/* attach connection to a new socket. */
 	llc_ui_sk_init(newsock, newsk);
 	sock_reset_flag(newsk, SOCK_ZAPPED);
@@ -737,6 +755,8 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
 	sk_acceptq_removed(sk);
 	dprintk("%s: ok success on %02X, client on %02X\n", __func__,
 		llc_sk(sk)->addr.sllc_sap, newllc->daddr.lsap);
+	release_sock(newsk);
+	sock_put(newsk);
 frees:
 	kfree_skb(skb);
 out:
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54c..092625e28b3bb 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -32,6 +32,7 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 							      struct sk_buff *skb);
+static void llc_incoming_sock_work(struct work_struct *work);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -88,6 +89,13 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 		 * skb->sk pointing to the newly created struct sock in
 		 * llc_conn_handler. -acme
 		 */
+		if (sk != skb->sk &&
+		    atomic_read(&llc_sk(skb->sk)->incoming_state) ==
+		    LLC_INCOMING_PENDING) {
+			sock_hold(skb->sk);
+			atomic_set(&llc_sk(skb->sk)->incoming_state,
+				   LLC_INCOMING_QUEUED);
+		}
 		skb_get(skb);
 		skb_queue_tail(&sk->sk_receive_queue, skb);
 		sk->sk_state_change(sk);
@@ -765,27 +773,196 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
 	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
 	newllc->dev = dev;
+	newllc->incoming_listener = sk;
+	atomic_set(&newllc->incoming_state, LLC_INCOMING_PENDING);
+	INIT_WORK(&newllc->incoming_work, llc_incoming_sock_work);
+	sock_hold(sk);
 	dev_hold(dev);
 	llc_sap_add_socket(llc->sap, newsk);
+	spin_lock_bh(&llc->sap->sk_lock);
+	list_add_tail(&newllc->incoming_node, &llc->incoming_children);
+	spin_unlock_bh(&llc->sap->sk_lock);
 out:
 	return newsk;
 }
 
+static void llc_incoming_sock_work(struct work_struct *work)
+{
+	struct llc_sock *llc = container_of(work, struct llc_sock,
+					    incoming_work);
+	struct sock *listener = llc->incoming_listener;
+	struct sock *sk = &llc->sk;
+
+	lock_sock(sk);
+	llc_sk_stop_all_timers(sk, false);
+	sock_orphan(sk);
+	release_sock(sk);
+	llc_sk_stop_all_timers(sk, true);
+	dev_put(llc->dev);
+	llc->dev = NULL;
+	llc_sk_free(sk, false);
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
+	spin_lock_bh(&llc->sap->sk_lock);
+	list_del_init(&llc->incoming_node);
+	spin_unlock_bh(&llc->sap->sk_lock);
+	sock_hold(sk);
+	llc_sap_remove_socket(llc->sap, sk);
+	schedule_work(&llc->incoming_work);
+}
+
+bool llc_accept_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (atomic_cmpxchg(&llc->incoming_state, LLC_INCOMING_QUEUED,
+			   LLC_INCOMING_NONE) != LLC_INCOMING_QUEUED)
+		return false;
+
+	spin_lock_bh(&llc->sap->sk_lock);
+	list_del_init(&llc->incoming_node);
+	spin_unlock_bh(&llc->sap->sk_lock);
+	sock_put(llc->incoming_listener);
+	return true;
+}
+
+void llc_release_incoming_children(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+		struct sock *newsk = skb->sk;
+
+		if (newsk && newsk != sk) {
+			int incoming_state;
+
+			bh_lock_sock_nested(newsk);
+			incoming_state =
+				atomic_read(&llc_sk(newsk)->incoming_state);
+			if (incoming_state != LLC_INCOMING_NONE) {
+				llc_release_incoming_sock(newsk);
+				if (incoming_state == LLC_INCOMING_QUEUED)
+					sock_put(newsk);
+			}
+			bh_unlock_sock(newsk);
+		}
+		kfree_skb(skb);
+	}
+	if (llc->sap) {
+		spin_lock(&llc->sap->sk_lock);
+		while (!list_empty(&llc->incoming_children)) {
+			struct llc_sock *child;
+			struct sock *newsk;
+
+			child = list_first_entry(&llc->incoming_children,
+						 struct llc_sock,
+						 incoming_node);
+			list_del_init(&child->incoming_node);
+			newsk = &child->sk;
+			sock_hold(newsk);
+			spin_unlock(&llc->sap->sk_lock);
+
+			bh_lock_sock_nested(newsk);
+			if (atomic_read(&child->incoming_state) !=
+			    LLC_INCOMING_NONE)
+				llc_release_incoming_sock(newsk);
+			bh_unlock_sock(newsk);
+			sock_put(newsk);
+			spin_lock(&llc->sap->sk_lock);
+		}
+		spin_unlock(&llc->sap->sk_lock);
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
+	struct sock *sk, *newsk = NULL;
+	bool newsk_lookup_ref = false;
 	struct llc_addr saddr, daddr;
-	struct sock *sk;
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
 	/*
 	 * This has to be done here and not at the upper layer ->accept
 	 * method because of the way the PROCOM state machine works:
@@ -795,11 +972,31 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
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
@@ -813,18 +1010,49 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
+	if (unlikely(llc_sk(skb->sk)->state < LLC_CONN_STATE_ADM)) {
+		if (newsk) {
+			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+			    LLC_INCOMING_PENDING)
+				llc_release_incoming_sock(newsk);
+		} else if (atomic_read(&llc_sk(sk)->incoming_state) ==
+			   LLC_INCOMING_PENDING) {
+			llc_release_incoming_sock(sk);
+		}
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
+			if (newsk && !newsk_lookup_ref)
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
@@ -852,12 +1080,52 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
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
+			if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
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
@@ -870,6 +1138,23 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 out:
 	return rc;
+retry:
+	if (atomic_read(&llc_sk(newsk)->incoming_state) ==
+	    LLC_INCOMING_QUEUED) {
+		local_bh_disable();
+		bh_lock_sock_nested(newsk);
+		if (llc_sk(newsk)->state >= LLC_CONN_STATE_ADM) {
+			rc = llc_conn_rcv(newsk, skb);
+		} else {
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
@@ -906,6 +1191,8 @@ static void llc_sk_init(struct sock *sk)
 	llc->rw = 128; /* rx win size (opt and equal to
 			* tx_win of remote LLC) */
 	skb_queue_head_init(&llc->pdu_unack_q);
+	INIT_LIST_HEAD(&llc->incoming_node);
+	INIT_LIST_HEAD(&llc->incoming_children);
 	sk->sk_backlog_rcv = llc_backlog_rcv;
 }
 
@@ -960,16 +1247,17 @@ void llc_sk_stop_all_timers(struct sock *sk, bool sync)
 /**
  *	llc_sk_free - Frees a LLC socket
  *	@sk: - socket to free
+ *	@sync: whether to synchronously stop timers
  *
  *	Frees a LLC socket
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

