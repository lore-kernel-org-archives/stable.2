Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0193BFACE
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938631; cv=none; b=sHlrKGBIyLw9r9B7D14/QH3u0mXNOhPUh6TSHR+OhBmAw6vYWpfenKk1lt0zoEGWrpeXUQaAmd+tBqdlZ5BLEKzjUO/IwtuuhROz3OPI4Zk8twe6rs1V0mbN6Ay2b8Zybevwh1D96oBkcyhcRh8hyN6NXHo3YiBC5HP3HWnbtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938631; c=relaxed/simple;
	bh=6eCkFQ3pHgwn8l4mQYBv1gAg6isYBlWYb4iaywME6zA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sLuyushfLtxBIUpvpxUe4Xl+gh/H+0Ctv0OhgjaHOZMPI6XBXtJSkkMT/3gp+1a2wolgJ6SmOKFGVmPE3AhVS3c/oV4zcDZ4yy1CTVGbYgsCghbEJmEhX8mE8Aq70PJU73VOg9amGYmixdegln+NoVB64ua5aUXq4p75eZM/jCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WAEq5wvu; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAEq5wvu"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-49226201eb8so787084b6e.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938628; x=1783543428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sot0xOLLqT5jl7UPs1tEjpIi3IAlhrP2GH6sB88yxis=;
        b=WAEq5wvulNyE7EKAd7F60NhfrnViX8Lv5j4WMxM3lTz2LCFH8NtagPKFEDN5h63Nsz
         E2AAdSpFGC9FzRUtaVlnJblfiH7daQ2giWu09ZQorXN7Pqn96Vqwcqwk/QAp5juSJTsA
         qnohlpodbHRU+/4Z4+FPr0mi7UFerX+Zy8gMFTz6M/DvV+bTuELyulrFAnBXGN1T7ui8
         YXXBmfyBBNbxJUMKwhdr/ii/AdisqhpxkmcOpd9WwjB2nVds8L06v6dXK7MBD5HWApfJ
         FUrlCqVodZjcZUEwe1jF1xkOL6Ka+zwcS1c/hjuTseZVKWB7SiLfp6Y3EDifjnocVWUI
         YpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938628; x=1783543428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sot0xOLLqT5jl7UPs1tEjpIi3IAlhrP2GH6sB88yxis=;
        b=Nwvr2uqnMWVCmn38M1E6Cgymtlx7u6fs+S3D8U5OJ27qW39Vfi94orZcsd6jzQpLf8
         ZeLbKnWS8d31aRJ8zu+LyqOGbFlAYohkhO5Gu4k9jmfl7QhZeuNUi8qkJ8OZQASGsSOz
         nOA6oVrbyM5DoSqhnLIdsjLLYldJ5JSv07U9wJjDsNtc6eZNX1+azAS4u8YECBOXJlaN
         7w5eubkxV3RAJTzWhuaF3x0okc7iwu0kYkaDTQzbSdh3M+pZ9FRfnrOE0+c0OgZekgTB
         kvr3rzOvUEkpdOcsd+oHuczde/DsKcT5+kA9NafQEwOdBRGRHdg457tkrOWKOhsx4QSm
         debA==
X-Gm-Message-State: AOJu0YxC27nkyAwQclZTrL/fm0Wzln8H7qpbmSixyYq2In9y+rFD6+hf
	KpufpyNlTehzDnLVKsC0G8w9PJAuutKtF1xlZm4zF0qjC+tJ/TFVo8TcJDLX5MkCU/+vF+LJ6vv
	vyEPkK4720benUoA31j0tj/0fGYfbQGMCjfF0x0hsobsL8hSdXmlsCnALuwqRn7QSqjNcSDaBAv
	KR7WmmAUjvC/7NhLMOyvUYUMVSFS8bGHIij7SX5YgkOHy8uSAcYceDIqjrpoZ36cQ=
X-Received: from jabjw14.prod.google.com ([2002:a05:6638:a20e:b0:5e7:3ea0:602c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1210:b0:48a:3f80:ee5f with SMTP id 5614622812f47-4960f04d9cdmr2092075b6e.29.1782938627860;
 Wed, 01 Jul 2026 13:43:47 -0700 (PDT)
Date: Wed,  1 Jul 2026 20:43:42 +0000
In-Reply-To: <20260701204342.2654385-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701204342.2654385-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260701204342.2654385-6-coltonlewis@google.com>
Subject: [PATCH 5/5] arm64: Revamp HCR_EL2.E2H RES1 detection
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Jan Kotas <jank@cadence.com>
Content-Type: text/plain; charset="UTF-8"

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit ca88ecdce5f5127ef2ee241b12b23a7e03c6210f ]

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
index 3498dc5d02c18..38d32116a23eb 100644
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
2.55.0.rc2.803.g1fd1e6609c-goog

