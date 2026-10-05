Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F0412BF3
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240821; cv=none; b=aV8LRJhqyHHR6Y1HO6vxovvYe1edrvvWULl213LAtWOeFNPFHrzX+KkU/TcKampjR60xyPVOvd2qydO32rxWptWg+cCbUbWcl5ziaXD0MXkyzHW28Jz9m49Leyy7dbrL3mU3+9fzSej6qEY7o2d72svvF6GKfSINIB4bdnmwoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240821; c=relaxed/simple;
	bh=tdOFE6FcJ8Zaz8nWme+IK4YauiWyzaLXFkG6MfVuq24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVqq10C63gzqhLO/ohFgVg6e6c1vtKHtae1FCKU3/dz7riSIbeY8bwTn2WAAD3OtV8ma+SshnPS+1to+00vgcjkkIcrNct2jlWHJdTBZqvop8IX8ZftNEfR1Kh3McmasbQ+EtrR6FN8EyLpZMVihyALDQFGOCHk5aP7qDSsS5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM+0MhIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM+0MhIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1990B1F00893;
	Mon,  5 Oct 2026 22:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240819;
	bh=/9u5YCDZZWTHgBHcgeJoLuJwzUonN+kLMnwAF3Cl/UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OM+0MhIl2AgrLGQkZlFPgJUbDrQ9ekml51UDrVPfY24sIYGz5rrugImGH/tbIGLVt
	 Wx+nS08zLtQhDHauIOz14w4VgN4RMwz0F/lDSO7JOZqpOoJ8LKHkkDiOUNb9Isu4Yy
	 qcLDKpGtMsUWEeg7EKLnigXl8tyRUyHNsWxZvfIF5W7jVdspup1XDT2qzQ37tDDRIq
	 6uWKrjlXYlk0W8FwdySUbcQlf+Cx4lAUcWv2s6DMi88vrrFF5LIkXrlt97RKpCRDNy
	 ZGLANo4tTOQ7CJs/3Nl3O9lKdwD+dUT6n05hK01S407tzX68SMnnHa0b7LTinbsN12
	 Tj9UD/QmLtuFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Beata Michalska <beata.michalska@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] arm64: errata: Add Cortex-A725 erratum 3821522 workaround
Date: Mon,  5 Oct 2026 18:53:34 -0400
Message-ID: <20261005225325.3487067-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005225325.3487067-1-sashal@kernel.org>
References: <2026100500-widget-handcart-8d85@gregkh>
 <20261005225325.3487067-1-sashal@kernel.org>
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
index 88b4aa45a2066..826dfb90c8f7a 100644
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
index a38a3940cf208..89b6a7dc6d32d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1058,6 +1058,28 @@ config ARM64_ERRATUM_2645198
 
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
index a6dc9f20373e5..f67ae51dc2395 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -382,6 +382,10 @@ static const struct midr_range workaround_amu_constcnt_list[] = {
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
index 15035f051c25b..b4f6eb213aa89 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -385,10 +385,11 @@ static void cpu_read_corecnt(void *val)
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

