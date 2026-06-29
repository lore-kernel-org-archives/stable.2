Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70618DF80
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782705666; cv=none; b=lj4T4aph1xrTDa+n+dHOgTcXo/Nl9ZY8brUrFoJna/GMAJ2TLYizl10uFzr6T2PoQ1jG/LTXnh7Mt0eIU4ogMnPCOneTCwk11JqMnRLzWIK9/CQJuBvSJQYK0OCxMzkVC8jrecWR3um3/eNoWWfsrQ74coeXYbbN3hw2LjdMsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782705666; c=relaxed/simple;
	bh=3QkoE1jtNtq4n2U70SnB/hX4AkNxbV7a7d9DCgtjFME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfRWV5z5UgE3m5TSs8MaXQl/mmFlmgfM44B5/9GzjjLh8cdsK/nWeDKJCyT9Ph7x4NVFBZCOzejoh6CcnV9ZrHWmfv0fAdrwTEsTv/H0jAUMbpeNYyY2SFCe6reBMe5SkLsrRiCw0tJWQWPsHnaf06KUq9WI60FG7zZO6Gtts10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pyZsVxVM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=axMpJbtn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pyZsVxVM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axMpJbtn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T2cvqW1549945
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 04:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hUw3sV/S3qIZv1q5k215WRUdwAcFAR4YpwI7q+yvo8w=; b=pyZsVxVM6XSyaqW+
	VeAlx5wsghE2fas0aAgdufYZhe44kmLN+s+nhW+HibSItIlptqjGrvP4DNjQwhV+
	pUNYuTX4+TsJ6A14csUNEXJmH0EYrfOS6ulq0nwWVSQW6Ged4Qfhj6Gw7enArCa6
	e7NVGLEzSfnmgOCpmg+dXSm0kls2tDL5Fe2jvFtAxDtmQkISdLk4ZRyqMyocM6fv
	uoeERLNAU4elVXbsmdiRGSroub43gJcraSeJQNq1c1ojdoJAJDL/8OsNENWCovPx
	+7KReRTClnaQD1ugJQ8StBfbM74bCl1i2oUxNlkr3zNA/z3W+QR6ngTKyXC1p6Cn
	iQwGYQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mdx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 04:01:03 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-137fc6f8e9fso4874897c88.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 21:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782705662; x=1783310462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUw3sV/S3qIZv1q5k215WRUdwAcFAR4YpwI7q+yvo8w=;
        b=axMpJbtnoiPKdJ2rY0A8nwdU3lxTAru51/iDkvd2gtNH2WAfEUb23TG2sDBw6x1rss
         Abyy57/hZhbUi79znsZCu0r6pMwokyADuZLokzidlz12z0CtDrTEbfKi6XPYi6MNE5QV
         8LbwCHZ+JOmZIWgxKI6lmyi+Jsbj7tYWyqePp6KUXSBTHLhXG0ytC7pIObsaozs/+lOK
         cVX3WyKIheiBVx3dwrCepONwpFGE061y+VOwoDJkOs9wNaPllWBYRKTmwtIfZ8Ug0tIW
         BA6wvvOcWLJznJg2h2my2cz25y8JbRNqQ4UMuVmIBo9i9xeCuyXe0jCoKlEda3j3PF3L
         nyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782705662; x=1783310462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUw3sV/S3qIZv1q5k215WRUdwAcFAR4YpwI7q+yvo8w=;
        b=LI7Al3Q6n0jDhIGo/EhkA7SqtDEHFj16OSDWVBy1Yx3/qXRknnpOuV8m/fTqvL+Y75
         JG0TrTuUnXopiiq2kxJS1VzGuX00Zd60xsZ8bz9hqknkqTpXEK4l7gqWcDsZepXf6uRD
         hoqq15LrKqcttONU8z/ca+Jfs1XaNBOhy4qilE/9gbyeP824vp7uGvO4Q4OAGaxsGSW6
         VdHIGqXlcAEFxT6sS4Hn2hxTUtqdxUfxP3JoE7mrr3Cu2B/3hGotbh0Ncp4THO8ti3iL
         s+B+qbZ8aW9LHITicNFQ3RSdKauUQ38TPJANSV85WPBnX7wLD+6CNyTutvQCTfXewmJD
         40hw==
