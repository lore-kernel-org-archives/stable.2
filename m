Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358E534475
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652092; cv=none; b=C+Z7yMLdS/2N7aXFGJj93pvYyXX9YrmeseDX4toUTOs8Fu00M2EwfRUKlJsnoIJuGE+krlOmEUsQ+M9QN2oO5a8QePTmZHa0IUNweKdBOFkxtCw6Jdy9LAnqNYK+w1wgqmLPiqkPCnr0FAY3L9nS75clq5LXosoWBcCGpvI36CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652092; c=relaxed/simple;
	bh=OJfGnb52eBOYWglmJbZpz0pNPaVTANDl6LDhXhZRAt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnVsbl2AnOnju4MleH76jlIBXvO6BdiwM8XDLlhkoBfvdxLuUT21mmrSQVrNIv7Q516jbiV+UMGFKmHwYRJ/4tWkm2fgPp5rIst1Vt3aMdf9jxhrHDqgFsCfa38eVWtHhpW56nvMP8Tr1p2cBuyQQ6Egn+HjJFNh2hiq4zrgbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLfs4UPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLfs4UPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004EB1F000FF;
	Thu, 17 Sep 2026 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652082;
	bh=NgyKiXAuacYzOJlNHDsbz3y7f+oMrQ/BF7s7Uld+yQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLfs4UPrNTcPhoWrnJ4paMRq17A3PhIWMI7mEYNeyc/I1jtCW3ucHsek+Jtbw5H92
	 jDEFxTv/a9daTX8z38vJwt3Z+bNtL3sCtVGCbtUe8EPe05WugtEKgA30J1BNIn/WcC
	 4xQFHjdfbRaXpYBseAUebYz5oTfwPrCNRGpnm4rzR2On/Zj10Y4AnVngf7eU6ra/GH
	 cCGKBywDHNNblvrvNL6yaJTRP94xroZbKVlprnBJUxADV4kAZCAOgtfYMwemhyNT17
	 8v7soc2vUsl0BBPV2aXLy4wAfCfSxJG8lGWHoSuCzPcMLPWOpyXiKdoQOFJ58sh75j
	 n1Ql2beyNunQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] tcp: introduce icsk->icsk_keepalive_timer
Date: Thu, 17 Sep 2026 09:34:39 -0400
Message-ID: <20260917133440.405725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091622-thieving-raffle-4915@gregkh>
References: <2026091622-thieving-raffle-4915@gregkh>
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

