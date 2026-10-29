Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306099;
	b=Hxdw34NjeanG9jZvU51lnAAtmIlDGkIgdu+QduNZNetUC26vAhK5UCIecd7Gg/Y/qr3F
	 POHc9n9fz1Q7zxB6WoJUmLvhX687GsBW+TvCV4dlPdkepUij9Xqfw147N5ruTKdIBon5Z
	 us7G8GuTK4Md36inOj8XEjjeYRHUWDBIxiq66yq9E5axhBGe9tFm0ZNBJJ7b84Q6KFo0h
	 +R2opptWiOp+qktm95AWD50h34YYklE1GX4THPqOUIRNSJRhMhSpwYNaJ1COy1Wu9G4Dg
	 yh9ZWITwWWn2zRZMgNmcYtLlJe/QtO+Tc+UmG0b4cPvmO2BfwEucqtYkKcwY50nqrwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306099;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KxYr7Sm6OEegxhd0iVI9DwNJDZ8ymD/S/fyvDRwEbZs=;
	b=poJOfbxtBP7looHvNDjn7V1n62S3Z0LgjVp8LorPxB+J/WsMczIdSIXjDkKJK7+/WP23
	 hEVo+ySYdIwHGaZuTcCm5woOugZ+DdP7NxMcnPPiq1uq217kC4YhkW1+VBxIPfoj1PFZD
	 Mf2eTi97xtkFmJ56c3mxY/Gtgm4GXUj5nx/a9BZ6jSUeFENBsZtejzZfCrNJ5X5oEbi14
	 lIjwZX71u/jLIIOxk3XsrEU/KCpkk0JOjuk3sq2s9rhSTu0mCFOtz7Tkxn5YDpyVyGSKQ
	 KoJywobPwsW09XZ+0J6XYGr3r2l8DkdzxCpRm8zj5YzgCJkLsZ9SsBhz8meaqoGiiSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8stvVUt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040F606A32A;
	Thu, 29 Oct 2026 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8stvVUt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3413D1F01826;
	Thu, 29 Oct 2026 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306098;
	bh=KxYr7Sm6OEegxhd0iVI9DwNJDZ8ymD/S/fyvDRwEbZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m8stvVUtaQ1zzXBZo9b4DXWtjQAwfK94PwzaJ/eyWlctn2jfEk/kIccDZT4yzRzTV
	 xUwhkYp4JFgiEQbnWZ93UJ8mt2S+Web/7pzGe0SpkYI6oocQZiPLpHT73hP74roi3D
	 Yr+BUk3pE/quR4/Ig1StPmT2uOE6hcTPcUKEVJ/Lv5UMx5k4G06IaFelmWSX8rEvzA
	 ylUcnc1dGEcjLRHd7oeEGKeFW/1BtT4p1adLyRlFCZ+tJKXJz8Wd3CUiSLA5LptqrQ
	 Lopmi7EvwC7Ts8BZAb+MLwTj6XScPpqfDLchayfM4KgiBF4iArRR7JwJRL9P4FDqwX
	 OjQa5upyhqaBA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:01 +0100
Subject: [PATCH v2 06/47] mm/filemap: read mapping->a_ops->free_folio under
 i_lock
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
Message-Id: <20261029-fixes_core-v2-6-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722; i=david@kernel.org;
 h=from:subject:message-id; bh=QdrOe18hQtm70tC+kr29IxB4g7ljmyzLHze5efGpjA8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer22pSz/Yr2rC1Wyzv75dSO/9zxyjvv59K06tKJoq7
 jFNwXtbRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABOpqmNkOBziF+Ztzcv74uOs
 M8/99SO2irj9uWaeLBJ/3eKDe2PYO0aG15ob3G0e/LRW1gmRjJv2v3bv/R1bGjMeL888u3fdBef
 zDAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

memory_failure() -> ... -> filemap_remove_folio() can read mapping->a_ops
after the inode has been freed. Once the folio is deleted from the
pagecache it no longer pins the mapping, so after i_lock is dropped
e.g., a concurrent final iput() can evict and free the inode before
filemap_free_folio() looks up mapping->a_ops->free_folio.

Most callers hold a reference on the inode, but not all.

Documentation/filesystems/vfs.rst explicitly states that ->free_folio()
must not assume the original address_space mapping still exists.

Fix it by loading ->free_folio while i_lock is still held, similar to
what folio_unmap_invalidate() does.

Inline filemap_free_folio() into its remaining caller such that
delete_from_page_cache_batch() also just loads the callback before
dropping the i_lock.

The bug was found by code inspection and has not been reproduced.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 59c66c5f8c4f ("mm: factor out page cache page freeing into a separate function")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: get rid of filemap_free_folio() entirely; improve patch description ]
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c..906b013c11eb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -227,18 +227,6 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 	page_cache_delete(mapping, folio, shadow);
 }
 
-static void filemap_free_folio(const struct address_space *mapping,
-		struct folio *folio)
-{
-	void (*free_folio)(struct folio *);
-
-	free_folio = mapping->a_ops->free_folio;
-	if (free_folio)
-		free_folio(folio);
-
-	folio_put_refs(folio, folio_nr_pages(folio));
-}
-
 /**
  * filemap_remove_folio - Remove folio from page cache.
  * @folio: The folio.
@@ -250,6 +238,7 @@ static void filemap_free_folio(const struct address_space *mapping,
 void filemap_remove_folio(struct folio *folio)
 {
 	struct address_space *mapping = folio->mapping;
+	void (*free_folio)(struct folio *folio);
 
 	BUG_ON(!folio_test_locked(folio));
 	spin_lock(&mapping->host->i_lock);
@@ -258,9 +247,12 @@ void filemap_remove_folio(struct folio *folio)
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	filemap_free_folio(mapping, folio);
+	if (free_folio)
+		free_folio(folio);
+	folio_put_refs(folio, folio_nr_pages(folio));
 }
 
 /*
@@ -320,6 +312,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct folio_batch *fbatch)
 {
+	void (*free_folio)(struct folio *folio);
 	int i;
 
 	if (!folio_batch_count(fbatch))
@@ -337,10 +330,16 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	for (i = 0; i < folio_batch_count(fbatch); i++)
-		filemap_free_folio(mapping, fbatch->folios[i]);
+	for (i = 0; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
+
+		if (free_folio)
+			free_folio(folio);
+		folio_put_refs(folio, folio_nr_pages(folio));
+	}
 }
 
 int filemap_check_errors(struct address_space *mapping)

-- 
2.43.0

