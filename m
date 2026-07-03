Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05ED34F270
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087779; cv=none; b=KLTp1Tus5km+RQNZqMQJqTQVYUi51k+dg//+XWWtfyaYzPwaJL8PjRRd9IB5hwZ9m6uetyYv2Sqzn2ctoz0S2+MG+8/9uJzbmly6kZjNq884iRwLQNrVCsleq6Qy+Dx7UMw2t0d0zMdctICnFbyuXePBAIbpasyg1pQ+ut4XBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087779; c=relaxed/simple;
	bh=JIjw4BcPDDEBdk7dnObLb6u3MuShdNJLj1HvXx9GqJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSmCG4ayZjnxlBxxUlJ0ZGFU6Z8EGV1HpVEQl8EzuKK6Dy9OYN9yHs3Qnxv+No1BuIPT3DLJ328+KUqNEYEE2yxyF0xW4pluaMzvPfL1AGv+j5Q7+KW/UITojqIpb3rkZhUfjGUu/1E9k2zXvv/BzJnhWS3NHO0Jpgjei39/si0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZy76w8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZy76w8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25B81F000E9;
	Fri,  3 Jul 2026 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087777;
	bh=V6S2cQ8cQs03vQyemoqkIaF+YbM1OZ904N49hXuGajQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IZy76w8XHj+4Rza+9MRcF26Di3akDa8yRpCniAjAPlEbz4Yow+V8YfkC5QCK/fWNe
	 vYRkHgNQiY4qfNEKbqbVQdo3QB3RJqCLkPO+BpW4f5264cNWs6kiC/TsIYpRfqHqbW
	 pDXotIzqdSs6ncFsUqIT8ExSNr2B2htIbJploCbiAxJxNSnaK3J5KpnGaUpjkwjc3q
	 3jAcjFFYc01w+eGfoQL+PY54a6SpCjDevVTyaDS915budC4gbg+FaYR9u9lHoue1HY
	 kr0yuZ+jK9qyHMdnvA2vVGJvhak/e+pAjkzbXWnAAewrnF0EPaJvPZYenEf1Zm/JUl
	 Q0wbFoxaBpqAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: bound i_inline_xattr_size for non-inline-xattr inodes
Date: Fri,  3 Jul 2026 10:09:34 -0400
Message-ID: <20260703140934.18093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070205-tattoo-circling-7d61@gregkh>
References: <2026070205-tattoo-circling-7d61@gregkh>
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
 fs/f2fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 49470f4c9362a0..1caa84c15c9969 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -318,9 +318,9 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 	}
 
 	if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
-		f2fs_has_inline_xattr(inode) &&
-		(fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE ||
-		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
+		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE ||
+		(f2fs_has_inline_xattr(inode) &&
+		fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE))) {
 		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
 			  __func__, inode->i_ino, fi->i_inline_xattr_size,
 			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
-- 
2.53.0

