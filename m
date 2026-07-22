Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24F4C0419
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718087; cv=none; b=n/wwEuzw0+ugD8a3bSv7Afumd9/NgGlh0cRCEYuH7DTOuxaPmDHopfVVk6lUuKbpmapZt63+X1xoY63WPsxZdJUF6i/IQeWF3iv9su+Z/HqVAMX4RJ6mJ0ASIG+eWHb/5L6VsUsNKovajey9neeJJk3Z+0/ZmdT7qtsxwQxIjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718087; c=relaxed/simple;
	bh=r7xwQjrAt41KsqR/DwYWv2dVhTosDu8irts7nySysXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTm25nQGikrzbWndl3GFPdAmC9jojSXnwOJ5GlORFIEZfYxOQVTXzDymdmipx+f71xT+Lv1EAj4/4NaaEYTZK9SpyxEeu8VRDw6UGFnw5Kj+sXu2+3n3/C4TGZOxjbSjbwv/4+XJ3HN6ZtC1zBrhB4CKC1U9ijxetsvG3UMtfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=EWYJfi2e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPLCCboF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="EWYJfi2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPLCCboF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 736787A0057
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:01:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jul 2026 07:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784718085; x=
	1784804485; bh=Wl7nPL6Tx+n1rc5GxPIdN9SYihJF+4a+mEc1Hwtwadk=; b=E
	WYJfi2eqlZoAL6jdkjc2nzSBwFg91E43d6dCj4b1FM3bQoNgzesSW2qD3+KR1/AM
	MmHYwCFVRZn3cX46P4WdveNbvW2GZ5GwtVyhn/iy2bycbMy3n/0EGcDoKFZijxEX
	e0SYkqM8ErC+0RuAQ25NEYbYZcXAv75kNbKsK3qF15QgrDlm0NZlbLnSTklcEhzA
	XS2FMo9mrH3m3n/I2ABMcEfswZspREIHTRs0QOA9ax5yPMPo4kQX+Ez2JeAMtmQy
	GXTwFcEbpvJUgpJ7Fa/BNeEVqzdhy1d88bidSvZ87+fvIAIql/ig8gqP0qhqr3ri
	HdAkETqsM3IwrERRln9Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784718085; x=1784804485; bh=Wl7nPL6Tx+n1rc5GxPIdN9SYihJF
	+4a+mEc1Hwtwadk=; b=MPLCCboFpBkqCyyoOfulZ8dOGq3UHBE94oiSQchk5UPZ
	cM9CHMuE+OK7gkDM0v3i37SLeuWLskgk2qJqwYDKJYsBBm3RGJRDcZnDm+CQJ0q3
	Vcpeyf6OwWi3m99FWntMJi3BsyahVgsAdL/Y72xrLu6+die/qhMBSBj2CqbOg/uc
	E4A8CF+Sw3QYBz2UtAXWJ0hh4ALG5be+QBnoD3FllEE4utLM0TwPBDMvOSuLixdw
	5JrwmBJH3AH2FFzzhFjmSjF5z4+iaTddDsZ31Z7A1p65wtRF/dfd/OUtdOHeHNcJ
	np9EUOjrFmIH+le3lpfPVRAhdsTr9WyB2FDw6fTjjQ==
X-ME-Sender: <xms:BaNgarnPs8z7qAl5Iid5kS8qhNlnj97DZiiKkjOfJ4gdOzQFFSmfeg>
    <xme:BaNgaly8W0iRA_UMe_d37pAKguMmC2hwVCkyMDkenpJlFwb7-hC_BLhR7giGWlycR
    1GaLKlmf99QvhS2BYMSAYjX9lxbXPr3Z3BrolGVWlQYzGGvoN9bYJI>
X-ME-Received: <xmr:BaNganRGPCNjzCRPYN1Y1jIyt8FqEhwSs-0nfQr6QJ1KHzqhsXbUZWxTX9bJTQ>
X-ME-Proxy-Cause: dmFkZTGLYZZMl2hMwQw1LuHd1aYiZcmKqhmiUdpMpdZLck39rkkZE62y0zJcEMlaN+pJ7+
    1ZekjjoFnAPmFjlwkYGe0bZF/qzJAkCXS14GWA/4Y+9yRzNaLjViW95ou/RI/kUM0tTjOU
    ssgNf/mnrZ8kR4Gbunr4wdL2KShfEBiLLNKr1+JA2m82Zn1hGmww6+v6hRXU7ptNJrDJfA
    hTgzVVWE5/TB3fyEMCfebi1gat0ffC99R2R7732aD4dsvXJzLE9PRI2Hx7DcjBRiTkIqP6
    rwttFXZR0P+xngTBaG+DXJJTeyus6jDxGF8JIACMlWHF1iKHx4bQ7T7sxxzQRxiBEpIuBD
    otUsQ1Z+cYCq3juTNyVJ/dNrKERSvN960199ylsPvCMXxLSVgAuvH0zBkmVLfmHjtfBDGs
    e4V30X4MEU+Gq/fbzpgB9CO26R1wl84/0Q7L9ZBUQOcz7wzrG7CarAku5roGbZfD4b6yAn
    zmMmZU7cW5cWGiiufNIDn+zN5Y451Bpr0U+1flYgx7tjZlP2Ta6V6ZWoAscKLXh08NrR6o
    U+s+M05rEVr4qvzH43rQXhTyiIkpz9R9oWv/NuqYejYgBFdvo2pNqF5yWiJYRzHfuULN8v
    HrNwWs4xGDHc3QA2/lfXHtXBBlKqQdUJnw6HF7T1WU4n7GFHOs69IPvq7kRA
