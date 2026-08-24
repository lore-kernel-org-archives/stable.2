Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415443812EF
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608540; cv=none; b=S1qfjAQj5yfIA7rmcswqAMJIzWYNeg+WsdsZnbbKX6CJDORHcgElOrV3Lw3x4hrpUMIExObQGuc3xs6EazelCH8Z0wfRDAUaPnXE0ln0Tu+xkFaKyOlg9gVZ67H/oeNKO+xT0qMXVIGssoEmmGA2HgLCWogIBm0KoUfiDhX6q6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608540; c=relaxed/simple;
	bh=tp4UOeviWPLANhEW6EGaI+YXWy62nn9Codsdbx35Ews=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cun/XEMmGEfVp2L73nduhUJSHgM/7w1HpcSCb7I60ynvuUNY6wnpDeT+8X13e4IdDgfmyl5jdUdbda5NHJTT5fj6jsCH4EfT/AI/kX1SN16RkluNiwAeW30T3X8icWySN4Ee4be5/2yjmy+NZz11SZwioWfe7YiT76749XUlcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uwv3duvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwv3duvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561B41F000E9;
	Mon, 24 Aug 2026 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608538;
	bh=Zl1JEs8fPyzDdZLkH4ttuQkwWIi9iv0oD9FUbt1as7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uwv3duvVlUVpKpDmsUzO/1RjvRVrbM6/VzaEMdXBLes+PaapxasGjlM2XPu4iy7Zt
	 SQisRcVd4r8y10mjjw12jgoxUgjbaW212m0bYTNXbQmYscF5t/us0bvX+wyIKI5Kek
	 I7RaMY6YgG3eVItE2kPiKyOEeEyZRR1br3gAs2o3R6M7pGg3Dett7bWMUNn00LEZh2
	 64d5oOZ4Pr3D5bFA12m1/gYR6cpjUXtZzX6eLfFv1w+QTjX9fWx3EfJnRnvexalGd8
	 KuTsbsHDd4c41g/j3JhI7ndPuCt9Dw3f4sw69xYx0YHpKyC7hGPbD4nMnq08Y5ayDk
	 lZZ5MA9r8saNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/3] mptcp: pm: rename add_entry structure to add_addr
Date: Mon, 24 Aug 2026 17:55:34 -0400
Message-ID: <20260824215537.431571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082045-blaming-kiln-83fe@gregkh>
References: <2026082045-blaming-kiln-83fe@gregkh>
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
index c5f95c251fbfa..745ccca474db7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,7 +12,7 @@
 
 #define ADD_ADDR_RETRANS_MAX	3
 
-struct mptcp_pm_add_entry {
+struct mptcp_pm_add_addr {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
@@ -133,11 +133,11 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
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
index 352d5771de0b1..3c5dd07f57bb0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1133,7 +1133,7 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
-- 
2.53.0

