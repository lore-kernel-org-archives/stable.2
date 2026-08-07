Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C3453A5C
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085672; cv=none; b=Kx7XSz32gL6qj6+lIltsQzav1fCyHf0px5gmJdHrg2r5bKsWOcmiNdcDbL71Evb1CA53ofbC+XDsIhGFHAhbk+RQaXqQpV+2Yk0IXSA4ddTNa7P8rwc1MqeGv0sZOg8bEFmCB9z1ape5m5/va2zv+CAyPO0TLq3UWLc+NawqBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085672; c=relaxed/simple;
	bh=tug7sQswO90srQ+3Q3AllW5rofm8ksyrqn6GVbehczM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkHS2QGzViCbsG/b1EfouPNDAMPGcyuO7FUmXln5SEBTGP/6JEDsVind2Y5rCvxOm7AY9zolBnlvk9XhT3r0cOWG7srnt/erZcMnVdohPMTczx5XG+4f8ze49UAG3ldU1sp3OhYmWK1saCpeTn9xaHQFdqowYbHvGRIrfzVOwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=leP7pXFk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UUkomepa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="leP7pXFk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UUkomepa"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6776C82m3576231
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 06:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZeOBTbYHrkUTwW5imyA1ZIjKriCPkAvo/0a6LVyIW64=; b=leP7pXFkWUrClpiK
	Ickn3XtAgxSfXj1RcXk19Fme9576WrJTTDMaZSJU07Mgj2wZsNes11qS68wbdh2H
	P47d9fu8iq0YdAf9e4qVW6vKLxHu6g+ifk2a2KzRAQR0vcveEum2mcTMF96zr3RS
	0JAa3Z8nram284q7ytcuHKTc3uPJv+lKSDqijUfwc0Mt1SH9RSA1R12J9xNFP5Us
	M56gzuo0/BA1UQEezcoezE0mTRMD7MslN1ldkO9ARVqN67vO+9UVWBQLshNkWpTV
	L9YB6ScdVgJWNHhK9Y0o8NHaQoaR4WcAabzRW+Fp60feDrNW3qEEwX1qZucKels+
	E/pwog==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fw9vu04y8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 06:54:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84f0d3ab2f4so2642024b3a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786085666; x=1786690466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZeOBTbYHrkUTwW5imyA1ZIjKriCPkAvo/0a6LVyIW64=;
        b=UUkomepaZB4Ob93GQy6X5cwlBRTWt1fY2ENdgYW+Zj8+46oHwPc3cERPt4TugirdPv
         AtyWRZNx5RkFSTt7VYe3wAlusqnFH2RHpK08E3ruAuGWrOlS7aEsbyaEf9wIvAdWRM66
         7bea/efbLbEoy+ho1AOnb7sX7sogtUaPvAARTQEbCS33T5LaS6quigOX1D8riIus7d06
         uyontBqu5mwENm0JOgJsRcXOpeScHiXDIlAdIeblVR9HkDaFP592B6C/ZYCeQbjcrK+l
         TB2jt3v4BPhMRmkPwpaUfkjCeMMeKfrlIP48Qdvyp1kD0X6xBAc0m1ScfYQFLb9x/kv4
         RAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085666; x=1786690466;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZeOBTbYHrkUTwW5imyA1ZIjKriCPkAvo/0a6LVyIW64=;
        b=GaLUlotAdlve/W8ALDrmXE/cZiR1RK0KwxeqpuKMi1c0TDUMDBvS1BqfKUWZzxClN2
         0Ubmf31U1xQms1c04/H2iZNWaNx3gyVlsHiQDMW1exlJ9Q7fdXHL9kS9o2FS/MJl8PyK
         zOPMyp+YrxEp0ZxiN8fSsO/YkowzA2BOmGZbqwj0FyBJnDlny3U+xXhF974NWGX7Cxgi
         +227CiP4c51qOzKFhS/SfPec6/M3V95+6mfrHd4af1VnMVCo1xpVN+Ns7CfTAqfz0tM1
         vxhZV77+OG5f/siFnt7mzN+VvkDKIEFJWnzVEEcO5tJj9Lwie5xeElHmjUKLaBgXZCKq
         SDMg==
X-Forwarded-Encrypted: i=1; AHgh+RrPWZ0ep20z+Pd4QOdoxcJOJQRBY6Zw+xJa97vi5MuI5sA5XyhU8BuUVGhIUBWx5fTh1sZXh+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEsbSVqKWS/GxQ23C3WzjIWxpfDlNKvJoBBUibrg44aCZLNWFs
	V3PtyNPkfbe806s1C1r/8LggnQugptfHRiC6n4iLD+hJe7E1WtAnW2tBkFT9bin0NAz6iCg2j9f
	XI9gnZwHSC97qYLFuNzIfXBzr4KK0DdIM1hWjMbZo8B8FLxl7AU0NJOfIF28=
