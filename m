Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046307;
	b=sDCN96Hrhiua/tI9hfyckFFCZXiyhEqIb84T9fq3fd9SkP3f0JBLsG0btGd0j3zEARiD
	 YYWpWLikAvfXnUUZGlVUi1ejPhZQu8YLTjVoGVm98cr6ahD4n5GCSv9DNMuFwXwFIfuLf
	 3gwEOj13f7WhzC2WAnCA8lN4uKgsep0CKMuztn/lClnC09LmBCX84dJyKPVOlI0oai0I9
	 3NUoYw+hqQciI2+GAhQ6EEJlGzgP6VL9WyYjAL5KBAL35YVy5AbaAFd8QpCU98X7Jodpd
	 c83zi/nMeIySkBmSIQTH603Fjju6lO6tXGXO+/12aSK7SzFettyYTxP0HY19Y1DkEAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046307;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CiVt+et9mZrBLp+liacRjmoh8r+y6ZRzwAe+qlqAcPA=;
	b=4ynF6LBLQYWiObxseTxYN1sLdY7C3cVxPw30z8Ug2+FhOtEBCt34Bxs6NJc6jn9Yh/FG
	 kZ2QiGWhFOvmOH9+MntWw4UKFX+c84JS3vNQKIkIXzxezfXGVL0V4jUNLdL6ghiVNKl9z
	 Uog5DxSImg5vEyH+vGmc3/dvnFk91HQVhybd3ANuxGYgqWH8rOGkcnPHROI3/rO1LTiDi
	 Sy57z5VfnHDvoOI/9Y6Unc1zCjKf4TSXM8X3b5zRBz/EwcaXSqP2B6hzyCcV+AL72qeZD
	 lPJJgB8UGNDQ6f3+1oihV/4IolDRHh3dfc3dEcCZatnhXhSFJMgqC2JBpXkVoKBpbpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWbZn6yS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWbZn6yS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AD81F0089F;
	Sat,  7 Nov 2026 10:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046307;
	bh=CiVt+et9mZrBLp+liacRjmoh8r+y6ZRzwAe+qlqAcPA=;
	h=From:To:Cc:Subject:Date;
	b=bWbZn6yS48cWoKZxrR2uJmGBkR6378+sPtTLLzcucPT30Q/xcHgc+UPvLemWPAg+d
	 j2SQt8xJ/ZQ82h+VHdL2ssDTEOak074H1ZMwkjBnt+8GvvdhPY8WouPyJt9QoFGhf4
	 Ic5N2eJBIrVTA+Et3KX3n3PHixEy7sSkUewnq062oYDYEQ4NvhmRiDMgibg2COppVC
	 R3d951DcP4LQEy31DIA5P2vSZtiTU20yUFcrr61ee09aiWg7Cxn2zJFpMUtjlQIUzc
	 ZC/BxMTFwKyc8qJ2ICrNV9pOzpEpuHGDS4JAFRMCYzlx3S5KB985VOdyW/4C4RhISA
	 eW6MEtyCUY8QA==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	oupton@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:45 -0500
Message-ID: <20261107051145-failed-6.18-a1b4bd2c2c26@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a1b4bd2c2c262b8094c86afb99364d16ac08cb66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051145-failed-6.18-a1b4bd2c2c26@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




