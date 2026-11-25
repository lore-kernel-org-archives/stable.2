Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646102;
	b=sRzeqi16wFclNuPX/LXb0I5R3qReK2z1jZzqasPLvfOM9P06ieiEA93Xh33uxxBrPsUg
	 gkVc2ertqgi9+QzHI4yfDFPikwNKp+WzWfSddoZ6LPB1Kw+r6X5a5HWFbOzGYrRyK+csY
	 QgeAo51jHQvTN70eM3HwW80AXUgQJ1aIhLIKhoiyoa9v+opxQPy8POY1km+HFSaMNY2SE
	 M8mx9AsIa1YTGQGzQihA61pJH4PkqTi3kHFVljsZOpWqHGUbR/JEYpNoe3eNQYq5KqBlX
	 bapX97A1UHsSQsgc+jTx93oQP4ytI98zZqG6ZpOlVDzzXKvbOOEltouMA7NUZqFmKyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646102;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rfL5x6QN4uMtbxP3f8hbUSFP2Tb3L1Ge5tQU0VKhPiU=;
	b=vlCdDXpuGB24ax6qj/6Oa+DjIYsHdR/F3qbNDU7RKTxmwfd3xgqVaFGZ2aBwuHCwYmL2
	 wqjlZ7w9J6uwhMdOwljDxaacnEnvBj+Kngw1aFDuZSg9nLl5AP0Kdo9RFHRv2jFMMKPch
	 SwOkYEzFYbOLO0mG/3n4qwNiw3AHKCSGXbovrzVfxXxTDTaAjIyA7ZDq/9RMRRj5VgAlE
	 ggWZYHpgTZpNe3kuKk6iQ5EYLwb6bBTrfWhyoOTDtiDHcQHrUr+konJdKtKG9v3UgIBwj
	 LNKwlXg12Y2u+l9K8elta9imeiGupE0fBih6sXFDyVgJkp+P6upwgos9toy+f/paVAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9nyDQ2J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424B606A339;
	Wed, 25 Nov 2026 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9nyDQ2J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E2E1F000D8;
	Wed, 25 Nov 2026 22:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646102;
	bh=rfL5x6QN4uMtbxP3f8hbUSFP2Tb3L1Ge5tQU0VKhPiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b9nyDQ2J/RIU42aEm7BmZJbfvXcRFNipTjhfwdSgRn0KzkRLJdvdxcUi9aMl1YWyy
	 TMHtFurAtb3rTwa/SqNviyHbah/r8l0b9Jj7s43SnuUcATIvotOlhb91ZJGwL1W9M8
	 Ip9bBn89Ra7CmDp/hoab/W4xrVJS6qW4XbFBQMct+5eso2M/+mWCzUfSUjhaX79JVK
	 h8DYuAWlix+O3sgFNPzVew0i8bcRct4KI0fiYeEbJ0JQH3SstmPi8gQte0qYzfsMYP
	 EcT6sgUk9AqPVGaMPCTh+LNfFYpAIKt90ZC/1tdl47XLlkSKII75q4vHiiMfUpzzGz
	 qGK/u2K08DVjg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:04 +0100
Subject: [PATCH 06/21] hugetlbfs: fix deadlock between hole punching and
 memory failure
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
Message-Id: <20261125-hugetlb_fixes_2-v1-6-db27fd2f71a8@kernel.org>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5106; i=david@kernel.org;
 h=from:subject:message-id; bh=8Ks2EUC02lGqJ75Fw8MnkFmyG7Ap+d4rJhnmmYI1Rhc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1RcNk/jPB8lsK6CY6/E85woho3/zc0WJMVvMX3g7
 /D7xfopHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExE8jzDf8fJ9sIrVruEJDzt
 lPhmECz0s2C7kZcZi/S5vZP+qO9hKWdkeJb0ILqSp4Zr/3OtJBHnRRb9h9SeSs/Vvmt0Q++LUfk
 eFgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

Punching a hole that isn't aligned to the huge page size can deadlock
against memory_failure() on a mapped folio at the edge of the hole.

