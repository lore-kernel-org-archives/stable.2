Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437404;
	b=vZlXry/JbJNQ4PLOo+BwTPf3z26dzXrPNrNWk1qk7UBclcoPvhMF05OstUkrmVeultOf
	 dQglkdliRSj0Lu+iTQhPov5xJ2hpx09Ph7iDyiGZjX5VS1HisQcxOjfvJxYv/0OthUtUa
	 DhszgRNalvijz8vZFQZGvtfkAkowBjhqo/R/uFMTfxP37zLBx/5G/U1dS5BfIzAwa9StJ
	 4re7o+ZV553CGjdnKR2JlD43Wyw1Hl1X0v06IzWpWfNGwS/ilxZKFeejitnr7tTiZeux1
	 tNyKbgdWW576Qjl6LnStaFzF4SRgcm32BHFH0UWz71g1lxO7hNij6wGyw4YhQyy4uyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437404;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uvuWkmR5cSVG5819SAj7bOcVR2rL3YncXgbCnmeAeNs=;
	b=d0vkZ5qFojaBw0lor68ahDbJigLFcOCaE6QZx5O9KxZ4J0w5RGyz31AcSuGGXbn67cYW
	 C8StnOICSvgQi/e8esZdVJwvhxsuJVtXSn14ZRRjp46pdAXWH8M0GTIQUmorqL3MJTkNt
	 8ANrgNSMhJoT9VTRPStD4nBkN91NzV5+7+J+/qfQnk1NBoF/cB0sgGaw4e9t/a5L9m6em
	 Kj+6hMoKUSwAlY/T29GHfqzEMumLWCeoqc1e8KQAkOGO5o9o+9mCmOGDuH8vwioX/UBNy
	 UNDh2Qnn0IjnbsJE6sfuoEIBpgNzVFJKfI5E/8fWUNtsuZmuLriJ7LNnl7Cai/q0kWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ+vQW0m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA147606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ+vQW0m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF931F00A05;
	Wed, 11 Nov 2026 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437404;
	bh=uvuWkmR5cSVG5819SAj7bOcVR2rL3YncXgbCnmeAeNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQ+vQW0mXJf5PH18ebeQV8ZBCBSngs8ImPymVu9RBHdkEcYuIWPTHoS3UGeVURBo6
	 /2zKNDxsoIeEksDJL1Bno/tRE/bFR4DLry9Xmer9fWT5dAt9840bFsRhd9SVA4zebc
	 Lb+9yyBvUE6skspJlr3bu7blyuxxoHyXLV3PGYXvJwCVNGO931rxghDjCEXK0pPPR2
	 JKV7brfuu5/1PewwkZuA08PWoK4x6L+wDD7ZtYbzBMamg0duj/574lnuY3M2DxSU2W
	 0IyJn6xpujTc8m2O6mMtXy7kr5/uH0fnGLw+zpAJwBPHEXcnhBIomhKfghbqGWSJPT
	 E06OkHfVEDHiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jake Labelle <southampton.jake.labelle@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nilfs2: validate directory position after llseek in readdir
Date: Wed, 11 Nov 2026 17:50:02 -0500
Message-ID: <20261111224938.251235-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054541-failed-6.1-de7f49c12566@kernel.org>
References: <20261107054541-failed-6.1-de7f49c12566@kernel.org>
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

From: Jake Labelle <southampton.jake.labelle@gmail.com>

[ Upstream commit de7f49c12566cc5c7437a2f26c6c754b9d4d5648 ]

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
[ sashal: adjusted helper insertion context to follow nilfs_set_de_type() instead of nilfs_next_entry() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/dir.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 0f3753af16741..0c68db4e4bd53 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -265,11 +265,27 @@ static void nilfs_set_de_type(struct nilfs_dir_entry *de, struct inode *inode)
 	de->file_type = nilfs_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
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
@@ -288,6 +304,24 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
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

