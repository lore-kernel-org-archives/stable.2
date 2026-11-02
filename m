Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625517;
	b=e2uA/h6Ho72Feby2bbdosqxbni3qchOTsUDsnrxASBFSTiDgNqugBxfA+wABihWv2mfg
	 7eKPhzgyc+9wzqZZir4lqgSFG0IMXjBEiwpeUkZnJfQtsnyRLhBT0rtetz7ksr2FqG7Wo
	 Ckv2z7cfhCfhSWFLiYCXicJTCcotwy2fch2r/MIEB26lAf0gzfDXNCWxJ7Bm6Fd5lVBIP
	 07y1erJR1OholiTe0DjFmWc5HG3g1q/QxSjWujsKhkWMCVafObB+PXNf7wj1tVM6sfqyO
	 5Zgt4E00C1KQ1JSzSIDA3nyITsdvbMmSgpHv9BpnQoDyv38/6RDsFi0a9wyllSwqqCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625517;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wENrlcnx/TfX13LE4fmrSq6Sfd1Kg83k4NkVHnz3yWc=;
	b=aXj2+KkPeF70v0hCZuZud9WHXl4S75QYGafaMpiubHbgirDqJxlLZPPCRNleVNCi2uXm
	 RXnBBnAoplG3odOEjcOqSXwXIiXixS5Y1MC7FyWFqDn/I/eyH7yyhIqw6+8kbr2JBb0fR
	 WNhdE+lRTUg5hDE19yPZHoylof0jzHFOHdVZRGAe2MW8qPhNCrfYGV1H2EYEZuEEz6XmN
	 0lITQiCt9/7iYE0ldwrhNxFqynHOGT58UZsOg9iuqtRdhCKs49EMUVXGFiNhtRugXWTkJ
	 JeSEvaNoNeb6ViewG+poQ3l4vpzhSSC0S43nLEgP28zko2fwxBxUFMI3GZ/jD3aHR7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JAfho2OI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G0e8fJIq;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69780606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69780606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JAfho2OI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G0e8fJIq
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAjXL3982164
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 13:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wENrlcnx/TfX13LE4fmrSq6Sfd1Kg83k4NkVHnz3yWc=; b=JAfho2OIO1VS6Znz
	do1h73Vq4cioW0TO68GheEso+i0lhSG/eJSiveij9JZ0IEY0tfSRLr/KTnXZdT19
	jj+QWDf1cKBAtmLdJoNAG5f0Ov3/qQeKV6pinJ5MYshRQFzROLssCmIoFnRGA2ta
	3Ohrf/KxYZZdC0bhYumFSNBYuIEC+2Rni/gozwMYYboy3O2Y+EmHum2vRSHeJy2e
	6ZBh0+gwf60HB84h5pxk/GpmR19d4wSuUAgEr+R4q1LQ3kE9h7B8PVWkq9cwccOz
	2sOFI0SbIoHvPMpPMeZN3IjARoLBlj1qh6AXL+SdrTJm3ZEH9nG/XZU5KgHlq1Gn
	h2CNDw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpss5gc2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:18:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5866886eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793625514; x=1794230314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wENrlcnx/TfX13LE4fmrSq6Sfd1Kg83k4NkVHnz3yWc=;
        b=G0e8fJIq+aWUaHHIH6l3pbYLjlbnMxlhA8rVnREJJCame4jV+b1UUSeMGhpu64aUEO
         KIg2qJiQhkg3Kx8XxklwJ4JecBzH+FnHaBz8dVEH9JqpNIYhUAJ/BrYL3RgSstioPyFr
         7jnxrpNt0e0UqkoytOrVA3l9lf+ogqY5Bpc5+puD/tnDMmZhmYA0/+uOhm2BsciUHCFu
         S96oUCpNV43O+UoD+XzyNhJyT+PxdR+MmiLA3ocGqK9fLO5TnCj9hm/ns6ghvsYa1dJJ
         W9/cnJyBZ94tJn1oSLIPAP6rLOOi/ZZEch6pJTAumEzNiOLGoYYRVDnW5OaXtfulKeqe
         MoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625514; x=1794230314;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wENrlcnx/TfX13LE4fmrSq6Sfd1Kg83k4NkVHnz3yWc=;
        b=hUynE4juBfFb1KAi4unn5e2MWUiJweqsAgYqP/RU+ZlMjN0mOta6ckEyVQVool8lia
         7STqggrWJdH0/w9a8Fsp+/ImwJyoeJ0AdKof57H5jbEpNWwwf+/MrBPkzWRtfKMXG7ai
         BXQEB2698Bs3gSU77epeFAG+G9I2iEdnhFUn7bjzhhUElmQJXLtVC5oRu6uPM2BNgAiU
         A2YsYUkJw+S4NsIluTGNfCps5VcRvR/T8cZLxAtta79eOBFf2lQh0nAubPMXLuwE6qp/
         MbEfv/joHEgDnxYXFNo91aZgXCIstBhwx36sZOhjFzpsBbKlLBTaqKOYiJ3Wesyu/F1H
         X+Dg==
