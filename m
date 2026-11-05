Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793899168;
	b=4esfrvEk55STS07oEsNpzB59dLb9ibRAbr893+jZj+T4HHg9MYDhIL34uVrQUALuzTj7
	 eMTSFBc7Y6qt5oxsNy2yJLkhfhk3Xk3Dimn2UnkhW66cNEKoYRqcDF2iTohOrfqdLFe9h
	 hJ2g+HJVVK/0r+Izb60XPhySyM3a/mjGEvk+O2F6kaAsN9H7fx4Odh+xO8eh27FPj80oW
	 JKvE6V5/EPeBS4ZXD2Ts9Rj+cdMhJP+UarrtrS2Fm+kAo2y2SyUEI6oHFqD5bTPvyddZ1
	 NmsQOp5gX2k3niFjAGkRCC5EDGmdVrrl/8bj+j3TuF3taANRx4L7a7NIo1+n9M+Eb8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899168;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ri8L3EEoBfWFKUTJIJIbM8fwsbVuZzUOY2ODmdTus0Q=;
	b=qOq1Us7iybAKxxsWvZkAbyEs+mUGRH1GH+0ZvJ59DQroHeFA8iDwM4Uu/Cn2b2OeNT7r
	 vMbH6hO5afxLdEqRRuBljK3gnsDtR/X7k8yI/8MmM8qqNP+aP60STURr6MZ3zomOLGRtr
	 JZyxz/qIZGTYnLJ7KNniUPth3QTBfRtR2ojGdUrRY2d+fKlH1yaxGwD6jqPHQp0LVvlvk
	 UD3OW+LVd9V2rb211YavgfuMo5fiQc1ldm8QTwUm7eia9MaQOtPQDLG4EHt4FMf/KjL8h
	 dS73MpmO3Yb2virIGWOEO1F+iE5KbfKww/OwCLSY7rCkTdTmNX+B2ofZdE6rJVMlSuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAepGpPK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874F606A32E;
	Thu,  5 Nov 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAepGpPK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793899168;
	b=BYlD+bkzTnSOJCEgeQXIsSdMXMKWpQQiOAQ5czviYxqmO8xYR/t+MkeLQ0RDhV8pXG0i
	 8LYQrjoEF3Nvp7MHwiFfPTrwEP5G27YIqwttvzBq8fqzhx1tBd7WFj5/6ZGyjw3S035PH
	 qmWFdANS7cu/UpiF3TxGHpfE5Y74uVga8YO2FNNaQa0xn/FAIByxNwF90Cpsnk0woUiAn
	 tHYMJB4U6SpuA1VUQ2EY7UeZtW5nWnqCB+FiOPvt8slPOjVB2Qo489DECRPid67veBwsJ
	 XRo/rXTow7upVWgpqvsRtbDFxBP5ju8Bxh8LxvHWf3WojrZkHyYoG7jYmFM7TLEWa8g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899168;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ri8L3EEoBfWFKUTJIJIbM8fwsbVuZzUOY2ODmdTus0Q=;
	b=oskCuaH29X6wZN7Q7LdmWDbTgOj/kkYsLptBTuQCJoyJ6BM4njxtHpflxD8QtC3WwrTO
	 hBhckZF57FqP6rhnICUBTwmhctcGf6rNFbCb3ECsJB29naWieLxrO1gF+MXTtoH+WFKwv
	 r3xq4atBoMJX3D6GLfGLDenb5g8lwHHCfRd17Ht+izCgcxc9shnB/eRAv2GPPGbBCCNB2
	 o4AhPY6upNO+Fj22tz9ez4gg9kdxp6rIfBi4mzN87vf0Cn5/1PaR2o/1ZEN21z5bAGcOH
	 MC7JTB3ruzhxkkbj75QhGT9nNfoTmTnOipAShiFdCzfk0zUpeXlbLAEvZeCuuv8gW3Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A7C231F00A16;
	Thu,  5 Nov 2026 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899168;
	bh=ri8L3EEoBfWFKUTJIJIbM8fwsbVuZzUOY2ODmdTus0Q=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=CAepGpPKhgaekSDGEQhP07Bx34thjGLDvhVKhEZ2W1l85QfWsJKVWhiWxPjk/Uy9e
	 c7kdKqPudkncJwZ5V5v5nt1+TUKosdGD0mXDSgnDULQJHBcaIyFM3qjK42Pc2W1BBO
	 vAayO96njBbXY4f9mtUsvSb3ITpyDETvZzKwCgSpcv9AgXrk/jSQVpoO75Wtk/gUG9
	 tCB8yqcWsrK8RTVhnTYe4CXnoxVu3Pss8Hivvtfy3Wd3FOnGK2/+mi09HIcQ//xBIY
	 lIir7q7U0AzE+kOzVYPTOh3Ms6ZzIscrxdb/Ykj0fSgwVrheWq+7hoq8r/ixU7E89T
	 piSj7WXQFNWfw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 094EA47348;
	Thu,  5 Nov 2026 17:19:27 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Thu, 05 Nov 2026 12:19:27 -0500
