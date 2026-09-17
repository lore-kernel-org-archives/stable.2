Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAEA39061D
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617276; cv=none; b=OHlivjZIuAAluGO2ACP6ZI9e8fM/GlX110Up6w6QtznTp6sqO5yOYn4GUgAWLosU2QZkdCV/NSeWuAlZ3dBn0OTXSMI3AKj6aAhyw+LkAWnMKG95zUJ9wSePpaSj/0ZFQY8BuiJmbUHQydiFOhl3UGaJMZJ438YTqwd5PeD15G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617276; c=relaxed/simple;
	bh=I+dwx/ob7zRHY6Ugi0VIpdFOCzZTwi/pIy/V8mDJGzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSB2wWR7xgauW4+S+U/aWeuMfMhoS75bjZg2Y11WCUzLwLG0XUNAr2ayvv2/prlTuC++m17vCOyjVr1+YSrDtq+qUynD5crYBf+sEPf0vMjMO3yW0RqSu4a9tsZu+J3T4bHzX1cgqi1ACG36c0m821eUi6BOaJ+6QqxD3TXSCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjXOG8CS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjXOG8CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8D01F000FF;
	Thu, 17 Sep 2026 03:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617272;
	bh=E+TvUB7/EvYj97al7F97hHUv9VNnfh2bwf2RmB8uZo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjXOG8CSf1GwiVKKGovtG5/azhySe3I6tMbnhpYuelveP1aioKwOlxpvD6GRYCPwt
	 PHb0haETADoPmdQ1RfX0VNRMX3nRdwQK2zREVxUAQiL3NpC2THc4dx0ARJjAiIilEg
	 x8x1Num1Xl/XXzYEYcs0UzV4GKsRIILo4c25lR0chdq6yXFqkk5KV2R1zlwxy58ADT
	 vQLHGm8/8tXP7oRiRozogYikpBOfEJu2YkVumJbpfpkMoYSlzztAhZg+fbNcP314T4
	 U2Mr6rfQYI9yz1ylzJthdSmRnqqZ4yYWyjcoYCzMDudgwmZ2a3JxtR3e7Mdo7QAXXa
	 HizWHprQV2PFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mptcp: pm: uniform announced addresses helpers
Date: Wed, 16 Sep 2026 23:54:29 -0400
Message-ID: <20260917035430.4114445-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091603-retail-undrilled-d003@gregkh>
References: <2026091603-retail-undrilled-d003@gregkh>
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

Stable adaptation for 6.6:

Keep the existing announcement helpers and their stable implementations,
including struct mptcp_pm_add_entry and the teardown/timer fixes. Rename
all existing callers and declarations, including the destructor call in
protocol.c. Keep announcement removal static and retain the older
userspace removal path; do not import helpers absent from this tree.

Rename pm_netlink.c to pm_kernel.c and update the MPTCP Makefile. Also
rename the existing mptcp_pm_nl_rm_subflow_received() helper and callers
to mptcp_pm_rm_subflow(). These naming changes let target commit
2ac7d6e620764f1fc79eb4edd3610a7a661981ca apply unchanged. No functions are
added and no runtime behavior is changed by this dependency.

Stable-dep-of: 2ac7d6e62076 ("mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/Makefile                      |  2 +-
 net/mptcp/options.c                     |  2 +-
 net/mptcp/pm.c                          |  4 +-
 net/mptcp/{pm_netlink.c => pm_kernel.c} | 49 ++++++++++++-------------
 net/mptcp/pm_userspace.c                |  2 +-
 net/mptcp/protocol.c                    |  2 +-
 net/mptcp/protocol.h                    | 14 +++----
 net/mptcp/subflow.c                     |  4 +-
 8 files changed, 39 insertions(+), 40 deletions(-)
 rename net/mptcp/{pm_netlink.c => pm_kernel.c} (98%)

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 84e531f86b82f..a93434bfae6c2 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) += mptcp.o
 
 mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
-	   mib.o pm_netlink.o sockopt.o pm_userspace.o fastopen.o sched.o
+	   mib.o pm_kernel.o sockopt.o pm_userspace.o fastopen.o sched.o
 
 obj-$(CONFIG_SYN_COOKIES) += syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b76f73704cac1..aaea136b4c499 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1258,7 +1258,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0d21f4e693908..8e96819d22354 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -253,7 +253,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
