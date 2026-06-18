Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238661E4AF
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781746243; cv=none; b=NLhJrEOX+POR4rw0XYx7Mot2Ab/JIXAxZ4Ly2kf3yPXJd2NUfbS3N5jxcmzUl6xfiBj4HjKY9OB+Z8etu6IGaXjt6kUg2pc8EhcEb1QtgxWTBKpskEjUDYGxrzARtpA3Y8FoOvWXmP0nCmvdS9m5+3/QnzHLW/MjzWHrahKzLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781746243; c=relaxed/simple;
	bh=xXWgGBgQoCldbXSorwbebvXAaddQF+ZKb/qrNLzOp9w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qav4PXDluF2uf48FkXFxSZzqDCDTs/DJ5vOVDkZC4sfIUA5dGxq2ToAb1MWDDuPnVaJyIHkbZtW6Dh/CuNXfMqvyXhv/Ymhq4OgVlWOuoaQfJnzcUXSqexABb+X0L7Io21drTRxM383M6YYcFMpG6G6KTCEGAkIBOKmstI1RvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oziYE+/q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BBrckebF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oziYE+/q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBrckebF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHd78G2845499
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iIhvmxaTT/WGeHYzztvI3zMkUGHJTXnzFOaumPvPxFc=; b=oziYE+/qTudazA3o
	xWayu+2R64MgeYdVieAJQwiyuJgsn9qHnETR9Ol2jGCk1Q3LujXbtqmQImvZ3dLw
	rlrPypdIIsnUrBposm7kyCqeAHn9VMshguXB0YneGReZZ43FSYW79mW2yR8r/3xQ
	xhqcTIY0DN5JYhu4jDPRxtXVpS0hh9BT6rLIoAlS08w8iW9tszOr6vsQWCUzhe8i
	c8VN8l8Jq3WdK7cT0l/nd0bGnOouLf0EOvvAO4kRqVjKV+NdwkdU/klfm39Ak7Tq
	qFmPPuouHa/1fYWGksrkL264VI8K6v/FUhGIoheQElNMxpYPN8aWsa2kJvXpSUxn
	mvVo6w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euxt522wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:30:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30ba395b047so1708248eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781746241; x=1782351041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iIhvmxaTT/WGeHYzztvI3zMkUGHJTXnzFOaumPvPxFc=;
        b=BBrckebFlOCdd0qE2TROz9B2lwxVigLSvvCPM/Q8OBqdfYUiIAFffWiOElPrQrtyu4
         4zaGdxoFH4CsNq6pLXr7VNX2Qf/xJMAfZuDpvuoh8CB/IvrPWAnSkRHephDypJ3bTL89
         zKCRmps5mgmT8qeuNotOCt+r12KPv9tmr1YDwYKuefhx9uFDlFTme6v2OBgjGJK/U6+r
         wutAEHodEKToBOfoFVFul+nS9rqLW2i8nscPGicO8HLjQ4XaZ9oN56iZrQahuhnvuPaZ
         J8zPfP+KyZJZ0Bxk9Kd0gReA7CsV6IgeNL27GyHX7Swh2IkbSDfPoPDsTrJV0qUnidi9
         Fa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781746241; x=1782351041;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIhvmxaTT/WGeHYzztvI3zMkUGHJTXnzFOaumPvPxFc=;
        b=jMF2/zfNY87YhwIy1o4TLvds3229egULEmltXV2xURV06JLync8jPlKmjDpCME5ZSJ
         AXkLNua0MrPS/exwyrmJNwdOyVpqgAR7JM11h/eDkzPoQYDFghoAgn57kTPoEJbQFgRC
         1sxCzc6u1Sd/UlhP/7N1syzUdSkIuqXTrct32HCGeEJyjQjd9Q1bQG2Sdeqw4qwYCgy9
         SmL+BSG+LaHCMlTwBHsN9fFEayrJfhxWGHvM62lDPBmoAnINgJwef1JEKh9Aes9iiGbF
         FGSCkTqRyA8esUDaLR9xQ2M85TZ8S4MfKjPQd5Op+ZvNTAA77KlbP+nAxPo0ZNK4fA5J
         zk7g==
X-Forwarded-Encrypted: i=1; AFNElJ84c6UN4qW/ZX3jk9pGV6fb77vxn+9U88iSfoZ7KC3aWUy5q8JP5FF+dIbD5EU0XOT+gGYpMMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvO1HgSlRrsTEln7ExzFlgsc1Yeez+YBs1ZYQBSub7LwkIWzYx
	nJRcn4slG/zzoE9mTpovextb3xOjuqdnDBK3H6OKNKV4njYExGf5vG65qQ9qHooc8Q6G4G4cMYI
	zkdFxObZCX9JEPTKfGBvJBjGKR86SFLgg+uBQSO96aw4jnK1mSPE67XMAewU=
