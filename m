Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581440;
	b=oIpKOiQOjVlADu2DGfXfWDhzwbfKCRt/L4t45fQZUsIws6wHeR9WiTxUqJ0SXQiKfOFs
	 TRMeM9RN/jz+b8IKlRt3czcO7VQpHU+tfewMhiWuuc3PGA1GmLee+QSFJV7jecbcSOaDp
	 Nrw53n3eX+JZ7BK1pcmJ+aNzyAlU+1Agp54sXDcODJNWOjwGIWJMJsfOEKkdMgdMWHj/i
	 l4AH9kKg5OHUBO0WbI7U3QDS4yf9BsuWwPvRyYzaIra4LN/Q++VkQZhRsV0BknEVQhkht
	 WxArWwjA8+yFlQeK5JWa+zzKjcQ7ZSMLz+vhToSOwla69oAIq5Flz5GmEFUl1lMDg0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581440;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5O0auP4jitpbItZztn3RS4SvBnW87g5weMpMzD5R8eQ=;
	b=QVyFGZ1k6OpYvSMFwwUMJv4mpPf3WpxgYDVUJIU5C4dmMb7iJWy6hQkOfJP7qk/EUmMq
	 petcYhnxr1+JqZBYQh8sSbhs/ftScXJw2DdSh2eKo5BaBxqNUDY8EUSn5dEl0uI2GJ9yf
	 gzZxVWnMfKeJRPzKtTuik2tjE10204ECQm3g3Dqa/AzSb2DIE8Mln0+RgoyIwrGmh9jo/
	 dNc4qFq5wip+rmQfJXUF2ZFlJNTO5bwHUC/PGSi6h6shxpRRpofjm6m+lQxqHK5LbZBVv
	 rhV2BD56V+YzskKt4QU8QG6e9YjKHj0zlfFlyd4XLm4xQ72B1/IMfF8QDGuMcS/rqXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dT+YVzFn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64842606A32D;
	Fri, 13 Nov 2026 14:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64842606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dT+YVzFn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C43A31516;
	Fri, 13 Nov 2026 06:50:36 -0800 (PST)
Received: from e144440.cambridge.arm.com (e144440.arm.com [10.2.199.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F6423F673;
	Fri, 13 Nov 2026 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794581439; bh=8sH6OWzawGkWhFlM6CLsdZvyw+UZgXwwEVjUcXVsOGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dT+YVzFnfF27iG8kpym2vzxt8yjMknCqDWB/v2AXQJCBIsDPGpSIbSRMpEki2lyeO
	 yyTG9oV5OvUyHKJbbBVp9/JlbYYIahUW4+6bXLUsjVH7eeDS5Pa61HfTlDVK4gZvCj
	 +U2K3KjTYqPLOScnEf6K7fMKAnm8EOe59dbYj+4g=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linu Cherian <linu.cherian@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/6] arm64: cpufeature: Remove Neoverse-V3/AE from the BBML3 allow list
Date: Fri, 13 Nov 2026 14:50:15 +0000
Message-ID: <20261113145022.2592454-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113145022.2592454-1-ryan.roberts@arm.com>
References: <20261113145022.2592454-1-ryan.roberts@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neoverse-V3 and Neoverse-V3AE erratum 3053180 can cause a load or store
to livelock when mapping size changes without break-before-make or when
contiguous hints are programmed inconsistently.

The erratum was previously reported as fixed in r0p2. On that basis,
commit 5aa4b625762e ("arm64: Add BBM Level 2 cpu feature") allowed
Neoverse-V3 from r0p2, and commit 8fca3852e33d ("arm64: cpufeature: add
Neoverse-V3AE to BBML2 allow list") did the same for Neoverse-V3AE.

The updated SDENs, MP168 v11 for Neoverse-V3 and MP172 v12 for
Neoverse-V3AE, dated 9 June 2026, list r0p0, r0p1 and r0p2 as affected
and the erratum as open. There is no fixed revision on which to base
either allow-list entry.

Remove both entries so these CPUs observe break-before-make, and record
the workaround in the silicon errata registry.

Cc: stable@vger.kernel.org
Link: https://support.arm.com/documentation/109231/11-0/?lang=en
Link: https://support.arm.com/documentation/109704/12-0/?lang=en
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 4 ++++
 arch/arm64/kernel/cpufeature.c              | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index afe109afe692..9ad965d3e1ea 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -243,10 +243,14 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V2     | #4193787        | ARM64_ERRATUM_4118414       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3     | #3053180        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #4193784        | ARM64_ERRATUM_4118414       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #3053180        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #4193784        | ARM64_ERRATUM_4118414       |
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 34c5c03c0c9b..b15619690f42 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2012,8 +2012,6 @@ bool cpu_supports_bbml3(void)
 	/* CPUs that support BBML3 but dont advertise through ID_AA64MMFR2_EL1 */
 	static const struct midr_range supports_bbml3_list[] = {
 		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
-		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
-		MIDR_REV_RANGE(MIDR_NEOVERSE_V3AE, 0, 2, 0xf),
 		MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 		MIDR_ALL_VERSIONS(MIDR_NVIDIA_RIGEL),
 		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
-- 
2.43.0

