Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9E37F74B;
	Thu, 15 Oct 2026 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080478; cv=none; b=lFOto30WoilefsJj1uiWkzoidXgoHcXFoZT6PGUfY7/sPVjGnq8/9EHs06sK4jIkeTTav5/WIZ2LoSsv2V3RH41Z+/Vd4/3ODXJVDnxlVsc3HOVUFUQSuGX7B6G2KZX/jwB2s0HlZG4EMlyx+CWzuv3otD3roZR6a76aRbhd9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080478; c=relaxed/simple;
	bh=Hw68Xl0G1E+o58UO13jm0l+jupYSoJKy2G+eUgleY7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=taK6mmGGDmjZCjHTLsEk2L2pKdi7YQSs3B1BL7ZiIye0RQnTKnyK8gjvOXGIYgo0CZDFuGDJuWX2ukUvhUCfllb/jnCwqxcFMRXDUDZb+/oHRoj0eeYzeVpT6UxPZW0/nMpFSSiXmfgoS1+Ln/LOhjaliBRVzq0ayRhkMfQMrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxcQo8mE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxcQo8mE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B271F000C6;
	Thu, 15 Oct 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080461;
	bh=sxQdEIHHQczO8FrqgYpZ12aLH3TYfe0Zx2M3uMQqQ28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DxcQo8mEM+dyXRPVyXdvrAZHITYnPqATklWnP6c59RjxxpgAJdcqsEUGv6vSESwuo
	 eB9X1OXRRgFh33CpYLk7UAJvucKXNiBOU3KoHPXbngY0/RxAYO/wCI8gTS8PWD6/Gl
	 Tm9e0MhdEORTNg42IQUZJ4XIqn4Q3uVIni4Nz9PQ0iXrDo02th0CuF74ZJN9sajcQu
	 V3CK+tIUf/ZwqXsbvaBcjAcI8oupGumCCFqOh7f05ozc+Z6DhDI4/WYfqo2otdZoST
	 xv1BcXxPfntQ0o4QPK+3KYFU/HycxYTVTgwi0RZcp6KxhVQBIO8Ad4GCIrR1ZAifnh
	 lb6XfpoIUL/9A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:09 +0200
Subject: [PATCH 03/10] mm/hugetlb: fix use-after-free in
 hugetlb_mfill_atomic_pte()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-3-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=david@kernel.org;
 h=from:subject:message-id; bh=Hw68Xl0G1E+o58UO13jm0l+jupYSoJKy2G+eUgleY7o=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DJ+9yLJdP5cZrYNExY1eXS39HxtTig98JP114lf2
 /w53H53dZSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCR4+KMDHMk9zFM7L1bMGV3
 0LszuusCAo0a7r1esybkwsMjsu/mfg1mZNjnuv3dokxf6SsGdczXQk0m6JwP2nh3BvtZtmdiMWv
 /7mMHAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's fix another instance where we use a folio after dropping the PTL,
where someone else could e.g., MADV_DONTNEED it once we drop the PTL,
making us trigger a use-after-free on the folio.

Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
Cc: stable@vger.kernel.org
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ce9e87228ec62..86928d76ef12d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6478,11 +6478,16 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
-	spin_unlock(ptl);
 	if (!is_continue)
 		folio_set_hugetlb_migratable(folio);
 	if (vm_shared || is_continue)
 		folio_unlock(folio);
+
+	/*
+	 * Hold the PTL until we're done with the folio: the page table owns the
+	 * folio reference now.
+	 */
+	spin_unlock(ptl);
 	ret = 0;
 out:
 	return ret;

-- 
2.43.0

