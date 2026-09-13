Received: from mta0.migadu.com (out-240.mta0.migadu.com [91.218.175.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAC126BE1
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789276813; cv=none; b=h80f10sF3KQ9oMJgMoxhkDTXY9LxiWAfBZBmEOofGlIu/X2EO3/gUdhAIZFkxtVdyDy5XEHEB/2nYa2J0W7/w3FKYG7dzBaGdeCyVQGTQgmI6wpsW8cmyocM15sgZEwUIH0DTKj3wu8llZG3C4xc8YV8oifdpkO8ozZaozoNW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789276813; c=relaxed/simple;
	bh=NMYn3pbfZMJwwPcgVnZkDAC09qrdHDK3+hZHa3z6uk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgETGH5zYvQTSqoMzdy1OsoaIB0zw89nRPOgbrbwLS39NSJohW4DN5CdAwBepMkkroUUm8thkt4ipzjh00v8MHMh/YjSU9EBkWVZRF22crvq6dkASMH7kRuPC56pc1kZU7KmwzdhjzZYQNM8ZyyGI2zpLBzrpF6l9z2uP0hgtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yo+prUFH; arc=none smtp.client-ip=91.218.175.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yo+prUFH"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NMYn3pbfZMJwwPcgVnZkDAC09qrdHDK3+hZHa3z6uk4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789276806; v=1; x=1789881606;
 b=Yo+prUFHLs/xWM/XhCDAN8KP6uq2i1UCGPQgoXKEvxYTlntSRFCGhqDu5XrUaCha/s4IEVzA
 4ko+nQkhugGu79Z0UVGNmNUxRgK5o/WNU6DYx3ggwwafBEky3UbU7cjaTO9Cv8/GHxi+gTQFWFz
 WOPFqBXhyyQ5WQ7PWpH9UPHk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8181c55abab0265d;
	Sun, 13 Sep 2026 05:19:56 +0000
X-Mizu-Trace-ID: 8181c55abab0265d
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	ljs@kernel.org,
	surenb@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] mm/huge_memory: fix pgtable withdrawal for huge zero PMDs
Date: Sun, 13 Sep 2026 13:19:42 +0800
Message-ID: <20260913051942.40889-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

has_deposited_pgtable() uses !vma_is_dax() to decide whether a huge zero
PMD has a deposited PTE page table. That also accepts raw PFN mappings
of huge_zero_pfn, although vmf_insert_pfn_pmd() does not deposit a page
table on x86.

Zapping such a mapping would call pgtable_trans_huge_withdraw() without
a corresponding deposit. With pmd_huge_pte(mm, pmd) == NULL, that causes
a NULL pointer dereference.

Use vma_is_anonymous() for the huge zero PMD check. This matches how PTE
page tables are allocated, deposited and moved.

- For anonymous page faults that install a huge zero PMD,
  do_huge_pmd_anonymous_page() allocates a PTE page table and
  set_huge_zero_folio() deposits it before installing the PMD.

- On fork, copy_huge_pmd() allocates and deposits a PTE page table when
  copying a huge zero PMD into an anonymous VMA.

- Raw PFN mappings use vmf_insert_pfn_pmd(), and DAX file holes use
  vmf_insert_folio_pmd() to map the huge zero folio. Both use insert_pmd(),
  which deposits a PTE page table only when arch_needs_pgtable_deposit()
  requires it.

- Moving an anonymous huge PMD preserves its deposited PTE page table.
  move_huge_pmd() transfers the deposit when necessary. For UFFD MOVE,
  both VMAs must be anonymous, and move_pages_huge_pmd() transfers the
  deposit as well.

Keep arch_needs_pgtable_deposit() first so architectures that require a
deposited PTE page table still return true regardless of the VMA type.

Commit d80a9cb1a64a ("mm/huge_memory: add and use
normal_or_softleaf_folio_pmd()") removed the vma_is_special_huge() check
in zap_huge_pmd(). That check skipped the huge zero PMD deposit test for
non-DAX VM_PFNMAP and VM_MIXEDMAP mappings. Removing it exposed these
mappings to the incorrect !vma_is_dax() test.

Fixes: d80a9cb1a64a ("mm/huge_memory: add and use normal_or_softleaf_folio_pmd()")
Cc: stable@vger.kernel.org
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6895b38e4704..0ed997a97416 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2529,11 +2529,11 @@ static bool has_deposited_pgtable(struct vm_area_struct *vma, pmd_t pmdval,
 		return true;
 
 	/*
-	 * Huge zero always deposited except for DAX which handles itself, see
-	 * set_huge_zero_folio().
+	 * Huge zero PMDs have a deposited page table only for anonymous VMAs,
+	 * see set_huge_zero_folio().
 	 */
 	if (is_huge_zero_pmd(pmdval))
-		return !vma_is_dax(vma);
+		return vma_is_anonymous(vma);
 
 	/*
 	 * Otherwise, only anonymous folios are deposited, see
-- 
2.39.3 (Apple Git-146)

