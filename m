Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337799;
	b=5c29xH2SC59Hgt2ZuNvh1V117uLx5a4FqBmTm+38OM+9su8aC0pWbq5hezSXgJ5JACYM
	 4QbHxA7ChTmDJ4MwORDICsF0F0lsFFenpnI6ljd7dosJChFp2Uzkxsns9mvcad4dLb2wC
	 2K3GhdInAKk0gxfGd3iEtiMT0thAZXg9b9EDAd1Gi+X3YmhmIy+bNyPOljuOTEAPf70rJ
	 B7ucQNfnIecIs3mxuMDAqjvUSx61o1RAmSzi8CHVdC8W3eNLz1+zIUkB+hrjmKNU4tauu
	 jLLAHpbkMOVeV5ff0XDTIyTZ4LRgiwqFIsay0D6RcXX5t6MhcmHjI5dAy7jXqwv2BxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PV9cT+NwleDr5HTpf8v503qccMjspP+Pn5PQRUifZas=;
	b=whHVeBJGJMeB461WxIqOx8GJALq+wKbn+dxO+SMlKltZYJtpLqv6bIL6/p6HrrObQXL+
	 UgFmL9f4meZvakvIYhZOc80R5Jz0PhkDRBDjLbCAjjLWymOhmrLTwkdZiPhPmTxlUxkIs
	 XMyoFhNk9krZhuyJd/35iuPjBN0hgGbxywVL8k5zElIgaeSlmnTKWsB70hTOKrG5BsIUA
	 aBWjkvnN73hxmbGeMcmujl0z0EgaUgrQMiy7TD8zKEqEqzOPpMP/fnr7BAdxh8t7qXwPV
	 zNRaiTCbivupqSJBkrG85yES2nFmgOpUMh8ci3nV7RSvPaoH1G3JNGqHsbEfsZBiSCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/gAZSW4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25940606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/gAZSW4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9431F008A1;
	Tue, 10 Nov 2026 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337799;
	bh=PV9cT+NwleDr5HTpf8v503qccMjspP+Pn5PQRUifZas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/gAZSW4rUqvIyeZxMlY0buJ5Ovj6Gu3RIqs0/VHRe9+6c2I83lgn9jk8VvXvVWen
	 U0c0JX9WM0fTXRCqdi0hBR2eoUtdWIqtJRAGRdp7UZMWKQJL/sEf/DnR4Cy1Ud68vb
	 QIwmVyJ6pXGd4ZulLejQhvp4Bl17H9gQvlCIY5NC5I4YgFj1+x9ALENTHMzofnbb9b
	 RlAP1ZwecE4DI9eKkChB6VvntBulm4jcoAimeckntUa6Ch+t/qnvDK7DezcBoRm5eL
	 lWxbd0JiPnJkUUeaFWdE1fXAMCT4kF0EynL4F842ydd4Lr3cTl65kUWDKSaOqRcPd3
	 v05/CPfOjhngQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruide Cao <caoruide123@gmail.com>,
	Vega <vega@nebusec.ai>,
	Sashiko <sashiko-bot@kernel.org>,
	Ren Wei <weir@nebusec.ai>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fix MP_CAPABLE token migration when cloning reqsk
Date: Tue, 10 Nov 2026 14:09:56 -0500
Message-ID: <20261110190829.3442804-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060753-failed-5.15-2093bc7fa500@kernel.org>
References: <20261107060753-failed-5.15-2093bc7fa500@kernel.org>
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

[ Upstream commit 2093bc7fa50056fef8620d2b82bcb2e9a0a5575d ]

TCP request migration clones pending request sockets with
inet_reqsk_clone().  For MPTCP MP_CAPABLE requests this byte-copies the
token_node hlist state into the clone even though the token table still
names the original request, and the following warning can be seen:

  WARNING: net/mptcp/token.c:364 at mptcp_token_destroy_request+0x2b0/0x330, CPU#2: swapper/2/0
  CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 7.2.0-rc5-00353-gc27e36054537 #10 PREEMPT(full)
  RIP: 0010:mptcp_token_destroy_request (net/mptcp/token.c:364 (discriminator 1))
  Call Trace:
   <IRQ>
   subflow_v4_req_destructor (net/mptcp/subflow.c:694)
   __reqsk_free (net/ipv4/inet_connection_sock.c:906)
   reqsk_timer_handler (include/net/request_sock.h:137 net/ipv4/inet_connection_sock.c:1147)
   call_timer_fn (kernel/time/timer.c:1748)

Move token request ownership from the original request to the clone under
the token bucket lock.  Make mptcp_token_accept() and
mptcp_token_destroy_request() re-check token_node under the same lock and
treat an already moved or removed request as a normal race instead of
warning.  This also keeps token bucket chain_len accounting balanced.

If a passive MP_CAPABLE socket cannot claim the token, destroy the
provisional MPTCP socket and let the subflow fall back rather than
installing a socket with mismatched token ownership.  Mark that path as a
passive handshake fallback so MPCapableFallbackACK records the downgrade.

If the speculative clone later loses the inet_ehash_insert() ownership
arbitration, the original request may find that its token was already moved
and fall back to plain TCP.  The clone destructor then releases the token
reservation and keeps chain_len balanced.  This trades an exceptionally
rare fallback for eliminating the warning and persistent accounting drift.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261013-net-mptcp-misc-fixes-7-3-rc8-v1-4-932c9b182fc7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: adapted token acceptance failure handling to subflow_syn_recv_sock() using the existing mptcp_force_close() cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h   |  4 ++-
 net/mptcp/subflow.c    | 10 ++++++-
 net/mptcp/token.c      | 65 ++++++++++++++++++++++++++++++++++++++----
 net/mptcp/token_test.c |  4 +--
 4 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 913d9b1474b05..7fd7ee90c0e50 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -712,9 +712,11 @@ static inline void mptcp_token_init_request(struct request_sock *req)
 }
 
 int mptcp_token_new_request(struct request_sock *req);
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req);
 void mptcp_token_destroy_request(struct request_sock *req);
 int mptcp_token_new_connect(struct sock *sk);
