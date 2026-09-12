Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82F0472071
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211819; cv=none; b=PpnaRkrgmtR4eMDZrpsT5oUPbm1IqBref8OmF2Y15xCkKzoafQ494MMpV2OBNnAMh60tw6zpup4REeO931wVKJMT/zIjRXXDpywNPrJ7CjrTsWx2gHU9jhoG89eH2x4yb/aOJY58r1Xh01vLjYA88jOqfxsbGkhbD8dLggCrumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211819; c=relaxed/simple;
	bh=3wVG33NNpLM0+XohEx1dTHUJj34ZvkQbwIE98Oessz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ap6/+N9DRqHEbyQhKaj+/xZCkU0AnUbhZlmcpt83FSiX024gcUKmQkDR6eeDaTM8p80WJIz842BKVZrKi92Gu5Uvtxu/OQZ6SMKPT61eBjNyfrw1fD2Eo72oIfyPcCP3cN3eVGN7ELxRyE4vpFQcUd1yGsjg95Vz3SAOZqiP/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrBCYHt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrBCYHt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7061F00898;
	Sat, 12 Sep 2026 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211817;
	bh=mmMsPlsE7wC0qw3Pkts/wShXDd/BWFJ47WAHmk/AsnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrBCYHt/9yvzDc3hf2aJ1irlsQsG147bqaIXsF2ghPy3BtG3tuVhg93ZOwl1ilaBi
	 ZQLpGCE5DylHvR/ig8QdNdu2SR+AKZwbpAPQPtUSAc6fQG2Wgx3jA8JPBoWkFcEqJq
	 SvbzLTUgXW4bxwvt6uSQSbEFT4KRuh3zu8jzX5hGI/EBv6Fn8NWDWAcqoRvGwSTkmW
	 fj8PhcIKE8ppLyD0utV7YVRPCfgR3lxtemwsWSqEew3DmyXQvMC1QJanLnARHY5IpK
	 AWrVYm8WAglDhLlnmQTcaTy2LUQ4ThVL+U8plWb5XDrIYCxZNIw2EeeaKiKPpoCUV6
	 KaWOec4Ul5UuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
Date: Sat, 12 Sep 2026 07:16:52 -0400
Message-ID: <20260912111653.2276190-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111653.2276190-1-sashal@kernel.org>
References: <2026090944-reprint-spruce-0599@gregkh>
 <20260912111653.2276190-1-sashal@kernel.org>
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

[6.18 backport: Keep the existing non-tracing lock helpers. Release
sbi->gc_lock before calling f2fs_sync_fs(), which reacquires it while
issuing the checkpoint, and retain the upstream error/retry behavior.

Also carry only the error-exit preparation from 5d49025a4e596
("f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()"): use the
per-iteration err variable and next label without moving locks or
changing the f2fs_gc_range() interface. This preserves stable's return
values, dry-run stopping behavior and lock coverage while supplying
the context required by 2b8704b6a8b2 ("f2fs: fix to reset all pinned
status during fggc"). No new functions are introduced.]

Stable-dep-of: 2b8704b6a8b2 ("f2fs: fix to reset all pinned status during fggc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c      | 12 +++++++++---
 fs/f2fs/segment.c |  9 ++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 429fc5bd4ae0d..05308e44a3550 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2140,6 +2140,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
+		int err = 0;
 
 		/*
 		 * avoid migrating empty section, as it can be allocated by
@@ -2154,14 +2155,19 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
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
index b39dcf8973a10..215f531dcc791 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3364,10 +3364,13 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
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

