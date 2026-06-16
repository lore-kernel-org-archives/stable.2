Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1121B9F6
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586964; cv=none; b=tNUC1M5mY7nIbai6ZsknRNWKAfd3FJQbOoscioiIWkhfAgdjjgdjENSvaRl5Um98T0xL+arKKrSzuZT7NmpN38qUVngY8QyvULm5nIghLFTgsfSwe0ZskOvGZby9SdUI6ncF7fTt3qttityT8YXeCoST/PBOFIW7Ni8etowvpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586964; c=relaxed/simple;
	bh=lldkDsAHPaKWKeKBJ8E0S5hUw8nRSjtUIWGjoQS0KnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHIFURRbgB8annIgf36GkeutMnY30QxTv4sRSHKVeXsj8gwCGstVQ1+IpeHlrgz0j60vCoVeT2kcsWYlw28j+DX7lMHG/r5raSFZQJrdoKBuOCoFHJqRUPGlgrnWrC9ehQb1b+WgrFZihwT7BuOSpD+K3POf4ZAUHuDJxgUD4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dnBudIF8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dnBudIF8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23B3E3D4B;
	Mon, 15 Jun 2026 22:15:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 902883F763;
	Mon, 15 Jun 2026 22:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781586962; bh=lldkDsAHPaKWKeKBJ8E0S5hUw8nRSjtUIWGjoQS0KnU=;
	h=From:To:Cc:Subject:Date:From;
	b=dnBudIF87Zk0XlRoh50bIABQDMF9/jCZ/XfP8nowN1oyi+UsYaSVHdNCcWmN8KSK3
	 HBLzsgBk3I0+udQoYX0dHJJaQ2Y2VK4CCOi4+aiS/rSD/21EXW3l3pdaUBW+i0XMbI
	 EaziDR7Tv4GeGIJHJepYV5HMNU1KX2SzVpYppZCk=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 6.12.y 0/8] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 06:15:44 +0100
Message-Id: <20260616051552.111675-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v6.12-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
yesterday:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

This backport includes prerequisite patches which were previously sent
on their own (unchanged since that posting):

  https://lore.kernel.org/stable/20260611134024.1700323-1-mark.rutland@arm.com/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.12/arm-4118414/backport

Mark.

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

 Documentation/arch/arm64/silicon-errata.rst | 48 ++++++++++++++++
 arch/arm64/Kconfig                          | 50 ++++++++++++++++
 arch/arm64/include/asm/cputype.h            |  6 ++
 arch/arm64/include/asm/tlbflush.h           | 63 ++++++++++++---------
 arch/arm64/kernel/cpu_errata.c              | 34 ++++++++++-
 arch/arm64/kernel/sys_compat.c              |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c                |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c               |  8 +--
 arch/arm64/kvm/hyp/pgtable.c                |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c                | 10 ++--
 10 files changed, 185 insertions(+), 40 deletions(-)

-- 
2.30.2

