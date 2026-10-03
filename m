Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFA388879;
	Sat,  3 Oct 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791032214; cv=none; b=OyQBGXjKj09zy4ADyWZfCWrI0RbjH0INarIi1xxDHSvui22DafgMI9HA9rKF5DaD4vjc/rF8IKTlc0AUD0p8aptQzvyDx4z2DVw3sCMzmyS6euAMlehdEPA1VdFSrRHcF4rwqYB9QK+dcg36xhtG+9jIbjvbG4n7LRueRCNVZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791032214; c=relaxed/simple;
	bh=zLjYHpDjGPkmq2hNarOWUNpXRJtgP9iqpk8q1N4pg4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrZCuvosrXxbWnrP7ELSzM0mo8ILDOdrcBSctjJxbciaZcjuPI9On0OooFx1Q759368lqWxS8SZRXw0mg8UXDCSZnmcgqNoDzySRij9Qx0dx4aLRII/rqryNurgi5Al2s4DR7ydSv0MTqgrRt49KNdcyVjCnV5J2XzG7C/ozrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=X7Fp5zwW; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="X7Fp5zwW"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791032204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VuOimPrsV8wsFxxYojq2E2r3fz9HZPoE/XuZbePoExI=;
	b=X7Fp5zwWyHTbrjfL+EiErcRJ8alreT1eX2NJl9IDlnwgCsPtLg6QS3pZpTraFlkID0npqJ
	P/flLxkgZJVXp1BdBB7KofnvFJlWyLcdgJP1B6CiJHdzI87yjD4YOhXuh2ILbNP/ZWFIWd
	u2rmB8VkClG8SeKHFDe+wvXy4UWkn04=
To: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>,
	stable@vger.kernel.org
Subject: [PATCH 0/3] sparc64: stale TLB/TSB entries can livelock a thread
Date: Sat,  3 Oct 2026 14:56:22 +0200
Message-ID: <20261003125627.3419702-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a SPARC T7-1 (M7, 256 strands) running up to 256 compiler processes
in parallel, a thread now and then stops dead: runnable, fixed PC,
system time climbing, no kernel messages.  One was caught retrying the
same store for 25 minutes.

Two causes:

 - flush_tlb_fix_spurious_fault() is a no-op on sparc64 (it falls back
   to flush_tlb_page(), which is empty here), so a write that faults on
   a stale read-only TLB entry faults again forever.  Same for the PMD
   hook.

 - tsb_grow() publishes the new TSB before the other CPUs have switched
   to it, and all flushes go to the new one.  Stale entries survive in
   the old TSB and are reloaded into the TLB: read-only ones feed the
   loop above, writable ones for unmapped pages point at freed memory.

A probe in the fault path on the T7-1 showed 128 of 868 spurious faults
during one toolchain build and test run on a CPU still using an old TSB
that held the read-only entry, 31 of them repeating on the same thread
and page.  A SPARC T4-1 (64 strands) shows the same: 143 of 2780.  With
the series the T7-1 run shows 757 spurious faults, none on an old TSB
and no repeats, and the build's system time is back from 29 min to 7.

Patch 1 avoids a double flush once the hook does real work, patch 2
defines the PTE and PMD hooks, patch 3 keeps the old TSB flushable
until smp_tsb_sync() has returned.

Tested on a T7-1 (sun4v): five consecutive full Go test suite runs
(make.bash + dist test), once with THP off and once with THP enabled,
no stalls; a T4-1 runs it as its daily kernel.
On sun4u (V240, UltraSPARC IIIi) it boots and survives TSB-grow,
copy-on-write, hugetlb and fork stress with no stale reads.
Build-tested with CONFIG_SMP=n and without THP/hugetlb.

Tracking issue with the probe patch and the logs:
https://github.com/sparclinux/issues/issues/108

Stian Halseth (3):
  sparc64: provide ptep_set_access_flags()
  sparc64: flush the TLB on a spurious write fault
  sparc64: keep flushing the old TSB while tsb_grow() switches CPUs

 arch/sparc/include/asm/mmu_64.h      |   5 ++
 arch/sparc/include/asm/pgtable_64.h  |   3 +
 arch/sparc/include/asm/tlbflush_64.h |  10 ++++
 arch/sparc/mm/tlb.c                  |  35 ++++++++++++++
 arch/sparc/mm/tsb.c                  |  80 ++++++++++++++++++++++++++++++-
 5 files changed, 127 insertions(+), 6 deletions(-)
