Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012994;
	b=JGvdYt4aNYnZKT+vqhEuXy2lPCKY2RSHvk0wrH0GivmilrAvRpPIhO1neaDxgTGzu7t/
	 NU8gOYxCkagGLnF7Po8JfIaYm/LVDYtgko3m3YooISg+ZCZl9V0/KBMbxtqiQZt+ZTt33
	 XxJca0UaM3BjXm0T7hwolvK/13I7Ot1cwkBoXBFn6WI6+l/J3qNEitkHGpk6yUl4mjowK
	 bzH1s8x/4dU/XyWVZ4eodU5+TkpQ6LPfMylEhLToURVpx3Mw9e2RBMD38Xawez6EpC8Vf
	 FD902OJm9Acpl6aUdLI68wmCH5xqCZ9GgX0bs5WNpzclrRkH3EjtG1HN1abUu72x7XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012994;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4kyiXEVHnEq96nV0xkvtnyuEM+U+bqA5NzQcRaSrYP4=;
	b=JsdvOAnhn8oNCMUjTBgrUgW9RrYnntkBpa3/r7o99Ih3748d8jbZ2l2he0F/wYOux3d6
	 W+QIHnTObmEuim5ZqNMpUkFMNunlqseuRJjEzE8Fw1OjB/tgtu6JFVNK/p98qP1UZ2p72
	 zSpEOpRYn32tRdeeb0fXb9uB/w6VAzhjIWXGm29wJ6zsBBpH57Kg7hnJ5MYPObSIIzdcw
	 i5CFNLptJ8IVACtdX16DJcCLi2BVPJ6kLl2ySZnjj1Bfk1FpIwvDci408UUuNyCR4ekyz
	 1zk6aJYlAc436k/ewxjnmqIk8vXuBAFPnsyavMHBRvGxcDkdRd9TiJnZDyC0M/8qylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J9Qrx44R;
	arc=none smtp.remote-ip=95.215.58.166
Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D9606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J9Qrx44R
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aUndDEiuHa+xg264iTWBHeme8bosu3XwdgWQ9NWKR1s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795012992; v=1; x=1795617792;
 b=J9Qrx44RmUB0CmJmJ2Km1ORVuzdNH8Ju680fjuxz0Q/ax8zFv3rVlSRWRXHJQc6kTMKUPVxU
 dVDa/CZQHWMYb+OyVxouYJt6LzgfY/5UEYrn16eFdj9MHGvr9hKXEtIFeBy87br/80t+LoHBgUu
 rvkIe0ZBNOyWFeCYkBlb0LGo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0b13aa2a19314f58;
	Wed, 18 Nov 2026 14:43:12 +0000
X-Mizu-Trace-ID: 0b13aa2a19314f58
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
Subject: [PATCH net v3 1/2] tcp: fix shift-out-of-bounds in SYN-ACK retransmit timers
Date: Wed, 18 Nov 2026 22:42:37 +0800
Message-ID: <20261118144249.358481-1-jiayuan.chen@linux.dev>
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

req->num_timeout counts the SYN-ACK timeouts of a request and is used as
a shift amount:

	/* tcp_reqsk_timeout() */
	u64 timeout = (u64)req->timeout << req->num_timeout;
	/* tcp_fastopen_synack_timer() */
	req->timeout << req->num_timeout

Once it climbs past the width of the shifted type the shift is UB. Seen
with tcp_synack_retries=255 and a peer that never completes the
handshake:

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

The sysctl is not needed: TCP_SYNCNT=127 on the listener gets there
too, and the TFO shift is 32-bit, so it is UB from num_timeout 32.

The value can also wrap to 0 before the shift count is out of range,
which arms a zero-length timer. E.g. with HZ=1000 and req->timeout ==
1000, (u64)1000 << 61 and (u32)1000 << 29 are both 0.

