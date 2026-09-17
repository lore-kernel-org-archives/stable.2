Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239271448E0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617215; cv=none; b=I9y4Yi19aVGbf15LNygeLDDepHjhcxYidCFeqOyI9LMuAcTcIUn/OOZa/8qVkRzW2V8d6Cl4NlVVTyt9m76t3dXXEdsMnqOmmQaLhtPt/3JKDNuPAOuClIj8J/Gz+5aGZhN8LiqIU+xUjcCjZV91vACGgWkzcez/0HG2hxfh6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617215; c=relaxed/simple;
	bh=LZNXpNQiZ450F1wpYfcPO2Eikt6rQvrT8bDPj8PwzMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpZVNQZlDWyGokdUSnX8zHzkC4IRuAnI0Rs0uLt+xMjR/5eSheudpK0bpuGRwy8wVygevZJk+jk213Q8JwMM6jB+rXwKsigSJV2pCX65gWt7e/HIA4kNhQRNjU3JaaYUVTQPSOxxShtGqLDnW0wLr5/nNzp7TD5XIu0BTAaLtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyHNK7qQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyHNK7qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F651F000FF;
	Thu, 17 Sep 2026 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617213;
	bh=eu2c4jsfpRu32COjZ0sEgugdgKRjhYO87RfiwxlSqXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KyHNK7qQqcG7LG6CoPV9y9TrjQ5f9cg/+rBwYHOgS2Yo+Tlg+eDyreFmxJpY/mmYR
	 1TQ1WgjjyozNgzvIhZ0gYDZ6xLz0OZd5assmZ5s3IdgqMUqBw5V4n4R6uBLIDhEFrJ
	 aZq+OAvBrFH2eA160IE7UnWO2aCxl/1z1IoOmmnTp3XbR97whFFLlL77QuljXxWKh0
	 N+eRnl7WwxzglgsCIb6iU0Qj+6QyLcMJqgO7hvRYWzy8r+r9mLQL9jh1vgF8YjsbtG
	 bSM47e4vRhuTAe1oUJoCW+5NitzNVX9CF9xJzszTas3PJwAUMKF0FZXMW1u3+fTWBY
	 PbFirSfYO8Yuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] tcp: introduce icsk->icsk_keepalive_timer
Date: Wed, 16 Sep 2026 23:53:30 -0400
Message-ID: <20260917035331.4104961-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091621-feed-gargle-2568@gregkh>
References: <2026091621-feed-gargle-2568@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 08dfe370239e53494453cee1e2ded2cdaa1efd12 ]

sk->sk_timer has been used for TCP keepalives.

Keepalive timers are not in fast path, we want to use sk->sk_timer
storage for retransmit timers, for better cache locality.

Create icsk->icsk_keepalive_timer and change keepalive
code to no longer use sk->sk_timer.

Added space is reclaimed in the following patch.

This includes changes to MPTCP, which was also using sk_timer.

Alias icsk->mptcp_tout_timer and icsk->icsk_keepalive_timer
for inet_sk_diag_fill() sake.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20251124175013.1473655-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[6.12 dependency adaptation for 85c580b0d859:
Keep the 6.12 from_timer(), icsk_timeout and existing inet_csk keepalive
helpers. Move those helpers and the DCCP keepalive callback to the new
timer as well; DCCP still shares inet_csk_init_xmit_timers() in this tree.
Preserve the stable cacheline documentation format and retransmit fields.

Include only the MPTCP retransmit-timer migration from 9a5e5334adc03:
alias sk_timer as mptcp_retransmit_timer and update its initialization,
callback, pending checks, reset and stop operations. TCP and DCCP keep
their existing icsk_retransmit_timer.

Use the existing mptcp_pm_connection_closed() helper for close events,
following 5add80bfdc46f, so the target's disconnect hunk applies unchanged.
Initialize MPTCP's icsk_rto_min to the stable TCP_RTO_MIN default, since
the target reads it but MPTCP does not call tcp_init_sock().
No functions are added. The synchronous-stop fix remains in the target.]

