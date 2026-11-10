Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343049;
	b=UvGnx8OjkW6F/bv2S3hYpdCK+0yDrh2jtGxSKX9FYFfGe9hIij/Feu6nmbgtlnZoFddd
	 49Oh629aOvn46AA7eIA5oFDSCmbA+e6sMhzHp/FThwjD66q/ZoUSTy6i9YyccjBBBzTqS
	 U1aqQgBiJDOg8AcSYE54XPHyrPYybiSgrIGvciCgbTYNVg3GHwBfLQ+DWlV81S7Fk/mwC
	 MlakOUf4YISRKLwyUnQ6JXKSyyxHKO71uRPDF+q4eLwc6dSW/Xohjj1ZfE2M+yt6okq3W
	 Hrv42qV8t3X+rl0Y+WvQgTISdsN1MhwdekbviE+Z0KREfEK+3nCuqrj8L0SxvMcuJGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343049;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5cNAcRV4gTeLmVPsApuEJzf0CRKWSf5+z5blAR+MWsE=;
	b=BXAfipr2rtKA7OPI8qQctLAHE2tLXtvU1BhLcl5Uf0BhHTjqqcl/tfMmTL59VIyeGunW
	 WcXu7fHnRoxDHiOgLMUUXS9pT0GAzuFR0giElw1NgMpcmJCVsLhVdzuDrFBy0ROt6CSAe
	 e2808W5Fp3tP73KcO3SM4YM62sFgbCwTb64W1kds6BqnCS4Dc4YxnlBfxUbgmF070xaKb
	 UvKpGvGkvhzS7fnzRPts5le5MMoWwFqCYQ9nhrcORwjpcitB30NeE9YYRfiC3J3AXJQhW
	 yeZLa5nHYc+RkJWbtqgnvi4QKKvkKiuK/pLie3BP3gYIPCEnupKbWKXq4jI5bR3he4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gATmaa1L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13259606A31C;
	Tue, 10 Nov 2026 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gATmaa1L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180A51F0089F;
	Tue, 10 Nov 2026 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343048;
	bh=5cNAcRV4gTeLmVPsApuEJzf0CRKWSf5+z5blAR+MWsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gATmaa1Lt3X4HxUciLGSnlropuYm4F3ZLnuep9dLY4gLa+sROlNo43awVKfMp4uQW
	 /iSzFiOV0acs6IL0XeaNHIDdnf4AWYgpHDw/nKMCIyqpIJTkkI4CXe5dkwFTPKiBZX
	 yqPWKttpYDXqGv1UJAyj9NxHQkNgYDoR4IqW71qgb5SEvWus0HSDtz2gTVqcZDhNok
	 v/rek6poivDFqmh0xY5gVphxzfygcp+tYx6Dgs74DL5jchkkkec7IvZ3016EYSItiE
	 ZRqJQJOon0e9l7ZqSPzEZzDDj1S3p/OtO7squ3YRhBSkPZu62FgdjYPFM23KVlxz8u
	 cDd95itkFhSZA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 10 Nov 2026 21:35:42 +0100
Subject: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
In-Reply-To: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7960; i=david@kernel.org;
 h=from:subject:message-id; bh=CFQQVb0CdG/lsM7RC0wDMWlA61o5yVNMMb/8X2xuOEk=;
 b=owGbwMvMwCF2QOXvyb15Z08znlZLYsj63BBuliNlcd/iuT3/Rt/S58rLVt571vqcfWd5uPzFk
 0vduxn0OkpZGMQ4GGTFFFmurctJDV7T6lgWZegGM4eVCWQIAxenAEwkficjw9+WJVyKjwx3PUqT
 NA9JZ7FaxRtgW7PW8sErVc//vh0dxxkZ2tSCX2y9yjWbqWYqY91TgZbWhU6Zv7zPPdi01Znj/KX
 vfAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Similar to mapping pagecache folios into page tables, let's reject
additional references when splicing folios into a pipe if the refcount
is at its limit, similar to how we handle it during GUP.

This will prevent more cases of possible folio refcount overflows with
large pagecache folios.

Introduce folio_get_checked() for checked reference acquisition when
the caller already holds a reference. It warns and fails on a non-positive
refcount and rejects additional references at the limit.

Use folio_get_checked() in splice_folio_into_pipe() and
fuse_ref_folio(), returning -EFAULT on failure, like we already do for
pipe-buffer duplication. Similarly, make try_get_page() use it instead.

Likely try_get_page() should be renamed (or removed) later, as it doesn't
match the folio_try_get() semantics and is confusing.

If we hit the limit after splicing some data, return the number of bytes
already spliced. Teach the callers to handle errors, and stop
filemap_splice_read() if we only spliced part of a folio, so we don't
skip ahead to the next folio.

The check in try_get_page() also covers pipe-buffer duplication by tee()
and partial pipe-to-pipe splicing.