X-Gm-Gg: AR+sD1317ZNF7Mkonc1ech0+oifql6Cq3Pl9WGFghPM3XF7PNUnNkqhmzD9NzZK9Xua
	Os6Bvvk5PY+RlIOwUC0Axtend5mU/kB+BCjgrzh7oEo62b2wFC6X1WsLhQW9qeNIX7rrXpX73+P
	EMPMumnFZeNlxvUWmTt8BG5xR/YQGNNlrRUJLf52k+kRCBV3b0owGHljHoy80PA4Lok03tK9Vuk
	9ADGxxpQdBXEqL5TzTl32+SbjohDa5HAAsWzLDnakZk6QqO247KxJwj0cNHYUetonkDjn/7sYqa
	AzyCdED7HxSIAYE8xmHHWC4gn93PHTTRLYL50VJnWBFMQmbJ9OlwtLbeyDCEqIMuZ5AXIQ2jfh0
	GPTiDBGkvYeAYSpKXeNtjI239HQ424rxmDg==
X-Received: by 2002:aa7:9303:0:b0:848:6b76:592f with SMTP id d2e1a72fcca58-84f2e021ecfmr25217919b3a.5.1786085666427;
        Thu, 06 Aug 2026 23:54:26 -0700 (PDT)
X-Received: by 2002:aa7:9303:0:b0:848:6b76:592f with SMTP id d2e1a72fcca58-84f2e021ecfmr25217866b3a.5.1786085665952;
        Thu, 06 Aug 2026 23:54:25 -0700 (PDT)
Received: from [10.218.24.187] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a188esm510948b3a.5.2026.08.06.23.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 23:54:25 -0700 (PDT)
Message-ID: <9a965b40-c15d-4802-8d55-aacb9ad33987@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 12:24:20 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/core: Fix group leader use-after-free after
 sibling detach
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
 <james.clark@linaro.org>, Ingo Molnar <mingo@elte.hu>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com>
 <20260806195020.GR48970@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
In-Reply-To: <20260806195020.GR48970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kwF5_PNuxhxti0_5XWM30wOVHs0lTY-P
X-Authority-Analysis: v=2.4 cv=SYbHsPRu c=1 sm=1 tr=0 ts=6a758123 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6HyQyo9fOVBPkGHd9gEA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1MCBTYWx0ZWRfX26AvHUUOfFhl
 0tRr6NleINBbJUtM4lMtW0jgpsoHx8ozFOlDZtK9irjsZeYWESFtYL//fbQkvdRrBdmDvXGQwJE
 LP0Us8lyqimXvu7VbQzQRtmq7lKQ6v8=
X-Proofpoint-GUID: kwF5_PNuxhxti0_5XWM30wOVHs0lTY-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1MCBTYWx0ZWRfX4HqV8LMi0IwS
 UlF+iVPVsB3qcBaG7KbZGKOkgoJqY0jCaQMLGuyKSJFBVNz+1Hld4ThQlrecP8LvIodMis/dbt8
 AY52GLxtdd3NhzWhsYGs37rjpg5cMmsocFnoLeKxuqxfPfAuXDd4IlScVoMb9AIAf3ShnccIJke
 hRdXfm0tFli0bFKZGnBakc19YINoTTF87PpZ2fe6TqIrZ1u5KzflyB3B/X4X21u7eJxcBvo4nXu
 FzWox/ATYlpL0NUyCP1+tCOIBCDM0uGnWPn+GLbdAphI7c0Ay/uYDSf/uV0wK+AK3JwkzheGBUK
 tglUJhVxlLFi95UEQd2iEfIvNBJB6AJk5AceTNmnN/3nO58VnKCQ1f3nGqVcnkDGIox4rq2VQIz
 DeXY5GlEBNbk4jExXJIRm4MW3dA89ooZY6LdRlpYtmsXQmylEv/Up8pxr4MkI3YOSBW9Gkj/FJu
 YPm9FZz2mGoANwsQFww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070050

