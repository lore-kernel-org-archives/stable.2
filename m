Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E25592F4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881060; cv=none; b=FWzaNeRjiJwyohqZ+9AH6rVIbRjbXTnhheOwdHQeI9mLi6b3pneQNQm/YoHasGmvBXQKwJyTw+dFQD9fhVat0pucbI6V1e4MfRtYKEnw6Lx4+mUA3Hg0ZKwojtPPY4tz4IFvUnCqmED30MORcvnvEVozTJ8eqiAvA5Vs3kC+4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881060; c=relaxed/simple;
	bh=378UApzYUdHc7nA0s8Xze++4Y0fwfNuwVF3XfZVIDeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ly2nnhlEK6Oz5gzo1XQMhYwZrOKymwsIVu70y9wvzBFayg0u0JJumEkTb+RRi7tzHGPIHxyQdr+SsfKFKGuINpf2DxOOShdvbmh0+4ZSV5MErxvbjUugW0iy5eTOaiSKrGr9FI0HSG6o2Gupe/ndIUc9NelCCY1hzj2T9GLVHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=doAyOXC0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="doAyOXC0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66AF1C2B;
	Tue,  8 Sep 2026 08:24:06 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A36053F7B4;
	Tue,  8 Sep 2026 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788881050; bh=378UApzYUdHc7nA0s8Xze++4Y0fwfNuwVF3XfZVIDeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doAyOXC05BIkBRFLZB6O0nomsMx0uSsDRF9Crqiev7p8PMhWcU6Xv6wUB+s0ytXS2
	 Rr6VZlMQjcfBbfdVuDKIRhepOxl8lv48KUAq0cqgIbN0SVRxgUdenplQC9IQr+8nPj
	 rip2js+gAuaMHLArWD59E+QKAT2JD8v5hth4kfLA=
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
Subject: [PATCH v4 17/21] arm64: percpu: Implement preemptible return RMW ops
Date: Tue,  8 Sep 2026 16:17:37 +0100
Message-Id: <20260908151741.394589-18-mark.rutland@arm.com>
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

Use the PCPU GPR infrastructure to implement all of the RMW ops which
return a value.

Test case:

| u64 outline_this_cpu_add_return_u64(u64 __percpu *p, u64 v)
| {
| 	return this_cpu_add_return(*p, v);
| }

Generated code before this patch (v7.2-rc4):

| <outline_this_cpu_add_return_u64>:
|        paciasp
|        stp     x29, x30, [sp, #-32]!
|        mrs     x3, sp_el0
|        mov     x29, sp
|        ldr     w2, [x3, #8]
|        add     w2, w2, #0x1
|        str     w2, [x3, #8]
|        mov     x2, x0
|        mrs     x4, tpidr_el1
|        add     x2, x2, x4
| 1:     ldxr    x0, [x2]
|        add     x0, x0, x1
|        stxr    w5, x0, [x2]
|        cbnz    w5, 1b
|        ldr     x1, [x3, #8]
|        sub     x1, x1, #0x1
|        str     w1, [x3, #8]
|        cbz     x1, 2f
|        ldr     x1, [x3, #8]
|        cbnz    x1, 3f
| 2:     str     x0, [sp, #24]
|        bl      0 <preempt_schedule_notrace>
|        ldr     x0, [sp, #24]
| 3:     ldp     x29, x30, [sp], #32
|        autiasp
|        ret

Generated code after this patch:

| <outline_this_cpu_add_return_u64>:
|        mrs     x3, sp_el0
|        mov     w5, #0x10a0
|        strh    w5, [x3, #20]
|        mrs     x5, tpidr_el1
|        add     x4, x0, x5
| 1:     ldxr    x2, [x4]
|        add     x2, x2, x1
|        stxr    w6, x2, [x4]
|        cbnz    w6, 1b
|        strh    wzr, [x3, #20]
|        mov     x0, x2
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
 arch/arm64/include/asm/percpu.h | 36 ++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 504a7fefa2015..9fe44d04c871b 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -201,24 +201,36 @@ __percpu_##name##_case_##sz(void __percpu *pcp, unsigned long val)	\
 
 #define __PERCPU_RET_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\
 static inline u##sz							\
-__percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
+__percpu_##name##_return_case_##sz(void __percpu *pcp, unsigned long val)	\
 {									\
+	u16 *gprs = &current_thread_info()->pcpu_gprs;			\
+	unsigned long addr;						\
+	unsigned long off;						\
 	unsigned int loop;						\
 	u##sz ret;							\
 									\
-	asm volatile (ARM64_LSE_ATOMIC_INSN(				\
+	asm volatile (							\
+	__PCPU_GPRS_BEGIN("%[gprs]", "%[pcp]", "%[off]", "%[addr]")	\
+	ARM64_LSE_ATOMIC_INSN(						\
 	/* LL/SC */							\
-	"1:	ldxr" #sfx "\t%" #w "[ret], %[ptr]\n"			\
+	"1:	ldxr" #sfx "\t%" #w "[ret], [%[addr]]\n"		\
 		#op_llsc "\t%" #w "[ret], %" #w "[ret], %" #w "[val]\n"	\
-	"	stxr" #sfx "\t%w[loop], %" #w "[ret], %[ptr]\n"		\
+	"	stxr" #sfx "\t%w[loop], %" #w "[ret], [%[addr]]\n"	\
 	"	cbnz	%w[loop], 1b",					\
 	/* LSE atomics */						\
-		#op_lse #sfx "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
+		#op_lse #sfx "\t%" #w "[val], %" #w "[ret], [%[addr]]\n"\
 		#op_llsc "\t%" #w "[ret], %" #w "[ret], %" #w "[val]\n"	\
 		__nops(2))						\
-	: [loop] "=&r" (loop), [ret] "=&r" (ret),			\
-	  [ptr] "+Q"(*(u##sz *)ptr)					\
-	: [val] "r" ((u##sz)(val)));					\
+	__PCPU_GPRS_END("%[gprs]")					\
+	: [gprs] "=Qo" (*gprs),						\
+	  [addr] "=&r" (addr),						\
+	  [off] "=&r" (off),						\
+	  [loop] "=&r" (loop),						\
+	  [ret] "=&r" (ret)						\
+	: [pcp] "r" (pcp),						\
+	  [val] "r" ((u##sz)(val))					\
+	: "memory"							\
+	);								\
 									\
 	return ret;							\
 }
@@ -322,13 +334,13 @@ PERCPU_RET_OP(add, add, ldadd)
 	_pcp_wrap(__percpu_add_case_64, pcp, val)
 
 #define this_cpu_add_return_1(pcp, val)	\
-	_pcp_protect_return(__percpu_add_return_case_8, pcp, val)
+	_pcp_wrap_return(__percpu_add_return_case_8, pcp, val)
 #define this_cpu_add_return_2(pcp, val)	\
-	_pcp_protect_return(__percpu_add_return_case_16, pcp, val)
+	_pcp_wrap_return(__percpu_add_return_case_16, pcp, val)
 #define this_cpu_add_return_4(pcp, val)	\
-	_pcp_protect_return(__percpu_add_return_case_32, pcp, val)
+	_pcp_wrap_return(__percpu_add_return_case_32, pcp, val)
 #define this_cpu_add_return_8(pcp, val)	\
-	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
+	_pcp_wrap_return(__percpu_add_return_case_64, pcp, val)
 
 #define this_cpu_and_1(pcp, val)	\
 	_pcp_wrap(__percpu_andnot_case_8, pcp, ~(u8)(val))
-- 
2.30.2

