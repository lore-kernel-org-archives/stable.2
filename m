Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884249;
	b=P783EMoPMmJgt/TmWoBw49I/lGg8GFYOXy7SZS9S66qrBbem7MiZQSOAJvEvoLpnAYRj
	 ycrD+orH7FukZn9WBiIoNhuWOhbQHnpDHCgFw23Bp5VvqPoCRGwiAJ4KqxIeT7N6ZxtoA
	 WW3jFqY1GV9Fa7UO9W5oYxhkBa5Q7MqjFG189UzL7hhXg4Erwxwb9AScvWoYsKqSArSMg
	 P1aHWurNRYtP1qXtWIGJpnQRzmyMQsNhxxzjddoKs+6kOfKr3e116wjsLHgXY7yNEZ1Ky
	 EFJ5nLAAzZXyEsSvix6/zXEPp4P21WYLyQIQevutys22rpb9tZr+NYmpPz6YYJyh0cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884249;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=R1iaS7pxTq1YBHZDyspJs0dpXEY7StT0kkQshxwr2aA=;
	b=cz2A2/6M5iE1VYumtReU0c5dzjAYbSynrp0Y2nnRKSN+Jv5HQJLmqchy4zb8f0zJWkoe
	 kXX+8e8MAA6XgiF4f4R1sHh1l1tQ2bweV7rOHMn4vAM66GnoUxGOlo2fVXYIQGAcmE7Ma
	 BUO2vvyALc3gXTdNx8kBUTka4Idztz6RCR5PNKCx+D7YdyMhR7gTDnjk0HZigDaRDrdhZ
	 DXrIAvgsBi3nSzM+Q78fLFn2tjIwSeES1Oatb54d3QNnnRPgs9WT8lTyuV1mZm+o5DVTT
	 eEES7HcBGCLsUisR7sEm+mSfQriuIVxez7mXoecm8g6L9BT7w5zPBjtB+CQrK2nR1mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F3f/VwnP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4B606A32D;
	Thu,  5 Nov 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3f/VwnP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456FC1F00A15;
	Thu,  5 Nov 2026 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884248;
	bh=R1iaS7pxTq1YBHZDyspJs0dpXEY7StT0kkQshxwr2aA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F3f/VwnPu04LnZzWyr4Ia4UOIe5utTPhGLEtSJh1SqeElGu1gCesnH5rre9xAB+bp
	 QwDwK8WstTrGd28xcMJHGxZKaNcY03hk3IeONTxDsD5dG0cN4w2kTnUAkJztduLBK4
	 PnEDs8EXg4JBG1aBM5oWyLk2ocDTbBQm8/EHMloh6SSkWpwZi+Yv0RKSR89EbFlwY3
	 vWHydrYSXA6VlTp5u3NsVnkOwouQr/+Z86PZt6pQLyyrWs69OgL/8xpke7mKYvAad1
	 sZI2CNXm7TbzH07tw1FlPJ1SoUgV2Mqy9PqGqoOZgSiDDb08Dsx3ne392X4jwr0gIL
	 bNZoy8UNYlGwA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 05 Nov 2026 14:10:11 +0100
Subject: [PATCH 2/5] mm: limit pagecache folio refcount when splicing into
 pipes
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
Message-Id: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
In-Reply-To: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2550; i=david@kernel.org;
 h=from:subject:message-id; bh=HeWasX6+2Sb8yH40ZbaSQQX7qw4+HNYtLsd9jtSfniY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeNFiqbmVpubH3yal3z2PnOTmfnbnlyMRdb9R0tUXj4
 593nWIq7ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAi1W0Mf3iTuydduqH4dBPr
 4WKrx/1TbI/s+SRkcjUnuGRC55Hjy/4w/A+7c0c98ctFqUM1IVq+DGc8N0ZvDNctjJji62Yk84T
 tODMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Similar to mapping pagecache folios into page tables, let's reject splicing
folios into a pipe if the refcount is at it's limit, similar to how we
handle it during GUP.

This will prevent more cases of possible folio refcount overflows with
large pagecache folios.

Let's keep it simple and check in the two callers of
splice_folio_into_pipe().

Also check in try_get_page() to cover pipe-buffer duplication by tee()
and partial pipe-to-pipe splicing.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h | 9 ++++++---
 mm/filemap.c       | 4 ++++
 mm/shmem.c         | 4 ++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 79ae8fc0d6bb4..a82cfbce18215 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
 
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
index 920bbf86dfdff..0f2ec790a5b65 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3168,6 +3168,10 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			if (writably_mapped)
 				flush_dcache_folio(folio);
 
+			if (unlikely(folio_ref_count_over_limit(folio))) {
+				error = -ENOMEM;
+				goto out;
+			}
 			n = min_t(loff_t, len, isize - *ppos);
 			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
 			if (!n)
diff --git a/mm/shmem.c b/mm/shmem.c
index cda1a0f7db99d..1c0f6bceac486 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3819,6 +3819,10 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			 * Ok, we have the page, and it's up-to-date, so we can
 			 * now splice it into the pipe.
 			 */
+			if (unlikely(folio_ref_count_over_limit(folio))) {
+				error = -ENOMEM;
+				break;
+			}
 			n = splice_folio_into_pipe(pipe, folio, *ppos, part);
 			folio_put(folio);
 			folio = NULL;

-- 
2.43.0

