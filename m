Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799601;
	b=QZxxlOg097/NQo1ccs5FP67137tUGuYindeNSDXYfhbzFR1Qye65ClbPUpQt17GwN55D
	 VBUHLsjDkrd/UJ3S7tZW1he/5En7XH5HA7be6tsk67cM+fPyR9gVzJEwSHWH+egum/e6p
	 aOq94NVa+/HBJCV2wUn27QSQ3Pn/piNZ03TJTxHCiEK6/ReyzWAaI4uZ41aY6zKPRaq33
	 1a8XJQvFSfL9bTiyApYzdZUjpkALRe3RGT+gBCUTiDqKOV9gd1q8RL7ojZKYGyGSTrAFF
	 hBO3dsR4QLYJO9ocIMLxC8Ib4r99DsZGmTbzxrz0PwCTZUFuJfOaWWXNNYs0N10FQuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799601;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4DzoKJl6EWZkaiUxS2AOoO5HQVacT4R3GymKDwHucAc=;
	b=APpJ9rtw0HV5J+z8Rg+trNN7YfEisc6YUmSCllrJBYJ3nwZgnBucG10IEyN7kqaw3m+8
	 sms6ppa3jW2hDENAvKpdCps+xOxnFC7a1ml4dCA5S/ADpfJu5dV4ZZRu6R4uTQbeeguRF
	 pNFOBHcyjw7rHbWXApFLGeCJimqiPOJVNFpsIutlrcy0sJtiOA92aLm5Ek9qXOVEMjDy3
	 056SzQT56BT7irUSzZqkOVaAUL7X80cQz0htZbR2OETGu2O+9Mz6jqHPXCN2R0gOflhje
	 L2G4gY9bKKEame+al6pFRegywRK6kp3A21Ekq9AOoO0hFjGemv5rOPxQeaMDk3IhsJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KxoRtvzX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49EF606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KxoRtvzX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751E01F000C1;
	Wed,  4 Nov 2026 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799600;
	bh=4DzoKJl6EWZkaiUxS2AOoO5HQVacT4R3GymKDwHucAc=;
	h=Subject:To:Cc:From:Date;
	b=KxoRtvzXjgc+g/HviAOAwpgkuOewO/QYHIjyZp3i6MGl/+5PswYLf8FpdB3DVTUHP
	 2PxBDAFvLsSB7+6f6MeKIrV/S208MnKCQ1qehGbnuzM0/LQRQbeAqCMTwrEkTCbDaD
	 nAOD1D+9KoICssEdmRDaklRpMkozQn0jn1nA70i4=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix use-after-free of a new anon folio" failed to apply to 6.1-stable tree
To: josef@toxicpanda.com,agl@us.ibm.com,akpm@linux-foundation.org,david@kernel.org,jannh@google.com,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,linmiaohe@huawei.com,ljs@kernel.org,mgorman@techsingularity.net,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@suse.de,peterx@redhat.com,pfalcato@suse.de,riel@surriel.com,rppt@kernel.org,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:39:58 +0100
Message-ID: <2026110458-retreat-runaround-54e7@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 824cc56bf43c714319992bad3558803cac6e77c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-retreat-runaround-54e7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 824cc56bf43c714319992bad3558803cac6e77c0 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 15 Oct 2026 18:07:08 +0200
Subject: [PATCH] mm/hugetlb: fix use-after-free of a new anon folio

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

[david@kernel.org: simplify+move comment]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-2-42796911043b@kernel.org
Fixes: 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b017ae1dfd6f..16a3abb985be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5991,8 +5991,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		ret = hugetlb_wp(vmf);
 	}
 
-	spin_unlock(vmf->ptl);
-
 	/*
 	 * Only set hugetlb_migratable in newly allocated pages.  Existing pages
 	 * found in the pagecache may not have hugetlb_migratable if they have
@@ -6003,6 +6001,12 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 
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
 

