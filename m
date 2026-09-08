Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB527AC57
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880970; cv=none; b=nDJFWkzJyoJ3nUGQ8p54Iht4cgDOII6Lh9j25cKOymkB/UO0+nbFC8cGq3zMe16P3YY9H6c+819WyGTu7L7hdlVzSYvlcb6WPpzeFfmH2Ykqh3n+hBL4w6MyHArQxnP/hB6//2hoBVf4HEw98nXAUP81i3uSRTMNkC3E/X0zMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880970; c=relaxed/simple;
	bh=pUGiK76B/cGSXLCAJDeQJWe6X+z6/ttgCiv66ralV/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvGO4s9mEsV1YASNo7YSZHhvPy09kmvO20+cQujnQPbyIsWE1GcEWerT6dwIl+PxfPpH1/gz0kp2ki6LUw0rD+xx8/GILh0ttJmEVIOQ9saxx1c29T3/wToqaQeldiJVhYcTs9NlIRn2HOrufph16IGq+r5ErTaSYjjXb5rkZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gskfN7qS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gskfN7qS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 501BE1C25;
	Tue,  8 Sep 2026 08:22:35 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C2B13F7B4;
	Tue,  8 Sep 2026 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788880959; bh=pUGiK76B/cGSXLCAJDeQJWe6X+z6/ttgCiv66ralV/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gskfN7qSBPy6MuEKz8Un2ZUKEgtO6KEC1SWbKnxWytEIDx8PPUQzFNihP42j5W7zq
	 0i5+xaHppTKDOkWBkdE3YzcShsEZah45LBGq8gPRcwXFPWMDn6yUTgS1YUkHKp5aZN
	 mKuKlcfePaufoszVXlqhc5u+uTH15SqI7kx+nm6Q=
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
	usama.anjum@arm.com,
	vladimir.murzin@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: [PATCH v4 13/21] arm64: entry: sdei: Make 'tsk' available
Date: Tue,  8 Sep 2026 16:17:33 +0100
Message-Id: <20260908151741.394589-14-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260908151741.394589-1-mark.rutland@arm.com>
References: <20260908151741.394589-1-mark.rutland@arm.com>
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

