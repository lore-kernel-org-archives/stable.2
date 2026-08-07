Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA2272E6D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070174; cv=none; b=LATUlZqPXJlJGUZ5MfXJZHL8VoQEMZzZLNKRnfWOLrmHbD22RsU/00HfPrXtof/mcRwHIVjuF1yPW7H3/EVDm44bW0SjPL4aDhOAgamB2g36XGYPQpNMR62TpPGb0gHUL6hpLpnJnTpibiFo/gQ9ZFupMPZg0+0dfY3x3RObLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070174; c=relaxed/simple;
	bh=n0Ph/cUJUw5WPRwjkCvGJHiTWUXIJMBuh7LbvFzFA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pheOmmYwcKlbJu8UhZuMA1m90s1awuMt86UupnQ7VugWxb8tbTY4jkPX5NNkDj2F1aOvIVW+vpt/mlwg4vKDcH2c6/kE7P8SybXE47O92Ph9RlPDZVDwI6VFG+5o6/zSYkHnraxvbVGv3Y0VMoNbVpLG4qQbjPNbzxq8ykWdjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkXZgBzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkXZgBzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B77D1F000E9;
	Fri,  7 Aug 2026 02:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070172;
	bh=4xJMdkNp6pOlviu9T0fSkp7vnnM0OiZhdGBbF0XJrnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkXZgBzu8eqzcyMHWlpHMalVFtlQdn+YdVP7nEyAHrHYgp2h1LMeN+vVKruo1R7gg
	 WnJkyZQHJulDaTIdyf3LdRs4VcC/bI4K9Mw+NZq38ZIId/p8SX0QT7Hwld7rV05bxg
	 wK4Dn3vFGCh2rLFaWkgE2KB5Fp44UPk9IWRNhG0nCrgsq/zjyZeB89xZ8yWMDP47fq
	 MxDNRgV77/4sJ77Gboe9Vcm8JHDha2V0wRIc2xiZKCPPJx01L5c49XIJnDG9oXl2e1
	 JmTKMZY0CwVk82ntEXsOsdtPov++qIcUlQJo3/O7KMBjOHqtInXC+aLzzQ4txLdEu/
	 ht2fD8J+d2VEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] mptcp: cleanup MPJ subflow list handling
Date: Thu,  6 Aug 2026 22:36:08 -0400
Message-ID: <20260807023610.1683763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072945-judge-corset-9953@gregkh>
References: <2026072945-judge-corset-9953@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 3e5014909b5661b3da59990d72a317a45ba3b284 ]

We can simplify the join list handling leveraging the
mptcp_release_cb(): if we can acquire the msk socket
lock at mptcp_finish_join time, move the new subflow
directly into the conn_list, otherwise place it on join_list and
let the release_cb process such list.

Since pending MPJ connection are now always processed
in a timely way, we can avoid flushing the join list
every time we have to process all the current subflows.

Additionally we can now use the mptcp data lock to protect
the join_list, removing the additional spin lock.

Finally, the MPJ handshake is now always finalized under the
msk socket lock, we can drop the additional synchronization
between mptcp_finish_join() and mptcp_close().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: f3ca0ee2cc30 ("mptcp: decrement subflows counter on failed passive join")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c |   4 --
 net/mptcp/protocol.c   | 118 +++++++++++++++++------------------------
 net/mptcp/protocol.h   |  15 +-----
 net/mptcp/sockopt.c    |  24 +++------
 net/mptcp/subflow.c    |   5 +-
 5 files changed, 60 insertions(+), 106 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 01ecd546e8443..87321d545564e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -174,7 +174,6 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	msk_owned_by_me(msk);
 
 	rcu_read_lock();
-	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
@@ -619,7 +618,6 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
 	rcu_read_lock();
-	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
@@ -658,7 +656,6 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
 
 		rcu_read_lock();
-		__mptcp_flush_join_list(msk);
 		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 			if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 				continue;
@@ -796,7 +793,6 @@ void mptcp_pm_nl_addr_send_ack_avoid_list(struct mptcp_sock *msk,
 	    !mptcp_pm_should_rm_signal(msk))
 		return;
 
-	__mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		if (!__mptcp_subflow_active(subflow))
 			continue;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 26d32af7a43f7..4e1a5f10fba0a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -848,47 +848,38 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	mptcp_data_unlock(sk);
 }
 
-static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
+static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow;
-	bool ret = false;
+	struct sock *sk = (struct sock *)msk;
 
