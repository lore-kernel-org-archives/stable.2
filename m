Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB653CF050
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587413; cv=none; b=g25OvtR+lFHWnvTxdhuWgMRiaJDg8tzN/Gwr/cMYhO2jRutkpDzPNxC095LTp+sxE+d+OMUpyr95gc0SiRGNa7qWueRV3t/508RYrdfmmfEbG1dhCMnctJOU6s66YmtIpAYCZo1Srnf2NeGL2EQlJLI9uBUnJFJj4eXmaytNgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587413; c=relaxed/simple;
	bh=NVHFEovC6U2vWgSM50B8BuZ9EoWZemaDY/OHDNy2LMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hpj+a0FRBd5e5N7yofC+vSGdol0/SI8/xSlSO4957yEBTACXRdHVP3B105hspuVLy4h/mCf/tp4fAxbtTkuJ1jP7fMdBbOST18VJ5ISE09jZfnp99Su54fzNuNXqQx76lmbBm3+5p/Zlm+L0GJhc1uwq03wMn8jGFIxwwN0GkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZQG/Nynj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZQG/Nynj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9002A1A00;
	Mon, 15 Jun 2026 22:23:26 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 849013F763;
	Mon, 15 Jun 2026 22:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587411; bh=NVHFEovC6U2vWgSM50B8BuZ9EoWZemaDY/OHDNy2LMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQG/NynjtKhHim6mMJopA0ltwoBB4tZZgKFhjMiY+MvR6DngMQTXYMD0SkyeJ2BuD
	 Bu4zfXmvt2CgjJxzank8Vh296ijjO9om7J66tdEpn9l+uLvtYLpLU8gZ0XRn4rFwJa
	 +f/TCwI8J9Y4exBZei//i9kI1s/gXrd0kd5tYOwU=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 5.15.y 8/9] arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU
Date: Tue, 16 Jun 2026 06:23:06 +0100
Message-Id: <20260616052307.112083-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616052307.112083-1-mark.rutland@arm.com>
References: <20260616052307.112083-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shanker Donthineni <sdonthineni@nvidia.com>

commit ec7216f92e4ebd485b1c6dc6aa3f6064b71a5768 upstream.

NVIDIA Olympus cores are affected by the TLBI completion issue tracked as
CVE-2025-10263. The existing ARM64_ERRATUM_4118414 handling already uses
ARM64_WORKAROUND_REPEAT_TLBI to issue an additional broadcast TLBI;DSB
sequence and ensure affected memory write effects are globally observed.

Add MIDR_NVIDIA_OLYMPUS to the repeat-TLBI match list so the same
mitigation is enabled on affected Olympus systems. Also document the
NVIDIA Olympus erratum in the arm64 silicon errata table and list it in
the Kconfig help text.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v5.15.y]
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 Documentation/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                     | 3 ++-
 arch/arm64/kernel/cpu_errata.c         | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index af41fdc025d88..84eeb04a0d794 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -242,6 +242,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | Olympus core    | T410-OLY-1029   | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b8611b9548505..d7031082ee73b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -902,7 +902,7 @@ config ARM64_ERRATUM_4193714
 	  If unsure, say Y.
 
 config ARM64_ERRATUM_4118414
-	bool "Cortex-*/Neoverse-*/C1-*: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
+	bool "Various: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
 	default y
 	select ARM64_WORKAROUND_REPEAT_TLBI
 	help
@@ -929,6 +929,7 @@ config ARM64_ERRATUM_4118414
 	  * ARM Neoverse-V2 erratum 4193787
 	  * ARM Neoverse-V3 erratum 4193784
 	  * ARM Neoverse-V3AE erratum 4193784
+	  * NVIDIA Olympus erratum T410-OLY-1029
 
 	  On affected cores, some memory accesses might not be completed by
 	  broadcast TLB invalidation.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 63087637bfcb8..3238673e94fd0 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -249,6 +249,7 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
+			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 			{}
 		})),
 	},
-- 
2.30.2

