Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE767384258
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551140; cv=none; b=pTeIYKE6HnRDEnPsQQTvwB9ML0kcneLbb2AK/RtLaQLiOqWudB20oeHJOlswQYLFgDdMxMAHa1RhE2QjLIYtXMl/Q0OKBnVxAKx4GQL2txTbI+5DqD/kFgKA7PBHlx8sH8J3sRLQ3X8hL9qbRGURMh7dIgZZc72G3ZRe+XIjCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551140; c=relaxed/simple;
	bh=E+z0mSY99NzfjH7XlauQzJBh4gqBbtEbX4/+lWjFsGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JO6dIzCT566XYDjcNyg4kCxieepYHFb8/tSo/fqye51FwcGBwW+Jb25tlt2yc8fSzWwbE2AtWDwTngb1m5mJL7Pe8hYAtCFamFgPTGK1VEcp1l7ksobrl3Ph5gkg787zvRkhte39/u7mJjrexAd3xDCCb2apAICwDE++wg7LrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWkgMq81; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWkgMq81"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7eb60cfd476so277859a34.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783551132; x=1784155932; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYbxzb3UFNoiytOECv3hgns4dgvMX5WmqlL/nKi0B9I=;
        b=bWkgMq81vnOaY7I6sS1qIAULwI9RWtcWj2zbGRw2JroNPyou3+tJTiD3KiDtsPqKM+
         8LAvHc1wYj52+3QXykBwSVfILpXk2YJf4ytl7FCwBaPA95JsILj28BW4BQztI4PqWywc
         zV8/rw2w+WSvlKwMMrRhqwmgLNVlcOrJSb4z00lLoIeg45bw4FfFKDJRmADc4ub6gU1m
         jHCSHbfvE0SxnHPxO64J5/2My6vfpMR4ZCjc36HyMrNDHReuFsPNIqQHyEVz6pQa8dBs
         gGMY/T0DwQgv9Kri/C/qm8mN5jsadfAkRoqQXhOU9cTRsxlqq1vCorY/wETtgdXV4Eq+
         al9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783551132; x=1784155932;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYbxzb3UFNoiytOECv3hgns4dgvMX5WmqlL/nKi0B9I=;
        b=aNXeTFpBbgLnaRt6aAy/yeJmVe9xNJ1SNU7xVUvL7KcFUdTTUGpcpJNWwOB7hLMWyi
         g2j27Kgd1rYlzgbLJ0yNAf007jN01xDxL2MO4Auq6xlKFcWeSFWSr3EO5Ajh90SRtP/y
         eHGSBPOBVL4PDFXb0b25CmrHAMClVfcbpa6AoFzhtlZZobBeMRbhDomXNfJ9JO4mU8Y9
         pyYGasrJ33JmNdtV7DmtBoL8Tmt9w2PCOwvk/U0fvZ9DHECh3PxeRSt7Kr5K03u90ZHC
         xTce/k3lKmb1PRRZJ7DnsY8Wr53h6uiNhwJJz5uq0fxE+me7Xk5iEDNnOXjrOSX41nGP
         RuNQ==
X-Gm-Message-State: AOJu0Ywsi0kNl1Ba3AYpw2ojiYvOLnxUusvPSwouK9AsHW+3/TBRhqBn
	FsvRNIksJmqzO9fD4zxkBklby/+FpvwdOUEecC8e2oiD0typDKM8zKuwhEIqMwBCclGtbY8Y/Gw
	XplQmUfNXB74LolGKl+D7BW9Coy4HSpF21HqbdMxwI2X7sA80FH434PJ1rjOZeR8Cm4HMlHFsc7
	PLHNecu1um7X8dPIRf39i+1G1p6ssmwoxf08qgVVEhAO38Lt5ri7i/ykFZNPKEQRE=
X-Received: from ilmt14.prod.google.com ([2002:a05:6e02:10e:b0:503:bd20:d827])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a4a:e910:0:b0:6a1:53a0:5330 with SMTP id 006d021491bc7-6a36d971080mr3288768eaf.16.1783551131404;
 Wed, 08 Jul 2026 15:52:11 -0700 (PDT)
Date: Wed,  8 Jul 2026 22:51:22 +0000
In-Reply-To: <20260708225124.4130846-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708225124.4130846-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708225124.4130846-5-coltonlewis@google.com>
Subject: [PATCH 6.6 v2 4/6] KVM: arm64: Initialize HCR_EL2.E2H early
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

