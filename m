Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510109;
	b=iBFZIEAiY+XM6KW/BKVPeqrWOYenIl1QZCw7O0uJWGDCP1VJGg4IDBtcrRFtdp1Vhekj
	 +D1FUzMjfmVgqgINylDxN6kwZ4EBPWrEMnUsIky4tUNUd97WqYK4UxsRXH1LDtx3D13b1
	 5RwmphWrJTi7QGebSOnVW2TMRCvkr5nw8AODpCjec6B10Xu0weMplxi4wHSNDprIJh2cE
	 XAE9PuMsRdtiWgqnqr1SgwAGYiuNNLB7yqeRaYqe81pLaYwUEEp7b8i30ozbJWc6eJAY6
	 Pr9oI7jjR9btT1upKyXGKNQD9bCxnhX4Dy3ReeZlDrtk1rZH6iChSzTgHAi9WGPSEBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510109;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NMfXN428M3Pscdin+6iB0nBnywevrayks8T3ADwi/F8=;
	b=gDb4lBbpTPhXzhp9vBrHOY7LNOZq/CUkxH43J0b3CUFd2rEesVOIbWr+Bggj0rrZwD14
	 b3mY3/+NZ5CfdODYHemFWjDHEWwYX0s1A0O3x3/yBrzd5HznFCm9xLgcpDlNr1IhyDr0p
	 MsvOnBFVzfwDfHhuikp2VdR3wSUBAs//xGYpZn67nCMm96c0FgBS/JYO1IOglnDEhCsdm
	 49yMtEyWghlePC1g9jAUAI9w1eFUcktYtgR9usuGIA03oLAb9M+JhRTfrehDOKja/8X8H
	 +fKjS1/bVzcfJwEd+7le16oiUWq0jfOtEOJywipTrTk9AerSAEk9oeI4ukGOOM1Ee3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r2Vm0Fx2;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB92606A31E;
	Tue, 24 Nov 2026 08:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB92606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r2Vm0Fx2
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795510104; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NMfXN428M3Pscdin+6iB0nBnywevrayks8T3ADwi/F8=;
	b=r2Vm0Fx2iKegbeKUrYw7N/J/iLCr5SFs6Etq5biLFPvODq+5pG90jUtqP9ixx1IIkrQmQloS44JajIoYHaJNKbDdtzGtBY9xgtxp5Lei3PH3yjMEb4D6r8BfgUnSQ3Eb+jowj8ycOVCulR6JPAsJEn1zffUwnmtqqy8yirou5O8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=jinyue.li@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XFO-WoZ_1795510103;
