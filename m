Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D430D418
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103058; cv=none; b=ifeCpFzgJH8fvIuAkhLw+X+v+keUQxc75bQPY89cLdK7p8PkJy1HXJbib9TSii0xVc2TOEBWCQ7I4TJL2JSDyONJa8bkgSDCbzJ0CKhLRGe3OmcJk8o51ni4niJ95ML3JYKV+Z4DyxUtDVpUQvI136OUSM+GUCrI9zVTfAFT3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103058; c=relaxed/simple;
	bh=Js76AjTDO08S9OZZqG1prgFeL51UvoQnLIuEg/6SM/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0sXeac9SeZVcXchXGxUz745tcOIWMyHoDsZT2p9ef4CUTlIJwNFThYuNgruBSazgdMPgpIn4cFHWaWmNuF36bG3WG0ckJ6Y1o3NeQT91eHyDVPTD6Kat1tRu4Km13XQiiD7MUJuPaWoaRYo2VOrRg6JXd36iihWSuwihKiZXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI8u284i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI8u284i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466C21F00A3E;
	Fri,  3 Jul 2026 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103057;
	bh=jEoQ5UkI54O8rGBxUF8tDSYWQ4FnSb3AFSgEP7Gids4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UI8u284iBq9WdgLxjp+zGHoat3SNg4m5xHS/yGh/A3aqF96bnYEiDeEmTta462TMb
	 eTcpK/rWYwuqIZB5IkpScNW9jOXocSsrWF9Ku4DK6K6AoP83M4t15fojqxKkWJA2f+
	 dI78uKdFf0zBJ2fm9yPFk2mKIbE3ImES/RWt4JDTj3IFEluL9QRVE3Y/ADYylC5v0P
	 slc6Kpk8bGzQgoMNGWGa+m8HfP37Ea8ejjErmyWqmEi5Evw1D0FdnVrCuUcIGxT7EM
	 5ZfE43NXhgAjETjb6wzU7cP92euoWc0edfvlMMm9n6V4nKdfSXlQC3yAj4BPC/emxG
	 OR+2hj5rjS6qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Ruipeng Qi <ruipengqi3@gmail.com>,
	Chao Yu <chaseyu@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()
Date: Fri,  3 Jul 2026 14:24:13 -0400
Message-ID: <20260703182413.254727-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703182413.254727-1-sashal@kernel.org>
References: <2026070241-ludicrous-affix-dd78@gregkh>
 <20260703182413.254727-1-sashal@kernel.org>
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
index d074fda20aedc6..4e47826b570a56 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -434,6 +434,13 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
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
@@ -452,13 +459,6 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 			.err_gc_skipped = false,
 			.nr_free_secs = 1 };
 
-		/*
-		 * Submit all cached OPU/IPU DATA bios before triggering
-		 * foreground GC to avoid potential deadlocks.
-		 */
-		f2fs_submit_merged_write(sbi, DATA);
-		f2fs_submit_all_merged_ipu_writes(sbi);
-
 		f2fs_down_write(&sbi->gc_lock);
 		stat_inc_gc_call_count(sbi, FOREGROUND);
 		f2fs_gc(sbi, &gc_control);
-- 
2.53.0

