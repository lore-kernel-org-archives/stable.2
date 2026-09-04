Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231004FC8C9
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541020; cv=none; b=bHCdp2uPLom5uqgS7cRDaDTWovrI/cxvuIT3e2jCd+qL82jXRBlNxSKr2wiQwlqto2iC7jmvpzwcF1o2zkTKsY17rNjTgSaE0OLV8GVD+AiIX+ZJ9CB+95spzQWH0j+NlOUUhvcu5rrosGChMGSQ33+ikA5oY74QfFQdwY7bGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541020; c=relaxed/simple;
	bh=BsIvtuBar/wrgFohR+cdVkNa49fe8IIL2JvmYClbIJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKtgRzqFETyTkaIfRbvJIRHRSZQf1Puffo8rhBEqRbfnbK5AekVLjj5nTlviBw5736Zu9ZOO2W0Bjd/XDwW/LWW2SKTpHXJytOiWvROHUGUV/+dMgC5Lnw/y9GAucFLlV7XTNhgu2k9tnJYJX6aUBgIXHKXTESNpMXyU+Xj+gHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UbNZ1D6R; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UbNZ1D6R"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD2F7152B;
	Fri,  4 Sep 2026 09:56:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62C4F3F673;
	Fri,  4 Sep 2026 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788541017; bh=BsIvtuBar/wrgFohR+cdVkNa49fe8IIL2JvmYClbIJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbNZ1D6REv1YuYqNYJcYvohjzWV5QmbxuVanheSQlYywlQSNDR/YE4KNA3p304l3A
	 GTr0xvzSLqMvry3I6apxTE4AdCPFb/awFSLGsWw5dUA14K8lKCRsVvs13FO9+LAWFC
	 0G+M4C+7Xg1mPi2fSJTyD9VNoqO9Je+LEqN+lENU=
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
Subject: [PATCH v3 04/21] arm64: cmpxchg: LL/SC: Avoid redundant extension
Date: Fri,  4 Sep 2026 17:56:49 +0100
Message-Id: <20260904165649.376930-1-mark.rutland@arm.com>
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

The __ll_sc__cmpxchg_case_##name##sz() template always takes 'old' as an
unsigned long. When 'sz' is less than 32 bits, the 'old' is explicitly
truncated so that old[31:sz-1] is zero, which is necessary so that the
W-register EOR+CBNZ sequence doesn't fail spuriously.

For 32-bit types specifically, no extension is necessary, but as 'old'
is 64 bits, the caller must extend 'old' to 64 bits. This leads to a
redundant instruction (typically a MOV) to extend the value, as can be
seen from disassembly of the test case below.

Avoid this by always taking 'old' as a 'u##sz' type, and explicitly
zero-extend this to a 64-bit or 32-bit type matching the X or W register
used by the assembly. To make this work, the table of cases now
explicitly lists 'x' for the cases where an X register is used.

For 32-bit types this removes the redundant instruction. For 64-bit
types there is no truncation, and hence no change. For {16,8}-bit types,
the existing zero-extension to 64-bit is equivalent to the new
zero-extension to 32-bit, and compilers happen to use the same
instructions for this.

I've placed the logic for zero extension into a new <asm/xwreg.h> header
as it will be used by other logic in subsequent patches.

Test case:

| u32 outline_cmpxchg_u32(u32 *p, u32 o, u32 n)
| {
|         return cmpxchg(p, o, n);
| }

Before this patch:

| <outline_cmpxchg_u32>:
|        b       1f
|        casal   w1, w2, [x0]
|        mov     w0, w1
|        ret
| 1:     mov     w3, w1
|        prfm    pstl1strm, [x0]
| 2:     ldxr    w1, [x0]
|        eor     w4, w1, w3
|        cbnz    w4, 3f
|        stlxr   w4, w2, [x0]
|        cbnz    w4, 2b
|        dmb     ish
| 3:     mov     w0, w1
|        ret

After this patch:

| <outline_cmpxchg_u32>:
|        b       1f
|        casal   w1, w2, [x0]
|        mov     w0, w1
|        ret
| 1:     prfm    pstl1strm, [x0]
| 2:     ldxr    w3, [x0]
|        eor     w4, w3, w1
|        cbnz    w4, 3f
|        stlxr   w4, w2, [x0]
|        cbnz    w4, 2b
|        dmb     ish
| 3:     mov     w0, w3
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
 arch/arm64/include/asm/atomic_ll_sc.h | 27 +++++++++++++--------------
 arch/arm64/include/asm/xwreg.h        | 16 ++++++++++++++++
 2 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/include/asm/xwreg.h

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 89d2ba2723590..160c1251f0ec9 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -11,6 +11,7 @@
 #define __ASM_ATOMIC_LL_SC_H
 
 #include <linux/stringify.h>
+#include <asm/xwreg.h>
 
 #ifndef CONFIG_CC_HAS_K_CONSTRAINT
 #define K
