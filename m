Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A43B635F
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636641; cv=none; b=PyRN7V9ttky+yvPYxd6yP+tXJZq9BwbbMvW4DajYTL83l1i9UArF7rfTssPI03y3tQdW9Zz9IS/pLf1dKG7Y1oiTMKowO+0t+kX318WO9Ie7GDFV6f/+M86FeRaaBeLb4fAQRrptSZmdF0vSr5et/wSXZBC2ir4KaPN6sSmqUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636641; c=relaxed/simple;
	bh=WdOyXOJs/f3tVNJI0K+pSdMM4nDPAMKEFPXoJrBf+mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n/ni6E48FapIS/pugXyCUy/rhaBAcML5hZOmPs/gPsoJioI1dxoSEDPMP/Zk6KnhujNlMcsISFKcFsfIjTc9S/URDXikyQXdMM+HkWaXdQdfF1zkz45FO7gcRUiA8BpDNN4EkmCQHY5U575Lsw98P5sbwGkSBZZ4BwxbakyWx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aK24pL6o; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aK24pL6o"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-43b6de00772so149232fac.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783636638; x=1784241438; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ty5ADPWIKqd8Px0gGtRTP0jl6mErohylK4VL5tgWduw=;
        b=aK24pL6oL26nfj5UDtE8yRM13EjdD4qX+MXh+q3WAMB3RxrButVfxFr17nxOfABxA1
         kpzrVj0jFqiZLkFLiv+LnZNziRzx/GIzrGervVlXGAyUJxCaTeIoJeueGY+9HE027uGE
         hZSLVJqiWzFDE2yMlruzjI9ClYV0Q98Z0Qn0oaWVdEqfBWiVzG3Bgn9oSSlZZDDoE4aK
         WwhxjhlX4ae0cGsckcrg7abS3k0zjCo9wxTYtUQsS8WoBoinuL9TZsSI/aLUGaeIYMqJ
         HgUML2xJgDWmvoC7TFvCHRSUAvO2FwJXWyChQ+Jnluw1tyAUI7PgYal9fPTY7ml5NGAp
         o0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636638; x=1784241438;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ty5ADPWIKqd8Px0gGtRTP0jl6mErohylK4VL5tgWduw=;
        b=hHo7z4IIdlegeGAl5rNP74vk/SyzlEta7Ubj27Z/5RaHBdHmF4hdMtyPHGyVyxVUsW
         sOUfwXEn2bodx6qH5Ky71DBkV8cQJ6GCHM8xU5lgOw7722U9WsPdxicfLr4kzaK6ZqKy
         fytLqGV908yPefoolpWCLwg7MH4KYS1lON22vUz98RGdJxUq5o0F/ScJ/xeYG0yV30qC
         Brek487rmiwsyF7BnTL7xzZhg8ZtJKNjrrVeeQUiv3Nl5SP1YUbu02Vw3MNMY4LOWipB
         JAZgqDdWiK9sJ5wkPLoRJeSTbqMf6FCd3QKuzpo9jAxLsjVM/4LM+L+QS/gPiAuFQcuQ
         O8Pg==
X-Gm-Message-State: AOJu0YzS1NQogjC23R3UzfqY1Fl8sd0kAj1sDHH9gDF+kiYrRz7CtjTa
	Jt6f1FrQ479lu70485VKmcNK958pBYZ4XPxPjvfFbJMCgiYbUCWPhyr/HQ1cWWG42hmbNV6hd97
	MyXGCmCKtjuIXUAoOOVXBOEJ3AJRJecZda5nkdRpouXXKiTcmQo0udm3rroIYI0fTaOusBJQqWB
	O/Pc3XeE0zuis29vG6jhtiybWGSUq1vrSSqGha67RFVaXC1tL6iKDNG/3fC43/Evg=
X-Received: from ilsj14.prod.google.com ([2002:a92:ca0e:0:b0:502:28a2:9963])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1308:b0:496:10e9:7627 with SMTP id 5614622812f47-4a202004393mr6764891b6e.9.1783636637765;
 Thu, 09 Jul 2026 15:37:17 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:01 +0000
In-Reply-To: <20260709223604.12934-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709223604.12934-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709223604.12934-5-coltonlewis@google.com>
Subject: [PATCH 6.6 v3 4/6] KVM: arm64: Initialize HCR_EL2.E2H early
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ben Horgan <ben.horgan@arm.com>, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 7a68b55ff39b0a1638acb1694c185d49f6077a0d ]

On CPUs without FEAT_E2H0, HCR_EL2.E2H is RES1, but may reset to an
UNKNOWN value out of reset and consequently may not read as 1 unless it
has been explicitly initialized.

We handled this for the head.S boot code in commits:

  3944382fa6f22b54 ("arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is negative")
  b3320142f3db9b3f ("arm64: Fix early handling of FEAT_E2H0 not being implemented")

