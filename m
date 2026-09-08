Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5F55C301
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880863; cv=none; b=EdoHT857MmONX4j672MGgdA7hlB8AUo8GdDZjyNMYIpuVbaVZDPhglj7wSR9fpmOwkaOWC+ghCQMIQUIzzaocnaRiioANZjxiE2sNpOTCVfGo68pf2/418QtiuWjAdghEIkDpXsVYgE0UVrB7d2/O0+DHtyB3LVcgjbzPWOdSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880863; c=relaxed/simple;
	bh=akjiP9r6aGZFVaFuTV4xO4inC06yx1CbzVLMerEToh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rh1mxuwTwdII8AFv7F8X1mK7PxzvkwsltV3ZHkQjBR6LEN+Ry/sFJV5nnhT5DLvQUq5ioGCqEg47xqOEmVg8bWDdGVuSv5FlR3qcDZzgki+04f3h7dA7SBqUv6g8aGqRXpDccCL7sEoV4Sxf/Yte+d50grrstlV4DNu1RV3vRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=juyitk4r; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="juyitk4r"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FCCE1C14;
	Tue,  8 Sep 2026 08:20:47 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E9CF3F7B4;
	Tue,  8 Sep 2026 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788880851; bh=akjiP9r6aGZFVaFuTV4xO4inC06yx1CbzVLMerEToh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=juyitk4rXxH7QunLguaLvhOqTlsgRMEYc3j1VnBt5kKETZe5FTe6EfrUQoqJ2T75+
	 FXd2iMiSOzgd6vcnXSOtyskCWPPHmZ6ZFKxbsB5uUVrRvKMjcAhDl5ahacSYuTnm6d
	 9+bNUN96WU/QS+D+2PpicZEDhohlxT1J/w0ZlJDA=
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
Subject: [PATCH v4 09/21] arm64: percpu: Factor out percpu offset asm
Date: Tue,  8 Sep 2026 16:17:29 +0100
Message-Id: <20260908151741.394589-10-mark.rutland@arm.com>
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

Depending on whether the kernel runs at EL1 or EL2, the percpu offset is
stored in either TPIDR_EL1 or TPIDR_EL2, and __kern_my_cpu_offset() uses
an ALTERNATIVE() sequence to read the relevant TPIDR_ELx.

In subsequent patches we'll need to read the percpu offset in other
assembly sequences. Factor the ALTERNATIVE sequence out of
__kern_my_cpu_offset() into a new __KERN_ASM_CPU_OFFSET() macro so that
we can share the code sequence.

There should be no functional change as a result of this patch.

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
 arch/arm64/include/asm/percpu.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 8cf4068ce1b56..746d2a56f48bb 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -29,6 +29,11 @@ static inline unsigned long __hyp_my_cpu_offset(void)
 	return read_sysreg(tpidr_el2);
 }
 
+#define __KERN_ASM_CPU_OFFSET(dst)					\
+	ALTERNATIVE("mrs " dst ", tpidr_el1",				\
+		    "mrs " dst ", tpidr_el2",				\
+		       ARM64_HAS_VIRT_HOST_EXTN)
+
 static inline unsigned long __kern_my_cpu_offset(void)
 {
 	unsigned long off;
@@ -37,11 +42,11 @@ static inline unsigned long __kern_my_cpu_offset(void)
 	 * We want to allow caching the value, so avoid using volatile and
 	 * instead use a fake stack read to hazard against barrier().
 	 */
-	asm(ALTERNATIVE("mrs %0, tpidr_el1",
-			"mrs %0, tpidr_el2",
-			ARM64_HAS_VIRT_HOST_EXTN)
-		: "=r" (off) :
-		"Q" (*(const unsigned long *)current_stack_pointer));
+	asm(
+	__KERN_ASM_CPU_OFFSET("%0")
+	: "=r" (off)
+	: "Q" (*(const unsigned long *)current_stack_pointer)
+	);
 
 	return off;
 }
-- 
2.30.2