@@ -390,7 +390,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 	 * let the PM state machine progress.
 	 */
 	if (skip_add_addr) {
-		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_announced_del_timer(msk, addr, true);
 		mptcp_pm_subflow_established(msk);
 	}
 	return ret;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_kernel.c
similarity index 98%
rename from net/mptcp/pm_netlink.c
rename to net/mptcp/pm_kernel.c
index 2be19e1877c88..9354f35f390fd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_kernel.c
@@ -255,8 +255,8 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 }
 
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
+			  const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -270,7 +270,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	return NULL;
 }
 
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *sk)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct mptcp_addr_info saddr;
@@ -322,7 +322,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	/* The cancel path (mptcp_pm_announced_del_timer()) can race with this
 	 * callback. Once cancel updates retrans_times to MAX, suppress further
 	 * retransmissions here. If this callback acquires pm.lock first, one
 	 * final transmit attempt is still possible.
@@ -355,8 +355,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 }
 
 struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
@@ -365,7 +365,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 		stop_timer = true;
@@ -388,7 +388,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	return entry;
 }
 
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
@@ -401,8 +401,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
 		return false;
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-
+	add_entry = mptcp_pm_announced_lookup(msk, addr);
 	if (add_entry) {
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
@@ -430,7 +429,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	return true;
 }
 
-void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -638,7 +637,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
+		if (!mptcp_pm_announced_alloc(msk, &local.addr))
 			return;
 
 		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
@@ -1050,8 +1049,8 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
 
-static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-					    const struct mptcp_rm_list *rm_list)
+static void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
+				const struct mptcp_rm_list *rm_list)
 {
 	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
@@ -1620,12 +1619,12 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 	return 0;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
+static bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
+	entry = mptcp_pm_announced_del_timer(msk, addr, false);
 	if (entry) {
 		kfree_rcu(entry, rcu);
 		return true;
@@ -1640,7 +1639,7 @@ static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
 	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
 }
 
-static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+static bool mptcp_pm_remove_announced(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
@@ -1649,7 +1648,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_pm_announced_remove(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (ret)
@@ -1687,14 +1686,14 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
+		mptcp_pm_remove_announced(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 
 		spin_lock_bh(&msk->pm.lock);
 		if (remove_subflow)
-			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			mptcp_pm_rm_subflow(msk, &list);
 		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 			__mark_subflow_endp_available(msk, list.ids[0]);
 		else /* mark endp ID as available, e.g. Signal or MPC endp */
@@ -1736,7 +1735,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
-		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
@@ -1809,7 +1808,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 			break;
 
 		/* only delete if either announced or matching a subflow */
-		if (remove_anno_list_by_saddr(msk, &entry->addr))
+		if (mptcp_pm_announced_remove(msk, &entry->addr))
 			anno_nr++;
 		else if (!lookup_subflow_by_saddr(&msk->conn_list,
 						  &entry->addr))
@@ -1839,7 +1838,7 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    remove_anno_list_by_saddr(msk, &entry->addr))
+		    mptcp_pm_announced_remove(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
@@ -1849,7 +1848,7 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 	}
 	if (slist.nr)
-		mptcp_pm_nl_rm_subflow_received(msk, &slist);
+		mptcp_pm_rm_subflow(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	msk->pm.local_addr_used = 0;
@@ -2140,7 +2139,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	mptcp_pm_rm_subflow(msk, &list);
 	__mark_subflow_endp_available(msk, list.ids[0]);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 12dd30d63c717..d0f6a3577cb53 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -235,7 +235,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+	if (mptcp_pm_announced_alloc(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 127438ef120e6..317aeca9cc328 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3541,7 +3541,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
 	spin_unlock_bh(&msk->pm.lock);
 
-	mptcp_pm_free_anno_list(msk);
+	mptcp_pm_free_announced_list(msk);
 
 	/* Free the userspace local address list unconditionally: the socket
 	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index af00d64e61f4b..7425e284bf3d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -942,16 +942,16 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
+void mptcp_pm_free_announced_list(struct mptcp_sock *msk);
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id);
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
+			  const struct mptcp_addr_info *addr);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index db2e3a1ebb6ed..97b414f5079f7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -233,7 +233,7 @@ static int subflow_check_req(struct request_sock *req,
 			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_announced_has_ssk(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				return -EPERM;
 			}
@@ -904,7 +904,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
-				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
+				if (!mptcp_pm_announced_has_ssk(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
 					goto dispose_child;
 				}
-- 
2.53.0

