Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048320;
	b=xDsrqsLHCwDU+j6nX9C/WykDgXd5qqePnHABPgjBR5xWS/ZFVSR7WweOQY+Lf4GwNspb
	 //K42tB6uwLwON9SnqAwwChbOqTYU+SSXpOs1k1lRmxPspIp3IffUNTy+unzlNGNuu+Om
	 PIWpqOGOET+Emya+6okciNQj2dVFXYoFkEkPNHg3ZSDU1EGwYowJlY8FWTMU5FSopzzB2
	 5vwr+e2pcTx+pUoJ2vU2x8FDtlngT8uE0CDxBMtiCHh4mmmasggG7dMnwdu32W07WFhOa
	 xryQtJoyjtlQOPBl+SGbW4Cl05ZjJzii9qOOjQOlGJJjBxJlaUD6lRM0jasUW7SLxuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tBGEtT3l+B1Kqq1OhSCxBEkxSRIPPQYCwinfZnoQmXM=;
	b=FCDOme3rpxKwUetWCssgDtiOc9rZ6ZDFb2d+BwfoP+WES06eqo2g+OplI3KTMrG4j/AJ
	 47zuGN2n3LaPrwr1gnpnIlsmneyvTFrPtmX5Nd9MSphxTp5hwMU6fU6eGFAP6jXwsvuLf
	 N/Lbv8iyeclRj5StniEhtMijoP0dOuef49wTnsPOLugpUVuAJ5ELi28V6zSDElAyI7TIC
	 Z0svK7oHBjnWZ6V0FHB2N4f8cns8jmASXPFxLupyHCyGoz4zpBSfhu9zDWXiwVyE0PwCi
	 TECTH5j5jHMEY4xJoGqY8GzF+y3U9eItuSibczhLQChCkwaswWMA3wgcFIkV7Kv6Zww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9QAaa0q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C459606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9QAaa0q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBC61F0089F;
	Sat,  7 Nov 2026 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048320;
	bh=tBGEtT3l+B1Kqq1OhSCxBEkxSRIPPQYCwinfZnoQmXM=;
	h=From:To:Cc:Subject:Date;
	b=R9QAaa0qYuyTCbVF1dyoy8pSQnYrtQ2uWHqsjrwBJgLc3Nie8OVYG7b+zzZUsG7v4
	 TKHYVhl7TTjLsW8t6gAvXBNzsT9oO12UJDN+8ivfOzGuYCA8qW68CtrPlsrY6jXYF8
	 1b43VdYcm2deTOXGx4Rg65UMw3PC7yZgyThl1WjPr4/yGmhjXDwfkUt704AnpEN+cV
	 cVWBKx3/JtS8vmjDkWL12oNtFMxfe8AZl+Mqf6sNQdhCtWk2XXszuM7MQdUUkqb7+P
	 zyMOuoGUhlIJuE2W55slZCQ+OL4jL5KoxA6AuCXh4s2iPgk27BjFqLa5kTydjyyWUZ
	 no9B3n5+h6QzQ==
From: Sasha Levin <sashal@kernel.org>
To: joseph.qi@linux.alibaba.com,
	akpm@linux-foundation.org,
	gechangwei@live.cn,
	heming.zhao@suse.com,
	jlbec@evilplan.org,
	piaojun@huawei.com,
	junxiao.bi@oracle.com,
	mark@fasheh.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ocfs2: restrict OCFS2_INVALID_SLOT suballoc slot to system inodes" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:17 -0500
Message-ID: <20261107054517-failed-6.1-25bf9e549360@kernel.org>
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
git cherry-pick -x 25bf9e549360b656a6763232e0e9e58a00c3aff7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054517-failed-6.1-25bf9e549360@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 25bf9e549360b656a6763232e0e9e58a00c3aff7 Mon Sep 17 00:00:00 2001
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Date: Tue, 1 Sep 2026 20:52:18 +0800
Subject: [PATCH] ocfs2: restrict OCFS2_INVALID_SLOT suballoc slot to system
 inodes

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
---
 fs/ocfs2/inode.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 180107a11046c..9228d6ef23c24 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -638,14 +638,18 @@ static int ocfs2_read_locked_inode(struct inode *inode,
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
@@ -1520,8 +1524,23 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
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




