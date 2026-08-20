Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DD3E49C7
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217804; cv=none; b=OQWXXhiFfvmc/28jfyS2Yr7YEqWO8Gmv4d3vl3B0uT/A3f90XKQXDyqdW4LLumHMyHCbvV9v4dRqI2+BP6K1bnXe6Xfr+qzCXESY0nbGaQqQcbeoT5iQuz+IdTvA3afSS66vVuvCgP3gFjP1ROd/GjPia1OC5tP9b6cGH6WsNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217804; c=relaxed/simple;
	bh=eWXjDm/rNRBZghDqHn6cqTEJsRLefjaNGwagAb1uQXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPbz5BU1EEvMySEUSW0v1prcP4qZnQjD3SXSRGGRM7tI0BF9w09gICokPRKcX08J5Xq4CWY8w/pv1MCsMmtohv66fQRIbghCdLMvv8KkUYyGa6vJuraK8vG95eMZQ34XODzGa8KkaYYA9VAaI+JMW5aFBAaEIXO6pc1cgnQNkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTQq2QvM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aKp4aleV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTQq2QvM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aKp4aleV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6VXT91258930
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+pxcnC7LlOtfUPE7WuTxX2VzzLJtGCT7IRYPoYVTdU=; b=jTQq2QvMSp0y/uZN
	xox1lfpNY6g4oK03nKR3XiaprcFddensAQirhiFcrHptE6B59srTccg81Ye0Kkec
	7UAemEp+19KkAnoWW6EAu/kewplyAfz7UHdb6m8IMnlVoOSVXUKaqBICyDwbdRWz
	1aIdWiBU1syOy8qIo4Y6lnfddKhhJKnicaxMDJhkORoX7c0OgPVLMfWtpDScbWBW
	uIqllcZRvDbzqIh6UQvdzPaepsmziToG77R7CPxQWf7KoqG++h02gGValP+yT9vZ
	1RPdfumxjSTtqHwvjj6FTqady8l+08Bq+gFceuYigW+81EpA3ytx6xHBe4rmEteQ
	Zw1iUA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es642kj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:23:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso2469649a12.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787217800; x=1787822600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+pxcnC7LlOtfUPE7WuTxX2VzzLJtGCT7IRYPoYVTdU=;
        b=aKp4aleVVc7/K6fjBd5U5hBIPsk94yhLm0SxJjhMY5hEI8RBYhuIJGAZC6XZKNIMrT
         N+QD6aI5vjB6/ezLs+WpJLpVsGdCNNoywZSBWzx5dMCY74Io15Sg3I2D+5b5VyAZKN/k
         bZBmK3V71XNSbkrq+QoV417Dw0y6ka7B5v7z/A7jFhgV16cVs1K1C1atKjuaFNJdFlUY
         vR9WWSBoL+IBloEwrz2bHGZbn7Q8XrHHTKT3GD9aynXM5F4Mb+hD28jtVTrffGdVh81M
         ustDko27Un9mMpmLde2phm8KQSmmrlCmYHUb7GEq1RbuStgZTfWZxwdahiVqteMp6YGg
         aiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217800; x=1787822600;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+pxcnC7LlOtfUPE7WuTxX2VzzLJtGCT7IRYPoYVTdU=;
        b=l9v8dUgH2P0UP/d6kxS4lvb16ze1mKx7s3RB9um4VnobKx7xQDQ4yKDHTbejEX8vcz
         /lknwR6yc/O8rKRmXi1u5DrPiAA2fhBSdcRM4WrzmsPDEHoI2etx73mKIjUqBM4lZLI6
         t7ezXVTW1Kh+iU2y5alQZiZoR/0IUWzazd5dxAJpPnyaxIp40D1B7ZKGt2Y3QZcEW5Db
         AEnEt1wzIZBrcTSBJuU7KMXdcKi3+Jd56b0PMa9hdXueXHlmW16sWZUAKuv8ZD14koRM
         NQQW4sk5Dc9mfXFR5e1QvapvFtFxFGCPJ8T7hKAX+3QGUfN8crRjtGVP2zgsRNB8olL2
         qMMA==
X-Forwarded-Encrypted: i=1; AHgh+RrXR3rNuvL1zqbm7aPlsOKpBkV2ngvbgovaHFTslKsQc6nXNOObO/QJvH3RAEP5TQEWb8PMISM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfj5zdux87Rb+yjsj+vxzKzAL22u/BUAzwl8q7Pdzc1QM7Sh+a
	Iy/CTn5xzK4h+m1vMEnt3XxiBNuzk61L/zDv/JB6dp4ki5Ik2FAQP9paiyxUXtOIoENXplZgWT2
	ywWwSWJvROLixB/coGHi6ms/2EzAJmVejlRf9NYOTHgmoII+gCHkBJEnygao=
