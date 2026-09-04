Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB650AC0F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541182; cv=none; b=f+SHu2KCdz6Qi9qqYqO97DD/R/SccRccQepLP/QS5t6GynUGSSAj5d1S9DKtWjoRfkzd/AK+HW5A/w58azZCczJtpsCLFqA1tKe2/vlMx9Qf3Foz3xegbcb0FmAkL51Beepoix5aTN6IVTxuKd2xaQHnHOJCW6Rnnux42stKz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541182; c=relaxed/simple;
	bh=pUGiK76B/cGSXLCAJDeQJWe6X+z6/ttgCiv66ralV/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcsAXJ7ag1QxpFPkWPKHPdlR4LGIwyTBtyjVXELFBUoZSJXxSoEKBX5rThAv+BgY8IGfWwpdc4bqDM0iBAUtAqWgS3kXE1YCtS9v8WWrD/hsWEonGyCC124kT09R80klVEP+KZ8NcvVN5X/sLAbGbLHySfxcVkPm6jemv/EwdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WVzc1af6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WVzc1af6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 272F2153B;
	Fri,  4 Sep 2026 09:59:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75EA53F673;
	Fri,  4 Sep 2026 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788541179; bh=pUGiK76B/cGSXLCAJDeQJWe6X+z6/ttgCiv66ralV/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVzc1af6BsoBN+nSWzGu7WuzcrXUgXXhkngtMEHQvkQu14E0Ge9JYX/Qv5SHpWfXl
	 jfmqv9NQQatVww2rTjQ+T2HARXaDpUs50Spu3XanEmF/cpCN6Pe8iKGz8A0yxmmpiJ
	 Qf1PBDRJeqmXVQEZzyZQWk2Vxa5Ja4/Jla7oXmOo=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	david.laight.linux@gmail.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	peterz@infradead.org,
	ruanjinjie@huawei.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com,
	vladimir.murzin@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: [PATCH v3 13/21] arm64: entry: sdei: Make 'tsk' available
Date: Fri,  4 Sep 2026 17:59:26 +0100
Message-Id: <20260904165926.377036-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260904161758.376504-1-mark.rutland@arm.com>
References: <20260904161758.376504-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For regular entry/exit sequences, we use 'tsk' (x28) to hold the current
task pointer, allowing this to be used by various assembly macros. The
SDEI entry/exit sequence uses x28 to hold the value of the interrupted
sp_el0, and doesn't retain the current task pointer in a register.

These differences makes it awkward to share assembly macros across
regular entry/exit and SDEI entry/exit, and risk surprises.

Align the SDEI entry/exit sequence with regular entry/exit, keeping the
current task pointer in 'tsk', and preserving the interrupted sp_el0 in
another (callee-saved) register. I've used x20 as x19 was already in
used for the relevant sdei_registered_event, and these are the
lowest-numbered registers above x18 (which we must preserve for shadow
call stack).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/kernel/entry.S | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a6ec5c5a2d29c..0902c1bd9dd3d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1023,11 +1023,12 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	/*
 	 * We may have interrupted userspace, or a guest, or exit-from or
-	 * return-to either of these. We can't trust sp_el0, restore it.
+	 * return-to either of these. Preserve the interrupted sp_el0, and
+	 * initialize sp_el0 to the current task.
 	 */
-	mrs	x28, sp_el0
-	ldr_this_cpu	dst=x0, sym=__entry_task, tmp=x1
-	msr	sp_el0, x0
+	mrs	x20, sp_el0
+	ldr_this_cpu    dst=tsk, sym=__entry_task, tmp=x1
+	msr	sp_el0, tsk
 
 	/* If we interrupted the kernel point to the previous stack/frame. */
 	and     x0, x3, #0xc
@@ -1043,7 +1044,7 @@ SYM_CODE_START(__sdei_asm_handler)
 	mov	x1, x19
 	bl	__sdei_handler
 
-	msr	sp_el0, x28
+	msr	sp_el0, x20
 	/* restore regs >x17 that firmware won't restore */
 	mov	x4, x19         // keep x4 for __sdei_asm_exit_trampoline
 	ldp	x18, x19, [x4, #SDEI_EVENT_INTREGS + 16 * 9]
-- 
2.30.2

