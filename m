Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF838F643
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905455; cv=none; b=a+xR4ISOn6paUJIdPzfsYyMfNzVScBh1FVlYhVwe5noWPqE3UB5Koc6NeJItkH4swk0OkkTbKGtYLiUqS1xmbGjjOcGXws8vt7zML1rd07ege0jpCJpuGwxA7+M8f7R7+vdejWKK8pOULy4hz1SiuFvBWPrp4lLjIR62hmZg1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905455; c=relaxed/simple;
	bh=7xl5ZJ1KevTPBNN+h45CaAdKyk7R/YqHDdBsPsCvuZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFH2X8VnQ5FsYV0MKTTLCyX/5v46/zQx6F686GeSkCIsLIOAjn+oM+MjHm1DtuePTRNehWq10mRyIiolfhylTuHili5orbjqTxRiNgUK08EiBIbylZTpG/ZtZOPwZI9iIWSzpFfZ9sxWkL8B3FuF10oX/icRweCsh5QWvGXlSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B64M+k14; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qn1OiNiA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B64M+k14";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qn1OiNiA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OlYh2347183
	for <stable@vger.kernel.org>; Mon, 8 Jun 2026 07:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	inrSZaqSNNfPmqqbbkk6A/tclz5TUzd+4OzD5QMl0o4=; b=B64M+k14a8dzXt9t
	pFcpXMZRmFGsxn+n9iPEZxzHjZKiTj251qd6xREojiAphU8r+OOYwMgFAT1SfXY1
	o/PXmow4P024ZA6UP+DRzFkOHwFmPcAHxFtgMoWnSAvlFnvKmQw+EEes4XpByJJk
	FSDAHXcL9dpqZZIvyKBpK6r64IOoju+P9xgSt/J4XtpeWwnuy1NjpZtXg3QHuDqZ
	ntGJrBrpGI+E1mippHkJzLBc6yYmyB92DoTRJ7NFLvYyWaEHWR4cJQj6GLUjfYkQ
	5kAs5eShUrDzXr+FRqgCsJiqw4nlyR1Q0s5ML1S2VX6WfIDxj9gmo+/5LXHtsmKY
	7AaUgw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagrex8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Jun 2026 07:57:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51759082206so12317731cf.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780905452; x=1781510252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inrSZaqSNNfPmqqbbkk6A/tclz5TUzd+4OzD5QMl0o4=;
        b=Qn1OiNiAhRvw4MvuBpDmK4398l/gK5XclP2Gor3MvWFfrT0S2CGIKaejOiuBnCGTnh
         AUINF+JUmpB28DYMKVX6nCQZ2xe89A6ZYHmVzdt990O3scRlYMhzLyjlmpf/ugAO7PA+
         N5YNPM3jwKCUKH70QEdfO1MLIUqrt+fU5NEmV4T3r099axg4mRsyyppYaeBHjhy7VnvX
         FNMWB+6XRYHm+zI5VqsGoEkJESiI9CszIjtFVERnBRWlWB6og4ZPNkw7VLUhx6Oo8rgP
         aA5FZaT4AkYQdMiZ0uEGnpU1zAak/tHU4pVuBPEDICxFY75uq5raq0fHlvnU8MoaVBGQ
         3NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905452; x=1781510252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inrSZaqSNNfPmqqbbkk6A/tclz5TUzd+4OzD5QMl0o4=;
        b=jg3u/ngS4H+jApMP8NjTOnhd1Jy1PqeE7YxD159nolw6A1lKHIjyH4Xq4WMy4m0van
         tP3kIbjG8bVrvjtLkA+axNjNDTer17hZtHRz2YHmBFG0SV0ZNZYQznf2wieu6WjRJejs
         odVrDW6QzwBgDAV3+JunGfOYoC9PBc4Mgx3QzBGl1vP69DP9Ir4Lslr69+tH1QPei+fW
         hfV+SbxdQk8bcP6KRacGJpG4hr3KkI42PLJV/B2jcv/HpHDoxIxyFnVdqTStfgjXj2bi
         OXt497vxQ6YRcnQdCwYeK9G6sPZzW1CpiOYhVcQK8EWcuyjwseowSkL0WEsnuo+rA4pl
         TnSw==
X-Forwarded-Encrypted: i=1; AFNElJ/KOczywUhfazSL0QpcSvcLCCcjISDNLzjkS7j9uW+W22RkwOkuV0Z9VbNuQVSSXsgPFDxl+Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzalGyGNejA+s0yXYcIQBpM3mQOpnsLrwO2NSYrqVEKLugEt8A+
	bBXC+iN9AaVavWgTBRYvY4cy0bGc/ot+8cli1wFFN8ouqWjAkeNoSXpVkEI7WiL4e9odVN0WWQB
	AMB4/DdktRAx/3w14U575B/ZR5NKzhBTkCMnGX2JTHPBftifXHfjRWUsPLWw=