Subject: [PATCH v3] mm/swapfile: drop a large unmapped swap-in folio in
 unuse_pte()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-swapin-large-unmapped-v3-1-d5906e4cf18d@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNTQ6CMBAF4KuYrq1pCxRw5T2Mi1IGGcNP00LVE
 O5uiwsTE+PyZd58byEOLIIjx91CLHh0OA4hJPsd0a0arkCxDpkIJiRnCaPurgwOtFM23OahV8Z
 ATaUuGgmy5IVMSfg1Fhp8bO758s5urm6gp4jFRotuGu1zG/Y89v5teE45TTmkCpK8AKlPeuzmv
 kJ1gHomccaLDxSkX5AIUJHrnEFW5iJjX9C6ri/CfztfGAEAAA==
X-Change-ID: 20261030-swapin-large-unmapped-6c8f6e691864
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793899166; l=6342;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=8JpSwuWf9NP1iQYvz5Gpx6uSt1GJJVSQ0Pxbzq2T8RE=;
 b=xkIsHYjRBs2rIxzOFBF2QCdJqdG9ZWe2Zb7y5agSBS+3a8FYWIRsZN0iJGCkY1GbGI1UR/EXx
 4pSs4ibZEoJD8kISLzMiOBs1eP+1JiOnI0ge0A7V9/F0eLEa4DVx+Rg
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

