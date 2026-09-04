Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30634FDE62
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538756; cv=none; b=Wnz2hR9pqSx+MYGRdUBa/nf/aIWUR5X/PIW4Ln+B6gqz5FQVn+4/Hz5aT0Pr37kcI24B8VAyzoVbznV+D5DOKzEH4grnf0tf46Gt+Z/+FkeQ/xp9slZLrejmLB3JGrHNQnHR6n/Rz/7aaX6mWQD7kcAvJRhEOqbbtWvo5pG+QTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538756; c=relaxed/simple;
	bh=weSg9lKsIHE/83qMW/SyU4ojYrTWn2q+C4WdqveaRvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpa08Cqz+dgAmzulnmmmNP2jepTeZk/hR75TCDQyzshO5/4rEPrIy2wtwl1AkTZHVGnORR1z6yY//E8+Dj7SaRxukh6jC/mZMdkYerTkUQy9JfJp0uxzsyX8P+5jPIc1mszR8GKq46v44VvviW6URdemE02xF2Ds/7dfxaElok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a4hap3h3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a4hap3h3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1928D1BCA;
	Fri,  4 Sep 2026 09:19:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5E503F673;
	Fri,  4 Sep 2026 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538752; bh=weSg9lKsIHE/83qMW/SyU4ojYrTWn2q+C4WdqveaRvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4hap3h3C5OV/1PtxcADwm+sdkgAHNCMw6GTY0aLOrd78pYQBCnfUlLXLTf+WNgQv
	 vDxUMotFxfUDGdz1UdbnLaPOdzCMSyLUidtRSlHb0R3p4jY+/SiJ8mV7NRNC0SiTAi
	 SsaDtQDHYxXYtZKwgBpM0uzTdsCssq1vqmH1IkJ4=
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
Subject: [PATCH v3 19/21] arm64: percpu: Implement preemptible CMPXCHG ops
Date: Fri,  4 Sep 2026 17:17:56 +0100
Message-Id: <20260904161758.376504-20-mark.rutland@arm.com>
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

Use the PCPU GPR infrastructure to implement all of the {8,16,32,64}-bit
cmpxchg ops.

Note that before this patch, the LL/SC and LSE implementation was chosen
with an alternative branch. After this patch the implementations are
patched inline, matching the style of the other percpu ops.

Test case:

| u64 outline_this_cpu_cmpxchg_u64(u64 __percpu *p, u64 o, u64 n)
| {
| 	return this_cpu_cmpxchg(*p, o, n);
| }

Generated code before this patch (v7.2-rc4):

