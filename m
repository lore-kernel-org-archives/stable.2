Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F01F2BE035;
	Mon, 15 Jun 2026 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547882; cv=none; b=IX9elHoKrNn4vvgJnEf08kfZJkfBVc1zzAt32qhEL5mKwk/cXXlBMoNTtJ6BJxwUwY0cZaeHLiZWQUpI4/VT+7Htem6RriDLf792TTeIxzKqVH5kOj/eSeGMhllatGLKlcl1ZTQAau9rqbqwfxHdH7R8HPzv6uWdMOrl0EyDNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547882; c=relaxed/simple;
	bh=GqX3nmQdXJ2BcQPGs+V8jhTLhqBB4Y8nmM3AxKEgoUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d20p2ln/r6LerZHFSLSQGnv7gYGbz2BkXw+y5eT3CkQkwWRMrgU7Of5eIR0uPWxG71oEtOpg2OR6b40Y06TWMqW/oG+DOsRymdAjEE6GbH47FgkRZ7njyviy15htghp4lCyn2+w5gbl3ki8gyhIddlFam0pFwuCp+OZIXdG6TWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CPVHHc+t; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CPVHHc+t"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B4E1764;
	Mon, 15 Jun 2026 11:24:33 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000D23F905;
	Mon, 15 Jun 2026 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781547878; bh=GqX3nmQdXJ2BcQPGs+V8jhTLhqBB4Y8nmM3AxKEgoUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPVHHc+tZ1mRngLyGm29F29IxKxlBGJzBEojWtBVBMikG6AsYyU0pSU+sUQf78uVh
	 qINYo0b8R1cx+8sQrTRZ092xSngkbDQtGrNjYbCyI4V0bH3Y3uo0DSNVCmJFmdC8FJ
	 NN0gNIeRxA4moyAMnRUoKzopB7e2MXSN+4m8q+6k=
Date: Mon, 15 Jun 2026 19:24:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>,
	Oleg Nesterov <oleg@redhat.com>, Qian Cai <cai@lca.pw>,
	sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ajBDWkeIbBXjhCjP@arm.com>
References: <20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org>
 <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>

On Mon, Jun 15, 2026 at 10:49:06AM -0700, Breno Leitao wrote:
> kmemleak_scan() walks every thread and scans its kernel stack under a
> single rcu_read_lock() with no reschedule point. On a host with very
> many threads -- amplified by KASAN/lockdep in debug builds -- this loop
> can hog a CPU long enough to trip the soft lockup watchdog:
> 
>   watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
>    scan_block
>    kmemleak_scan
>    kmemleak_scan_thread
>    kthread
> 
> A cond_resched() cannot be added directly: the loop runs inside an RCU
> read-side critical section.
> 
> Walk the tasks one PID at a time with find_ge_pid(), taking the RCU read
> lock only to look up and pin each task. The stack is then scanned with no
> lock held, so cond_resched() runs between tasks and the scan stops early
> on scan_should_stop(). This follows the next_tgid()/task_seq_get_next()
> iteration pattern and keeps each RCU critical section short.
> 
> Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

I think the Fixes is just a marker to tell how far back to go. Before
the above commit, we used a read_lock(&tasklist_lock) which probably had
similar issues.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin
