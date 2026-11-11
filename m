Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417522;
	b=RnyX3ri+FuZ/UG+fqBgjB6cGfYS+gXfljnf6zA5bHvMNolH1EVyODt2ljEj2Gk4cHjCR
	 M8naOWke41OlyX0zKa562XKJOgN+voyUCd5by4n5omrD/pZudBSK0g0Rau9qDCOtAzLfR
	 Ju3Xw8ysZIrfnjVSdWH23/sdJdsySLy/cJ2ZMl10mPhPHMhL/O6o3v1eFRmFQd9ahE6Xl
	 QmHsIzfSUldkwgJBwn0r9ftsauqX5Scm9wNq76qsN3/0n4YR9RIBSvM6lPsMvj70QMcGy
	 oZX+oO43UgmnVkf8jDtUuww0n/SZkKny3eEvOdeFan17/6G4Qv+pM10Li1vfiZjoOeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417522;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mR4wbsXPZmMIqqMTGvsE9rw5EE8vN45O/IeKcFdGVTE=;
	b=dQstRTXwo+jbaOo9RfL+X5TOOsVr7PYo94wdx+YIIWJDGQFlbsogpemJZPZdZZzx6pyM
	 llbwX4jqvPjNlK202qifHKjqy0csiRUXb/bsOZ9KVIunWCnQ95SWeklo9sE2fCniAPX/Z
	 teIwUOF+dbUi7ByoZoQVNG3mSXzxGmBxa6Xt5sbAT2NuMT1PUtFswQoRZuAcktU6hIsDq
	 JaD28gjFzIRaPPRyWFtr9aFKQ9wP5QvgKj3pMO3Vd5v/PAdo3/mdVw4bRJY7xrJI+Jpwa
	 WhdTHRfOImHM+8+lsRtJnCvi64yOHIXxSazxu+Oc33g7c0EP2JUnSchWcvN2EE1/UfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OX3TJtFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B19606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OX3TJtFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EAC1F00A05;
	Wed, 11 Nov 2026 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417522;
	bh=mR4wbsXPZmMIqqMTGvsE9rw5EE8vN45O/IeKcFdGVTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OX3TJtFdd+nMUNzmz7ckNJxOhgQ6U8lpYbdSGOuPVqaZS/Jn3dNSRFSmc/1QSgzgI
	 3bXnFvFSpPMNpQ7WBPI+JnOp00Tb3TGeUqw5WKOdVvLJi77TUzSlb15Ws4UMIhHcuN
	 QqCYGobM4ug59VQ+ta9iE9rl7Q962zq18MBTORtUtINqPVUau2N2p77r31JbZLSfFR
	 XoxnoSXY4TVTSoAMBSuMG73gEUunlw/MaklwqNRRLLdG+CkHIsS4rnYX30O/uWe1gs
	 Gy33AfBkGsz233TVZCWTwneA+HMBHcFFNqOjiZRbybmV+A29ityW6Jg+47s8/O4YFK
	 qDf7SeC+Kgsdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: release a removed xattr node in roll-forward recovery
Date: Wed, 11 Nov 2026 12:18:40 -0500
Message-ID: <20261111171738.3482274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052314-failed-6.12-f5924de8867c@kernel.org>
References: <20261107052314-failed-6.12-f5924de8867c@kernel.org>
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
[ sashal: adapted upstream API calls to the existing page-based cache and single-block invalidation interfaces ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8a11623dbf1ef..0247720432778 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2767,6 +2767,45 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
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
+								&ni, false);
+		if (err) {
+			f2fs_put_page(ipage, 1);
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
+				F2FS_BLK_END_BYTES((loff_t)ni.nid));
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ipage);
 	f2fs_put_page(ipage, 1);
 	return 0;
-- 
2.53.0

