Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690EF54706D
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245372; cv=none; b=S7Ej7LMYOawd7f+vIAjA8pvC9+3B+Pvb2WjnSreiWlntoaNgK7hwrj9ynm3eO1UxToyRpPu2e3xE1VtQPxsFiKTZ8SrZij9QypATdEG5vTeMaRplVluilL/z+9fpFSpiuvVBGnXxCAS5Tp5Jyw5yENV9oynLEKEIOCw+AizDpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245372; c=relaxed/simple;
	bh=TZwlkVqyITlilWLhw9saZHhfSghy08OK94geRYjjvgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5QmYHC1uQFxIKnWk3uiLRBodafi5ls3utCgVNu1ir8eKYFiT4TX5FTyiVU73Fw2o4pOj6xr7nI/tEvVarmg63OMkZtnF+hY4VvGwkREIhKwmozCTsC5DMytAQWFlwE7AYGsqvgWo8Mr27ShdDPclyO5qhdQXrhsnTZ87j6ldYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFsASElX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFsASElX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82521F000FF;
	Tue,  6 Oct 2026 00:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245371;
	bh=jBkLinjU3e5RC/1xzLAc8wpiqT2fS9vLiueBXnKad5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FFsASElX+kuQ9Yk7jlfmTyeMSie30zeLPyMaCo8L70uQ+ys4wUIb28VTa3miKLHAW
	 UaysFGQP0udmhFq/la8qOQqii+XwG/WuSJSOQeauQKRlTQyQPfli7UboMjcm9seknx
	 u2JtF1nWMp6XRMvI+IRFnW2emukDvEv6DH/u3WQJ8XdLAWW4WIGKfHfvjLb1LY770O
	 bGGYRKj81XC+M6cc5cAq43SlmkkWeDbrpXr98obnGe/Vtyi+zGRTeWdJ3WrzYvYUb9
	 OsRSfGeEzEUNqT/ZivW6nX6uJJNCKnQ2at1rQLPDuGiWqhj8nikFhZNyK75KwHMsLj
	 U+gaVpZ+uBERA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Beata Michalska <beata.michalska@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] arm64: errata: Factor out broken AMU const counter cap
Date: Mon,  5 Oct 2026 20:09:26 -0400
Message-ID: <20261006000910.3554634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100500-elsewhere-excretion-642e@gregkh>
References: <2026100500-elsewhere-excretion-642e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Beata Michalska <beata.michalska@arm.com>

[ Upstream commit 573371caf7aea8582212da81dcead2c3f48fac4b ]

Move the workaround from the erratum 2457168-specific cpucap to a generic
broken AMU constant-counter one. This keeps the existing Cortex-A510
handling unchanged while allowing other errata with similar AMU constant
counter issue to share the capability bit and call sites.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>

The paired CPPC FFH counter-read helper is absent here, so omit its
comment-only update. Retain the shared capability and MIDR range list,
and update the existing AMU initialization and constant-counter read
paths. This preserves Cortex-A510 handling and prepares the shared
workaround for Cortex-A725.

Stable-dep-of: 45f730467987 ("arm64: errata: Add Cortex-A725 erratum 3821522 workaround")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig             |  8 ++++++++
 arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++------
 arch/arm64/kernel/cpufeature.c |  2 +-
 arch/arm64/kernel/topology.c   |  2 +-
 arch/arm64/tools/cpucaps       |  2 +-
 5 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f7c4cb4fbaf1b..8f483df09dbe7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1049,9 +1049,17 @@ config ARM64_ERRATUM_1902691
 
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
index 1a7425375d0e1..917231415c007 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -353,6 +353,16 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
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
@@ -869,14 +879,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
index 39a798f74778e..bb73d05318a92 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2054,7 +2054,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
 
 		/* 0 reference values signal broken/disabled counters */
-		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
+		if (!this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT))
 			update_freq_counters_refs();
 	}
 }
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1be36a30d9e6c..6ad8ea3c7258b 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -431,7 +431,7 @@ static void cpu_read_constcnt(void *val)
 	 * the counter is disabled. A return value of 0 at counter read is
 	 * properly handled as an error case by the users of the counter.
 	 */
-	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
+	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
 		      0UL : read_constcnt();
 }
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 16d123088ddd4..3e2c5c1914d88 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -98,7 +98,6 @@ WORKAROUND_1902691
 WORKAROUND_2038923
 WORKAROUND_2064142
 WORKAROUND_2077057
-WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
 WORKAROUND_4193714
@@ -122,3 +121,4 @@ WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
 WORKAROUND_SPECULATIVE_SSBS
 WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+WORKAROUND_BROKEN_AMU_CONSTCNT
-- 
2.53.0

