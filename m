Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524060;
	b=YZKTAyX5DhipgFg1H8nHVVZ1i+cMytocGpsUAqBPG+yihJSXqruxl2o6WEWyGSOcg875
	 vDrqcPppOHEetICYhRUM7u/RTA3on6B1/vroPqhhD32foXRZsfMTlNB9oeWqQS/tXhjbY
	 mFK4+gcK4Pu06QMBNVGCp3PZzz9rzbMkg/UcVRRDYUKcFb7IiSvj2ergfvH3iZM+Sc/ad
	 cZ+GYlU+yckbAVtR+a0eEnjqXgRKHk3r34F+Enea5j3aAqoXPuNkz0x5yr28hHfLMUT7F
	 HNUaRfY/DHlw/c/qdIqrEzCVT4DrqtFoB80pdOK+P0FTG3GwufFtMto90/NAKnIa4ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524060;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Tzhio+p5uj/Apj4ZLWHO+xI0TGptYSX3NjSGWNpVGLg=;
	b=V+KACaMnYnvToUDzPHqywfe8f6hfC6xaEdFjNh/O/FriNTWOmOisMOricrU3mqR/7Xvn
	 Fn5cAFcNP1nurqDJE5ih/IWhnu3ekmItjaqbRcSsfV1T5cSBtMXeG96xObNaXoqbzGd3x
	 FBarmwOKkCKcJ85lgQpgjJQ6X9cJtiaijfRQc8ArzVx3Zr7s0fxsgLc9u0PUZjz5wARCZ
	 ne92ElSunxiKnWTCHkU7f0aGeYM4AooD1SynfeDVtX4c2IeCBIwuAh7UYxQfCLwEONUCc
	 hsuP/IwxmkaAQUm938ri3W1sX3YCYxLBoT1WE63/Re8N2if3A49as2Zw6qs0m9JidTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsH8yQCJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158C606A323;
	Thu, 12 Nov 2026 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsH8yQCJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FDD1F000C5;
	Thu, 12 Nov 2026 22:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524059;
	bh=Tzhio+p5uj/Apj4ZLWHO+xI0TGptYSX3NjSGWNpVGLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CsH8yQCJgew0T7yjC+Ye7xILTGbzvytsdr33ROL/O5lsP3hLmfGgysPHKFWDXj+gc
	 ds9QdstQuwvkm5k6yTjh8L6cFegAqhxEGoqLMdd9PSBMj5u/LxCcssPOSZKfpKH9hf
	 M8DhWBntbPyxH4tKwXBZrF9Cj6XYgX5xO9LBeEuOVBConxIH5k9dqbRmSexvl/rWAx
	 AlglCWCRVXBJzNnWwHTKvt/JU5aJTJs8/5wcL/P70yEJchBSltYf9vJbQ3dnbbxkVf
	 wrifDqmOh2vJtNlj7oT8941F6e7AAiTaEchGiVscz1l9hn8z0GRUvQBwCmfQI5kYs+
	 qunfQdN/G9A5g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:53:21 +0100
Subject: [PATCH v4 2/9] mm: limit pagecache folio refcount when splicing
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
Message-Id: <20261112-refcount_overflow_stable-v4-2-ad3deef0bd23@kernel.org>
References: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
In-Reply-To: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
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
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9915; i=david@kernel.org;
 h=from:subject:message-id; bh=cKbuqWeh+NwZcJyo9b9LkGYlyqAoqJxb5hRZLYGLI5M=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+OWe+r1t0Vm6RWq31MbHXon8+5eZINfR6Gn49kZjxZ
 c3iF/eDO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhI+21GhnuCW3Y81xPNXflh
 /zvlVV/zzWd+Eui+vy2accXGEwvSPY0Z/imLXnx0jE/p8/Pr7cdfZ9UvrU/zO50zpUs84Tfv/9w
 4YS4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Similar to mapping pagecache folios into page tables, let's reject
additional references when splicing folios into a pipe if the refcount
is at its limit.

This will prevent more cases of possible folio refcount overflows with
large pagecache folios.

Introduce folio_get_checked() for checked reference acquisition when
the caller already holds a reference. It warns and fails on a non-positive
refcount and rejects additional references at the limit.

Add __folio_ref_count_over_limit() so folio_get_checked() can reuse the
refcount instead of having to read it a second time.

Use folio_get_checked() in splice_folio_into_pipe() and
fuse_ref_folio(), returning -EFAULT on failure, like we already do for
pipe-buffer duplication. Similarly, make try_get_page() use it instead.

Likely try_get_page() should be renamed (or removed) later, as it doesn't
match the folio_try_get() semantics and is confusing.

If we hit the limit after splicing some data, return the number of bytes
already spliced. Teach the callers to handle errors, and stop
filemap_splice_read() if we only spliced part of a folio, so we don't
skip ahead to the next folio: note that we wouldn't run into this
scenario before as we always spliced the requested range.

The check in try_get_page() also covers pipe-buffer duplication by tee()
and partial pipe-to-pipe splicing.

Note that we deliberately will not fall back to the slow path of copying
the folio, particularly as the folio might have an invalid refcount. If
it is ever really required, we can revisit.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/fuse/dev.c      |  4 +++-
 include/linux/mm.h | 49 +++++++++++++++++++++++++++++++++++++++++--------
 mm/filemap.c       | 26 ++++++++++++++++----------
 mm/internal.h      |  4 ++--
 mm/shmem.c         |  7 +++++--
 5 files changed, 67 insertions(+), 23 deletions(-)

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
index 9b247bebeda2c..383a5c2271d6b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2237,8 +2237,9 @@ bool folio_ref_count_over_limit_slowpath(const struct folio *folio,
 		unsigned int ref_count);
 
 /**
- * folio_ref_count_over_limit - Check whether to refuse more folio references.
+ * __folio_ref_count_over_limit - Check whether to refuse more folio references.
  * @folio: The folio.
+ * @ref_count: The sampled folio reference count.
  *
  * Check before adding page table mappings or other significant refcount users
  * to pagecache folios (!hugetlb), either before acquiring references or
@@ -2252,15 +2253,27 @@ bool folio_ref_count_over_limit_slowpath(const struct folio *folio,
  *
  * Return: True if the caller should refuse the operation, false otherwise.
  */
-static inline bool folio_ref_count_over_limit(const struct folio *folio)
+static inline bool __folio_ref_count_over_limit(const struct folio *folio,
+		unsigned int ref_count)
 {
-	const unsigned int ref_count = folio_ref_count(folio);
-
 	if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
 		return false;
 	return folio_ref_count_over_limit_slowpath(folio, ref_count);
 }
 
+/**
+ * folio_ref_count_over_limit - Check whether to refuse more folio references.
+ * @folio: The folio.
+ *
+ * See __folio_ref_count_over_limit().
+ *
+ * Return: True if the caller should refuse the operation, false otherwise.
+ */
+static inline bool folio_ref_count_over_limit(const struct folio *folio)
+{
+	return __folio_ref_count_over_limit(folio, folio_ref_count(folio));
+}
+
 /**
  * folio_get - Increment the reference count on a folio.
  * @folio: The folio.
@@ -2285,15 +2298,35 @@ static inline void get_page(struct page *page)
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
+	const int ref_count = folio_ref_count(folio);
+
+	if (WARN_ON_ONCE(ref_count <= 0))
+		return false;
+	if (unlikely(__folio_ref_count_over_limit(folio, ref_count)))
 		return false;
-	page_ref_inc(page);
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
index 78f86f1daefe4..b972c6cd992c1 100644
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

