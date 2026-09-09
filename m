Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805A545280
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954296; cv=none; b=AHuDj2f+St7+WKOE71CojwBHRO2YNjstFaY0XGy9zLlGTu/OBQDNv0FTafrMVLuOFfrzu6MoXwcIU4l8U1rGOun3QLMeX5hzz3ETndzUJ9eh1C6SU7qD0pp0P+ncIHRoU7fVEKzZ0UlHJRx+0cSk9bvjJY83LhWrZWfd2dyNm4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954296; c=relaxed/simple;
	bh=8w64aDKJ13wAHIiK6klzb8OoORfCCYuvhegHHyHj9v4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qxD/6RdnmzgFuiVqirsJM/OaUEWEMB4CEIq19dPTkdhwijAqJ3v+21tODBAjYvHxdMmnWRdgw2tmfLgS8lg/9fM4IdnNfMXzkW3+CcL0bEAAjomMOBtwm1llvDH0FqC9i2H9nBly1Xl4Ba7m2zDJEtHjIDRGyQmanFIr8YaFTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UwTE9Qso; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UwTE9Qso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EA81F00A3A;
	Wed,  9 Sep 2026 11:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954295;
	bh=SCPPlfU576uRHGFz7kbAk2nFR+lRNvdnBhQsEx9sod4=;
	h=Subject:To:Cc:From:Date;
	b=UwTE9QsoqWaxX6uYFO0qJJxBVtBLDugKH5LkoP4ASw40ugPDuksHdJiK6fplojv/A
	 n+lFpjTMzK1IEqRaYbeXUmnHKFxDmth6Jvf+uteQiMzjLn8XL1tsX4uBRI4xdY+jdA
	 yyjCneGlQlg5Px5EVtnhK0LixrVoAZnEMCZD6+F8=
Subject: FAILED: patch "[PATCH] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()" failed to apply to 6.12-stable tree
To: chao@kernel.org,daehojeong@google.com,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:27:57 +0200
Message-ID: <2026090957-scariness-crudely-46a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fa487f56efba6344aef67d871688f0908fe08af3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090957-scariness-crudely-46a1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa487f56efba6344aef67d871688f0908fe08af3 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Wed, 12 Aug 2026 12:17:54 +0000
Subject: [PATCH] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()

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

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b81245ddd490..7bc779c8e935 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3477,10 +3477,13 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
 				true, ZONED_PIN_SEC_REQUIRED_COUNT);
 		f2fs_up_write_trace(&sbi->gc_lock, &lc);
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

