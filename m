Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9D3939BF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954200; cv=none; b=Cwb7Zb/2MRjLDdPfxkIvjG9OjmLvW+MsKzQ7ye1+tGOv+VbRRftQFOh4mYSnZnhp0wqrv6k52L7aundncPMe1ZrPNs3rEJM/2YM0pozpl/6ro+uiLK885xB7jwb6n9JtYY1i6dz57gTYxdkGrTcn3l7y5YQqpDS139uftMN32XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954200; c=relaxed/simple;
	bh=/XuHDYRGypA9UZXbnHUUsCTZBQD8/ppYA6SDk/k+jLY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a3lmcwJdezg6WQpu+ZWkBIwDM+PKx2rrQFjHT1/eR6CgmQjLPQDDsuZb3J945YrBJVyXnTszfE23wGdmNI3g8wzg9PyxFDJ+pfIXk5NqlVeGnFBbjYKttz6LFWWCmSqGzqBnqRDERt6EEO0E+4Ks52+q5qOcWjJl5RlU32KeSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J8Cq4XSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J8Cq4XSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1A01F00A3A;
	Wed,  9 Sep 2026 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954199;
	bh=ilQHO4C0MDTH+kFukx6zUbVcYWeg/hAOU/9/HkYcuVU=;
	h=Subject:To:Cc:From:Date;
	b=J8Cq4XSdnji9uz4NeWrZ7LlgdB3EOCbAMCvpNP2UahPjzk5rgYsoZ+LA0Gn4vixgF
	 YMZ7UMJIHkvMEJeFyTeXhZ9Ce6uj57IrDuJ/VEc9izdTs1w9MiESBV8RggChbewY06
	 IUqzJgFfniIUW7ZIsrV3BxZyeQqoTJj/zwg8GVbA=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid potential section-unaligned pinfile" failed to apply to 6.1-stable tree
To: chao@kernel.org,daehojeong@google.com,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:25:50 +0200
Message-ID: <2026090950-buccaneer-avoid-d121@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d0a481fad5c7a3a56ecf54a099651216869f4d0a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090950-buccaneer-avoid-d121@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0a481fad5c7a3a56ecf54a099651216869f4d0a Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 29 Jun 2026 11:49:18 +0000
Subject: [PATCH] f2fs: fix to avoid potential section-unaligned pinfile

Blocks of pinfile may not aligned to section size due to wrong use
on pinfile, result in heavy overhead of GC, let avoid this by
adding additional check condition in f2fs_setattr().

- truncate -s 8mb pinfile
: random checkpoint may persist filesize w/ inode
- fallocate -o 0 -l 8mb pinfile
 - f2fs_fallocate
  - f2fs_expand_inode_data
   - f2fs_allocate_pinning_section
   - f2fs_map_blocks
    - f2fs_map_lock
    - __allocate_data_block
    - file_need_truncate
    : w/ FADVISE_TRUNC_BIT, we can expect unaligned mapping can be
      truncated while open() if f2fs is not umount abnormally
    - f2fs_map_unlock
    : following f2fs checkpoint and sudden power-cut

- mount
- open pinfile
 - f2fs_file_open
  - finish_preallocate_blocks
   - truncate_setsize
   : filesize is 8mb
   - f2fs_truncate
   : can only truncate block outside filesize, rather than truncating
     unaligned blocks inside filesize

Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Cc: stable@kernel.org
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..c54897a25981 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1107,17 +1107,23 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			!IS_ALIGNED(attr->ia_size,
 			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
 			return -EINVAL;
-		/*
-		 * To prevent scattered pin block generation, we don't allow
-		 * smaller/equal size unaligned truncation for pinned file.
-		 * We only support overwrite IO to pinned file, so don't
-		 * care about larger size truncation.
-		 */
-		if (f2fs_is_pinned_file(inode) &&
-			attr->ia_size <= i_size_read(inode) &&
-			!IS_ALIGNED(attr->ia_size,
-			F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
-			return -EINVAL;
+
+		if (f2fs_is_pinned_file(inode)) {
+			/*
+			 * It may break section-aligned fallocate recovery
+			 * mechanism, so do not allow larger size truncation.
+			 */
+			if (attr->ia_size > i_size_read(inode))
+				return -EINVAL;
+			/*
+			 * To prevent scattered pin block generation, we don't
+			 * allow smaller/equal size unaligned truncation for
+			 * pinned file.
+			 */
+			else if (!IS_ALIGNED(attr->ia_size,
+				F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
+				return -EINVAL;
+		}
 	}
 
 	if (is_quota_modification(idmap, inode, attr)) {

