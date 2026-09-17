Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56473A875E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615013; cv=none; b=C0e200eNvAcLz4WajAT9ahxv/eYl9snE6gCCU9YMrxy7FazvaLavHPLo35/I3CmrErkufjymSXcDtVQARpDifde+iNnPGh3RAT0df/gzr9gK0rOeerRlNH0eM/QLbOG5MA6b6+jhOSwQKmtJ9g7plOsEtJ5UEcKipB+DtBz5lHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615013; c=relaxed/simple;
	bh=LJRQnoQc+93AOkcs27eZDWDrbOZrpcSvd1g+OKgA5Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbQ0c/E6QeTALdMmqL5uNUvWA7peMuuytW6SbqYihNt0dW2T94x1uAmjmaqjwMa3sjrcZ1JHofCxsCQXeCCJIHVeMWPY39YBx2NsrMlbi8XVvsus7ozoKjCYRnrJrLcR4TmpPcOizMMvswV+E/q4lKrLRMIx2oNdqBjCRT8AORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUKmzJhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUKmzJhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B29B1F00898;
	Thu, 17 Sep 2026 03:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789615004;
	bh=AeNOojmcaWoRLSfZPozv/hBsqBJd5Eej+3aRpDHSB84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUKmzJhM402mj876pg8qgqKi8Ai9E76rSx/yGjTN8SFAPFCVs/XTMdpImX36ZH8qL
	 NRd3c2rpXlpeyKdNvriRvV/BLPAqa5berlPTaK4JPgri3DVegU3aJ4CUOsvbSuDSi8
	 erSWjtf8y/jp/IxaX2+ScZnF2+02iyuElMdqhQuLD3iTcTGPKP7Z+gjYPvYNQ/xQjW
	 TxNUSDQeoX/FG/UrPHJ5HZLoqTWiMwgrE7TGus87wlw2pR+p83xzGL57UZEC44FGlo
	 0adNk44gjvebO8mq3o+BNAV41yjV9t55np7uuX4WRHn4g08ZFGuw88V8KuMwOuAWPO
	 SoYBr5CMwgt5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mptcp: pm: rename add_entry structure to add_addr
Date: Wed, 16 Sep 2026 23:16:41 -0400
Message-ID: <20260917031642.3978029-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917031642.3978029-1-sashal@kernel.org>
References: <2026091602-garbage-gumdrop-1752@gregkh>
 <20260917031642.3978029-1-sashal@kernel.org>
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

Stable backport adaptation for 2ac7d6e620764f1fc79eb4edd3610a7a661981ca:

The stable tree retains the ADD_ADDR announcement structure and helpers
in pm_kernel.c, renamed from pm_netlink.c by the preceding dependency.
Apply the structure-tag rename to those existing definitions and users
instead of importing the upstream helper block into pm.c.

Update both return-type declarations in protocol.h: the announcement
lookup is still externally visible on this branch. Preserve the stable
function bodies, timer APIs, allocation APIs and linkage; no functions
are added. The target's ID0 removal hunks apply unchanged to pm_kernel.c.

[ sashal: Reduced backport -- upstream 350d76dd6e794 touches 2 file(s), this
  backport carries 2. Not backported here:
  net/mptcp/pm.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 2ac7d6e62076 ("mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_kernel.c | 20 ++++++++++----------
 net/mptcp/protocol.h  |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 44f7f419e69a2..f8190fb5166ee 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -18,7 +18,7 @@
 
 static int pm_nl_pernet_id;
 
-struct mptcp_pm_add_entry {
+struct mptcp_pm_add_addr {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
@@ -253,11 +253,11 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -271,7 +271,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
@@ -292,7 +292,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
+	struct mptcp_pm_add_addr *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -353,11 +353,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct sock *sk = (struct sock *)msk;
 	bool stop_timer = false;
 
@@ -390,7 +390,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_add_addr *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 	unsigned int timeout;
@@ -431,7 +431,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_add_addr *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
@@ -1575,7 +1575,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 static bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 36f3f5b34a5d6..8205250bbf834 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1048,10 +1048,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
-struct mptcp_pm_add_entry *
+struct mptcp_pm_add_addr *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
-- 
2.53.0

