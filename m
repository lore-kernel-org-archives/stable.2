Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA93806D7
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611539; cv=none; b=ekqAv7a6IToVzAUFw2ICORFv0+JI+NFFCHc7l8qjVmH/hK6mffSZFkAtrNpvbpy3vz83xLEh8tI8b7VRDq5koWIKjwpXk/Ga2hl4eYnqlKTonyCKFxErsyp3R/IcxTJk1GHx+6hWapEyPGoWQ9gL5Ro0LUx2XpxOMD/46w8SJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611539; c=relaxed/simple;
	bh=LgRKbkTQQ5OgKqhkJSSNd9cABCzHqbYoBIV487aGtPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehEr1m1JzJmbNbTpEzz98Zne8QYwWFx4EMUIxKxUS1k51EZuEJPlskE2mEXgxwn8+lXlkTLJxdjhPer+lLmKoxAbrwO6A2kl/SrP9TOraLBuUaGUtDOUW4n3pUh6uLx6KjIXlqjdTNw4dFVanUTa6grtnOYYfW1RMQh+FUinte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLn6uktF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLn6uktF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0951F00893;
	Thu, 17 Sep 2026 02:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611538;
	bh=kqif8VOFr/W1dUuU7+R6Req/qc73opCNHzk3lTamntM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLn6uktFagOCzkkJb6qSBzk97OAemCn8za5hALnlbLXvdXO19NluFmplnS7vi2Qnj
	 CU752voO7szaqJP/8S9HWqI4Y7pKB9CttIiJm4J7xPhZry/2AW/1sdcus+qb8v7h+K
	 UnTRffwldZp+/qOPz5qh7MfwA309RxEC8zWy2Z16Jx0EZuCC6eV5MzfO1RzAoFIlYn
	 aJHNUJDoTxroxlYBVI4QRckHAbjLt0zNX4Um8+9N/9TAeBDbO8zyftG0+fCoamIfRx
	 NHgkaRTb66uHUqfiBTtiF+0bhXxuUlBd3xuE/K4g33j8eMAP8j++FgoNDIXOTKLkMj
	 1tc390WvpT0LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] tcp: remove icsk->icsk_retransmit_timer
Date: Wed, 16 Sep 2026 22:18:53 -0400
Message-ID: <20260917021854.3809939-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021854.3809939-1-sashal@kernel.org>
References: <2026091613-tank-dimmed-fed6@gregkh>
 <20260917021854.3809939-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9a5e5334adc039fa652aa071ea95b18db0bc1f43 ]