X-Forwarded-Encrypted: i=1; AKwUvBwJDbphHMunqcenR/kgzwWQFh48bI1G7oW6h1rrq6BPdOqiO8RwV9r89/ho+vC3vzceKKOUyRI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwn/CNrNSMOLUAjtu2uFDke/GSe2tMx8Dd0F0ZwMWXXCtIU9E3
	PsZZqgWj4YQSG40e3SWcOIVwahWOdc1lGZ1ZirJXiTy5Kua9xn0kOlk1rdiRGUNYYmGBUC4xCw1
	Uz26I9JxyTTszfvn6K7siqR2izeDZxJbW3XBwH0DMG9uhoHhZHrzVnZBYwmc=
X-Gm-Gg: AYBFou0f3Xnx1sezox1w/1uYY4VqpFyQAs9o/8V/b2s6qy34rVwRxRDd3VcgAzR+28c
	bcsPWpZgSesXMdxTF5wKJIqMAfRe0wURtoXi3kp6FklBmXk1Sy3b3taJywO1GjYZEN8LeO1dp/n
	rXG9AH1e4WPQdk2s1zk+mUl4pnZicLydOGHVYRI1b5m03yLI2VxgmgZh1MtouZJznv1ym1II8xP
	pxr/P8dNS53VQ2mgx8PXDqeIEEJ3MXEw2iZoMEggqteq+OxW6Awt3XiqcdGkWw7DL0iZl8CkHTu
	NQk+xEHxDf42f490iftTMK5SAQgAGkeI6wVerw1k+XWAInq1Is3+42JgYzRJuo08lz81rWFwbDF
	iKk91OD1y6U7B6YbVUDJVLbNuv5exakOwD6iv75E6r7QwXsRuDoDnOUvhb7jjSYfronygF60qBQ
	31iZ0jpA==
X-Received: by 2002:a05:7022:eb44:10b0:186:5b49:90d8 with SMTP id a92af1059eb24-1ac5782fd31mr16463759c88.4.1793625514152;
        Mon, 02 Nov 2026 05:18:34 -0800 (PST)
X-Received: by 2002:a05:7022:eb44:10b0:186:5b49:90d8 with SMTP id a92af1059eb24-1ac5782fd31mr16463714c88.4.1793625513450;
        Mon, 02 Nov 2026 05:18:33 -0800 (PST)
Received: from [10.204.101.201] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1a16sm30918429c88.1.2026.11.02.05.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 05:18:32 -0800 (PST)
Message-ID: <366b19af-326f-424d-987a-bb0fb77d3665@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 18:48:27 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Fix VSP clock calculation for high bitrate
 streams
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261006-fix-vsp-freq-calc-v1-1-53532d893852@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261006-fix-vsp-freq-calc-v1-1-53532d893852@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VORIDNPX c=1 sm=1 tr=0 ts=6ae88dab cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=actxAcgqoPy2R-xb-rkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: gpjz4Ou-avm-v3MI3COqk3jjdOmYdUgf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MiBTYWx0ZWRfX+qtPbUcFXGBl
 ePLFG5KYmOpEkGqcyNzNjSDWGWvePFyjLtMlGwKtz8p28f7d01fIvFuqlGQ2cbZPRyI208DtuYE
 mIBnkFGHY87HLmJg3vE/gxpfWZSgTwahnGTaM/9+Jnm6wt1WgfJWeZjtGC1PtKAusvJ5ECe9z+l
 m03rKKvc9Fweo0nLFnnZA0EsEE/Dfx+c1WVie9mrz/3s7+/dbcwF1NSyI/fXEaN/ZCiHuptv4NF
 Sx/jcYdvjPWYuTfjVxrssQiI/H0yib154mCcFs+iDMz5o6PNyYRvi5kUHdYsWP3WNzTbNHIBHFh
 TEVtDc2FlasmHbe/Gh6ov//Cqui0/W9zk3vZCqYyqHjxK9LNvz6cVuB/TyCBbqiILfRDmMRTW50
 OQixTqevinibw/9cl8FdA1J6yqs7oWBa5KZzx3z8Qj4LSSYBTz0h4PBqD7o1+Ayvnnekk5hm+HA
 WZ5cxJYsG5pm/PgUacQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MiBTYWx0ZWRfX/vKDgXTdH4N9
 /vz+A7Wfh9DIxNMTX6B+Gtj2Yfyi0bXH/HZf8jqCTUNptz5cms1Whvs6rZmlw7LOz+fCJ5ZBlbe
 2+H5CQA5t+qEcewm3qK6xdIB28fmDuw=
