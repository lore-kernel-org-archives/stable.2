Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15BE3403E9
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355966; cv=none; b=I6K32kOuPwEfQ5sHesW+/q3FSjU2V1GlRYj8ztuOQRd5t9jQZHpqNEvr7aPsEHguRuy0+Y8Hk4DtmiSwZPzxumpdfpZLu+D92HKngccAOXFQRgWycjNw5Yl1kvtEKHzg+2MBOG5Ac+fvYY7O5Zfm1vqoYeWXztn/ytIkBNqt3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355966; c=relaxed/simple;
	bh=vMyC5+PEVcy327m6EPaRBNAl7GuUZ1WfTVhXzgGvaPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKSGbwvvhyjdakHJ4xKttVI4KFf2MrkdWLdLO/zNvH/o1Q7zCUX7bhKtzuQn7yz9TPNpMvJEwmRFtIFA58pG/xzgo9AbW1LulYMLIpU0Vy1+Bh0hjutPpVszJlKdb0lOeX8pM5r+PkNxjArpoC5hre2+UtG8O25KTSuuS3/FRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SGh6bztQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SGh6bztQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AA7A165C;
	Wed,  2 Sep 2026 06:32:40 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 194023F673;
	Wed,  2 Sep 2026 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788355964; bh=vMyC5+PEVcy327m6EPaRBNAl7GuUZ1WfTVhXzgGvaPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGh6bztQl85YttGpNjtY8XkojwGDHt0vkHojjy20HentO6GLedPdeHTFsdqv4wyCb
	 h8keHWxU7ReaaE90FmKKbTc9cu8pcErydfd8vVF+6zUlv9NF0Wc11BnJKwj4FDAxaf
	 U4dNHN3gKcfRt+oDfLOZL8JY3OxsQUy3+Ocu9gdM=
Date: Wed, 2 Sep 2026 14:32:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Usama Anjum <usama.anjum@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, vladimir.murzin@arm.com,
	ryan.roberts@arm.com, peterz@infradead.org, catalin.marinas@arm.com,
	david.laight.linux@gmail.com, stable@vger.kernel.org,
	ruanjinjie@huawei.com, james.morse@arm.com,
	yang@os.amperecomputing.com, cl@gentwo.org, maz@kernel.org,
	david@kernel.org, ljs@kernel.org, will@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v2 00/20] arm64: Preemptible this_cpu_*() operations
Message-ID: <apgldIKysSQWuMT0@J2N7QTR9R3.cambridge.arm.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <9789fd67-205a-412f-90d6-42c401d3babe@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9789fd67-205a-412f-90d6-42c401d3babe@arm.com>

On Wed, Sep 02, 2026 at 12:55:12PM +0100, Usama Anjum wrote:
> On 04/08/2026 6:04 pm, Mark Rutland wrote:
> > This series reworks arm64's this_cpu_*() operations such that they do
> > not need to disable preemption, avoiding related overhead in the fast
> > paths.

> > I've given this build-testing (with GCC and clang) and some light boot
> > testing, but this hasn't seen significant functional testing or
> > benchmarking. From inspection of the generated code I expect this to
> > have reasonable positive impact to performance where this_cpu*() ops are
> > used heavily. I would be grateful if anyone could take this for a spin.
> 
> tl;dr
> Comparing this series with the page-table series [a] gives 8 improvements and 3
> regressions.

Amazing! Thanks a lot for testing this!

