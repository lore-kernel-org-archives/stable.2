Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229E50C2A6;
	Tue, 13 Oct 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901799; cv=none; b=XhLCXeujDqclR/oPmH61uOB6EyDsEKZmaUtbK0fAWkdYgpzdb1nnB9ypFmCCvfF+nmMeNdv8E0gk1MrZyfnOKXR6+YR7fuBcTvyl9ggyXuJxupkvi0IEDiG9oc267LZcWVFxwFcij1i5k8Btd+waPMxk+elkRigQA06skf6LI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901799; c=relaxed/simple;
	bh=xczTdxb1dlC7Jiy3wK2ipSgCvCEU3TRNqUVNIID5+6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOQxcROvm80zIry85fDBgcF9EExffNS6T8Xaf542AbAKVM0I1sW7Wx8qgTd16Y+Nq7s+YJxxuH0+i1q/Z5I9cHhXOYdVEGg4xjosJD9XVE3qy4iHcP+qYCbRrUZYyHuorwKhE04RB9JhRMmnNVYE6PHtN/6/6nINUTNdzXLjR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJOnXj3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJOnXj3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9CC1F00893;
	Tue, 13 Oct 2026 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901798;
	bh=SiVL/n3dP5utCOnBBkrY8fVguE95vfRtjhQnwk91cC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fJOnXj3f9UYi44PfhQwoSxUsUiwjBMhqEdX+TL+Z3sHIbm8kkeGsJGijax6gNLqSV
	 0aihDVBiJ4mMxAS4PZozMulzyHnkQGpjsI4l4sYxi2FrnG4a9IerZ7G77+m7g9ijAr
	 gELGSd9XWNVESyEFtPOduTUU+l2XNPzoI+Ihl4SOT0j0CKBbLpMpEUkunqCaqoADXt
	 WAF5TFgtFC2QCxoUSunGMfNul3OZ7Oc/XKu0WTqf//EzZxOPHhumYDaGIwBamlmuiM
	 MpzeFBe2vtqpFRFCF4XWb9f/LzFYDYnE7caf/vYxiXhvZABcFd6tL5kpZj/WdJZo1v
	 8wNfuAnrHDpuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Oct 2026 16:29:21 +0200
Subject: [PATCH net 3/4] mptcp: hold MP_JOIN msk ref when cloning reqsk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-3-932c9b182fc7@kernel.org>
References: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
In-Reply-To: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Ruide Cao <caoruide123@gmail.com>, stable@vger.kernel.org, 
 Kyle Zeng <kylebot@openai.com>, David Lee <david.lee@trailofbits.com>, 
 Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7567; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=stPa2tT3Cd3J1dkg16Wr6A9iKDC7hLeY9rXYkKRzJFY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOOUQoz9R7UzPF+vupUv2UdSwluqcj9rLXPk75L9/Xd
 0CVsfNiRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESmBTH8le3aYsBf9S/r+OYC
 +XXBgZdWCYdHWZif8npx68ns5UkRlgz/9IJu79rxJdrbXyPx8ubPzyrUVH9w3zl7JflPz75Jd7y
 EeQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone().  For MPTCP MP_JOIN requests this byte-copies
subflow_req->msk, but the clone does not own a reference.

The original and cloned requests can consequently drop the same msk
reference, leaving one request with a dangling pointer.  This manifests as
a KASAN slab-use-after-free in subflow_req_destructor():

  BUG: KASAN: slab-use-after-free in subflow_req_destructor (net/mptcp/subflow.c:45)
  Write of size 4 at addr ff1100010e008d40 by task swapper/0/0
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc5-00353-gc27e36054537 #10 PREEMPT(full)

  Call Trace:
   subflow_req_destructor (net/mptcp/subflow.c:45)
   subflow_v4_req_destructor (net/mptcp/subflow.c:694)
   __reqsk_free (net/ipv4/inet_connection_sock.c:906)
   reqsk_timer_handler (include/net/request_sock.h:137 net/ipv4/inet_connection_sock.c:1147)

  Allocated by task 10014:
   sk_prot_alloc (net/core/sock.c:2246)
   sk_clone (net/core/sock.c:2488)
   mptcp_sk_clone_init (include/net/sock.h:1848 net/mptcp/protocol.c:3564)
   subflow_syn_recv_sock (net/mptcp/subflow.c:883)
   tcp_check_req (net/ipv4/tcp_minisocks.c:934)

  Freed by task 0:
   slab_free_after_rcu_debug (include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6439)
   rcu_core (kernel/rcu/tree.c:2645 kernel/rcu/tree.c:2897)

  Last potentially related work creation:
   kmem_cache_free (mm/slub.c:2638 mm/slub.c:6377 mm/slub.c:6504)
   __sk_destruct (net/core/sock.c:2289 net/core/sock.c:2391)
   sk_destruct (net/core/sock.c:2419)
   __sk_free (net/core/sock.c:2430)
   sk_free (net/core/sock.c:2441)
   mptcp_close (include/net/sock.h:2020 net/mptcp/protocol.c:3399)
   inet_release (net/ipv4/af_inet.c:442)

  The buggy address belongs to the cache MPTCP of size 2968
  The buggy address is 128 bytes inside a freed 2968-byte region

