Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3549E13B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982950; cv=none; b=UDA0qagkGuflBcsc97zx3LT/1vzF1I+WYjnFV/F7o+awrqIVpyyZJNArlbWhL00Zztoe9NfjyYQSJtP7Iv0WGP4C86xGB1f3I0L85kEboIMxlJhakY7nOAxSZBTwy5H/RidhJZt2H1J4zzIOwL/g15UJ/tk4UnmOQRMtl7NlmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982950; c=relaxed/simple;
	bh=GZh7TLiWSHoFylXh/htKohdUX6adPDJdp5jc7Atnung=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uk9L0RrdzSA53u7OpEoCaSVJsqb7XIZs+hg5Vx5xK8xAc6qCIxgKO3RqMa3jMtQHME8rJ4651NxBq7nbUW4ONTjHcYOHIFMe03qQ3VcSBvrXea8wvWSt1IbRt1FhVMN6zoy5TDsgbeZmm5rWXLzNLSMteFuGrH9u+zbMLrmPsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i8XfHTSe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aC0RACHh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8XfHTSe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aC0RACHh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7AUsI468487
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=; b=i8XfHTSeay8DT1Fh
	4WrZG5wurO+Dfpp+YDGEtXm1ZVk4Yk9CN2MtkbRrnes6lByDq3qyDNiMofF9HCl3
	t9w7AM4CSKL9jPqVeeUs4T1Y/uZzcQnjrLFfqaebRaJE4dnH58uEkH0EyGMYIOfJ
	t546zULee1PNU7JJgbu/2nSUpP3boSRJFFLrn0zeL6UTgJGaFtgBY+6kPteNUAnO
	NneebAST39au2u+cJuczn6O+eSlpkw9F0Y0XvQ9/yxpcwtnbfWS7+pfdSsqn0Pt6
	moZ8sLALYa+sPX2pTJ8ero98BS48PzNqOYVBSfEmUXoRnTHc51MK1VVMtOeX0tSV
	D7rBew==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8b9xaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:29:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-532bad5d751so387331cf.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789982946; x=1790587746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=;
        b=aC0RACHhn343+0QNSRzzsKOrT4dHIV0JAOi1l+qzQLepQAGZbAeeXTQ87r2E4ODAfz
         LPMqyy0IKdWphbYRlE/LpTPimw8A42h7alPUCPm7fTeQJNkwiGPP96g81gEMce2ltEaZ
         WBlW9Oj/WBb8zczXwzZRATO0LwfGytoBP18xsEA6+EqMr+r3+IWZgnOujYmE0R7eCTbS
         mNMfwX0O1iDwrHyUlzGmqi7h9QSAhOXZ50/TJZLwlrHTDi7etsg2hH1AuVjU9xVk2oDA
         WlzGl+TiBfV57PJ1M+YFJ4NbVDjbwan8W0elcid2jlF7D6p/YMXo42zQBXmtKtis2nOB
         YtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789982946; x=1790587746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=;
        b=ssfQ3qEaRwzoqsUouzc1D/dYrnoy1INfDfa00iz86xUDSai28PGhAVuQqx/xGA2avW
         XB2IJPfF8g3XVSMKZZJngBHMv4wWUaBAJ1QJEx46OULzqVBSpMTidFuQLo4+9fuc4UO6
         ltt0Z6CIKGw2P3XJe/bZDRq4Cbfh6yhIPPl1xLmTRjep9l6Q4JefIV+705aHdK/JBom7
         XOeZx8yEjdqGybI7OG3CBMXhnU9UsjcGqpcu1BlcHfmRxpF07nr6yFp3i3ZHDikPzYKT
         T/4wcl8JkQaaH+LRzmrfOWXwZN+5hVhjYHgQWzgih9zRyoatlHtzwHVTi3w6BGPDwsal
         hWUw==
X-Forwarded-Encrypted: i=1; AKwUvByd8Ew9Hr9vf1b2NXSKssooUHRX12FiFw6K7Wn+sibKyt+IBaeusACtBRA6KjTsDxlE0F0qf/I=@vger.kernel.org
X-Gm-Message-State: AFuF++l2/LtC8Vs/tBYB/ZyhERI0LUUzJL5cESrccueq93WBU2p+Slze
	3QipfSryqXadHHKie+m1DudMp78ONS9dUx3pz31LkDwFSFk5QiH6PnCqfdspNq8unM4rMcuGicB
	6efrUS8t7oHqmiSt22sDgJWoBL3UT2Ds9y/7osbkY1Y+GRpbCF9mOtZAumCA=
