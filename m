Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940312;
	b=jogBKpn9/ifpbJCz7Yy2rsb7NrgIbOPsIjkRREsqiel8bcxWQHXTQN3Ga3xXWnTa1TI2
	 Om/Kn3h9RvdxoeSpWvLimS9VGL56ceV7rmXLKC4ZHynWEWLXp4+wNqeU6GcllDW1Jbyg4
	 C5Ha4aCDzEkQaWqowVu9nPqTD1NMdV1zn84uIcPGe2fhIl1fW2a1y3jT2qozRGNzMq2b0
	 IHf48mzpfuRyzehQ4ZHm5BkiufAkMDc+Hjaj9O6qMNf13cmUxVn+WJD43ay4+SJyPzn0z
	 hy7G1e6mEKg7d8QgezLlW3zNPQiKZ0T+ar/2SoSfdELvpXOWuvNdMSaOgzX5VlJXFwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940312;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ROYhJnwskLbtUSLFDNTgyxYJZVqH7Mi1D1ofZwYsCgE=;
	b=iYMaYrziGOun0oWsPmvdTTYzX3MJitB7KONQXTLe0axkbxXM4rrKEqj4jjHnHhtlVS5s
	 TZCDco5GXd6BKMMGZlwe38H17GPwgBcTW8byPsfiZOooSJvd/MpMIGINHTTMv68bfnpUf
	 JDdj+Fd6u3CbiUlaGzQkRNW8odxR6PQlMl/DJjnZMm130E3G86VcBzWkOkkAAYgRj/Q/8
	 YkPLfgFzm1mXiZ05FItCv2dL/Ny9RykHTDBvMwWuT7LzqLoHdBc2n6pQG0yaRQwC1602/
	 ebAFZ5KKvQ5+O+OOh6zVbfxW5bZYzzJWZW/WscG8DQtGEJyR1CU/cV9DU8+01czQ6dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHIvjNVU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BC606A32C;
	Tue, 17 Nov 2026 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHIvjNVU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863E31F000C8;
	Tue, 17 Nov 2026 18:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940312;
	bh=ROYhJnwskLbtUSLFDNTgyxYJZVqH7Mi1D1ofZwYsCgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YHIvjNVU5ROPBZy/6H9B5IyIvqiqgxp90L+jGjs/45bsODcDHwCD29V1FYs4IjhiR
	 TLeChVrR1kvX+6ot8EtR7QKZSCRtStS+sj6qdaXp7gED+xDKYOGSRehn82Ve0aA4Q4
	 c2rerzv6GHHeHbPa1qbFK3g7lCGC/XkAgzS5UiJ92Jh4s1jZAGF/d4mmC+GwMmTXXQ
	 tRSEY09WEHk21sa9r+QD+O/+VzcFkgVWL8edk+ZRxDh5tUsjEkgozcnUrelqeaH+et
	 gTsNL/88JJByMEsgfyavlaKp2gdN8DU3OX6eX1slhcsTbHZS//osSVLamEzPW2fN9u
	 oYQo919LW8/Bw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 17 Nov 2026 18:31:32 +0000
Subject: [PATCH v2 1/4] mm: update walk_to_pmd() to explicitly return an
 error
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
Message-Id: <20261117-huge-pfnmap-fault-races-v2-1-276007e73bcb@kernel.org>
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
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
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=ljs@kernel.org;
 h=from:subject:message-id; bh=vNl3Zl3ZMfO6x8wWrH4TBXRKhY+lxi4UMdolsZxZ5/4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL+zO0ytvM4bDzj6fNHtzeuarWYVLv0yJTToU2LfiwNt
 k4VKPna3VHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJFNgw/A++HRST1Xxz46y7
 0w6GtXOJ7Xj1h7Ppe8HUmun2aZs/S61hZPi6eMVVxvQdvPmGqx4mKDYcqnL+q71tr/DLWVdvPd5
 U480IAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Rather than callers inferring an error from a NULL pmd return, explicitly
return error codes.

This allows different error codes to be returned for different failure
conditions.

No functional change intended.

This is a prerequisite for the fix to insert_pfn() which follows, as that
needs to be able to tell a failure to allocate a page table apart from a
race with a huge fault, so mark it for stable alongside that fix.

Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3a20d64fd276..67ee25215ca5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2366,7 +2366,7 @@ void zap_special_vma_range(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(zap_special_vma_range);
 
-static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
+static int walk_to_pmd(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -2376,24 +2376,25 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
 	pgd = pgd_offset(mm, addr);
 	p4d = p4d_alloc(mm, pgd, addr);
 	if (!p4d)
-		return NULL;
+		return -ENOMEM;
 	pud = pud_alloc(mm, p4d, addr);
 	if (!pud)
-		return NULL;
+		return -ENOMEM;
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
-		return NULL;
+		return -ENOMEM;
 
 	VM_BUG_ON(pmd_trans_huge(*pmd));
-	return pmd;
+	*pmdp = pmd;
+	return 0;
 }
 
 pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
 		      spinlock_t **ptl)
 {
-	pmd_t *pmd = walk_to_pmd(mm, addr);
+	pmd_t *pmd;
 
-	if (!pmd)
+	if (walk_to_pmd(mm, addr, &pmd))
 		return NULL;
 	return pte_alloc_map_lock(mm, pmd, addr, ptl);
 }
@@ -2532,13 +2533,11 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long curr_page_idx = 0;
 	unsigned long remaining_pages_total = *num;
 	unsigned long pages_to_write_in_pmd;
-	int err = 0;
+	int err;
 more:
-	pmd = walk_to_pmd(mm, addr);
-	if (!pmd) {
-		err = -ENOMEM;
+	err = walk_to_pmd(mm, addr, &pmd);
+	if (err)
 		goto out;
-	}
 
 	pages_to_write_in_pmd = min_t(unsigned long,
 		remaining_pages_total, PTRS_PER_PTE - pte_index(addr));

-- 
2.56.0

