Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090279;
	b=S5WPftga8y8V+3uC1yiHWLa6o03bK8UBnpFuFp4WnTW2tJZX65Ogau7YALgtjkFNKGDV
	 cQ/wARPS3SHKeQaiOtb1peagFoJXJK6qz6+Ui/CYsSlEy8CmHHBat6coqkLAjuPA9YL0j
	 9TOCOISoToh801n/CG2xnwsFpRY2oiGpFzeVUy/OrxFnCsQFPFAmJL7CZG67aeMjlLJ7G
	 L6PT5Re7+rl0RHmAUXxFItH18SdhZGU09sxDFZSS6y58Beoz82XdKyFDJlloIiQGNjifR
	 F94pnW89h7fRzJSaAYNXmLJwaExpDqoOlqvEl6GcvaC0e0vUCc+t/5xqy59pXZH6bNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090279;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=s6N4YpPTgOoqUcx/vTuyNssoa2j7GTXJb10U+3l7OOI=;
	b=zJOJJ3XNpUWOfPZtbK9hLuYFF0tTd3v1oFgKp6emue4wc2mv5n+8ZoNyn2HMcDaGsTAf
	 h+8bZgRA2omXu76HWUeH84x1ec/vtUMZkBWNsv1oB/6GvaOaXUDPcMLGvj3QXuqMs3nG0
	 S28ng3xAPodmVYm+UsyCmSimluxeZHNmOTeRcwRJJiX61XEhLND2fH3HPRpZer/4hSyfj
	 oh3b9qOfDNF5DseIOCyjhTVKIHHtZ5MfFO6qzcNl6SuEjMUmZ2WIy2nITbQU7w1NYi7Bu
	 p8/b39xDnrfxKWpMdU4c+BCoMiYzAGr2B7JF4H7YJPcvXQMP1E6YP/253wvD7AY0cnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Oi/wh6Fo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B298606A326;
	Sat,  7 Nov 2026 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi/wh6Fo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674061F008A2;
	Sat,  7 Nov 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090278;
	bh=s6N4YpPTgOoqUcx/vTuyNssoa2j7GTXJb10U+3l7OOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Oi/wh6Fo/queHm2D7vPoJJ1fq6YiCpzQtIUPsMBDDhk7dLv5IcXdilowlTNG7d0FF
	 baIzia55b/JRdjUobNqZjaqmklfUOnZI6gMTSmEUj3AhAE9M/ViQ/zKHXwEuthHHWw
	 JqJhxxiQOYeQV6UeF4l+SBpXy0Rgodw18hdVVS5mgI+Zcq3OKeUoV0W0OmireqmSXh
	 /tKcv/OIVa1dZi0mgxomFJCWkkMPpxHl9T0pVjypmUn2eGrrB+XSM9FqO5kQiiSc1k
	 wdWE5gbvaFhC8GVduDwKtoTtxBr9Qli91+dDkJ6znNoCj1LE7EGK1mo4AUekojw0tR
	 DJWVEVuA5ZY+A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 07 Nov 2026 23:23:38 +0100
Subject: [PATCH v2 2/5] mm: limit pagecache folio refcount when splicing
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
Message-Id: <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
In-Reply-To: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5422; i=david@kernel.org;
 h=from:subject:message-id; bh=v5xbjRDjGerU96PcN0sE4co5RzL91Qtl1i190D5ET5k=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeL2Xk5vyk/dx2wZ3WtSXz/61y5Vi6fu2NK74f77Leq
 bhaprc4rqOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJ3OljZFh7JHkG47+nvk+3
 iOnN84uO+5wSfFopl92xev7MOQI/9W4y/HdlZX9kI3VeLbTqbUzNo8NzNla/sjnTXx2i11dbtP+
 aBT8A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Similar to mapping pagecache folios into page tables, let's reject
additional references when splicing folios into a pipe if the refcount
is at its limit, similar to how we handle it during GUP.

This will prevent more cases of possible folio refcount overflows with
large pagecache folios.

