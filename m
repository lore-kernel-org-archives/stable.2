Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324572;
	b=w5KkZ0dqJ9cJqveBQjtL9GWAp2PQqHaL+roduCr0CMvPnBi8Nya8/iWBs54XrjQIAgrQ
	 FoT15e6hweK7a7FuIky+5KAF5NvOvy4G3i1TgtBVby4G3PQxCys0jLMhaKORAWfNHgNch
	 zZXoUQqvCWoV8CotnoRfJ1BiWYBppTEoJQv60wIz2pTetbutAKX4msrWTczb/XlPvmCEY
	 ZFliX+wYhh2QCzySJUjS3h4LeFCuQgAFH3Nr1aXWlI7u+27HWlWIrHQu6CT+VdiInOvyv
	 nc4FeKAsc+qWsOLpXEy5Usu2ce9fScQtx1urB0RZuaAVeSiMhqS1OTr+rs19sjnvp5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324572;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w6je1FckbrOrEzrUSitAOSJCqdAxcEqe9CL3wqZ2FjA=;
	b=E8NnwERB+qpTJRzmbhKNgusPoMJA+1AqXK/QhOkD2NnYjOUCwx74fdRTa2NlxZitYjxm
	 aQKXhn23DUrDCbQhi/k+XaHpLWrlgw97/o6WdK5zUEir2SEN5Dvx4n+qOlDC7Zv1aUm21
	 G2Vo6xcCAmXeAAlmSYmHynQVwac5lWZcHzmWutk58ynrwtYFSJ2jrAdO2a8sa9Fz6GXfo
	 m14wwfHmKK8ffFpsQ1xDDrDSU9hXnJh3QXC+tKFleXJXJqgWbn/V68tO9/19NKXg7RoX1
	 Mi1gAFQQdhyQehTOUmnza7prEpHtpM6fvtm02Xl/guyB1tYYkWTn0x5bSrx3SlBuhlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eANDt5r1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79060A5BCC
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eANDt5r1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C251F008A5;
	Tue, 10 Nov 2026 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324572;
	bh=w6je1FckbrOrEzrUSitAOSJCqdAxcEqe9CL3wqZ2FjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eANDt5r14OP5LKTBU+2GP2tGWSS35uLnSisnOdckOYFJb7HbFrcdd9BbNkFyTDEjB
	 5I3xwyVknPxDNKMt0GH2bJtabY9eDx4/AqLdEAlozKXbIbSLQU2OvCKU+lJKqEElUG
	 pi8em8pPa4UkL2BPrttF8j7mUuG4xfXUAe9hXYDnY7ImdnOFYutUOStWkds6GiHyYv
	 cfgH+4t7FbeuliVJ1oDlckk+xqmhRpV6LufCJmSyhoKSwgyzGhB0Ryd0V2q2G6kbCt
	 6LSuUa8mLkpmXWGCTy9qopa6AGJe2I05EzzsvGWfB2cMqn5vbIuApYN4yAZX/SElpP
	 5w0o+RyoY5ZQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: arm64: vgic-v3: Roll back assignments from the new region
Date: Tue, 10 Nov 2026 10:29:30 -0500
Message-ID: <20261110152856.2086590-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060142-failed-5.15-a32c01324eb4@kernel.org>
References: <20261107060142-failed-5.15-a32c01324eb4@kernel.org>
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

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit a32c01324eb494dda811912eb847b0e907cd7270 ]

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
[ sashal: adapted rollback to the existing reverse vCPU loop protected by slots_lock and kvm->lock ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index fd1fa2561520e..e354b1b2d15f9 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -758,7 +758,8 @@ void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
 }
 
-static int vgic_register_all_redist_iodevs(struct kvm *kvm)
+static int vgic_register_all_redist_iodevs(struct kvm *kvm,
+					   struct vgic_redist_region *rdreg)
 {
 	struct kvm_vcpu *vcpu;
 	int c, ret = 0;
@@ -774,7 +775,13 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 		mutex_lock(&kvm->slots_lock);
 		for (c--; c >= 0; c--) {
 			vcpu = kvm_get_vcpu(kvm, c);
+			if (vcpu->arch.vgic_cpu.rdreg != rdreg)
+				continue;
+
 			vgic_unregister_redist_iodev(vcpu);
+
+			vcpu->arch.vgic_cpu.rdreg = NULL;
+			vcpu->arch.vgic_cpu.rd_iodev.base_addr = VGIC_ADDR_UNDEF;
 		}
 		mutex_unlock(&kvm->slots_lock);
 	}
@@ -871,21 +878,21 @@ void vgic_v3_free_redist_region(struct vgic_redist_region *rdreg)
 
 int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 {
+	struct vgic_redist_region *rdreg;
 	int ret;
 
 	ret = vgic_v3_alloc_redist_region(kvm, index, addr, count);
 	if (ret)
 		return ret;
 
+	rdreg = vgic_v3_rdist_region_from_index(kvm, index);
+
 	/*
 	 * Register iodevs for each existing VCPU.  Adding more VCPUs
 	 * afterwards will register the iodevs when needed.
 	 */
-	ret = vgic_register_all_redist_iodevs(kvm);
+	ret = vgic_register_all_redist_iodevs(kvm, rdreg);
 	if (ret) {
-		struct vgic_redist_region *rdreg;
-
-		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
 		vgic_v3_free_redist_region(rdreg);
 		return ret;
 	}
-- 
2.53.0

