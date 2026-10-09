Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881A4BEE38
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544917; cv=none; b=RVlm7Bbl134vwTpTtvelue49RLXSz0YrLgpJBGTEuG25skBl+d436LqgKnoammAXTcLpBjAhmhM1HOomTB4PuJO4jpCQRAfMjg54/3wcA6LexGbj4h49htoC4WoqFNAM+vSbuicpIGHE2MfT0eMw36ObIhEMo+h+F8JxFZtD7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544917; c=relaxed/simple;
	bh=xUZQT0pos1AQ9CiwDr91fj/8eGuLxciFFV46nHtdW40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm4Gx7XYAVfdrJatxKCZWjWFthh1XBdwZpyiYMgtrO9ScFoGT3r/xVtkg/nXiQPVqkohMoO0nGaZZ25LdGq81UiUIaEsEkMDPUkuA6NqNC70EdRnecHgcHxNLtivEF+Vu0gUBC+kqY0Da9BOQQBardZK/HP9YlrzV5Zu4rtM/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPl2TKjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPl2TKjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734421F00893;
	Fri,  9 Oct 2026 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544909;
	bh=wkKYxpwXQrJN7QJ00Jh4R5X/o+mpVJfA6MnR/Y4L3Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OPl2TKjSs6yso7zTmbi1JtQbu0Hunkpt+dbV7ockUB21S8Zej/LeecyJrzF2eouCV
	 kXUqXkEPW23IY8pfI7OxwFFN+TBi+C4+6irMosEF4AEslTS1rB5XGno4XQ6CK1p9fI
	 Z4beufHbhlEO5Q6/IZSmX9JaVDzWUg0bvvWigrv+Q2JrwMeAfKVvvSkx/hcTiiZkZq
	 1W6P1RB28dnmcKKp/PwgvRugNHMeceB/XS1oQWZpcKzmEyr71SWWIAa4xYObbyfhwK
	 WQHef6yVY7aDHgwZuZET5TcCJf6NjCZ87bwzRny3ifTyjm4ZrSL5uYwiLv3WlPEJ+X
	 avggcW9d3bLUw==
From: Chao Yu <chao@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH RESEND 6.6.y 2/3] f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
Date: Fri,  9 Oct 2026 11:21:39 +0000
Message-ID: <20261009112140.2275137-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009112140.2275137-1-chao@kernel.org>
References: <20261009112140.2275137-1-chao@kernel.org>
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

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Chao Yu: backport to 6.6.y:
  - drop file.c changes as f2fs_ioc_reserve_dev_alias() is not present in 6.6
  - use f2fs_{down,up}_write(&sbi->gc_lock) as 6.6 lacks lock tracing
  - use IS_CURSEC() in gc.c as cursec pinning is not present in 6.6
  - pass dry_run_sections == 0 to do_garbage_collect() as in 6.6 ]
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      | 33 ++++++++++++++++++++++++---------
 fs/f2fs/segment.c |  4 +---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 63d3450f895e..bf6f58c110f2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3921,7 +3921,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections);
+		bool dry_run, unsigned int dry_run_sections, bool lock);
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ac21950f53cd..8a37461fc278 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2034,7 +2034,7 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections)
+		bool dry_run, unsigned int dry_run_sections, bool lock)
 {
 	unsigned int segno;
 	unsigned int gc_secs = dry_run_sections;
@@ -2045,29 +2045,44 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
+		int err = 0;
+
+		if (lock)
+			f2fs_down_write(&sbi->gc_lock);
 
 		/*
 		 * avoid migrating empty section, as it can be allocated by
 		 * log in parallel.
 		 */
 		if (!get_valid_blocks(sbi, segno, true))
-			continue;
+			goto next;
 
 		if (IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, segno)))
-			continue;
+			goto next;
 
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
 						dry_run_sections == 0);
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
+			f2fs_up_write(&sbi->gc_lock);
+		if (err)
+			return err;
+		if (dry_run && dry_run_sections && !gc_secs)
+			return 0;
 	}
 
 	return 0;
@@ -2102,7 +2117,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 		f2fs_allocate_segment_for_resize(sbi, type, start, end);
 
 	/* do GC to move out valid blocks in the range */
-	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
+	err = f2fs_gc_range(sbi, start, end, dry_run, 0, false);
 	if (err || dry_run)
 		goto out;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c5c94ac40860..6bc1b57a7835 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3147,9 +3147,7 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 	f2fs_unlock_op(sbi);
 
 	if (f2fs_sb_has_blkzoned(sbi) && err && gc_required) {
-		f2fs_down_write(&sbi->gc_lock);
-		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
-		f2fs_up_write(&sbi->gc_lock);
+		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1, true);
 		if (err)
 			return err;
 		err = f2fs_sync_fs(sbi->sb, 1);
-- 
2.49.0

