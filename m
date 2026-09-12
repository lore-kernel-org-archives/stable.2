Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6C427FB7
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789214208; cv=none; b=sfPhjIDkq3c9eBEedF2H3ZlvFkk3e8SM7WCRABH83EAhdR2pir87mdFEDA7XLQVrq9rtvEne2CL3LnkgghTX1+/w9LXD2apkNot69QpafxrVMCRydWHYfcmouP7uj5uEIaFLazca5679EztpLgsHqFzz34vZmRS5ilcoEI8VnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789214208; c=relaxed/simple;
	bh=PkIcsXDFaBIlvz1htezxv1G6FOCSAyuHaOZH3ftoqU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiZRDpoVIzvfVF2nKtf6JaxIhp+n3OyFySfavre0GBWJ1q1pNgueUiQfpZ3gwWO/0XZ+Zhb6qCSRsFOYNURQFSRUqmS+H3Mv+3/wBHd1l1iD4jsWxNmyUHQxnDeWc/4q3hwLGjHnaUiIHemKHQpzcobBnn/qI+EVfMwdENgddJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+grNtNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+grNtNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9971F00898;
	Sat, 12 Sep 2026 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789214207;
	bh=6VJ0/QU5jSNH8V5Q7Tq9eZ3dES/tiD2EaAtd8QhsRew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+grNtNwo56Erfu9uIvbmRmDJJfNtSfIsIfrHgQlwZvDcjmYSNoFef7Ce4c0/PDT8
	 C0NsrbDyPGUz5seIQ/PZjvRHUdbBSW1fz50NXS6gKouHbfiYX7JCNZg1IrI6uC+bU7
	 1N8fvdISfRHIyK2xOgde/Te6QEZl1kYcByO34JDOlb188aAysRyEGBVpdCrpOOthn0
	 JiYaAZNUMzS13PgFRCBw/fKC/BxUNnpxQ4dBu+Ty+OpYBs9SUUFD1FQUYxHYmT4lBD
	 BNpGKFsB0BUPiBZwUPIqi0xJb0wRMAY77uK2eUxRB4NKY+B5iL7e+Okpxp5SpZR+C1
	 StyzbiYV7G/hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
Date: Sat, 12 Sep 2026 07:56:43 -0400
Message-ID: <20260912115644.2476312-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912115644.2476312-1-sashal@kernel.org>
References: <2026090944-celtic-lavender-8b43@gregkh>
 <20260912115644.2476312-1-sashal@kernel.org>
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

Backport to 6.12: use the existing f2fs_down_write()/f2fs_up_write()
API and IS_CURSEC() macro. Drop the device-alias call-site hunk and the
adjacent victim-reset declaration, which do not exist in this branch.
No functions are added.

The preceding dependency already supplies the shared error exit in
f2fs_gc_range(). Extend it to release gc_lock on every section, including
empty/current sections and successful early completion. Preserve the
stable branch's fatal-signal check after each non-final reclaimed section.
Pass lock=true from pinned-section allocation and lock=false from resize,
which already holds gc_lock. Keep the checkpoint after range GC outside
that lock.

This retains the context needed for the target's pinned-status reset,
which will run while gc_lock is held.

[ sashal: Reduced backport -- upstream 5d49025a4e596 touches 4 file(s), this
  backport carries 3. Not backported here:
  fs/f2fs/file.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 2b8704b6a8b2 ("f2fs: fix to reset all pinned status during fggc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      | 17 ++++++++++++-----
 fs/f2fs/segment.c |  4 +---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e1cbd3917b9d9..631062c547ea5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3984,7 +3984,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections);
+		bool dry_run, unsigned int dry_run_sections, bool lock);
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 01cefe00449eb..80a88748d71f2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2105,7 +2105,7 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections)
+		bool dry_run, unsigned int dry_run_sections, bool lock)
 {
 	unsigned int segno;
 	unsigned int gc_secs = dry_run_sections;
@@ -2121,15 +2121,18 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		};
 		int err = 0;
 
+		if (lock)
+			f2fs_down_write(&sbi->gc_lock);
+
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
 
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
@@ -2140,13 +2143,17 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		}
 		if (dry_run && dry_run_sections &&
 		    !get_valid_blocks(sbi, segno, true) && --gc_secs == 0)
-			break;
+			goto next;
 
 		if (fatal_signal_pending(current))
 			err = -ERESTARTSYS;
 next:
+		if (lock)
+			f2fs_up_write(&sbi->gc_lock);
 		if (err)
 			return err;
+		if (dry_run && dry_run_sections && !gc_secs)
+			return 0;
 	}
 
 	return 0;
@@ -2184,7 +2191,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	}
 
 	/* do GC to move out valid blocks in the range */
-	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
+	err = f2fs_gc_range(sbi, start, end, dry_run, 0, false);
 	if (err || dry_run)
 		goto out;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9895d5534350b..9684a99d05603 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3264,10 +3264,8 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 	f2fs_unlock_op(sbi);
 
 	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
-		f2fs_down_write(&sbi->gc_lock);
 		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
-				true, ZONED_PIN_SEC_REQUIRED_COUNT);
-		f2fs_up_write(&sbi->gc_lock);
+				true, ZONED_PIN_SEC_REQUIRED_COUNT, true);
 		if (err)
 			return err;
 		err = f2fs_sync_fs(sbi->sb, 1);
-- 
2.53.0

