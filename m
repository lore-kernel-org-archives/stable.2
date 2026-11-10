Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272970;
	b=yuN0fumo+AY16za5rR3vuFM1NLuOxT2S03HV0q9Mz0aFGi9qqnilrfKlw18RkRwShq8y
	 LzEfhYA585FIG259N440JuLFLQBslbqg5ru50+O3JQIx9OfGvrRBdSDRGDGKyQVhvCQ9B
	 T7ZpEHLapL9B01vuzEjYquDxIpkKYPkrFcOCg9kBLLr4tEVCuubICGjfzGz7by7E9a12o
	 qIWNIuBsZ6r1dntKDpAoCQTDAImfBPq1FeeDPrwaB0MHx3uCgU+MUZyS86i0b/oO7i96k
	 JUVsV3WchBQk9HyBymo68O4I59mwNh3CqCOF8ooiQdZT0Pb9dWkEYp1O/ULWYebeS1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R3w9pbFmXk4U/1P2NDDd6Igr3BYs7y1NecncpK2dlMY=;
	b=xtCPXsHZwRfTLQW3eWMnOfkw2oX736b54mbNxMDCgObh9cRpiWyo0hoocdpxEW2K687O
	 NopZZFhIB24lGCLJDOQppITAOiTAezWfgaWDejlThsz9aPBXZN+29ibm+ZtASfWJqMJmA
	 GtvMTLYycfnKaK7bcQs4fbRZfzLGmJovRtfjyGHn5smbL+BnaD9xHlCfHC/ISGMvRLGYe
	 XoCiZoWFq7o/zMb31TUTKLCaLkxn2sSBeEIPVtywWRFy2xKxQkOvvkViLjrEt2EVhO7xi
	 1eKVJQrE8hgzPJq4qUZLaSLw4MYh93BhyQcOPahT8qM92ODkll2zxh9CVC/jYKvUovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVCNURjT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA89606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVCNURjT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D071F0089F;
	Tue, 10 Nov 2026 01:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272970;
	bh=R3w9pbFmXk4U/1P2NDDd6Igr3BYs7y1NecncpK2dlMY=;
	h=From:To:Cc:Subject:Date;
	b=DVCNURjTRGakg3+SSJ8tV9Ymtm69ljlOGjS36o9J3evYKjgzc6obSFcr3N5czwZns
	 rAJEspHv5K6APcn0dFHRfymlPHJHvkERrjxrt43i+IC/WdMtbgpQRcB/UvdE8sDMuI
	 lB8rRLLnbPTihqIMQ5D//UlglmNLXRUSvQQzXrk85ttocNmrsrB9YOS8wM1mC7eeVY
	 o1iPpiq4qnW4x52YUC/lAbhwidk9fDBlxVt6SEV0TgHWg0UWnM957iL2JoFVZnFtqZ
	 te66Rp4t6GEhovEBkLkIe0eBAlbjc4qsRH4n6HYO2qyUdMKIqBmBavsXQmaDJ5+mS4
	 ox9x9S/rZfdCA==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	usama.anjum@arm.com,
	kas@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/huge_memory: split huge PUDs when adjusting VMA boundaries" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:28 -0500
Message-ID: <20261109200928-failed-6.12-23e570927421@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 23e570927421d569fdc510d5f3f29542a43eeda5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200928-failed-6.12-23e570927421@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 23e570927421d569fdc510d5f3f29542a43eeda5 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:12 +0100
Subject: [PATCH] mm/huge_memory: split huge PUDs when adjusting VMA boundaries

PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
only handles PMDs.

After faulting a writable PUD-sized VFIO BAR mapping, changing its first
page to read-only with mprotect() makes the PMD walk treat the PUD leaf
as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.

Walk the page tables once at each adjusted boundary and split a huge
PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
PMD-aligned.

Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://patch.msgid.link/20261031-fixes_core-v3-43-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 70 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f10a199548d8f..7de94775a3598 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3504,16 +3504,66 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 	__split_huge_pmd(vma, pmd, address, freeze);
 }
 
-static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
+static bool pud_split_required(const struct vm_area_struct *vma,
+		unsigned long address)
 {
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
+		return false;
+	if (IS_ALIGNED(address, HPAGE_PUD_SIZE))
+		return false;
 	/*
-	 * If the new address isn't hpage aligned and it could previously
-	 * contain an hugepage: check if we need to split an huge pmd.
+	 * Only selected VMAs support mapping PUDs for now. Lift the
+	 * restriction once this changes.
 	 */
-	if (!IS_ALIGNED(address, HPAGE_PMD_SIZE) &&
-	    range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
-			 ALIGN(address, HPAGE_PMD_SIZE)))
-		split_huge_pmd_address(vma, address, false);
+	if (!vma_is_dax(vma) && !vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT))
+		return false;
+	return range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PUD_SIZE),
+			    ALIGN(address, HPAGE_PUD_SIZE));
+}
+
+static bool pmd_split_required(const struct vm_area_struct *vma,
+		unsigned long address)
+{
+	if (IS_ALIGNED(address, HPAGE_PMD_SIZE))
+		return false;
+
+	return range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
+			    ALIGN(address, HPAGE_PMD_SIZE));
+}
+
+static void split_huge_leaf(struct vm_area_struct *vma,
+		unsigned long address)
+{
+	const bool split_pud = pud_split_required(vma, address);
+	const bool split_pmd = pmd_split_required(vma, address);
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/*
+	 * mmap, VMA and rmap write locks protect the walk; the split helpers
+	 * take the page table locks.
+	 */
+	if (!split_pud && !split_pmd)
+		return;
+
+	pgd = pgd_offset(vma->vm_mm, address);
+	if (!pgd_present(*pgd))
+		return;
+
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return;
+
+	pud = pud_offset(p4d, address);
+	if (pud_leaf(*pud))
+		__split_huge_pud(vma, pud, address);
+	if (!split_pmd || !pud_present(*pud))
+		return;
+
+	pmd = pmd_offset(pud, address);
+	__split_huge_pmd(vma, pmd, address, false);
 }
 
 void vma_adjust_trans_huge(struct vm_area_struct *vma,
@@ -3522,14 +3572,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 			   struct vm_area_struct *next)
 {
 	/* Check if we need to split start first. */
-	split_huge_pmd_if_needed(vma, start);
+	split_huge_leaf(vma, start);
 
 	/* Check if we need to split end next. */
-	split_huge_pmd_if_needed(vma, end);
+	split_huge_leaf(vma, end);
 
 	/* If we're incrementing next->vm_start, we might need to split it. */
 	if (next)
-		split_huge_pmd_if_needed(next, end);
+		split_huge_leaf(next, end);
 }
 
 /*
-- 
2.53.0




