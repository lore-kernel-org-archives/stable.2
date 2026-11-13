Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593873;
	b=NhVe3+YUA9qdXErE4wfUwWjpTfABxgoJndl8ywaj8A0U6sRWyUKsKvT7QsDG+C61cc2Q
	 d+D7lJuNw8ImpQNkuCopWEHQ4urt0pYvBxjZcq4ozUgChXiA4HQQrwxXoFeOF/wE6zu2V
	 ley2NvYTk+razZq94skaApt6oLw82uAi1GNoEz2rxEJcTw3IJKrziuOEJ4X4T3AIx7BrV
	 r/P6vd2ZGzcwE2+YxIDPUj6sAm9tZTdJkY0H/8zVLtZNTisQ1j9QeWw//7WRt/3yYlILv
	 y/X45eiemJjEt6opP4tqmw8n1QDKcN1jtPXw5FqPlig0kaz7U2yj+CP4og37Grsueqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593873;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DIWUBaGuWsD0xZ7Hp4rCkINn5dbjhOkM4Za7aeiZ0A8=;
	b=gPSAxGXv1kvvPeDNd64BcRK40lbzv6F4NPDviTE+n9+75RMfKk5fAmGmYiSY5csNudTA
	 m3vKMpRmqT+93xuFO/TdOFbo+wciaJtg4ITzKnr71PL8D6OiDkOHqSaxfx0ZzXIHluFVX
	 fP13x7yewtBe9JpbZrcCWnlKECOae80wUcNFQSNoSlznv8M/ifj6JuAM9k2JQGuns2XEu
	 2j7nHqmzCiqqH1k+AHDk3PCbvHDHX7K+asVIlK7X5AbQovsfNKdfsK4rV0XpTgZfenz9c
	 vf7SbeLBf47zlhc1nuXAWQqLHLaq/9I5xoe4NcmBahIscVdODDmG+TgV+MeELBK/HCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ep12povA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qj0UwVkW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4E606B509
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F4E606B509
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ep12povA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qj0UwVkW
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR5IK1189950
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DIWUBaGuWsD0xZ7Hp4rCkINn5dbjhOkM4Za7aeiZ0A8=; b=Ep12povAjm11dMKE
	yQPIbH475q3SYP43UmPt7XA+VfVQbMbgxRugtn+ESp2KmiCvTd2lAm/AlY4ymJfv
	6Jwhn+B5w5R/PPWzbIXMD782ZZ7C1w4YqbvC36u/NvXhBRaFcizAQqLJkA1L963Z
	scOjJlUCw70Hh7jiXBrMcIvlykWoMTNzPZtvF+l2yBMKmRLSScRFbw0JclZgI7hd
	fc77H4okzV7k/lpiNMzvTVU3nqOJ9/lUwpYTNBfz/kCwj3c3L/EDcnLlD9GRDLUm
	Vb1X2qu1yFPYuN9VbaffVxL1AMMDLLykNA8De0g2OOAo1+n2gBs5TugY7ugSugqe
	K+piRw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufkkea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:17:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-313c7315becso184288eec.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794593871; x=1795198671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIWUBaGuWsD0xZ7Hp4rCkINn5dbjhOkM4Za7aeiZ0A8=;
        b=Qj0UwVkW/J4uXHaK89gPSJpVTia8nzJfw2bJPKEQWGzthinVL8yukpubyVI9ZuoiR6
         F8otjOmQj0HfKPrAdit0ziL1O+Osv+8jzcw7XznnIv03K0vplRTKfRqq3ul/VhyFSVJe
         wLt9J1Pyf6JSloV3A0HmuRMny/TeRiQNmkbnKuqGlsD+S48mhTlQOKDdiPAAjrgmIOm6
         Rl4DhV58p1UOehqG4+ugVfsj3j77g4XtXXh4M6oXIvmwyqMXLMnXtAmZJt+nfcg+zjPR
         88cIV5czkdaSCN0pANiCYVMOpeLz/1niFjb2eD9F+8d3QX5vSjGUS9NwI2nLcmqIjC1h
         p+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794593871; x=1795198671;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DIWUBaGuWsD0xZ7Hp4rCkINn5dbjhOkM4Za7aeiZ0A8=;
        b=aZfu4dtbTVPJuT2sleDebOV5d1IP7S9YCPxawhfyd2oI1Bd5ex1B834uQG0sXLbuoU
         OrpvCm+ZXoHcs5GyH2BzP734NepVK0lYFzHZsBPdoGfW7fKdyQanRHAgMhrCLAJ9UUD9
         YZGPfPfrYinIU0PsEor8Ikc/6FfN1fIUUyb3Gu2k+oQip3ZHW9XpPz/exOicJWSC7xEz
         cwQWsXgqLH1MyM/+lArAkg5LQQkq1IHM/eRq9yXtKLFlV89IXU4+LWCzVZXjD6FyiOfC
         6eINs+U7l6NHOVQEJfNGVUNy2edSRf35bJX0Q92ApxqgqfquB5AqhhNwT13E6xMJkKLG
         kKWA==
