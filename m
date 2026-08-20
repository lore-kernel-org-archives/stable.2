Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793B43D4EF
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230632; cv=none; b=YZrvRfNVKOOkhYWRlNJ855JjwoIkxC+WGfTy+/itdvAMvUyIHOclgao6iYs2IP/e+KmKPtO7THUn6OSe4GQQNo+VyHXm0T5Nf/fLu0xLEV+0urfk4C4BZTCfNf4rlbi3lalVcevexUOC7iRFd8ncBFobAIUal29daegdwq/0+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230632; c=relaxed/simple;
	bh=6zPicfPSfuHP5+V8DMnoMTiDbA7taLfFXsURXMarNus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XADvNAQrZdT3zvlpBOk2TmBgdu9pWw6Cfnd+SIk7GsaBNeZZ/vY7r1cOvb1Oz1yXEiaUd4XTq/L4pxVkW187VCUi17ogQ5tuLiD6ghP0Y/WmWOJyQDhsMG3h/MTGPQYX6ZB9rQ43+fAiuCu4HGzRogKtSfhrDaTPbJYDtH3V6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fzeij/KY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g0l5kqHA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fzeij/KY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0l5kqHA"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KA2uNN2933270
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7fpQDiZh6Rcpd53mASakZgg950UiukvD0vCxtgS43C8=; b=Fzeij/KYYbYcT4iP
	Qogo9oAMVShbd7qjrNoRYE0XcfkQH1/xw4cT/MiTXAyE8aOhRP3cJVPg1t1Tsh9k
	wMLL2wuBpPixMO7qIsXN1jqgrG+oj+v1SnOM/+SfgzPxu6aYflpd54ogEAI0wNBM
	113lpXUunt/DssYPbjcLjCzFqHNxJNRxiI+1M45AQJkE19sBz9RaCKFAT0n9OneH
	+QbHlgYsbNHdsN1urEt4CTlF1RC3DPu7vu94FG6+WZFj6QSABfyk+SuWsUS0ts5l
	vVgc6dh+IkjBycTHyhwIKxolnlZ267DHpzxQazd74b7kBBOonJoJH9PNsbvXm/T/
	TQvarg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0gktc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:57:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso4031607a91.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787230629; x=1787835429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fpQDiZh6Rcpd53mASakZgg950UiukvD0vCxtgS43C8=;
        b=g0l5kqHAAC7QR/HccktfhCOc4AurVOfLSrjdctUOkCQF7Ckue1xbTxC9X6yteYVUKU
         RhhwMUksI4d7TQj+3GcoQY10uQOtivqLIXI6WqorohawHF9OqfY0+BbSvuHoAl+blIa2
         zyKppFhW1mUxlPLuMD3pgV8+U280CnfAjar6tDvWZ2k3RAk3aChmO+SuvR7GFUmKVUri
         nTcIUjitWChrtiquX3Si5d8uZlFrE0BhfPQhHbdioITMx8AspRTXaVeXu4aXFw6ct3OO
         nNCEDhD6cSSQKcP2GQKUds2cl3IUfgE+PPbJgmSjN8cA2bJhCuJmUoleP/NBeEFW+1pn
         N+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230629; x=1787835429;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fpQDiZh6Rcpd53mASakZgg950UiukvD0vCxtgS43C8=;
        b=DeXbIFYn7sqDlaFNsC35d2lYRo5F99FY7Ljch3QgXx/l/f0tBQX3rRtQnHAYOo+AJQ
         UfIq/5NB4QPJbnYfm7iPtuVDMURdPj7fWU8WI4HOPlbXnzgTG0lxvpzaVzrdfRessRa1
         bNq6ASAw87HkYJTnic1BofctK/vHmfYQiXoJ8eOKDh1ffAKQ1RqToZLpq5WRJ65E9yrl
         IpuBVODr5E8RJ87fBzx/1twy4iC3hfZwgF4LGvp1g35iOntshCzADO6jShDtaTWy1GO1
         F8x5/lMWsjg2Oy0HQvqdF0CJ4jUmoIqZLeslsqAR58BkVDJKpYtA8Ga+Wzx7WcFMqF5G
         rhHg==
