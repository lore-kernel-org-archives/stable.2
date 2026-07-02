Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC43909A3
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997901; cv=none; b=BZ2A1sGDluQjigBpewI9+ZpKaRvC5K0/sqjqq5cfjcdq7Fmkcsf2yZ4JqhuU9DKOqcMJ+Lmjfsdrn3Y4Z98Av+W1yGQ4CLvmdZokgsMFBumKlWOWPKVguM3DjD85+re9iMNaqPVsNIWsX3pNM2IxkSvAm2rxjd4Scr1xiXlnrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997901; c=relaxed/simple;
	bh=wnlAWCgX6rmJIntj1t+5CSszNfGZUi52TL2Lye7cXG0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BuOabWkYrQhrj6esL34VBEFv/GTyPW384QXRhUZBrEB6cR7Cc1AlynYoeYDa1K9X7Soaj+XvbGn7xBs2KzMAH7LVe84ljDW80UANHjrRV5m5aNMH7nXLKRXK2XsSsQsBBDY/C16l9qJ+L0zuh0lOJELVSDWBEca3vQFKjMJNQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t5GNHmVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t5GNHmVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F4F1F000E9;
	Thu,  2 Jul 2026 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997898;
	bh=lhXF+OV26l4lMbDhdsR58WC5ScbtPZ5zl/qV0NLN7vw=;
	h=Subject:To:Cc:From:Date;
	b=t5GNHmVmonouswaq2y1IsS+slGVVH72TSYQ5xl9Nr/SAVZb1Z9pRETKVFCNhJYHAb
	 9FG4kO9xywEboYsEcsl8z09R5tCVa4uICWyAEKnzGtOEdj85aQMBDjxZukV5Wi6pBg
	 jhOQvAKCGiX6KNQ1HWeWKoPCR5kpPdzpLiJIEsQY=
Subject: FAILED: patch "[PATCH] f2fs: fix potential deadlock in gc_merge path of" failed to apply to 6.12-stable tree
To: chao@kernel.org,chaseyu@google.com,dhavale@google.com,jaegeuk@kernel.org,ruipengqi3@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:11:41 +0200
Message-ID: <2026070241-ludicrous-affix-dd78@gregkh>
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
git cherry-pick -x 8b4468ec023d0d1b4669dfb867588997cc03a06b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070241-ludicrous-affix-dd78@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b4468ec023d0d1b4669dfb867588997cc03a06b Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 19 May 2026 01:14:38 +0000
Subject: [PATCH] f2fs: fix potential deadlock in gc_merge path of
 f2fs_balance_fs()

When we mount device w/ gc_merge mount option, we may suffer below
potential deadlock:

Kworker					GC trehad			Truncator
- f2fs_write_cache_pages
 - f2fs_write_single_data_page
  - f2fs_do_write_data_page
   - folio_start_writeback  --- set writeback flag on folio
   - f2fs_outplace_write_data
   : cached folio in internal bio cache
  - f2fs_balance_fs
   - wake_up(gc_thread)
   : wake up gc thread to run foreground GC
   - finish_wait(fggc_wq)
   : wait on the waitqueue --- wait on GC thread to finish the work
									- truncate_inode_pages_range
									 - __filemap_get_folio(, FGP_LOCK)  --- lock folio
									 - truncate_inode_partial_folio
									  - folio_wait_writeback            --- wait on writeback being cleared
					- do_garbage_collect
					 - move_data_page
					  - f2fs_get_lock_data_folio
					   - lock on folio  --- blocked on folio's lock

In order to avoid such deadlock, let's call below functions to commit
cached bios in GC_MERGE path of f2fs_balance_fs() as the same as we did
in NOGC_MERGE path.
- f2fs_submit_merged_write(sbi, DATA);
- f2fs_submit_all_merged_ipu_writes(sbi);

Cc: stable@kernel.org
Fixes: 351df4b20115 ("f2fs: add segment operations")
Cc: Ruipeng Qi <ruipengqi3@gmail.com>
Reported: Sandeep Dhavale <dhavale@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chao Yu <chaseyu@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7c8ac62b1b0d..1ef4edb77078 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -445,6 +445,13 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	if (has_enough_free_secs(sbi, 0, 0))
 		return;
 
+	/*
+	 * Submit all cached OPU/IPU DATA bios before triggering
+	 * foreground GC to avoid potential deadlocks.
+	 */
+	f2fs_submit_merged_write(sbi, DATA);
+	f2fs_submit_all_merged_ipu_writes(sbi);
+
 	if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
 				sbi->gc_thread->f2fs_gc_task) {
 		DEFINE_WAIT(wait);
@@ -464,13 +471,6 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 			.err_gc_skipped = false,
 			.nr_free_secs = 1 };
 
-		/*
-		 * Submit all cached OPU/IPU DATA bios before triggering
-		 * foreground GC to avoid potential deadlocks.
-		 */
-		f2fs_submit_merged_write(sbi, DATA);
-		f2fs_submit_all_merged_ipu_writes(sbi);
-
 		f2fs_down_write_trace(&sbi->gc_lock, &gc_control.lc);
 		stat_inc_gc_call_count(sbi, FOREGROUND);
 		f2fs_gc(sbi, &gc_control);

