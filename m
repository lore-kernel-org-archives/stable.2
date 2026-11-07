Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048602;
	b=FBN4t9oG+z12Cn28q0Eu2agQhNTFhtAkJtRciKzmYWCx/SlumZHMOb5tehe2klyiKSp3
	 wJHlWKu8ecs/wHRzMonHv0ncZJiR5aMxtkR+h2+eBH+N2KX3TrxFtsjAlGxZn5ksi+KFv
	 UuR1H4m9lRnaB5HVoBnLvSEWLOOFwVr/lWLImZQgIFyCdB96itlDwl7aQgPUDKOzK95sb
	 qx1BlOqY3m1Hpvc2I0navv1qrk4UYrOyLy7NLKPk9PHOTq7mvL7vH6a2nw6x6Y8hXOL3x
	 oSuAbLfuERgPrTZanbMyoyeK6Y60OCFnnKnxgPOvBTONwL+zG4L7LkcgSYOn9v9MDWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3LthrQFSH8pIEABd7g84qtvjAVHUGLL6pbR+sd9MO5o=;
	b=zmI7DR6hqriQ+B2X/EXoD7nxgD6QPbBeGRrQzFPClQcZxs64xDypSrrQnC8KyHKFOMOv
	 ZdmX4BGcVCkRGtawTpMUKS/7gaUvjoqmGNztFXUcY8SWDObEE4cd8z029ydtDmutp0ZX2
	 6LG6XrWf4SoPyXimN31JpKaYXS1A45u+5NG4d0cT+YIm9O6flljvCn79YZstFYCnzaySQ
	 vPYzg7iyWdk0XKFKMD0DC4LLNVLOAVdveK4sHpqrHn8t60KisGABYcBIPqAcsuKWRDFye
	 T0H+FdJCsN0u3TlLIEmqihUtT0fiUnYAb1nUY83cIMfG9D4fEqsO5DZpg4ODRRRSnlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0Z2FygM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F9606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0Z2FygM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CDE1F008A2;
	Sat,  7 Nov 2026 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048602;
	bh=3LthrQFSH8pIEABd7g84qtvjAVHUGLL6pbR+sd9MO5o=;
	h=From:To:Cc:Subject:Date;
	b=J0Z2FygM43G1EJvgjcUdBl0dZKsj0C9i2J/cI3lKw/ReuL6hwIvlye70TQ/j6pgKt
	 Fb1wVP4m8rKDY5BpS2zii/bbKMPCZQAmQT2VQluF+Ii/Gtdm9HXU17HIm/dA9VkV75
	 hM2ZlDxtRm1G7xW3JA2lAXqluCMJX9YL4j+DrmbKoDgTpkajdc7N4wavJWk8LtAGTV
	 eQyf4/UEVTpRfUcCZ6jtehJOVRCiHy8Il9xzeXzvOxymQVQ7kC9P+gJDe0/+JEU0CL
	 +dyGt+ZYeq20I9ZHPm6VfLT2heyocEoKrw0mXFMc+U6qO9ylvFJeGcBvSNoyBYqgXA
	 Ku0g/Q5HOh9og==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: release a removed xattr node in roll-forward recovery" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:50:00 -0500
Message-ID: <20261107055000-failed-6.1-f5924de8867c@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f5924de8867c09206ba631b9faed63862ec00a10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055000-failed-6.1-f5924de8867c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




