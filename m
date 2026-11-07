Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049638;
	b=X4+r/3ulTPenKwTFY4u2Q10jatW5fw9EAxug+h25qlhf53DPwkJtzPti7Rd509GfetrY
	 4fN8BvM/YNIIpkDx0iaVDZxPjPrFNILOI4Z4QOZ6/2TDW1zctYBGhTFr2YBO+KsfpArx+
	 uX/xYU9oiL1jYLgEe/eDp7DpM0wubMO6IkVrEQhQlLAYE8gNkfqgrRAQfIfDp+UacMSI2
	 WtVbqnlbDawhvMgqlN8DbzBI8xJGYk1JcBld2+lX5hcOqs5ZZMhOb6TT0QmYhBwzBFc9L
	 GYGaSh9eqYD7oGqEEqgsIXNo58vSxbNIo8LI7C8N3F34r9P2o6zP2GAlWKviF0iW2tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7dwqP8JSzhgVQduK2huxZaq9X+/6Y4ddMWse5vNdfxM=;
	b=SA1+Re0/UhT6CkKqUyRfzzzA+dvZOLGvHes/Xxg6UCahjmCzLZbNKWZiWVgzZIbzCYAq
	 KbkYVceEwO1v+OP7qFyMGlSfobukO+hQyrD0NGWdNOmn4HarIjmbNSG1p6nBwNMxrW8pt
	 fzcno6HR405woWW5tWiDQ6ZEJeXmvUFmDP07ZYdivYLtXdJRKyZTxvH4ppYphfQXjaqFy
	 Ap+IhAzJp7f7f72vXe7kEOfwt+TWHvVYlSVXZRo+JK8MLnYLF+0nHSy6g8RXOP2yiL+M7
	 HIx/r5JjeSxgkcWBaEQ2TmG3dhsA35xYhe2nwNIHoq+B0EDmVspQb68DUq+yzMN19Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxbNgeMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA16606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxbNgeMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83621F0089F;
	Sat,  7 Nov 2026 11:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049638;
	bh=7dwqP8JSzhgVQduK2huxZaq9X+/6Y4ddMWse5vNdfxM=;
	h=From:To:Cc:Subject:Date;
	b=DxbNgeMy4xOqOV1TZdJnXLEVLF08abCMGsZ6Hc6jMY+3sKohDleI4aY6+a+/ZcCi3
	 /riwUPKb6NS/s2jT6vwPg4meU0Jxl3WqIwM+FAssMpeWfg5WVPWPpCJ3dGD6jJRpHg
	 OV+NzfoN1lxxZ1MSbsVC4hmzg+7aiqHcppfTVXBKzlUO/UML9zAt8azhRAyWIDKasM
	 sKEKMrrsEKNZXvW2liuxJSTxU/pS6uA9ydLQ5doLh4UgH0Ol23uCMLtwWiQeG9Xvsf
	 4aQa7IqYmvdk41Hp0lmVj88N+3t3cI2SdqdPFkZV9guU2n7M5tCs5MYYfyKBMoisCB
	 YVRxEK+tLcw3w==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: release a removed xattr node in roll-forward recovery" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:16 -0500
Message-ID: <20261107060716-failed-5.15-f5924de8867c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f5924de8867c09206ba631b9faed63862ec00a10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060716-failed-5.15-f5924de8867c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f5924de8867c09206ba631b9faed63862ec00a10 Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Thu, 15 Oct 2026 02:57:31 +0000
Subject: [PATCH] f2fs: release a removed xattr node in roll-forward recovery

When xattrs shrink enough to fit in the inline xattr area,
write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
the file is then fsynced without a checkpoint, only the inode block is
written, with i_xattr_nid of 0.

Roll-forward recovery starts from the checkpointed inode, whose
i_xattr_nid still points to the old xattr node.
f2fs_recover_inline_xattr() copies only the inline xattr area, and
f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
the stale xattr node:

 - The node block is never released, and fsck reports "nonzero bytes in
   xattr space after end of list".
 - If the inline xattr list ends exactly at the end of the inline area,
   its terminator is read from the stale node, and the removed xattrs
   come back after recovery.

When the fsynced inode has no xattr node but the checkpointed one has,
release the old xattr node as truncate_node() does: check its block
address, invalidate the block and drop its node cache, which may still
be dirty.

Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2dc136dbee34f..424e95ca58789 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2846,6 +2846,43 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
 	f2fs_cache_wait_writeback(ientry);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
+	/*
+	 * The xattr node of the checkpoint was removed before fsync, e.g. the
+	 * xattrs became small enough to fit inline. Release it as well, or
+	 * the inode keeps pointing to the stale xattrs.
+	 */
+	if (!ri->i_xattr_nid && F2FS_I(inode)->i_xattr_nid) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		struct node_info ni;
+		int err;
+
+		err = f2fs_get_node_info(sbi, F2FS_I(inode)->i_xattr_nid,
+								&ni, false);
+		if (err) {
+			f2fs_put_cache(ientry, true);
+			return err;
+		}
+
+		if (ni.blk_addr != NEW_ADDR &&
+		    !f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
+					   DATA_GENERIC_ENHANCE)) {
+			f2fs_err_ratelimited(sbi,
+				"nat entry is corrupted, run fsck to fix it, ino:%u, nid:%u, blkaddr:%u",
+				ni.ino, ni.nid, ni.blk_addr);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
+			f2fs_put_cache(ientry, true);
+			return -EFSCORRUPTED;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		/* drop the cached xattr node, which may be dirty */
+		f2fs_truncate_node_caches(sbi, ni.nid, 1);
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ientry);
 	f2fs_put_cache(ientry, true);
 	return 0;
-- 
2.53.0




