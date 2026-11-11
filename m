Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437796;
	b=l1TxjKeaGHix43NVs27PAunaFFwhaGuV1OihIA3zdrH0FQcLPaBNYnJirtYU8mFhBI3f
	 HQhN4oDTTvRq26xT0k6VI6ayjqVE7P+lb5XrOKIUWGwsJ9qeTwWwKKvFTDAxHkQDvFzqZ
	 hZwuuDHudeN9FFCvASViJQqJJzQkDNalv99cXEbVfS1WWqSIK0BibaHSyptaA1MGQQmSz
	 MwIObOA6cKU9qCAq6cwNr/ivON6/h2xGcg8W0n0Kp0+jaLATJMq0P/cLsA3bz6Snox0Gs
	 qa66ARkHoLJsfCaVGii/O7SOMNwWF5TUK7IjYTqvAe9NditKytBwYk7GNc2ytbGje2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a/cWUAvXNdVI/prNYUiOUVaBw4YHF8RhXatUo3nS+Hg=;
	b=X/5pftO9r2zzhqDlTbGJY38fIpaIrurJpUC+36X6yma6zc+Y7kLqtwimFkpMFjKoglAh
	 qyfH4gkzHJrDIyYKsJ5J5MtG/PCF/Zljq5xnCx23jQc9jkRWRN/X7LKhnyhIK9qdWtNm6
	 M+zPlhHf3hB04UZ+m+xb0+HM9n7GcgA4ZAbihiRAZcNgkGctK74bbngQjpAD1xgusi5PR
	 Jm36bAHX6h7TFwTQ7mC0A05EiF3r+Kzt4Znbxyrtj2jBVkV0tVZHxHf07Qka/lMOieKx1
	 /YuB8+7x+Q/Qf0oKKqZgYlYFaBihMEL65t/EYELrzCuX3MmEHP6Lgm6sHd1Vx5bCMxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXVP7XqI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E57606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXVP7XqI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2A21F00A05;
	Wed, 11 Nov 2026 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437796;
	bh=a/cWUAvXNdVI/prNYUiOUVaBw4YHF8RhXatUo3nS+Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GXVP7XqIsIIwmz+S+Zi74l/dUBJgBj4iNgBJwfQIRMtQmnTR4KX9Nh8rqSlgIuIwR
	 VwKJyN8NY0V37wz24CIdKLF9Wp8JvYsTx/mYIqyGodjnDSI7+Ojzo78f+FclPUem/o
	 bAw5jPwJPc2zKEIShX9EesG51neCCXeUKLxI77bsTfBYvxYYnoyUN3CrS0nHXILKeA
	 lLlU/Y374d4LXw5FkTYMXsnDV17xFZYgz60hBCZOYBnx9myUbbytD/Aw0I31ZvBc/c
	 MsxOyzvEnuNI7R2o9HoAtlbsK1WyBjAxilgqvfv69ngVmfV+Uemfis1GxMcqJCJcgM
	 ayMw9W+1hNa8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jake Labelle <southampton.jake.labelle@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nilfs2: validate directory position after llseek in readdir
Date: Wed, 11 Nov 2026 17:56:34 -0500
Message-ID: <20261111225605.352650-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061955-failed-5.10-de7f49c12566@kernel.org>
References: <20261107061955-failed-5.10-de7f49c12566@kernel.org>
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
index 3d7e692f3e7f1..2ff8f8d3c3d6d 100644
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

