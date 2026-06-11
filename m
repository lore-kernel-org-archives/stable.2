Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44A33F788A
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185236; cv=none; b=i7mif2WCoJasOt+YarNWsinmN+X7ie+In9B3xJ0YMjmqqQmi8z3jbdzoDlfgaV/Q6UQoN1LuRusWLelaxbwwCtd9N1VrGhGcSbdh6bQQZo8yotHXwmtuz5TwbMjDmhy+9UHImB7cCA1JSWjMCTF1wh4bzBUhoak2RbN7FQE6Yhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185236; c=relaxed/simple;
	bh=yrKs/eMhesXtTbBGx0mb3B4KBmCw2f6TOht/07OU9FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xb0tRabmE+hrpNXcdVyzOyT5N6xR0cHIJfbL1YuaUY0PrsFW7sUtLy4u4Df9qSKqSWc2onKzj17TMTYPCppk+rK4bzf6a/JFoXnQqfkoKPKqib/aNzM8ftTu3A1HVrVrCLONiE9qpM8gK5onJtC+Av0sp8h49qfirhR9g8JKRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SXH17Raq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SXH17Raq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B62D1DB5;
	Thu, 11 Jun 2026 06:40:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E2633FAF5;
	Thu, 11 Jun 2026 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781185233; bh=yrKs/eMhesXtTbBGx0mb3B4KBmCw2f6TOht/07OU9FQ=;
	h=From:To:Cc:Subject:Date:From;
	b=SXH17RaqpbDtQGhYW85l/MWOqI2NpjT09jeIbJXXGQJ7Vq7AtxB4qu9scgq5PgIej
	 KgftCCm+yT9atJw6vA5hm1ZTdAqwmJOXlqD3HWyS5y7/NJI6MHNWV9GZV5MSrg28qN
	 KLnV+Z/e+39ZG5rKXr/BtDpidS1lt1pnzC4Rgb7A=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	will@kernel.org
Subject: [PATCH 6.12.y 0/2] arm64: tlb: Prerequisites for TLBI erratum workaround
Date: Thu, 11 Jun 2026 14:40:22 +0100
Message-Id: <20260611134024.1700323-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v6.12.y-only backport of updates to arm64's
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

I've pushed this series to my stable-6.12/arm-4118414/prerequisites
branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.12/arm-4118414/prerequisites

I've pushed a v6.12.y backport of all the not yet upstream patches to my
stable-6.12/arm-4118414/backport branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.12/arm-4118414/backport

... and once those are merged into mainline I will submit stable
backports.

Mark.

Mark Rutland (2):
  arm64: tlb: Allow XZR argument to TLBI ops
  arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI

 arch/arm64/include/asm/tlbflush.h | 63 ++++++++++++++++++-------------
 arch/arm64/kernel/sys_compat.c    |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c      |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c     |  8 ++--
 arch/arm64/kvm/hyp/pgtable.c      |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c      | 10 ++---
 6 files changed, 49 insertions(+), 38 deletions(-)

-- 
2.30.2

