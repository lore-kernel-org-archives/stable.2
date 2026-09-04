Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310D4E13EC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538757; cv=none; b=eaD78NAhVyD9tI/56qHyufyy1ICorG7KDAk2IgBORS5fFwQ0b2vG3D0+Ub6LaM2G2ozEB96wS1NLt8p+RTYdYXEM8MvYML/q7X8rmR8Img+BmY5A6C9O3/oMQZAzdyHOJPd9VGniiOxRJ8GCHn4cdoJf0s+Tlrj+8UBjSe9HYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538757; c=relaxed/simple;
	bh=ulS9e57JOpVuxlf/+qzYMC41G5m8IkihwUPBziATUvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b55mucWbuvoPqqPkyf27zHRPKQfS1QTENlLld7og9sd7F9+fyHJGAT8jzYntbT3o98bs+5JCGyoZhgPtZTIKTsLH6emgZntqryZJHQbV1iwLDHXHs/+uwrrmYNEqp7bKiRHxCwWgHg+M05e15X5r2b56fx/n1Ii3BuoWqgZ7IM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EXkyg96W; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EXkyg96W"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0DE1FC4;
	Fri,  4 Sep 2026 09:19:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 20CBD3F673;
	Fri,  4 Sep 2026 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538755; bh=ulS9e57JOpVuxlf/+qzYMC41G5m8IkihwUPBziATUvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXkyg96WQ/98cWTYDCCR8rmhD1JRF6iYNWWVdQmrD3pOiVnSppi+OUljuC223mog9
	 1j2mCOLV0RL7uAej6pTkk1+tkgCvp2M3O1jsVR3H/bGdMHyDV6fH2o8M2f/vejZake
	 x8rdPdRIWGftdi1CRc9EWL0gdwLH4/pajLRix97U=
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
Subject: [PATCH v3 20/21] arm64: percpu: Implement preemptible CMPXCHG128 ops
Date: Fri,  4 Sep 2026 17:17:57 +0100
Message-Id: <20260904161758.376504-21-mark.rutland@arm.com>
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

Use the PCPU GPR infrastructure to implement this_cpu_cmpxchg128().

Note that before this patch, the LL/SC and LSE implementation was chosen
with an alternative branch. After this patch the implementations are
patched inline, matching the style of the other percpu ops.

The sub-optimal register shuffling before and after this patch occurs
because we hard-code specific registers, as LLVM (currently) lacks a way
to place a 128-bit type in a compiler-allocated even-odd pair of
registers for inline assembly. We should be able to improve that in
future, given compiler support.

Test case:

| u128 outline_this_cpu_cmpxchg128(u128 __percpu *p, u128 old, u128 new)
| {
| 	return this_cpu_cmpxchg128(*p, old, new);
| }

Generated code before this patch (v7.2-rc4):

| <outline_this_cpu_cmpxchg128>:
|        paciasp
|        stp     x29, x30, [sp, #-32]!
|        mov     x6, x0
|        mov     x0, x2
|        mov     x29, sp
|        mov     x1, x3
|        mrs     x2, sp_el0
|        ldr     w7, [x2, #8]
|        add     w7, w7, #0x1
|        str     w7, [x2, #8]
|        mrs     x2, tpidr_el1
|        add     x6, x6, x2
|        b       4f
|        mov     x2, x4
|        mov     x3, x5
|        mov     x4, x6
|        mov     x5, x0
|        mov     x7, x1
|        casp    x0, x1, x2, x3, [x6]
| 1:     mrs     x3, sp_el0
|        ldr     x2, [x3, #8]
|        sub     x2, x2, #0x1
|        str     w2, [x3, #8]
|        cbz     x2, 2f
|        ldr     x2, [x3, #8]
|        cbnz    x2, 3f
| 2:     stp     x0, x1, [sp, #16]
|        bl      preempt_schedule_notrace
|        ldp     x0, x1, [sp, #16]
| 3:     ldp     x29, x30, [sp], #32
|        autiasp
|        ret
| 4:     prfm    pstl1strm, [x6]
| 5:     ldxp    x8, x7, [x6]
|        cmp     x8, x0
|        ccmp    x7, x3, #0x0, eq
|        b.ne    6f
|        stxp    w2, x4, x5, [x6]
|        cbnz    w2, 5b
| 6:     mov     x0, x8
|        mov     x1, x7
|        b       1b

Generated code after this patch:

| <outline_this_cpu_cmpxchg128>:
|        mov     x6, x0
|        mov     x1, x3
|        mov     x0, x2
|        mov     x3, x5
|        mrs     x7, sp_el0
|        mov     x2, x4
|        mov     w5, #0x10a6
|        strh    w5, [x7, #20]
|        mrs     x5, tpidr_el1
|        add     x4, x6, x5
|        prfm    pstl1strm, [x4]
| 1:     ldxp    x9, x10, [x4]
|        cmp     x9, x0
|        ccmp    x10, x1, #0x0, eq
|        b.ne    2f
|        stxp    w8, x2, x3, [x4]
|        cbnz    w8, 1b
| 2:     strh    wzr, [x7, #20]
|        mov     x0, x9
|        mov     x1, x10
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
 arch/arm64/include/asm/percpu.h | 70 +++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index f19a82437b3fd..5cd98e20e825d 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -490,19 +490,63 @@ PERCPU_CMPXCHG_OP(x,  , 64)
 
 #define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
 
-#define this_cpu_cmpxchg128(pcp, o, n)					\
-({									\
-	typedef typeof(pcp) pcp_op_T__;					\
-	u128 old__, new__, ret__;					\
-	pcp_op_T__ *ptr__;						\
-	old__ = o;							\
-	new__ = n;							\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp));					\
-	ret__ = cmpxchg128_local((void *)ptr__, old__, new__);		\
-	preempt_enable_notrace();					\
-	ret__;								\
-})
+static inline u128
+__percpu_cmpxchg_128(void __percpu *pcp, u128 old, u128 new)
+{
+	u16 *gprs = &current_thread_info()->pcpu_gprs;
+	unsigned long addr;
+	unsigned long off;
+	union __u128_halves r, o = { .full = (old) },
+			       n = { .full = (new) };
+	register unsigned long ol asm ("x0") = o.low;
+	register unsigned long oh asm ("x1") = o.high;
+	register unsigned long nl asm ("x2") = n.low;
+	register unsigned long nh asm ("x3") = n.high;
+	unsigned long rl, rh;
+	unsigned long tmp;
+
+	asm volatile (
+	__PCPU_GPRS_BEGIN("%[gprs]", "%[pcp]", "%[off]", "%[addr]")
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+       "       prfm    pstl1strm, [%[addr]]\n"
+       "1:     ldxp    %[rl], %[rh], [%[addr]]\n"
+       "       cmp     %[rl], %[ol]\n"
+       "       ccmp    %[rh], %[oh], 0, eq\n"
+       "       b.ne    2f\n"
+       "       stxp    %w[tmp], %[nl], %[nh], [%[addr]]\n"
+       "       cbnz    %w[tmp], 1b\n"
+       "2:\n"
+	,
+	/* LSE atomics */
+	"	casp	%[ol], %[oh], %[nl], %[nh], [%[addr]]\n"
+	"	mov	%[rl], %[ol]\n"
+	"	mov	%[rh], %[oh]\n"
+	__nops(4)
+	)
+	__PCPU_GPRS_END("%[gprs]")
+	: [gprs] "=Qo" (*gprs),
+	  [addr] "=&r" (addr),
+	  [off] "=&r" (off),
+	  [tmp] "=&r" (tmp),
+	  [ol] "+&r" (ol),
+	  [oh] "+&r" (oh),
+	  [rl] "=&r" (rl),
+	  [rh] "=&r" (rh)
+	: [pcp] "r" (pcp),
+	  [nl] "r" (nl),
+	  [nh] "r" (nh)
+	: "memory", "cc"
+	);
+
+	r.low = rl;
+	r.high = rh;
+
+	return r.full;
+}
+
+#define this_cpu_cmpxchg128(pcp, o, n)	\
+	_pcp_wrap_return(__percpu_cmpxchg_128, pcp, o, n)
 
 #ifdef __KVM_NVHE_HYPERVISOR__
 extern unsigned long __hyp_per_cpu_offset(unsigned int cpu);
-- 
2.30.2

