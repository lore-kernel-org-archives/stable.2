Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915941;
	b=AJpDF2VeFdSYNFdFFWknUPhdk+sa79b4qDYL7ciqGNr+f5sh0S6hxxXzKdqFe4afZj5f
	 NCxZE7IGhoASDH6gKWGLSrMgLuGVvgrtvMeam7cvbAkyWINJXlJYGiBcMUvR7lEIlIuj5
	 cxwkEFzblCN0Udrl951SxrCp73KA8CMMmiykCUAI9gZ77oOk2vhPL46fGL7ErYxh0DBCT
	 08iSfzTmCbX3NoQva2dnbUX2zv/4Oo7JnNRuHoW3Tu6y0qQeed9LEHUUy/qchuGhCpwam
	 RUeK7TNbz6OYRk5yi8opwSnlxJqlMnqHSLZndtdJMXUs34mzVCejTzRprV3VMCjJuYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915941;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZuldvTFGqvoThScV3eP1J10a3bvY6Jb5DSXjzpU3950=;
	b=AEs9rk+i6vGr7iqZdb7n6TU5RIi7cRi1A6Tu3DMp/qz/DD124geiWt4N4Pjbzv9WD9Ep
	 BK6ByhanSQWF+IJKGPdoOh1uCfapGlzUzwVJSqK6MSejiZYj+IHEmdreVAmQONlR47J2q
	 5rjJ1ZuhHBiVogShN3ejKKteeYAratO85iuWV1W4tGziojcWhsiKIKKjufhmOS5cbZOg7
	 ruANu43UHXr4wVsAmaTnDHE4/QNr4kneYItxYCUkbwHotLLFO0ab83eYKMjcwNgqxp9WK
	 uwLhQQfwlWjTyHfAMq7t1cFpEsaJvgACDUKuq7MHGy67voGDS0Mx+0O7J0/xBBHvwLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ef6CtlAd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DKGNStEw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2B606A336
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D2B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ef6CtlAd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DKGNStEw
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH8pdIS2934233
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZuldvTFGqvoThScV3eP1J10a3bvY6Jb5DSXjzpU3950=; b=ef6CtlAdlzQsPznc
	1LfAdj7bPyn+8o1f88i9Yc6QEnL+vdNkcUSHPCOfDxcRGMTo9SYel6SL9eOJ/8rB
	3vhtc5sgq66Fdpbr/FiOqYtn/m6U/c46m/qPYuMYAybAciMR9iKfo2PrEVbLl2Am
	2ouCOYRzSEOk/8sDVIJ/zwKklVDMkTGhRn+/rcr6SO/yvRK4MfICEWh0q3U9PKVr
	Himln70OmQiqFzUIHnWY/Kd/AvKNOXNzQMtxlLyirG1MAxzUCOA1QW5ZrUBuKWfR
	lf9+yGmeeh2l93c87dtbZQck8oEwRXbqQ/upslIidr7qQ3AAFz+ZVhl2em+Ht6q2
	ogUOFA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m0awpd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:45:39 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b238436265so2713700c88.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 03:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794915939; x=1795520739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuldvTFGqvoThScV3eP1J10a3bvY6Jb5DSXjzpU3950=;
        b=DKGNStEw0OOdlx4fL2M+MTRytbVB85jjL9m5pkqJHqf0a8e3q7nmE/JiYpVp2jXGKk
         8YOThlJKCbCSGcznv0W5EJd+gs4fhPlIKxOcbH6jlmjT34NlgCVLNkMCvC4gEuxuNeHb
         OfjLash39isBTiJvU2RDHw56tUOCzAC4MdDWO/qSlc43anTMjgZvgkKoxPSGuPbntCmV
         6SiMT8Md1WKUhAvCdDTvpfmTE3VHCvSN1LpJovCYRUqUVWayKn+3M1eaA2qUpnsCBrFy
         WgPFhEDvKa0ipS2qf0O1opHNm0Lojo8r2CJJtHxsx5xbukFtEnaA5IVTSgJRPmZ+guhS
         0j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915939; x=1795520739;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuldvTFGqvoThScV3eP1J10a3bvY6Jb5DSXjzpU3950=;
        b=UiiLhS5vvrFZyKjSPvAeIX1ms6bSloHpYlfKUnSVvbUiukG5hFaPEjsf7GSdigYcXY
         Aw6PQRBrbbz/n3+lLPmbiOvaG6hsq/MfxX5/WyZKYIKUVCAOannjwSN4GjJ/+fYyAGLx
         ku2UMnudOv1vsaLAZ1elSo18pTJfFntY3xR9wXx982t5X3RKUrO0r41Sh0WMnMAY6Y3D
         BVaxpgI+jRsMONFjp7R4hM51yqjLArPnL2mWz/6ZCC5kq96+RIuHNIJ2TnYQ2YUtzd9j
         ElRMUoQ5MtegmNwmc5pmfzE74nnNHRQ2g8RL0/1acLSe4Egv5XjFEVjtOPumNacn7I+X
         ySZg==
