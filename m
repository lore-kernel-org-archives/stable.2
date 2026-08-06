Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8FC471277
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017784; cv=none; b=sDP2XNGLPbK08OFUQwLKDwWYZSHDx7nZUaLW9VtmcCzXxwaDxBBna1YIfH1An5lXrO2zZ1qavC1azpJIBZhtotS+cZkQsNF7ihIa0zouFQwDwNSKzfpunwssipWIAYv+9iPmTRwL7BVUH1w2JjQj8ZCsBeDobS53lLl9WxtQYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017784; c=relaxed/simple;
	bh=Pes57n+6v17ZygtCGqVVA3yl7WFgtBkWoGseT7Oe42U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS8+5/NuwU6S91b+fPQKM2orhHL+wJ1AA7gNH5aBBgmF/ijXuQWY6QaiKfAnamHy/cNeQlE2Fp5TBXKLFfIbnWu56KDgBkj10pMFiI2ll7o2EbD4zGKO/PD3qKP8vYGIJLE+XNiEp+lIxeGbMUQIENRPVjdzIgkrrmvGYNuy4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MV3n4NTg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MV3n4NTg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06C4F153B;
	Thu,  6 Aug 2026 05:02:57 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89CED3F66F;
	Thu,  6 Aug 2026 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786017781; bh=Pes57n+6v17ZygtCGqVVA3yl7WFgtBkWoGseT7Oe42U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MV3n4NTgx9HTigR5cVdXwcPNeiaG+1rdIG24BewFcVMlSAIwTKvL6D0DQFZunbBCH
	 UXWI9N/29GOOa8TfR+8Ze7pmZGsLupvdF9pOOT+7mq5XM8spEqflVAp/4biOhhTwsc
	 u7z9MuA9JMEXH6pB8m4Y7hbneTmB42rsQ0LyWjCA=
Date: Thu, 6 Aug 2026 13:02:56 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
	ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
	david.laight.linux@gmail.com, james.morse@arm.com, ljs@kernel.org,
	maz@kernel.org, peterz@infradead.org, ruanjinjie@huawei.com,
	ryan.roberts@arm.com, stable@vger.kernel.org,
	vladimir.murzin@arm.com, will@kernel.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH v2 13/20] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
Message-ID: <anR38C1uTmU4WYhr@J2N7QTR9R3>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-14-mark.rutland@arm.com>
 <7df18d5e-886e-43d1-b53d-52a1d08aba49@kernel.org>
 <d600d0db-5109-4386-9a49-955be74cc432@kernel.org>
 <anRuT1Psmar9mW5L@J2N7QTR9R3>
 <9c3feb9d-3111-4f37-90f7-3ad3c2e094c7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3feb9d-3111-4f37-90f7-3ad3c2e094c7@kernel.org>

On Thu, Aug 06, 2026 at 01:32:52PM +0200, David Hildenbrand (Arm) wrote:
> On 8/6/26 13:21, Mark Rutland wrote:
> > On Wed, Aug 05, 2026 at 08:47:08AM +0200, David Hildenbrand (Arm) wrote:
> >> On 8/5/26 08:45, David Hildenbrand (Arm) wrote:
> >>>
> >>> FWIW, in a recent discussion on some prototype hacking [1] we saw some overhead
> >>> in micro-benchmarks that would really hammer on a path that would now do a
> >>> preempt_disable()+preempt_enable().
> >>>
> >>> Switching from preempt_disable() to preempt_enable_no_resched() made it turn to
> >>> noise. Of course, that has other undesirable impacts, and I am not sure if we
> >>> are in the territory of code layout changes affecting the numbers.
> >>>
> >>> Just mentioning it as some data point.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20260630174852-mutt-send-email-mst@kernel.org/
> > 
> > Thanks for the pointer.
> > 
> > IIUC in those cases you're using preempt_disable() .. preempt_enable()
> > directly, not this_cpu_*(), right?
> 
> It was purely preempt_disable/preempt_enable experiments without any percpu stuff.
> 
> > If so, patches 5 and 6 of this series [2,3] might have an impact, but I
> > wouldn't expect a significant change unless you're calling
> > preempt_enable a lot.
> > 
> > Please beware that it's not safe to use preempt_enable_no_resched()
> > UNLESS it is immediately followed by a call to schedule(). That's not
> > documented today (and I couldn't find a good reference), so more folk
> > are likely to be tempted to use it...
> Yes, that's also why we abandoned that (including for various other reasons :) ).

:)

> preempt_enable_no_resched() helped to identify that the preempt_enable() was
> really causing the noticeable overhead, not the other minor stuff we added on
> some hot paths.

Understood!
	
If we seeeing particularly noticeable overhead from preempt_enable() in
some workloads, there are some options we could investigate to reduce
that impact (e.g. using __preserve_most or a trampoline like x86's
preempt_schedule_thunk to reduce necessary spills and register
pressure).

Please let me know if you see anything that stands out, as any examples
would be useful for investigation. We'd want to figure out how much of
the overhead comes from register pressure, and how much of it comes from
the conditional call itself.

If you're testing with PREEMPT_DYNAMIC=y, on some architectures
(including arm64) you might see overhead reduced by:

  https://lore.kernel.org/lkml/20260803191731.3244294-1-mark.rutland@arm.com/

... but IIUC on x86 that won't change the cost of
preempt_enable[_notrace](). Today that makes a static call to
preempt_schedule[_notrace]_thunk, and a plain call will be the same
cost.

Mark.