Stable-dep-of: 85c580b0d859 ("mptcp: prevent race between disconnect() and rtx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net_cachelines/inet_connection_sock.rst   |  1 +
 include/net/inet_connection_sock.h            | 11 +++++--
 include/net/sock.h                            |  6 +++-
 net/dccp/timer.c                              |  4 ++-
 net/ipv4/inet_connection_sock.c               | 10 +++---
 net/ipv4/inet_diag.c                          |  4 +--
 net/ipv4/tcp_ipv4.c                           |  4 +--
 net/ipv4/tcp_timer.c                          |  5 +--
 net/ipv6/tcp_ipv6.c                           |  4 +--
 net/mptcp/pm.c                                |  3 ++
 net/mptcp/protocol.c                          | 33 ++++++++-----------
 net/mptcp/protocol.h                          |  2 +-
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |  4 +--
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |  4 +--
 14 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index 7a911dc95652e..9a5289462f1e4 100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -14,6 +14,7 @@ struct_inet_bind2_bucket            icsk_bind2_hash        read_mostly         -
 unsigned_long                       icsk_timeout           read_mostly         -                   inet_csk_reset_xmit_timer,tcp_connect
 struct_timer_list                   icsk_retransmit_timer  read_mostly         -                   inet_csk_reset_xmit_timer,tcp_connect
 struct_timer_list                   icsk_delack_timer      read_mostly         -                   inet_csk_reset_xmit_timer,tcp_connect
+struct_timer_list                   icsk_keepalive_timer   -                   -
 u32                                 icsk_rto               read_write          -                   tcp_cwnd_validate,tcp_schedule_loss_probe,tcp_connect_init,tcp_connect,tcp_write_xmit,tcp_push_one
 u32                                 icsk_rto_min           -                   -                   
 u32                                 icsk_delack_max        -                   -                   
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 41354036b0c87..e898cee3dff6e 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -62,6 +62,9 @@ struct inet_connection_sock_af_ops {
  * @icsk_bind2_hash:	   Bind node in the bhash2 table
  * @icsk_timeout:	   Timeout
  * @icsk_retransmit_timer: Resend (no ack)
+ * @icsk_delack_timer:     Delayed ACK timer
+ * @icsk_keepalive_timer:  Keepalive timer
+ * @mptcp_tout_timer:      MPTCP timeout timer
  * @icsk_rto:		   Retransmit timeout
  * @icsk_pmtu_cookie	   Last pmtu seen by socket
  * @icsk_ca_ops		   Pluggable congestion control hook
@@ -88,8 +91,12 @@ struct inet_connection_sock {
 	struct inet_bind_bucket	  *icsk_bind_hash;
 	struct inet_bind2_bucket  *icsk_bind2_hash;
 	unsigned long		  icsk_timeout;
- 	struct timer_list	  icsk_retransmit_timer;
- 	struct timer_list	  icsk_delack_timer;
+	struct timer_list	  icsk_retransmit_timer;
+	struct timer_list	  icsk_delack_timer;
+	union {
+		struct timer_list icsk_keepalive_timer;
+		struct timer_list mptcp_tout_timer;
+	};
 	__u32			  icsk_rto;
 	__u32                     icsk_rto_min;
 	__u32                     icsk_delack_max;
diff --git a/include/net/sock.h b/include/net/sock.h
index dffbaaa7fe493..416d96f443246 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -300,6 +300,7 @@ struct sk_filter;
   *	@sk_txrehash: enable TX hash rethink
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
+  *	@mptcp_retransmit_timer: MPTCP retransmit timer
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING flags
@@ -465,7 +466,10 @@ struct sock {
 	u32			sk_dst_pending_confirm;
 	u32			sk_pacing_status; /* see enum sk_pacing */
 	struct page_frag	sk_frag;
-	struct timer_list	sk_timer;
+	union {
+		struct timer_list sk_timer;
+		struct timer_list mptcp_retransmit_timer;
+	};
 
 	unsigned long		sk_pacing_rate; /* bytes per second */
 	atomic_t		sk_zckey;
diff --git a/net/dccp/timer.c b/net/dccp/timer.c
index a4cfb47b60e52..fc1d88d6bc3fb 100644
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -160,7 +160,9 @@ static void dccp_write_timer(struct timer_list *t)
 
 static void dccp_keepalive_timer(struct timer_list *t)
 {
-	struct sock *sk = from_timer(sk, t, sk_timer);
+	struct inet_connection_sock *icsk =
+		from_timer(icsk, t, icsk_keepalive_timer);
+	struct sock *sk = &icsk->icsk_inet.sk;
 
 	pr_err("dccp should not use a keepalive timer !\n");
 	sock_put(sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 117a424d1fee3..18e95dd367843 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -750,7 +750,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 
 	timer_setup(&icsk->icsk_retransmit_timer, retransmit_handler, 0);
 	timer_setup(&icsk->icsk_delack_timer, delack_handler, 0);
-	timer_setup(&sk->sk_timer, keepalive_handler, 0);
+	timer_setup(&icsk->icsk_keepalive_timer, keepalive_handler, 0);
 	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
 }
 EXPORT_SYMBOL(inet_csk_init_xmit_timers);
@@ -763,7 +763,7 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 
 	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &icsk->icsk_keepalive_timer);
 }
 EXPORT_SYMBOL(inet_csk_clear_xmit_timers);
 
@@ -778,18 +778,18 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 
 	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
-	sk_stop_timer_sync(sk, &sk->sk_timer);
+	sk_stop_timer_sync(sk, &icsk->icsk_keepalive_timer);
 }
 
 void inet_csk_delete_keepalive_timer(struct sock *sk)
 {
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &inet_csk(sk)->icsk_keepalive_timer);
 }
 EXPORT_SYMBOL(inet_csk_delete_keepalive_timer);
 
 void inet_csk_reset_keepalive_timer(struct sock *sk, unsigned long len)
 {
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + len);
+	sk_reset_timer(sk, &inet_csk(sk)->icsk_keepalive_timer, jiffies + len);
 }
 EXPORT_SYMBOL(inet_csk_reset_keepalive_timer);
 
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index f2de2f2962595..01b6b50ae11d4 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -319,11 +319,11 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		r->idiag_retrans = icsk->icsk_probes_out;
 		r->idiag_expires =
 			jiffies_delta_to_msecs(icsk->icsk_timeout - jiffies);
