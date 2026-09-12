Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5D455162
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789214207; cv=none; b=tMH7YUzVhiYrPdET4krYOt4TrfqAo96O/XY1KDUPrhBOy2U1OWpHShlJ51rbahLtTi1kVZlgLO0SdgqyqmfHGzY4j+rOdtpmQiECcHcxC68tnG62BUViGcbLrC4EL6+u92tGt/jPRo1TLdXA3iUNxEhbbq9QMkvAPhT5fF6T48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789214207; c=relaxed/simple;
	bh=OOuP2SQQeaiVcbfNNbUcPA8Yw7YJWODMeD3v0dxqotg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHmmKgDIPceTF+GuLNq2Tytk93zQHEKo4r8OkrvNJ33ajYW1eo4HDvTfb2D8K8oqkPm9Gwf7kpAYcPp2IyGPNaWIQyEVMansBw1usWXvKNGLaWx/gAxfRb0rVgjUVvgv/TdSgqZ1RTgk9yLnjxJnqaLxQdd9LbxhHlWQoi0eOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyCnjcCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyCnjcCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC361F000FF;
	Sat, 12 Sep 2026 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789214206;
	bh=DA2Hi4MW+s1e+1WZ7Blj5RZMfdLFl64GCViineVV2w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IyCnjcCJyGxFfCG+YEV97XZfhtP6Fm5sC0LgwY6xzJbv/AdN8tkrzFR2hyvD+5MiS
	 a2BzCoiwYzaFLh+xUwcNWH8eknonUrKSvhmdN3aLXmswV97xwEp/5UXH4nmcQ91exK
	 J6bRZeLOe5yv+G5n8U8oKcTKM2+HYaZnlt2M3YzCq40iFOqkSYFoaoab791c5eLcYS
	 1ngVIjYk2hZ62SKZbUfmedZHY8T4W/KB3S7+Zh6dYtgvIbh0PvgNGHjn4T2F8aSFxe
	 wnhiUmcHEkz2hHmU1obACS7gSBC5t2KfvBLwy5WNoWOywj/BKmns1Xy0z52jjWRTDE
	 62Ve2nuRjtkEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
Date: Sat, 12 Sep 2026 07:56:42 -0400
Message-ID: <20260912115644.2476312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090944-celtic-lavender-8b43@gregkh>
References: <2026090944-celtic-lavender-8b43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit fa487f56efba6344aef67d871688f0908fe08af3 ]

It needs to trigger checkpoint to free space reclaimed by f2fs_gc_range(),
otherwise, fallocate() on pinfile will fail easily even there is slash
space in conventional zone.

[Testcase]
nullblk_create.sh 512 2 1024 1024
mkfs.f2fs /dev/nullb0 -f -m
mount /dev/nullb0 /mnt/f2fs/
touch /mnt/f2fs/pinfile
f2fs_io pinfile set /mnt/f2fs/pinfile
mkdir /mnt/f2fs/dir/
for((i=0;i<3934;i++)) do { dd if=/dev/zero of=/mnt/f2fs/dir/$i bs=1M count=1;} done
sync
for((i=0;i<3934;i+=2)) do { rm /mnt/f2fs/dir/$i;} done
for((i=0;i<1950;i++)) do { rm /mnt/f2fs/dir/$i;} done
sync
f2fs_io fallocate 0 0 $((1024*1024*1024)) /mnt/f2fs/pinfile
sync
stat /mnt/f2fs/pinfile
f2fs_io fiemap 0 $((1024*1024*1024)) /mnt/f2fs/pinfile

[Before]
fallocate failed: Resource temporarily unavailable
  File: /mnt/f2fs/pinfile
  Size: 109051904       Blocks: 213208     IO Block: 4096   regular file
Device: 250,0   Inode: 4           Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2026-08-12 20:04:02.264000000 +0800
Modify: 2026-08-12 20:04:26.784000000 +0800
Change: 2026-08-12 20:04:26.784000000 +0800
 Birth: -
root@localhost:~#
root@localhost:~#
root@localhost:~#
root@localhost:~# f2fs_io fiemap 0 $((1024*1024*1024)) /mnt/f2fs/pinfile
Fiemap: offset = 0 len = 1073741824
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000002e00000 0000000000200000 00001000
1       0000000000200000 000000002dc00000 0000000000400000 00001000
2       0000000000600000 000000002e400000 0000000000600000 00001000
3       0000000000c00000 000000007a400000 0000000005c00000 00001001

[After]
  File: /mnt/f2fs/pinfile
  Size: 1073741824      Blocks: 2099216    IO Block: 4096   regular file
Device: 250,0   Inode: 4           Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2026-08-12 19:47:49.428000000 +0800
Modify: 2026-08-12 19:49:06.808000000 +0800
Change: 2026-08-12 19:49:06.808000000 +0800
 Birth: -
Fiemap: offset = 0 len = 1073741824
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000002e00000 0000000000200000 00001000
1       0000000000200000 000000003aa00000 0000000000400000 00001000
2       0000000000600000 000000003b400000 0000000000200000 00001000
3       0000000000800000 000000007a200000 0000000005e00000 00001000
4       0000000006600000 0000000002800000 0000000000200000 00001000
5       0000000006800000 0000000003200000 0000000000400000 00001000
6       0000000006c00000 0000000003000000 0000000000200000 00001000
7       0000000006e00000 0000000003600000 0000000037200000 00001000
8       000000003e000000 000000003b200000 0000000000200000 00001000
9       000000003e200000 000000003a800000 0000000000200000 00001000
10      000000003e400000 000000003ae00000 0000000000400000 00001000
11      000000003e800000 000000003b600000 0000000001800000 00001001

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Backport to 6.12: retain the existing f2fs_up_write() lock API; this
branch does not have the upstream lock tracing context. Preserve the
checkpoint after successful range GC, outside gc_lock, before retrying
the pinned-section allocation.

Also route the existing f2fs_gc_range() error returns through a shared
per-iteration exit. This preserves the stable branch's return values and
loop behavior while matching the patch context needed by target commit
2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ("f2fs: fix to reset all pinned
status during fggc"). No functions or newer GC locking APIs are added.

Stable-dep-of: 2b8704b6a8b2 ("f2fs: fix to reset all pinned status during fggc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c      | 12 +++++++++---
 fs/f2fs/segment.c |  9 ++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b8a9412ca1dc8..01cefe00449eb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2119,6 +2119,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
+		int err = 0;
 
 		/*
 		 * avoid migrating empty section, as it can be allocated by
@@ -2133,14 +2134,19 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
-		if (!dry_run && get_valid_blocks(sbi, segno, true))
-			return -EAGAIN;
+		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
+			err = -EAGAIN;
+			goto next;
+		}
 		if (dry_run && dry_run_sections &&
 		    !get_valid_blocks(sbi, segno, true) && --gc_secs == 0)
 			break;
 
 		if (fatal_signal_pending(current))
-			return -ERESTARTSYS;
+			err = -ERESTARTSYS;
+next:
+		if (err)
+			return err;
 	}
 
 	return 0;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4e47826b570a5..9895d5534350b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3268,10 +3268,13 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
 				true, ZONED_PIN_SEC_REQUIRED_COUNT);
 		f2fs_up_write(&sbi->gc_lock);
-
-		gc_required = false;
-		if (!err)
+		if (err)
+			return err;
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (!err) {
+			gc_required = false;
 			goto retry;
+		}
 	}
 
 	return err;
-- 
2.53.0

