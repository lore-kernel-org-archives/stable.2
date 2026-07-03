Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468F3D9520
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088794; cv=none; b=Dyw85F/inZvHgihXNc+CM1QUKfRo/HONAZhvotq+eS4dCl18HxuHNJ1qsX8GgjV7oFuBdBnsjYKP4antD7cZWXuVWPrXKTM3oeXtoKx4rH7J72pSCHfpOcvpNBB1AdeG+uDAvX5XiAsc36eImNnVP/mtyRqDzV015lKcfV/y36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088794; c=relaxed/simple;
	bh=AcVZj7rniMeBJQ84esGsL/BFSwG93hF8LIv16UONRnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz7fr0JJ2QSW8/XPO9UiVy4FUZowzeatFizWetk2b0qNU6v+lu/VxtmIawwkRGwKwiCccC6Vh4jG8fyqlvk2xnm7D9rFhdWwbjEskkfpz2n/ETfTujCAQf2dJC7F+01CfxIVA8sKUVeoPy3nAgkwNuUMfOLhpNeCwIROiUPRJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRfDZTEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRfDZTEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA92F1F00A3A;
	Fri,  3 Jul 2026 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088793;
	bh=e2TeR/Y21zaeZPy+yRYxdB/6PCz9eJ3jB54N9kDkSjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TRfDZTEOpoBVMv0Nteyxtzf4jgJULawbybqEA2FqgIlYeHLxXxnBM/HryzdMxReD5
	 W+LmnbH4cfnCNrMdD9If0jBVkb4VPMm9aqQJTPPNQ/8wPYYtpqE/garQRZJsSQ5nTx
	 /R0Gz9DJvwSTS6xKJbQ3WhLjNbaPw5iSpdWf5yfDXamWaUKN/whOW7jyDoCwpdkZbT
	 3j7Lcs/UE5QD26e0G/t63QrpjKBLd2b6xHIMAvuVCqt769rgkyJJhJHAo2D0JLCuSX
	 hWsDvqCJT5D3Z8Jv54aY0DqD0MYruK4fRKUKzzFfUICQSot2kZrHBs+EXuf8vygovB
	 AURe0I7DcWnog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Ruipeng Qi <ruipengqi3@gmail.com>,
	Chao Yu <chaseyu@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()
Date: Fri,  3 Jul 2026 10:26:30 -0400
Message-ID: <20260703142630.55436-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703142630.55436-1-sashal@kernel.org>
References: <2026070240-portal-down-4efd@gregkh>
 <20260703142630.55436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 8b4468ec023d0d1b4669dfb867588997cc03a06b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 22a9a7c85ee9a5..c0276a30185602 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -444,6 +444,13 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
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
@@ -463,13 +470,6 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
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
-- 
2.53.0

