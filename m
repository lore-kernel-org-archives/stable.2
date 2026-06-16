Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E713CE09B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587115; cv=none; b=AuuWyBz7nvvBIqSX7dLvmHPRWvjrrYhqWO/eDoWuOPV+m+s1B6wWyev6/QSL3WxXBfziIIx+gyEOg3MX88FBNfMtRYmSdsA41f66Ub/N6up/yjSMjyDnZJzGQVCfo0Lh2LOgS7nq15ognE63W7PSnjfzlM9QXvHdZ+tl+Ow5WC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587115; c=relaxed/simple;
	bh=T+O5SnnNXmbWrnhrROFuRS1uRRWnCWda5cT1lIWqP4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PjnrpiZio7BCqzg7TJSJMeqC5iXQUJjazFM2EA54og1CKPRO9Z4N4yaPOc01w1F9YJFdcMFLRpL62+GOu9+CwS53QKlEiR11UTzRo5gSKvUM53mGWj9nB9U0FQeCdL7S5RcPD9w2oG4iikIw+qo1ybxiSVSkUr7r12jwMiMpQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NoiEs0b1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NoiEs0b1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A087C3D5D;
	Mon, 15 Jun 2026 22:18:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9244F3F763;
	Mon, 15 Jun 2026 22:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587113; bh=T+O5SnnNXmbWrnhrROFuRS1uRRWnCWda5cT1lIWqP4o=;
	h=From:To:Cc:Subject:Date:From;
	b=NoiEs0b12ZW0h+EI4nkpiSqPVSApnRHZgIH22eKL56aOQS8nuA9AIrGm2Y2mbB7yz
	 9zhKd0xPByCCvYz6J0a7H1reejVC21vCq4YtIWmP4AuGlziDntGIqboNbh3EyGSp+c
	 IEAw50Ic3e3iCj2zN7h1vCeh6q42QQRus9JvPya4=
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
Subject: [PATCH 6.6.y 0/9] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 06:18:13 +0100
Message-Id: <20260616051822.111870-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v6.6-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
yesterday:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

This backport includes prerequisite patches which were previously sent
on their own (unchanged since that posting):

  https://lore.kernel.org/stable/20260611134248.1700496-1-mark.rutland@arm.com/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.6/arm-4118414/backport

Mark.

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

 Documentation/arch/arm64/silicon-errata.rst | 48 ++++++++++++++
 arch/arm64/Kconfig                          | 50 +++++++++++++++
 arch/arm64/include/asm/cputype.h            |  6 ++
 arch/arm64/include/asm/kvm_mmu.h            |  5 +-
 arch/arm64/include/asm/tlbflush.h           | 64 +++++++++++--------
 arch/arm64/kernel/cpu_errata.c              | 34 +++++++++-
 arch/arm64/kernel/sys_compat.c              |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c                |  2 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c              |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c               | 69 ++-------------------
 arch/arm64/kvm/hyp/pgtable.c                |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c                | 21 ++-----
 12 files changed, 187 insertions(+), 118 deletions(-)

-- 
2.30.2

