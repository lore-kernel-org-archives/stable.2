Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4383A5E90
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529073; cv=none; b=PFW6MG1rEsTW29pE005TyEOsrRL3+lBm3ygx6wF/EOzicRHBVWLy1Aa6fvEIvYMkz2p4mT5rDKfuQCWafoy1gxACjdxRHfO+ESx7gwhCkpT8boyFYL3zkdwDLSX8DKrrLg9tqV7kIheDPTIiQAyT1BDmXMKQk2+bT+S2vCVRUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529073; c=relaxed/simple;
	bh=5ERdhktJIoJIo9p96wQTjyWFqT0l4v/JPHtR8HbIza0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhczgcHnXkQqN/EB7/Nm9aKqYtFCn8GrjcMfhDfdd++MH1gUrp61eVRf9pcPGD/TLiwAPfyiGNmDXOm9+UQ+hjgRcFr53398GW4YZhEXvv8YHXStzAOMktFQp5tfgvUQSbijT/7cjbjczIodYuQ6rEyJ2/+/aK2gIPfxNMDJhgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RS5fKhv4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S1JnHUi0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RS5fKhv4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S1JnHUi0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HFpI594036
	for <stable@vger.kernel.org>; Fri, 9 Oct 2026 06:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/i8NmI7i8KDIOyDpCxYcf9EtRiTu5EYcsw8myqPflEg=; b=RS5fKhv4VL+Bwy9b
	ZZg3psc2JiyKmybpRSeKfUzHjhdhSEIytJh6dn9LAI9W0FyL+Olr3mSFZquqtgoI
	HNs9a++2Da1inLUV/6Hvi+zP7jDRrsrbEp8KisUDYqgwDY+SQtmhb3nsPn3Yq2Bt
	9fXzxwECcYq1yWt4nOAR9VYc0LpYaqn3Y7CAxJv4K6x1xPH0LQ5kFYZwnuf6OIBX
	lDiVSvXy6/fhuQNt29BvWE4OU2wD8qUEVPg/jjop1lOzm3lHs72NbPBHMwGfrN6S
	Yy6Ifqi2KtmJ4xLO+hVNGXJXczJkKur9eCIioHRYEO1wxX/NYxJw55Br0HEQZ81M
	4IBuTg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6baj3hyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Oct 2026 06:57:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88d2d26a8d5so1416733b3a.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791529071; x=1792133871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/i8NmI7i8KDIOyDpCxYcf9EtRiTu5EYcsw8myqPflEg=;
        b=S1JnHUi0BvHG/MD5gNpfSk+9F5YGxOsQeQd938lBGxgeDle98ZuD4U1p7ohPIKSpAi
         a31Yi2KzI7j1VuVF0CHGvGI5oD7S52/QOCNg9YpEFkSztsOBj66K/44bzlYPPhqGiZKA
         NlhKukG/HkulVdWgZGs1j0bl3VJse2mcO2Jbpwl6Sj5bFDXnazMXb8qO4suMNsPPQuaB
         hu9Xgr2FfAV4kMwpptMBvAY15ZdAdRpSEWtAiDQ72LovLJptVH+LMSvTEh0iSvJDyEqp
         Hpi+r/Uh4yXTNmo94zh0HqBKpl45wmC4hK8PmYktFBmFjXofO17TrjptNOdiN7MkjtOq
         NtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791529071; x=1792133871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/i8NmI7i8KDIOyDpCxYcf9EtRiTu5EYcsw8myqPflEg=;
        b=KwA77efK8hoMozM9gJT5XDuMuRkeTjl5vwBTGc/wyDEyr8EYJXZ8OPsim+XQ8rrfBB
         I5/2mzEh5i6+VqA9G86SV67FypTD1Hgedh0vmKYZyxs9Jg01ibX3Bovww6qg3lsPwo+u
         avAFvcK6ExA9u+3tjKIHMlbTszSEESHixH3hLKx4mLxe+pivNYglfthDMUxKOFEkxctw
         5daDg9REDhJ9+IbAH6UpPwqUYaGcN9isVEJHtGYWPapZf/i73Is8c8QHhYOO7q6cKZmG
         FM7FAJ0OQcys6JMHfpOoQ6711iXgU1fz/DOfV7II5ZFhL9ZVbgaLJ+pWXqCQy4o/6Sy9
         8jcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeOvJznWEOIm3spCohftwodBqp5GrTVVRiigcg58MT7dxfGy4CL8f3XVg+6ExKYjlH7sNYC44=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2fJz9mmHSFej2Db21ddeBVgUhuv+SmdgXkpJAAx5WJnMK+H/C
	Y4rsSfiRGk+3vQwGnO9OqlQYMFKOiaZ71Rm7dkV2xXQ9/ZSdy+EjrRoddz+E9CexpEysW/fSxWm
	NEstwdsBp1Wf5Zkht0weDu02oKTVSsr5Pe1Cfav6IsLy/NDgTnBqRbIof+EE=
