Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757589;
	b=4vKKVCuD+T5uWvglg7DSTBye8wDpQOk346G8VdkYN65HXkbtyvGId0q9QqCfRWpDUdsC
	 5rYDeoYmJo1kRyezYIB3fTb9x4ZmL9Is1x1hqGdI+PJLLZnvFPzSHyUs8ZBfwthqqNtM+
	 YDAckxTH3DgrJ+MieWybc8K5236iVPLYGup8XYNSfT5npbp7o9denZAgHDCp3ZaF8jiXB
	 7KmynYpeJA664Qs2z7LvH9MgtRl5jWyF8wwMaS5dQXc173eccvEj310WrPbU34Oh/mEnG
	 XqRaHnNgNVtMkJGMbkBgS47AqdogS52sltxhDkuGVq94PIYsT41jn+jaWq0HOONtTaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757589;
	h=DMARC-Filter:DKIM-Signature:X-Lms-Return-Path:References:Subject:
	 Date:X-Mailer:Content-Transfer-Encoding:Content-Type:From:Cc:
	 Message-Id:Mime-Version:In-Reply-To:X-Original-From:To;
	bh=qoF1RPn6HPNki8UOdmD2+HVuHX6Hw9QlW7A9xjkpPmY=;
	b=sJ8wxwjs1whetCEEgQPSNFoJUygcJcM6MbCvFUFouYUgwz0imBYbwwGaYzIzZsq6oJsC
	 ysjByRvpgPhbIubXbfMMDMkN67qWHhvS4HykLQEid6CCB3W7tWADGhRsrE49HdYphJbCF
	 v5FSbSF5rdHeWGOlRk1J7lcRw0p0ljzgukFab/g49K2tN/okK0G25sBlnEpLHVSzOmisE
	 Pw8XWofp2AdvPFF6Vhm/cKSOyrZe985sLJzPnOYKzEIYm5qhCjw4wJ5rMeUaxFZuUBgtF
	 jo4DuPw2axGHLIWmg4MR/+XMK/uhHBraX3uV2SNRKBMr5Y+o2uptLbGimXBKJ8dpWzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=MaivSzgh;
	arc=none smtp.remote-ip=209.127.230.113
Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEEF606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CEEF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=MaivSzgh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792757582; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qoF1RPn6HPNki8UOdmD2+HVuHX6Hw9QlW7A9xjkpPmY=;
 b=MaivSzghVkP2FD9N3kGx7UPHk2q91thBRtwjvhEYGQuX73lpbHhRpe6H02Bhga9v1lKmec
 7oVUAZYJUEiW57hX/2MeWD7agOBuJQzv8Hbf6NPUYbsHMgNSjGsOnddKL/UDVKeBkysry0
 wVkdGzJtXRoW49jRzQXguye1trMKtZb1hEPIB1MqADqatcbhZMnObWX1t2ShpNesfYD5gz
 CWNeNjKb2QOjR6LGgyr2fSXiVHq9AYV+AXB4SMSfUmZBeARdDy/2i3JFNIn6cfa2E+5exK
 MElIjXWLYT5WdjU2liUtR03E4NQB3CzfNg1NiNC5JME5uEghFaexphiA+iMo3w==
X-Lms-Return-Path: <lba+26adb4f4c+6252a5+vger.kernel.org+zhaogongyi@bytedance.com>
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
Subject: [PATCH v2] arm64/mm: restrict transparent contpte mappings to valid PTEs
Date: Fri, 23 Oct 2026 20:12:33 +0800
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Cc: <ryan.roberts@arm.com>, <dev.jain@arm.com>, 
	<baolin.wang@linux.alibaba.com>, <lance.yang@linux.dev>, 
	<mark.rutland@arm.com>, <akpm@linux-foundation.org>, <david@kernel.org>, 
	<ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, "Zhao Gongyi" <zhaogongyi@bytedance.com>, 
	<stable@vger.kernel.org>
Message-Id: <c4c33aaddf5741e125e4130f2220b1892b50aa61.1792756709.git.zhaogongyi@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
In-Reply-To: <20261013093600.54995-1-zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>

The transparent contpte layer treats PTE_CONT as software grouping state.
When a valid PTE has PTE_CONT set, the contpte helpers may align an
operation to a CONT_PTE_SIZE block and operate on the whole block. The
current single-PTE helpers use pte_valid_cont() to identify such groups;
this is a helper contract, not an architectural restriction on using
PTE_CONT with present-invalid descriptors. Explicit users such as hugetlb
manage their contiguous encodings separately.

