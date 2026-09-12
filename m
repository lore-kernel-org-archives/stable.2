Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E033F368
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789178196; cv=none; b=QzkJcjZG/yUjFuKXzRCmXkLvpx250Yb7oKdu2/o2Dh8HlblzAQC/zIuNitfHaRRz6KKejC2hQjmFweKCVMlTorO/NptmWY/MbqhfPiQnQoJqnaOLqAXWebo/5PxmC+pTOnK7LMS9SLEfiJRrACmFLWChsdbywst4YM27BMiqXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789178196; c=relaxed/simple;
	bh=1ZUWFpBwNOYxkqF1p169ieEYK8PWZG011u5fS3dqQBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8zAW7H1keH1EgRVd92QbRJ5EW/8Dt+Kc7XQVkDgwES4NlvIIi/V1/5F+AVYYNnPGbFnhyaBxfxwH+9mPO58o6fiozu3dbPN2aar7lvU8QR+5GtepKicFAb75+Fx8vQJ98h36H3WBPYlSHcWyB3+PaRSsHCnWwr4QwiqOAjRrgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYNWA7ZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYNWA7ZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A39D1F000FF;
	Sat, 12 Sep 2026 01:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789178194;
	bh=VAMS9RT0eYfeeGq5QJ6g6Q89ZIs8emXwN28LTAQaMfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYNWA7ZXP7OctExEQaDWE00fzAZIH+Qh8w5QKTWdQl9StJGGGqS69CJXde9xnVTZZ
	 6/Alw2tdmyjt9BhJEPR65onkfKY/GUVypfB9OeDywF73HCk5JTCZVyS0QvnmDg3bS9
	 aeps0cOtbTHr9vd042ImioYDVsqGXe2Bb0O1JyvtrxvAqeCLptCHWD2sgZp9dqOswk
	 +zJLGXmuT+3PLfmgpM6V+LYjtzQc3rYV/lJdBrNdT8nkSj0o6LH1yDKNDAoHs7vTNO
	 hnoTONyH/p+H6zFUyGT/XBYbUJkGkdMo7uNOSYAlXjUqhzRoRtTLyws475FReKJlaF
	 +4gB5HnkAKkBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
Date: Fri, 11 Sep 2026 21:56:31 -0400
Message-ID: <20260912015631.1863870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090957-skintight-librarian-4737@gregkh>
References: <2026090957-skintight-librarian-4737@gregkh>
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
[ adapted the GC error check to capture the previously ignored f2fs_gc_range() return value. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9c27353f384be..f4bff680e9e0c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3148,11 +3148,16 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 
 	if (f2fs_sb_has_blkzoned(sbi) && err && gc_required) {
 		f2fs_down_write(&sbi->gc_lock);
-		f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
+		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk),
+				    true, 1);
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

