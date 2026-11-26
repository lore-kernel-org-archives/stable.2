Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694895;
	b=AXCzwcfKKVEqfNzgxlkJ7jtCUtgnUv2hl48A0WJ3lqqshaANKuK5jNaFH22BqSCyeEwb
	 yy/l9H5JbOGeA+HI/Jh5H9e2Sr8PvxIkmo0JdYUlL9azAH30+pL1jll4HeVn6D1um9j5d
	 sOckL1pcg+Gik/9PQ3UlRT1q1mPcZWYUWYikfaDmbl9roHBL0bksKYZfoQkPgYbpYm1/J
	 /FGAISctyGss5Dx6ZfQ7r9eIh7MlH76qrHv1AnSKk6pQCo3xzkmulTpcp2jnQBbWo5Y0u
	 2bI5/9FhsNKJR6+4sYC8jv7gJ+07xRThfj1cR/C9OW+5/aelA/lYAoKqtO4iDibg4GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=4SVfDoLwtWsNqklX6U3Vo1vpURtzjNZI3fsbY/rTazM=;
	b=PFvv6UKHYjzVeLKqbIH6Z6LEic9Eum5l45Wd/3ucNlf6W4R6tMbRph5stNhXq6if+3Eq
	 PQyJVi+yhf1k9VpL1lwVH8/jeMfRlNms3z7muyZkCWRMWxM/JaC8mnJRC/vXlL33HMaFs
	 NYApFa91ocXff1w7bD6j8jQUx06M8rSteYSMQjrrGkY8rEGOh9F1XRrkjhFFIKuUElO0Z
	 3S/KTTENQTRwYHN7IN++Fl4U8e0TmuXJ0PvQKDYkWvt05YDgNJJqYr3O5utLOs2SCjm1c
	 TFOhWLkId4MiipYTMXYe/7IuBiO83TLBIdgM5uS6qXLEgfnSTUZfB1XJhV2JDa+SezA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=B7KIW8u5;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E4606A31C;
	Thu, 26 Nov 2026 12:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 731E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=B7KIW8u5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4SVfDoLwtWsNqklX6U3Vo1vpURtzjNZI3fsbY/rTazM=; b=B7KIW8u5AVWuwIDsjtarSTTzPZ
	V7qAQyAOXyOQFwozgEZnWuoRdZdmp7zaLebqm0i+bC03hX3bYqguhEHREHt3SDinkIbawVxcytytm
	IUfoY1oh0AbrdVey55sQ9QSAG2comlaHVYgfDJrN4fmhq/uou8zGjl6TMFFA5VOsT5Z5gKDGARvE0
	tvzAGjLENDVlXsplt6iOv1CzDZaiiNBiU1QNHUW3PuvFv29rVjeIHbdLd0HQVZGBlxAPdmN0aOTZd
	RzTZygi0Q/+UOo0EP/XyrTd0KnFUu7rvRAzYm37hJHQeY0BXTZUsl23PfagnfiZfxVDeoD2mu/TFj
	Ihck30Lg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWYGo-00000006SRK-230B;
	Thu, 26 Nov 2026 12:08:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4F88E302186; Thu, 26 Nov 2026 13:08:09 +0100 (CET)
Date: Thu, 26 Nov 2026 13:08:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
Message-ID: <20261126120809.GA83911@noisy.programming.kicks-ass.net>
References: <20261125-topology-wunsequenced-v3-1-efa3db7e0bf8@kernel.org>
 <20261125094643.GY2668804@noisy.programming.kicks-ass.net>
 <CAKwvOdmyGdn4ES6Ku+Yovd7a5imzmtmYtd7KB=OMCqKpv1X8rg@mail.gmail.com>
 <20261125200311.GA3625068@ax162>
 <20261126115032.GE49833@noisy.programming.kicks-ass.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126115032.GE49833@noisy.programming.kicks-ass.net>

On Thu, Nov 26, 2026 at 12:50:32PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 25, 2026 at 01:03:11PM -0700, Nathan Chancellor wrote:
> > On Wed, Nov 25, 2026 at 11:32:31AM -0800, Nick Desaulniers wrote:
> > > On Wed, Nov 25, 2026 at 1:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Nov 25, 2026 at 12:23:35AM -0700, Nathan Chancellor wrote:
> > > > > Clang's warning is ultimately pointing out that jiffies may have two
> > > > > separate values in this initializer because it is volatile and accessed
> > > > > twice and the order of these accesses is not specified. This could
> > > > > result in unexpected or inconsistent behavior depending on the code
> > > > > author's intent and whether they realized the variable was volatile or
> > > > > not.
> > > > >
> > > > > As two separate accesses is not necessary here, add a local variable to
> > > > > hold the value of jiffies before the designated initializer so that a
> > > > > consistent value is used for initializing both members, clearing up the
> > > > > warning.
> > > >
> > > > None of this tells me why we should not just disable that warning and
> > > > get on with life.
> > 
> > See below, I believe this warning has general value (but maybe not
> > here).
> 
> Yeah, not here.
> 
> > > I think the warning has value generally across the tree, even if this
> > > particular single instance "isn't a bug, per se."
> > 
> > Hard agree. Just because this particular instance is not a bug does not
> > mean future instances won't be. We pay a small cost to silence the
> > initial instances then we get to see what it flags in the future. If it
> > turns out there are never bugs, we can just turn the warning off
> > globally (we've done it before) but I'd rather have hard evidence of
> > that first; to me, these initial instances don't count. No maintainer
> > has objected to the other patches I have sent for the other instances of
> > this warning and there were not all that many for how much code the
> > kernel has.
> 
> I just don't understand any of this. Perhaps I'm being super dense, but
> calling this UB is utterly stupid IMO. It is trivial to define what
> should happen here and make the compiler do it, although perhaps it is
> not what people expect -- but at that point you can have a warning about
> performance, rather than it being UB.
> 
> Most all of this is me being distrustful towards the C committee about
> volatile; they hate it while we live by it.
> 
> But I really don't see the difference between two jiffie reads in an
> initializer vs two jiffie reads in random code. Its just two reads that
> cannot be fused, big deal.
> 
> So they're making a big deal out of the unsequenced thing; but at the
> same time they're eroding actual sequence points; I mean WTF ?!
> 
> So function calls used to be a sequence point; but then they allowed
> auto inlining (without the use of the inline keyword), and guess what?
> An inlined function is explicitly not a sequence point.
> 
> So they cannot be both concerned about sequence *and* erode sequence.
> 
> All of this just sounds like a whole pile of wankery without actual
> merit.
> 
> Also; the purported justification of UB has always been room for
> optimization, but volatile is the anti-thesis of that, it explicitly
> does not allow optimization. Marking something with volatile as UB is
> just batshit.
> 
> I mean, I suppose I can apply the patch, but I'm not buying any of it.
> This is not an improvement, it actively makes clang worse!

So, if we hide this evil volatile in an external function call; then the
C frontend will not see this most evil of UB. If we then LTO these
objects together, the optimizer will happily merge it all back together
again.

There is no spoon^WUB.