Let's keep it simple and check in the two callers of
splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
progress, so do_splice_read() can fall back to copy_splice_read() when
read_iter is available. This keeps sendfile() and other splice users
working when ordinary reads would still succeed.

Also fall back to copying in FUSE when taking another reference through
fuse_ref_folio() would exceed the limit.

Also check in try_get_page() to cover pipe-buffer duplication by tee()
and partial pipe-to-pipe splicing.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/fuse/dev.c      |  5 +++--
 fs/splice.c        |  8 +++++++-
 include/linux/mm.h |  9 ++++++---
 mm/filemap.c       | 11 ++++++++---
 mm/shmem.c         |  4 ++++
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3641abb90d6bb..4f6b7b42bfd3e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 		if (cs->write && cs->pipebufs && folio) {
 			/*
 			 * Can't control lifetime of pipe buffers, so always
-			 * copy user pages.
+			 * copy user pages. Also copy folios at their refcount limit.
 			 */
-			if (cs->req->args->user_pages) {
+			if (cs->req->args->user_pages ||
+			    unlikely(folio_ref_count_over_limit(folio))) {
 				err = fuse_copy_fill(cs);
 				if (err)
 					return err;
diff --git a/fs/splice.c b/fs/splice.c
index e6d43329ed3f0..df73a4e65118b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -956,6 +956,7 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
 			      unsigned int flags)
 {
 	unsigned int p_space;
+	ssize_t ret;
 
 	if (unlikely(!(in->f_mode & FMODE_READ)))
 		return -EBADF;
@@ -977,7 +978,12 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
 	 */
 	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
 		return copy_splice_read(in, ppos, pipe, len, flags);
-	return in->f_op->splice_read(in, ppos, pipe, len, flags);
+	ret = in->f_op->splice_read(in, ppos, pipe, len, flags);
+
+	/* Fallback to copying when hitting folio refcount limits. */
+	if (unlikely(ret == -EOVERFLOW) && in->f_op->read_iter)
+		ret = copy_splice_read(in, ppos, pipe, len, flags);
+	return ret;
 }
 
 /**
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3356f7a670d1e..dd50262a70758 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2288,10 +2288,13 @@ static inline void get_page(struct page *page)
 
 static inline __must_check bool try_get_page(struct page *page)
 {
-	page = compound_head(page);
-	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
+	struct folio *folio = page_folio(page);
+
+	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return false;
-	page_ref_inc(page);
+	if (unlikely(folio_ref_count_over_limit(folio)))
+		return false;
+	folio_ref_inc(folio);
 	return true;
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 920bbf86dfdff..8564165e224b3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3094,9 +3094,10 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
  * Return: On success, the number of bytes read will be returned and *@ppos
  * will be updated if appropriate; 0 will be returned if there is no more data
  * to be read; -EAGAIN will be returned if the pipe had no space, and some
- * other negative error code will be returned on error.  A short read may occur
- * if the pipe has insufficient space, we reach the end of the data or we hit a
- * hole.
+ * other negative error code will be returned on error; -EOVERFLOW will be
+ * returned if the folio's refcount is too high and the caller can fall back to
+ * copying.  A short read may occur if the pipe has insufficient space, we reach
+ * the end of the data or we hit a hole.
  */
 ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			    struct pipe_inode_info *pipe,
@@ -3168,6 +3169,10 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			if (writably_mapped)
 				flush_dcache_folio(folio);
 
+			if (unlikely(folio_ref_count_over_limit(folio))) {
+				error = -EOVERFLOW;
+				goto out;
+			}
 			n = min_t(loff_t, len, isize - *ppos);
 			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
 			if (!n)
diff --git a/mm/shmem.c b/mm/shmem.c
index be4ab228cf67c..6067b1de6417f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3830,6 +3830,10 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			 * Ok, we have the page, and it's up-to-date, so we can
 			 * now splice it into the pipe.
 			 */
+			if (unlikely(folio_ref_count_over_limit(folio))) {
+				error = -EOVERFLOW;
+				break;
+			}
 			n = splice_folio_into_pipe(pipe, folio, *ppos, part);
 			folio_put(folio);
 			folio = NULL;

-- 
2.56.0

