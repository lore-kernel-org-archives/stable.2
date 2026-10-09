Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2D4CDDC9
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544917; cv=none; b=Z7GHDeS/9RWbO/3xBqUgbMsB8Ef0EtxGie+FT+umyaPLd2c8saEy2LV7HWfTeT0RFtmblhlo8FoqYUg6NuClVZMIDvKm6qUKzzP16o5L2CoPOXyJ8Qkp2lK7L1TFWr3TNxMAIeE9TTfeQTVdGR8dTfOSw4ESuBByp0mJFFYihm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544917; c=relaxed/simple;
	bh=m4Je+1Loy6mLoPCXjyf16mVBmJDHPS2K5DWcbAqjkIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjAz7Yziln8wN5+30Y1BepG8NPDYSg4u6s7LNu+kz+eHe/Ae+TDNQb7oWVPjhL6LOv5VXdSEtZ/5svzZHZRe0SRK8gzFr3bUUBRXC5dKZ2Ps9ie+7nY7Cm2olPw3hLt5YINGYGsEdHdh/PiKmTkvUnw0MJGiqUOuZojeMWvQQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX4ep1C5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX4ep1C5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EB01F000FF;
	Fri,  9 Oct 2026 11:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544908;
	bh=C1SdB7k2BTQWPIn8qLRWoFGVhJ6N6HSqN3Bs4zPCWRg=;
	h=From:To:Cc:Subject:Date;
	b=EX4ep1C50Hdn6JQ7WZ2O1k0b6y+KLW0PynL7m3rqqJHkAITrQAe1HY51kHnZEqXRd
	 TMGdiwtFztQXg08r00tvYCv9xSEwL1bNbKgoRgYmsLKz4Jetvs8uwNxI40Fd9FBZoN
	 LARJ5TzKi6o51beImtdSVJO/41Yi29jcV+bwkw8e9VJEIWKKP+cE7VhjXZP4BU7U5O
	 ZQNrusqCjhBZzCEBddZE47U3xF9uZeDVHO9rmGCApXms6MplQEa8M08vuIoUwdOKis
	 2gSluw4vjLuSRw5Yd+FlTF/RFs5Rr5sdkFnShBVJjWgIdIZzJX6OoJWc9GsgiziltW
	 TGSDw7NNyo70A==
From: Chao Yu <chao@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH RESEND 6.6.y 1/3] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
Date: Fri,  9 Oct 2026 11:21:38 +0000
Message-ID: <20261009112140.2275137-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
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
[ Chao Yu: backport to 6.6.y:
  - retain existing f2fs_up_write(&sbi->gc_lock) as 6.6 lacks lock tracing
  - assign err = f2fs_gc_range(...) to check return value as in upstream ]
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9c27353f384b..c5c94ac40860 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3148,11 +3148,15 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 
 	if (f2fs_sb_has_blkzoned(sbi) && err && gc_required) {
 		f2fs_down_write(&sbi->gc_lock);
-		f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
+		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
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
2.49.0

