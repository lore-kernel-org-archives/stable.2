Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7C55C1DE;
	Thu, 15 Oct 2026 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080502; cv=none; b=IL00LMzDkB3mB9eOONWeJbpt+it/lGtP591NiKimPifY4/S/f9EbvPstKam1Fs4LhaWIhmWKil7tEnP+/fZgM8m9R+CfQC21/2ACuiCgk5PCQulyo8aP52GThGA/2HTmRMsUm10nbbe/LdzsX8Le9u+RxCOGPkaV26QI3doRalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080502; c=relaxed/simple;
	bh=+A1Chphb2VITOuNoz7RmBYZYcGXcwS2W5/AbSTwZtoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gB2us4l6eD/JweJMO678xFtY7rKdbrG/fLMWbv8s7klV2A8oDbVDcgnC6RFQ9r8/8Ki1fizqyrEnJ0k4NTkg48BG7jBbVQqw865MKschSifarJczD4nTeyprk4Z2yIJk7JDK9tcPIySQ6yE6s0lcgmASBp2zWNU05dDbbwEH8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYcxpNIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYcxpNIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3A01F000CC;
	Thu, 15 Oct 2026 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080487;
	bh=eqtt2G7yriEeHnOR1/BbpfoTCAOmwPLLgIR0/nLFghI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZYcxpNIFmgCQLbJ6gKyzpvUn7tozj4+2u7vUUUL+7Aqo1W3aYwEw8PGzXGi32Wvij
	 OxjNg5lRcSvx811juXHVi5R43K/h+tHrxDIlWq4X7woi2AfJUMzhFRAM2hvfFtkqAc
	 zo1PaPqXFL06M+UnAh0E10nXPAWC5GOWrIDWwCBDSEX2O+06CC6NEhnfIbS0hnieTX
	 ygopodw7SUNSJ4DHMKzIxtUJjGU0YfKJdrU5OVMPuS0ae4AEemAEMeClPSsaJvuRbS
	 clwz5u8Lqxs+Z3nIy5gK+H49YplBh0PH9ilp20xalypFnd30cBVNro5R+d4Qif+PfV
	 NzPfB0acVJLxw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:13 +0200
Subject: [PATCH 07/10] mm/hugetlb: tolerate uffd bits set without uffd for
 PROT_NONE PTEs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-7-42796911043b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=david@kernel.org;
 h=from:subject:message-id; bh=+A1Chphb2VITOuNoz7RmBYZYcGXcwS2W5/AbSTwZtoE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DJulRZwuF5+1XCm2AsPcXa1rWLN5dPLRQr/rm6o4
 twZuNG3o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIlEuTIybOy203dTeec342v3
 Tp8/l9aVRk/yeS9ffmqX+DW27kcHNjD8FXjetnKq72OJ1qzn277qy8govLZy/bnx1b29+vedTs5
 z4gcA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

The whole uffd handling when a VMA is unregistered from UFFD is shaky:
there are still some scenarios where we might have stale uffd PTE bits
in VMAs no longer registered for UFFD, which confuses other code.

Let's just tolerate that for now and simply clear the PTE bit. Add a
TODO to really clean up any uffd leftovers when unregistering a VMA from
userfaultfd.

The handling is now more similar to what we have in handle_pte_fault().

Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c3823f1958568..ba6860b9b7f4c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6127,16 +6127,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * NUMA hinting), so let normal hugetlb fault handling proceed.
 	 */
 	if (pte_protnone(vmf.orig_pte) && vma_is_accessible(vma) &&
-	    userfaultfd_rwp(vma) && huge_pte_uffd(vmf.orig_pte)) {
+	    huge_pte_uffd(vmf.orig_pte)) {
 		spinlock_t *ptl;
 		pte_t pte;
 
 		/* Sync: drop hugetlb locks before blocking in handle_userfault() */
-		if (!userfaultfd_rwp_async(vma))
+		if (userfaultfd_rwp(vma) && !userfaultfd_rwp_async(vma))
 			return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
 
 		ptl = huge_pte_lock(h, mm, vmf.pte);
 		pte = huge_ptep_get(mm, vmf.address, vmf.pte);
+		/*
+		 * TODO: fix all cases where uffd PTE bits remain in VMAs that
+		 * are no longer registered with uffd.
+		 */
 		if (pte_protnone(pte) && huge_pte_uffd(pte)) {
 			unsigned int shift = huge_page_shift(h);
 

-- 
2.43.0