X-Gm-Gg: Acq92OGP/6BKlQVz72w5aksJmnKzn9YTSGxS2bAHo78YWkPEczZq7WwAreTS5Ab618m
	nyVfNkHIb2RhjxfjMchVCB+Mp/lSLglF56GKFq7itDqTROhu0xs4FdQrosI4b+d21l3fT/Fw8W+
	hRPt8r+Jj68aAbDUnjxdHKztBXWmqI3AwKPH2zjpRu19s0lREy+DxO9nCarHdO4eXd9+kJ+5S9l
	DauAWFo/Bghkv6JB9UHxR1d9m2UlHQiMAXgndjJazHaUMiGgFIXR+uhhfrUozkUHzO030Hpj++m
	9l6kdcLzcnqxy0pX8klokvmBXG5xEZa8esTlSZSqtad5rs/QfhcP71sUEcHOyADCqkNtS4SAxI2
	1fyWdgUwDEeZYUQoHqiPWDQf5WXaETVaGUDghkuKgr8KzOobcS9z0ddOT
X-Received: by 2002:a05:620a:7113:b0:915:769d:56e with SMTP id af79cd13be357-915a9c1326dmr1339166485a.1.1780905452592;
        Mon, 08 Jun 2026 00:57:32 -0700 (PDT)
X-Received: by 2002:a05:620a:7113:b0:915:769d:56e with SMTP id af79cd13be357-915a9c1326dmr1339164485a.1.1780905452100;
        Mon, 08 Jun 2026 00:57:32 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0517721c2sm798793366b.3.2026.06.08.00.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 00:57:31 -0700 (PDT)
Message-ID: <f2dc655c-8698-4db7-a18f-069f215f011f@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:57:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] crypto: qcom-rng - Allow zero as a random number
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Om Prakash Singh
 <quic_omprsing@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
        stable@vger.kernel.org
References: <20260530020332.143058-1-ebiggers@kernel.org>
 <20260530020332.143058-3-ebiggers@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260530020332.143058-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3MiBTYWx0ZWRfX7pkRjbtbtQHO
 bsGEZH2qmu2zqx25v8Vro0iwCZMgJZqrErrYiZiiVt0apZaFGDsl3P3zL5Kaz1ZQNsEHLkHxSe2
 6LS6JzKkSY7C5YXIZC1gOdPV1C5o7yStRd28/J0XthtoUi9mvLcXBPSkErx9Q8Ef7hnr/abUysm
 AUFowIZMJ8skqUhowI8qGq1DICxwEGuXo/vcQ8l2wjlaA/QMJS5xsMWGF55xgLEeX0mFh1h8Siu
 jeOwzR3vIqMo1U/UFTDum+wnuu3LR147g2l1s1a5W6kyPwlRvkbLZ287AFsNKVGGrsbnl0etaye
 EReR4B4bJfXWBu9JlczgFWl1F89gZ3UCDu45404NivmEPdcgyRn9B8QOAEy7P28zmbjtXP0nUEu
 52r2TX1SGVcB/Mo9oZcwjONd7Jg2X38NapY6myHVm8xcMjKxX/DG3M/M1nGTFJh/GDRL3wVA0J/
 8FOmp/naNEVr+4L3Jpw==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a2675ed cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hpjdtu9zJg2xOlDm1gEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: a7AsdTnz_iXMcTd6C1TRRrr5OWnr_wOk
X-Proofpoint-GUID: a7AsdTnz_iXMcTd6C1TRRrr5OWnr_wOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080072

On 5/30/26 4:03 AM, Eric Biggers wrote:
> Zero is a valid random number and needs to be allowed.  Otherwise the
> output is distinguishable from random.
> 
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/crypto/qcom-rng.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index f31a7fe07ba7..b7f3b9695dac 100644
> --- a/drivers/crypto/qcom-rng.c
> +++ b/drivers/crypto/qcom-rng.c
> @@ -63,13 +63,10 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
>  					 200, 10000);
>  		if (ret)
>  			return ret;
>  
>  		val = readl_relaxed(rng->base + PRNG_DATA_OUT);
> -		if (!val)
> -			return -EINVAL;
> -

nit: in case you respin, please keep the \n between the read and the
following checks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

>  		if ((max - currsize) >= WORD_SZ) {
>  			memcpy(data, &val, WORD_SZ);
>  			data += WORD_SZ;
>  			currsize += WORD_SZ;
>  		} else {
