Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1D23D7F0
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103899; cv=none; b=hf8bVClVzfdD/fuXqzQIj+3bHU3ApXxq0BM5DA/2QLLMnYc1LhyJoegODxyNG9meqSMO8veCGX9cqhSGZLB4nzIXDeueUFvJ9ZsLrsnMygiwAueEf0OkO+tEpFvkz3f4y28fFh/kbiXxud7ZUf/C0Mjer3VYIvPiRfXgLGekY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103899; c=relaxed/simple;
	bh=+s8MepRo2Gv7FNXl4mHiQTHYvo4BbnUxFS2M7x0+4HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjOnP/LP8W5TAp+tijxR7CtoDPaQsbbDQ9KcxDICDaA+etb3dbo07lLabS7W9ziVj9kUHv8aUDtZuIQbJG8McAtVHLJmKUps7IClE9Xoi7j18oN3uARK+id2s3DqGgx/nvM2VDN5vxB3d7U8t6YcYTU+pI2mL1hSNamwdMYerQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS5+LhKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS5+LhKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CD21F000E9;
	Fri,  3 Jul 2026 18:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103898;
	bh=rse7jzlieMape6zthQBpRnVES9nh3+emITX+8Txxa20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LS5+LhKgpUUcDZl+6pybVsWai5rHOsrCCfa6raL3zEPHbCDlUSEUFQspCZV61oxoF
	 9DUWU1dtzjuGIvBeAeQWZC1F0BdmPUKhivPyikbM1dEWPG9rsxVA1ytuEiDkWhJOqL
	 vg+2qWVsOi20lU3IQ1YXp6jUSsdHR/dJhVU+IkHNNkFhdK3PrZ7IDoeBH9F9516pI/
	 P5WxdOQuBgCDoDMgvHBuLzaMpsqKUyRfMm1dA6aChaDLvu7gd2tjh4vHF2zaVOS5qW
	 M1JsY1sFQJE+pv8CsyX5rgHdPvjB2u/f3GTqg4T1IGD44KE6sFfU3+wF6XSCdUBtqH
	 g5xA7zmYWrqeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruipeng Qi <ruipengqi3@gmail.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: fix potential deadlock in f2fs_balance_fs()
Date: Fri,  3 Jul 2026 14:38:14 -0400
Message-ID: <20260703183815.261615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070242-popper-obstinate-d622@gregkh>
References: <2026070242-popper-obstinate-d622@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruipeng Qi <ruipengqi3@gmail.com>

[ Upstream commit dd3114870771562036fdcf5abe813956f36d224d ]

When the f2fs filesystem space is nearly exhausted, we encounter deadlock
issues as below:

INFO: task A:1890 blocked for more than 120 seconds.
      Tainted: G           O       6.12.41-g3fe07ddf05ab #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:A    state:D stack:0     pid:1890  tgid:1626  ppid:1153   flags:0x00000204
Call trace:
 __switch_to+0xf4/0x158
 __schedule+0x27c/0x908
 schedule+0x3c/0x118
 io_schedule+0x44/0x68
 folio_wait_bit_common+0x174/0x370
 folio_wait_bit+0x20/0x38
 folio_wait_writeback+0x54/0xc8
 truncate_inode_partial_folio+0x70/0x1e0
 truncate_inode_pages_range+0x1b0/0x450
 truncate_pagecache+0x54/0x88
 f2fs_file_write_iter+0x3e8/0xb80
 do_iter_readv_writev+0xf0/0x1e0
 vfs_writev+0x138/0x2c8
 do_writev+0x88/0x130
 __arm64_sys_writev+0x28/0x40
 invoke_syscall+0x50/0x120
 el0_svc_common.constprop.0+0xc8/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x30/0xf8
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x190/0x198

INFO: task kworker/u8:11:2680853 blocked for more than 120 seconds.
      Tainted: G           O       6.12.41-g3fe07ddf05ab #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:11   state:D stack:0     pid:2680853 tgid:2680853 ppid:2      flags:0x00000208
