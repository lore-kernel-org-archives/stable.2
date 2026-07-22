Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D94BC030
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718086; cv=none; b=fppBt2SCvPW8EAayPBKK9fCaRwRwqTof5SPrpN6PqsfEZqogFxY8OtJhVfIMl6CFQhhGURMWPly5gbrPXaXUdsvVvt0Lk7vSGXj2mwngM0ZHHtv2XjQS9ivPtJ1U1lAuFW3vqKR6V5TWrMI8xCzoV24nnLamz/c69sz2GeF/CsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718086; c=relaxed/simple;
	bh=AlyQiJMxT7qMFC+6QLfj8lj9OFYbygQZqHeP7NYp/Ak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpGzAFsXSJ5nS/g81ufuweGo4dcCg34VrPJuuz1j1tVvb6n4P8K15evheA01jgchvb21CBz35RmllgnXtc5Oc2enOCzZ8LEVtl+zVZ3Y4j7dlCZhjI4HI/YvPzu9n9/G9z2/Kdbw/33SSN5dA4JW3yy36Fu1pX7YQkUlVhkFaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=soRpDHLV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FBTEI+pV; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="soRpDHLV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FBTEI+pV"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A69B31D00153
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:01:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 22 Jul 2026 07:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784718083; x=
	1784804483; bh=JC6aWOhXfkYQ8pK3WHuOpIFh/tCLVtdCSstqOiRDSgI=; b=s
	oRpDHLVrT7qlcpwU1lAw8oNTVtLccuGhXJz7evNqie0dFrTqQEDB0pT7Pf/jvCax
	sxQNm5pike8YCCPsIRPUTBD2HZG2poDeu/rqzvmBs0LyNUKzOSBR3Yw9fn0j99qb
	inoD7948U+HduoVo0KxW/Yx/YbGqP+A5CdJMZdeGIksqhkMxGuR10eb4tRkt7kIe
	NTe4npoJWoYGmAs4jc0O07OnYf6WeiH+HNK9fpF12scmID3NfN4hFQtl9pj+05Uv
	YHC7h/bp8SDbICsnXoDqibwbbdIBzKd/wdyQbtgYZft7ZnRmToxFK+qyol5il2C/
	ZgLKHbJAuA3YHeW6BLBwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784718083; x=1784804483; bh=JC6aWOhXfkYQ8pK3WHuOpIFh/tCL
	VtdCSstqOiRDSgI=; b=FBTEI+pVeu4Cy1ggyAQgN16sfWMsDh+XCySv4DEl3BPx
	1WXOa8nWm94eWpiWU2Fm7PX7YZ+Fd5eDJ3i26+vUV11hLmKT0PP/LllE9RY0eb26
	0JJnhNtvnzC4UotRLDVO/ICIc4uaVD2CI4Bzftqi6iMi+LzIYVgmWqx0ClbbvsD0
	+opNCERK/ujxx767x30RuZkHf+UdXGmc2rGH9sValmyKD/MwgkjoIJRbHmYAHmbF
	BS818jEfK0AJogqOD0P693KLiIUjtTTvIjGf85LjwEfbFR0DQq4zFvmZ7jT6nxJ6
	n2rMxZ62orXqORqF2DVzjs3BzXkYRa4o8i9vW9TrsA==
X-ME-Sender: <xms:A6NgakRGuDjTWF9gUAh5eUWhcvJZJOGMDEYyfUIkob3uPANYBrwxBg>
    <xme:A6NgaosX5xqrE-XaMzSVw6NmDoweHUBN74wSB2eKjErALcY9XcYgyRg8dJtLTlZhw
    ETO2qkjm_xw_rO871CjVQwK5lyyIqc7g6H4GpjjOcWsQHCcdVUiIVQ>
X-ME-Received: <xmr:A6NgandT0s3PuU8tqZt28Xre8tgqpUYvlRCEt2YMeVBvlVHkSKTYoLb1HKuP-A>
X-ME-Proxy-Cause: dmFkZTGoOtiQOO9COd3U2ftphsqZ2TZaQg1itl7UNlfmjYKAn5Gp7bvq6ktIxZ2nsjSlxL
    0ex+nQQHV0IQTjWK7T1TY+AO160hqzruLiKq9f7yN3D1Z8YZnZ5lmHTYIkRvDj3b5X3psQ
    a4wSslwqDAV1I21kRdYcvKOvxauhYItTbMpVLgwv17H98EX9WWCYNYC6pn/ilvRL1HwXqy
    JrfxAhC0lsXIzdtI5dy5iTnjYmXOitaQhIC3SaDf9DY7ZL/eYTlwvElX7Bs4DgONJWLkMJ
    mBfhUkz1GfoEtZkjM/pq6snVvTP5M653gyUraDpSc4axAQCmMJoO2YYOOqhKwsWFDIp4l8
    NWXpWzQMWxnsW0WQwY1+cjboMRyqzB2Q5T83I7CJGuCLRHWpEBO1UT1TnTAkK6jjRDG3qa
    vVvgGWepvqj4z3LhCzRG9BiAc7JV53pbVq/bWispfo+kFcOngUDCs78nDKmZ9H4/RHaCen
    7CrKtNRNyAG08+3OmasKOq6sAGM6fpurP9liso05mX5VencOx4oPHnvCRu5vZVQpV6Ji+u
    YzeDW/uOmeqX/+7U+XAeNK12OSVg0iMdKYRdwli8usOyAUcAZsyhZntXsBG8rjuC8KRKtW
    F1kw7oQOFHEwjsHK8cBsUcVC/6i5jFkUbMo8FNvBHywMIVGDGiVNKwCNap0w
X-ME-Proxy: <xmx:A6NgatL0syXsp8B-AFsB9196_5t5JdZ0diyAd71nAGRGJYSEvkzj0g>
    <xmx:A6NgatbeUCqBnAfv3gvv6sItv0r6hQhFWmn4R1OGDdFEVz3g3GKQPA>
    <xmx:A6NgagsSlm-NSqUJh5qstT-yubxFDO_EDRVPt9-Z2JlFFA8hfVullA>
    <xmx:A6NgaiuaPpIKyemdRCUpkfyqWK7KyOohDs5LOz5g2W5y2F0xh2dE3A>
    <xmx:A6NgasQctwvurqMVv3rNocRCtgbRsbb42244OJq2XTquqh9i5Fhe0tgg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:01:23 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race
Date: Wed, 22 Jul 2026 12:01:20 +0100
Message-ID: <20260722110120.1908684-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072036-corsage-untracked-8fee@gregkh>
References: <2026072036-corsage-untracked-8fee@gregkh>
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
index fb01a071b83d..9e0cdae64f2f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2254,15 +2254,19 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 
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

