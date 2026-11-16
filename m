Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813223;
	b=YyHT6jwY+APnVuNbJEXwebUWK45/5jGePFJo37EGWFLY5tf/Av7qjxJXgnDaVluwyPLE
	 M4cVRO+jrRnORpXW7DxM4fciFbvSKTy+E9cRSPnZW+0Tknh2kQ/ql+TerYALSy8/Jq+4m
	 fCIXulaKUxjFncafk9tLfZNGI4JJQQVxLx93d54iC63e9/YZAi/uUBRAavLTBUKKUujJj
	 5p2LJNxDMouG57CQmDj75LQRFNJ5ENZtR5WUp8Jg9o1VIxdcXD43mIjRJ4Hrmu6DujzQa
	 he+KNjM6S8vUcIeagVO9h0GcW6LhwyiiTcTy/mhjJ/Ph/ao3A5tX0yDQ/i1GnvvI1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813223;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AOtJc8ArX8+ToyaiTRWaxycd35R3Jnx2kTE6b07ZdMU=;
	b=JixcxNql1O7YG2st22srOlpqSJzLsL5mbABw+117h0I5CWogbnZr5yxEslCewhKkWZZf
	 Hpz/qQWPulusUSyQnKjinz6d7L/wmZTqLKIBJ7lLqeET/PuUvAXYCn4fWhgZ7XO0ewCbk
	 BXoI6xE0QIdCgv50jM31WZS02uxQ0VjfWWiyF3HjQq06m4UBMkrlwtO4Juydxeit4/Ga1
	 dwOYN8UF2TmTFTF+su4wrOUl5BxUJFyswfDlSRYWKZ/mBQsDvb6Pe7DyM1kgCW3Wthcu1
	 8gB6yZyJThamp9RRHQ+qTvsJJI7SA5w0HjI2gFXV9KFk3B1LZ5kMCZraKtB5ISqBgNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nW0D0jtq;
	arc=none smtp.remote-ip=95.215.58.206
Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F6606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 149F6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nW0D0jtq
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7/JYJzeyd+b/iRPmzXRLtiBy/A7aQtupMKn/EdxvRIU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813221; v=1; x=1795418021;
 b=nW0D0jtqi6IQbHFRngaT2zyRdXassmaeVQlNRx4TiqLyjQ8Y2vz17pMg4BjgFljgUXl4meIE
 N5IXqCpfY69OSpwUq+ZvebtoPlDTTPyDSEoXvCIR8d3Uz7XyaZ4OXg+ebyqLSrfCn9l8zY8jpHN
 lcltd8kejcBirorUAS+J6bLA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e79e42b6b187866;
	Mon, 16 Nov 2026 07:13:40 +0000
X-Mizu-Trace-ID: 2e79e42b6b187866
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 01/11] mm/vmalloc: skip cond_resched() in the vmap unmap paths when atomic
Date: Mon, 16 Nov 2026 15:13:15 +0800
Message-Id: <20261116071325.263682-2-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116071325.263682-1-hao.ge@linux.dev>
References: <20261116071325.263682-1-hao.ge@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmap failure paths can be reached with GFP_ATOMIC or GFP_NOWAIT
since commit b186a94227b7 ("kmsan: remove hard-coded GFP_KERNEL
flags") and commit 8da89ba18ed4 ("mm/vmalloc: handle non-blocking
GFP in __vmalloc_area_node()"), so an undo of a partially installed
mapping may have to run in atomic context, where the cond_resched()
in vunmap_pmd_range() cannot schedule.

Give __vunmap_range_noflush() and kmsan_vunmap_range_noflush() a
can_resched argument and skip the cond_resched() when it is false.
The existing callers are on sleepable paths and pass true, so nothing
changes for them.

Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 include/linux/kmsan.h |  8 ++++++--
 mm/kmsan/hooks.c      | 14 +++++++++-----
 mm/vmalloc.c          | 24 ++++++++++++++----------
 mm/vmalloc.h          |  3 ++-
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 7da9fd506b39..0016c032d1e7 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
  * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
  * @start: start of vunmapped range.
  * @end:   end of vunmapped range.
+ * @can_resched: whether the unmap walk may call cond_resched(); pass
+ * false from atomic context.
  *
  * KMSAN unmaps the contiguous metadata ranges created by
  * kmsan_map_kernel_range_noflush().
  */
-void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
+void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
+				bool can_resched);
 
 /**
  * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_range() call.
@@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_range_noflush(
 }
 
 static inline void kmsan_vunmap_range_noflush(unsigned long start,
-					      unsigned long end)
+					      unsigned long end,
+					      bool can_resched)
 {
 }
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index a706666db097..69008b085658 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -136,10 +136,13 @@ static unsigned long vmalloc_origin(unsigned long addr)
 						 KMSAN_META_ORIGIN);
 }
 
-void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
+void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
+				bool can_resched)
 {
-	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
-	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
+	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end),
+			       can_resched);
+	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end),
+			       can_resched);
 	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
 	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
 }
@@ -168,8 +171,9 @@ static void kmsan_iounmap_pages(unsigned long start, unsigned long end)
 		if (origin)
 			__free_pages(origin, KMSAN_IOREMAP_META_ORDER);
 	}
-	__vunmap_range_noflush(shadow_start, shadow_end);
-	__vunmap_range_noflush(origin_start, origin_end);
+	/* ioremap metadata mappings are always GFP_KERNEL, so resched is safe. */
+	__vunmap_range_noflush(shadow_start, shadow_end, true);
+	__vunmap_range_noflush(origin_start, origin_end, true);
 	flush_tlb_kernel_range(shadow_start, shadow_end);
 	flush_tlb_kernel_range(origin_start, origin_end);
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaf158c5b7f..3c0d9e69b886 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -429,7 +429,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 }
 
 static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
