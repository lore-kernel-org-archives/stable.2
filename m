Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314098;
	b=ii6/w69YPZ6pqzz4Cf5YNlVg/XvpP0Y6tjp0beZBgF2ztiD8Aw95gxCDN//qb4Lfir6P
	 wuI7P7gBJIkEkxGI4t5c6FL+xY3vEGwJ+Dz5hU4ZXcnm9jcPZ/lQCZrhbyblWxG6IvY77
	 ZB29W6+1mliYGV1gif6QRqKsWg100Palp3j2FAB2IoqSE46ZN8aeyshoKF+8L4JA19UV4
	 89GUZ4qIcb83eCiB++5uNqvDOLIy45WzUX7EH5NdstzhVTyqHvWCzSajLcbRwr2joSEB8
	 J5VtCiaZlCcAA+opqiJoGBxPQleuzD/0qdJvnUTSsa8e+3hhE9MULbXYAhKIb3LbiNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hx/v47Ry1psqZsCHBHEiyDh3M2dWr71QHmItWBdV6bg=;
	b=Zt2stV1TOFt+WU6FbqO4FWtEDBz4a32VmopVbG3hrY3yIsQza4p5apGkk2V+txpLINWL
	 gsCpI7Ct4Aqk8kkqUgxxpmEmQBHJlBugBX9aN8RZiCwdtrrtAklXZ/HrEPEwuX4ZrtPiR
	 qhqZV/oOrDcHxvoew9pR7T9jXP6nCTYle3apcM/TOh+aJryO5LXAxf7u5sbrhNDq+mYrl
	 iP9B/9ZTic7XFX1k3sHtVeoeJeNkXQRMmmb9M+JTHJycwXCBS8W0CnpiL7lzm9arwY04R
	 sakjYXDOOxuvQfMFxG5nOiCVUW3sngaVxg898X0SYfdwlXutpq0PHgTj3S+wfZVvN0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9eWwi8R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFF606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9eWwi8R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C4D1F0089F;
	Tue, 10 Nov 2026 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314097;
	bh=Hx/v47Ry1psqZsCHBHEiyDh3M2dWr71QHmItWBdV6bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d9eWwi8RVLjIMiyYpJxAOb0INFKgQDOObFlwbrQfRDzpkJ2GhHFoYOWy9co7DkKgL
	 2o7xy5Nm/o+HunH2awoYZ+PURJX3p9Md6rxXu1GahZ9zSfd/lnvE3BeW4f3Gh/+qPh
	 JMP/9lHwH1XIXEQHSk+WUX0QSPVPr8tX1IxFxzHBdY51J27hwL7ccIQ77VrLatNlZ8
	 UY08SLO+81kn/NgERu0zcOvSOgMwJWYXhAIegIfz+rEhTbGE7ccsO2pgk6rSoCClLf
	 WiTDYW1klHp2A49p8dZAuwpvtYUD2FKzntInddhMK/tGHnxXnjMjoEKH0bXXAyaK7c
	 fPxpJyuJdrPbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changwei Ge <gechangwei@live.cn>,
	Heming Zhao <heming.zhao@suse.com>,
	Joel Becker <jlbec@evilplan.org>,
	Jun Piao <piaojun@huawei.com>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Mark Fasheh <mark@fasheh.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ocfs2: restrict OCFS2_INVALID_SLOT suballoc slot to system inodes
Date: Tue, 10 Nov 2026 07:34:55 -0500
Message-ID: <20261110123434.1291399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054517-failed-6.1-25bf9e549360@kernel.org>
References: <20261107054517-failed-6.1-25bf9e549360@kernel.org>
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

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit 25bf9e549360b656a6763232e0e9e58a00c3aff7 ]

Patch series "ocfs2: validate suballoc slot and bit of metadata blocks", v3.

The ocfs2 metadata validators trust the on-disk suballoc slot and bit
without checking them against the slot range of the mounted filesystem and
the capacity of the block group bitmap.  A corrupted image can carry
OCFS2_INVALID_SLOT or another out-of-range slot, or a suballoc bit beyond
the bitmap, and once the corresponding inode, extent block, xattr block,
dir index root or refcount block gets freed, the bad value goes straight
into ocfs2_get_system_file_inode() or _ocfs2_free_suballoc_bits() and hits
a BUG_ON() or runs off the end of local_system_inodes[].