Workqueue: writeback wb_workfn (flush-254:0)
Call trace:
 __switch_to+0xf4/0x158
 __schedule+0x27c/0x908
 schedule+0x3c/0x118
 io_schedule+0x44/0x68
 folio_wait_bit_common+0x174/0x370
 __filemap_get_folio+0x214/0x348
 pagecache_get_page+0x20/0x70
 f2fs_get_read_data_page+0x150/0x3e8
 f2fs_get_lock_data_page+0x2c/0x160
 move_data_page+0x50/0x478
 do_garbage_collect+0xd38/0x1528
 f2fs_gc+0x240/0x7e0
 f2fs_balance_fs+0x1a0/0x208
 f2fs_write_single_data_page+0x6e4/0x730
 f2fs_write_cache_pages+0x378/0x9b0
 f2fs_write_data_pages+0x2e4/0x388
 do_writepages+0x8c/0x2c8
 __writeback_single_inode+0x4c/0x498
 writeback_sb_inodes+0x234/0x4a8
 __writeback_inodes_wb+0x58/0x118
 wb_writeback+0x2f8/0x3c0
 wb_workfn+0x2c4/0x508
 process_one_work+0x180/0x408
 worker_thread+0x258/0x368
 kthread+0x118/0x128
 ret_from_fork+0x10/0x200

INFO: task kworker/u8:8:2641297 blocked for more than 120 seconds.
      Tainted: G           O       6.12.41-g3fe07ddf05ab #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:8    state:D stack:0     pid:2641297 tgid:2641297 ppid:2      flags:0x00000208
Workqueue: writeback wb_workfn (flush-254:0)
Call trace:
 __switch_to+0xf4/0x158
 __schedule+0x27c/0x908
 rt_mutex_schedule+0x30/0x60
 __rt_mutex_slowlock_locked.constprop.0+0x460/0x8a8
 rwbase_write_lock+0x24c/0x378
 down_write+0x1c/0x30
 f2fs_balance_fs+0x184/0x208
 f2fs_write_inode+0xf4/0x328
 __writeback_single_inode+0x370/0x498
 writeback_sb_inodes+0x234/0x4a8
 __writeback_inodes_wb+0x58/0x118
 wb_writeback+0x2f8/0x3c0
 wb_workfn+0x2c4/0x508
 process_one_work+0x180/0x408
 worker_thread+0x258/0x368
 kthread+0x118/0x128
 ret_from_fork+0x10/0x20

INFO: task B:1902 blocked for more than 120 seconds.
      Tainted: G           O       6.12.41-g3fe07ddf05ab #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:B     state:D stack:0     pid:1902  tgid:1626  ppid:1153   flags:0x0000020c
Call trace:
 __switch_to+0xf4/0x158
 __schedule+0x27c/0x908
 rt_mutex_schedule+0x30/0x60
 __rt_mutex_slowlock_locked.constprop.0+0x460/0x8a8
 rwbase_write_lock+0x24c/0x378
 down_write+0x1c/0x30
 f2fs_balance_fs+0x184/0x208
 f2fs_map_blocks+0x94c/0x1110
 f2fs_file_write_iter+0x228/0xb80
 do_iter_readv_writev+0xf0/0x1e0
 vfs_writev+0x138/0x2c8
 do_writev+0x88/0x130
 __arm64_sys_writev+0x28/0x40
 invoke_syscall+0x50/0x120
 el0_svc_common.constprop.0+0xc8/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x30/0xf8
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x190/0x198

INFO: task sync:2769849 blocked for more than 120 seconds.
      Tainted: G           O       6.12.41-g3fe07ddf05ab #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:sync            state:D stack:0     pid:2769849 tgid:2769849 ppid:736    flags:0x0000020c