X-Forwarded-Encrypted: i=1; AFNElJ9mHh23CdX90lslzgdLik7uDxTql2eTJESMglOGdXwEdCC76A9IScahjLMV+XxVCvam0r0FGqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JY4qBZji3QzDmAhwOEcdajtXCqFqnoLN+5PXyBH05Mvqde29
	SYZziEe3sd+ACm58gO7RpGW+nD8oZDUgAKLJGWNQuMrMbtiUjpQyJv9GxzlrgXfi8CwYjSAZtU7
	RK8vilGJtBJiXWBfh0HuJ72kthR9dLw1Jo2Dp6eh/2RdA5MExund8uTp1e48=
X-Gm-Gg: AfdE7clofGe/yB32lsUMoZXoEXsoDRW9TxbuEfg2cWNBjvL41t+svVw9yn4PNnvnvsZ
	NSvZB4ZXQTDAf0+IQQdBXJWJsPMnx9h9D1AEX4A5k/9GL+K8PoYE9lUy7IojhWd8Q3qrEImfaD8
	Ds20ZefKQbD+w+uExj5zIP+FQ7Y9LG5YcyBaEedHGN5zEpsmasVoe5gN8l5hIXRtlfea/gWv5gr
	XhHrI7Rrhv5aGf+rtojGqrXSqIfXx2Xl0IbjqviZ0f0JiaznBraCJ7NGFfks9eTWgz73YxG72oZ
	Oi4h/NPrzxvrP+eyMMCQAaY6XCmJYZUfs0zi0WlKxTMW8Orrnr+9rHgJZ8pL1Ksvtav2grVDYwp
	VK9m4I/c5DXC73Cm23GbV4moL3BUu4tM5MXs/JJ4qzAgH
X-Received: by 2002:a05:701b:4516:10b0:139:f62c:9587 with SMTP id a92af1059eb24-139f62c979fmr2629911c88.22.1782705662104;
        Sun, 28 Jun 2026 21:01:02 -0700 (PDT)
X-Received: by 2002:a05:701b:4516:10b0:139:f62c:9587 with SMTP id a92af1059eb24-139f62c979fmr2629884c88.22.1782705661457;
        Sun, 28 Jun 2026 21:01:01 -0700 (PDT)
Received: from [10.219.57.157] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d912197bsm68401244c88.15.2026.06.28.21.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 21:00:59 -0700 (PDT)
Message-ID: <bdca57f5-fb8a-4556-b5f3-13beec0cdda1@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 09:30:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix group leader use-after-free after sibling
 detach
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260626-fix-group-leader-uaf-v1-1-ac54652ca944@oss.qualcomm.com>
 <67f56151-3164-4922-a85b-e511b2c448e8@linux.intel.com>
Content-Language: en-US
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
In-Reply-To: <67f56151-3164-4922-a85b-e511b2c448e8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXxcHJWqbvNBbT
 0cLb8E4Nj81Q8sN1Bu/dKbcPwHhCfhn96Ux7keOOLWVig36K/zx3Ja9iCBXmZP5TH0GBp7zvYzg
 HRPA2M9m9qwJWj79pTyOd5tEh0bskWs=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41edff cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=5nFhSs-KBMbq4J5pQ7cA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: IeZmc2C1UgrrIgOkvkslmXg048BJJuPh
X-Proofpoint-ORIG-GUID: IeZmc2C1UgrrIgOkvkslmXg048BJJuPh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX+XM1UzsYlojm
 K7HbAcoyV4BkZZTUUAzFFIb2FSV52BW/T5YY290LYCcmw7v5zDVH1D2SRqgwfvlGTizPN4wBsDa
 3609XPOyysxFYXIl3qqU7qRC3oebsbmRMw4WgmaUOrNRnlgizipqBujucZcPkd5ucoia2ESjirj
 q91eGdnf2W+YP8/ZQ+OA+hUgHB7DipX/+V9KYJpRbLECWZIvlgJx+NdlmszwgU9ZD+ngcwqQkfY
 Fv7aURWKVPDmLxKimq2AybRcsPk2dwDQAg9BgixZjUjEtlkujm38hPK2SJrlh6MLZd5DrtOIJNp
 KAUziaixH/YCu//iueBHPL5He918MTvjAPu/0EgiaMTXHjQ/auC0/1cElT219nSZxvYgZvvEF1d
 9xle8YJU717c7Mgs+GvBAvWojsMXmkdkV3d3RZEfpiLFoYXPuxCinmjAugtIphlNYb828xnw+pe
 +cTQuh2uU8Iy6K6UqAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031

