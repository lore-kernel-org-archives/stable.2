Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590184;
	b=FnMIajt2+R9KKUIIfIwrQhXVeC3kqf/iHiSkiROR4dnnzstItUDOy9fCVIYfYXJlc0J9
	 99bd8WU0nJBXvjbAs9rehucervYe0R+X7N3F+YentRnocjfEmXDQn5GlyTpFaea6YuWmt
	 Eb8CUuws+oARUe8KHrYQJmNq9BaRZKQ21pMk3sMXYd6XwzJWhSAGg6NMMN69SaYmuBIGO
	 UqIK46+4K843vV/LNvGtPpnuyG/17P1qSDTBr16XP5ceP0as9bPGKAQ03WOCNgPUQyqrL
	 dAZCCMNE5Zxxy1Hy96hqtBdy0JnbyAQH0/E67Jxw0W+7XYUQQ/OjFVh7QeeLLrxHEzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590184;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ObU4XwVMkOVyRR/G2X4HsUtiWh83zWij+QPvSrsleEg=;
	b=BKQTFOK5luho26N0s+rMpky6sOoFnyf0XLGHMrWZ4SdrJLXjnZXJkMu4wFRdSPI8J2yV
	 dbnhne2gnEsl0Y8X28+fwiWOU3wWNFWfMLDFMB5FYbHAi+9RyytuGCLMtGmYME2HTOH/j
	 5BZYnN4c0dbcUuO5LDqb+EL4jNqhx5tvYMFxY/ODuLqQTIZ9AR2FJ9y2cNYssKWjOut+A
	 eGFaM+ASNufDsNHqwTE/Fn1c19ZcZ09ZwAOicc3CnCt0FkSVjvIdCC+JZzgZ4kqx8xVnW
	 K/ruH6xlvh6wKo3N6X7mayRkb+9F5+9/MPUdS6UF64lZjMw3Le2hlQcl8iaQOuUxLKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVU2bhzl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A16071435
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVU2bhzl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00621F000C7;
	Fri, 13 Nov 2026 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590184;
	bh=ObU4XwVMkOVyRR/G2X4HsUtiWh83zWij+QPvSrsleEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LVU2bhzlp33P/f7IWI6MK+VUCHi4/VjrF38oWoC26i86L960YJHe3Lc718FYRM2dp
	 w5hkNomn+GHmEgp2SJSD/svNcJtM/CLsA2juSSFIXDJmwLd0bQGuz0aY99Lsryn213
	 lumwJXk5DtkqwNsFdZTcA426kIiVRmrKnCXjIKLPdhffOynCGhZ3wpiZvhC+mPqMvC
	 Kyywb6ODLyhLo1DT/MNplu2E+hxah9z/C80V4v2yKsi4+LKx+mbjotieG0biRVGAQX
	 VC85P/P9z9Dq5sG5fh+Dx5LbJhR2XHcLqI4R39KZBJ+lc6Sxx00d2TTHdAi+6B8v4l
	 ku6Qwx6ZYVbEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: arm64: vgic-its: Don't map an LPI from more than one event
Date: Fri, 13 Nov 2026 12:16:22 -0500
Message-ID: <20261113171600.2160470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051225-failed-6.18-de81b28f0b83@kernel.org>
References: <20261107051225-failed-6.18-de81b28f0b83@kernel.org>
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
[ sashal: Changed mapped from a boolean bitfield to a plain bool to match the existing vgic_irq layout. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-its.c | 26 ++++++++++++++++++++++++--
 include/kvm/arm_vgic.h         |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 7ce07c8eb5b7e..0f77c755b16f9 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -774,6 +774,7 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
 				its_unmap_vlpi(ite->irq->host_irq);
 
 			irq->hw = false;
+			irq->mapped = false;
 		}
 
 		vgic_put_irq(kvm, ite->irq);
@@ -782,6 +783,23 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
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
@@ -1091,13 +1109,14 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 		vcpu = collection_to_vcpu(kvm, collection);
 
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
@@ -2208,7 +2227,10 @@ static int vgic_its_restore_ite(struct vgic_its *its, u32 event_id,
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
index 25eb6ba9dd23c..e8c00881dc218 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -142,6 +142,7 @@ struct vgic_irq {
 	bool active;
 	bool enabled;
 	bool hw;			/* Tied to HW IRQ */
+	bool mapped;			/* LPIs: mapped by an ITE */
 	refcount_t refcount;		/* Used for LPIs */
 	u32 hwintid;			/* HW INTID number */
 	unsigned int host_irq;		/* linux irq corresponding to hwintid */
-- 
2.53.0

