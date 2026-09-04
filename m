Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3536C0CD
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538731; cv=none; b=irsdkZEKvAQhhaB8NcBS9fWneZTOLKrzIbHPmUMx7HTI+fHiMVp+0s5N9Z6Y/x+j/1hUsAdwdQi8TAKvey2gIjljAJmCgIu45hvLMXqyZFCgAmBjranhzEwk5BkC8n8eEr7XdzGDdnUEg/RPbwY+wF0HzZAR5ChQHoGTM3TOAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538731; c=relaxed/simple;
	bh=akjiP9r6aGZFVaFuTV4xO4inC06yx1CbzVLMerEToh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WgTVog9pVppu0BZVLStMcE5s/84w2vFYhWzgMd0C1cGjPsQOFRpbTZqEG+7ATnSvwtuklaYf54s0rd8Miy5Mhbifgn4Yf/DYGucJecVSfx3TPTQDo/gRozdvPng77bUFHkJZnM1CT57eqYn30BCJd5KpghXyPLtdH//YLEOW8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IjdEbgOL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IjdEbgOL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDD46152B;
	Fri,  4 Sep 2026 09:18:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 893413F8D6;
	Fri,  4 Sep 2026 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538729; bh=akjiP9r6aGZFVaFuTV4xO4inC06yx1CbzVLMerEToh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjdEbgOLb1z6qV8YYTmdsm+bm7XWNTXJFFp0fWlsypZJknlxUCCUXWa9ykBtweIl1
	 XcQ+vTcX/ul1/P5HDnUHxsgEU98gdeDDwnBUJHtQ62Tngwss/4Y+v0KKsV9A/YmJE0
	 ug1mFV7/tOysivevkM947WV/GNR89Ch51b0pu7yw=
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
Subject: [PATCH v3 09/21] arm64: percpu: Factor out percpu offset asm
Date: Fri,  4 Sep 2026 17:17:46 +0100
Message-Id: <20260904161758.376504-10-mark.rutland@arm.com>
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

