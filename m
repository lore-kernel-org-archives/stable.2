Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD43C8C48
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639485; cv=none; b=ntbA1Yyhm+9082X7+HFdzFLyMAksa5G1chMoyCjuWo0ufSvROD5vv9imBruXm0xPAnh3d14JCwKlGbcadn8f3ynIbaf6IDfycN84KKxn9xXTVD1Lr50+o6r/ZWlezwo0rYTrckIb8AVXh3GobKtVrMjGdE4eU7+wQgQjzJlaPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639485; c=relaxed/simple;
	bh=tvw1MVMD6Bx2WGas01UVf7XjRa5n2vYhhdQjoD/yYT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMfmdoA8DZP6HcEwwlieOPMFcvEieiGDL/SeZyYfvfqnUYI/FJxPFYsEk6UJtzn2fp/YiFe8axE50bUNUkfVrfoRhootXuOOcOfWoPNmH9Qp+SLszYhnkegUi/HbnsYFib0Kdxhl2DmErF5Yf2Lt3o0kRI30dZoSFtAT9wDNFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ieblt+Pr; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ieblt+Pr"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a7fecf8440so212273a91.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791639480; x=1792244280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPtlzfN0S1oL1fXH4tml8et8bDzwWRFyvuUgyoI3xEE=;
        b=ieblt+Prdqg6MXf9KtMhUtuZ6+HYch3SMflNgwmUVYEhrIK83C1D2hBsfPvW0Y9TBn
         qFipSFXDtzYTQKRlrIQ3O08YL4q0c1bIq08GsO7vEVUhkk8LSmHCgqC49lSU5ViqHf37
         ks/iGyzJCFplZB9z1tXqKjdvDSSTB/fZbr+QYmtIj1D7dG39jBPyQwh1t+OnS/TRnuAa
         1E6mPXPrluO81yxVL8+atCBB5KS7I08ngs5tINgoyzY2DbcSf8fKJQvIprC8jQDlCS/H
         xv/GemF4Ub3wRJ3hQ03FjShdrRJO5yKEbe4ILJZWJrzTfNei4/diHI69qe5kzHilu8St
         2ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791639480; x=1792244280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPtlzfN0S1oL1fXH4tml8et8bDzwWRFyvuUgyoI3xEE=;
        b=XHoA/XO7jTLSq9dWWsioo66ibY8tvrtB1CkDQTbECgymdU3G5N4tWzj1KQQWdu5LZb
         dD8BrlqFwP2nNVEmAr/8BlTD1UoE/7TOwLzE5RdhlbdIaJ5eLc1YziLh6JNxtX5q1jAW
         teu4stUR3rQQymDCUdvdXnupQ3eBeRVyReHn4MENSYNkKL6/UUI54NiN/1+S20RbKVif
         Q+Hh4LI0o6A5/JzW60ET3iwXW1q9bHSOzx3UY8ASQIZmdjDZyrziapvJFlAlOLUxQ6s2
         cqQPBS8bjRctWRhRf9JDydpeVreqjUpVMqe/mtvWm2GwxmV6/KCAyYNDdlkXY33Kimra
         +iGg==
X-Forwarded-Encrypted: i=1; AKwUvBxltKJ3oGh/BHiaoQnaH+g2k7P/QABdpUBkyUnPfeONc6inaZMm2RMWT36sL9rJ6C5MMbmsMsA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdXzv1mjl/RUIpQA1Z/Q8kdY8qXI8yD5ThZUV1pa8UQf6PCkJK
	EOQbk2sfcpJatbdQO9FT1SxFOZ5YppqmMvdyMGayR0YQgQuIief2RsiiZMCCWyBImfI=
