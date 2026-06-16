Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743D1EEA49
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587568; cv=none; b=pns1oHV2NSrfp/Bu79l4l4Yt8r+AMDcClcdPoRJPME7UIUV5Dgw6cMwujghG1ctkEF4LOxWfH+mdPE9oGlJGuMeg3kJCqrssuxAPM9xaKvj8Fw5TvKrFRvjlHhY7JEze2w551UBep+WeCAG1tqFcvE1ktg24WxCrKUvVZmX/wAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587568; c=relaxed/simple;
	bh=UtSMHHsXfSiCDtdQ1IZ5LCSpTCtZLD9tj7AnylW5P3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvXGeguirZ1A4uIy6P6u9xG17+70PHMLOfIQUdqiQEMK42FwDOMzPn8gf9XeTF3hG/k1hJbPMPLsdWghK8ySgFokkgcVYUy5ONYboOBCVB8ELQ26vrjyHBzlcf+HG0nMTPsJxzyPc59z8eiFUZwB+Osamrr4Xvz5Y2DrIWZtRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ajuWqy0j; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ajuWqy0j"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A34A24360;
	Mon, 15 Jun 2026 22:26:01 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AAA423F763;
	Mon, 15 Jun 2026 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587566; bh=UtSMHHsXfSiCDtdQ1IZ5LCSpTCtZLD9tj7AnylW5P3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajuWqy0jTMvFZDY/MKbd40XuZj7bx4PiFpJL7ZQpFBo1Uvuv6YHSnSFSO4WN30rKy
	 wv1qA73Ac67NKSb25N38e37B6bnPPh8+7oQrOideUSSWAPSJj8+oxQZcoGQkSOHETB
	 rCrqC1vu4QtJOkbBvDvxgKzfAyhIL+X7AgyXF0KM=
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
Subject: [PATCH 5.10.y 08/10] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 06:25:41 +0100
Message-Id: <20260616052543.112176-9-mark.rutland@arm.com>
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

commit cfd391e74134db664feb499d43af286380b10ba8 upstream.

A number of CPUs developed by Arm suffer from errata whereby a broadcast
TLBI;DSB sequence may complete before the global observation of writes
which are translated by an affected TLB entry.

These errata ONLY affect the completion of memory accesses which have
been translated by an invalidated TLB entry, and these errata DO NOT
affect the actual invalidation of TLB entries. TLB entries are removed
correctly.

This issue has been assigned CVE ID CVE-2025-10263.

To mitigate this issue, Arm recommends that software follows any
affected TLBI;DSB sequence with an additional TLBI;DSB, which will
ensure that all memory write effects affected by the first TLBI have
been globally observed. The additional TLBI can use any operation that
is broadcast to affected CPUs, and the additional DSB can use any option
that is sufficient to complete the additional TLBI.

The ARM64_WORKAROUND_REPEAT_TLBI workaround is sufficient to mitigate
the issue. Enable this workaround for affected CPUs, and update the
silicon errata documentation accordingly.

Note that due to the manner in which Arm develops IP and tracks errata,
some CPUs share a common erratum number.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v5.10.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/silicon-errata.rst | 42 ++++++++++++++++++++++
 arch/arm64/Kconfig                     | 48 ++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         | 32 +++++++++++++++--
 3 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 02169bedae450..fce8283618fc5 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -96,18 +96,32 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #4193800        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76AE    | #4193801        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A77      | #4193798        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78      | #4193791        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78AE    | #4193793        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78C     | #4193794        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #4193788        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #3456084        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
@@ -116,16 +130,28 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1       | #4193791        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1C      | #4193792        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X2       | #4193788        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X3       | #4193786        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X4       | #4118414        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X925     | #4193781        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -134,18 +160,34 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N1     | #4193800        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N3     | #3456111        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V1     | #4193790        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V2     | #4193787        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3     | #4193784        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #4193784        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Premium      | #4193780        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Ultra        | #4193780        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 308ea83cb07d5..44c2867e162cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -732,6 +732,54 @@ config ARM64_ERRATUM_3194386
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_4193714
+	bool "C1-Pro: 4193714: SME DVMSync early acknowledgement"
+	depends on ARM64_SME
+	default y
+	help
+	  Enable workaround for C1-Pro acknowledging the DVMSync before
+	  the SME memory accesses are complete. This will cause TLB
+	  maintenance for processes using SME to also issue an IPI to
+	  the affected CPUs.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_4118414
+	bool "Cortex-*/Neoverse-*/C1-*: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
+	default y
+	select ARM64_WORKAROUND_REPEAT_TLBI
+	help
+	  This option adds a workaround for the following errata:
+
+	  * ARM C1-Premium erratum 4193780
+	  * ARM C1-Ultra erratum 4193780
+	  * ARM Cortex-A76 erratum 4193800
+	  * ARM Cortex-A76AE erratum 4193801
+	  * ARM Cortex-A77 erratum 4193798
+	  * ARM Cortex-A78 erratum 4193791
+	  * ARM Cortex-A78AE erratum 4193793
+	  * ARM Cortex-A78C erratum 4193794
+	  * ARM Cortex-A710 erratum 4193788
+	  * ARM Cortex-X1 erratum 4193791
+	  * ARM Cortex-X1C erratum 4193792
+	  * ARM Cortex-X2 erratum 4193788
+	  * ARM Cortex-X3 erratum 4193786
+	  * ARM Cortex-X4 erratum 4118414
+	  * ARM Cortex-X925 erratum 4193781
+	  * ARM Neoverse-N1 erratum 4193800
+	  * ARM Neoverse-N2 erratum 4193789
+	  * ARM Neoverse-V1 erratum 4193790
+	  * ARM Neoverse-V2 erratum 4193787
+	  * ARM Neoverse-V3 erratum 4193784
+	  * ARM Neoverse-V3AE erratum 4193784
+
+	  On affected cores, some memory accesses might not be completed by
+	  broadcast TLB invalidation.
+
+	  This issue is also known as CVE-2025-10263.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6269a4e56f407..11e99b9fe3e5d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -226,7 +226,35 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 		ERRATA_MIDR_RANGE(MIDR_QCOM_KRYO_4XX_GOLD, 0xc, 0xe, 0xf, 0xe),
 	},
 #endif
-	{},
+#ifdef CONFIG_ARM64_ERRATUM_4118414
+	{
+		ERRATA_MIDR_RANGE_LIST(((const struct midr_range[]) {
+			MIDR_ALL_VERSIONS(MIDR_C1_PREMIUM),
+			MIDR_ALL_VERSIONS(MIDR_C1_ULTRA),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
+			{}
+		})),
+	},
+#endif
+	{}
 };
 #endif
 
@@ -476,7 +504,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
 	{
-		.desc = "Qualcomm erratum 1009, or ARM erratum 1286807",
+		.desc = "Broken broadcast TLBI completion",
 		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = cpucap_multi_entry_cap_matches,
-- 
2.30.2

