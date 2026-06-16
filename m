Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377663CF1EE
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587260; cv=none; b=tId5UgX1CE44gGzuwYO87YrRbLfkMf8KlRgQceuMvZhVw5v5+TTK1WE98KvEZJOdBzEnNAWFeNvHQnt9gfFoBZlp5sOguW+3aMJ6gT5BX7KqHGKegjCdeiFTukdMc5sCpMKWHqHWOteI2HCRBzoCizzYvY5gfWZKaCsagtCCGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587260; c=relaxed/simple;
	bh=l2NxSeo2hxpiXbRiQ5lMJPk3K5h6JAZV71IKj8X99Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hr3KT1jCx0QaSmcdCBTvIVoA3aoOqBq3SEYQDASEexwjgU2vuDDBFkqA+ngwh/HfU7Pm+OUD3bDHh86OEuIH/mN2fLjaT1Z+KDqbhZHazwsu+pxse2PLhFqiiWx2gjRRCDyRxrJt6sbhqAwPDH3VyCPwN1tWJbZXo5MSIimDDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e+MduJZa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e+MduJZa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CCD93D9C;
	Mon, 15 Jun 2026 22:20:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 201913F763;
	Mon, 15 Jun 2026 22:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587258; bh=l2NxSeo2hxpiXbRiQ5lMJPk3K5h6JAZV71IKj8X99Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+MduJZaNn7nEUwoqYawmD92/4frZ+FyRLvHpOgp+/QOI4wvI41t1JypAeqfxepES
	 HNYd1apz72FS1JE6Jm0h7Su5b5HIX9zqWfx7BDZcY6w+//7ugqRXLIoCHdpKa2jA7N
	 VD5bk1oNmhvyhdvx7dv9iWZu+H9+85T2cFH2jDTI=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 6.1.y 2/9] arm64: tlb: Allow XZR argument to TLBI ops
Date: Tue, 16 Jun 2026 06:20:39 +0100
Message-Id: <20260616052046.112003-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616052046.112003-1-mark.rutland@arm.com>
References: <20260616052046.112003-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit bfd9c931d19aa59fb8371d557774fa169b15db9a upstream.

The TLBI instruction accepts XZR as a register argument, and for TLBI
operations with a register argument, there is no functional difference
between using XZR or another GPR which contains zeroes. Operations
without a register argument are encoded as if XZR were used.

Allow the __TLBI_1() macro to use XZR when a register argument is all
zeroes.

Today this only results in a trivial code saving in
__do_compat_cache_op()'s workaround for Neoverse-N1 erratum #1542419. In
subsequent patches this pattern will be used more generally.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Mark: Backport to v6.1.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 412a3b9a3c25d..2626a45849c24 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -37,12 +37,12 @@
 			    : : )
 
 #define __TLBI_1(op, arg) asm (ARM64_ASM_PREAMBLE			       \
-			       "tlbi " #op ", %0\n"			       \
+			       "tlbi " #op ", %x0\n"			       \
 		   ALTERNATIVE("nop\n			nop",		       \
-			       "dsb ish\n		tlbi " #op ", %0",     \
+			       "dsb ish\n		tlbi " #op ", %x0",    \
 			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
 			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
-			    : : "r" (arg))
+			    : : "rZ" (arg))
 
 #define __TLBI_N(op, arg, n, ...) __TLBI_##n(op, arg)
 
-- 
2.30.2

