Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5A344DB9
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196421; cv=none; b=eQYr9mBxPOPr1HcmjrX5612MVK5Hibt1xu9iff+iCkOKeOkHZKjSDWGe4KDbrSUkTmMake6QTHdhpEvLWg0luyg3vsp11voR4zAVWVXLgR5CyLVRlekFNwCJtz0akB0kuLLorXp0qsOx+iydcJ88DFdee8yThzUwk84LcfzSxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196421; c=relaxed/simple;
	bh=etbJ2oo+uM1CMJV3SVt3i6CLWP3m1olRE2mzZkP/jqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCXaq5uyrla3nQRZXK5clGLFF3zqJqvaEJ3DyhZcTj3XQbVaheBHd4cO8An62ke2yvae1/T10wXIp99XZuu9y23+cUlVJBfJztO3chNUFaqSo2joSHk1L8T74NoNLrfynWAGth1MXq0J580+Aa88yrPZ0JRnKQVWq1GJx1MpR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oiNixrV6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T06ynyFU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oiNixrV6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T06ynyFU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0kkac2599960
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etC2UpUQyiixtRZefzGaiIsxGOMjL3UeeleogTdY9wI=; b=oiNixrV6RHoi+er1
	NcKPqrwFvYTdeMe8mf78gfX+Xll1kGA2a0RqiXCulksijwMJWuVtDm3qSMegJopJ
	kLjTPZYug6guhQ8N8bEYifDrl9yvqxNfyixAV1qGTPRwp2xO2npmwp4MLmemZeAC
	xC+14HiGQG3cGmxSxhzxlDseZdITnO4ngao2n6y/39pprwKH+rYUMeEb1u5d4vZC
	bd/vqGEEsOwWl4tOPODtumyS8sv++aAjRHMpQXKreSg/zoeV0dwOSPf3P38DrJmb
	q0AfzvPNvZFbqYKDtg6iDhpNkbUH023PwT2KfNkqnv2ZoepnczRpCRyozt8357nd
	6RmpPQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5yeb9dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:33:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8422382178bso3380250b3a.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782196418; x=1782801218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etC2UpUQyiixtRZefzGaiIsxGOMjL3UeeleogTdY9wI=;
        b=T06ynyFUWoElTJWYraztrST/XF8kynrYwjbowdTceELJezK1CJ4JeG0XZAdtJ/Buq8
         SVmODEFbYJIboTuW4MHNGeCpMJ1pzP5wvKFcqg2S5AYNqm2YUOL3UjNrqCdEzX/7qWBw
         hgK+zResOaoV2ldhugbIzpcgzITf5UsouXgubNlERS1p0VSiaHKKH7WhuXMjd0QBz8Cx
         cDAqoG5JlLiF5P5CF7dZlLdlsXzWjxo1BDbgnkfGJN7UmSm1oKjl7RsJGKH6l0S1ApCb
         jHirlJ4bnS6CTYc/X+Cl+JjDuNtGt2ef3yn0/ce28Mu8xmaX3S5acbA8PoqPmggDSmvV
         Jc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196418; x=1782801218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etC2UpUQyiixtRZefzGaiIsxGOMjL3UeeleogTdY9wI=;
        b=HpcSF6vxJOhi7Hx70mOYGJ+/jt0OeFH7TDYLH+sB28pEaZd0/KiUD6Y9/1zucPVV6R
         cPp+/GlgEVEjTsekRSHwt+ZYCp6Mn60a9j1HVnlrDCzajzJRDnyfFaJyG6x0kvitqFOa
         vptYqVpSY0z4e31nqXQ25LI/dzAmDGd6hb9JTRVwBsreLw39+uNfAoOu9duq6bhhxn2H
         d7Sfepu8OdyByrzWYJIUHVGn8Ad9ur3JwadNp6BORJ7pF4qKLuuh6lWl54h+CUgWkyLd
         6nbq53Prq5ch7tUVF8Nw9+guIy1+cW55fW/kE+YETQFv/QhzKVvgaIilvSFgxAmNG9Af
         aG0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9keoV0W3ksECn1rZ67LV5O0mucXz5Y23f3QrErDUz6DC4uA+1xZJT95gSovVvSG8Q9mlmab3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhxi0nohMaZzLQNgFyQnlhzd+gGd8isVCd97EqO86lV/mIdH3U
	SepewkdKD8jbvx628nQB6TEqlIz5ByWVGnujWzOdl9EkL9MmrzRiLpA1ElHmCUnzhKzi6HZP5tP
	Sobwo3gFa+qbGUwnaF6K90JT7xnPn9aJMcBbPNtWWbML4BhuSO9crBlBhCls=
X-Gm-Gg: AfdE7cmP3K+i1Are4atU/dD1ANY/MBLaGQFMkxT1QRCI63akdep7W74VZFKUveCs8EZ
	eNS90pokzgJrFhNWFMymuFykGDHUjWdLcb2icDgOaWhjD3+xmbAxx8TgA4yWM1wCy/ihYOK2COR
	hyQpBrFRD89aqn+ZGuOkiJZ3CZ6asvMaTVyW98Aoz/EagOyApT5+Ec5msQY30Chru7Uv45zOQKG
	KwXrVihXeDpqGIv0i3fSgkPTebdXJ2mOkM9dKR6vAtzr/vW7DVzn8jJOfzu5oUugmFhlAeZzezU
	zFzV9RV+P/bKl75CStPPQKx6rK4aptA7lt6MhDt5VK5s72Uf1fVRkZE3tqXdzbXzucrjsJoVrKn
	7j+dlAG3/NVkg3Q1k8i+HHH1kiuMyCqoHCkwivgoE52VsoLIkN4PyFF/Pa9ao