-void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
+bool mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 bool mptcp_token_exists(u32 token);
 struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 73580bf40aca8..c0fb2400b907d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -81,6 +81,8 @@ void mptcp_subflow_reqsk_clone(struct request_sock *req,
 	}
 
 	new_subflow_req->msk = msk;
+
+	mptcp_token_move_request(req, new_req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
@@ -779,6 +781,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
+fallback:
 			if (fallback)
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 
@@ -803,13 +806,18 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			if (mp_opt.deny_join_id0)
 				WRITE_ONCE(mptcp_sk(new_msk)->pm.remote_deny_join_id0, true);
 
+			if (!mptcp_token_accept(subflow_req, mptcp_sk(new_msk))) {
+				WRITE_ONCE(mptcp_sk(new_msk)->first, NULL);
+				fallback = true;
+				goto fallback;
+			}
+
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
 			new_msk->sk_destruct = mptcp_sock_destruct;
 			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
 			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
-			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
 			ctx->conn = new_msk;
 			new_msk = NULL;
 
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index e581b341c5beb..7a9dd2ade92b7 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -178,6 +178,43 @@ int mptcp_token_new_connect(struct sock *sk)
 	return 0;
 }
 
+/**
+ * mptcp_token_move_request - move request token ownership to a clone
+ * @req: original request socket
+ * @new_req: cloned request socket
+ *
+ * Move the token hash entry from the original request to its clone.
+ */
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	struct mptcp_subflow_request_sock *new_subflow_req;
+	struct mptcp_subflow_request_sock *pos;
+	struct token_bucket *bucket;
+
+	new_subflow_req = mptcp_subflow_rsk(new_req);
+
+	if (hlist_nulls_unhashed_lockless(&subflow_req->token_node)) {
+		mptcp_token_init_request(new_req);
+		return;
+	}
+
+	bucket = token_bucket(subflow_req->token);
+	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&subflow_req->token_node)) {
+		mptcp_token_init_request(new_req);
+	} else {
+		pos = __token_lookup_req(bucket, subflow_req->token);
+		if (pos == subflow_req)
+			hlist_nulls_replace_init_rcu(&subflow_req->token_node,
+						     &new_subflow_req->token_node);
+		else
+			mptcp_token_init_request(new_req);
+	}
+	spin_unlock_bh(&bucket->lock);
+}
+
 /**
  * mptcp_token_accept - replace a req sk with full sock in token hash
  * @req: the request socket to be removed
@@ -185,22 +222,33 @@ int mptcp_token_new_connect(struct sock *sk)
  *
  * Called when a SYN packet creates a new logical connection, i.e.
  * is not a join request.
+ *
+ * Return: true on success.
  */
-void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
+bool mptcp_token_accept(struct mptcp_subflow_request_sock *req,
 			struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_request_sock *pos;
 	struct token_bucket *bucket;
+	bool ret = false;
 
 	bucket = token_bucket(req->token);
 	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&req->token_node))
+		goto unlock;
 
-	/* pedantic lookup check for the moved token */
 	pos = __token_lookup_req(bucket, req->token);
-	if (!WARN_ON_ONCE(pos != req))
-		hlist_nulls_del_init_rcu(&req->token_node);
+	if (pos != req)
+		goto unlock;
+
+	hlist_nulls_del_init_rcu(&req->token_node);
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
+	ret = true;
+
+unlock:
 	spin_unlock_bh(&bucket->lock);
+
+	return ret;
 }
 
 bool mptcp_token_exists(u32 token)
@@ -349,16 +397,21 @@ void mptcp_token_destroy_request(struct request_sock *req)
 	struct mptcp_subflow_request_sock *pos;
 	struct token_bucket *bucket;
 
-	if (hlist_nulls_unhashed(&subflow_req->token_node))
+	if (hlist_nulls_unhashed_lockless(&subflow_req->token_node))
 		return;
 
 	bucket = token_bucket(subflow_req->token);
 	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&subflow_req->token_node))
+		goto unlock;
+
 	pos = __token_lookup_req(bucket, subflow_req->token);
-	if (!WARN_ON_ONCE(pos != subflow_req)) {
+	if (pos == subflow_req) {
 		hlist_nulls_del_init_rcu(&pos->token_node);
 		bucket->chain_len--;
 	}
+
+unlock:
 	spin_unlock_bh(&bucket->lock);
 }
 
diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index 5d984bec1cd86..8fbf69b8172d3 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -91,7 +91,7 @@ static void mptcp_token_test_accept(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			mptcp_token_new_request((struct request_sock *)req));
 	msk->token = req->token;
-	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_TRUE(test, mptcp_token_accept(req, msk));
 	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(&init_net, msk->token));
 
 	/* this is now a no-op */
@@ -114,7 +114,7 @@ static void mptcp_token_test_destroyed(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			mptcp_token_new_request((struct request_sock *)req));
 	msk->token = req->token;
-	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_TRUE(test, mptcp_token_accept(req, msk));
 
 	/* simulate race on removal */
 	refcount_set(&sk->sk_refcnt, 0);
-- 
2.53.0