-	} else if (timer_pending(&sk->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		r->idiag_timer = 2;
 		r->idiag_retrans = icsk->icsk_probes_out;
 		r->idiag_expires =
-			jiffies_delta_to_msecs(sk->sk_timer.expires - jiffies);
+			jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
 	}
 
 	if ((ext & (1 << (INET_DIAG_INFO - 1))) && handler->idiag_info_size) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2b7c580e37281..36862681731f2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2919,9 +2919,9 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
 		timer_expires	= icsk->icsk_timeout;
-	} else if (timer_pending(&sk->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active	= 2;
-		timer_expires	= sk->sk_timer.expires;
+		timer_expires	= icsk->icsk_keepalive_timer.expires;
 	} else {
 		timer_active	= 0;
 		timer_expires = jiffies;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index a58094b0acd4f..566e4bf1b5eff 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -755,8 +755,9 @@ EXPORT_IPV6_MOD_GPL(tcp_set_keepalive);
 
 static void tcp_keepalive_timer (struct timer_list *t)
 {
-	struct sock *sk = from_timer(sk, t, sk_timer);
-	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct inet_connection_sock *icsk =
+		from_timer(icsk, t, icsk_keepalive_timer);
+	struct sock *sk = &icsk->icsk_inet.sk;
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 elapsed;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 84efaf846f07f..c8c6b7625e6d4 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2177,9 +2177,9 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
 		timer_expires	= icsk->icsk_timeout;
-	} else if (timer_pending(&sp->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active	= 2;
-		timer_expires	= sp->sk_timer.expires;
+		timer_expires	= icsk->icsk_keepalive_timer.expires;
 	} else {
 		timer_active	= 0;
 		timer_expires = jiffies;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 009020ee1e041..f6968833f83d0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -154,6 +154,9 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
 	pr_debug("msk=%p\n", msk);
+
+	if (msk->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8b61fe656ec66..a84b635d8ccbf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -414,9 +414,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
-
-	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer(sk, &sk->mptcp_retransmit_timer);
 	mptcp_sk(sk)->timer_ival = 0;
 }
 
@@ -973,12 +971,11 @@ static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list
 
 static bool mptcp_rtx_timer_pending(struct sock *sk)
 {
-	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
+	return timer_pending(&sk->mptcp_retransmit_timer);
 }
 
 static void mptcp_reset_rtx_timer(struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
 	unsigned long tout;
 
 	/* prevent rescheduling on close */
@@ -986,7 +983,7 @@ static void mptcp_reset_rtx_timer(struct sock *sk)
 		return;
 
 	tout = mptcp_sk(sk)->timer_ival;
-	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
+	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
 }
 
 bool mptcp_schedule_work(struct sock *sk)
@@ -2390,9 +2387,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 static void mptcp_retransmit_timer(struct timer_list *t)
 {
-	struct inet_connection_sock *icsk = from_timer(icsk, t,
-						       icsk_retransmit_timer);
-	struct sock *sk = &icsk->icsk_inet.sk;
+	struct sock *sk = from_timer(sk, t, mptcp_retransmit_timer);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	bh_lock_sock(sk);
@@ -2410,7 +2405,9 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 
 static void mptcp_tout_timer(struct timer_list *t)
 {
-	struct sock *sk = from_timer(sk, t, sk_timer);
+	struct inet_connection_sock *icsk =
+		from_timer(icsk, t, mptcp_tout_timer);
+	struct sock *sk = &icsk->icsk_inet.sk;
 
 	mptcp_schedule_work(sk);
 	sock_put(sk);
@@ -2853,7 +2850,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	 */
 	timeout = inet_csk(sk)->icsk_mtup.probe_timestamp ? close_timeout : fail_tout;
 
-	sk_reset_timer(sk, &sk->sk_timer, timeout);
+	sk_reset_timer(sk, &inet_csk(sk)->mptcp_tout_timer, timeout);
 }
 
 static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
@@ -2969,6 +2966,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->first_pending = NULL;
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	WRITE_ONCE(msk->rmem_released, 0);
+	inet_csk(sk)->icsk_rto_min = TCP_RTO_MIN;
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 
@@ -2986,9 +2984,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
 
-	/* re-use the csk retrans timer for MPTCP-level retrans */
-	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
+	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
+	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
 }
 
 static void mptcp_ca_reset(struct sock *sk)
@@ -3190,7 +3187,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	might_sleep();
 
 	mptcp_stop_rtx_timer(sk);
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &inet_csk(sk)->mptcp_tout_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
 
@@ -3295,8 +3292,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
-	if (msk->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
+	mptcp_pm_connection_closed(msk);
 
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
@@ -3362,8 +3358,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_stop_rtx_timer(sk);
 	mptcp_stop_tout_timer(sk);
 
-	if (msk->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
+	mptcp_pm_connection_closed(msk);
 
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 36f3f5b34a5d6..c1accd3dc6bfa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -844,7 +844,7 @@ static inline void mptcp_stop_tout_timer(struct sock *sk)
 	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &inet_csk(sk)->mptcp_tout_timer);
 	inet_csk(sk)->icsk_mtup.probe_timestamp = 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index 92267abb462fc..be540970fcc1f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -103,9 +103,9 @@ static int dump_tcp_sock(struct seq_file *seq, struct tcp_sock *tp,
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
 		timer_expires = icsk->icsk_timeout;
-	} else if (timer_pending(&sp->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active = 2;
-		timer_expires = sp->sk_timer.expires;
+		timer_expires = icsk->icsk_keepalive_timer.expires;
 	} else {
 		timer_active = 0;
 		timer_expires = bpf_jiffies64();
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index 943f7bba180e7..9f72398fc3cc3 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -103,9 +103,9 @@ static int dump_tcp6_sock(struct seq_file *seq, struct tcp6_sock *tp,
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
 		timer_expires = icsk->icsk_timeout;
-	} else if (timer_pending(&sp->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active = 2;
-		timer_expires = sp->sk_timer.expires;
+		timer_expires = icsk->icsk_keepalive_timer.expires;
 	} else {
 		timer_active = 0;
 		timer_expires = bpf_jiffies64();
-- 
2.53.0

