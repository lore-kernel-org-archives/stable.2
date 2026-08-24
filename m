Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F83803C5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615055; cv=none; b=mCmj4G0XAxbphj4rcj4kiSJy+b5CGeZaJVm8P7/bJfK7xfYn17bwHbNXq+iRIuGo++6VDAqYPjtikrNXDF8KtjqO7mRo1+GsHShWLudhqq297pG4IaV/s1+reKGNco4g/5uqB6lgyTzVEgyjLfdxqFsMPRgdjISoqeiw2bHvtk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615055; c=relaxed/simple;
	bh=MdkW/8ostwefti6rQINtPZG6nUkXUs7KrLHd4SA02e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR3Dfw718M9OB8w2lWk46aN5Tyw7KTO9lYhGbz2pVCjcGbQKHuskYf1Uv+RYuNZiua9VuLML6wHUF2YuZca4WhBNS9RB21LjmMaunv8gcLxYzkIKTRAADWLcf2NACacQWHuCWuAgyZ2vLUg7Z85dWDkBvPRd/GdR91rOjK8Q8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4/mlJ3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4/mlJ3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA291F000E9;
	Mon, 24 Aug 2026 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787615054;
	bh=e5P6tOVHy72K3XGlbquwCRYqlWoMTXh5Tz/VNuKTCbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4/mlJ3ogoS/BOYYmWUJCSunjmfYaGDJFIvgbfBzcSCawqL4IalgY9IncJk/Fd20e
	 S+iWnpGYovs2+TZ6BHiR99bVvKRnLvDiV/BHsenX/xhsaTu9/ynSKWU1eh4TWav3QL
	 WmiYu7xGqiqcV2XC+7BO0REteov8Q236Ex/U5XiNCJY6T4s/z89YB2m8nHdFqvThm6
	 CXjRD+hxPL5B7QFdCC4DQexEznf8abar/3jgTUnI7vd/bkwT/+k1QlJ9FmKFPWsyt3
	 j9JGWkgElVavEWUW5NvFJSE6jeeDhn3SSUWlpgNdqaqjzk/qUFWqM9fSJOqRWr14Vd
	 gqosVA69Web3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] mptcp: pm: use for_each_subflow helper
Date: Mon, 24 Aug 2026 19:44:09 -0400
Message-ID: <20260824234412.685251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082046-scolding-cresting-0cd9@gregkh>
References: <2026082046-scolding-cresting-0cd9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit f81689172429885d6c2c7c3dd4926ec626e794bb ]

Similar to most places in the MPTCP code. So instead of passing the
subflow list and use list_for_each_entry(subflow, list, node), pass the
msk and use mptcp_for_each_subflow(msk, subflow).

That's clearer and more uniform with the rest.

While at it, add 'pm_' prefix for the exported one to easily identify
the origin. Plus replace 'lookup' by 'has', because a bool is returned.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260605-net-next-mptcp-add-addr6-port-ts-v2-9-758e7ca73f4d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: efc33b5102ff ("mptcp: pm: fix memory leak from alloc-during-teardown race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm.c           |  6 +++---
 net/mptcp/pm_kernel.c    | 12 ++++++------
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4f2c173d9d750..4e7c5357506ce 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -115,14 +115,14 @@ static bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
-bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-				   const struct mptcp_addr_info *saddr)
+bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
 	struct sock_common *skc;
 
-	list_for_each_entry(subflow, list, node) {
+	mptcp_for_each_subflow(msk, subflow) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		mptcp_local_address(skc, &cur);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index a31a845e5cd42..10c8ccc61c3c4 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -86,13 +86,13 @@ u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_extra_subflows);
 
-static bool lookup_subflow_by_daddr(const struct list_head *list,
-				    const struct mptcp_addr_info *daddr)
+static bool has_subflow_daddr(const struct mptcp_sock *msk,
+			      const struct mptcp_addr_info *daddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
 
-	list_for_each_entry(subflow, list, node) {
+	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (!((1 << inet_sk_state_load(ssk)) &
@@ -652,7 +652,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_addr_send_ack(msk);
 	mptcp_mpc_endpoint_setup(msk);
 
-	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
+	if (has_subflow_daddr(msk, &remote))
 		return;
 
 	/* pick id 0 port, if none is provided the remote address */
@@ -1074,7 +1074,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			goto next;
 
 		lock_sock(sk);
-		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
+		remove_subflow = mptcp_pm_has_subflow_saddr(msk, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
@@ -1202,7 +1202,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+		    mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index db5693262c8c6..f80bace765500 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -286,7 +286,7 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	/* only delete if either announced or matching a subflow */
 	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
 		anno_nr++;
-	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+	else if (!mptcp_pm_has_subflow_saddr(msk, &entry->addr))
 		return;
 
 	alist.ids[alist.nr++] = entry->addr.id;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a03c8b04ee9ba..1d768efe60bb1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1087,8 +1087,8 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
-bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-				   const struct mptcp_addr_info *saddr);
+bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
-- 
2.53.0

