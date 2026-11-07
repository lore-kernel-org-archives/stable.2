Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047578;
	b=qtqFGkUhGikvZq3ZDT/AfxTbbeH3areWVN2R3fS8EUVv28UNF58YOhhyCCwRWXYnuGqH
	 9rRE92tTUOBvUc9qViLBpguINd6oXIMhXYV2DbWA2qvP512Jjs72RC9hlhmgF7R+oS4HN
	 0i/je620OAnZg6+M9McOTXXcxIaUyWgDh0hMmAirKLFxHOnEXGIXTkZOqjk9NJTyDZ65d
	 5ad61GIHCxtBh94bN8CoRZcQwzLmS6Ebw+b4ceqgIzPPkYOxgxu/g5FmTcQDN2TnJ1VC0
	 6OLlOUIfbY9SW8Zj2J0dlU2+sLGEEI8oEexZclHDXWBZwkqB9qty+X7N3kSyaVVt6fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047578;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EuJkJbtJQLq+NjD5uhfVZVpJ+uP2xn2lnISJqNI3Qao=;
	b=45xAKS8FzaX8yrkMiRQHNaEVZilBDqMDMYOw8u6untvEE47k4M5Za4KQz2CjYbrY3iaI
	 52n4z0bvNik7IkEwMDNMemLYQs5j9QcWPjhblyb5nz6Oi7Laz6guzhm+vqFekXvcti/l7
	 3eaIgcqFovUY7t/oQb1IIbWHxWl1kjdKGlTtFJq2NYcSI4UjvK3XgKApZWvwCtavZzIU1
	 zQk/wu6Pp5KH90JmS9R1siiubcAGpDzH8DoXS3QV2aYa/CHMQi3OUtKmK3UEucaJSUYvH
	 hR+1LBgTq3N7IxVi9FiPNqgAj8jUq1LnreurlwqOT2xqjsrvmWtz/FsDk3jQpifh54Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2BFVAAH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE48606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2BFVAAH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF41F0089F;
	Sat,  7 Nov 2026 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047577;
	bh=EuJkJbtJQLq+NjD5uhfVZVpJ+uP2xn2lnISJqNI3Qao=;
	h=From:To:Cc:Subject:Date;
	b=C2BFVAAHjJWof4cso6kJ6tx+jJU+/iPRgmkCtx7iEs7gAgkfEeiGLamRKbfjmicem
	 04F6stTWHAd5IF4tY7ov6fIef4d589VRAbi5J4LFltUdDyJ+/38F1jjjwxkOMkiGLJ
	 4wsKPAHEEj2Kuw5LIVDg8KogLqkmEK3fHOBIHRfVkA55Zpa0wth4AL3MNyTUuC/e85
	 EbEgMeIkWrcLj1tCTUwCFoaVQm+xNti0wYuWx3ITm3ZhOUuwex+1lcFzLjA2ld5EsK
	 4TheaEmuetXw4sBljbmktFbahdfJdaLwFdR2zHR4NEd6fcg1OoX0Qu+VhH+4gSkpFZ
	 +DVTpCRvKkXcw==
From: Sasha Levin <sashal@kernel.org>
To: southampton.jake.labelle@gmail.com,
	konishi.ryusuke@gmail.com,
	slava@dubeyko.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nilfs2: validate directory position after llseek in readdir" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:55 -0500
Message-ID: <20261107053255-failed-6.6-de7f49c12566@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x de7f49c12566cc5c7437a2f26c6c754b9d4d5648
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053255-failed-6.6-de7f49c12566@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From de7f49c12566cc5c7437a2f26c6c754b9d4d5648 Mon Sep 17 00:00:00 2001
From: Jake Labelle <southampton.jake.labelle@gmail.com>
Date: Thu, 8 Oct 2026 20:52:48 +0900
Subject: [PATCH] nilfs2: validate directory position after llseek in readdir

nilfs_readdir() uses ctx->pos, which userspace can set to an arbitrary
value via llseek, as an offset into the directory folio and parses
whatever bytes sit there as a directory entry.  A position pointing
into the middle of an entry -- or at unused bytes of a corrupted image
that the page validator never inspected -- makes dir_emit() copy up to
255 (name_len) bytes from a bogus entry, possibly reading past the end
of the folio and returning unrelated memory contents to userspace.

Snap unaligned positions onto a valid entry boundary by walking the
rec_len chain from the chunk start before parsing, as ext2 does in
ext2_validate_entry().

[ryusuke: fixed offset wrap-around in nilfs_validate_entry() and
 conformed AI tag to guidelines]

Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
Assisted-by: Claude:claude-mythos-5
Signed-off-by: Jake Labelle <southampton.jake.labelle@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/nilfs2/dir.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 8b53802b6ebd7..7686ca9228fc8 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -231,11 +231,27 @@ static struct nilfs_dir_entry *nilfs_next_entry(struct nilfs_dir_entry *p)
 					  nilfs_rec_len_from_disk(p->rec_len));
 }
 
+static inline unsigned int
+nilfs_validate_entry(char *base, unsigned int offset, unsigned int mask)
+{
+	struct nilfs_dir_entry *de = (struct nilfs_dir_entry *)(base + offset);
+	struct nilfs_dir_entry *p =
+		(struct nilfs_dir_entry *)(base + (offset & mask));
+
+	while ((char *)p < (char *)de) {
+		if (p->rec_len == 0)
+			break;
+		p = nilfs_next_entry(p);
+	}
+	return (char *)p - base;
+}
+
 static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	loff_t pos = ctx->pos;
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
+	unsigned int chunk_size = nilfs_chunk_size(inode);
 	unsigned int offset = pos & ~PAGE_MASK;
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
@@ -254,6 +270,24 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 			ctx->pos += PAGE_SIZE - offset;
 			return -EIO;
 		}
+		/*
+		 * ctx->pos comes from userspace via llseek and may point
+		 * into the middle of an entry -- or at unvalidated bytes
+		 * of a crafted image. offset is only nonzero here on the
+		 * very first iteration (subsequent pages always start at
+		 * offset 0, which -- like any chunk boundary -- is always
+		 * a legitimate entry start, since no rec_len chain crosses
+		 * a chunk boundary). Snap a non-chunk-aligned offset onto
+		 * a real entry boundary by walking the chain from the
+		 * enclosing chunk's start, as ext2 does; otherwise
+		 * dir_emit() copies name_len bytes from a fake entry,
+		 * reading past the end of the folio.
+		 */
+		if (offset & (chunk_size - 1)) {
+			offset = nilfs_validate_entry(kaddr, offset,
+					~(chunk_size - 1));
+			ctx->pos = ((loff_t)n << PAGE_SHIFT) + offset;
+		}
 		de = (struct nilfs_dir_entry *)(kaddr + offset);
 		limit = kaddr + nilfs_last_byte(inode, n) -
 			NILFS_DIR_REC_LEN(1);
-- 
2.53.0