X-Forwarded-Encrypted: i=1; AL+hErG7kxgUVyy3VmzbpLOnOKq/geUnZyhSyCFIfnUraU+Dt4lUlSNDu9j258JSZxjlC2CIT1Hgu+M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dG8tiKoXD94WoSuaUZk0BQYUXaVseAUEs+XS8a4nsyV0PSnKi
	/JK6GNvgwWRwLCEQ53u5wynBbvTKZiAeXqcDorXu2rYHg150xhREdnv+typg8y4SIH/KWNxI9eQ
	Sw7+RkpDrzof1HKjiUMcNSj7IkuhHFNKLbVJ0qugw2Ra5c5xvlQD892R0kSM=
X-Gm-Gg: AYBFou0sihr4sqj/NY0V5x/uSX8mn7JhYKTeTPFq1QF5sRZVpva6lvTSc9Ds1mF8ii3
	HC18Vy1rFaDGi2t4AefdkseCkr4z1KEt8y8IxHdijst6zGzuZUyykOp+ZZotm8qANSXvmgkYr0N
	hCl41QMXo//pScxouIVQOJqIvOe70+VVTzBBxO2aDvIUz2Wq2FVna63o4FRmWLVdLaGMK/Hiuuu
	d2Sl4C2b/b+Kp1MqiwAmOM/Cj5tqIAUpKqPjWLy0GoM6lNNx0x88jYn29ZWTw5dS007OBelZzUk
	1h6D8zY+LhfKZpcuJC+YdAtTnH+FMHfP8t94AvXtQoa8KRLPsbLd2t5aOYMJyhUl97pEsJGQZIc
	3u3JwBhfCayawRQZSmKbmXECYLpUhLYem+4Y1AyECHKPLBplB+w1vaRy9F7kvna3d3oak8f9oZw
	GVXpt1
X-Received: by 2002:a05:701b:424b:20b0:1ab:6b10:461 with SMTP id a92af1059eb24-1b50310fab8mr12608201c88.45.1794915938592;
        Tue, 17 Nov 2026 03:45:38 -0800 (PST)
X-Received: by 2002:a05:701b:424b:20b0:1ab:6b10:461 with SMTP id a92af1059eb24-1b50310fab8mr12608167c88.45.1794915937985;
        Tue, 17 Nov 2026 03:45:37 -0800 (PST)