X-Gm-Gg: AfdE7cnkTeWTde0UBrLKOfKbz2Hw6stKvvHWtb59GMi3VIo4wpqMNtOWodKeUFhxHbt
	F1kb+tAxhnAYBGFQrkBT80KSYY2YhRefeCGX4ZZQBZVV9HHRwawygIxX5TbtAqYoG9JkE2uygjO
	pqbN6P6wyDFXQFWGDX9Lqnbh0qRHZgMSVv83wWluS9XVsMfMDHPL3jDJyhs+qkX1vJoa9v/C8g/
	pdwk4VqicKLN9SLwUtmqOQv9xsdjVG6xgph8J4EnDEFaB+1WGc6Yg3IioO/koGb5DMLKvvl9B6i
	HNyRpIdx/drdkqE4b6svoRhuo2H6zCsSGttRItOWzEPI5XB3to1ZKnxj+8eaMlkVnfH1CBpDVZk
	7zYEjR5nDoTsmq4poI1Pb5oIIvDaFxnhV8siRNXq4pN5mJJ5fOKSSju5eEBILGBdYcNmQ1tqvG0
	XINfs=
X-Received: by 2002:a05:7300:1897:b0:30b:eb75:8a5a with SMTP id 5a478bee46e88-30bf09a16a4mr837075eec.25.1781746239908;
        Wed, 17 Jun 2026 18:30:39 -0700 (PDT)
X-Received: by 2002:a05:7300:1897:b0:30b:eb75:8a5a with SMTP id 5a478bee46e88-30bf09a16a4mr837056eec.25.1781746239369;
        Wed, 17 Jun 2026 18:30:39 -0700 (PDT)
Received: from [192.168.1.31] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm26643423eec.4.2026.06.17.18.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 18:30:38 -0700 (PDT)
Message-ID: <e46348dc-a95e-496e-8b49-2838b25bf9f8@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:30:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Daniel Hodges <git@danielhodges.dev>, linux-wireless@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
 <d5429e89-0eb8-46bd-b143-95fc5adefa2d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d5429e89-0eb8-46bd-b143-95fc5adefa2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KNHwY9jeqMW2WKxxY7ax-SzvErGwEwbT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDAxMSBTYWx0ZWRfX0zt0crRkprgA
 ChXoGuyYclaRRSzsX21Zc59dXzHtBA+KIOWEnBG7W+CCKKRKXTfr9rAESd7IZlrmbqML2E2iXJi
 Zfgmqgv9V7FyPxpGvC28a2yN4A7S1JE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDAxMSBTYWx0ZWRfX05YOmVmimn6G
 iQCSs/qkWuU34qy78k904lTsQa8pM4WQo7/bkE4xOUo27QpNsVZzGZ76h5FSOVeNqgdiBSmk/X/
 SXP0U07Rt/cUR2A1U12C4jfLBV9ggPqkjc7NoJkHkxhJ/USuNls6x9fMh19VaWCXU0t7p9nGl1h
 YV5SZEwD97nx2h9jl6p2gGN2zdIHFt7PLLv/Uqx4pSoy2kzxJ0l7jRVBCenLHNpxzAmWSQ5FRcc
 ymabiT8BCRjQGH0Vg1SrjWIYdsX0XLHV/1IYaPTiH0Jec/+yqvwdcbq83apl1ySRLZAuD4kP5ZV
 Z6P0UxGiBz3R9rkMmXPh5fbPy6EX59PYOENqDyGWQpOO8jlggroGxA8ncN44T4OxNr9H1ERbto6
 WEkeXfpUL8HesNxEE4tdNeWvLOCT9608C6YnFBbgIBt57d5VvxPA/tw5p3zD/eIZ59d5FIMUq3F
 o1VFKevGbOX9e1nsubw==
X-Authority-Analysis: v=2.4 cv=PMw/P/qC c=1 sm=1 tr=0 ts=6a334a41 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=ssj8URQz7FPryPeC8vIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: KNHwY9jeqMW2WKxxY7ax-SzvErGwEwbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180011

On 6/17/2026 6:26 PM, Jeff Johnson wrote:
> On 2/6/2026 10:52 AM, Daniel Hodges wrote:
>> The aggr_reset_state() function uses timer_delete() (non-synchronous)
>> for the aggregation timer before proceeding to delete TID state and
>> before the structure is freed by callers like aggr_module_destroy().
>>
>> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
>> is called, the callback will continue to access aggr_conn fields like
>> rx_tid[] and stat[] which may be freed immediately after by
>> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
>>
>> Additionally, the timer callback can re-arm itself via mod_timer() while
>> aggr_reset_state() is running, creating a more complex race condition.
>>
>> Use timer_delete_sync() instead to ensure any running timer callback
>> has completed before returning.
>>
>> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>> ---
>>  drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
>> index c3b06b515c4f..25ff5dec221c 100644
>> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
>> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
>> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>>  		return;
>>  
>>  	if (aggr_conn->timer_scheduled) {
>> -		timer_delete(&aggr_conn->timer);
>> +		timer_delete_sync(&aggr_conn->timer);
> 
> My review agent claims this still doesn't fix the UAF since aggr_timeout() can
> call mod_timer() to rearm itself and hence the timer can fire again.
> Instead it suggests timer_shutdown_sync() should be used since that prevents
> any rearm from taking effect.
> 
> But I'm not familiar with this driver so I don't know if there are reasons to
> not use timer_shutdown_sync(), i.e. if the timer will be reused again then
> timer_setup() will need to be called again.

Interesting enough, another iteration of the same agent says:
**The fix is correct.** `timer_delete_sync()` loops until the timer is both
not-running and not-pending — it handles the re-arm case because after the
callback calls `mod_timer()`, the sync loop picks that up and cancels it.

Gotta love our new AI-driven workflows...

/jeff
