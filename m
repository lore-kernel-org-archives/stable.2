Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146B3CF1E2
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587404; cv=none; b=Q4kFWPbgyt/p6fbzNlm1MhipS3wR5KCHq+M+s8pccPTJwKMzxoAhNGWt3SuFqYdoORtCsGNl+YAslSwXZuWVwKhsGLLGL+nqQ5WiwBk92uXkNwIDMkU1sDkclH4PjZqHSwXC6Qg44hKJAhrjJtB/mPgG9O4wOVz/rXqH2uvs+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587404; c=relaxed/simple;
	bh=v4eWRn7j9UipZbDKeXVqlr+wTvTWTwTGA9Tf2QQ16eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iYZZ15I57/mi2WK9SUGJTQXYC23X4jnWXNGmY4RH8EFve/jJ1jGjFFlV2ziPjHfMKH7SGZtbc+eXq2xtXT6w65EJWk9LBxE+6IWCi6tn+GtSpxX+27jM79tLBPKFMCiuxgHw8g9f12edgjo3OTVMdvhiJqQuCEzIJxQDqiYRJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f5J3vT/7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f5J3vT/7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4642F3D4B;
	Mon, 15 Jun 2026 22:23:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3795E3F763;
	Mon, 15 Jun 2026 22:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587402; bh=v4eWRn7j9UipZbDKeXVqlr+wTvTWTwTGA9Tf2QQ16eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5J3vT/7/c6vQ1LZ83u2X4/FrnQClvz81CfDLTnUL6tnwiKF6gtzrtTqtKwGtBK05
	 MmGhtrdAOmMrLclKvM8yp4eqsO2YF9Sh2Ed4H248a3u/JCMnrfPjtFZLT582I9xOKJ
	 33BGnCpwALnDi0vKzK/V4z3xb4A3yFh1IYKmqmlo=
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
Subject: [PATCH 5.15.y 4/9] arm64: cputype: Add NVIDIA Olympus definitions
Date: Tue, 16 Jun 2026 06:23:02 +0100
Message-Id: <20260616052307.112083-5-mark.rutland@arm.com>
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

From: Shanker Donthineni <sdonthineni@nvidia.com>

commit e185c8a0d84236d14af61faff8147c953a878a77 upstream.

Add cpu part and model macro definitions for NVIDIA Olympus core.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v5.15.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index d49743d01fe66..d006b3e3cfc37 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -121,6 +121,7 @@
 
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
+#define NVIDIA_CPU_PART_OLYMPUS		0x010
 
 #define FUJITSU_CPU_PART_A64FX		0x001
 
@@ -183,6 +184,7 @@
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
+#define MIDR_NVIDIA_OLYMPUS MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_OLYMPUS)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
-- 
2.30.2