Since commit f1879e8a0c60 ("mm, swap: never bypass the swap cache even
for SWP_SYNCHRONOUS_IO"), a fault can read a swapped-out mTHP range into
one large folio in the swap cache.  The folio only becomes anon once
do_swap_page() maps all of it, so if the faulting PTE changes in the
meantime the folio stays in the swap cache while not being mapped or
anon:

  Task A (fault)                       Task B
  do_swap_page()
    /* swaps in large folio F */
                                       madvise(MADV_DONTNEED)
                                         /* zaps the faulting PTE */
    /* PTE changed (F not mapped) */

swapoff then maps it, which marks all of its pages as mapped and
exclusive, and the next fault on one of the other PTEs crashes in
do_swap_page():

  [    6.424485] kernel BUG at mm/memory.c:5195!
  [    6.424503] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  [    6.427654] CPU: 0 UID: 0 PID: 67 Comm: swapmthp Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
  [    6.432665] RIP: 0010:do_swap_page+0x24eb/0x2fa0
  [    6.451035] Call Trace:
  [    6.451567]  <TASK>
  [    6.453841]  __handle_mm_fault+0x13b5/0x3b40
  [    6.458525]  handle_mm_fault+0x16f/0x480
  [    6.461143]  do_user_addr_fault+0x312/0xa30
  [    6.462044]  exc_page_fault+0x66/0xc0
  [    6.462846]  asm_exc_page_fault+0x26/0x30
  [    6.476708]  </TASK>

do_swap_page() already drops such a folio from the swap cache when it
can't map all of it.  We move that check into a helper and use it in
unuse_pte() too, so swapoff drops the folio and swaps the entries in
again as small folios.  With the fix, the next fault doesn't crash
anymore.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 1s.

Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO")
Cc: stable@vger.kernel.org
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Changes in v3:
- Don't handle a dirty folio, the helper already warns on debug kernels
  (David)
- Keep the comment above the check in do_swap_page() and say "some folio
  pages" instead of "sub pages" (David)
- Drop the note that the check goes away once folio allocation is unified
  in the swap cache layer, mention it here instead (David)
- Add Nhat's Reviewed-by
- Link to v2: https://lore.kernel.org/all/20261103-swapin-large-unmapped-v2-1-87c70e597250@columbia.edu/

Changes in v2:
- Move the check in do_swap_page() into a helper and use it in
  unuse_pte() too (David)
- Use VM_WARN_ON_ONCE() for a dirty folio (David, Kairui)
- Keep a dirty folio and return -EBUSY from unuse_pte() instead of
  dropping it, since dropping it would lose data (Kairui)
- Rebase on mm/core.git for-next-fixes
- Link to v1: https://lore.kernel.org/r/20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu

This is based on mm/core.git for-next-fixes, on top of David's 7f2c000ffb10
("mm/ksm: check large swap-cache folios before mapping them").  On mm-new
it only differs in context and applies with a 3-way merge.

The check can go away once folio allocation is unified in the swap cache
layer, where allocating a folio stabilizes the swap entries.

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/swapmthp.c
---
 mm/memory.c   | 13 ++++---------
 mm/swap.h     | 10 ++++++++++
 mm/swapfile.c |  9 +++++++++
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 91836d217d25..10016f7984fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5170,18 +5170,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * If a large folio already belongs to anon mapping, then we
 	 * can just go on and map it partially.
 	 * If not, with the large swapin check above failing, the page table
-	 * have changed, so sub pages might got charged to the wrong cgroup,
-	 * or even should be shmem. So we have to free it and fallback.
+	 * have changed, so some folio pages might be charged to the wrong
+	 * cgroup, or even should be shmem. So we have to free it and fallback.
 	 * Nothing should have touched it, both anon and shmem checks if a
 	 * large folio is fully applicable before use.
-	 *
-	 * This will be removed once we unify folio allocation in the swap cache
-	 * layer, where allocation of a folio stabilizes the swap entries.
 	 */
-	if (!folio_test_anon(folio) && folio_test_large(folio) &&
-	    nr_pages != folio_nr_pages(folio)) {
-		if (!WARN_ON_ONCE(folio_test_dirty(folio)))
-			swap_cache_del_folio(folio);
+	if (!swap_cache_folio_mappable(folio, nr_pages)) {
+		swap_cache_del_folio(folio);
 		goto out_nomap;
 	}
 
diff --git a/mm/swap.h b/mm/swap.h
index d5bf21f517dc..7779ccff5a0d 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -464,6 +464,16 @@ static inline void __swap_cache_replace_folio(struct swap_cluster_info *ci,
 }
 #endif /* CONFIG_SWAP */
 
+static inline bool swap_cache_folio_mappable(struct folio *folio,
+		unsigned int nr_pages)
+{
+	if (folio_test_anon(folio) || !folio_test_large(folio) ||
+	    nr_pages == folio_nr_pages(folio))
+		return true;
+	VM_WARN_ON_ONCE_FOLIO(folio_test_dirty(folio), folio);
+	return false;
+}
+
 extern const struct swap_ops swap_bdev_ops;
 
 int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 71ef9e2efb3a..5d915951639e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2513,6 +2513,15 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (!folio_matches_swap_entry(folio, entry))
 		return 0;
 
+	/*
+	 * A large folio that a fault didn't map can't be mapped one PTE at a
+	 * time here, so drop it and swap in small folios instead.
+	 */
+	if (unlikely(!swap_cache_folio_mappable(folio, 1))) {
+		swap_cache_del_folio(folio);
+		return 0;
+	}
+
 	swapcache = folio;
 	folio = ksm_might_need_to_copy(folio,
 				       folio_file_page(folio, swp_offset(entry)), vma, addr);

---
base-commit: 71555ae8c7572fd99158013ca2e29187c5d2508d
change-id: 20261030-swapin-large-unmapped-6c8f6e691864

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


