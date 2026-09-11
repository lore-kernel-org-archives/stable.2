Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FD29CE9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124348; cv=none; b=a4ZDqKq7E8jpUX5cuFHB4OrfA9Bnom1fSnLQnTIbOtgFIWmtKYBs3bmc5Gd7+6Zt1pjiHLv8GN62FB5pbAP9fiP4CuB6+7S8RZTFXjdlX2Rr8YD43ho/Zg98c/v+DSfxhJ5QJ1vCQcK6BIGBEkq6JRM6xhuJMeCSpz9NsgSyCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124348; c=relaxed/simple;
	bh=goyXvENrkl9cL/kkDSm3v5/IsmDwKwKw90XA0wc82fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAn9eCB5RxLIenxGOBwSKxa3SAHSH3/zEN/A+LUR3u0TDyjBgG0EErbzcvlcl5WqsR8D2bJ5Uc68AfLl2qwzLAfrkfgx0gLoki8apY0yiOEFWtrzLfHoRm7CDif6Ke5393u4CB+aPfve5jD//+FNExxdUBZ79KVgpPDDCjervbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBR3NPET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBR3NPET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CCF1F00899;
	Fri, 11 Sep 2026 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789124346;
	bh=YbnZ+yPnhdxWX11j6HJb42+gyYAF/mAAozVVD2L6GiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UBR3NPETwUPJR5Ra/VRAoe6XkXD203vXimJNb8fq0x0t4czhDZ5i6BGA/D6xttTWO
	 ahu4A0YkNcrtfFcClnF/lAGRHRyP8+YIwrzKU5UMogYzlfjGo/DhVMkOHpVF09t5Gr
	 u6R1IUKJAhir9ehFES8fXHRXpug+F2bhKqJw4sKpc1krbklbLRtRUsn75rH2hwbDkA
	 owBRQ+DcjyueutlYE/3Gnvj+Q3FSMOyhwIshbeMwNDrXktloUH+MgBA/dwKSISRt/g
	 S6Ee08/lutRT5i8aWhoplRpiVluYH+6YdTwSh0KLa4FrB7d6ABi2gdOO3irxFKwAYp
	 Q82Pb27R0SGxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	sashiko-bot@kernel.org,
	Yuan Yao <yaoyuan@linux.alibaba.com>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] KVM: arm64: Handle VNCR TLB invalidation race with vcpu_put() VNCR unmapping
Date: Fri, 11 Sep 2026 06:59:03 -0400
Message-ID: <20260911105903.296829-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911105903.296829-1-sashal@kernel.org>
References: <2026090924-dweeb-huskiness-bd94@gregkh>
 <20260911105903.296829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 38640bc32be3fcf9526d477155bc19d3f146231f ]

While VNCR TLB invalidation always occurs under the MMU lock,
vcpu_put() doesn't, while it unmaps the VNCR page.

The problem is that the invalidation evaluates vncr_tlb::cpu to
decide whether an unmapping needs to take place (cpu != -1) before
performing it. On the other hand, this_cpu_reset_vncr_fixmap()
unconditionally unmaps if L1_VNCR_MAPPED is set.

These two obviously can race, with a TOCTOU pattern on the TLBI
path, and a BUG_ON() on the vcpu_put() path. And the two can end-up
calling vncr_fixmap(-1), with extra lethal effects.

Move the reset of vncr_tlb::cpu to -1 to a common function, and make
this update atomic so that only a single thread can reset the field
and perform the corresponding unmap. The vcpu_put() still need to
unconditionally unmap the current VNCR to close another ugly race.

Finally, the assignment of vncr_tlb::cpu is moved to be kept in sync
with the actual mapping, similar to L1_VNCR_MAPPED being set.