X-ME-Proxy: <xmx:BaNgaou4WxuzHTfiMjxlXQxYfIoUMimOUFG9AUbqygVijnJKCNjh1w>
    <xmx:BaNgaptqI1mkmWV-xa5H9lsCd6ueNgUXErSvk_f_A6i6IzcOotzzpA>
    <xmx:BaNgauySajhM_408XbN239VpPXruY1Teb5GNm0HzMEl5bOX9EUlpAA>
    <xmx:BaNgavif7-1dvWlzk8gruO5jhiTZVdhk3VmkoQfrcD5b9bXc4nY7nA>
    <xmx:BaNgar1Aq8r3owHBoevXg86pTlBVddw5IvObJA38btWJb8V5EvlxDPCq>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:01:24 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race
Date: Wed, 22 Jul 2026 12:01:23 +0100
Message-ID: <20260722110123.1908692-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072035-discolor-busily-8d3a@gregkh>
References: <2026072035-discolor-busily-8d3a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

Patch series "userfaultfd/pagemap: pre-existing fixes".

These are pre-existing bug fixes that were carried at the front of the
userfaultfd RWP working-set-tracking series up to v5 [1].  Per review
feedback that fixes should not sit in the middle of a feature series, they
are split out and sent on their own; the RWP series is reposted rebased on
top of this.

All six were flagged by the Sashiko AI review of the RWP series and carry
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>.  They are
independent of RWP, apply to mm-new directly, and carry Cc: stable@.

  1: fs/proc/task_mmu: a missing huge_ptep_modify_prot_start() in
     make_uffd_wp_huge_pte() can lose hardware Dirty/Accessed updates
     when PAGEMAP_SCAN write-protects a hugetlb PTE.

  2: fs/proc/task_mmu: pagemap_scan_hugetlb_entry() compares the range
     against HPAGE_SIZE rather than the hstate page size, so it never
     write-protects gigantic hugetlb pages.

  3: fs/proc/task_mmu: PAGEMAP_SCAN with PM_SCAN_WP_MATCHING over an
     unpopulated hugetlb range self-deadlocks -- pagemap_scan_pte_hole()
     calls uffd_wp_range() while walk_hugetlb_range() holds the hugetlb
     vma lock for read, and hugetlb_change_protection() then takes it
     for write. Install the marker inline instead.

  4: mm/huge_memory: change_non_present_huge_pmd() drops pmd_swp_uffd_wp
     on a device-private PMD permission downgrade, silently losing the
     uffd-wp marker.

  5: userfaultfd: must_wait() applies pte_write() to a locklessly read
     PTE without checking pte_present(), so swap/migration entries
     decode random offset bits and a thread can stay parked on a stale
     fault.

  6: userfaultfd: __VMA_UFFD_FLAGS feeds VMA_UFFD_MINOR_BIT (41) to
     mk_vma_flags() unconditionally, an out-of-bounds write into the
     single-word vma_flags_t on 32-bit. Build the mask from config-gated
     per-mode masks so an unavailable bit is never materialised.

This patch (of 6):

make_uffd_wp_huge_pte() arms the UFFD_WP bit on a present HugeTLB PTE by
calling huge_ptep_modify_prot_commit() with a ptent snapshot that was
fetched without the corresponding huge_ptep_modify_prot_start().  The
start helper is what atomically clears the entry so the kernel-owned
snapshot stays consistent until the commit; without it, the hardware may
set Dirty or Accessed in the live PTE between the original read and the
commit, and huge_ptep_modify_prot_commit() (whose generic implementation
just calls set_huge_pte_at()) then writes the stale snapshot back over the
live hardware bits, losing the update.

The non-hugetlb sibling make_uffd_wp_pte() does this correctly via
ptep_modify_prot_start() / ptep_modify_prot_commit().  Mirror that pattern
for the present-PTE branch.  The migration case stays as-is -- migration
entries are non-present, so there's no hardware update to race against.

Link: https://lore.kernel.org/20260529172331.356655-1-kas@kernel.org
Link: https://lore.kernel.org/20260529172331.356655-2-kas@kernel.org
Link: https://lore.kernel.org/all/20260526130509.2748441-1-kirill@shutemov.name/ [1]
Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 04718f7c9290f95385f0dd328758753dc1c36dec)
[ kas: adapt to the pre-softleaf idiom; apply the
  huge_ptep_modify_prot_start()/commit() fix to the present-PTE
  (!huge_pte_none()) branch ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/proc/task_mmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4c5adfd4fc1f..8d9d36304246 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2485,15 +2485,19 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 
 	psize = huge_page_size(hstate_vma(vma));
 
-	if (is_hugetlb_entry_migration(ptent))
+	if (is_hugetlb_entry_migration(ptent)) {
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
 				pte_swp_mkuffd_wp(ptent), psize);
-	else if (!huge_pte_none(ptent))
-		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
-					     huge_pte_mkuffd_wp(ptent));
-	else
+	} else if (!huge_pte_none(ptent)) {
+		pte_t old_pte, new_pte;
+
+		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
+		new_pte = huge_pte_mkuffd_wp(old_pte);
+		huge_ptep_modify_prot_commit(vma, addr, ptep, old_pte, new_pte);
+	} else {
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
 				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
+	}
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
-- 
2.54.0

