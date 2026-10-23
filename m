Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738170;
	b=mDJtiEJlVZsq/KEudQ5RJ77mSMkIF7r7PeULMBjtZppAGy4sVI81QQuaSKez5nw0B85/
	 7oKVO7HAygdXUsiKdqn3DAbFjAuYYpnc2uLUq9+AnRsiPxmZ73PMxh4tv7l2fYwcfj6ai
	 vzZZtipNls1oCkoBMHufqUOPwwEnbBLGifjbBWjuYUStoOLvVyaAV9827lCLzCNRaASZz
	 i3rbKHaBRQSjJbHwrXhFc0nHNgN+YwZ2S2m+DjxRdDAiLMX/t5P3kKhJeX/ctAFCIAmIZ
	 DAybNKR8tlgFBE/r77y+5N46TfIhtZ93Ww2pmhCzacTFl6UJ7NzeMBa0cP+w10cVQjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738170;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iOmSfo1BLUabRqGhTTq7VtNuOK5zj3apC9gTPwUCSRY=;
	b=HhiJY+Ad0eiz9pQYbYz/DU+hqsFzMNMzPGTxbVMAg2aCdONpyDQb7mRUT9zHQppej5Zv
	 YS8hk5kPuyG/hxId9RWZ40lYnoLxvYlpUGks8QtKwvVt0c7swqdchtN8ry/CAlcQU1Vwk
	 T6JhQFEg3ZBkuCjelGuNF7jb6xKSQk0/KtpLpVDgPLeuZlB9r0iqlQ2obWdtMa9NfPdDp
	 GKm4HgsMy/R7+xANzIH75ABz2fGSDlMR+h/48g98zmKkhRyMJs1HYohz9SEHsG7aret3g
	 ugv0m2EZ+lZlBkS3T9K0aRL3cfNlCHb5ANe/CiByTpi/+9I41AbXYvP3aYIVTPBbi6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=baxAwx+6;
	arc=none smtp.remote-ip=91.218.175.229
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA89606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA89606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=baxAwx+6
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Vv4j5Pv1cnPIxvBGz2v55+iSe+rgTOEu0/znzRKQCBY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792738167; v=1; x=1793342967;
 b=baxAwx+6S2aI5n6HuxPzPBDBJFfeDGL8LKvYvZJhQqQ/gli7hXwNIygmiOgC5RH82DNmHw30
 IbY8XlqR7OBfmk033gTyQBzqXqwtrbQhwvxwotoakoPyNpSjINHEK9jZWc2rfLw3vAnd/HqGPuD
 qJifiYWTtULfmGxiGNPoFUIU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e5a3d02f2eeff016;
	Fri, 23 Oct 2026 06:49:27 +0000
X-Mizu-Trace-ID: e5a3d02f2eeff016
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] tcp: fix shift-out-of-bounds in SYN-ACK retransmit timers
Date: Fri, 23 Oct 2026 14:49:10 +0800
Message-ID: <20261023064915.401112-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_synack_retries is a u8 sysctl with no upper bound (0..255), and
TCP_DEFER_ACCEPT can derive a comparable count. Both feed the
max_retries / max_syn_ack_retries that decide how long a request_sock
keeps retransmitting SYN-ACKs. req->num_timeout is bumped on every
SYN-ACK timeout and then used as a shift amount:

	/* tcp_reqsk_timeout() */
	u64 timeout = (u64)req->timeout << req->num_timeout;
	/* tcp_fastopen_synack_timer() */
	req->timeout << req->num_timeout

Set tcp_synack_retries high enough and num_timeout climbs past the width
of the shifted type, which is UB:

  UBSAN: shift-out-of-bounds in ./include/net/tcp.h:917:34
  shift exponent 64 is too large for 64-bit type 'long long unsigned int'
  Call Trace:
   <TASK>
   dump_stack_lvl+0xc1/0xf0
   dump_stack+0x10/0x20
   __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
   reqsk_timer_handler.cold+0x1c/0x5d
   call_timer_fn+0x17d/0x510
   __run_timers+0x662/0xab0
   run_timer_softirq+0xdf/0x260
   handle_softirqs+0x204/0x9b0
   __irq_exit_rcu+0x13c/0x220
   irq_exit_rcu+0xe/0x20
   sysvec_apic_timer_interrupt+0x40/0xd0
   asm_sysvec_apic_timer_interrupt+0x1b/0x20

