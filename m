Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76936E497
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551135; cv=none; b=YFqN01tgKqortkgqywYcPwk4B4S4Si7xSyRUrerll63dXEYnO7xeYRFtdDyUcj9umBDG2Afl8g9ZeuzaK6zh9c6LvRuhAA6Yy9hwXZ8ZDJ1PEnqwxTiybW9zGvh/wm2oeHBPc0iCKns02xA/ryFhvsJYB6mOx5KNCVvLY/35yZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551135; c=relaxed/simple;
	bh=GcTzCgDwS7y4wDnrGBefwcu9zbRuGcMdXbDLOI4++CE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bja1oePhILHiGvrC+LIUq+au0GzwtboGt/65IHL/gacVQ2LsXIe6wWqfbdp/XkrKSBBfBL7aNHMiCEQJWsFrTqn9CwSLDcjxeLaMRZbAKXrp6nsi1W0/5ymsUmB1t+4888KV8+DI01WSk6u/TbG557O4NWNyAWAQZB5yUEOywek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obPqeTY9; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obPqeTY9"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-6a37685f41aso544254eaf.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783551131; x=1784155931; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVcT/XbiQLVXOFsg2iWKEGLEgGzJkv14kL5pzrUYsoQ=;
        b=obPqeTY9yUHy3OH4U3eUWDY70jFdT3zyGARkbLp6bTd5hY56TwPg9W/cS5RnXMg1kL
         TjXnkireWhA8U3HFIQK8CVRJL1tQkw2rAkZg397RuYWL9FGk83eGIxZ0glPQY7yeTOlJ
         DqBem6gvdVnuR/+W+eKI68D+FDxgDV9CvTffkB8/BSwoVMWZGhKX7CT6ukcfg1FyPUY6
         6jxw/z+RFspCcjPB05hLGnGRdvERT+5s/6ikovuGerqvNdVTImyGSs0wGPGfvOnr8AO1
         TrvqDHr1Bp3BDBNrzRHLVBGi5n1hw5y+FaN1oUtPssiqUWZfj5FQEYFC6gDvaP7d6w1n
         7K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783551131; x=1784155931;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVcT/XbiQLVXOFsg2iWKEGLEgGzJkv14kL5pzrUYsoQ=;
        b=R0FKa63OY13oG6YIPoW61zURlRg5P3NRnbMa3i6M/S+sVzevl1HLhK5jXwDQimQZ2g
         EDVExX5RxDzav8Gs+KqDt6vuUPmsSxQ1dLAe5RjMQmzjCNtdhMAogZPXltJPktJy90RN
         W7xxRe2n9dL6z6IrbTnvXLloHdM6/ElxSgdBIfm6saVX9DzzdpVTZ+k5hTBuRRNcGCZj
         tB2PGH2TIN/PkcRGKUya0LNnNrKNA4pzEC3GjV1AonCEgdwg0qFwgDa2RivjwcgPcWH4
         tbZxQc8RgcE2aM1T+VwBb3aNfimriRm9x9TkLU1rKSQ2a9T/AhAvIX88gkh1hLLdXf+c
         HrHQ==
X-Gm-Message-State: AOJu0Yxli3GUJEakLotq1Bj2Kuw1gLf0w0xaSc6acC6vvinLHCXAlVF0
	/Pnlw0Dr1T+5mH1nS57rIW/fi5IkeVJn2/K8Euoow0eWhZ0/XFv+mptajJRm0UObXFLEgHtsT92
	Bi+azAYMzppTkD9KEjeF2f821l4AY78CmIgzAb4/5dZRtqVxTm13h6hmhzHhcw2MvA0QxTkgzbx
	57reJicb+YAqXGvxmPUTOYWgCdI9bGDLGqyod3YSokBK9I3XhgonnEiaezgKZKn4s=
X-Received: from ilov7.prod.google.com ([2002:a05:6e02:f87:b0:503:921d:b167])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:8c5:b0:69e:34f1:9690 with SMTP id 006d021491bc7-6a36da60d5emr3142261eaf.35.1783551130514;
 Wed, 08 Jul 2026 15:52:10 -0700 (PDT)
Date: Wed,  8 Jul 2026 22:51:21 +0000
In-Reply-To: <20260708225124.4130846-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708225124.4130846-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708225124.4130846-4-coltonlewis@google.com>
Subject: [PATCH 6.6 v2 3/6] arm64: Fix early handling of FEAT_E2H0 not being implemented
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, dbrazdil@google.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit b3320142f3db9b3f2a23460abd3e22292e1530a5 ]

Commit 3944382fa6f2 introduced checks for the FEAT_E2H0 not being
implemented. However, the check is absolutely wrong and makes a
point it testing a bit that is guaranteed to be zero.

On top of that, the detection happens way too late, after the
init_el2_state has done its job.

This went undetected because the HW this was tested on has E2H being
RAO/WI, and not RES1. However, the bug shows up when run as a nested
guest, where HCR_EL2.E2H is not necessarily set to 1. As a result,
booting the kernel in hVHE mode fails with timer accesses being
cought in a trap loop (which was fun to debug).

Fix the check for ID_AA64MMFR4_EL1.E2H0, and set the HCR_EL2.E2H bit
early so that it can be checked by the rest of the init sequence.

With this, hVHE works again in a NV environment that doesn't have
FEAT_E2H0.

Fixes: 3944382fa6f2 ("arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is negative")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20240321115414.3169115-1-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kernel/head.S | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index e32c8dd0b17a7..e0e710b36da37 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -576,6 +576,21 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	isb
 0:
 	mov_q	x0, HCR_HOST_NVHE_FLAGS
+
+	/*
+	 * Compliant CPUs advertise their VHE-onlyness with
+	 * ID_AA64MMFR4_EL1.E2H0 < 0. HCR_EL2.E2H can be
+	 * RES1 in that case. Publish the E2H bit early so that
+	 * it can be picked up by the init_el2_state macro.
+	 *
+	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
+	 * don't advertise it (they predate this relaxation).
+	 */
+	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
+	tbz	x1, #(ID_AA64MMFR4_EL1_E2H0_SHIFT + ID_AA64MMFR4_EL1_E2H0_WIDTH - 1), 1f
+
+	orr	x0, x0, #HCR_E2H
+1:
 	msr	hcr_el2, x0
 	isb
 
@@ -588,22 +603,10 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 
 	mov_q	x1, INIT_SCTLR_EL1_MMU_OFF
 
-	/*
-	 * Compliant CPUs advertise their VHE-onlyness with
-	 * ID_AA64MMFR4_EL1.E2H0 < 0. HCR_EL2.E2H can be
-	 * RES1 in that case.
-	 *
-	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1, but
-	 * don't advertise it (they predate this relaxation).
-	 */
-	mrs_s	x0, SYS_ID_AA64MMFR4_EL1
-	ubfx	x0, x0, #ID_AA64MMFR4_EL1_E2H0_SHIFT, #ID_AA64MMFR4_EL1_E2H0_WIDTH
-	tbnz	x0, #(ID_AA64MMFR4_EL1_E2H0_SHIFT + ID_AA64MMFR4_EL1_E2H0_WIDTH - 1), 1f
-
 	mrs	x0, hcr_el2
 	and	x0, x0, #HCR_E2H
 	cbz	x0, 2f
-1:
+
 	/* Set a sane SCTLR_EL1, the VHE way */
 	pre_disable_mmu_workaround
 	msr_s	SYS_SCTLR_EL12, x1
-- 
2.55.0.795.g602f6c329a-goog

