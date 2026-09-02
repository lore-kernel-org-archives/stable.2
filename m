Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA323A7587
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350125; cv=none; b=q2As2Rs0To6tqDoVOVEUTZYjlzbqUKil/7+vLe5OLvuKOsXHFDMi1KkV7MZJGJ6WiUX0PuTFV6rZjupO2cxTC8aGVRtxOZCWTfzz71fwA0zWf/qf7mfZYxZh9taTWMxH1HdC3CZYSdN6ILIB/5LQRislwR1nWAFs1IyVjNnir4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350125; c=relaxed/simple;
	bh=G2NVwnC/VCZnRdRYBAgE76g2IS9xpMkKiu/eLnsYt7s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cBIlsI597TlSmMrQCtVgvrROUq0x2qbSyvfx1KYpO/CGttO5lg2VI/Lb5JMfTHkwmF7vN8KOdpILfGJJgXlzqeW5ANtINJfQQoiY6eR85gFGvjTjDnfSAjmhIuVlL97x8E4T1eo8/V7Okur+cQjUK4X19rX9rgvxVETjZzXInjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SWdMNwf2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SWdMNwf2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AF7F1596;
	Wed,  2 Sep 2026 04:55:13 -0700 (PDT)
Received: from [10.2.198.93] (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 690703F85F;
	Wed,  2 Sep 2026 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350116; bh=G2NVwnC/VCZnRdRYBAgE76g2IS9xpMkKiu/eLnsYt7s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SWdMNwf2slAOSI6A7eXocHUXy4Y1nt2gknjV8WpwOYadJlkYo0kY0gV3Nqk9mxinq
	 TH5kXWD5O5Il5Rt3hCn/V/2Od15zxNanvuQCVJL0eg3dMVKRUrAO7dJGXWJTDRmKtv
	 48xpfAhQJapyLyfKvTFHgJOpHvp5c/A10Vs+012Q=
Message-ID: <9789fd67-205a-412f-90d6-42c401d3babe@arm.com>
Date: Wed, 2 Sep 2026 12:55:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, vladimir.murzin@arm.com, ryan.roberts@arm.com,
 peterz@infradead.org, catalin.marinas@arm.com, david.laight.linux@gmail.com,
 stable@vger.kernel.org, ruanjinjie@huawei.com, james.morse@arm.com,
 yang@os.amperecomputing.com, cl@gentwo.org, maz@kernel.org,
 david@kernel.org, ljs@kernel.org, will@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v2 00/20] arm64: Preemptible this_cpu_*() operations
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20260804170503.3513916-1-mark.rutland@arm.com>
Content-Language: en-US
From: Usama Anjum <usama.anjum@arm.com>
In-Reply-To: <20260804170503.3513916-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/08/2026 6:04 pm, Mark Rutland wrote:
> This series reworks arm64's this_cpu_*() operations such that they do
> not need to disable preemption, avoiding related overhead in the fast
> paths. Instead, the ops begin/end a "PCPU GPR" critical section using
> unconditional/posted stores, which should be very cheap on any
> reasonable micro-architecture. During a critical section, should a
> (preemptible) exception be taken, the entry code will apply a fixup to
> the GPRs containing the percpu offset and the generated percpu address.
> 
> The scheme is described in detail in patch 13, and is similar to the
> approach Heiko Carstens applied to s390 [1], which inspired this series.
> 
> Please note that the fixup IS NOT a restart. The GPR fixup in the
> exception entry code DOES NOT alter the PC, and there are no necessary
> branches within the PCPU GPR critical sections.
> 
> This scheme should build and function in all kernel configurations (e.g.
> regardless of KPTI, SW PAN, CNP, VA BITS), and has no dependency on new
> architectural features. The fixup logic should "just work" with kprobes,
> etc, and I don't expect that this will need to become more complicated.
> 
> The patches are organised as follows:
> 
> * Patches 1 to 2 are preparatory fixes for latent issues which were
>   found by inspection. These will need to be backported to stable, and
>   have appropriate Fixes tags.
> 
> * Patches 3 to 6 are preparatory improvements to code generation issues
>   found by inspection during development. These aren't strictly related
>   to the PCPU GPR scheme, and it would make sense to queue these even if
>   we don't go ahead with the rest of the series.
> 
> * Patches 7 to 12 are preparatory work for the PCPU GPR scheme.
> 
> * Patch 13 implements the core of the PCPU GPR scheme, with all the
>   necessary exception handling logic, and the addition of helpers to
>   begin/end a PCPU GPR critical section.
> 
> * Patches 14 to 19 convert this_cpu_*() operations over to the PCPU GPR
>   scheme. These changes have been made over several patches to aid
>   review and bisection (if necessary).
> 
> * Patch 20 removes code made redundant by earlier patches.
> 
> I've given this build-testing (with GCC and clang) and some light boot
> testing, but this hasn't seen significant functional testing or
> benchmarking. From inspection of the generated code I expect this to
> have reasonable positive impact to performance where this_cpu*() ops are
> used heavily. I would be grateful if anyone could take this for a spin.



