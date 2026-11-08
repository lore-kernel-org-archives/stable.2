Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794129309;
	b=Rg3JSsVOWPtjxJO0h/ELIKlK3Ff7qhENc0cRQUfDynILV6Fwksy8rd2RXmqeJYsMgAS7
	 /rkxkIM46kS9JtHV1H5vslrP3LfNh4VpHzO0Nqi1j6Xe4rmUeRWRkEsgDVb1yZqmYPihJ
	 GE21k403MSqKeWmgdLgBqMBObFoMFSo9uKR8EdIG7h9f3bn/xvPbiSp2xb0vXvemsDGGV
	 OO1opioGH86XDTZrX1BcOcPWFfWdSmOWGIn7T7WQG/MN3nTVFcNOhLNK4PSEZHyhgcE7Q
	 DWDIoljS8zaSBjerf8N6IYyKfEvDLcGto91Anz+1XkDL+THHgRL13QUzIFXHf4MWGuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129309;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LeQtM5VzYu47mMivuajAK9kUAFs5kDbX9OFi64Z8JXs=;
	b=uUim7Bjiu8tkI8kdBqjTwIrqt2a6+iZo84VX87ZGPPxdoZcba8tbzeKsE/JJU1VxvmQx
	 VhVDdpEvklz7J+Xxg/1RTKgEZ8kc57UYR6yOJ9GyJx1lgXbYO6/sH2X/Lw2WFVE6dwGAx
	 MbozUMqSBMP+zHuUHujyg0rN2RCuRef5b/DfPXjWOqr4LlaMIXkbEZwPdjPmRqpqLnkXl
	 uwK9jTnA9Mnaghxwu7sCGP1KGnhV3sHIukrIYe6WhbZJFhkFWH20XLP2Uapz1fnvc73wv
	 FNgRdYGEEei4MNiZIdY/tPkvIIMlvzhJe3zLyDTKLgT77A2cQ6oRYB06hSzjZRczQwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jPglDm2r;
	arc=none smtp.remote-ip=91.218.175.190
Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0F606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 09:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A0F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jPglDm2r
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=t4Z7aeZNT5PlqzzWkin+BcsnPWpstMOaNJUW6KAwwws=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794129304; v=1; x=1794734104;
 b=jPglDm2rDcjeZdDo5iLArbqU/YoZm7OXvO6MSf4ZypK3bkncRkj1eBPoG4CL9ApVzJNOZ92A
 XF4dMJAi6mxkFGS9cEiaQkoI/vNzJhnQt1ZGuMwpkHHHJqqPQqUxvBxcrw0DRcjzD7qncmDzYBN
 qerqr5g6hvdhXxQdmnkZ6b+M=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4eda76d6e28ebe59;
	Sun, 08 Nov 2026 09:15:04 +0000
X-Mizu-Trace-ID: 4eda76d6e28ebe59
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	qi.zheng@linux.dev,
	hughd@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: free unused page table allocated by do_set_pmd()
Date: Sun,  8 Nov 2026 17:14:55 +0800
Message-ID: <20261108091455.88759-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261106-khugepaged_set_pmd-v2-1-d2457b5e377a@kernel.org>
References: <20261106-khugepaged_set_pmd-v2-1-d2457b5e377a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Nov 06, 2026 at 01:36:12PM +0100, David Hildenbrand (Arm) wrote:
>do_set_pmd() can allocate vmf->prealloc_pte on architectures that need a
>deposited page table, such as PowerPC with the hash MMU. If the PMD is
>no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
>without consuming that table.
>
>Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
>userfaultfd operation can install a PTE table before taking the folio
>lock. If that races with set_huge_pmd(), the unused preallocated table
>is lost when its local vm_fault goes out of scope.
>
>Track whether do_set_pmd() allocated the table and free it after dropping
>the PMD lock if it was not consumed. Preserve any preallocated table
>supplied by the caller for PTE fallback. Successful PMD installation
>consumes the table and clears the pointer.
>
>Returning without a preallocated table matches the existing behavior on
>architectures that do not need a deposited table. All callers
>already handle that case.
>
>Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
>Cc: stable@vger.kernel.org
>Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/memory.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/mm/memory.c b/mm/memory.c
>index becf53a2a0944..421064aef3cf0 100644
>--- a/mm/memory.c
>+++ b/mm/memory.c
>@@ -5687,6 +5687,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
> 	struct vm_area_struct *vma = vmf->vma;
> 	bool write = vmf->flags & FAULT_FLAG_WRITE;
> 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>+	bool pgtable_allocated = false;
> 	pmd_t entry;
> 	vm_fault_t ret = VM_FAULT_FALLBACK;
> 
>@@ -5725,6 +5726,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
> 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
> 		if (!vmf->prealloc_pte)
> 			return VM_FAULT_OOM;
>+		pgtable_allocated = true;
> 	}
> 
> 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>@@ -5755,6 +5757,10 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
> 	count_vm_event(THP_FILE_MAPPED);
> out:
> 	spin_unlock(vmf->ptl);
>+	if (pgtable_allocated && vmf->prealloc_pte) {

Took me a sec ... to see why we can't just check vmf->prealloc_pte here
...

Emm ... as it turns out, the caller might have supplied it for fallback :D

LGTM1

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>+		pte_free(vma->vm_mm, vmf->prealloc_pte);
>+		vmf->prealloc_pte = NULL;
>+	}
> 	return ret;
> }
> #else
>
>-- 
>2.43.0
>
>