| <outline_this_cpu_cmpxchg_u64>:
|        paciasp
|        stp     x29, x30, [sp, #-32]!
|        mrs     x4, sp_el0
|        mov     x29, sp
|        ldr     w3, [x4, #8]
|        add     w3, w3, #0x1
|        str     w3, [x4, #8]
|        mrs     x3, tpidr_el1
|        add     x3, x0, x3
|        b       4f		// alternative branch
|        cas     x1, x2, [x3]
|        mov     x0, x1
| 1:     mrs     x2, sp_el0
|        ldr     x1, [x2, #8]
|        sub     x1, x1, #0x1
|        str     w1, [x2, #8]
|        cbz     x1, 2f
|        ldr     x1, [x2, #8]
|        cbnz    x1, 3f
| 2:     str     x0, [sp, #24]
|        bl      preempt_schedule_notrace
|        ldr     x0, [sp, #24]
| 3:     ldp     x29, x30, [sp], #32
|        autiasp
|        ret
| 4:     prfm    pstl1strm, [x3]
| 5:     ldxr    x0, [x3]
|        eor     x4, x0, x1
|        cbnz    x4, 6f
|        stxr    w4, x2, [x3]
|        cbnz    w4, 5b
| 6:     b       1b

Generated code after this patch:

| <outline_this_cpu_cmpxchg_u64>:
|        mrs     x4, sp_el0
|        mov     w6, #0x14c0
|        strh    w6, [x4, #20]
|        mrs     x6, tpidr_el1
|        add     x5, x0, x6
|        prfm    pstl1strm, [x5]
| 1:     ldxr    x3, [x5]
|        eor     x7, x3, x1
|        cbnz    x7, 2f
|        stxr    w7, x2, [x5]
|        cbnz    w7, 1b
| 2:     strh    wzr, [x4, #20]
|        mov     x0, x3
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
 arch/arm64/include/asm/percpu.h | 69 +++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 820340c61d70f..f19a82437b3fd 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -306,12 +306,67 @@ __percpu_xchg_case_##sz(void __percpu *pcp, u##sz val)			\
 	return ret;							\
 }
 
+#define PERCPU_CMPXCHG_OP(w, sfx, sz)					\
+static inline unsigned long						\
+__percpu_cmpxchg_case_##sz(void __percpu *pcp,				\
+			   u##sz old,					\
+			   u##sz new)					\
+{									\
+	/*                                                              \
+	 * Sub-word sizes require zero extension so that EOR+CBNZ don't	\
+	 * consume non-zero upper bits of the register containing "old".\
+	 */								\
+	xwreg_t(w) cmpval = xwreg_zero_extend(old, w, sz);		\
+	u16 *gprs = &current_thread_info()->pcpu_gprs;			\
+	unsigned long addr;						\
+	unsigned long off;						\
+	unsigned long tmp;						\
+	unsigned long oldval;						\
+									\
+	asm volatile (							\
+	__PCPU_GPRS_BEGIN("%[gprs]", "%[pcp]", "%[off]", "%[addr]")	\
+	ARM64_LSE_ATOMIC_INSN(						\
+	/* LL/SC */							\
+	"	prfm	pstl1strm, [%[addr]]\n"				\
+	"1:	ldxr" #sfx "\t%" #w "[oldval], [%[addr]]\n"		\
+	"	eor	%" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"	\
+	"	cbnz	%" #w "[tmp], 2f\n"				\
+	"	stxr" #sfx "\t%w[tmp], %" #w "[new], [%[addr]]\n"	\
+	"	cbnz	%w[tmp], 1b\n"					\
+	"2:\n"								\
+	,								\
+	/* LSE atomics */						\
+	"	mov	%" #w "[oldval], %" #w "[old]\n"		\
+	"	cas" #sfx "\t%" #w "[oldval], %" #w "[new], [%[addr]]\n"\
+		__nops(4)						\
+	)								\
+	__PCPU_GPRS_END("%[gprs]")					\
+	: [gprs] "=Qo" (*gprs),						\
+	  [addr] "=&r" (addr),						\
+	  [off] "=&r" (off),						\
+	  [tmp] "=&r" (tmp),						\
+	  [oldval] "=&r" (oldval)					\
+	: [pcp] "r" (pcp),						\
+	  [old] "r" (cmpval),						\
+	  [new] "r" (new)						\
+	: "memory"							\
+	);								\
+									\
+	return oldval;							\
+}
+
 PERCPU_XCHG_OP(w, b, 8)
 PERCPU_XCHG_OP(w, h, 16)
 PERCPU_XCHG_OP(w,  , 32)
 PERCPU_XCHG_OP(x,  , 64)
 
+PERCPU_CMPXCHG_OP(w, b, 8)
+PERCPU_CMPXCHG_OP(w, h, 16)
+PERCPU_CMPXCHG_OP(w,  , 32)
+PERCPU_CMPXCHG_OP(x,  , 64)
+
 #undef PERCPU_XCHG_OP
+#undef PERCPU_CMPXCHG_OP
 
 /*
  * It would be nice to avoid the conditional call into the scheduler when
@@ -355,6 +410,12 @@ PERCPU_XCHG_OP(x,  , 64)
 	(typeof(pcp))op(&(pcp), (unsigned long)(val));			\
 })
 
+#define _pcp_wrap_cmpxchg(op, pcp, old, new)				\
+({									\
+	(typeof(pcp))op(&(pcp), (unsigned long)(old),			\
+			(unsigned long)(new));				\
+})
+
 #define this_cpu_read_1(pcp)		\
 	_pcp_wrap_return(__percpu_read_8, pcp)
 #define this_cpu_read_2(pcp)		\
@@ -419,13 +480,13 @@ PERCPU_XCHG_OP(x,  , 64)
 	_pcp_wrap_xchg(__percpu_xchg_case_64, pcp, val)
 
 #define this_cpu_cmpxchg_1(pcp, o, n)	\
-	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+	_pcp_wrap_cmpxchg(__percpu_cmpxchg_case_8, pcp, o, n)
 #define this_cpu_cmpxchg_2(pcp, o, n)	\
-	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+	_pcp_wrap_cmpxchg(__percpu_cmpxchg_case_16, pcp, o, n)
 #define this_cpu_cmpxchg_4(pcp, o, n)	\
-	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+	_pcp_wrap_cmpxchg(__percpu_cmpxchg_case_32, pcp, o, n)
 #define this_cpu_cmpxchg_8(pcp, o, n)	\
-	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+	_pcp_wrap_cmpxchg(__percpu_cmpxchg_case_64, pcp, o, n)
 
 #define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
 
-- 
2.30.2

