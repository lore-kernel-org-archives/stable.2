Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C0531714A
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612439; cv=none; b=thX++LJtUapM5ShgTZlYK70c766nXaKsja+IKo2A/Ge3C4DhBWo+yrACVmTWotaAQ5aFNoEDWLwMmy9KDOT711OQ8Cb5uDgxHmlZVv4cP30UhgTtsZ0VpmoIgLyZMb2nQkU/8G8bMN18FfwZ4F7uxKOuuU4GGj0XtJG8e/QQ4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612439; c=relaxed/simple;
	bh=9m0b8CnfHDYJvYoeIQQnZjAvUrT4/TMAaM8ff9ivnOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3sZOAQwqMvfsJEga0rWw3668Qvy8Y2RtHH+4BnwY9E9goxuMhyD4lbBvE9NBnsdonYfM3i//3fQfDkbyEfYR7lLMdTGpxfRFJUY7c9mW1kEatj5E1AkaUW4jE55Jire+IzmITMF0roV5PPPLWqVN6PabwYYLe6LdtLSYjjDbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gaY9keKv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gaY9keKv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC5614388;
	Tue, 16 Jun 2026 05:20:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 882863F915;
	Tue, 16 Jun 2026 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781612436; bh=9m0b8CnfHDYJvYoeIQQnZjAvUrT4/TMAaM8ff9ivnOI=;
	h=From:To:Cc:Subject:Date:From;
	b=gaY9keKvZJ9UDTtrbjBVwuDUbCkxU928+fcOW4zbizHr+oU/hZak4edhKTboMyfxh
	 KYZu80GnDAFLUAIcsH+Wu9mSr+/TAKSjHGSYbL4mfKtT6zL2l0RI2/P8tag/iUrRAk
	 Qd+mqRwu59VyPHQANS8aXWRXZ4Aprovyyvk0Ghuc=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: catalin.marinas@arm.com,
	lee@kernel.org,
	mark.rutland@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 7.1.y 0/5] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 13:19:52 +0100
Message-Id: <20260616121957.237072-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

This is the v7.1 backport you requested at:

  https://lore.kernel.org/stable/2026061658-landowner-dangling-5d07@gregkh/

... regular spiel below.

This is a v7.1-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
recently:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-7.1/arm-4118414/backport

Mark.

Mark Rutland (3):
  arm64: cputype: Add C1-Ultra definitions
  arm64: cputype: Add C1-Premium definitions
  arm64: errata: Mitigate TLBI errata on various Arm CPUs

Shanker Donthineni (1):
  arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Will Deacon (1):
  arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

 Documentation/arch/arm64/silicon-errata.rst | 46 +++++++++++++++++++++
 arch/arm64/Kconfig                          | 38 +++++++++++++++++
 arch/arm64/include/asm/cputype.h            |  4 ++
 arch/arm64/kernel/cpu_errata.c              | 34 ++++++++++++++-
 4 files changed, 120 insertions(+), 2 deletions(-)

-- 
2.30.2