-	if (likely(list_empty(&msk->join_list)))
+	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
-	spin_lock_bh(&msk->join_list_lock);
-	list_for_each_entry(subflow, &msk->join_list, node) {
-		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
-
-		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
-		if (READ_ONCE(msk->setsockopt_seq) != sseq)
-			ret = true;
-	}
-	list_splice_tail_init(&msk->join_list, &msk->conn_list);
-	spin_unlock_bh(&msk->join_list_lock);
-
-	return ret;
-}
-
-void __mptcp_flush_join_list(struct mptcp_sock *msk)
-{
-	if (likely(!mptcp_do_flush_join_list(msk)))
-		return;
+	/* attach to msk socket only after we are sure we will deal with it
+	 * at close time
+	 */
+	if (sk->sk_socket && !ssk->sk_socket)
+		mptcp_sock_graft(ssk, sk->sk_socket);
 
-	if (!test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
-		mptcp_schedule_work((struct sock *)msk);
+	mptcp_propagate_sndbuf((struct sock *)msk, ssk);
+	mptcp_sockopt_sync_locked(msk, ssk);
+	return true;
 }
 
-static void mptcp_flush_join_list(struct mptcp_sock *msk)
+static void __mptcp_flush_join_list(struct sock *sk)
 {
-	bool sync_needed = test_and_clear_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags);
-
-	might_sleep();
+	struct mptcp_subflow_context *tmp, *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (!mptcp_do_flush_join_list(msk) && !sync_needed)
-		return;
+	list_for_each_entry_safe(subflow, tmp, &msk->join_list, node) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
 
-	mptcp_sockopt_sync_all(msk);
+		list_move_tail(&subflow->node, &msk->conn_list);
+		if (!__mptcp_finish_join(msk, ssk))
+			mptcp_subflow_reset(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
 }
 
 static bool mptcp_rtx_timer_pending(struct sock *sk)
@@ -1678,7 +1669,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			__mptcp_flush_join_list(msk);
 			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
@@ -2086,7 +2076,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	unsigned int moved = 0;
 	bool ret, done;
 
-	mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
@@ -2577,8 +2566,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
-	mptcp_flush_join_list(msk);
-
 	mptcp_check_fastclose(msk);
 
 	if (msk->pm.status)
@@ -2617,8 +2604,6 @@ static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	spin_lock_init(&msk->join_list_lock);
-
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
@@ -2781,7 +2766,6 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
-	mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2814,12 +2798,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	might_sleep();
 
-	/* be sure to always acquire the join list lock, to sync vs
-	 * mptcp_finish_join().
-	 */
-	spin_lock_bh(&msk->join_list_lock);
-	list_splice_tail_init(&msk->join_list, &msk->conn_list);
-	spin_unlock_bh(&msk->join_list_lock);
+	/* join list will be eventually flushed (with rst) at sock lock release time*/
 	list_splice_init(&msk->conn_list, &conn_list);
 
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
@@ -2934,8 +2913,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (sk->sk_wait_pending)
 		return -EBUSY;
 
-	mptcp_do_flush_join_list(msk);
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -3182,6 +3159,8 @@ static void mptcp_release_cb(struct sock *sk)
 			flags |= BIT(MPTCP_PUSH_PENDING);
 		if (test_and_clear_bit(MPTCP_RETRANSMIT, &mptcp_sk(sk)->flags))
 			flags |= BIT(MPTCP_RETRANSMIT);
+		if (test_and_clear_bit(MPTCP_FLUSH_JOIN_LIST, &mptcp_sk(sk)->flags))
+			flags |= BIT(MPTCP_FLUSH_JOIN_LIST);
 		if (!flags)
 			break;
 
@@ -3194,6 +3173,8 @@ static void mptcp_release_cb(struct sock *sk)
 		 */
 
 		spin_unlock_bh(&sk->sk_lock.slock);
+		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
+			__mptcp_flush_join_list(sk);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
@@ -3342,8 +3323,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct sock *parent = (void *)msk;
-	struct socket *parent_sock;
-	bool ret;
+	bool ret = true;
 
 	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
@@ -3356,36 +3336,39 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (!msk->pm.server_side)
 		goto out;
 
-	if (!mptcp_pm_allow_new_subflow(msk)) {
-		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
-		return false;
-	}
+	if (!mptcp_pm_allow_new_subflow(msk))
+		goto err_prohibited;
 
-	/* active connections are already on conn_list, and we can't acquire
-	 * msk lock here.
-	 * use the join list lock as synchronization point and double-check
-	 * msk status to avoid racing with __mptcp_destroy_sock()
+	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
+		goto err_prohibited;
+
+	/* active connections are already on conn_list.
+	 * If we can't acquire msk socket lock here, let the release callback
+	 * handle it
 	 */
-	spin_lock_bh(&msk->join_list_lock);
-	ret = inet_sk_state_load(parent) == TCP_ESTABLISHED;
-	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node))) {
-		list_add_tail(&subflow->node, &msk->join_list);
+	mptcp_data_lock(parent);
+	if (!sock_owned_by_user(parent)) {
+		ret = __mptcp_finish_join(msk, ssk);
+		if (ret) {
+			sock_hold(ssk);
+			list_add_tail(&subflow->node, &msk->conn_list);
+		}
+	} else {
 		sock_hold(ssk);
+		list_add_tail(&subflow->node, &msk->join_list);
+		set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->flags);
 	}