X-Gm-Gg: AR+sD11LHACerqmO1IGxEfhG749OA2BDxG/V7cZ/vZKkP5uS+10CwI5WGfiSr5ZU/+g
	ChL+P7GzV7Jla7Tz4ZcMIYkQc7r/149KDCN/qZYLFG+eyZtjl6rQNXhVvQ5j7cG23mswl0N1Mp5
	GNXP9VDVEpB9/S2vLfZRnIq2wUvMD63VV61fxUoTWmPsvjNoIukPCZf/JxCrwjlEgwkwszTIX0G
	FNKmmZ60/fg++eKfPk1+LkPGSxiaCJcm1rgzRBm/gkusOBYbmNwdmPC+evPSzP0aNy4ltlRP+LK
	GDns1UspoOuWWNFK8VWjzUEntic5nOnOpqoAN1ASVEv1SQwUIT0CC6wBICVWQJCzA9IQZZJ62hB
	eyLy60g23ru9tgxgmugPYUlVnZtwsXNAWD78k/lMhCuj0wN5dWy5FPUn+tuW7gYDP6a2PKjjR
X-Received: by 2002:a05:6a21:48c:b0:3bf:7081:9356 with SMTP id adf61e73a8af0-3cd0126b6cfmr21929947637.17.1787217800534;
        Thu, 20 Aug 2026 02:23:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:48c:b0:3bf:7081:9356 with SMTP id adf61e73a8af0-3cd0126b6cfmr21929856637.17.1787217800100;
        Thu, 20 Aug 2026 02:23:20 -0700 (PDT)
Received: from [10.133.33.222] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15523b579sm1611537a12.3.2026.08.20.02.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:23:19 -0700 (PDT)
Message-ID: <0b8371b8-408c-48a3-a41f-2e2f1079d315@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:23:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] cpufreq: loongson3: Make this drvier depend on
 MACH_LOONGSON64
To: Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-2-chenhuacai@loongson.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260818123921.3600606-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E5/9Y6dl c=1 sm=1 tr=0 ts=6a86c789 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=FBMUh9G_Qb7lsv0hvtoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: GwBXjLNIex2rMvRTfmii-MXZOx6Ve9Hb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2OCBTYWx0ZWRfX29+PJcAPzY7P
 0rxEYNSAASiRQeUxE1Md+NPTAKvFW9MUBEuuZqO2OsTaYMxl3tqcAb7E7Y66rCMeXxVEMO3vyig
 c3UnVe7CJEH6EFpAt52A0iNbBqFVcZtMiT9DwjHlM2i3Gt3G2bvkfEI9GbrrJ+wFf/ma+IpIU53
 6Bgf/1AZD6WC5iw6k9LNhbeEsoNXlLCsIQFYaBFgjY86QFsgZ5pPv6xznbeZG1fnrH8/Y7QFos4
 vvoXEMeQV0EispykVby6C6zfYzv5SvasXcavtHxXP8i6UhZB0BOY5kotS+uupGCRve7X61LEtPw
 VacqxrhZ3oMOzC3/uEtqEA5iADTtkPQJXQ4Cb6ivby19DNndvG130U5aDQR2LlfAvNQMtT+sNk0
 BJqJEg1g8aAB1kTrxDBi46H8zO6IQL6RaQM4eEQNiI5GJhiGjQDLujP7fk3+qiMEXtfW125+gBE
 23n9bMxjgp1lES+m8pg==
X-Proofpoint-ORIG-GUID: GwBXjLNIex2rMvRTfmii-MXZOx6Ve9Hb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2OCBTYWx0ZWRfX1kujWlOxbJkn
 YU+1Y+V0laOtNL1Rb6SfN2sYq0fW2wFC9wTRwzHkhMZbyvWNBhmeU6VcPsJz6iNuRVGauey6FqW
 2IWAwL2XnUPGnvhy7374+cZeo+14llU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200068

Hello Huacai,
Just share a few inline comments/questions below:

On 8/18/2026 8:39 PM, Huacai Chen wrote:
> 32BIT Loongson machines don't have SMC and FreqCtrl registers, so make
> this drvier depend on MACH_LOONGSON64.

Typo --> driver? Likewise the subject.

> 
> Cc: stable@vger.kernel.org

Nit, it is better to add fixes tag?  For example:

ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index db83f3365698..edc1299098d4 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -288,6 +288,7 @@ endif
>   if LOONGARCH
>   config LOONGSON3_CPUFREQ
>   	tristate "Loongson3 CPUFreq Driver"
> +	depends on MACH_LOONGSON64

Small nit:

Please feel free to correct me.

There are two MACH_LOONGSON64 symbols in the tree:
   arch/loongarch/Kconfig: config MACH_LOONGSON64
                                  def_bool 64BIT

   arch/mips/Kconfig:      config MACH_LOONGSON64
                                  bool "Loongson 64-bit family of
                                  machines"
                                  select ...

The one that actually applies here is the LoongArch one, i.e. this is
really just "depends on 64BIT".  Since drivers/cpufreq/Kconfig is a
shared file that also contains an "if MIPS" block, please at least
is it better to mention it in the changelog which MACH_LOONGSON64 is
using, because the LoongArch one has no prompt and is therefore
invisible in menuconfig. Or just write "depends on 64BIT"?


>   	help
>   	  This option adds a CPUFreq driver for Loongson processors which
>   	  support software configurable cpu frequency.


-- 
Thx and BRs,
Zhongqiu Han
