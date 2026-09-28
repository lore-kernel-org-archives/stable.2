Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3554D09F5;
	Mon, 28 Sep 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613906; cv=none; b=cBg/wFcdx8KM3GIbXZYNuw45YNh3/QDCL5m/U+yTxDv3krGlc7SMj9dlRetkyhY61WbCuoLljN+ql47FqajQAdDWq2Fmh9zP0WuyuhNfV7lXFKt+N1giLa7IyuApgVmsmOvII1qux/gWHj6vHVxvKRNyDsDhH0LsAZO96SIGKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613906; c=relaxed/simple;
	bh=VyvjQnu65mXMiE6ziLs5qp1BclpRNlQTWNsj1f87aJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewYwLVHDhof5fUAjIIwITqjF1mwIrNXxgjDZYIbHhtFpBksuTaIchmLSSEh11iMs0S2qTXtLmxjqZTnaeaU76LHicdsHjsf2URm3HKF0N/F2QN2j0acWW8cCFBpSXv+VGz3UAmJVYi7M4hhMZezVKjxMj+JQ7HbUDwnUdci4ml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=ZQ42ztwD; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="ZQ42ztwD"
Received: from fedora ([104.28.225.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SGijNr080644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 01:44:51 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=p0uKnmPMY0uDIGxR1D+DBtC7q/r0xhrp4+xMgf5ceJs=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790613891; v=1;
        b=ZQ42ztwD/ta1aY+viDw9lJ4KOlmBe0Y82gMcMAH9KVndzgub61UHaXFL/CbhJIRd
         l6x4wqOE5iKdCYW4xuxaJ3g9wCwGvWBP6OvCg2Zyv7Fq9KinZmo2rgjPgZqHzEq9
         +dMa6XgxzI3bVwlL+OwjCs7414yAXa57kIFVnDUajm2+GvgkMY/UlsKbEP8QftgY
         2a3Lmg0srWBjz7wSMx51vCdropzY/nsSVLxs/tLLsk3C5UslV5stfh7aanvaRVSO
         vXCCWG+/juKIkuRUzO0lngpF+Ws5YTxnOGrqJfZ4RNmdHIUxkpNGCVjnCrtdhk9u
         SlfPDjj65/T+UW18d97pDQ==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v4 06/11] KVM: X86: Rename gpte_is_8_bytes to has_4_byte_gpte and invert the direction
Date: Tue, 29 Sep 2026 01:44:22 +0900
Message-ID: <20260928164427.4699-7-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <laijs@linux.alibaba.com>

commit bb3b394d35e80d7a58ce015191e4960a13f54ba5 upstream.

This bit is very close to mean "role.quadrant is not in use", except that
it is false also when the MMU is mapping guest physical addresses
directly.  In that case, role.quadrant is indeed not in use, but there
are no guest PTEs at all.

Changing the name and direction of the bit removes the special case,
since a guest with paging disabled, or not considering guest paging
structures as is the case for two-dimensional paging, does not have
to deal with 4-byte guest PTEs.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Message-Id: <20211124122055.64424-10-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 Documentation/virt/kvm/mmu.rst  |  8 ++++----
 arch/x86/include/asm/kvm_host.h |  8 ++++----
 arch/x86/kvm/mmu/mmu.c          | 12 ++++++------
 arch/x86/kvm/mmu/mmutrace.h     |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/virt/kvm/mmu.rst b/Documentation/virt/kvm/mmu.rst
index f60f5488e121..5b1ebad24c77 100644
--- a/Documentation/virt/kvm/mmu.rst
+++ b/Documentation/virt/kvm/mmu.rst
@@ -161,7 +161,7 @@ Shadow pages contain the following information:
     If clear, this page corresponds to a guest page table denoted by the gfn
     field.
   role.quadrant:
-    When role.gpte_is_8_bytes=0, the guest uses 32-bit gptes while the host uses 64-bit
+    When role.has_4_byte_gpte=1, the guest uses 32-bit gptes while the host uses 64-bit
     sptes.  That means a guest page table contains more ptes than the host,
     so multiple shadow pages are needed to shadow one guest page.
     For first-level shadow pages, role.quadrant can be 0 or 1 and denotes the
@@ -177,9 +177,9 @@ Shadow pages contain the following information:
     The page is invalid and should not be used.  It is a root page that is
     currently pinned (by a cpu hardware register pointing to it); once it is
     unpinned it will be destroyed.
-  role.gpte_is_8_bytes:
-    Reflects the size of the guest PTE for which the page is valid, i.e. '1'
-    if 64-bit gptes are in use, '0' if 32-bit gptes are in use.
+  role.has_4_byte_gpte:
+    Reflects the size of the guest PTE for which the page is valid, i.e. '0'
+    if direct map or 64-bit gptes are in use, '1' if 32-bit gptes are in use.
   role.efer_nx:
     Contains the value of efer.nx for which the page is valid.
   role.cr0_wp:
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2c378064a1db..d31817fb3962 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -297,14 +297,14 @@ struct kvm_kernel_irq_routing_entry;
  *
  *   - invalid shadow pages are not accounted, so the bits are effectively 18
  *
- *   - quadrant will only be used if gpte_is_8_bytes=0 (non-PAE paging);
+ *   - quadrant will only be used if has_4_byte_gpte=1 (non-PAE paging);
  *     execonly and ad_disabled are only used for nested EPT which has
- *     gpte_is_8_bytes=1.  Therefore, 2 bits are always unused.
+ *     has_4_byte_gpte=0.  Therefore, 2 bits are always unused.
  *
  *   - the 4 bits of level are effectively limited to the values 2/3/4/5,
  *     as 4k SPs are not tracked (allowed to go unsync).  In addition non-PAE
  *     paging has exactly one upper level, making level completely redundant
- *     when gpte_is_8_bytes=0.
+ *     when has_4_byte_gpte=1.
  *
  *   - on top of this, smep_andnot_wp and smap_andnot_wp are only set if
  *     cr0_wp=0, therefore these three bits only give rise to 5 possibilities.
@@ -316,7 +316,7 @@ union kvm_mmu_page_role {
 	u32 word;
 	struct {
 		unsigned level:4;
-		unsigned gpte_is_8_bytes:1;
+		unsigned has_4_byte_gpte:1;
 		unsigned quadrant:2;
 		unsigned direct:1;
 		unsigned access:3;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 62e9a7db0183..bfb1455ebeef 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2094,7 +2094,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	role.level = level;
 	role.direct = direct;
 	role.access = access;
-	if (!direct_mmu && !role.gpte_is_8_bytes) {
+	if (role.has_4_byte_gpte) {
 		quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
 		quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
 		role.quadrant = quadrant;
@@ -4840,7 +4840,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 	role.base.ad_disabled = (shadow_accessed_mask == 0);
 	role.base.level = kvm_mmu_get_tdp_level(vcpu);
 	role.base.direct = true;
-	role.base.gpte_is_8_bytes = true;
+	role.base.has_4_byte_gpte = false;
 
 	return role;
 }
@@ -4885,7 +4885,7 @@ kvm_calc_shadow_root_page_role_common(struct kvm_vcpu *vcpu,
 
 	role.base.smep_andnot_wp = role.ext.cr4_smep && !____is_cr0_wp(regs);
 	role.base.smap_andnot_wp = role.ext.cr4_smap && !____is_cr0_wp(regs);
-	role.base.gpte_is_8_bytes = ____is_cr0_pg(regs) && ____is_cr4_pae(regs);
+	role.base.has_4_byte_gpte = ____is_cr0_pg(regs) && !____is_cr4_pae(regs);
 
 	return role;
 }
@@ -4984,7 +4984,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	role.base.smm = vcpu->arch.root_mmu.mmu_role.base.smm;
 
 	role.base.level = level;
-	role.base.gpte_is_8_bytes = true;
+	role.base.has_4_byte_gpte = false;
 	role.base.direct = false;
 	role.base.ad_disabled = !accessed_dirty;
 	role.base.guest_mode = true;
@@ -5267,7 +5267,7 @@ static bool detect_write_misaligned(struct kvm_mmu_page *sp, gpa_t gpa,
 		 gpa, bytes, sp->role.word);
 
 	offset = offset_in_page(gpa);
-	pte_size = sp->role.gpte_is_8_bytes ? 8 : 4;
+	pte_size = sp->role.has_4_byte_gpte ? 4 : 8;
 
 	/*
 	 * Sometimes, the OS only writes the last one bytes to update status
@@ -5291,7 +5291,7 @@ static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
 	page_offset = offset_in_page(gpa);
 	level = sp->role.level;
 	*nspte = 1;
-	if (!sp->role.gpte_is_8_bytes) {
+	if (sp->role.has_4_byte_gpte) {
 		page_offset <<= 1;	/* 32->64 */
 		/*
 		 * A 32-bit pde maps 4MB while the shadow pdes map
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index 2924a4081a19..9863290dcba1 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -35,7 +35,7 @@
 			 " %snxe %sad root %u %s%c",			\
 			 __entry->mmu_valid_gen,			\
 			 __entry->gfn, role.level,			\
-			 role.gpte_is_8_bytes ? 8 : 4,			\
+			 role.has_4_byte_gpte ? 4 : 8,			\
 			 role.quadrant,					\
 			 role.direct ? " direct" : "",			\
 			 access_str[role.access],			\
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7a64fb238044..74df3f6a3a59 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -179,7 +179,7 @@ static union kvm_mmu_page_role page_role_for_level(struct kvm_vcpu *vcpu,
 	role = vcpu->arch.mmu->mmu_role.base;
 	role.level = level;
 	role.direct = true;
-	role.gpte_is_8_bytes = true;
+	role.has_4_byte_gpte = false;
 	role.access = ACC_ALL;
 
 	return role;
-- 
2.53.0

