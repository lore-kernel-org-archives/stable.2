Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7F4302EC
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225708; cv=none; b=c6hy/o5whFrSxXs44uOLxjfuMHTbAqOUSYGkCtmca7R8lzdVjBiNADvFmB7GWCW1Y8oplUTe++42fbh17QeQGpoWfWKHQR0CzOz1YHZU15uQQzW6n7DEj24BiyDma9B+y3zASrHX6PiXjPBrlW0K+W1Wca/xl2iLHDssHGE2878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225708; c=relaxed/simple;
	bh=w/oe/n1XYNtDc0P/sdP49l4CFCqy7eqL6XVrY+vYFP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSzd9A03VM1l4d53i4r3T8w1Qf2asJuXTbbwt0FNVLf7ROwxMfyHCIKkjkjcNJKwEGImD5qgJdWmU+0g23oyMsfaa0pXOysz90oAoYVf0+/5/Wv0t9R1oKaYXMjNCJrAYkWrMZfjVF0uuu4fCmOs98nLfhvxGWgCxZtCSiT01TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INnkzwFD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UYcvNaX6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INnkzwFD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UYcvNaX6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8PECJ2465462
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ozwCerwZWysjPLIz52++2YvvXko1OeccWoS1EoE+S/c=; b=INnkzwFDr3Mt1N52
	g+XzLhNJuP+bvMZ1xMcVQcUw5aLDHKyA8EVsfD9vtdhiDG/VqOAKHKPfbYiL5Ky0
	4UfyOzpOTJgAS+VXDxyt6nu+I9LNrqrIrNUdqg0dgy/0fdYHvsofX89QYMvG3o3A
	WBJHYkd5w0pWXPGrq8ZZec33IxE6/yDkOTTs43JL0SAzWTRA4C9iRFe+i8JcV46n
	hbJDHDyU1D/pB9kGyG2DSDUcAq6dF6hpAYfUjbjJJkTzBEwgFJXJrqVTBcipwv2q
	9bbd5+x/7UOk9WrPY//PscDf+SUWRq6XThmZ1eDWmLHyggSsg0oRT3qyVrZc8+MB
	GrA4aw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29gqy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:35:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso3331797b3a.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787225705; x=1787830505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozwCerwZWysjPLIz52++2YvvXko1OeccWoS1EoE+S/c=;
        b=UYcvNaX67Q4SsodrwLa0qUNGoqlTsMX3degjh7YecLjj3iTZXhGe1GEMauB3eUepF7
         GcWUgC11wppa7E84lHC5SIYIg9HpkTIGKh65WrWStKWZHFLGGmIF360ho280HB/cqt07
         h0FbxfXuRzQ2qw0KMbQm8XHRmpxcfpEjEIVczalzmUFnHGE1wScVRwZZoynFh2xoQUoP
         AlOVj2A/oECOGDibCM1t8QamtKltqdiJI5TQ3BMpEPCpQ/nhCI/kvh8+l7Iz28JSRy/0
         xxAcSABQXKso/ntbYeaeZrU+4NmLEFg8+0F5GzsfLZ7hRgE3G7IeGUTGURPaWgIVOOrc
         YInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787225705; x=1787830505;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozwCerwZWysjPLIz52++2YvvXko1OeccWoS1EoE+S/c=;
        b=pavP8DNMsYM2BFiGA00cDJW3MBP7gICxkpn9xucsgbNDZo8i8ey7fqSChOai4+xhhy
         n23LEox30AIHRyArW3/WNFIU0F0Ukej9y7ue251ZZozaPAgyJuUT9nBSjYDc/jU8NgEz
         1X8GOuWciFCj7d3VMEzxpIg6G89AxSGUJPaucnlWwDLh3lX5BSMXWLT0g/4B0/BmLVyh
         itKrfncHMONdQKIqJ5+8Zb0jF9g4lRfduB6xoG6Ht0BKChcQPR289jQO34qIopiZqYsf
         ro5A/DKllmeOrfzc3vknGfKhyhSb6w0prUNgSSlAIqiwi4yqNcE9m6OgHA1be88udd5I
         7uJw==
X-Forwarded-Encrypted: i=1; AHgh+RqsAfRQ5jFM/Mty6AyIuQQRgt5FLhWBegtiTqUAjaxLNcOzhn/6MulctQFcwk+gv+OlQlgGIZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBGX5/quxiHvLQVT42k0JZ09tSARePNrR2tuHj5WOMwyKeh93
	1b1/tIVeHCi/wufQcfw0Bylld7+qjVomGEcW8bx3d3L4Y5OsqABQXltUgeMJ1PpManTLQfJUl/k
	EQWmotP2IZB9+ViDpDFF5h6NW9BNgwIDIQfw/0GKujyQrtEAj1kt2xzsuO1I=
X-Gm-Gg: AR+sD10SKWHAO+1N5SyjJvm1LoYJX4V+eOMtFl9yMUU5Us+hhUTmnQncJW3Yym1f5H9
	IMQ2tA+xNIhPjrYXwI0RLI+hYVc1Mz09xtnaoEykPAJ8DmKzMLs4EuZ1maUj21595Fy2T2sfYkp
	zO8dUNp5XRHP+CEU9X3siQmNmmPNdKMlyYY7MyBNl90YzPgsZ9G3G34y4wnqT8kEfsVy4ZZp3jg
	L0HB/95+ugIh96i/r/yfqr5IGhMCHCXc68U/E+y7KpPpWH/f61GuBUKpe4bABZLzA8QfmFmKL4m
	7ZQ7RPklz57WrdlREQXEcDx3t6WfoNqamwCZziRgrRhK2KyPQo8OfBbYGQwBDESLp5YyWw1CHuh
	kK24l3P7hJw5INO80y0t1Cy1tTw+UPg==
