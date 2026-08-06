Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5963DB630;
	Thu,  6 Aug 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007437; cv=none; b=T39W05oSeNASD/7ETlCRL0+5RpZ8wWONpwqQujUxYiecFrp+9M1m1fyBzhKx+5CrFE7ROEK1IS6AuynJFRIUuhbel18Mqf2hflS/kiiHugBZAz/wgAuYGGS8mSQWhpHUwSpfa6kRM497fLHWSf1zUGl0nKkM5qEtYPL11nbn3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007437; c=relaxed/simple;
	bh=LeCHOn/2Zp6cXW6Gp1GeENW3Pk3Qm/nrH3BtXvUM1nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmIAoOPpxHQ2mbKf8cfFt+BH+py92VhORf8176CN6lJoSDcueBgmoymlL2RCszul7r2BzfdTN9qyCxlNNsTk94VCk4eh57Og+F+9tUhV1cdt723rm9z2oXtJ0dwn1G0xGtm4G8YW4MnQcRvnXLXOK7ZiHkWJQrsA/3cuzKwM+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFC7fD/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFC7fD/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C1D1F00A3F;
	Thu,  6 Aug 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007434;
	bh=ysq1Of4ffXNIE2ctqACKSbrDmA9C1+pcfxCS9T6+5iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KFC7fD/Z7PNyMzCgfYDnsSCPAdDhoFeXkuC2+wYQ11DA35hCdDn9BkjfQGgoeox2Q
	 PcGKOryNNi7PaBoFDUr8TNX9tRHOzUC0zIt6i4N5NYiFDp6J3+FJLvqmhc8Zp7pTSl
	 tbfoLSw0YlVVcF2/YTRGG21XakpMHlFnP//HkL/ehjS0El0ptMfG5GVKR8pVoQVieB
	 b55K4EBHN+AMcGIxhfMmrBWFUayyfudICQQ/v05BBxNDqUtPCO89li2VGREodCPUH3
	 77VxYj+xhtOwy+GSH/rysNz0bPcw0ygpuscjfEqMUSi1JzFbS/jqRDtpYxHR+3mjZO
	 jixoQYa8tz94w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wru7U-0000000CtHi-44tJ;
	Thu, 06 Aug 2026 09:10:33 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Yao Yuan <yaoyuan@linux.alibaba.com>,
	ljs@kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 5/8] KVM: arm64: Handle VNCR TLB invalidation race with vcpu_put() VNCR unmapping
Date: Thu,  6 Aug 2026 10:10:23 +0100
Message-ID: <20260806091026.620700-6-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806091026.620700-1-maz@kernel.org>
References: <20260806091026.620700-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, imv4bel@gmail.com, yaoyuan@linux.alibaba.com, ljs@kernel.org, sashiko-bot@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

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
---
 arch/arm64/kvm/nested.c | 42 +++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 8a602d074dbb4..cf0d45059edbd 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -27,7 +27,7 @@ struct vncr_tlb {
 	bool			hpa_writable;
 
 	/* -1 when not mapped on a CPU */
-	int			cpu;
+	atomic_t		cpu;
 
 	/*
 	 * true if the TLB is valid. Can only be changed with the
@@ -894,16 +894,40 @@ void kvm_vcpu_load_hw_mmu(struct kvm_vcpu *vcpu)
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
 }
 
@@ -995,8 +1019,7 @@ u16 get_asid_by_regime(struct kvm_vcpu *vcpu, enum trans_regime regime)
 static void invalidate_vncr(struct vncr_tlb *vt)
 {
 	vt->valid = false;
-	if (vt->cpu != -1)
-		clear_fixmap(vncr_fixmap(vt->cpu));
+	unmap_l1_vncr(vt);
 }
 
 static bool vncr_tlb_intersects(struct vncr_tlb *vt, u64 addr,
@@ -1452,7 +1475,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		vt->hpa = pfn << PAGE_SHIFT;
 		vt->hpa_writable = writable;
 		vt->valid = true;
-		vt->cpu = -1;
+		atomic_set(&vt->cpu, -1);
 
 		kvm_make_request(KVM_REQ_MAP_L1_VNCR_EL2, vcpu);
 		kvm_release_faultin_page(vcpu->kvm, page, false, vt->wr.pw && vt->hpa_writable);
@@ -1583,8 +1606,6 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	if (vt->wr.nG && get_asid_by_regime(vcpu, TR_EL20) != vt->wr.asid)
 		return;
 
-	vt->cpu = smp_processor_id();
-
 	if (vt->hpa_writable && vt->wr.pw && vt->wr.pr)
 		prot = PAGE_KERNEL;
 	else if (vt->wr.pr)
@@ -1599,7 +1620,8 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	 * FIXME: WO doesn't work at all, need POE support in the kernel.
 	 */
 	if (pgprot_val(prot) != pgprot_val(PAGE_NONE)) {
-		__set_fixmap(vncr_fixmap(vt->cpu), vt->hpa, prot);
+		atomic_set(&vt->cpu, smp_processor_id());
+		__set_fixmap(vncr_fixmap(atomic_read(&vt->cpu)), vt->hpa, prot);
 		host_data_set_flag(L1_VNCR_MAPPED);
 	}
 }
-- 
2.47.3

