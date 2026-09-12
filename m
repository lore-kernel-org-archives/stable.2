Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888038D3F0
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789179745; cv=none; b=myvuyYV+DJm0K5ZeNlBf2hO6w8o/EjwrJU5voUsandqoWICCr2gpeznDx9zFuRlLtROhTZ7X+YkIiteobNbtWRUbmpfDZtjZF7hR9WFIK3EHlvvGa7ZDVfK2ubQlMS15TCk0g8BkOkZ+vwF7uRagBMirng0q2AMyEBQhNNMRHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789179745; c=relaxed/simple;
	bh=uA6ayX1WTJUhqgmhkmk2wTCgOA5Ypjq99ksbJBRpS/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXodCRhjdn2k47kBhC0SV8YY+xCy7E8/JwrqnfW6QygnYGepepx4GYKpYfz0XcXMjUewNPLSreooMnuAdeQt7XDTiTH0GhIVkx+3mR0tvoGX9yj15piDJ/hgK8qEFF+9N7ln3Z0+V/aCn45tfB/mMItL7lP5Rgt3+5u3JWURR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQxZqUfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQxZqUfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDCC1F000FF;
	Sat, 12 Sep 2026 02:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789179743;
	bh=xyhJivSN6JNebxNVqFxVup6FxoG65+eNvrdDDwfO8pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQxZqUfhfmDV+7RSrVMc+Fb4lnD8pn/xuPNrvRDuGiIpK9Dc7AdhCl07A8bLIupIk
	 pHS1Cxewgvv0Z8QcbzxI2Bh+H9lSdxcnZt5gnP4+iOG7h87bWhbYIRHimsbW0Bm6fA
	 jdiw1dvij/J7ZhqrexKLpPOcMGsQP7xoQgJzgCvdQuWJRePgf+qRYPBd/ztP3UiJbC
	 4FV6/u3Bof36bzkP0Y4AQFONVTrbZTfnfgxO7vxUL/DpQeTLVLpbpoRWAgYx0sqVuC
	 3bJhMMA7TbTDPHLLVTxSOEYSLCi8Iu8N6O9+UDg2I3nyQ0cajOAXk7Gne9r/W/t88M
	 hXorSUTmtF2Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
Date: Fri, 11 Sep 2026 22:22:20 -0400
Message-ID: <20260912022221.1969770-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090944-feline-renewable-9808@gregkh>
References: <2026090944-feline-renewable-9808@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 5d49025a4e596c4c9ac0c519ef9f9a2c91396856 ]

In f2fs_allocate_pinning_section(), we will hold gc_lock before calling
f2fs_gc_range() to migrate section in conventional zone, we may suffer
worse case because we may need to traverse and migrate multiple sections
if we failed to move blocks in section due to lot of reasons: ENOMEM,
fail to migrate block of pinfile, racing on i_gc_rwsem.

To avoid hold gc_lock for long time to block checkpoint, let's hold
the lock and only try to migrate one section.

Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Backport notes for Linux 7.2:
The stable tree lacks eae3faf210bdc ("f2fs: support dynamic
reserve/release for device aliasing"). Drop the file.c hunk for the absent
f2fs_ioc_reserve_dev_alias() caller and omit the unrelated
f2fs_reset_gc_victim_resource() declaration from the header resolution.
Keep the per-section gc_lock handling, updated f2fs_gc_range() prototype,
and both callers present in this tree. No functions are added.

This preserves the context needed for 2b8704b6a8b2 ("f2fs: fix to reset
all pinned status during fggc"); its patch applies without conflicts.

[ sashal: Reduced backport -- upstream 5d49025a4e596 touches 4 file(s), this
  backport carries 3. Not backported here:
  fs/f2fs/file.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 2b8704b6a8b2 ("f2fs: fix to reset all pinned status during fggc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      | 34 +++++++++++++++++++++++++---------
 fs/f2fs/segment.c |  4 +---
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8011bbdf2c688..93ffd1aa6a238 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4255,7 +4255,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections);
+		bool dry_run, unsigned int dry_run_sections, bool lock);
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 1eda818619747..e5bae53278fbd 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2150,8 +2150,9 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections)
+		bool dry_run, unsigned int dry_run_sections, bool lock)
 {
+	struct f2fs_lock_context lc;
 	unsigned int segno;
 	unsigned int gc_secs = dry_run_sections;
 
@@ -2164,28 +2165,43 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
+		int err = 0;
+
+		if (lock)
+			f2fs_down_write_trace(&sbi->gc_lock, &lc);
 
 		/*
 		 * avoid migrating empty section, as it can be allocated by
 		 * log in parallel.
 		 */
 		if (!get_valid_blocks(sbi, segno, true))
-			continue;
+			goto next;
 
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno)))
-			continue;
+			goto next;
 
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
-		if (!dry_run && get_valid_blocks(sbi, segno, true))
-			return -EAGAIN;
+		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
+			err = -EAGAIN;
+			goto next;
+		}
 		if (dry_run && dry_run_sections &&
-		    !get_valid_blocks(sbi, segno, true) && --gc_secs == 0)
-			break;
+			!get_valid_blocks(sbi, segno, true)) {
+			--gc_secs;
+			goto next;
+		}
 
 		if (fatal_signal_pending(current))
-			return -ERESTARTSYS;
+			err = -ERESTARTSYS;
+next:
+		if (lock)
+			f2fs_up_write_trace(&sbi->gc_lock, &lc);
+		if (err)
+			return err;
+		if (dry_run && dry_run_sections && !gc_secs)
+			return 0;
 	}
 
 	return 0;
@@ -2223,7 +2239,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	}
 
 	/* do GC to move out valid blocks in the range */
-	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
+	err = f2fs_gc_range(sbi, start, end, dry_run, 0, false);
 	if (err || dry_run)
 		goto out;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 091bfb170d615..b8e360b055baf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3357,10 +3357,8 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 	f2fs_unlock_op(sbi, &lc);
 
 	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
-		f2fs_down_write_trace(&sbi->gc_lock, &lc);
 		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
-				true, ZONED_PIN_SEC_REQUIRED_COUNT);
-		f2fs_up_write_trace(&sbi->gc_lock, &lc);
+				true, ZONED_PIN_SEC_REQUIRED_COUNT, true);
 		if (err)
 			return err;
 		err = f2fs_sync_fs(sbi->sb, 1);
-- 
2.53.0