Fixes: 7270cc9157f47 ("KVM: arm64: nv: Handle VNCR_EL2 invalidation from MMU notifiers")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260801130237.0FD8F1F00ACA@smtp.kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
Link: https://patch.msgid.link/20260806091026.620700-6-maz@kernel.org
Signed-off-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/nested.c | 42 +++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 5a297c16bc338..747aad09a40ee 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -27,7 +27,7 @@ struct vncr_tlb {
 	bool			hpa_writable;
 
 	/* -1 when not mapped on a CPU */
-	int			cpu;
+	atomic_t		cpu;
 
 	/*
 	 * true if the TLB is valid. Can only be changed with the
@@ -771,16 +771,40 @@ void kvm_vcpu_load_hw_mmu(struct kvm_vcpu *vcpu)
 	}
 }
 
+/*
+ * Unmapping an L1 VNCR can happen concurrently without the mmu lock being
+ * effective (vcpu_put() vs TLBI handling). The atomic_xchg below ensures
+ * that only one CPU sets it to -1 while getting a valid CPU number back.
+ */
+static int unmap_l1_vncr(struct vncr_tlb *vt)
+{
+	int cpu = atomic_xchg_relaxed(&vt->cpu, -1);
+
+	if (cpu != -1)
+		clear_fixmap(vncr_fixmap(cpu));
+
+	return cpu;
+}
+
 static void this_cpu_reset_vncr_fixmap(struct kvm_vcpu *vcpu)
 {
 	if (!host_data_test_flag(L1_VNCR_MAPPED))
 		return;
 
-	BUG_ON(vcpu->arch.vncr_tlb->cpu != smp_processor_id());
 	BUG_ON(is_hyp_ctxt(vcpu));
 
-	clear_fixmap(vncr_fixmap(vcpu->arch.vncr_tlb->cpu));
-	vcpu->arch.vncr_tlb->cpu = -1;
+	/*
+	 * Unconditionally unmap the local VNCR if we have lost the race
+	 * against a concurrent TLBI. Otherwise we could end-up running
+	 * another vcpu with VNCR still mapped if the TLBI thread is
+	 * preempted between the exchange and the clear_fixmap().
+	 *
+	 * Note that we do not care about the TLBI nuking the fixmap behind
+	 * the back of an running vcpu. This will only generate a fault and
+	 * possibly a retranslation.
+	 */
+	if (unmap_l1_vncr(vcpu->arch.vncr_tlb) == -1)
+		clear_fixmap(vncr_fixmap(smp_processor_id()));
 	host_data_clear_flag(L1_VNCR_MAPPED);
 	atomic_dec(&vcpu->kvm->arch.vncr_map_count);
 }
@@ -870,8 +894,7 @@ u16 get_asid_by_regime(struct kvm_vcpu *vcpu, enum trans_regime regime)
 static void invalidate_vncr(struct vncr_tlb *vt)
 {
 	vt->valid = false;
-	if (vt->cpu != -1)
-		clear_fixmap(vncr_fixmap(vt->cpu));
+	unmap_l1_vncr(vt);
 }
 
 static bool vncr_tlb_intersects(struct vncr_tlb *vt, u64 addr,
@@ -1321,7 +1344,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		vt->hpa = pfn << PAGE_SHIFT;
 		vt->hpa_writable = writable;
 		vt->valid = true;
-		vt->cpu = -1;
+		atomic_set(&vt->cpu, -1);
 
 		kvm_make_request(KVM_REQ_MAP_L1_VNCR_EL2, vcpu);
 		kvm_release_faultin_page(vcpu->kvm, page, false, vt->wr.pw && vt->hpa_writable);
@@ -1452,8 +1475,6 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	if (vt->wr.nG && get_asid_by_regime(vcpu, TR_EL20) != vt->wr.asid)
 		return;
 
-	vt->cpu = smp_processor_id();
-
 	if (vt->hpa_writable && vt->wr.pw && vt->wr.pr)
 		prot = PAGE_KERNEL;
 	else if (vt->wr.pr)
@@ -1468,7 +1489,8 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	 * FIXME: WO doesn't work at all, need POE support in the kernel.
 	 */
 	if (pgprot_val(prot) != pgprot_val(PAGE_NONE)) {
-		__set_fixmap(vncr_fixmap(vt->cpu), vt->hpa, prot);
+		atomic_set(&vt->cpu, smp_processor_id());
+		__set_fixmap(vncr_fixmap(atomic_read(&vt->cpu)), vt->hpa, prot);
 		host_data_set_flag(L1_VNCR_MAPPED);
 		atomic_inc(&vcpu->kvm->arch.vncr_map_count);
 	}
-- 
2.53.0

