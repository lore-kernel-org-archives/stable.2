Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078349551A
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863179; cv=none; b=AzGJ6+48+hPSGTM5hwx1ivhTIeM+FXjFzfwevW+k6YccY/Owhcl4JPeff7XU42hwM2cVYWQtvTp8waO7hKnnbI79Fvs00e5ymc3St5Sn7zkN86iOfl5VfBROgyWW7qpMNh30iairhq5IqCxYFzXhvAhrVWNJVpTpdwp+8bGZ1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863179; c=relaxed/simple;
	bh=l6V0gdyQVLiuFV34wfUAHvBWEK9j3znHuHfws+Z7rhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRKV1yg0ejTzscd39NtwzN4ywlFuPMM54w8RVD8vPUSWzPTQkqSlJfK/uQbTPhGhyWD2FeTKgljYJvW/o3ZEK/gzqSMZg/ntH4AznoAI2zi42lOjy1uQMMEIfqwg9ysKC1j6iLXyBOGQu/H/hZj+k209cUmnaTzwSyh1ehYvSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lqcbSZJG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lqcbSZJG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C14CF168F;
	Tue,  4 Aug 2026 10:06:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE4DF3F632;
	Tue,  4 Aug 2026 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785863166; bh=l6V0gdyQVLiuFV34wfUAHvBWEK9j3znHuHfws+Z7rhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqcbSZJGNmNDoLYAe9CagUEDKdBHuuZ1MCOE0DB/ArBKSE+OQyP+V+jD1DZcdDhGW
	 QJjmhFp2MGBkxFLhKFmz/unsflctzbehOsKuB/cCcPBbmrt6t5geEySCUbZ3e2ZlvX
	 SRhIklTV88hvTfRGbW1S51IyqDHFOPeDE3qh3hhQ=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	david@kernel.org,
	david.laight.linux@gmail.com,
	james.morse@arm.com,
	ljs@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	peterz@infradead.org,
	ruanjinjie@huawei.com,
	ryan.roberts@arm.com,
	stable@vger.kernel.org,
	vladimir.murzin@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: [PATCH v2 12/20] arm64: entry: sdei: Make 'tsk' available
Date: Tue,  4 Aug 2026 18:04:55 +0100
Message-Id: <20260804170503.3513916-13-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260804170503.3513916-1-mark.rutland@arm.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
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
index eadf4e74e72a8..1b4cd70515550 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1027,11 +1027,12 @@ SYM_CODE_START(__sdei_asm_handler)
 
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
@@ -1047,7 +1048,7 @@ SYM_CODE_START(__sdei_asm_handler)
 	mov	x1, x19
 	bl	__sdei_handler
 
-	msr	sp_el0, x28
+	msr	sp_el0, x20
 	/* restore regs >x17 that firmware won't restore */
 	mov	x4, x19         // keep x4 for __sdei_asm_exit_trampoline
 	ldp	x18, x19, [x4, #SDEI_EVENT_INTREGS + 16 * 9]
-- 
2.30.2

