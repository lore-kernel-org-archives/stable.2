Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FA395AF2
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126824; cv=none; b=mhhofJDYGWrMA8ho3XCTY5fj8/RjM+/EmO93+DSDhLnlYEcFKeB6bK9gvm3VSNb2eKPMvaNLhMFa2Xnh8+ZnB8lUseFsk1QIt1Oc3fGIalNwbcg7gagWXZUyUcdUjNrngFHbeKIi9LcC57C+HPDSUMP+lj9h5KXB2K5WFwyuVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126824; c=relaxed/simple;
	bh=AiFZxVxb4uPFuB6epvfZYhvtU1oHMpSADyh0bZhRhLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZNKsbyfJsSW3UWrNPE1qpgBdkv9FYHWxG813e0YBcBuJNXXHkV1NWtiUli0d09Wahq2m8/7opf7Vn9FCuuBH/tX+7sZm7U+paIjcn7R+xVdCpVZn3ES1GEb4ruveTuSB9JEbKz1W4vyBqZeI7FR55qP7EnQqSDZxcH6powDurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9V4kjb7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GR68RKuZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9V4kjb7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GR68RKuZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BApskR3433245
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L3Wnep3ucQT0IwQfa+r8v+NvhklcvjC9W+oJ9otiAag=; b=K9V4kjb7SQeHdbk+
	BQMo9NMTrDLO78f2+xH2BQ6KW3qMZHJEqBIiHCohKkU+edfFGLfPn6yTfePW0g7Z
	WCfQSJ+STQbnQCh8oJ7kH8zFnIugyOjt5SoFsvmePuObEHkEOCwAF5mr2XYgjq1c
	yLP3PYzQzgdw56cGFwUO38f6RMwsAzC7cHDCU6971B82yu1IcUIipNE3WeAlVF2v
	hFJaX93I6wc+3GloOuJVPKga+TPcYbDZ0yNUMhlIdDOtcblT3eRXtVPTCkH1qQeb
	7eZ33+V+VXB0lxjnmCBn3vKIJkeSHglHnq9gJiEMfi2fUDliqDYPKMJZTGMgBDsH
	N+ElPQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmfbbgfgm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:40:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db050d469fso29655375ad.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789126822; x=1789731622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3Wnep3ucQT0IwQfa+r8v+NvhklcvjC9W+oJ9otiAag=;
        b=GR68RKuZNoRcc4TK2tUyu2zrxIahyXQs8s6DczYxAhycK7hqDMyxMn9xGuy1JnDeux
         00eJg5/tajlB7LwkC06043WzNTo95VtUh/PpOsRFjQkLWZaZkcIpw/6DAahJShc9hc96
         XgniL4/kx6S+fsOwiEDY5zmqrqEwr0YwLd3pV629ck5v/8jRSu8YTuD9IBMZcivblt5D
         Gf+GNiHAmlOZgrePKwNci5YV/Wd8CVcUIzWNKTngy+X8YpN5eWhRzRMxoJLv8Iqk820G
         P0xZpOBikPNLTxZlehPtf5u5pAIunBDP/o/LLX02ASVNrmHxzNnH/SqsGabWnL/6eJ8u
         4JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789126822; x=1789731622;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3Wnep3ucQT0IwQfa+r8v+NvhklcvjC9W+oJ9otiAag=;
        b=FL1nzP4rTzErZlqX0lh3C6fICZmh0UG5qX1o0HTeaZzOceqnFGtVRPsdoLHgGfot6N
         gULmC7nuKKJ+ajpWI8kOG82UqgQKl6qkiXTkw6//6+7IRbywDX0WCEECgCtZ5fZtsIvq
         w5RL8zD9twQBIV3ZE6SXfZrVttUHtQko1vkY0rfbFpEm/rMyzYLGBwUeMoe7zVIpIoBg
         k5gdsIDMrU5LnLdJzS+GI4h4djDhfdUdnqn5ZuJjnpwoihK/ax1+pd5iBhphTpjgVprL
         69Uk+KkFv+QSoIjG/sS9OO+E0z3vvos4W59QXwXDzKhObmZB8+dWgHP8bP2gRC8eWdFE
         nEEg==
X-Forwarded-Encrypted: i=1; AKwUvBzd6kgmYg+6mYT7cdV1+n3aDGtxqem3dvVJoJdZfeshhjMQkYZgd0Df+p/fi9JcvLdHAGUrnio=@vger.kernel.org
X-Gm-Message-State: AFuF++nGS3XXRlNq+o9lw+vonZqL5mXYgjnA/jdvvPyr9kw0iuo3ERMh
	iy+lFlbdtCtpYJ9Yo/sr32WkP/Trl5qq+tUwHp3XmIA1O141TwwJuZg9IfxFcbP5bldZYHRcSYw
	JBbD6TwmM4s1BgcnSzi6OiEzI2XIQuDuBlWydb72l81D/MiugeE8PU0tUqyE=
