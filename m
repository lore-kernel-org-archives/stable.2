Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AA3D8115
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448006; cv=none; b=XcDqdyRT6UkWrBeZtemzexgep9iKek457vLD1DXH8hQYn7mMzSputa+HgLxWFMrq8jLTi0opprUI+WYUx+xmfJNlQTnN3Yvng/A23DF5pp6zPfrNJdlEoPgzFLSLW9za0dZmxpE5eqnjnwQbCOh6s01ROiMhhH+GGao15hTbAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448006; c=relaxed/simple;
	bh=rEY5l0iVfrsuPam470fa6kHhUaPkw3/kKcg6uXvE1yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRc1gNpcb4WstJ6EHnbzLMRrdz29sFfFbNKDKs+/+a68DBNIt0cp2lhD4ndHpODl7sRwoodos31yIjutr0XgDMF40MH91uQ1bIQmqxhPSLgM7LRWUumV1PumpGkIzn3sDcPsW4nIlS9s2C0w7N9hpmJP1rOpZ+Jl0x95KPAi2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N0LNsfCv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nkvb7+2q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N0LNsfCv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nkvb7+2q"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F2nPWC1758051
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cpZr2026EGm/eLzB8Zb79A6jAwwpRMzfhRw5jUZ8oS4=; b=N0LNsfCvGJsh0nhX
	gInT4SvYULBoRKC0rghmUzBUgaSbjPoqQzT0EFONCW9CsZlWgxs7BWzAQi3FXDMM
	6bfHlpiqpzBAJmDbYqyLXVKUQPYGO1la7s703AIF4qoqeB8gqzmW4MO2JRPbOpGH
	vpybwAECFL1ApyXuHK96SVKxsv8Lk1aQC+TRi8VQZZ4xIr/V8QWdawkZQIWgCo+W
	YgWaX4+Vl3Rgwe0DdIVzs8mo4VoJpuLAO1pGr8/vun4mAFsKv8yYzxObnYGYS6+F
	Y/k1mcXFbWSnX1M7tf+yfdAjgSliS4OBtTSzkEVOJg+CjNYFRLe/5395UDKEAF8F
	0M7hOA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f4f60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:53:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so5879589a12.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789448002; x=1790052802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpZr2026EGm/eLzB8Zb79A6jAwwpRMzfhRw5jUZ8oS4=;
        b=Nkvb7+2qfBCu80k206Cllj9PQrcaozneZiXCzwFcudu7KwYPitN17xsbD5C3JJ8s+P
         Wn5G4d+oKRgpl0Bx0Ju70wF1QvsG7DLw9NpEkpf8mJNhkaCSxgtak0LGrHmnZ3QoXjSo
         OpEhPkbSy1J/zpSI5QqanjPD9m8MjYoyO6RqwaEPY9pckwyEkR16NG72FJyK3xftA9q5
         Mi1TkzKvJYOhwXdhhfMZJ2nPyu/E5buXwHfpzeOhX8vzJf5mznT+I0M+pd/xXAfEIhsk
         qS2yCa9nZVI/PMQ6qpIGay0NDErg/C11caxlOxP88wWNIDaeIvbRQnl35d0A3m1qYIpT
         u6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789448002; x=1790052802;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpZr2026EGm/eLzB8Zb79A6jAwwpRMzfhRw5jUZ8oS4=;
        b=e/HsQb6WfxI06Prj6+ArgO//k1kZ8QVONhpDafWR66rop3z3+ptIsway1YdUSgq0Uz
         y6V+8k9G8LZU81H7jr9xVJSEFVUZpVtp/uZDB88L9dh503WD4bFbC1TSiSNindO7UTVQ
         gJvkytjInrjvYoBG1Lo7uvEPLb0/2Nj5foI7ei3i1RLwM8Y+6ikkTpTi55X1uCdUF/BH
         8JtJ2709ZYKH/rgR8uuZE1nIA+yIXb0RQX37vUGQYltM0E2CMjqvyYlOpY1J7S9lEfE6
         ueirdVM0zFOoLVTW/+FBWHQ54Oi8tcNUdARVIB8+mWxDMB3d9d0vkZDDcV/jfuuD9ytx
         oZIw==
X-Forwarded-Encrypted: i=1; AKwUvByEIOdUuSn6vozNV4dZ6chh2OHkSXpvA+mG3NIX8DvNNSG+upbzflyNmyYn6vR35e09ifczVAY=@vger.kernel.org
X-Gm-Message-State: AFuF++lm55f+RSQ5ElWm7qOxckKsGtZgig371H2d4INMt96FXbgVjKlr
	4rdtcbTomYbnKO+WgqFnnDAbts8v2FSknNRJIG2CcJaOS4c2Sv0nLQ+7ePS8N8LtCtIFoYwyQGc
	Q2W8q+6pitWqLmtOOvFGqKCmvKSoNHrTEaeuTq5SiZPMEljLK8dS9tvhn56o=
X-Gm-Gg: AYBFou3y4wc3X5eQXgJvdt6rc0xe3BWrIV+F0K6q69K0+MIiUJRChMCCKuCZbTre/Jp
	9w8ZPVLd89qZwUraSY51o0H40RIdUiOlJBLpnQGmqDu1aRRHI3FB+U2o9sbKDyv5XTQE/8QD625
	qPe7AyC+FuzYqH0Xe14jT/xYZTr9M955MmdIfhhjGXPDwC5czuWm/B/so/YWDx9yE5TIsCCYXsS
	Aj6wVm5BJ5C79ZZC6WUCyHAnFrD+hnlTQY4pD4yPcGLx/RByR8g1dR/hvF2rnBJBKSWgBxPktyw
	QmosPRNm5HbOVxiAQCrdxAbk8lOlLHVFMMajIo1hXpkZpN8Dq/HGgv0CD3m8PQkzgWoxSr2B2ne
	JriEWQ67Jtx9MyJp7/kkKyqecBEpuabWigNdfCPLNMo1DnJTs8dVC44svnP2mWUAvN5pt
