Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D537E5DA
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292522; cv=none; b=guQGRVslUV2pQruX2/fCpqCRZl9eEq2FMUE5wu/S1TIidozoPpXfOwDi42XNOLlqFU0jM6Lh/QsNlo9unP4QfKsxNT8UBtAxrHM3Tcrj27uqxu164QlqQlZSQ/uPNHwULOyUDlva99jLdBl11YoJu1Dx8zeQvznIO3JgGWF6O4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292522; c=relaxed/simple;
	bh=dmNbLRvHS7xW5bvHv1HsojNXa/Xdd8utKnH7iazq6u4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNPU78igfuhwzmXp6n59x/nA1utVoTIwSA3A9m+gvkxDiKRtZJXbU0p1t+h871Wq2dEx8ltVhluPK1QQxz3YMmYg2+iaoZ0pEMSC7npsF2jd64ygmvdZC+ouPyQj1IqYwFEwhIBjdMu8XjsbP1QdAs8Nwzblc5YWQzIt9otbUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K3vMLjho; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K3vMLjho"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E09D01516
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:15:14 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.11.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF4A83F763
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791292518; bh=dmNbLRvHS7xW5bvHv1HsojNXa/Xdd8utKnH7iazq6u4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K3vMLjho9/zEBA3f9uqz60VF7d/YD3pv2ReBNedvrXn1hZvfvl6gJ9+TG9Kf5HSeI
	 TkdMb1kNIyipH+E7dWt4Aj4MoHNqi2lPef7HJ+1wzNxJVVTQSGDeUxcIUGHXeuUB11
	 1jgTsahMtLCwCT8m9cSyDIf5ny/1VuZDGQ7f+x1g=
From: Beata Michalska <beata.michalska@arm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 1/2] arm64: errata: Factor out broken AMU const counter cap
Date: Tue,  6 Oct 2026 15:14:28 +0200
Message-ID: <20261006131507.2528032-1-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100502-relatable-unharmed-b738@gregkh>
References: <2026100502-relatable-unharmed-b738@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the workaround from the erratum 2457168-specific cpucap to a generic
broken AMU constant-counter one. This keeps the existing Cortex-A510
handling unchanged while allowing other errata with similar AMU constant
counter issue to share the capability bit and call sites.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
(cherry picked from commit 573371caf7aea8582212da81dcead2c3f48fac4b)

Skipped comment updated on amu_read_core_const_ctrs, as that
functionality is not available here. Otherwise unmodified.
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/Kconfig             |  8 ++++++++
 arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++------
 arch/arm64/kernel/cpufeature.c |  2 +-
 arch/arm64/kernel/topology.c   |  2 +-
 arch/arm64/tools/cpucaps       |  2 +-
 5 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 06ef732c0472..27b5ef31e471 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -716,9 +716,17 @@ config ARM64_ERRATUM_2441009
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
+	bool
+	# Targeting errata affecting AMEVCNTR01, the AMU constant counter.
+	# On affected CPUs the counter may not increment at the expected rate,
+	# making it unreliable. As a result, AMU users should treat it as
+	# unavailable rather than relying on misleading counter values.
+
 config ARM64_ERRATUM_2457168
 	bool "Cortex-A510: 2457168: workaround for AMEVCNTR01 incrementing incorrectly"
 	depends on ARM64_AMU_EXTN
+	select ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
 	default y
 	help
 	  This option adds the workaround for ARM Cortex-A510 erratum 2457168.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e9f0b46e6f65..6da777e815d6 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -259,6 +259,16 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
+static const struct midr_range workaround_amu_constcnt_list[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2457168
+	/* Cortex-A510 r0p0-r1p1 */
+	MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
+#endif
+	{}
+};
+#endif /* CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT */
+
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 const struct midr_range cavium_erratum_27456_cpus[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
@@ -660,14 +670,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
 	},
 #endif
-
-#ifdef CONFIG_ARM64_ERRATUM_2457168
+#ifdef CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
 	{
-		.desc = "ARM erratum 2457168",
-		.capability = ARM64_WORKAROUND_2457168,
+		.desc = "Broken AMU AMEVCNTR01 (const counter)",
+		.capability = ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT,
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
-		/* Cortex-A510 r0p0-r1p1 */
-		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
+		CAP_MIDR_RANGE_LIST(workaround_amu_constcnt_list)
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1742098
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a2518ccc5e98..7fd2f014c479 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1785,7 +1785,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
 
 		/* 0 reference values signal broken/disabled counters */
-		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
+		if (!this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT))
 			update_freq_counters_refs();
 	}
 }
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 877c68f47282..615efd611a87 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -285,7 +285,7 @@ static void cpu_read_constcnt(void *val)
 	 * the counter is disabled. A return value of 0 at counter read is
 	 * properly handled as an error case by the users of the counter.
 	 */
-	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
+	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
 		      0UL : read_constcnt();
 }
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index e7f4ae17f31b..84baf77e847a 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -55,7 +55,6 @@ WORKAROUND_1463225
 WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_1742098
-WORKAROUND_2457168
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
@@ -71,3 +70,4 @@ WORKAROUND_QCOM_FALKOR_E1003
 WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
 WORKAROUND_SPECULATIVE_SSBS
+WORKAROUND_BROKEN_AMU_CONSTCNT
-- 
2.43.0

