Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0344756DC;
	Tue, 15 Sep 2026 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473759; cv=none; b=GarU6ZAmeLIP86eyIdaxzGIyey6Loh+oWnGdSxd7lbA4zjR9K82Ip2m9gNtttPvV7D5LbAH0l3PAsqukyl6ibG2Ktmo0zBVJS1xvup+zgQ6d1xaPuavn3MIwy8nv+ReBTT/WWve3gYUw0J93ZBE8s9OkX0hoXp/Ki3dMu50gDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473759; c=relaxed/simple;
	bh=xH4BCF4cpahzuac2ZoXL2NSBHU4lSAMzOshqCCIjEYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhAbp1Y2eIOEKewkBZrJozYICmhRifdB8fZ+7FLi+y1qDyt40tL4aC7oI5nsTBIWmFH/oFmrrW+L8nYUGNdsfqdzhbgLGE878UJ00ygoYVFFt4vrEcsf35OMPVQnEqpabhphjMLmQ/7TgMPkzAiG21fX16kyrsaLNSkEW8x25a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLK5OWmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLK5OWmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387C61F000FF;
	Tue, 15 Sep 2026 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473757;
	bh=BYasB2n7OsZrAGTIxhx0vfL6Hr1V6lv0SGK3yUmQUqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kLK5OWmH5FeRp2yt2e4myKCi9y3+mY53BiK6L9vNHQ5uTM6fj3DO0pwiEqHUMvsM0
	 ESaDLlNooJaZWZzXn+fwt8sx8JYjo+kme8y6simxJbzOdml/7d7qzBvclr8ss8ybop
	 6UATgRKamRM/oJ7u2yL66NRnyvug6qhu/2dONTa5uVosSvM7FVkJ6ldmN7iiyFe0cf
	 vM+1VhChDAB7MMFUh/P7ImUwICvdJ59Zd1YtKfAMsDwPcQLf0IrNzaT/gIv0qXIxYD
	 wQAY0ojWQ/qj8v9AbBn4WGO39CTsvBMsG4tlr8iNS54yNb1hR1I1ImUeriu3Ma1+Ne
	 TFmZtf2+q/2CA==
Message-ID: <1a859476-36de-49a9-872f-a62f6eacb7f4@kernel.org>
Date: Tue, 15 Sep 2026 14:02:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: do not boost watermarks in kdump capture
 kernels
Content-Language: en-US
To: Yuanhe Shu <xiangzao@linux.alibaba.com>, akpm@linux-foundation.org,
 mgorman@techsingularity.net, linux-mm@kvack.org
Cc: surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev,
 hannes@cmpxchg.org, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Henry Willard <henry.willard@oracle.com>,
 David Hildenbrand <david@kernel.org>
References: <20260914131142.2984623-1-xiangzao@linux.alibaba.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260914131142.2984623-1-xiangzao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/26 15:11, Yuanhe Shu wrote:
> A watermark boost is not confined to one watermark: wmark_pages() adds
> it to min, low and high alike, so every watermark check sees it,
> including should_reclaim_retry() and the last ditch ALLOC_WMARK_HIGH
> attempt in __alloc_pages_may_oom().  Once the boost exceeds the memory
> still free the allocator gives up and invokes the OOM killer, and a
> capture kernel that is still booting has nothing to kill: the boot
> panics and the vmcore is lost.

Sounds like an oversight and we should deboost watermarks first before going
for an oom kill? But I guess at the same time not boosting in the first
place in kdump capture kernels makes sense and it's simpler to do.

> Seen on an arm64 machine with 64K pages, CONFIG_PAGE_BLOCK_MAX_ORDER=10
> (pageblock = 64M) and crashkernel=512M, running a distribution kernel
> based on 7.0.14.  A high order UNMOVABLE allocation fell back to a
> MOVABLE pageblock while the capture kernel was still in do_initcalls():
> 
>   Node 0 DMA free:68096kB boost:65536kB min:68160kB
>   low:68800kB high:69440kB managed:479168kB
>   Out of memory and no killable processes...
>   Kernel panic - not syncing: System is deadlocked on memory
> 
> The zone was not short of memory.  Subtracting the boost gives
> min:2624kB low:3264kB high:3904kB, so the 68096kB still free sat 17
> times above the high watermark and the allocator would not even have
> entered its slow path.  The boost supplied 65536kB of the 68160kB min
> and by itself put the zone 64kB under water.  It is that large because
> boost_watermark() clamps it with max(pageblock_nr_pages, max_boost);
> watermark_boost_factor alone would have allowed 5824kB.
> 
> Commit 14f69140ff9c ("mm: limit boost_watermark on small zones") already
> tried to protect capture kernels, but it infers them from the zone size
> and skips the boost only below four pageblocks.  arm64 64K pageblocks
> were 512M then, so the guard reached zones up to 2G;
> CONFIG_PAGE_BLOCK_MAX_ORDER can cap them at 64M, which shrinks the guard
> to zones under 256M and lets this 468M zone through.

Hm while the large pageblocks on 64kb kernels are source of various
surprises, this at least seems consistent to me. The check together with the
clamp means we limit the boost to 1/4 of the zone regardless of pageblock
size, right?

> kdump is a property of the kernel, not of the zone, so test for it
> directly.  A capture kernel exits within seconds and never uses the
> fragmentation avoidance the boost buys.  Normal kernels are unaffected:
> the size based check still covers their genuinely tiny zones.
> 
> Passing sysctl.vm.watermark_boost_factor=0 to the capture kernel does
> not cover this window: sysctl.* parameters are written through procfs
> by do_sysctl_args(), which runs after do_initcalls() where the panic
> above happened, and watermark_boost_factor has no early_param of its
> own.
> 
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
> Cc: stable@vger.kernel.org # v5.0
> Cc: Henry Willard <henry.willard@oracle.com>
> Cc: David Hildenbrand <david@kernel.org>
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> ---
> Build tested with CONFIG_CRASH_DUMP=y and =n.
> 
> Tested on the affected machine with the original crashkernel=512M and
> capture kernel command line.  Without this patch both capture boots
> panicked at 7.9s inside do_initcalls() with a 64M boost in place.  With
> it, and with boost_watermark() instrumented, every call was suppressed -
> including those inside do_initcalls(), where the panics happened - free
> memory came down to within 64kB of the min watermark, where a single
> boost would have put it 65472kB under, and the dump completed.
> ---
>  mm/page_alloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c48..276fa7169b99 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -37,6 +37,7 @@
>  #include <linux/vmstat.h>
>  #include <linux/fault-inject.h>
>  #include <linux/compaction.h>
> +#include <linux/crash_dump.h>
>  #include <trace/events/kmem.h>
>  #include <trace/events/oom.h>
>  #include <linux/prefetch.h>
> @@ -2178,6 +2179,14 @@ static inline bool boost_watermark(struct zone *zone)
>  
>  	if (!watermark_boost_factor)
>  		return false;
> +
> +	/*
> +	 * A kdump capture kernel exits before a boost can pay off, while
> +	 * the raised watermark can exceed the memory left for the dump.
> +	 */
> +	if (is_kdump_kernel())
> +		return false;

I was going to argue for making watermark_boost_factor zero with
is_kdump_kernel() but it would be more code to handle and this is not a
fastpath so I guess it's fine.

> +
>  	/*
>  	 * Don't bother in zones that are unlikely to produce results.
>  	 * On small machines, including kdump capture kernels running

We should stop mentioning kdump capture kernels here then? They can't reach
here anymore.

> 
> base-commit: 704340f1cd0dcef829eb62f5b48ae95a2ce17bdf

