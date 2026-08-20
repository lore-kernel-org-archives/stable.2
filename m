Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989F3B9D95
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222586; cv=none; b=ScUkl6n5xppeCMTnUQqtfke4owiKWjbBwnVT9lsvW2uzehbYGcUdqTl2dCiRQo0SDCYD3+7afCXyAQCqVxEVO/PR2Dhmgl+Olog/BEpE7F4VR9vHPt7oeSwbj99Go3l8XsyRFQjkJeJ5vwlWXBLUiHWVuCIRGYnBupzMBDn7VyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222586; c=relaxed/simple;
	bh=rduBG+K1k7K8fLrJUhyRdLcO03e/RmPtWvKLFtXemUU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rqg2NxN7WeafVgknlbAKMMUlCCsR1mjoTLhVQTOwF+yQfz5Mpg8WBaZzKLgoLA0P38RHOXHYXvkZlKMcOve3/j9YkRPOZ0KPyT7eBGm6hrOEx/2S9BNUDNEdRFRu5hE/UKwcRhDJvXTBFULvx24i3lGk1jQsKe13E0HSp23C0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2e0wKbsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2e0wKbsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D0D1F000E9;
	Thu, 20 Aug 2026 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222582;
	bh=CuqcmRTAsrhebqexibq1y14m1MZJtACDZ1e5YS6YTTs=;
	h=Subject:To:Cc:From:Date;
	b=2e0wKbsfeKvNrDHnCJfZG25NMoKSyXyFioV+5W4l+DQ90XYMz2aCOC2Nsz7t5fY51
	 LuiBt6MWdZBcVjB6AIwIh1vGcUb7uYh+bI0nlW05Y0aQWyzqdYbX32sDQQScUaD3b3
	 90mj7ODysbWhoO9mEcCH71Ph25+c/VHHQfx3GpLg=
Subject: FAILED: patch "[PATCH] mptcp: pm: fix memory leak from alloc-during-teardown race" failed to apply to 6.6-stable tree
To: shardul.b@mpiricsoftware.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:42:47 +0200
Message-ID: <2026082047-stumbling-handrail-8338@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x efc33b5102ff859bacd390a5f30112d8e0c084c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082047-stumbling-handrail-8338@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From efc33b5102ff859bacd390a5f30112d8e0c084c0 Mon Sep 17 00:00:00 2001
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Mon, 3 Aug 2026 18:16:38 +0200
Subject: [PATCH] mptcp: pm: fix memory leak from alloc-during-teardown race

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

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c71dcf887683..64a1236aabee 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -443,6 +443,9 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
+		return false;
+
 	add_entry = mptcp_pm_announced_lookup(msk, addr);
 	if (add_entry) {
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
@@ -1145,10 +1148,16 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
+	spin_unlock_bh(&msk->pm.lock);
+
 	mptcp_pm_free_announced_list(msk);
 
-	if (mptcp_pm_is_userspace(msk))
-		mptcp_userspace_pm_free_local_addr_list(msk);
+	/* Free the userspace local address list unconditionally: the socket
+	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
+	 */
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 945aa5afc2dd..2203cc2d2748 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -54,6 +54,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING)) {
+		ret = -EINVAL;
+		goto append_err;
+	}
 	mptcp_for_each_userspace_pm_addr(msk, e) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c13680d18994..1b80f2d6ec5a 100644
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

