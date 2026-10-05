Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6304746C9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195868; cv=none; b=iXFNKDhNreTPTBzOhynpAfLFZsY0hi3GLLSVw1GzU5Vpn+LHk3v52gaXwlvNyTpEKBEnlHX5sLaTBZ2950Q3C4s6i88p9Y3tVWRFH48Tf6n82xE5Z4lI6In/f+aDPesQt032sjav+HT7WbyNCBS9LsqcG1w9sOOLTo5uU2qR6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195868; c=relaxed/simple;
	bh=VSOsr4vhX2Ur/25os1Nx10/wk0CWGXYl2rXomQV0kv8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P+ZAI7Y0cx9D7gWLXuJeaTyrwg35x/Zf9x39XqpK5UbEJ7T3ilctgp28gA8G5WnXeE/1J83YL5wwo3H5MxYhT4Twf6pVCISdxgGfI9Yv9gZJt3KA5ndIerX3nxE1Grm3srZuTyNU1m2iANzuBN/ofrRPralpCNcAquVsK1e46v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBKMWdaz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBKMWdaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275501F000FF;
	Mon,  5 Oct 2026 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195866;
	bh=WyfLi6NMskXA6+J8bqEwlAgv0G58w8HH5/gCQAEhT3E=;
	h=Subject:To:Cc:From:Date;
	b=ZBKMWdaz782gknJ6zh6Mp+lIl1QsswGNwY4BaDdMieJaevGXp4lsoq+n599+dlQ26
	 +JyCIc1KC8YmaUa4pMgIHljtwQQufLxKv8VNB7mx80en7DoSnhsLMxSppYR1HGfWBd
	 M0QZgAh/Z9ybIbk/n+4HwoRKgKy3LZMq3ToHyEWY=
Subject: FAILED: patch "[PATCH] arm64: errata: Add Cortex-A725 erratum 3821522 workaround" failed to apply to 5.10-stable tree
To: beata.michalska@arm.com,vladimir.murzin@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:24:03 +0200
Message-ID: <2026100503-gummy-amniotic-e701@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 45f7304679875eb000d67e194090ee7abd05c89c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100503-gummy-amniotic-e701@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45f7304679875eb000d67e194090ee7abd05c89c Mon Sep 17 00:00:00 2001
From: Beata Michalska <beata.michalska@arm.com>
Date: Thu, 1 Oct 2026 11:00:32 +0200
Subject: [PATCH] arm64: errata: Add Cortex-A725 erratum 3821522 workaround

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

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index ac3248b9f2f3..99a1eb4b833d 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -174,6 +174,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A725     | #3821522        | ARM64_ERRATUM_3821522       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #1502854        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3b6c052d46a1..cab741a695f5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1081,6 +1081,28 @@ config ARM64_ERRATUM_2645198
 
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
index dbd70728a9bd..e0c09402540c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -389,6 +389,10 @@ static const struct midr_range workaround_amu_constcnt_list[] = {
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
index 214d153cba6e..806373aac3db 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -395,10 +395,11 @@ static void cpu_read_corecnt(void *val)
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

