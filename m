Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534988;
	b=w+0piUodWcilQJO4127PPbrRjYIvVNVdLTrWB4z9+vonAm3Mdb/IFKhdnMN1Rkg2MFlG
	 Umud9e41E0vfaDt/rOS5CNXcvhDuSHpXM1VDLCZmO+/TDiFON/CaBMVDYwb+P21R3O6sH
	 7Th7GKcNOPGcl+FF/0Pbhqo/WLwuuBG0/DqG/QZINtF3yAoB3Wjbg28g28BqZ99ohjKW2
	 GdUOP6+lSeAGL38CFImMRy1HsSNix+eplENAYnDu9n0hEu+u4qIr/rGwFp0zKyqn6axmd
	 2uEEpCaFHVPfBE6mDhTQSY4oXjYlLmZESqEV5MTh6xwYvNSiiuBIsykcVLrODM/7V4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534988;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XWwx40Fc2d4fw+4DgSXIQdfumTmq2OJztcy+UXXcpVY=;
	b=LxPCtS5rxLg+TUroiguZNsgdNDIoEhyGdG4uX5QtkPwBdnnuD0QwRY/aTZytjkp041Iy
	 3R7KDtf1TPrOBWzlNJayYzhg2B0sFv6NR1JTvz1/819wr1Vaeb/HDgiH0SdPnHf+u6ZS4
	 hIlb2mX1scbukL2GdT25k7Zg1AfZzZK07/q6x8BpsfCVSVektrpmdK9cJwPqDwQnlg/+8
	 vHaiDrlUxFQ1xMoi3OSHmrFwq9yytviq1NkcfLowj6/7UeHpa3Qm+66plpIRbI9kN10Xh
	 5tTYANfmAxok/oI6pV3a3C2xSBYgyXV2KOPo6ZoAXfj4T2w+ZhRsV+F+Lija+dPay0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cuGA2L6G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA884606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cuGA2L6G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F286A1F000C4;
	Tue, 24 Nov 2026 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534988;
	bh=XWwx40Fc2d4fw+4DgSXIQdfumTmq2OJztcy+UXXcpVY=;
	h=Subject:To:Cc:From:Date;
	b=cuGA2L6GgnzeOKvGEQjaF1l0BFAUhd0ygxUbrJd0xDFkpZR0dXffy35rmJspFUBkG
	 00Z1eGDy9cflftoij8AF8BimkpWUdE1dhXKzWivwvBFSv8u8txfL8Mv1wWRU1ulPZD
	 S0wZkHvOIQdqc5jRKvhVynuxjstLp0ng7xiMX6hE=
Subject: FAILED: patch "[PATCH] btrfs: reject refs=0 subvolume without DEAD in" failed to apply to 6.18-stable tree
To: teel4res@gmail.com,dsterba@suse.com,quwenruo.btrfs@gmx.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:43:28 +0100
Message-ID: <2026112428-spearmint-famished-4675@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9a58e56e70f610e29b53821e9c706600e529cca3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112428-spearmint-famished-4675@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a58e56e70f610e29b53821e9c706600e529cca3 Mon Sep 17 00:00:00 2001
From: Cheng Yongkang <teel4res@gmail.com>
Date: Sat, 31 Oct 2026 23:25:39 -0700
Subject: [PATCH] btrfs: reject refs=0 subvolume without DEAD in
 SUBVOL_SYNC_WAIT

btrfs_ioctl_subvol_sync() assumes that a cached root with zero
references has BTRFS_ROOT_SUBVOL_DEAD set, and asserts that before
waiting for the cleaner. Two states break the assumption:

- A corrupt ROOT_ITEM with zero references and a matching orphan item,
  on a writable filesystem.
- A failed subvolume deletion. btrfs_delete_subvolume() zeroes the
  root references, aborts the transaction, which forces the filesystem
  read-only, and then clears DEAD again. No on-disk metadata is
  corrupted in this case.

With CONFIG_BTRFS_ASSERT=y, both reach a BUG().

Change the ASSERT() into a proper rejection to avoid triggering a BUG().

Fixes: 6c83d153ed86 ("btrfs: add new ioctl to wait for cleaned subvolumes")
CC: stable@vger.kernel.org
Suggested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Link: https://lore.kernel.org/linux-btrfs/dd97efe9-91ec-495b-b698-acff1447421c@gmx.com/
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
[ Rework the commit message, drop the ad-hoc RW check. ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 847fdc19bd40..000276bb49ad 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5161,8 +5161,12 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
 			return -ENOENT;
 
 		wait_for_deletion = true;
-		ASSERT(root_flags & BTRFS_ROOT_SUBVOL_DEAD, "root_flags=0x%llx",
-		       root_flags);
+		if (unlikely(!(root_flags & BTRFS_ROOT_SUBVOL_DEAD))) {
+			btrfs_err(fs_info,
+				  "subvol %llu has refs 0 without DEAD flag",
+				  args.subvolid);
+			return -EUCLEAN;
+		}
 		sched_ret = schedule_timeout_interruptible(HZ);
 		/* Early wake up or error. */
 		if (sched_ret != 0)