Backport to 6.1 as a dependency of 85c580b0d859 ("mptcp: prevent
race between disconnect() and rtx"):

Keep icsk_timeout and the existing TCP retransmit timer. Update the
existing inet_csk keepalive helpers in inet_connection_sock.c instead
of introducing the newer TCP helpers, and use from_timer() in the
callbacks. Adjust the DCCP callback, since DCCP still shares the inet_csk
timer setup in this branch. Omit the absent net_cachelines document.

Also alias sk_timer as mptcp_retransmit_timer and move all MPTCP
retransmit timer users there. The target directly stops this timer and
the new mptcp_tout_timer, so both names must identify the timers actually
in use. Initialize the MPTCP icsk_rto_min to this branch's TCP_RTO_MIN so
the target restores a valid retransmit interval during disconnect.
No functions are added.

[ sashal: Reduced backport -- upstream 08dfe370239e5 touches 11 file(s), this
  backport carries 12. Not backported here:
  Documentation/networking/net_cachelines/inet_connection_sock.rst
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 85c580b0d859 ("mptcp: prevent race between disconnect() and rtx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h            | 11 ++++++--
 include/net/sock.h                            |  6 +++-
 net/dccp/timer.c                              |  4 ++-
 net/ipv4/inet_connection_sock.c               | 10 +++----
 net/ipv4/inet_diag.c                          |  4 +--
 net/ipv4/tcp_ipv4.c                           |  4 +--
 net/ipv4/tcp_timer.c                          |  5 ++--
 net/ipv6/tcp_ipv6.c                           |  4 +--
 net/mptcp/protocol.c                          | 28 +++++++++----------
 net/mptcp/protocol.h                          |  2 +-
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |  4 +--
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |  4 +--
 12 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 9760ba0516b6c..51be99667a23c 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -63,6 +63,9 @@ struct inet_connection_sock_af_ops {
  * @icsk_bind2_hash:	   Bind node in the bhash2 table
  * @icsk_timeout:	   Timeout
  * @icsk_retransmit_timer: Resend (no ack)
+ * @icsk_delack_timer:     Delayed ACK timer
+ * @icsk_keepalive_timer:  Keepalive timer
+ * @mptcp_tout_timer:      MPTCP timeout timer
  * @icsk_rto:		   Retransmit timeout
  * @icsk_pmtu_cookie	   Last pmtu seen by socket
  * @icsk_ca_ops		   Pluggable congestion control hook
@@ -89,8 +92,12 @@ struct inet_connection_sock {
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
index 9fe621f985740..1aada87bde5f6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -315,6 +315,7 @@ struct sk_filter;
   *	@sk_txrehash: enable TX hash rethink
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
+  *	@mptcp_retransmit_timer: MPTCP retransmit timer
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING flags
@@ -459,7 +460,10 @@ struct sock {
 	__u32			sk_dst_pending_confirm;
 	u32			sk_pacing_status; /* see enum sk_pacing */
 	long			sk_sndtimeo;
-	struct timer_list	sk_timer;
+	union {
+		struct timer_list sk_timer;
+		struct timer_list mptcp_retransmit_timer;
+	};
 	__u32			sk_priority;
 	__u32			sk_mark;
 	unsigned long		sk_pacing_rate; /* bytes per second */
diff --git a/net/dccp/timer.c b/net/dccp/timer.c
index 27a3b37acd2ef..ff9c0184e3f68 100644
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
index 6184534aa1bf5..5e31302b42505 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -749,7 +749,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 
 	timer_setup(&icsk->icsk_retransmit_timer, retransmit_handler, 0);
 	timer_setup(&icsk->icsk_delack_timer, delack_handler, 0);
-	timer_setup(&sk->sk_timer, keepalive_handler, 0);
+	timer_setup(&icsk->icsk_keepalive_timer, keepalive_handler, 0);
 	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
 }
 EXPORT_SYMBOL(inet_csk_init_xmit_timers);
@@ -762,7 +762,7 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 
 	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &icsk->icsk_keepalive_timer);
 }
 EXPORT_SYMBOL(inet_csk_clear_xmit_timers);
 
@@ -777,18 +777,18 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 
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
index 2bd5d0ed7a6fc..02d8a63f39ebf 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -310,11 +310,11 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
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
index ec3b0aa0a6260..aa99d7cd4bfec 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2646,9 +2646,9 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
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
index 3662b49ce71ae..d086026018d62 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -706,8 +706,9 @@ EXPORT_SYMBOL_GPL(tcp_set_keepalive);
 
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
index d3952b058453f..3d7bfa0e7be42 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2000,9 +2000,9 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2ce20884d7305..70810fa673c34 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -426,9 +426,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
-
-	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer(sk, &sk->mptcp_retransmit_timer);
 	mptcp_sk(sk)->timer_ival = 0;
 }
 
@@ -976,12 +974,11 @@ static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list
 
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
@@ -989,7 +986,7 @@ static void mptcp_reset_rtx_timer(struct sock *sk)
 		return;
 
 	tout = mptcp_sk(sk)->timer_ival;
-	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
+	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
 }
 
 bool mptcp_schedule_work(struct sock *sk)
@@ -2347,9 +2344,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 static void mptcp_retransmit_timer(struct timer_list *t)
 {
-	struct inet_connection_sock *icsk = from_timer(icsk, t,
-						       icsk_retransmit_timer);
-	struct sock *sk = &icsk->icsk_inet.sk;
+	struct sock *sk = from_timer(sk, t, mptcp_retransmit_timer);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	bh_lock_sock(sk);
@@ -2367,7 +2362,9 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 
 static void mptcp_tout_timer(struct timer_list *t)
 {
-	struct sock *sk = from_timer(sk, t, sk_timer);
+	struct inet_connection_sock *icsk =
+		from_timer(icsk, t, mptcp_tout_timer);
+	struct sock *sk = &icsk->icsk_inet.sk;
 
 	mptcp_schedule_work(sk);
 	sock_put(sk);
@@ -2799,7 +2796,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	 */
 	timeout = inet_csk(sk)->icsk_mtup.probe_timestamp ? close_timeout : fail_tout;
 
-	sk_reset_timer(sk, &sk->sk_timer, timeout);
+	sk_reset_timer(sk, &inet_csk(sk)->mptcp_tout_timer, timeout);
 }
 
 static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
@@ -2917,6 +2914,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first_pending = NULL;
 	msk->rmem_fwd_alloc = 0;
 	WRITE_ONCE(msk->rmem_released, 0);
+	/* MPTCP sockets do not go through tcp_init_sock(). */
+	inet_csk(sk)->icsk_rto_min = TCP_RTO_MIN;
 	msk->timer_ival = TCP_RTO_MIN;
 
 	WRITE_ONCE(msk->first, NULL);
@@ -2929,9 +2928,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
 
-	/* re-use the csk retrans timer for MPTCP-level retrans */
-	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
+	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
+	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
 
 	return 0;
 }
@@ -3108,7 +3106,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	might_sleep();
 
 	mptcp_stop_rtx_timer(sk);
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &inet_csk(sk)->mptcp_tout_timer);
 	msk->pm.status = 0;
 
 	sk->sk_prot->destroy(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e835028fc4e50..cc70b15f8d692 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -697,7 +697,7 @@ static inline void mptcp_stop_tout_timer(struct sock *sk)
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

