Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621775;
	b=o/RmZzt4FcJxlL/6aGSQel/l5VxxjS7u82Lp+9NvC61ZuZIMtMWzsVERxIv669aLwkut
	 l0eo/AlD68iCZO+yJarVeu9Uf3vApc4Jae2zZK1t4HGn/aN5NvMaodLXSKar5yBX/qbHa
	 3MTcZSH7oET/LnwYUhFKsT3e5eZ/2SRr1iizd72cNpjZGtYOyZ5/u4yYAInRx9FDHn0B9
	 FOJ0VbOQSiTd2k3Jc2QL1H6loFtGde+CwuOKxROjRrgBD6VOMqZCIn6A2B9h2VhPI1cSv
	 U3QSfq1Qy+6cLq4rJwWV1qLqBe+1AuCMKojEk+bJbJ8udcvu4kX77308e/mv1pznZ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621775;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xwN7N2TJ/AxtSCaqTfLM9jPZ0Ogy+48kHJQgnpkXTHY=;
	b=WVQTBV4cG//VvIZHyBM45f1TPQ8Qke9U3XDuNOR2KZNRap1axnanK+FpNwBN7rMbtBzX
	 1Bnt8Nmlo8E3CLc9+qyODVf44P++cZi9NRKFSPnb/tH6TPSOQvUcRsgWLhUH75/pYzmRt
	 Zy5jHQqkvPh137Zt9UhqnoVAmshWlONDFfnWR9C6VLmoUxdzVtuOYtVRd0TyT6XH07PP8
	 F3UjaEAEsE4H25HW2jBqfpREZ+BwJNB34fT08Jl/ciuY4lSJ19X2foKbGIv59wX4mbdS8
	 +6IsOXnWOLzRv1XDRpqPITvLVB3L4hY3vjtVBfT6fX40I5wadPBwAivYt88hz276ktA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOOzE1Ia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B932606A332;
	Wed, 25 Nov 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOOzE1Ia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BE81F00ACF;
	Wed, 25 Nov 2026 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621775;
	bh=xwN7N2TJ/AxtSCaqTfLM9jPZ0Ogy+48kHJQgnpkXTHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LOOzE1IaHjp88Xb0pe3QCQu7CIqsf9lvB2bWUHMyrquKLsE4mk3eSefypXwCchx3/
	 EgDm9WYoe9egxS4uzllqv4tVecTYA4VGcRRpMrF6IZn9+kOnaqnGiTyRjV7ad+DIPf
	 kiRZkpUSghvkaz+DxSJ+hB7Rae8h02h/GXcc8vmDBYeLGWK4fZygL3H/I2Bdj6bkGJ
	 PagDwhj4P2FJg4JoA/yA2/SGYxaB/eZmY3/+F9aFz++Kq0PaHWKz/qGtQ3rUCGL2vn
	 zoCiluotK1PIu1HVzJVPeNyK1XVICu+74JYxil/rYHKTDWqn5RR6PbqKKTDQ5drbOj
	 C9Ap2JSXYBDKw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 25 Nov 2026 15:48:52 +0000
Subject: [PATCH v3 4/4] mm/huge_memory: only compare PFNs of huge entries
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
Message-Id: <20261125-huge-pfnmap-fault-races-v3-4-bbc44489341b@kernel.org>
References: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
In-Reply-To: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
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
 h=from:subject:message-id; bh=JsUg5bNeXJ+T8vfVeKVvW7LaLcQrJO3bFcpJ22VjJ8o=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLZmTPfaT6JTWB5lP5ylWZvkL14xaT58xaapXudKV8gP
 EfJy/VyRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACayKZThf43eEc45337s6NKu
 8KqICTCase4gU46K+67dvwI2BukI2jH8d3qlIGQX9zWlsqs5fHu0RUjLPMtZCc/23ZmvE/zhVqU
 aFwA=
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
index 0d589be136d2..ab267ad48020 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1643,6 +1643,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
+		/* We may have raced a fault which installed a page table. */
+		if (!pmd_present(*pmd) || !pmd_leaf(*pmd))
+			goto out_unlock;
+
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
@@ -1770,6 +1774,10 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
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

