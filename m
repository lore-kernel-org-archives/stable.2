Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9932D7FA;
	Mon, 29 Jun 2026 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716785; cv=none; b=HAtX9PbKuWDedeNkbA9bwWqjX1x/GTBH4iID5zHB6FIVQk2o/3OmsmudRPth5w5UvjDb1EfUYuPnk7lCnFQu90wgXx5tDrRfS9UG6H/+yl0E3vG7Ep0TRZXXGXI5wH382KNmAjPdKBfB7ErRHDwcCslG8vsW7l68GDclhxoWlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716785; c=relaxed/simple;
	bh=fm//Z/sEN83LXAQ9nhz6Cuyn6ACep7//Iaeq01RQoYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvF4erKMExyPJPrD+cgPkp5rnNAGA9qK86t+1iK5Z0JcHBuOv9EOQ1y72C+Z0iYzoH2mI+IFGH3xzHYhrb+OMOWW6Pi0Jk/2M9VHqZXm8kbf3O6jor/9h5UIrs7O277U2EebRJDuMq1SOEb0DrBkIWUEhStRmKK0ToQv9Ra/9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZL6yowT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZL6yowT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782716783; x=1814252783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fm//Z/sEN83LXAQ9nhz6Cuyn6ACep7//Iaeq01RQoYY=;
  b=EZL6yowTedbWVX34VbMuvZgv5+xWbbNh55m0R4Ucwl7hrVEV7G8AYJ6X
   cz+5Uxke6j45LFN+XhhvsuiPIZikx7rWTN8e1a37wjZFbXpLBmE4x3EoC
   dznFurA+7t8tHr/6ER+52GEnZ1uyrySl8OKxLgUPjfhD24x5iBpcJfsK9
   VtZnqDuAZ/Me5eQFRAQ8J+r1qp5jPQCrbHsyrJ+xlfDsoHKT5EjTCHRgm
   THyORTmXjVE7t7G2czJy/S2ghyEZccq5AQl6i/fOnd7XnaJY1OAqqimuI
   J/8oRePxi8OlIqQGuJ7nAOoEZgb16q9Acrnr0i1msi7YuNxX6HiichCGW
   Q==;
X-CSE-ConnectionGUID: sX4Tnt3WTySVAyi4vQ2KCQ==
X-CSE-MsgGUID: qrJMhQJ6RVKz+xE9Sl9ZRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83271919"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83271919"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:06:22 -0700
X-CSE-ConnectionGUID: jIlYiO37TquiUvgq3OPcMA==
X-CSE-MsgGUID: Fnv2K9z5TI+Y80YMH83S+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="250810112"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:06:18 -0700
Message-ID: <cbd90339-f6c1-4986-8727-50a6c1b24d76@linux.intel.com>
Date: Mon, 29 Jun 2026 15:06:15 +0800
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
 <67f56151-3164-4922-a85b-e511b2c448e8@linux.intel.com>
 <bdca57f5-fb8a-4556-b5f3-13beec0cdda1@oss.qualcomm.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <bdca57f5-fb8a-4556-b5f3-13beec0cdda1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/29/2026 12:00 PM, Aditya Chillara wrote:
> On 6/29/2026 8:28 AM, Mi, Dapeng wrote:
>> On 6/26/2026 5:54 PM, Aditya Chillara wrote:
>>> perf_group_detach() handles leader and sibling detach differently. When the
>>> group leader is detached, all siblings are promoted to singleton events and
>>> their group_leader pointer is reset to themselves. When a sibling is
>>> detached, it is removed from the leader's sibling_list, but its
>>> group_leader pointer is left pointing at the old leader.
>>>
>>> That is harmless when the sibling is being closed and freed immediately, as
>>> in the DETACH_DEAD path. It is not safe when the sibling is detached but
>>> kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
>>> sibling is removed from the context, while its file descriptor can still
>>> keep it alive.
>>>
>>> A typical failing sequence is:
>>>
>>>   - A group contains leader L and sibling S.
>>>   - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
>>>     L->sibling_list but leaving S->group_leader == L.
>>>   - L is later closed and freed.
>>>   - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
>>>     dereferences the freed leader.
>>>
>>> This was reproduced by running the perf event fuzzer, CPU hotplug, and a
>>> stress workload concurrently:
>>>
>>> Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
>>> CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
>>> pc : perf_ioctl+0x34c/0xc68
>>> x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
>>> Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
>>> Call trace:
>>> perf_ioctl+0x34c/0xc68 (P)
>>> __arm64_sys_ioctl+0xa0/0xf4
>>> invoke_syscall+0x58/0xe4
>>> el0_svc_common+0xa8/0xdc
>>> do_el0_svc+0x1c/0x28
>>> el0_svc+0x40/0xc0
>>> el0t_64_sync_handler+0x68/0xdc
>>> el0t_64_sync+0x1c4/0x1c8
>>>
>>> The fault happened in perf_ioctl(), where perf_event_for_each() follows
>>> the stale group_leader pointer and perf_event_for_each_child() then
>>> dereferences the freed leader's context.
>>>
>>> Fix the use-after-free by promoting the detached sibling to a singleton.
>>>
>>> Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
>>> Assisted-by: PatchWise:gpt-5.5
>>> Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>>> ---
>>>  kernel/events/core.c | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 954c36e28101..dd9892040ab2 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -2605,6 +2605,26 @@ __perf_remove_from_context(struct perf_event *event,
>>>  		perf_child_detach(event);
>>>  	list_del_event(event, ctx);
>>>  
>>> +	if ((flags & DETACH_GROUP) && event->group_leader != event) {
>>> +		/*
>>> +		 * list_del_event() needed the old group_leader to tell a real
>>> +		 * leader from a sibling. That's done now, so make the detached
>>> +		 * sibling self-contained.
>>> +		 */
>>> +		event->group_leader = event;
>>> +		event->group_caps = event->event_caps;
>>> +
>>> +		/*
>>> +		 * PERF_EV_CAP_SIBLING event requires being part of a group, so move
>>> +		 * the event to ERROR state if it is still alive.
>>> +		 */
>>> +		if ((event->event_caps & PERF_EV_CAP_SIBLING) &&
>>> +		    event->state > PERF_EVENT_STATE_ERROR)
>>> +			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
>>> +
>>> +		perf_event__header_size(event);
>>> +	}
>>> +
>> Why not move this part of fixing code into perf_group_detach()? It seems a
>> better place to fix the issue. Thanks.
> Because list_del_event() just above my change does:
>
> 	if (event->group_leader == event)
> 		del_event_from_groups(event, ctx);
>
> so resetting the group leader in perf_group_detach() would attempt removing sibling
> event->group_node from a group rb-tree it was never added to (only leader gets added
> in list_add_event()).

Yeah, but I don't see why we can't do same thing for the sibling event
detaching in perf_group_detach(). Just like the group leader detaching,
each sibling event would be re-added into ctx groups by calling
add_event_to_groups(). Suppose we can do same thing for the sibling event
detaching, call add_event_to_groups() to add the standalone event into ctx
groups, right?


        if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
            add_event_to_groups(sibling, event->ctx);

            if (sibling->state == PERF_EVENT_STATE_ACTIVE)
                list_add_tail(&sibling->active_list, get_event_list(sibling));
        }


>
> Thank you,
> Aditya
>
>>
>>>  	if (!pmu_ctx->nr_events) {
>>>  		pmu_ctx->rotate_necessary = 0;
>>>  
>>>
>>> ---
>>> base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
>>> change-id: 20260626-fix-group-leader-uaf-c46960e525e0
>>>
>>> Best regards,
>>> --  
>>> Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>>>
>>>
>
