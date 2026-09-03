Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65FC4AA026
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439560; cv=none; b=pZG0f9tW3tpDdJB9TtO6zFxszNtqM5cR64zEDrOnBHgtsGnqsru1hyipjh2Slga2JpbBOg9LrcZlpO6RZLC+M2klAffHTUMl5CSEB35u7yqgs1QKrwR7sNJI9/22+YVpmmjJD+socVGsTyzunP9ZEgYHFSx5NW9wVTv75xeFgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439560; c=relaxed/simple;
	bh=NsQdXvIdEmsbGOeOSJ0fjz4p6EU1pqWa2qgvVtVChe8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E46AzzbWXOg5Ttl82R49tHrT7R2/CmDtsqAAd1Uh7U3wwIU5eBAdZ7vVSPk2iT2SmGbZrXa45j4tlIMRGTRvFBokCbDWJN0oYqpDol7uQTfnujGT2ss9oNu1HWvhykr70qoLJDN68oHh24ckej9QPbu0r9V5JmAmzulrydDAd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HK+pJuXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HK+pJuXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868C71F00A3A;
	Thu,  3 Sep 2026 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439556;
	bh=4OyUbk2gQRcAMOcpCr8qJWyrqY6C8o53/URejaTBGF8=;
	h=Subject:To:Cc:From:Date;
	b=HK+pJuXfHGmC3dacmabZ7P8FbRv+Pmn7qw6HOZcKVAkZ3gnrU6E0X9VZH0XL3Lzti
	 hKNtm7vdarl+hqeD0Yz/HoCGD7qsgQRuQvDuhNavjSnR9f0OWMDNK+nEO9ltsQ1QDL
	 9xC8EdWfc5xzat+kBgaZqgqfAuL08WGm2MH00+Mo=
Subject: FAILED: patch "[PATCH] mm/migrate: use huge_ptep_get() in remove_migration_pte()" failed to apply to 6.1-stable tree
To: dev.jain@arm.com,ak@linux.intel.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,apopple@nvidia.com,byungchul@sk.com,catalin.marinas@arm.com,dave.hansen@intel.com,david@kernel.org,gourry@gourry.net,harry@kernel.org,j-nomura@ce.jp.nec.com,jannh@google.com,joshua.hahnjy@gmail.com,jpoimboe@kernel.org,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,matthew.brost@intel.com,mel@csn.ul.ie,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@suse.de,pfalcato@suse.de,rakie.kim@sk.com,rcampbell@nvidia.com,riel@surriel.com,ryan.roberts@arm.com,stable@vger.kernel.org,vbabka@kernel.org,will@kernel.org,ying.huang@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:48:33 +0200
Message-ID: <2026090333-amigo-cassette-d4bd@gregkh>
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
git cherry-pick -x ac1ec50d71b953524100ddc09057ee61a3dfaff3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090333-amigo-cassette-d4bd@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

