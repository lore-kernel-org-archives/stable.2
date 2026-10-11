Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3430306764;
	Sun, 11 Oct 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734196; cv=none; b=ZztuVTZAwyzOM7wYEL2UJXVJd0EXGB0RuRxpbPeMDsaZIFntnLcGVkIYEhFzyprMxHFNrdJWzRspYTGGZEEL5W1hujpPNxZ5eRnPpNn6DiPiziLKCqbkgSJH0nGn6aHMhQeECHffTe8heiavVzPfVNUaRBBVlVhYtiAl1ufjZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734196; c=relaxed/simple;
	bh=SJhz41fsAmbRBHsGTxoTJpHzqxK69BKYpaPmrWXNWCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GglgsKL05Ca+nIATrbUfoWEP4PqoxkSeizH6jJLnXgetww1So1qIuE4+ZWMirOr4Wru6E2JGnn4Hg0BGzcPtgTyqnZKLQ0ZqAJRUeHLDmp3PZlnzJCsJpjLtq0pKzZ0c+I3t2kjeqC53UnSNUHa3yCsse+Z1sYISLBg4gOCOSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0ClXX4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0ClXX4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9705A1F0089B;
	Sun, 11 Oct 2026 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734194;
	bh=1Diri74Y7LBSNOdqaCTEHWeogyZCybVDVv2BCooqToo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O0ClXX4ZlNnbfuj/9nNZfkj/V1kTOG3JqM7zmc+JVwy7UY041TaBVQ1wt2sptUjmx
	 VDZv6Y4jkvp22o//yzAuE8kKZ7Viu8Xo4P8x6nXHqJrJWbEEZpmdcZA8euY2oA2ID9
	 HBLYTQQGOtSG/YiETj7VnJKc1lRWRsf01E9fZNOt6psi9Lk3oRXhqibk35E4rzVfLG
	 ITAS2TXdLQiCATRFpuTPQRUVl6f2NirYHP6ihe2thCeUushXuxXzH8J5f+vMI1QNy+
	 z+Hl/aO4+cwjEv/CVUYZYozYKhbwFkxwHwncOAuvIzeTyusp+w4vMzFFGk3JNzFUB0
	 65HYDEH4D52BQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:11 +0200
Subject: [PATCH 11/15] super: keep the read-only state if a reconfiguration
 doesn't change it
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-11-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SJhz41fsAmbRBHsGTxoTJpHzqxK69BKYpaPmrWXNWCM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jjnGdfZq53nYjyeR2jtO3w2RuP8ilfs1W/Tkx5ef
 HCyZ2kkW0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzukx/OEsqE5yK5sVkp3J
 Ye5pd7t78kzV/K6S3deWz3pw/YFvtjrDP7V5s0RFGS9kXmeJP3Lm+JENLwO5xOd8yLHqK+kylz+
 Ryg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

fspick() creates a reconfiguration context with an empty flag mask. Only
setting "ro" or "rw" adds SB_RDONLY to it. reconfigure_super() honours
the mask and leaves SB_RDONLY alone otherwise. But a lot of filesystems
decide in their ->reconfigure() whether to go read-write by comparing
fc->sb_flags & SB_RDONLY with the current state of the superblock and
ignore the mask: affs, befs, btrfs, efivarfs, ext4, fat, gfs2, hfs,
hfsplus, hpfs, isofs, jffs2, jfs, minix, nilfs2, ntfs, ntfs3, ocfs2,
overlayfs, ubifs, udf, ufs and xfs. mount(2) always puts SB_RDONLY into
the mask so that never mattered for it.

So reconfiguring a read-only superblock through fspick() without "rw",
e.g., to change an unrelated option or with no option at all, makes
these filesystems go through their read-only to read-write transition.
For ext4 and btrfs that ends with a read-write superblock that writes to
the device and can be written to through any read-write bind mount:

  EXT4-fs (vda): re-mounted 68db7463-95cb-47f9-ab87-d1fd35252958 r/w.

Fill in the current read-only state when the mask doesn't cover it.
reconfigure_super() is called with s_umount held so that can't race with
another reconfiguration. Doing it when the context is created would.

Fixes: cf3cba4a429b ("vfs: syscall: Add fspick() to select a superblock for reconfiguration")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index ac4c4d067509..edd5648d1720 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1077,6 +1077,14 @@ int reconfigure_super(struct fs_context *fc)
 	if (sb->s_writers.frozen != SB_UNFROZEN)
 		return -EBUSY;
 
+	/*
+	 * Filesystems take fc->sb_flags & SB_RDONLY as the read-only state the
+	 * superblock ends up in. If that isn't being changed, e.g., fspick()
+	 * without "ro" or "rw", it's the current one.
+	 */
+	if (!(fc->sb_flags_mask & SB_RDONLY))
+		fc->sb_flags = (fc->sb_flags & ~SB_RDONLY) | (sb->s_flags & SB_RDONLY);
+
 	retval = security_sb_remount(sb, fc->security);
 	if (retval)
 		return retval;

-- 
2.53.0

