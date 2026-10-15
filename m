Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095948CD64;
	Thu, 15 Oct 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058746; cv=none; b=KXlNf7OzaNYfrwZAgmRHAqKXurHHdADaf2s7mpkSigX1MR7Qpux19qEw84/B38/nhJLoZcOv3XjomT9sZSAulrIFI6LOh3FwnSuiFb5lo9/Fdi+IhBe6TbkaouzreXN2Y9fpxmQfez9JS/uo9JQiEs1ji09EKOPsaskMASDwGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058746; c=relaxed/simple;
	bh=knzTx/me3bvPcPv2wOCm15+VaykGUxquRNGyyfPcLo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faOVQ0eDnQDRgenR/adVJaTWUZhD9WdqCalniNx3dYsQhCjdPZ9JlosY4fybB4waJ8Us9vuiStyN9o15tLCyIhDs7z6hD6sdDFNlpbGfZWJ8K0woMY2oBze5qCbMxnTKDqYcNlAk2CZ9S7EQDaNg8j9WxHGYl6m9DSTiU8buQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMvC8hbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMvC8hbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF60A1F000C4;
	Thu, 15 Oct 2026 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058744;
	bh=BmnveEK/Au4BHKu6rYCY9uow2IlDD6JSmyT+v9bH2+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMvC8hbTwx35EDF1mfYnZMdo12CxUa7ruvuP3Y82mmlRf6nW6YymuR6Tcy/Mb+npJ
	 CHumy45pKLe7eTkZD4qaRuk/a2rhffK7JFuUmnfV8gv1xl4VZ4lXPKg2XxCXeTmAyw
	 qtMzXlKyEOYuBJNBCxoLSZJZez86ilTsB+I2oVqH9ZbF9f9yhMSLgRcvr+xFSv387k
	 VlmBWreq16FdrJWJUr1jcoJcJl7AXEbfPAR5Jxxp5VSPndhPOgWssiqOs/2LPbFMIY
	 btqLsBM9oHjv2rBGf6IV4QQNKic5jGO+bJhgBxwt4ZQcyVt/jBPUiyvzCPP7QI5PAy
	 i/ZzSYYuUFaKw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xHILG-00000003EfK-40ru;
	Thu, 15 Oct 2026 10:05:43 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved
Date: Thu, 15 Oct 2026 11:05:34 +0100
Message-ID: <20261015100539.1011760-3-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015100539.1011760-1-maz@kernel.org>
References: <20261015100539.1011760-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

OUTSIDE_GUEST_MODE indicates to the rest of KVM that the vcpu has
exited. So far, this is set as soon as we return from the notional
hypervisor (which with VHE is just a function call away).

However, code that uses OUTSIDE_GUEST_MODE as a synchronisation point
relies on the vcpu state to have been written back to the in-memory
structures. Clearly, this is not what is happening

Move the publication of OUTSIDE_GUEST_MODE to the point where the state
is actually written, and give this write release semantics to ensure the
correct ordering.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/arm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 73706464d2653..8b46fafdd3494 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1334,13 +1334,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 
 		if (ret <= 0 || kvm_vcpu_exit_request(vcpu, &ret)) {
-			vcpu->mode = OUTSIDE_GUEST_MODE;
 			isb(); /* Ensure work in x_flush_hwstate is committed */
 			if (kvm_vcpu_has_pmu(vcpu))
 				kvm_pmu_sync_hwstate(vcpu);
 			if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
 				kvm_timer_sync_user(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
+			smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
 			local_irq_enable();
 			preempt_enable();
 			continue;
@@ -1356,7 +1356,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		ret = kvm_arm_vcpu_enter_exit(vcpu);
 
-		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->stat.exits++;
 		/*
 		 * Back from guest
@@ -1390,6 +1389,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		kvm_arch_vcpu_ctxsync_fp(vcpu);
 
+		/*
+		 * All the state has been synchronised, let advertise
+		 * we're outside of the guest.
+		 */
+		smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
+
 		/*
 		 * We must ensure that any pending interrupts are taken before
 		 * we exit guest timing so that timer ticks are accounted as
-- 
2.47.3

