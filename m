Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DED43149F
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352265; cv=none; b=tV+pZqA9SGomVszswBmPxeWYsYHksvsVyCduPW9NeOovazMUJurPoKCRScb+YFTFYT9LCfotDJPinC9FpExnmMOfbSxvhu1P1YssrpJwWqKLHc60vAG9Z22msTIaYNrR55vnVA/rGnPqI5o1HxKUgWt+17Re6H5MDMx9F9Iq1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352265; c=relaxed/simple;
	bh=o9JniCOQwoZ997J2sLZ/aXDXCK5YccIpFD2pRIXPnz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiYCohjJvAlsrhrhI8QcAbZrmOpELjWbdaRBWzeSaE0liI4S2bMGXY3aV+f4St71weRgre4Dkyx5vqw+B02w5SogfuLjpMBNCUAGjPPC1EPK6/2apfzk3Zm93aK/BYR/Mk4QOAkZ6zTHae1Y7H6DIYwNsTgm9DCO7IwWmT/bEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O62LOiTI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GTq9OV5Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O62LOiTI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GTq9OV5Q"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF3wl981455
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 15:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1hUvU7+YPjYZoemxWGudb5HAwYsBJ2lip94he8TAung=; b=O62LOiTIr+OGbYsa
	2foSvydPvNkHVmJAENUjbCvuLzrUhR87vjk2oDpW4PEYBQf/KtjJgOJt7ak0Go9W
	xzoAAu7+KaJgvYQ6TXnLdeC10aDkmcJzLNxolwNfueGhbm//zDOOiweTTPwz99yw
	iXHcAT5At5jCQMFwdAKC6prWW3vEXA70Sk0cuRpV29yFWOBF2AIiJG9wwQS5pr6O
	wwyAHNkZTHei7IYUMR4VTvtxsGaEEunvyasH/fkR5D8HTD5gSiFkFjCLP1ho4RLi
	uRzIS92Sq4SB09zp9mAeAkOOaGdBBPpFRelJTdF0X034L0eh9iW+GbdzkTKPF01Z
	4oDUqA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgsp8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 15:37:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfe75b7dbso10324631cf.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352262; x=1783957062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hUvU7+YPjYZoemxWGudb5HAwYsBJ2lip94he8TAung=;
        b=GTq9OV5QBjppqcLvle3/AmeRg9NxKHjqqSmyO2v5tXQ5tHSJoTrRTrk2HPiVcyV6tu
         JBMNoS0oOA9lWX5iWwiLOJ3JgTsKUyFYqzhtTm/6zLw6efgz5U2/W8R9cO7vlnR5G5TM
         ozzsURlpnwQ2LWcmLjdPsqkJVUMLFSrlbxlgHmfozKyHCHytb0pUXLnzi8C/ryUc1AVh
         O46asJFmILDiWLQ7InDFaeYvZWVItWTQC3pYh9Ke/w9S+VKk++OMy8sjWlk/8AEZ2u0d
         HHoZX40GsbWPTTN6ZjWdwKqpRqIPXJi/3GVusLeE1sb5f4aMVUqRBBwFGp1GLyVTu4wc
         VbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352262; x=1783957062;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1hUvU7+YPjYZoemxWGudb5HAwYsBJ2lip94he8TAung=;
        b=F16ncEgomTlxbu9QRFNnXf50n1BMTPfNSSq9BjQeAr4pdYD+tYAZmpKvy050pfQ5S/
         k8Ky0L1PxWZTRenDXozq+yqhR3IMAiEQ8naDQVmqUywMABK2qakqZ+ORg9rR0IakmfB+
         u59Tfb2eU2OvOHptSs+zn9fxZNW0hDEZQHhUC6CMKiTc3e9qAbnWAzoVRPup6ry3LJA/
         Kk0vqfECKl8NvWDHEP+9n0Q3MhoodhkIKWdvPOV8+93+GUvPkZWS+BvC2kB5ykLVizuQ
         cV0jhDvuitM7czxEdvfxAQoxulYsIArh865I135PNCu2Vi61KqkMdpStLlBEB5BrZAxk
         485A==
X-Forwarded-Encrypted: i=1; AHgh+RrAYAihOi+MzIq8Df4bqupeRAB5xVaFc7PdO6iK+qKSIUnCgA39JaMJEssgh0VyA/nBwXWYdxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQFAbsOnwp2wWRHj9LklYTEFmANUC22qDJR8pHGq/AZuXSRkN
	GBbCkCFq0+rc1nx1uaL97Do9pPEg4uW7HcVLGsgbOUCmwAWL2ioQAmXsqbu6lGassjXjLP5oEjG
	kFuymMywJvi9eqgyrLsBRrqb8BGsw+NgrE8e/3ori3AS4GxT/51cZ/qxcaXE=
