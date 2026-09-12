Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237F4BEE20
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222861; cv=none; b=CnZrN8ecdi2eh+dIp+cTZitktm9ENq3TN3edi23kNhQU5jcpVq9DRk9127ZJzBIcY6RVyeeq4xsMQxhrBZn0ti8OBB5+fkbSG/WszivU/T1n3ISoNGg9VJsg7zVBtvfIGn42GNJGbVQaoR6rMIRHaeIKtB3JR2yRq0MEBeZ17VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222861; c=relaxed/simple;
	bh=M+g9VZbJLU5tvD9VzaBc+IJX6zDw1hCDZHqlvZCed2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmnIwKCOxfGnkNUynIoHPHO1QJJj1cnJ2j9+/Qa1719QzfTzzZcsYE0YXF9JFgy9scZP10bqu9TTRgMkV1FDlG6HxyJ06ldMBuo9r2ucwhYNA/4EtMBNn/mdk9fLh6cUMg46fCS7A9k6Xfx5ByeM5kyCA6RmZuswe3w6WAud2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmRkLcUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmRkLcUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCA31F000FF;
	Sat, 12 Sep 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222859;
	bh=43+w2iWxB4nxUN/qqJ4qqDVUawfXxNiVMQ7pjSFjzs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmRkLcUp6BcwvZykIrcEMOl3v8cdCYOrDtqAsh8wtU8ZGU79AQ/OfnWzpds+u1p4k
	 b2RLl9BjQsX/VfaBF1iwPc/jz2T0T8C9xL4dzmK0LNptOyOIBtA0paTq3A/f0mcs7p
	 +cMEb9aHwGnkxZRR+OHZpLM2XflJiyU3tuy9sHJMAh0+xmhzM0KOGw6oKXn4JbZde1
	 fD327QjbPt6eiU80Ye6zJQUa0JXuDeDLOfM5RGrmanDcFc3upz6qJDnbqZOA/zUBGy
	 sbH5xcfdIiGl+QSwB6b/J6nBUB6Auno8yigZGrwz1CQBl8L0w3+uiRGps5ZDhiPIa1
	 zJfQHRTlSZrGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
Date: Sat, 12 Sep 2026 10:20:56 -0400
Message-ID: <20260912142057.2913172-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090945-delicacy-nutmeg-a9dc@gregkh>
References: <2026090945-delicacy-nutmeg-a9dc@gregkh>
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

Backport to 6.6: retain the existing gc_lock helpers and first-device GC
range with its one-section reclaim request. Capture the GC result, return
GC failures, and issue the checkpoint after releasing gc_lock before the
single allocation retry. The newer lock-tracing and zone-range interfaces
are not required for this fix.

Add braces around the existing -EAGAIN check in f2fs_gc_range(), without
changing its behavior. This supplies the merge context needed to
cherry-pick 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 cleanly on 6.6,
without importing the upstream GC locking refactor or adding functions.

Stable-dep-of: 2b8704b6a8b2 ("f2fs: fix to reset all pinned status during fggc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c      |  3 ++-
 fs/f2fs/segment.c | 13 +++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ac21950f53cd2..f6ae5b086f44d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2060,8 +2060,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 						dry_run_sections == 0);
 		put_gc_inode(&gc_list);
 
-		if (!dry_run && get_valid_blocks(sbi, segno, true))
+		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			return -EAGAIN;
+		}
 		if (dry_run && dry_run_sections &&
 		    !get_valid_blocks(sbi, segno, true) && --gc_secs == 0)
 			break;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9c27353f384be..39a03fcb8e9d0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3148,11 +3148,16 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 
 	if (f2fs_sb_has_blkzoned(sbi) && err && gc_required) {
 		f2fs_down_write(&sbi->gc_lock);
-		f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
+		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk),
+				true, 1);
 		f2fs_up_write(&sbi->gc_lock);
-
-		gc_required = false;
-		goto retry;
+		if (err)
+			return err;
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (!err) {
+			gc_required = false;
+			goto retry;
+		}
 	}
 
 	return err;
-- 
2.53.0

