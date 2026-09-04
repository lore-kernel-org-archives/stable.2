Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657ED4A9D78
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538718; cv=none; b=EdMBhcZlTTrStGg+taZIJLk3pZFBOMuCJjLSHSgDNzu22YWYryb3cXG3QvulZW2oRjXfk7PBMKD4HU7e5uU3FAokNTaTyDlLuV8YIH+5gjMVs8ock2RsLgxNySO3cFTwEYorU5tpeysv9/m41sky2SX9oJzXwFG5LDB25bKVQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538718; c=relaxed/simple;
	bh=VNTopBOMSkbcm9JObmGqJlQAEJJ4Esr4E5Inmoq7/1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mash4blyZirBstV2hnnBIT4bBr+GBJc0wCR7iww9ld5ZP4kvbKevgvTf24KDw0uOsL1myDdOZQ73J/FFYx7CT6xjRGsuW+KJCY6mpHTfaO2rbvj5BJZEt1SyRWewpwal2SLzZqOE1B7cDvEl2Kx42jYp1hCCY3rjNY4//Lv8lLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FnElP0XC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FnElP0XC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDD4E152B;
	Fri,  4 Sep 2026 09:18:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 951143FB7F;
	Fri,  4 Sep 2026 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538715; bh=VNTopBOMSkbcm9JObmGqJlQAEJJ4Esr4E5Inmoq7/1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnElP0XC/Lud9MIzr6OOcRyDIulmEImgxyNGRQpXnKCWyBPRz0FY6RkwT9wIiDI22
	 2GCgirH2Y+Se8pYXG99OcBgFochdX/us/Mg2eygivxq4J3kk9x3cOWPzbLpDxBnX4R
	 Y8PDF2A5Xik9DKwuqCMjp4joWDf/XqvqaDTg1ZJM=
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
Subject: [PATCH v3 03/21] arm64: percpu: Fix LSE operations on {8,16}-bit types
Date: Fri,  4 Sep 2026 17:17:40 +0100
Message-Id: <20260904161758.376504-4-mark.rutland@arm.com>
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

The assembly for __percpu_##name##_case_##sz() and
__percpu_##name##_return_case_##sz() doesn't use the 'sfx' macro
argument to form the LSE instruction. Without 'sfx', a W register
argument will imply a 32-bit memory location, and consequently
{8,16}-bit ops will erroneously read and write 32 bits of memory when
the LSE instruction is used.

Fix this by appending 'sfx' to 'op_lse' to LSE instruction. It is not
necessary (and not valid) to append 'sfx' to 'op_llsc', as 'op_llsc' is
a register-register operation which does not access memory (and does not
take a size suffix).

Test case:

| void outline_this_cpu_add_u8(u8 __percpu *p, u8 v)
| {
| 	this_cpu_add(*p, v);
| }

Generated inline code (same before and after this patch):

| <outline_this_cpu_add_u8>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x2, sp_el0
|        mov     x29, sp
|        ldr     w3, [x2, #8]
|        add     w3, w3, #0x1
|        str     w3, [x2, #8]
|        mrs     x3, tpidr_el1
|        add     x0, x0, x3
| 1:     ldxrb   w5, [x0]        // <----------------
|        add     w5, w5, w1      // LL/SC alternative
|        stxrb   w4, w5, [x0]    // instructions here
|        cbnz    w4, 1b          // <----------------
|        ldr     x0, [x2, #8]
|        sub     x0, x0, #0x1
|        str     w0, [x2, #8]
|        cbz     x0, 2f
|        ldr     x0, [x2, #8]
|        cbnz    x0, 3f
| 2:     bl      preempt_schedule_notrace
| 3:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Generated LSE alternative before this patch:

|        ldadd   w1, w5, [x0]    // 32-bit LDADD
|        nop
|        nop
|        nop

Generated LSE alternative after this patch:

|        ldaddb  w1, w5, [x0]    // 8-bit LDADDB
|        nop
|        nop
|        nop

Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
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
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 31193bcf89a2b..8cf4068ce1b56 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -77,7 +77,7 @@ __percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
 	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
+		#op_lse #sfx "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
 		__nops(3))						\
 	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
 	  [ptr] "+Q"(*(u##sz *)ptr)					\
@@ -98,7 +98,7 @@ __percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
 	"	stxr" #sfx "\t%w[loop], %" #w "[ret], %[ptr]\n"		\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
+		#op_lse #sfx "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
 		#op_llsc "\t%" #w "[ret], %" #w "[ret], %" #w "[val]\n"	\
 		__nops(2))						\
 	: [loop] "=&r" (loop), [ret] "=&r" (ret),			\
-- 
2.30.2

