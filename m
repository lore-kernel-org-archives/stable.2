Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B89264617;
	Tue, 30 Jun 2026 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789058; cv=none; b=k/hDcd5aXgkx2WRY7kjDALREsFOGjgtVAHnoqebai8ap+bjxq/ud5JbEVoiny1AXhuixnYVVepCGpqN8m9K7Fe+RU52Oery0ubkAR6U4pB/8iV42dNEwaHGFOTdSbwJ+O2Eba58EilZ6M8GkMdv2CJnMrNf1pQfyfoyb3XDeu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789058; c=relaxed/simple;
	bh=kTEPPbJxVN5buc3F2nTCDSgkowYHC7ZBtLeJFcNH0h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpodrA/FZ2L/wwYcyUi9KZMgNOkJDHLCY0USqC1bau2R9KU+WQtQNeSbdwI+BWo8s/X2OB2kECH6sWAaD+Os740sKwML79j+HJDuWQfbkjzACQ10dhqTfYAlc9bRF0ew7WxVlcxJsX801KZfjsGSgMVv2ZDaQ7ECj4NDgJ3olrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSbd9pXF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSbd9pXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782789056; x=1814325056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kTEPPbJxVN5buc3F2nTCDSgkowYHC7ZBtLeJFcNH0h4=;
  b=aSbd9pXFkmH8KnGOYKVxoZYItuT3IYI8RcABhsyaKGCwK6ZrNRTI/HH6
   T7LaJYEdJqB5pzmr55Tc7/BOjoFNVyUMXilA8fqEUdxgvU7eZ5pgR3YKG
   ZGocOE91Soi0IkwQV6pP6cUJTq9VPp3bOdOcuBHggS1Nt8xtGpWHgI93j
   +XcyU4Dewwh8UlAyqwt5bmmiRIv8rFUlLXrSvHjqBAyuEgy1Butm2bctf
   l5E0iwQ05amiydLkFOFIzZgoB/0YlgFphnJ8vnVNDJkcktPlMp4zmirGu
   smavuRNK4t3S5xd8Ga5jMYWTvtYAGEkEZmU0SjDNgF1mGAq/OaWYCCDso
   Q==;
X-CSE-ConnectionGUID: hafI7H6BQG6Cx0VN2/X/Bg==
X-CSE-MsgGUID: fOcSO5MsRJyxmt1ue+jwRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83270073"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83270073"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 20:10:55 -0700
X-CSE-ConnectionGUID: hKJBoE3LRaKI5VtXHrqsNg==
X-CSE-MsgGUID: cv4r6+HHTY+1uO5cuXdsEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="249497144"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 20:10:52 -0700
Message-ID: <acea8b54-4887-4d59-9bd9-0fa7ff803d3a@linux.intel.com>
Date: Tue, 30 Jun 2026 11:10:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/core: Fix group leader use-after-free after
 sibling detach
To: Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 6/30/2026 3:12 AM, Aditya Chillara wrote:
> perf_group_detach() handles leader and sibling detach differently. When the
> group leader is detached, all siblings are promoted to singleton events and
> their group_leader pointer is reset to themselves. When a sibling is
> detached, it is removed from the leader's sibling_list, but its
> group_leader pointer is left pointing at the old leader.
>
> That is harmless when the sibling is being closed and freed immediately, as
> in the DETACH_DEAD path. It is not safe when the sibling is detached but
> kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
> sibling is removed from the context, while its file descriptor can still
> keep it alive.
>
> A typical failing sequence is:
>
>   - A group contains leader L and sibling S.
>   - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
>     L->sibling_list but leaving S->group_leader == L.
>   - L is later closed and freed.
>   - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
>     dereferences the freed leader.
>
> This was reproduced by running the perf event fuzzer, CPU hotplug, and a
> stress workload concurrently:
>
> Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
> CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
> pc : perf_ioctl+0x34c/0xc68
> x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
> Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
> Call trace:
> perf_ioctl+0x34c/0xc68 (P)
> __arm64_sys_ioctl+0xa0/0xf4
> invoke_syscall+0x58/0xe4
> el0_svc_common+0xa8/0xdc
> do_el0_svc+0x1c/0x28
> el0_svc+0x40/0xc0
> el0t_64_sync_handler+0x68/0xdc
> el0t_64_sync+0x1c4/0x1c8
>
> The fault happened in perf_ioctl(), where perf_event_for_each() follows
> the stale group_leader pointer and perf_event_for_each_child() then
> dereferences the freed leader's context.
>
> Fix the use-after-free by promoting the detached sibling to a singleton.
>
> Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
> Assisted-by: PatchWise:gpt-5.5
> Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
> ---
> Changes in v2:
> - Moved the fix to perf_group_detach() with a small refactor
> - Link to v1: https://patch.msgid.link/20260626-fix-group-leader-uaf-v1-1-ac54652ca944@oss.qualcomm.com
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
>
> ---
> base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
> change-id: 20260626-fix-group-leader-uaf-c46960e525e0
>
> Best regards,
> --  
> Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>
>
