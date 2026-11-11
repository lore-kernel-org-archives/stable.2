Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421297;
	b=mWDnk1bA0iQd7+ilmZhO4PNiLhg+Y2XIfx+zjekrSZGA1qvu4qhbGt+nPiOKQkcjS6N6
	 +NSg05iqOhyDqF8HViFyd6rcY4qZgu+QABFAFb82KyoVgNv/9EUMF6Ugm8L806j6wtUzP
	 9MhKoO/rXGvdu5UQXpLi1cJxvtQC5kQLhPGg27iv1JDk+lH9Zs0SwOxVQxmkDPlqPJ5lw
	 ze4fMwMN+ynJYwePScMPg7Rl6NSPNKYRZrwemeeu5Y+uef5YKVk9tyFekLwBYToXULQRz
	 uzvlTn7FymUqXweacOsopezwKuUvt6BFcJ4ZYjlRBez4aTBRHSGCgFeQa/vn/f6Hd2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421297;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lCzbiOM6zTl7tyh27ByotKdPrZZ1rktNwIi45p8sWps=;
	b=TRVf2iEauv6PgrrIr0U8WEAKNoIAIDuokZyz/4qrOncD5QwPJvMYucTnTDNt4yQRdJ5J
	 mIr9y77xFRQw1BI/0xokufc3H4Jc0gFszVuHDmQ/EbWiC7QoEwWjTi2WqUTVL1Zu/QJNG
	 gJZzK3h/NnyyB8QM043aaOC5CRn5CH1GihniAhhCSjQqUanHzUZznp4oaG5l/5/3L3fkq
	 XjJeVfN2qqLZOol1qgL09RlH+7TAmv0FkaOjHi4x6YwmlNabHLvxfzcZYaGqMvbEztpEJ
	 6QeAkt9xusjPhbNY9m3NvnxJL6v0lJdeHkuOvucQ5/rcXBruUYb2slE3wwdpugnrJGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePWenG72;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962C606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePWenG72
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748131F00A05;
	Wed, 11 Nov 2026 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421297;
	bh=lCzbiOM6zTl7tyh27ByotKdPrZZ1rktNwIi45p8sWps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ePWenG72bhYm7S1JRm4R6qbwTHbEJvOwctxiFRlYXmrVSn/38Epkr8jj9gMozDEGF
	 jKSOY0GJWp5vbX8ZvcEgP4M7x8XNjeR+blrDMuavaprl/0RlIFYRPWJ0M8ugBtVjOD
	 HYSYcjFSRECTRYxxWlx6CHBbkO7aQw0D5w6UWkxhjRg+OPqw3V3OvrLQpc9XlbVTLn
	 sStfTUH7W8KW0dWIOC4BzT1QY6zR2+uMW6X7ZhNkKOVAcGkoiIJbtYtabvU9GmUZeM
	 OwP3r32EzkUKzbR3YBnrFyY+F0kzZkvXL+I8YRUhYhn/Xu2aFpMZvspd/pCjgQ0rBT
	 DIucmk/xXeL7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: release a removed xattr node in roll-forward recovery
Date: Wed, 11 Nov 2026 13:21:35 -0500
Message-ID: <20261111182054.3675603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062411-failed-5.10-f5924de8867c@kernel.org>
References: <20261107062411-failed-5.10-f5924de8867c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit f5924de8867c09206ba631b9faed63862ec00a10 ]

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
[ sashal: adapted F2FS cache operations to the existing page-based APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1dddb65e249ad..fc1f0d3bf6ed7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2635,6 +2635,44 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
 	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
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
+								&ni);
+		if (err) {
+			f2fs_put_page(ipage, 1);
+			return err;
+		}
+
+		if (ni.blk_addr != NEW_ADDR &&
+		    !f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
+					   DATA_GENERIC_ENHANCE)) {
+			f2fs_err(sbi,
+				"nat entry is corrupted, run fsck to fix it, ino:%u, nid:%u, blkaddr:%u",
+				ni.ino, ni.nid, ni.blk_addr);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_put_page(ipage, 1);
+			return -EFSCORRUPTED;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		/* drop the cached xattr node, which may be dirty */
+		truncate_inode_pages_range(NODE_MAPPING(sbi),
+				F2FS_BLK_TO_BYTES((loff_t)ni.nid),
+				F2FS_BLK_TO_BYTES((loff_t)ni.nid + 1) - 1);
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ipage);
 	f2fs_put_page(ipage, 1);
 	return 0;
-- 
2.53.0

