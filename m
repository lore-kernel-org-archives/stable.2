Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A158130C158
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185379; cv=none; b=DxG3RIHYoA0WT5tO1oOFKecDeYLPi/82lYB5icEqog1xDy5oFBvQvdR1pyYUu4Xm9Qf+EZhzOVQbGXs2PLh0bYlxbk4HQPc0zwHSzQtO76bpPirJQjBYR/XScbEftdmOzKTJ8g/IvcZngAm29HRqqRQC1fTFkAh2oWC+693MS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185379; c=relaxed/simple;
	bh=qYopb4hIwF340W9FD7UKVqpxzWbwQPH5UqqJAHzjrh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pIrWncDSMHoASfuaAgrYUG4E/Xp51Z6VLRyl3EGFzwiD60WJW/JlomyWgcmQYoQEV/l8WsJjbrkzkIyTsKvhbX0WBnft1DqsSoAki3n2wjImwgoJsajvsNNG8Ap6Ux/I9JoRdVxFlEWJyRAAOOErKC+4WxU4GXYLx931ezkzlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aQb36LSy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aQb36LSy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2EF1DB5;
	Thu, 11 Jun 2026 06:42:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CE973FAF5;
	Thu, 11 Jun 2026 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781185377; bh=qYopb4hIwF340W9FD7UKVqpxzWbwQPH5UqqJAHzjrh4=;
	h=From:To:Cc:Subject:Date:From;
	b=aQb36LSyq3z4qsxYa5r8eonClhg+ZPXLhQbQtu/ZYfKLfpgjGr0PwqMoHbbv1oSfT
	 zkIsEzwPNUZe62c4koc0Xe18tmnJVnuSzI3UqfDZ9zCAU8K8j6TY4v3Sv457ZeZGVk
	 b2TGMgPJ0uhl5AXs7IBJqihMN0pwX/+eRjNDWii0=
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
Subject: [PATCH 6.6.y 0/3] arm64: tlb: Prerequisites for TLBI erratum workaround
Date: Thu, 11 Jun 2026 14:42:45 +0100
Message-Id: <20260611134248.1700496-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v6.6.y-only backport of updates to arm64's
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

I've pushed this series to my stable-6.6/arm-4118414/prerequisites
branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.6/arm-4118414/prerequisites

I've pushed a v6.6.y backport of all the not yet upstream patches to my
stable-6.6/arm-4118414/backport branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.6/arm-4118414/backport

... and once those are merged into mainline I will submit stable
backports.

Mark.


Marc Zyngier (1):
  KVM: arm64: Remove VPIPT I-cache handling

Mark Rutland (2):
  arm64: tlb: Allow XZR argument to TLBI ops
  arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI

 arch/arm64/include/asm/kvm_mmu.h  |  5 +--
 arch/arm64/include/asm/tlbflush.h | 64 ++++++++++++++++------------
 arch/arm64/kernel/sys_compat.c    |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c      |  2 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c    |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c     | 69 ++-----------------------------
 arch/arm64/kvm/hyp/pgtable.c      |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c      | 21 ++--------
 8 files changed, 51 insertions(+), 116 deletions(-)

-- 
2.30.2

