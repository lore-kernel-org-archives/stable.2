Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782975;
	b=DEommeotBHeYFjkFGl2O3ILCoGX7SNLVLGadbAD6y/cev0a3cPAxx4+O9cEO7tVT3lUI
	 MNYv2HC+T7VpEgJfnNne22lss1XS8LtSCaEjth9JvnveJPo7u6PS0XekEFnG3IZr4+ANv
	 /v2FJ2cqbGlhaFimFknm42vphO07YP3gYaDaRdgbIDMawHDALHQV2zposhQw5Ewi8c+Uz
	 UMyiIbisi6EA/YYDzYeDCwWgfjFTponjMbjmUdxxt813P8kYN4SA0UPpiBAQPp87j0S+N
	 jVJXxnw8b4sio/dMa5ag/frW28H0stCCYR/GQKFtqsk8KX7rwAPJq7I2mr4+L0i3IEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1N1CcmdcT3FVeB/E3+Ym0rYVGWZlRxMCPE1GM0GIUcE=;
	b=D6DslQpwa7R6D9XRdku9rnCFOSuh5yhDy+xb2w/G/DJhwAKVBaX4ROREyThIj3y1rn80
	 UjxBCcLWKU4MVQycZPXnTKJYyJsWhuqqRJvbegIp073Cmcnb2WtAs1OKBeTLUWwmyKNkJ
	 IV0IVAO37/9C63F0aREdJSJ/cuo+SQQHJPUSCKw4uxdnvv4kmU66e6Yi0LeFvNjN2PYU0
	 BQOYEMZX6vOSHWOrc4q9HEluWOPXiDun1jSz7FTtRwK+ezmP/hzgXVVcwMl8mvHo589Kt
	 Eraiq+KCvSfzm6AniRI6lIRWGJEZpjcps2wXwUvc6U6J310RJB0IDb8g4MESivEVhJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yltmxzro;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AVGy2adv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CC606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 800CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yltmxzro;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AVGy2adv
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAsNeK3610402
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1N1CcmdcT3FVeB/E3+Ym0rYVGWZlRxMCPE1GM0GIUcE=; b=Yltmxzro9F0fz3IC
	sKBbAb5Uxce5VqZBvNq/Fgje0i5NCOWL+pIhyfEFZHA+IquEWiWO6pgdB/EHJMXX
	ew9DTVjvABGD2Mg+KGOl58n2qS9i4yywuf3cIZUXu1iABC/UNuNl11kOZ7xmoF0B
	qYjGR6rHsLpbdnyOvHIpetUS+Pk9QcvQ4TmezyYn5BKwRvVhB4e/ORzKiD4c5/gd
	xycTyDq/DJbXc3nVo0+yeNCbtohZb6yu2ROEDfU0KVkJ2R23nS1TU7B9hyyak5uN
	BMtqHeV0dYFyy8aP4gNKd0PGk3P/rInX4bx/E/5AVdRDZ2vodxGXiHQWlyn4kH9x
	+E0tCQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73dh9myc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:36:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso9757271eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795782972; x=1796387772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1N1CcmdcT3FVeB/E3+Ym0rYVGWZlRxMCPE1GM0GIUcE=;
        b=AVGy2advgIFido5xKYcSx40QuS3xc1FPHk+87j4iFDLX+NmqvmaeWOXDQL0ZbV2omP
         FQ14KruW7z+3onecsDUrb1ipzdbg1rmNWYBeVKIFHDW5dbLxj6Rv4J/rd98AH2KwhlV8
         UV8nMFeRLs617dTTuHn0I1DvssJJthNdcSwD7k1S5m5j3DAeqBwP/G1SAau/rWiJQK/6
         fRgD7wPX351I1vOsItTRNgEmKoxfgrXcCREsP8foCkv2UkC5BJtbR2kv8MvVo1tpioN5
         etOkEKOBH9Hz3fka9jGujLkbA9VJi/wAtQllhZ0+gBkh3VrhI0mrf6sCbg/1gvcehjyJ
         NKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782972; x=1796387772;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1N1CcmdcT3FVeB/E3+Ym0rYVGWZlRxMCPE1GM0GIUcE=;
        b=LnDLe8219qu05nc8PRGweaaUy5hzr+8Rvp7+hP/pXsYFF/bm3rnxFBDzEnZCzFCy9Q
         39i/mOIn2bvHANh8nLuakQNJODPvz38WcceAib1u64ShHRVHbvYn+YVUOGV2Kvlrm6P9
         NjQHCtfk6QIWzO5mJQXOFzrr1gJMDkoajsbhBc7YSXEeNzyA1x9xWJ2MT5KZ/um49vl8
         sjvTQAdXc2SJUiqlybqpu/Q7vsLatlv7sjOf9j6cE0nLMHScyDuHdWe+bdyjESeEzslS
         ErrQ0zOjhrcftGyKTMH9hDhiTias8Mu42/dIjkXj3JXPBj9OMqXFr2H64On6Xfyidk8a
         rqSA==
