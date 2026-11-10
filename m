Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354047;
	b=JGTXiTJrhTzX3AHedWg6QDimQoLEibDBxO89GZ6PD44MaX/MExe6K3tWxyuZswhLWhtC
	 JAPNC1/AMMxd7ifgGy3B/rENrIIYg75o/6Hg8BhhaSplG0iwS1dALpGg5eJqIlJ9zMVtN
	 bMpw9jaEb3L0AdVyWiWa0MMB3MMsj+40efCsjgjB4+Ls9LzBaoLhpTOdm6lZsKGhfB2av
	 VAhVlE1URGK4F1lNCHDLtD1wclp7YmI0D9HdwnUCGU4xHk8+CRZp8TRCd8a9pcv55xZTy
	 70jGdiEhVSZb5Vn7wDNO9cw2WhZlhITP/yfq4tpHvNxcUh7C9NOR1rJyAu+tflcv/vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=brHWgnXbfENa3Pvi9qjIejV7+Ev4AtYuDj+o15AAsm0=;
	b=15WSR9IMjqx/GXZLTf+0GCYtkhRNqpRZEOjsBVDEDsulqFVmxealf5KGCQg0BfJ5QT9L
	 64CbBKeun3v5G4pqCvdkeAP7FL53RvGMv7axIWXOVStlhgYGsK9q9+Mwun/Gxx42kaKGC
	 9vRdtMnlg7XmH4zms1y0+EJsYo2gJg4Uc8rqYbRRARlyIopGyta7StYQDcdAx1D9RY5Aq
	 cpPZduoEAwxUmM/kuWabnlPKbsXx3gzEP1unuhpn9wW32rcguodIE0wH0UlkuQAawczlB
	 bjXAUYWge81kvroaQjEHrT2J3E6uhXlKbhNdRh1q7xuAfzALf+uVCLIkFU0EFJZZXLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FeH7lwLD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FeH7lwLD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C6F1F0093C;
	Tue, 10 Nov 2026 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354047;
	bh=brHWgnXbfENa3Pvi9qjIejV7+Ev4AtYuDj+o15AAsm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FeH7lwLDg0Xr7GaVVu4WKnac1iVPzbNx2omD33LFUchq5UUu4ITIAGHNhtC+QYQIF
	 RXvT4KqZ/426nbiSH1kOlwIbXE1gv7HovRuMuumnKT928IcYnE0UCWrk9Uzrkja3+g
	 OuVH8zvdSyesstWZNYqq3wTxLF4CbnhEeN90XjHfhKl38Mkshno/rEi3yPMunV4DS8
	 Lf8bAaftrABzseFXkRWbZzynUogfzetLoM2cdbEOVRyAew22oxJqX2fkGJ56PEycXN
	 4GeNYHlWT3+7BLHQ9NffcdhUYsFIIw8M/q3bMoxouGwrImtSXDoIdnqaFhkLbecK8z
	 6peBa/8cNJqUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs
Date: Tue, 10 Nov 2026 18:40:45 -0500
Message-ID: <20261110234025.143830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052303-failed-6.12-a1b4bd2c2c26@kernel.org>
References: <20261107052303-failed-6.12-a1b4bd2c2c26@kernel.org>
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit a1b4bd2c2c262b8094c86afb99364d16ac08cb66 ]

Disabling LPIs is pretty nasty, as it directly messes with the AP list
of the affected CPU, which could be running... This has the potential to
lead to really bad behaviours, and we should not be doing that.

Take example on the way the Active state is handled and simply pause the
the vcpu so that we are sure it is in a quiescent state, and the state be
safely manipulated.

Nobody has any expectation of performance for this anyway.

Fixes: 96085b949672d ("KVM: arm/arm64: vgic-v3: Retire pending interrupts on disabling LPIs")
Co-developed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261015100539.1011760-7-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: replaced missing kvm_pause_vcpu() and kvm_resume_vcpu() calls with VM-wide kvm_arm_halt_guest() and kvm_arm_resume_guest() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 6e157b0b21adf..c62666adc2f8d 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -276,9 +276,19 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
 		if (ctlr != GICR_CTLR_ENABLE_LPIS)
 			return;
 
+		/*
+		 * Yes, disabling LPIs is painful, since it can be done from
+		 * a *remote* vcpu! So let's not take any chance, and make
+		 * sure that the target vCPU has written their LRs back to the
+		 * irq structures, and release any reference they would have.
+		 *
+		 * If it hurts, don't do it.
+		 */
+		kvm_arm_halt_guest(vcpu->kvm);
 		vgic_flush_pending_lpis(vcpu);
 		vgic_its_invalidate_all_caches(vcpu->kvm);
 		atomic_set_release(&vgic_cpu->ctlr, 0);
+		kvm_arm_resume_guest(vcpu->kvm);
 	} else {
 		ctlr = atomic_cmpxchg_acquire(&vgic_cpu->ctlr, 0,
 					      GICR_CTLR_ENABLE_LPIS);
-- 
2.53.0

