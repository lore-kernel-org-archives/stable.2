Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1903446BE
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196447; cv=none; b=iTbjSKxEcSKuWLuMABc+xPHm5c8IwHcGZi9+tkAnxkbRkryJDrZBRDyBtzrhSDwaT1Skpcu9oOKpSVk2UyNzyQrKKLG7nLP3gi1Uf625K/zekt38Rk2yqE9P9X5z7oHAvjaiOLDQ47g1GIwoFYguevvAe7doOzYLIzOxS4YIZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196447; c=relaxed/simple;
	bh=c41GS6byMdgzPlJMdkS6ltuAmcNP5Cpu8h+GhWoORiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqI7cAOx3CNVWZk4o/5NvgjtEogNfjAdAlDHlSkKN8WlXmkkO5eqGp2ioK1znUHXO19XwOM/ZvlR5aiKzZCO13pZfc3n5JNF6miOTNchz3n4t0KsCqh8B41jzi6Mi3Ssu6XfXF8xiKzQSxT1LrVkb3B5/8jnC9sEZUUu5jT3OO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnEWeU+R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XQqOz4kU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnEWeU+R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XQqOz4kU"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0l1942869361
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RWx0gdwex8o21W9NKWEoQBE03/Z8wuoolfwNIjEcNC0=; b=QnEWeU+RNdBmYzjb
	yjV8ezRCkvGMiRrlnzjNRtMMfI59QNSM6VfY6YoWCZoCAnkE300qqgyCfb+3TrqP
	R1sx+1cxftHUSZivgVKmMbcbWwxtZwyTS03Ec3be4PbC9ajmG9okmlbFSapPCdPm
	gUXH2NeAiB13VH7kTsnDQemmBCEk6do5GUc03K7g17xiqPrt76kyeaVdLVtMm0/T
	Zo/ZikfMwBhRNYhS+SZe19D+ETU+NoIKamuZn7Xk9hwLzDjKVKhM6hfAgCTXfNRr
	0C0Zf4GX98CCPKFkbnWbXnJD4W9pxMyFGdBlku0Ly1Y78j2qaWg5d3uHN2k1k44l
	KlGghA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmu1jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:34:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37dc9b82e55so859293a91.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782196444; x=1782801244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWx0gdwex8o21W9NKWEoQBE03/Z8wuoolfwNIjEcNC0=;
        b=XQqOz4kUF18Uv9xzl5Ynp3QuF/lx3bdH8lgRPrhKyg2lcNTzELjKf5h949Gy5gpG6P
         dfuWVicvDVzRjJvTGFLA4gBi6uiPl6sIAex8RpwJA0V+uDanQrqm9RAg7WdlZz8o+lGO
         BFZCh4V29wvENGDaTZUs3PFFceGEB5fmAT6411zzPI8SNa8C4vSqV/ptCj6Kovi9K8NV
         KuzsJMnmThwjXsZL9zzZln9A7odr9dgU/4J7VkMNHGvE3xNf4OzQUDHtXZpYbfbW9S2g
         r/K0RTUSLNSD+3BHU97KanboGyQbOM7WuAcPUqPbywxUxFcnxyQw39menS1GfSklx7py
         2puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196444; x=1782801244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWx0gdwex8o21W9NKWEoQBE03/Z8wuoolfwNIjEcNC0=;
        b=o+sthq51baqr8hKLIJ+Zn+pLH/ZEJbMslHoxPWhnVAcpVvHbTBiCXukBV9UOc0fnqV
         P0Kupwp6/pd2+Jdep4E+t+xVnrpiCfKH1jyy3oeH3Ip0Zs+WUc7s3p0aU6JhJZ39JwT6
         h8pjDn3EPyhnd/bxVCH8FI6/C2gw3Z8a3dvwAYdPjjg7g0GT/v2FEMQiGpUP2cfXgMSt
         /8zhUVxcEW5mxyWE635MY6yVPEW8hS9KbrncddKrY8btK4VftI8pPqvoeSoXfWYYdMP9
         PiMUEqZmsARx085zAgorok1/CpV4liWqXtrQQxoljjOwFLcvfrDAWI0cXGL6XjHRvavr
         P2bw==
X-Forwarded-Encrypted: i=1; AHgh+RqId7DTOG3Dh1/5emziHWNoJXJig0R9iTP411QFNOAqCuLflDWPpzW4X1yaY49BlsDMZiia7b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkeeDPJ2uETwLryA2cnXBneSMFC9S0Ht1rTaisurRc59tjYX8
	oxvTYzeNA73YE1OZb4yZlG4gpWynsOwiMAJwpcyH1bwT1GxB2P6esute5exvkGpykOuAsBMHzCE
	Nns83e0MllAuIbPE1cmk33pH7AXL3RnrVA8OFNOMkdkHMxzX/f23XTWaWtkk=
