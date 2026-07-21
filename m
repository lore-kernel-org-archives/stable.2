Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66B3B7778
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625345; cv=none; b=apojfX7YlBlKjtX0wIXGEJ4SLAs9F1tT+kG8gk/WSgOZCw10VR/BrkcPlr1rdqCDmCJfg3lqtwSoE3p/12SX5emWab0V+i33LxWdXzENvvqVXnx3hoTHQkcDJ30Rg1a3GBmPZDeiYXx9DpeblEIs2G017WO7trQCWsXptEuj3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625345; c=relaxed/simple;
	bh=s1HwS9BJiMnxOFtLRerFzqSJ28uKkcMkXa8VaBs/ANQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hkOGf3PPsCv+8PXOQD1ZG5I4QK9oUzySOQwSFRDlFVH18mKXzclqQYjb1Ht/ifOymJ7swZFxPa6gsp64+iT4VvKGbNg1s14bsux/dxL7FZ/SJUvj3O3zgSF79zqOTw93Is4JDrmkaGLCyIX2RH/Fp77EfKm0hgZOdFgQ0agaBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFHTgR9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFHTgR9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868FE1F000E9;
	Tue, 21 Jul 2026 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625344;
	bh=TqDsb37dc+eQVXnjSSHzgzXkKohxcllVdBdknirmDsc=;
	h=Subject:To:Cc:From:Date;
	b=bFHTgR9RHze6vu6uFdmorrz8fI+uxdZ0J1XGB43lY0PVCeXpfZLpyfe/FQMTWIFW0
	 z0dk3HPTCdlykWNldnxfNjnVjH31SF83yBbxgextZbgkuXGu0X8orOf4e0YM3DxfV+
	 aj4TxnBmedSukHAPbbovN4ac7AuiWv6AW754UXg0=
Subject: FAILED: patch "[PATCH] fs/resctrl: Fix double-add of pseudo-locked region's RMID to" failed to apply to 6.12-stable tree
To: reinette.chatre@intel.com,bp@alien8.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:15:20 +0200
Message-ID: <2026072120-luster-garden-e534@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b9f089723aee892efc77c349ae47a6b452b293c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072120-luster-garden-e534@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9f089723aee892efc77c349ae47a6b452b293c4 Mon Sep 17 00:00:00 2001
From: Reinette Chatre <reinette.chatre@intel.com>
Date: Mon, 6 Jul 2026 15:46:23 -0700
Subject: [PATCH] fs/resctrl: Fix double-add of pseudo-locked region's RMID to
 free list

A pseudo-locked group's RMID is freed when it is created. On unmount
rmdir_all_sub() unconditionally frees all RMID of all groups, resulting
in a double-free of the pseudo-locked group's RMID. The consequence of this
is that the original free results in the pseudo-locked group's RMID being
added to the rmid_free_lru linked list and the second free then attempts
to add the same RMID entry to the rmid_free_lru again.

Do not double-free a pseudo-locked group's RMID.

Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/551432dd7e624a862b8e58314c38aaba0afff3e9.1783377598.git.reinette.chatre@intel.com

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ce277f16ea12..cc9966ff6cdf 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3084,10 +3084,6 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -3098,7 +3094,13 @@ static void rmdir_all_sub(void)
 
 		rdtgroup_unassign_cntrs(rdtgrp);
 
-		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+		} else {
+			/* Pseudo-locked group's RMID is freed during setup. */
+			free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		}
 
 		kernfs_remove(rdtgrp->kn);
 		list_del(&rdtgrp->rdtgroup_list);

