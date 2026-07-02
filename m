Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140C42B33F
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997904; cv=none; b=RO0FFYpQ6+FJNaAv63iPah8pSryCmx5UefYaRKVbkTE1vnQh945a6t4bwTupnGd6WJ3wkk2P7Zwf492q16CNv2nLmxX6fsLaqdA8O/Fsi81bvp+e7Azl5/oSHj0tWzAty4m0ucULsl244alaOWn+3rIbnzVw+IWFsLzoWGX2i4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997904; c=relaxed/simple;
	bh=Maly9oO/o6oCHbOz8DUay1O9hlJrOkWimntt3sbZWto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gEOluBeoTwuTO15qZ7oXZdDHkgCctYUbkRzU6A2PWxdmrzyT1rP3BSyvjS38e81yuZ6+rh7YPmLk7GokmWeWO7W33TJ6B98wcXtLnpWAAMD3ryLFZq0zIGrf3BNliYkIDHxGjQM+PfXJry2gSioYYkBP18+BMR254RPblWDcVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IHEBoWpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IHEBoWpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC831F00A3A;
	Thu,  2 Jul 2026 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997901;
	bh=PvCrRE9L1NPQ7A9ZxS785HTxhj/ZM3Skc3WcdfHSaMM=;
	h=Subject:To:Cc:From:Date;
	b=IHEBoWpBY+uS5JBfZUPqjvlKAihr0OqeO45875wh8LxmEuscbRWLXVh6mDt44/E48
	 Q0V9vaoLd6qOk9K7bV90G3VRhSEqBBaKp7ZrS0L43XJl7861wnz0ApPUJEcEQU1WY8
	 i1ncEr/Hv6mFnm6IDmaFp9LrzYKZSibRj3/1TVRI=
Subject: FAILED: patch "[PATCH] f2fs: fix potential deadlock in gc_merge path of" failed to apply to 6.18-stable tree
To: chao@kernel.org,chaseyu@google.com,dhavale@google.com,jaegeuk@kernel.org,ruipengqi3@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:11:41 +0200
Message-ID: <2026070241-banker-throwback-07c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8b4468ec023d0d1b4669dfb867588997cc03a06b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070241-banker-throwback-07c2@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

