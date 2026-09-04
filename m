Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559CA3BFAEE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538740; cv=none; b=j87gb8Wki7ovjd0RwhhU0K02j5LBKaXE3ilK2zjvtVYOWxhDK7+XH2CQPfLZ7D7e1gyo/VT+tj3KsG3Uof1C2MJ7JTNYHTjgZ5bsyMIuVDtFxEX5eoLzyJQ8HlaGL1iZJNyIF0/6nV4IHr02aAH1Sr62w6cqQE5+o550q/4Z5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538740; c=relaxed/simple;
	bh=pUyEkl4bH7bjN7cz2XbK3Pl6rivIm/Z5yqVzikq2V+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSp5BKNzH+n3ndOJazbR06lzcqpsrp+TYpHDCg1TcR5BOBbuGBx13TTqKGnDQbrqLvk6NGtxiOY//KK2720vvu2nqTsLI13TKa0OG/upg13Kiw5KCcGyoHO0nbNCFp6pmliR0sO+/AAkgl4jRIH+cGKph5ayc7m68jpwmwgxSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rQhs7b3F; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rQhs7b3F"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9165153B;
	Fri,  4 Sep 2026 09:18:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 822F23F8D6;
	Fri,  4 Sep 2026 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538736; bh=pUyEkl4bH7bjN7cz2XbK3Pl6rivIm/Z5yqVzikq2V+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQhs7b3FjaUZd3YeBRcvwQCaIPNsMAYiIycOFk7VjmlIpt26wAOPUSLOlThOrUSlx
	 btY/r2SeucKbi0Dwn5UsfCqT4euj/pDMewj/YEvm7troIiQjoG+90qr4oVV9zJtTjG
	 MBzAG9jnJAdvmAa8NPinTIQr0iFLEHmbRCiJj6Ds=
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
Subject: [PATCH v3 12/21] arm64: entry: sdei: Restore all clobberable GPRs
Date: Fri,  4 Sep 2026 17:17:49 +0100
Message-Id: <20260904161758.376504-13-mark.rutland@arm.com>
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

Currently __sdei_asm_handler() avoids restoring x20 to x27, as these are
not be clobbered by existing code. This is correct today, but it makes
it awkward to rework __sdei_asm_handler(). Given the rarity of SDEI
events, restoring x20 to x27 should not have a measurable impact.

Restore x20 to x27 when returning from an SDEI event handler. This will
free up those GPRs for usage in __sdei_asm_handler() prior to return.

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
 arch/arm64/kernel/entry.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f63049ac32dc6..a6ec5c5a2d29c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1044,10 +1044,14 @@ SYM_CODE_START(__sdei_asm_handler)
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
+	ldp	x26, x27, [x4, #SDEI_EVENT_INTREGS + 16 * 13]
+	ldp	x28, x29, [x4, #SDEI_EVENT_INTREGS + 16 * 14]
 	ldp	lr, x1, [x4, #SDEI_EVENT_INTREGS + S_LR]
 	mov	sp, x1
 
-- 
2.30.2

