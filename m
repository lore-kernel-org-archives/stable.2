Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737286;
	b=ZE0DT1rG8fKxID+Rwg8pDfmbGPoeBe4MrR29l6Zlg1TrWorbr60viO8t/BtfIRCYlktj
	 F2jzf8Hjz+pEugK8WSI1BPmQqwqhuHJsAs070RsIuBqh/GW64y+CiG1QWYtHSsYPrFY1q
	 TrZsHYvItyn8QzH9VI/MRsHUcVJC0BApVEnmMORZW7SZqQ3kJf9eCCG/dWU6jq7ohfpCf
	 OQZLmh5q56nbBZ0hBt9UbVF0hkOXpKluT94veV9dmgYstZi/K3FCkBzO+foZe5JBkrJIu
	 q5eS4WaqgGTHv/RbetuuhAFM9KgpLhBhsS9AYBCTcbx4jXf6KsbfsVOb7t+pv6s1Y1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rturI3iC2rqsVMr8++V5T0eWydBVkbRvFCJtmlAqnJE=;
	b=dzRA2+evoYmTaIdhOBguDx7hguZSX0Vy56qN7euWqIqyhLagBBRExwBYivaMRw3mD6MX
	 3j4euGKV52ZrmYpoPv51EHGZ3mS6cIJZhl6h8zw163hPPdcogMYgbbsbgYmdosk40bkUD
	 3IiSJzCoRBRVHXp1xZI5VGK9JQ2ZW/VFkTivPm+r8KvQlOjd25hgEWrW7fSIXn5cTiLFz
	 DPnNvmFMxe+s0sz7sb3cZcPGKpJTIwgpREKVoHaeSZUOoh+jNS5Z6WowKIta1oFehvnkr
	 nEOgIPx96UrB9sFRRZTSjJrNj4UgA09J5w8x/NoAZhEskxXHviTlGXBOhq1qq+GNnkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Q3hkvQEU;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF422606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF422606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Q3hkvQEU
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso229507a12.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792737284; x=1793342084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rturI3iC2rqsVMr8++V5T0eWydBVkbRvFCJtmlAqnJE=;
        b=Q3hkvQEUTa3wxkrHL2uDgCDaKcHUWdyc//o4khcvwZvSa8HmNCNisJ9EBY8gaMgQSs
         s6078Z1EMS7a0QiCscxhnXDumdo4RCnYHIUWz24CbGQGP3AfsFc3dYHQNZHyVBqEKaJ3
         meEkLIOjP8Qds7hKXMQcp1hhMUkbK7/x32LbeK7G9LrDA3ofpLzaiz8phm62cxpiwSK8
         +wEVX3eEkNuvpI6fUGEJgQc+xdSWkN3QTMS9QxCmmVGEPl9XG4HbijbyNMRbQOaFWmE1
         fDVm/pSbH6sDiLGMHOxLiem2lsF+Lrx/DysQiksex8UFDwIdjEeBiZVPePnCBj095Ctr
         /wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737284; x=1793342084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rturI3iC2rqsVMr8++V5T0eWydBVkbRvFCJtmlAqnJE=;
        b=jHE6bKUX2T4Jtie7eIXApSBb0gj9rQIwMZkcfYHlT5FDfVRkkZaVbW+0Y9Umc0qXpu
         FGPLOCFJwmlbui3IcEEtxdu2IDZN6LLLtnQMaJt8EX3uiHZ0bDXbNdlUnX5aHMhX89xs
         xdF85cPHJHB1w7dpxpOdVuwmCaJI2sfjEMUFwza5k6BCInzzVdTBU2dtatSDFPjijObY
         71By03AnngFMum9waeqYjOYmWQKIu7WgYj9seOozdUspcu3e0YzyVlpeB9vajcX61rwf
         0kpj2nKmHaRDYCvu+ofWK7+5h6Rgsjv1DUIS99I9hT8qV26iM9nCaxylAdcaWYzWCQq0
         bVgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSiZQpO+jzcBVLl6GUm1dtiS8DL4Vq38L5wx5Od8wow/9tVpWEQsnz0K6uRMgyuZ0phEgxglk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVCMyX0TJFghksdXhmRrIOby4qmufohc/ff/G9Bra1Bh+6Jtl4
	mAHarfwSukxx+K12BVzpgxGhKFmMI4gF2suZQ5/bJoyLOg+UzYd5QELIh4KNfEZ+sY0=
