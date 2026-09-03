Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692D431A23
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439564; cv=none; b=ixgg/Yx7ybKz1QyktmiXcxbBJFYKE1i+DmWklXwnTPI+u7OpOQ7Bkp20blAdWdiSN+Dm/OKI5NNmLz89jipXJSXBVn7GiK7MOOrxDfEWsVeY/ncGcvM3Dr+jSzPWcY8Zm3PW1yqB5F0nJjQP2PtGj1zi2MmIG8fO/bb2DMG/USg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439564; c=relaxed/simple;
	bh=28k83L0x1UjhMROGJfBedIC5EyF4JFBRS4o1LGNEdIg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S1cVuqz2prW3t6442QV5XwrdBqfmwvWgvXgqfAeHwSmk60UBWZUr3Lo/h7AUq5AwbnN2T1a1shFPAzuvOw3e9fbm2UTqVE2UW3YCBoe67VhM3Ssy2tmUEcWnrBU9bWvECF0tNkYjCXZ2BdOzF55BWFOTnnO9z7nTUTQXNNlQAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUK+dvCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUK+dvCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1798D1F000E9;
	Thu,  3 Sep 2026 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439561;
	bh=B53GLbKqxqBVZmDzukyTmqA8vXmJignfBF72Wy8QMdU=;
	h=Subject:To:Cc:From:Date;
	b=YUK+dvCPldyNEwKUzwu9IGpYzpYJaairDU8lfwKlyjj7EcpROLw2WZGUwdEufYpz/
	 PdQ2barQO5ykmALXZCiu6jVOx4ocQhyRRVETA2Z5v5UN26ulNyzDfK4ZBgcvj7glke
	 n2GnIBZtn0kAn4ntNUHdFhbxrEQF4QkkcoPPXxQ8=
Subject: FAILED: patch "[PATCH] mm/migrate: use huge_ptep_get() in remove_migration_pte()" failed to apply to 5.15-stable tree
To: dev.jain@arm.com,ak@linux.intel.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,apopple@nvidia.com,byungchul@sk.com,catalin.marinas@arm.com,dave.hansen@intel.com,david@kernel.org,gourry@gourry.net,harry@kernel.org,j-nomura@ce.jp.nec.com,jannh@google.com,joshua.hahnjy@gmail.com,jpoimboe@kernel.org,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,matthew.brost@intel.com,mel@csn.ul.ie,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@suse.de,pfalcato@suse.de,rakie.kim@sk.com,rcampbell@nvidia.com,riel@surriel.com,ryan.roberts@arm.com,stable@vger.kernel.org,vbabka@kernel.org,will@kernel.org,ying.huang@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:48:34 +0200
Message-ID: <2026090334-saturday-unwell-f39b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ac1ec50d71b953524100ddc09057ee61a3dfaff3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090334-saturday-unwell-f39b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac1ec50d71b953524100ddc09057ee61a3dfaff3 Mon Sep 17 00:00:00 2001
From: Dev Jain <dev.jain@arm.com>
Date: Fri, 3 Jul 2026 11:41:57 +0000
Subject: [PATCH] mm/migrate: use huge_ptep_get() in remove_migration_pte()

remove_migration_pte() converts migration entries back to present PTEs
after folio migration completes.  For hugetlb folios,
page_vma_mapped_walk() returns the pte pointer to the hugetlb folio in
pvmw.pte, but the code reads it with ptep_get().

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(),
pte_present() etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Use huge_ptep_get() to dereference a huge pte pointer.

Link: https://lore.kernel.org/20260703114202.365553-5-dev.jain@arm.com
Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
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

diff --git a/mm/migrate.c b/mm/migrate.c
index 1977905ce12c..b6f56b67e367 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -372,7 +372,11 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
-		old_pte = ptep_get(pvmw.pte);
+		if (folio_test_hugetlb(folio))
+			old_pte = huge_ptep_get(vma->vm_mm, pvmw.address,
+						pvmw.pte);
+		else
+			old_pte = ptep_get(pvmw.pte);
 		if (rmap_walk_arg->map_unused_to_zeropage &&
 		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;

