Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD04344D8C
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185754; cv=none; b=HUfISBEg2gQheuEOeCs3BwYWkWO0si670XY4T84Hi11EfDMLZc1To9CUQCsSQFMLqmKNC+nHGo5pYHOsZXksbDMKYV4R7ZSNNNlLUapGP3wxKfijNd00+Qtl3gT3r5hw/SJuInioLFa6PKXb9ODoqBuGFizk6FXxzAD8d6ypjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185754; c=relaxed/simple;
	bh=1rj10U3ExjbeV66rNeCVAQL/Y+MdxYSRnBoQai6ri7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Saosq8qHa5lFP7/EaywuZvllQhf7LtwUcAWHhJ0etXixXZ5oYs7YfMrtZr7zTs/Nh6+2TVR7INhBq8ElwLT77g9IqzOnmtOF0MkEc78k8gOQy45PxRO9GB8KpV7x/moobHp4QFakOViwbLNY5L9rA5F4UYeP5CeeOqQYtxfDeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ti04BvRq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ti04BvRq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59BCB1E5E;
	Thu, 11 Jun 2026 06:49:07 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67D863FAF5;
	Thu, 11 Jun 2026 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781185752; bh=1rj10U3ExjbeV66rNeCVAQL/Y+MdxYSRnBoQai6ri7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ti04BvRqBocApwopd3x9+tt1sVG8/DMXz7kh566SGcC8nb8BzeU7kSTeeO8Qa72BG
	 iXK3qfmtwp3RUCG2MnSxtsT7/SBi+gXrZSizgWktHvWw45Sez1BGxwxcH9PJm4ZAyR
	 Ks+f+DdiXzdy2PhSqRF3FVojgh9TlcSU5ff9EZVQ=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 5.10.y 1/3] KVM: arm64: Remove VPIPT I-cache handling
Date: Thu, 11 Jun 2026 14:49:01 +0100
Message-Id: <20260611134903.1700976-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260611134903.1700976-1-mark.rutland@arm.com>
References: <20260611134903.1700976-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

commit ced242ba9d7cb3571f6e0f165f643cb832d52148 upstream.

We have some special handling for VPIPT I-cache in critical parts
of the cache and TLB maintenance. Remove it.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20231204143606.1806432-2-maz@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: Backport to v5.10.y. VPIPT HW was never built; this is all dead code]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  4 ++--
 arch/arm64/kvm/hyp/nvhe/tlb.c    | 35 --------------------------------
 arch/arm64/kvm/hyp/vhe/tlb.c     | 13 ------------
 3 files changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 47dafd6ab3a30..c700bf9241fce 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -162,8 +162,8 @@ static inline void __invalidate_icache_guest_page(kvm_pfn_t pfn,
 	if (icache_is_aliasing()) {
 		/* any kind of VIPT cache */
 		__flush_icache_all();
-	} else if (is_kernel_in_hyp_mode() || !icache_is_vpipt()) {
-		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
+	} else {
+		/* PIPT */
 		void *va = page_address(pfn_to_page(pfn));
 
 		invalidate_icache_range((unsigned long)va,
diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
index 229b06748c208..435d0a54ab9a2 100644
--- a/arch/arm64/kvm/hyp/nvhe/tlb.c
+++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
@@ -82,28 +82,6 @@ void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu,
 	dsb(ish);
 	isb();
 
-	/*
-	 * If the host is running at EL1 and we have a VPIPT I-cache,
-	 * then we must perform I-cache maintenance at EL2 in order for
-	 * it to have an effect on the guest. Since the guest cannot hit
-	 * I-cache lines allocated with a different VMID, we don't need
-	 * to worry about junk out of guest reset (we nuke the I-cache on
-	 * VMID rollover), but we do need to be careful when remapping
-	 * executable pages for the same guest. This can happen when KSM
-	 * takes a CoW fault on an executable page, copies the page into
-	 * a page that was previously mapped in the guest and then needs
-	 * to invalidate the guest view of the I-cache for that page
-	 * from EL1. To solve this, we invalidate the entire I-cache when
-	 * unmapping a page from a guest if we have a VPIPT I-cache but
-	 * the host is running at EL1. As above, we could do better if
-	 * we had the VA.
-	 *
-	 * The moral of this story is: if you have a VPIPT I-cache, then
-	 * you should be running with VHE enabled.
-	 */
-	if (icache_is_vpipt())
-		__flush_icache_all();
-
 	__tlb_switch_to_host(&cxt);
 }
 
@@ -142,18 +120,5 @@ void __kvm_flush_vm_context(void)
 {
 	dsb(ishst);
 	__tlbi(alle1is);
-
-	/*
-	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
-	 * is necessary across a VMID rollover.
-	 *
-	 * VPIPT caches constrain lookup and maintenance to the active VMID,
-	 * so we need to invalidate lines with a stale VMID to avoid an ABA
-	 * race after multiple rollovers.
-	 *
-	 */
-	if (icache_is_vpipt())
-		asm volatile("ic ialluis");
-
 	dsb(ish);
 }
diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
index 66f17349f0c36..67047feb30687 100644
--- a/arch/arm64/kvm/hyp/vhe/tlb.c
+++ b/arch/arm64/kvm/hyp/vhe/tlb.c
@@ -146,18 +146,5 @@ void __kvm_flush_vm_context(void)
 {
 	dsb(ishst);
 	__tlbi(alle1is);
-
-	/*
-	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
-	 * is necessary across a VMID rollover.
-	 *
-	 * VPIPT caches constrain lookup and maintenance to the active VMID,
-	 * so we need to invalidate lines with a stale VMID to avoid an ABA
-	 * race after multiple rollovers.
-	 *
-	 */
-	if (icache_is_vpipt())
-		asm volatile("ic ialluis");
-
 	dsb(ish);
 }
-- 
2.30.2

