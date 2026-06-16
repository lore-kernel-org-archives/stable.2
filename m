Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224803CF1FD
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587257; cv=none; b=Gy8S3LgPiHa6VuVdJJvqmOlIP6TP1h9NDL5aDqt0vmf6ao2RKtq5ANR+49iXkzBj3kkhVsRWUSI6m5o3FLSq13nVvt0/SFQkBG518nvkMODiD+i5gJSY6HkVk6ZEzOup373R7Xobjzm016B2TxZ3ysw8cONRZ/qqXO3ur0F+o0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587257; c=relaxed/simple;
	bh=F8GMh151XZEH1IJGS4i2ScY6FZVvBKPAxosRptMbit4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSZq1UcSZdFSyrLDj+4O/MKtnFWS82sHFkPBcBAVC520oHJ6pBHEWTc9JWUtPt9FZ8xG8XRywE0JK4G5HqpGILLfM9MbnmnhnoeT2V/vawLIcWPZkcJxAneUL+lsf7ZAoqyY2mYApZIbQItJV7RDMG7rB7JV05rRDtfAERth7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WWNmMMum; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WWNmMMum"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 080833D4B;
	Mon, 15 Jun 2026 22:20:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEFA33F763;
	Mon, 15 Jun 2026 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587253; bh=F8GMh151XZEH1IJGS4i2ScY6FZVvBKPAxosRptMbit4=;
	h=From:To:Cc:Subject:Date:From;
	b=WWNmMMumCoFvz54ZcA6C83G6nEVL8s0D/LA+2RyNczgokBvLm7ul7aFD6Uw9ItiNW
	 N2jy+DGV4JxjRkGhlfwNjeV3sYFxJeB2KT+rwO+TzQhRKoI1xYAnOsKVW/jMQ3PJcP
	 ldl8ioDe55JJvlMcRUVqaLyWFtJlP+l5oeQFkicY=
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
Subject: [PATCH 6.1.y 0/9] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 06:20:37 +0100
Message-Id: <20260616052046.112003-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v6.1-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
yesterday:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

This backport includes prerequisite patches which were previously sent
on their own (unchanged since that posting):

  https://lore.kernel.org/stable/20260611134451.1700637-1-mark.rutland@arm.com/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.1/arm-4118414/backport

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

 Documentation/arm64/silicon-errata.rst | 46 +++++++++++++++++++++++
 arch/arm64/Kconfig                     | 50 +++++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h       |  6 +++
 arch/arm64/include/asm/kvm_mmu.h       |  4 +-
 arch/arm64/include/asm/tlbflush.h      | 52 ++++++++++++++++++--------
 arch/arm64/kernel/cpu_errata.c         | 34 ++++++++++++++++-
 arch/arm64/kernel/sys_compat.c         |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c          | 41 ++------------------
 arch/arm64/kvm/hyp/pgtable.c           |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c           | 19 ++--------
 10 files changed, 180 insertions(+), 76 deletions(-)

-- 
2.30.2

