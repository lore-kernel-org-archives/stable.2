Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045905;
	b=xivi+tf4RBKTbs/7D6n/BglaqYf6kro7qAk87cc4lpqq6+lxpCm2BkFHu9EfnW44Xu0s
	 zCG2x+W80hduRwC3ZkQcUymWpx+4G3DruNacDFsLqDSOQnsqHowjGbBJKKGJnrtQxm8rW
	 HC89qKCyj9fo/omZAQKYqRUcvi42XCEKpPqPZKD6LVKHOsjN6SPZYIlUO8M0gcmnDZSQX
	 pWINCmfCHCIH0L6EqO7bQY2O9vgW2MIAV9VVVdb1ZA60YkgAQRXF7Aa1VqHFgXzUvNNA7
	 9DiLPxJkHXdtCPJu7TlLPhU5BN30ERG+mjrj0ni60a+SoGKT3zoWFnX5+cCo7Xq5abA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045905;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q+k+WNDYKu/fCzxH6+9AuG7lQCwgpBKjfQSs3IDNYB0=;
	b=HQmlPRxN7hRjtaqRDc9IuQbVLMhcEzsi169soKOraAR9kY1JG3AZCXeENaPqeAteOWBv
	 JoEMozCD5suHiNgCEdK35hmi96h/VHu4r5mOV6WUTztJjwZFGAycRxA1RHez5W2bOoWXf
	 /qShBSa/aGxJKXFR5THRxtFL8YAz7dFWghO30ECPdo4xxTBp69r1MBv+UB1HSwKTfCIT7
	 BjsQkW1oz3XknKwbMvpsXk+XBSiTTzsjF1EOiUA5piKLE/7dpCQrTMJK1eHCqNWihamZV
	 Yj7bRgSd+hUHlQDuuMigCYT9yPyu10Fow4utd+NQBH9IRlvT8im0h34bHvGLM/o9I2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gulJuRdR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE982606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gulJuRdR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0BE1F0089F;
	Sat,  7 Nov 2026 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045904;
	bh=q+k+WNDYKu/fCzxH6+9AuG7lQCwgpBKjfQSs3IDNYB0=;
	h=From:To:Cc:Subject:Date;
	b=gulJuRdRg2NJLt8AO7JIkZl4dnVdhGC4s8G/6i05l/ayNFKrFesRGAbud70ew7FY1
	 +yhuo0yCyKg0sGNJjZZGeWkmjSPvLCbg+Ex8Xvj7LMxDUvnimGMQn1o0ZafkD1atXW
	 SALT4ehDEECI0iu6NQqZg0eL1NzHFsDKI10ZeJ69DAXCWvYtw0QjYnnH85Cl+cL9e5
	 GeqPyBMGuaTD76w5cH/XPwpL+QtRQ/iy1HpY3uxMirCemE/vZgLj+IZ45j6/L9tgg0
	 5zS2oF/e2YMVYRqaUOmCZC87ftLMcT7/emoCXkCNVpR1yWTeoDhM9KWEB5Kj8kk+7T
	 nj9D8w6Oqo4Rg==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: release a removed xattr node in roll-forward recovery" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:03 -0500
Message-ID: <20261107050503-failed-7.3-f5924de8867c@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x f5924de8867c09206ba631b9faed63862ec00a10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050503-failed-7.3-f5924de8867c@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




