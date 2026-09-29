Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA752BE4C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688679; cv=none; b=ryKE86a2T8Uhsjv/juvPR1vY0PFNWF7dfYxSpieKennex5Rk5cwMJ/yxW0aXsbz8NIM5twUaeDRV4/c5CK3OJyMGPgbgm49d6GjMZ1rxJ8CkIBmdb7JctOj/NzApa9pcbttfEDbInWGhqcoTfovrzyhAxYYX8+ZxZ4bwlIyww18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688679; c=relaxed/simple;
	bh=UdPm6YNoWzPdyvV5eoEU+L+yV5zvkTc8YpptS208jU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYzCaqwfVjsHUOujvAqokge3kyirT8VAeR7GYnF5UyAj/jwXbAGQmeZ108d3h3/L+W9kQmAdx6OPQxsBk2fOjKOlHXdKE5Za48IFxBuwYaVwaM7TjgUuI9ysndRYVC6/NDkaCio7tIwtvZzMgUn3z6uMJ013SffYmWfRLVnLw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR2QUGNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR2QUGNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3901F000FF;
	Tue, 29 Sep 2026 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688678;
	bh=Px6hYUX+k3ZAIgbE3XvTdJG39FkBidZEQQ6E2tOtTYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mR2QUGNB04/Xh6TpIK5Yh7Q9eGZueRVqaiWm5QYH8/Wj+MC8EOOKnOvU2noyEVQJc
	 lB2ZZ8v+nHGIfm/Fz1jQZtdO574f31EdlWNhn4BJGuOuVFh8+fqAy+66+3vjIj6HR/
	 HYxTFK/tzGFuxlLxCnc7kFGIXbASxg66+avvOiYn/pTdphsU4oJjGuEWKw7AABv2ri
	 jQCdEv5YPq3XUVpy572pY/WSUA9K4HlyyvFJqxoI1oS9yH/Xt/GgHuRQ4L4OSjIXf6
	 22FSGjskAsVoDZxHKSuol+pS+WB6mgaf1xm40FndKeojIE8LfRR1cyavcX5PLcZMfk
	 Pwj203cLgll4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] x86/sev: Move the internal header
Date: Tue, 29 Sep 2026 09:31:04 -0400
Message-ID: <20260929133116.3502913-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092939-ecard-twirl-6094@gregkh>
References: <2026092939-ecard-twirl-6094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Upstream commit c1e8980fabf5d0106992a430284fac28bba053a6 ]

Move the internal header out of the usual include/asm/ include path
because having an "internal" header there doesn't really make it
internal - quite the opposite - that's the normal arch include path.

So move where it belongs and make it really internal.

No functional changes.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20251204145716.GDaTGhTEHNOtSdTkEe@fat_crate.local
Stable-dep-of: 6c43c72748ff ("x86/sev: Make vTPM SVSM calls preemption-safe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/startup/sev-startup.c                          | 3 ++-
 arch/x86/coco/sev/core.c                                     | 3 ++-
 arch/x86/{include/asm/sev-internal.h => coco/sev/internal.h} | 0
 arch/x86/coco/sev/noinstr.c                                  | 3 ++-
 arch/x86/coco/sev/vc-handle.c                                | 3 ++-
 5 files changed, 8 insertions(+), 4 deletions(-)
 rename arch/x86/{include/asm/sev-internal.h => coco/sev/internal.h} (100%)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 09725428d3e65..789e99d38d17b 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -27,7 +27,6 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
-#include <asm/sev-internal.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -41,6 +40,8 @@
 #include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
 
+#include "../../coco/sev/internal.h"
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d20e9cc065a87..19adb17bd09d1 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -31,7 +31,6 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
-#include <asm/sev-internal.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -46,6 +45,8 @@
 #include <asm/cmdline.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
 /* Bitmap of SEV features supported by the hypervisor */
 u64 sev_hv_features __ro_after_init;
 SYM_PIC_ALIAS(sev_hv_features);
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/coco/sev/internal.h
similarity index 100%
rename from arch/x86/include/asm/sev-internal.h
rename to arch/x86/coco/sev/internal.h
diff --git a/arch/x86/coco/sev/noinstr.c b/arch/x86/coco/sev/noinstr.c
index 422ce72f51d58..5afd663a1c217 100644
--- a/arch/x86/coco/sev/noinstr.c
+++ b/arch/x86/coco/sev/noinstr.c
@@ -16,7 +16,8 @@
 #include <asm/msr.h>
 #include <asm/ptrace.h>
 #include <asm/sev.h>
-#include <asm/sev-internal.h>
+
+#include "internal.h"
 
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index 7fc136a353347..c54f2a032e392 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -23,7 +23,6 @@
 #include <asm/init.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
-#include <asm/sev-internal.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -35,6 +34,8 @@
 #include <asm/apic.h>
 #include <asm/cpuid/api.h>
 
+#include "internal.h"
+
 static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 					   unsigned long vaddr, phys_addr_t *paddr)
 {
-- 
2.53.0

