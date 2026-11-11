Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419072;
	b=FUQjGheVPno/y0lD84xP0mkE1FemAmh2YT7SxE28JC5ibpeHBQU+Pzzm8vEVdWIeXUVR
	 pUKA0eTBBc7OmjEzARklWN1tdm7HAVRZwQkIzxBWaSgx1dHrvfZ7bLqUO3g06qQEvsYIu
	 pdsXubPhPFFqilVBAtxkAY82VyJQnO7mHxNYcijQ72rJzZcXXEPiY3MxQskQSw+3Ngykw
	 O+AD+wDb41nsqNtcTBvOhbhVqPZvmTRC6nk8QjLE30RYk48MDQctPSg/av6L/ZPazT6PV
	 H+GeALq6/VdVA0iqIvQ2yA/ZxG+/wuc55LBL9SrarRGDiCHjd6CwB6Kuy0152//kx9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0c0pAzhYC3XfrKZgnkgVRS58rkn1ITP8HT7tc7mGJ44=;
	b=tExtsyGWHU2YSTHX82Qe8TVXIg00x8GE1Km63yYbtVRjOYbfJfUfwIPovE/JAe6lTuMX
	 fzR4N2Z0OPFySEVMz5YGP+1aS0mLS/2oVyMsvOELm2Cqfrq5o1+L+22s59+o4yB9Tp555
	 5c2VFUCmbwQ3ARr7n9oe1ckz3F3y30EaohEvxyIq2AkPuHI6W7FI57I8xqkjoijQ8MpOB
	 kaAZY2kyENk8fMW1xLz3MB5TsmZZBio6rgXt1cwuyft26Gc1Fq76/3Z/1IdmmuTc6ak2v
	 5wa+G90nnLG1x9BkPgtufODS2EQ4PX3DWtvHw1sKCCjVbiOaM5cPcxwI5aQ/pq7qhew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjDMhvYq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjDMhvYq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0286D1F00A06;
	Wed, 11 Nov 2026 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419072;
	bh=0c0pAzhYC3XfrKZgnkgVRS58rkn1ITP8HT7tc7mGJ44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FjDMhvYqhFleqJ+vsD8vVE0v7NPxBXVDHf3kVpAbqNqwRfFpJB1NnAmT6i2YirMuE
	 bDaFLCMVq95oePyyISk4+ksSJDP7JGAkPKvRtxg7JALBczcxaK0uguQEGXpUWSCG2t
	 6GVafz6V7/9CMLT+XNvfvvylbl+8jliUEOmYvmsPyFrAwFInSuef58IGqrXqnw3Hov
	 cKXcdvpLmpX304pPuvpiFZkk+phEy9xm1n9GTw4ovjun9hgjSSPr4K70azdikOIsZ6
	 kONrBsHOa5pO8qOCYVNc9Bf09g+OI2ZzVtQEmISLWRjXJfWKDherzPsAm0Cuy+ezGb
	 +6kBXOwh7LCiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: release a removed xattr node in roll-forward recovery
Date: Wed, 11 Nov 2026 12:44:30 -0500
Message-ID: <20261111174331.3601636-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060716-failed-5.15-f5924de8867c@kernel.org>
References: <20261107060716-failed-5.15-f5924de8867c@kernel.org>
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
[ sashal: adapted newer F2FS helpers to existing page-based APIs and legacy error handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e5a06a65a5398..2871a236e8fb5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2713,6 +2713,44 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
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