tl;dr
Comparing this series with the page-table series [a] gives 8 improvements and 3
regressions.

Fastpath is a Linux kernel performance benchmarking service. The table
compares the both patched kernels: positive values are faster, negative
values are slower, and (I)/(R) indicate statistically significant
improvements/regressions. Unmarked differences are not significant after
accounting for confidence and noise thresholds.

+---------------------------------+--------------------+-----------------+-----------------------+
| Benchmark                       | percpu-pgtable [2] |   gpr-fixup [3] |         gpr-fixup [3] |
|                                 |    vs baseline [1] | vs baseline [1] | vs percpu-pgtable [2] |
+=================================+====================+=================+=======================+
| lmbench/lat-mem-rd              |             -0.26% |       (I) 1.24% |             (I) 1.50% |
| micromm/fork                    |          (I) 1.10% |       (I) 2.46% |             (I) 1.35% |
| micromm/munmap                  |         (I) 18.10% |      (I) 19.78% |             (I) 1.43% |
| micromm/vmalloc                 |         (I) 11.92% |      (I) 14.68% |             (I) 2.47% |
| mmtests/hackbench               |              0.27% |       (I) 1.09% |                 0.81% |
| mmtests/kernbench               |          (I) 1.19% |       (I) 1.18% |                -0.01% |
| mmtests/sysbench-cpu            |              0.01% |           0.06% |                 0.05% |
| mmtests/sysbench-mutex          |             -0.85% |          -0.14% |                 0.72% |
| mmtests/sysbench-thread         |         (R) -4.49% |       (I) 3.02% |             (I) 7.86% |
| perf/futex                      |              0.55% |      (R) -2.80% |            (R) -3.34% |
| perf/sched                      |          (I) 1.61% |          -0.39% |            (R) -1.97% |
| perf/syscall                    |          (I) 1.54% |           0.98% |                -0.55% |
| pts/memtier-benchmark           |          (I) 2.37% |       (I) 2.51% |                 0.14% |
| pts/nginx                       |              0.42% |           0.96% |                 0.54% |
| pts/perl-benchmark              |          (I) 1.83% |       (I) 1.63% |                -0.20% |
| pts/pgbench                     |             -0.09% |           0.55% |                 0.65% |
| pts/pybench                     |             -0.05% |          -0.07% |                -0.02% |
| pts/redis                       |             -0.00% |          -0.04% |                -0.04% |
| pts/sqlite-speedtest            |              0.15% |           0.44% |                 0.28% |
| repro-collection/mysql-workload |              0.73% |           0.25% |                -0.48% |
| schbench/thread-contention      |              0.42% |       (I) 1.04% |                 0.61% |
| sockperf/echo-lat-tcp           |          (I) 2.88% |       (I) 1.69% |            (R) -1.16% |
| sockperf/echo-lat-udp           |          (I) 3.93% |       (I) 5.11% |             (I) 1.14% |
| sockperf/packet-tp-tcp          |             -0.41% |       (I) 1.37% |             (I) 1.79% |
| sockperf/packet-tp-udp          |          (I) 1.45% |       (I) 1.49% |                 0.04% |
| specjbb/composite               |          (I) 1.39% |       (I) 1.65% |                 0.26% |
| speedometer/v2.0                |         (R) -1.04% |      (R) -1.04% |                 0.00% |
| speedometer/v2.1                |             -0.10% |           0.10% |                 0.20% |
| syscall/getpid                  |             -0.98% |           0.52% |             (I) 1.51% |
| syscall/getppid                 |             -0.43% |           0.14% |                 0.57% |
| syscall/invalid                 |          (I) 3.06% |       (I) 3.56% |                 0.48% |
+---------------------------------+--------------------+-----------------+-----------------------+

[1] v7.2
[2] v7.2-percpu-pgtable [a]
[3] v7.2-percpu-gpr (This series) (Based on email review, we fixed SDEI to restore x26
    instead of corrupting x22, and adjusted this_cpu_write() helpers to
    avoid GCC overflow warnings.)

The constraints/workarounds for the per-CPU page-table series were supplied as
this Kconfig fragment for all the different runs.

CONFIG_EXPERT=y
CONFIG_SMP=y
CONFIG_ARM64_4K_PAGES=y
CONFIG_ARM64_VA_BITS_48=y
CONFIG_ARM64_VA_BITS_39=n
CONFIG_ARM64_VA_BITS_52=n
CONFIG_ARM64_PA_BITS_48=y
CONFIG_ARM64_PA_BITS_52=n
CONFIG_UNMAP_KERNEL_AT_EL0=n
CONFIG_ARM64_SW_TTBR0_PAN=n
CONFIG_KASAN=n

[a] https://lore.kernel.org/all/20260715180455.515692-1-yang@os.amperecomputing.com/

Hence:
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Regards,
Usama
