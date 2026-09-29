Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D037D101
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664307; cv=none; b=oOL5wVzgOUdvrmgKkmnz87vsXMD9jymVAroGcQsQYJED9a2l7rbaChU/UAmY+LpJvj/e0KNAypIRjAL7xrGN8UMILNXqKxacuAby0qCwze2+m5H68A74pYeqvskhq/j2GQARPbtqCOR0fMjLUe4i1/AixAUGe/o0kGu7SO1t6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664307; c=relaxed/simple;
	bh=nsLReEc8bkocP/pCi8bh6U8EA3R9DR4DRG10EmCQEHU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tfzv0z+FVoQetHkP3ib2YwxiNUvizBYssM/vObvQSvU9WzD+kyRVGZpqQ6mHNFwZfu5avsPXtbPXp6YfwR6DdPtl2G8qVpzBcif1dRQZh1QW530dCVr9bvYPGz00z/1IGshQO8Cj6cq1e/c7MZDOz900RvTRp4XSR6aHd6E9/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bPr7mBZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bPr7mBZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FE01F000FF;
	Tue, 29 Sep 2026 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664306;
	bh=bsFssnSB+BZkftqyITunBFl7VSRwsC98dauAkHMMzkM=;
	h=Subject:To:Cc:From:Date;
	b=bPr7mBZPmHkptAu4IGzoOkKZj7/GwtOeVv7LoCovf42tulkMGCfngijtMLc8dPhCE
	 +8AHtvmbONCODHuv/12XF/IClsR5y6LuvW1fSfa7FgKFdqBPxLol2YyrbG6IsT8iBw
	 iSLQvZ0EVwyNPc4on6F06AtcO0An9JQprF/c7ZWs=
Subject: FAILED: patch "[PATCH] writeback: bound cleanup_offline_cgwb() rescans by rotating" failed to apply to 5.10-stable tree
To: perf.patrick.lu@gmail.com,brauner@kernel.org,jack@suse.cz,roman.gushchin@linux.dev,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:44:55 +0200
Message-ID: <2026092955-municipal-nebula-4546@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f6988c90671e83db79df1b7b9d6fdb0e5947fd84
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092955-municipal-nebula-4546@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6988c90671e83db79df1b7b9d6fdb0e5947fd84 Mon Sep 17 00:00:00 2001
From: "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Date: Fri, 11 Sep 2026 18:49:49 +0000
Subject: [PATCH] writeback: bound cleanup_offline_cgwb() rescans by rotating
 scanned inodes

cleanup_offline_cgwb() prepares at most WB_MAX_INODES_PER_ISW inodes
per call and is called again until the dying wb is drained, but every
call walks wb->b_attached and then wb->b_dirty_time from the same end.
Inodes already prepared (they stay on the list with I_WB_SWITCH set
until the switch worker runs) and inodes that cannot be switched
(I_FREEING, I_WILL_FREE, !SB_ACTIVE, DAX, already on the target wb)
stay where they are, so each pass rescans a growing run of them under
wb->list_lock and a full drain is quadratic in the number of inodes on
the list. With ~17M inodes attached to one dying cgwb we saw this end
in soft lockups, with CPUs reported stuck for 21-48s.

Walk both lists from the oldest end and move every scanned inode to
the newest end, so the next pass starts where the previous one stopped
and the drain becomes linear. b_attached is unordered, so nobody sees
the reorder there. b_dirty_time is ordered by dirtied_when, but the
oldest unscanned inode stays at the end move_expired_inodes() picks
from, sync takes the whole list regardless of order, and prepared
inodes leave the list as soon as the switch work runs and get a new
dirtied_time_when on the new wb anyway, so the only inodes left out of
order are the ones that can never switch (DAX), and only on the dying
wb.

Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
Cc: stable@vger.kernel.org
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>
Link: https://patch.msgid.link/20260911-wb-cgwb-rotate-v2-1-a9ab253a1295@gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e744f9f9d43f..ea3eb40bf828 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -727,19 +727,34 @@ static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
 				   struct inode_switch_wbs_context *isw,
 				   struct list_head *list, int *nr)
 {
-	struct inode *inode;
+	struct inode *inode, *tmp;
+	LIST_HEAD(scanned);
+	bool full = false;
+
+	/*
+	 * Walk from the oldest end and move scanned inodes to the newest
+	 * end, so the next scan resumes at unscanned inodes instead of
+	 * re-walking an ever-growing run of prepared and skipped ones.
+	 * For b_dirty_time this keeps the oldest unscanned inode at the
+	 * end move_expired_inodes() picks from; b_attached is unordered.
+	 */
+	list_for_each_entry_safe_reverse(inode, tmp, list, i_io_list) {
+		list_move(&inode->i_io_list, &scanned);
 
-	list_for_each_entry(inode, list, i_io_list) {
 		if (!inode_prepare_wbs_switch(inode, new_wb))
 			continue;
 
 		isw->inodes[*nr] = inode;
 		(*nr)++;
 
-		if (*nr >= WB_MAX_INODES_PER_ISW - 1)
-			return true;
+		if (*nr >= WB_MAX_INODES_PER_ISW - 1) {
+			full = true;
+			break;
+		}
 	}
-	return false;
+	list_splice(&scanned, list);
+
+	return full;
 }
 
 /**

