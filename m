Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD493C5836
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587572; cv=none; b=qbHz536n07mJ6VIJHC4TY5CbD8efvwOBsiDJtlBbHXbEvpYipAXhciCRMNnVB9EMWa1idcuI+F9U2Gc6qAZa07OlaG3bln6zezBuzXCOmxILea4Ps4aR+m5P8JuAxBol1Z078jXR9WpcC6yH4eBPsj9n9TpsL0PIToPbWcYWRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587572; c=relaxed/simple;
	bh=4fS0J0a/vmBlCjzTiPGQq15N+0fJjX4XzBKbxlX9mOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqziVjbknK3UdUyCPaobVsUw5zPHiCt8GoSAwg0Ghe3kLPo+PF9XbJLIrYCuMtrPuBoc1Fc+QZ7SNOniIS+jS5lhatRrCCbVogxCUy2Nf5DnmHcPkj9RKQ9MlRfvPZaxCqF4QJ+fiZLiNbeoaAEcztZr6bsFo4flNnC/SsGimrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=g+PdV7M0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="g+PdV7M0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CDC93D4B;
	Mon, 15 Jun 2026 22:26:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92CDD3F763;
	Mon, 15 Jun 2026 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587570; bh=4fS0J0a/vmBlCjzTiPGQq15N+0fJjX4XzBKbxlX9mOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+PdV7M07rZVnCZPVsaT/UN3YDjh6DkSUnjxoFliK36n/PHAqVWMuq9djpI70Xq/y
	 ctjxpXKddBivR0ih1AGBxspuuliNVUup42/DPO2aYBQN0LhxaQLaXp6ccEPDsSA60q
	 umU4osbH23GeCmOwobR3yI4whyKYwNUoQVgLIThw=
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
Subject: [PATCH 5.10.y 10/10] arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU
Date: Tue, 16 Jun 2026 06:25:43 +0100
Message-Id: <20260616052543.112176-11-mark.rutland@arm.com>
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

From: Will Deacon <will@kernel.org>

commit 1940e70a8144bf75e6df26bf6f600862ea7f7ea1 upstream.

Commit fb091ff39479 ("arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
Neoverse N2 errata") states that Microsoft Azure Cobalt 100 CPU "is a
Microsoft implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and
therefore suffers from all the same errata.".

So enable the workaround for the latest broadcast TLB invalidation bug
on these parts.

Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v5.10.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/silicon-errata.rst | 3 +++
 arch/arm64/Kconfig                     | 1 +
 arch/arm64/kernel/cpu_errata.c         | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 49db8a9c0178c..98d794cc16d73 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -262,3 +262,6 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ff6f2db27a8ae..15182435b7a4f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -772,6 +772,7 @@ config ARM64_ERRATUM_4118414
 	  * ARM Neoverse-V2 erratum 4193787
 	  * ARM Neoverse-V3 erratum 4193784
 	  * ARM Neoverse-V3AE erratum 4193784
+	  * Microsoft Azure Cobalt 100 4193789
 	  * NVIDIA Olympus erratum T410-OLY-1029
 
 	  On affected cores, some memory accesses might not be completed by
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 82b93767e2ee0..201a7e29fa113 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -251,6 +251,7 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
+			MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 			{}
 		})),
 	},
-- 
2.30.2

