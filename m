Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3FF3C98BE
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088799; cv=none; b=fgxa5AXEjjYhrX95jAsrAQ9Y7XG2suzK7VDCItg2RrD7j9Q2eNSpjVVOSQhvuRXwvWPsg+Zbwp2raiV1EXJQ1wa8tsW8oLnkr7CR0DRtRzD0dzEUCkNV6LrrihkBttx7s9qPAbOpJiKJTQ5JvAmv04YgOzpdVfTzlr0M0JozL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088799; c=relaxed/simple;
	bh=EkKsTHz1KV+GqhBNEWUqcEYBX2n7F4i8vzIumM9ba30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTXMpN/p68xWg0Gfg3HpSjSNb8cod9EFt3iwGFMYXOz3k3uC0bunUwz/Wt1FPbhjUMEfGc13BjK8rOA0NtYjVRRLBq5or1zJ55DswjCW6kPmKABf/IrAr7O4foYiUviKx84TisJ4m9Su13Cr7PykW53wGkmdPGn5I7Lw4LQW7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6KtatC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6KtatC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845CE1F000E9;
	Fri,  3 Jul 2026 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088798;
	bh=uAbotocb4cFWLP+C3w5016YzHxjF9ItY0gzMjhnOdBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F6KtatC+ir/b/1UiFA82/1Ucc7cU//W6xd+89oleY+o2pwl8/y7i/+uIlXBGHkiAT
	 gfQVJe6ABXxDhkzcC3vyno2Denxl8au6MtlJRiPKtwIyZNPY3MDUSsnE4qsMq5nmb4
	 dXvwcmsqNKB6H3Eb0BRqM1kPZOfC0RQgiNYZFfHMpluoDhgrfAbD8wHcaRpUFBJk7v
	 uir6hA/whguoJ/4/LQ0wCWkr2PS5tZkYWL7fvjTq2Aae2cOVYVS7nfH7vA90vw1gTD
	 R4MpEOYNzvlpP6fSgqNJba+Crn/9CZ7WjUoDePA7bcYsFTDbmOMtdldWWob6RN4K9U
	 omNJOKGQaqI3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: bound i_inline_xattr_size for non-inline-xattr inodes
Date: Fri,  3 Jul 2026 10:26:35 -0400
Message-ID: <20260703142635.55675-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070206-smell-prewashed-02ec@gregkh>
References: <2026070206-smell-prewashed-02ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 378acf3cf19b6af6cba55e8dd1154c4e1504bae8 ]

When the flexible_inline_xattr feature is enabled, do_read_inode() loads
the on-disk i_inline_xattr_size unconditionally:

	if (f2fs_sb_has_flexible_inline_xattr(sbi))
		fi->i_inline_xattr_size = le16_to_cpu(ri->i_inline_xattr_size);

but sanity_check_inode() only range-checks it when the inode also has the
FI_INLINE_XATTR flag set.  An inode that carries an inline dentry or inline
data but not FI_INLINE_XATTR -- the normal layout for an inline
directory -- therefore keeps a fully attacker-controlled
i_inline_xattr_size from a crafted image.

get_inline_xattr_addrs() returns that value with no flag gating, so it
feeds the inode geometry:

	MAX_INLINE_DATA()  = 4 * (CUR_ADDRS_PER_INODE - i_inline_xattr_size - 1)
	NR_INLINE_DENTRY() = MAX_INLINE_DATA() * BITS_PER_BYTE / (...)
	addrs_per_page()   = CUR_ADDRS_PER_INODE - i_inline_xattr_size

A large i_inline_xattr_size drives MAX_INLINE_DATA() and NR_INLINE_DENTRY()
negative, so make_dentry_ptr_inline() sets d->max (int) to a negative
value.  The inline directory walk then compares an unsigned long bit_pos
against that negative d->max, which is promoted to a huge unsigned bound,
and reads far past the inline area:

	while (bit_pos < d->max)		/* fs/f2fs/dir.c */
		... test_bit_le(bit_pos, d->bitmap) / d->dentry[bit_pos] ...

Mounting a crafted image and reading such a directory triggers an
out-of-bounds read in f2fs_fill_dentries(); the same underflow also
corrupts ADDRS_PER_INODE for regular files.

Validate i_inline_xattr_size against MAX_INLINE_XATTR_SIZE whenever the
flexible_inline_xattr feature is enabled -- i.e. whenever the value is
loaded from disk and consumed -- and keep the lower MIN_INLINE_XATTR_SIZE
bound gated on inodes that actually carry an inline xattr, so legitimate
inodes with i_inline_xattr_size == 0 are still accepted.

Cc: stable@vger.kernel.org
Fixes: 6afc662e68b5 ("f2fs: support flexible inline xattr size")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9180693b933f83..536ed199317d07 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -308,15 +308,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
 			return false;
 		}
-		if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
-			f2fs_has_inline_xattr(inode) &&
-			(!fi->i_inline_xattr_size ||
-			fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %lu",
-				  __func__, inode->i_ino, fi->i_inline_xattr_size,
-				  MAX_INLINE_XATTR_SIZE);
-			return false;
-		}
 		if (f2fs_sb_has_compression(sbi) &&
 			fi->i_flags & F2FS_COMPR_FL &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
@@ -326,6 +317,16 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
+	if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
+		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE ||
+		(f2fs_has_inline_xattr(inode) &&
+		fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE))) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
+			  __func__, inode->i_ino, fi->i_inline_xattr_size,
+			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
+		return false;
+	}
+
 	if (!f2fs_sb_has_extra_attr(sbi)) {
 		if (f2fs_sb_has_project_quota(sbi)) {
 			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
-- 
2.53.0

