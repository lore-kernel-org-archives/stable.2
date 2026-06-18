Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0128CF5F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745976; cv=none; b=CubWfktT3lQDuQWQ+WGdMC1zE6fry0ww7SXesUQuM0kIH/IsjINiv22t5JpMGgVv7G+wNbinCo0E27NbmYLKPPo3UEFS6snRUQS3aJS1CI0/yyaS9eXPu+XSiYrPWbe6Zn5OvatTU0c3yXtOf1jFBAeDA9Og+p1+xCG19GeCk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745976; c=relaxed/simple;
	bh=po1VNmaGNeX8hpKAsE+zWftJGH3ZFExeT2TRvt4SRNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbdaF/LIvUGcEjZe93h4nNDBQvQvpgarQ1FXz05hNgFINB5Hm+3hH8OvRCbZK99po5a/smWq8szmYKMSlT7VdYjiKCi6xzv3SlisvQWnItICGxPuKGdkStzUBlAbAj3Xd8Ocp287zRODZGFYDw/DMiHolq2qm+KZZ216XIRFDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NVh/m3B5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kWTcrxxd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NVh/m3B5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kWTcrxxd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HI18MM3577378
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8XKu0UYunFj/QEVwO21dV2lkrJPY7vJQuRxaCwuzOeE=; b=NVh/m3B5qSwJXP+5
	wGkAniDjt0DrcHTtUnpNa4ifFphSmOUjq936UBsgHuvd3K7YLHIOi8IkI+O6r5NO
	kAxXoBrkngon19Wj5+TGYTcDTw2dwgXiXx+AWwEWf5wKGNN1fv+284U2gpD7qEIt
	LmqibM+qINxSlRQljFlSjK5AAwYPfXYaOpSguCF+JrkK25FHMvs7UnTWzcIEDJQc
	SILFNbw3wE79CX6inKzaETsdTyz/8mTEMbaa3Tfba8mMSvcQBhsgQR3t44P8Qk2h
	h+3dKpkvYTXr2IpkK39XwxFY5dq9wEqpZRHhHbhL1iS0ue/XePfstp276Skypjoz
	rZ1Yyw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7hfha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:26:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ba395b047so1695885eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781745973; x=1782350773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XKu0UYunFj/QEVwO21dV2lkrJPY7vJQuRxaCwuzOeE=;
        b=kWTcrxxdHe+hGCk9mZ0LVmvCpkz3E6a9AMedpsyu2ICni3Ap6NoBbxzImjMPJiIcas
         V+gBPu8e44GzLXev5nExrzkfAYLNGxG7lDtJl8SgCgbdfZk0suzpXNfDCbi+gdmmwDvq
         ejYoeTQwytiELV1U32P8W74wyhPkJ3QnsgIXxogl03ai4O6DzMmGyJabeSVRo8BQLO+E
         UDU53GW8ASWZZ9leHpkp11FCNBZdK1BlWm4EsEoQIfnU8xbhnic7uy9+iHV4Fev4JjnO
         dXeBYoVjPzK0wKFTO+/fuXq3TO5kLM+OjjC0VIC0AFY1YrwbrZW0a90HM67zWVQ6XMlx
         6TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781745973; x=1782350773;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XKu0UYunFj/QEVwO21dV2lkrJPY7vJQuRxaCwuzOeE=;
        b=M8svhFaepM4ZNFXbVi1ilDpIFpyhkEXYx/IIQ1R01OWIoaiJ7TsN246T010lZFVdv+
         gGs/3XosI2CQ5eMv0ey69IrIJwerC/zFcdA5xaR1qZ4R6mm3lY1bcskQnxGvbiMkhLJr
         +sqfAZNJE0Dt/uibo/6wqCyuqoNGMt+5LcelrxsMxy+MCdGR7cj3d4pju9fL02mesm8S
         znrI/SwiSqqO07E1eN+5xqdQN6HvMcfn6VPRORCYt3Y9MhFwdACJeDlbC3LisR02iVgr
         A0LqAFqSwabtOYzv6gyMiUYeEl8VR1gsuHi1CpLVmL53RBFBzTqRCUYceL3/dYsQBETa
         XlAA==
X-Forwarded-Encrypted: i=1; AFNElJ9GplismRtZZLMWmZejFAeS4uUWye7f0hldartpBFyaedTF3iX0ARtGP09PvXHN13jWXEof+28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMk4HBMndhzr977ICiu/i6AAO8OxKxvTWYrYVdWT/advRQXHb
	Mv6jkYVsrBSoSTSvbyRWa6CTV74y+ZsjSpPIVh0NNX1bv/taY+nw6bX74QrPBjtwR0Y12eSlxAm
	lB47ziNoOZuZkjY9+KRnFLZEl6xiF9Mn0PLxUmaL6Rdys2ai0SUiqPOTYW1pfM9AP1wQ=
