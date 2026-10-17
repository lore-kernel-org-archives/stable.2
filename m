Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239733B8D48
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206585; cv=none; b=Bixxk8/YE85boWcfbGFmUuUDfh6ctrx/qNMxksqW6NJzzlCaqR018T+Uj1SIOaVyJxy7WG5IqgiUJCsY064aLg63K4UF7i+BLPgbsYl8ukz0i6a7LVQL2Z1USRgv08/emUVobKmjSfPBH4aVQJ/4zxCEsc8yZZ9YxppOzbCZCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206585; c=relaxed/simple;
	bh=zDoMxRzARHHAy5ri+HjeBWocd4VpQdNpx8uIHCb8OO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLypF0fzsRsEtyuL7HyDNY2qBhoDNEkFH/lPsRfxSFqFGpZEiIET+laPFU7bM5yMQ9HuhOxdE9o8ozeI1gtDDxG4assfhDK6x0D4RrIRNp9qOQqi9jhqD+OBCe5wAhMA44vNBwFzM/Z7KZoA0QygsCYB503WDCIZZP2ocewei1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8NQSuSz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8NQSuSz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab98332238so445644a91.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792206583; x=1792811383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=enK3RSWvXdgqwIVRPBvjJmOYoe9F1G7CwzrwYjBwBdA=;
        b=o8NQSuSzgCXIdFSZZ+2MsfR9MAPbOPh2uYIQbEAizPuIr2fimr1aRAHpLzBaH3pEYI
         /F94ZDCPpGq1/JUMOxY1/1LcKGYRt9LsAQXWHo/hUuR8+XE3wPcxzaYFdtcOn8uNMBta
         BpSB2enEL47sles4fWQL7RKiSjbGlyrwBDryhLvqqYlPtzgsJoBTPQ3uaB2gnsU7toQ1
         qnxucSC6Lq6h0KAfs1HmaFcpQ042anF/O2fVAgYmCY1PdkDwooZ+dXK05v19hheQoSaM
         +55fgUfzXM8VLs4YWqqevu6atMcERWl8QUp4vu1uFpF/Mh/wgkmPOYLZoJ58omAGOm2s
         iVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792206583; x=1792811383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enK3RSWvXdgqwIVRPBvjJmOYoe9F1G7CwzrwYjBwBdA=;
        b=VviEjcmHRc4qMJEAOYdC3m6Mt2VmZ8v9clHYLYia1+QvlGxbgpFxiNVDrG4/foGuCk
         PcK9F/zw8WQJ4sXbq4SBYi4mG9m/uQlVkOX06yhBuxj3FhJe6eLyoEJEV2/y24P6FN1C
         Ex2PswxTqQ5t2aBPmN0wBQgE4k9GtBeORVg862ZydqdyapqlzYJ+SeUHCQwiKHOnIxg1
         bsgDOBmfVO99cWEpJ+EJyDFYTAB0kigGyXdvucUjoyur9iy6XoQvujEU8sDRTK9kDzIT
         B7F/IwD3pny8j61vx6EkIIZ9J2ye8A259uoSaeb6fSWdBRL3FHW607Iq7kGY2do4nGfI
         FeuA==
X-Forwarded-Encrypted: i=1; AKwUvByN6dNuf5D8sJg1h5SKXDGEzayyU9ac0ADrLm58iFGinM56C/2w8G+A2RrefaEIyP5x0l1Dv8U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKkvcDXK3zFvUMT/XgiQFMh04rxqFyl4AyST7TV9KxUfT30EBJ
	c+oMf8Pxuj845zr1WJBUBTCTvrccdEhdc1cZOx+y9aC+lRXYy7CzDFoq
X-Gm-Gg: AYBFou38EyamQ1Dus4WPkg+QL4t8a99EBcQd/ReZnVGQsUgCh19PCNRi4Ykbx9kjT7f
	gQdYEM3Sufhyc/NL7mXJoK9VZb241pJULBVuCco5gLBmHajbXeG0/f2mI/jJQ9J76ccSOJFZZIj
	l+kzJ0QNg3bk4SF2smxRLJR4cR0WInj4pmFcAUX5rnOR7pEdY+7wm75+pgKKZvLjZTkiM5wg11G
	43HAlfUgt5b4FBnrjZGGyAV8w71bQpwkdJTTBAToa6gzHVDYMYAD0VGlTyyfqD2D2tYavfFbUkP
	J1xamdGAmgYMDjAcE8FfBK2mWwwxpPgQ4lOu/qzXmIfDJURk6lpGtlGNp33AdyjHSR4uVAhGAEh
	sux/OaJveuwVFv58sudN0eQwWTy24b8K8xnJWfgHyBpFneSO50tiJyUQmvEamwrG++hVrQltTBQ
	YbZStUoBgd2MJ7OcS8Wn9wnAuYEa3AD8qSB3veZebcF2Mlch1VUJ/OmjkPUzMILmnI7xRwK5kSJ
	+H5aH+y+DKk+oPT2ACEfuBoM/SbncxELw==
