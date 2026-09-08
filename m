Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AF560AA5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880680; cv=none; b=OBkauOgCVml5kuEXIj8Rx1X3Vx9V4wnanqIrotm71hWTpIgaqQZvdF0YHqhjUR1DZtwNdjEqFImPtP14vvTPJ/D/UWH2CdWpreNIY8CM2QkeYb7N1mmUaPib3XW5o7gym6hFuy6KFoaWUB4PX4NYPhptTZAQO/hrZLieFwPVp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880680; c=relaxed/simple;
	bh=XfPVvq8e9tGKo018JKnP1xN3ulUHGDRgrdtFYDoHbhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PLOiPD8t17dN641uXIUtk6VyjSuk67+2V6NbiCARsAKus3ODZ/Zv+4FpL3GDxwMfOPYGuFPyF3C8kSF/QnbWR6hq2kEehG69+uAm+61ehh3Ju4w2zuwXo7k/H4eNYPXzJ/Ha9aYjxytE6b6CdTIhWwq/hOyLPEj4dJsV9qcwqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eC1JwmJX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eC1JwmJX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BE1C1476;
	Tue,  8 Sep 2026 08:17:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25AF93F7B4;
	Tue,  8 Sep 2026 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788880672; bh=XfPVvq8e9tGKo018JKnP1xN3ulUHGDRgrdtFYDoHbhQ=;
	h=From:To:Cc:Subject:Date:From;
	b=eC1JwmJXjAGjIR8jtufTmIkRWC9+mz95Z+2YR5MTq9dTvmA3NECireUnkC1iacjsd
	 FLVOJoxem4DY8FJshVvwvNaOM6Yjz4+Tr+4k/HLioTAHN1MC9dfj0yOIjtKcmpvPQI
	 uyBIzAhSeZCKdYV2y4Ibzr5ehUtu5O0lwmD9vzh8=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	david@kernel.org,
	david.laight.linux@gmail.com,
	james.morse@arm.com,
	ljs@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	peterz@infradead.org,
	ruanjinjie@huawei.com,
	ryan.roberts@arm.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com,
	vladimir.murzin@arm.com,
	will@kernel.org,
	yang@os.amperecomputing.com
Subject: [PATCH v4 00/21] Preemptible this_cpu_*() operations
Date: Tue,  8 Sep 2026 16:17:20 +0100
Message-Id: <20260908151741.394589-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reworks arm64's this_cpu_*() operations such that they do
not need to disable preemption. The scheme is described in detail in patch 13,
and is similar to the approach Heiko Carstens applied to s390 [1], which
inspired this series.

This scheme should build and function in all kernel configurations (e.g.
regardless of KPTI, SW PAN, CNP, VA BITS), and has no dependency on new
architectural features. The fixup logic should "just work" with kprobes,
etc, and I don't expect that this will need to become more complicated.

The patches are organised as follows:

* Patches 1 to 3 are preparatory fixes for latent issues which were
  found by inspection. These will need to be backported to stable, and
  have appropriate Fixes tags.

* Patches 4 to 7 are preparatory improvements to code generation issues
  found by inspection during development. These aren't strictly related
  to the PCPU GPR scheme, and it would make sense to queue these even if
  we don't go ahead with the rest of the series.

* Patches 8 to 13 are preparatory work for the PCPU GPR scheme.

* Patch 14 implements the core of the PCPU GPR scheme, with all the
  necessary exception handling logic, and the addition of helpers to
  begin/end a PCPU GPR critical section.

* Patches 15 to 20 convert this_cpu_*() operations over to the PCPU GPR
  scheme. These changes have been made over several patches to aid
  review and bisection (if necessary).

* Patch 21 removes code made redundant by earlier patches.

I've given this build-testing (with GCC and clang) and some light boot
testing.

Since v1 [2]:
* Implement necessary SDEI entry logic.
* Drop RFC tag, as I believe this is now functionally complete.
* Add patches to fix latent bugs and poor codegen (per David, and myself)
* Make gpr-num handling consistent with asm-extable.h
* Assert PCPU GPRs are distinct at compile time (per Vladimir)
* Add comments to document PCPU GPR helpers.
* Improve commit messages.
* Add tags from v1.

Since v2 [3]:
* Rebase to v7.3-rc1.
* Fix SDEI register restoration.
* Avoid -Woverflow warnings.
* Add preparatory fix for {8,16}-bit types.
* Add tags from v2.

Since v3 [4]:
* (hopefully) correct CC list and send this out without issues.
* Add Jinjie's Reviewed-by tag on patch 3.
* No other changes.

Thanks,
Mark.

[1] https://lore.kernel.org/linux-s390/20260526055702.1429061-1-hca@linux.ibm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20260728123859.2911495-1-mark.rutland@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20260804170503.3513916-1-mark.rutland@arm.com/
[4] https://lore.kernel.org/linux-arm-kernel/20260904161758.376504-1-mark.rutland@arm.com/

Mark Rutland (21):
  arm64: percpu: Fix this_cpu_write() casting
  arm64: percpu: Fix this_cpu_and() mask generation
  arm64: percpu: Fix LSE operations on {8,16}-bit types
  arm64: cmpxchg: LL/SC: Avoid redundant extension
  arm64: cmpxchg128: LSE: Remove redundant operands
  arm64: preempt: Simplify and optimize __preempt_count_dec_and_test()
  arm64: preempt: Treat should_resched() as unlikely
  arm64: ptrace: Always inline pt_regs_[read,write}_reg()
  arm64: percpu: Factor out percpu offset asm
  arm64: gpr-num: Add wxN aliases for wN registers
  arm64: gpr-num: add __GPR_NUM() helper
  arm64: entry: sdei: Restore all clobberable GPRs
  arm64: entry: sdei: Make 'tsk' available
  arm64: percpu: Add infrastructure for preemptible this_cpu_*() ops
  arm64: percpu: Implement preemptible read/write ops
  arm64: percpu: Implement preemptible void RMW ops
  arm64: percpu: Implement preemptible return RMW ops
  arm64: percpu: Implement preemptible XCHG ops
  arm64: percpu: Implement preemptible CMPXCHG ops
  arm64: percpu: Implement preemptible CMPXCHG128 ops
  arm64: percpu: Remove _pcp_protect*() wrappers

 arch/arm64/include/asm/atomic_ll_sc.h |  27 +-
 arch/arm64/include/asm/atomic_lse.h   |   4 +-
 arch/arm64/include/asm/gpr-num.h      |   9 +
 arch/arm64/include/asm/percpu.h       | 462 ++++++++++++++++++++------
 arch/arm64/include/asm/preempt.h      |  29 +-
 arch/arm64/include/asm/ptrace.h       |  12 +-
 arch/arm64/include/asm/thread_info.h  |   1 +
 arch/arm64/include/asm/xwreg.h        |  16 +
 arch/arm64/kernel/asm-offsets.c       |   2 +
 arch/arm64/kernel/entry-common.c      |  38 +++
 arch/arm64/kernel/entry.S             |  41 ++-
 11 files changed, 497 insertions(+), 144 deletions(-)
 create mode 100644 arch/arm64/include/asm/xwreg.h

-- 
2.30.2

