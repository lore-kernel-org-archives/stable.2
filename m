Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8401EEA49
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587551; cv=none; b=eUpu+9vCByg42eDuDRGB4a5U8TZ+5wINRKeaigQ9+41O5B2iBr4rT7RUPNxRUSZGDTv4VnGadzXfWPWJNilAAvG8XPtvDAOY0ypWSDg6bnSKD9vtuIgYZhNXLhHEg2w9Rp1EXtmCMjeTw5cRJ4LQyOP3abROFWefjsufecRtrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587551; c=relaxed/simple;
	bh=F/4jl9jeIT/0Y0tBoOEZaPrEGYX4sMXESSCb/ey/sXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XzWmqR2yseGe/2D58xp04siMiuWmV7MHGla0D4oFOrMa+kpsJfm3rmDyRp2jboG3QjUxCldIcckEu8LGORXwyk5NwrouMrEUgenvsgOfUWhMYAdGYt/E0tQOYrypy3JvxzpqJEscLjBKnYt/MHB9aLGo09rXjHCRiQDZ0nZVpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iDaK0cmZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iDaK0cmZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 489E03D4B;
	Mon, 15 Jun 2026 22:25:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DFBB3F763;
	Mon, 15 Jun 2026 22:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587550; bh=F/4jl9jeIT/0Y0tBoOEZaPrEGYX4sMXESSCb/ey/sXk=;
	h=From:To:Cc:Subject:Date:From;
	b=iDaK0cmZ0BlQ5qLhcBouimcW9QfyDGBP6p4I+tgYnqJG6PQHpT49vTbyQdim7Qi0w
	 zTiGgDb0u/yE2aeNN1IK2XMRygSl70FDtajbK+EjOa3a4pRiOERKRM/ML1uMJbc+r5
	 Ms/zJZG8su6MLj0mWkfOF8pUYMlxX5g+6AKdOtT8=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	eahariha@linux.microsoft.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 5.10.y 00/10] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 06:25:33 +0100
Message-Id: <20260616052543.112176-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v5.10-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
yesterday:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

This backport includes prerequisite patches which were previously sent
on their own (unchanged since that posting):

  https://lore.kernel.org/stable/20260611134903.1700976-1-mark.rutland@arm.com/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-5.10/arm-4118414/backport

Mark.

Easwar Hariharan (1):
  arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Marc Zyngier (1):
  KVM: arm64: Remove VPIPT I-cache handling

Mark Rutland (5):
  arm64: tlb: Allow XZR argument to TLBI ops
  arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI
  arm64: cputype: Add C1-Ultra definitions
  arm64: cputype: Add C1-Premium definitions
  arm64: errata: Mitigate TLBI errata on various Arm CPUs

Shanker Donthineni (2):
  arm64: cputype: Add NVIDIA Olympus definitions
  arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Will Deacon (1):
  arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

 Documentation/arm64/silicon-errata.rst | 48 ++++++++++++++++++++++
 arch/arm64/Kconfig                     | 50 +++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h       | 10 +++++
 arch/arm64/include/asm/kvm_mmu.h       |  4 +-
 arch/arm64/include/asm/tlbflush.h      | 55 ++++++++++++++++++--------
 arch/arm64/kernel/cpu_errata.c         | 34 +++++++++++++++-
 arch/arm64/kernel/sys_compat.c         |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c          | 41 ++-----------------
 arch/arm64/kvm/hyp/vhe/tlb.c           | 19 ++-------
 9 files changed, 188 insertions(+), 75 deletions(-)

-- 
2.30.2

