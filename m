Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095890;
	b=ARdQ1p9TuiwiFSV+K8IYtsX7DcvZEpkVkJdP0kO+ZLDLM4vL2UlsNqksS8isk9lni574
	 zDHxeU5u5bpC0IVEuJYCXBLcabn4jZpA7GEXne1vQ0GlSOD7/2LxwE2raRpEMelkTkVPH
	 IInZIRcU5kpIg5uPn+o37e4rDkUyPav4cG2CM2Jx6ZddH79KwFtO3BBi4wZvR/l96fvkb
	 7jeMCS6JWFDvyx1PPj9BXWFzmKRSt9gqWbf2+ZcHU/lSQJpc948Fov/H+q14thg4RDtqw
	 yepi2dZVxnL4g1qyD6AgLEGnvClLkNG8AAP+AyQq5TvcTZSVyHfiL7sW3CZVK3LLn3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095890;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nbB8McM+pZsP1nWFy++Avpejx7qyy0NzIjLQT0z2hjc=;
	b=o4S8sj3TFryHV1VnIeL0SgJyBfxyhHCux/zSMpdWsu4ev3pEJHlZblnybqngQdvgA7P8
	 8vp1e24xvmIV2vBW6FXgqI8hsoQkPho+ZxRAbi1FpqfSjaBb29gEAOTlKaeBwVVc6twOJ
	 RDI3JTo/cp34VG27/YGeqSk4lqUO7lvE6Mlmm0eVdXLH11O3H8AcH/EDVNXLUu2IP/i6M
	 FcnNWXWAKahBcGfhix6v9yqr0xMjTOHVJDD2hCXqsdztbWUH/skKOsm/4De9GjCv6XbDP
	 LEyDZulEzYRu+z1N5lhU3JaGMVY3qgs/uic+Iy3xc+5edlTSfdQ9oXH28vI8M/h752w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=QzByG199;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7B606A33C;
	Thu, 19 Nov 2026 13:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F7B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=QzByG199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=nbB8McM+pZsP1nWFy++Avpejx7qyy0NzIjLQT0z2hjc=; b=QzByG199OY9wUoYkzrg
	DPhUwBEew+cryv6qFjom7gBw0UeNqytujh+Q+kBpgavYFY3wiqAs7Xun+tveG/sqUEdWKbNSaO6Kw
	N8iJ5bqIMBjyVh17oHXC2E6nJ2PpZqNgZOQLYrrezy93+s89Kr5v4+ASTJfzbS9eWtC7yD5t+zdZU
	keh71avNmAB+GINqp+EVNdq91FtBCDlaWP2CiPH084rjsJRF0rKkDZ8Zbhw4CoXInwxGcX8pt7arx
	UcTFhAIyKP5xltkYIbSAtBfTAoGZHFNwIl9LSKaomb4dUmLHdm5UY1nnFNWFqRpPqC3e2QPkKiHtm
	HegkEpsm4YvT8uw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xU2R7-00FBqZ-17;
	Thu, 19 Nov 2026 14:44:25 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Thu, 19 Nov 2026 14:44:04 +0100