X-Gm-Gg: AfdE7clzLg4RUA46wIMSHZpSmMBTSjLg3dSjsy6wSl+g/EpJSFrhvyP0HQ07j1797uB
	sRothv9G+Jre3PCSz3X+0KvWNcKtJjK39pbqWiWy4G64iIwBcqwT7AP3og1D2lrzjUQW3W8EvfH
	7MSCKX3Dsy050Q4DeqTvzvALzIfC2i33rHilrUyj0A9b75Gqexibq8cLJBJGVlJUz0WB6CfwOSC
	mqo7OyQukljfvGsz4Ev3EKQIjVYJWb8LOOxIKE+ODm4O+qBqKc7zWu3fO9iGXTVTpLGojCGK3y8
	Uj2kOr+5mjFnMTr8McSm5yxEwqsNdou9AU1217JCF097tdW8K3wW+V5jfNSFpWayTNPMrY4yreA
	B3+KmqgUCKnjaEpZP+PuV8cJMlrH8Kn69t+7SHfx4jZ84JCVSSCR+OVbeIGi1RdatNUtGdI2Sp/
	xiJXk=
X-Received: by 2002:a05:7300:df0b:b0:2ed:e15:c927 with SMTP id 5a478bee46e88-30bf0a45b07mr1072459eec.35.1781745972827;
        Wed, 17 Jun 2026 18:26:12 -0700 (PDT)
X-Received: by 2002:a05:7300:df0b:b0:2ed:e15:c927 with SMTP id 5a478bee46e88-30bf0a45b07mr1072429eec.35.1781745972223;
        Wed, 17 Jun 2026 18:26:12 -0700 (PDT)
Received: from [192.168.1.31] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bd8ab412fsm3953303eec.31.2026.06.17.18.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 18:26:11 -0700 (PDT)
Message-ID: <d5429e89-0eb8-46bd-b143-95fc5adefa2d@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:26:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
To: Daniel Hodges <git@danielhodges.dev>, linux-wireless@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260206185207.30098-1-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDAxMCBTYWx0ZWRfX5ECsAa+WNS2K
 30AVmyTIobW7oyGBbQGp29OTmMZ4DBL1hgcSkthE9laLPYMRUq4LDZAoFf9GPrDtVOID8t7HN8P
 4qsSRdRwbDFacqsjIoZMlqpRPVohc1bffpp/cxuPjB9LBKTpqXqIovoTH00Ys4m8Hb3gKSYGpk1
 L+8squnzpAtnmMUBmHD3mA4hvvH++UxRA3v5f7pghWkX/wrFsdc22MfjEnhm03SwyCxrbWR0pEw
 XzeH89i6JgqpNRqvxP5fRbITvFSZ+Ln18hB4aLVOlKYwgBw7jxSV8miB9xv5xZoi3wvu504Xx/8
 KxkGvSlv1Ci4cY9tf0yAmlWwf4CqDm7yl4JzkT2PVC/YvZKzNuE4flG0xCUCkTn+YU05kb8mr58
 cDrjU/eyJkeZj7Y5Qfwhjtnw9IDmj6A8V9cEc1MsCOmp6OavPPAgUvgnWQGaNa68jgLZqnfwLPu
 XsBjrjVn/mZRGMYdmrQ==
X-Proofpoint-GUID: AXFpd6BHx_X-xIhr2bH99ug1hFK23NCr
X-Proofpoint-ORIG-GUID: AXFpd6BHx_X-xIhr2bH99ug1hFK23NCr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDAxMCBTYWx0ZWRfX/J5XuknevaGm
 7zlKUyaX2paHqPicayX43J8lLQ82BE7XiN6eAKDxIoCW0luOaZGXfLD8EqE0sxv4dbz/gsmBDaw
 qSgg/GY56j1OeyzdsOVp+0ZVgzc7Tf0=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a334935 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=yrwDRl_2H5AUk312M7UA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180010

On 2/6/2026 10:52 AM, Daniel Hodges wrote:
> The aggr_reset_state() function uses timer_delete() (non-synchronous)
> for the aggregation timer before proceeding to delete TID state and
> before the structure is freed by callers like aggr_module_destroy().
> 
> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
> is called, the callback will continue to access aggr_conn fields like
> rx_tid[] and stat[] which may be freed immediately after by
> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
> 
> Additionally, the timer callback can re-arm itself via mod_timer() while
> aggr_reset_state() is running, creating a more complex race condition.
> 
> Use timer_delete_sync() instead to ensure any running timer callback
> has completed before returning.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
> index c3b06b515c4f..25ff5dec221c 100644
> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>  		return;
>  
>  	if (aggr_conn->timer_scheduled) {
> -		timer_delete(&aggr_conn->timer);
> +		timer_delete_sync(&aggr_conn->timer);

My review agent claims this still doesn't fix the UAF since aggr_timeout() can
call mod_timer() to rearm itself and hence the timer can fire again.
Instead it suggests timer_shutdown_sync() should be used since that prevents
any rearm from taking effect.

But I'm not familiar with this driver so I don't know if there are reasons to
not use timer_shutdown_sync(), i.e. if the timer will be reused again then
timer_setup() will need to be called again.

>  		aggr_conn->timer_scheduled = false;
>  	}
>  