Unfortunately, we forgot to apply a similar fix to the KVM PSCI entry
points used when relaying CPU_ON, CPU_SUSPEND, and SYSTEM SUSPEND. When
KVM is entered via these entry points, the value of HCR_EL2.E2H may be
consumed before it has been initialized (e.g. by the 'init_el2_state'
macro).

Initialize HCR_EL2.E2H early in these paths such that it can be consumed
reliably. The existing code in head.S is factored out into a new
'init_el2_hcr' macro, and this is used in the __kvm_hyp_init_cpu()
function common to all the relevant PSCI entry points.

For clarity, I've tweaked the assembly used to check whether
ID_AA64MMFR4_EL1.E2H0 is negative. The bitfield is extracted as a signed
value, and this is checked with a signed-greater-or-equal (GE) comparison.

As the hyp code will reconfigure HCR_EL2 later in ___kvm_hyp_init(), all
bits other than E2H are initialized to zero in __kvm_hyp_init_cpu().

Fixes: 3944382fa6f22b54 ("arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is negative")
Fixes: b3320142f3db9b3f ("arm64: Fix early handling of FEAT_E2H0 not being implemented")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ahmed Genidi <ahmed.genidi@arm.com>
Cc: Ben Horgan <ben.horgan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250227180526.1204723-2-mark.rutland@arm.com
[maz: fixed LT->GE thinko]
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ Backport: Resolved trivial conflict in arch/arm64/kvm/hyp/nvhe/hyp-init.S
  caused by __kvm_init_el2_state not existing in 6.6.y (EL2 state is initialized
  inline via init_el2_state / finalise_el2_state); placed init_el2_hcr 0
  directly before the inline sequence. ]
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/el2_setup.h | 26 ++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 19 +------------------
 arch/arm64/kvm/hyp/nvhe/hyp-init.S |  2 ++
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b7afaa026842b..3498dc5d02c18 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -16,6 +16,32 @@
 #include <asm/sysreg.h>
 #include <linux/irqchip/arm-gic-v3.h>
 
+.macro init_el2_hcr	val
+	mov_q	x0, \val
+
+	/*
+	 * Compliant CPUs advertise their VHE-onlyness with
+	 * ID_AA64MMFR4_EL1.E2H0 < 0. On such CPUs HCR_EL2.E2H is RES1, but it
+	 * can reset into an UNKNOWN state and might not read as 1 until it has
+	 * been initialized explicitly.
+	 *
+	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
+	 * don't advertise it (they predate this relaxation).
+	 *
+	 * Initalize HCR_EL2.E2H so that later code can rely upon HCR_EL2.E2H
+	 * indicating whether the CPU is running in E2H mode.
+	 */
+	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
+	sbfx	x1, x1, #ID_AA64MMFR4_EL1_E2H0_SHIFT, #ID_AA64MMFR4_EL1_E2H0_WIDTH
+	cmp	x1, #0
+	b.ge	.LnVHE_\@
+
+	orr	x0, x0, #HCR_E2H
+.LnVHE_\@:
+	msr	hcr_el2, x0
+	isb
+.endm
+
 .macro __init_el2_sctlr
 	mov_q	x0, INIT_SCTLR_EL2_MMU_OFF
 	msr	sctlr_el2, x0
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index e0e710b36da37..ff7769821166a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -575,25 +575,8 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	sctlr_el2, x0
 	isb
 0:
-	mov_q	x0, HCR_HOST_NVHE_FLAGS
-
-	/*
-	 * Compliant CPUs advertise their VHE-onlyness with
-	 * ID_AA64MMFR4_EL1.E2H0 < 0. HCR_EL2.E2H can be
-	 * RES1 in that case. Publish the E2H bit early so that
-	 * it can be picked up by the init_el2_state macro.
-	 *
-	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
-	 * don't advertise it (they predate this relaxation).
-	 */
-	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
-	tbz	x1, #(ID_AA64MMFR4_EL1_E2H0_SHIFT + ID_AA64MMFR4_EL1_E2H0_WIDTH - 1), 1f
-
-	orr	x0, x0, #HCR_E2H
-1:
-	msr	hcr_el2, x0
-	isb
 
+	init_el2_hcr	HCR_HOST_NVHE_FLAGS
 	init_el2_state
 
 	/* Hypervisor stub */
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 1cc06e6797bda..3efa9cfaa9d48 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -202,6 +202,8 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
 
 2:	msr	SPsel, #1			// We want to use SP_EL{1,2}
 
+	init_el2_hcr	0
+
 	/* Initialize EL2 CPU state to sane values. */
 	init_el2_state				// Clobbers x0..x2
 	finalise_el2_state
-- 
2.55.0.795.g602f6c329a-goog

