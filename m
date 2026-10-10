Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECF3AFCFA
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791631568; cv=none; b=XNIGUeC1fACMgFdv7mQ7XEOz3VHrifFjZOfl3NHOwZ7tfl/jAxfQOBh+tMYMhwuvTN2A+LL+d5/YJW+hyfDKIMhbn5cxH+4LqZ0p8VS/wKOb27jvqcNZeYN2eY4y518mJOO9R7r/mQvaWCE1E4kp/Sa+o2+1uHW3zNg5NKsp9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791631568; c=relaxed/simple;
	bh=nWybq7yQxC8+/T552eckpJODLWJQdYPcXh43xqRBaU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwI1GpUipZ+vKXFelJYZmc9lHenAmkOipz0oOVyfvdBO+hcw+7fNX/dQRYozHHzehv9GaJ92acnvUb5hfS//f+/oP0dtXMgIreEdyJABzdhHn1nTmMk3OhusPLmqmt5h33J6haAYWiqZMv/3Km9YMKfB2BAQ3r0dLKNOkteBFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fe2slg+s; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fe2slg+s"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so342472a91.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791631567; x=1792236367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPrbN6fNnAjfl8a6kAKqWueJEJ1qRXmGBrgomj1Gs8U=;
        b=Fe2slg+snRFvEJcb9Gtuz/v+bbxljiJ1KcA9kD09yO4j8TW0X5M41lmVGTDukEGr2F
         urGM6UWnKjHRE5wyrURxIu5tYNHuPsLJ7/SJblWb1Ij2fx64K0wQpoQbSvIBQ84nMcaw
         71OPOf4RaqrPdA3YW3unPGCDpUalAEfOZpHqu6UgLd+VQt6zm5GrV/tdILqQQiJnNYM9
         1KeXwyc5RgL/Y94XSeLsPp5LMkr2IXhJsJYpq0S8XHa8hAr2wm2Tl1Jy5+OttvL+vIw1
         1tUPfaWYjJdJ9zGyY+9Mpbo6FOkNW6K3nVc9YZgJTiuEZJtJ0J1soMWEyyH3kwr0uhu4
         DyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791631567; x=1792236367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPrbN6fNnAjfl8a6kAKqWueJEJ1qRXmGBrgomj1Gs8U=;
        b=TM3V450t9qNuQHypTIHKoKI9w5GDBJZ4L9hpd6Z3ghrgSrgx2SxT1g8UyjUYgsEH7q
         K3ow5V0xxHYjUopBHTyC7xbd0zpKmhGGsnL3TqEF5/OMXcHHsSl8vD4nKrD56yAyoLbc
         bVcu6chVD10abeTWPidodf7KOknZ11kt/VZSMsHS7QrlBQys+OI7LxgpmSPJRvxgqjN/
         HqRXZydbFSahjQEJkoR/Iz9eqCBYpw1DaCw4eqyQ2QK62F8gd5QEW6i0pheQCgqgkouF
         jYlUEROVvbO14wv+H18C5RImhxgF8E39ByL26qsn0keyeFd8T5QxxOVTjA6d92H3u4sJ
         M2ng==
X-Forwarded-Encrypted: i=1; AKwUvBxF0DYeE/RIEis6cHarhT+pnm0SKQkBszm/IIJZXaloGAZyaduiwC9JssG0idTAIFBJQscY4oc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3p2ErLEICyz05nr84ZsCFne7TcKuwMMWSE8iW0qQNKGzb/kQ1
	IG+SwGgeGuZKl+sPHk2/swi5g9MXtEt3cm6Ixm6RVPiTGb3LVILMzX/ORIgmObRXKwE=