On 8/7/2026 1:20 AM, Peter Zijlstra wrote:
> 
> Finally got to look at this. In principle this seems okay, but while
> staring at it, I had a few questions, see below.
> 
> On Tue, Jun 30, 2026 at 12:42:12AM +0530, Aditya Chillara wrote:
>> ---
>>  kernel/events/core.c | 62 +++++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 42 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 954c36e28101..744643ada948 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2253,6 +2253,8 @@ static void put_event(struct perf_event *event);
>>  static void __event_disable(struct perf_event *event,
>>  			    struct perf_event_context *ctx,
>>  			    enum perf_event_state state);
>> +static void event_sched_out(struct perf_event *event,
>> +			    struct perf_event_context *ctx);
>>  
>>  static void perf_put_aux_event(struct perf_event *event)
>>  {
>> @@ -2343,6 +2345,44 @@ static inline struct list_head *get_event_list(struct perf_event *event)
>>  				    &event->pmu_ctx->flexible_active;
>>  }
>>  
>> +/* @sibling must already be unlinked from its old leader's sibling_list. */
>> +static void perf_promote_sibling_to_leader(struct perf_event *sibling,
>> +					   struct perf_event_context *ctx,
>> +					   int group_caps)
>> +{
>> +	/*
>> +	 * Events that have PERF_EV_CAP_SIBLING require being part of
>> +	 * a group and cannot exist on their own, schedule them out
>> +	 * and move them into the ERROR state. Also see
>> +	 * _perf_event_enable(), it will not be able to recover this
>> +	 * ERROR state.
>> +	 */
>> +	if (sibling->event_caps & PERF_EV_CAP_SIBLING) {
>> +		event_sched_out(sibling, ctx);
>> +
>> +		/*
>> +		 * The guards keep this correct even when @sibling is already
>> +		 * disabled (see __perf_remove_from_context()).
>> +		 */
>> +		if (sibling->state > PERF_EVENT_STATE_OFF)
>> +			perf_cgroup_event_disable(sibling, ctx);
>> +		if (sibling->state > PERF_EVENT_STATE_ERROR)
>> +			perf_event_set_state(sibling, PERF_EVENT_STATE_ERROR);
>> +	}
> 
> The below code used __event_disable(); and this change is not
> mentioned in the Changelog. Why was this changed?

I should've mentioned this in the Changelog, I'll update it.

In case of __perf_remove_from_context(event, ...) where the event is part of a group
but is not the leader; by the time we get to perf_group_detach():

1. perf_cgroup_event_disable(event, ctx) would have been called
2. The sibling's state may have been set to EXIT/REVOKED/DEAD if not OFF

So we cannot use __event_disable() because it would unconditionally call
1. perf_cgroup_event_disable() that would decrement nr_cgroups twice
2. perf_event_set_state(event, PERF_EVENT_STATE_ERROR) that could bring back
   the state from EXIT/REVOKED/DEAD/OFF to ERROR.

In previous code, in case of __perf_remove_from_context(event, ...) where the event
is a leader; __event_disable() was called for siblings unconditionally but I do not
see a reason why the added guards don't hold.

Should we move the guards to __event_disable() instead? That would simplify the code:

static void __event_disable(struct perf_event *event,
			    struct perf_event_context *ctx,
			    enum perf_event_state state)
{
	event_sched_out(event, ctx);
	if (event->state > PERF_EVENT_STATE_OFF)
		perf_cgroup_event_disable(event, ctx);
	perf_event_set_state(event, min(event->state, state));
}

Also, event_sched_out() in case of pending_disable calls perf_cgroup_event_disable()
and sets the state to OFF, but __event_disable() immediately calls
perf_cgroup_event_disable() again.

> 
>> +
>> +	sibling->group_leader = sibling;
>> +	sibling->group_caps = group_caps;
>> +
>> +	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
>> +		add_event_to_groups(sibling, ctx);
>> +
>> +		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
>> +			list_add_tail(&sibling->active_list, get_event_list(sibling));
>> +	}
>> +
>> +	perf_event__header_size(sibling);
>> +}
>> +
>>  static void perf_group_detach(struct perf_event *event)
>>  {
>>  	struct perf_event *leader = event->group_leader;
>> @@ -2368,6 +2408,7 @@ static void perf_group_detach(struct perf_event *event)
>>  		list_del_init(&event->sibling_list);
>>  		event->group_leader->nr_siblings--;
>>  		event->group_leader->group_generation++;
> 
> Here we can do 's/event->group_//'

I'll update this.

> 
> Also, this case 'leader != event' we remove one sibling from a group and
> decrement leader->nr_siblings...
> 
>> +		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
>>  		goto out;
>>  	}
>>  
>> @@ -2377,29 +2418,10 @@ static void perf_group_detach(struct perf_event *event)
>>  	 * to whatever list we are on.
>>  	 */
>>  	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
>> -
>> -		/*
>> -		 * Events that have PERF_EV_CAP_SIBLING require being part of
>> -		 * a group and cannot exist on their own, schedule them out
>> -		 * and move them into the ERROR state. Also see
>> -		 * _perf_event_enable(), it will not be able to recover this
>> -		 * ERROR state.
>> -		 */
>> -		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
>> -			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
>> -
>> -		sibling->group_leader = sibling;
>>  		list_del_init(&sibling->sibling_list);
>>  
>>  		/* Inherit group flags from the previous leader */
>> -		sibling->group_caps = event->group_caps;
>> -
>> -		if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
>> -			add_event_to_groups(sibling, event->ctx);
>> -
>> -			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
>> -				list_add_tail(&sibling->active_list, get_event_list(sibling));
>> -		}
>> +		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
>>  
>>  		WARN_ON_ONCE(sibling->ctx != event->ctx);
>>  	}
> 
> This is the case 'leader == event' (per not being the other case), and
> this we remove all siblings, but then do not set leader->nr_siblings =
> 0, should we ?

Yes, I'll add this.

Thank you,
Aditya