On 6/29/2026 8:28 AM, Mi, Dapeng wrote:
> 
> On 6/26/2026 5:54 PM, Aditya Chillara wrote:
>> perf_group_detach() handles leader and sibling detach differently. When the
>> group leader is detached, all siblings are promoted to singleton events and
>> their group_leader pointer is reset to themselves. When a sibling is
>> detached, it is removed from the leader's sibling_list, but its
>> group_leader pointer is left pointing at the old leader.
>>
>> That is harmless when the sibling is being closed and freed immediately, as
>> in the DETACH_DEAD path. It is not safe when the sibling is detached but
>> kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
>> sibling is removed from the context, while its file descriptor can still
>> keep it alive.
>>
>> A typical failing sequence is:
>>
>>   - A group contains leader L and sibling S.
>>   - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
>>     L->sibling_list but leaving S->group_leader == L.
>>   - L is later closed and freed.
>>   - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
>>     dereferences the freed leader.
>>
>> This was reproduced by running the perf event fuzzer, CPU hotplug, and a
>> stress workload concurrently:
>>
>> Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
>> CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
>> pc : perf_ioctl+0x34c/0xc68
>> x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
>> Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
>> Call trace:
>> perf_ioctl+0x34c/0xc68 (P)
>> __arm64_sys_ioctl+0xa0/0xf4
>> invoke_syscall+0x58/0xe4
>> el0_svc_common+0xa8/0xdc
>> do_el0_svc+0x1c/0x28
>> el0_svc+0x40/0xc0
>> el0t_64_sync_handler+0x68/0xdc
>> el0t_64_sync+0x1c4/0x1c8
>>
>> The fault happened in perf_ioctl(), where perf_event_for_each() follows
>> the stale group_leader pointer and perf_event_for_each_child() then
>> dereferences the freed leader's context.
>>
>> Fix the use-after-free by promoting the detached sibling to a singleton.
>>
>> Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
>> Assisted-by: PatchWise:gpt-5.5
>> Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>> ---
>>  kernel/events/core.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 954c36e28101..dd9892040ab2 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2605,6 +2605,26 @@ __perf_remove_from_context(struct perf_event *event,
>>  		perf_child_detach(event);
>>  	list_del_event(event, ctx);
>>  
>> +	if ((flags & DETACH_GROUP) && event->group_leader != event) {
>> +		/*
>> +		 * list_del_event() needed the old group_leader to tell a real
>> +		 * leader from a sibling. That's done now, so make the detached
>> +		 * sibling self-contained.
>> +		 */
>> +		event->group_leader = event;
>> +		event->group_caps = event->event_caps;
>> +
>> +		/*
>> +		 * PERF_EV_CAP_SIBLING event requires being part of a group, so move
>> +		 * the event to ERROR state if it is still alive.
>> +		 */
>> +		if ((event->event_caps & PERF_EV_CAP_SIBLING) &&
>> +		    event->state > PERF_EVENT_STATE_ERROR)
>> +			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
>> +
>> +		perf_event__header_size(event);
>> +	}
>> +
> 
> Why not move this part of fixing code into perf_group_detach()? It seems a
> better place to fix the issue. Thanks.

Because list_del_event() just above my change does:

	if (event->group_leader == event)
		del_event_from_groups(event, ctx);

so resetting the group leader in perf_group_detach() would attempt removing sibling
event->group_node from a group rb-tree it was never added to (only leader gets added
in list_add_event()).

Thank you,
Aditya

> 
> 
>>  	if (!pmu_ctx->nr_events) {
>>  		pmu_ctx->rotate_necessary = 0;
>>  
>>
>> ---
>> base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
>> change-id: 20260626-fix-group-leader-uaf-c46960e525e0
>>
>> Best regards,
>> --  
>> Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>>
>>

