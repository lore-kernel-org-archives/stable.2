Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF484B5408
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445460; cv=none; b=Zs4qImNpiyW+9aDUd6Mgj1ELoH5sY9i4SBqsiTMg1ejWjbg0rruds0GBcgQzxbjXHyrdWEDxcQHuZPlK/BmKd/opdJlGOM2q+Adl0/3yJBS2Guyscal1n34d9RmCppANs5eEssgjo7K2vT5JCD4PNz2pN3aS9Vm0XwkkcaDThWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445460; c=relaxed/simple;
	bh=ylPgC11JOWgJaqTbKBtw5HTaUllHcnQW8SAeOQgSAgk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=acbVbklUEr7Cs91gIUvWbxC/NcgfcCcfVCDdR34XyYX0huVdZeu2Dsh5Wt0lhPUajRv4ekcihxf3FJIM3HekAquQQqPDLIw5fLHAM43REOYmf09DOezvqVzdUmgXYmcbG2f9aYzkraEjSPadiaKk8FyHhQboW6ZgiPs9SzINrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sbWA/0sb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbWA/0sb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568CB1F000E9;
	Thu,  3 Sep 2026 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445455;
	bh=IjfFV7uPSnv+pl980B1/o0eLk63+shYtjDXSg/pNpcQ=;
	h=Subject:To:Cc:From:Date;
	b=sbWA/0sbrn8Alxzen90rtCe4bQTxv7SBvLTcMmhAF2YXXxSQqQm8LpKQXLe1uwMIw
	 B1axFReVNvMbt6OFmhYkss8/gBVhVd7Eu69+Wvnf+4WQr6hoxEVCUF8SiT6HGkgW/m
	 BvMPnTpdL4oXHBnErPUxUjcUM5hC0Kzjrkfu5NBM=
Subject: FAILED: patch "[PATCH] jbd2: bound shrinker scans by examined checkpoint buffers" failed to apply to 5.15-stable tree
To: max.kellermann@ionos.com,jack@suse.cz,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:59:25 +0200
Message-ID: <2026090325-massive-fabulous-a27d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 15cb16496446b94e67f7abcb049b8e2c75cd3d02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090325-massive-fabulous-a27d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15cb16496446b94e67f7abcb049b8e2c75cd3d02 Mon Sep 17 00:00:00 2001
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 13 Jul 2026 12:22:29 +0200
Subject: [PATCH] jbd2: bound shrinker scans by examined checkpoint buffers

The jbd2 shrinker currently accounts only checkpoint buffers that it
successfully releases against nr_to_scan.  Busy buffers therefore do not
consume the scan budget.

If a checkpoint transaction contains mostly busy buffers, the shrinker
can scan its entire checkpoint list while holding journal->j_list_lock.
Large checkpoint lists can result in excessive lock hold times and leave
other CPUs spinning on j_list_lock, causing soft lockups or RCU stalls.

Pass nr_to_scan into journal_shrink_one_cp_list() and decrement it for
every buffer examined, including busy buffers.  Pass NULL from checkpoint
cleanup paths so their existing full-list behavior is preserved.

This restores the scan-budget semantics that existed before
journal_shrink_one_cp_list() was changed to always scan a complete
checkpoint list.

Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260713102229.1598812-3-max.kellermann@ionos.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 5266017565ac..513273712010 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -358,15 +358,16 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 /*
  * journal_shrink_one_cp_list
  *
- * Find all the written-back checkpoint buffers in the given list
- * and try to release them. If the whole transaction is released, set
- * the 'released' parameter. Return the number of released checkpointed
- * buffers.
+ * Find written-back checkpoint buffers in the given list and try to release
+ * them. If 'nr_to_scan' is set, scan at most that many buffers. If the whole
+ * transaction is released, set the 'released' parameter. Return the number of
+ * released checkpointed buffers.
  *
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 						enum jbd2_shrink_type type,
+						unsigned long *nr_to_scan,
 						bool *released)
 {
 	struct journal_head *last_jh;
@@ -375,13 +376,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 	int ret;
 
 	*released = false;
-	if (!jh)
+	if (!jh || (nr_to_scan && !*nr_to_scan))
 		return 0;
 
 	last_jh = jh->b_cpprev;
 	do {
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
+		if (nr_to_scan)
+			(*nr_to_scan)--;
 
 		if (type == JBD2_SHRINK_DESTROY) {
 			ret = __jbd2_journal_remove_checkpoint(jh);
@@ -403,7 +406,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 next:
 		if (need_resched())
 			break;
-	} while (jh != last_jh);
+	} while (jh != last_jh && (!nr_to_scan || *nr_to_scan));
 
 	return nr_freed;
 }
@@ -425,7 +428,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
-	unsigned long freed;
 	bool first_set = false;
 
 again:
@@ -458,10 +460,9 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		next_transaction = transaction->t_cpnext;
 		tid = transaction->t_tid;
 
-		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						   JBD2_SHRINK_BUSY_SKIP, &released);
-		nr_freed += freed;
-		(*nr_to_scan) -= min(*nr_to_scan, freed);
+		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+						       JBD2_SHRINK_BUSY_SKIP,
+						       nr_to_scan, &released);
 		if (*nr_to_scan == 0)
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
@@ -517,7 +518,7 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-					   type, &released);
+					   type, NULL, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if