Now sk->sk_timer is no longer used by TCP keepalive, we can use
its storage for TCP and MPTCP retransmit timers for better
cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20251124175013.1473655-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e2ab913f68c7 ("mptcp: do not reschedule the RTX timer for fallback sockets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net_cachelines/inet_connection_sock.rst       |  1 -
 include/net/inet_connection_sock.h                |  8 +++-----
 include/net/sock.h                                |  9 +++++++--
 net/ipv4/inet_connection_sock.c                   |  6 +++---
 net/ipv4/tcp_timer.c                              |  8 +++-----
 net/mptcp/protocol.c                              | 15 +++++----------
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c |  4 ++--
 8 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index 4f65de2def8c9..cc2000f55c298 100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -12,7 +12,6 @@ struct inet_sock                    icsk_inet              read_mostly         r
 struct request_sock_queue           icsk_accept_queue
 struct inet_bind_bucket             icsk_bind_hash         read_mostly                             tcp_set_state
 struct inet_bind2_bucket            icsk_bind2_hash        read_mostly                             tcp_set_state,inet_put_port
-struct timer_list                   icsk_retransmit_timer  read_write                              inet_csk_reset_xmit_timer,tcp_connect
 struct timer_list                   icsk_delack_timer      read_mostly                             inet_csk_reset_xmit_timer,tcp_connect
 struct timer_list                   icsk_keepalive_timer
 u32                                 icsk_rto               read_write                              tcp_cwnd_validate,tcp_schedule_loss_probe,tcp_connect_init,tcp_connect,tcp_write_xmit,tcp_push_one
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 53de8565e3c27..d50e0afc3193f 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -58,7 +58,6 @@ struct inet_connection_sock_af_ops {
  * @icsk_accept_queue:	   FIFO of established children
  * @icsk_bind_hash:	   Bind node
  * @icsk_bind2_hash:	   Bind node in the bhash2 table
- * @icsk_retransmit_timer: Resend (no ack)
  * @icsk_delack_timer:     Delayed ACK timer
  * @icsk_keepalive_timer:  Keepalive timer
  * @mptcp_tout_timer: mptcp timer
@@ -86,7 +85,6 @@ struct inet_connection_sock {
 	struct request_sock_queue icsk_accept_queue;
 	struct inet_bind_bucket	  *icsk_bind_hash;
 	struct inet_bind2_bucket  *icsk_bind2_hash;
-	struct timer_list	  icsk_retransmit_timer;
 	struct timer_list	  icsk_delack_timer;
 	union {
 		struct timer_list icsk_keepalive_timer;
@@ -195,7 +193,7 @@ static inline void inet_csk_delack_init(struct sock *sk)
 
 static inline unsigned long tcp_timeout_expires(const struct sock *sk)
 {
-	return READ_ONCE(inet_csk(sk)->icsk_retransmit_timer.expires);
+	return READ_ONCE(sk->tcp_retransmit_timer.expires);
 }
 
 static inline unsigned long
@@ -211,7 +209,7 @@ static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 	if (what == ICSK_TIME_RETRANS || what == ICSK_TIME_PROBE0) {
 		smp_store_release(&icsk->icsk_pending, 0);
 #ifdef INET_CSK_CLEAR_TIMERS
-		sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+		sk_stop_timer(sk, &sk->tcp_retransmit_timer);
 #endif
 	} else if (what == ICSK_TIME_DACK) {
 		smp_store_release(&icsk->icsk_ack.pending, 0);
@@ -243,7 +241,7 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 	if (what == ICSK_TIME_RETRANS || what == ICSK_TIME_PROBE0 ||
 	    what == ICSK_TIME_LOSS_PROBE || what == ICSK_TIME_REO_TIMEOUT) {
 		smp_store_release(&icsk->icsk_pending, what);
-		sk_reset_timer(sk, &icsk->icsk_retransmit_timer, when);
+		sk_reset_timer(sk, &sk->tcp_retransmit_timer, when);
 	} else if (what == ICSK_TIME_DACK) {
 		smp_store_release(&icsk->icsk_ack.pending,
 				  icsk->icsk_ack.pending | ICSK_ACK_TIMER);
diff --git a/include/net/sock.h b/include/net/sock.h
index 50b9178cc827f..9e13e1233e417 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -303,6 +303,8 @@ struct sk_filter;
   *	@sk_txrehash: enable TX hash rethink
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
+  *	@tcp_retransmit_timer: tcp retransmit timer
+  *	@mptcp_retransmit_timer: mptcp retransmit timer
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING flags
@@ -480,8 +482,11 @@ struct sock {
 	u32			sk_dst_pending_confirm;
 	u32			sk_pacing_status; /* see enum sk_pacing */
 	struct page_frag	sk_frag;
-	struct timer_list	sk_timer;
-
+	union {
+		struct timer_list	sk_timer;
+		struct timer_list	tcp_retransmit_timer;
+		struct timer_list	mptcp_retransmit_timer;
+	};
 	unsigned long		sk_pacing_rate; /* bytes per second */
 	atomic_t		sk_zckey;
 	atomic_t		sk_tskey;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 2976b819ff5ce..6193db63b2973 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -748,7 +748,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
-	timer_setup(&icsk->icsk_retransmit_timer, retransmit_handler, 0);
+	timer_setup(&sk->tcp_retransmit_timer, retransmit_handler, 0);
 	timer_setup(&icsk->icsk_delack_timer, delack_handler, 0);
 	timer_setup(&icsk->icsk_keepalive_timer, keepalive_handler, 0);
 	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
@@ -761,7 +761,7 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 	smp_store_release(&icsk->icsk_pending, 0);
 	smp_store_release(&icsk->icsk_ack.pending, 0);
 
-	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer(sk, &sk->tcp_retransmit_timer);
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
 	sk_stop_timer(sk, &icsk->icsk_keepalive_timer);
 }
@@ -776,7 +776,7 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 	smp_store_release(&icsk->icsk_pending, 0);
 	smp_store_release(&icsk->icsk_ack.pending, 0);
 
-	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer_sync(sk, &sk->tcp_retransmit_timer);
 	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
 	sk_stop_timer_sync(sk, &icsk->icsk_keepalive_timer);
 }
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 4f2df3a692115..a26d161b2a649 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -701,7 +701,7 @@ void tcp_write_timer_handler(struct sock *sk)
 		return;
 
 	if (time_after(tcp_timeout_expires(sk), jiffies)) {
-		sk_reset_timer(sk, &icsk->icsk_retransmit_timer,
+		sk_reset_timer(sk, &sk->tcp_retransmit_timer,
 			       tcp_timeout_expires(sk));
 		return;
 	}
@@ -728,12 +728,10 @@ void tcp_write_timer_handler(struct sock *sk)
 
 static void tcp_write_timer(struct timer_list *t)
 {
-	struct inet_connection_sock *icsk =
-			timer_container_of(icsk, t, icsk_retransmit_timer);
-	struct sock *sk = &icsk->icsk_inet.sk;
+	struct sock *sk = timer_container_of(sk, t, tcp_retransmit_timer);
 
 	/* Avoid locking the socket when there is no pending event. */
-	if (!smp_load_acquire(&icsk->icsk_pending))
+	if (!smp_load_acquire(&inet_csk(sk)->icsk_pending))
 		goto out;
 
 	bh_lock_sock(sk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5f24f4c4a7d7e..2dd6840089f86 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -425,9 +425,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
-
-	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer(sk, &sk->mptcp_retransmit_timer);
 	mptcp_sk(sk)->timer_ival = 0;
 }
 
@@ -936,12 +934,11 @@ static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list
 
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
@@ -949,7 +946,7 @@ static void mptcp_reset_rtx_timer(struct sock *sk)
 		return;
 
 	tout = mptcp_sk(sk)->timer_ival;
-	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
+	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
 }
 
 bool mptcp_schedule_work(struct sock *sk)
@@ -2328,9 +2325,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 static void mptcp_retransmit_timer(struct timer_list *t)
 {
-	struct inet_connection_sock *icsk = timer_container_of(icsk, t,
-							       icsk_retransmit_timer);
-	struct sock *sk = &icsk->icsk_inet.sk;
+	struct sock *sk = timer_container_of(sk, t, mptcp_retransmit_timer);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	bh_lock_sock(sk);
@@ -2937,7 +2932,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	spin_lock_init(&msk->fallback_lock);
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
-	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
+	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index 685811326a041..b1e509b231cd9 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -99,10 +99,10 @@ static int dump_tcp_sock(struct seq_file *seq, struct tcp_sock *tp,
 	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active = 1;
-		timer_expires = icsk->icsk_retransmit_timer.expires;
+		timer_expires = sp->tcp_retransmit_timer.expires;
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
-		timer_expires = icsk->icsk_retransmit_timer.expires;
+		timer_expires = sp->tcp_retransmit_timer.expires;
 	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active = 2;
 		timer_expires = icsk->icsk_keepalive_timer.expires;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index 0f4a927127517..dbc7166aee91f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -99,10 +99,10 @@ static int dump_tcp6_sock(struct seq_file *seq, struct tcp6_sock *tp,
 	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active = 1;
-		timer_expires = icsk->icsk_retransmit_timer.expires;
+		timer_expires = sp->tcp_retransmit_timer.expires;
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
-		timer_expires = icsk->icsk_retransmit_timer.expires;
+		timer_expires = sp->tcp_retransmit_timer.expires;
 	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active = 2;
 		timer_expires = icsk->icsk_keepalive_timer.expires;
-- 
2.53.0