Received: from [10.204.100.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm46094903c88.8.2026.11.17.03.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 03:45:37 -0800 (PST)
Message-ID: <f8e072d3-3fe4-2538-d88f-26bfd3fb075c@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 17:15:32 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: iris: Fix out-of-bounds read in timestamp metadata
 fallback
Content-Language: en-US
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <MHYjgQwKyl4g6PykXAKsc_qby-VHmaZ8ZyKEoTM1Fpmve-Cg_dUJaQT0a2MReqplHxr4JLS7xunPQ6qB5AlxVg==@protonmail.internalid>
 <20261017-fix-oob-tss-v1-1-fb86f4cabf65@oss.qualcomm.com>
 <c81473c3-e735-44ba-b9b3-ef71a206e4c9@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <c81473c3-e735-44ba-b9b3-ef71a206e4c9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0NiBTYWx0ZWRfX07wSCCdwDvIn
 Va7Sl1M/BXozNfVEQ9W97pvnBeOz6hrVyq7UGvanGoXLM8MCfvb8sY4hH2ogUnNhwJ7tHAyRF7X
 +9M6T3TcQ23dOMAb5RtpX6DYgcFSzQc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0NiBTYWx0ZWRfX58bvx7lR6G/p
 0QXzowsIEGk5z5pYEChSNEHDUblBL0fbVQrvo1wtSJQgsYouW934D7GEX2xq2cnmdhmiHX9JPxV
 ARn70xCqMmN6rhJjIQSux+cWQCT088mn1AmGsH/3hyAi29XJV5YvXLOcSrnmTx0klNkjF+rftDW
 Kz2iojqmXHF8XaM3mDWuZWsNnsoVcQF2HnaUu7jeNkF6rjcr3rFaMUgxaxLerQofyAcHzQrTStR
 2Xtg7JQhEzeldtkLGubfMVJvbU4xrs/+1P4eYerk7F/xej9TxXdkT3yXtTrWrqCP49a5bmaaIVR
 emQ3vHUDKMJqvjpZdXaOrmdAXT9G5Hn3GEJRc0ZlhPb6nHNDIAivBGhWIigHXgvP//s8pwdrfem
 QwD3tULIx88yXKSaRIwF7TgbkAd0RrDoZu5Z1yaYBVNbSAOcrKAdTaZjJ4obNp0J/sn+6zX5jHE
 uAEX3lBQaRawbOiJJlA==
X-Proofpoint-GUID: ugITLwdGw9N4wp2IHD35IAeEvaYmJnSx
X-Proofpoint-ORIG-GUID: ugITLwdGw9N4wp2IHD35IAeEvaYmJnSx
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afc3e63 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=l-SxXqRTaWQHASsAo6AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170046


On 11/15/2026 6:24 PM, Bryan O'Donoghue wrote:
> On 17/10/2026 04:25, Vishnu Reddy wrote:
>> inst->tss[] has VIDEO_MAX_FRAME (32) entries, so valid indexes are 0
>> through 31. iris_set_ts_metadata() writes at metadata_idx and then
>> increments it. After the 32nd input buffer, metadata_idx is 32 until
>> the next input buffer is queued.
>>
>> If iris_get_ts_metadata() finds no matching timestamp in that window,
>> its fallback reads inst->tss[32], one entry past the end of the array.
>> UBSAN (Undefined Behavior Sanity Checker) reports this as an
>> array-index-out-of-bounds error.
>>
>> Use the last written entry, metadata_idx - 1, in the fallback instead.
>> Fall back to slot 0 if nothing has been written yet. Even if stream off
>> and stream on happen multiple times on the same session, the fallback
>> always uses the latest metadata received.
>>
>> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and
>> firmware response")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_buffer.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c
>> b/drivers/media/platform/qcom/iris/iris_buffer.c
>> index eb8de60c1177f..31cba99a665c1 100644
>> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
>> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
>> @@ -865,9 +865,11 @@ static void iris_get_ts_metadata(struct iris_inst *inst,
>> u64 timestamp_ns,
>>           return;
>>       }
>>
>> +    i = inst->metadata_idx ? inst->metadata_idx - 1 : 0;
>> +
>>       vbuf->flags &= ~mask;
>> -    vbuf->flags |= inst->tss[inst->metadata_idx].flags;
>> -    vbuf->timecode = inst->tss[inst->metadata_idx].tc;
>> +    vbuf->flags |= inst->tss[i].flags;
>> +    vbuf->timecode = inst->tss[i].tc;
>>   }
>>
>>   int iris_vb2_buffer_done(struct iris_inst *inst, struct iris_buffer *buf)
>>
>> ---
>> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
>> change-id: 20261013-fix-oob-tss-7d317d612cf0
>>
>> Best regards,
>> -- 
>> Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>
> Just control the variable where it is owned/assigned - the index should never
> run outside of bounds - dealing with that out-of-bounds is a fixup that
> shouldn't have to be done.
>
> Don't let the index overrun at all. That way the next function that reads the
> index, doesn't have to know or care that the index might run.
>
> [0] % git diff
> diff --git a/drivers/media/platform/qcom/iris/iris_common.c
> b/drivers/media/platform/qcom/iris/iris_common.c
> index 25836561bcf3e..b2b9349c38ea9 100644
> --- a/drivers/media/platform/qcom/iris/iris_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> @@ -33,9 +33,6 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct
> vb2_v4l2_buffer *vbuf)
>         struct vb2_buffer *vb = &vbuf->vb2_buf;
>         u64 ts_us = vb->timestamp;
>
> -       if (inst->metadata_idx >= ARRAY_SIZE(inst->tss))
> -               inst->metadata_idx = 0;
> -
>         do_div(ts_us, NSEC_PER_USEC);
>
>         inst->tss[inst->metadata_idx].flags = vbuf->flags & mask;
> @@ -43,7 +40,10 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct
> vb2_v4l2_buffer *vbuf)
>         inst->tss[inst->metadata_idx].ts_us = ts_us;
>         inst->tss[inst->metadata_idx].ts_ns = vb->timestamp;
>
> -       inst->metadata_idx++;
> +       if (inst->metadata_idx + 1 >= ARRAY_SIZE(inst->tss))
> +               inst->metadata_idx = 0;
> +       else
> +               inst->metadata_idx++;

Thanks for the review. The issue with wrapping after the write is that
metadata_idx then points at the next slot to be written, not the last
one. After the write to slot 31 the index becomes 0, so the fallback in
iris_get_ts_metadata() reads tss[0], the oldest entry, instead of the
latest. For v2 I advance and wrap the index before the write, so it
always points at the last written entry and is never out of range.

>  }
>
>  int iris_process_streamon_input(struct iris_inst *inst)
>
> There should exist no window in time where the index is invalid.
>
> ---
> bod
>
