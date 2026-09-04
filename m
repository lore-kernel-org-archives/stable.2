Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F04B0CA0
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538745; cv=none; b=M2dqpzOE8n869WwKay1jCCu1jjbHJKCsOXnQVD2WEvHWfFuhxkZuJ1NmC+1p/iooYD+Og27ppMxnfMh0DGfcqYAmJU0XAScdabRSdLZHBexLM7VrN3ejELesJzMICtaQmWCy3/8ZHoYFQ4O9M8X8F7+nWf4ufVOrgO6is5LdEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538745; c=relaxed/simple;
	bh=Vs9u8mzEXViD8Vv/CNdwO/SfW5bYcOi6Omyxf47fU7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JcMSmKTnGSK7v6c/MsSAc/A5yxESxAQbycuKPr7CPEFhdQ6vNpCjIQpcyO5uWEcDDhiVt5igoQzRn2eL6WoWv7w6M3J4W6CH3vOcY+TxjhffybV9G5Epxzh/IMY4WzmcIUxFqYLIPXIQnqNSNK6fy7aN3X8LpteZtph7ETKH/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AWJbPPdX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AWJbPPdX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C36CE201B;
	Fri,  4 Sep 2026 09:18:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CBB23FB7F;
	Fri,  4 Sep 2026 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538743; bh=Vs9u8mzEXViD8Vv/CNdwO/SfW5bYcOi6Omyxf47fU7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWJbPPdX50hG0QW1qrpvjTWndUOXTjrQxBYh/tavXiKRPF0jeswmd2kF6pbfMwGlZ
	 fMDl6r/GDQ45QrhPkoC8IJ3Wv+fDnn7ql0Mi2wkyBknTnsQYNCRuBxMrgYo+h85icT
	 6G9YTDL9iMfPskBJ7grw6Esavv1e7xGASLhSruD0=
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
Subject: [PATCH v3 15/21] arm64: percpu: Implement preemptible read/write ops
Date: Fri,  4 Sep 2026 17:17:52 +0100
Message-Id: <20260904161758.376504-16-mark.rutland@arm.com>
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

Use the PCPU GPR infrastructure to implement preemptible this_cpu_read()
and this_cpu_write().

This change means that this_cpu_read() will always use a plain LDR, even
in LTO configurations where READ_ONCE() will use LDA[P]R. Using plain
LDR is preferable, given that the rationale for using LDA[P]R in
READ_ONCE() was to retain address dependencies against values written by
other CPUs, which isn't expected usage for this_cpu_read(). Using plain
LDR will enforce fewer ordering constraints.

Test case:

| void outline_this_cpu_write_u64(u64 __percpu *p, u64 v)
| {
| 	this_cpu_write(*p, v);
| }

Generated code before this patch (v7.2-rc4):

