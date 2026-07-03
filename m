Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2DA29ACF6
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103062; cv=none; b=THr0iU8s4gB0+lFbIU3ivLPJosRDJtA6y8CYZECGIvMUnEeb5mrDJ/Ww2n5xKdU6iQWqshziC8dCy41fRgjCFGZy1kiaml2fWiZ+XOM9dF8MRs3xwuX6EfEMVO9x6D3N+/K51ixECPOa+MMDrqQtW8w3AB4HCAbzDqxQfgScK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103062; c=relaxed/simple;
	bh=T2SjdtpSPSQkEL13s5Bqv8uMyFXy9mQdO/wK3sIa2ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4rc67Bk0pa7F56CccIKFuozPxEbWPD7lgJcNEY6bi5MCBy1WhMxMsvzTehO+oO/NeeNBf2vC2606RqXADMXqT5K2R2VKyQgE5R9J7wNcMLF8w9yIpwooNW3XrNrWUd6Ay47u5NJ7kE4rdeyiiIq5TgaoK9H78h4I/iUN/zjPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKAZyRdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKAZyRdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E58C1F000E9;
	Fri,  3 Jul 2026 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103060;
	bh=y3SqlYhXWyD27oHWhY61odeipXuJYPieQntFTDmCX8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKAZyRdGEakJMzk6cqnDnK5RCblmqEhaOdo+u85UWZLXH52/LrlWJxZ2C+T3lH2Qj
	 JA8IQBjQ9R/Zm8qx9/sRyb/0FpPHMFzQ9QWwOgti6F51AWtwO+obH6x+re9w/a+bZ/
	 mcu2RqB/aVV6MGMPnMN8N5FBBMRJWaB6CbmpLs4c2GJexXtE7UMewzlPDTrs38HY+N
	 r7EmZCbtTiXSEM4YYoEUokgcVbbiKriSKCHwQ+J3r1w+zw1NWRDWvyzwxyUJBVs6vS
	 HVOeLyLapnpJJq411/CCjZPsLqK7AEAD0g/yJ+6VMyqIcDuOPgs6NPVIuqZl2+71xu
	 I322hdZTD1m4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: bound i_inline_xattr_size for non-inline-xattr inodes
Date: Fri,  3 Jul 2026 14:24:18 -0400
Message-ID: <20260703182418.254897-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070207-duke-grinch-4c91@gregkh>
References: <2026070207-duke-grinch-4c91@gregkh>
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
 fs/f2fs/inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 96d4f15cf79116..9ed052ddc0112a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -242,14 +242,15 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
-	if (f2fs_has_extra_attr(inode) &&
-		f2fs_sb_has_flexible_inline_xattr(sbi) &&
-		f2fs_has_inline_xattr(inode) &&
-		(!fi->i_inline_xattr_size ||
-		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
+	if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
+		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE ||
+		(f2fs_has_inline_xattr(inode) &&
+		fi->i_inline_xattr_size <
+			sizeof(struct f2fs_xattr_header) / sizeof(__le32)))) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %zu",
 			  __func__, inode->i_ino, fi->i_inline_xattr_size,
+			  sizeof(struct f2fs_xattr_header) / sizeof(__le32),
 			  MAX_INLINE_XATTR_SIZE);
 		return false;
 	}
-- 
2.53.0

