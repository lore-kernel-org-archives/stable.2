Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590925;
	b=kwmMbtbugx/TasuIn/pSC2TJOrNWUDii7SPQI2oV/EPsNjjlNkNGUToTTgAzAivm8roU
	 CsQCdCb+2+P9Uo579se/6yTnISt76Am24fwdDpLwXRmnRPzo6RN4MEElJZBnWjpPD27VB
	 xxMcZcJ5tlNPVn4X12eRHNLvAaEnHtlsfIN8kQNTCCcV5S+Dn4dQz967ECKc2BPpTe1cM
	 R9B1Ms40Dc028FlMrUdCwHUS4t7HOryVgO/zceitYnIyz6euG3iG5eCcxT8f7plc58hBw
	 BusUgH0/rZXm2ytR2qV76EDJthFjc8W1OygkoR6UJzJfzvoaQlqoD3Z/Jhuxa4NvZRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590925;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=18ZIosLKk7BzjHsSpGNZQkf0kkfqcw7xiPJnCtS/mBA=;
	b=mNHcfxWJWS5NaVB19+0Wwu4zr1KuNQy4GHHG/rbhdJJqmrE4Qv/UPxT0S0rJVG/xSTMO
	 Zwe1ENRJ1SM4uZGQfsHzDqGDzlJ3Nwatw6Z0urf87LZeBLJWglGLke+8XKEbWJQUSug8z
	 tZJoJjYsTXMux4nbRbEuygpeP5ahWtA6P8cSSep535KQh3QKAN8/qCkI1ObEqTBV4FvAG
	 CTsnoYy3Tr1V3PTF2DYB71h52sM7iWTK3cHHry+WVzqMSnAXVxlyAmFoWxFmN+FtHt9vL
	 V41kHh/SoCTjnFn1z7ht7c8aH5ZBpoFnpGrPFJoMJcw51cuVJq3wYZODS1StUj+wkrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEY+Lkcf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B36606E677
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEY+Lkcf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5031F000C6;
	Fri, 13 Nov 2026 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590925;
	bh=18ZIosLKk7BzjHsSpGNZQkf0kkfqcw7xiPJnCtS/mBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UEY+LkcfcA0kDkTfn59OyB1tAJZlV8vreuezPLgDHTUA1Yy4FXeSfkyCTpALeWWGr
	 KN0sRtCJV2wWoR+cK+6Xzi49250/EBD3l0/pM2av8d4kFzDBcv2i2X8MaoleegKRLz
	 CsINpW40nd8B2IGA2aJPnavnWyWyA697cMCZSRVRxziR5K56KHYbbnJcrJKuGFK5QA
	 th6qm+USY2H2bpgbA5HqDrBBmq7VRAjasosBuy9kyPCQAvGnfg4ZP7AvD25fc5EmWR
	 V/2lIDN7qSqrrQJgEDFWwUbFUXOwslwjskdS4ByDlyKQ6ZlhwpTLYUrYO97v7hg1ST
	 oYCuOtNZZra2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: arm64: vgic-its: Don't map an LPI from more than one event
Date: Fri, 13 Nov 2026 12:28:43 -0500
Message-ID: <20261113172820.2181215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053616-failed-6.6-de81b28f0b83@kernel.org>
References: <20261107053616-failed-6.6-de81b28f0b83@kernel.org>
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

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit de81b28f0b83b22163d7d9a9b708d7aa912e0ef7 ]

KVM keeps one vgic_irq per LPI. A MAPTI of an LPI whose vgic_irq
already exists reuses it for the new ITE and leaves its target vCPU as
it was. Mapping one LPI from two events is UNPREDICTABLE (IHI 0069H.b,
5.2.10), but nothing stops a guest from doing it. If the first MAPTI
names a collection the guest never maps and the second a mapped one,
the LPI translates through the second event with a NULL target vCPU.

When the VMM routes an assigned device's MSI to that event on a host
with GICv4 enabled, kvm_vgic_v4_set_forwarding() takes the vPE from the
NULL target vCPU and the host oopses:

  Unable to handle kernel paging request at virtual address 0000000000001980
  [...]
  Call trace:
   its_build_vmapti_cmd (drivers/irqchip/irq-gic-v3-its.c:943) (P)
   its_irq_set_vcpu_affinity (drivers/irqchip/irq-gic-v3-its.c:1380)
   irq_set_vcpu_affinity (kernel/irq/manage.c:670)
   its_map_vlpi (drivers/irqchip/irq-gic-v4.c:326)
   kvm_vgic_v4_set_forwarding (arch/arm64/kvm/vgic/vgic-v4.c:485)
   kvm_arch_irq_bypass_add_producer (arch/arm64/kvm/arm.c:2977)
   irq_bypass_register_consumer (virt/lib/irqbypass.c:44)
   kvm_irqfd (arch/arm64/kvm/../../../virt/kvm/eventfd.c:496)
   kvm_vm_ioctl (arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5270)

