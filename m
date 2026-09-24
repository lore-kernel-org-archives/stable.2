Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3C3890E5
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266587; cv=none; b=ETeHmS2bCKCwQL0YdLPT3bJ3Vp6di0rEn4tjLHme9t7UpnUi9V/jh5AuCbwggoAKjf8GRoOqRzsyJbPUqxU8Ol+bGVNmM8S5P88FRbg9/aswh2+56zsl8Urf4PqA/ruZOciha0MTdctGo67EScG9BEtDrVlx0BgQD64wrq8TFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266587; c=relaxed/simple;
	bh=bOOJWOAbO0gDFgO8PblWIzaHwfRvGBO666n+MZ1kxXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1D37ptzGbMZwCANWaMaQuRwx702+cZ/kAqh6YfuonpUDJNA6HBcS01K9vtZCnmfPz5ItgzWxjQ8yfdP8vC6LujrUY/ucRl6RQJpTJ1eiCbCmgrwVJ4998LcoRvZ/QG5LXQujae1+Ge4xEH+aqcCj4Ly6pImv12XNVSHTaJuc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=birMX9T0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="birMX9T0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0283F152B;
	Thu, 24 Sep 2026 09:16:21 -0700 (PDT)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C385E3F86C;
	Thu, 24 Sep 2026 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790266584; bh=bOOJWOAbO0gDFgO8PblWIzaHwfRvGBO666n+MZ1kxXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=birMX9T01zpqA2jbnY8FhUCkU9qM54dzIQ5nOu1JUfPf7sPg9PAnTc8aGcG9Apzpx
	 9VNCZQ2WJpIj0PRu2acMxaGiFxDyINA+I1RLhfyWxId/tRrBGl/sMTvQ/DD8h9n6Jr
	 wo2n81Z7wOvRxXnwda1gw7lRQ2iOJYDzstY3Bd6k=
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>,
	ada.coupriediaz@arm.com,
	ardb@kernel.org,
	cl@gentwo.org,
	david@kernel.org,
	david.laight.linux@gmail.com,
	james.morse@arm.com,
	ljs@kernel.org,
	maz@kernel.org,
	peterz@infradead.org,
	ruanjinjie@huawei.com,
	ryan.roberts@arm.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com,
	vladimir.murzin@arm.com,
	yang@os.amperecomputing.com
Subject: Re: (subset) [PATCH v4 00/21] Preemptible this_cpu_*() operations
Date: Thu, 24 Sep 2026 17:03:49 +0100
Message-ID: <179026582920.3572476.8424936957104740430.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908151741.394589-1-mark.rutland@arm.com>
References: <20260908151741.394589-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 16:17:20 +0100, Mark Rutland wrote:
> This series reworks arm64's this_cpu_*() operations such that they do
> not need to disable preemption. The scheme is described in detail in patch 13,
> and is similar to the approach Heiko Carstens applied to s390 [1], which
> inspired this series.
> 
> This scheme should build and function in all kernel configurations (e.g.
> regardless of KPTI, SW PAN, CNP, VA BITS), and has no dependency on new
> architectural features. The fixup logic should "just work" with kprobes,
> etc, and I don't expect that this will need to become more complicated.
> 
> [...]

Applied to arm64 (for-next/preemptible-this-cpu), thanks!

Patches 1-3 are already upstream as fixes (in -rc4, used as a base for
for-next/core). I fixed some minor comment typos in a couple of patches,
I haven't touched the code.

On v2, Usama reported performance regression in perf/sched and
perf/futex benchmarks that have not been addressed yet. It would be good
to run the tests again on this version, in case they were just noise. I
don't see why these would regress, maybe because of pt_regs being larger
and we get some more cache misses?

[04/21] arm64: cmpxchg: LL/SC: Avoid redundant extension
        https://git.kernel.org/arm64/c/78746ba584fc
[05/21] arm64: cmpxchg128: LSE: Remove redundant operands
        https://git.kernel.org/arm64/c/de2824489899
[06/21] arm64: preempt: Simplify and optimize __preempt_count_dec_and_test()
        https://git.kernel.org/arm64/c/1bee18253c2e
[07/21] arm64: preempt: Treat should_resched() as unlikely
        https://git.kernel.org/arm64/c/6254b223153d
[08/21] arm64: ptrace: Always inline pt_regs_[read,write}_reg()
        (no commit info)
[09/21] arm64: percpu: Factor out percpu offset asm
        https://git.kernel.org/arm64/c/b7f3aa93f407
[10/21] arm64: gpr-num: Add wxN aliases for wN registers
        https://git.kernel.org/arm64/c/47c62b09f03b
[11/21] arm64: gpr-num: add __GPR_NUM() helper
        https://git.kernel.org/arm64/c/05c44981d9ec
[12/21] arm64: entry: sdei: Restore all clobberable GPRs
        https://git.kernel.org/arm64/c/1e0a5cc90aab
[13/21] arm64: entry: sdei: Make 'tsk' available
        https://git.kernel.org/arm64/c/fb532fdb4430
[14/21] arm64: percpu: Add infrastructure for preemptible this_cpu_*() ops
        https://git.kernel.org/arm64/c/95d2c5f6663b
[15/21] arm64: percpu: Implement preemptible read/write ops
        https://git.kernel.org/arm64/c/6e2cec1c39b2
[16/21] arm64: percpu: Implement preemptible void RMW ops
        https://git.kernel.org/arm64/c/c7ac8f9baaef
[17/21] arm64: percpu: Implement preemptible return RMW ops
        https://git.kernel.org/arm64/c/6fe3da372d04
[18/21] arm64: percpu: Implement preemptible XCHG ops
        https://git.kernel.org/arm64/c/5e8ef5fb7720
[19/21] arm64: percpu: Implement preemptible CMPXCHG ops
        https://git.kernel.org/arm64/c/39d50a10e318
[20/21] arm64: percpu: Implement preemptible CMPXCHG128 ops
        https://git.kernel.org/arm64/c/c0ff52c3683c
[21/21] arm64: percpu: Remove _pcp_protect*() wrappers
        https://git.kernel.org/arm64/c/479671f943c9