num_timeout is also a 7-bit field (max 127). Once max_retries goes above
127 the "num_timeout >= max_retries" expiry check can never be true, so
the reqsk keeps retransmitting SYN-ACKs and never gives up.

Leave the one-byte sysctl range alone and fix both in the consumers:

 - bound the shift amount in tcp_reqsk_timeout_sk(). The result is
   clamped to tcp_rto_max() anyway and a num_timeout well under 30
   already saturates that, so capping the shift at 30 changes no
   reachable behaviour and drops the UB.
 - cap max_retries / max_syn_ack_retries at MAX_TCP_SYNACK_RETRIES (127,
   the num_timeout field width) so the reqsk can actually expire.
 - route the TFO path through the same bounded helper.

Fixes: e6c022a4fa2d ("tcp: better retrans tracking for defer-accept")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 Documentation/networking/ip-sysctl.rst |  4 +++-
 include/net/tcp.h                      | 16 ++++++++++++----
 net/ipv4/inet_connection_sock.c        |  2 ++
 net/ipv4/tcp.c                         |  2 +-
 net/ipv4/tcp_timer.c                   |  3 ++-
 5 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4b19c8d3efda..eac33072be2d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -956,7 +956,9 @@ tcp_stdurg - BOOLEAN
 
 tcp_synack_retries - INTEGER
 	Number of times SYNACKs for a passive TCP connection attempt will
-	be retransmitted. Should not be higher than 255. Default value
+	be retransmitted. The sysctl accepts 0-255, but values above 127 are
+	silently capped by the SYN-ACK timers to match the 7-bit
+	request_sock::num_timeout field. Default value
 	is 5, which corresponds to 31seconds till the last retransmission
 	with the current initial RTO of 1second. With this the final timeout
 	for a passive TCP connection will happen after 63seconds.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0265c27a5fd7..986b7ea05e4a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -183,6 +183,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define MAX_TCP_KEEPINTVL	32767
 #define MAX_TCP_KEEPCNT		127
 #define MAX_TCP_SYNCNT		127
+/* request_sock::num_timeout is a 7-bit field. */
+#define MAX_TCP_SYNACK_RETRIES	127
 
 /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
  * to avoid overflows. This assumes a clock smaller than 1 Mhz.
@@ -912,12 +914,18 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
+						 const struct request_sock *req)
 {
-	u64 timeout = (u64)req->timeout << req->num_timeout;
+	u64 timeout = (u64)READ_ONCE(req->timeout) <<
+		      min_t(u8, req->num_timeout, 30);
+
+	return (unsigned long)min_t(u64, timeout, tcp_rto_max(sk));
+}
 
-	return (unsigned long)min_t(u64, timeout,
-				    tcp_rto_max(req->rsk_listener));
+static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+{
+	return tcp_reqsk_timeout_sk(req->rsk_listener, req);
 }
 
 u32 tcp_delack_max(const struct sock *sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 8151c638a24c..ee7b64f3141c 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1072,6 +1072,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	net = sock_net(sk_listener);
 	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
+	max_syn_ack_retries = min_t(int, max_syn_ack_retries,
+				    MAX_TCP_SYNACK_RETRIES);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
 	 * If synack was not acknowledged for 1 second, it means
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 99d7237a623d..a309fd45ad42 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -358,7 +358,7 @@ static u8 secs_to_retrans(int seconds, int timeout, int rto_max)
 		int period = timeout;
 
 		res = 1;
-		while (seconds > period && res < 255) {
+		while (seconds > period && res < MAX_TCP_SYNACK_RETRIES) {
 			res++;
 			timeout <<= 1;
 			if (timeout > rto_max)
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index e56eae4bc341..f7b100334a89 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -469,6 +469,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 */
 	max_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
+	max_retries = min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);
 
 	if (req->num_timeout >= max_retries) {
 		tcp_write_err(sk);
@@ -490,7 +491,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	if (!tp->retrans_stamp)
 		tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-			  req->timeout << req->num_timeout, false);
+			     tcp_reqsk_timeout_sk(sk, req), false);
 }
 
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
-- 
2.43.0

