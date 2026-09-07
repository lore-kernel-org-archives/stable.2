Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5354DBD8E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789270; cv=none; b=ImcLJxBy6/r/Z4pecnpdzyqjJO6XZ42IyjeUtS7htG81QneRoZuJi/dXSVNAIVeFpQxXbCIgkAOGnDnKx35+slF7X4xRbCFl3OCW+XsXBb9u+BkWnhXRDRcl2LEyxrT3OqoxkMOw0vh+g64d7CzvWeoN45FcHGVgTlLwzX8m45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789270; c=relaxed/simple;
	bh=FvCwPyHNjIGqU2S/tl8qDvqBgiLf5QF2NCDh0EWr/cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6+uG71biyGCg20kU2JFwCcY95u7Hv6NcRNhcOeWWdlnaFmvETxebKWGSWI2ei1naY6NA/5AmUchagfRzwIBta99jR6rm+WYJ4eCO6PoRihaEVbFO4ZHYIiT6Pev762sd1rFY/HsbnJ534Rosa+oN9wJxJa74zMZq4cIwDVlH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k13Fr4O6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k13Fr4O6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906D91F00A3E;
	Mon,  7 Sep 2026 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789268;
	bh=EkIxvcEn/pGZECFrtf1NwHBrWz5fnp/ViiV9JYHgfWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k13Fr4O6tcqi3ho15Sxq8ZUfiQi6xvC+9q392npCal2DH/cMNbs0mCQHCK63aJQA+
	 JEcBGi1j4XprCmum6N/Q/jtsBq45iPpy99yKpC9uLcxlqpAaGAswhl15yelwTdNOEA
	 FGBMv2q2RUhihDIneWvJlFpJXs/pbU8ydCJEKX5s8OWrcxRN+/C1DSfqbGtoyKbCtF
	 Bt4fDvyL78yZl5IPZxg4YiHKaBHZ4ZPcKaAxb07kBRkjPJvumwQdu6eC4qaxainGCp
	 yh6ZCFnmG3e4YIu/doE4cIMGaoAnM/a0LbduBkTIBS2IHEQ9/BUkocQ/bXOoEDbgbD
	 Qxpqk6FAwKFHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag
Date: Mon,  7 Sep 2026 09:54:24 -0400
Message-ID: <20260907135424.3120784-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907135424.3120784-1-sashal@kernel.org>
References: <2026090331-stipulate-faction-d656@gregkh>
 <20260907135424.3120784-1-sashal@kernel.org>
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
index ea17c73bd5fec..ffd4e5f7ad11d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -287,14 +287,21 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
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

