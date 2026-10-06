Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8F41D635
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294511; cv=none; b=fsw2/79sjKStVG+s/LtZAckXydbdMATk0eC+W6JQqPBANIROtFpjBV/jq0zCac8JOzEEWF00Z7SDaTvijFJK+GVMOs5c/NxuBZdjPrnyYxuQ3TfHy+TtxPT+DO4gn0TuuAExaVpa3+K5XX4w3q7auxGfHcjooADThAWYrkAU8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294511; c=relaxed/simple;
	bh=I2jH4Nf9ubfqSv2XucWV3QTg9eiLNiAQifSWhE9M+wQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGZwcOphwgxQ6HEU8VR2p5wW/6GY8xT+GPYB++/Z3Kq84+F+pOLMj57iutEW2WPoWdslkIyXKOypZNxOr+g+6jYkivF+rgTGgeopK6N5uY7tKjaTdRL3D77OeMRNtnzCAWV6oyGymNUmt/uZGXcj+eQEaFR+a8EVWchxearfEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f+qLcAr3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f+qLcAr3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49320152B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:48:25 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.11.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 116143F763
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791294508; bh=I2jH4Nf9ubfqSv2XucWV3QTg9eiLNiAQifSWhE9M+wQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f+qLcAr3TsteY4CvimlGwYB1OSPa432X6w7Hr/XgVU2LlwJqV1KAjCoFkmw8kpLkf
	 P7I8bvF9jT15wefPngRaIYMR3MfUPaiLLDEK2ThDkSnGvvogigwUk8MNf3tcVzopYt
	 mGTF/eamv7XHo2HWg18yozIBJTD/TlUxe2bGuHtk=
From: Beata Michalska <beata.michalska@arm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] arm64: errata: Add Cortex-A725 erratum 3821522 workaround
Date: Tue,  6 Oct 2026 15:48:07 +0200
Message-ID: <20261006134820.2627481-2-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006134820.2627481-1-beata.michalska@arm.com>
References: <2026100501-bulginess-bullfight-da31@gregkh>
 <20261006134820.2627481-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 45f7304679875eb000d67e194090ee7abd05c89c)
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 22 +++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              |  4 ++++
 arch/arm64/kernel/topology.c                |  9 +++++----
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index b5b46b6ab277..c40e6271072f 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -161,6 +161,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A725     | #3821522        | ARM64_ERRATUM_3821522       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #4193791        | ARM64_ERRATUM_4118414       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27fe95b9aac7..fc29ac6bad57 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1045,6 +1045,28 @@ config ARM64_ERRATUM_2645198
 
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
index 699eb5a820a8..871e440f386a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -280,6 +280,10 @@ static const struct midr_range workaround_amu_constcnt_list[] = {
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
index 33a834e8aeeb..24a8b61a4f46 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -268,10 +268,11 @@ static void cpu_read_corecnt(void *val)
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
2.43.0

