Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1D51B18A;
	Tue, 13 Oct 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901804; cv=none; b=dxpChhSNAM8e3rmU68s7jPgqStYXGUo4JIyia/sSdGFSS/ngXpqp12VaSom0cDPeNskWLgxIGmS4EhT0QlOKCdWJzC0b2aXeQVb+1g1YNokPsMC/DC5j9qKgYnfoYeYhzbTOYThooPrVVwx46Q5LhLfoUeO9fvJAyB4b+O+utFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901804; c=relaxed/simple;
	bh=IdW4R4gqcSI/i6vYYmDLjdNdLbE/LCN3TUzswns8h6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s0M3YTz2M+eGzXcT8ypTT9FnyQ4V9OSk/opnkeu0hkYwuwsO0xJ94NMJFR7IxeHr5vcU9Rx51mN4VteutcpXVPkNX/lnNfQ3S04zmEeTY1GNUZxYlb+lPeeW8V9fIDfB8jf4TTAuglEIFwVRGrBgJhf6vs1wbLDyG10qfczIDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5a2Wlv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5a2Wlv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AA61F000FF;
	Tue, 13 Oct 2026 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901802;
	bh=XvmG6srCFZD3gvLPKwQK8KOCNAbbFShLGPMRv8LaDb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e5a2Wlv8uQ5jHbIHbEt/jKQhKnBvRz1/D3cq9KyYC4qyQxJd2hy9cdD9/5rue0lrL
	 wZIwxAi7/y2jyD9kInWUbj3goxjZZUYuZ91BrBnH233mcY3ctM24WfuAtUeg8QfZSH
	 iyl1s0TcUz7KkicEMzykBFuWZYmgjGGu6U3JeWrvUV7Wn0uaj8sKAAMvRmWhRnnpPG
	 gQsDp64i9kdMFjEEjh6TUPXgfC39ynyo/M+VvtfAtmSR26alavy70j9QpIV9MRa+tx
	 3FzBumTyKBlLgc0HozOHn7OLF8lD5wjoR4WPqGvLIiCX7IXyop7zXxZ2JcP/VKJ8Si
	 69NKoh5ITOZ9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Oct 2026 16:29:22 +0200
Subject: [PATCH net 4/4] mptcp: fix MP_CAPABLE token migration when cloning
 reqsk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-4-932c9b182fc7@kernel.org>
References: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
In-Reply-To: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Ruide Cao <caoruide123@gmail.com>, stable@vger.kernel.org, 
 Vega <vega@nebusec.ai>, Sashiko <sashiko-bot@kernel.org>, 
 Ren Wei <weir@nebusec.ai>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10599; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kKtTIJqrnRIR4+BDDu5GdGAdZPPvXyBYZZIgJ2snsuI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOOUT2982sTWv8Hf52zbaSx/cj4988WH1kxoqjSgHXw
 1tyVl3u7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI0DRGhssM71Yn67DZ1pnY
 GWczBUo2qZW9PNz7qPB+wTW395YVzxgZVnnv/3fPb7GAHevuVPlajmjfn5xT+cRD4vgcpvwRcOn
 nAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Ruide Cao <caoruide123@gmail.com>

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
Assisted-by: LLM
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
v6: https://lore.kernel.org/cover.1788800732.git.caoruide123@gmail.com
---
 net/mptcp/protocol.c   | 31 +++++++++++++++++++----
 net/mptcp/protocol.h   |  4 ++-
 net/mptcp/subflow.c    |  6 ++++-
 net/mptcp/token.c      | 68 ++++++++++++++++++++++++++++++++++++++++++++------
 net/mptcp/token_test.c |  4 +--
 5 files changed, 97 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e6f73a5ee630..05c38564e8fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3706,6 +3706,24 @@ static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
 	rcu_read_unlock();
 }
 
+static void mptcp_sk_clone_destroy(struct sock *nsk)
+{
+	struct mptcp_sock *msk = mptcp_sk(nsk);
+
+	mptcp_release_sched(msk);
+	mptcp_set_state(nsk, TCP_CLOSE);
+	/* inet_csk_prepare_forced_close() clears TCP sock_ops state via
+	 * tcp_sk(), but nsk is an MPTCP master socket; keep the inet-level
+	 * destroy preparation here.
+	 */
+	bh_unlock_sock(nsk);
+	sock_put(nsk);
+	sock_set_flag(nsk, SOCK_DEAD);
+	tcp_orphan_count_inc();
+	inet_sk(nsk)->inet_num = 0;
+	inet_csk_destroy_sock(nsk);
+}
+
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
@@ -3765,11 +3783,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssk);
 
-	/* new mpc subflow takes ownership of the newly
-	 * created mptcp socket
-	 */
-	mptcp_token_accept(subflow_req, msk);
-
 	/* set msk addresses early to ensure mptcp_pm_get_local_id()
 	 * uses the correct data
 	 */
@@ -3778,6 +3791,14 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
 
+	if (!mptcp_token_accept(subflow_req, msk)) {
+		list_del_init(&subflow->node);
+		WRITE_ONCE(msk->first, NULL);
+		sock_put(ssk);
+		mptcp_sk_clone_destroy(nsk);
+		return NULL;
+	}
+
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	bh_unlock_sock(nsk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c006110b1c56..4ed598febbf0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1083,9 +1083,11 @@ static inline void mptcp_token_init_request(struct request_sock *req)
 }
 
 int mptcp_token_new_request(struct request_sock *req);
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req);
 void mptcp_token_destroy_request(struct request_sock *req);
 int mptcp_token_new_connect(struct sock *ssk);
-void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
+bool mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 bool mptcp_token_exists(u32 token);
 struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3139a9ab2853..2c72cb50fbf3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -78,6 +78,8 @@ void mptcp_subflow_reqsk_clone(struct request_sock *req,
 	}
 
 	new_subflow_req->msk = msk;
+
+	mptcp_token_move_request(req, new_req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
@@ -922,8 +924,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 		if (ctx->mp_capable) {
 			ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
-			if (!ctx->conn)
+			if (!ctx->conn) {
+				fallback = true;
 				goto fallback;
+			}
 
 			ctx->subflow_id = 1;
 			owner = mptcp_sk(ctx->conn);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f1a50f367add..e0f2823f92ef 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -180,6 +180,43 @@ int mptcp_token_new_connect(struct sock *ssk)
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
@@ -187,24 +224,36 @@ int mptcp_token_new_connect(struct sock *ssk)
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
 	struct sock *sk = (struct sock *)msk;
 	struct token_bucket *bucket;
+	bool ret = false;
 
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
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
+	if (ret)
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+
+	return ret;
 }
 
 bool mptcp_token_exists(u32 token)
@@ -355,16 +404,21 @@ void mptcp_token_destroy_request(struct request_sock *req)
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
index 4fc39fa2e262..be9acce8a567 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -99,7 +99,7 @@ static void mptcp_token_test_accept(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			mptcp_token_new_request((struct request_sock *)req));
 	msk->token = req->token;
-	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_TRUE(test, mptcp_token_accept(req, msk));
 	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(&init_net, msk->token));
 
 	/* this is now a no-op */
@@ -122,7 +122,7 @@ static void mptcp_token_test_destroyed(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			mptcp_token_new_request((struct request_sock *)req));
 	msk->token = req->token;
-	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_TRUE(test, mptcp_token_accept(req, msk));
 
 	/* simulate race on removal */
 	refcount_set(&sk->sk_refcnt, 0);

-- 
2.55.0

