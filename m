Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049608;
	b=Ws10DXnN+yIMOMalAZtdU1GFpFYhTGzKBgdjyeKJmKOeB+oCgaTvlOqrp3lVLir+73QA
	 +zU9tLJWaPOJZ5LPfz8w5Pi+7CUAxcFfO+7fQ/+2cc9ZQ3AsNashpPuAjFu1SQK0psRY/
	 XMFUU4LEWFcWZ4w/lB0ui0uMMkDUmM+gnIYvfrKFz+gzJpWfB9IIME4JdlNuA3VeB1a7f
	 iUngJVSIHk8A/nypiPNI3viRu6wx/spsPTLBrBqmBmOiIgL5Bk+f1c0L4NikDga6ma8V3
	 pIln3oZQMwVNB/g+kIaUuwtUFpZLLXXAjjRimFrYMGo0b2+44mHy1pGF2sdx2w8MOiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=efTSjZ3Lig8auLmF6ZhZlprsUnLI6ikjZFss1pi1zQY=;
	b=xYH+qf/ZcS0LiACt21XsW5K3KBtEXHfKkV8I/dqmW9XswG1BPZdS4LOsdSeupp33Ibcj
	 Asak/bBFmQq8qv7gNHPehYG+6X7HZp0wvR8HDil5wRysg8G/Fag3NazHvi9owD1twsYEe
	 Ld9Nr8w2NZNc2njfWuDkJi3qzEThJBKqSfRvO3OwelA33rzo8xC3pLzt8WhT9Qe7dAun6
	 uHufJCLvDqNrA7C/7RpaJF6tRN5dGELxHRPf98ipUnGywUVA04bSstGi8X94Vcaz6Rhx/
	 GkSoNJRFtguPOCWy40DCrYJHC+Dr+q0Zr8nN+oLxcdQj0IXE5fKz5RFUMva8lE/70NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gRb4jqNu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15428606D82A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gRb4jqNu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873791F0089F;
	Sat,  7 Nov 2026 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049607;
	bh=efTSjZ3Lig8auLmF6ZhZlprsUnLI6ikjZFss1pi1zQY=;
	h=From:To:Cc:Subject:Date;
	b=gRb4jqNuTqMWJUclI1TDvG36A+za4Boyl8b+F83rGsYuHlT46IuzanAW9K7XPkbYb
	 GzIZhSSff1gAYa349zcOf1WHslWTr7XjfHwzcGZhxfobYse3+Xe+q3DtDe4t+dROWL
	 A5WXfygK37RNhPbCNMdwgic8iZNrC/KtJ4DHQx4/nf6CbbM3bnjsvW+XXDWTFbj7xm
	 xCa5oTEdo35DpXW/FfpupeqRO4+4KuvxxNlZglUkEhnGUPsKQ7/79CX5mSwEmm8MMe
	 4dyvEDu4G/JJLPvo3I1Vt/LAdGdbDQd6ok+oGzd6zo3HPF4ZusNoPi4e0aPoJm8ian
	 uiPYLHJqeyZcw==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:06:46 -0500
Message-ID: <20261107060646-failed-5.15-22b6557ad05b@kernel.org>
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
git cherry-pick -x 22b6557ad05bf05c73246f62c19af3e04017270e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060646-failed-5.15-22b6557ad05b@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 22b6557ad05bf05c73246f62c19af3e04017270e Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:35 +0100
Subject: [PATCH] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded

IN_GUEST_MODE is advertised too late, when state has already been moved
onto CPU registers and cannot be observed by another CPU anymore.

Move the IN_GUEST_MODE publication ahead of the state being loaded, and
immediately check for pending request. This ensures that there is no
window of opportunity for another CPU to observe OUTSIDE_GUEST_MODE and
yet for state to be loaded.

This also simplifies the "state rollback", which solely amounts to
synchronising the timer when no irqchip is present.

Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261015100539.1011760-4-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/arm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7ce9f3bfa7fff..cadc82ba5a5a0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1321,31 +1321,33 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		local_irq_disable();
 
-		kvm_vgic_flush_hwstate(vcpu);
-
-		kvm_pmu_update_vcpu_events(vcpu);
-
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
 		 * interrupts and before the final VCPU requests check.
 		 * See the comment in kvm_vcpu_exiting_guest_mode() and
 		 * Documentation/virt/kvm/vcpu-requests.rst
+		 *
+		 * Requests to self must be posted before this point, or
+		 * won't be taken into account until the next exit. No state
+		 * loading other than what happens at vcpu_load() time can
+		 * be done before we have checked for pending requests.
 		 */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 
 		if (ret <= 0 || kvm_vcpu_exit_request(vcpu, &ret)) {
-			isb(); /* Ensure work in x_flush_hwstate is committed */
-			if (kvm_vcpu_has_pmu(vcpu))
-				kvm_pmu_sync_hwstate(vcpu);
 			if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
 				kvm_timer_sync_user(vcpu);
-			kvm_vgic_sync_hwstate(vcpu);
 			smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
 			local_irq_enable();
 			preempt_enable();
 			continue;
 		}
 
+		/* From here onwards, we are commited to entering the guest */
+		kvm_vgic_flush_hwstate(vcpu);
+
+		kvm_pmu_update_vcpu_events(vcpu);
+
 		kvm_arch_vcpu_ctxflush_fp(vcpu);
 
 		/**************************************************************
-- 
2.53.0




