Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2043494833;
	Thu,  6 Aug 2026 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045855; cv=none; b=QLeQByLpYht1EjQYXCFBzAh46/vq6j80ZSldLCQRL5ZyuTacX0QzEWjTifVGhpARjhmNjxQp/hbQkwTBgveP/qwjAkxutx4355zBsf219d7oUTLDmqnEfsmy4fyLvQpY6afVfNC4tCagcNniwrizu2exHd272CVjOuEVFLR8EA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045855; c=relaxed/simple;
	bh=r4igmtqsgJdJuTxgeWm1z88UJ3xiqpjQRKi0xWKxtiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvXUnxZyc3Uc6WdLlgFqP2KDh4Sf4c2Wbah4mfo2f7lz5Wj18OLO0ouhSWEpQxLEbJXDE2j8cPtFD9a4LvYLMN0Pum31YJ+aUsy3BXsz+H1scz5tDC0OdprqA5hB5Ua4NlAK0KwYBjvlIwHev/+TydKGmhF/L0NVY2b8RlV0jyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UkknVyW4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkknVyW4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XPnJPdlwKV+pn57HNCg/oc14+pPD0gwRMq25SDg0VlI=; b=UkknVyW4KJCNOA8HKSgHTDZ1sK
	/yQuaKagJ5GqemMEQN5TIGoTHwWzbaNT90F7or12jMvSQK0EdEWtItslNKkz3Wsaqx4HhXCcxgfzX
	ufUolcNm+ROQLejFE4r0oH63SNsDdrkzZdSmZpQ2ADFFwb1StDHm3VEUp8oZVLMpfQHP+yJV9X3Q0
	rODT2xNARIcqrhYP1vzTOx6UQPJuAvgQFJ0DLk+dwsQ2FKgtPH67YLzGGh6vg0w7eXTB49J/x47j4
	4a6tICmj9KlT+L9+OL9/FwRAV8cMzD3+E6d0TnAn8HV/I7YZqH+FdMNtLCxQ0btPWuLWFXVspuisW
	+PegT6cg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1ws46f-0000000BnZB-43yd;
	Thu, 06 Aug 2026 19:50:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 880BA30045A; Thu, 06 Aug 2026 21:50:20 +0200 (CEST)
Date: Thu, 6 Aug 2026 21:50:20 +0200
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
Message-ID: <20260806195020.GR48970@noisy.programming.kicks-ass.net>
References: <20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com>


Finally got to look at this. In principle this seems okay, but while
staring at it, I had a few questions, see below.

On Tue, Jun 30, 2026 at 12:42:12AM +0530, Aditya Chillara wrote:
> ---
>  kernel/events/core.c | 62 +++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 954c36e28101..744643ada948 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2253,6 +2253,8 @@ static void put_event(struct perf_event *event);
>  static void __event_disable(struct perf_event *event,
>  			    struct perf_event_context *ctx,
>  			    enum perf_event_state state);
> +static void event_sched_out(struct perf_event *event,
> +			    struct perf_event_context *ctx);
>  
>  static void perf_put_aux_event(struct perf_event *event)
>  {
> @@ -2343,6 +2345,44 @@ static inline struct list_head *get_event_list(struct perf_event *event)
>  				    &event->pmu_ctx->flexible_active;
>  }
>  
> +/* @sibling must already be unlinked from its old leader's sibling_list. */
> +static void perf_promote_sibling_to_leader(struct perf_event *sibling,
> +					   struct perf_event_context *ctx,
> +					   int group_caps)
> +{
> +	/*
> +	 * Events that have PERF_EV_CAP_SIBLING require being part of
> +	 * a group and cannot exist on their own, schedule them out
> +	 * and move them into the ERROR state. Also see
> +	 * _perf_event_enable(), it will not be able to recover this
> +	 * ERROR state.
> +	 */
> +	if (sibling->event_caps & PERF_EV_CAP_SIBLING) {
> +		event_sched_out(sibling, ctx);
> +
> +		/*
> +		 * The guards keep this correct even when @sibling is already
> +		 * disabled (see __perf_remove_from_context()).
> +		 */
> +		if (sibling->state > PERF_EVENT_STATE_OFF)
> +			perf_cgroup_event_disable(sibling, ctx);
> +		if (sibling->state > PERF_EVENT_STATE_ERROR)
> +			perf_event_set_state(sibling, PERF_EVENT_STATE_ERROR);
> +	}

The below code used __event_disable(); and this change is not
mentioned in the Changelog. Why was this changed?

> +
> +	sibling->group_leader = sibling;
> +	sibling->group_caps = group_caps;
> +
> +	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
> +		add_event_to_groups(sibling, ctx);
> +
> +		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
> +			list_add_tail(&sibling->active_list, get_event_list(sibling));
> +	}
> +
> +	perf_event__header_size(sibling);
> +}
> +
>  static void perf_group_detach(struct perf_event *event)
>  {
>  	struct perf_event *leader = event->group_leader;
> @@ -2368,6 +2408,7 @@ static void perf_group_detach(struct perf_event *event)
>  		list_del_init(&event->sibling_list);
>  		event->group_leader->nr_siblings--;
>  		event->group_leader->group_generation++;

Here we can do 's/event->group_//'

Also, this case 'leader != event' we remove one sibling from a group and
decrement leader->nr_siblings...

> +		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
>  		goto out;
>  	}
>  
> @@ -2377,29 +2418,10 @@ static void perf_group_detach(struct perf_event *event)
>  	 * to whatever list we are on.
>  	 */
>  	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
> -
> -		/*
> -		 * Events that have PERF_EV_CAP_SIBLING require being part of
> -		 * a group and cannot exist on their own, schedule them out
> -		 * and move them into the ERROR state. Also see
> -		 * _perf_event_enable(), it will not be able to recover this
> -		 * ERROR state.
> -		 */
> -		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
> -			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
> -
> -		sibling->group_leader = sibling;
>  		list_del_init(&sibling->sibling_list);
>  
>  		/* Inherit group flags from the previous leader */
> -		sibling->group_caps = event->group_caps;
> -
> -		if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
> -			add_event_to_groups(sibling, event->ctx);
> -
> -			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
> -				list_add_tail(&sibling->active_list, get_event_list(sibling));
> -		}
> +		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
>  
>  		WARN_ON_ONCE(sibling->ctx != event->ctx);
>  	}

This is the case 'leader == event' (per not being the other case), and
this we remove all siblings, but then do not set leader->nr_siblings =
0, should we ?