X-Forwarded-Encrypted: i=1; AL+hErH/BSCH8gjfajWhx7PgIQAEWa52A6MvSZFOdSQdCntge9Al0OQDh6Alzg/EFqXG7iUVRMoa6G8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ToTbZQVEOYvL/qpF+rKshMuvakR0lN1Yb1+Ja+J5JHcK5jnlm
	GvrD5R1ddr8+JuzvSJbG489jF+XQcKPIY1PlV5vBMvvji4PjSnizul7aa4cJOVROEhuTCyhiboe
	9ltErXqcK5ISRqF5h0D4wtXzwAZ9rpYnS9C3oU67LRvr73oVWNFAehFWJs/I=
X-Gm-Gg: AYBFou0gtEmEGIMf4xU6XgUsEgJSzxacIFm+yOqpWShhO5GfaQ4iCJFPt0oSfqbdVmq
	YP+LQniBespV1IG4HH4bPpDRkTFTq+Gi0kxN9IESDy9m43ZA1EpeRSNlCAzEIrJagEBAjvKwST7
	lGIwMrbVJpu6krbI9kEhdQ4mxhRMBdO8+Tasc9uvbOcNEfarACQo82Ou+i/4Qund838t+zXRhac
	mMMznp+PlmFISS+Kl6mRpFCVUIhmiOczqclZRiQJRi+9Z2uZeeV62LdAdYtMw8h+lNoBGXcBRAI
	c1W0rGLT+dQ0hfaKtyTjSrZAqXPjX+2jKaIebYgggymMxfmZI9hByw60YjEscHPrUAtl2PbheYr
	u1EKXfSzwX/ckXdVQCWjF4dxjIdNsFpFYXNsJbXyswMgEiNCuL9InIHfuTmbJ6SFLN4Qjx5n6rp
	+l2g763Y9KXtM=
X-Received: by 2002:a05:7022:158e:b0:183:d275:cf76 with SMTP id a92af1059eb24-1b5030dcb27mr5315151c88.2.1794593871383;
        Fri, 13 Nov 2026 10:17:51 -0800 (PST)
X-Received: by 2002:a05:7022:158e:b0:183:d275:cf76 with SMTP id a92af1059eb24-1b5030dcb27mr5315118c88.2.1794593870614;
        Fri, 13 Nov 2026 10:17:50 -0800 (PST)
