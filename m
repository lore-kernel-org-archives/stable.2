Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF94AA1CB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439583; cv=none; b=KW/j730FTGpgPaceTcMhhGCy0UQWxx7yb6Rq48LZTTGyfo+B3TvdjOfoj/Pvixjm3BUaU6UWrCEnYT0vLs1smV7p3FSL9IwtqyB4nz1+/bgh7xQVKbabJ/okjhCqQSlZgm+WZ/gQ4VShD+wtL/JxvO9Y5EyY8Xn1O5yOIhTU5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439583; c=relaxed/simple;
	bh=qqZ09F/rVvyYt+8hFDOBKU5fFjHtosNU90QpeCKbMmA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hON/r7n+u2/HzA8idoNeltHqIKopImQPJg8uOuvN7Hts33dUUmjEZr/PGvbX5UExrmJk09jp85PUEaM4csG/waLBh1EXmmFzseK2x65AmGyrN6i+QnxT1t2OYj0RAY0S1yoaPgtpweLTiuuIH9l1bAAEPTY/utvHbltgkPwiGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QW2caWvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QW2caWvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B247D1F00A3A;
	Thu,  3 Sep 2026 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439581;
	bh=qy/2bo3NimKPM9haylFn5/qz0pXitx9n9yI6driKLM4=;
	h=Subject:To:Cc:From:Date;
	b=QW2caWvuQstP/HkftFPK6XSJ22ad30YgRDRAr20FIBoI2XmM9qvtWlSxTlCAX+Aa9
	 NIrHWUN9GThIUN7mjGeaPQMWreDNFk6xQ7hluoPbAEa3y6NpUj7VokumYt68mx+0R4
	 H3p/0skpTlyz57JYUeovIfqM0kjCagfRiMsDHjDc=
Subject: FAILED: patch "[PATCH] mm/page_vma_mapped: use huge_ptep_get() for hugetlb" failed to apply to 6.1-stable tree
To: dev.jain@arm.com,ak@linux.intel.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,apopple@nvidia.com,byungchul@sk.com,catalin.marinas@arm.com,dave.hansen@intel.com,david@kernel.org,gourry@gourry.net,harry@kernel.org,j-nomura@ce.jp.nec.com,jannh@google.com,joshua.hahnjy@gmail.com,jpoimboe@kernel.org,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,matthew.brost@intel.com,mel@csn.ul.ie,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@suse.de,pfalcato@suse.de,rakie.kim@sk.com,rcampbell@nvidia.com,riel@surriel.com,ryan.roberts@arm.com,stable@vger.kernel.org,vbabka@kernel.org,will@kernel.org,ying.huang@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:49:26 +0200
Message-ID: <2026090326-freestyle-gratify-7686@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e87df0d5d6962bde50f55f6d02b779daa394f894
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090326-freestyle-gratify-7686@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e87df0d5d6962bde50f55f6d02b779daa394f894 Mon Sep 17 00:00:00 2001
From: Dev Jain <dev.jain@arm.com>
Date: Fri, 3 Jul 2026 11:41:58 +0000
Subject: [PATCH] mm/page_vma_mapped: use huge_ptep_get() for hugetlb

check_pte() is the final validation step in page_vma_mapped_walk().  It
reads pvmw->pte with ptep_get() to decide whether the entry maps the PFN
range being walked.  For hugetlb VMAs, that pointer refers to a hugetlb
entry.

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Use huge_ptep_get() to dereference a huge pte pointer.

Link: https://lore.kernel.org/20260703114202.365553-6-dev.jain@arm.com
Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Harry Yoo <harry@kernel.org>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jann Horn <jannh@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Jun'ichi "Nick" Nomura <j-nomura@ce.jp.nec.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Mel Gorman <mel@csn.ul.ie>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index bac2eb5de63d..d7670ba4147b 100644
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

