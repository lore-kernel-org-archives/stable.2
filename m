Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050638;
	b=2KU1qpkLVnasdphgzau8tnoIs/MDUzo+APHrxxRyJXQIn6qxKgMI38E474jnelwFkblG
	 akg8AhTuedI3RWqmjl9u5nIG7GgkzaMK314zmekk9rUpC6VLjFI1RIxfVYVu+FmuBHR73
	 lgzCijGYpqFWEKtasqiCabICGwAZsRKJcVxFZdKl4XfrMwZPSgqXr4qvd66jC9XQQtQP5
	 WI6D3Cw1JsJpjfO1uFwtTFz/PjobMZU9mIJp2KAPDpJ0GZB+keRyiaHDe+8JN3NqdK38H
	 S4swOf1j1NoJG5joL5hFJVzuuKdQNgpc2xXAd28RktMYJVTIf0odTdjE+HYAkoM/YDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=po5qEd08e1ceieGMteAdsUKYMqJYk97tX4XKuOaxzkk=;
	b=YzDJBkSwpoRa7DhJIr6WS3JGacb1sG1wryvAAl1tc5iBjEQ9IplXZTKBtur4CKMPUaFL
	 267mlBTgi4RV18MnFXJ+09T1g2Nm70H91G5vKeJijMZ3mi9cN8Eqx2ZrhaiSnt/ErGDJe
	 IjuumelaxhTrSLtNNmG/qTnNREb42pWt8cfqXymI26FUoRgeyLiDWGfq4lGy/ptEQzAne
	 3dNs3pcnWYHLtuUKXVDAnqB8PHnjpsTCejTiBCsgyLavxNdBmwGxJ3q/ag9LyLQpoQaO8
	 0ufvumgQUT++YgPE+lP16lEULVkauGELhKKTOX26ehk+rfRGLdAyw8HXLy/3cKo+t2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJeiQhDh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJeiQhDh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87F91F0089F;
	Sat,  7 Nov 2026 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050638;
	bh=po5qEd08e1ceieGMteAdsUKYMqJYk97tX4XKuOaxzkk=;
	h=From:To:Cc:Subject:Date;
	b=oJeiQhDhrjDu8HiNND2cn2GV5Gc0iWbJGu1+F6SdX/Z/iDyODcaFr06/tXdnk4jdQ
	 2Jp6sydUWmiO4lDj7pT0kQrir/D7Wru2i7XtVPDOJTbnMnsht+kMaKNDXs3j4VLhZQ
	 ZqTP2ixdsykBEozXHU3O6wUwY6sdj9PmFCp8mWnDYeAbU7NEM+oiMcGPKFPywcuPfD
	 wx+/xXWfX4+NUqZjkMgcrQYCR84GEAG/+vUzmwd+GYNGrGCBCSGGAK/gu8rfmzQUPE
	 5daCpt8Vab6OjnbnHA4mZnWKZLNClmUnExS9VX4Rt1jeSy5guT2HLnikGhGRiPcyeN
	 1+WcZZRb6feFA==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	oupton@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:56 -0500
Message-ID: <20261107062356-failed-5.10-a1b4bd2c2c26@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a1b4bd2c2c262b8094c86afb99364d16ac08cb66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062356-failed-5.10-a1b4bd2c2c26@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a1b4bd2c2c262b8094c86afb99364d16ac08cb66 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:38 +0100
Subject: [PATCH] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs

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
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d83019..f5bd29fbe3a90 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -303,9 +303,19 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
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
+		kvm_pause_vcpu(vcpu);
 		vgic_flush_pending_lpis(vcpu);
 		vgic_its_invalidate_all_caches(vcpu->kvm);
 		atomic_set_release(&vgic_cpu->ctlr, 0);
+		kvm_resume_vcpu(vcpu);
 	} else {
 		ctlr = atomic_cmpxchg_acquire(&vgic_cpu->ctlr, 0,
 					      GICR_CTLR_ENABLE_LPIS);
-- 
2.53.0




