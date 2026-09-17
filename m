Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273072DCF55
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613434; cv=none; b=uvKJ8x9WSioynoDdVW/c7rnf+d94cJIQ649Df/Tr6A0aftYHhMTarIEDsvk60RXBmCYoX6txAiRFa8/wA2MnhXQpi5Xvx9DrFTPBfuwBgf3RR7GupTfDfb8rJY8UAtV3TuKg3KXBSdzbWBMR4rc7q2OppFW6muFeId1UJVewsGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613434; c=relaxed/simple;
	bh=2HNdOmQPYAtYGJliFUc7aUuz9CvcKLzKMth08RL3s+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTUTpeYCwJk5tWKxBBEx9vHjWFoY5TQplDP5sy2KdosUiPlbyg5UM/xZFOvrCq5YPPUWQpC25+B/eYwJC8OvSGHJMByd1HPvSWfYLaRrGtHt71cOm0QNj136mvXAJrExPDuWJ5G2PIdo+RpdwLiJzfMLXhVM/xsUmldxKf+eWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5L6kQL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5L6kQL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAED1F0089B;
	Thu, 17 Sep 2026 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613417;
	bh=vmuPL6kNXASDMLe5zZMjZPZfIWHHHnDRu4Uv9chzl1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H5L6kQL5XomXbhb2yBs7aJ1tO8PObm8kW+6DJFKJJUO/EZkVTki/FCsxbCk/IfdBW
	 SDmWwndKwb9jFan4ufdOqdcxsFjMPMnkdyicPX4brO/nBrWkV5L80fnl6eF08uAt7y
	 ji9l9CqvCcNWK5HcYFjhKzyd2gJ8x7fLo+pwNVPK9nQNNHMeuP3gWjAWRjpDIaS330
	 C4CRd4z739v9m2jh0I1i5uI3p4rKvh2Slv/KB2zylLtg27G9DbOOCwe3jc3m3ERoxZ
	 1MffwrYNHKyUcSzjfpoSD/IOAY4jKJFp2IDLXSsj6aXHs/6vs1T3BLKmSAmJZV+n4E
	 TBk6fUjCIM3cA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] tcp: rename icsk_timeout() to tcp_timeout_expires()
Date: Wed, 16 Sep 2026 22:50:12 -0400
Message-ID: <20260917025015.3917201-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091620-haziness-luridness-ad42@gregkh>
References: <2026091620-haziness-luridness-ad42@gregkh>
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
Stable-dep-of: 85c580b0d859 ("mptcp: prevent race between disconnect() and rtx")
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

