Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591710;
	b=JIdPek1QPif2R9wumRelJw1iuaO7WSjOiILxVk4c7LhYESaiBmHWpEKtRDcbxGLORmWX
	 nkH7VmtJRZzAnYmrOHGvHL9Tod0a82/jmn1nLB4zVtMaywX4x3H5V7JhQ49wAjI9A+EzO
	 qJyNJo/ng2nqK7vLHL1+TzTnBZQULcJequWjdMumDfQKb/zMzlAA9cBjCdQQCkRrpGthO
	 4v12VRBNwcgEFxrwktnPI4Vz4aEKQnUbzpP6aL8UEO4GSCUCbkiy76TXQ1eYMNae1jLad
	 aEmJzyX/+BmovYZ+y6i1cKHwaB74h6mjkWT0V/EVPIvKy/btgDkDR7VNMI1JkqZnBgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z5KY+bl0PZgv0WBME6a5w1DCO2YNSyqb9r0MJ3c6HN0=;
	b=BcnCW+GXVk+Ad6io0URPhDZp8yiZigdnzC68Ul709xM2YOWLf9ZIv9dVBpCndhPT/nQT
	 PV53aie2rQX3keMtAqrgGfgbKiCvcHBOZcjFPOGX9zSU0TLmXkFc6iyCQUNSj7lxu2Q7W
	 +P6vPx0H/7mVmi6cddQBn1W844rovNOnNzT0NCmo1t0LKE3uZq2WYUcVC5ZiL7xz6FJvw
	 j9a5jXFt58qYCYCFm6mgUM4Idce5XbULCbSTsyaSghtT1AdkmC2L9+Z6fEeY/YCHJcauE
	 apiXBxmYrn6bPemeR5VDZESyvBipfuKjtmZ3lrxOGJXmROTPJsZPMkFpX4ID2v67SAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpJ58rDg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC460703F3
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpJ58rDg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D981F000C4;
	Fri, 13 Nov 2026 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591710;
	bh=Z5KY+bl0PZgv0WBME6a5w1DCO2YNSyqb9r0MJ3c6HN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CpJ58rDgV9+ULaMo0xJH9gslRw6hbt9d9sPZjQvzW+6DHWT7eNqJoZ/MGlvXbfw5Q
	 CWW4EiGpw/S5o4RIlGAbYVSVce1Er2/CmEjsmwJkxXdWZXiX6B16SNYTlpdYht//Wb
	 fSgLxLdtsFhCRSwY2uhdfLabT7GZGWesskdy3b6QkuZ7436HdzQhwsvhnNGXJKQHPq
	 rvR1RM1N3YalzfXKQOL5KvZPpD2+Tr6ybLQPixwM4H1o0z7OM0QR9Q5CZqPkUe2vKT
	 8xdBPjDwXbFpVPP+RGkf9CpgPC6YXD+KUTC/dAzf6e9oIcUAq5ceR2iOGpRKknj+uD
	 KnM7Tm4Kphg7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: arm64: vgic-its: Don't map an LPI from more than one event
Date: Fri, 13 Nov 2026 12:41:48 -0500
Message-ID: <20261113174126.2186262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060759-failed-5.15-de81b28f0b83@kernel.org>
References: <20261107060759-failed-5.15-de81b28f0b83@kernel.org>
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
[ sashal: replaced scoped_guard() with explicit IRQ-saving spinlock calls for GNU89 compatibility ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-its.c | 40 ++++++++++++++++++++++++++++++++--
 include/kvm/arm_vgic.h         |  1 +
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index e6ed23b14623f..ae0ffb8dc667f 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -821,13 +821,20 @@ int vgic_its_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
 /* Requires the its_lock to be held. */
 static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
 {
+	unsigned long flags;
+
 	list_del(&ite->ite_list);
 
 	/* This put matches the get in vgic_add_lpi. */
 	if (ite->irq) {
+		raw_spin_lock_irqsave(&ite->irq->irq_lock, flags);
 		if (ite->irq->hw)
 			WARN_ON(its_unmap_vlpi(ite->irq->host_irq));
 
+		ite->irq->hw = false;
+		ite->irq->mapped = false;
+		raw_spin_unlock_irqrestore(&ite->irq->irq_lock, flags);
+
 		vgic_put_irq(kvm, ite->irq);
 	}
 
@@ -1074,6 +1081,7 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 	struct its_device *device;
 	struct its_collection *collection, *new_coll = NULL;
 	struct vgic_irq *irq;
+	unsigned long flags;
 	int lpi_nr;
 
 	device = find_its_device(its, device_id);
@@ -1114,13 +1122,27 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 		vcpu = kvm_get_vcpu(kvm, collection->target_addr);
 
 	irq = vgic_add_lpi(kvm, lpi_nr, vcpu);
+	if (!IS_ERR(irq)) {
+		/* Mapping one LPI from two events is UNPREDICTABLE: the first ITE keeps it. */
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
+		if (!irq->mapped) {
+			irq->mapped = true;
+			irq->target_vcpu = vcpu;
+			ite->irq = irq;
+		}
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+
+		if (!ite->irq) {
+			vgic_put_irq(kvm, irq);
+			irq = ERR_PTR(-EEXIST);
+		}
+	}
 	if (IS_ERR(irq)) {
 		if (new_coll)
 			vgic_its_free_collection(its, coll_id);
 		its_free_ite(kvm, ite);
 		return PTR_ERR(irq);
 	}
-	ite->irq = irq;
 
 	return 0;
 }
@@ -2186,6 +2208,7 @@ static int vgic_its_restore_ite(struct vgic_its *its, u32 event_id,
 	struct vgic_irq *irq;
 	u32 coll_id, lpi_id;
 	struct its_ite *ite;
+	unsigned long flags;
 	u32 offset;
 
 	val = *p;
@@ -2219,7 +2242,20 @@ static int vgic_its_restore_ite(struct vgic_its *its, u32 event_id,
 	irq = vgic_add_lpi(kvm, lpi_id, vcpu);
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
-	ite->irq = irq;
+
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
+	if (!irq->mapped) {
+		irq->mapped = true;
+		irq->target_vcpu = vcpu;
+		ite->irq = irq;
+	}
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+
+	/* Drop an ITE whose LPI another ITE maps, as MAPTI does. */
+	if (!ite->irq) {
+		vgic_put_irq(kvm, irq);
+		its_free_ite(kvm, ite);
+	}
 
 	return offset;
 }
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index e9caa57cd633a..fcfa2777aaa08 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -136,6 +136,7 @@ struct vgic_irq {
 	bool active;			/* not used for LPIs */
 	bool enabled;
 	bool hw;			/* Tied to HW IRQ */
+	bool mapped;			/* LPIs: mapped by an ITE */
 	struct kref refcount;		/* Used for LPIs */
 	u32 hwintid;			/* HW INTID number */
 	unsigned int host_irq;		/* linux irq corresponding to hwintid */
-- 
2.53.0

