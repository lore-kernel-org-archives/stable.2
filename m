Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF2C346FAE
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612565; cv=none; b=BowFGde3MbtXFrGn4s4DuxWZ5oODp2pg4k1qo7F9SYH51red4iCgPm3xZmXER3xVHBExtX+4LJtIfMNNLCmqnTXxl1Nib3nuv2kCncj8//6dw1yV3Bnz8lfd1Ipw9dYf6NLdVoXNhCj2T0eKXubmcj3+exFzKTZ/3WbLCgxj5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612565; c=relaxed/simple;
	bh=94oIa9oJpZvBNrseYuz9B4RovQR11vSdQXlbs4GZ7sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/1MrvH8dYQg+E5w0/wM0PZ4bgC/o5zc8mZ1rk3uQcwYALZxNmhha6N9ER4hwDDCOuTQmlS+Lzo6e+lB+HMawRvkEJakewss8mKwf0FcvSmodgeTVUzLj9pOjJkomS6l3/phxrsc+nKnQezjdMIeURZUJmuBG7ky29ubcEE+ugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ADx/8QU6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ADx/8QU6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4894388;
	Tue, 16 Jun 2026 05:22:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A59593F915;
	Tue, 16 Jun 2026 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781612562; bh=94oIa9oJpZvBNrseYuz9B4RovQR11vSdQXlbs4GZ7sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADx/8QU6dApfPGIBn6CsVsOOYdv0oXCVExor2YETqWzTnvANnu9dwwgN5wHDp+VsO
	 rFY9eOMF0Tu9C5J8bwOPdQxpVojLd5J8KmaXPFLKrKQrdd87kjCnNNo6LnbC430Pl7
	 loo5mKiEkcTKYmsxjhDDHoeNqhRhJTm/JxTEL1S4=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 7.0.y 2/5] arm64: cputype: Add C1-Premium definitions
Date: Tue, 16 Jun 2026 13:22:28 +0100
Message-Id: <20260616122231.237216-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616122231.237216-1-mark.rutland@arm.com>
References: <20260616122231.237216-1-mark.rutland@arm.com>
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
[Mark: backport to v7.0.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 70beef0712424..45f96ca01cea5 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -99,6 +99,7 @@
 #define ARM_CPU_PART_CORTEX_A720AE	0xD89
 #define ARM_CPU_PART_C1_ULTRA		0xD8C
 #define ARM_CPU_PART_NEOVERSE_N3	0xD8E
+#define ARM_CPU_PART_C1_PREMIUM		0xD90
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -191,6 +192,7 @@
 #define MIDR_CORTEX_A720AE MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720AE)
 #define MIDR_C1_ULTRA MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_ULTRA)
 #define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
+#define MIDR_C1_PREMIUM MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PREMIUM)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.30.2

