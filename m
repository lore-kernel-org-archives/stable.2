Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619366;
	b=0wFsLf+A3ZAM7qKdePGEyAeLFQBvNjTEsKX/9xmqdwtLe85+YFowUdHLVpbnuMJFT6fK
	 hbKsUhYyFXYbTZb3p+N2mpJE/150to3oTgw/aP0wGKnb1kKvQGAoOIXnfh9Q0zPXlqKDm
	 XDq6IUi3oZhWUQSVhUp/NbYoOvOASY2fEkK8MYHv7WcH2BzeLKFChoFFNp9cpKeS1YYSz
	 BimIOVBj7HMh05rRo6lt6K24WuruhGtOtONGUH8iS0Sz5U5h9BjZMfxXVjio58cTP2ngA
	 elqw1v6eB8feSMNf91B2roHTJxwScaP2SMHLXekixVdBRTmAExxFrq/rhhzXQHqTdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wqQKJXCEJbpK/1tNJLfo8w9P556HQ6GqdXI05Swo5pg=;
	b=FfP/OjKlAHfTk/WIRC7JyZYASiuPGkkrH3HNyYH8gvzFOhgRmwFOnCS+42ZruU+s6nON
	 sXNp1dzilNdW/H1N2jZPokYr18R49zHsA10uMdnKE12ZMGXhJbgGDwrvFwxhwc+XELmOL
	 YrEBmR7t40/5Z3cBib96eIfuhzTHOoHQse3CP8KCIsjDb4EAuGZQuEx1q+ZpOe+nGtsiU
	 D81JdR08QXlqn/43yAYCwBVZOFklJXptOdt9/Gz3q3+JYREgSTlnOnFpRNA5O8PJGE/qD
	 Buz4V3/hSfqjbPY6mKmORqUmvp0zijMYdWG1C85Lxvbmx7mSlkIBLno2Ss/+0UDbJQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n5YSC/C0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A3606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5YSC/C0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D511F000D1;
	Wed, 25 Nov 2026 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619366;
	bh=wqQKJXCEJbpK/1tNJLfo8w9P556HQ6GqdXI05Swo5pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n5YSC/C0Xz2hOhX4Ug9eaYEgtb6X9b2wX2ckpFfEN17BKggdNjdEFBOolWl2YhJdE
	 jXrmG/7rbdrsaXrxpUKtucsGhyCPDQNAE+yQCv/DZY47J42snCJOoRwQbuI+33sVPZ
	 sBQk/dIOF+HATe0yUuTusT64CfLr1BQD3JoNGuDqjwXU5FOmaof8QCtV+7UEg9pPRI
	 p3hSbp73NKtV+V4AbRPa2ySVIFwK0LVB0Cn9AF2vBxHJ4Ega1yMoVUox6jggKH2Qo1
	 ZNCuG/BB7RklD8vGzvZ/tAAZqgHYrENJ3vfod2pXem2RkkLnyYJdmEXS/Q18K1t4Fx
	 MzuQOX00IbTrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <x-professor@outlook.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tcp: free saved_syn after an RCU grace period
Date: Wed, 25 Nov 2026 10:09:24 -0500
Message-ID: <20261125150903.26734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112537-alone-exclusive-638d@gregkh>
References: <2026112537-alone-exclusive-638d@gregkh>
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

From: Yingjie Wang <x-professor@outlook.com>

[ Upstream commit 2b9fd1a0abf0c1c7200be7a33cfeeca1c68089b6 ]

tcp_reqsk_record_syn() allocates saved_syn separately from its request
socket. bpf_sock_ops_get_syn() can load that pointer while processing a
retransmitted SYN under RCU.

There are two ownership transfers which can let another CPU reclaim the
allocation while such a reader is still using it.

First, tcp_move_syn() transfers req->saved_syn to a newly created child
socket. The child can be closed and tcp_saved_syn_free() can reclaim the
allocation before a reader of the old request finishes.

Second, inet_reqsk_clone() shallow-copies request_sock during request
migration. After reqsk_migrate_reset() clears the old request pointer, the
migrated clone owns it. However, a reader which already loaded the pointer
from the old request can still be using it when the clone is released.

I found this through LLM-assisted concurrency fuzzing.

Mark the request-socket saved_syn pointer as RCU protected and use RCU
accessors for its reads and updates. Keep the full-socket pointer plain
because all of its accesses hold the socket lock. Embed an rcu_head in
struct saved_syn and use kfree_rcu() in both teardown paths. This lets a
request-side reader which loaded the object before an ownership transfer
finish.