X-Gm-Gg: AfdE7ckQlNslKNHZ4XQkVI6qhwWbnSQXYt6t3UWNtloKtOjHCXBCMl/1d5LM1GlD4P+
	fXiWe3v5yFzN787FUiyAGQoylVLhezF/0zIDtbIZLRSS+7oIQQaLzkBVFg3sa7fDbnOH7Z253y1
	73Z7TxUfmhsi5d1tBvj03PG/1na5lN2DosYHnTsS0PGmEUSPysr0q5loJ91SR26Cp823yP+MrhD
	irdi8U3KLLjhr2P0nhhHblayN5Y3BUqOBBWFn3YiDT9BzQI2VrW8UH9vH7GuXdnKQJqJSGQjb2C
	i6RqU8+jTvJTqCRgMH7YY2P2nvrZI2LkFkScpzT0blYg/mAh0Knl9Kl25Zt1/VOvRrj5uQATI3y
	vK4W9MffNb3lx9DJqoK8O6XfOi8FviMy40hRctwKVgrFy+fjEILAQBrzAAMqH
X-Received: by 2002:a17:90b:1f91:b0:37c:83ec:1641 with SMTP id 98e67ed59e1d1-37d4d71d7d0mr13004092a91.5.1782196444318;
        Mon, 22 Jun 2026 23:34:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1f91:b0:37c:83ec:1641 with SMTP id 98e67ed59e1d1-37d4d71d7d0mr13004063a91.5.1782196443843;
        Mon, 22 Jun 2026 23:34:03 -0700 (PDT)
Received: from [10.137.71.130] ([106.198.36.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15df815csm12594916a91.15.2026.06.22.23.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:34:03 -0700 (PDT)
Message-ID: <cf96c4e1-cc42-4f2d-96f5-f5d6aadf9af0@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:03:58 +0530
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
        jouni@qca.qualcomm.com, kvalo@qca.qualcomm.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260206185207.30098-1-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX3hCMHW6gK1pU
 9aqSDensuth8jQ3EopwnbGRYmeTiznvhiNbhNWqUjj84/MRaAtYQwzcvt7P0AIciO0sTLORwaAC
 k/VxgItiil9LRGqxL2WLQ4FHGB22CzM=
X-Proofpoint-GUID: bUsCLMG81rWCuAGMOBnNm46PptqD-jAC
X-Proofpoint-ORIG-GUID: bUsCLMG81rWCuAGMOBnNm46PptqD-jAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX3GdqTSWnerVQ
 GCpCZ4YbJzWyrQSXhuqBl82cMLrp2yNnX5LS6NudtJ+qWt/ZT8biVa76GW83pgx+oaPBeINlQsk
 UIEUrnaaHkY/VruoX+KSiGnQ0ejeL9KVGWnsmicHCbj+AA4FvmU2zsUoC2ORVdYAHrJh+FU7v+C
 eqpbM6LNdNsqEsUt8CIqdvfFFRcBjfPSagJqk+o/+CkEdHSSVELLyHMHpuaHp1MGFbLdlZWteoY
 A7MUpw8w0BVpeTSCsEgncmlg3uLPPxObdsjHuZIiljwR6ettMa3WDxjfFNSgJkjaTQRw1ZyzDBK
 R3h4YSN82EQs1kxPJu5971BcwSxNY06LaFZerofbzxJWMgTT5EhCbhkzD9LddHLU8JyH3WYT9f5
 z6koyGTNJveekENQemo3a5q68+1zAFZlzr2em/deef/poZAcrByN/MWjx28LeqDm8S1+IgBtfdS
 M5m/meRP3gGuurErZpQ==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a3a28dd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6/2MXK9rXRWb21GBy9lArw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yrwDRl_2H5AUk312M7UA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1011 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230051



On 2/7/2026 12:22 AM, Daniel Hodges wrote:
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
>   drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
> index c3b06b515c4f..25ff5dec221c 100644
> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>   		return;
>   
>   	if (aggr_conn->timer_scheduled) {
> -		timer_delete(&aggr_conn->timer);
> +		timer_delete_sync(&aggr_conn->timer);
>   		aggr_conn->timer_scheduled = false;
>   	}
>   

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
