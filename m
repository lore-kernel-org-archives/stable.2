Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C264A99D2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439509; cv=none; b=oEL/u9lb5Smi5Vw6n+K+/TB02qWdOJaQsZHwJtBiFHZGuVBQuEWVGEptlTolunpluxmfLQHZZXa3BNAcCILsw9/5FFH49gNMPGKEMxs+Ua6S7JkeK1jpJnMcnnsCbnK+WdezXuv6yWV9Gn8nndKUvXxEp4mUO98zcGh4GtWHPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439509; c=relaxed/simple;
	bh=zlSM0UtsXtTfIKZJRvsT/Ur5KGz9Ea2E3M90pZeNQbU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sTMdoXjnNDJf2lOVigKmfMRAt4huIp2RyCmRprHV/PLNOryBf1D+29fIzsOygwhnGb2M7O97EH6blOZ1mxon+55D1XDKmPotbMzQrm06o0RoduxIgIYj2TE2UiJt6I13lVxYX+IdoezzYVIcQJJr7GrU1IdVJLGCJb3Hiitq+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKRLiARn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKRLiARn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84E51F000E9;
	Thu,  3 Sep 2026 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439508;
	bh=m/WswT93i5+MR1lSZUVMmAhUScYg16Zwlx/+2kDYEIQ=;
	h=Subject:To:Cc:From:Date;
	b=vKRLiARnMLAzVrxnEPlewRCqQp7Z6IQ7zHGiHBwD6Y48Zy4i6E8jn7PE/CY3t5TvF
	 I3b74ZuanJwswjWED3eA24zaSDr8UActwvrKGpX/rW6iK5z5B+C7+JA3Vcn+g2CMbf
	 VF49fme+8UdffHKxbgf4g1jEz5i0yVpmE9uoo/WE=
Subject: FAILED: patch "[PATCH] mm/hugetlb_vmemmap: fix __hugetlb_vmemmap_optimize_folios()" failed to apply to 6.18-stable tree
To: muchun.song@linux.dev,akpm@linux-foundation.org,aneesh.kumar@linux.ibm.com,david@kernel.org,fvdl@google.com,liam@infradead.org,ljs@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,osalvador@kernel.org,osalvador@suse.de,ritesh.list@gmail.com,rppt@kernel.org,songmuchun@bytedance.com,stable@vger.kernel.org,usama.arif@linux.dev,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:47:20 +0200
Message-ID: <2026090320-cufflink-ambitious-4582@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6e25c6a9c7eff141ecfc966ecdb7801db2a8810e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090320-cufflink-ambitious-4582@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e25c6a9c7eff141ecfc966ecdb7801db2a8810e Mon Sep 17 00:00:00 2001
From: Muchun Song <muchun.song@linux.dev>
Date: Fri, 12 Jun 2026 11:58:46 +0800
Subject: [PATCH] mm/hugetlb_vmemmap: fix __hugetlb_vmemmap_optimize_folios()

__hugetlb_vmemmap_optimize_folios() uses incorrect arguments when handling
bootmem HugeTLB folios.

The section number passed to register_page_bootmem_memmap() is derived
from the vmemmap virtual address of folio->page instead of the folio PFN,
so the bootmem memmap metadata can be registered against the wrong
section.  The helper is also given HUGETLB_VMEMMAP_RESERVE_SIZE even
though it expects a page count, not a size in bytes.  In addition, the
write-protect range is based on pages_per_huge_page(h), which does not
cover the full HugeTLB vmemmap area and can leave part of the shared tail
vmemmap mapping writable.

Fix the section lookup to use folio_pfn(folio), use
HUGETLB_VMEMMAP_RESERVE_PAGES when registering the reserved memmap pages,
and use hugetlb_vmemmap_size(h) for the write-protect range.

Link: https://lore.kernel.org/20260612035903.2468601-3-songmuchun@bytedance.com
Fixes: 752fe17af693 ("mm/hugetlb: add pre-HVO framework")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Frank van der Linden <fvdl@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador (SUSE) <osalvador@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c713c0d2593a..ea6af85bfec1 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -635,12 +635,12 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			 * mirrored tail page structs RO.
 			 */
 			spfn = (unsigned long)&folio->page;
-			epfn = spfn + pages_per_huge_page(h);
+			epfn = spfn + hugetlb_vmemmap_size(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
 					HUGETLB_VMEMMAP_RESERVE_SIZE);
-			register_page_bootmem_memmap(pfn_to_section_nr(spfn),
+			register_page_bootmem_memmap(pfn_to_section_nr(folio_pfn(folio)),
 					&folio->page,
-					HUGETLB_VMEMMAP_RESERVE_SIZE);
+					HUGETLB_VMEMMAP_RESERVE_PAGES);
 			continue;
 		}
 