A non-NULL subflow_req->msk means that the request owns one reference. The
third ACK can concurrently transfer the original request reference to the
child and release it, so taking an unconditional hold on the copied pointer
is unsafe.

MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all current inet_reqsk_clone()
callers run in an RCU read-side critical section. Document and
lockdep-check that calling-context requirement.  Read the pointer from the
original request and acquire a reference only if it is still live.  Use
refcount_inc_not_zero_acquire() so the subsequent ownership validation
cannot be reordered before the try-get, then re-read the original request
to verify that it still owns the same msk. If either check fails, clear the
clone pointer; otherwise its normal destructor balances the new reference.
Mark the ownership-transfer store with WRITE_ONCE() to match the lockless
reads.

The following patch completes the clone fixup for MP_CAPABLE token
ownership. Both patches carry the same Fixes tag and are required for
stable backports.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Kyle Zeng <kylebot@openai.com>
Reported-by: David Lee <david.lee@trailofbits.com>
Reported-by: Vega <vega@nebusec.ai>
Closes: https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbits.com/
Assisted-by: LLM
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
v6: https://lore.kernel.org/cover.1788800732.git.caoruide123@gmail.com
---
 include/net/mptcp.h             |  9 +++++++++
 net/ipv4/inet_connection_sock.c |  4 ++++
 net/mptcp/subflow.c             | 35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 485d55b66ea6..ad7005b574bb 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -219,6 +219,9 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+/* Caller must hold an RCU read-side lock. */
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -305,6 +308,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 	return NULL;
 }
 
+/* Caller must hold an RCU read-side lock. */
+static inline void mptcp_subflow_reqsk_clone(struct request_sock *req,
+					     struct request_sock *new_req)
+{
+}
+
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6a30f1138454..c6f8011200a0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -21,6 +21,7 @@
 #include <net/xfrm.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
+#include <net/mptcp.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -961,6 +962,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
 	}
 
+	if (rsk_is_mptcp(req))
+		mptcp_subflow_reqsk_clone(req, nreq);
+
 	return nreq;
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f0a6725d2c37..3139a9ab2853 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,39 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	struct mptcp_subflow_request_sock *new_subflow_req;
+	struct mptcp_sock *msk;
+
+	new_subflow_req = mptcp_subflow_rsk(new_req);
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
+			 "MPTCP reqsk clone called without RCU");
+
+	/* A non-NULL ->msk means the request owns one reference.  The clone
+	 * copied only the pointer, while the original request can concurrently
+	 * transfer its reference to the child.  Acquire a reference for the
+	 * clone, then verify that the original request still owns the same msk.
+	 * MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all clone callers run in
+	 * an RCU read-side critical section, keeping the memory stable here.
+	 */
+	msk = READ_ONCE(subflow_req->msk);
+	if (msk) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt)) {
+			msk = NULL;
+		} else if (READ_ONCE(subflow_req->msk) != msk) {
+			sock_put(sk);
+			msk = NULL;
+		}
+	}
+
+	new_subflow_req->msk = msk;
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
@@ -927,7 +960,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			}
 
 			/* move the msk reference ownership to the subflow */
-			subflow_req->msk = NULL;
+			WRITE_ONCE(subflow_req->msk, NULL);
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {

-- 
2.55.0

