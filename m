Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAFB33F5BF
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612568; cv=none; b=k5ZDveKVdGB4A+TnG6t+FLSh7jhNy+yTpde5lsh682ndG0YLJhTeu9hcHwunvup6fe6vx/usALsp5Bkn9nVuThfhqNYFiYiK8MhnOjFTF45KAe6xr0/bcqgjjqWE5InjKDF8wjrOH2bo3y+uTz/F3xeJSvAy/CK++czrQJaCtlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612568; c=relaxed/simple;
	bh=cKc7E7R0jhzq18YdorOqLopTh2bP/qMjWXdIlQ2aC6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3Rpul8JOFx44mfVcBCcfmiqNPePDou/YSGGgEoHOPEjbjP+k7rq1vwrKY6smVOS+7f5XeQ5miVikNJ8mqMs4gXb4AtG8DXtYXyG+Oyk0nqiUWLFVFwcoFk2P5CPdFSuqzKugdd4U0pLmcUtod2WND5WVslfjc03wfx1lqD7LNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qyj9eBAH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qyj9eBAH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A50E74507;
	Tue, 16 Jun 2026 05:22:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 603963F915;
	Tue, 16 Jun 2026 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781612566; bh=cKc7E7R0jhzq18YdorOqLopTh2bP/qMjWXdIlQ2aC6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qyj9eBAHbetpjOwfJuFZv/yZz+L7MOGKiJaRKXOzF/VM7uupPCcFg+6XX5KlKMvSc
	 2941zQ4WjklP5V6v3X9xuOcQx/OQMIl3/QUQGXvhinCZ7cHSJz2MXy3nb5JPcPlRAk
	 p7PUuZC5M+IiOeRu8n9efup1MuSXI+UI97kZuWa8=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 7.0.y 5/5] arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU
Date: Tue, 16 Jun 2026 13:22:31 +0100
Message-Id: <20260616122231.237216-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616122231.237216-1-mark.rutland@arm.com>
References: <20260616122231.237216-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Will Deacon <will@kernel.org>

commit 1940e70a8144bf75e6df26bf6f600862ea7f7ea1 upstream.

Commit fb091ff39479 ("arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
Neoverse N2 errata") states that Microsoft Azure Cobalt 100 CPU "is a
Microsoft implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and
therefore suffers from all the same errata.".

So enable the workaround for the latest broadcast TLB invalidation bug
on these parts.

Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v7.0.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                          | 1 +
 arch/arm64/kernel/cpu_errata.c              | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 9d680c1a7befe..6046648f6d515 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -352,3 +352,5 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Microsoft      | Azure Cobalt 100| #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c5808f3cba627..81fa36603e3e3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1204,6 +1204,7 @@ config ARM64_ERRATUM_4118414
 	  * ARM Neoverse-V2 erratum 4193787
 	  * ARM Neoverse-V3 erratum 4193784
 	  * ARM Neoverse-V3AE erratum 4193784
+	  * Microsoft Azure Cobalt 100 4193789
 	  * NVIDIA Olympus erratum T410-OLY-1029
 
 	  On affected cores, some memory accesses might not be completed by
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0b39556c88349..476a37c821083 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -364,6 +364,7 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
+			MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 			{}
 		})),
 	},
-- 
2.30.2

