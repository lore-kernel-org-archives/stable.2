Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E733BBA2
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586970; cv=none; b=llZiyuT/OoWW28kjOXrh45xQj9N9CPynJ+M/XVfQ+rAs8GSr2yExNzVHkicm75xxED7UTVi7a4WIcms02riCx3B6aXm1yosAKlYFA5LttqgothtdfYHRG4n0xDcV+43/jgEJ5+tYI/Xck507sp5EHB22XNjVSi7oHNnpnizKqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586970; c=relaxed/simple;
	bh=yprjfRwgEmmG8LM7O7+9xDRw45MdEuWKXLrHj2RKJWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bS5vfGGqZCin0mqis+avJSJ9zfsi3x/5HazTy3Vq3ObnpmUZhyG16hBJqjrE1aYpmJK0FnxQu6g2oJhW98/k1ua4S+XygGKBCLdBu8epKfTRGqQ3z7GTv7khr52jC3FzJ80CQzy/JHm51ASnoi7sBic/JsyW7CXsFP8tmaW9dRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LNbp+XgS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LNbp+XgS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9AB93D5D;
	Mon, 15 Jun 2026 22:16:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FD653F763;
	Mon, 15 Jun 2026 22:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781586968; bh=yprjfRwgEmmG8LM7O7+9xDRw45MdEuWKXLrHj2RKJWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNbp+XgSE1ISSl1PzQuemsjsFCVtffFSClp9UNaeV+dBdS0MB+xKu3NdbkM4fZfBg
	 t5DlwVRfj52eHRk8lE9rQLhUGqHCQ7Wt1C3w+xv3U1R9Vel1yVctJrwOO5TRpiVkS/
	 3iCH6bnOnfnPOBMNchNyAPVBX3QYHaJ7z7XNqMSc=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 6.12.y 3/8] arm64: cputype: Add NVIDIA Olympus definitions
Date: Tue, 16 Jun 2026 06:15:47 +0100
Message-Id: <20260616051552.111675-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616051552.111675-1-mark.rutland@arm.com>
References: <20260616051552.111675-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shanker Donthineni <sdonthineni@nvidia.com>

commit e185c8a0d84236d14af61faff8147c953a878a77 upstream.

Add cpu part and model macro definitions for NVIDIA Olympus core.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v6.12.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index c279a0a9b3660..41f55ba56e139 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -129,6 +129,7 @@
 
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
+#define NVIDIA_CPU_PART_OLYMPUS		0x010
 
 #define FUJITSU_CPU_PART_A64FX		0x001
 
@@ -209,6 +210,7 @@
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
+#define MIDR_NVIDIA_OLYMPUS MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_OLYMPUS)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
 #define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
-- 
2.30.2

