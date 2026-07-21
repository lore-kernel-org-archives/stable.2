Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5B392822
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625359; cv=none; b=fgS5XneuIAIY+8914bW1GMhVIzip+JUyupiufIi+btsrMj22MZ2qAVmz7iTsFCUUTBvjRT33qKesadKjg004AZ8z3UUjBurgBA2rGktdaFytcVJSiSXL3t+nU2tVHYpW8TMqaUZ0AEmha01zIR1M6AM86tkLMDA1s2My/lshuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625359; c=relaxed/simple;
	bh=IZPIXZ802Elz7sWWH7JryZyyhflMA6pZLk9aPjfKxl8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hv+KtAeo1213yasCIYOnTdq0cgeyKpw/oOhClNdvm60dfI4wmOtpDd2nNI0EPyv30VpvVe9wqJBfhV5h9ZZ4J7vL6ePcQRXznoNibZYtCPBTNXx5yeQLPMGr7Zx5iRWmQoP0HuwoQ/jhJshdX+0pubfTqNfFoUzaWiijRjLkV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mt5hcZf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mt5hcZf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371841F000E9;
	Tue, 21 Jul 2026 09:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625357;
	bh=u8JIW2hbhH4K2PUdGZHN9wU5TrcPz0HFH3yidqnVKVY=;
	h=Subject:To:Cc:From:Date;
	b=mt5hcZf7QyIG3W4pWoD3eHzXFus9KJhlY/8qWDrUdISsjFub1tnYz5Lu1z5Pj+UHO
	 VqYZwL8ssNNHdasmGS5ZYMTk/jvDFAVpbLhjnVyCjDLErqP2Kt/nEBnkoYIZYeFX7P
	 dnElygZHKtMp/Y49zlByoYQOUurVNAonouXEUuGU=
Subject: FAILED: patch "[PATCH] fs/resctrl: Fix double-add of pseudo-locked region's RMID to" failed to apply to 6.6-stable tree
To: reinette.chatre@intel.com,bp@alien8.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:15:35 +0200
Message-ID: <2026072135-smashing-sudoku-fcfa@gregkh>
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
git cherry-pick -x b9f089723aee892efc77c349ae47a6b452b293c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072135-smashing-sudoku-fcfa@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

