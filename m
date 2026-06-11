Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA288223DEA
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185635; cv=none; b=iGPvuPiRidPFVl3+AWvA143B9lYPKcWJyxzkcyOkJdgc5pxGD+CCURkFlwvV5AbiGOjuVZUWlSss2uCi3SR8vX/jrrV4yC54jEVzq5xStMxK+SuqQNI5IyELX4q2Xxbheindia7Mn3Z9+P52XZmTWsQWyOYgM2njLcu7Hfw08pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185635; c=relaxed/simple;
	bh=bYAJUf0w34Qyhoh9YHc5g8CJVtvEBmXWfYKn4Nt0gcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdvqPOuDkBdwhwd6gga6M2Y6iNFSKUMJZhKFcXNJt65dAebjdsI/5gbo2ZC0EdxHnO+oXXzGM8b9H7ZUwUIjVbbvJESIZ/1lYthnfAWsIJz84xOpITEZL9cjWqcX4qvrs4Im3uvVPKqqtLBiii6oC6nskf9jMeDpYrttleGqrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FjLVB9oF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FjLVB9oF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FCD51E2F;
	Thu, 11 Jun 2026 06:47:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BF6C3FAF5;
	Thu, 11 Jun 2026 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781185633; bh=bYAJUf0w34Qyhoh9YHc5g8CJVtvEBmXWfYKn4Nt0gcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FjLVB9oFDo6bHZXgbHTeMMIokZ9mijzOFDiNteDLkDLxpxCKcrVYpcS+yweGZT7a0
	 M3lZQCkUSnztVKwi4CPjLmllWX2ujttPtpvcRcj9b84tJZt3ioCI/VJUm8O28fUgdm
	 FSXaNNm+hMNzTdLL3srvqe4x4FI2yqjMcwki+HxE=
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
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 5.15.y 0/3] arm64: tlb: Prerequisites for TLBI erratum workaround
Date: Thu, 11 Jun 2026 14:47:03 +0100
Message-Id: <20260611134706.1700777-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v5.15.y-only backport of updates to arm64's
ARM64_WORKAROUND_REPEAT_TLBI erratum workaround, which have been
upstream since v7.0 and have already been backported to v6.18.y. These
are prerequisites for patches to enable the workaround for many more
CPUs, which are queued in the arm64 tree targetting v7.2-rc1:

  https://lore.kernel.org/linux-arm-kernel/20260609101203.1512409-1-mark.rutland@arm.com/
  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/errata

I'm sending backports of these ahead of backports of the
not-yet-upstream portion as these have the key logic changes and I'm
hoping they could be queued early and see more testing. On their own
they serve as an optimization to existing users of the workaround.

I've pushed this series to my stable-5.15/arm-4118414/prerequisites
branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-5.15/arm-4118414/prerequisites

I've pushed a v5.15.y backport of all the not yet upstream patches to my
stable-5.15/arm-4118414/backport branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-5.15/arm-4118414/backport

... and once those are merged into mainline I will submit stable
backports.

Mark.

Marc Zyngier (1):
  KVM: arm64: Remove VPIPT I-cache handling

Mark Rutland (2):
  arm64: tlb: Allow XZR argument to TLBI ops
  arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI

 arch/arm64/include/asm/kvm_mmu.h  |  4 +--
 arch/arm64/include/asm/tlbflush.h | 55 ++++++++++++++++++++++---------
 arch/arm64/kernel/sys_compat.c    |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c     | 41 ++---------------------
 arch/arm64/kvm/hyp/vhe/tlb.c      | 19 ++---------
 5 files changed, 48 insertions(+), 73 deletions(-)

-- 
2.30.2

