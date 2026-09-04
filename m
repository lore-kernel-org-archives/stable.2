Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF124FB9A6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538753; cv=none; b=WNXRCW2tEtPJ6cmYZVk4GTzo9/foVTvNMR5oVPS9T7uXEYpmtM6GOlLPhKNAlSjfsYA2isDJCQ3vg3VIOk3Bdy7l2hsxp4oa+/Z8621dejvo5HjHyAEWxDU9PxCx6Iso3LI6Zh9wC8E3SahkMOXQ32B//i7PuuVZ+WhruBJguPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538753; c=relaxed/simple;
	bh=IkSLmCvkfNucuZa5pjOOMJu7wxmHLN+BpWa/Zg98QUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJ1x/tYsb5bHRNOcjgjntbjBOTpTYNAbPFh5KO9r8PSF1K7Aeb7ZPNgrhVCfcMoFbordb4DdltoGuaxDSIBDEvlf1OL2jA1FaQGzPZ00Wtdz8g8I6ftcifMcuKroRxZ/GA1E/cgKZpJcZQ8crwLfHwsNUroOmfPZa/D6zoTcrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CACXboHw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CACXboHw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE500152B;
	Fri,  4 Sep 2026 09:19:06 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76B193F673;
	Fri,  4 Sep 2026 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538750; bh=IkSLmCvkfNucuZa5pjOOMJu7wxmHLN+BpWa/Zg98QUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CACXboHwjorluT9f6fvpvYPUAEPxhg5czfb/kIAgfDsSnQpRu18OxG6euH3zhPl/M
	 /BBk+gSUglLl0dH8rSNp8i5N3kBVQTFSnDpbiB8sOIB7PeTCkUb3yE1YD2QC3+gOP7
	 9W9I5PqLuxiL41nKrkMCyFNDT0yOdJm1Ii62lRLs=
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
Subject: [PATCH v3 18/21] arm64: percpu: Implement preemptible XCHG ops
Date: Fri,  4 Sep 2026 17:17:55 +0100
Message-Id: <20260904161758.376504-19-mark.rutland@arm.com>
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

Use the PCPU GPR infrastructure to implement all of the xchg ops

Test case:

| u64 outline_xchg_name(u64 *p, u64 v)
| {
| 	return xchg(p, v);
| }

Generated code before this patch (v7.2-rc4):

| <outline_this_cpu_xchg_u64>:
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
|        prfm    pstl1strm, [x2]
| 1:     ldxr    x0, [x2]
|        stxr    w5, x1, [x2]
|        cbnz    w5, 1b
|        ldr     x1, [x3, #8]
|        sub     x1, x1, #0x1
|        str     w1, [x3, #8]
|        cbz     x1, 2f
|        ldr     x1, [x3, #8]
|        cbnz    x1, 3f
| 2:     str     x0, [sp, #24]
|        bl      preempt_schedule_notrace
|        ldr     x0, [sp, #24]
| 3:     ldp     x29, x30, [sp], #32
|        autiasp
|        ret

Generated code after this patch:

| <outline_this_cpu_xchg_u64>:
|        mrs     x3, sp_el0
|        mov     w5, #0x10a0
|        strh    w5, [x3, #20]
|        mrs     x5, tpidr_el1
|        add     x4, x0, x5
|        prfm    pstl1strm, [x4]
| 1:     ldxr    x2, [x4]
|        stxr    w6, x1, [x4]
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
 arch/arm64/include/asm/percpu.h | 57 ++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 9fe44d04c871b..820340c61d70f 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -269,6 +269,50 @@ PERCPU_RET_OP(add, add, ldadd)
 #undef PERCPU_OP
 #undef PERCPU_RET_OP
 
+#define PERCPU_XCHG_OP(w, sfx, sz)					\
+static inline unsigned long						\
+__percpu_xchg_case_##sz(void __percpu *pcp, u##sz val)			\
+{									\
+	u16 *gprs = &current_thread_info()->pcpu_gprs;			\
+	unsigned long addr;						\
+	unsigned long off;						\
+	unsigned int loop;						\
+	unsigned long ret;						\
+									\
+	asm volatile (							\
+	__PCPU_GPRS_BEGIN("%[gprs]", "%[pcp]", "%[off]", "%[addr]")	\
+	ARM64_LSE_ATOMIC_INSN(						\
+	/* LL/SC */							\
+	"	prfm	pstl1strm, [%[addr]]\n"				\
+	"1:	ldxr" #sfx "\t%" #w "[ret], [%[addr]]\n"		\
+	"	stxr" #sfx "\t%w[loop], %" #w "[val], [%[addr]]\n"	\
+	"	cbnz	%w[loop], 1b\n"					\
+	,								\
+	/* LSE atomics */						\
+	"	swp" #sfx "\t%" #w "[val], %" #w "[ret], [%[addr]]\n"	\
+		__nops(3)						\
+	)								\
+	__PCPU_GPRS_END("%[gprs]")					\
+	: [gprs] "=Qo" (*gprs),						\
+	  [addr] "=&r" (addr),						\
+	  [off] "=&r" (off),						\
+	  [loop] "=&r" (loop),						\
+	  [ret] "=&r" (ret)						\
+	: [pcp] "r" (pcp),						\
+	  [val] "r" (val)						\
+	: "memory"							\
+	);								\
+									\
+	return ret;							\
+}
+
+PERCPU_XCHG_OP(w, b, 8)
+PERCPU_XCHG_OP(w, h, 16)
+PERCPU_XCHG_OP(w,  , 32)
+PERCPU_XCHG_OP(x,  , 64)
+
+#undef PERCPU_XCHG_OP
+
 /*
  * It would be nice to avoid the conditional call into the scheduler when
  * re-enabling preemption for preemptible kernels, but doing that in a way
@@ -306,6 +350,11 @@ PERCPU_RET_OP(add, add, ldadd)
 	(typeof(pcp))op(&(pcp), ##args);				\
 })
 
+#define _pcp_wrap_xchg(op, pcp, val)					\
+({									\
+	(typeof(pcp))op(&(pcp), (unsigned long)(val));			\
+})
+
 #define this_cpu_read_1(pcp)		\
 	_pcp_wrap_return(__percpu_read_8, pcp)
 #define this_cpu_read_2(pcp)		\
@@ -361,13 +410,13 @@ PERCPU_RET_OP(add, add, ldadd)
 	_pcp_wrap(__percpu_or_case_64, pcp, val)
 
 #define this_cpu_xchg_1(pcp, val)	\
-	_pcp_protect_return(xchg_relaxed, pcp, val)
+	_pcp_wrap_xchg(__percpu_xchg_case_8, pcp, val)
 #define this_cpu_xchg_2(pcp, val)	\
-	_pcp_protect_return(xchg_relaxed, pcp, val)
+	_pcp_wrap_xchg(__percpu_xchg_case_16, pcp, val)
 #define this_cpu_xchg_4(pcp, val)	\
-	_pcp_protect_return(xchg_relaxed, pcp, val)
+	_pcp_wrap_xchg(__percpu_xchg_case_32, pcp, val)
 #define this_cpu_xchg_8(pcp, val)	\
-	_pcp_protect_return(xchg_relaxed, pcp, val)
+	_pcp_wrap_xchg(__percpu_xchg_case_64, pcp, val)
 
 #define this_cpu_cmpxchg_1(pcp, o, n)	\
 	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
-- 
2.30.2