Subject: [PATCH v6 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
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
Message-Id: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-3-efa7817a2bb3@virtuozzo.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
In-Reply-To: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4194;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=0KbTMYxwQGgCuwBNwt1Pek/vi+cv68YluLjm3ssgOAk=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq/v03feVsR9uS5X8yS8SIHKVuDw/Cs0h9NcRGk
 G1L467BasCJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCav79NwAKCRBRlgpH+WFc
 KtsaD/4upDZ3XOtGVuDlVMtEZc6ok0w47ytJX2pe4pZSlEyhwyYu2hNNv7HOVvaTxVdOJwB8t10
 R4bYNeK2RHBH32+UrYqVTMdv4KCU5XtpCW3Dcvv7tKgYraXEO4J3ZchXA9qYonPXblA/Cx2H03w
 l8G6NqMFhFhC0Es4AfG09RdLDoDGT0o73ildtP02dN0HsDsq5tk3IXZc0YFrVEyO2/ubPoR4LgM
 FmyvZSN8S8uaUnA9InrJGifkTJ1p3Hu9lkJ7pSWucQcl8eIPnP2/55JVtx1ZPN1tbDviOBiyopQ
 1yFbfeGc6aVE6+wRNQjjbbaN7NnNHoNVc4u9uKwRMxc6DpeoHFBb08oTNHaPV4pcXEVe6/2ZAOV
 ihWRAfsHlDC9k8qPXMdM0h1mjo0i70ayiHMbMJYE8m+HPr8Mtt/8HcaDAcDc7HpnUEpnX9+bnLs
 HOx7QnnfgckSuJErP7G26GWKsErWQyc4lDOVQvr3ijPBipiZ6+FH1udhQHUEpBkCK/ilzlG5fCo
 QENePxvVh8xXHLuF0WEy4NIgggm84eK/WNiSyVPvkSDY3aIh9D4+MReR0r3YIXRHA2oByJwPOSp
 apRhB7ACPdHpBkMynndAtijGBWcFBa7CoRRIJZDAX1ufjBJ4HyjIUiQkyk46ISBTz+EuywI4TRS
 TEQ5SXwEBP98vyA==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

copy_huge_pmd() reads a special PMD without the page table lock and
copies that value to the child. The mmap write lock held by fork does
not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
lock.

The zap visits the parent VMA before the child's, as dup_mmap() links
the child right after the parent in i_mmap. If it clears the parent PMD
after fork has read it, and passes the child before fork copies it, the
child keeps a mapping the driver has revoked, for example:

- vfio-pci: the child reaches the BAR after the device memory was
  disabled or the device was reset, instead of getting SIGBUS;
- panthor: the child maps the pages of an evicted buffer object after
  the driver has released them.

The same branch deposits no page table under the copy. ppc64 in hash
mode keeps the hash slot array of every huge PMD in that table, so the
child dereferences a NULL table on the first hash fault, in
__hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().

Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
from a folio under them, as copy_present_ptes() does with
vm_normal_page(). The zap clears the parent PMD under the same lock, so
either fork finds it none and skips it, or the copy is in place before
the zap reaches the child.

The copy of a PFN mapping then goes through the same tail as a folio:

- it gets a page table where the architecture needs one;
- in a shared mapping it is marked clean in the child, as a PTE is;
- in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
  protected instead of a warning being printed.

Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #PowerPC
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 277d27a8a4364..adf3ca088bf41 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1977,25 +1977,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 	bool writable;
 
-	pmd = pmdp_get_lockless(src_pmd);
-	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
-		     !is_huge_zero_pmd(pmd))) {
-		dst_ptl = pmd_lock(dst_mm, dst_pmd);
-		src_ptl = pmd_lockptr(src_mm, src_pmd);
-		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		/*
-		 * No need to recheck the pmd, it can't change with write
-		 * mmap lock held here.
-		 *
-		 * Meanwhile, making sure it's not a CoW VMA with writable
-		 * mapping, otherwise it means either the anon page wrongly
-		 * applied special bit, or we made the PRIVATE mapping be
-		 * able to wrongly write to the backend MMIO.
-		 */
-		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
-		goto set_pmd;
-	}
-
 	if (vma_is_anonymous(dst_vma) || arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(dst_mm);
 		if (unlikely(!pgtable))
@@ -2037,7 +2018,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		goto copy_pmd;
 	}
 
-	src_page = pmd_page(pmd);
+	src_page = vm_normal_page_pmd(src_vma, addr, pmd);
+	if (!src_page)
+		goto copy_pmd;
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
 	src_folio = page_folio(src_page);
 
@@ -2088,7 +2071,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 	if (src_vma->vm_flags & VM_SHARED)
 		pmd = pmd_mkclean(pmd);
-set_pmd:
 	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 

-- 
2.43.0

