Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338951;
	b=z1fPjqTWouJiB1pxysTHcbF0Yh5G65idBggiuem0nBE8JNNACUFs+iXKuD1ENf2AulYi
	 xX+2167SrQLLzaNjy9WmGNJvZ5WUdi8x/bySCiQEUHCvx5jCwgGGMP0NSuG9SsRlfS2Lk
	 nJSYWLRTytI6UYKch8u4FWSeSvLRCHg34nQ/q1NS2CQpwHQfwVPwtAbCE3X7DaZc032io
	 EaYWPoZdYIiWdx8sropZDnmoasca3F6HPbcktlIzGBNjtrk+NC3HyDpE/jgQoo7hX5qJ3
	 cPBdIsZNMpyS1JYK/37c2t5AfcX1mExtNwLCKTXumS4c0GIH9zIjRGaxOPDc7fZx9RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VcbE5pzfJXpS1pMkZKrHBbdd1JCSNb7B3eF/VdyBlZ8=;
	b=e9byVdrQpKGoIrmJC6lyJ4fWjGt48KUTtcG5fHJzahlgd95igXiEvv+pKG3wDGVa7Yab
	 lxM2jKomFgIRdgRaBZq/r9pgRvF+xU8h3DUqhjZiUi2LgIMoZlAv+MCkUuMjGIkT6nYX7
	 04ZRomSiHgI7O5KoxyvRGwDPqaEIJNoelozRiqoPsmY7Tf2Mo5cZdM0pogmC/HZmDhRHb
	 +Z1dB5In9EITc2uogEDB1G0CUqlHoDzZFHnkvMlsnwgCdLomp9Ny3DO6o54IPnBGiluF6
	 TLM7EmE0Bt2BLLTZIbNbOOAYvQqKvCnaM8wj8H2h+q3D1j8tcvMJM3CZjhuMwkmt0Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjjXj7qs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3A606A33F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjjXj7qs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6DA1F008A3;
	Tue, 10 Nov 2026 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338951;
	bh=VcbE5pzfJXpS1pMkZKrHBbdd1JCSNb7B3eF/VdyBlZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SjjXj7qsKVgu9aROeYyPFmkwTkTb4K7w7XLqQ8tM/HqnuUeFSK74xZWyDryQAV9YV
	 ePMXu7BQoOKL3fCPQlazfqEEUVsFQuRhuTDgAJ00Ayu/+LvA2PJk+fePjg3RoNQl8A
	 I/3z5Wgg4SYC4HJcOqqyfkfkghGHvSiDrcnPAFiBd2ATEt62dIX6AHlMdYTbjHTqJe
	 Mwr9B7XQTmct75Ubx43d1PXJqpTydHgu/0F3zPsLGRgPUw2x6I99RqOPVzcbPoD/GG
	 klySmL0+MmdlX6uI8oY/6f3f5k1p7o9x0qt2rYqVvuVYWZo7IBaR4IRlsEVzp3npoF
	 OA3z/jM5LF3RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] nilfs2: convert nilfs_page_count_clean_buffers() to take a folio
Date: Tue, 10 Nov 2026 14:29:06 -0500
Message-ID: <20261110192816.3526676-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110192816.3526676-1-sashal@kernel.org>
References: <20261107051714-failed-6.12-cb6702e63e0a@kernel.org>
 <20261110192816.3526676-1-sashal@kernel.org>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit c1d73eb8d06003e7714cd3ce1d0d79832e59b1e9 ]

Both callers have a folio, so pass it in and use it directly.

[konishi.ryusuke@gmail.com: fixed a checkpatch warning about function declaration]
Link: https://lkml.kernel.org/r/20241002150036.1339475-3-willy@infradead.org
Link: https://lkml.kernel.org/r/20241024092602.13395-11-konishi.ryusuke@gmail.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: cb6702e63e0a ("nilfs2: force clear dirty state when restoring from the shadow map")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/dir.c   | 2 +-
 fs/nilfs2/inode.c | 2 +-
 fs/nilfs2/page.c  | 4 ++--
 fs/nilfs2/page.h  | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index b0f182b1da8d0..287e7c8e5dccc 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -95,7 +95,7 @@ static void nilfs_commit_chunk(struct folio *folio,
 	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, from, to);
+	nr_dirty = nilfs_page_count_clean_buffers(folio, from, to);
 	copied = block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 	if (pos + copied > dir->i_size)
 		i_size_write(dir, pos + copied);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 040b93f027306..dcae6745ccd29 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -242,7 +242,7 @@ static int nilfs_write_end(struct file *file, struct address_space *mapping,
 	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, start,
+	nr_dirty = nilfs_page_count_clean_buffers(folio, start,
 						  start + copied);
 	copied = generic_write_end(file, mapping, pos, len, copied, folio,
 				   fsdata);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index bc698bb66f790..012ade1714e60 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -458,14 +458,14 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 	__nilfs_clear_folio_dirty(folio);
 }
 
-unsigned int nilfs_page_count_clean_buffers(struct page *page,
+unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
 					    unsigned int from, unsigned int to)
 {
 	unsigned int block_start, block_end;
 	struct buffer_head *bh, *head;
 	unsigned int nc = 0;
 
-	for (bh = head = page_buffers(page), block_start = 0;
+	for (bh = head = folio_buffers(folio), block_start = 0;
 	     bh != head || !block_start;
 	     block_start = block_end, bh = bh->b_this_page) {
 		block_end = block_start + bh->b_size;
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 64521a03a19e0..136cd1c143c9c 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -43,8 +43,8 @@ int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
 void nilfs_clear_folio_dirty(struct folio *folio);
 void nilfs_clear_dirty_pages(struct address_space *mapping);
-unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
-					    unsigned int);
+unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
+		unsigned int from, unsigned int to);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff);
-- 
2.53.0