Call trace:
 __switch_to+0xf4/0x158
 __schedule+0x27c/0x908
 schedule+0x3c/0x118
 wb_wait_for_completion+0xb0/0xe8
 sync_inodes_sb+0xc8/0x2b0
 sync_inodes_one_sb+0x24/0x38
 iterate_supers+0xa8/0x138
 ksys_sync+0x54/0xc8
 __arm64_sys_sync+0x18/0x30
 invoke_syscall+0x50/0x120
 el0_svc_common.constprop.0+0xc8/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x30/0xf8
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x190/0x198

The root cause is a potential deadlock between the following tasks:

kworker/u8:11				Thread A
- f2fs_write_single_data_page
 - f2fs_do_write_data_page
  - folio_start_writeback(X)
  - f2fs_outplace_write_data
   - bio_add_folio(X)
 - folio_unlock(X)
					- truncate_inode_pages_range
					 - __filemap_get_folio(X, FGP_LOCK)
					 - truncate_inode_partial_folio(X)
					  - folio_wait_writeback(X)
 - f2fs_balance_fs
  - f2fs_gc
   - do_garbage_collect
    - move_data_page
     - f2fs_get_lock_data_page
      - __filemap_get_folio(X, FGP_LOCK)

Both threads try to access folio X. Thread A holds the lock but waits
for writeback, while kworker waits for the lock. This causes a deadlock.

Other threads also enter D state, waiting for locks such as gc_lock and
writepages.

OPU/IPU DATA folio are all affected by this issue. To avoid such
potential deadlocks, always commit these cached folios before
triggering f2fs_gc() in f2fs_balance_fs().

Suggested-by: Chao Yu <chao@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Ruipeng Qi <ruipengqi3@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8b4468ec023d ("f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c    | 29 +++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c |  8 ++++++++
 3 files changed, 38 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7643c1d7dbb273..85800d27bb11ce 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -887,6 +887,35 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 	}
 }
 
+void f2fs_submit_all_merged_ipu_writes(struct f2fs_sb_info *sbi)
+{
+	struct bio_entry *be, *tmp;
+	struct f2fs_bio_info *io;
+	enum temp_type temp;
+
+	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
+		LIST_HEAD(list);
+
+		io = sbi->write_io[DATA] + temp;
+
+		/* A lockless list_empty() check is safe here: any bios from
+		 * other kworkers that we miss will be submitted by those
+		 * kworkers accordingly.
+		 */
+		if (list_empty(&io->bio_list))
+			continue;
+
+		f2fs_down_write(&io->bio_list_lock);
+		list_splice_init(&io->bio_list, &list);
+		f2fs_up_write(&io->bio_list_lock);
+
+		list_for_each_entry_safe(be, tmp, &list, list) {
+			f2fs_submit_write_bio(sbi, be->bio, DATA);
+			del_bio_entry(be);
+		}
+	}
+}
+
 int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 {
 	struct bio *bio = *fio->bio;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 50847fd7e55045..63d3450f895eeb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3866,6 +3866,7 @@ void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				nid_t ino, enum page_type type);
 void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 					struct bio **bio, struct page *page);
+void f2fs_submit_all_merged_ipu_writes(struct f2fs_sb_info *sbi);
 void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
 int f2fs_merge_page_bio(struct f2fs_io_info *fio);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8791aba087cd52..334eb4d81bd671 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -450,6 +450,14 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 			.should_migrate_blocks = false,
 			.err_gc_skipped = false,
 			.nr_free_secs = 1 };
+
+		/*
+		 * Submit all cached OPU/IPU DATA bios before triggering
+		 * foreground GC to avoid potential deadlocks.
+		 */
+		f2fs_submit_merged_write(sbi, DATA);
+		f2fs_submit_all_merged_ipu_writes(sbi);
+
 		f2fs_down_write(&sbi->gc_lock);
 		stat_inc_gc_call_count(sbi, FOREGROUND);
 		f2fs_gc(sbi, &gc_control);
-- 
2.53.0

