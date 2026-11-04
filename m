Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801990;
	b=cIxf49V/TrLyNzh0Crh2sb56NcTM3X5xa+DWvQDeIhycJOmgegQvmxAmC0Wnbi2VmRxS
	 nhTUOuHp7vqb9CyuIvQZbLTNLSoqJMGe+RlVWSddEOeO3ijw1t3/qZv1bONx8XgFOP9cr
	 sCPY9bSgMsrLnqk7HKuVuvII+i3/jvAzVKQCBZI1H1tgPqi4KHhqPueajrawl02DvbQp4
	 kK/8yq1GWiCD9C2ti7S1ksad6oUcN4P0X/sKuyveOuDgGdRihHdUcRWX3PG68SZcjCRTI
	 rHbV9CJ/owzRw60xxUAEp43T0eaXUoOSxG5z4RFZCntDcRoKTCkOtIaVCyanRK7qn9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801990;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6ABKBMk8R2IVzTizNndTb3HeHsQaL/kLU2wg3A55CnM=;
	b=Cv/5DFIolFaRylrlsl5cik7V6kR10FN8fqgDE64DJH9Z+7obeL+qinWoXKekFf+YkynU
	 IjbHBZghRgB/ZNuYQV/XMIo/wDexzCxBqZ/fPUOv6aBMCRJmhs5678t6laVQA1ZRRnrXs
	 Fmej5kCFlnGWKZ/o1Wix85MMzkUdcIdyUQzEE/LakmIsUmBR/BURJBMHJfaYBuWsZ7T5o
	 QzuZs+mdVVp1AGEqXOiK4Mwl7ApAjepZ+itPbkymYs8DhHQQeB4F+eoE9HevfxwUl8WIq
	 mfphRc2J6p6ewtI7dLjYvezLn3rvamyNs4RoSfVxUAJ3aVPbYIj5PfzeVqR2iIW4GcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hcF28wlu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23A606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hcF28wlu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981091F00919;
	Wed,  4 Nov 2026 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801989;
	bh=6ABKBMk8R2IVzTizNndTb3HeHsQaL/kLU2wg3A55CnM=;
	h=Subject:To:Cc:From:Date;
	b=hcF28wlutGSnH4XPJRXEYAW/xshEf2ZOzhnU2WWVPcRJV3JIKo0Y6NIC20CTN7cbw
	 hyy4O9s8dhgJ3firXvFhjzFHuAk22q24YYq4j7Y4recXckdKHyNWBChUQXe3QO43ga
	 FbPvPJZbUb1O9RxDIZqFrLhlN37UgLC92OkUsMbY=
Subject: FAILED: patch "[PATCH] mptcp: hold MP_JOIN msk ref when cloning reqsk" failed to apply to 6.18-stable tree
To: caoruide123@gmail.com,david.lee@trailofbits.com,kuba@kernel.org,kylebot@openai.com,matttbe@kernel.org,vega@nebusec.ai,weir@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:19:48 +0100
Message-ID: <2026110448-scrambler-renovate-a361@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c9c90cf437a9e6597611b6d3aad6e255fad22867
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110448-scrambler-renovate-a361@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9c90cf437a9e6597611b6d3aad6e255fad22867 Mon Sep 17 00:00:00 2001
From: Ruide Cao <caoruide123@gmail.com>
Date: Tue, 13 Oct 2026 16:29:21 +0200
Subject: [PATCH] mptcp: hold MP_JOIN msk ref when cloning reqsk

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

