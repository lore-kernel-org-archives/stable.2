Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696079;
	b=XajKpDwYqLUNJNEE/SCfaQ7WzpM0v9u9MFe6t0nVZ1R+A3WsokcRmJmYrOKS3AFEN/6g
	 LddTeCCilGUBvKpwsv2lWopNl9QZVBJzFmcv7Tb9SyWSCs0A+u6rM0+fvkpkrjDNnwupr
	 edzcVX7usJfubrvGuLu7IQwUyvgLmMqhro5UHihbOXBP81vA+H7wnpprMeb6O0HcQLHkH
	 fe8p5BszEBvyQ3c8Ygq3XWl5VovYSQAf03WVyYLI1q6Ty6O+kgthe9NmCnLYr0RIObGSt
	 tB6pytPW1QcCKFPrdff0/Bj51eSSzJb6OAHqvryE/tx15k586nz2BfPWtu4oEQ/o9Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696079;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Pp5rk/qh54GKQJ0E3WMEabU8snT7wc6IwafEvL/lrSM=;
	b=rTGlPDo39nZECGXW6KQ5R5xG48MRYgUV7jZg2kVLp3y66ALGMRvN5/ga+cuH1ik6h7Os
	 YI2cDUsVS6hiOLRDYN2ZQWt/9K1nxEEGemY7p2Ed7zrdqerB0b7B4gnLaWWbFiV6klFIE
	 mSKG88/5CwWB0vF0Md8Wt9GlVKADZR0PFHD+3ZIpQ56nIGtDElwoSEz3Wn9j8vxkwe5ST
	 7zpo9XNjqv0dwUldQRpqWrlFPUTSfDuxDItSFk7x70e2D/wPIAaYpfpmD66FL9Y9WUGy1
	 mbWrELPl3se7wAlQgPuoWLpOQigbnp4lvKpsoJD82YnrsgPcUmjp4iJK0bAidU4THBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=gmQWy2CA;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC1606A31E;
	Thu, 26 Nov 2026 12:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCDC1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=gmQWy2CA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pp5rk/qh54GKQJ0E3WMEabU8snT7wc6IwafEvL/lrSM=; b=gmQWy2CAop8sfj/0usbBQUuucN
	s1B2/e/BjrJ+pfDlF0XUTz2GNUxjdFYJHCyrHWoDOhJ6W2ol+tn6U2Wa2+jPFga/UN2Pg5q0N6v3f
	WcZdFoays6NXz1/mLF+dRWCkR++2qVr4mLTnBGsr0bggvr3rUMeDQQb/0A6N16bf0mEUGOMbOU6sP
	IgiWVlagn6CxTlUW1kAsoGWMJy5osZyHkC2rxoT9inoaErm0gp6uh/sIDuN8PtGleoZ1vIj3Ikfh7
	t/iPc7zY78KPBUh8zaltlahe0TjtE3WIJnIhapuV/bk6N3nyVZIJlF8YXZFLopwOIe9dvaaKLmIcA
	MrHIhUBw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWYZu-000000036CH-0BQo;
	Thu, 26 Nov 2026 12:27:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EAD8A302186; Thu, 26 Nov 2026 13:27:52 +0100 (CET)
Date: Thu, 26 Nov 2026 13:27:52 +0100
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
Message-ID: <20261126122752.GB83911@noisy.programming.kicks-ass.net>
References: <20261125-topology-wunsequenced-v3-1-efa3db7e0bf8@kernel.org>
 <20261125094643.GY2668804@noisy.programming.kicks-ass.net>
 <CAKwvOdmyGdn4ES6Ku+Yovd7a5imzmtmYtd7KB=OMCqKpv1X8rg@mail.gmail.com>
 <20261125200311.GA3625068@ax162>
 <20261126115032.GE49833@noisy.programming.kicks-ass.net>
 <20261126120809.GA83911@noisy.programming.kicks-ass.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126120809.GA83911@noisy.programming.kicks-ass.net>

On Thu, Nov 26, 2026 at 01:08:09PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 26, 2026 at 12:50:32PM +0100, Peter Zijlstra wrote:

> > I just don't understand any of this. Perhaps I'm being super dense, but
> > calling this UB is utterly stupid IMO. It is trivial to define what
> > should happen here and make the compiler do it, although perhaps it is
> > not what people expect -- but at that point you can have a warning about
> > performance, rather than it being UB.
> > 
> > Most all of this is me being distrustful towards the C committee about
> > volatile; they hate it while we live by it.
> > 
> > But I really don't see the difference between two jiffie reads in an
> > initializer vs two jiffie reads in random code. Its just two reads that
> > cannot be fused, big deal.
> > 
> > So they're making a big deal out of the unsequenced thing; but at the
> > same time they're eroding actual sequence points; I mean WTF ?!
> > 
> > So function calls used to be a sequence point; but then they allowed
> > auto inlining (without the use of the inline keyword), and guess what?
> > An inlined function is explicitly not a sequence point.
> > 
> > So they cannot be both concerned about sequence *and* erode sequence.
> > 
> > All of this just sounds like a whole pile of wankery without actual
> > merit.
> > 
> > Also; the purported justification of UB has always been room for
> > optimization, but volatile is the anti-thesis of that, it explicitly
> > does not allow optimization. Marking something with volatile as UB is
> > just batshit.
> > 
> > I mean, I suppose I can apply the patch, but I'm not buying any of it.
> > This is not an improvement, it actively makes clang worse!
> 
> So, if we hide this evil volatile in an external function call; then the
> C frontend will not see this most evil of UB. If we then LTO these
> objects together, the optimizer will happily merge it all back together
> again.
> 
> There is no spoon^WUB.

Further idiocy; the only case where it would actually matter is with
MMIO; and there the multi register case is far more interesting than the
single register case. However, the C language is very specific about
only declaring the single object multiple times UB.

The more I look at this; the less sense it makes.
