Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835554570D5
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863132; cv=none; b=BzrlRoS8unS8n/f6hcg/SN0YEvr5lPB+IY0ZXeKyRhgoUA5t1Ac5o+vVsFo6EJTmOifTlaYWtrcx/icmvGMCCTL2ZqFnU7dQUNqUYE1J14e9PzMuFwtpbV/XAyP4lRkUgZkuUkVy8Gi7FlyDX2BUu+DjEJ3icfc+4oMIAdbfxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863132; c=relaxed/simple;
	bh=WVzy+CFQzZ9ki8AaGr2tZyokJVK18eIfmnCV3Kgx2R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dodXtVHyfF38IbDJILz8Z9ZwBYGn+c3NeShS5I/vj7KelP/xfl94oiZDECsfqfnkdVePJt4PCt/cCYDMTyIckQxToTXr+aQNw1C9Bc37bvO8pIXwii0njMUp72bANolxkF1XZfzFB8ni6PsTBUKZS3qHhldOl6vTwX+2oTvL9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sGehTrTU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sGehTrTU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 533831684;
	Tue,  4 Aug 2026 10:05:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CFE643F632;
	Tue,  4 Aug 2026 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785863120; bh=WVzy+CFQzZ9ki8AaGr2tZyokJVK18eIfmnCV3Kgx2R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGehTrTUwMenQPYItLGFO9Vpv7W1HiuDEAatv/sjFrxlAx3wLHPoXTh4GY2NfFKSX
	 BlUKhI5zrxRUz8aSlfnPPqzQRtlKyDECCx4QSn3HAsKzijYJm5luPkrCPgChQH/8O5
	 o59yg178gbY80vIMcCK8WHGJbvw61cewmODJs6EQ=
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
	vladimir.murzin@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: [PATCH v2 01/20] arm64: percpu: Fix this_cpu_write() casting
Date: Tue,  4 Aug 2026 18:04:44 +0100
Message-Id: <20260804170503.3513916-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260804170503.3513916-1-mark.rutland@arm.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 implementation of this_cpu_write() casts 'val' to unsigned
long. This is necessary to handle cases where 'val' is a pointer type,
and to avoid spurious compiler warnings for the (unreachable!) cases
where the pointer type would be cast to a smaller integer type.

Unfortunately, the cast is applied to 'val' rather than '(val)', which
won't always generate the expected value when 'val' is an expression.

For example, for this_cpu_write(pcp, zero - 1), where 'pcp' is a u64 and
'zero' is a u32:

* 'zero'                      ===> (u32) 0x00000000
* 'zero - 1'                  ===> (u32) 0xffffffff
* '(unsigned long)zero - 1'   ===> (u64) 0xffffffffffffffff
* '(unsigned long)(zero - 1)' ===> (u64) 0x00000000ffffffff

Fix this by adding brackets around 'val'

The bug described above can be seen from the disassembly of the
following test code:

| void this_cpu_write_zero_minus_1(u64 __percpu *pcp)
| {
| 	u32 zero = 0;
| 	this_cpu_write(*pcp, zero - 1);
| }
|
| void this_cpu_write_zero_minus_1_brackets(u64 __percpu *pcp)
| {
| 	u32 zero = 0;
| 	this_cpu_write(*pcp, (zero - 1));
| }

Generated code before this patch:

| <this_cpu_write_zero_minus_1>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x1, sp_el0
|        mov     x29, sp
|        ldr     w2, [x1, #8]
|        add     w2, w2, #0x1
|        str     w2, [x1, #8]
|        mov     x3, #0xffffffffffffffff
|        mrs     x2, tpidr_el1
|        str     x3, [x0, x2]
|        ldr     x0, [x1, #8]
|        add     x0, x0, x3
|        str     w0, [x1, #8]
|        cbz     x0, 1f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 2f
| 1:     bl      preempt_schedule_notrace
| 2:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret
|
| <this_cpu_write_zero_minus_1_brackets>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x1, sp_el0
|        mov     x29, sp
|        ldr     w2, [x1, #8]
|        add     w2, w2, #0x1
|        str     w2, [x1, #8]
|        mov     x3, #0xffffffff
|        mrs     x2, tpidr_el1
|        str     x3, [x0, x2]
|        ldr     x0, [x1, #8]
|        sub     x0, x0, #0x1
|        str     w0, [x1, #8]
|        cbz     x0, 1f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 2f
| 1:     bl      preempt_schedule_notrace
| 2:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Generated code after this patch:

| <this_cpu_write_zero_minus_1>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x1, sp_el0
|        mov     x29, sp
|        ldr     w2, [x1, #8]
|        add     w2, w2, #0x1
|        str     w2, [x1, #8]
|        mov     x3, #0xffffffff
|        mrs     x2, tpidr_el1
|        str     x3, [x0, x2]
|        ldr     x0, [x1, #8]
|        sub     x0, x0, #0x1
|        str     w0, [x1, #8]
|        cbz     x0, 1f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 2f
| 1:     bl      preempt_schedule_notrace
| 2:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret
|
| <this_cpu_write_zero_minus_1_brackets>:
|        b       this_cpu_write_zero_minus_1

Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
Reported-by: David Laight <david.laight.linux@gmail.com>
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
 arch/arm64/include/asm/percpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index b57b2bb009677..63bbfd4944a37 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -179,13 +179,13 @@ PERCPU_RET_OP(add, add, ldadd)
 	_pcp_protect_return(__percpu_read_64, pcp)
 
 #define this_cpu_write_1(pcp, val)	\
-	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
+	_pcp_protect(__percpu_write_8, pcp, (unsigned long)(val))
 #define this_cpu_write_2(pcp, val)	\
-	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
+	_pcp_protect(__percpu_write_16, pcp, (unsigned long)(val))
 #define this_cpu_write_4(pcp, val)	\
-	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
+	_pcp_protect(__percpu_write_32, pcp, (unsigned long)(val))
 #define this_cpu_write_8(pcp, val)	\
-	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
+	_pcp_protect(__percpu_write_64, pcp, (unsigned long)(val))
 
 #define this_cpu_add_1(pcp, val)	\
 	_pcp_protect(__percpu_add_case_8, pcp, val)
-- 
2.30.2