X-Gm-Gg: AYBFou3lbTRksv4IoQJ2BgVpk3xhhrznY9xYo+unMVQ0pNhFoFfwPQ/qKfqcx8/iwUk
	Pb5ryhRu2N1QAKUKr6fAkzZjSgCsLHCBBmeByVAX8gw9TAKkP97LVNZFwXlLysZfaBXKfjelRnm
	WyCcmMSA7nljPROobEdp98gUCB36dSj4aGZJTmAs/MMpJ0DxdJx8uWU91AUf15L5xK68xycW9a6
	rGDoXT3nAQiFahvHFtUW0913LlyN7QXdkG9mYgBGG0CKptEdKYIzGS6NEMuosKk0Y3EXGMWEH4I
	SGOA3VTBVdHw/9lr1ahoyrtLaM0VxKRmUmpbNzUtEzXVgDNHU8ICFc4xxCeQdCkwNa5kSgvDYo4
	xFl6CjhyoFD5dwIhF2Vf7MTuq74vSv14h+6/1cM4gHy7SG18=
X-Received: by 2002:a05:6a00:2b98:b0:881:66c:53e3 with SMTP id d2e1a72fcca58-896a3a512afmr968569b3a.32.1791529070821;
        Thu, 08 Oct 2026 23:57:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:2b98:b0:881:66c:53e3 with SMTP id d2e1a72fcca58-896a3a512afmr968556b3a.32.1791529069467;
        Thu, 08 Oct 2026 23:57:49 -0700 (PDT)
Received: from [10.152.209.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c310737esm514809b3a.10.2026.10.08.23.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 23:57:49 -0700 (PDT)
Message-ID: <e6213779-bed7-4484-a230-ff3508e8ec65@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:27:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: initialize CFR locks before capability
 checks
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20261009060326.1162818-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20261009060326.1162818-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX+eRcQRVYxrSB
 pxstsXALpIVMRLqAM4o9J0DQvR1hS+3qSKnbjp7s2MuZoGSFPRA0t/lJDIfpleRKkOaeUA0M/Bf
 qJ6u2HAH8u5COSG41PUMilTMTDtH3SvosNWZFtp+YwO3NfZucciIWyuejbGHCmn3hhNnKfBbUrw
 ARoMkM6w01hcIGWPF5l3Xk/UacTNWajmgjPJUukCq5yC4Oct6vA5iS5R8pAesaAOmA0Tx4E3bd1
 qGSvKChe5uVNQZu2aRqHNwiV4Omqoe5Mip6piwqYH7M5OKBhG0HkmtCCW1nlfAnZ9WQxDOtZj3M
 kBDtWAoxXAujhv5cRb608fUkyMAlYzfdphG8PAbz92S73A68QMhrounLPbpkjsPx+/xgxWSvowf
 SKIimdpbCCxdKl5TxsUD5XOjwt/3fr+x8vYBRSRVN4A+ChXOt31U/jc/di+2CnVZ5fsnTghtuvW
 kSJWt6rYVVE+lVtr6Gg==
X-Proofpoint-GUID: xlNmTyFvUvaV3y7ysEj_i0UuVcT5XttH
X-Authority-Analysis: v=2.4 cv=H/dOUOYi c=1 sm=1 tr=0 ts=6ac8906f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=ZH9U8Pc_akMW9uxFS8YA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: xlNmTyFvUvaV3y7ysEj_i0UuVcT5XttH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX9OcTIIADPkPv
 d6sMuGu8voZ4p8ya8//xyv4KYsTnHC2rGF1vRyYhq0jna5Gf1LQ1TYBOObqW1IB+B7VKzbQfbq8
 NvurcREo/QckeNxsbLIJIcUdN4sdm8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090027



On 10/9/2026 11:33 AM, Runyu Xiao wrote:
> ath11k_cfr_init() returns before initializing cfr->lock when CFR
> capability is absent.  However, station removal still calls
> ath11k_cfr_decrement_peer_count(), which unconditionally takes this
> lock.  This leaves a production path using an uninitialized spinlock.
> 
> Initialize cfr->lock for every radio before the capability check.  Keep
> the CFR ring and lookup-table lock initialization conditional, since
> those objects are only used after CFR capability setup.
> 
> Fixes: 9b2e3b4ebec7 ("wifi: ath11k: Add initialization and deinitialization sequence for CFR module")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/net/wireless/ath/ath11k/cfr.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
> index a91f25fb6..0708ca28b 100644
> --- a/drivers/net/wireless/ath/ath11k/cfr.c
> +++ b/drivers/net/wireless/ath/ath11k/cfr.c
> @@ -956,6 +956,9 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>   	struct ath11k *ar;
>   	int i, ret;
>   
> +	for (i = 0; i < ab->num_radios; i++)
> +		spin_lock_init(&ab->pdevs[i].ar->cfr.lock);
> +
>   	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
>   	    !ab->hw_params.cfr_support)
>   		return 0;
> @@ -971,7 +974,6 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>   
>   		idr_init(&cfr->rx_ring.bufs_idr);
>   		spin_lock_init(&cfr->rx_ring.idr_lock);
> -		spin_lock_init(&cfr->lock);
>   		spin_lock_init(&cfr->lut_lock);
>   
>   		num_lut_entries = min_t(u32, CFR_MAX_LUT_ENTRIES, db_cap.min_elem);


NAK. This can never happen.