Track in each vgic_irq whether an ITE maps it. Drop a MAPTI of an LPI
that is already mapped, as a failed MAPTI already is. Restoring the ITS
tables keeps the first ITE it reads for each LPI and drops any later
one, so a guest saved with a double mapping still restores. Key the
check on the mapping, not on the vgic_irq. A vgic_irq outlives its ITE
while anything holds a reference to it, such as the vCPU it was last
queued on. A later MAPTI of such an LPI succeeds as before, and now
retargets it to its collection.

Fixes: 196b136498b35 ("KVM: arm/arm64: GICv4: Wire mapping/unmapping of VLPIs in VFIO irq bypass")
Suggested-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/20261013081646.933312-2-fuad.tabba@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: added the missing locked IRQ cleanup block in its_free_ite() to accommodate the older implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-its.c | 37 +++++++++++++++++++++++++++++-----
 include/kvm/arm_vgic.h         |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index efc556b196826..2b393e2082c84 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -851,12 +851,18 @@ int vgic_its_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
 /* Requires the its_lock to be held. */
 static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
 {
+	struct vgic_irq *irq = ite->irq;
 	list_del(&ite->ite_list);
 
 	/* This put matches the get in vgic_add_lpi. */
-	if (ite->irq) {
-		if (ite->irq->hw)
-			WARN_ON(its_unmap_vlpi(ite->irq->host_irq));
+	if (irq) {
+		scoped_guard(raw_spinlock_irqsave, &irq->irq_lock) {
+			if (irq->hw)
+				WARN_ON(its_unmap_vlpi(ite->irq->host_irq));
+
+			irq->hw = false;
+			irq->mapped = false;
+		}
 
 		vgic_put_irq(kvm, ite->irq);
 	}
@@ -864,6 +870,23 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
 	kfree(ite);
 }
 
+/* Mapping one LPI from two events is UNPREDICTABLE: the first ITE keeps it. */
+static bool vgic_its_map_lpi(struct kvm *kvm, struct its_ite *ite,
+			     struct vgic_irq *irq, struct kvm_vcpu *vcpu)
+{
+	scoped_guard(raw_spinlock_irqsave, &irq->irq_lock) {
+		if (!irq->mapped) {
+			irq->mapped = true;
+			irq->target_vcpu = vcpu;
+			ite->irq = irq;
+			return true;
+		}
+	}
+
+	vgic_put_irq(kvm, irq);
+	return false;
+}
+
 static u64 its_cmd_mask_field(u64 *its_cmd, int word, int shift, int size)
 {
 	return (le64_to_cpu(its_cmd[word]) >> shift) & (BIT_ULL(size) - 1);
@@ -1173,13 +1196,14 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 		vcpu = kvm_get_vcpu(kvm, collection->target_addr);
 
 	irq = vgic_add_lpi(kvm, lpi_nr, vcpu);
+	if (!IS_ERR(irq) && !vgic_its_map_lpi(kvm, ite, irq, vcpu))
+		irq = ERR_PTR(-EEXIST);
 	if (IS_ERR(irq)) {
 		if (new_coll)
 			vgic_its_free_collection(its, coll_id);
 		its_free_ite(kvm, ite);
 		return PTR_ERR(irq);
 	}
-	ite->irq = irq;
 
 	return 0;
 }
@@ -2329,7 +2353,10 @@ static int vgic_its_restore_ite(struct vgic_its *its, u32 event_id,
 		its_free_ite(kvm, ite);
 		return PTR_ERR(irq);
 	}
-	ite->irq = irq;
+
+	/* Drop an ITE whose LPI another ITE maps, as MAPTI does. */
+	if (!vgic_its_map_lpi(kvm, ite, irq, vcpu))
+		its_free_ite(kvm, ite);
 
 	return offset;
 }
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 5b27f94d4fad6..751490f9795ef 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -138,6 +138,7 @@ struct vgic_irq {
 	bool active;			/* not used for LPIs */
 	bool enabled;
 	bool hw;			/* Tied to HW IRQ */
+	bool mapped;			/* LPIs: mapped by an ITE */
 	struct kref refcount;		/* Used for LPIs */
 	u32 hwintid;			/* HW INTID number */
 	unsigned int host_irq;		/* linux irq corresponding to hwintid */
-- 
2.53.0

