Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596678;
	b=Zaoi5vXS8uyRRh8tg55ud0ZOocEFOcip50LpXn2/p7aKHX+VoSlm0a9XkuNnwnzpF+Ld
	 juUoV2u06fdBlzSRan3VbFwXlIMfYhCOuiAco6h13u1fRSfPijBtLyiGy41e2a7RFbM1L
	 CpQS1O6ElD/9+roZhGehU7hfnLXWRZ1W8Ep6J8pi4ZHsCDPRjK8gzdVvikgREncXeavxj
	 AxlC9Sb6munOyn/xwqSGf7umv07FAjpKoR9XuAX92/kkjwacx7YtdNUpXzidb6/kaoLSq
	 /ZpH2TfF2Er1XrUdfTDB6v5rwRC5/MT9uXg7C8SuqgN3mAn+J742Lg2Pk1AevGWe76Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596678;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7KAky0guYqwAguHypW6wmkJe4yEMuSVJcInDlOuehOM=;
	b=UKvxZxa/oI6FDWjubNwvwaXX4ZIxwwzC846u/kSB9gQByfoeMlSb9s7UwRiwNeyqqkVq
	 XsyH+Jl98hetSvhdZ+F7lDSdwJhqw70KnPg56zJMU3NVOObdG1DKK2BtNrQP6044vvWyL
	 0R1OIYKExgMe4bDz2AuhRDUslPHCSrFcAmWt6DX3jSnhrkAL063jeuB3nk5ix1vwazlKM
	 BTn9DOqpE2KhEfj6N4lLP28fSoXuRIMTf74gVPVu50zUKSaetd1OwLC93u9UTgf9upmcV
	 cUTs7XEtHEU4EA3YQ3/nSl6RkKx+oiQW4WAWRrcLnOMgecJTUQaNLk6s01xsr3IUkjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PfEZglrq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52019606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PfEZglrq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF4A1F000CA;
	Wed, 25 Nov 2026 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795596677;
	bh=7KAky0guYqwAguHypW6wmkJe4yEMuSVJcInDlOuehOM=;
	h=Subject:To:Cc:From:Date;
	b=PfEZglrqFxs0ZkTwVyTGVWMoaQyrvWMfALo8fTW1HfdXbAcRpbgmQLbtLqfP+M4Wt
	 zCR1MYuw0oec6o7zqeo8UqHnWqICBlekQSR3dDpBkSeESxvXpuIx9wLatUsCqV39i8
	 I34acWddPXWUAS7W89NQnaAZp9CU3srwEi9eAysk=
Subject: FAILED: patch "[PATCH] tcp: free saved_syn after an RCU grace period" failed to apply to 5.15-stable tree
To: x-professor@outlook.com,edumazet@kernel.org,kuba@kernel.org,kuniyu@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:48:38 +0100
Message-ID: <2026112538-impotence-esquire-e8e6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2b9fd1a0abf0c1c7200be7a33cfeeca1c68089b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112538-impotence-esquire-e8e6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b9fd1a0abf0c1c7200be7a33cfeeca1c68089b6 Mon Sep 17 00:00:00 2001
From: Yingjie Wang <x-professor@outlook.com>
Date: Wed, 4 Nov 2026 12:32:19 +0000
Subject: [PATCH] tcp: free saved_syn after an RCU grace period

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

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index ef6c7e77f74c..e6b79cf4798f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -622,13 +622,13 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
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
index 5a9c826a7092..faa6dc49cea8 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -39,6 +39,7 @@ struct request_sock_ops {
 };
 
 struct saved_syn {
+	struct rcu_head rcu;
 	u32 mac_hdrlen;
 	u32 network_hdrlen;
 	u32 tcp_hdrlen;
@@ -68,7 +69,7 @@ struct request_sock {
 	struct timer_list		rsk_timer;
 	const struct request_sock_ops	*rsk_ops;
 	struct sock			*sk;
-	struct saved_syn		*saved_syn;
+	struct saved_syn __rcu		*saved_syn;
 	u32				secid;
 	u32				peer_secid;
 	u32				timeout;
diff --git a/net/core/filter.c b/net/core/filter.c
index 52e6ea6d5045..9d29e5a20e6c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6188,7 +6188,7 @@ static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
 			 * not be available.  It has to resort to
 			 * saved_syn (if it is saved).
 			 */
-			saved_syn = inet_reqsk(sk)->saved_syn;
+			saved_syn = rcu_dereference(inet_reqsk(sk)->saved_syn);
 		else
 			saved_syn = tcp_sk(sk)->saved_syn;
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec43877..37cc8606d683 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -869,7 +869,7 @@ reqsk_alloc_noprof(const struct request_sock_ops *ops, struct sock *sk_listener,
 	req_to_sk(req)->sk_prot = sk_listener->sk_prot;
 	sk_node_init(&req_to_sk(req)->sk_node);
 	sk_tx_queue_clear(req_to_sk(req));
-	req->saved_syn = NULL;
+	RCU_INIT_POINTER(req->saved_syn, NULL);
 	req->syncookie = 0;
 	req->num_timeout = 0;
 	req->num_retrans = 0;
@@ -908,7 +908,7 @@ void __reqsk_free(struct request_sock *req)
 	req->rsk_ops->destructor(req);
 	if (req->rsk_listener)
 		sock_put(req->rsk_listener);
-	kfree(req->saved_syn);
+	kfree_rcu(unrcu_pointer(req->saved_syn), rcu);
 	kmem_cache_free(req->rsk_ops->slab, req);
 }
 
@@ -979,7 +979,7 @@ static void reqsk_queue_migrated(struct request_sock_queue *queue,
 
 static void reqsk_migrate_reset(struct request_sock *req)
 {
-	req->saved_syn = NULL;
+	RCU_INIT_POINTER(req->saved_syn, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	inet_rsk(req)->ipv6_opt = NULL;
 	inet_rsk(req)->pktopts = NULL;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ddb9ebcfbf31..e971947083af 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7671,7 +7671,7 @@ static void tcp_reqsk_record_syn(const struct sock *sk,
 			saved_syn->network_hdrlen = skb_network_header_len(skb);
 			saved_syn->tcp_hdrlen = tcp_hdrlen(skb);
 			memcpy(saved_syn->data, base, len);
-			req->saved_syn = saved_syn;
+			RCU_INIT_POINTER(req->saved_syn, saved_syn);
 		}
 	}
 }

