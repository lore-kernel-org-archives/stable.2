Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056787;
	b=Do+VrFMY5IG7k6Kw3q302uDfOnw1joY0YhxMidgPEdAs5PfBVboI1jg7z7u74NVDkNKJ
	 whmX3m2bwvOrcOM9tTci/uQ98A0rx9evFILuYmvlpwIM7Xz8tzCPBBmVQqY/egNslY48U
	 juyrBoSPQeWLGizTsksUnwQipq+ofCgpjZPO2G32SGlewd4YlFwCiysirnwvMsGx9OlAi
	 fHXvKlHhg2pY/99yRlNS/GDV5drnn8x3QTLOJ/Dh13hXFytep4Yh31DOc5q94YingRHEj
	 r8rQcZjwP4fAtDU4FiC4Bp1Na+HWWdUe5FGyXvVRQFs4Fzb6JSic8prT/sGlnQ5vU+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056787;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rRXrA/tyStkBmC7dglbBDKVTBfaDXW25Ud/zHKaz2Ig=;
	b=i+L7XJCaOgVEWLYStJEMTvSbR7x3bS4AQzR+24gbEoshNrFOD4LiWAxSo2imalkmSwY7
	 t/pHPwZhBiuLshnzRTqwUVscWp8DuuFHrliFUAkd7UofxllBqek67BbxUJE6ppuvzUt2W
	 rBG+smgzxrtcKb/b6DgSVvS8g1A78PFQTWbOvoNcvYQ4H7hOukxyRmhloyPKr1qg7XmaY
	 Al+9UIcGnBGayDvVVdVGiEA8sITTGEFVDxbo6bPGz2qgGC6I+c0voQAGahyLSmea0E7pc
	 6OeMHemhfcR/omHp2OA7tEYIjMby6+6YofJX/fm1LVF3WbZxQlYytdaySi68rSmvVKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUd4ools;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A968606A329;
	Mon, 26 Oct 2026 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUd4ools
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116581F031E1;
	Mon, 26 Oct 2026 23:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056787;
	bh=rRXrA/tyStkBmC7dglbBDKVTBfaDXW25Ud/zHKaz2Ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KUd4oolszt2QIPW7WtveUCPtMmmqmnf7waWs2nfCbzJeAcTAHVmBk0D3JQc3Io4PS
	 rR+U4nUnLeY1sUJzPA7GpkTQNcyMET0bo3nYYpqYCDvmx/jgOLmjLPMkjKvQN8JsFG
	 hQnH/+x9Z+7koraSDGlRHmAcUVAx068DAkkSDdPDWTfzcFrJPtZ2GRcAGW8fpr+Ugd
	 CswVpJ7Ydma41W/jftH7QT3TZoCDIPCOPel25/UbeqDkX8FX0hG8otDam5riyDC5OP
	 qeKhgIWGvEDFp9qsdAw15fwMyqP3+7fcGO7T3lZaj357eyUeo7dS1Oj2XQmmvBC+Yc
	 cB5Gq3lGzCBGQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:26 +0100
Subject: [PATCH 06/46] mm/filemap: read mapping->a_ops->free_folio under
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
Message-Id: <20261027-fixes_core-v1-6-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3678; i=david@kernel.org;
 h=from:subject:message-id; bh=b6PA7tE/rZMjLIceJa9YiiSjeJMFaXXevLttm/76m88=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35+cfMGKMVghRr+Z4+jbqxncs+c4PLu1/+7j/7qPl
 p1a8OepcUcpC4MYB4OsmCJLUPB9g5cv19VWu/Exw8xhZQIZwsDFKQATkTJkZJiTcvdRWKK80bdZ
 VeyPMrIkeX6e4Qozka6SeSBldurjNmNGhrO2+UuWe+7JdFLcu/1LecLJIzfP3AnZuWHfRqNGl86
 J4UwA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c6..906b013c11eb3 100644
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