Note that we deliberately will not fall back to the slow path of copying
the folio, particularly as the folio might have an invalid refcount. If
it is ever really required, we can revisit.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/fuse/dev.c      |  4 +++-
 include/linux/mm.h | 26 ++++++++++++++++++++++----
 mm/filemap.c       | 26 ++++++++++++++++----------
 mm/internal.h      |  4 ++--
 mm/shmem.c         |  7 +++++--
 5 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3641abb90d6bb..50f41bb287832 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1230,7 +1230,9 @@ static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
 	if (cs->nr_segs >= cs->pipe->max_usage)
 		return -EIO;
 
-	folio_get(folio);
+	if (!folio_get_checked(folio))
+		return -EFAULT;
+
 	err = unlock_request(cs->req);
 	if (err) {
 		folio_put(folio);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6c7c29a086bd1..33bc57342590c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2284,15 +2284,33 @@ static inline void get_page(struct page *page)
 	folio_get(folio);
 }
 
-static inline __must_check bool try_get_page(struct page *page)
+/**
+ * folio_get_checked - Try to acquire a reference to a live folio.
+ * @folio: The folio.
+ *
+ * The caller must already hold a reference to @folio. Warn and fail on a
+ * non-positive refcount, and refuse additional references at the limit.
+ *
+ * Use folio_try_get() for speculative reference acquisition where the
+ * refcount can legitimately be zero.
+ *
+ * Return: True if the refcount was incremented, false otherwise.
+ */
+static inline __must_check bool folio_get_checked(struct folio *folio)
 {
-	page = compound_head(page);
-	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
+	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return false;
-	page_ref_inc(page);
+	if (unlikely(folio_ref_count_over_limit(folio)))
+		return false;
+	folio_ref_inc(folio);
 	return true;
 }
 
+static inline __must_check bool try_get_page(struct page *page)
+{
+	return folio_get_checked(page_folio(page));
+}
+
 /**
  * folio_put - Decrement the reference count on a folio.
  * @folio: The folio.
diff --git a/mm/filemap.c b/mm/filemap.c
index 0f6d57432a7e5..e6e73e37f3ea4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3047,10 +3047,11 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 EXPORT_SYMBOL(generic_file_read_iter);
 
 /*
- * Splice subpages from a folio into a pipe.
+ * Splice subpages from a folio into a pipe. Return the number of bytes spliced,
+ * or -EFAULT if we cannot splice from the folio.
  */
-size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-			      struct folio *folio, loff_t fpos, size_t size)
+ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			       struct folio *folio, loff_t fpos, size_t size)
 {
 	struct page *page;
 	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
@@ -3063,13 +3064,15 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 		struct pipe_buffer *buf = pipe_head_buf(pipe);
 		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
 
+		if (!folio_get_checked(folio))
+			return spliced ? spliced : -EFAULT;
+
 		*buf = (struct pipe_buffer) {
 			.ops	= &page_cache_pipe_buf_ops,
 			.page	= page,
 			.offset	= offset,
 			.len	= part,
 		};
-		folio_get(folio);
 		pipe->head++;
 		page++;
 		spliced += part;
@@ -3094,9 +3097,10 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
  * Return: On success, the number of bytes read will be returned and *@ppos
  * will be updated if appropriate; 0 will be returned if there is no more data
  * to be read; -EAGAIN will be returned if the pipe had no space, and some
- * other negative error code will be returned on error.  A short read may occur
- * if the pipe has insufficient space, we reach the end of the data or we hit a
- * hole.
+ * other negative error code will be returned on error; -EFAULT will be returned
+ * if acquiring a folio reference fails and no data has been spliced.
+ * A short read may occur if the pipe has insufficient space, we reach the
+ * end of the data, hit a hole or hit a folio refcount limit.
  */
 ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			    struct pipe_inode_info *pipe,
@@ -3154,7 +3158,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
-			size_t n;
+			ssize_t n;
 
 			if (folio_pos(folio) >= end_offset)
 				goto out;
@@ -3170,13 +3174,15 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 			n = min_t(loff_t, len, isize - *ppos);
 			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
-			if (!n)
+			if (n <= 0) {
+				error = n;
 				goto out;
+			}
 			len -= n;
 			total_spliced += n;
 			*ppos += n;
 			in->f_ra.prev_pos = *ppos;
-			if (pipe_is_full(pipe))
+			if (pipe_is_full(pipe) || *ppos < folio_next_pos(folio))
 				goto out;
 		}
 
diff --git a/mm/internal.h b/mm/internal.h
index b129510b92e2a..08e259758937b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1276,8 +1276,8 @@ struct migration_target_control {
 /*
  * mm/filemap.c
  */
-size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
-			      struct folio *folio, loff_t fpos, size_t size);
+ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+			       struct folio *folio, loff_t fpos, size_t size);
 
 static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index be4ab228cf67c..8b94877c36c18 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3751,7 +3751,8 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 	struct inode *inode = file_inode(in);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio = NULL;
-	size_t total_spliced = 0, used, npages, n, part;
+	size_t total_spliced = 0, used, npages, part;
+	ssize_t n;
 	loff_t isize;
 	int error = 0;
 
@@ -3837,8 +3838,10 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			n = splice_zeropage_into_pipe(pipe, *ppos, part);
 		}
 
-		if (!n)
+		if (n <= 0) {
+			error = n;
 			break;
+		}
 		len -= n;
 		total_spliced += n;
 		*ppos += n;

-- 
2.56.0

