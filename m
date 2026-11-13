Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581442;
	b=uLUw1ifmJjJftUU7IsHpKVZLN4af17VAbAf8Jz+6zknSkUrQYNj/arUxF3pXkn42p3Lg
	 eO7FCmq7LQL01VuY9/WFUraR/z4cDxDVCQLCcw++MOYbIl217zW+bO1CyTgbIQg3UZry1
	 HOAm9ogIEdzc78kljEnMgdADDO1UaCB01k1dXPkYMpGkCCWf1dguv1SUXj4jZPaWwL/R1
	 rcCUke2IHsSIjz28e0EkcAGD54fikLGy/ZIiksJ/fHU3YY9GEARXFPpHGlx/ubjarvKhF
	 5fBqoQ0+nRRoZtMAp8VGBstCvIzx+JbC0gyrIinoXyywrr6G4sihKTYLWNQ8cU4RHfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581442;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1sqIuqvMzVFwYcFFuvB/apl5px1GCvknNh/xIFDj1SY=;
	b=emGnfFp8WXkChMOqIPdH1WhOHpZ2ltfJdzjMujGD0sH/p2SDB7oOx5N9TrPbk02RgkPu
	 VVfylJFTamVjUe1QuXCdHvaZWLJaBM3uUbdbAY57KpguAFREeq+11DZJulQiEId4lkTwZ
	 ReCBNgGtmb4VOV0dIcmkefs+wiFT/JOzMU/9e0AIRYy10ORxOg0Co8U23jHHPKGWUwEd7
	 q3vDVT9XRO49zkeV/0Y9g+zB8di4FF9WmWjf3jVWgP6NTnVjtpOxVu1ZWpfyv8042gSSy
	 ZSwC1pdgZQVB/3fJVLnQWR7PE6fe9BXhZKxL0RrPbmsffLQgTrpXO0E1hAGAiShdexw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WW3kvaeG;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAB0606A88B;
	Fri, 13 Nov 2026 14:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEAB0606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WW3kvaeG
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6493C152B;
	Fri, 13 Nov 2026 06:50:38 -0800 (PST)
Received: from e144440.cambridge.arm.com (e144440.arm.com [10.2.199.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E4B73F673;
	Fri, 13 Nov 2026 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794581441; bh=9SQUwLMIpYjcJX0oV2YKzFqBcvrlXidnGf8kMaWOSRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW3kvaeG9n4NBPABbem1UbMv99+oSVaMw1U5+oBv4pPoupwTYXe4OMAfkgLFyHtVN
	 GMCpq55Y+7ITdds5C+fDgP25eWxbVe0cI9jU1dh8LTjbZjt+rTmIJpiWLr5UvLYq/K
	 FA1QCBM924D3Nf9NnWkqCzQD1gQPXaZba0GJw8zU=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linu Cherian <linu.cherian@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 2/6] arm64: cpufeature: Remove Cortex-X4 from the BBML3 allow list
Date: Fri, 13 Nov 2026 14:50:16 +0000
Message-ID: <20261113145022.2592454-3-ryan.roberts@arm.com>
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

Cortex-X4 erratum 3043263 can cause a load or store to livelock when
mapping size changes without break-before-make or when contiguous hints
are programmed inconsistently.

The erratum was previously reported as fixed in r0p3. On that basis,
commit 5aa4b625762e ("arm64: Add BBM Level 2 cpu feature") added
Cortex-X4 from r0p3.

The updated Cortex-X4 SDEN v13, dated 18 June 2026, lists r0p0, r0p1,
r0p2 and r0p3 as affected and the erratum as open.

Remove the entry so Cortex-X4 observes break-before-make, and record the
workaround in the silicon errata registry.

Cc: stable@vger.kernel.org
Link: https://support.arm.com/documentation/109148/13-0/?lang=en
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/kernel/cpufeature.c              | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 9ad965d3e1ea..9d6d13045a55 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -201,6 +201,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X3       | #4193786        | ARM64_ERRATUM_4118414       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X4       | #3043263        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X4       | #4118414        | ARM64_ERRATUM_4118414       |
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b15619690f42..8819652a67ed 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2011,7 +2011,6 @@ bool cpu_supports_bbml3(void)
 {
 	/* CPUs that support BBML3 but dont advertise through ID_AA64MMFR2_EL1 */
 	static const struct midr_range supports_bbml3_list[] = {
-		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
 		MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 		MIDR_ALL_VERSIONS(MIDR_NVIDIA_RIGEL),
 		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
-- 
2.43.0

