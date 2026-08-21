Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C94471420
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303169; cv=none; b=Wf815GXBC2uS0DLlBkebbUSjBd4ZcMBlhCYOA8KPtupDgtyXXpqPwQwuz888+psus4nkvOe9AZELvxR22KGCfM8f3DDkSZOsLxbi4KGox9RNSrOEjCNea1jfty+9n8LsuOUlCYFtEGyYwWZI5DJweUAB+dU7sjJUWshVfVSK+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303169; c=relaxed/simple;
	bh=RhM/aNRBbeWRKMTsdM8v7FFxp6FLR8zH3UKc4QkY0Bg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z2JJ9lfV4VUKNaAmv19MlBC7HAylPYJcLfFfCGrGzKm+Qfuk9UzrGl2PRn2bx3fceCJlHbiT5BfDiNV1Gp3VLkiMxauUM38gKhsmPo+ilWksxYGTd7WQmWhOf/MuKIEAR+/tRDooiyXmovRpRc61oM9EAalEvm/4qLx7hbLYhtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=gx0oTpBV; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="gx0oTpBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1787303164; x=1818839164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kDikvsdMYoBh9+d7XLGt2RYJcuAPps9Xjx/TmVaf2Js=;
  b=gx0oTpBVKU3BeMKgT28qm7dgkSh7GhHlXD8saBjYzmoCchaZOtFtBywV
   Os5VaEXNNHFGwmUCJOpzHb/5RglA7zVXQUMbNOjfbu+Y6B9o8C6explH+
   FjTAj6fPUpn1RvmHZxwPbn/hY6e2q7lyil2lyDmq1smIrqesbwg+S5DdR
   31J73n1H5d0rm2YtVtTXPOkLJa6NFvollKOP2wZbzme9cmKA08sw5pVhC
   vp2dXgXKGIc3ZlmdFgSMsziTRcvVs6lBJlbrF8Qw8Nuu4koplB9GNvXNW
   GmniNwF3h7HG9p09Ec36BHsyZnWS7M9xfsIh6+qf7z4s4TtKhuNrYjBBH
   Q==;
X-CSE-ConnectionGUID: osgsXeJ8R1WCH3BBfegUfg==
X-CSE-MsgGUID: LJFy35O7Q6msC9DYR1OT8g==
X-IronPort-AV: E=Sophos;i="6.25,234,1779148800"; 
   d="scan'208";a="26569210"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 09:05:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:3958]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.103:2525] with esmtp (Farcaster)
 id e5a5d0b5-0376-458c-a3d6-00551f3acdaa; Fri, 21 Aug 2026 09:05:59 +0000 (UTC)
X-Farcaster-Flow-ID: e5a5d0b5-0376-458c-a3d6-00551f3acdaa
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 21 Aug 2026 09:05:59 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 21 Aug 2026 09:05:58 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, David Matlack <dmatlack@google.com>,
	<kvmarm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>, "Sean
 Christopherson" <seanjc@google.com>, Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 5.10.y] KVM: arm64: Retry fault if vma_lookup() results become invalid
Date: Fri, 21 Aug 2026 09:05:38 +0000
Message-ID: <20260821090538.3493280-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: David Matlack <dmatlack@google.com>

commit 13ec9308a85702af7c31f3638a2720863848a7f2 upstream.

Read mmu_invalidate_seq before dropping the mmap_lock so that KVM can
detect if the results of vma_lookup() (e.g. vma_shift) become stale
before it acquires kvm->mmu_lock. This fixes a theoretical bug where a
VMA could be changed by userspace after vma_lookup() and before KVM
reads the mmu_invalidate_seq, causing KVM to install page table entries
based on a (possibly) no-longer-valid vma_shift.

Re-order the MMU cache top-up to earlier in user_mem_abort() so that it
is not done after KVM has read mmu_invalidate_seq (i.e. so as to avoid
inducing spurious fault retries).

This bug has existed since KVM/ARM's inception. It's unlikely that any
sane userspace currently modifies VMAs in such a way as to trigger this
race. And even with directed testing I was unable to reproduce it. But a
sufficiently motivated host userspace might be able to exploit this
race.

Fixes: 94f8e6418d39 ("KVM: ARM: Handle guest faults in KVM")
Cc: stable@vger.kernel.org
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230313235454.2964067-1-dmatlack@google.com
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
[doebel: adjust to contextual and naming differences in 5.10]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
The fix is already present in every newer supported stable tree, so
5.10.y is the only one left without it:

  5.15.y  00f74003edf5 (backport)
  6.1.y   e1562cc202c9 (backport)
  6.6.y   and later contain the mainline commit 13ec9308a857 itself

Tested using the Amazon Linux kernel test suite.

 arch/arm64/kvm/mmu.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 26068456ec0f3..2cda74acada2e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -769,6 +769,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
+	/*
+	 * Permission faults just need to update the existing leaf entry,
+	 * and so normally don't require allocations from the memcache. The
+	 * only exception to this is when dirty logging is enabled at runtime
+	 * and a write fault needs to collapse a block entry into a table.
+	 */
+	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
+		ret = kvm_mmu_topup_memory_cache(memcache,
+						 kvm_mmu_cache_min_pages(kvm));
+		if (ret)
+			return ret;
+	}
+
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	mmap_read_lock(current->mm);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
@@ -818,32 +831,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		fault_ipa &= ~(vma_pagesize - 1);
 
 	gfn = fault_ipa >> PAGE_SHIFT;
-	mmap_read_unlock(current->mm);
 
 	/*
-	 * Permission faults just need to update the existing leaf entry,
-	 * and so normally don't require allocations from the memcache. The
-	 * only exception to this is when dirty logging is enabled at runtime
-	 * and a write fault needs to collapse a block entry into a table.
+	 * Read mmu_notifier_seq so that KVM can detect if the results of
+	 * find_vma_intersection() or gfn_to_pfn_prot() become stale prior to
+	 * acquiring kvm->mmu_lock.
+	 *
+	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
+	 * with the smp_wmb() in kvm_mmu_notifier_invalidate_range_end().
 	 */
-	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
-		ret = kvm_mmu_topup_memory_cache(memcache,
-						 kvm_mmu_cache_min_pages(kvm));
-		if (ret)
-			return ret;
-	}
-
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
-	/*
-	 * Ensure the read of mmu_notifier_seq happens before we call
-	 * gfn_to_pfn_prot (which calls get_user_pages), so that we don't risk
-	 * the page we just got a reference to gets unmapped before we have a
-	 * chance to grab the mmu_lock, which ensure that if the page gets
-	 * unmapped afterwards, the call to kvm_unmap_hva will take it away
-	 * from us again properly. This smp_rmb() interacts with the smp_wmb()
-	 * in kvm_mmu_notifier_invalidate_<page|range_end>.
-	 */
-	smp_rmb();
+	mmap_read_unlock(current->mm);
 
 	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
-- 
2.51.0

