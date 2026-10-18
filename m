Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9462348C6D
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 04:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792298114; cv=none; b=CUr0cwYsogwY2SkgLrR05vEeMO5QeoW0X4Eiwd5PKdulFQpZ6SW6YNSyZMqQsGH0p1l6WjU1nK4q5J7GP7PCl4oIY05E0fs305m6tnH/cchbjoATKVrmCUezGUiHx5CSYQkR0BZEuAKtF8XILSjCBLVifilQG4kZ4fbO1vdEhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792298114; c=relaxed/simple;
	bh=AjBQmFyhsIuMBm3hPrg2M4zz8ssEzhjh4P/UkVsxEGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOhZbQmavB159u/gWSikW0hyYKsJtQ8eeBhDgWN7aDULyjns1iMIv7hSKWOWNYpOjr3Z4m+Nyc6UV2XXRqP2axU79+SsOWUfy+Z7OPF0V4cR1ezTUWROKpRuiq7mk4OvmqGFS7VBITLDyiIR+JF+jfzhul34bJFGeGuIloHwzaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k9WBLN+M; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k9WBLN+M"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so591868a91.2
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 21:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792298112; x=1792902912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UP34xPhDFhtAM+cWwkHeUJ1O9EQe7R6dx6I7BN7Iz7U=;
        b=k9WBLN+MWoxFB+gwnloiiD9tW1irADzXIbXEC3YTUGaUG1byL39RrtDUyIsocF3sA2
         PBnQp2P4AAYdfZEBiXtHU4Y2uhJATk/TCkFzw6BxiSAzNNg3wEcO4HJh6HI3fV0uOTU5
         GtF/YPKhKQb9zb2zOCzN9LybFhWnSyr0A3F1xOjsPDST3NHqMQTO6XGLlSHYuIsbtVWG
         tnGHX2K9jhPlmQV1B2Z1Bg0f/Dvvg64pXq3kA7XL/DC1gqvBUMUz6/XlmfkIPsxR5rcN
         afz7GW4Ds85NQwwV9mheNlooOFRkygZ4iTk1u3g3vXi6RHyZRniNR8ls5mgPocQ34czM
         HCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792298112; x=1792902912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UP34xPhDFhtAM+cWwkHeUJ1O9EQe7R6dx6I7BN7Iz7U=;
        b=UKpKaJMCTkUE8gz9NWO3Gm5yzykkQaSeiwoCpn+C7XvMnb+h9qgAzpYPuqZVm9Vp7x
         15+Oh+VfR7N420Teoooj+EdH9ulM1NHeuG+2MQYdZhHJuiI584vT+L9qviwPuAGYcFtv
         SSO4Zu7JTjt5VfmLaqnlHRamLQN00ZQ4fGdU/6VuEGpTPbW6lggAGZJEZVjQ4uxC+6rh
         doucBtOW7c4HHn5Vd7akCZ9+by59pQmdPws/hhm8vLyUP5AoUZmcib+CtVjLfwFSW8i5
         o7cwMdrX/sD7LtE4i4iUZIyoJUK2XOxlqDTvZwrOHNzUYiRBt316TAoJumnlF1+EQPKQ
         1CJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQprcRdQmnlFMFRpl/oIMW6/+1vDmEx0+FYqJ6Aex56Wz26jTjJPzeQ9IDZzjGURovQTmT6tU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHJpb8CLcGXDEiDlfBDIdW0H6AySxUuJDMcfrvdcNhy0lK89nI
	JKwhvb8kuJJv7RnLkkf2tTNWFy6hYgYmlrPM4lUM2JMAoA0Vv3/txpR9yxVHEgJG7PU=
