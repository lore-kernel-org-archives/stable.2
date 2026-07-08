Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680638B14B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551140; cv=none; b=mlYXJGtyZQIIq2DLMuRfauB366uVq+KBn3AIj1LRKLOG1Ua+e87kz9bXFF0uXMawVnNUhBW2ofnjaqCc+5gj0zEPTq+A+oMAf30n4CvtooMr2GCPnA3ZPd3wZwHps8334rgj8FYYwE2d9B1lveBuqNZr+Lrt8ZC/vvaGRPG+yJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551140; c=relaxed/simple;
	bh=nUhFMfzpySNDZtLZSUs7iGBvYNcjPGt8shYlgz2wNtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZNqIeBVJcIoMMquRJtmhRE28sbqA2c835HsXyKbVEYgwBvya8vAgClZGqiB0Lfe96gmbQnQo9HDk0laG5qe5vn9j7mQdIhvgAencgTkORMff+vsYLVz/RzTtx0MDkYQnsj8CSrwB7/IY6/C+/M2RUG8lRF+B/lLan1rQk58sqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9afbvFy; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9afbvFy"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-4893fc86bebso1663141b6e.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783551134; x=1784155934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRLBDv0GR5+I5QEs+yagz6DalTxaINze8PKIAjmPSRo=;
        b=E9afbvFyEVMONUp2AKT9TkUB/R1XHvbFpFFN4KtN5q4W3kC9CTCa3QNuKtQbaZ++2U
         Uqc0ml4g+DzYmKwhk32M84CBk2HL7sr/qJsbETnPEQQkR4TeKZIHysr13VJaty3INlRU
         7ojOJr1lHuhawvNH7Xl4ZvaqnSQ4gvVtDh76nmjBjtMIgBjo2ctAyD6IXAe4ALcKRNKT
         tELIQFx8DdTtkYKqDxuOBjBEb4Tn05AtTMatXkDwQ5Z0hlh1jYQfYwzxe8zmjoTTejrs
         /SqMSxOHw70I66eOVlzST6J+Q/z27tMjyeyksqiBNWT6vbx51pf84E0ZOFofZ1ZWz0Sc
         COCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783551134; x=1784155934;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRLBDv0GR5+I5QEs+yagz6DalTxaINze8PKIAjmPSRo=;
        b=MEqj1o4zyNxnFSCTClfNHP4Wi4AIPWvAiXVDcjZGdkoA5b2AkSM70LPi6ARDBWw+6x
         zJ+adzIlZuY9oQ5RXxBypHM22je95py5BFwpAKhBpwIzVMTewPLIqev3dHEgwEejIZe3
         SYjsnAFMyD3qVBbb9cBKNdggU21M8AftrlyFhNim8eBC++V27mhclDHkF8+q2YJi3gcD
         40qKA/mgZvfNx9WuAkAQ9xq2DlrpAUMg1y7waeJqGd0BDKSa8EQzBLyHgF91oYoAuK/M
         xdJQO3cpeWYiAGVBpevBglelNZCIIYCSrBTtyDV3PKpuSNywtqeizf8RClSQSZBdOlPH
         hJFg==
X-Gm-Message-State: AOJu0YyuVCSV+CewgwE+YRv4odwyq3XlqoQRm3djdqiWmT8gRNlq7JsF
	1DEdg7xCDZXD735NkadGwgoFu1z+kLQKxMnDw1Ms3Z81QILl5BGD074EopVYWb2QDCR3X3shQOA
	pOh2zYxaUa0/fDgzdGy2YraUTUIgVWoUuy2Yn6KPt+Y8rNaXA0nMmBVZnMsABgbezpLNpzhUBMA
	qmwVKCa8uGzKOxzmOAMRsVeeSVmc6bVkDGQdh49+EJ1vg/LaOpIWDZLbsaTphzzWA=
