Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776400;
	b=qNEWIaLDRasW1ggdg7dCzSKQBVz+vJ8xrPqHAFQi0tn7lQfjhDZ6nbstEV5q/6ZvXTjM
	 tzGRHY+hManE03Pa4CQtSjfUpFl2FmAj68utDMcxHCeufpfW0xScIvrq0jUuUiI8k2kRO
	 t73DvTYGZzvhchHxUN4nOpVGq+5/X7CjdFyBZ87IJOBOhFODq2CBLkpBF3902uBvWnDQq
	 HUVFz3kTl+4eJlgzyAsPuCMl6Pi8QOABcZXdN/YaZqjjmmTrqXSFcThDXDFOwNDZroPpx
	 XR4ochRMBxM2bGLuX7TcTDj1WwpSr73sieOo9bxDKEvkNx58hXG5CoNda+KgDCLqEgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776400;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=y+bR5cBurono24Kw/wb/TbttycTR3O4Q2jD2NlUXMHg=;
	b=uy8bHu3ykkLQD4TU6Z7+zz667H+cWo1YFhSzTckG4kafIqzTsYutMisP+JKwZBdQkLde
	 ACHjEPjw+VyqhOwez1tC39zYCNaKM6euAlf4dyO7MbjJqb5gpgBKxs5SbBfbqrzC9U6bT
	 vDXlY5UECa53/mPq3245jEbgW/i1AAyaG5zVtm7xOsutYLZaCue8Dz4Z1ADa1UaPU7fMm
	 sFel0Kt+xTrOI4qE5lvgzNUR1Vl/OKXvSQTxMohL5C7kUVDIRaoxuiIZbEM4+a/jGpkQ0
	 Huqg/D136Ttn1Eh7iZZ8TnE8uodcWPHezdJDPDJwHsiGypEGUtAmVWag7NPNOdaisHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzRS1V51;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734A606A331;
	Sun, 15 Nov 2026 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzRS1V51
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154A41F000C4;
	Sun, 15 Nov 2026 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794776400;
	bh=y+bR5cBurono24Kw/wb/TbttycTR3O4Q2jD2NlUXMHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gzRS1V51pltUaGQ4clealxmv+V5VlpuxsykAnivxRreKaD5ic20+Pu+EjDTnilpIS
	 QICOE3KhDr2nwmNf1Y6+bnsw3M4GMmbwKcruWOBqCYRygaZgqmtzHinhQDl/I63sG9
	 xz5tI/W5GRrnMKiXOo1vD5XZhZ6+2oOVUn57pIeBS0T5GxUzRZQH5d9ZKFbUVlTIkc
	 2soeI8WV9qapMO56490VxJO1BAlyUYTgWsn80tiCDKcVmKA6GjNx+qyvI8UTvl8q0n
	 xwF+oME7WmzjhG4Hm0LlIT/RB4ULgXGYIv2cW364RuiRTe+Mvi0U7pZBjMBqZMDpOA
	 YdPD2menGUUZA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sun, 15 Nov 2026 20:58:21 +0000
Subject: [PATCH 2/3] mm/memory: do not report OOM if insert_pfn() races a
 huge fault
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
Message-Id: <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
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
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2512; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Kb306QFNS082In8qH6Nh+EfDd8c/5dSFK4umAapy0uE=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJ+yTpxCM+ta522yuXs32IXY91zdfN0ptezpjqcO/42x
 7E0TfxFRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACbyZy3D/ygG6ZuM5pH/RdtZ
 rV8eebwwNu+FyPlKs2M37C5wFJVvmMLwP5GJIYeT9dSpDy1LI+/Ulzu1HaqM3e0eXqFUybS7vug
 TFwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Eliav Farber <farbere@amazon.com>

A driver that implements both ->fault and ->huge_fault must anticipate
concurrent use of both.

This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
concurrent with faulting, as that only holds the mmap write lock and thus
does not exclude faulting threads stabilised by VMA lock.

This is not currently safely handled by insert_pfn(), however, which
obtains its PTE entry via get_locked_pte(), and treats a NULL return value
as an allocation failure, returning VM_FAULT_OOM.

The issue is that get_locked_pte() also returns NULL if the PMD entry is
not a page table which can happen if a concurrent huge fault installs a
huge PMD entry between __handle_mm_fault() observing the PMD entry to be
empty and insert_pfn() being invoked.

This can result in VM_FAULT_OOM being reported incorrectly.

Address this by proactively checking whether a page table allocation
actually failed, and returning VM_FAULT_NOPAGE if the NULL indicates that
we were raced instead.

The same assumption is made in insert_page(), however only DAX implements
->huge_fault and can reach it, and it serialises faults of different orders
with its own mapping entry lock, so it does not require a change.

Target the commit introducing the first driver able to do this.

Link: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Signed-off-by: Eliav Farber <farbere@amazon.com>
[ ljs: rewrote commit message, trimmed comment ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e03110906aa8..cff39eccfd42 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2866,10 +2866,17 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, entry;
 	spinlock_t *ptl;
+	pmd_t *pmd;
 
-	pte = get_locked_pte(mm, addr, &ptl);
-	if (!pte)
+	pmd = walk_to_pmd(mm, addr);
+	if (!pmd)
 		return VM_FAULT_OOM;
+	if (pte_alloc(mm, pmd))
+		return VM_FAULT_OOM;
+	/* We may have raced a huge fault, if so let the fault be retried. */
+	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!pte)
+		return VM_FAULT_NOPAGE;
 	entry = ptep_get(pte);
 	if (!pte_none(entry)) {
 		if (mkwrite) {

-- 
2.56.1

