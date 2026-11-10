Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272832;
	b=HMwmnQm4ynj2TSbIhid5efa4vr8fPJiIRdZSSnPZnQn1wizK9vyfTVu/RirSV03JaqOJ
	 tebjNRZqGfPTIhx3lO8wNa2DhQ+odM3QQqiN9DANryexA1muliByhu2AXS40B745Ngqe4
	 zElkn0L1rXL0F9jUSKtfFc58QyNYPnRAYL5T5k8gMGWmoPeiwiu0Ns272BhenTapkhRRU
	 d7gemqanFdacztbZvlFg8SYZGYii0TuFTF9Q5TzIADxFyCl8DsvondTn1RX9gyBRS/UT9
	 ChpQspdXALF3I0/YUHYQLp23VKYswhXf0YgUWGEVv7DYkv1VqbQVhFdgqfluvK4d+DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5JtG7a/MBH7jp4qQS32dYW0C8omUrmzLMcl3UCbzrEA=;
	b=PPOIW7Tpeo3lGQMQBxiB5MKBMaaET/MtsWpwaasPricnnG4kYmRknq1uY5IPJNAdj8f5
	 +QRMJG3kkIhDcraIBH2Vmn5JnAQlvF2EFqtHG5JssmeEb4uI0cPW1TkDuYDUlbZsVtgHv
	 vbCyQPr1g+OxXZHMg5hArPgF8WHhem9WV7QTRpxR6EZkU2f2QP1efNQDbLGhPCy396yV/
	 X6Ali+ZB+adUe8Aw/SFCuGbpBAT9bXQD31DmM5Q/qebH77fWjpMPXXsGwW4yzxAVc9fTf
	 tEp2bfJ0xqBARGKK+29sUhm/5ZbxWpjkX2tdZf06t4MxWHhkkzB93dMR7VpecVsoDPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htL7PgJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FF606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htL7PgJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91471F0089F;
	Tue, 10 Nov 2026 01:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272831;
	bh=5JtG7a/MBH7jp4qQS32dYW0C8omUrmzLMcl3UCbzrEA=;
	h=From:To:Cc:Subject:Date;
	b=htL7PgJjIjug97k3VcMMQEFxXRc9FrxyWjln5GSAhjR/GNR6/I6CgTMMqyAZEm/Rl
	 VHz70CuYkXAQbvU1quRFlNs81v5lFnzXE3odZZV7yekbQ4ZLoXhxVdbLeWOsk7YfMt
	 PLdEhwrKd2dI5dttK+v+AT0K1YKUnVJqlH20A1akgqPbeIq31ir5s632CbccW56UgL
	 xUMpXCusNS+iH77uFwz4vFe9RkPjxB0t3/V6qVSrZlsGdOOM3P8jq23JkCp1g3ptN5
	 /pMCOvsOAcr7byUBFYRqruk4X+Colg+F8cvdVvVecfwLLZKS2MYMSJXo+KMXlPKfhY
	 BN11xj0nZj/OA==
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
Subject: FAILED: patch "[PATCH] mm/rmap: handle device-exclusive entries in folio_referenced_one()" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:09 -0500
Message-ID: <20261109200709-failed-6.12-f3c493d2f42b@kernel.org>
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
git cherry-pick -x f3c493d2f42b5f44a5c134d8d7ea7f960caf5e2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200709-failed-6.12-f3c493d2f42b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