-			     pgtbl_mod_mask *mask)
+			     pgtbl_mod_mask *mask, bool can_resched)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -451,12 +451,14 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			continue;
 		vunmap_pte_range(pmd, addr, next, mask);
 
-		cond_resched();
+		/* The undo path may run in atomic context. */
+		if (can_resched)
+			cond_resched();
 	} while (pmd++, addr = next, addr != end);
 }
 
 static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
-			     pgtbl_mod_mask *mask)
+			     pgtbl_mod_mask *mask, bool can_resched)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -476,12 +478,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		}
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		vunmap_pmd_range(pud, addr, next, mask);
+		vunmap_pmd_range(pud, addr, next, mask, can_resched);
 	} while (pud++, addr = next, addr != end);
 }
 
 static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
-			     pgtbl_mod_mask *mask)
+			     pgtbl_mod_mask *mask, bool can_resched)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -496,7 +498,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		vunmap_pud_range(p4d, addr, next, mask);
+		vunmap_pud_range(p4d, addr, next, mask, can_resched);
 	} while (p4d++, addr = next, addr != end);
 }
 
@@ -512,7 +514,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
  *
  * This is an internal function only. Do not use outside mm/.
  */
-void __vunmap_range_noflush(unsigned long start, unsigned long end)
+void __vunmap_range_noflush(unsigned long start, unsigned long end,
+			    bool can_resched)
 {
 	unsigned long next;
 	pgd_t *pgd;
@@ -527,7 +530,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
 			mask |= PGTBL_PGD_MODIFIED;
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		vunmap_p4d_range(pgd, addr, next, &mask);
+		vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
 	} while (pgd++, addr = next, addr != end);
 
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
@@ -536,8 +539,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
 
 void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
-	kmsan_vunmap_range_noflush(start, end);
-	__vunmap_range_noflush(start, end);
+	/* The unmap paths are sleepable, keep the resched point. */
+	kmsan_vunmap_range_noflush(start, end, true);
+	__vunmap_range_noflush(start, end, true);
 }
 
 /**
diff --git a/mm/vmalloc.h b/mm/vmalloc.h
index d8372a4f65c4..4ec114a75f04 100644
--- a/mm/vmalloc.h
+++ b/mm/vmalloc.h
@@ -44,6 +44,7 @@ int __must_check __vmap_pages_range_noflush(unsigned long addr,
 
 void vunmap_range_noflush(unsigned long start, unsigned long end);
 
-void __vunmap_range_noflush(unsigned long start, unsigned long end);
+void __vunmap_range_noflush(unsigned long start, unsigned long end,
+			    bool can_resched);
 
 #endif /* __MM_VMALLOC_H */
-- 
2.25.1