X-Forwarded-Encrypted: i=1; AL+hErGfrZy4CxuIg41fTki8dol59aTa62DZw91eGELNNSIZo/ih2l+cU5FTTs6FnKzf7pI1ygGm/0c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tk0Zg2vObR+OGfsIYVEtci9CW9HmulmT4U9JATPzV813voBH3
	7HewSQD87zG3S7BTPughlgKI7XHkDC0jQ1J/4idkoruIG3Qu/KCwibIj9+2E++LfHpOLSPYMeCI
	UxME8OwkoTP7rgncYfOs3khTLVL8QB4PuP3gihxCkS2pO3OksmxuRJ9l3dPw=
X-Gm-Gg: AZFdTZcg7B1cQzq+ICRpHKVEQ+owLTUNvIAZ2fy5XqEwalGYjRscehHB2qi5bdDdqTr
	zarsuGRskRcoUruT7KQUTxlUgOepglhTbQsG+dqLzeUsQHY/XCtQec9F/7N+Azl+3kpEGH33mlh
	rfJvGxq0Qt9nr5mk6SpfQSuiwbN8RBfRlbQTS/C5Si8dxDn/oJVtrQRKWeBRoMG3HuajCs4Hren
	Sy70pB/SF9G3cpC0j6JTbczj95CDzal9qSzZKbsgEVmP/LlgZVKFw3VcqRE/l2B/QRjJwQBdnQQ
	kzc+kfUGVhBTfbcvV95Lwz/NhmmV+OjY/Bq9q1onSZngfWZudTMluD//bUXjJBzjMJWsKIq+tK6
	4s7sjXZTPFO+JhWoyYt2nCz8RYWPCUw5wKhbPAvnPXwKmYiKxSYIgz8m1Q93iM+jCSAUijOyHC1
	EDDoGE8w==
X-Received: by 2002:a05:7301:6188:10b0:386:9ba8:2864 with SMTP id 5a478bee46e88-3869ba82acfmr18635565eec.0.1795782972182;
        Fri, 27 Nov 2026 04:36:12 -0800 (PST)
X-Received: by 2002:a05:7301:6188:10b0:386:9ba8:2864 with SMTP id 5a478bee46e88-3869ba82acfmr18635541eec.0.1795782971622;
        Fri, 27 Nov 2026 04:36:11 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm80984881eec.21.2026.11.27.04.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:36:10 -0800 (PST)
Message-ID: <a795dc11-2827-4897-9c55-bd4a999e72f9@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:06:05 +0530
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
Subject: Re: [PATCH v2] media: iris: Fix VSP clock calculation for high
 bitrate streams
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261125-fix-vsp-freq-calc-v2-1-9825a64d2a88@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261125-fix-vsp-freq-calc-v2-1-9825a64d2a88@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX7mhi/xt3Ah4h
 vmvHAN2hbIuZa4hXSrwuLqHggUKtmAOKy7ZWh6Leu4FNrPphOg9zssmsejvG4ToM4d1k7gORCxV
 e2meQTEiib3dDhtr+5Sg/2voWrPzHmI7IseHA9NNNOVr4CbQCW+Z9GG7LGzE2Qei6vRoNEdkjwW
 kreJU4kFAW1CAjsW10QEiKRiOAT9EQKCypPPdngMahwFeh44FqhHW5z10iwAtrk+KE+mCiutmGo
 4fBdpEii2csjtFN7LaHvQY54japyQhPGpaGiJVsVEq07X9l61WWPak94it7A3WiB/1L1jDADpaY
 p5nYsMnSKiJZvxbd8O3JB6lvPxMW7X+3/OdAwtm2lv5y3hDCWsyLkeR9PdbmhUSViwFcZ8o6L9m
 ogZj9Bn72UTFAoo920stWWuxaceYexRfanQr3wRxszw01zOSQpm0Ey7zeG3mUkrHBFhjbzi4TnZ
 KZmKjpJDxo53GPDmF8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX31nMzYI2oQ7/
 jBXW1AmqolRfuRGMOICGEUuRqhQ/CRPcSWCsjUAZqPcjVGZz2uCSlVLx27dVS1DaF73ctL67bbQ
 k5ufnLS79EmAkBmv7fTGXBFMG+appS8=
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6b09793d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LyeWGEF7gOwipDuC1LkA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: bEJ-BDcXwhE-_e0My9EJ2ZdtklRLf4ko
X-Proofpoint-ORIG-GUID: bEJ-BDcXwhE-_e0My9EJ2ZdtklRLf4ko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270050