num_timeout is a 7-bit field. Once a retransmit limit is above 127 the
"num_timeout >= limit" check can never be true, the request is never
expired by that limit, and after the field wraps to 0
reqsk_timer_handler() decrements queue->young again on the next expiry.

 - split tcp_reqsk_timeout() into tcp_reqsk_timeout_sk() and cap the
   shift at 32 there, same as inet_csk_rto_backoff() in the next patch.
   req->timeout << 32 is already above tcp_rto_max(), so the clamped
   result does not change.
 - cap max_retries / max_syn_ack_retries at MAX_TCP_SYNCNT (127), the
   largest value the field can hold. The sysctl range is left alone:
   narrowing it would make setups that write 128..255 fail with
   -EINVAL, and the caps are needed anyway for TCP_DEFER_ACCEPT and the
   TFO "+ 1". 128..255 now act as 127.
 - cap the TCP_DEFER_ACCEPT conversion in secs_to_retrans() at 127 too;
   larger values kept an acked request from ever expiring. getsockopt()
   now reports at most 14527 instead of 29887 seconds.
 - route the TFO path through the same helper.
 - document that tcp_synack_retries values above 127 act as 127.

Found by checking sysctl ranges against their users. Reproduced in a VM
with UBSAN: tcp_synack_retries=255 and tcp_rto_max_ms=1000 on the
server, and an iptables rule dropping the final ACK of the handshake.
The splat shows up after about 64 seconds, and is gone with this patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: e6c022a4fa2d ("tcp: better retrans tracking for defer-accept")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2 -> v3:
 - drop READ_ONCE(req->timeout), cap the shift at 32, reuse
   MAX_TCP_SYNCNT, simplify the doc text (Neal)
 - changelog: mention TCP_SYNCNT, the wrap to 0, why the sysctl range
   is not narrowed, how it was found and tested (Neal)
 - add Fixes: 1da177e4c3f4, the shift was already there
v1 -> v2: reworded the commit message, no code change.
v2: https://lore.kernel.org/netdev/20261026123244.239766-1-jiayuan.chen@linux.dev/
v1: https://lore.kernel.org/netdev/20261023064915.401112-1-jiayuan.chen@linux.dev/
---
 Documentation/networking/ip-sysctl.rst |  2 +-
 include/net/tcp.h                      | 14 ++++++++++----
 net/ipv4/inet_connection_sock.c        |  1 +
 net/ipv4/tcp.c                         |  2 +-
 net/ipv4/tcp_timer.c                   |  3 ++-
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 3cc80d9b024b..468d3df998a5 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -956,7 +956,7 @@ tcp_stdurg - BOOLEAN
 
 tcp_synack_retries - INTEGER
 	Number of times SYNACKs for a passive TCP connection attempt will
-	be retransmitted. Should not be higher than 255. Default value
+	be retransmitted. Values above 127 are treated as 127. Default value
 	is 5, which corresponds to 31seconds till the last retransmission
 	with the current initial RTO of 1second. With this the final timeout
 	for a passive TCP connection will happen after 63seconds.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 25d11fab1b03..39ee5c250bae 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -920,12 +920,18 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
+						 const struct request_sock *req)
 {
-	u64 timeout = (u64)req->timeout << req->num_timeout;
+	/* timeout << 32 is already above tcp_rto_max(). */
+	u64 timeout = (u64)req->timeout << min_t(u8, req->num_timeout, 32);
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
index 5807067083c9..02a472d44ea5 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1071,6 +1071,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	net = sock_net(sk_listener);
 	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
+	max_syn_ack_retries = min_t(int, max_syn_ack_retries, MAX_TCP_SYNCNT);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
 	 * If synack was not acknowledged for 1 second, it means
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d510e982dcea..45ecc97e164f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -358,7 +358,7 @@ static u8 secs_to_retrans(int seconds, int timeout, int rto_max)
 		int period = timeout;
 
 		res = 1;
-		while (seconds > period && res < 255) {
+		while (seconds > period && res < MAX_TCP_SYNCNT) {
 			res++;
 			timeout <<= 1;
 			if (timeout > rto_max)
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 00debcba122b..814fadb30749 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -468,6 +468,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 */
 	max_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
+	max_retries = min_t(int, max_retries, MAX_TCP_SYNCNT);
 
 	if (req->num_timeout >= max_retries) {
 		tcp_write_err(sk);
@@ -489,7 +490,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	if (!tp->retrans_stamp)
 		tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-			  req->timeout << req->num_timeout, false);
+			     tcp_reqsk_timeout_sk(sk, req), false);
 }
 
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
-- 
2.43.0

