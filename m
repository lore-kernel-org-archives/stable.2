Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429AF3DB300
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544961; cv=none; b=KcrAhiVuey3FCxHdSDDEaH00kz343steWmGzj2cvxtMECr3mI14Sy6XWeHXQ+OGFrEjfrOVLX5Rk2Fii8ius93lnkjn/a8t2K3DBZ/iDs+8eJIkHvyHA44lTDD6oxwRuveWdc7RWVIQlPuNVTh7C08+nrZkd1c6st0HWAel1WZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544961; c=relaxed/simple;
	bh=IbeBNI5fL4FRhaw6cvOB1zss/wO2ugjZIxf+WdkFtJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfmkU6AxLsbiIdom4eJbuzZNVi4I6glsqbBqpITql3Sssb4Od9NloGfxdjZ/kfNDC1p4hVGImrHhOf12nUuf6BE04cYuEt7lWFo2VQH6S0k6LBAyaUkh7UhEHC5aDYLWHlHcOAufFX/Qkr6xM2qs3SoSuFsZCKSHSGrWqgcBm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQzrzbdr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQzrzbdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E31F00898;
	Fri,  9 Oct 2026 11:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544952;
	bh=cYLHh2vFEwwzSjDjxFQIW0PW1qi9Pe60h75NQH/ba/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQzrzbdrIUd8GVPqKxuqzBpBKU0apJOBsa/9oWONoLWKscqSk06kJSipEzp2t3n1y
	 AUHpjWOMYk1tdnSYVOJf3K73ww5aHyNZ35WvfTQPtzd4rInmZIWjJ2nxcbUuqDAsmF
	 jYPW1rk2BP9F6LlFbUo7Vvk0iygOad2QJHvLuqWN0ZPan5vPILTCFCTX4K4nO1slu2
	 4hnKvJTSAk5/QqnNFZnsES6VXq9pwg256txuFRp9kA+fNYosSxSAq0SaPZkWj5sWNN
	 iACr5AyhRXSzVxqniuJgGeC1NJvrXmU9duUJriGlnw7Z7XVUD6ZPuvYrp3HE2dIbo4
	 cA3+CPW5wcubw==
From: Chao Yu <chao@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH RESEND 6.12.y 2/3] f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
Date: Fri,  9 Oct 2026 11:22:19 +0000
Message-ID: <20261009112220.2276173-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009112220.2276173-1-chao@kernel.org>
References: <20261009112220.2276173-1-chao@kernel.org>
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
[ Chao Yu: backport to 6.12.y:
  - drop file.c changes as f2fs_ioc_reserve_dev_alias() is not present in 6.12
  - use f2fs_{down,up}_write(&sbi->gc_lock) as 6.12 lacks lock tracing
  - use IS_CURSEC() in gc.c as cursec pinning is not present in 6.12 ]
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/gc.c      | 33 ++++++++++++++++++++++++---------
 fs/f2fs/segment.c |  4 +---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 053c8630d6ef..12ca7ba9d6dc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4028,7 +4028,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections);
+		bool dry_run, unsigned int dry_run_sections, bool lock);
 int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4f9fa45ebbac..664260807072 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2100,7 +2100,7 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 
 int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		unsigned int start_seg, unsigned int end_seg,
-		bool dry_run, unsigned int dry_run_sections)
+		bool dry_run, unsigned int dry_run_sections, bool lock)
 {
 	unsigned int segno;
 	unsigned int gc_secs = dry_run_sections;
@@ -2114,28 +2114,43 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
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
+			f2fs_up_write(&sbi->gc_lock);
+		if (err)
+			return err;
+		if (dry_run && dry_run_sections && !gc_secs)
+			return 0;
 	}
 
 	return 0;
@@ -2183,7 +2198,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	}
 
 	/* do GC to move out valid blocks in the range */
-	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
+	err = f2fs_gc_range(sbi, start, end, dry_run, 0, false);
 	if (err || dry_run)
 		goto out;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 328799ec670d..1ec43e1537fb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3263,10 +3263,8 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
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
2.49.0

