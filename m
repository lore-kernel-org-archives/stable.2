Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039F3BFAEE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538734; cv=none; b=t/KSIoSdfaqkymUoQOwQDHpv+rKE4iVHSUBScZlmYahoeOnZzct+Y4i4LKJKgBa+RkdFR1ZSP6SLp2EdYji/c+krVc+tCD5z9ozHvJUaE4r4aEh01YFZ1gEA23YoERI9XCBbJqE96cSA1DFthy9xu3otIzAbwz1vjax8ODMrooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538734; c=relaxed/simple;
	bh=w07zAcxGPrwpKNC+UEkyQF6OePGiGiP3sL6U5wQzJsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWMHlWW2XG12XpYjvpASGN9xXNwPNUikS3dy6R3ZL5/SmFU2RA9dlpRnzAPtmRM2GKXbJOJ3nuVfhY/5JZsWm5CZvR3ug6WaFioMQozTzmKDKtRU4WqMabxVQRtBDnNswtHvbzolYjxHjkzEX7ZIpHdAJwAcQ5aqSfUu0ZJS0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gM/bDQR0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gM/bDQR0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B9D61FC4;
	Fri,  4 Sep 2026 09:18:48 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D840B3F8D6;
	Fri,  4 Sep 2026 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788538731; bh=w07zAcxGPrwpKNC+UEkyQF6OePGiGiP3sL6U5wQzJsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gM/bDQR0GbHmXFnoDfCIxntg9/jiTMGUld1GSVVhLOI655uh4ePdJjINsHtpR7EYk
	 8/ZBWBG1XkImKS60gBJzKdF9oHS/WsTyjcfb4aOhDMVJyStvGP1H/s/effCLFH0mHf
	 8KA7b6GDkKdN4a7+D7OYdZuJZ4aqp2PLJhh/Qy1I=
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
Subject: [PATCH v3 10/21] arm64: gpr-num: Add wxN aliases for wN registers
Date: Fri,  4 Sep 2026 17:17:47 +0100
Message-Id: <20260904161758.376504-11-mark.rutland@arm.com>
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

Some A64 instructions require a W register name for specific register
arguments, and will not accept an X register name. For example:

	STRH <Wt>, [<Xn|SP>, (<Wm>|<Xm>){, <extend> {<amount>}}]

This is painful when writing macros for inline assembly, especially
where a single register is used as both an X register and a W register.

We solved this for plain assembly by adding a wxN alias for each xN
register in commit:

  4c4dcd3541f83d21 ("arm64: assembler: introduce wxN aliases for wN registers")

Add the same facility for inline assembly, with a new
__DEFINE_ASM_GPR_ALIASES macro.

As with the other macros in gpr-num.h, different escaping is necessary
for inline vs non-inline assembly, so we can't share a single definition
that we stringify().

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
 arch/arm64/include/asm/gpr-num.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/gpr-num.h b/arch/arm64/include/asm/gpr-num.h
index a114e4f8209b0..240cd25d55c5a 100644
--- a/arch/arm64/include/asm/gpr-num.h
+++ b/arch/arm64/include/asm/gpr-num.h
@@ -21,6 +21,11 @@
 "	.equ	.L__gpr_num_xzr, 31\n"				\
 "	.equ	.L__gpr_num_wzr, 31\n"
 
+#define __DEFINE_ASM_GPR_ALIASES									\
+"	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"	\
+"	wx\\n	.req	w\\n\n"										\
+"	.endr\n"
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_GPR_NUM_H */
-- 
2.30.2