This series rejects such values at read time, in the existing validators,
so corrupted objects fail with -EROFS (and a read-only remount) instead of
crashing:

  patch 1 restricts OCFS2_INVALID_SLOT dinodes to system inodes,
        completing fe7a283b3916 ("ocfs2: add suballoc slot check in
        ocfs2_validate_inode_block()"), and turns the "system file
        state is ambiguous" BUG_ON() in ocfs2_read_locked_inode() into
        an ocfs2_error();
  patch 2 rejects oversized dinode suballoc bits;
  patch 3 validates the suballoc slot and bit of xattr and dir index
        blocks;
  patch 4 validates the suballoc slot and bit of extent and refcount
        blocks.

The checks only enforce what the kernel and mkfs.ocfs2 already write: a
valid slot from meta_ac->ac_alloc_slot and a bit within the block group
bitmap, with system inodes carrying OCFS2_INVALID_SLOT plus
OCFS2_SYSTEM_FL and extent blocks using slot 0.  Nothing changes for
healthy filesystems.

Each new check was exercised under QEMU by corrupting the field in
question with an out-of-range value; with the series applied the access
fails with -EROFS and the filesystem remounts read-only instead of hitting
the BUG_ON().

This patch (of 4):

ocfs2_validate_inode_block() currently permits i_suballoc_slot to be
OCFS2_INVALID_SLOT for any dinode.  Only system inodes created by
mkfs.ocfs2 are allocated from the global allocator and thus legitimately
carry this value; regular inodes are always allocated from a per-slot
suballocator and hence must have a valid slot.

If a corrupted regular inode with OCFS2_INVALID_SLOT is accepted,
ocfs2_remove_inode() will pass the slot to ocfs2_get_system_file_inode()
and get_local_system_inode() will hit BUG_ON(slot == OCFS2_INVALID_SLOT)
when the inode is deleted.  This can be triggered by an unprivileged user
unlinking such a corrupted file.

Reject OCFS2_INVALID_SLOT for non-system dinodes during validation, while
still accepting it for system inodes.  Note that a crafted dinode carrying
OCFS2_SYSTEM_FL passes the check above, yet a plain lookup of it still
used to BUG() in ocfs2_read_locked_inode() ("system file state is
ambiguous").  Since i_flags comes from disk, handle that mismatch with
ocfs2_error() instead of BUG_ON() as well.

Link: https://lore.kernel.org/20260901125221.1634686-1-joseph.qi@linux.alibaba.com
Link: https://lore.kernel.org/20260901125221.1634686-2-joseph.qi@linux.alibaba.com
Fixes: fe7a283b3916 ("ocfs2: add suballoc slot check in ocfs2_validate_inode_block()")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: <stable@vger.kernel.org>
[ sashal: adjusted context in ocfs2_validate_inode_block() to match the preceding validation block ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/inode.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 3d96cc7fc5070..e370efeb70dc1 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -575,14 +575,18 @@ static int ocfs2_read_locked_inode(struct inode *inode,
 	fe = (struct ocfs2_dinode *) bh->b_data;
 
 	/*
-	 * This is a code bug. Right now the caller needs to
-	 * understand whether it is asking for a system file inode or
-	 * not so the proper lock names can be built.
+	 * The caller must know whether it is asking for a system file inode
+	 * or not so the proper lock names can be built.  Since i_flags comes
+	 * from disk, a mismatch is filesystem corruption instead of a code
+	 * bug, so handle it with ocfs2_error() rather than BUG_ON().
 	 */
-	mlog_bug_on_msg(!!(fe->i_flags & cpu_to_le32(OCFS2_SYSTEM_FL)) !=
-			!!(args->fi_flags & OCFS2_FI_FLAG_SYSFILE),
-			"Inode %llu: system file state is ambiguous\n",
-			(unsigned long long)args->fi_blkno);
+	if (!!(fe->i_flags & cpu_to_le32(OCFS2_SYSTEM_FL)) !=
+	    !!(args->fi_flags & OCFS2_FI_FLAG_SYSFILE)) {
+		status = ocfs2_error(osb->sb,
+				     "Inode %llu: system file state is ambiguous\n",
+				     (unsigned long long)args->fi_blkno);
+		goto bail;
+	}
 
 	if (S_ISCHR(le16_to_cpu(fe->i_mode)) ||
 	    S_ISBLK(le16_to_cpu(fe->i_mode)))
@@ -1579,8 +1583,23 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		}
 	}
 
-	if (le16_to_cpu(di->i_suballoc_slot) != (u16)OCFS2_INVALID_SLOT &&
-	    (u32)le16_to_cpu(di->i_suballoc_slot) > OCFS2_SB(sb)->max_slots - 1) {
+	/*
+	 * Only system inodes created by mkfs.ocfs2 are allocated from the
+	 * global allocator and thus legitimately carry OCFS2_INVALID_SLOT.
+	 * Regular inodes are always allocated from a per-slot suballocator.
+	 * If a regular inode with OCFS2_INVALID_SLOT was accepted here,
+	 * deleting it would pass the slot to get_local_system_inode() via
+	 * ocfs2_remove_inode() and trigger BUG_ON(slot == OCFS2_INVALID_SLOT).
+	 */
+	if (le16_to_cpu(di->i_suballoc_slot) == (u16)OCFS2_INVALID_SLOT) {
+		if (!(le32_to_cpu(di->i_flags) & OCFS2_SYSTEM_FL)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode %llu: suballoc slot %u for non-system inode\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(di->i_suballoc_slot));
+			goto bail;
+		}
+	} else if ((u32)le16_to_cpu(di->i_suballoc_slot) > OCFS2_SB(sb)->max_slots - 1) {
 		rc = ocfs2_error(sb, "Invalid dinode %llu: suballoc slot %u\n",
 				 (unsigned long long)bh->b_blocknr,
 				 le16_to_cpu(di->i_suballoc_slot));
-- 
2.53.0