X-Gm-Gg: AYBFou05P6g/seKZ71TMi4COzJDP8NCQUK7+TCbUJMrGPbxncmPokCny3X6YnOyTvL7
	eNxAbn4Uuccm/Zw51ZLZ9hsWuASW3IjjKUCMWqnjy4+TiDpCPgciJ/JS1yrEHZjdlQeSywH6PeP
	H21ruS34HYez0JAxxJ47sPa4Z2SVjGbmFMluJCq9okcRfRB4a5Bi2k8p+edNbHW7ZftwDeiJ0yr
	BPULYBZriz/iSTwAFi4E2KsQCNuYiM1VIcOlWESYBf/E/okkR17qOT+vXA8b4Zj6Hz4o5lHJurj
	pg8hfO8qKd8ga4cRG8BQdqPflkr+EMwhlf8VdYb+dT7qHqoVRGm+CgmNERlMLT8gvW163UGJoZh
	+wEfRB0dQ0G5l9hIo9H1C7Z0Qom/vyW95eEQI8oPSZYySMYXMENMZhCl7vWKZMWvZCZkRzZJJzB
	9MFwOhmoqFN+YS7BAFTSzl8F2gIwuh47Idp18C1iK67zpp8p5DXhkRcIBUIWslU4yJsyyay6LHp
	EK5AN6MoIyPejPcYYcP5cO46yYTuJGT+ifha4mrD1f8E/yCoK/Wn4vRWgR+e9wRSdv7xt7s/1Uh
	jA==
X-Received: by 2002:a17:90a:f945:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3adce7dd585mr1009938a91.24.1792737283991;
        Thu, 22 Oct 2026 23:34:43 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add246f308sm575202a91.0.2026.10.22.23.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:34:43 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 1/4] mm: fix missing page-table destructor in pagetable_free()
Date: Fri, 23 Oct 2026 14:34:25 +0800
Message-ID: <20261023063428.3658761-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023063428.3658761-1-songmuchun@bytedance.com>
References: <20261023063428.3658761-1-songmuchun@bytedance.com>
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

Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
pte_alloc_one_kernel() runs the page-table constructor for kernel PTE
tables.

HVO (HugeTLB Vmemmap Optimization) uses pte_alloc_one_kernel() when
splitting a PMD. Restoring the vmemmap backing pages does not collapse
the PTE table, so a later memory hot-remove eventually frees it through
pagetable_free() on x86-64. That releases the page without running the
matching destructor and leaves NR_PAGETABLE elevated.

Make pagetable_free() the common free-side primitive for page-table
pages. It checks PageTable() and runs the destructor only when the
constructor state is still present. Callers that explicitly ran
pagetable_dtor() have already cleared PageTable(), so they are not
destructed twice; pages that never ran a constructor are freed directly.

Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
Cc: stable@vger.kernel.org # bf9e4e30f353: x86/mm: use pagetable_free()
Cc: stable@vger.kernel.org # 39406c05f8f1: x86/mm: Fix freeing of PMD-sized vmemmap pages
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v3:
- Explain why pagetable_free() does not run the destructor twice
  (requested by Kevin Brodsky)
- Add x86 stable prerequisites (suggested by
  Jose A. Perez de Azpillaga)
- Collect Acked-by from Dave Hansen and David Hildenbrand
- Collect Reviewed-by from Jose A. Perez de Azpillaga and Kevin
  Brodsky

v2:
- Move destructor handling from x86 into pagetable_free() (suggested by
  David Hildenbrand)
- Trim and update the commit message (requested by Dave Hansen)
---
 include/linux/mm.h | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..466875c5908b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3812,23 +3812,6 @@ static inline void pagetable_free_kernel(struct ptdesc *pt)
 	__pagetable_free(pt);
 }
 #endif
-/**
- * pagetable_free - Free pagetables
- * @pt:	The page table descriptor
- *
- * pagetable_free frees the memory of all page tables described by a page
- * table descriptor and the memory for the descriptor itself.
- */
-static inline void pagetable_free(struct ptdesc *pt)
-{
-	if (ptdesc_test_kernel(pt)) {
-		ptdesc_clear_kernel(pt);
-		pagetable_free_kernel(pt);
-	} else {
-		__pagetable_free(pt);
-	}
-}
-
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
@@ -3921,6 +3904,26 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+/**
+ * pagetable_free - Free pagetables
+ * @pt:	The page table descriptor
+ *
+ * pagetable_free frees the memory of all page tables described by a page
+ * table descriptor and the memory for the descriptor itself.
+ */
+static inline void pagetable_free(struct ptdesc *pt)
+{
+	if (PageTable(ptdesc_page(pt)))
+		pagetable_dtor(pt);
+
+	if (ptdesc_test_kernel(pt)) {
+		ptdesc_clear_kernel(pt);
+		pagetable_free_kernel(pt);
+	} else {
+		__pagetable_free(pt);
+	}
+}
+
 static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
 {
 	pagetable_dtor(ptdesc);
-- 
2.54.0

