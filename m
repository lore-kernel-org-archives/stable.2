Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB15342CA7;
	Thu,  2 Jul 2026 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782969304; cv=none; b=YbkhK08Tnobi6Psri8/xf4TdrIAKVaD1/Y3TJ3QRsOiTOMfPFbjz61EfUh9xL9cAC8BIxZU3LW81c30v1JhrloJwDrtZxdleXTQwfW9AW6l76A2+8Vhkz1C2olX0cm566u+VjOA+CBXLCLp16azGqJfZDK1klphcR2XCI8/hFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782969304; c=relaxed/simple;
	bh=YVYXx7DeCmRXI/6Xkq+kjiu0y3ZMotg0IHB7MU6Rf+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFjXXw7zsuLHGGVIAnPiunGkYEHONkBQLyC13l1SyTQcdPSsj4U300gBXACAi1gpv3Y0YgtX5FR3dZ9qHkoIGWI425xt58qNix8jma26bfjISF1BgPwG6jxRmA0VOJYC2TchmR4P6LnUOY7ojh3uV4eLKmI6k+AEytox4Fr0Jlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DKhRSDIO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DKhRSDIO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0A293585;
	Wed,  1 Jul 2026 22:14:57 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84B2F3F85F;
	Wed,  1 Jul 2026 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782969302; bh=YVYXx7DeCmRXI/6Xkq+kjiu0y3ZMotg0IHB7MU6Rf+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKhRSDIOqCQhkTX1IEPSmVgkM/59IaCv/pY2k6Bd5h6m8z4wqBUSZjy54VDD5BRLn
	 mrhAiLbh96u/gKDoMChUuxyrG+/9igIyPCWkfYnaw9PKtxNZek+6uGHOkP8vEIorR+
	 Y3dHBFTViV1wFB6gGFhkduABUrh1JJn9f52xt01g=
From: Dev Jain <dev.jain@arm.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcampbell@nvidia.com,
	apopple@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	j-nomura@ce.jp.nec.com,
	nao.horiguchi@gmail.com,
	ak@linux.intel.com,
	mel@csn.ul.ie,
	pfalcato@suse.de,
	jpoimboe@kernel.org,
	dave.hansen@intel.com,
	tglx@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v2 5/6] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
Date: Thu,  2 Jul 2026 05:13:39 +0000
Message-ID: <20260702051341.126509-6-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702051341.126509-1-dev.jain@arm.com>
References: <20260702051341.126509-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_pte() is the final validation step in page_vma_mapped_walk().
It reads pvmw->pte with ptep_get() to decide whether the entry maps
the PFN range being walked. For hugetlb VMAs, that pointer refers
to a hugetlb entry.

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(),
pte_present() etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Use huge_ptep_get() to dereference a huge pte pointer.

Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/page_vma_mapped.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2ccbabfb2cc17..18e1d341f463c 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -107,7 +107,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 {
 	unsigned long pfn;
-	pte_t ptent = ptep_get(pvmw->pte);
+	pte_t ptent;
+
+	if (is_vm_hugetlb_page(pvmw->vma))
+		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
+				      pvmw->pte);
+	else
+		ptent = ptep_get(pvmw->pte);
 
 	if (pvmw->flags & PVMW_MIGRATION) {
 		const softleaf_t entry = softleaf_from_pte(ptent);
-- 
2.43.0

