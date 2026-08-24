Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78351393DF1
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615056; cv=none; b=uz4RG5wXswmFBy/IbRdOm3L73Wcvg+bv/j9N6OX2LnKtJksWormATJtoOnENtMxrPsb2RkDF4K5w7CBSt5+iy8ccob3d1G9GflmX55Intp81UAfwE/jOceTAidACHzlWssnvms4fmmPKtn3+NcaDjjR5mZL9b9TI1gtbi/joXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615056; c=relaxed/simple;
	bh=0shKeaVm+p9nwTUdyK1FmkEl2K0QQRX6zVe7R8Fys8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/9W2Zc8VimtQoc++uCEHG9RaefcVY/2DxfrYOk34g8atxY3yUM4N+HjOwP/jWBjxGEGYqe+hMyy7f+ZXmrl+1UAsai0E/7aN8Dx7swEE2kBV9znv0LsYuM6T1hdpaAEVMqlHa3IoFMtnwN5S8ChtrsvMs12UbB2h8dCrdldngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUBitBmr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUBitBmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723381F00A3A;
	Mon, 24 Aug 2026 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787615055;
	bh=bXknJZODuFSSGcXapetT9KIwuKs3JUNhAvWDUcrVPjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OUBitBmrIrq4DBPcUAcIYatP4SYbpIozpJj/0x9xo2uim2DEkwzjHHO0L2EBbeDQ9
	 gCTapiKq8MdFd2mh2MqOoca6sd9zRwuqD1vzRCyGG2Ztk2G3kTP9zGmTmniR3IG2WL
	 0c/Os7lPjgN61Fote+lwNu9nw6Xx/3OnQW7VkfqwTPjTHyMJkt3W1QFOIbocfkkSlw
	 JjL/SIPeRo81cjyBZtZQvGRdli/bLNNfbxxmNqzY6MvDuYBtWA2l7XhcWt8PmGE8nJ
	 8+ePe87T4+ClawaqVOAXuqJqffzxbygowax2y3I7SSedn/FK4hmZ7VMrcKFGUKUwa8
	 yPb0FjZsKpiEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] mptcp: pm: rename add_entry structure to add_addr
Date: Mon, 24 Aug 2026 19:44:10 -0400
Message-ID: <20260824234412.685251-2-sashal@kernel.org>
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

[ Upstream commit 350d76dd6e79468ac85767f2d236299a135572df ]

Using only the 'add' prefix is confusing: does it refer to a generic
added entry or address, or specifically to ADD_ADDRs. Using add_addr
removes this confusion.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260605-net-next-mptcp-add-addr6-port-ts-v2-10-758e7ca73f4d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: efc33b5102ff ("mptcp: pm: fix memory leak from alloc-during-teardown race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm.c       | 22 +++++++++++-----------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4e7c5357506ce..c8fd54670c32b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,7 +12,7 @@
 
 #define ADD_ADDR_RETRANS_MAX	3
 
-struct mptcp_pm_add_entry {
+struct mptcp_pm_add_addr {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
@@ -133,11 +133,11 @@ bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
 	return false;
 }
 
-static struct mptcp_pm_add_entry *
+static struct mptcp_pm_add_addr *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -152,7 +152,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	bool ret;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
@@ -164,7 +164,7 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
@@ -340,8 +340,8 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
-							      add_timer);
+	struct mptcp_pm_add_addr *entry = timer_container_of(entry, timer,
+							     add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -399,12 +399,12 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_add_addr *entry;
 	bool stop_timer = false;
 
 	rcu_read_lock();
@@ -436,7 +436,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_add_addr *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout;
 
@@ -473,7 +473,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_add_addr *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1d768efe60bb1..f2f6e082157b5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1084,7 +1084,7 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_pm_has_subflow_saddr(const struct mptcp_sock *msk,
-- 
2.53.0

