Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6371EEA49
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587406; cv=none; b=rveiPMD2pbHrezBZ5HvuPJ47pZoUbuglGGf+E7706eojed4l+PSb1qEg3saZtu0cwdS7q91ZqfGh533oxj3oEvQ1dG6eDSEbloPWSMu1SfpDJduUzKNkynMN+o29GxqxMFiGHTWzqlUsGqZMOU5MVsk/dABDZ/1x6/Gi7EHtsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587406; c=relaxed/simple;
	bh=hfQurs3SabBp5XtlL7+WbLabb2fndmFtpe7eIvok9rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGBO+wfGg5DgF4r+E18qcbYhmUi5JwBUMZgo42pUKHqUEKmT8PzIiRJQanCyH9Url05uzpjwaTaQN5TNCpIeMu8zb81aZ6OIdPS2JnXPtaBbd1/A6tqRgaXUGHnVwRYJiIPwnDJcUQtnrfwgTlTkrmJlSzZIT10NWxRZ834hqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Km8THeBv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Km8THeBv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5535E4360;
	Mon, 15 Jun 2026 22:23:20 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4ACF43F763;
	Mon, 15 Jun 2026 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587405; bh=hfQurs3SabBp5XtlL7+WbLabb2fndmFtpe7eIvok9rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Km8THeBvA+WwdP9ok5ahymm3q7Gox70guLct8k2tnnfHv9XKGDIu4wB7pABigMkr6
	 ggSi0WqMaE90Zsnj1MUDrHP7Bjx6GMYX90T9eH/hP1aL0ka/K+CSlc7kA262wtawcf
	 8TTi1dP03DioXdRR8M5g1kabBZVleeqtSmymHJ1Q=
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
Subject: [PATCH 5.15.y 5/9] arm64: cputype: Add C1-Ultra definitions
Date: Tue, 16 Jun 2026 06:23:03 +0100
Message-Id: <20260616052307.112083-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616052307.112083-1-mark.rutland@arm.com>
References: <20260616052307.112083-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 60349e64a6c65f9f0aa118af711b3c7e137f07ff upstream.

Add cputype definitions for C1-Ultra. These will be used for errata
detection in subsequent patches.

These values can be found in the C1-Ultra TRM:

  https://developer.arm.com/documentation/108014/0100/

... in section A.5.1 ("MIDR_EL1, Main ID Register").

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v5.15.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index d006b3e3cfc37..176d0c4b50f73 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -97,6 +97,7 @@
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
+#define ARM_CPU_PART_C1_ULTRA		0xD8C
 #define ARM_CPU_PART_NEOVERSE_N3	0xD8E
 
 #define APM_CPU_PART_POTENZA		0x000
@@ -166,6 +167,7 @@
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
+#define MIDR_C1_ULTRA MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_ULTRA)
 #define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
-- 
2.30.2