X-Received: by 2002:a05:6a21:2d43:b0:3cc:f0c7:5999 with SMTP id adf61e73a8af0-3db40622c8emr13064048637.16.1789448001614;
        Mon, 14 Sep 2026 21:53:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d43:b0:3cc:f0c7:5999 with SMTP id adf61e73a8af0-3db40622c8emr13063997637.16.1789448001168;
        Mon, 14 Sep 2026 21:53:21 -0700 (PDT)
Received: from [10.73.212.239] ([106.192.34.92])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c657156bsm6002715a12.21.2026.09.14.21.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 21:53:20 -0700 (PDT)
Message-ID: <78ed75a1-6f74-4707-86bf-5ebaddc8cbd6@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 10:23:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: ncm: validate the NDP chain before parsing
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
References: <20260915041111.2429236-1-qwe.aldo@gmail.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20260915041111.2429236-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cjESF6y51ZDH3nrvGjb4-0L-WL02sX49
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA2NiBTYWx0ZWRfX6IaCzM9ZPY9s
 HuKPRkSRv0AjGjucwWGyvAwYJzM3+wOaIVfgQ8x3VSub1bS1knEuGhBSbUsLcBDnjk41or4fxyx
 KngffZDe999xBz8BDp8EnIKjgL0LUNk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA2NiBTYWx0ZWRfXwr3MZj1oyc1p
 WsGqma4M5TxWffC+sRHAldyk6eNta1tPOgpyTWsez495nVumsM5JUsDd5hTf4EpgerKWC9DjfvU
 0Bdhoc0DBYSLvs9ClrBqgFQNYGBZtEZZyIBT+6PXisxQKXtslMkWfwMeO4stIII6w+k2Y3ePDHV
 /eBQVBZGaOaZDmPd0Cf031Vs39Mv+syJGaLTsBHNl4TTTfBl9j7XGwO7UGg2qZgfSuCSD2Bvv+C
 lmTXQtVRerDSFwet5GJc2SZPFOGA9T21YNitENjDXoGUf8v1iifCBKBvNL69ta96BJ65Hsju1kF
 neKEi/fRAmHQWmb8vzVgvGpGwQll0knrsPhzxiHZ6/71ksUmq3KUic7URxqqf9qKh2CB0ggFDfS
 AZmSruQibIA6by8RPPlnYGOT811F9NOdvmDfnRqyHDZIkox0ugwF00N5K/HDWz+bcjUp9W5AjHJ
 SAn/4zc5CljyFwhvnjw==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa8cf42 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ebQaAufLtzKgtO4u2lSP0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=HSZgmaD_RsK9m5tnku4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: cjESF6y51ZDH3nrvGjb4-0L-WL02sX49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150066



On 9/15/2026 9:41 AM, Aldo Ariel Panzardo wrote:
> The next-NDP pointers form a chain supplied by the USB host.  A cyclic
> chain therefore makes the receive path loop indefinitely and repeatedly
> allocate datagram skbs.
> 

Is this an issue with NTB creation on host side ? (seems like it). If 
so, can you update commit message with an example packet details 
indicating the same (or a walkthrough of a packet with such headers 
indicating a cyclic chain).

Regards,
Krishna,

> Prewalk the chain using only bounded header reads before parsing any
> NDP.  NDP offsets must be four-byte aligned, so following more than
> block_len / 4 valid offsets proves that the chain contains a cycle.
> This terminates cyclic chains without imposing an arbitrary limit on
> valid NTBs or allocating skbs before the chain is known to terminate.
> 
> Fixes: 370af734dfaf ("usb: gadget: NCM: RX function support multiple NDPs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>   drivers/usb/gadget/function/f_ncm.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
> index 64eabda2f5..085aea142f 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1175,6 +1175,7 @@ static int ncm_unwrap_ntb(struct gether *port,
>   	unsigned	dg_len, dg_len2;
>   	unsigned	ndp_len;
>   	unsigned	block_len;
> +	unsigned int	ndp_count, next_ndp_index;
>   	struct sk_buff	*skb2;
>   	int		ret = -EINVAL;
>   	unsigned	ntb_max = le32_to_cpu(ntb_parameters.dwNtbOutMaxSize);
> @@ -1224,6 +1225,30 @@ static int ncm_unwrap_ntb(struct gether *port,
>   	}
>   
>   	ndp_index = get_ncm(&tmp, opts->ndp_index);
> +	next_ndp_index = ndp_index;
> +	ndp_count = 0;
> +
> +	/* Validate the NDP chain before allocating datagram skbs. */
> +	while (next_ndp_index) {
> +		if (next_ndp_index % 4 ||
> +		    next_ndp_index < opts->nth_size ||
> +		    next_ndp_index > block_len - opts->ndp_size) {
> +			INFO(port->func.config->cdev, "Bad index: %#X\n",
> +			     next_ndp_index);
> +			goto err;
> +		}
> +
> +		/* More aligned offsets than fit in the NTB imply a cycle. */
> +		if (++ndp_count > block_len / 4) {
> +			INFO(port->func.config->cdev, "NDP chain cycle\n");
> +			goto err;
> +		}
> +
> +		tmp = (__le16 *)(ntb_ptr + next_ndp_index);
> +		tmp += 3; /* skip the signature and length */
> +		tmp += opts->reserved1;
> +		next_ndp_index = get_ncm(&tmp, opts->next_ndp_index);
> +	}
>   
>   	/* Run through all the NDP's in the NTB */
>   	do {

