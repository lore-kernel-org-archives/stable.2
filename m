Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB931340413;
	Mon, 29 Jun 2026 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782701905; cv=none; b=qGt3uepT5I+OoFEyyXh3Rq43j//U8DsmW2uRt6y5NlqqE/8MAeq2Xs4NL6J2RS9p49s3+vbg8lVlplbNJAeHQIfnHpJYo8fdMC/0ibZ0ySztIkxpuWObtWQYuIR1P/Ci/mVrRoK8gA2yCK2MelthisQb8Pyt02gTOqcXalBRLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782701905; c=relaxed/simple;
	bh=DGrLnzj4QZZIdbPFeL2tolj6NLKAY6G2YYt7yvUXhr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayulVzI41aDfSE1X7JJX/M0O2KboWH2I0HXzJVqSP8AO/sU9cSdw9M2M6bOgeyEDJ9CZPYqEbWveE3JYNO/BBL175O/y3Rwyu1Q6h+Ar2MpRL9bjT5hlNf3p2TAt49ATDLllhcecMrkDxgAw7Uxoy9jDa0x8EWM1bVDPgDnSpUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr2G+lUd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr2G+lUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782701904; x=1814237904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DGrLnzj4QZZIdbPFeL2tolj6NLKAY6G2YYt7yvUXhr8=;
  b=mr2G+lUdaA+6Fvrfbu9Cj5iSixXhUruvQfZk70zuxI6F25mDA9ifpxRb
   ed/SdZUtq4jqqElCfIdOyy4cZxdfCFD5M1kQyaux8fGA4CqUJWPUGKpml
   UCgylIWHB2A9o7DwesdUoTZuGAcl6ZFb5tsYbQURGUEJCW5FmcMExcfbR
   A4NJWywWCZDZ2nhEHj2lYpy3CaRVRtirmJ/+ROxnuPalE+a4NZ8AxravP
   AabAm6EcG4glfdEZX+sfQ1+8XeczOYu8bh/mwp6Qj9SyKlK3VV291B07D
   qWPYvPsGZlEiPgxdrFegwj56NwOT40iJDnDSKVfyj2gpFLmq5wxXNvPnT
   Q==;
X-CSE-ConnectionGUID: c2kNi7I1RhiBxeO+9iWl+g==
X-CSE-MsgGUID: nk/CAu7BT/yqdR8UnX1FYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="82490895"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="82490895"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 19:58:23 -0700
X-CSE-ConnectionGUID: 5iQpqTcmTAuGZgYuXrv+5A==
X-CSE-MsgGUID: lYYThJxvQ2Cp/D5sg478Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="255437394"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 19:58:18 -0700
Message-ID: <67f56151-3164-4922-a85b-e511b2c448e8@linux.intel.com>
Date: Mon, 29 Jun 2026 10:58:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix group leader use-after-free after sibling
 detach
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
References: <20260626-fix-group-leader-uaf-v1-1-ac54652ca944@oss.qualcomm.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260626-fix-group-leader-uaf-v1-1-ac54652ca944@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/26/2026 5:54 PM, Aditya Chillara wrote:
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
>  kernel/events/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 954c36e28101..dd9892040ab2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2605,6 +2605,26 @@ __perf_remove_from_context(struct perf_event *event,
>  		perf_child_detach(event);
>  	list_del_event(event, ctx);
>  
> +	if ((flags & DETACH_GROUP) && event->group_leader != event) {
> +		/*
> +		 * list_del_event() needed the old group_leader to tell a real
> +		 * leader from a sibling. That's done now, so make the detached
> +		 * sibling self-contained.
> +		 */
> +		event->group_leader = event;
> +		event->group_caps = event->event_caps;
> +
> +		/*
> +		 * PERF_EV_CAP_SIBLING event requires being part of a group, so move
> +		 * the event to ERROR state if it is still alive.
> +		 */
> +		if ((event->event_caps & PERF_EV_CAP_SIBLING) &&
> +		    event->state > PERF_EVENT_STATE_ERROR)
> +			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> +
> +		perf_event__header_size(event);
> +	}
> +

Why not move this part of fixing code into perf_group_detach()? It seems a
better place to fix the issue. Thanks.


>  	if (!pmu_ctx->nr_events) {
>  		pmu_ctx->rotate_necessary = 0;
>  
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
