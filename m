Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBD53BB681
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636642; cv=none; b=oL5dFdmOVoIpI153Ad0eyCX/xZks3qRHp4KfWjN9BB0r54zWu4LbhsRmecPhH+k7K4fmlp2oW668mOVZJK20ilG5mn+EgBgeC4iUiwAd+GbLJaSztX0dIpU0mGfwCH9MYNjxHY0N1Uyg4b4fkFANNxpujJ1YKDh9s7JuLys3NZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636642; c=relaxed/simple;
	bh=qWW0samGfe5E/4ZqJapkRBjspn06LXjiv9cwPGxOjb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OyqJQS0l29+hUaj2HghpPiYY0b6Sutbx8BhUGhFI9oYw+SgC+SJfUk39TWlfECNWLTlZ1COxZDdOsHQtd9HxitSkipjCkS9nMvf/PiPcNzGEgpJkphk3CaLxZEPlUSfotEtdznfVUZNbJGio+8nJj7oSUSqteKTtVHcPns52ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hN3npKn8; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hN3npKn8"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-4413ecf22a0so215075fac.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783636639; x=1784241439; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+WyHlE4oxu8xuOxQGOIEBY4bo4OikBdt2+d9yKecQo=;
        b=hN3npKn8FRgwAuQAw/8rAKfeyvUVMpt3z4Idwii/dEDT7SBHWVBi1y+UG0oJHEgifZ
         B1S0C8OPCcqjiqoNdXmYxNHyRX5T1CgE+hmIrOXBcKOxap8tLZCY8Bqqm+JJ2iT1LI7x
         8Y9CSwAxAc4FpndPZeQkBLHXfcxNOEZ1trrRQBuSc4srpcAXaLqo/D6vUkSc7mQsjMQE
         F57Oz3IwMZoDDlgYBfrgH0P3wAxBCwHe0fLMrNaL3snnTlfypRqiGe3xajz7MuGlPcsQ
         pDKmzaUYZOvytcwh9b+X4U3qSfTIj4aHSLcLY++vaujZzZ5CNBLdG4ebyEb8+VZyUVxT
         meDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636639; x=1784241439;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S+WyHlE4oxu8xuOxQGOIEBY4bo4OikBdt2+d9yKecQo=;
        b=N065xBrOo+q1uui7P9uCvtzgLobAxr9IhFdfxplFnt6dOwK0NtSNqO7Aqjs7ULx4PV
         KVQJXt26FB3Em6JULHA/QTEm17Gg4qikdiuct1YJJ4HGn3rT6JyX+jeTmBrUdKgXwFpH
         FWbQxwg3Pw8293vLWcz2AdZk5bK9Kah/kqzul4t4K9Q9MUojiAS7x+k638cMXlReHKiM
         LIiz+sMBW6K958xpQivNxbhgGOwhCMFiNxure4uwB0va08OThcegSxg5LzmwUUDGILrK
         yi1dJ/nv5eu2bUl9UHjqcC5LQAa3Yndz9ayicXrqhkiUbcpJ2E8cAnJvZIrMqBmFX14Y
         4f9A==
X-Gm-Message-State: AOJu0YziuhUkGoCVOrafqbO7lRc/n+ftyf7PVzayxkP15zYJO0XhkZIx
	G28iteo0s2JTO+queBzHHfoZsDtDF+i48L/eIm362i6URzaOSd0zBsIIh7xotYgF6Ko8wXPBBI3
	4hqHfC3B/maSvKbhru850BhcgNH6mOM3XhefJgCvUVGEhnXnZkjx8FQId2YjimU/TFNrWDAHS2b
	r/CqT6yb4Hm6AcGNFaDlB1uYItqozogRmY0UVBRldkvhyst3gdn0D2ArRFcc6KLvA=
X-Received: from jabms16-n1.prod.google.com ([2002:a05:6638:e050:10b0:5e7:2c1b:b294])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4d01:b0:4a3:2bd1:5218 with SMTP id 5614622812f47-4a32bd160fdmr4018778b6e.20.1783636638778;
 Thu, 09 Jul 2026 15:37:18 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:02 +0000
