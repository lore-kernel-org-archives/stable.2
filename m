Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE11F09AD
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743003; cv=none; b=jD7nFQ+1lzzTp/LXHJ7kIEUqgpnNNFLa+7B4I3sxklQn6QVN8a3c0VdsYoAeaq2Vl0bQ+w3aYp8B0TwJLp0hUpu5sFYpH6BlkRo4fLLddyDkpbCMCyLO0mvyTJpBn3mdhLYj3bx8Gkl8o8AjjcG7QAap6DIH3R1P/2wyJmutiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743003; c=relaxed/simple;
	bh=QG3fQAlBnOjRMvH6Zn6TUW57kQMllgZEpCfHyGP5HLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOhCug25vbkxJJ6aij7+XROxDuh6IqPavURW64sKZJm37JBka7LNCJsVCj6F1stEB6syITgPIrzHFkNaCcTBIozUS/tWeVR0RVW7Rq+l4nCJhghZPsJ3H4XCmo/P/KvVyP1YxSkqek/MpAMQ5aYGd1eWWxM3/sAV9pi7KafAUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWaCZmFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWaCZmFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996841F00A3F;
	Mon,  7 Sep 2026 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788743002;
	bh=1oh6b74kyqlGbCse1x35doqEpeCITfrFttPSnWID+Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oWaCZmFvQMgbOCM/YyPuWqUKGoI1UeNrgd/hzX2BQ9g06r3amhZKJ02p0wFa1qOn2
	 deGYYwyasb6GoJ38bozqun0sSuorb66c6d2RP7eRZj/gHeZJczRIiW9pGUNrqINEyP
	 bXD5Jr01lz57zizyQX4hnvIFNfR7ipEQ7v5oPX1pk8yEPr0XUCW1qdigzzPNv4n8M/
	 otfnu2s5PYRf0Jzy0ChPmGfupT3PncCHh31epkfxIepDvr7D6TJFZjgMoErjdmbtpB
	 SMxnholroVEyf4kbx88Sqa5SDwU3X+Tm2qEaD6LHm/OxlSr50gR+hBS6BkYhurpsA6
	 Z/VKVQxKlz7sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag
Date: Sun,  6 Sep 2026 21:03:17 -0400
Message-ID: <20260907010317.1950131-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907010317.1950131-1-sashal@kernel.org>
References: <2026090330-ferocity-flavorful-f5e4@gregkh>
 <20260907010317.1950131-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 15f7c86215e8d5f14b24127fa88af6c79363d50e ]

[TEST FAILURE]
The test case generic/628 will fail if MOUNT_OPTIONS is set to
"-o nodatasum":

  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 btrfs-vm 7.1.0-rc4-custom+ #383 SMP PREEMPT_DYNAMIC Sat May 30 07:35:42 ACST 2026
  MKFS_OPTIONS  -- -O bgt -K /dev/mapper/test-scratch1
  MOUNT_OPTIONS -- -o nodatasum /dev/mapper/test-scratch1 /mnt/scratch

  generic/628  1s ... - output mismatch (see /home/adam/xfstests/results//generic/628.out.bad)
     --- tests/generic/628.out	2022-05-11 11:25:30.816666664 +0930
     +++ /home/adam/xfstests/results//generic/628.out.bad	2026-06-08 18:56:49.878542927 +0930
     @@ -8,8 +8,9 @@
      310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
      310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/d
      test reflink flag not set iflag
     +XFS_IOC_CLONE: Invalid argument
      310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
     -310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/b
     +d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/b
     ...

[CAUSE]
The direct cause is that after "chattr +S", the btrfs inode will lose its
NODATASUM flag inherited from the mount option. E.g.:

  # mkfs.btrfs -f $dev
  # mount $dev $mnt -o nodatasum
  # touch $mnt/foobar
  # sync
  # btrfs ins dump-tree -t 5 $dev | grep "(257 INODE_ITEM 0) itemoff" -A 3
         item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
         	generation 9 transid 9 size 0 nbytes 0
         	block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
         	sequence 1 flags 0x1(NODATASUM)
         	                     ^^^^^^^^^ Proper NODATASUM flag

  # chattr +S $mnt/foobar
  # sync
  # btrfs ins dump-tree -t 5 $dev | grep "(257 INODE_ITEM 0) itemoff" -A 3
  	item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
         	generation 9 transid 10 size 0 nbytes 0
         	block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
         	sequence 2 flags 0x20(SYNC)
         	                      ^^^^ Only the new SYNC flag

This makes the inode drop the old NODATASUM flag, while the new reflink
destination will still inherit the NODATASUM flag.  The mismatching
NODATASUM flags will cause the reflink to fail.

The root cause is that, inside btrfs_fileattr_set() if no FS_NOCOW_FL is
set, we remove both NODATASUM and NODATACOW flag.

However we should not touch NODATASUM flag, as data COW doesn't require
checksum.  Only NODATACOW implies NODATASUM, but DATACOW doesn't imply
DATASUM.

The deeper problems are:

- Fileattr API is too binary
  It either clears or sets a flag, there is no "do not change" option.
  So that why "chattr +S" implies "chattr -C", and is forcing us to
  change NODATACOW along with NODATASUM flag.

- No way to change NODATASUM through fileattr API
  In fact NODATASUM can only be modified through mount option.

The deeper problems are much harder to attack.

[FIX]
Remove NODATACOW flag when FS_NOCOW_FL is not set, but only remove
NODATASUM if "nodatasum" mount option is not set.

This allows the existing "chattr +C" then "chattr -C" to remove
both NODATACOW and NODATASUM flags on a default mount.

But for a mount with "nodatasum" option, the NODATASUM inode flag will
persist through either "chattr +C" and "chattr -C".

Fixes: 7e97b8daf634 ("btrfs: allow setting NOCOW for a zero sized file via ioctl")
Cc: stable@vger.kernel.org
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c38d7cd0f34e5..27089a49cfd22 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -320,14 +320,21 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 			inode_flags |= BTRFS_INODE_NODATACOW;
 		}
 	} else {
-		/*
-		 * Revert back under same assumptions as above
-		 */
-		if (S_ISREG(inode->vfs_inode.i_mode)) {
-			if (inode->vfs_inode.i_size == 0)
-				inode_flags &= ~(BTRFS_INODE_NODATACOW |
-						 BTRFS_INODE_NODATASUM);
-		} else {
+		/* We can only change NODATACOW for zero-sized regular file. */
+		if (S_ISREG(inode->vfs_inode.i_mode) && (inode->vfs_inode.i_size == 0)) {
+			inode_flags &= ~BTRFS_INODE_NODATACOW;
+			/*
+			 * There is currently no way to change NODATASUM flag
+			 * through fileattr API.  If we unconditionally keep the
+			 * current NODATASUM flag, chattr +C then chattr -C will
+			 * keep the NODATASUM flag, and no way to remove that
+			 * flag.
+			 *
+			 * So respect the current mount option for NODATASUM flag.
+			 */
+			if (!btrfs_test_opt(fs_info, NODATASUM))
+				inode_flags &= ~BTRFS_INODE_NODATASUM;
+		} else if (!S_ISREG(inode->vfs_inode.i_mode)) {
 			inode_flags &= ~BTRFS_INODE_NODATACOW;
 		}
 	}
-- 
2.53.0

