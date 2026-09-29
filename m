Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FE3B14C6;
	Tue, 29 Sep 2026 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669866; cv=none; b=elr44AqLh0HHkGqQAVRLieHw0p8rA9kaTW99JXQF7YMppPTJlkJz1j9shiVDIXBeDBtfqeTrLYWcdkVJk8zjtbWotobCL7WKClCZTDNAH6OXbk5BQFWb7cmYYgSrDjaBPiQc6RU8MTNJYrBMh4zr7UbmgKYieOoG0iG5y08fGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669866; c=relaxed/simple;
	bh=9wjlQLssATALYhKM0vpkOIcxvVmpWm1aP34WbYkqIbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si2yRm+bBLDzbtSQ+HJ05kKPKp15td+NFtEJmxaoO8Yb9mM4INNml1UTJrnFc034lBcHwzZMbv3z2b97pVOFarxMefBnooUEsP7dmKq13T+43V61VhKAtlqcfY/i+7YvWmrLKnIRP1QYoqutj6/OM6bgh9CZbPxeeAM1oWJ8Rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gqu8QVk2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gqu8QVk2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9wjlQLssATALYhKM0vpkOIcxvVmpWm1aP34WbYkqIbA=; b=Gqu8QVk2WonuQBpb3WMf8KpX+O
	Chm2ExLDnu2QFPuHjF/UvhHPx3UELfAtyslk5+0jGYtS214mFRSRRArDi4fgGeavZ2J4Gpl/dZXlD
	eVVX58Z0/Pj3IIBYJOozGJgLeZX+P1vATGJHmoPHqn4wVbDCHOfHEanDimsxiUjNYUl/Ig5XBKBG8
	T+4WV588I3cxM9iEwUP4Vw89thBVugIlBc6XIU3n1E4gR8aQfyQAYxaWGZaTSn6Oq+xWMFi7n4mT1
	cIJyJH0vjUWC6ekkTvsgFnM2ZOG/3x6ZOo2DwiPHHBUcwKIT+MEuOi9bJKRSvaZ6UYJpzb7yTsVd0
	SEcp4dPw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT1x-0000000BgJe-2Nsd;
	Tue, 29 Sep 2026 08:17:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B9C95300446; Tue, 29 Sep 2026 10:17:40 +0200 (CEST)
Date: Tue, 29 Sep 2026 10:17:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Stevens <stevensd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched/psi: clamp negative cpu_clock() skew
Message-ID: <20260929081740.GH4121620@noisy.programming.kicks-ass.net>
References: <20260928233743.3777102-1-stevensd@google.com>
 <20260929081004.GS4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929081004.GS4120091@noisy.programming.kicks-ass.net>

On Tue, Sep 29, 2026 at 10:10:04AM +0200, Peter Zijlstra wrote:

> > When running browser workloads on an Intel N100 with a sustained
> > psi.mem.some of 2-3%, this underflow is observed once every couple of
> > hours.

Reading is hard. This is sad, that's a relatively modern chip :-(
