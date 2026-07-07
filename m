Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E183438B7
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414449; cv=none; b=NmVjjHD3OAa25dkRIU+yRGqPk554nj7HciTnH04xg8Lx4qwJIQHjBKgrAUnoS5mfatknxEmkQpXzJIr7qu8lhjyxOkNZz7MJvEFjqpS9cGYoDcJoXRykBsZCN59gIs+7SRirLVRuRwS0hxzMhXcQZEwByNYzv+34/6oOe0h31+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414449; c=relaxed/simple;
	bh=H+1xQdIuoHy+Nk2vlq10nHbMJcUSSEPlCSoflmw4yr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcdMYVOXlnw1uCF8LMylbmkZVuxBLoC8dEN849C/wwHlVoLN4KwaU+OZTT1PnbeKLaRUusMMxC8LSo10pSGPHPcvcLVCN0SMfBBgNKbQbgd7cOCXCQh+XVWONjoPQyeh0IpHceefKf8PHS8+zYpCmek6AfGl6D8JpWnzOB/iD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G2JApmaw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T2S8RBEZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G2JApmaw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T2S8RBEZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678E2RR3070557
	for <stable@vger.kernel.org>; Tue, 7 Jul 2026 08:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U2n1C9hOFlYsRmTm9Nk1r1gsSE3jJPg/8JSVraPix7s=; b=G2JApmawdiqJgeng
	aj/GqZciBvsdO78F6chdium2PmjaE3aKnRbSyUByGQH845VNNEA+nk6g+EB3f+Re
	IYgO5nLxldGTZb1QyM4MIKTf2StoF24DOU9FwiL3XVTRmg/l2O8lZEvOnMXnspcl
	AikyGa6lvWnIBXhy8U7hKZW8a8avxS9Wvn5wSPy90VwZQ1QVdysUFh73NQ7aiNtA
	bqEiQaABs9KC7LOC8xYiHLRxS4heUlU4Z446hgwCTeY0UrY8GNg8w9lOUyGvG8WI
	JmbvoXtIjvL2xYQrU3aOJCZopIRUuMEL3ZVbYlDe+XStDZWyn4Q3TrihztjcXLaN
	cm5jWQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8h4uj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Jul 2026 08:54:07 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so2530153a12.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783414447; x=1784019247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2n1C9hOFlYsRmTm9Nk1r1gsSE3jJPg/8JSVraPix7s=;
        b=T2S8RBEZWZmF9VZz4CVdUGKtyr6ZUKvIjNxmgy6EpNPlsZw2WAFrG6h++5LBMzXH83
         dsLUQrmBXOjAWBsVDPGWEf98eneE4sRK81vyoFr3ajeyytZ61F1zGy9BBhhtAeZHY/RN
         sfqDCW6WYpm2mE/Qtzio/vbxXR55dHN41yaiAzyHuyxCkuAyJ+lh2S7lrzwlBL8W0qz9
         PZcHGjyoQ+v/QXoEGa7I+olN7reC0XiMf5ploeVAkMBginbn0deEs9TXoX0K4vktuF9t
         d1SeS3DigoTRxlIE+xPhqydaTlQB9GeE4VGVh5HoHI4c30EklNTfoZXG8QWaudxS5wW0
         0d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783414447; x=1784019247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2n1C9hOFlYsRmTm9Nk1r1gsSE3jJPg/8JSVraPix7s=;
        b=G59QoJxhQDXsro4JMoWyxz8moFoY2mscXBsc6tUv7/jlD8s0OSXUOMZ9zuqYY66bi/
         wAielEORdNtzeM1fWvaE5FJjgwYHkyR33nhSLhkX1l3YIJ5W6Bzj6ha9/JiU1yFDEMrQ
         K1ZHd5bwNFvZS6Vh+JE+6/q3rczeihXVT9ffFdOnWYNk9UtjEEJyW9AvCZpPkouwGtW4
         X79fwXyxU1e7bfxhdwpjRfFfrFWPbgxVg4GHe2Kg40QEw48QRakOjaEfP2CT1hbNsiGX
         /Gn8R+Mb2Yi5TcSHgks0fWTMzTIextOfZgPtb2uGK4n7Sz5SxHdyDf9nxWMhcbL7+vov
         5PXQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrXq9rnAZHLkjHZNbyeAsLvLLc+jUwo2IbFXTMTi0VyZdAB0uet+qUdx05zJkuWPXfVvukWQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzSM3zPuTasXdti+J9T7Wdxav5LPpr9WxCr8pTA0R9e3gyyvA
	PcCy5ts+dXvm81fvZ7jBL1/UKJu1Fe4b8gty9QOtZldfUM5x5DkIXZWlIDVwmmj5ShNehn9bjmC
	ZZJKTHr08uaJyndEQbsxSALL6xLeImNJYckL7QnmD1fMGKOaSmqu5rglrJ5c=
X-Gm-Gg: AfdE7ckizn7O/30kyquQ2fMsmmZaycOohlQ7ivjIsePghN3GygbHKbhm4Ce98ZzkS4N
	wtSiuAjjuBvJWj+ozPzauWjFZpyEmG3208VCKNt1a3P/Xi8S1oMWojnuL/zAHZD9jpVx4DsD4Bs
	4s9cfgVwY/hYDp0RJU5kcXf27Xdd60ZhCCpVA6ZFS6mW6bIviHH6vchRyv/6E69o8KhBD/rwHrw
	zcg0wy7hrDYZcRl5KXHfm/zdZwhaC2vbuK5SKxCmqYoXZ2Aj83giGRdF4uZZhf1C2CIMxMlf0Mk
	eNAGZDL67km/Q9stGvxth5lxoCYh+Fu23z1e34poEjaiZIrZayGlrVqLEBVHWwpFScX5BoSkufG
	0zxmMvL3Vl1jaDZCPPFjgVOWandm4clPdnCDj0ReUDFRJ
