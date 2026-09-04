Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBF4A9D48
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538723; cv=none; b=J2W2f8Vxu/rB5h+QUV50e5oJ7SrHYzq8EPZccJlskdHi9/SXBLLktYhYdnq7KZjmw9PI/o8+4UqgxUwCo+2EYG4DdWH6mXAIvkAfjwTDy2OhfXRZ/bStVGz2VwEJRaazndoeJ5qIuVV3jmWKP/qwcMwK7jdP/8p6/+cGa5sfN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538723; c=relaxed/simple;
	bh=Dku5Deo1eRRXqpsPtgYa4sf2TVZxd3PZhvBhEyKq1EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJVDizMQX9ewqyPMCJXF6z7YzpuqIZmzaOegd2PX4cO9BnmO9JpUN+heXwV4s5UN8gN39nFtisygMokoAxfhDUgwzsyNuJWfuzGgLhmydPqkLoAoS4hZ6jXEIS7NiN9spZBVDPMnkoc0pTNuy3bM/idG/NJyLdp4QkBUeKJcBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HL3AgFia; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HL3AgFia"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 818B61595;
	Fri,  4 Sep 2026 09:18:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F1F33FBD2;
	Fri,  4 Sep 2026 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538720; bh=Dku5Deo1eRRXqpsPtgYa4sf2TVZxd3PZhvBhEyKq1EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HL3AgFiaPLEiFmTJz7F1HxgNKFrTuFJMuiLp8Ng7WEz3wOuxClIpuRtDfsS9A/owU
	 rilQPzsYqVxdlp3s0lXVPey0y0bmJ0WNLJU76OcBUXQiMspFqdruooCWgQB256lk9o
	 Zf/JKCY8DSbp1WkfduD92kVlXZfr34BVAx/AZIaw=
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
Subject: [PATCH v3 05/21] arm64: cmpxchg128: LSE: Remove redundant operands
Date: Fri,  4 Sep 2026 17:17:42 +0100
Message-Id: <20260904161758.376504-6-mark.rutland@arm.com>
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

The LSE assembly for cmpxhg128*() has redundant operands which cause
unnecessary register pressure. These operands can be removed without
adverse effects, as described below.

It is necessary to force specific registers for the 64-bit halves of
'old' and 'new', as the encoding of CASP[A][L] requires that these
halves are allocated into even/odd register pairs, and contemporary
versions of LLVM don't support a mechanism to allocate a value into an
even/odd register pair for inline assembly. We manually allocate these
into x0/x1/x2/x3.

It is not necessary to force the address into a specific register, as
the encoding of CASP[A][L] can accept this in any GPR or SP. Hence, it
is not necessary to manually allocate the address into x4 for the
'[ptr]' operand. The assembly uses the '[v]' operand, and contemporary
compilers happen to allocate '[v]' into a separate register from
'[ptr]', meaning that '[ptr]' only serves to create register pressure.

It is not necessary to allocate the '[oldval1]' and '[oldval2]'
operands, as these are not used by the assembly. The assembly uses the
'[old1]' and '[old2]' operands for both input and output. The
'[oldval1]' and '[oldval2]' operands only serve to create register
pressure.

Remove the redundant operands. This saves on register pressure, as
demonstrated by the test case below. There's still some unfortunate
register shuffling due to the manual allocation of 'old' and 'new', but
this should be less prominent within a larger function.

Test case:

| u128 outline_cmpxchg128(u128 *p, u128 old, u128 new)
| {
| 	return cmpxchg128(p, old, new);
| }

Generated code before this patch:

| <outline_cmpxchg128>:
|        mov     x6, x0
|        mov     x1, x3
|        mov     x0, x2
|        b       1f
|        mov     x2, x4
|        mov     x3, x5
|        mov     x4, x6
|        mov     x5, x0
|        mov     x7, x1
|        caspal  x0, x1, x2, x3, [x6]
|        ret
| 1:     prfm    pstl1strm, [x6]
| 2:     ldxp    x8, x7, [x6]
|        cmp     x8, x0
|        ccmp    x7, x3, #0x0, eq
|        b.ne    3f
|        stlxp   w2, x4, x5, [x6]
|        cbnz    w2, 2b
|        dmb     ish
| 3:     mov     x0, x8
|        mov     x1, x7
|        ret

Generated code after this patch:

| <outline_cmpxchg128>:
|        mov     x6, x0
|        mov     x0, x2
|        b       1f
|        mov     x1, x3
|        mov     x2, x4
|        mov     x3, x5
|        caspal  x0, x1, x2, x3, [x6]
|        ret
| 1:     prfm    pstl1strm, [x6]
| 2:     ldxp    x8, x7, [x6]
|        cmp     x8, x0
|        ccmp    x7, x3, #0x0, eq
|        3f
|        stlxp   w2, x4, x5, [x6]
|        cbnz    w2, 2b
|        dmb     ish
| 3:     mov     x0, x8
|        mov     x1, x7
|        ret

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
 arch/arm64/include/asm/atomic_lse.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index afad1849c4cf5..d588af0565331 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -291,15 +291,13 @@ __lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
 	register unsigned long x1 asm ("x1") = o.high;			\
 	register unsigned long x2 asm ("x2") = n.low;			\
 	register unsigned long x3 asm ("x3") = n.high;			\
-	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
 									\
 	asm volatile(							\
 	__LSE_PREAMBLE							\
 	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
 	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
 	  [v] "+Q" (*(u128 *)ptr)					\
-	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
-	  [oldval1] "r" (o.low), [oldval2] "r" (o.high)			\
+	: [new1] "r" (x2), [new2] "r" (x3)				\
 	: cl);								\
 									\
 	r.low = x0; r.high = x1;					\
-- 
2.30.2