X-Gm-Gg: AYBFou1l8sg95hGVJnV/AgsNRzYhm9xMjlgOU5YZiabeoLhLo1tIJrKkAv8u38Itsdf
	0KWaSA1TkyrgDfegY+QjM2RcpAHJtFtDLSRoFQQqzvls3E5fSzdT93EM4xlb683++IZLabNiP5d
	tnfEnv0DcYYiJ3+vnSFjGcN5wrtLWQFg6PGZIueHxiK+KgN85dw0Tx9r0FNH27un2JBWFOD39pJ
	GNhkL6l40v+Vk7rgbvR6DoaeE5iwWTEKS7B60YwhAUZ33rLbBO4agIGUpYGahHIRAuprGZxlRif
	hKMiLAcxDBY2gmURPOKDcwnaI2mAalHaOH7rKukrQBkKFRQlkBpQv0UrOID7B9gBMChwIpExy4B
	/+jtL90UfiTGkZVqD6Gg9ML5Ewch0TwPqGgkEvQFgOmAlDexrabswmBPJ0mO9CFx8X9JEwBfAfm
	y2LHM5WLoxvGh6e8/ZR/G9OI9/3jXtFOqRXUwAst3GNmUTErWNahMll8uZtF7USmvA6VhS+8QmT
	+Lzhpd689iOtapMd7ifcUT77g0xz/+PWPnqWMhoQjmT/B82Pb9oGpk6M0x2QuZ52GHZN+80GXmi
	SS2pfqBDWSTl9kyQFo1Bi4o=
X-Received: by 2002:a17:90b:55cb:b0:3ac:9c37:9431 with SMTP id 98e67ed59e1d1-3aceec251a0mr3458188a91.19.1792298109782;
        Sat, 17 Oct 2026 21:35:09 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487cccdsm10412082a91.8.2026.10.17.21.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:35:09 -0700 (PDT)
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
Subject: [PATCH v2] kasan: fix runtime shadow page table synchronization
Date: Sun, 18 Oct 2026 12:35:01 +0800
Message-ID: <20261018043501.3257632-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kasan_populate_early_shadow() is also used after slab becomes available
to install shadow mappings for hot-added memory. When this path allocates
a new page table at a level that requires synchronization, the new entry
is initially published only in init_mm.

On architectures that maintain separate kernel page tables, runtime
changes to the kernel page tables must be propagated to existing process
page tables. Otherwise, the KASAN shadow mapping can remain unreachable
and fault when the hot-added memory is accessed.

Use the existing page-table allocation tracking helpers to collect the
modified levels, then synchronize the affected kernel mappings once after
the walk.

Once synchronized, an entry remains in other process page tables. Clearing
only init_mm and freeing its target table during teardown would leave stale
pointers behind. Retain page tables referenced by synchronized entries.

Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Use the existing page-table tracking helpers and synchronize once after
  shadow population (suggested by Andrey Ryabinin)
- Fix aligned shadow population to reuse existing page tables instead of
  replacing them (suggested by Andrey Ryabinin)
---
 mm/kasan/init.c | 125 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 90 insertions(+), 35 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 66a883887987..f94f461d864c 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -17,6 +17,7 @@
 
 #include <asm/page.h>
 
