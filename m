Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96A3B6BF4
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636641; cv=none; b=cpGSRVumf92P3x9oNBTzICnl+4IvBX1b4xjoHvNzBwrYtzOWqbdP+Haa8GVLUvsYZ5FV2cUBlCXwLrNJtgHR5tbPZ1AUoV/us3y1iqMIAuxIEa6l2i/aI3jx81+dgloMN19YUxSAD886g/kKv9EndXb9nLg3vl5ZcPJtVpxGudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636641; c=relaxed/simple;
	bh=OWCxBSzaeWIE2U5n1eWlPbSfhQNJbN6VFfYTdf5ETt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GIWTT64wsbHGfePKVXTpjFuoDvTiJhg2QCG1dJF1b5Gv86Tuf8OjPmzuLalhdB7KOHIFv593eqBpTD00pFCEsDHp8wXEhfD97qHbASP+zsJbMePIQkZNNGa5oqcGihFJAhkhSlndBTpH7Wosw/KLKpZlIeCDknHUaCsgbRpCObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQXcwiqU; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQXcwiqU"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-48f680bda84so348948b6e.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783636637; x=1784241437; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78osRNk8qRzph/366BzOmfMhZhXhz27WDl9JWZTx3ao=;
        b=OQXcwiqUpIn/1h4gwtYxmMBOvMsuXO8gU2popm6FEaVDInethC7LlOcLEqW09t/8gv
         TrqpFlUccEtZlYG5Dbft5Qqcs/Fvsq21Uxd89hUQ5mZrJBOAgjmVj2V4BJF9iCr7t3Fy
         PdZkK7ychhDOLAjbr+RVMv8D9his96oiFkJTScsY1eVkVnBlQ3oDhEz1QjWz1xq+cJbx
         1Uoyj+SLhlmBTCLys8QnN4vWNoUaXbJJbvd7dK5/Ls4RcTahf85PtfNuKcAg3aZ8Zx/3
         l7Oejb9wmcOt3Pv1jD8qFw7nEuWlAH+RJoX/cf7SsMBR2XqU4/wCj5CjJ34D4hJ3NFFj
         mSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636637; x=1784241437;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78osRNk8qRzph/366BzOmfMhZhXhz27WDl9JWZTx3ao=;
        b=smGYQ/E+yPnW42DPrlTiHTgImQXeNzJgd2Da9w0LLWa90QAz2vFcvRUkdUbZo0RgQM
         lfguPYmgDXR4BiI6EaD0RPhDwbcSDfnhgshRKcfTA+zyM+uid9Q0C3/pUd32QPThRSAH
         fH70UMWjZb/wuL7u7sbJM+BKv7xDnoW+AoiKQW8vQoKLg6aLyhy/J9HY5j35HCcx2zMP
         l+3f7l2tViBrsYomkKQzq1MDwaBF8+F2MqL2wO26Pn1Xgnw+Zk1FjLmtKEVeaAZtwbTg
         asUzjDB5p88D4TGkzeGKJ7BZCyYBsQi1l6gHFPvHJLi17mY+lLJfC8lPPm3dliapwA9t
         Xjgg==
X-Gm-Message-State: AOJu0YywQsYNTMt3vxpcdWogyff26OvlsWuz7en+QC0qFY2XWh23sM+l
	kqccJQa36VJIezeRtwarZt9Ua9Q920ZV3ha5z/4KMZubPdhj1XugKtKi9bAOvDDJ+2IJbu9ZKdS
	2NpIAnjGhRQSaCCX1A/T1lObFR4bAvsvZVVnuAuJUlIWPWoeW7K1nRVfUVc3vEMD3DC2Tz2Kdhd
	LDzTd0YtWw3TSeY0Lmso8XvERN6TBUzUjxTIjW5M5ki8YgdYkOP/UI47lhV7pkpDo=
X-Received: from ilbcl1.prod.google.com ([2002:a05:6e02:3781:b0:503:6571:319a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:250c:b0:495:f74a:5bed with SMTP id 5614622812f47-4a203fc3ef9mr7510176b6e.28.1783636636840;
 Thu, 09 Jul 2026 15:37:16 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:00 +0000
In-Reply-To: <20260709223604.12934-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709223604.12934-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709223604.12934-4-coltonlewis@google.com>
Subject: [PATCH 6.6 v3 3/6] arm64: Fix early handling of FEAT_E2H0 not being implemented
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
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
Signed-off-by: Colton Lewis <coltonlewis@google.com>
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