X-Forwarded-Encrypted: i=1; AHgh+RpwklzKgJUY24fqxuzjJEaJaHzuEuIdKLMGpeKcpatroUkfilJGFHMWkG8kPPzB7QFqQJW9QDc=@vger.kernel.org
X-Gm-Message-State: AFuF++nAVx8mFaRdbPuEtO0ThUcC3w3Ad6CtxrbRGWRQzqAbRtrGtUKf
	NQXMVmd0VlzTDWSSRJ2AY9THhJiYDmdKUmNYJoOGUwSdajVZLy3uyQklkrgFSasnRJWiZsXhCPz
	FTlvlW8swCVLWJ09B6i+dZgwqkaIYLY/I6YrS5M1hO6dUgTHsmoGnkAck7jc=
X-Gm-Gg: AR+sD12kqrts+wE2//l2QYsS9ZNSsv+JG3MzCDHPM5TEc7+R1G4SmSzpq5XERfl9UcQ
	+nWP+5d4gWv8XRA6M0mLpVEQtUcITvbpmOCOazbJyrcVSoUqQmT5H/zUBBMHWcxSRU0BXdPW19m
	wXCWQ6jFZYDxd96XQJawi58b4osE6ncK05guwx0BGOGRpStCP18vjfQi9Wvk34XMfjW7yodOlz8
	08JWw2mWLbayocMDAoFkrVWiWsl4UU7fH/HQhKZeAnfy5q9BO5OQ/cPb9+tEo1jc0DOucGAnp2P
	PuVOygCw9dSIyhc0JHMAmVmkawKbkyMLiWSBsdztFPXvjcqImRoFgtQvVhvPggFmfVvj9912lXs
	JQQ9rcej5R/IzV71jJKPxCjJsF2+aaq1xdIzqUgWyV9eXnWWwsEnFVv6V9DW5vi/ckX0XCbu6
X-Received: by 2002:a17:90b:3c8f:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395810e9626mr25289923a91.15.1787230628799;
        Thu, 20 Aug 2026 05:57:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8f:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395810e9626mr25289810a91.15.1787230628295;
        Thu, 20 Aug 2026 05:57:08 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb60a2bsm7019248a91.17.2026.08.20.05.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 05:57:07 -0700 (PDT)
Message-ID: <a4b1ff9d-f71b-4cde-b225-70568ca8ba8b@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 20:57:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] cpufreq: loongson3: Replace IOCSR read/write with
 MMIO ones
To: Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-6-chenhuacai@loongson.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260818123921.3600606-6-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RyHpV-h_YnuuYhfLpRDMBArSFp_84W-Q
X-Proofpoint-ORIG-GUID: RyHpV-h_YnuuYhfLpRDMBArSFp_84W-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX9sOyUT5JEaN7
 WVsJq+QGuru5OM9lUNWLIG3sHLKb2ZscPp8RFggSdzp0UNHVndNOV6vmMTenfvQErVLgz6tNifG
 asBottBzw789r2JPjtw33dTVsKNggE/mbCCpJo37CgIjQ0gEbIZKuvP3TCpcY65RIEdsnqLwkL3
 UpsLRNSFi37wRPhEg9WTT17c26392fGdETsjNvXM+jdW7Jc5uA+y+h7vHWa36bTlvFVZhOOnw0Z
 FN6wLmBkqxdhKG63iAPWh7x+6hLBjBD0qgeT0ZlelI3bnGqU9+MPn/lwA7AKwLOukP6STyljBnf
 DIf41JCApXqM6pCbBQY/fwjQ+pUPIIF/6P+ACjGYkvnd3aFe6KCCsUKlH4XzDrkgzuL3yLwhAtz
 vcBNqi1ql0hYO22OIEe9iG8SV47PdVmOd43N+8M6I63M/MvrXb/C7njAjmlUScfx4H1tnkz7Jpw
 zR+uigb0j04fwqo4A9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX3drA+6R5O2q1
 J6Ou8rW2zIEHBhgUyUvRbjouCSzE83y+iZDM9SV4UJC7BmR8eB4rNbVvQm+Hvw+RVzk+ZIvKAeA
 bbJm9VtuftZEExlvTEbvTv7RTUPyZBQ=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a86f9a5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=X8ooYf98hskApLny6-EA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200097

