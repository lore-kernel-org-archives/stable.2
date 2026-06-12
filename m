Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AB346E43
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781236768; cv=none; b=Gb2igfn6pMhRsPRAIJx3IE3p+6F8tI9Cf+mIpASDRnAD9p7OuaDSN0ttAXjyArTYwKgN5v+B9RhUvzdexMD69rkqBh8ibAHyhJi7Tah0nLx3vV2ztYZJ1HBbEGL/KBskZ+GXTSLujjTQTe8ae1aulV8IiyzlOhFAVnd703udwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781236768; c=relaxed/simple;
	bh=it3esgE937uFjKRnmVX2qECQgX5Lg/OcvcB1PIsf0q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqg8S9r1udI1KxkmTE+e6UqNZlnLWdq78bk1cx144ozVcufK17eTdO0w2RFn0DNmka0qZVZXz1taINiu8BOtsmViqFpL6eoPp1D1Mr2v1arCMhF3EmDmLiwUtckS0OI3EiwjGo/KRugDzTSn0AtwHQPH2nXv38E5sP5ToYzoLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KZF3MpPD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KZF3MpPD"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8422871b42dso382407b3a.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 20:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236766; x=1781841566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A38edv4qBFIhST2C0H/v4DfDnWwAK1V2ZV54LtDXngc=;
        b=KZF3MpPDUOP61IlwzBlYHkDDlUC3aJgzIzEOTTk1BrbKrCGD/6RnXmiy/pWqbxlano
         11gnYXiMYJ9aNcWizy37Zi8SEwOVK5srQKbBRfUEr4mbt7EoGYyVjnZ9I2PFWetVTOwW
         UCuIxX2pkSHXMY0CvkcwPIeQSFOJqPUcxshxGY76baW2ikiATHUnIWxgeVaeG4C22I63
         vlCoyeFd7HOs8VqRrOx4JDbtzp5fgLo5RqXWPH0O0PIDsu+KjeCWi0soVmdiZsbPlNmo
         Ssx96Wanvu0z6kpNPJ857WCYu8ipv7YMEJrGv331Dg/i3E5W1vc8GZkM35IOsLfIgd63
         /5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236766; x=1781841566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A38edv4qBFIhST2C0H/v4DfDnWwAK1V2ZV54LtDXngc=;
        b=oQzbku6CAF935iWL1Ov7L1eMYTvsG7B4HGOyJTFUCCIl+7KUgmUb8Rkn2/S9h1yh2e
         E4YgEk7i7G5lFc+GPflVU1bF4fMDLvgTyk7/XjFp5ozgnzitv1bsiFbvu3uZahNu2yhb
         NutDdANoo8R6KlxpYLTqgOyQ0TTH2tnWdilRtrdJ4qavHLNRr3f7DtiDt1roigee4r6H
         JhbT6cyz6cZnYqJ655A7mH2e9Ye4ZG/Z9anzsOVlM8NEjMhtpcF1iNN7P+eGwS7lnpjE
         dSCO3AmMvfWwx56W3DsMU4+TL47xC1FFzomnUN4T/pPN/7X44AZn7eEv8NkJkZPpGyVU
         7udw==
X-Forwarded-Encrypted: i=1; AFNElJ+DBUR/5KNIv4Q4dRPVekJ7ydiE8iKeykGyJ8W1RfU7Czjfpt0BykG5D50+bskPemkkx2lDyuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFICIgNYthTvp7etnuHNv/l1HiMp9QGawEsikCp9LcfG/owfQ9
	I0CoPhh49xa7es6N9DV8qzHlo8/G68of3hN0PKCLZU4iiTFi7tcrMzoVnSsnA4wtBBg=
