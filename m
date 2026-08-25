Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C044062B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663882; cv=none; b=CdQBMs5sHC+bF14OagXTF6/hNIxcvRmPTyel2yDct3pAAS8jeAcmqCmrtDPb5csNapU1KECTLTuKr3Hh6+8/MyyGFIh0kHpdBSOZVEbj5HybJ0p0ccuD8ZrXgHmWkLjXiLHVdeObbxCSOd+JkYYfk2imcbdPgBkOFY21ozrQBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663882; c=relaxed/simple;
	bh=zzDBSIlYNdMWP/JXrT4+8YYT0ftbjOn+JH+mgz7psyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syQKkhr4g1QZZIp07gl5XpfUAM0oGpx7GZhVNSlG79JOegQ0Olq06/Zo6Hr0QVGdtdkDN9Vt9nXxZ2GzV6xHSetGkLJcrQZQ86kzodc/DICmJZ3VD8/m+fz1mKceonlQ5ECnWvMpe29SnWcodE62SN6jani9MwdpFbaYokssrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBQ2yC6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBQ2yC6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932601F000E9;
	Tue, 25 Aug 2026 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663879;
	bh=qtX65M0qcTl1fe8WpV568rvJnlF09lZfQsRnvW9Dgn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TBQ2yC6jKdlhQ500fUVYzGG4k156cjn471HXR10CObGXewrc6Lmxoh91o5fjBmgaA
	 hDVkqlpHloACFnDLyp1y/gSkksE3CC94iLWgnEl3SEqjyW5btwWqmSEGt1TSRxuAcd
	 1E83JKYBxFFTRKLCID5uZXqyZiNDZUO3uUEf2QaKssCt7fYsJenGEThKUxz6iNbwms
	 N6HKn6vho+yBKn7Wh6R1/Fc2rmuKUPidWfgB52VSF6cwlyi7y3hBFHRMM3XiGUR+DS
	 T6Y3d89lONNGsdduxMj2Q3kpxJlzly6WB4OorIJEKCANAfP70WPUV9THJc3A3ILf8w
	 JcmpRSrr6epSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: fix memory leak from alloc-during-teardown race
Date: Tue, 25 Aug 2026 09:17:57 -0400
Message-ID: <20260825131757.3822785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082048-armoire-active-d911@gregkh>
References: <2026082048-armoire-active-d911@gregkh>
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
[ set MPTCP_PM_DESTROYING in mptcp_destroy_common() since mptcp_pm_destroy() doesn't exist yet ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c   |  3 +++
 net/mptcp/pm_userspace.c | 10 +++++++---
 net/mptcp/protocol.c     |  5 +++++
 net/mptcp/protocol.h     |  7 ++++---
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9a931c4a9cdc2..6358b343881dc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -404,6 +404,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
+		return false;
+
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 42f46e92780c2..52ab9a3f070a8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -13,9 +13,9 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	if (!mptcp_pm_is_userspace(msk))
-		return;
-
+	/* Free the userspace local address list unconditionally: the socket
+	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
+	 */
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
@@ -53,6 +53,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING)) {
+		spin_unlock_bh(&msk->pm.lock);
+		return -EINVAL;
+	}
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 00314933da2a7..2ce20884d7305 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3540,6 +3540,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
+	spin_unlock_bh(&msk->pm.lock);
+
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ebefde9c22be3..e835028fc4e50 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -180,9 +180,10 @@ enum mptcp_pm_status {
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

