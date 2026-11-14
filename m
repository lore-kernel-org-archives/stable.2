Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630283;
	b=w2J91zFhEKcX1A1D9OghRcnI6ObrAwjX7w/7VvFMdz7lUmcmdkHSPOJscQ2CKSprlORY
	 We2KBkCxP6+c+PG68vuRjiqQwzsOfsx56qASlCOhsEIE3+4YL2K39icWSxCJ6UrboDLY9
	 FeA9Ow3aTjNfBWnk3DQ8NwIcx2NOqH6MyHRGwoH+oQztACWqPdS1uAU+o0nZFqO4+s5oF
	 Pl+ZyN8h1B+yWMcMQraTtQMeenaAN9+vCR7/ONJC9zplpJhmpOLnZJPXvo+IrRvAjg+Bo
	 qxuFc4BJWBVXvMf+AWfzUG9HKeRdNDC5dARR8zunWI6hNxlOlMYdhD7LRp3QZsg4SoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=joKHWasDVx94xJaDBf76q7rwDUpQIE4X9bCzWu1KkXo=;
	b=sbvROnZ/YdtIvIrCDCaJikY5grMh/gyL8cWQv2qZIOvPghqYKym50Nlx9vyrADlG6/YE
	 TCZlquXZ8eccwzeLA7bGwzPM/jhVv/w5oc8H9MNF1m+2rk93wXKM/W0uCCq/G7OGzTA7N
	 JyQZd3wThoTvJanl5lu3mKGS33o/r+KJEQ6OF7Ibq3W2HaIF2vc6brs+59gc6IM1CVhhy
	 3jYerbk53/lJNAAyS5/z6VRzCyK14k4tA1w7vSGKAaBWNIbFRlOfGDyM0ASWFLH6TYR9W
	 vtfAbN3F0WHyjLjwAjsts9m8HcYx4ReVmHxIgL96KpuVFvogVWb8zZqVuMCO8dOcRIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hs0qXFUI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817D606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hs0qXFUI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756411F000C4;
	Sat, 14 Nov 2026 04:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794630282;
	bh=joKHWasDVx94xJaDBf76q7rwDUpQIE4X9bCzWu1KkXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hs0qXFUI02nL2eDVAKGvtUuDmbRV8Mur82ZYIY2m3KiLhTJgZzw8dLttyzht0W7e/
	 efWPs6pmmErAZZiIg405tL6enVYnfsAfEQaBojWhhyYiSd1BA3yaycS5jmuk+Iec23
	 IzXH8mQaKD9qX8kw2fuiuj703RIhLeeKSoR2QU1bMy4YnbAQRmL4HW3OUjBsijSpyV
	 UzyiLq7jtpD0h6nLBsKtuINtzUWDY00aH+aRQqV/4/zRUVjtc33WUPs/ICpPyuWEnV
	 M6TexpAcm3FLmMvvMpAzR2xxl43+2fIEgcft1PeTE5yI21NYwwW0XBpRwfQSHSnFxN
	 aVkjezANrrQzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/rmap: handle device-exclusive entries in folio_referenced_one()
Date: Fri, 13 Nov 2026 23:24:40 -0500
Message-ID: <20261114042411.2838629-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200320-failed-6.18-f3c493d2f42b@kernel.org>
References: <20261109200320-failed-6.18-f3c493d2f42b@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit f3c493d2f42b5f44a5c134d8d7ea7f960caf5e2c ]

page_vma_mapped_walk() can return non-present device-exclusive entries,
but folio_referenced_one() passes them to PTE young-bit accessors that
require present PTEs.

We must neither call clear_flush_young_ptes_notify() nor
folio_pte_batch() with non-present entries. For example, clearing the
young bit on non-present PTEs can corrupt the entry: on arm64
PTE_AF overlaps the swap type, so clearing it turns a device-exclusive
entry into an ordinary swap entry.

folio_pte_batch() will VM_WARN_ON_FOLIO.

Apply the same approach as the previous fixes to e.g., damon_ptep_mkold():
treat these entries as old from the CPU's perspective and obtain their
young state through the MMU notifier.

Skip PTE batching and MGLRU look-around for non-present entries, and
don't modify non-present PTEs.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-9-d6437171ecc3@kernel.org
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: adapted batched PTE handling to the existing single-PTE APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 03d7d666cc578..14b5d9f2093fd 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -858,6 +858,7 @@ static bool folio_referenced_one(struct folio *folio,
 	struct folio_referenced_arg *pra = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	int ptes = 0, referenced = 0;
+	pte_t pteval;
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
@@ -901,12 +902,25 @@ static bool folio_referenced_one(struct folio *folio,
 			return false;
 		}
 
-		if (lru_gen_enabled() && pvmw.pte) {
+		if (pvmw.pte)
+			pteval = ptep_get(pvmw.pte);
+
+		if (lru_gen_enabled() && pvmw.pte && pte_present(pteval)) {
 			if (lru_gen_look_around(&pvmw))
 				referenced++;
 		} else if (pvmw.pte) {
-			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte))
+			bool young = false;
+
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			if (pte_present(pteval))
+				young = ptep_clear_flush_young(vma, address, pvmw.pte);
+			young |= mmu_notifier_clear_flush_young(vma->vm_mm, address,
+							      address + PAGE_SIZE);
+			if (young)
 				referenced++;
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			if (pmdp_clear_flush_young_notify(vma, address,
-- 
2.53.0