X-Gm-Gg: Acq92OHBQ3PA3ZxmjpnFp9BtujVbUJqzUEQcLz3/A9dRtKpfD6wNMno/2lu2X5rnvVc
	BAmfKVYj7pDIzPyHuvucZNvT/uo+ccipibIHD95cF9JAm27txtYvpb8wkFoCMGP3Oc9zX6jtbIQ
	PCVWDHNVS6BD4nG/nl3ybHOwfh99mTjfuLUucQ3ibKWaL/uW4lm2z+B/lSbQSGlypxMU2vx+ntO
	P8sEO+nLVGiqNkaJp0WxfFwn3NGRdT/OTCpoo1vyBJV2Yor1lOCQbi5Boiy5yMDGn+H/akkWYuk
	uoFDncNRzlVJRR2bW39EkedwFJKRgxcQoG4gh/wr8H33NTczQsrJLnuuyUoVhezN3pt+8qf/9Cb
	Ew9RuaRPJindbEk/nXcBQBL2e8PgCcqY0B0ARX1KAGRIpoz4EbAPIoFTj2407lS13PY/z+vDqS2
	L22YIQtsWr+nWlQhEpnHarr2R/rwrhOn2Kw1KSZRdmL4U=
X-Received: by 2002:a05:6a00:2288:b0:842:5988:470b with SMTP id d2e1a72fcca58-8434cc161cfmr1136338b3a.1.1781236766275;
        Thu, 11 Jun 2026 20:59:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:25 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 03/19] powerpc/mm: Fix wrong addr_pfn tracking in compound vmemmap population
Date: Fri, 12 Jun 2026 11:58:47 +0800
Message-ID: <20260612035903.2468601-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmemmap_populate_compound_pages() uses addr_pfn to determine the PFN
offset within a compound page and to decide whether the current
vmemmap slot should be populated as a head page mapping or should reuse
a tail page mapping.

However, addr_pfn is advanced manually in parallel with addr.  The loop
itself progresses in vmemmap address space, so each PAGE_SIZE step in
addr covers PAGE_SIZE / sizeof(struct page) struct page slots.  Since
addr_pfn is compared against nr_pages in data-PFN units, it should
advance by the same number of PFNs.  The existing manual increments do
not match that and therefore do not reliably track the PFN
corresponding to the current addr.

As a result, pfn_offset can be computed from the wrong PFN and the code
can make the head/tail decision for the wrong compound-page position.

Fix this by deriving addr_pfn directly from the current vmemmap address
instead of carrying it as loop state.

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

---
v3->v4:
- Add Cc: stable@vger.kernel.org (suggested by Ritesh Harjani)
- Collect Reviewed-by from Ritesh Harjani
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 10aced261cff..cf692b2b5f7b 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1314,7 +1314,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	 * covering out both edges.
 	 */
 	unsigned long addr;
-	unsigned long addr_pfn = start_pfn;
 	unsigned long next;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -1335,7 +1334,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 
 		if (pmd_leaf(READ_ONCE(*pmd))) {
 			/* existing huge mapping. Skip the range */
-			addr_pfn += (PMD_SIZE >> PAGE_SHIFT);
 			next = pmd_addr_end(addr, end);
 			continue;
 		}
@@ -1348,11 +1346,11 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			 * page whose VMEMMAP_RESERVE_NR pages were mapped and
 			 * this request fall in those pages.
 			 */
-			addr_pfn += 1;
 			next = addr + PAGE_SIZE;
 			continue;
 		} else {
 			unsigned long nr_pages = pgmap_vmemmap_nr(pgmap);
+			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
 			unsigned long pfn_offset = addr_pfn - ALIGN_DOWN(addr_pfn, nr_pages);
 			pte_t *tail_page_pte;
 
@@ -1376,7 +1374,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				if (!pte)
 					return -ENOMEM;
 
-				addr_pfn += 2;
 				next = addr + 2 * PAGE_SIZE;
 				continue;
 			}
@@ -1392,7 +1389,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 					return -ENOMEM;
 				vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-				addr_pfn += 1;
 				next = addr + PAGE_SIZE;
 				continue;
 			}
@@ -1402,7 +1398,6 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 				return -ENOMEM;
 			vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 
-			addr_pfn += 1;
 			next = addr + PAGE_SIZE;
 			continue;
 		}
-- 
2.54.0

