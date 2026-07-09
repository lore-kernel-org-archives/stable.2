Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB263D0934
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636644; cv=none; b=BlRGmB5pUfABkHsLPXlZYueR1GK8DYP++VwBsf/do3DjTAC0gJR525RvBcIZjiEyoL2Yevss46Th4z8whLXeHT7hMcqx4QxlQ9B7xGdRA/9m0NpLuacc+50jkSaC9d7EHF6ybifSAd/Tm9uEPhXwL39B6SHOVPLpX4YmhBOTZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636644; c=relaxed/simple;
	bh=3up1sBtO4PIJV4dpkOl/Oq19tQ7laWLZmhnYXu8p8ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ms40P3Z/6Zdpx4CFnvxwfINuGQJoE+iHI6b9J9C8wMdRXyK19z58XIHUTrortT5EYFQ8tWW4WP8iaZ+vkprdy/Hvi71klo/N1ABtG53KeQXgtmtNkgqwxI9Rhv/71AEAAbeV+wzO3nHRQUCFeL8xG7zF/6Dz2dxkg/AJn026zuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvJ6qSOd; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvJ6qSOd"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-48f5afc9692so332569b6e.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783636640; x=1784241440; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sSD/MdR7z212lU1O4WIMPoRpCWIEcBrC5jBLx8jitA=;
        b=nvJ6qSOdcofSZSzweb9pi2yNz7H6EFsSPDErsrGoTqmqu2bnoD1h1F7SvXaduRgVcr
         rQk1MT/1Kn+rLdko4DbKtOn6LFMEFlFa36Z7mot0eW8tqRB4vfb8PkS+lafoxTEZYj8C
         1ndEYSpM8Osr41QpMLpTdoFYh4nqgzzG7uf2pNsC+7pOs05Er6o3k7Wbg5TSQd2L0Rcj
         apGy6K0FIBTs96kfSVJSt+IuP31hdZaWftY0w6IXrr6zveckcOV2Ib9a1zJnW3TfI9T/
         1LBeFSMlGiMosgVobVm974k3E+HVl4Rh7+knencOZY9oD635SbRS2qKaKdySnWsJbGQl
         RQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636640; x=1784241440;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sSD/MdR7z212lU1O4WIMPoRpCWIEcBrC5jBLx8jitA=;
        b=PbbZjmzpBSY7bI+nvrdkHZHmXWpIKZpxdaHE/a7zhAh5JDpsxlhPQLvg/gCxcOEE/L
         MMVrU8Ycswf8IxxvCFssRExuUxLinYlhLcSsek5xXy0eW2BR564FxudGsYlfjqZtrEzM
         KWlb9Uo34N27ut0TDRsahFrGIXlMIdQG8f1ZMLqdGvvkDhgEyhP8MfvLpr+3/G+H3eMO
         G8wal1eaPdivm6lNj7FxWEOdYfuFDKOUxni90ez0wxbADBEcgjRuTg0P64yEU0/pAh+2
         iz77IA+TlNwhScrO7k3OdCa1rViGapAD39hbeB921w6Y6BIjPoQh+WBu6mLsZLRziRZT
         e84w==
X-Gm-Message-State: AOJu0Yy8RR5fBbOwse5g5JZfVvBGZXp7Fy2zC+et1KKGh5rTT97AQE3z
	+PPOlad+D4e0cAftW5+Frw8auz6dehypYcTdx5nQTlKEgQCoLJ4BeRMytPBoAaP44UZ985kWAci
	z+EkUz1RQlwRjv2I021PJin51LTmYzVs6plHznzvADV5yFZtUaEhazhuXa8e+ShkeoHYh/hJ/Nk
	7rJgDfSEWLIBNHRdwERfxnW+qW2/L1X6ss74UcnNZGIJS2d+uAL2U63fZ7W61DXN4=
X-Received: from ilpy16.prod.google.com ([2002:a92:c750:0:b0:501:bcc7:5e68])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:152b:b0:4a4:934:b316 with SMTP id 5614622812f47-4a40934b663mr1606708b6e.21.1783636639699;
 Thu, 09 Jul 2026 15:37:19 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:03 +0000
In-Reply-To: <20260709223604.12934-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709223604.12934-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709223604.12934-7-coltonlewis@google.com>
Subject: [PATCH 6.6 v3 6/6] arm64: Revamp HCR_EL2.E2H RES1 detection
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jan Kotas <jank@cadence.com>, Colton Lewis <coltonlewis@google.com>
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
Signed-off-by: Colton Lewis <coltonlewis@google.com>
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

