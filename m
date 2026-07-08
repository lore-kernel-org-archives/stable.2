Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FC393DF1
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551140; cv=none; b=ETDkl3hBVK9OjsnqrPqX/XqAnF6+A3vKPQ3EaAwk7dqXo0KZpNuKfaILCnpOwr9oJTDsSwWURZARZg+L/t7rCpZPL1NgyKcvtQ/v1AtJyGwQM3QuGykQfhY+ftQ56vSh73fcB5FpAdZbH1js8gZj03MH/kvlg7Sstv2JfLI8Ywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551140; c=relaxed/simple;
	bh=lIhEm2wVtEXNQNvGEaqy2EwOqFAEAnqOIu34Qyyuk0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AlJXSbQ0Z6ghiv7USJPmR6WVL9n+yBJNmdKZ/oNFjiBHHxPuQJT6MzouMjr5XvRs6ErmkIXF8JABgP9+SBF6N17to0pa+Z9Q+H0BZ1sAsNQ3/Tm/M3s3Q/WH2otV7X4m3udr37nWEi8wiN95ETMqYcP+7S6Wwxw5CKYTmP4gZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6Z8LYQI; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6Z8LYQI"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-44801afec53so1280208fac.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783551133; x=1784155933; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mutBHrPPn84rf+SwTAASYZI6R7q+QxGKCuZHvQ7HuZU=;
        b=b6Z8LYQIoHhdlG0uY11Qn1ocSIGISnAh1JWCgfaEjAj+f27YYr1yuLaxWZzX+/AQ8l
         LnhGzy4A1BGjwjHiym+odbkkRAzEOlEc67Ti9Wcvdn359wVB5Lr9AC5qIYX/iuwV9NYA
         6hH1XijPxXQzsUfTGIKfPrKiRLKFY5OtIWpD2cNJcdxvAKxd6iroU0tgrt+tvbImQSby
         nfu1P/1Nl3Oetvdxl4gJftsi4ZJciETTexgfxY2E20oohX0kVp0iojBGUDyziQLTzH49
         RAfYmLqk1wowYObBMciiY5Z+DTeSMJ9AG/yLsVS0P5URe4DaJg6J+B9WCBvp0SGwVQyu
         3nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783551133; x=1784155933;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mutBHrPPn84rf+SwTAASYZI6R7q+QxGKCuZHvQ7HuZU=;
        b=qjgEH22aYBNuJG77WEohILKbiaDrwYSgI4xwk5crnwI6qlxkOHE9UwcfnqGDq0/G+I
         0PmH9a3xQHQkzC6uGngSynedyFiHCB0QSajtq9OQx/bT+/wkIUwcZpT0Lju5hWLieqzm
         EiC4BWKhzoQI6hvY9SOKMfP/0xiCUfS8CvegSKmbUANaCeoFMC+LJ6UQrheGmEfufCcf
         lp1mpPgnJpEpP3O++xt0BcfFK8sj3IrtNCrhMvdsR7kpvsbSbUP1bEx56wZhLEcThsNN
         wCcUSUzjThBdKIMlxFhaVjUqbcozsJin23ZZPUNm9ghDAmXva/XS4QR6oyOaWAqqvHQt
         AYYw==
X-Gm-Message-State: AOJu0YxQMMp9tA/c5+KUsnwZSg+ufscP2DTbYvp5cFDhMl5iV2C1RSI2
	FukCoAjlel1NMfkY82z/BS50DkhV51DwKIjhNREW29rbI/Sr5UkiJkmIQA/0ZYMsCDih6copplE
	xvEzRl6ChzhHlJElVjSXpHBwG1gR51mcVp3wTXmtHL8fQ8iKRtZ5Y9NOO3l11WPCrQmaaOwx0ek
	vL7+znNlas3JnvF9iJgg/jIsQ466ZrzMBG0BWpOBKx2SP5hosxxAAjHDdPMFw8CaY=
X-Received: from iltr14.prod.google.com ([2002:a92:c5ae:0:b0:502:eb99:7080])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:c0d4:10b0:6a3:76ab:476b with SMTP id 006d021491bc7-6a376ab4a96mr1122254eaf.57.1783551132443;
 Wed, 08 Jul 2026 15:52:12 -0700 (PDT)
Date: Wed,  8 Jul 2026 22:51:23 +0000
In-Reply-To: <20260708225124.4130846-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708225124.4130846-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708225124.4130846-6-coltonlewis@google.com>
Subject: [PATCH 6.6 v2 5/6] KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, dbrazdil@google.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ben Horgan <ben.horgan@arm.com>
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

