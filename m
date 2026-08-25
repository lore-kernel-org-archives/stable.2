Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD93F4827
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657068; cv=none; b=EUFXzeUvAJvLiQgnbsnSXEQ3D2eYgX0P4WpAw4ObdlzvgwkDzNmLpBFmFbA2AWqWLgiuR97TEEoEtpYxI02xSRbxKNA2TLNyY9aVhppDrl5hkVT0yv2JO0b4pl5/kiDL3TE+ue2AjeCbOlO5UBqIrPIhpXTodqLI2DUJQqapADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657068; c=relaxed/simple;
	bh=MM2zyqJCFhoK4zM4mpb57umtPWx10RO/d4p2GmSLYp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xi1BeiqlDESpEtI59mPIPXUB0JpKGzazy5WMiZebDKfJGwM0piHsa6OYVK2v0iTjd33M3GsEch4pbxlQPWbNj1b04IkggEZxgPR3BDtNAzytGphWHVouEownnxHN7eiSXHC11peu833uWEzyk83xiwNMR4iiWFKUQV6y7vGUvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWbLtYZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWbLtYZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699C81F000E9;
	Tue, 25 Aug 2026 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657067;
	bh=lv2cnOrbiXvxl4iaKD0AAv0iOqQevY1mrjBosxNGWoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DWbLtYZbbV4++oUB3sPZXj265Rk3FcK2rRe34/8pbhoJ9Q9e6nlIwQWVHUz0vXF3e
	 6dXAsI0f2LKzRjH7nYLE2FIK/VvKlfvkaHQcIv8ViDRKpothcC4IGhRjl+RfoiESCU
	 cCpaoY7Gi9gdUihTr4TAPuPTMiMYtReKnqOrrkHX1spVMbz8Vvy56KuA82RQ2waqha
	 b71mdWGWNAdKwUw/L5mV8mT1tD7yQzqJJbFesL+u8CymPR25I/8gIzHZvK8F/ciIJs
	 tXcOYem9V+fdZ3QMvIEd0A5IfoInb5yCnhB2elg0z2ZNFkcB8GztA5poLR8erTbEI3
	 l+s/9pdAk5OQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: fix memory leak from alloc-during-teardown race
Date: Tue, 25 Aug 2026 07:24:24 -0400
Message-ID: <20260825112424.3540743-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082047-mutiny-refusing-2715@gregkh>
References: <2026082047-mutiny-refusing-2715@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

[ Upstream commit efc33b5102ff859bacd390a5f30112d8e0c084c0 ]

mptcp_pm_destroy() empties msk->pm.anno_list and
msk->pm.userspace_pm_local_addr_list under msk->pm.lock during socket
teardown, dropping the lock between the two.

A concurrent userspace PM genl ANNOUNCE on the same msk holds a sock
reference via mptcp_token_get_sock() and, in
mptcp_pm_nl_announce_doit(), calls
mptcp_userspace_pm_append_new_local_addr() and
mptcp_pm_announced_alloc(). Both take msk->pm.lock briefly to add to
their respective lists. Because the genl handler holds a sock reference,
mptcp_pm_destroy() may run on the same msk via mptcp_disconnect(), which
invokes mptcp_destroy_common() without dropping the sock refcount,
before the handler completes.

If the lock acquisitions interleave such that mptcp_pm_destroy() empties
a list first, the later alloc adds its entry to a list head that nothing
else iterates for this msk, and the entry leaks. kmemleak reports both
mptcp_pm_add_addr objects (from mptcp_pm_announced_alloc()) and
mptcp_pm_addr_entry objects (from
mptcp_userspace_pm_append_new_local_addr()) under sustained concurrent
ANNOUNCE + close load against the userspace PM.

Add an MPTCP_PM_DESTROYING bit in msk->pm.status, set by
mptcp_pm_destroy() under pm.lock before the lists are emptied and
checked under pm.lock by the alloc paths. Either the alloc takes pm.lock
first, in which case its entry is on the list when mptcp_pm_destroy()
frees it; or mptcp_pm_destroy() takes pm.lock first, in which case the
later alloc observes the bit and refuses.

Found by an MPTCP protocol-flow harness extending BRF (arXiv:2305.08782).

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Cc: stable@vger.kernel.org
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-6-b8f496d71664@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Inlined `mptcp_pm_destroy()` at its call site in `mptcp_destroy_common()` and moved the fences into the pre-rename `mptcp_pm_alloc_anno_list()`/`mptcp_free_local_addr_list()` equivalents, deleting the `mptcp_pm_is_userspace()` guard from inside the callee instead of the call site. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c   | 3 +++
 net/mptcp/pm_userspace.c | 7 ++++---
 net/mptcp/protocol.c     | 9 +++++++++
 net/mptcp/protocol.h     | 7 ++++---
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 550c4c1b963d8..876373e7d0cb0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -395,6 +395,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
+		return false;
+
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2a219e47392ce..33494c4a8fb29 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -14,9 +14,6 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	if (!mptcp_pm_is_userspace(msk))
-		return;
-
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
@@ -54,6 +51,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING)) {
+		ret = -EINVAL;
+		goto append_err;
+	}
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 967c3ef7aa2f2..8b61fe656ec66 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3578,7 +3578,16 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
+	spin_unlock_bh(&msk->pm.lock);
+
 	mptcp_pm_free_anno_list(msk);
+
+	/* Free the userspace local address list unconditionally: the socket
+	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
+	 */
 	mptcp_free_local_addr_list(msk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4540431b49c1..36f3f5b34a5d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -190,9 +190,10 @@ enum mptcp_pm_status {
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
-	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED /* persistent status, set after MPC local address is
-					 * accounted int id_avail_bitmap
-					 */
+	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED, /* persistent status, set after MPC local address is
+					  * accounted int id_avail_bitmap
+					  */
+	MPTCP_PM_DESTROYING,		/* To fence out PM list allocs */
 };
 
 enum mptcp_pm_type {
-- 
2.53.0

