Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703798;
	b=zlsjKh/dGj/vJqARv14y6t8zXr2qOeIuAc6YHe5z/a5gIynbNxlXJvqdC3rDoN5SJXC9
	 E4A/IjCpo6XJZh1sWynBIB7hFyB3KhtC/xqascyUFmD9ozMREmGW4txP9iKBXr+L5UeOJ
	 Yf0AFgD9V3wUUTSnzTSOqRHuz+HnaaM8UB1sQxO4tbPrxRYXJMDehachdl8P5X336oAMy
	 pxNNxlpr8/4FtM9xQhfHq4/ZGr7UTrHOdOxwiF4IIlwizfaWLidLWFbihzRtJOldhZGkP
	 eA1fcpfDWcT78rBo5rneuPajLLX+Zukj2H2ZQWWgvOlmitimMLigagQS2f/UjsmYFaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703798;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yzhx4S6CgopYZuvRvzMNNuzmkmo623ZyQL4HnSkBQWw=;
	b=RMmYge5zOtYaTeeKdP+YoZloRKJ4Phb0g+xPpaPnsiUA3QgDtLiEbDsbBKn1efuy+h06
	 nnRNbEnmwZ6Dk4Dz2FKF19f4VNkFAvoqogqbGxTViVa2qIi8pqbP3YX5Um8waaXMZUzfG
	 EdR/eaMKz5BhOjpxP5uaLmAYJqg7/wcJgGBEd9gYZRa+L0DjNodXomBIGOhgbD2fSZKcP
	 Istdu5w2F4OY+YmgP4BKg/t1/Kh+A6veeoJzAwA9K0tRHwGTId8yztFUEr81T8+a4Wm5/
	 bIIleott8bwHsiifcE0GR/bo9rn9iuJN6mZagpVjnsRDifUfdoD/xGhOscxFrnG5LDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWGKIQZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E9606A31C;
	Thu, 26 Nov 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWGKIQZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD61F00AD4;
	Thu, 26 Nov 2026 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703798;
	bh=yzhx4S6CgopYZuvRvzMNNuzmkmo623ZyQL4HnSkBQWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NWGKIQZIyXqUnKnO0h/KH4YoJGuxxSTsJFUlW4ha1yW6+F4HDf8oHE8B1eRDLwWs6
	 zWSJipOAO0Cre3cRd5mym7yWU8se9TAuWXIdNWgGPhGDHIdEgB40Ucj7IbF/apqda9
	 OUbLG1nXBTzlH67WKF850s3zUPYMIF7rQ0Oy3puK4NrRRQBaqbcnJz2xLGdKWi5yKq
	 +ReT6YyvNcq0nEmMqm7xUyh5lf9RDr+t6RoK3nGOBccILyNZt2YjEKjjfo1Zp3mjHa
	 dc6lmKzE7f7Dp8W1acKveRddT3Htz28nw1gR8tz0uMACsyfnR6jZU/O+LxGSsXGFo7
	 f6zHNlcTO+68w==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 26 Nov 2026 14:36:19 +0000
Subject: [PATCH v4 1/4] mm: update walk_to_pmd() to explicitly return an
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
Message-Id: <20261126-huge-pfnmap-fault-races-v4-1-feecd58bb14f@kernel.org>
References: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
In-Reply-To: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
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
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "T.J. Mercier" <tjmercier@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=ljs@kernel.org;
 h=from:subject:message-id; bh=eSgawdzudFWcEtJVM1nuUlLqHr08H2o5wA7JaB1bBJQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5nF8cNgl+y3yl2ZAlVE94ewdfTVxjZCrL61cGqyS3r
 OATWtHeUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIkIvWVkuPbBOOX8FqcQtdqS
 CY+Xur7PDl8r1PKlx/Hv8QcTKgzCFjMy/H1w9fJV+RUPZnHp/a7c7n6IIUbp3K6bTF9iYtReCDb
 84wIA
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
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d238985dbf01..0e994f076bf7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2383,7 +2383,7 @@ void zap_special_vma_range(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(zap_special_vma_range);
 
-static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
+static int walk_to_pmd(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -2393,24 +2393,25 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
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
@@ -2558,13 +2559,11 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
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
2.56.1