| <outline_this_cpu_write_u64>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x2, sp_el0
|        mov     x29, sp
|        ldr     w3, [x2, #8]
|        add     w3, w3, #0x1
|        str     w3, [x2, #8]
|        mrs     x3, tpidr_el1
|        str     x1, [x0, x3]
|        ldr     x0, [x2, #8]
|        sub     x0, x0, #0x1
|        str     w0, [x2, #8]
|        cbz     x0, 1f
|        ldr     x0, [x2, #8]
|        cbnz    x0, 2f
| 1:     bl      preempt_schedule_notrace
| 2:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Generated code after this patch:

| <outline_this_cpu_write_u64>:
|        mrs     x2, sp_el0
|        mov     w3, #0x7c60
|        strh    w3, [x2, #20]
|        mrs     x3, tpidr_el1
|        str     x1, [x0, x3]
|        strh    wzr, [x2, #20]
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
 arch/arm64/include/asm/percpu.h | 79 ++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 03fa916030fd1..984f69846cc09 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -128,15 +128,42 @@ static inline unsigned long __kern_my_cpu_offset(void)
 #define __my_cpu_offset __kern_my_cpu_offset()
 #endif
 
-#define PERCPU_RW_OPS(sz)						\
-static inline unsigned long __percpu_read_##sz(void *ptr)		\
-{									\
-	return READ_ONCE(*(u##sz *)ptr);				\
-}									\
-									\
-static inline void __percpu_write_##sz(void *ptr, unsigned long val)	\
-{									\
-	WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);				\
+#define PERCPU_RW_OPS(w, sfx, sz)						\
+static inline unsigned long __percpu_read_##sz(void __percpu *pcp)		\
+{										\
+	u16 *gprs = &current_thread_info()->pcpu_gprs;				\
+	unsigned long off;							\
+	unsigned long val;							\
+										\
+	asm volatile(								\
+	__PCPU_GPRS_BEGIN_OFFSET("%[gprs]", "%[pcp]", "%[off]")			\
+	"	ldr" #sfx "\t%" #w "[val], [%[pcp], %[off]]\n"			\
+	__PCPU_GPRS_END("%[gprs]")						\
+	: [gprs] "=Qo" (*gprs),							\
+	  [off] "=&r" (off),							\
+	  [val] "=&r" (val)							\
+	: [pcp] "r" (pcp)							\
+	: "memory"								\
+	);									\
+										\
+	return val;								\
+}										\
+										\
+static inline void __percpu_write_##sz(void __percpu *pcp, unsigned long val)	\
+{										\
+	u16 *gprs = &current_thread_info()->pcpu_gprs;				\
+	unsigned long off;							\
+										\
+	asm volatile(								\
+	__PCPU_GPRS_BEGIN_OFFSET("%[gprs]", "%[pcp]", "%[off]")			\
+	"	str" #sfx "\t%" #w "[val], [%[pcp], %[off]]\n"			\
+	__PCPU_GPRS_END("%[gprs]")						\
+	: [gprs] "=Qo" (*gprs),							\
+	  [off] "=&r" (off)							\
+	: [pcp] "r" (pcp),							\
+	  [val] "r" ((u##sz)val)						\
+	: "memory"								\
+	);									\
 }
 
 #define __PERCPU_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\
@@ -196,10 +223,10 @@ __percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
 	__PERCPU_RET_OP_CASE(w,  , name, 32, op_llsc, op_lse)		\
 	__PERCPU_RET_OP_CASE( ,  , name, 64, op_llsc, op_lse)
 
-PERCPU_RW_OPS(8)
-PERCPU_RW_OPS(16)
-PERCPU_RW_OPS(32)
-PERCPU_RW_OPS(64)
+PERCPU_RW_OPS(w, b, 8)
+PERCPU_RW_OPS(w, h, 16)
+PERCPU_RW_OPS(w,  , 32)
+PERCPU_RW_OPS( ,  , 64)
 
 /*
  * Use value-returning atomics for CPU-local ops as they are more likely
@@ -245,23 +272,33 @@ PERCPU_RET_OP(add, add, ldadd)
 	__retval;							\
 })
 
+#define _pcp_wrap(op, pcp, ...)						\
+({									\
+	op(&(pcp), __VA_ARGS__);					\
+})
+
+#define _pcp_wrap_return(op, pcp, args...)				\
+({									\
+	(typeof(pcp))op(&(pcp), ##args);				\
+})
+
 #define this_cpu_read_1(pcp)		\
-	_pcp_protect_return(__percpu_read_8, pcp)
+	_pcp_wrap_return(__percpu_read_8, pcp)
 #define this_cpu_read_2(pcp)		\
-	_pcp_protect_return(__percpu_read_16, pcp)
+	_pcp_wrap_return(__percpu_read_16, pcp)
 #define this_cpu_read_4(pcp)		\
-	_pcp_protect_return(__percpu_read_32, pcp)
+	_pcp_wrap_return(__percpu_read_32, pcp)
 #define this_cpu_read_8(pcp)		\
-	_pcp_protect_return(__percpu_read_64, pcp)
+	_pcp_wrap_return(__percpu_read_64, pcp)
 
 #define this_cpu_write_1(pcp, val)	\
-	_pcp_protect(__percpu_write_8, pcp, (unsigned long)(val))
+	_pcp_wrap(__percpu_write_8, pcp, (unsigned long)(val))
 #define this_cpu_write_2(pcp, val)	\
-	_pcp_protect(__percpu_write_16, pcp, (unsigned long)(val))
+	_pcp_wrap(__percpu_write_16, pcp, (unsigned long)(val))
 #define this_cpu_write_4(pcp, val)	\
-	_pcp_protect(__percpu_write_32, pcp, (unsigned long)(val))
+	_pcp_wrap(__percpu_write_32, pcp, (unsigned long)(val))
 #define this_cpu_write_8(pcp, val)	\
-	_pcp_protect(__percpu_write_64, pcp, (unsigned long)(val))
+	_pcp_wrap(__percpu_write_64, pcp, (unsigned long)(val))
 
 #define this_cpu_add_1(pcp, val)	\
 	_pcp_protect(__percpu_add_case_8, pcp, val)
-- 
2.30.2