X-Received: from ilmq1.prod.google.com ([2002:a92:d401:0:b0:503:8d4a:5b5b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:5708:10b0:6a3:74fd:a86f with SMTP id 006d021491bc7-6a374fdb227mr1250772eaf.9.1783551133388;
 Wed, 08 Jul 2026 15:52:13 -0700 (PDT)
Date: Wed,  8 Jul 2026 22:51:24 +0000
In-Reply-To: <20260708225124.4130846-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708225124.4130846-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708225124.4130846-7-coltonlewis@google.com>
Subject: [PATCH 6.6 v2 6/6] arm64: Revamp HCR_EL2.E2H RES1 detection
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, dbrazdil@google.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jan Kotas <jank@cadence.com>
Content-Type: text/plain; charset="UTF-8"

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit ca88ecdce5f51874a7c151809bd2c936ee0d3805 ]

We currently have two ways to identify CPUs that only implement FEAT_VHE
and not FEAT_E2H0:

- either they advertise it via ID_AA64MMFR4_EL1.E2H0,
- or the HCR_EL2.E2H bit is RAO/WI

However, there is a third category of "cpus" that fall between these
two cases: on CPUs that do not implement FEAT_FGT, it is IMPDEF whether
an access to ID_AA64MMFR4_EL1 can trap to EL2 when the register value
is zero.

A consequence of this is that on systems such as Neoverse V2, a NV
guest cannot reliably detect that it is in a VHE-only configuration
(E2H is writable, and ID_AA64MMFR0_EL1 is 0), despite the hypervisor's
best effort to repaint the id register.

Replace the RAO/WI test by a sequence that makes use of the VHE
register remnapping between EL1 and EL2 to detect this situation,
and work out whether we get the VHE behaviour even after having
set HCR_EL2.E2H to 0.

This solves the NV problem, and provides a more reliable acid test
for CPUs that do not completely follow the letter of the architecture
while providing a RES1 behaviour for HCR_EL2.E2H.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Tested-by: Jan Kotas <jank@cadence.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/15A85F2B-1A0C-4FA7-9FE4-EEC2203CC09E@global.cadence.com

[ Backport: Resolved conflict in arch/arm64/include/asm/el2_setup.h
  by replacing msr_hcr_el2 macro usages with raw msr hcr_el2 (since
  the macro is missing in 6.6.y). ]
---
 arch/arm64/include/asm/el2_setup.h | 38 +++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 76b0d50d286d5..4c7467b382b60 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -24,22 +24,48 @@
 	 * ID_AA64MMFR4_EL1.E2H0 < 0. On such CPUs HCR_EL2.E2H is RES1, but it
 	 * can reset into an UNKNOWN state and might not read as 1 until it has
 	 * been initialized explicitly.
-	 *
-	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
-	 * don't advertise it (they predate this relaxation).
-	 *
 	 * Initalize HCR_EL2.E2H so that later code can rely upon HCR_EL2.E2H
 	 * indicating whether the CPU is running in E2H mode.
 	 */
 	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
 	sbfx	x1, x1, #ID_AA64MMFR4_EL1_E2H0_SHIFT, #ID_AA64MMFR4_EL1_E2H0_WIDTH
 	cmp	x1, #0
-	b.ge	.LnVHE_\@
+	b.lt	.LnE2H0_\@
 
+	/*
+	 * Unfortunately, HCR_EL2.E2H can be RES1 even if not advertised
+	 * as such via ID_AA64MMFR4_EL1.E2H0:
+	 *
+	 * - Fruity CPUs predate the !FEAT_E2H0 relaxation, and seem to
+	 *   have HCR_EL2.E2H implemented as RAO/WI.
+	 *
+	 * - On CPUs that lack FEAT_FGT, a hypervisor can't trap guest
+	 *   reads of ID_AA64MMFR4_EL1 to advertise !FEAT_E2H0. NV
+	 *   guests on these hosts can write to HCR_EL2.E2H without
+	 *   trapping to the hypervisor, but these writes have no
+	 *   functional effect.
+	 *
+	 * Handle both cases by checking for an essential VHE property
+	 * (system register remapping) to decide whether we're
+	 * effectively VHE-only or not.
+	 */
+	msr	hcr_el2, x0		// Setup HCR_EL2 as nVHE
+	isb
+	mov	x1, #1		// Write something to FAR_EL1
+	msr	far_el1, x1
+	isb
+	mov	x1, #2		// Try to overwrite it via FAR_EL2
+	msr	far_el2, x1
+	isb
+	mrs	x1, far_el1	// If we see the latest write in FAR_EL1,
+	cmp	x1, #2		// we can safely assume we are VHE only.
+	b.ne	.LnVHE_\@	// Otherwise, we know that nVHE works.
+
+.LnE2H0_\@:
 	orr	x0, x0, #HCR_E2H
-.LnVHE_\@:
 	msr	hcr_el2, x0
 	isb
+.LnVHE_\@:
 .endm
 
 .macro __init_el2_sctlr
-- 
2.55.0.795.g602f6c329a-goog