+#include "../pgalloc-track.h"
 #include "kasan.h"
 
 /*
@@ -107,7 +108,7 @@ static void __ref zero_pte_populate(pmd_t *pmd, unsigned long addr,
 }
 
 static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
-				unsigned long end)
+				unsigned long end, pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 	unsigned long next;
@@ -115,25 +116,26 @@ static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 	do {
 		next = pmd_addr_end(addr, end);
 
-		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
+		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE &&
+		    pmd_none(*pmd)) {
 			pmd_populate_kernel(&init_mm, pmd,
 					lm_alias(kasan_early_shadow_pte));
+			*mask |= PGTBL_PMD_MODIFIED;
 			continue;
 		}
 
 		if (pmd_none(*pmd)) {
-			pte_t *p;
+			if (slab_is_available()) {
+				if (!pte_alloc_kernel_track(pmd, addr, mask))
+					return -ENOMEM;
+			} else {
+				pte_t *p;
 
-			if (slab_is_available())
-				p = pte_alloc_one_kernel(&init_mm);
-			else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				kernel_pte_init(p);
+				pmd_populate_kernel(&init_mm, pmd, p);
+				*mask |= PGTBL_PMD_MODIFIED;
 			}
-			if (!p)
-				return -ENOMEM;
-
-			pmd_populate_kernel(&init_mm, pmd, p);
 		}
 		zero_pte_populate(pmd, addr, next);
 	} while (pmd++, addr = next, addr != end);
@@ -142,80 +144,93 @@ static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 }
 
 static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
-				unsigned long end)
+				unsigned long end, pgtbl_mod_mask *mask)
 {
 	pud_t *pud = pud_offset(p4d, addr);
 	unsigned long next;
+	int ret;
 
 	do {
 		next = pud_addr_end(addr, end);
-		if (IS_ALIGNED(addr, PUD_SIZE) && end - addr >= PUD_SIZE) {
+		if (IS_ALIGNED(addr, PUD_SIZE) && end - addr >= PUD_SIZE &&
+		    pud_none(*pud)) {
 			pmd_t *pmd;
 
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
+			*mask |= PGTBL_PUD_MODIFIED;
 			pmd = pmd_offset(pud, addr);
 			pmd_populate_kernel(&init_mm, pmd,
 					lm_alias(kasan_early_shadow_pte));
+			*mask |= PGTBL_PMD_MODIFIED;
 			continue;
 		}
 
 		if (pud_none(*pud)) {
-			pmd_t *p;
-
 			if (slab_is_available()) {
-				p = pmd_alloc(&init_mm, pud, addr);
-				if (!p)
+				if (!pmd_alloc_track(&init_mm, pud, addr, mask))
 					return -ENOMEM;
 			} else {
+				pmd_t *p;
+
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pmd_init(p);
 				pud_populate(&init_mm, pud, p);
+				*mask |= PGTBL_PUD_MODIFIED;
 			}
 		}
-		zero_pmd_populate(pud, addr, next);
+		ret = zero_pmd_populate(pud, addr, next, mask);
+		if (ret)
+			return ret;
 	} while (pud++, addr = next, addr != end);
 
 	return 0;
 }
 
 static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
-				unsigned long end)
+				unsigned long end, pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	unsigned long next;
+	int ret;
 
 	do {
 		next = p4d_addr_end(addr, end);
-		if (IS_ALIGNED(addr, P4D_SIZE) && end - addr >= P4D_SIZE) {
+		if (IS_ALIGNED(addr, P4D_SIZE) && end - addr >= P4D_SIZE &&
+		    p4d_none(*p4d)) {
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate_kernel(addr, p4d,
+			p4d_populate(&init_mm, p4d,
 					lm_alias(kasan_early_shadow_pud));
+			*mask |= PGTBL_P4D_MODIFIED;
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
+			*mask |= PGTBL_PUD_MODIFIED;
 			pmd = pmd_offset(pud, addr);
 			pmd_populate_kernel(&init_mm, pmd,
 					lm_alias(kasan_early_shadow_pte));
+			*mask |= PGTBL_PMD_MODIFIED;
 			continue;
 		}
 
 		if (p4d_none(*p4d)) {
-			pud_t *p;
-
 			if (slab_is_available()) {
-				p = pud_alloc(&init_mm, p4d, addr);
-				if (!p)
+				if (!pud_alloc_track(&init_mm, p4d, addr, mask))
 					return -ENOMEM;
 			} else {
+				pud_t *p;
+
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate_kernel(addr, p4d, p);
+				p4d_populate(&init_mm, p4d, p);
+				*mask |= PGTBL_P4D_MODIFIED;
 			}
 		}
-		zero_pud_populate(p4d, addr, next);
+		ret = zero_pud_populate(p4d, addr, next, mask);
+		if (ret)
+			return ret;
 	} while (p4d++, addr = next, addr != end);
 
 	return 0;
@@ -230,15 +245,19 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 int __ref kasan_populate_early_shadow(const void *shadow_start,
 					const void *shadow_end)
 {
-	unsigned long addr = (unsigned long)shadow_start;
+	unsigned long start = (unsigned long)shadow_start;
+	unsigned long addr = start;
 	unsigned long end = (unsigned long)shadow_end;
 	pgd_t *pgd = pgd_offset_k(addr);
 	unsigned long next;
+	pgtbl_mod_mask mask = 0;
+	int ret = 0;
 
 	do {
 		next = pgd_addr_end(addr, end);
 
-		if (IS_ALIGNED(addr, PGDIR_SIZE) && end - addr >= PGDIR_SIZE) {
+		if (IS_ALIGNED(addr, PGDIR_SIZE) && end - addr >= PGDIR_SIZE &&
+		    pgd_none(*pgd)) {
 			p4d_t *p4d;
 			pud_t *pud;
 			pmd_t *pmd;
@@ -251,34 +270,46 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate_kernel(addr, pgd,
+			pgd_populate(&init_mm, pgd,
 					lm_alias(kasan_early_shadow_p4d));
+			mask |= PGTBL_PGD_MODIFIED;
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate_kernel(addr, p4d,
+			p4d_populate(&init_mm, p4d,
 					lm_alias(kasan_early_shadow_pud));
+			mask |= PGTBL_P4D_MODIFIED;
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
+			mask |= PGTBL_PUD_MODIFIED;
 			pmd = pmd_offset(pud, addr);
 			pmd_populate_kernel(&init_mm, pmd,
 					lm_alias(kasan_early_shadow_pte));
+			mask |= PGTBL_PMD_MODIFIED;
 			continue;
 		}
 
 		if (pgd_none(*pgd)) {
 
 			if (slab_is_available()) {
-				if (!p4d_alloc(&init_mm, pgd, addr))
-					return -ENOMEM;
+				if (!p4d_alloc_track(&init_mm, pgd, addr, &mask)) {
+					ret = -ENOMEM;
+					break;
+				}
 			} else {
-				pgd_populate_kernel(addr, pgd,
+				pgd_populate(&init_mm, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+				mask |= PGTBL_PGD_MODIFIED;
 			}
 		}
-		zero_p4d_populate(pgd, addr, next);
+		ret = zero_p4d_populate(pgd, addr, next, &mask);
+		if (ret)
+			break;
 	} while (pgd++, addr = next, addr != end);
 
-	return 0;
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
+	return ret;
 }
 
 static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
@@ -286,6 +317,9 @@ static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
 	pte_t *pte;
 	int i;
 
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PMD_MODIFIED)
+		return;
+
 	for (i = 0; i < PTRS_PER_PTE; i++) {
 		pte = pte_start + i;
 		if (!pte_none(ptep_get(pte)))
@@ -301,6 +335,9 @@ static void kasan_free_pmd(pmd_t *pmd_start, pud_t *pud)
 	pmd_t *pmd;
 	int i;
 
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PUD_MODIFIED)
+		return;
+
 	for (i = 0; i < PTRS_PER_PMD; i++) {
 		pmd = pmd_start + i;
 		if (!pmd_none(*pmd))
@@ -316,6 +353,9 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
 	pud_t *pud;
 	int i;
 
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
+		return;
+
 	for (i = 0; i < PTRS_PER_PUD; i++) {
 		pud = pud_start + i;
 		if (!pud_none(*pud))
@@ -331,6 +371,9 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *pgd)
 	p4d_t *p4d;
 	int i;
 
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
+		return;
+
 	for (i = 0; i < PTRS_PER_P4D; i++) {
 		p4d = p4d_start + i;
 		if (!p4d_none(*p4d))
@@ -377,6 +420,9 @@ static void kasan_remove_pmd_table(pmd_t *pmd, unsigned long addr,
 			continue;
 
 		if (kasan_pte_table(*pmd)) {
+			if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PMD_MODIFIED)
+				continue;
+
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE)) {
 				pmd_clear(pmd);
@@ -403,6 +449,9 @@ static void kasan_remove_pud_table(pud_t *pud, unsigned long addr,
 			continue;
 
 		if (kasan_pmd_table(*pud)) {
+			if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PUD_MODIFIED)
+				continue;
+
 			if (IS_ALIGNED(addr, PUD_SIZE) &&
 			    IS_ALIGNED(next, PUD_SIZE)) {
 				pud_clear(pud);
@@ -430,6 +479,9 @@ static void kasan_remove_p4d_table(p4d_t *p4d, unsigned long addr,
 			continue;
 
 		if (kasan_pud_table(*p4d)) {
+			if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
+				continue;
+
 			if (IS_ALIGNED(addr, P4D_SIZE) &&
 			    IS_ALIGNED(next, P4D_SIZE)) {
 				p4d_clear(p4d);
@@ -464,6 +516,9 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
 			continue;
 
 		if (kasan_p4d_table(*pgd)) {
+			if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
+				continue;
+
 			if (IS_ALIGNED(addr, PGDIR_SIZE) &&
 			    IS_ALIGNED(next, PGDIR_SIZE)) {
 				pgd_clear(pgd);

base-commit: 63562804f25cb5b6f5e4f5e3a9f0d1c3c6868596
-- 
2.54.0