hugetlbfs_punch_hole() locks and zeroes the partial folios with
i_mmap_rwsem held for write, following the hugetlbfs locking order
documented in mm/rmap.c: i_mmap_rwsem before the folio lock.

However, try_memory_failure_hugetlb() locks the folio first, and then
collects the processes to kill under i_mmap_rwsem:

    hugetlbfs_punch_hole()              try_memory_failure_hugetlb()
    ======================              ============================
    i_mmap_lock_write()
                                        folio_lock()
    hugetlbfs_zero_partial_page()       hwpoison_user_mappings()
      filemap_lock_hugetlb_folio()        collect_procs_file()
        waits for the folio lock            i_mmap_lock_read()
                                              waits for the writer

In fact, the documentation is outdated: hugetlbfs_punch_hole() is the
*only* one that still takes i_mmap_rwsem before the folio lock. All
other scenarios always take the folio lock before the i_mmap_rwsem.

Only memory failure can deadlock with the hole punch:

* truncation and hole punching of full folios are serialized against it
  through the inode lock
* unmap_ref_private() holds the lock of an anon folio, not of a page
  cache folio that the hole punch zeroes
* migration only tries to take the i_mmap_rwsem.

There is no need to zero the partial folios under i_mmap_rwsem. The lock
only protects the VMA tree and PMD table sharing, nothing about zeroing;
the inode lock and the folio lock are sufficient.

Let's fix it by only holding i_mmap_rwsem while unmapping the full
folios of the hole.

Update the documented locking order in mm/rmap.c and the function
comment above hugetlb_folio_mapping_lock_write().
hugetlb_folio_mapping_lock_write() could now take the lock
unconditionally, but we leave that for a separate change.

The order of the folio lock and i_mmap_rwsem now matches the one for
other folios, which is nice.

This has low urgency, as the race shouldn't really happen all that often
in practice (never seen).

Fixes: 68d32527d340 ("hugetlbfs: zero partial pages during fallocate hole punch")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust comment and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 6 ++----
 mm/hugetlb.c         | 3 +--
 mm/rmap.c            | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 4a92f31c88e1a..2e8672ae2fd52 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -684,8 +684,6 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		return -EPERM;
 	}
 
-	i_mmap_lock_write(mapping);
-
 	/* If range starts before first full page, zero partial page. */
 	if (offset < hole_start)
 		hugetlbfs_zero_partial_page(h, mapping,
@@ -693,10 +691,12 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	/* Unmap users of full pages in the hole. */
 	if (hole_end > hole_start) {
+		i_mmap_lock_write(mapping);
 		if (mapping_mapped(mapping))
 			hugetlb_vmdelete_list(mapping,
 					      hole_start >> PAGE_SHIFT,
 					      hole_end >> PAGE_SHIFT, 0);
+		i_mmap_unlock_write(mapping);
 	}
 
 	/* If range extends beyond last full page, zero partial page. */
@@ -704,8 +704,6 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		hugetlbfs_zero_partial_page(h, mapping,
 				hole_end, offset + len);
 
-	i_mmap_unlock_write(mapping);
-
 	/* Remove full pages from the file. */
 	if (hole_end > hole_start)
 		remove_inode_hugepages(inode, hole_start, hole_end);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0f3db932266d7..befa2670cb03f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1871,8 +1871,7 @@ void init_new_hugetlb_folio(struct folio *folio)
  * Find and lock address space (mapping) in write mode.
  *
  * Upon entry, the folio is locked which means that folio_mapping() is
- * stable.  Due to locking order, we can only trylock_write.  If we can
- * not get the lock, simply return NULL to caller.
+ * stable. If we cannot get the lock immediately, we simply return NULL.
  */
 struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index fe354fa6cc43a..f35b671d26514 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -49,8 +49,8 @@
  *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *     vma_lock (hugetlb specific lock for pmd_sharing)
  *       mapping->invalidate_lock (when allocating page cache folios)
- *         mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
- *           folio_lock
+ *         folio_lock
+ *           mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
  */
 
 #include <linux/mm.h>

-- 
2.56.1