X-Received: by 2002:a05:6a00:808f:b0:848:56d4:3288 with SMTP id d2e1a72fcca58-851d383149amr20467234b3a.4.1787225705548;
        Thu, 20 Aug 2026 04:35:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:808f:b0:848:56d4:3288 with SMTP id d2e1a72fcca58-851d383149amr20467124b3a.4.1787225704987;
        Thu, 20 Aug 2026 04:35:04 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3617efdsm1528743b3a.39.2026.08.20.04.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 04:35:04 -0700 (PDT)
Message-ID: <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 19:34:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cpufreq: loongson3: Replace per-package mutex with
 per-node
To: Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        Hongliang Wang <wanghongliang@loongson.cn>,
        zhongqiu.han@oss.qualcomm.com
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-4-chenhuacai@loongson.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260818123921.3600606-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8b2Hdx-f8acReUMkLN0rgrVq6FO8o1Eo
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a86e66a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=aB35LMdZ1wvYvMI90LkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4NSBTYWx0ZWRfX+so+NU1EKwnr
 yP/YF4d8pCmjNhXYLaCaDlMvKYhYjhEWa7rXZ8q2NoOoQ9Hk34VSYvxmAwxTKpm0By2BhWti6dr
 VGUEEcfE/I2gjcRLNz0BLcjXEjKiMziAkZA0PlZBzVRfxWnZgg0LbJ/bi59w0sAclvRothP8YbN
 XtQXd6I+6aDI6ejkURipVotkeNrctuv4hRjIyBBGeBcTP7wjSV1D8hHZFKQ9iTj5iT54IZSPlny
 pTtvbkNjOoQIaOXtR+M0TAnOp2YVE4hEiGqIihxJWhKLtBA/C9Cb64OBP/5VLSBw8GaVirf12ee
 vYfHS5KxB9GbV5BRTpc8iai/GarCyNnvYXbymgNk/3Xs+4J4yO9tTQuShWK+NB2egaAUe+pTFdc
 8E8pROSnJeefE5xz+S9hBGcdGI3MpMgqTj8fOY48ix6DE0qe8tIJ1xn/Pn1KMsEEUN2wsDgYxM7
 iWIut4RVyT+vfZRkmkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4NSBTYWx0ZWRfXw/bnJbj0KvWf
 fuhABklK8ZXaePWivWM97/M81y9yqcEWYyXqJ+HH6IaPtgWqhDkozygVJVsvrXyDSShO/FphuKM
 yfiRYUXgWfRUZ3i9K7W7T63QQ5hvU3g=
X-Proofpoint-GUID: 8b2Hdx-f8acReUMkLN0rgrVq6FO8o1Eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200085

On 8/18/2026 8:39 PM, Huacai Chen wrote:
> Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
> nodes in one package and SMC mailboxes are also per-node. So replace the
> per-package mutex with per-node one.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/loongson3_cpufreq.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> index 630f679aa739..e3cd78a5ab18 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -169,7 +169,7 @@ struct loongson3_freq_data {
>   	struct cpufreq_frequency_table table[];
>   };
>   
> -static struct mutex cpufreq_mutex[MAX_PACKAGES];
> +static struct mutex cpufreq_mutex[MAX_NUMNODES];
>   static struct cpufreq_driver loongson3_cpufreq_driver;
>   static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
>   
> @@ -177,14 +177,14 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
>   {
>   	int retries;
>   	unsigned int cpu = raw_smp_processor_id();
> -	unsigned int package = cpu_data[cpu].package;
> +	unsigned int nid = cpu_to_node(cpu);
>   	union smc_message msg, last;
>   
> -	mutex_lock(&cpufreq_mutex[package]);
> +	mutex_lock(&cpufreq_mutex[nid]);
>   
>   	last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
>   	if (!last.complete) {
> -		mutex_unlock(&cpufreq_mutex[package]);
> +		mutex_unlock(&cpufreq_mutex[nid]);
>   		return -EPERM;
>   	}
>   
> @@ -208,11 +208,11 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
>   	}
>   
>   	if (!msg.complete || msg.cmd != CMD_OK) {
> -		mutex_unlock(&cpufreq_mutex[package]);
> +		mutex_unlock(&cpufreq_mutex[nid]);
>   		return -EPERM;
>   	}
>   
> -	mutex_unlock(&cpufreq_mutex[package]);
> +	mutex_unlock(&cpufreq_mutex[nid]);

An optimization independent of this patch: considering to use
guard(mutex)(xxx.lock)

>   
>   	return msg.val;
>   }
> @@ -337,7 +337,7 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
>   {
>   	int i, ret;
>   
> -	for (i = 0; i < MAX_PACKAGES; i++) {
> +	for (i = 0; i < MAX_NUMNODES; i++) {
>   		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
>   		if (ret)
>   			return ret;


-- 
Thx and BRs,
Zhongqiu Han
