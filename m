Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30A1F938;
	Thu, 15 Oct 2026 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051115; cv=none; b=kIUKj6XCjiY931iPjF/Xn59NsFxBFNmvw9EVCZrs5u7oXadVmyiqqQObcRuMnkHMtJQ1FDqAiFROOgzmYRYWHp9EbE1mS1pHQUCCmKFJ5NZUQb6+va3kBIIyGcqhI8q0nXoAb74aURNH+8fs4jniqUtkCF3vokqXVOEn/H0u4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051115; c=relaxed/simple;
	bh=+FihA+wh135Mh2QhaSZ7a9xrEpWCFEqF2iSOSQKyRVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0/na0OQN8UZl2bZ1F+YqixnCVWyKL/f4wGw7ps8UyM41ke2R1da3zFAL+ze847ibvpFZu4mymlCdJW6cNbiqct7LcoPT4+M9jxVVvKWctdC9QcjzFfe9irYw17x25FPmhzkcu/2yABDlosCEwNCtk6ppNJhlWRAhNjYxtQkKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=plOm3eYz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="plOm3eYz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MuYxvdkpIR0KZVLJnlzEAlHcY1DAFQwL7TPwoqX0imc=; b=plOm3eYzfpQf+gcMrQmQumLKRe
	eocpFjC2eX62dRMenfFtdWKOflcecV7HwMtCngSiof5GWj5913fVpj1SyS4eGCyO+iwT9AUpaR4CL
	MlCmW1MH8PBy/32LxYw2M1+eatrA+x/Vy1h3qlV0t7C0rFQ4xLE3q+TH6sBlOOZl9Gkggz5uIwJpp
	xMYEv+Pc82DrJHW5EGXADS2P6Bg0ljYTLSvnOU18Ap+Qme5NGy37wy5NFHQIpUIdRlI9ltjoRN+2d
	oHEs4O9oYMsBdmhi7wWsjdPKoytC/xIr9MKoOtETTb8Mhh47jNVEhUlEx2vNme7h/ElPY8Wykh9RZ
	ZXxnJNqA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHGLy-0000000Bwf6-1pFu;
	Thu, 15 Oct 2026 07:58:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 03E37302F8E; Thu, 15 Oct 2026 09:58:18 +0200 (CEST)
Date: Thu, 15 Oct 2026 09:58:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, regressions@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	Alexander Motin <alexander.motin@truenas.com>,
	Ameer Hamza <ameer.hamza@truenas.com>,
	"Caleb St. John" <caleb.stjohn@truenas.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: track the perf mlock gift separately
Message-ID: <20261015075817.GO2009045@noisy.programming.kicks-ass.net>
References: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>

On Sat, Oct 03, 2026 at 05:29:07PM +0100, Lorenzo Stoakes (ARM) wrote:
> The locked_vm field in struct user_struct was originally introduced by
> commit 789f90fcf6b0 ("perf_counter: per user mlock gift") to provide an
> mlock-like budget for perf measured against mm->pinned_vm (since 2011).
> 
> perf grants each user a 'gift' of perf_event_mlock_kb * online CPUs of
> buffer pages which is charged to user->locked_vm without any RLIMIT_MEMLOCK
> check.
> 
> Only pages beyond the gift are checked against RLIMIT_MEMLOCK, per-mm, via
> mm->pinned_vm, which makes it different from the standard mlock() check,
> which is per-mm and made against RLIMIT_MEMLOCK.
> 
> However, since this was introduced, a number of other components have
> utilised this field where a shared resource needed to be limited against
> RLIMIT_MEMLOCK.
> 
> The other users are currently MSG_ZEROCOPY, io_uring, AF_XDP, iommufd,
> s390 KVM zPCI and most recently, secretmem in commit 97d34aa65c29
> ("mm/secretmem: properly account locked pages").
> 
> This field is shared between all of these, but because the gift is not
> checked against RLIMIT_MEMLOCK, user->locked_vm alone can exceed it - 16
> CPUs * 516 KiB is already more than the default 8 MiB - after which every
> other user of the field fails unconditionally.
> 
> This was reported by a user who saw secretmem failing while running a
> simultaneous perf record.
> 
> Resolve the issue by simply giving perf its own field separate from the
> rest.

So I'm a little confused by all this -- perf introduced this field,
others jumped on and shit broke, so we fix perf instead of the others?

> BPF used user->locked_vm up until commit 80ee81e0403c ("bpf: Eliminate
> rlimit-based memory accounting infra for bpf maps") which landed in 5.11.
> 
> Thus also eliminate the now-defunct ifdef for CONFIG_BPF_SYSCALL for
> user->locked_vm.
> 
> This issue exists between all of the components which use user->locked_vm
> and perf, however secretmem is the first user who has caused a report over
> many years and has been backported, so target the fix at that.
> 
> Fixes: 97d34aa65c29 ("mm/secretmem: properly account locked pages")
> Reported-by: Ameer Hamza <ameer.hamza@truenas.com>
> Closes: https://lore.kernel.org/20261002175651.811343-1-ameer.hamza@truenas.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Anyway, patch seems straight forward enough; and you added comment to
the fields, which I suppose does clarify things some.

I'll take it. Thanks!