On 8/18/2026 8:39 PM, Huacai Chen wrote:
> Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
> nodes in one package and SMC mailboxes are also per-node. However, IOCSR
> read/write can only perform on the current node, while sometimes we want
> to perform on other nodes (e.g. when switch governor, the get and target
> callbacks are not run on target core). So replace IOCSR read/write with
> MMIO ones.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/loongson3_cpufreq.c | 31 ++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> index c75c0e30e881..e5062cd62390 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -164,6 +164,12 @@ union smc_message {
>   
>   #define FREQ_MAX_LEVEL			16
>   
> +#define MMIO_SMCMBX(node) \
> +	((void __iomem *)(IO_BASE | (u64)(node) << NODE_ADDRSPACE_SHIFT | LOONGSON_REG_BASE | LOONGARCH_IOCSR_SMCMBX))
> +
> +#define MMIO_MISC_FUNC(node) \
> +	((void __iomem *)(IO_BASE | (u64)(node) << NODE_ADDRSPACE_SHIFT | LOONGSON_REG_BASE | LOONGARCH_IOCSR_MISC_FUNC))
> +
>   struct loongson3_freq_data {
>   	unsigned int def_freq_level;
>   	struct cpufreq_frequency_table table[];
> @@ -176,13 +182,25 @@ static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
>   static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 extra)
>   {
>   	int retries;
> -	unsigned int cpu = raw_smp_processor_id();
> -	unsigned int nid = cpu_to_node(cpu);
> +	unsigned int cpu, nid;
>   	union smc_message msg, last;
>   
> +	switch (cmd) {
> +	case CMD_GET_FREQ_INFO:
> +	case CMD_SET_FREQ_INFO:
> +	case CMD_GET_FREQ_LEVEL_NUM:
> +	case CMD_GET_FREQ_LEVEL_INFO:
> +	case CMD_GET_FREQ_BOOST_LEVEL:
> +		cpu = cpu_number_map(id);

cpu_number_map() is undefined when CONFIG_SMP=n. Wouldn't that result in
a build failure?


> +		break;
> +	default:
> +		cpu = raw_smp_processor_id();
> +	}
> +	nid = cpu_to_node(cpu);
> +
>   	mutex_lock(&cpufreq_mutex[nid]);
>   
> -	last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> +	last.value = readl(MMIO_SMCMBX(nid));
>   	if (!last.complete) {
>   		mutex_unlock(&cpufreq_mutex[nid]);
>   		return -EPERM;
> @@ -195,12 +213,11 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
>   	msg.extra	= extra;
>   	msg.complete	= 0;
>   
> -	iocsr_write32(msg.value, LOONGARCH_IOCSR_SMCMBX);
> -	iocsr_write32(iocsr_read32(LOONGARCH_IOCSR_MISC_FUNC) | IOCSR_MISC_FUNC_SOFT_INT,
> -		      LOONGARCH_IOCSR_MISC_FUNC);
> +	writel(msg.value, MMIO_SMCMBX(nid));
> +	writel(readl(MMIO_MISC_FUNC(nid)) | IOCSR_MISC_FUNC_SOFT_INT, MMIO_MISC_FUNC(nid));
>   
>   	for (retries = 0; retries < 10000; retries++) {
> -		msg.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> +		msg.value = readl(MMIO_SMCMBX(nid));
>   		if (msg.complete)
>   			break;
>   


Please ignore this comments if you do not think it is worth addressing:

A separate issue, it seems that DVFS and Boost feature is set in
loongson3_cpufreq_probe(), what if about on other nodes (non-boot cpu
node) and what if cpu hotplug?

static int loongson3_cpufreq_probe(struct platform_device *pdev)
{
	int i, ret;

	for (i = 0; i < MAX_PACKAGES; i++) {
		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
		if (ret)
			return ret;
	}

	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
	if (ret <= 0)
		return -EPERM;

	ret = do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE,
				 FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
	if (ret < 0)
		return -EPERM;

......

}


-- 
Thx and BRs,
Zhongqiu Han