X-Received: by 2002:a05:6a00:230c:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-845507864b4mr19402316b3a.9.1782196418159;
        Mon, 22 Jun 2026 23:33:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:230c:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-845507864b4mr19402234b3a.9.1782196416901;
        Mon, 22 Jun 2026 23:33:36 -0700 (PDT)
Received: from [10.137.71.130] ([106.198.36.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecad79sm10674704b3a.50.2026.06.22.23.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:33:36 -0700 (PDT)
Message-ID: <1da2b466-ffbe-4aae-9a31-7c6177bdf525@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:03:30 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Daniel Hodges <git@danielhodges.dev>, linux-wireless@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
 <d5429e89-0eb8-46bd-b143-95fc5adefa2d@oss.qualcomm.com>
 <e46348dc-a95e-496e-8b49-2838b25bf9f8@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <e46348dc-a95e-496e-8b49-2838b25bf9f8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YRTQCYaztrbrsKOaA4G5kLU4Xu_aXfA5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfXxxhMXlKeMJyf
 +woq9bCyF7UoKmSn5ONRD0m9nuiCAL1d33rZdhU6U6yWLxqLxDN/GemYIKSRrwFh2F432BhZ8RO
 jFhTMhMTmw2WB74bBD7nO+mfsUS/ekQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX4CkeJ81K589a
 2XsE4N3wEJQv0+vdmKwUYE90e/cxZL64mw+J6O6mO71hb8t/wRN5uhwRiOJRnvurquIL+qIJ2+5
 EityhYxFyhp/BPSqEJ3g07nH+8uAUAnmD3eUKsV6Fqi5YMZBZ4P1lI9ddX7Vt49U4FDYnxY3B2f
 Ub9jyleKCcVYA1VlRl4d9XOQNHQginPbeEZvCNyORZIanOdSXhkVCkaJZGNAEqOsGmoelseH50u
 1UUuyyF3AcEcP1Cuvy7J3f11QN5gljFr+c51r+XzbuNvGlrJPSFGCaPhMCwNlsAn42+akAXymn7
 YFqakFMkcmQAyKnuPmmjmeFS+O7IeVLoZhqidt7k2kgzLiMyeBnVjX8LZDuySQvNUjqAz+b9w9y
 2ZzHirQdRk8x/KX+VuCS/qo+deOBhe4GPaMZgQIit+j+Tm8QaH+FY0bh1UA1ewHhGpKdKeJVv57
 89B31ni9dPUCZ0Sihag==
X-Proofpoint-GUID: YRTQCYaztrbrsKOaA4G5kLU4Xu_aXfA5
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a3a28c3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6/2MXK9rXRWb21GBy9lArw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=-5zR_lsLDLaSFfFJBCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230051



On 6/18/2026 7:00 AM, Jeff Johnson wrote:
> On 6/17/2026 6:26 PM, Jeff Johnson wrote:
>> On 2/6/2026 10:52 AM, Daniel Hodges wrote:
>>> The aggr_reset_state() function uses timer_delete() (non-synchronous)
>>> for the aggregation timer before proceeding to delete TID state and
>>> before the structure is freed by callers like aggr_module_destroy().
>>>
>>> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
>>> is called, the callback will continue to access aggr_conn fields like
>>> rx_tid[] and stat[] which may be freed immediately after by
>>> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
>>>
>>> Additionally, the timer callback can re-arm itself via mod_timer() while
>>> aggr_reset_state() is running, creating a more complex race condition.
>>>
>>> Use timer_delete_sync() instead to ensure any running timer callback
>>> has completed before returning.
>>>
>>> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>>> ---
>>>   drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
>>> index c3b06b515c4f..25ff5dec221c 100644
>>> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
>>> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
>>> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>>>   		return;
>>>   
>>>   	if (aggr_conn->timer_scheduled) {
>>> -		timer_delete(&aggr_conn->timer);
>>> +		timer_delete_sync(&aggr_conn->timer);
>>
>> My review agent claims this still doesn't fix the UAF since aggr_timeout() can
>> call mod_timer() to rearm itself and hence the timer can fire again.
>> Instead it suggests timer_shutdown_sync() should be used since that prevents
>> any rearm from taking effect.
>>
>> But I'm not familiar with this driver so I don't know if there are reasons to
>> not use timer_shutdown_sync(), i.e. if the timer will be reused again then
>> timer_setup() will need to be called again.
> 
> Interesting enough, another iteration of the same agent says:
> **The fix is correct.** `timer_delete_sync()` loops until the timer is both
> not-running and not-pending — it handles the re-arm case because after the
> callback calls `mod_timer()`, the sync loop picks that up and cancels it.

Yeah, my understanding is also that timer_delete_sync() will ensure that the
timer will not be pending (including the one armed from the timer callback itself)
or running when it returns with the caller ensuring the timer is not rearmed concurrently.
With that, I think this code change is fine and no need to use timer_shutdown_sync().

Vasanth
