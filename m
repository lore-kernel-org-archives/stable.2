Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439692;
	b=3AytWB1AraWsuyTo0aQtqA0lv6EFUiOnZS6pmc5LWB6HcVESBr0lyWXDuf8ZH2Bi9/vA
	 TLZ6o/VkxQYYvqko3VEb5U5lXwNNCVwWtEBssK4lx+fOSyT8JCo2hWjQEzA2DMENjdeSP
	 r5dKcw9rzTox/YxBH01nFHwGXgB7feL4arhoUd0zz14RW/GZor6fnj3HCRYre1RlcPCHa
	 be3b9amk0S/0QYhD8pib2Tbdxo+9AdC/7fu8oD+los14suywKSUhag+YjLmCgI6hXakom
	 X8TD1J2nD51JKFDt0CPh5FHhA2YQ7wNbdcuePX+CsScNvkNmftOLB7aPOnAsa/KXqYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439692;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QGuRmlgdygObvznbXL/myoAOdC5nWgmQoqR4OnAPidI=;
	b=Wm14vvCfhu5USV1UI1ZGeIv3yKWP4qq9XiJfnP0DTz35M7WUAw8LHtHIppAiKBXC0kMq
	 +rKGB/GYKJ7X75gYA7oFvbVQjfhGXQG4CHWVqWuVF3JDU48p3nhKWsQfr+PQUMPLhDNHO
	 r/8QKNP4FXGVKo9Q1NQBWQkLNQiR84yiNd8ggh+LKxvm66hdhA1vpppn5cHbn9qnkMGi7
	 dQRDus7qM2RQKycQ5c7iBAd5th5VinDCDxLWazPDfq5Wq5kvxN9cx6JL6h/stQxvNqIOc
	 tSKtFZq90YlYOAlNfdpMZkfQcgFJnULXuzjW3uAtMiIwZtif8reC9zY+9tzZdvOdORg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W/sNTsP/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30D606A31C;
	Sat, 31 Oct 2026 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/sNTsP/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E231F000C1;
	Sat, 31 Oct 2026 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439692;
	bh=QGuRmlgdygObvznbXL/myoAOdC5nWgmQoqR4OnAPidI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W/sNTsP/7YhZkHsnjMseT8CYQUygcByg0tOChrYtT8xBCVqre4r9jLKJJsMggx5gX
	 87O66sm7yn3O32ivd7YLpmDwG8Eo4Udl9Ytj/BDMvyxadvDwDR+9WBcmZgFKnpejEQ
	 70ZgFWnzXwU/0jds0ZxBqjkNxdU3CUdz/Hvq0B7g9y7DNnylBgDhz+rYwDgHjAP+A5
	 vGLQxFbdxzugXEW1ITC6m/jl4b7P6gn4SO5WpWBIAI2d9s8a/2KLn/rF/1x4pJzdps
	 7DJy3rVDVLPSS0VgtIo7t+cHTsYBa1ODN9LpMPKvOIoUw0nuiuVodjygzS1Js5rRgp
	 +4DTOVCn+7CmA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:34 +0100
Subject: [PATCH v3 05/47] mm/truncate: look again if a folio left the
 mapping
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
Message-Id: <20261031-fixes_core-v3-5-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
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
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3484; i=david@kernel.org;
 h=from:subject:message-id; bh=56hchqGFF4LpT3G5ku/YdXRgHAq1wg+bHXHcqlx7eng=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk8tl/gicH2WyJbvsoW1Nmf+vF67QeHk5i1vrZZbu
 e2I5lk4saOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJmPIzMszYWGrxvqj1+WLT
 5e9uGJ3wmDQhevGZSWIBpxobtzYkn2xg+J+2qiUjwiT1iV6bTEZl55kFXalruXcJ1pS81ujTjo6
 3ZAYA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

invalidate_inode_pages2_range() skips a folio which no longer belongs to
the mapping by the time it has got the folio lock, on the assumption
that somebody else has removed it from the page cache. But the folio may
have been replaced, and then there is a new folio with the same data at
that index.

For most cases, like folio migration, that is impossible. However,
collapse_file() only checks the refcount of the old folios, under the
i_pages lock, and relies on their folio locks from there on. That works for
users which repeat the lookup when they find folio->mapping changed.
The following scenario is, however, possible:

  CPU0 pwrite(O_DIRECT)               CPU1 collapse_file()
  kiocb_invalidate_pages()
                                      read the folio (old data), lock it
                                      refcount check
  the write completes                 copy to new_folio
  kiocb_invalidate_post_direct_write()
    find_get_entries() -> old folio
                                      xas_store(new_folio)
                                      folio->mapping = NULL
                                      folio_unlock(folio)
    folio_lock()
    folio->mapping != mapping
      -> continue

In that scenario, the collapsed folio with the data from before the write
stays in the page cache after the write has returned.

This used to be impossible, as khugepaged only collapsed files that nobody
had open for writing.

Restart the lookup at that index, like shmem_undo_range() does. The same
problem seems to exist in truncate_inode_pages_range() as well when
truncate_inode_folio() fails, so handle it there as well, but slightly
differently: simply check once more through find_get_entries().

Fixes: 1b6444331beb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/truncate.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 733d2713a875a..9e9bf029635cf 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -475,8 +475,11 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		}
 	}
 
+	if (start >= end)
+		return;
+
 	index = start;
-	while (index < end) {
+	while (true) {
 		cond_resched();
 		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
 				indices)) {
@@ -499,6 +502,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			folio_lock(folio);
 			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
+			/* Do not handle errors, we'll do another lookup */
 			truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
 		}
@@ -760,7 +764,12 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 			folio_lock(folio);
 			if (unlikely(folio->mapping != mapping)) {
 				folio_unlock(folio);
-				continue;
+				/*
+				 * Folio might have been replaced: look up
+				 * again.
+				 */
+				index = indices[i];
+				break;
 			}
 			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);

-- 
2.43.0

