Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617944;
	b=J7zTgjRSUOXBZTXZPjb28bpkGbE0JqvOHCK7spiXHXRztT4EQdxnb+yeODqL1UZHumk2
	 zMm55lMzb91IZRZxGk/05cjEu92FRzdT0AirQmnxsZtlSMAmjXuCmce6RxY1gqkjTLrCA
	 SrhwagFsVGKxMyJCIQ1TG77XenuVxQ2lbYj5YlE7RHuSODc34u08dQwn3QFjmX2sTX25T
	 uF6f3ZQgI2zK4Fm+i46f36qN25c7L2jnH/h5xiEKrQ9p8o4VaWsjpjTFp8MZmEXHVplZ+
	 iVMc8hS+ugzW9fAg8XmwjhJdGcIkt8glqTkBRBP1PLfwwOHtwPp6R2WOcKQXakrJ9JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617944;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+wwizQyr68ME7reLRM81gcCFcVFWbbFlCSm858g52eg=;
	b=JQIJIYE0mT/Cbhhw9JWCuo4II1dHXrDEyI9Zl9dQYuxrvjd+jNP954NJmZh1nEJYReH8
	 wkVxt55P8wCDVlNHiuBBg1KhTIxvsOZuwre6roMBJ8RejYSAAa5f20r8PJg6zaPWUUPHS
	 l91aCojhpBDbCu+jSqIpogGoGHF5h0zzeShj3jCtcmXygotOEgZnq6fcowv4co5Xx+veB
	 GEgfngLZaaQy3UhtDVrTU9H21DDZl13kflzgQVhEuC4yRLs+qozUY/CS3NHz57gwgOIMM
	 yewYnlf1wqvs/7YJvjajCdL76a1ugWdeMxRbfll3uwB+Nqp7YN9x1JFeOe2JKIj8p3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvqQAXUu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532E606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvqQAXUu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E1B1F000E0;
	Wed, 25 Nov 2026 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617943;
	bh=+wwizQyr68ME7reLRM81gcCFcVFWbbFlCSm858g52eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GvqQAXUuvEAtE45eWybcqdCSVyW5Xf8i/i5oFpFzIGcDLHjS+W59LGKZOjPsLO7I8
	 0EidgyKBysyJ/LWpf+wkFYk/n+gpxVAkkw+CpYcG4XenuWgZBUIW2556yZkevUxFAw
	 1mM8U6ZETcXCkduHSS/XF1HxG1dyau10jy5m1LkDMgJ0H8+SWWGeYir52+V7TPQ2hG
	 4ePW3sU/ZJmOyLD7VDUI1F96No7MXeQZnOI0jRXURdzB9ssG9Jb2AvcAjZ+KwytoRw
	 WTWYzFsdJxllV/Tkj1/rZ1xN8zK4ffcHq48zYizx81k30w4VBlkNjhA/s2DCLCngBI
	 ZxCIw1mD+pB2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] tcp: fix request_sock use-after-free during Fast Open accept()
Date: Wed, 25 Nov 2026 09:45:40 -0500
Message-ID: <20261125144533.4173150-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125144533.4173150-1-sashal@kernel.org>
References: <2026112552-threefold-playset-c83a@gregkh>
 <20261125144533.4173150-1-sashal@kernel.org>
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

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 62754aad50d0b30938bd8ce30b43474ce502a2af ]

Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
made inet_csk_accept() check tfo_listener before taking fastopenq.lock
to avoid taking the lock for connections that did not use Fast Open.

reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.lock,
then reads req->sk. If inet_csk_accept() concurrently observes
tfo_listener after it has been cleared, it skips fastopenq.lock and
drops the last reference to the request_sock. This can free the
request_sock while reqsk_fastopen_remove() is still using it.

If the freed memory is reused for a new request_sock with req->sk ==
NULL, the reset path in reqsk_fastopen_remove() can append the new
request_sock to the original listener's list of requests that caused an
RST. After the new request_sock is freed, the next append writes through
the stale rskq_rst_tail into freed memory.

KASAN reported the following use-after-free when writing
fastopenq->rskq_rst_tail->dl_next = req:

  BUG: KASAN: slab-use-after-free in reqsk_fastopen_remove+0x142/0x210
  Write of size 8 at addr ffff888108230688 by task swapper/5/0
  ...
  Call Trace:
   <IRQ>
   ...
   reqsk_fastopen_remove+0x142/0x210
   tcp_check_req+0x96f/0xdd0
   ...
   tcp_rcv_state_process+0x19c/0x26b0
   ...
   tcp_v4_do_rcv+0x16e/0x490
   tcp_v4_rcv+0x14a0/0x1af0
   ...
   ip_protocol_deliver_rcu+0x39/0x1e0
   ip_local_deliver_finish+0x124/0x1e0
   ip_local_deliver+0xfb/0x1e0
   ...
   </IRQ>

To widen the race windows, mdelay(5) was added after newsk = req->sk,
mdelay(20) after the if (req) reqsk_put(req) block, and mdelay(100)
after tcp_rsk(req)->tfo_listener = false. The KASAN report above was
reproduced with this kernel.

For the lockless check, use tcp_sk(newsk)->syn_fastopen_child instead of
tfo_listener, which reqsk_fastopen_remove() clears.

syn_fastopen_child is a field of the Fast Open child TCP socket
referenced by newsk, not of the request_sock. It is set before the child
socket is added to the accept queue. The paths that call
reqsk_fastopen_remove() in response to a remote ACK or RST do not clear
this field.

inet_csk_accept() uses this field to take fastopenq.lock only for Fast
Open child sockets and rechecks tfo_listener while holding the lock.
Connections that did not use Fast Open continue to avoid the lock.

Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/avQKA_YTAThtbsYU@v4bel
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_connection_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6b6a195ca7954..7439996bdc0c2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -683,7 +683,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 	newsk = req->sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP &&
-	    tcp_rsk(req)->tfo_listener) {
+	    tcp_sk(newsk)->syn_fastopen_child) {
 		spin_lock_bh(&queue->fastopenq.lock);
 		if (tcp_rsk(req)->tfo_listener) {
 			/* We are still waiting for the final ACK from 3WHS
-- 
2.53.0

