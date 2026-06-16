Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD21E8320
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612444; cv=none; b=EWv0hd+5JP2kqDhBIGWY3MP2xAzUm1vkFtMTMVnWReyoEPiF3EcLH5bTuNZGpmSKLcEU9IYBEHgGgB2c3T/tXZM3XjgnX0U6tyKG2gMLbexCnVnvqEU+aM2oumu24Npowj39c4JtHxl2mFI/Z4WskQLQBxyU/X8ZfPXH4RFuWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612444; c=relaxed/simple;
	bh=G9Bokbb/v6c/hevkiXsoPlLJugZJBNUFbg13K0kFTLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOy4XrCOnQNDItmNl4kqwLihPTXi5R67kYzazo+nJ95PuwCeUbBqMprEdZoaputBO3D9HrLC+EkbSnyPmVYt9pCDYNX4iMJT9qzdZbQQF6+nhQwJXh+r1TNLhzo0anVBvcAPIzbllk5ecHyvM6Xjt0BJvyGdXh7uY13kSxo4WCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=acOQansN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="acOQansN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0994388;
	Tue, 16 Jun 2026 05:20:38 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB1073F915;
	Tue, 16 Jun 2026 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781612442; bh=G9Bokbb/v6c/hevkiXsoPlLJugZJBNUFbg13K0kFTLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acOQansNiTL6E2oKqWKM/EezmJwIrK3c0H/vEf4EEoAXBS23y/HkNfCySxmb3++SA
	 IMoXpFNnhletGShP06Cgv44TvzIrotYR2a+4WhnS9Fzg/DgQk67cwdj41JS4KBsv7x
	 yeJttzwDr8Pfimhb1Ur8BhrbftJS1HLlLtE1Mms8=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 7.1.y 4/5] arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU
Date: Tue, 16 Jun 2026 13:19:56 +0100
Message-Id: <20260616121957.237072-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616121957.237072-1-mark.rutland@arm.com>
References: <20260616121957.237072-1-mark.rutland@arm.com>
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
[Mark: backport to v7.1.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                          | 3 ++-
 arch/arm64/kernel/cpu_errata.c              | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index a01e916ede17d..ad09bbb10da80 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -298,6 +298,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | Olympus core    | T410-OLY-1029   | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | T241 MPAM       | T241-MPAM-1     | N/A                         |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 48233b54c4820..1069ae9535822 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1155,7 +1155,7 @@ config ARM64_ERRATUM_4193714
 	  If unsure, say Y.
 
 config ARM64_ERRATUM_4118414
-	bool "Cortex-*/Neoverse-*/C1-*: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
+	bool "Various: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
 	default y
 	select ARM64_WORKAROUND_REPEAT_TLBI
 	help
@@ -1182,6 +1182,7 @@ config ARM64_ERRATUM_4118414
 	  * ARM Neoverse-V2 erratum 4193787
 	  * ARM Neoverse-V3 erratum 4193784
 	  * ARM Neoverse-V3AE erratum 4193784
+	  * NVIDIA Olympus erratum T410-OLY-1029
 
 	  On affected cores, some memory accesses might not be completed by
 	  broadcast TLB invalidation.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index fe6fe5de495b0..d597896b0f7f3 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -364,6 +364,7 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
+			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 			{}
 		})),
 	},
-- 
2.30.2