X-Gm-Gg: AYBFou0747Dm7+gS+i64Chv23g9Nq8wv5eeqcgt+INXcN2yccbnn07WkndNxKcsDsad
	YBAmH95ZERNlk2sEAgNxbV9oUTpOSC4U4V0efl+3RGHvnU2FCzc4no2+4YETtv31XqJ+lhcTWGH
	XZxOODT6aw4fK5XJVgLpg/TjrtxwoE/4nT5OL/10UjmFUaS4ja/tGj0merLxb132XyCRpY3xcqf
	EFBndB9AK8+emVZ7X7uJQOrjpP0zVT/LzA5ByvUyJLjr8FFePjLjeJ6ZNbQOLF320XbbzamQJiL
	BPbPR2KLKOq2qj4v4E+8XvIVT8dVC1hxMD51XNutp04w7EC6Fg3vo2p2OzP67cz4ufFfHAoiFHS
	HCf16xHLTcVi+c3uUdsSccWkXPFq9z2IHXbvBlJGT1qzFBDDvdiIcR3IqaaAPBMOkJcxiqZ4/qW
	vOb7katp6Y0cSi3KLZNZKTBsegRZlU40Om5sRVisJ9txW8L5FljjcBCodHlb65yeecn7DdRKw+O
	ybMlzP6UnEvBDtNLzL+Jh9lOSEeUAk=
X-Received: by 2002:a17:90b:5346:b0:3ab:1a24:56e3 with SMTP id 98e67ed59e1d1-3ab3ac9dea0mr3733554a91.25.1791639479882;
        Sat, 10 Oct 2026 06:37:59 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm8522697a91.4.2026.10.10.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 06:37:59 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Dan Williams <djbw@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH] kasan: fix runtime shadow page table synchronization
Date: Sat, 10 Oct 2026 21:37:50 +0800
Message-ID: <20261010133751.46807-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kasan_populate_early_shadow() is also used after slab becomes available
to install shadow mappings for hot-added memory. When this path
allocates a new P4D or PUD table, p4d_alloc() and pud_alloc() publish it
only in init_mm.

On x86-64, runtime kernel mappings that add a top-level entry must call
arch_sync_kernel_mappings() so existing process page tables can see it.
Without this synchronization, the KASAN shadow mapping can remain
unreachable and fault when the hot-added memory is accessed.

Add p4d_alloc_kernel() and pud_alloc_kernel() to perform the required
synchronization, and use them for runtime KASAN shadow population.

Once copied, a top-level entry remains in other process page tables.
Clearing only init_mm and freeing its target table during teardown would
leave stale pointers behind. Retain these shared levels instead. On x86,
this keeps PUD tables with four-level paging and P4D tables with
five-level paging, while lower-level tables can still be freed.

Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 mm/kasan/init.c    | 10 ++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5cca90fc1df6..5453d3e42780 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3855,6 +3855,18 @@ static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
 		NULL : p4d_offset(pgd, address);
 }
 
+static inline p4d_t *p4d_alloc_kernel(pgd_t *pgd, unsigned long address)
+{
+	if (unlikely(pgd_none(*pgd))) {
+		if (__p4d_alloc(&init_mm, pgd, address))
+			return NULL;
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
+			arch_sync_kernel_mappings(address, address);
+	}
+
+	return p4d_offset(pgd, address);
+}
+
 static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
 		unsigned long address)
 {
@@ -3862,6 +3874,18 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
 		NULL : pud_offset(p4d, address);
 }
 
+static inline pud_t *pud_alloc_kernel(p4d_t *p4d, unsigned long address)
+{
+	if (unlikely(p4d_none(*p4d))) {
+		if (__pud_alloc(&init_mm, p4d, address))
+			return NULL;
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
+			arch_sync_kernel_mappings(address, address);
+	}
+
+	return pud_offset(p4d, address);
+}
+
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 66a883887987..93a74a1fcdec 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -206,7 +206,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *p;
 
 			if (slab_is_available()) {
-				p = pud_alloc(&init_mm, p4d, addr);
+				p = pud_alloc_kernel(p4d, addr);
 				if (!p)
 					return -ENOMEM;
 			} else {
@@ -268,7 +268,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 		if (pgd_none(*pgd)) {
 
 			if (slab_is_available()) {
-				if (!p4d_alloc(&init_mm, pgd, addr))
+				if (!p4d_alloc_kernel(pgd, addr))
 					return -ENOMEM;
 			} else {
 				pgd_populate_kernel(addr, pgd,
@@ -322,6 +322,9 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
+		return;
+
 	pud_free(&init_mm, pud_start);
 	p4d_clear(p4d);
 }
@@ -337,6 +340,9 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *pgd)
 			return;
 	}
 
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
+		return;
+
 	p4d_free(&init_mm, p4d_start);
 	pgd_clear(pgd);
 }

base-commit: 8b38ed9ab5b09c8ba168cbcc49524e9b380ee5c4
-- 
2.54.0

