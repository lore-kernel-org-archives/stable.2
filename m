Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F9511E89
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650932; cv=none; b=jII+9p2T26Z55u3whORraMvEf7bflMrcMiVq3cfyVzCiif14Fvd+y5KYlfN4eZa2NpcBc/DB6jwqQASJIKMJo2MBjdmbfGBRzhEL4MeEGTaw0KPWXPNxJ8PChtzCWjy3ejRtYCvzhFgvGcoLgLVEpU7O+7id/J3PQuN16wk+Fpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650932; c=relaxed/simple;
	bh=ySI8N4zT8P6VK/P4JHNrzzJjNHzYEN/NUeSeIyFoIEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqGYkARcLbxnmSc+pbwuLFf20CtP7MHW3o7w3UQsnFYfTaafZ3pBt6R4LX4KaUC0h/MvJSA+P1ufrC7+tvuPxo46dFQSY4p1Hy3A9L0amqxnbsAOkQwuUzvQqb1AyOBpTifsORfAyxtSUjl9jPOP4nEH8RqRET4mEOL/ihbhBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvDA/8F2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvDA/8F2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831441F000FF;
	Thu, 17 Sep 2026 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650925;
	bh=+b+74OYui8VaAU8JikdTJrbJP2idOfx2u5IVis1zYLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvDA/8F2CS2eS5DN1V0N3Mf+YaYE2BMMYneVFWfuMeJNmm53m3UZPUvLhZfdYNrge
	 es5S0TUDMVnNgyeN4Ak9i7E7Oz2dO9kP+WdM1eLuKPwk3wyKEXTb7Yw1/8sS1FiPRS
	 iFZ8+chzJsdEv0AM8m1c+3Onh9DjlokM02lKhjv0mY/7ILxUF1jogaiaQGkBgAznBb
	 QEYtCmUywEbKywnVG6/jCbt3Y9eZmzq7D+CAgqk67BTvT51yOR57bBioDwCrAJnntF
	 gBXwkTfst4xRi/9T5MUmTryP+pNrF+W4avE/59+0oVNzDma/Ng8xFvyUde8BzVcCXF
	 84qKt7d0Sqt5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mptcp: pm: uniform announced addresses helpers
Date: Thu, 17 Sep 2026 09:15:22 -0400
Message-ID: <20260917131523.352351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091604-bogus-decent-1706@gregkh>
References: <2026091604-bogus-decent-1706@gregkh>
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

Backport to 5.15: apply the helper renames to the existing path manager
implementations, retaining their types, visibility, locking and behaviour.
In particular, rename the existing remove_anno_list_by_saddr() helper to
mptcp_pm_announced_remove(); no new functions are introduced. Update the
5.15 destructor in protocol.c as well as all declarations and callers.
Drop the userspace path-manager hunks because that implementation is absent.

Move the existing pm_netlink.c to pm_kernel.c and update the MPTCP Makefile
so target 2ac7d6e620764f1fc79eb4edd3610a7a661981ca can be cherry-picked
without a missing-file conflict. This is only a source-file rename; keep
the 5.15 netlink implementation instead of importing the upstream split.

[ sashal: Reduced backport -- upstream 7d4dacc8ccca8 touches 6 file(s), this
  backport carries 7. Not backported here:
  net/mptcp/pm_userspace.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 2ac7d6e62076 ("mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/Makefile                      |  2 +-
 net/mptcp/options.c                     |  2 +-
 net/mptcp/pm.c                          |  4 +--
 net/mptcp/{pm_netlink.c => pm_kernel.c} | 34 ++++++++++++-------------
 net/mptcp/protocol.c                    |  2 +-
 net/mptcp/protocol.h                    | 12 ++++-----
 net/mptcp/subflow.c                     |  4 +--
 7 files changed, 30 insertions(+), 30 deletions(-)
 rename net/mptcp/{pm_netlink.c => pm_kernel.c} (98%)

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index e54daceac58be..41a84e3d4db50 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) += mptcp.o
 
 mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
-	   mib.o pm_netlink.o sockopt.o
+	   mib.o pm_kernel.o sockopt.o
 
 obj-$(CONFIG_SYN_COOKIES) += syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c913f1903380b..6a79223a4bd64 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1208,7 +1208,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 737fb96ff690d..4b2a5cec7079e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -215,7 +215,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
@@ -326,7 +326,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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
index e912615e008f3..c91ba820e830a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_kernel.c
@@ -276,8 +276,8 @@ static void check_work_pending(struct mptcp_sock *msk)
 }
 
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
+			  const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -291,7 +291,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	return NULL;
 }
 
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *sk)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct mptcp_addr_info saddr;
@@ -343,7 +343,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	/* The cancel path (mptcp_pm_announced_del_timer()) can race with this
 	 * callback. Once cancel updates retrans_times to MAX, suppress further
 	 * retransmissions here. If this callback acquires pm.lock first, one
 	 * final transmit attempt is still possible.
@@ -376,8 +376,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 }
 
 struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
@@ -386,7 +386,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 		stop_timer = true;
@@ -409,7 +409,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	return entry;
 }
 
-static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+static bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 				     const struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
@@ -419,7 +419,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_pm_announced_lookup(msk, &entry->addr))
 		return false;
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -441,7 +441,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	return true;
 }
 
-void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -545,7 +545,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
 		if (select_signal_address(pernet, msk->pm.add_addr_signaled,
 					  &local)) {
-			if (mptcp_pm_alloc_anno_list(msk, &local)) {
+			if (mptcp_pm_announced_alloc(msk, &local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local.addr, false);
 				mptcp_pm_nl_addr_send_ack(msk);
@@ -1466,12 +1466,12 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
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
@@ -1480,7 +1480,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 	return false;
 }
 
-static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+static bool mptcp_pm_remove_announced(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
@@ -1489,7 +1489,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = addr->id;
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_pm_announced_remove(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		msk->pm.add_addr_signaled -= ret;
@@ -1516,7 +1516,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
+		mptcp_pm_remove_announced(msk, addr, remove_subflow);
 		if (remove_subflow)
 			mptcp_pm_remove_subflow(msk, &list);
 		release_sock(sk);
@@ -1632,7 +1632,7 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 			alist.ids[alist.nr++] = entry->addr.id;
 			slist.ids[slist.nr++] = entry->addr.id;
 		} else if (alist.nr < MPTCP_RM_IDS_MAX &&
-			   remove_anno_list_by_saddr(msk, &entry->addr)) {
+			   mptcp_pm_announced_remove(msk, &entry->addr)) {
 			alist.ids[alist.nr++] = entry->addr.id;
 		}
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 522d8740a0f3a..1fa36034afa26 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3110,7 +3110,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
-	mptcp_pm_free_anno_list(msk);
+	mptcp_pm_free_announced_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 609e7768fab31..69f53465bdb35 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -753,14 +753,14 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
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
 int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 					 u8 *flags, int *ifindex);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 33b16ea7ae5bc..262df0724fa8b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -230,7 +230,7 @@ static int subflow_check_req(struct request_sock *req,
 			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_announced_has_ssk(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				return -EPERM;
 			}
@@ -806,7 +806,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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

