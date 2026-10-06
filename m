Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B454706D
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245374; cv=none; b=lmnVl/fXqdCjYaS0bAyWixsFtya2CMod27Vn7Mwl/qH2FU4LkiFJnp+Xmu44MuEZ6oTvsbq/3b47VknDhvYJmZM+IRsLJI/DiQ/bCrXBQBaUznnQDSPj6q6aQxIIM9z0hu8/baBnTwJNJMo2XLbR0VAgukuKunzVnqsyDCcQw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245374; c=relaxed/simple;
	bh=xIUc4V13SeqNlaY5m2r0fgrPkiinOET0KDYD62mRc7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POiNfkjFXJosjVa7h4m6CRnJ0jzdXEDetjgrlr4K/nZyiB+701AMwooNabtmt4w3xyQ79eYO4bXi65wbN8/Ms4KifPlpR4TO1og1V8+82rdtDXVTR2A856mM51v1qneF1bH3KXBaMvGl1WZtHOkgC9E1jLcLnTFzkiwS23jNuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH8UHUvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH8UHUvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9072E1F00893;
	Tue,  6 Oct 2026 00:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245372;
	bh=oK1UQbNKiVDx4hjk40ErsSgCppS3Ts11yHJqdmmOXJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JH8UHUvAtNrs5ja5AUpsqqsdGpKf8Lm75p3ALTudqJklyM/2JnA9Mj6kuqpeMhqJO
	 efayz+6eVHiCisMTlMUtfp+A4eK4EFENR3+KoS0u1qefHqAoziBLrAtbnBfYbZ4LBJ
	 J/0PDyjV1s6sDZOvhZjw+QuORj1csvo9ne9NX/NM85NOT9MBCP4EMsCI3/V9cMG6nl
	 zUHaVbrx1x4P81WbirCZx4A+gU6Z0Sv+aS1aQPO87YYP95ccWGynB8PDJklxqk5dwZ
	 EUkn1wuWEyWzMgCQGwcBq9bfCmk4uglP4JjM483Hr4hmJ5t0aJmwQ5L/q0CI3ZGi5E
	 W+SpsV3rd3q+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Beata Michalska <beata.michalska@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] arm64: errata: Add Cortex-A725 erratum 3821522 workaround
Date: Mon,  5 Oct 2026 20:09:27 -0400
Message-ID: <20261006000910.3554634-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006000910.3554634-1-sashal@kernel.org>
References: <2026100500-elsewhere-excretion-642e@gregkh>
 <20261006000910.3554634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Beata Michalska <beata.michalska@arm.com>

[ Upstream commit 45f7304679875eb000d67e194090ee7abd05c89c ]

Cortex-A725 erratum 3821522 affects the CNT_CYCLES event, which can
incur a significant increment error when a CPU enters and subsequently
exits WFE or WFI, and may no longer track the system counter
frequency.

The AMEVCNTR01_EL0 counter is used as the AMU constant counter for
frequency invariance and CPPC FFH feedback counters. Wire the affected
Cortex-A725 range into the shared broken AMU constant-counter capability
so the affected counter is treated as unavailable by returning zero in
the AMU counter paths. This prevents the broken counter from being used
as a reference source.

The erratum can also affect PMUv3 users of the CNT_CYCLES event,
but this workaround intentionally does not change PMU event handling.
Hiding or rejecting the PMU event from the erratum code would change
the perf-visible PMU event interface, including raw event selection,
and would need a separate PMU-specific approach rather than being
folded into the AMU reference-counter workaround.

Cc: stable@vger.kernel.org
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 22 +++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              |  4 ++++
 arch/arm64/kernel/topology.c                |  9 +++++----
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 1c5accd6dec49..75c6ba532c20c 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -168,6 +168,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A725     | #3821522        | ARM64_ERRATUM_3821522       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #1502854        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8f483df09dbe7..2e567a7d89c9b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1090,6 +1090,28 @@ config ARM64_ERRATUM_2645198
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_3821522
+	bool "Cortex-A725: 3821522: workaround for possible CNT_CYCLES increment error due to WFE/WFI"
+	depends on ARM64_AMU_EXTN
+	select ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A725 erratum 3821522.
+
+	  On affected A725 cores, the CNT_CYCLES event may incur a significant
+	  increment error when entering and subsequently exiting WFx.
+	  As a result, the CNT_CYCLES may diverge from the system counter
+	  frequency at which it is expected to increment.
+	  This renders the AMU counter AMEVCNTR01, that implements CNT_CYCLES,
+	  being unreliable and unsuitable for use.
+
+	  Since there is no hardware workaround, reads of the affected CNT_CYCLES
+	  counter return 0 in the relevant paths. This causes users of the counter
+	  to treat it as unavailable and is functionally equivalent to firmware
+	  disabling the affected counter.
+
+	  If unsure, say Y.
+
 config ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	bool
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 917231415c007..516a1e37a51fe 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -358,6 +358,10 @@ static const struct midr_range workaround_amu_constcnt_list[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2457168
 	/* Cortex-A510 r0p0-r1p1 */
 	MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_3821522
+	/* Cortex-A725 r0p0 - r0p2 */
+	MIDR_RANGE(MIDR_CORTEX_A725, 0, 0, 0, 2),
 #endif
 	{}
 };
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 6ad8ea3c7258b..202f677e2b0f2 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -426,10 +426,11 @@ static void cpu_read_corecnt(void *val)
 static void cpu_read_constcnt(void *val)
 {
 	/*
-	 * Return 0 if the current CPU is affected by erratum 2457168. A value
-	 * of 0 is also returned if the current CPU does not support AMUs or if
-	 * the counter is disabled. A return value of 0 at counter read is
-	 * properly handled as an error case by the users of the counter.
+	 * Return 0 if the current CPU is affected by a HW erratum.
+	 * A value of 0 is also returned if the current CPU does not
+	 * support AMUs or if the counter is disabled. A return
+	 * value of 0 at counter read is properly handled as an error
+	 * case by the users of the counter.
 	 */
 	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
 		      0UL : read_constcnt();
-- 
2.53.0

