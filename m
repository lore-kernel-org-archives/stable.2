Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306129;
	b=ooeda9ddoOm/+3HzqAn7elRzBqol2bCNwMF79Bd/riYjPQ+9GtayxQPnxCu8Jp0KuKU/
	 3AxutKg/G9su80W1vUvf0ge09DmyYtSeTOv1I/AK1sSqRfBDZ2+dnfDRQAxVAeGyae5wj
	 flkTEtx1CEVtYmw5jmyw41ljJWQAQ0SG00jk6MORlm3dJdhTXsu4bmXZcdYJ0lgVI+x09
	 nIEyZYJvHHgtRh7QZ/jLFtnjL7UG7qLwvO4aX845z9G79ghDAMEKBnDfkc+uzxQj6MAgr
	 BvO9adS2gwRcgiyFmwX0G2U9I/Dd/RVAl/KqI5abFCGWsB0Og2KDl1vEwKgd4vfqr+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306129;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JIqz6J3TwNkGVPVANkFEl6jPQa+Zivkvvh5bXw83jC0=;
	b=3YHt0z4X29s+o+6E9ZSF9yrI3hUQnvNARxIwTOzzFqylXsAviL6kDOs/0AJJcpc4oQ0K
	 C8Vvh4dhmxzCkR3fU5xxcjdGWqvYTFHMaRZt60VJtgdu1h/BQtcsyGKlfHRlvrErJELtd
	 fIffcjSkjEudhEam7ZFL1f8Jyvu28lSCI0gr4aPaPhYP6e7FaEWXcD6KiZswXaxT+Icz1
	 Aa56H9KT7giRoRSsn13mIkZpNQKMr6EfTeTFks1S1FR5J/On9BjxeIp0/3KqTjyyz812Z
	 bKWF0eP+1vCBDiVdPYQEI+mStBYwkV5CfbKHGvtPCHxT5lbJvga+Fc5hOFhxj2DM3yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnPvwTVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC5606A33E;
	Thu, 29 Oct 2026 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnPvwTVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655ED1F01825;
	Thu, 29 Oct 2026 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306128;
	bh=JIqz6J3TwNkGVPVANkFEl6jPQa+Zivkvvh5bXw83jC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TnPvwTVdhfq5HQD+vvFOcn8G/MzS9HbLRPmKgokJVWGtdm6ivj0/dhyWASnhrcLiL
	 ZN4i+CpGa5N9kOSCQrMCXDeUbAKZd7alG2BxvMvzAOROCgMDr/lTJTYYaKeE3rrAUR
	 6KzV1RVU74/NaDc3KZ+6vyUfDSmZIp6PCUP6k4Jo4eTEpk+00SbIdCuq90C0L/1uww
	 5wrHFXdgPxr05IDgusi0rT9Q93tvtbt4aVHs+6j/ScZMe6mP/IC9VohQbhhalkgC0q
	 lQY7qrUH+AxPdMcuMBp/OivDUp8Joxs/UCz+baxOhtfhMGCpnjd+RB2zjjKYEyxKVa
	 7Fspe6PVIpRvw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:03 +0100
Subject: [PATCH v2 08/47] mm/filemap: finish fault cleanup before dropping
 the fault lock
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
Message-Id: <20261029-fixes_core-v2-8-a64ce7f83abb@kernel.org>
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
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4079; i=david@kernel.org;
 h=from:subject:message-id; bh=8upppjNvZx+R13jPGAHHeYmNd3f41Ow9JcPqILGtH6s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer201VjohpJtZeHGJz9T8Nfl1gi+zM/Y0Vf9e1M5z6
 8v/jZZ+HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEwk3ZThf3KrZ4le176Zx1k2
 WFlwPoxvjXyys75Zl/v+LDPZu7qBLIwMDUqqbtfWHb9bzv588VNBExGh21FTHmb++uVxMNa+4tw
 eHgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

On a retried fault, a fatal signal interrupting the folio lock wait
makes lock_folio_maybe_drop_mmap() drop the fault lock without pinning
the file. However, filemap_fault() may still need to release
mapping->invalidate_lock. A concurrent munmap() can release the last
file reference and free the mapping before that unlock.

Defer dropping the fault lock to filemap_fault()'s retry cleanup, after
releasing invalidate_lock. If the fault lock was already dropped for
I/O, release the existing file reference instead. Keep the fault lock
held for FAULT_FLAG_RETRY_NOWAIT as before.

Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6b5e1d866a9e..b04be64a5069 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3308,11 +3308,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
  * @folio - the folio to lock.
  * @fpin - the pointer to the file we may pin (or is already pinned).
  *
- * This works similar to lock_folio_or_retry in that it can drop the
- * mmap_lock.  It differs in that it actually returns the folio locked
- * if it returns 1 and 0 if it couldn't lock the folio.  If we did have
- * to drop the mmap_lock then fpin will point to the pinned file and
- * needs to be fput()'ed at a later point.
+ * Returns 1 with the folio locked, or 0 if locking failed.
+ *
+ * On both entry and return, a non-NULL *fpin means the fault lock has
+ * already been dropped and the caller must eventually fput() the file.
+ * Otherwise the fault lock is still held, including on failure.
  */
 static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 				     struct file **fpin)
@@ -3329,21 +3329,9 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 		return 0;
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
-	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__folio_lock_killable(folio)) {
-			/*
-			 * We didn't have the right flags to drop the
-			 * fault lock, but all fault_handlers only check
-			 * for fatal signals if we return VM_FAULT_RETRY,
-			 * so we need to drop the fault lock here and
-			 * return 0 if we don't have a fpin.
-			 */
-			if (*fpin == NULL)
-				release_fault_lock(vmf);
-			return 0;
-		}
-	} else
-		__folio_lock(folio);
+	if (vmf->flags & FAULT_FLAG_KILLABLE)
+		return !__folio_lock_killable(folio);
+	__folio_lock(folio);
 
 	return 1;
 }
@@ -3572,7 +3560,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
  * vma->vm_mm->mmap_lock must be held on entry.
  *
  * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
- * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
+ * may be dropped before doing I/O or when aborting an interrupted wait.
  *
  * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
  * has not been released.
@@ -3728,9 +3716,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
 out_retry:
 	/*
-	 * We dropped the mmap_lock, we need to return to the fault handler to
-	 * re-find the vma and come back and find our hopefully still populated
-	 * page.
+	 * With fpin set, the fault lock was already dropped. Otherwise it is
+	 * still held. Release invalidate_lock before dropping either protection.
 	 */
 	if (!IS_ERR(folio))
 		folio_put(folio);
@@ -3738,6 +3725,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		filemap_invalidate_unlock_shared(mapping);
 	if (fpin)
 		fput(fpin);
+	else if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		release_fault_lock(vmf);
 	return ret | VM_FAULT_RETRY;
 }
 EXPORT_SYMBOL(filemap_fault);

-- 
2.43.0

