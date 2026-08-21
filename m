Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82DF44C51A
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305252; cv=none; b=NCFDHGOmalwrdv8+dGjUA3Z6MN1AhlcrpoRoNWBOMW7OGYdKnu8azFMZSRyzIzZWtH+IteIAoisWI6bUmqrHRHvbz0MO54rA3Gpf7vI/JzuK3g8sQD5My33DV/MmnawEuWP77fPl2pm3vXL9NtRWmmpA67ldv8QC1skCi/YpnBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305252; c=relaxed/simple;
	bh=rje9kgYuMA1aq3fzUJvJvQXzw+bsrsWwQiF7njuvW4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGh7GP8lFhwnJTZ0xAS7BIXyzf2NzIDpmudtkpqa4zJSuScM7mmPxJPr7M6qxVFTx8UGx/rKygImslfq6TQgdxDKGl5pIaPNMR/WPPUAImWxHs7IGG4OPxEmFNzatmTMxYa1iPeeRUezWfc54y7SAW4QhU/16BX4eWaME8iQVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SP+5iXG4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KOLO0zc7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SP+5iXG4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KOLO0zc7"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9MAbo2006587
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 09:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8XxJnaSrtt5CjTwOdeQ9vMPi4AA9i6v5V+T6kkVelS4=; b=SP+5iXG4hAssiTAz
	PHDJN/6NeDUx6Dk2ZAH4KObRyveAIuauE8XGN0VItQx/1J8j+C6HhhJ3WD14oNlF
	4qA0Aqwk/Z9cnoFtixe1Vd/J2QaovktCNrSQvWw6aRvTz6Tp8FXKgHyadtJH1meU
	H2I1M1AJlrlSMrWIqxptL/UWlDCJukTCyI9mt+k23jHOek/qRxvhqWCHI62WfxxX
	EdPpcFHmQgGQFb/jPQ/QmQ9x6c+U7/Iy9wpYW7dvI7TQsjrsA9rZH/3i/pM37068
	3vWTF8JdGbTdpXdBP1sfRa5/rzGp2ivtC79Kj/WWarFsftwL7g7lwl7UcW9HUeoY
	cfcp/g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gddgxha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 09:40:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1173058a91.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787305240; x=1787910040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8XxJnaSrtt5CjTwOdeQ9vMPi4AA9i6v5V+T6kkVelS4=;
        b=KOLO0zc7d26viJ+TNTkpWFbOuDoB+08dAMtToKJcO/Xfkhal4587cqYRnXAQvXVHY7
         Ry1jV+s2AOtTGAD8eofwrwUXrWrkLPQWa9NdqD4KHA92rY+1FP6HV8t3EJnOy5pkuk0m
         /1qdUCL6bPUT2cUoBaSwJGBT2AHZgAOq6boDonwQRwzrSEh66f6yKQ3ZV8Y1Qzvc7nAR
         IH6/ndY5ALghypAYIAB2wLhyZEbEfCOgAMcnZfYms/wTcl8M8j9jA7ybY7cJtV0iwpKn
         rx77d4ziHVcQuEXPPlqXU0ZyB1WQzpoSu7ao+iMucgtD5RNiwQin7YW4Ixi92u6S7Orb
         b7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305240; x=1787910040;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XxJnaSrtt5CjTwOdeQ9vMPi4AA9i6v5V+T6kkVelS4=;
        b=I5zCYywoSLey5RWPDtJocn0TA9+Ftln3wCEIBnzDHei/xctMh+7vDIwxsIa+DVGsD8
         RVnViUlBhqiNY6DERmMkqeh/u9KwuU2yTJepCQ1hGii+vYK9iVnlPkC8+TVjcN2mN0Fn
         mqQ8nZa5xbwAnC9aOA4lOfI4b7R4/Lo8+4jXkfHIcKrBelO06RkqghAzcL9Eq1/+wTIO
         WoQ2OFg4RSCu9Pr4zu0v4Ltd26w03P4w4KFN7x3SdntftjX9hGeLjorQ64M7i6DTXwzc
         r7BfKPUvvqeqtbHhB+NnChQpd4gduDmpa9a34WWRugEzM47Q9S76iWeasYIvwUnJChHD
         TcOw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5ttjkb+jTy7kSFjb2cJBuE9ti019QuNZdkTAv41V8yZoxWGPVc9vt5GRRxfaZv+h6oLR/iyY=@vger.kernel.org
X-Gm-Message-State: AFuF++mB4KqyoeVajz4L4x+QuBuaHcec8Ccw4Lqv7/Arsze44Lpv+jbg
	0leJOjdLUA1lPwaPdl8RgB3PV4AX6YgSWOodH/gT0HwEeEZo+sCnFamuOKbLhT19YVbD742c9f1
	JIKB02OMFoKb0Ixdrv7oyn3TiLU3YsN3CvX4dTB/bKQtJabYn2FMpNnqpep0=
