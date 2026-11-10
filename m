Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273090;
	b=uZyD53nEtI/2ACAUqQPBGG+Sw+kKw16Y4h3URJK0VlfpyExtZ97d1qXFQRmZbGR+CvFq
	 R5kYOWommQaSkFSDH62SBKNiOKeDrwU60MpPGnGoVZB3/gOtFF6Lu8FouYnSv3xZXo3+f
	 gO5+TZnoDyhffaFuWFw5vFFlNeSfjIxWj9ywYEFFhLsyQMHBH4d+zAZX2NU/k7cFzVu5Z
	 yKnOSUe7Ishk14BGR5i96HICyenD8NIa711dfZn6x0UjNI5KjXMQbuf/wksM/sgKgl9El
	 szsFhCafcC6wgK0wuXf7j8q+MDEKqDeH4FPgRTqMtTw23bpHCHX2triWEcPbZMXJ+uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273090;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lxTGjhtxuQp5ya3OAcIjXmpeK8Pw3kSRM3+rGtDu4NI=;
	b=CcVRmDcL4JSGAJu+jGUys2HSkPcHMstcetlvMJBXj9C+4G9JKbQUr0TmCSVuDyscXjBb
	 3j6QuXTmKDZ5ZrP0slTWavEhiwn2+UkOUnKN0ZMG/YNlOIYT2z8HEL7BNy6cPocY9CRpH
	 NNhhaRQpudTgLikT2yRr+tn3y7kwErH8UvgLEiPl4LS5dVDPwsOGBHcEqP+VOGvO1Zebi
	 Hxm4cdBSPQlfTMwxd26roufFYI8otscREb2c4O+ZczlYJTL1N9cfiGHXXxAh3gOURKPbW
	 UCmwIgBcNqcJEakBHF91GWC6VocxUFjeE9WjzeSMo19iW7BaajPGp17hj0Cf3ASmRYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrFzIuCk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrFzIuCk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E689B1F0089F;
	Tue, 10 Nov 2026 01:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273090;
	bh=lxTGjhtxuQp5ya3OAcIjXmpeK8Pw3kSRM3+rGtDu4NI=;
	h=From:To:Cc:Subject:Date;
	b=RrFzIuCkm+WIXy+R3ZYFCDo56v3JY5YeMSeEAxl4EXd+351r9EXZlY3JDExlUPOWi
	 pwq4XbMTp82RuXoPq037U3ukV1DyFshA8xmsPoLSpRaPN3gNdgpeuXmVNemE0nt6Bj
	 L9ESO9AJhHTfPnhQEX9btra0uRw1sbS7cIfEEaxIxjos1OqsQv6rF1h59GAUHZyfi7
	 EEzvvTbyoyYIr9GjnBqvTMmwFvbE+rmgKvw42g8WMUAnYuqkAwUyYiOMuN0Xui8WYQ
	 WC94qAL4qhg47lh08NvSiboLHhjd2iLjfEkowKcKenzoV/vbSZNbiAya/k3IJ3IXys
	 PZETw1r4PMEXg==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	josef@toxicpanda.com,
	harry@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	usama.anjum@arm.com,
	baolin.wang@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/rmap: handle device-exclusive entries in folio_referenced_one()" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:27 -0500
Message-ID: <20261109201127-failed-6.6-f3c493d2f42b@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f3c493d2f42b5f44a5c134d8d7ea7f960caf5e2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201127-failed-6.6-f3c493d2f42b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f3c493d2f42b5f44a5c134d8d7ea7f960caf5e2c Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:38 +0100
Subject: [PATCH] mm/rmap: handle device-exclusive entries in
 folio_referenced_one()

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
---
 mm/rmap.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1131b76bbbc28..0faef46806e5c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -924,6 +924,7 @@ static bool folio_referenced_one(struct folio *folio,
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	int ptes = 0, referenced = 0;
 	unsigned int nr;
+	pte_t pteval;
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
@@ -968,10 +969,12 @@ static bool folio_referenced_one(struct folio *folio,
 			return false;
 		}
 
-		if (pvmw.pte && folio_test_large(folio)) {
+		if (pvmw.pte)
+			pteval = ptep_get(pvmw.pte);
+
+		if (pvmw.pte && pte_present(pteval) && folio_test_large(folio)) {
 			const unsigned long end_addr = pmd_addr_end(address, vma->vm_end);
 			const unsigned int max_nr = (end_addr - address) >> PAGE_SHIFT;
-			pte_t pteval = ptep_get(pvmw.pte);
 
 			nr = folio_pte_batch(folio, pvmw.pte, pteval, max_nr);
 		}
@@ -981,11 +984,23 @@ static bool folio_referenced_one(struct folio *folio,
 		 * are. —they could be on active/inactive lists or on MGLRU. So the
 		 * simplest approach is to disable this look-around optimization.
 		 */
-		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte) {
+		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte &&
+		    pte_present(pteval)) {
 			if (lru_gen_look_around(&pvmw, nr))
 				referenced++;
 		} else if (pvmw.pte) {
-			if (clear_flush_young_ptes_notify(vma, address, pvmw.pte, nr))
+			bool young = false;
+
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			if (pte_present(pteval))
+				young = clear_flush_young_ptes(vma, address, pvmw.pte, nr);
+			young |= mmu_notifier_clear_flush_young(vma->vm_mm, address,
+								address + nr * PAGE_SIZE);
+			if (young)
 				referenced++;
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			if (pmdp_clear_flush_young_notify(vma, address,
-- 
2.53.0




