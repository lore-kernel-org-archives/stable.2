Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A73368B8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527899; cv=none; b=aQBBUmy5OL8EwzCOteaSc6r5JaqriJeL9XsJlUwEzep40IAka1KI1fH5fPA0dFfIL0yc8KsLDpuTvE0QJWKOFcpGpq7n/rv+xEmI6ccSXTrYZOR0rxBiLs8vd3YlEdV4q3cHSelyVlyWENC5jLC2UP5g1ZmtMCOS/E2n1dWEPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527899; c=relaxed/simple;
	bh=4Ifj5fXeZ70eEACHMG6tC59AGHmYZNRk+9/MhSJSchk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7xy2Q7zDYyJq8LXot9nxIUfLwDkvafPTDdV6dWooc59IN47r/tv/iuxcL6Z8Q6tnlOU9XQisri9R4aJ0asXT/yMtkG0LCA8J7xzwGPxGEMU7r7BiGdCSihzLh0D/us5Rli7fg4FFNUvVI/ANGu8CHrxhF1TTiHmrTJW8jjhWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyrB6H5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyrB6H5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA631F00A3E;
	Fri,  4 Sep 2026 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527895;
	bh=vGSuhgTVcXg1//cRLCcIqOZ6O3FGRrxOpAreaGbK4nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyrB6H5nW/Jw9OfuhwP9xrNBxKEMD1VgtPWkQQ04Vks/aDTg9WhyrNzL9YkKzeQAf
	 +WDnsx1Q32LHQxEz9rFoQscm/Q44EBq31pQsG1n2cGycKL8uw17kT/0Mxv3uZ51vT2
	 bKMfX7W7CCI+Z18u+70T8M/1DEfsNVV7oP5wxkONTkncTReD5wM0zv+XhYwFZDPkws
	 KN2mAKnGfF3/NsNy54YoorLizQrCEYr73UU/b2ae7ux1tdjH8PYYk03GRhYE2vCE4j
	 VsXwvjF2fvWNDdWrv0ciP18fb71GhXP3dkRzGSICi7ISJFIQKAzQCji84f5Ki/1OxW
	 zSTYHxi9EMggQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] fs/proc/task_mmu: convert smaps_hugetlb_range() to work on folios
Date: Fri,  4 Sep 2026 09:18:07 -0400
Message-ID: <20260904131809.503371-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904131809.503371-1-sashal@kernel.org>
References: <2026090314-mumps-septum-7049@gregkh>
 <20260904131809.503371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 6401a2e6900843a77a27873c0529dea68f61193d ]

Let's get rid of another page_mapcount() check and simply use
folio_likely_mapped_shared(), which is precise for hugetlb folios.

While at it, use huge_ptep_get() + pte_page() instead of ptep_get() +
vm_normal_page(), just like we do in pagemap_hugetlb_range().

No functional change intended.

Link: https://lkml.kernel.org/r/20240417092313.753919-3-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: e87df0d5d696 ("mm/page_vma_mapped: use huge_ptep_get() for hugetlb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/task_mmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d0896bf8e12f0..1a9c1c9e53e4e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -723,19 +723,20 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	struct page *page = NULL;
-	pte_t ptent = ptep_get(pte);
+	pte_t ptent = huge_ptep_get(pte);
+	struct folio *folio = NULL;
 
 	if (pte_present(ptent)) {
-		page = vm_normal_page(vma, addr, ptent);
+		folio = page_folio(pte_page(ptent));
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (is_pfn_swap_entry(swpent))
-			page = pfn_swap_entry_to_page(swpent);
+			folio = pfn_swap_entry_folio(swpent);
 	}
-	if (page) {
-		if (page_mapcount(page) >= 2 || hugetlb_pmd_shared(pte))
+	if (folio) {
+		if (folio_likely_mapped_shared(folio) ||
+		    hugetlb_pmd_shared(pte))
 			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
 		else
 			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
-- 
2.53.0

