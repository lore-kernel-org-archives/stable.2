Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797213E40ED
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444656; cv=none; b=C+CNimNWw/VcUlHscuJistON9b7cDVP3u5aEXn4DRvC9SbKwRqd4kYWMylLmL+VAOnLx8ZrJymMCKHAGOb5Kk1ZBJ4SY7iUhQOv00re+jEHF9BTcD+Nksn1oiITRsAEvMPlVU9jn8dQT3P/WKlL9s6m8UoT7s6yAe/vNT3Chozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444656; c=relaxed/simple;
	bh=INyxVPnKC83MyO/UHZgCMkoyzhnaiRcH9H5tEQTZslA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+1IeT8kxUGHJKSWdVslTkzjnTOuaX+QgbTlxSj+qihJ1ppACcvPUKw7Ec1mfVh/eB1o4SBto6qSiIckbAK9CG+jzRtoN+8RNdcHixKcPygIi8btleLv11c9LvG1USflJILeExMnaW8dfLV5+GD6HMFuc9OqXOu46yy7jB+YZf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dk0ej1OR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dk0ej1OR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e4a341d177so28060775ad.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791444647; x=1792049447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7XwukL8/yd82nFdVG9qm4VBZNIyM/fBMMvZK+hA2jjo=;
        b=dk0ej1OR+wutMc4RAl2Yc737vqCb6Nm11de5vq8+s0Pd/Us9n4y6Au8epej6ku9mdu
         vSdtCF6BM6pefIVLyB+3I0lglQpIz8ZR6q9wWsLy+LZbYSJ9vUSRVr69SMqRz2n5f1gm
         pOnXvY0we/DOcqi4AGqELOT8qEuDfMeoH4gbp66Xf+pU/vvHbWjPCa38xpuDr/x7GagK
         Oxp9C82zF/WNP49XXE6DCF5urI0vu2pWgiGNipjGw6Jiv6P01R+DuKX2FifXwTpSKddn
         fw7sdJXBcLJCykJESD3YN4L+TuA/eSH+4KfAhwMp58fetw0RPWox/1MYfA8jr8O1k0z/
         DXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791444647; x=1792049447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7XwukL8/yd82nFdVG9qm4VBZNIyM/fBMMvZK+hA2jjo=;
        b=z81BDWbeL0kHMOBI8FvQXM5P2zO4WigYgTTGA7OSUVynUku1d0qta869G7ffX7n2aU
         mfrNIWsE5897YQUgzi3ykgxMZlEk+l1e0J5aMMOXLoqmC6zs2rM9gwCmduexGO+dU6U1
         mfVUKZcfJHyUWXkN0aBZmi/4TP5wydn4uHH4mF4VUkgHwkexqs8LVruGcbu832Zx3uUM
         J7uOpJmK84Ejk8BzwFxV4vnyU1kB4X1ixP4coqzChEF/HpMhyqvEbCuMvxne7LzJJ/34
         Wd5sHaaqMqN7ojbQp2NPOdUIZVZBeWXLfvRSvvFy7TCqT7eIUqHrUqLA2NVDMKA5sGfY
         3IfA==
X-Forwarded-Encrypted: i=1; AKwUvBxDqOijbGsltJnhXcoCv3qcN+M5pOd+0pphnsvaPHfzuOjEn5CRhmb53eFa87/UBzVYH8FiSNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSm3WpSU3x4yP0NBOviMHCuqJJ+6tneMXiyB7kCCXaQvKjbXWT
	38+X4haw+CsExjZ3JfQza02cITVIydcoopCh8v7RHzkDU5s5SX8Grjc+/U/FSGnIOyY=
