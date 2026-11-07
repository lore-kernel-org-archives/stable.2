Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049305;
	b=XCUtTPg77dsqiBbTMjGwEWXQHTQAstMm0auB0PAS6OYdTpsvf8f0fcKPROUeb+pWIXfR
	 H9zJPehZgoUEO4yrN8GFGSowBBgyRucRP1KVYhJ131F0ojnR1W87CLJz+KMI8uhfOMGb1
	 auM1M1Pru4//50EoxDVsHWjQEeKL7Mn44gbUfcFWrz/lF9wviQ2bY3qIdooAciN1ldGTz
	 SJi0fBTvYXcFjCCJO0OA6/T8N677yIgJu4sIQI1YCTbk5jmKz+WMNYE2XTTSy8MwPOTJ7
	 EnWuzBtzGpCqeN+AIl/tWqSiPAEfsI4Fbwj8me1l+kapLh61MeA2LIP3sirHanMVxhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4w+TcZeULr7wIKlQA9OLedqHyQ5ko5wp3fc82OJ5t/k=;
	b=K8qvUaezxC+r4IkDkjdpJ1EgmwAXJjVWR6GuhfxSoaWLTJ4Y2TxtY+FhC6/PkrRwuvwp
	 JFsz1mEGZPvs46FwZC2a01JOzFdF9CettNASIj/apc2q0BopB6I4N3AvLYylpcgrWPH2O
	 h/vI0fK9oZoTx0ygle4yVZRDDzVgBmOwo41Yc9MIbf8udWdDuCR8QQplpaGnuySw/SjaR
	 X6mHJsluUXLMZOevI0qNc9Oyj+qiezKbXHC6Nlxe0J8bRN1gps0psTneLeEmJDxiq0AZZ
	 IUDP7AytyIngusJ8m8gESwdH9s+fpUsqaQ6RZ/rDDqjYKnvUpqIxRbLZT8/MTyQzSBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jF2H+zPL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B6606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jF2H+zPL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585251F008A1;
	Sat,  7 Nov 2026 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049304;
	bh=4w+TcZeULr7wIKlQA9OLedqHyQ5ko5wp3fc82OJ5t/k=;
	h=From:To:Cc:Subject:Date;
	b=jF2H+zPLQe5/bcytqmJvt4e4KDLrj59kkejsbuGFaAHBVe7HqtW6umuLA6JwiPkmE
	 gH+7TbhMQjwzguOquZhmayo4VHsYi2fbKC3fvelkKC/He8JPaojAcZy76CvL8NVURP
	 x6Mj2602EGikMdEEVcotqID2EHZaqb/hMpNJeQH5z84hyL+FIAuAENw7ifxP+Ee7aA
	 utQkwDMG0GEoD8PDIxFc1cyWKUS0FSc0Qg1o2UPRu44k/sqOD0+PoDLiZ6GpLJtlx0
	 GS3IBe8L4TVdJdusHOXJodOECSoh3H2ZxQZ25ZJpR/KBclxBkiNzRxJhVwbVbM0oEX
	 SUBRsjP70KKnw==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-v3: Roll back assignments from the new region" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:43 -0500
Message-ID: <20261107060142-failed-5.15-a32c01324eb4@kernel.org>
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
git cherry-pick -x a32c01324eb494dda811912eb847b0e907cd7270
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060142-failed-5.15-a32c01324eb4@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a32c01324eb494dda811912eb847b0e907cd7270 Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Mon, 31 Aug 2026 10:10:02 +0200
Subject: [PATCH] KVM: arm64: vgic-v3: Roll back assignments from the new
 region

A failed REDIST_REGION write unregisters the redistributor iodevs of every
vCPU processed before the failure. This includes vCPUs assigned to older
regions. Their assignments remain cached, so a retry does not register the
iodevs again.

The vCPU whose registration fails has no assignment to roll back. For vCPUs
processed earlier, limit rollback to those assigned to the new region. The
region is removed on failure, so its free_index does not need restoring.

Resetting assignments from older regions is unsafe because a vCPU can own
one before kvm_for_each_vcpu() can see it. Rollback could then move
free_index behind that live assignment.

kvm_vgic_addr() holds slots_lock across the REDIST_REGION write. vCPU
creation takes the same lock before assigning a redistributor. A concurrent
vCPU cannot acquire an assignment from the new region before rollback
completes. The lock also keeps rdreg valid across the config_lock drop
required by MMIO-bus registration.

Fixes: c011f4ea106b ("KVM: arm/arm64: Check vcpu redist base before registering an iodev")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Link: https://patch.msgid.link/20260831081005.41346-3-kmehltretter@gmail.com
[maz: moved helper into the sole caller]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 8fb0a3eb3457d..5ab789accc9d4 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -846,7 +846,8 @@ void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
 }
 
-static int vgic_register_all_redist_iodevs(struct kvm *kvm)
+static int vgic_register_all_redist_iodevs(struct kvm *kvm,
+					   struct vgic_redist_region *rdreg)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long c;
@@ -866,7 +867,14 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 
 		for (i = 0; i < c; i++) {
 			vcpu = kvm_get_vcpu(kvm, i);
+			if (vcpu->arch.vgic_cpu.rdreg != rdreg)
+				continue;
+
 			vgic_unregister_redist_iodev(vcpu);
+
+			guard(mutex)(&vcpu->kvm->arch.config_lock);
+			vcpu->arch.vgic_cpu.rdreg = NULL;
+			vcpu->arch.vgic_cpu.rd_iodev.base_addr = VGIC_ADDR_UNDEF;
 		}
 	}
 
@@ -975,10 +983,13 @@ void vgic_v3_free_redist_region(struct kvm *kvm, struct vgic_redist_region *rdre
 
 int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 {
+	struct vgic_redist_region *rdreg;
 	int ret;
 
 	mutex_lock(&kvm->arch.config_lock);
 	ret = vgic_v3_alloc_redist_region(kvm, index, addr, count);
+	if (!ret)
+		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
 	mutex_unlock(&kvm->arch.config_lock);
 	if (ret)
 		return ret;
@@ -987,12 +998,9 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 	 * Register iodevs for each existing VCPU.  Adding more VCPUs
 	 * afterwards will register the iodevs when needed.
 	 */
-	ret = vgic_register_all_redist_iodevs(kvm);
+	ret = vgic_register_all_redist_iodevs(kvm, rdreg);
 	if (ret) {
-		struct vgic_redist_region *rdreg;
-
 		mutex_lock(&kvm->arch.config_lock);
-		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
 		vgic_v3_free_redist_region(kvm, rdreg);
 		mutex_unlock(&kvm->arch.config_lock);
 		return ret;
-- 
2.53.0




