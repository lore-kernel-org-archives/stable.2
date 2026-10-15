Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82578513564;
	Thu, 15 Oct 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060864; cv=none; b=Pbdrh+41R2AP4dtZbaPZqry/cee7J98TnJe4Yve/pN20zqDpvLQDrLwlR8arWhIrYgNRNkFroUiXdTjDSSIAlGsTAGCw2pIwsjbJFvdKOi4XDH1aCd9PO6IaubZeogsQ+FludYewKddna7+8Ut3Poo+HGfxBp+yYG9+QAYx8NZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060864; c=relaxed/simple;
	bh=ScXbcgoSotmOrGMQXkrBDfhNkZYnKfm02o8V/VmFAlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nriFmED36d08HdthtSZZONLGIU3pAxeyVWaMoGNS2x/vQGOquNKcAp7wd1mdsQ8sh0sAqQR5HXHzeLlUD19cBt8USDg75Sev88LZm7StPDmVfQh7PwaQ1wRkdoXv0ULdLO0qG2dc48hgF602sUPLrN7zhuZwoGt9w6e7NFVqJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VTyvizd0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VTyvizd0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k519mSkHitpZvxCm5lMKw2mYcRI2vBvy+ZCjclepCjo=; b=VTyvizd0GEhvWz7vbKVFob2vzH
	3Xgyho9kYMZCKqfNGeXmWNijxbLvFmq61YLoWNWYX1PolPFKCHtVS3TUBmYYTgIPyUxXR3+w4rOC5
	aFa7aorubIevwlqkFix7KhlPwFhuZv5xkwS8xJT+gW6fOuZsNJ1jpK9iNi/xm565Yjyqv32DrA1Kf
	XfiMbjo7x0hAY5K25za/aL4UEjeWKN0dWTQoHn73iauEj24M0t4IZGZ1k7gmYh3AUeOiXdfBFt+4W
	hZ/dpdRBhKMuOZte96F3U+ayuHb6EV133XciqNvsKMzluONdCQnHLqaatfN0Ku2ZeoYs6TVQnfGzr
	Cc2KBLlg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHIt7-00000000G8V-1oLD;
	Thu, 15 Oct 2026 10:40:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 84CC63006DD; Thu, 15 Oct 2026 12:40:39 +0200 (CEST)
Date: Thu, 15 Oct 2026 12:40:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20261015104039.GP2009045@noisy.programming.kicks-ass.net>
References: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
 <20261015075817.GO2009045@noisy.programming.kicks-ass.net>
 <atCYFpm63elRyuw7@gremlin>
 <e51025a5-8106-41b3-90fc-53e51891ea9c@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51025a5-8106-41b3-90fc-53e51891ea9c@leemhuis.info>

On Thu, Oct 15, 2026 at 11:27:59AM +0200, Thorsten Leemhuis wrote:
> On 10/15/26 11:09, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Oct 15, 2026 at 09:58:17AM +0200, Peter Zijlstra wrote:
> >> On Sat, Oct 03, 2026 at 05:29:07PM +0100, Lorenzo Stoakes (ARM) wrote:
> > 
> >>> Resolve the issue by simply giving perf its own field separate from the
> >>> rest.
> >> So I'm a little confused by all this -- perf introduced this field,
> >> others jumped on and shit broke, so we fix perf instead of the others?
> > Yeah I think the blame really lies with the later users, and that send a trend
> > that led to further confusion (including myself, mea culpa!)
> > 
> >> Anyway, patch seems straight forward enough; and you added comment to
> >> the fields, which I suppose does clarify things some.
> >> I'll take it. Thanks!
> > Thanks, much appreciated! :)
> Just wondering: how urgent is this fix? Is this something we should try
> to get into 7.3 given that this was noticed in a regression report that
> blamed it on an 7.3-rc commit[1]? That commit also made it to many
> stable series now, which might be another reason to get in mainlined
> rather sooner than later.

I have it lined up for tip/perf/urgent. I'll try and push it out later
today. For now it lives in queue.git/perf/urgent.