@@ -239,20 +240,17 @@ __ll_sc_atomic64_dec_if_positive(atomic64_t *v)
 #define __CMPXCHG_CASE(w, sfx, name, sz, mb, acq, rel, cl, constraint)	\
 static __always_inline u##sz						\
 __ll_sc__cmpxchg_case_##name##sz(volatile void *ptr,			\
-					 unsigned long old,		\
+					 u##sz old,			\
 					 u##sz new)			\
 {									\
+	/*                                                              \
+	 * Sub-word sizes require zero extension so that EOR+CBNZ won't	\
+	 * consume non-zero upper bits of the register containing "old".\
+	 */								\
+	xwreg_t(w) cmpval = xwreg_zero_extend(old, w, sz);		\
 	unsigned long tmp;						\
 	u##sz oldval;							\
 									\
-	/*								\
-	 * Sub-word sizes require explicit casting so that the compare  \
-	 * part of the cmpxchg doesn't end up interpreting non-zero	\
-	 * upper bits of the register containing "old".			\
-	 */								\
-	if (sz < 32)							\
-		old = (u##sz)old;					\
-									\
 	asm volatile(							\
 	"	prfm	pstl1strm, %[v]\n"				\
 	"1:	ld" #acq "xr" #sfx "\t%" #w "[oldval], %[v]\n"		\
@@ -264,7 +262,8 @@ __ll_sc__cmpxchg_case_##name##sz(volatile void *ptr,			\
 	"2:"								\
 	: [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),			\
 	  [v] "+Q" (*(u##sz *)ptr)					\
-	: [old] __stringify(constraint) "r" (old), [new] "r" (new)	\
+	: [old] __stringify(constraint) "r" (cmpval),			\
+	  [new] "r" (new)						\
 	: cl);								\
 									\
 	return oldval;							\
@@ -278,19 +277,19 @@ __ll_sc__cmpxchg_case_##name##sz(volatile void *ptr,			\
 __CMPXCHG_CASE(w, b,     ,  8,        ,  ,  ,         , K)
 __CMPXCHG_CASE(w, h,     , 16,        ,  ,  ,         , K)
 __CMPXCHG_CASE(w,  ,     , 32,        ,  ,  ,         , K)
-__CMPXCHG_CASE( ,  ,     , 64,        ,  ,  ,         , L)
+__CMPXCHG_CASE(x,  ,     , 64,        ,  ,  ,         , L)
 __CMPXCHG_CASE(w, b, acq_,  8,        , a,  , "memory", K)
 __CMPXCHG_CASE(w, h, acq_, 16,        , a,  , "memory", K)
 __CMPXCHG_CASE(w,  , acq_, 32,        , a,  , "memory", K)
-__CMPXCHG_CASE( ,  , acq_, 64,        , a,  , "memory", L)
+__CMPXCHG_CASE(x,  , acq_, 64,        , a,  , "memory", L)
 __CMPXCHG_CASE(w, b, rel_,  8,        ,  , l, "memory", K)
 __CMPXCHG_CASE(w, h, rel_, 16,        ,  , l, "memory", K)
 __CMPXCHG_CASE(w,  , rel_, 32,        ,  , l, "memory", K)
-__CMPXCHG_CASE( ,  , rel_, 64,        ,  , l, "memory", L)
+__CMPXCHG_CASE(x,  , rel_, 64,        ,  , l, "memory", L)
 __CMPXCHG_CASE(w, b,  mb_,  8, dmb ish,  , l, "memory", K)
 __CMPXCHG_CASE(w, h,  mb_, 16, dmb ish,  , l, "memory", K)
 __CMPXCHG_CASE(w,  ,  mb_, 32, dmb ish,  , l, "memory", K)
-__CMPXCHG_CASE( ,  ,  mb_, 64, dmb ish,  , l, "memory", L)
+__CMPXCHG_CASE(x,  ,  mb_, 64, dmb ish,  , l, "memory", L)
 
 #undef __CMPXCHG_CASE
 
diff --git a/arch/arm64/include/asm/xwreg.h b/arch/arm64/include/asm/xwreg.h
new file mode 100644
index 0000000000000..d55e3ac68f7eb
--- /dev/null
+++ b/arch/arm64/include/asm/xwreg.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_XWREG_H
+#define __ASM_XWREG_H
+
+#include <asm/types.h>
+
+#define __xwreg_t_x		u64
+#define __xwreg_t_w		u32
+#define xwreg_t(xw)		__xwreg_t_##xw
+
+/*
+ * Zero extend 'v' from 'sz' bits (8/16/32/64) to fill an X or W register.
+ */
+#define xwreg_zero_extend(v, xw, sz)	((xwreg_t(xw))(u##sz)(v))
+
+#endif /* __ASM_XWREG_H */
-- 
2.30.2