X-Gm-Gg: AYBFou1I3+ZbDL0rgtE6UHjV1cNk3UIt2400xQCdKu8J8WzLXOfWyI4OfHdmlBKvkht
	ZEbKab5Msz+iRbyjGHp9CBWicF7R6DChBC/5zHxkkeMbH33ySEgmtCCMhUBJ2kQfopVBxZk/4+O
	Nx0CtvYg2SANhWscV3biuTR1nzKC00OlGFcyfg+PqT1zjRbEAc9e1Q2i4og9QJ2V5Fbe9+tFQF8
	gDd22wyk9uyQBHNUCtgvKJvSnbY3Sul9oApmOyCkiTSnF+Mpxk97vz0ehZosD3hhYKDt6C2WjlG
	lvg1Lf+ZjOYC0WeoHueFVDKiFTmLCuicMz+L2JSUCFbaWe259IALlrxBhazf8SmecedSLTg7qTt
	eHWgl6aTy8kuwX/Pn0FncAC9gjyEOOF7gTe1JOW/UD65uxQTCbDjcY4lRyPpjXwWXZCPkWfdCl+
	3wGdJ4lxTR95SKO387SB/dPXCgeP21MoeZaw9u4PpazF7oOD7FoJ1HCoKklW9h5XOunL34JxsMu
	uhTOxHuJZUiw2ydgS8=
X-Received: by 2002:a17:90b:2652:b0:3a7:b260:9cc6 with SMTP id 98e67ed59e1d1-3a8a1b91be4mr3069089a91.42.1791444647313;
        Thu, 08 Oct 2026 00:30:47 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a438f25dsm3114715a91.2.2026.10.08.00.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:30:46 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	david@kernel.org,
	osalvador@suse.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	bjorn@rivosinc.com,
	apopple@nvidia.com,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH 2/4] riscv/mm: fix hotplug page-table destructor handling
Date: Thu,  8 Oct 2026 15:30:19 +0800
Message-ID: <20261008073021.2512665-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008073021.2512665-1-songmuchun@bytedance.com>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V uses the same memory-hotplug teardown code for the linear map and
vmemmap, although their page-table pages are not always allocated in the
same way. Late linear-map allocations run page-table constructors, while
vmemmap and early allocations may provide constructor-free pages.

The PTE path unconditionally runs the destructor, which is wrong for
constructor-free vmemmap tables. The PMD path avoids that problem by
using is_vmemmap as a proxy for constructor state, but that assumption
will no longer hold once runtime vmemmap allocations use the normal
pgalloc helpers.

Page-table constructors record their state in PG_table. Centralize
page-table freeing and use PageTable() to decide whether the destructor
is required. Keep reserved and constructor-free pages on their existing
freeing paths.

Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/riscv/mm/init.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 857f9a55039c..429a0b015ec1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1486,10 +1486,19 @@ struct execmem_info __init *execmem_arch_setup(void)
 #endif /* CONFIG_EXECMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static void __meminit free_pagetable(struct page *page)
+{
+	if (PageReserved(page))
+		free_reserved_page(page);
+	else if (PageTable(page))
+		pagetable_dtor_free(page_ptdesc(page));
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
 
@@ -1499,18 +1508,13 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	pagetable_dtor(ptdesc);
-	if (PageReserved(page))
-		free_reserved_page(page);
-	else
-		pagetable_free(ptdesc);
+	free_pagetable(page);
 	pmd_clear(pmd);
 }
 
-static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemmap)
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 {
 	struct page *page = pud_page(*pud);
-	struct ptdesc *ptdesc = page_ptdesc(page);
 	pmd_t *pmd;
 	int i;
 
@@ -1520,12 +1524,7 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemm
 			return;
 	}
 
-	if (!is_vmemmap)
-		pagetable_dtor(ptdesc);
-	if (PageReserved(page))
-		free_reserved_page(page);
-	else
-		pagetable_free(ptdesc);
+	free_pagetable(page);
 	pud_clear(pud);
 }
 
@@ -1645,7 +1644,7 @@ static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, un
 		remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altmap);
 
 		if (pgtable_l4_enabled)
-			free_pmd_table(pmd_base, pudp, is_vmemmap);
+			free_pmd_table(pmd_base, pudp);
 	}
 }
 
-- 
2.54.0