X-Gm-Gg: AYBFou0U/q4fMqIDz7Yqt6cXAjcA0vdS/arx+WQM0E7ZkUExAuN1h/KpbP/du2WX02d
	7lsqR4uHoWHUGnnoF+T3ip4yhuMeY+cJMfiIUM+ymatVl9mGBdtcKUYnF2v6w1Ob4Wk0dRZD9og
	uSBdyrE5yCuRWSRn11afVMV4fKKAv1s2PglatdZX1gi/sGJEh3+YmDQvKl5PGCkbNq6SqJWbCtf
	4YRTUh59kZb24IJJIoh1gInLFxlEXpHrWdk6gv6JyUWZgDH+f7jWs4WbuGBVzZe3Hc3qvPrwbLU
	GMwWDVYqmIc0uFjjcbwttD8Y9IMsdS4BJ55BMh6qYe6VxNu9eheI1B2TaL0RbvbeIAODnjv/EbS
	qzwI72bFUGN+zwEDfp+PAV+hd8mQNGmQO
X-Received: by 2002:a17:90b:3fcc:b0:38e:a52e:a3c9 with SMTP id 98e67ed59e1d1-39d7795b9aemr12122451a91.8.1789126821941;
        Fri, 11 Sep 2026 04:40:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcc:b0:38e:a52e:a3c9 with SMTP id 98e67ed59e1d1-39d7795b9aemr12122402a91.8.1789126821413;
        Fri, 11 Sep 2026 04:40:21 -0700 (PDT)
Received: from [10.206.103.83] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fa50efsm6705009eec.28.2026.09.11.04.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 04:40:20 -0700 (PDT)
Message-ID: <9a6b7238-11d1-45ac-ac0b-ed34c6109424@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:10:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Fix bus_info prefix in VIDIOC_QUERYCAP
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260818-v4l2-compliance-fix-v1-1-77f8076d5ca3@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260818-v4l2-compliance-fix-v1-1-77f8076d5ca3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rrm058t1u0nJU65J_KKjyO8z2Kwz-1w5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE2MyBTYWx0ZWRfXz5/RXlE+F8b1
 0uyCu9K/uNrSmmG8jsg6eJEJdWl9LGK0QI6tkbPxILDnj3P26XYASi8APC6bVVsRFeCAJQ6tMpW
 y51ddFQA5AgMTRhOBlgQHaWckqUYE6FS2TEAlMHpQJb1IhtvU8eUjK4W3urfPOjZwU94KmC3vtr
 ZLoP9Hqp1viCruyHdvDeG5ew7RCCxGXrAEeNfN/CI6JTCraJfLa7J06y2b7OAo3aEKRKBdr55SJ
 aTr3defbbPyE1zsg8GS7dtEUfKcemXoOjnqGTiTJu4Ttpdn1Kkb9F3QAIcXIsizO8JM3qg3Hh28
 fYI53cJIpohO0WqCMpOfJjVqGYb0YBU00EqAHUOKuFqhZomNB8zrY0Ung9AlAC3540vcY0sjnIG
 W6OZxN9aP0EBdKviVkdSVaCuCfA/JANLjUcCZ6aEeChscz/tm1s2YqvIPbe5HmJdbCYDymzkE2z
 eXNEvEj9kaVYEl8/roA==
X-Authority-Analysis: v=2.4 cv=X6jHu2Te c=1 sm=1 tr=0 ts=6aa3e8a6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=j3-kLYPpZ4N4r97w07IA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE2MyBTYWx0ZWRfXzuKCmo0aTWkL
 C71KTB8arY5rPDGjuO0/a++CSyxMpkiNW2e7AzKVX4MZa2oLC3QizGEqmb9VNAo6j0nTGeHlCn5
 Km40ep7MZwnzU0lS/dLeQosnxvovX4Q=
X-Proofpoint-ORIG-GUID: rrm058t1u0nJU65J_KKjyO8z2Kwz-1w5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110163


On 8/18/2026 9:43 PM, Vishnu Reddy wrote:
> The bus_info field returned by VIDIOC_QUERYCAP used the abbreviated
> prefix "plat:" instead of the standard "platform:" prefix expected
> for platform devices. v4l2-compliance validates that bus_info for
> platform devices starts with "platform:", and fails otherwise:
> 
> fail: ../utils/v4l2-compliance/v4l2-compliance.cpp(671):
> missing bus_info prefix ('plat:aa00000.video-codec:dec')
> 
> Update the format string in iris_querycap() to use "platform:" so
> that v4l2-compliance bus_info check passes.
> 
> Fixes: 94ef75095d5e ("media: iris: Enumerate cap->bus_info to differentiate between encoder and decoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vidc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
> index fcbc60016bee..d39ac71a25aa 100644
> --- a/drivers/media/platform/qcom/iris/iris_vidc.c
> +++ b/drivers/media/platform/qcom/iris/iris_vidc.c
> @@ -466,7 +466,7 @@ static int iris_querycap(struct file *filp, void *fh, struct v4l2_capability *ca
>   		info = "enc";
>   	}
>   	snprintf(cap->bus_info, sizeof(cap->bus_info),
> -		 "plat:%s:%s", dev_name(core->dev), info);
> +		 "platform:%s:%s", dev_name(core->dev), info);
>   
>   	return 0;
>   }
> 
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
