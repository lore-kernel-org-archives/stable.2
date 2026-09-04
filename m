Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F451476C
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541051; cv=none; b=tyU/n1Zw3KEiqNWx9xGW7E6hB9zbsSpvbnnFzzAvhrv2aA99yERhLk5XoIQtWipDRmYCiX+JACPVqT8foFJ8OJGikuPKhuGW7QouvQVqn0B/kdE+tUlodrbkJD+bxK3Movwf39mbBGY4upDsHyFSWHegOoX6pARH52KJyKACNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541051; c=relaxed/simple;
	bh=mir7vooTSDYmWsVJZrTEgRVne7RAsc886omUddrknHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8+TU+KeYNQgRPmv/vBi9tYiyH/5AiNp7IuuJ6+tL3Kkghg7rSw7ylTFrdBlZZ6H/hpGNX1P6z/wShvvA3lGvn3mBvnwPbfMc7oKpeceLeXBUYoIAiqC7/TT4w64qum5UHikJmuOCzUvWEoRMrNpnlos1bzM9nIuXjbxgWLTR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qxzpoHOT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qxzpoHOT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E75153B;
	Fri,  4 Sep 2026 09:57:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3576D3F673;
	Fri,  4 Sep 2026 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788541048; bh=mir7vooTSDYmWsVJZrTEgRVne7RAsc886omUddrknHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxzpoHOTgWEdAhhYXCTrpUWRPuJpE0oydIVXIBLlipwaPhlOCOmKKbqc0M+RGkmPZ
	 nNFrwOptCCUypgLCxVkbijvBb02WOlMNTO2Boxi72bnAwyvnLZ682Vhxh3v9R/Qvxz
	 yaBQHfla4Z7lixsPss2Ty25w0ItkpgcV6FVhVKGs=
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
Subject: [PATCH v3 06/21] arm64: preempt: Simplify and optimize __preempt_count_dec_and_test()
Date: Fri,  4 Sep 2026 17:57:09 +0100
Message-Id: <20260904165709.376981-1-mark.rutland@arm.com>
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

In arm64's __preempt_count_dec_and_test(), the final conditional load of
'ti->preempt_count' is always executed in the common case. The
conditional load leads to unfortunate code generation for
preempt_enable[_notrace](), and it would be better to unconditionally
load 'ti->preempt_count', as described below.

On arm64, struct thread_info contains the following union:

| union {
|         u64             preempt_count;
|         struct {
|                 u32     count;
|                 u32     need_resched;
|         } preempt;
| };

Note: 'need_resched' is encoded so that '0' means a reschedule is
needed, and '1' means a reschedule is NOT needed.

The core logic of __preempt_count_dec_and_test() is:

| static inline bool __preempt_count_dec_and_test(void)
| {
|         struct thread_info *ti = current_thread_info();
|         u64 pc = READ_ONCE(ti->preempt_count);
|
|         WRITE_ONCE(ti->preempt.count, --pc);
|
|         return !pc || !READ_ONCE(ti->preempt_count);
| }

The '!pc' condition can only be true when both:

* The initial value of 'need_resched' was 0, meaning that a reschedule
  is needed. This should be rare.

* The initial value of 'count' was exactly 1. This cannot be true for a
  nested preempt_disable() ... preempt_enable() sequence.

Hence in common cases, '!pc' will be false, and it's necessary to
execute the final READ_ONCE(ti->preempt_count).

This results in a conditional branch in the common case, as can be seen
when __preempt_count_dec_and_test() is outlined:

| <outline___preempt_count_dec_and_test>:
|        mrs     x2, sp_el0
|        ldr     x1, [x2, #8]
|        mov     w0, #0x1
|        sub     x1, x1, #0x1
|        str     w1, [x2, #8]
|        cbz     x1, 1f
|        ldr     x0, [x2, #8]
|        cmp     x0, #0x0
|        cset    w0, eq  // eq = none
| 1:     ret

It would be better to avoid the special case for 'pc == 0', and to
always load 'ti->preempt_count' after decrementing 'ti->preempt.count'.
For the common cases this will remove a conditional branch. For the rare
cases where preemption is needed initially, this only adds a single
load, whose cost should be dominated by other factors.

Remove the special case for 'pc == 0', and always load the combined
'ti->preempt_count' after decrementing 'ti->preempt.count'.

The removal of the conditional branch helps with code generation, as the
compiler can more easily move a dependent slow path out-of-line, as
demonstrated with the following compiled with GCC 15.2.0:

| void outline_preempt_enable_notrace(void)
| {
|        preempt_enable_notrace();
| }

Before this patch:

| <outline_preempt_enable_notrace>:
|        mrs     x1, sp_el0
|        ldr     x0, [x1, #8]
|        sub     x0, x0, #0x1
|        str     w0, [x1, #8]
|        cbz     x0, 1f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 2f
| 1:     paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      preempt_schedule_notrace
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret
| 2:     ret

After this patch:

| <outline_preempt_enable_notrace>:
|        mrs     x0, sp_el0
|        ldr     w1, [x0, #8]
|        sub     w1, w1, #0x1
|        str     w1, [x0, #8]
|        ldr     x0, [x0, #8]
|        cbz     x0, 1f
|        ret
| 1:     paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      preempt_schedule_notrace
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/preempt.h | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 9ecc2766a9f21..92ae2eb95a738 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -75,30 +75,23 @@ static inline int __preempt_count_sub_return(int val)
 	return pc;
 }
 
-static inline bool __preempt_count_dec_and_test(void)
-{
-	struct thread_info *ti = current_thread_info();
-	u64 pc = READ_ONCE(ti->preempt_count);
-
-	/* Update only the count field, leaving need_resched unchanged */
-	WRITE_ONCE(ti->preempt.count, --pc);
-
-	/*
-	 * If we wrote back all zeroes, then we're preemptible and in
-	 * need of a reschedule. Otherwise, we need to reload the
-	 * preempt_count in case the need_resched flag was cleared by an
-	 * interrupt occurring between the non-atomic READ_ONCE/WRITE_ONCE
-	 * pair.
-	 */
-	return !pc || !READ_ONCE(ti->preempt_count);
-}
-
 static inline bool should_resched(int preempt_offset)
 {
 	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
 	return pc == preempt_offset;
 }
 
+static inline bool __preempt_count_dec_and_test(void)
+{
+	/*
+	 * We must load the combined 'prempt_count' after decrementing
+	 * 'preempt.count' as an interrupt could modify 'need_resched' before
+	 * __preempt_count_sub() writes back to 'preempt.count'.
+	 */
+	__preempt_count_sub(1);
+	return should_resched(0);
+}
+
 #ifdef CONFIG_PREEMPTION
 
 void preempt_schedule(void);
-- 
2.30.2