This follows commit e3f33b0a1d89 ("ipv4: free inet_opt and ireq_opt
after an RCU grace period"), which fixed the same ownership-transfer
pattern for IPv4 options.

The issue was confirmed with KASAN on v7.3-16007-g36aad21d50d1 using
temporary kernel instrumentation to widen the reader and request-migration
window. KASAN reported a slab-use-after-free read in
bpf_sock_ops_get_syn(), with the allocation freed by __reqsk_free() from
reqsk_timer_handler(). The same explicit migration test completed without
a report with deferred reclamation. A patched kernel without the delay
instrumentation also completed a successful migration and seven saved-SYN
reads without a KASAN report.

Fixes: 0813a841566f ("bpf: tcp: Allow bpf prog to write and parse TCP header option")
Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <x-professor@outlook.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/38fa9f2cc476502e9b1c1fef09ebba1df5dd5901.1793795528.git.x-professor@outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Two hunks landed in request_sock.h instead of inet_connection_sock.c because reqsk_alloc() and __reqsk_free() are static inline there, and context lines differ (timeout vs syncookie). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tcp.h             | 6 +++---
 include/net/request_sock.h      | 7 ++++---
 net/core/filter.c               | 2 +-
 net/ipv4/inet_connection_sock.c | 2 +-
 net/ipv4/tcp_input.c            | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index c38778b0baa05..e51ffc5c5de74 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -536,13 +536,13 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
 static inline void tcp_move_syn(struct tcp_sock *tp,
 				struct request_sock *req)
 {
-	tp->saved_syn = req->saved_syn;
-	req->saved_syn = NULL;
+	tp->saved_syn = unrcu_pointer(req->saved_syn);
+	RCU_INIT_POINTER(req->saved_syn, NULL);
 }
 
 static inline void tcp_saved_syn_free(struct tcp_sock *tp)
 {
-	kfree(tp->saved_syn);
+	kfree_rcu(tp->saved_syn, rcu);
 	tp->saved_syn = NULL;
 }
 
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 144c39db9898a..7ed76b942f4ce 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -42,6 +42,7 @@ struct request_sock_ops {
 int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req);
 
 struct saved_syn {
+	struct rcu_head rcu;
 	u32 mac_hdrlen;
 	u32 network_hdrlen;
 	u32 tcp_hdrlen;
@@ -67,7 +68,7 @@ struct request_sock {
 	struct timer_list		rsk_timer;
 	const struct request_sock_ops	*rsk_ops;
 	struct sock			*sk;
-	struct saved_syn		*saved_syn;
+	struct saved_syn __rcu		*saved_syn;
 	u32				secid;
 	u32				peer_secid;
 	u32				timeout;
@@ -104,7 +105,7 @@ reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
 	req_to_sk(req)->sk_prot = sk_listener->sk_prot;
 	sk_node_init(&req_to_sk(req)->sk_node);
 	sk_tx_queue_clear(req_to_sk(req));
-	req->saved_syn = NULL;
+	RCU_INIT_POINTER(req->saved_syn, NULL);
 	req->timeout = 0;
 	req->num_timeout = 0;
 	req->num_retrans = 0;
@@ -119,7 +120,7 @@ static inline void __reqsk_free(struct request_sock *req)
 	req->rsk_ops->destructor(req);
 	if (req->rsk_listener)
 		sock_put(req->rsk_listener);
-	kfree(req->saved_syn);
+	kfree_rcu(unrcu_pointer(req->saved_syn), rcu);
 	kmem_cache_free(req->rsk_ops->slab, req);
 }
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 93c87a0d0d7eb..849fa24c63302 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5811,7 +5811,7 @@ static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
 			 * not be available.  It has to resort to
 			 * saved_syn (if it is saved).
 			 */
-			saved_syn = inet_reqsk(sk)->saved_syn;
+			saved_syn = rcu_dereference(inet_reqsk(sk)->saved_syn);
 		else
 			saved_syn = tcp_sk(sk)->saved_syn;
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index eb4dddccf17e2..52ffff7b10e98 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -965,7 +965,7 @@ static void reqsk_queue_migrated(struct request_sock_queue *queue,
 
 static void reqsk_migrate_reset(struct request_sock *req)
 {
-	req->saved_syn = NULL;
+	RCU_INIT_POINTER(req->saved_syn, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	inet_rsk(req)->ipv6_opt = NULL;
 	inet_rsk(req)->pktopts = NULL;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2efd492f40001..c2f6c109f84b7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7114,7 +7114,7 @@ static void tcp_reqsk_record_syn(const struct sock *sk,
 			saved_syn->network_hdrlen = skb_network_header_len(skb);
 			saved_syn->tcp_hdrlen = tcp_hdrlen(skb);
 			memcpy(saved_syn->data, base, len);
-			req->saved_syn = saved_syn;
+			RCU_INIT_POINTER(req->saved_syn, saved_syn);
 		}
 	}
 }
-- 
2.53.0

