Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993682;
	b=L9kGVjGYOx0ZYFhHiTZ2mOUK5KE4rdlg1KmwmMgPaseAzbOUFF/RzTMVwZk28QtP/3sO
	 KOeiESzrJLzY8xMSgOwR8gvopCB/wt0XvqtIAbY6BTjJ7E+5+6sqoaKCMpLexvbNZLyMA
	 Zn2ByOQPzf2YUfY76vx13UdyDEWbEvyKPK27+NCjOeK0DtSQYaeMIEtvwoESFi25PK0ct
	 obm2LIXKh7jKthY5Yr7uUpjcr9SJhcQiyWaKZ4fPGe13HrCXKrOYdJekPZYmy26dGCghm
	 wh6GhGzyRoHW8KQpcQDnDmHI+91tvW48/IIAlSsFsntZ/iPc8tYqMgNiOwVhQSGVfRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993682;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Bwt+W10TXQFxJoo8KiCnGMFoLN25LK8LTHzrqrXkSOc=;
	b=Ct9oFu0af/ol88oPCjEq34yVYXe6/sOsYwjvfzhBdyHfqGTe6Ay6+COK5rpZiQgNYyw/
	 OQkwpoDgFGEZ7zVFukk3MH2KX+fzkbeYXUeDXgvrAG3HxMjeF2+l7d+8mSjMtr9Ht6N4P
	 EnnDOVsnMyWETfwHVkfmn5vnddJ20yRIM/nEqmgh/dMgWZMowxplOmNvtlEXNq3ev3ti+
	 n3XO7uVSkrUU/DM0L4o+XtRYCBEWL0/G2XraiPJH8uJH5ISfOyMO4IXzHhKwEbnY5RSQG
	 NyLoYhpHe6IylNt9Q1kfJvOBrEFm2aXeHSRx/2ZL/AtANEx5ujcHiiBg2QGNKUdW9SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Krm1hHYo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33BF606A31C;
	Wed, 18 Nov 2026 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Krm1hHYo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0C91F000C4;
	Wed, 18 Nov 2026 09:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993681;
	bh=Bwt+W10TXQFxJoo8KiCnGMFoLN25LK8LTHzrqrXkSOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Krm1hHYolUXKUV8kGXxVGoFFO8pHT4nd92g2hABlny+AAHIkHYUzNTFWYRo8fEFLA
	 11oYemQujHj0tQS1u3CNRVRfWXZYWwfdv9dw4bCwCYU4y6l9GYeJTDeH1vJOtQMMyn
	 IS3sBH6kVI3Pvy0+xLqp4rLrcWcaaAg0qyKGMHghITzpKZF0/nevUgftqUeBgzxS/G
	 Or1enOAY2eG+4TZsewqvVVi6GAnAZRd71X1DguKwTgImBxxw8P/JaScgWUt6wjjFoS
	 eUEM9WA1umgchwM6YPthDeRuz9ORAZck+LfYbF49N9p/cJ9MOnzsfshbatArtjfJ+O
	 djbtdgYe8xJfA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 18 Nov 2026 10:20:36 +0100
Subject: [PATCH 1/4] mm: flush stale TLB entries before installing a CoW'ed
 folio
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-file_folio_flush-v1-1-e9e739ed14e0@kernel.org>
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
In-Reply-To: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, 
 =?utf-8?q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>, 
 Zhang Peng <zippermonkey@icloud.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
 Mel Gorman <mgorman@suse.de>, Sasha Levin <sasha.levin@oracle.com>, 
 Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
 Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3072; i=david@kernel.org;
 h=from:subject:message-id; bh=vwroXr9eWRQHq49VFaSRfOp1HZye8BrM6x31oeidRtA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+5v68u0hITPduqFlXiRqjxrPI43MWrA1YpbZT6T733
 GNXQzdrdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRk3oM/7R1Np2a6j5fO0zq
 4YauGIPgH0Il6dMzf5bNuT7tGH/++seMDJPm+agf3lkXlv/ALu7uxY+fDl1+oTY/YsYp17ybzeo
 HMlkA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Zapping PTEs in zap_pte_range() defers the TLB flush until after dropping
the PTL for clean page-cache folios.

A concurrent write fault in a MAP_PRIVATE mapping can then CoW the
page-cache folio and install a new anon folio without a prior TLB
flush:

	CPU0				CPU1
	LOAD(ADDR)
	 -> #PF
	    installs R/O PTE -> A
					fuse_open()
					 -> invalidate_inode_pages2()
					    -> zap_pte_range()
					       clears R/O PTE
					       // delayed flush
	// Other CPUs (incl CPU0) still cache ADDR -> A
	STORE(ADDR)
	 -> #PF
	    do_cow_fault()
	    copies A to B, installs R/W PTE -> B
	    // no TLB flush: PTE was none

CPUs with stale TLB entries will still read from the old folio while writes
go to the new folio, until the TLB is flushed.

We really must process pending TLB flushes if we are not faulting the
same folio back in.

Fix it by flushing the TLB before installing an anon (CoW'ed) folio in
set_pte_range() if a TLB flush is pending. Zapping itself stays as fast
as before.

Other faults are not affected: unmap_mapping_*() users only remove
folios from the page-cache after their own TLB flush, so until then, a
refault maps the same folio again. The exception is a concurrent
invalidation that removes the already-unmapped folio from the
page-cache before the zapper flushed the TLB; that is an unlikely corner
case that we'll not handle for now.

Note that we don't care about MADV_DONTNEED followed by a new read
fault, as MADV_DONTNEED only guarantees its semantics once the operation
completed. CoW faults will flush the TLB either way.

For example, imagine that MADV_DONTNEED zaps a page-cache folio and
doesn't flush the TLB (but still holds a reference). If the page-cache
replaces the folio, a new read fault might map the new folio without
flushing the TLB. That's okay, as MADV_DONTNEED did not complete yet.
Same applies to MADV_DONTNEED of CoW'ed folios when re-faulting the
page-cache folio.

Memory reclaim, which removes folios from the page-cache before performing
its own batched TLB flush, will be handled separately.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Cenk Yılmaz <cenk@deepfinresearch.com>
Debugged-by: Cenk Yılmaz <cenk@deepfinresearch.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index d2f48d78b0d7b..e1d9759e6fde1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5888,6 +5888,12 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		VM_BUG_ON_FOLIO(nr != 1, folio);
+		/*
+		 * Concurrent zapping might have dropped the PTL but not flushed
+		 * the TLB yet. Flush before installing a new folio.
+		 */
+		if (mm_tlb_flush_pending(vma->vm_mm))
+			flush_tlb_page(vma, addr);
 		folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 	} else {

-- 
2.56.1

