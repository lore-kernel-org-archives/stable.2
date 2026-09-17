Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44463CB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611539; cv=none; b=doxFt8HGQ2NPQ6QgY6ZbktHLlQcqlt7bzlk7gOAN2+MZNORJ8P+ogN8nxsdNkwl/Qwu5NyX5H8ioc8DCQL5cI5ckERZXb3EB2Ho1XsqQJdBHakEWvfCWK4dzzyXSX6hnqu2/G6Vvfes8v4mHXOiMZnPPVPBBwVDayvESLO1BtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611539; c=relaxed/simple;
	bh=K31SX2U2yOPnJ03MNYfCRogw9EOoZamaQhJL08kOe6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3KSC/0gBIJ1x7vwVmX8Zz30MU1b04eAFIPTtDj4lY6FBRTcmQPQGtdHcklaey5AY4/gYRlYF8DCEaYNcbX8+IoOw1693ORrq2bUgv5rkgNMP8u5o4Xi3r3dObmKOw8AvypLHi5Tfob1yp4RegBSHI5d9hFkvaGRxJ7AmcYZcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBwOVQkZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBwOVQkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92ED1F000FF;
	Thu, 17 Sep 2026 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611536;
	bh=SusMg6btwkeij6iCdKfrXIYvJP/jHR4AIsVlXs5xj1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBwOVQkZYnMsn0Ubj8PQOlrfD1YtZdLNHMe8FjJ9Lr21HUtMLyFOz79K7i7/x48p6
	 ZjyvlE+OrmzzUxTFMEwU8d5HEHRXJGRrY8IGc88Ia5291oJxVJBgqo07Ue5fjcI/k1
	 4EnwvheV0sF4IzkccgyKGgqUQM4XUYJaJOms5LGNWA1CgVo6fIhPIdIIQB66w5mja6
	 s4KT/g2EzX5N9ZQ/yu6k2g2ByStCMed1+qN90oNpF8pBmvk90btECD7QC3DXWlAv2Y
	 wwwVraR+k8c2N/Z14lUZVt9su95vfbLwHkOzVmvvQUC/5Hn4powsThyNHisFxDla/p
	 yhL3YoSb5zsTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] tcp: rename icsk_timeout() to tcp_timeout_expires()
Date: Wed, 16 Sep 2026 22:18:51 -0400
Message-ID: <20260917021854.3809939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091613-tank-dimmed-fed6@gregkh>
References: <2026091613-tank-dimmed-fed6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3a6e8fd0bf4042c572dc52e634878b9aca02970d ]

In preparation of sk->tcp_timeout_timer introduction,
rename icsk_timeout() helper and change its argument to plain
'const struct sock *sk'.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20251124175013.1473655-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e2ab913f68c7 ("mptcp: do not reschedule the RTX timer for fallback sockets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h | 5 ++---
 net/ipv4/inet_diag.c               | 4 ++--
 net/ipv4/tcp_ipv4.c                | 4 ++--
 net/ipv4/tcp_timer.c               | 6 +++---
 net/ipv6/tcp_ipv6.c                | 4 ++--
 net/mptcp/protocol.c               | 2 +-
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index afec146b8bafd..3a239b655d548 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -186,10 +186,9 @@ static inline void inet_csk_delack_init(struct sock *sk)
 	memset(&inet_csk(sk)->icsk_ack, 0, sizeof(inet_csk(sk)->icsk_ack));
 }
 
-static inline unsigned long
-icsk_timeout(const struct inet_connection_sock *icsk)
+static inline unsigned long tcp_timeout_expires(const struct sock *sk)
 {
-	return READ_ONCE(icsk->icsk_retransmit_timer.expires);
+	return READ_ONCE(inet_csk(sk)->icsk_retransmit_timer.expires);
 }
 
 static inline unsigned long
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index f0b6c5a411a20..9f63c09439a05 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -287,12 +287,12 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		r->idiag_timer = 1;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_retransmits);
 		r->idiag_expires =
-			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
+			jiffies_delta_to_msecs(tcp_timeout_expires(sk) - jiffies);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		r->idiag_timer = 4;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
-			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
+			jiffies_delta_to_msecs(tcp_timeout_expires(sk) - jiffies);
 	} else if (timer_pending(&sk->sk_timer)) {
 		r->idiag_timer = 2;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index dcd7c9f12c253..b4ee14c769213 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2928,10 +2928,10 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active	= 1;
-		timer_expires	= icsk_timeout(icsk);
+		timer_expires	= tcp_timeout_expires(sk);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
-		timer_expires	= icsk_timeout(icsk);
+		timer_expires	= tcp_timeout_expires(sk);
 	} else if (timer_pending(&sk->sk_timer)) {
 		timer_active	= 2;
 		timer_expires	= sk->sk_timer.expires;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 9ebce13fa8ad8..9565b37773b87 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -513,7 +513,7 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 	 * and tp->rcv_tstamp might very well have been written recently.
 	 * rcv_delta can thus be negative.
 	 */
-	rcv_delta = icsk_timeout(icsk) - tp->rcv_tstamp;
+	rcv_delta = tcp_timeout_expires(sk) - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
 
@@ -700,9 +700,9 @@ void tcp_write_timer_handler(struct sock *sk)
 	    !icsk->icsk_pending)
 		return;
 
-	if (time_after(icsk_timeout(icsk), jiffies)) {
+	if (time_after(tcp_timeout_expires(sk), jiffies)) {
 		sk_reset_timer(sk, &icsk->icsk_retransmit_timer,
-			       icsk_timeout(icsk));
+			       tcp_timeout_expires(sk));
 		return;
 	}
 	tcp_mstamp_refresh(tcp_sk(sk));
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e1db70c20943..fa94bdafbd02a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2200,10 +2200,10 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active	= 1;
-		timer_expires	= icsk_timeout(icsk);
+		timer_expires	= tcp_timeout_expires(sp);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
-		timer_expires	= icsk_timeout(icsk);
+		timer_expires	= tcp_timeout_expires(sp);
 	} else if (timer_pending(&sp->sk_timer)) {
 		timer_active	= 2;
 		timer_expires	= sp->sk_timer.expires;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1bf9b1dfc431c..4c318438b844c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -533,7 +533,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 	return inet_csk(ssk)->icsk_pending && !subflow->stale_count ?
-	       icsk_timeout(inet_csk(ssk)) - jiffies : 0;
+	       tcp_timeout_expires(ssk) - jiffies : 0;
 }
 
 static void mptcp_set_timeout(struct sock *sk)
-- 
2.53.0

