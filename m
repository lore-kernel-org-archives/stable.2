Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9D44C50B;
	Sat,  3 Oct 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043007; cv=none; b=BEvfMb25Yd2lUe5FKhXDbisSKC+bZppH42bJtGxhkqMYlkRc3Q9nakr/RAwf0W3nQKLcg2xzYrKWuqMRo/g0aPfrtm/KZcJSrRk0vmLmMUoNO0hmLbuldedHouwaWEYQ843XQEknj/2CirxINtFDD8PCeAAfg0bd0rKtmopgpJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043007; c=relaxed/simple;
	bh=QBmPqkM+BWPZEGUf8wgfH/hL9uC8UI8aHcoqXD3eDno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n38QrLjr9btOmaW3v5QoZKeacA9g9Pr6rgfYY56SCQMl03I/wPtqQM7ak+ztheH6BW7URGG+cgpzIw3he3bP+xeHQr8/P6GBxniOggD4iy0e82Sb32j70YGFB5FMWo5JkGtBZIBC1Ggxnlk7MlqDrbHBZZ1MN08LCUd2CJY0ul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPGAYEhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPGAYEhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679141F0089D;
	Sat,  3 Oct 2026 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791042998;
	bh=NzhxsV7jtoLr70i/Q5PxTj0BUfUeVGbJ6ybWMLKfAzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UPGAYEhXKD563KxiLn5ax0iwVPtf7O8U/4Rrb7nteA/xQiyDEM7ymdL3mWaQ4HF4v
	 qOfW01Y+a4iSnEmajSp0nHa77ZjyUH8XNKCKdf2dw9hYFa2HTBOg61IDwMtyTWcARE
	 Ep54D2ZuvN89OY7aCj2sH9wCDrdnhPBt2YZOqyq1CxkozpJEX2GC0tKNR5oUrSabhV
	 Z08QwcxH0Jzk5Yg5lBF40TagpG5a0CDp7iyXTaF7Y+5zYsaDi12VW17ywuDgGaKufs
	 WrJTYFodEGflFSOWoLnRFCY3cLC0pAzd9dkj9XWX2KMtimdQ0RDHV1njziP5LvrXDo
	 1xkenDJLThOTA==
Date: Sat, 3 Oct 2026 16:56:32 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ameer Hamza <ameer.hamza@truenas.com>
Cc: rppt@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
	david@kernel.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 4ncienth@gmail.com, sashal@kernel.org, 
	alexander.motin@truenas.com, caleb.stjohn@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while
 perf record runs
Message-ID: <asEllR7if-J3wteg@gremlin>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002175651.811343-1-ameer.hamza@truenas.com>

On Fri, Oct 02, 2026 at 10:56:51PM +0500, Ameer Hamza wrote:
> Hi,
>
> Since commit 97d34aa65c29 ("mm/secretmem: properly account locked
> pages"), in v7.3-rc2 and the 6.18.52 and 7.2.5 backports, touching a
> memfd_secret() page for the first time fails with SIGBUS while the
> same user is running perf record, and read() into such a page fails
> with EFAULT. This happens for root as well as for an unprivileged
> user running its own perf record. It reproduces on v7.3-rc4 and
> 6.18.52, and the same test passes without the recording or with the
> commit reverted.
>
> The commit charges secretmem pages to the per-user user->locked_vm
> and checks that counter against RLIMIT_MEMLOCK, with no CAP_IPC_LOCK
> exemption because the fd can be passed to other processes. perf has
> charged its ring buffers to the same counter since 2009, up to
> perf_event_mlock_kb per online CPU, and only what exceeds that
> allowance is checked against RLIMIT_MEMLOCK. sysctl/kernel.rst
> describes the allowance as not counted against the mlock limit, yet
> it sits in the counter that secretmem now enforces. perf record sizes
> its buffers to the allowance by default, 516 KiB per CPU, so on 16 or
> more CPUs one recording uses up the default 8 MiB limit on its own,
> and on fewer CPUs it leaves correspondingly less for secretmem.
>
> Reproducer, as root on a 16 vCPU x86_64 guest with the default
> ulimit -l 8192, while "perf record -o /tmp/p.data -- sleep 300" runs
> in another shell:
>
>   fd = syscall(SYS_memfd_secret, 0);
>   ftruncate(fd, 4096);
>   p = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>   read(open("/dev/zero", O_RDONLY), p, 4096);   /* EFAULT */
>   p[0] = 1;                                     /* SIGBUS */
>
> The commit closes a real hole, unbounded pinning of unevictable memory
> by unprivileged users. The question is whether the perf_event_mlock_kb
> allowance is meant to count against the RLIMIT_MEMLOCK budget that
> secretmem and the other subsystems accounting to user->locked_vm
> enforce, or whether perf should keep it in a counter of its own, which
> would leave the hole closed and secretmem usable during a recording.
>
> #regzbot introduced: 97d34aa65c29
>

Hi,

Thanks for the report, however this is not a regression in secretmem.

The field that is being used for tracking the allowance (user->locked_vm)
is used by everything-but-perf to track against RLIMIT_MEMLOCK, but perf is
using it for something else (pinned_vm).

So this is a bug in perf, which should use its own counter for this,
AFAICT.

Actually it seems perf invented the field (user->locked_vm) to calculate
memory that actually isn't mlock()'d, but is kernel-allocated and pinned so
treated 'as if' it were.

It tracks a per-process (rather than per-mm) RLIMIT_MEMLOCK allowance plus
a 'gift' of extra available pages which exceeds this.

Every other user since is checking against RLIMIT_MEMLOCK (and you'd hit
the same issues with them too) - io_uring, MSG_ZEROCOPY, AF_XDP, iommufd,
s390 KVM zCPI and now secretmem.

So this is a long-standing bug it seems.

Other things:

The SIGBUS is unfortunately necessary - since the region is populated on
fault, it is only then that it can be determined whether the limit is
violated.

Not being unlimited on CAP_IPC_LOCK is also, unfortunately, necessary to
resolve the security hole - often privileged processes hand out secretmem
to other unprivileged processes.

If those processes then didn't apply the limit check, the mitigation can't
work.

The commit message goes into detail about all this.

The way to address this right now, as I see you've applied yourselves as
far as I can see (in [0]), is to change the limits to account for this.

I will work on a patch for perf that fixes this specific issue.

Sasha - you can re-queue the fix. I will send out another fix for perf.

--
Cheers, Lorenzo

[0]:https://github.com/truenas/truenas_ros/pull/128
