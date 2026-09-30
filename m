Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D74E36D0;
	Wed, 30 Sep 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781559; cv=none; b=BV2JxMZIVo3aQuAgDLDO1XY1iMH9CwvLSyxLmcH1zigYtqqkSA6hUEmf5PP+37vEzFD16hksmiPq4o3cIH5/HSPSUbFwZeGZ6gF1iMEUp4I+HIaLh5u2cPr4Qfot0R1eouYQNwlMp/xDDoqKGP1kiS0+oRvlcpUjfeBJ3QMDC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781559; c=relaxed/simple;
	bh=ecYM6eiIN0pEXVUN9eXpKkK+UfcpLhdrTpGuD0OnECc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv7cVc6zdldXi57zYKrA1xhpYyQLTTZKFZ9dcRVS7nyogmxBqe/VGJ3acbh1iWhV7rW5HWiff7jx7AvscF5vLXqswzVGbpclmexHrRQYo3YQacvIGeAGOpTef7E5Jn4kYAVGndzJgbqz6sqzO23BWm1Tudcn6aFMl6D6cjOnDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R2aQ0b4a; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2aQ0b4a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1AS38y78ktzj4kRDrJvghL/aAxLdHqWz3VNxFKE2lRY=; b=R2aQ0b4avTTW5wxyrVIQlXaik7
	xlOfAblrDDetu/HEwhw6F1aqjF5CQqrnbXZWO248emvcbG1qgQHRbl9LzQ/iK76jEkhKwH26HtPhY
	INABzb6n79Y7lXJ08vRbx+YiQHlayZetBVQr211AjndXn7h4Gr9LffPyNfnn8aUUaG2khvfeXdA8C
	mpN5++iT7ua3vypo34K41aUJihJuv2EBKEnM9aGhxQQ3fmougOd2FxBfwsJqU5xPwBWnprmnzGDXO
	rUg2KaY2SIJBKHFDlgL130eusvyyWgohx4PnYR6reB4Xw/AbOaAeIFqh9I8PQH6rHatcA9NZ/5XAu
	sPAuHL/A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBw5I-00000003z5O-0myI;
	Wed, 30 Sep 2026 15:19:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BEEEF300673; Wed, 30 Sep 2026 17:19:02 +0200 (CEST)
Date: Wed, 30 Sep 2026 17:19:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Stevens <stevensd@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched/psi: clamp negative cpu_clock() skew
Message-ID: <20260930151902.GO88198@noisy.programming.kicks-ass.net>
References: <20260928233743.3777102-1-stevensd@google.com>
 <20260929081004.GS4120091@noisy.programming.kicks-ass.net>
 <20260929081740.GH4121620@noisy.programming.kicks-ass.net>
 <ar0bPEyD5CBK331p@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar0bPEyD5CBK331p@cmpxchg.org>

On Wed, Sep 30, 2026 at 10:22:52AM -0400, Johannes Weiner wrote:
> On Tue, Sep 29, 2026 at 10:17:40AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 29, 2026 at 10:10:04AM +0200, Peter Zijlstra wrote:
> > 
> > > > When running browser workloads on an Intel N100 with a sustained
> > > > psi.mem.some of 2-3%, this underflow is observed once every couple of
> > > > hours.
> > 
> > Reading is hard. This is sad, that's a relatively modern chip :-(
> 
> I'm still struggling, but I'm under the weather so bear with me.
> 
> That's a cpu_clock() implementation issue, right? "The value for
> cpu_clock(i) is monotonic for constant i". Presumably violating that
> would be a problem beyond psi?

Yeah, although most everybody has a filter on top for some reason or
another.

Mostly it could happen that when the watchdog would detect the TSC
wasn't stable after all, you'd be up a creek if you didn't also have
this filter.

But I'm very sad to see modern chips have shit TSC, that wasn't supposed
to happen.
