Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620747;
	b=TrTN0HnbNGbP1ityX9LJfFkJB1QclkHzk4z/ooYfsesOT0hQwHO3YU6aMMr1+KOJHQK/
	 bGp9k6vxrUZxE/uJUtNK28hv756WbHhdOFmu+Z9BzogHwg29i7d9YPDB9rZpoyTZVTpXV
	 oOU/Cs2GY+VVXi4J+oaZJ//ptyp3MBBqQSEgkvuPNKx0TB+YHycO+E1rOEkgmhaKgE2OQ
	 kKp4n49u992CA2mVV6zufGXZNLH6d8cBO2RmpWaMJHWh1aVp6FgXsneC7J1cyLiYxuQXj
	 Mb27gEBfrzhXnkOUse5w9jgSHe9OIcGnRQ5qCqFd5ODPEe/A+ialDak2FiGpKgp1oIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cOhucnwOFA87a/5bA1Fha4g7mxUYjMX3njpZb02Q5ls=;
	b=LmdmzUcEAvhKQKkmiTzvR9gZg1ddGDjl+E0td3l+tpDcNArA62vc9qiWFYLyNmqVokAL
	 xo5toFYAfAgKFfhZtjZSQIpr8FNxXaWyIe6nwDP9SZBcmYHuhV0kBC+5tiNmjHC1B7c34
	 VnrbZbi9IIss92hJMTNJJV5SzasfMnBlL4Ye/0G3vXYFspSgxMt12MnUQ4CWTq9LrWdHl
	 Z1y+ia6TSHV22zHy2LR63iuSM6zAbM0vejFeI9W46B9x5e95xitwBzAwnrJQoY+OG9+3O
	 LTMLPe52hRhdUto/9DSNsDT5PnubPg6ZBdfAoXm3Vik0WsuUu7Wen7wDm1C45+tEu5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqFJtw7R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D364606A683
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqFJtw7R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24901F000D2;
	Wed, 25 Nov 2026 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620746;
	bh=cOhucnwOFA87a/5bA1Fha4g7mxUYjMX3njpZb02Q5ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqFJtw7RkLYm+hjXc4+FWWMiL5HWJW9vax242tuK7Ki5D2Lg6ucq+nYS29SwqtMa/
	 mtpTed/C2ILIyX6ik9Vf349oD/XiyvBeVsqMJS/5gQ+D5UZjjzaVCFDJ9ROhUZCxzK
	 M/zTuRxp+GYT0yyEd4oNXVZ1ShvlEXymbNg4VhXlbZkxl+7SLwubX8c+uXFgtJwsN0
	 dNtC6TZpOdxaqlihCnJQ/hbiB2VklAhH93sB6VYqCloUi3rlF6v+Xod94Cxebge9IR
	 QbjxoggWEwwvNZpA2F9LcZ1XAsLI0BsnNF2zU6XEjYZwwIEx7zMEvIC/Y/2gfpvqoQ
	 FJ88acrZfEKKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <x-professor@outlook.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tcp: free saved_syn after an RCU grace period
Date: Wed, 25 Nov 2026 10:32:24 -0500
Message-ID: <20261125152946.328943-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-impotence-esquire-e8e6@gregkh>
References: <2026112538-impotence-esquire-e8e6@gregkh>
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
[ sashal: Moved the saved_syn RCU changes (reqsk_alloc and __reqsk_free) into include/net/request_sock.h, where those helpers are inline here, instead of net/ipv4/inet_connection_sock.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tcp.h             | 6 +++---
 include/net/request_sock.h      | 7 ++++---
 net/core/filter.c               | 2 +-
 net/ipv4/inet_connection_sock.c | 2 +-
 net/ipv4/tcp_input.c            | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 07a84ae6bf81c..50f8cbb39eb89 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -479,13 +479,13 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
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
index e27978405398d..b53a73dc3f248 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5418,7 +5418,7 @@ static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
 			 * not be available.  It has to resort to
 			 * saved_syn (if it is saved).
 			 */
-			saved_syn = inet_reqsk(sk)->saved_syn;
+			saved_syn = rcu_dereference(inet_reqsk(sk)->saved_syn);
 		else
 			saved_syn = tcp_sk(sk)->saved_syn;
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0c76b5f1c9d41..a0eeb5108a5bf 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -785,7 +785,7 @@ static void reqsk_queue_migrated(struct request_sock_queue *queue,
 
 static void reqsk_migrate_reset(struct request_sock *req)
 {
-	req->saved_syn = NULL;
+	RCU_INIT_POINTER(req->saved_syn, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	inet_rsk(req)->ipv6_opt = NULL;
 	inet_rsk(req)->pktopts = NULL;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 54e30bc368ca5..1aef70dc42f75 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6917,7 +6917,7 @@ static void tcp_reqsk_record_syn(const struct sock *sk,
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