X-Gm-Gg: AfdE7clzMI+aiMpvyg93KwnV9G/vW+HoeQX1CRep/wwxsgG1Rk2qWxi0x7KCOL3pzFZ
	HeASNyxhlMvNTnx1svV88ygaeYWESJ8H21E8PokrXZS4Ka/aLaDmqn0yPH2VT+HQ4rp5rMX1bk7
	XP66dww0VqyjyLg0oJ+RkIl3heEnbReVGdc/WaJN4qwjCCG8JreT+ZxEcqTXD0PkDK2P+tAxWnl
	0jyWtnKm1SmqmEE8S0C/miqhp9c3RMyC7Zpm1gbY2eOMraSHrQoC0N0Zh65CMoVqmVGi93mEBGj
	zvLh/xVRUgHujY0tJBfuPhKjU7B6aNAK2JqA9BPylmDa/GSZ/poLAScghnju4evxLGkmSlgHRSS
	iYISVaUuvi0MJCmBDs9vpD3115OTRhgur8D0=
X-Received: by 2002:a05:622a:144e:b0:51c:215:3e81 with SMTP id d75a77b69052e-51c4bddbc26mr100069661cf.4.1783352261799;
        Mon, 06 Jul 2026 08:37:41 -0700 (PDT)
X-Received: by 2002:a05:622a:144e:b0:51c:215:3e81 with SMTP id d75a77b69052e-51c4bddbc26mr100068971cf.4.1783352261047;
        Mon, 06 Jul 2026 08:37:41 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd8904sm4294955a12.2.2026.07.06.08.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:37:40 -0700 (PDT)
Message-ID: <decdd6fe-7460-42fe-9e53-0352f291d538@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:37:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] phy: qcom-qusb2: enable autoresume on Talos
 platforms
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Baruch Siach <baruch@tkos.co.il>, Dmitry Baryshkov <lumag@kernel.org>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>
 <20260706-fix-qusb2-v2-1-8d9cd73b1db7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260706-fix-qusb2-v2-1-8d9cd73b1db7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AvA56M6KJaSQBzv3SPzBC1VcEARHgIMk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1OSBTYWx0ZWRfXyUJ9uwTR1Nnt
 LIXbllKb9sCYvojckPUXAYA9xxPQcpH5EAFmq2P08g/YGRJuna76Yupq3b5/E1BdmSEw0ogshLg
 TtLDc+MYTuQuYoSP0vcRIW5jY2vRwdcblAFC8FQETQL0lX4f9MRyO8U8GXiopaWadyXnjoGEeky
 kPKcU0qDDhasZU/MGE19Cr920kSM86vtILbKnv3QBy60W21BqU5ykV+kvvhc/1eVt+acUdqvrVG
 dvR73LCdnDqLUegLuJZtoYzWBlN8kn/heYfUXY//FZ18rGn6U4odwO2rHTY26VckRuAC7mhYLQ7
 viQrStEdtI57oxdayp3D935f5tlhCn1zYdo6WT/60PCryaGAbLRrDGth9FmT0is9kaUwPR93jJE
 LTTJXhnEplF9YZSVDwI5YQf1s1vsruaHeWYGmiqwIG6RLGfgxKBS7CxTDug+J7ek+vlLtA6iykV
 R51iG5iRyCsXJwitJ9Q==
X-Proofpoint-ORIG-GUID: AvA56M6KJaSQBzv3SPzBC1VcEARHgIMk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1OSBTYWx0ZWRfX3tAIlW5JOAtm
 VFInCKuaSSTVgZ3u0xVvWTbzReuIn/hbWaHfZXUISh6VUi/Wb92FwtZByRo7x76nDH/qhmd8Yo8
 sTbzGCVpf2Ag0Qo6/oBFMOhafTr2wI0=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bcbc6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=w1RBZjOZuwMwct0x8h4A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060159

On 7/6/26 3:53 PM, Dmitry Baryshkov wrote:
> According to Krishna, having autoresume disabled on Talos is a c&p
> error and it should be enabled.
> 
> Suggested-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Fixes: 8adbf20e0502 ("phy: qcom-qusb2: Add support for QCS615")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
