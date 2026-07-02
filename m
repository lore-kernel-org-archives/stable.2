Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05648033A
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997797; cv=none; b=OMI+pJxcpVt7+Rm/sNaRSWyJmIdX5SjDpyECDicnjdWg7e/ej0xxre+KcAWdzE8pGgD9ZN5lPJ6YsrvMPnQbs2lGktDKI8eRTFSUc0FtM1H6qbzx4qZ36jdnsZgUUygcmqPA1YQ4UbZXrbNql9vNlaWG5MvJFiLZgEYJlPM/lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997797; c=relaxed/simple;
	bh=jXssX1Mi/0b+gzzZ2JzZXfsun8BPgZ8T5oqF6bX6fRQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sTcSCm7y439Py8/E9YrlLW6XjJDDFeZUD5+qVktiqYxyrlndCGCWSfpPDfZ4Y79/bMJ/NPHbY5KjpGZMR96cFgJoqXpDTAtFOQNHjbWqKZeX6jE+uQpvtQ2T3jbfPt2xplNQnodB+wYpVI0WZzsKwWH4X1N8jisbIveNFJpZCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WIocm79+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WIocm79+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC521F000E9;
	Thu,  2 Jul 2026 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997795;
	bh=ZTFY6JvEwKAi6KI4TCp5itUuD5h+4178wVOEyNLMoZo=;
	h=Subject:To:Cc:From:Date;
	b=WIocm79+E1ba3Gbbas0YeB9Z4iqT2qB0Pro3v5u+IlvVbo8j4omWEVmMSATXKSNMr
	 /sqnB/pp4TTddq2jJcOo1hi6OM+CBICI+Vdni8ogfSxiyzREc8B0pFIBo8UxxtrslS
	 g3SB5dA33lTmwJwHoodrCiwoeUzZKm4G1kUID8sc=
Subject: FAILED: patch "[PATCH] f2fs: bound i_inline_xattr_size for non-inline-xattr inodes" failed to apply to 6.18-stable tree
To: hexlabsecurity@proton.me,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:10:05 +0200
Message-ID: <2026070205-tattoo-circling-7d61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 378acf3cf19b6af6cba55e8dd1154c4e1504bae8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070205-tattoo-circling-7d61@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 378acf3cf19b6af6cba55e8dd1154c4e1504bae8 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 11 Jun 2026 23:00:36 -0500
Subject: [PATCH] f2fs: bound i_inline_xattr_size for non-inline-xattr inodes

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

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 25f30b8eadc5..c95e0b126da4 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -325,9 +325,9 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 	}
 
 	if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
-		f2fs_has_inline_xattr(inode) &&
-		(fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE ||
-		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
+		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE ||
+		(f2fs_has_inline_xattr(inode) &&
+		fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE))) {
 		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
 			  __func__, inode->i_ino, fi->i_inline_xattr_size,
 			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);

