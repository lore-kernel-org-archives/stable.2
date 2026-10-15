Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E73E1CE4;
	Thu, 15 Oct 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080467; cv=none; b=YTY6oRRNwo6hgQTcoDzpaCuxVQdanXa7PFnUQKJJQLakwm7NFyotBPtTvkLluTJ7nClWnoygO+0dWEK5cX3ftCOf7180VKkbOkdR7OdTMZ2RB3y96DQJqmloW1dPjeEUSZwFPiU9urOYPe1XyogkDLSqdTLjoNqqDwybiwKj2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080467; c=relaxed/simple;
	bh=9iPymqgWixsb8XHF4y8ArQPMoEGci1kIerOEwFe2tIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvPiRwh8lcraFBl3nc0Ssd7hFevbO++VmAXJvkFQpHfAtcWpbJLeQLQZdysUfhNHD8sQNJcl8Kti5mSKCkN0FjhAPYO/9hi5RkbtNrtZgfXOfMh87Q1aKPTWQLcMz45sw82Tjukk5ToTt7uA90pBMcVchCURLxh9GGNeP3djklo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Srjq4clX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Srjq4clX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699971F000C9;
	Thu, 15 Oct 2026 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080454;
	bh=36klJXXC0aAnOR97CHQ7Hc6li6xJpMIjRx0K78eNZ4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Srjq4clXVSQXEKQQlseICrzLRzIL6wBQhcIt4doE6Kwl5gbMmc0wlsf6RN8bK1LLn
	 zhWDaGukT2jrCeQzR2HzZ3LozLDLPs39jjDarJ15nC6DD23d8gb3jazVZqXv21R+AF
	 v9w8crQBLYPFVy1/JBxiOdNYElWhXNJE193aSkpDaqlg8QTSA7oC1szVNXNkY7uh3R
	 OCdxnZGaJtcVHFF13Mox6RIxXCbJoIghfz3LrFcsyV7Y42FhpXp+/H+zk2ngsQVUzw
	 cIvoFw3KkFURsSvPVUyJUqiQOsYU+sAy29s7hQg92vQR+mSRS+J8ehoikT9/fn5Eup
	 HVFEXI1FOkPpQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:08 +0200
Subject: [PATCH 02/10] mm/hugetlb: fix use-after-free of a new anon folio
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-2-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3241; i=david@kernel.org;
 h=from:subject:message-id; bh=/+TVzqw3aRMIyr8brH6Ah9l55OImF6leRLWzdkIev/I=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DJeq/J/o3CE/kphCbsFRw9VzbnyqWO/yvPul9WtO
 1YpnG1M6ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAih+4z/M/M1Fbq81TtXKcW
 fiPFQoOh8nS3l9TJw1sFVwre2LunYi0jw97l0wt0ndl1HFWPhOy5eKTqrmHievE75rtz30h47L2
 kzw0A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

For a fault in a private mapping with nothing in the page cache,
hugetlb_no_page() allocates a folio, locks it and maps it.  The folio has
one reference, which belongs to the page table entry from then on.  After
dropping the page table lock the function still sets the migratable flag
of the folio and unlocks it.

Whoever zaps the entry in between frees the folio.  The fault holds the
fault mutex and the lock of the vma.  MADV_DONTNEED and the first unmap of
a hole punch, hugetlb_vmdelete_list(), do not take the fault mutex, and a
private vma only has a lock if it owns a reservation map: not with
MAP_NORESERVE, and not in the child after fork().

Then the flag is set in, and folio_unlock() is called on, a folio that is
free or has a new owner.  A surplus page goes back to the page allocator
while it is locked:

  BUG: Bad page state in process init  pfn:108e00
  flags: 0x200000000000059(locked|uptodate|dirty|head|node=0|zone=2)
  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set

A page of the pool can be given to the next user, of any file, who locks
it and loses the lock to the late folio_unlock():

  kernel BUG at mm/filemap.c:1532!
   hugetlb_no_page+0x111b/0x23e0
   hugetlb_fault+0x3a9/0x14a0

An unprivileged process is enough: threads that write to a MAP_PRIVATE |
MAP_NORESERVE hugetlb mapping, threads that call MADV_DONTNEED on it, and
one that takes the freed pages for another file.

Until commit 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for more
pmd sharing synchronization") the fault held i_mmap_rwsem for reading,
which everybody who zaps takes for writing.  The lock that commit
bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs") gave
to private vmas closed the window again, but only for those with a
reservation map.

Be done with the folio before the page table lock is dropped, as
hugetlb_wp() is with its copy.  The function already unlocks page cache
folios under that lock.

Original fix generated by an LLM and sent in private by Josef.

Fixes: 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: simplify+move comment ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cea25773a6c95..ce9e87228ec62 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5949,8 +5949,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		ret = hugetlb_wp(vmf);
 	}
 
-	spin_unlock(vmf->ptl);
-
 	/*
 	 * Only set hugetlb_migratable in newly allocated pages.  Existing pages
 	 * found in the pagecache may not have hugetlb_migratable if they have
@@ -5961,6 +5959,12 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 
 	if (folio_locked)
 		folio_unlock(folio);
+
+	/*
+	 * Hold the PTL until we're done with the folio: the page table owns the
+	 * folio reference now.
+	 */
+	spin_unlock(vmf->ptl);
 out:
 	hugetlb_vma_unlock_read(vma);
 

-- 
2.43.0

