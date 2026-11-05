Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837796;
	b=EC0rsfZ0NO+8HvLpNQmrnJopYloXtSL0JMbXWi9YANg0P7qY9D2fxVmu4+abLvqZ38V8
	 Gn+esvUzuvT/4SswC6FUavWnXHdjCjy3n4hJzpm46P6NU+kECUi2yk0vO6cVn0FMFuPEU
	 7Dfax4CyaSttOKXNAavtGvmxRZVUh3/k1REAma9+VODRRvLakINe8A44tbiFEvX9I3UjT
	 lNlfBi1An85CLIF91oc/Z0eTzLv4pmepea+pDN8ByLV8YXo8yOKlFPTyVsO7el2WzzN1B
	 wrjurJdBiHGPIuxkJLJx4dxjUiMJ0w1KyxGikmh0kPj5hZgzWTxxMtChpYdC5m3LCNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VCjtAFGsYOwehVBCaAKMdBudsT0yz5g21JXAOHjxZ2s=;
	b=ysT02ewfJ6PlDBt9722pFlbOkW7L1wf9F/AB38ynAtKGLe4J5g2LPqGc+BvW/L2anGwB
	 jy9JmgOmg9A6LbiSSfh2D0AQ9y3X2Li0R3VsogiWpE7iTEwnExoMbyf0Qd0lmj1g5WAIZ
	 6nEbMDAHHVRVjbP6RMpruTVRYMZziN/oAm7D8RtLyWRLn9PjudjyGbqCXKsPC/i+23N9Y
	 rWkeI4Kv3cWoWCe14Q9GnlKjN+8CeFAi2ty3wqnDPoYPyaB+7IugQ6qtu7Tu4lHn5nE2t
	 L8FAZtykyzOSbWvt3ijpRS9CLtOWIjyuZNdM85JtwW5QnQ0UdEp4VSOHvtzGoCoRp9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtM2vPxp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35051606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtM2vPxp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0401F000C1;
	Thu,  5 Nov 2026 00:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837795;
	bh=VCjtAFGsYOwehVBCaAKMdBudsT0yz5g21JXAOHjxZ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CtM2vPxpJZVzbfruN0WFOFeQhYSeT7Y/rGCEIWc7xvuWP90nDHJ7JWCsuh1q3uUQ/
	 Jgqgai9sw2tfqep1w60IVDojYnJjGSDdM0CDvYXPrUkLp5Ufgmw/bh/o5V5ErVXxPK
	 WsH/HfznZZl0+Ug2tG0vVo6NpHEd/StxnDPZgswAr1O0n+CTSBiGpFPVJxAnuiGR0S
	 jDyOW8vygZt5XbPq0jIs8wY/tIcG90mViZ5wPO6YXHeozU9eV6aSM2wG/49qEfM2rt
	 wsboREzX8zVFhjN9Zu0Bmx08Hxoiw1VrU05e5V0PooWzuh/VJmIoFN2EkPIjZtCjuK
	 xplypJ3556f8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruide Cao <caoruide123@gmail.com>,
	Kyle Zeng <kylebot@openai.com>,
	David Lee <david.lee@trailofbits.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: hold MP_JOIN msk ref when cloning reqsk
Date: Wed,  4 Nov 2026 19:16:33 -0500
Message-ID: <20261105001601.980043-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110449-profile-pessimism-5c6f@gregkh>
References: <2026110449-profile-pessimism-5c6f@gregkh>
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

From: Ruide Cao <caoruide123@gmail.com>

[ Upstream commit c9c90cf437a9e6597611b6d3aad6e255fad22867 ]

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
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261013-net-mptcp-misc-fixes-7-3-rc8-v1-3-932c9b182fc7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted the MPTCP include placement because the TCP ECN header is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mptcp.h             |  9 +++++++++
 net/ipv4/inet_connection_sock.c |  4 ++++
 net/mptcp/subflow.c             | 35 ++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5e..280001e0ed921 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -213,6 +213,9 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+/* Caller must hold an RCU read-side lock. */
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -308,6 +311,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
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
index 14f54dc8e0179..a723f47828a18 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -20,6 +20,7 @@
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
+#include <net/mptcp.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -1005,6 +1006,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
 	}
 
+	if (rsk_is_mptcp(req))
+		mptcp_subflow_reqsk_clone(req, nreq);
+
 	return nreq;
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1d0deac2c0fee..17d392b042ba9 100644
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
@@ -928,7 +961,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			}
 
 			/* move the msk reference ownership to the subflow */
-			subflow_req->msk = NULL;
+			WRITE_ONCE(subflow_req->msk, NULL);
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-- 
2.53.0