Received: from [192.168.1.210] ([76.33.11.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031bc518sm8443143c88.15.2026.11.13.10.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 10:17:50 -0800 (PST)
Message-ID: <49eed8d1-0f3d-454b-b06a-b9a7a1c49ac0@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:17:26 -0800
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
Subject: Re: [PATCH] media: iris: Fix out-of-bounds read in timestamp metadata
 fallback
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261017-fix-oob-tss-v1-1-fb86f4cabf65@oss.qualcomm.com>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <20261017-fix-oob-tss-v1-1-fb86f4cabf65@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pr9RJTxz_kK1_OwBXeGtk0RuOZeBdjN7
X-Proofpoint-ORIG-GUID: pr9RJTxz_kK1_OwBXeGtk0RuOZeBdjN7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MiBTYWx0ZWRfX70StBsDXTzJB
 Tq/YpCnq1qBzZ53rwFLTTcgwjs0pw99h7T5dC7czEzbrSblobj3Wi+hM+49R3HBTW5+tLaneGVt
 ItAGvGtcRt5kYEz7YiY3hPd29yTnvFbJo8ILdZUCycLjfIgsMszeW9HMewd8ZpOJXdkZMlp1JTp
 v3cT7x30Y+EIbk968wtVT9CNvRlSAlWnuE0NVdBsWov7aw0AjHwli3cntyMKbuBvcWVAw2E5zcA
 8koK9V5j/UfvJ8WLXcTS1XIuKsmtJe4gNW9nIB6z2zEHZpHQdgcTiEXvXPKAFe96keADg/uVWA0
 wkk88bW4xTsRipgc3qHnho2TBXq4Try7RKFXbO+GT1CDeUSZ3709h4Mc5uJsZbPFnLZu1aS7HLL
 D7+VvEas6lUzLT2/QZlY/nMTi8bTh8yW2usnZ90+XF5yyIM9Iw6sJLhcTTUsVFXq/JqUELvf/hd
 n9pW2CEfaPBxfSK51xg==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af75450 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=yYUYPLL3N79xqptAUcuwSw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gQ9FY97bq1JvQ168ofUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MiBTYWx0ZWRfX+QLF6xRuVxiI
 IkS5LbUZAATVeUOdtOx1Ka8m4S/iBSqh5LPXWrV6sJQdgiBnRxej+A+eNaVt1LdKBZ99ww+qZDt
 Cv/Mw5RnEvH3qBu8tJEC2Nv1m7yDDd4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130072


On 10/16/2026 8:25 PM, Vishnu Reddy wrote:
> inst->tss[] has VIDEO_MAX_FRAME (32) entries, so valid indexes are 0
> through 31. iris_set_ts_metadata() writes at metadata_idx and then
> increments it. After the 32nd input buffer, metadata_idx is 32 until
> the next input buffer is queued.
>
> If iris_get_ts_metadata() finds no matching timestamp in that window,
> its fallback reads inst->tss[32], one entry past the end of the array.
> UBSAN (Undefined Behavior Sanity Checker) reports this as an
> array-index-out-of-bounds error.
>
> Use the last written entry, metadata_idx - 1, in the fallback instead.
> Fall back to slot 0 if nothing has been written yet. Even if stream off
> and stream on happen multiple times on the same session, the fallback
> always uses the latest metadata received.
>
> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_buffer.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
> index eb8de60c1177f..31cba99a665c1 100644
> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> @@ -865,9 +865,11 @@ static void iris_get_ts_metadata(struct iris_inst *inst, u64 timestamp_ns,
>   		return;
>   	}
>   
> +	i = inst->metadata_idx ? inst->metadata_idx - 1 : 0;
> +
>   	vbuf->flags &= ~mask;
> -	vbuf->flags |= inst->tss[inst->metadata_idx].flags;
> -	vbuf->timecode = inst->tss[inst->metadata_idx].tc;
> +	vbuf->flags |= inst->tss[i].flags;
> +	vbuf->timecode = inst->tss[i].tc;
>   }
>   
>   int iris_vb2_buffer_done(struct iris_inst *inst, struct iris_buffer *buf)
>
> ---
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
> change-id: 20261013-fix-oob-tss-7d317d612cf0
>
> Best regards,
> --
> Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

Tested-by: Deepa Madivalara <deepa.madivalara@oss.qualcomm.com>