X-Gm-Gg: AR+sD13e1EXefVvnOWBcpVtaA+GI8u5GTJlgkspocHUtYMG6pnvSuSh4gAgF38v5Ght
	gKbVTL1nPIvx7DRZQAW66Rlql5eB7KSPEz8IxDelCc9bmsl1bc9/Y78HkzgBGtnjvfEuzrqD/n/
	D1dYCSAqR49xGsT4GeJazm4+xMfQWZ50f2Lqb8jQkjK8QUrE8G9XhpoIZaxSEHqFLJAK6ZNOL+A
	PB/mtVxbHN6Tf2NgKJk29Y4gWG8PCJXQiqhejvVuSUGN9FrEgTFBOI9sot+BADB5BWQmtqw1TsJ
	pGvaCqB+avwHFsukmiHKi2t2ZmZ0Z+6zDS9oFTOeOUBmIKXOiBB7gIuM+lCEnvJCw9gHGHusUb1
	xKuK9FqCximvDCAS1/hY4TydB2xOSbT7mv8uXMOAyFmHB/ZXU3VH7ZNzsF2OV1Fr5eNLa5Fs=
X-Received: by 2002:a17:90a:c88b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-395c2f4b17emr10746517a91.0.1787305239775;
        Fri, 21 Aug 2026 02:40:39 -0700 (PDT)
X-Received: by 2002:a17:90a:c88b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-395c2f4b17emr10746426a91.0.1787305239331;
        Fri, 21 Aug 2026 02:40:39 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c48ffd70sm2407392a91.10.2026.08.21.02.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 02:40:38 -0700 (PDT)
Message-ID: <0eebafb4-951d-4360-b514-22ed24078611@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 17:40:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: airoha: fix probe failure with correct error
 check
To: Christian Marangi <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260821084541.139703-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260821084541.139703-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3MSBTYWx0ZWRfX/2Ou/7Ix8WP/
 uj35Wvf3vDZAPz29FARCLp0pv8k2sipEIHY7dP2+OQ4+G/8H6koNOpwm8V+DJal+NSKiO1lvhXP
 47ryXpmMGF1cTnlYTDyuy/DdujWiWyA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3MSBTYWx0ZWRfX/J0vmc9gsAUA
 k4KNFbHj+nhDBBNHx+s/VSQKLNfVN16REpuUqCuiBPQlwIaNfFKQT3Pt9zuA2N+04IKPhEIaSVD
 AtlA2hNwx47OA/vS0Wi6sMln4FvLG9iuciBOc16Pbbpj6cx2FI7IavIyX9/aHS5lmzZwhGYA7kI
 8vLGVf+wLcXH2rdnWe4VvQYOLjgFmgMaBCFAdDyMr+LX4roBFmMaJveRaYaLzitbp3WAgBtk3tT
 gnAhMSKnlGI2W6xSHDs+U8asnMjjx+XlsojiCkOezUYnIVuFswUXNxNxVDsdbCVw/6uPbmrEVv5
 c7+vSHEVmOcD8WHHAY1vaVnL4lfxHKpp6m6ES72dCCYzgGrd0V7Hn02mb8I++OcF9AyNSLULYys
 nn6mw3/6iFHmjU8MbYyO6xiRIPFhf28/8l4gDRMT4xy/xyMVjUapCHt/Yxg0okMCEJH4dgiVjzo
 6/ovBSWCGyEDhCNrFfg==
X-Authority-Analysis: v=2.4 cv=ApHeGu9P c=1 sm=1 tr=0 ts=6a881d19 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lLE1e_VV37mLdjPsc6kA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Ma7zHVHVt8deG59DWZ01iuHGutijMCac
X-Proofpoint-ORIG-GUID: Ma7zHVHVt8deG59DWZ01iuHGutijMCac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210071

On 8/21/2026 4:45 PM, Christian Marangi wrote:
> From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> 
> dev_pm_domain_attach_list() returns the number of attached PM domains
> on success (a positive count), or a negative error code on failure.
> The driver checks "if (ret)" which treats a successful attachment of
> one or more PM domains as an error, causing the probe to fail with
> return code 1.
> 
> Fix by checking "if (ret < 0)" like all other users of this API.
> 
> Cc: stable@vger.kernel.org
> Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
> Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
>   drivers/cpufreq/airoha-cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
> index 3e7770860d13..8283c528d0c1 100644
> --- a/drivers/cpufreq/airoha-cpufreq.c
> +++ b/drivers/cpufreq/airoha-cpufreq.c
> @@ -64,7 +64,7 @@ static int airoha_cpufreq_probe(struct platform_device *pdev)
>   	/* Attach PM for OPP */
>   	ret = dev_pm_domain_attach_list(cpu_dev, &attach_data,
>   					&priv->pd_list);
> -	if (ret)
> +	if (ret < 0)
>   		goto clear_opp_config;
>   
>   	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);


-- 
Thx and BRs,
Zhongqiu Han
