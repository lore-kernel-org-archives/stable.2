Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025355C32C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880939; cv=none; b=l1bATofIsNdoHOS2toaDh/J69O3hzyFiUtvXLFL9ZVmkwV4dCSo8K9KzjLPiwUx0OSa7VMSimVYZW7PTA0d4aBZ2xFVuiSFmYqYswvB6dRzdqIVZJzSI4VrypMyGvM+v78hQaW+djfzVXucv2AtkdFEbKpIuMP+tqJVC7LZ7BIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880939; c=relaxed/simple;
	bh=ki0awHv7wA0mCQKhq+F9Yw0sopN8F9mV84WGSkZrsjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6Qis3Q2RKicefKEKcZiC+QHop3514By53Sm7jwvfNoh0fGQlNk7bxKsLWoES2IKuCf+BRWMoZvCViIDS5BEsukjNNjDCYD0h5kDQEREzXt0S3QeqIg+uUi2s8l2I8vT5bkMaL7dsWJwvX3ilXiFMGeWkk8ltZcGLY43uADEhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qxf0H1yD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qxf0H1yD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C00B91C14;
	Tue,  8 Sep 2026 08:22:01 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACDDC3F7B4;
	Tue,  8 Sep 2026 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788880925; bh=ki0awHv7wA0mCQKhq+F9Yw0sopN8F9mV84WGSkZrsjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxf0H1yD3qENk6YokROYVjrFkjFMAtaAJ3/ocjaOZsepJmz2Mc9L/QjP7J6AvqXvy
	 9s/2CjUWg6xeLS5ewh3Arxp+9jXzAlsD2Sl2Kct05HsNT6j5Jy6BvzXys4Rg4AgG60
	 Vnv38tuDt4FMqEDbb0BaOFxbCFrwMluQ0D3hNAOs=
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
Subject: [PATCH v4 11/21] arm64: gpr-num: add __GPR_NUM() helper
Date: Tue,  8 Sep 2026 16:17:31 +0100
Message-Id: <20260908151741.394589-12-mark.rutland@arm.com>
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

The gpr-num infrastructure requires users to concatenate the register
name with a long prefix in order to get a symbol that evaluates to a
compile-time constant. Doing this manually is error-prone and painful to
read.

Add a new __GPR_NUM() helper which wraps the concatenation.

For the moment I've left existing open-coded concatenation as-is. In
particular, the DEFINE_MRS_S() and DEFINE_MSR_S() macros have awkward
stringification requirements and would require invasive changes that
outweigh the benefit. I have plans to rework those in the near future to
remove the need to use gpr-num values.

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
 arch/arm64/include/asm/gpr-num.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/gpr-num.h b/arch/arm64/include/asm/gpr-num.h
index 240cd25d55c5a..30fb8a67b19f0 100644
--- a/arch/arm64/include/asm/gpr-num.h
+++ b/arch/arm64/include/asm/gpr-num.h
@@ -11,6 +11,8 @@
 	.equ	.L__gpr_num_xzr, 31
 	.equ	.L__gpr_num_wzr, 31
 
+#define __GPR_NUM(gpr)		(.L__gpr_num_##gpr)
+
 #else /* __ASSEMBLER__ */
 
 #define __DEFINE_ASM_GPR_NUMS					\
@@ -26,6 +28,8 @@
 "	wx\\n	.req	w\\n\n"										\
 "	.endr\n"
 
+#define __GPR_NUM(gpr)		"(.L__gpr_num_" gpr ")"
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_GPR_NUM_H */
-- 
2.30.2

