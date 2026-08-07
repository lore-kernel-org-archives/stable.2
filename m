Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DDC40802B;
	Fri,  7 Aug 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093099; cv=none; b=TzGZ82cKPlsxnTR8u6Yd/zlSBC1v/SagSt+87t3gg75hN0vD4urFVDuPkPRDHJRerUKEnNZXwvaeWXMxjHWpMJj/KaoHFVUZV+Qd3Ws6KKdOaslp3QQL39XXDvVoRuKJ3eEHmHWKSB3QaTt3rBEV+x94jMvoU2S2/ckK8uum7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093099; c=relaxed/simple;
	bh=HOvCZRgllanI9wNXho5avz0HkORUNvmHi2Gm0HMRSZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd75pUa8c52Tm5hyYj0tC5v/t24v98kEVluzz0HzCsMPvh53MakFsqP14VGABvGwQfKMd5aKFxzvwt84vXrskBrdBo05CviDf2z2CzmrpSXR6ElCIoqFquHdPdu/cd5W48IkRkm5GaqftKweiH7uDVZa5iOh06KnsmRmtU4W7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nzr42lDn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzr42lDn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8kvsw19IQtGQNTBg1YRLcY00/ersReS1ZNni7Fkg1Qg=; b=nzr42lDnxlo8DexJQCck6ncQEq
	Eg62l1mVzfNZ3OzX7MmLMiKaf48DpmmWirwZBPR61Bp6lSGx9wH92WKsXYGuMBLm86IM9gJBInyI/
	IaR+L5+VbWrhLw3rX/rP7OjjvtROwzsuf/bRXNYWSJO+qlQ5y7zynsVi9bwHdN91BQL2Dp1IO1k+E
	tGqXxMfEzOUCO4FEvA1Z//08Qvi0xooKkO+wsbvYKVGmMzrc0qfgnD1bvhmbfGplviRb7FG953iYq
	baKewc8l1NbjGLrhBSsZMcN/3oEtp18JdyWrSMluLqYq41ro4vamZF1jj2BmgKGCF1G67WsskY/cM
	93ua6OcA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wsGOz-0000000CDry-3AQZ;
	Fri, 07 Aug 2026 08:58:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 119EE301127; Fri, 07 Aug 2026 10:57:34 +0200 (CEST)
Date: Fri, 7 Aug 2026 10:57:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Ingo Molnar <mingo@elte.hu>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Fix group leader use-after-free after
 sibling detach
Message-ID: <20260807085734.GQ776954@noisy.programming.kicks-ass.net>
References: <20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com>
 <20260806195020.GR48970@noisy.programming.kicks-ass.net>
 <9a965b40-c15d-4802-8d55-aacb9ad33987@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a965b40-c15d-4802-8d55-aacb9ad33987@oss.qualcomm.com>

On Fri, Aug 07, 2026 at 12:24:20PM +0530, Aditya Chillara wrote:

> > The below code used __event_disable(); and this change is not
> > mentioned in the Changelog. Why was this changed?
> 
> I should've mentioned this in the Changelog, I'll update it.
> 
> In case of __perf_remove_from_context(event, ...) where the event is part of a group
> but is not the leader; by the time we get to perf_group_detach():
> 
> 1. perf_cgroup_event_disable(event, ctx) would have been called
> 2. The sibling's state may have been set to EXIT/REVOKED/DEAD if not OFF
> 
> So we cannot use __event_disable() because it would unconditionally call
> 1. perf_cgroup_event_disable() that would decrement nr_cgroups twice
> 2. perf_event_set_state(event, PERF_EVENT_STATE_ERROR) that could bring back
>    the state from EXIT/REVOKED/DEAD/OFF to ERROR.
> 
> In previous code, in case of __perf_remove_from_context(event, ...) where the event
> is a leader; __event_disable() was called for siblings unconditionally but I do not
> see a reason why the added guards don't hold.
> 
> Should we move the guards to __event_disable() instead? That would simplify the code:
> 
> static void __event_disable(struct perf_event *event,
> 			    struct perf_event_context *ctx,
> 			    enum perf_event_state state)
> {
> 	event_sched_out(event, ctx);
> 	if (event->state > PERF_EVENT_STATE_OFF)
> 		perf_cgroup_event_disable(event, ctx);
> 	perf_event_set_state(event, min(event->state, state));
> }

Yes, that looks good.
