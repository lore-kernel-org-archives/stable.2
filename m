Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F033803C5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615057; cv=none; b=mIka4TybDLhKOlX7E6YmVl/frGS+YMhVpZJlWYBDhJtNs7haRjHMMNq0MhH4kl8BuhOjAlgcenZC6kjdQbtaX1FCsFR6k5BW8d5BmbJ31uCk3wyDuYxgzugnvISHUgUVbV3YM6+OOO/GXWzAn1lKDW/sLIVq89heXU2k7nlvjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615057; c=relaxed/simple;
	bh=PjC7kv9mEhpFCHYOaxkjRkHeWYJf03o3u8o+NbyilBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfJSoC3nKqtguLgLmH5QUj0RDD0Pi+x9QRpHeWUQpfaTNgRoodiUWMA3nNNM60rZssKttByL8UW8rCnUUWN37DTUn8vHF23qNW7p+n2IF7O/aaFwMD+cPfEDzl+y3P7qZXC86GYGNNHNZH3DGP7FbM/EDOxDWt9XQ/37MYk3SfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq3ZXHBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq3ZXHBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFC31F00A3F;
	Mon, 24 Aug 2026 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787615055;
	bh=djFczw46PIA4GHdFxc7/XLzZjzljxvrneZLB9X1Lxqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jq3ZXHBdEVCO/gKp2KT1sTtCgFqxq8guNo17f/iSzrHtoAwDJfdZJmci8ar6z1i0Y
	 O7SspsMFDdQP/Vy9CcCOTt6buQrScAbfjHKHB96yd5DfYo8gvgyapbYBkHa4u4ohvA
	 DrwMxaxExbT0NviSYlp5uT2JpDlFIR7Cpt9kn4kwHbwl6i4SYFmLAMwbTyNs7u1AS/
	 D4sjMQFtbi9wfVwW9oBk2vryFqGyOOVazOmozfmCpghZLlyl+s6Ik0UcpTR4HHkd4x
	 BxBJ0+5RrR2Vp5MnTPfNef34jXF8bbXrl9objtb8qz+wTqZ4ilw7Pi/gPg+SCAYajp
	 LPOkxee5Sb38Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] mptcp: pm: uniform announced addresses helpers
Date: Mon, 24 Aug 2026 19:44:11 -0400
Message-ID: <20260824234412.685251-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824234412.685251-1-sashal@kernel.org>
References: <2026082046-scolding-cresting-0cd9@gregkh>
 <20260824234412.685251-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 7d4dacc8ccca8e40fcb5f2ece9ea3e502da1bd3f ]

Similar to the previous commit, only using the 'add' or 'anno' prefixes
is confusing -- generally associated to the action of adding something,
or the Latin name for "year" -- and lack of uniformity.

This has been causing issues in the past, e.g. del_add_timer seemed to
suggest the goal is to delete a previously added timer.

Instead, use the mptcp_pm_announced_ prefix.

While at it, slightly improves some helpers:

- mptcp_lookup_anno_list_by_saddr: no need to specify what is used to do
  the lookup: mptcp_pm_announced_lookup.

- mptcp_pm_sport_in_anno_list: it doesn't just compare the port, but the
  whole address linked to the sublow: mptcp_pm_announced_has_ssk.

- mptcp_pm_alloc_anno_list: it allocates one item of the list, not a
  whole list: mptcp_pm_announced_alloc.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260605-net-next-mptcp-add-addr6-port-ts-v2-11-758e7ca73f4d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: efc33b5102ff ("mptcp: pm: fix memory leak from alloc-during-teardown race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c      |  2 +-
 net/mptcp/pm.c           | 35 +++++++++++++++++------------------
 net/mptcp/pm_kernel.c    | 10 +++++-----
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     | 12 ++++++------
 net/mptcp/subflow.c      |  4 ++--
 6 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 14a6d7265530c..7f7aa5af6092c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1259,7 +1259,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c8fd54670c32b..ddf68e175cc4b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -134,8 +134,8 @@ bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
 }
 
 static struct mptcp_pm_add_addr *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
+			  const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_addr *entry;
 
@@ -149,26 +149,26 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	return NULL;
 }
 
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr)
+bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_addr *entry;
 	bool ret;
 
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
+	entry = mptcp_pm_announced_del_timer(msk, addr, false);
 	ret = entry;
 	kfree_rcu(entry, rcu);
 
 	return ret;
 }
 
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk)
 {
 	struct mptcp_pm_add_addr *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	mptcp_local_address((struct sock_common *)sk, &saddr);
+	mptcp_local_address((struct sock_common *)ssk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
@@ -365,7 +365,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	/* The cancel path (mptcp_pm_announced_del_timer()) can race with this
 	 * callback. Once cancel updates retrans_times to MAX, suppress further
 	 * retransmissions here. If this callback acquires pm.lock first, one
 	 * final transmit attempt is still possible.
@@ -400,8 +400,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 }
 
 struct mptcp_pm_add_addr *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_add_addr *entry;
@@ -410,7 +410,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 		stop_timer = true;
@@ -433,7 +433,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	return entry;
 }
 
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_addr *add_entry = NULL;
@@ -442,8 +442,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-
+	add_entry = mptcp_pm_announced_lookup(msk, addr);
 	if (add_entry) {
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
@@ -471,7 +470,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	return true;
 }
 
-static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_addr *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -738,7 +737,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
@@ -947,7 +946,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 	 * let the PM state machine progress.
 	 */
 	if (skip_add_addr) {
-		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_announced_del_timer(msk, addr, true);
 		mptcp_pm_subflow_established(msk);
 	}
 	return ret;
@@ -1102,7 +1101,7 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
-	mptcp_pm_free_anno_list(msk);
+	mptcp_pm_free_announced_list(msk);
 
 	if (mptcp_pm_is_userspace(msk))
 		mptcp_userspace_pm_free_local_addr_list(msk);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 10c8ccc61c3c4..a7ce94ae2d1f4 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -359,7 +359,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
+		if (!mptcp_pm_announced_alloc(msk, &local.addr))
 			return;
 
 		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
@@ -1028,7 +1028,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+static bool mptcp_pm_remove_announced(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
@@ -1037,7 +1037,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_pm_announced_remove(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (ret)
@@ -1075,7 +1075,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = mptcp_pm_has_subflow_saddr(msk, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
+		mptcp_pm_remove_announced(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
@@ -1206,7 +1206,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+		    mptcp_pm_announced_remove(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f80bace765500..945aa5afc2ddf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -231,7 +231,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+	if (mptcp_pm_announced_alloc(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_addr_send_ack(msk);
@@ -284,7 +284,7 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	int anno_nr = 0;
 
 	/* only delete if either announced or matching a subflow */
-	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_pm_announced_remove(msk, &entry->addr))
 		anno_nr++;
 	else if (!mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f2f6e082157b5..ba1e3d2a9d9fb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1081,16 +1081,16 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr,
 			      struct mptcp_addr_info *rem,
 			      u8 bkup);
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_addr *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id);
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id);
+bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr);
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *saddr);
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr);
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 			  struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 42fd759c51df4..146127538a80d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -235,7 +235,7 @@ static int subflow_check_req(struct request_sock *req,
 			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_announced_has_ssk(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
@@ -928,7 +928,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
-				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
+				if (!mptcp_pm_announced_has_ssk(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
 					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 					goto dispose_child;
-- 
2.53.0

