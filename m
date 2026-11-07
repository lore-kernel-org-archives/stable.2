Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049682;
	b=wSgpIPw6uHBBuoClD0WWA2jjK+dcFuDX5HGg10b/nO3qxeB2a0TDcAqopPg8VoHFXTs/
	 YeSeYpF1V1JlD1ZoUUpRZiCPR3kymwuYZqCo2i/3a04duMCsjbnh+1oaOx4oiCc7kg7dw
	 S3UrSENtmqkX4rBxDi64SE1Rmtwo/IroUDCCOQKKK6mnz0060vkNlbAqh7Omp1gVj8kR/
	 Rgk843RC7rllxUDlsneHGmSfvQzWsj2W3LUARp9IQ/fJ70CfH5wwS1xuv0APCpbt0orCr
	 ap63XLsup+nxFLaLbxIGQaM6tiFIj1DMJNmxWl/gLeZMGXeVeDIKr7OfCbl+Wp9nOPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=c+yGDiy3N11XI712sIRhP01CmcFiCQqMd+adfNUS93g=;
	b=nIw+0Tf2wTViM68Fnd8gIuVRy0ZzCDeGhhXKJKTNYjmVxKGcDNKSantQvL4/YPQFl7rk
	 8Wha5jHovdEkVQZmZBfe1XYl3sZ8YsGmQtpgHf+ffzLGXhEYREAQvipji5/8zYX1WYzlH
	 ys4pCIlDsaut+c8X9/t9SH9s9pPUxpx4X7VMdKJJIvO44yVIT0DusKwXBiClFVunB26z1
	 5cp1G5JpEG2/GkG94os7XOkXUX9+vnaPSedugemxOpDAfqOTKAdb3yASCy8NcZwViPunM
	 dPnrgC0R9DFwdjWerJAlKrmBbLC2ZWtf4fENAvDCVq/RvDCao+DUM65AjxItrlZID8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giDERQ2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00910606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giDERQ2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A561F0089F;
	Sat,  7 Nov 2026 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049681;
	bh=c+yGDiy3N11XI712sIRhP01CmcFiCQqMd+adfNUS93g=;
	h=From:To:Cc:Subject:Date;
	b=giDERQ2aPfyRZJh0oH6ziHCcDh4ZGlRLW0js6xRkzVGN0e0oSHgkURYhjs+WPpofX
	 cuCxmNLOP0HwfLaN1X7DPj2e4h4Q0VZN4rGVAtVfLp0yWMmCBRk/r5Kj6pmQJnM0lg
	 A39n8nV4nQ79n+7SHVlP1c1CbePytI5Wfkn29gKR071tt0JeRwTnmgq1jUzmftS3NL
	 BLh4eBKyMzm/7Xd+4cMW91lbmhUuCZBJDt8YY9EpbjsM5kVZOH7Y3Kg/J/hOtkb6eq
	 XrnlBSOi4zmrQR5ZnEotx+puWUu2mTOtBczjgbMj5T/vaFkRHVnXMkibyZl7DRWnoF
	 wn6B+Y0nTmWEQ==
From: Sasha Levin <sashal@kernel.org>
To: fuad.tabba@linux.dev,
	maz@kernel.org,
	oupton@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Don't map an LPI from more than one event" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:59 -0500
Message-ID: <20261107060759-failed-5.15-de81b28f0b83@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x de81b28f0b83b22163d7d9a9b708d7aa912e0ef7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060759-failed-5.15-de81b28f0b83@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From de81b28f0b83b22163d7d9a9b708d7aa912e0ef7 Mon Sep 17 00:00:00 2001
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 13 Oct 2026 09:16:45 +0100
Subject: [PATCH] KVM: arm64: vgic-its: Don't map an LPI from more than one
 event

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
---
 arch/arm64/kvm/vgic/vgic-its.c | 26 ++++++++++++++++++++++++--
 include/kvm/arm_vgic.h         |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index a9949ab4e4133..73d7aa700687d 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -776,6 +776,7 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
 				its_unmap_vlpi(ite->irq->host_irq);
 
 			irq->hw = false;
+			irq->mapped = false;
 		}
 
 		vgic_put_irq(kvm, ite->irq);
@@ -784,6 +785,23 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
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
@@ -1093,13 +1111,14 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
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
@@ -2219,7 +2238,10 @@ static int vgic_its_restore_ite(struct vgic_its *its, u32 event_id,
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
index 086b7578e5f33..5c3a0154becc4 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -256,6 +256,7 @@ struct vgic_irq {
 	bool active:1;
 	bool hw:1;			/* Tied to HW IRQ */
 	bool on_lr:1;			/* Present in a CPU LR */
+	bool mapped:1;			/* LPIs: mapped by an ITE */
 	refcount_t refcount;		/* Used for LPIs */
 	u32 hwintid;			/* HW INTID number */
 	unsigned int host_irq;		/* linux irq corresponding to hwintid */
-- 
2.53.0




