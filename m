Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3C93EE1D8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294510; cv=none; b=qINXM+T/6Vt4RtYVymMctUA2FSSjGpiGgCk7GIJ0JR43yBpGHfNg+vyPZqoAFMxBM+EAHvS2PWveaRxSpvYfQPt1ZRGKmVx+ask+cPsYpEpCPL47L7NLC+fJ8IBfOVdxg9WA1mE44zrBC3fAehvX2ZiV3nZHdz35HX1Y5YmEreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294510; c=relaxed/simple;
	bh=/Vlv4E7o9UtT2l0QxSeohgQEgXC1C5uFgJVJrzk2U6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxLs95ERqTiygbKWoH8GG2Q85maslmemlirXwnrtV5lxD5efY7kkP1pRgM+nCMVm7pC5MgD4JU9To7eqTpbbyirWVjlHKZHuWk2QojAGqW/DFBpikGPpD3EOeaAXbfcJ5C1doR9MQ6Ysx4r0pZXu2hEfTgGyj16hmVNv/tFfk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N2ceVzBt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N2ceVzBt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448E81516
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:48:24 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.11.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 274AE3F763
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791294507; bh=/Vlv4E7o9UtT2l0QxSeohgQEgXC1C5uFgJVJrzk2U6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N2ceVzBtUAyEFWZ58zAC30Xmsf30nupB4cw1a4bZ6P2o+HULS6c6cRrlOJ54cMTmJ
	 BOPqsXbmtA4F842jy+X2Ey7xD3aIQxcEWdYlIMReiSyf+ACnxlc9MVKxk3IdyzJmTp
	 +2LfNayGRlYZsaNsDIBmd29GzIcw7hRqZZlutGk0=
From: Beata Michalska <beata.michalska@arm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] arm64: errata: Factor out broken AMU const counter cap
Date: Tue,  6 Oct 2026 15:48:06 +0200
Message-ID: <20261006134820.2627481-1-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100501-bulginess-bullfight-da31@gregkh>
References: <2026100501-bulginess-bullfight-da31@gregkh>
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
index 723e73042c1a..27fe95b9aac7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1004,9 +1004,17 @@ config ARM64_ERRATUM_1902691
 
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
index 03a438279909..699eb5a820a8 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -275,6 +275,16 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
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
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
 static const struct midr_range cavium_erratum_23154_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_THUNDERX),
@@ -766,14 +776,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2)
 	},
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_2457168
+#ifdef CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
 	{
-		.desc = "ARM erratum 2457168",
-		.capability = ARM64_WORKAROUND_2457168,
+		.desc = "Broken AMU AMEVCNTR01 (const counter)",
+		.capability = ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT,
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
-
-		/* Cortex-A510 r0p0-r1p1 */
-		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
+		CAP_MIDR_RANGE_LIST(workaround_amu_constcnt_list)
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2038923
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5db25bfb854f..b85d6058a347 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1950,7 +1950,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
 
 		/* 0 reference values signal broken/disabled counters */
-		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
+		if (!this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT))
 			update_freq_counters_refs();
 	}
 }
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1a2c72f3e7f8..33a834e8aeeb 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -273,7 +273,7 @@ static void cpu_read_constcnt(void *val)
 	 * the counter is disabled. A return value of 0 at counter read is
 	 * properly handled as an error case by the users of the counter.
 	 */
-	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
+	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
 		      0UL : read_constcnt();
 }
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index c251ef3caae5..1d3e0e178514 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -81,7 +81,6 @@ WORKAROUND_1902691
 WORKAROUND_2038923
 WORKAROUND_2064142
 WORKAROUND_2077057
-WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
 WORKAROUND_AMPERE_AC03_CPU_38
@@ -101,3 +100,4 @@ WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
 WORKAROUND_SPECULATIVE_SSBS
 WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+WORKAROUND_BROKEN_AMU_CONSTCNT
-- 
2.43.0