On 11/25/2026 9:18 PM, Vishnu Reddy wrote:
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
> Changes in v2:
> - Used the configured bitrate for the encoder VSP clock calculation (Vikash)
> - Link to v1: https://patch.msgid.link/20261006-fix-vsp-freq-calc-v1-1-53532d893852@oss.qualcomm.com
> ---
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 32 ++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 243bd845349f..376ea758c5dd 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -454,9 +454,24 @@ u64 iris_vpu2_calculate_frequency(struct iris_inst *inst, size_t data_size)
>   	return max(vpp_freq, vsp_freq);
>   }
>   
> +static u64 iris_get_vsp_ref_bitrate(struct iris_inst *inst)
> +{
> +	switch (inst->codec) {
> +	case V4L2_PIX_FMT_VP9:
> +		return 70;

could you replace the magic numbers with meaningful macro names here and 
other places in this patch ?

> +	case V4L2_PIX_FMT_AV1:
> +		return 100;
> +	case V4L2_PIX_FMT_H264:
> +	case V4L2_PIX_FMT_HEVC:
> +	default:
> +		return 150;
> +	}
> +}
> +
>   u64 iris_vpu3x_vpu4x_calculate_frequency(struct iris_inst *inst, size_t data_size)
>   {
>   	struct platform_inst_caps *caps = inst->core->iris_platform_data->inst_caps;
> +	u64 vsp_bitrate, vsp_ref_bitrate, vsp_ref_freq;
>   	struct v4l2_format *inp_f = inst->fmt_src;
>   	u32 height, width, mbs_per_second, mbpf;
>   	u64 fw_cycles, fw_vpp_cycles;
> @@ -484,8 +499,21 @@ u64 iris_vpu3x_vpu4x_calculate_frequency(struct iris_inst *inst, size_t data_siz
>   	if (inst->fw_caps[STAGE].value == STAGE_2)
>   		vpp_cycles += div_u64(vpp_cycles * 5, 100);
>   
> -	vsp_cycles = fps * data_size * 8;
> -	vsp_cycles = div_u64(vsp_cycles, 2);
> +	if (inst->domain == DECODER) {
> +		vsp_bitrate = fps * data_size * 8;
> +	} else {
> +		vsp_bitrate = inst->fw_caps[BITRATE].value;
> +		if (inst->operating_rate > fps)
> +			vsp_bitrate = div_u64(vsp_bitrate * inst->operating_rate, fps);
> +	}
> +
> +	vsp_ref_bitrate = iris_get_vsp_ref_bitrate(inst);
> +	vsp_ref_freq = inst->codec == V4L2_PIX_FMT_AV1 ? 533 : 480;
> +	vsp_cycles = div_u64(vsp_ref_freq * vsp_bitrate, vsp_ref_bitrate);
> +
> +	/* VSP FW SW offset */
> +	vsp_cycles = div_u64(vsp_cycles * 1000, 1055);
> +
>   	/* VSP FW overhead 1.05 */
>   	vsp_cycles = div_u64(vsp_cycles * 21, 20);
>   
> 
> ---
> base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
> change-id: 20261005-fix-vsp-freq-calc-19b967b79e62
> 
> Best regards,
> --
> Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

