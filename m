Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340C4949E8
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863176; cv=none; b=BU5wy6iQMXjuN6mTt4JxKLYiEaLpLzK5h6B9XFIZqFVOfrMPwbGwATzTHT/8elZ7zYJ6DeoozLxIxpKYd23fv5ODSQwY85GdJ7KPfAbDw+NeYWzLHAZLfIWYcVu+kdLCU0UrdnkNaBxVpN7iIXi6zbaPcKgdsb2gmpbWJYSwqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863176; c=relaxed/simple;
	bh=GqzmHYtgEjIxP+UFJ5lv+pjfRoiYR8pz4lfNF7Y/PDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPk1jXARyXpY/7/2FzaD7pOTBDOgIb05ChOwAiJ9oz3h4K6I1W+kgQvPaSqr4VGcAT9vbV1Bh7pbsAWpR8Halia7yqRCqEFEwS2Oym8RijxpteTgg5QU/elCOQVHi9et6TMT88unHqMsttuTjLCssDRS49O2ZmIY8046AlLWpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UlPHatFp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UlPHatFp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71618165C;
	Tue,  4 Aug 2026 10:05:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F2123F632;
	Tue,  4 Aug 2026 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785863162; bh=GqzmHYtgEjIxP+UFJ5lv+pjfRoiYR8pz4lfNF7Y/PDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlPHatFpFMdOgqcQWfYHzrMdjUt79Sfy0Ff+qU5+ZnEd8m3jhkDW3sDvmzIuVtK0w
	 5psWaaTxQ//79YuRn6MHKbcmcNl71Ze84eaKNC8kmIWw04biRbKgQQqsdmnLkhH03B
	 WbqTiRb56B1eYGuymjgHrrCnAraSqEupi4MDnMgA=
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
Subject: [PATCH v2 11/20] arm64: entry: sdei: Restore all clobberable GPRs
Date: Tue,  4 Aug 2026 18:04:54 +0100
Message-Id: <20260804170503.3513916-12-mark.rutland@arm.com>
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

Currently __sdei_asm_handler() avoids restoring x20 to x27, as these are
not be clobbered by existing code. This is correct today, but it makes
it awkward to rework __sdei_asm_handler(). Given the rarity of SDEI
events, restoring x20 to x27 should not have a measurable impact.

Restore x20 to x27 when returning from an SDEI event handler. This will
free up those GPRs for usage in __sdei_asm_handler() prior to return.

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
 arch/arm64/kernel/entry.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e0db14e9c843a..eadf4e74e72a8 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1048,10 +1048,14 @@ SYM_CODE_START(__sdei_asm_handler)
 	bl	__sdei_handler
 
 	msr	sp_el0, x28
-	/* restore regs >x17 that we clobbered */
+	/* restore regs >x17 that firmware won't restore */
 	mov	x4, x19         // keep x4 for __sdei_asm_exit_trampoline
-	ldp	x28, x29, [x4, #SDEI_EVENT_INTREGS + 16 * 14]
 	ldp	x18, x19, [x4, #SDEI_EVENT_INTREGS + 16 * 9]
+	ldp	x20, x21, [x4, #SDEI_EVENT_INTREGS + 16 * 10]
+	ldp	x22, x23, [x4, #SDEI_EVENT_INTREGS + 16 * 11]
+	ldp	x24, x25, [x4, #SDEI_EVENT_INTREGS + 16 * 12]
+	ldp	x22, x27, [x4, #SDEI_EVENT_INTREGS + 16 * 13]
+	ldp	x28, x29, [x4, #SDEI_EVENT_INTREGS + 16 * 14]
 	ldp	lr, x1, [x4, #SDEI_EVENT_INTREGS + S_LR]
 	mov	sp, x1
 
-- 
2.30.2

