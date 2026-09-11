Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6511C49E137
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127013; cv=none; b=jxWw/EvrxppcZ7ygLj/Gk74mXYZ4Jih1G3SiIZsU0/qMV4y7VL94QxqIsQROb5x8NcUmjyfoZv8xbfHfKqXEhFbQBSv/dwjOp5Ng+o1J2BYIM2XMKpTIrKZr/qAbK52pCQorolxxY+qQY9T6qtMEW8jtfzqcixAh1B7EUh6iBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127013; c=relaxed/simple;
	bh=ta82qRvpLbTuMvcPpvsizJtKFnj0c62EIcpwVjAC8FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0t/6giQZ+rXw6JgQcNoODE+bRIVZWOvUQMHMnBLXRB6TvOxpt5WZLjtWXtEbEXXA4T8sckDXHn20D8kj5+qSi0rmbmGQYuaKODRRUcTsJ/VCwNZrSV1Stf/jxH2PzKLJbqozvkDYBktNUyDPtdlNFBmpRQ58rduownpOI64+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qDty84m4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qDty84m4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22681655;
	Fri, 11 Sep 2026 04:43:22 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51553F59E;
	Fri, 11 Sep 2026 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789127006; bh=ta82qRvpLbTuMvcPpvsizJtKFnj0c62EIcpwVjAC8FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDty84m4BpIC3uWJlujhyCSYF9RHuMfeT3hJIq9BuGcZ9sRyih/H/wZ4XEXupSY55
	 cVzfizxQW5vye6JsQlfPLUu7iQXafWAmjdQcz3yHceBQpvR6JyqXcfAA9cYfcxmBiE
	 bENIKq/wkCzwmdgEpABCo96CyL9gu8WCKg/FdxgE=
Date: Fri, 11 Sep 2026 12:43:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
	ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
	david@kernel.org, david.laight.linux@gmail.com, james.morse@arm.com,
	ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
	ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
	usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v4 05/21] arm64: cmpxchg128: LSE: Remove redundant
 operands
Message-ID: <aqPpU2fHtK4CXOc6@J2N7QTR9R3>
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-6-mark.rutland@arm.com>
 <1b0a435e-68c1-46c2-8fc0-310694728772@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0a435e-68c1-46c2-8fc0-310694728772@arm.com>

On Thu, Sep 10, 2026 at 11:06:48AM +0100, Vladimir Murzin wrote:
> On 9/8/26 16:17, Mark Rutland wrote:
> > @@ -291,15 +291,13 @@ __lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
> >  	register unsigned long x1 asm ("x1") = o.high;			\
> >  	register unsigned long x2 asm ("x2") = n.low;			\
> >  	register unsigned long x3 asm ("x3") = n.high;			\
> > -	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
> >  									\
> >  	asm volatile(							\
> >  	__LSE_PREAMBLE							\
> >  	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
> >  	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
> >  	  [v] "+Q" (*(u128 *)ptr)					\
> > -	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
> > -	  [oldval1] "r" (o.low), [oldval2] "r" (o.high)			\
> 
> Both 'old1' and #old are read and write and that reflected by '+' constraint modifier.
> However, I do not fully understand why we need earlyclobber for them:
>  - they are not written before read
>  - we already constrained registers, so they do not overlap
>  - cmpxchg few lines above doesn't need it

I agree that the earlyclobber shouldn't be necessary for 'old1' or
'old2'. I expect it shouldn't have a negative effect on code generation
here, as removing it doesn't give the compiler any new freedom to
allocate registers differently, but maybe it causes the compiler to do a
bit more work internally.

I'll leave this patch as-is for now, but I am happy to delete the
earlyclobber in a subsequent patch (or to ack a patch doing so), if
people want?

> I had a look at ll/sc counterpart and both earlyclobebr and '=' constraint modifier
> make sense there, since we do not want registers to overlap and they are written.
> 
> I admit might be missing something. Anyway, FWIW

I don't think you're missing anything here. I suspect we just
copy-pasted the LL/SC constraints without thinking too hard when this
was added in commit:

  b23e139d0b66c021 ("arch: Introduce arch_{,try_}_cmpxchg128{,_local}()")

> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks!

Mark.

> 
> > +	: [new1] "r" (x2), [new2] "r" (x3)				\
> >  	: cl);								\
> >  									\
> >  	r.low = x0; r.high = x1;					\
> > -- 2.30.2
> > 
> 
