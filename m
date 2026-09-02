Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE91493632
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355005; cv=none; b=rqWx4zs7fVEkk9euRToI0tAnl+wjeYs+ZXnxDnSMA7S4hISW+0vQA9eVbIjWmk1cSHx1gvfxy+5lpJRc4vvEpYA/h5X+tsFy9VOzD2CYgK/2l5EeV+B0+oTW86+WnuSbFrgJLE/5pLZz61PCuX5xfUI76zhQrm9Lrqx+PTSEvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355005; c=relaxed/simple;
	bh=PIeNSn6dbPUSzotuL6dJrll2mRcEyuhJ+Z+5qYBburs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLYAnIKaI7wALpnVbbhxctldbs1CBacQliaWYhF7N8y91gUzvdAw6DWPgsIp9Bf3LvmrQ+ByDp3gBH9v9hXMbLuAmUj2qfoDTQA2hHOTNtFBSc335/wApIpyOdxdNRleZLGphs8Wlcg4tJ7wZkpdfLh4hvl1PtfoKmfC/MV8ueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9SE43wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9SE43wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E31C1F000E9;
	Wed,  2 Sep 2026 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355004;
	bh=WHyZ/G63rvwAjwU4vztYef/xCH4xZmisnZYFznJHchw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C9SE43wk6wEfvY7rbwjJlIDhxPYF4V8mY5JBn8DHaeqItWWDBLmp5vfg6hVeFPmJt
	 0rarlD9cqaUHCpo2jYgIre0ly39rkiyJVv04hOyUlEV8OzUqniAlwi5s03flzFPLeK
	 lcojVVMmP5puGAJCTODq+wkeRSozRKVFNTVtVc2tj0gEMWlQaHFixWF8jtbXPZAYij
	 EsMvyzQiykJq5mP7pf+Prr9jhVQsFoafmFQsKMd95VtikdmAY2TBAKa7M4p3XbJRzC
	 dKoGPdG4g1bRVpAngjdCXe4UZJMLIgdG5GL3qiJZZOyOvPJbYqs7HPKMg2n2dgMfYe
	 ePcvcMLfslAew==
Date: Wed, 2 Sep 2026 14:16:37 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Anjum <usama.anjum@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, vladimir.murzin@arm.com, ryan.roberts@arm.com, 
	peterz@infradead.org, catalin.marinas@arm.com, david.laight.linux@gmail.com, 
	stable@vger.kernel.org, ruanjinjie@huawei.com, james.morse@arm.com, 
	yang@os.amperecomputing.com, cl@gentwo.org, maz@kernel.org, david@kernel.org, will@kernel.org, 
	ardb@kernel.org
Subject: Re: [PATCH v2 00/20] arm64: Preemptible this_cpu_*() operations
Message-ID: <apgg8HuPzL9R2urz@gremlin>
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
> tl;dr
> Comparing this series with the page-table series [a] gives 8 improvements and 3
> regressions.

And the regressions are very small and importantly the improvements that
presumably form the basis of doing any of this at all (i.e. munmap, vmalloc)
perform _better_ with Mark's series, without requiring egregious core mm
changes + complexity.

>
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

Lovely :)

Well that settles the debate then!

--
Cheers, Lorenzo
