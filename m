Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F211EEA49
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587565; cv=none; b=Tna+kesEHhwRHONPNcVrUT/fXEhIVRSFEovVZrfKfwbslhQG1OVZc0HZNJCfDh0E1SyfCviUCsdImS4TJTtcWtN3KvUDpVtWBbMZdAtv9kO+P53SABwy8PUbEBvo2/LPY2OPZqmYyiO3aEqRKloszHCSQvCEtvyQB0ueTT32MI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587565; c=relaxed/simple;
	bh=HxzarnuQrLzub5BFtd+MFp91nq7SNQw72mMFoyg2cQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmNCIvWliuxGeS2Av3CunI2vRr2FVuApibm8kPCXh/zBBkgjE49/v/JtfdhxxiVI0dLzVEyWLzyc418nmqBZwUzYLXNrpLPZ2nOGcu8MFxkg8NFXv1t0k07LkwAvIGmbYo+YxkaJMytC1dLCAV2FbnbV1cTVB3vj/Nn6qj7HJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z+XSXWI/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z+XSXWI/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B09973D4B;
	Mon, 15 Jun 2026 22:25:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B574F3F763;
	Mon, 15 Jun 2026 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587564; bh=HxzarnuQrLzub5BFtd+MFp91nq7SNQw72mMFoyg2cQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+XSXWI/6XPCiEi9S/POOoo84OR+wwhUm4tM+2ygSJFn5jtZ2h06yJLSh1Pn4ftor
	 TdP61O5o4sn8XNnVz92TXr7jSVPZKrz7yH5E9iTx5uKtOY7PvHQdYi1l6RZiqkIH4l
	 nZarX26eZk55YCF3U0oirPlZTLdZnEY8RG3JBEHA=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	eahariha@linux.microsoft.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 5.10.y 07/10] arm64: cputype: Add C1-Premium definitions
Date: Tue, 16 Jun 2026 06:25:40 +0100
Message-Id: <20260616052543.112176-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616052543.112176-1-mark.rutland@arm.com>
References: <20260616052543.112176-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit d28413bfc5a255957241f1df5d7fd0c2cd74fe18 upstream.

Add cputype definitions for C1-Premium. These will be used for errata
detection in subsequent patches.

These values can be found in the C1-Premium TRM:

  https://developer.arm.com/documentation/109416/0100/

... in section A.5.1 ("MIDR_EL1, Main ID Register").

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v5.10.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 176d0c4b50f73..e2e3580441a5a 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -99,6 +99,7 @@
 #define ARM_CPU_PART_CORTEX_A725	0xD87
 #define ARM_CPU_PART_C1_ULTRA		0xD8C
 #define ARM_CPU_PART_NEOVERSE_N3	0xD8E
+#define ARM_CPU_PART_C1_PREMIUM		0xD90
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -169,6 +170,7 @@
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
 #define MIDR_C1_ULTRA MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_ULTRA)
 #define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
+#define MIDR_C1_PREMIUM MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PREMIUM)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.30.2