X-Gm-Gg: AYBFou1WoEt906N2rrNEByctq6MwRumPv5ahWF/nqkmsiejlJJNTqvmLXW/mG5wklmi
	elSoD5hglBInMlQAyBsHHn/3fI9DEVSgGStzE0wUfpOf6QHLsq/T4qJzAQWGcdnMJIHrN7MBdSO
	9MqTeyhgNYAkwQOF0ECbJikz9Du8T2Y2/DWqbdVhScE6CyAPn7uem2sG9Pjt4pNf1/ihcueyUtO
	D2CIYIdeTVGMj5pSa8bYWM//cC8SkcSvjUu8czQz4gpmluFUqFY4kpocwtwofx+ztFBSNSfqATd
	RoGasD3TR9HqmzkQYP1VkAgnShrDQKmIrodPre60M35tCCcFZtaHCvqKq/h/oA8Sx8vInB1d3yc
	B1o3J+mXNGUPCWkKosFXuFSH6ffzIKBSPTmmF5wUgumBY4Zvrop2Cid2PB3rNZksiMNdLyrKIaF
	TEa9t4zHgLZxyfbW/LHy510g5D8RQjjgYyflyDAh4nb5qkIaFgWbuZxmfKmVDijaM61gNYlpZeg
	phJg7m3kWp2xRByaVnEwY7V+f6Ss17oLbj5UQ==
X-Received: by 2002:a17:90b:384a:b0:3a8:c0cd:57f7 with SMTP id 98e67ed59e1d1-3ab3a735f76mr3813182a91.23.1791631566480;
        Sat, 10 Oct 2026 04:26:06 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm7900233a91.0.2026.10.10.04.25.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 04:26:05 -0700 (PDT)
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
Subject: [PATCH v2 2/4] riscv/mm: fix hotplug page-table destructor handling
Date: Sat, 10 Oct 2026 19:24:55 +0800
Message-ID: <20261010112457.49485-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010112457.49485-1-songmuchun@bytedance.com>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V uses the same memory-hotplug teardown code for linear-map and
vmemmap page tables. Late linear-map allocations run page-table
constructors, while vmemmap and early allocations may not.

free_pte_table() unconditionally calls pagetable_dtor(), corrupting
NR_PAGETABLE accounting for constructor-free tables. free_pmd_table()
avoids that for vmemmap using is_vmemmap, but mapping type is not a
reliable proxy for constructor state. In particular, it becomes invalid
once runtime vmemmap tables use the normal pgalloc helpers.

Introduce free_pgtable_page() to select free_reserved_page() for reserved
pages and pagetable_free() otherwise. The latter runs the destructor only
when PageTable() is set, handling both constructor-backed and
constructor-free tables.

Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Use pagetable_free() for non-reserved tables (suggested by David
  Hildenbrand)
- Simplify reserved-page handling
---
 arch/riscv/mm/init.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 857f9a55039c..151eb197cb09 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1486,10 +1486,17 @@ struct execmem_info __init *execmem_arch_setup(void)
 #endif /* CONFIG_EXECMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static void __meminit free_pgtable_page(struct page *page)
+{
+	if (PageReserved(page))
+		free_reserved_page(page);
+	else
+		pagetable_free(page_ptdesc(page));
+}
+
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 {
 	struct page *page = pmd_page(*pmd);
-	struct ptdesc *ptdesc = page_ptdesc(page);
 	pte_t *pte;
 	int i;
 
@@ -1499,18 +1506,13 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	pagetable_dtor(ptdesc);
-	if (PageReserved(page))
-		free_reserved_page(page);
-	else
-		pagetable_free(ptdesc);
+	free_pgtable_page(page);
 	pmd_clear(pmd);
 }
 
-static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemmap)
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 {
 	struct page *page = pud_page(*pud);
-	struct ptdesc *ptdesc = page_ptdesc(page);
 	pmd_t *pmd;
 	int i;
 
@@ -1520,12 +1522,7 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemm
 			return;
 	}
 
-	if (!is_vmemmap)
-		pagetable_dtor(ptdesc);
-	if (PageReserved(page))
-		free_reserved_page(page);
-	else
-		pagetable_free(ptdesc);
+	free_pgtable_page(page);
 	pud_clear(pud);
 }
 
@@ -1645,7 +1642,7 @@ static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, un
 		remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altmap);
 
 		if (pgtable_l4_enabled)
-			free_pmd_table(pmd_base, pudp, is_vmemmap);
+			free_pmd_table(pmd_base, pudp);
 	}
 }
 
-- 
2.54.0