X-Received: by 2002:a05:6a21:50f:b0:3bf:b68f:4682 with SMTP id adf61e73a8af0-3c08ec8d9f5mr5523251637.7.1783414447204;
        Tue, 07 Jul 2026 01:54:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:50f:b0:3bf:b68f:4682 with SMTP id adf61e73a8af0-3c08ec8d9f5mr5523149637.7.1783414445809;
        Tue, 07 Jul 2026 01:54:05 -0700 (PDT)
Received: from [10.204.101.214] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c865asm6275219c88.11.2026.07.07.01.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:54:05 -0700 (PDT)
Message-ID: <fbed6245-75dd-4975-8193-76edd4587fb5@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:23:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: iris: avoid bit depth validation for capture
 formats
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260707-qc10c_fix_and_disable_time_delta_based_rc-v1-0-33fa130bc535@oss.qualcomm.com>
 <20260707-qc10c_fix_and_disable_time_delta_based_rc-v1-1-33fa130bc535@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260707-qc10c_fix_and_disable_time_delta_based_rc-v1-1-33fa130bc535@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NSBTYWx0ZWRfX/TwGSjjm7mRu
 eedcqZUikKDn1tYxCrACeE8ephOPTa9KvCto/1FozZjZx2Ryo0VQw0rMMFX+BjCFVWsBQa9jd6d
 wLsEZ5og16nGLoBbZ6iFYmyH4ZyGLC4vVRWtknd/S8vMCzem4/VZ9S0hgcAlSqmY9DGIzu8AIy4
 nWzoqYxAFhkhUhs60mETTc902wI2/uoSIaVngnZMHnsqzVIkabT8/ljG6GUJeBO5tfPacxmWC3C
 JRMk7mOEBLXrD195RYYKu2TLZsqqn0xVWIhq7Um7IhHIwnaN55vH9ppMdtWav9EREVjLaufklkK
 4cuWRBXRE7n943HhXXQgS59sImwE5b4vM7FmSIogrIeJCvs+kl16snh2Hot/6bjVEaZULbUW8wk
 iGQAllqiaaUWRWQzgoicMSiHLhB8a4rNau+KgSsd2Eiexv/ouJP7DcQBOFSHL6+KfgBFLsxpxQ0
 HzMyYrkCsr8VkUYXtCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NSBTYWx0ZWRfX5U2eLQPBNQL5
 vSb6HuRSZjnlW+RNyB+7M+dD+x8oPat9eSd0j+VIQdhiBsOUOYipHhQerxA3V3YUySOhqlON9/D
 GTTIhAs0QK5qMAprPOsKxr31gHU7hxw=
X-Proofpoint-GUID: wp8AmpOYBXdeLamL_E51qPXvnrW_1l4n
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cbeaf cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0mt3kmHqsDAWChUqZT8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: wp8AmpOYBXdeLamL_E51qPXvnrW_1l4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070085



On 7/7/2026 12:05 PM, Vishnu Reddy wrote:
> When validating a capture format, check_format() compares the requested
> pixel format against inst->fw_caps[BIT_DEPTH]. However, the bit depth
> capability is not available at this stage and it contains the default
> value of BIT_DEPTH_8. The actual bit depth is updated later after the
> firmware reports stream capabilities through read_input_subcr_params().
> Because of this, a valid QC10C format request is rejected during the

client request

> initial format negotiation. The driver then falls back to the default
> capture format (NV12) and stores it as capture format.
> 

No new line

> Later, when the firmware reports that the stream is 10-bit, the driver
> sees NV12 as the selected capture format and switches to the default
> 10-bit format (P010). As a result, the original QC10C format requested
> by userspace is lost and QC10C decoding cannot work correctly.
> 

No new line.

> The bit depth information is not reliable during the initial format
> setup, so it should not be used to validate capture formats. Remove
> the bit-depth checks from check_format() and only verify that the
> requested pixel format is supported. This allows the format requested
> by userspace is handled correctly.
> 
> Fixes: 20c3ef4c7cae ("media: qcom: iris: vdec: update find_format to handle 8bit and 10bit formats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vdec.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
> index 9e228b70420e..7f89e745a4b1 100644
> --- a/drivers/media/platform/qcom/iris/iris_vdec.c
> +++ b/drivers/media/platform/qcom/iris/iris_vdec.c
> @@ -95,16 +95,6 @@ static bool check_format(struct iris_inst *inst, u32 pixfmt, u32 type)
>   	if (i == size)
>   		return false;
>   
> -	if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> -		if (iris_fmt_is_8bit(pixfmt) &&
> -		    inst->fw_caps[BIT_DEPTH].value == BIT_DEPTH_10)
> -			return false;
> -
> -		if (iris_fmt_is_10bit(pixfmt) &&
> -		    inst->fw_caps[BIT_DEPTH].value != BIT_DEPTH_10)
> -			return false;
> -	}
> -
>   	return true;
>   }
>   
> 