In-Reply-To: <20260709223604.12934-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709223604.12934-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709223604.12934-6-coltonlewis@google.com>
Subject: [PATCH 6.6 v3 5/6] KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()
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

From: Ahmed Genidi <ahmed.genidi@arm.com>

[ Upstream commit 3855a7b91d42ebf3513b7ccffc44807274978b3d ]

When KVM is in protected mode, host calls to PSCI are proxied via EL2,
and cold entries from CPU_ON, CPU_SUSPEND, and SYSTEM_SUSPEND bounce
through __kvm_hyp_init_cpu() at EL2 before entering the host kernel's
entry point at EL1. While __kvm_hyp_init_cpu() initializes SPSR_EL2 for
the exception return to EL1, it does not initialize SCTLR_EL1.

Due to this, it's possible to enter EL1 with SCTLR_EL1 in an UNKNOWN
state. In practice this has been seen to result in kernel crashes after
CPU_ON as a result of SCTLR_EL1.M being 1 in violation of the initial
core configuration specified by PSCI.

Fix this by initializing SCTLR_EL1 for cold entry to the host kernel.
As it's necessary to write to SCTLR_EL12 in VHE mode, this
initialization is moved into __kvm_host_psci_cpu_entry() where we can
use write_sysreg_el1().

The remnants of the '__init_el2_nvhe_prepare_eret' macro are folded into
its only caller, as this is clearer than having the macro.

Fixes: cdf367192766ad11 ("KVM: arm64: Intercept host's CPU_ON SMCs")
Reported-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Ahmed Genidi <ahmed.genidi@arm.com>
[ Mark: clarify commit message, handle E2H, move to C, remove macro ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ahmed Genidi <ahmed.genidi@arm.com>
Cc: Ben Horgan <ben.horgan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Link: https://lore.kernel.org/r/20250227180526.1204723-3-mark.rutland@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ Backport: Resolved context conflicts when removing the
  __init_el2_nvhe_prepare_eret macro and invocation:
  - arch/arm64/include/asm/el2_setup.h: conflicted because 6.6.y lacks later
    GCS/MPAM macros (__init_el2_gcs / __init_el2_mpam) surrounding the definition.
  - arch/arm64/kvm/hyp/nvhe/hyp-init.S: conflicted because __kvm_init_el2_state
    does not exist in 6.6.y (EL2 state is initialized inline). ]
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/el2_setup.h   | 4 ----
 arch/arm64/kernel/head.S             | 3 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   | 1 -
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 3 +++
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 3498dc5d02c18..76b0d50d286d5 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -229,10 +229,6 @@
 .Lskip_fgt_\@:
 .endm
 
-.macro __init_el2_nvhe_prepare_eret
-	mov	x0, #INIT_PSTATE_EL1
-	msr	spsr_el2, x0
-.endm
 
 /**
  * Initialize EL2 registers to sane values. This should be called early on all
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ff7769821166a..9996029853d23 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -601,7 +601,8 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	sctlr_el1, x1
 	mov	x2, xzr
 3:
-	__init_el2_nvhe_prepare_eret
+	mov	x0, #INIT_PSTATE_EL1
+	msr	spsr_el2, x0
 
 	mov	w0, #BOOT_CPU_MODE_EL2
 	orr	x0, x0, x2
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 3efa9cfaa9d48..9b2ada54be538 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -207,7 +207,6 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
 	/* Initialize EL2 CPU state to sane values. */
 	init_el2_state				// Clobbers x0..x2
 	finalise_el2_state
-	__init_el2_nvhe_prepare_eret
 
 	/* Enable MMU, set vectors and stack. */
 	mov	x0, x28
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index d57bcb6ab94d2..5688a16e2ea75 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -218,6 +218,9 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 	if (is_cpu_on)
 		release_boot_args(boot_args);
 
+	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
+	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
+
 	__host_enter(host_ctxt);
 }
 
-- 
2.55.0.795.g602f6c329a-goog