X-Proofpoint-GUID: gpjz4Ou-avm-v3MI3COqk3jjdOmYdUgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020052


On 10/6/2026 1:46 PM, Vishnu Reddy wrote:
> Frame drops were observed during high-resolution streams decoded at high
> bitrates, as well as concurrent decode sessions. Analysis showed that the
> Video Signal Processor (VSP) clock requirement was underestimated for
> these workloads, resulting in insufficient clock scaling and reduced
> processing throughput.
> 
> Update the VSP frequency calculation to more accurately reflect the
> processing requirements of different codecs and bitrates, ensuring that
> the requested clock frequency is sufficient to sustain the workload and
> prevent frame drops.
> 
> Fixes: 82b96a8d8d6e ("media: iris: Move vpu35 specific api to common to use for vpu4")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 29 +++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 243bd845349f..c4762229a1de 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -454,11 +454,32 @@ u64 iris_vpu2_calculate_frequency(struct iris_inst *inst, size_t data_size)
>   	return max(vpp_freq, vsp_freq);
>   }
>   
> +static u64 iris_get_vsp_ref_bitrate(struct iris_inst *inst)
> +{
> +	struct device *dev = inst->core->dev;
> +	u32 codec = inst->codec;
> +
> +	switch (codec) {
> +	case V4L2_PIX_FMT_H264:
> +		return 150;
> +	case V4L2_PIX_FMT_HEVC:
> +		return 140;
> +	case V4L2_PIX_FMT_VP9:
> +		return 70;
> +	case V4L2_PIX_FMT_AV1:
> +		return 100;
> +	default:
> +		dev_err(dev, "Unsupported codec\n");
> +		return 1;
> +	}
> +}
> +
>   u64 iris_vpu3x_vpu4x_calculate_frequency(struct iris_inst *inst, size_t data_size)
>   {
>   	struct platform_inst_caps *caps = inst->core->iris_platform_data->inst_caps;
>   	struct v4l2_format *inp_f = inst->fmt_src;
>   	u32 height, width, mbs_per_second, mbpf;
> +	u64 vsp_ref_bitrate, vsp_ref_freq;
>   	u64 fw_cycles, fw_vpp_cycles;
>   	u64 vsp_cycles, vpp_cycles;
>   	u32 fps = inst->frame_rate;
> @@ -485,7 +506,13 @@ u64 iris_vpu3x_vpu4x_calculate_frequency(struct iris_inst *inst, size_t data_siz
>   		vpp_cycles += div_u64(vpp_cycles * 5, 100);
>   
>   	vsp_cycles = fps * data_size * 8;
> -	vsp_cycles = div_u64(vsp_cycles, 2);
> +	vsp_ref_bitrate = iris_get_vsp_ref_bitrate(inst);
> +	vsp_ref_freq = inst->codec == V4L2_PIX_FMT_AV1 ? 533 : 444;
> +	vsp_cycles = div_u64(vsp_ref_freq * vsp_cycles, vsp_ref_bitrate);

Please check this for encoder if it is calculating the value properly 
considering raw YUV frame size.

Regards,
Vikash

> +
> +	/* VSP FW SW offset */
> +	vsp_cycles = div_u64(vsp_cycles * 1000, 1055);
> +
>   	/* VSP FW overhead 1.05 */
>   	vsp_cycles = div_u64(vsp_cycles * 21, 20);
>   
> 
> ---
> base-commit: f0406245cb9855e6318335a8a223551354291a46
> change-id: 20261005-fix-vsp-freq-calc-19b967b79e62
> 
> Best regards,
> --
> Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