X-Gm-Gg: AYBFou1afH/S1spMaIz3oqEzmp+22QCr6NKRICHYm8Pa6lWx/jC1DLRORRReOINtTDl
	tGXUXBN2Q0rZzbPNZM9NYs/tMYz1SUdn5whdWkiyMWsc//txrtNDeq6Mrri80b50TbU+5h741Df
	OHjtPM/Zdld9MmVWZehTeIZjXVW3ja8VP4JBm8nhxUmVKpCNzyA0W25iZaz1eAfq909N9No6g5v
	2i4w/rO3+mB2exdHfl7lpIZN8kg1S0fKgvHIDq1VtFTkeK5ZLJF17iU3DVLZSE3i+9uEV34WUji
	6uezAtJPFpWqah4Dld2b+j9A7izUxAae4mIEU5uI9CipLSmcfKdB4H12uehffTorYMYH3EUGGCt
	2d3K9xn43sw2P+wM0SulSaA==
X-Received: by 2002:a05:6214:76d:b0:90c:e7f4:8bfe with SMTP id 6a1803df08f44-9129c780e3cmr115801976d6.2.1789982946581;
        Mon, 21 Sep 2026 02:29:06 -0700 (PDT)
X-Received: by 2002:a05:6214:76d:b0:90c:e7f4:8bfe with SMTP id 6a1803df08f44-9129c780e3cmr115801736d6.2.1789982946186;
        Mon, 21 Sep 2026 02:29:06 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e11071sm3867362a12.23.2026.09.21.02.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:29:05 -0700 (PDT)
Message-ID: <acef563c-8eb7-4c7d-8048-49e3b0545437@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:29:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] backlight: qcom-wled: Fix WLED3 brightness
 register stride
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Marco Mattiolo <marco.mattiolo@hotmail.it>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
        stable@vger.kernel.org
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
 <20260914-qcom-wled-backlight-v3-2-d69fe9843841@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-qcom-wled-backlight-v3-2-d69fe9843841@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX9Szoi2ZIPQlo
 8JMqEVsPHSy2TFgSsp70dZGnnr0DWUwVUUF4f+NUkmKdV8BaSG9h9jcBqt3FyoB6Dp5wjggE25d
 m9fT3OQWsLJuqHkqzUZXNyjIVHQxdHoYbf8I/tzAkorWpjI0AhVHt6Y0n6Wndjtr581n7I4uPgH
 MfkACLBXrXzorWKYdKWPpv4ysJgmNF9J5uPMF7RBEYNLRpm2ukegCl4kg2cEPyXKfXE4enldZAL
 oeBxvmjC3kuKbu3UB/vAjMOkcMSHbN5mpl+d/6FA88z0KNXCDD8Lb4gaJrXz3nCpJPROgnljDxo
 7fAMotEO+5n7Cea9PNcbhIuIXUPXLpG6i+lYCbGxjAb3cqE0SgUgVQdKplf5D6qwgilbJ+Bjy/4
 ABI3Qaory3dapZeEHIN3YfB5j3PNOuY9s2vE1+jiDJ8DqNyjUdlZa+KlPHKFiwE7pm5SidEyUKe
 kts1g1D3DYtvtXzfpEA==
X-Proofpoint-GUID: 8woF4CqDjdczUt9rgF2lNHvGBo1JD52z
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab0f8e3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=fY3HbpO4PgkFXDM8leYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 8woF4CqDjdczUt9rgF2lNHvGBo1JD52z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX7VtObMe9cFhU
 Pa7YDO2YY6Qw60Gq2I0Y/LabeX8Dd6YVVBerT3IoG3FEdfhmbyvR/aS0qVt98+kaf6z/R7zmA5T
 X/+ux7D8Ty2oWz1l6KPeLnUgAsmOaeo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210136

On 9/14/26 8:14 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> WLED3 has a 16-bit brightness register pair per string, at 0x40 + 2*n,
> which is what the pm8941-wled driver wrote to:
> 
> 	rc = regmap_bulk_write(wled->regmap,
> 			wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
> 			v, 2);
> 
> The restructuring for WLED3 turned that into WLED3_SINK_REG_BRIGHT(n),
> defined as 0x40 + n, so the two byte writes for consecutive strings
> overlap: string 1 overwrites the MSB of string 0 with its own LSB, and
> with the default three strings only string 1 ends up with the requested
> value.
> 
> Use the 2 byte stride.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/video/backlight/qcom-wled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index a76158a298335..e1962c2d90ed4 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -54,17 +54,17 @@
>  #define WLED3_SINK_REG_SYNC				0x47
>  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>  
>  #define WLED3_SINK_REG_CURR_SINK			0x4f
>  #define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
>  #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
>  
>  /* WLED3 specific per-'string' registers below */
> -#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x10))

You said 2 in the commit message and you set it to 2 in patch 4

Konrad