contpte_set_ptes() currently sets PTE_CONT from alignment alone. Batched
set_ptes() users can therefore install present-invalid PTEs with
PTE_CONT set, for example mprotect(PROT_NONE), NUMA hinting through
modify_prot_commit_ptes(), fork() copying a PROT_NONE large folio, or a
PMD split installing PAGE_NONE PTEs.

This is not a hardware programming problem: invalid descriptors are not
translated, so the hardware ignores descriptor bits such as PTE_CONT. It
is a software-state problem. Some arm64 fast paths, such as
test_and_clear_young_ptes(), test pte_cont() directly instead of
pte_valid_cont().

In the observed failure, mprotect(PROT_NONE) installed a full
CONT_PTE_SIZE range of present-invalid PTEs with PTE_CONT set.
MADV_GUARD_INSTALL then zapped one PTE. The nr == 1 clear_full_ptes()
path only unfolds pte_valid_cont() entries, so the neighbouring
present-invalid entries kept PTE_CONT while the target entry became a
guard marker.

clear_refs_pte_range() then reached the marker through:

  ptep_test_and_clear_young()
  test_and_clear_young_ptes()
  contpte_test_and_clear_young_ptes()
  contpte_align_addr_ptep()
  __ptep_test_and_clear_young()

The marker changed from old_pte=0x00000000000047c0 to
new_pte=0x00000000000043c0 by clearing PTE_AF. For swap PTEs, bit 10 is
part of the swap type field, bits 6-10: 0x47c0 is SWP_PTE_MARKER with
offset 4, while 0x43c0 has type 15 and is decoded as an ordinary swap
entry. Zap later warned in swap_put_entries_direct() with a bad swap
entry.

Present-invalid PTEs could retain PTE_CONT as software grouping state,
but their single-PTE modification paths would then need to recognize
and unfold those groups consistently. Since current helpers mostly use
pte_valid_cont() for membership, avoid creating present-invalid
transparent contpte groups in contpte_set_ptes(). They bring no hardware
benefit while invalid, and eligible valid ranges can be grouped again
when they are installed.

The public set_ptes() wrapper already clears PTE_CONT before calling
contpte_set_ptes(). Return invalid PTEs through __set_ptes() directly,
and warn if a future direct caller unexpectedly passes an invalid PTE
with PTE_CONT set.

This is triggerable by a user process against its own address space. On
systems running with panic_on_warn, the warning becomes a denial of
service.

Fixes: 4602e5757bcc ("arm64/mm: wire up PTE_CONT for user mappings")
Cc: stable@vger.kernel.org
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Changes in v2:
- Return invalid descriptors through __set_ptes() directly instead of
  silently clearing PTE_CONT, as suggested by Lance Yang.
- Add VM_WARN_ON_ONCE() for an unexpected direct caller that passes an
  invalid descriptor with PTE_CONT set.
- Describe valid PTE grouping as the current helper contract rather
  than an architectural restriction, following David Hildenbrand's
  feedback.

Validation on arm64 QEMU/KVM with 4 KiB pages, CONFIG_ARM64_CONTPTE=y,
CONFIG_TRANSPARENT_HUGEPAGE=y, CONFIG_KASAN=y and panic_on_warn=1:

  Unfixed kernel: guard-marker reproducer warned and panicked on its
                  first iteration.
  v2 code:        100 guard-marker iterations, five fork probe runs and
                  five PMD-split probe runs without warnings.

The runtime build used base af32da41b032; arch/arm64/mm/contpte.c
matched the v2 commit's Git blob ID. The pgtable.h change since that
run is comment-only. The v2 commit itself is based on 24a19b953e2a
and was not boot-tested separately.
---
 arch/arm64/include/asm/pgtable.h | 3 +++
 arch/arm64/mm/contpte.c          | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6000905a2..6c81a3d22 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1651,6 +1651,9 @@ extern void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned long ad
  * The contpte APIs are used to transparently manage the contiguous bit in ptes
  * where it is possible and makes sense to do so. The PTE_CONT bit is considered
  * a private implementation detail of the public ptep API (see below).
+ * Single-PTE transparent contpte helpers use pte_valid_cont() to identify
+ * grouped PTEs; explicit contiguous-encoding users such as hugetlb manage
+ * their entries separately.
  */
 extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte);
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 0acab179f..be78d8602 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -460,8 +460,10 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 	 */
 	VM_WARN_ON(nr == 1);
 
-	if (!mm_is_user(mm))
+	if (!mm_is_user(mm) || !pte_valid(pte)) {
+		VM_WARN_ON_ONCE(!pte_valid(pte) && pte_cont(pte));
 		return __set_ptes(mm, addr, ptep, pte, nr);
+	}
 
 	end = addr + (nr << PAGE_SHIFT);
 	pfn = pte_pfn(pte);
-- 
2.39.5 (Apple Git-154)