> Fastpath is a Linux kernel performance benchmarking service. The table
> compares the both patched kernels: positive values are faster, negative
> values are slower, and (I)/(R) indicate statistically significant
> improvements/regressions. Unmarked differences are not significant after
> accounting for confidence and noise thresholds.
> 
> +---------------------------------+--------------------+-----------------+-----------------------+
> | Benchmark                       | percpu-pgtable [2] |   gpr-fixup [3] |         gpr-fixup [3] |
> |                                 |    vs baseline [1] | vs baseline [1] | vs percpu-pgtable [2] |
> +=================================+====================+=================+=======================+
> | lmbench/lat-mem-rd              |             -0.26% |       (I) 1.24% |             (I) 1.50% |
> | micromm/fork                    |          (I) 1.10% |       (I) 2.46% |             (I) 1.35% |
> | micromm/munmap                  |         (I) 18.10% |      (I) 19.78% |             (I) 1.43% |
> | micromm/vmalloc                 |         (I) 11.92% |      (I) 14.68% |             (I) 2.47% |
> | mmtests/hackbench               |              0.27% |       (I) 1.09% |                 0.81% |
> | mmtests/kernbench               |          (I) 1.19% |       (I) 1.18% |                -0.01% |
> | mmtests/sysbench-cpu            |              0.01% |           0.06% |                 0.05% |
> | mmtests/sysbench-mutex          |             -0.85% |          -0.14% |                 0.72% |
> | mmtests/sysbench-thread         |         (R) -4.49% |       (I) 3.02% |             (I) 7.86% |
> | perf/futex                      |              0.55% |      (R) -2.80% |            (R) -3.34% |
> | perf/sched                      |          (I) 1.61% |          -0.39% |            (R) -1.97% |
> | perf/syscall                    |          (I) 1.54% |           0.98% |                -0.55% |
> | pts/memtier-benchmark           |          (I) 2.37% |       (I) 2.51% |                 0.14% |
> | pts/nginx                       |              0.42% |           0.96% |                 0.54% |
> | pts/perl-benchmark              |          (I) 1.83% |       (I) 1.63% |                -0.20% |
> | pts/pgbench                     |             -0.09% |           0.55% |                 0.65% |
> | pts/pybench                     |             -0.05% |          -0.07% |                -0.02% |
> | pts/redis                       |             -0.00% |          -0.04% |                -0.04% |
> | pts/sqlite-speedtest            |              0.15% |           0.44% |                 0.28% |
> | repro-collection/mysql-workload |              0.73% |           0.25% |                -0.48% |
> | schbench/thread-contention      |              0.42% |       (I) 1.04% |                 0.61% |
> | sockperf/echo-lat-tcp           |          (I) 2.88% |       (I) 1.69% |            (R) -1.16% |
> | sockperf/echo-lat-udp           |          (I) 3.93% |       (I) 5.11% |             (I) 1.14% |
> | sockperf/packet-tp-tcp          |             -0.41% |       (I) 1.37% |             (I) 1.79% |
> | sockperf/packet-tp-udp          |          (I) 1.45% |       (I) 1.49% |                 0.04% |
> | specjbb/composite               |          (I) 1.39% |       (I) 1.65% |                 0.26% |
> | speedometer/v2.0                |         (R) -1.04% |      (R) -1.04% |                 0.00% |
> | speedometer/v2.1                |             -0.10% |           0.10% |                 0.20% |
> | syscall/getpid                  |             -0.98% |           0.52% |             (I) 1.51% |
> | syscall/getppid                 |             -0.43% |           0.14% |                 0.57% |
> | syscall/invalid                 |          (I) 3.06% |       (I) 3.56% |                 0.48% |
> +---------------------------------+--------------------+-----------------+-----------------------+
> 
> [1] v7.2
> [2] v7.2-percpu-pgtable [a]
> [3] v7.2-percpu-gpr (This series) (Based on email review, we fixed SDEI to restore x26
>     instead of corrupting x22, and adjusted this_cpu_write() helpers to
>     avoid GCC overflow warnings.)

I've folded those changes in for v3, along with a new fix for {8,16}-bit
operations that we don't seem to exercise today.

> The constraints/workarounds for the per-CPU page-table series were supplied as
> this Kconfig fragment for all the different runs.
> 
> CONFIG_EXPERT=y
> CONFIG_SMP=y
> CONFIG_ARM64_4K_PAGES=y
> CONFIG_ARM64_VA_BITS_48=y
> CONFIG_ARM64_VA_BITS_39=n
> CONFIG_ARM64_VA_BITS_52=n
> CONFIG_ARM64_PA_BITS_48=y
> CONFIG_ARM64_PA_BITS_52=n
> CONFIG_UNMAP_KERNEL_AT_EL0=n
> CONFIG_ARM64_SW_TTBR0_PAN=n
> CONFIG_KASAN=n
> 
> [a] https://lore.kernel.org/all/20260715180455.515692-1-yang@os.amperecomputing.com/
> 
> Hence:
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Thanks; I've folded in your Tested-by for v3 (excluding the new fix).

I'll go run some build tests and send that out.

Mark.
