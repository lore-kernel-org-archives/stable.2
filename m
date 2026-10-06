Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD97379C57
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287694; cv=none; b=QPOthXOuLBCw70l43hzUfjz0EB7uqMuclFxqEg3H64Ivw2KWw2knI6GHn7+gm+ZgBxZVlNjGLq5iHlIEeMp4PNa3EKXskfV2I7vcJbA3mSWwc8pD+eBeqFURBR/QZ6VKlAheq0dQy/BFxbxArAfstmW9HfSeERN7xLZs9hN8dEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287694; c=relaxed/simple;
	bh=t2tu+bR0fvMWgGr48O1AwssndYD5EUXlvYcHS7CKGyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uII7rjIO78nCkU75jaXr1X69TytdgJexva8W2aLz2h3HBVQZ3bk3o7v+BzkbLvSqRIQni4rDOxc6F20DnIYz++xnMTrvZeAXXfp59mCUuByik826cxrlkt+LisNyXfLm+AkayHEBRnAKTHhLbwM8tEMKQHc5cxVjyDNEyKLoIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hph9ZzCZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hph9ZzCZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7DC41516
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:54:47 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.11.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4A5E3F763
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791287691; bh=t2tu+bR0fvMWgGr48O1AwssndYD5EUXlvYcHS7CKGyg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hph9ZzCZt4Y7+IOCdpvHQ9QboHVYFYvOyYwM+tu68SpCLqic/gMimSiQAODKm+EpS
	 vsqbkGKJnO1QQGQn9ulLIsAfnVha9Yuju6czbT34Xt927QjZWTCcJ04xuTenu6SgZL
	 GQ6BGFBP3DduGZ4K73iNz6d0N5rWuJ4RWO2R/wQ4=
From: Beata Michalska <beata.michalska@arm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 1/2] arm64: errata: Factor out broken AMU const counter cap
Date: Tue,  6 Oct 2026 13:54:35 +0200
Message-ID: <20261006115442.2223870-1-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100503-gummy-amniotic-e701@gregkh>
References: <2026100503-gummy-amniotic-e701@gregkh>
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

Dropped changes related to CPPC/FFH as support for that is not available
here. Additionally renamed define for WORKAROUND_2457168 to new one,
WORKAROUND_BROKEN_AMU_CONSTCNT to reuse it as this kernel still relies
on the cpucaps header file for the workaround/errata ids.
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/Kconfig               |  8 ++++++++
 arch/arm64/include/asm/cpucaps.h |  2 +-
 arch/arm64/kernel/cpu_errata.c   | 19 ++++++++++++++-----
 arch/arm64/kernel/cpufeature.c   |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 15182435b7a4..ae4036d549fc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -673,9 +673,17 @@ config ARM64_ERRATUM_1508412
 
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
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 931c88182fb8..419eb982335f 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -67,7 +67,7 @@
 #define ARM64_MTE				57
 #define ARM64_WORKAROUND_1508412		58
 #define ARM64_SPECTRE_BHB			59
-#define ARM64_WORKAROUND_2457168		60
+#define ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT	60
 #define ARM64_WORKAROUND_1742098		61
 #define ARM64_WORKAROUND_SPECULATIVE_SSBS	62
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 201a7e29fa11..df83ff9a767d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -260,6 +260,16 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
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
@@ -611,13 +621,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 				  1, 0),
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
-		/* Cortex-A510 r0p0-r1p1 */
-		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
+		CAP_MIDR_RANGE_LIST(workaround_amu_constcnt_list)
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1742098
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e055ec3a5cfb..63ffb1993dcd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1608,7 +1608,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
 
 		/* 0 reference values signal broken/disabled counters */
-		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
+		if (!this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT))
 			init_cpu_freq_invariance_counters();
 	}
 }
-- 
2.43.0