Received: from aa8c952a0f58..(mailfrom:jinyue.li@linux.alibaba.com fp:SMTPD_---0XFO-WoZ_1795510103 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 16:48:24 +0800
From: Li Jinyue <jinyue.li@linux.alibaba.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Age the whole range in kvm_age_gfn() and kvm_test_age_gfn()
Date: Tue, 24 Nov 2026 08:48:23 +0000
Message-Id: <20261124084823.1189514-1-jinyue.li@linux.alibaba.com>
X-Mailer: git-send-email 2.25.1
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

kvm_age_gfn() and kvm_test_age_gfn() expect the MMU notifier range to
cover exactly one G-stage leaf. They warn when the size is not
PAGE_SIZE, PMD_SIZE or PUD_SIZE, and then only look at the leaf that
maps range->start.

The range is the host mapping being aged, clipped to the memslot, so
there is no such guarantee. folio_referenced_one() ages all PTEs of a
PTE-mapped large folio in one call, and a PMD-mapped THP backing a
memslot smaller than PMD_SIZE is clipped to the memslot size. In both
cases the range spans several G-stage leaves. syzkaller hit the second
case on a 6.6-based kernel with THP-backed guest memory split into
memslots of a few pages, followed by MADV_PAGEOUT. The line number
below is from that kernel; the same code in mainline is at
arch/riscv/kvm/mmu.c:362 and :382:

  WARNING: CPU: 1 PID: 7943 at arch/riscv/kvm/mmu.c:586 kvm_age_gfn+0x14c/0x20a
  ...
   kvm_age_gfn+0x14c/0x20a
   kvm_mmu_notifier_clear_flush_young+0x186/0x45c
   __mmu_notifier_clear_flush_young+0xc0/0x17a
   folio_referenced_one+0x4b8/0x81e
   rmap_walk_anon+0x400/0x9d0
   folio_referenced+0x216/0x3ae
   shrink_folio_list+0x148a/0x31c4
   reclaim_folio_list.constprop.0+0x11c/0x3a0
   reclaim_pages+0x2c6/0x420
   madvise_cold_or_pageout_pte_range+0xff6/0x16e0

Besides the warning, guest accesses to any page in the range other than
the first one are missed, so reclaim may treat recently used guest
memory as old.

Add kvm_riscv_gstage_test_clear_young(), which walks the range the same
way kvm_riscv_gstage_wp_range() does and tests or clears the accessed
bit of every leaf it finds, and use it in both handlers. arm64 had the
same problem and fixed it in commit df6556adf27b ("KVM: arm64: Correctly
handle page aging notifiers for unaligned memslot").

Found by syzkaller.

Fixes: 9955371cc014 ("RISC-V: KVM: Implement MMU notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>
---
 arch/riscv/include/asm/kvm_gstage.h |  3 +++
 arch/riscv/kvm/gstage.c             | 30 +++++++++++++++++++++++++++++
 arch/riscv/kvm/mmu.c                | 26 ++++++-------------------
 3 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1b77..04e6133665c2 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -82,6 +82,9 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 
 bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end);
 
+bool kvm_riscv_gstage_test_clear_young(struct kvm_gstage *gstage, gpa_t start,
+				       gpa_t end, bool mkold);
+
 bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base_gfn,
 				   unsigned long mask);
 
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index be70607a33ea..7cc66880acde 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -485,6 +485,36 @@ bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 	return flush;
 }
 
+bool kvm_riscv_gstage_test_clear_young(struct kvm_gstage *gstage, gpa_t start,
+				       gpa_t end, bool mkold)
+{
+	int ret;
+	pte_t *ptep;
+	u32 ptep_level;
+	bool found_leaf;
+	gpa_t addr = start;
+	unsigned long page_size;
+	bool young = false;
+
+	while (addr < end) {
+		found_leaf = kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_level);
+		ret = gstage_level_to_page_size(gstage, ptep_level, &page_size);
+		if (ret)
+			break;
+
+		if (found_leaf) {
+			if (mkold)
+				young |= ptep_test_and_clear_young(NULL, 0, ptep);
+			else
+				young |= pte_young(ptep_get(ptep));
+		}
+
+		addr = ALIGN(addr + 1, page_size);
+	}
+
+	return young;
+}
+
 static inline void clear_huge_mask(unsigned long *mask, unsigned long page_size,
 				   gfn_t base_gfn, gpa_t addr)
 {
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 6b77891d4582..26b85a0dcdb7 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -351,42 +351,28 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	pte_t *ptep;
-	u32 ptep_level = 0;
-	u64 size = (range->end - range->start) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
 	if (!kvm->arch.pgd)
 		return false;
 
-	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
-
 	kvm_riscv_gstage_init(&gstage, kvm);
-	if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIFT,
-				       &ptep, &ptep_level))
-		return false;
-
-	return ptep_test_and_clear_young(NULL, 0, ptep);
+	return kvm_riscv_gstage_test_clear_young(&gstage,
+						 range->start << PAGE_SHIFT,
+						 range->end << PAGE_SHIFT, true);
 }
 
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	pte_t *ptep;
-	u32 ptep_level = 0;
-	u64 size = (range->end - range->start) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
 	if (!kvm->arch.pgd)
 		return false;
 
-	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
-
 	kvm_riscv_gstage_init(&gstage, kvm);
-	if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIFT,
-				       &ptep, &ptep_level))
-		return false;
-
-	return pte_young(ptep_get(ptep));
+	return kvm_riscv_gstage_test_clear_young(&gstage,
+						 range->start << PAGE_SHIFT,
+						 range->end << PAGE_SHIFT, false);
 }
 
 static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
-- 
2.25.1

