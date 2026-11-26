Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703822;
	b=I28yEpt2gnOPZQHvgbFTFDgFpLxYdjEiNhL5i5dWTp/zhpX/QNpnX5Ja5pmFGr8Vybqe
	 O816wE3ik0XttuMyZ4zFurxPYEOIm1k42SfB8fBOQeFjScuKE4BbzzG4rjrqP8Nckcg6k
	 IEL9561jpG+XaV+2XadcEdArcdWC3M6f+X5KGzGcxQWpR5ZYDkBoWHADMLHVjd18P/zIr
	 5P1SWWLCnGCr2hcTX2/uLJcWU6dDBbkxY/w6ty/YnBrYU5Nso4i5AGyLvpREbRvZKMIgh
	 +PxYnxPfsP7lzkK+uB7bt0C+IV1hiFLKANxmvw0y9C/Gl20H2M8cl2mrLmBx8duqdvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703822;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eIY/cZ2ZGAVUM/6AhJkgxHUgyfzR1EyOHoWRylAwhN4=;
	b=iNhpJ76QUHuajJHCgT+WdDQ0/hl6cMU4ozmhVsh9wHD3nMxHlWihyr1lAnUNlcmZj6OO
	 XwujusyoJ4e0Twa2woRw+ee/KEZZNFPhgkKrGDaWgojV6KJoglavVpHkmdRNIZ4regaQ/
	 857jl1Lmwmrae0Ow0XNZKEqbioO2uNgQ77ZdiDNfhdrvfpvR7r84LUVviuHx3H6UtQfZ+
	 Agm21JSxQkz6Xwxm0Ill502ldbHmlIK0d9QjpcYDobpHZJvA1xfTtLUIro0Gkw8IAUr9V
	 3fIVSIJkSX0u9Kmu8o1g4RFKx1rvb2Mm3YFI4HmPAGi25aBQUhVkeRa46nURlM0/kRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki0jOakd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17895606A321;
	Thu, 26 Nov 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki0jOakd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50E31F000C4;
	Thu, 26 Nov 2026 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703821;
	bh=eIY/cZ2ZGAVUM/6AhJkgxHUgyfzR1EyOHoWRylAwhN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ki0jOakdQF1iXDy3TJX0E5xo6LK+YbuXi9dIEhripoCQV4WV+xvA3OH/LZnpD25Iu
	 6Q8lo7zG+0bQeKTw8/Pco5KhC5QGkIFkRfOCwFA/csCSjM83l9y0KpVadXvFn6Dtpj
	 ybdJ3va/vE8aJNaJl1OU2hEiOJ/ubkS/HjnplrjFzPvPvE0VDSLV3WY3JRFgU9w+3W
	 NtuYybHzbdE/C9dzEkRnh/rt9x/3x+G68hdO1MaDjHzW1Q+f9N6xz+9TNBBTcwuY/s
	 NdM3KPYV8e1F2dJMD4cORPeLfC2TPMY539WYCvqH4SBtcOTEbBMy78vj4+kAzMwSPr
	 J4ALFHaT4fQFA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 26 Nov 2026 14:36:22 +0000
Subject: [PATCH v4 4/4] mm/huge_memory: only compare PFNs of huge entries
 on huge fault insert
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
Message-Id: <20261126-huge-pfnmap-fault-races-v4-4-feecd58bb14f@kernel.org>
References: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
In-Reply-To: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, 
 "T.J. Mercier" <tjmercier@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3097; i=ljs@kernel.org;
 h=from:subject:message-id; bh=K+RR+33UGV2GmJYO6SEBtAFdDaiBsoC1Eii+CMY/7o0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5nF/IrZx1jPHhnx2cyyMaez4vXfb3m1dBFL+f+11x5
 ZYbj76e7ShlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEtk5i+KfM7WTMG/mZjc9+
 plpR9oe730P9c02m9e1h2zR/T5RV0nKGf2rh61mrRWdF5S2LsWovDDqS1LKj/vZq9v+RdtMEl6u
 fYAUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A driver that implements both ->fault and ->huge_fault must anticipate
concurrent use of both.

This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
concurrent with faulting, as that only holds the mmap write lock and thus
does not exclude faulting threads stabilised by VMA lock.

insert_pmd() and insert_pud() have issues with this as they both assume
that, if the page table entry being populated is not empty, it must be a
present huge entry.

This is problematic as if it is a write fault, it compares its PFN against
the one being inserted, warning if they differ, on the assumption that the
entry is a huge leaf.

Since the entry may be a page table, this is invalid and can result in
spurious warnings.

Equally, the entry might be non-present. Nothing can install such an entry
in the VMAs that reach this code today, but there is no reason to rely upon
that.

Therefore only examine the PFN if the entry is both present and huge, and
otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handled
at the appropriate level.

This is what already happens for a read fault, for which the existing entry
is not examined at all.

Target the commit which introduced the first driver which both mixes fault
orders and passes the write flag for the fix (since this commit, both
drm_gem_shmem and panthor are prey to this issue).

Reported-by: Eliav Farber <farbere@amazon.com>
Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon.com/
Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ca9ca39d2768..b15e5b22b180 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1644,6 +1644,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
+		/* We may have raced a fault which installed a page table. */
+		if (!pmd_present(*pmd) || !pmd_leaf(*pmd))
+			goto out_unlock;
+
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
@@ -1775,6 +1779,10 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
+		/* We may have raced a fault which installed a page table. */
+		if (!pud_present(*pud) || !pud_leaf(*pud))
+			goto out_unlock;
+
 		if (write) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
 				goto out_unlock;

-- 
2.56.1

