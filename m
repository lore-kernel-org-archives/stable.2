Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D314FB9BC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540971; cv=none; b=h4SROaA4u9D16j0cUH6ktUnyedQQCbzzLq8Q4uRhIw8ee3+3oUN8rnDTDQrARxmBp+GbIdI41yLPYhkvtCemIynxyEOTRpHCE9c+lxc/ldH/kvBwllmXFs3LvCTecJoRN9rIKWUvXLnNSqwQgOTer7MA8fky6d9FgRlezDtdQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540971; c=relaxed/simple;
	bh=+urC92fTi5p2Xjzo7KYfLK0V4wF1Ttkp4PL7+WZOhQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okl+3omCljDk55NyqMIWPFsIMFs053djwpKEVoDvVFZXHtxBIS4tB/n2Admd6UqQFMXIJr4ApKcYU2DWUtzvO6cGhWri7WAn6X1CUR18ZC/ldOXFmMI6JxoJOCqHuqHGiSdM3BT+xLfIdtWnjl845IMJpfEp0MfAmdD6Y6baFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=chu+8afO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="chu+8afO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02E15152B;
	Fri,  4 Sep 2026 09:56:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5E6C3F673;
	Fri,  4 Sep 2026 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788540968; bh=+urC92fTi5p2Xjzo7KYfLK0V4wF1Ttkp4PL7+WZOhQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chu+8afOWTBQLSxqW2RzALf9LMbiinW9KHMVuD9kbrgEkDhix1jMh/k7GDEWOkEU8
	 k+fJ5RpxaSDpP9jX6/VIia6ZE0Z5+EnK6TD0if8xtSpR4UN0ssCMIKWetJuS3kWrXS
	 7K8yu40a2r9hvzpoLEZ9R1kcPMURAMUfreMsCMz0=
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
Subject: [PATCH v3 02/21] arm64: percpu: Fix this_cpu_and() mask generation
Date: Fri,  4 Sep 2026 17:56:00 +0100
Message-Id: <20260904165600.376877-1-mark.rutland@arm.com>
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

The arm64 implementation of this_cpu_and(pcp, val) is built in terms of
ANDNOT operations, which requires the 'val' argument to be bitwise
negated. The bitwise negation is not implemented correctly, with two
bugs described below.

(1) The bitwise negation is performed as '~val' rather than '~(val)'.
    This won't always generate the expected value when 'val' is an
    expression.

    For example, for this_cpu_and(pcp, 1 - 1):

    * 'val'    is  '1 - 1'   ===> (int) 0x00000000
    * '~val'   is '~1 - 1'   ===> (int) 0xfffffffd
    * '~(val)' is '~(1 - 1)' ===> (int) 0xffffffff

    ... and thus bit[1] of 'pcp' would be preserved unexpectedly by the
    ANDNOT operation.

(2) The bitwise negation is performed on 'val' before it has been cast
    to (at least) the width of 'pcp'. This won't always generate the
    expected value for the upper bits.

    For example, for this_cpu_and(pcp, zero), where 'pcp' is a u64 and
    'zero' is a u32:

    * 'zero'           ===> (u32) 0x00000000
    * '~(zero)'        ===> (u32) 0xffffffff
    * '(u64)~(zero)'   ===> (u64) 0x00000000ffffffff
    * '~((u64)(zero))' ===> (u64) 0xffffffffffffffff

    ... and thus bits[63:32] of 'pcp' would be preserved unexpectedly by
    the ANDNOT operation.

Fix these issues by adding brackets around 'val', and by casting 'val'
to an appropriately-sized type before bitwise negation.

The bugs described above can be seen from the disassembly of the
following test code:

| void this_cpu_and_u64_zero(u64 __percpu *pcp)
| {
|         u64 zero = 0;
|         this_cpu_and(*pcp, zero);
| }
|
| void this_cpu_and_u32_zero(u64 __percpu *pcp)
| {
|         u32 zero = 0;
|         this_cpu_and(*pcp, zero);
| }
|
| void this_cpu_and_expr_zero(u64 __percpu *pcp)
| {
|         this_cpu_and(*pcp, 1 - 1);
| }
|
| void this_cpu_and_expr_zero_brackets(u64 __percpu *pcp)
| {
|         this_cpu_and(*pcp, (1 - 1));
| }

Before this patch:

| <this_cpu_and_u64_zero>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x1, sp_el0
|        mov     x29, sp
|        ldr     w2, [x1, #8]
|        add     w2, w2, #0x1
|        str     w2, [x1, #8]
|        mov     x3, #0xffffffffffffffff         // #-1
|        mrs     x2, tpidr_el1
|        add     x0, x0, x2
| 1:     ldxr    x5, [x0]
|        bic     x5, x5, x3
|        stxr    w4, x5, [x0]
|        cbnz    w4, 1b
|        ldr     x0, [x1, #8]
|        add     x0, x0, x3
|        str     w0, [x1, #8]
|        cbz     x0, 2f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 3f
| 2:     bl      preempt_schedule_notrace
| 3:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret
|
| <this_cpu_and_u32_zero>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x1, sp_el0
|        mov     x29, sp
|        ldr     w2, [x1, #8]
|        add     w2, w2, #0x1
|        str     w2, [x1, #8]
|        mov     x3, #0xffffffff                 // #4294967295
|        mrs     x2, tpidr_el1
|        add     x0, x0, x2
| 1:     ldxr    x5, [x0]
|        bic     x5, x5, x3
|        stxr    w4, x5, [x0]
|        cbnz    w4, 1b
|        ldr     x0, [x1, #8]
|        sub     x0, x0, #0x1
|        str     w0, [x1, #8]
|        cbz     x0, 2f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 3f
| 2:     bl      preempt_schedule_notrace
| 3:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret
|
| <this_cpu_and_expr_zero>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x1, sp_el0
|        mov     x29, sp
|        ldr     w2, [x1, #8]
|        add     w2, w2, #0x1
|        str     w2, [x1, #8]
|        mov     x3, #0xfffffffffffffffd         // #-3
|        mrs     x2, tpidr_el1
|        add     x0, x0, x2
| 1:     ldxr    x5, [x0]
|        bic     x5, x5, x3
|        stxr    w4, x5, [x0]
|        cbnz    w4, 1b
|        ldr     x0, [x1, #8]
|        sub     x0, x0, #0x1
|        str     w0, [x1, #8]
|        cbz     x0, 2f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 3f
| 2:     bl      preempt_schedule_notrace
| 3:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret

After this patch:

| <this_cpu_and_u64_zero>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x1, sp_el0
|        mov     x29, sp
|        ldr     w2, [x1, #8]
|        add     w2, w2, #0x1
|        str     w2, [x1, #8]
|        mov     x3, #0xffffffffffffffff         // #-1
|        mrs     x2, tpidr_el1
|        add     x0, x0, x2
| 1:     ldxr    x5, [x0]
|        bic     x5, x5, x3
|        stxr    w4, x5, [x0]
|        cbnz    w4, 1b
|        ldr     x0, [x1, #8]
|        add     x0, x0, x3
|        str     w0, [x1, #8]
|        cbz     x0, 2f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 3f
| 2:     bl      0 <preempt_schedule_notrace>
| 3:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret
|
| <this_cpu_and_u32_zero>:
|        b       this_cpu_and_u64_zero
|
| <this_cpu_and_expr_zero>:
|        b       this_cpu_and_u64_zero
|
| <this_cpu_and_expr_zero_brackets>:
|        b       this_cpu_and_u64_zero

Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Acked-by: Christopher Lameter (Ampere) <cl@gentwo.org>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/percpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 63bbfd4944a37..31193bcf89a2b 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -206,13 +206,13 @@ PERCPU_RET_OP(add, add, ldadd)
 	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
 
 #define this_cpu_and_1(pcp, val)	\
-	_pcp_protect(__percpu_andnot_case_8, pcp, ~val)
+	_pcp_protect(__percpu_andnot_case_8, pcp, ~(u8)(val))
 #define this_cpu_and_2(pcp, val)	\
-	_pcp_protect(__percpu_andnot_case_16, pcp, ~val)
+	_pcp_protect(__percpu_andnot_case_16, pcp, ~(u16)(val))
 #define this_cpu_and_4(pcp, val)	\
-	_pcp_protect(__percpu_andnot_case_32, pcp, ~val)
+	_pcp_protect(__percpu_andnot_case_32, pcp, ~(u32)(val))
 #define this_cpu_and_8(pcp, val)	\
-	_pcp_protect(__percpu_andnot_case_64, pcp, ~val)
+	_pcp_protect(__percpu_andnot_case_64, pcp, ~(u64)(val))
 
 #define this_cpu_or_1(pcp, val)		\
 	_pcp_protect(__percpu_or_case_8, pcp, val)
-- 
2.30.2