X-Received: by 2002:a17:90b:5803:b0:3ab:9c73:12e with SMTP id 98e67ed59e1d1-3acee29303bmr1411650a91.6.1792206583320;
        Fri, 16 Oct 2026 20:09:43 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549b6171sm1795406a12.14.2026.10.16.20.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 20:09:42 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: anup@brainfault.org,
	atish.patra@linux.dev
Cc: tjytimi@163.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@linux.dev,
	pbonzini@redhat.com,
	seanjc@google.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on host-writable leaves
Date: Sat, 17 Oct 2026 12:09:26 +0900
Message-ID: <20261017030927.345454-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dirty-log write fault fast path sets _PAGE_WRITE without checking
whether the backing page is host-writable. A read fault can install
a read-only mapping to the shared zero page. A subsequent guest write
then takes the fast path and writes into the zero page instead of
going through the slow path to break CoW.

Use RSW bit 9 to record host writability before dirty logging forces
the mapping read-only. Preserve this bit across write-protection and
fall back to the slow path when it is clear.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-174168@kernel.org/
Fixes: 7705be59eb2d ("KVM: riscv: Fast-path dirty logging write faults")
Cc: stable@vger.kernel.org # 7.2+
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
Testing:

1. HiFive Premier P550

   A selftest makes the guest read an untouched page, then write to
   it with dirty logging enabled. Before the fix, the write corrupts
   the host zero page. After the fix, CoW allocates a private page
   and the zero page stays zero.

   dirty_log_perf_test -v 3 -b 256M -i 3 shows no noticeable
   regression (14-21s per iteration before and after).

2. QEMU (-cpu rv64,h=true)

   The same selftest reproduces the zero-page corruption before the
   fix and passes after it.

This patch applies on top of the Accessed-bit fix [1].

[1] https://lore.kernel.org/all/20261016101458.221648-1-suunj1331@gmail.com/

 arch/riscv/include/asm/kvm_gstage.h |  5 ++++-
 arch/riscv/kvm/gstage.c             |  5 ++++-
 arch/riscv/kvm/mmu.c                | 15 +++++++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1b77..0d19ad6d7dfe 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -35,6 +35,9 @@ extern unsigned long kvm_riscv_gstage_max_pgd_levels;
 #define kvm_riscv_gstage_pgd_xbits	2
 #define kvm_riscv_gstage_pgd_size	(1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
 
+/* RSW bit 9: the host mapping behind this leaf is writable. */
+#define KVM_GSTAGE_PTE_HOST_WRITABLE	BIT(9)
+
 static inline unsigned long kvm_riscv_gstage_gpa_bits(unsigned long pgd_levels)
 {
 	return (HGATP_PAGE_SHIFT +
@@ -61,7 +64,7 @@ bool kvm_riscv_gstage_try_update_pte(struct kvm_gstage *gstage, u32 level,
 int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      struct kvm_mmu_memory_cache *pcache,
 			      gpa_t gpa, phys_addr_t hpa, unsigned long page_size,
-			      bool page_rdonly, bool page_exec,
+			      bool page_rdonly, bool page_exec, bool host_writable,
 			      struct kvm_gstage_mapping *out_map);
 
 bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index be70607a33ea..d9bfd0c6d5fd 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -207,7 +207,7 @@ static void kvm_riscv_gstage_update_pte_prot(struct kvm_gstage *gstage, u32 leve
 int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      struct kvm_mmu_memory_cache *pcache,
 			      gpa_t gpa, phys_addr_t hpa, unsigned long page_size,
-			      bool page_rdonly, bool page_exec,
+			      bool page_rdonly, bool page_exec, bool host_writable,
 			      struct kvm_gstage_mapping *out_map)
 {
 	bool found_leaf;
@@ -246,6 +246,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			prot = PAGE_WRITE;
 	}
 
+	if (host_writable)
+		prot = __pgprot(pgprot_val(prot) | KVM_GSTAGE_PTE_HOST_WRITABLE);
+
 	found_leaf = kvm_riscv_gstage_get_leaf(gstage, gpa, &ptep, &ptep_level);
 	if (found_leaf) {
 		/*
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 042d1e3b3547..196cde6c40cd 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -586,6 +586,12 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
 			break;
 		}
 
+		/* Let the slow path handle host-side write protection and CoW. */
+		if (!(pte_val(old_pte) & KVM_GSTAGE_PTE_HOST_WRITABLE)) {
+			ret = false;
+			break;
+		}
+
 		if (!dirty_marked) {
 			mark_page_dirty_in_slot(kvm, memslot, gfn);
 			dirty_marked = true;
@@ -630,6 +636,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	bool is_hugetlb;
 	bool unused = false;
 	bool writable;
+	bool host_writable;
 	unsigned int vma_pageshift;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
@@ -714,6 +721,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (is_error_noslot_pfn(hfn))
 		return -EFAULT;
 
+	host_writable = writable;
+
 	/*
 	 * If logging is active then we allow writable pages only
 	 * for write faults.
@@ -739,10 +748,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (writable) {
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
-						vma_pagesize, false, true, out_map);
+						vma_pagesize, false, true, host_writable,
+						out_map);
 	} else {
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
-						vma_pagesize, true, true, out_map);
+						vma_pagesize, true, true, host_writable,
+						out_map);
 	}
 
 	if (ret)
-- 
2.52.0