-	spin_unlock_bh(&msk->join_list_lock);
+	mptcp_data_unlock(parent);
+
 	if (!ret) {
+err_prohibited:
 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
 		return false;
 	}
 
-	/* attach to msk socket only after we are sure he will deal with us
-	 * at close time
-	 */
-	parent_sock = READ_ONCE(parent->sk_socket);
-	if (parent_sock && !ssk->sk_socket)
-		mptcp_sock_graft(ssk, parent_sock);
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	WRITE_ONCE(msk->allow_infinite_fallback, false);
+
 out:
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
@@ -3595,7 +3578,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
-		mptcp_flush_join_list(msk);
 		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5492c67ecc9a7..77350a0a0c704 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -121,7 +121,7 @@
 #define MPTCP_CLEAN_UNA		7
 #define MPTCP_ERROR_REPORT	8
 #define MPTCP_RETRANSMIT	9
-#define MPTCP_WORK_SYNC_SETSOCKOPT 10
+#define MPTCP_FLUSH_JOIN_LIST	10
 #define MPTCP_CONNECTED		11
 
 static inline bool before64(__u64 seq1, __u64 seq2)
@@ -252,7 +252,6 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
-	spinlock_t	join_list_lock;
 	int		keepalive_cnt;
 	int		keepalive_idle;
 	int		keepalive_intvl;
@@ -508,15 +507,6 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
 	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
 }
 
-static inline void mptcp_add_pending_subflow(struct mptcp_sock *msk,
-					     struct mptcp_subflow_context *subflow)
-{
-	sock_hold(mptcp_subflow_tcp_sock(subflow));
-	spin_lock_bh(&msk->join_list_lock);
-	list_add_tail(&subflow->node, &msk->join_list);
-	spin_unlock_bh(&msk->join_list_lock);
-}
-
 void mptcp_subflow_process_delegated(struct sock *ssk);
 
 static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
@@ -684,7 +674,6 @@ void __mptcp_data_acked(struct sock *sk);
 void __mptcp_error_report(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
-void __mptcp_flush_join_list(struct mptcp_sock *msk);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->snd_data_fin_enable) &&
@@ -859,7 +848,7 @@ static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 }
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
-void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
+void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
 {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 9e0fd3bffd940..e2605a9496563 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -904,27 +904,15 @@ void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
-void mptcp_sockopt_sync_all(struct mptcp_sock *msk)
+void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	u32 seq;
-
-	seq = sockopt_seq_reset(sk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
+	msk_owned_by_me(msk);
 
-		if (sseq != msk->setsockopt_seq) {
-			__mptcp_sockopt_sync(msk, ssk);
-			WRITE_ONCE(subflow->setsockopt_seq, seq);
-		} else if (sseq != seq) {
-			WRITE_ONCE(subflow->setsockopt_seq, seq);
-		}
+	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
+		sync_socket_options(msk, ssk);
 
-		cond_resched();
+		subflow->setsockopt_seq = msk->setsockopt_seq;
 	}
-
-	msk->setsockopt_seq = seq;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a5a03601c7f92..b1679c5949906 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1490,7 +1490,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
-	mptcp_add_pending_subflow(msk, subflow);
+	sock_hold(ssk);
+	list_add_tail(&subflow->node, &msk->conn_list);
 	mptcp_sockopt_sync(msk, ssk);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
 	if (err && err != -EINPROGRESS)
@@ -1503,9 +1504,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	return err;
 
 failed_unlink:
-	spin_lock_bh(&msk->join_list_lock);
 	list_del(&subflow->node);
-	spin_unlock_bh(&msk->join_list_lock);
 	sock_put(mptcp_subflow_tcp_sock(subflow));
 
 failed:
-- 
2.53.0

