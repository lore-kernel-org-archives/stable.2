Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782778;
	b=wSR0klzrVaedxu2dA2Sj0a+rGlBxYRyYOcmSSMvYeZOO9PwVPly2UYhUgXBSlYT+A+iL
	 u07aays42ZDAQrHhsWTt/nYvTNxRvsQan0v9DCgw9LaIg94AAWKQqBXTRpZqQ+205lMnr
	 hFfstAYz7gkpBd8pKkVibzEvQMBCLOZmIMFD39jBWuPxkIffzF0/9o02O1YrG1WU02h1K
	 QDVPxGlc8iIe8IdI0uXYDn6TN/7y0/zpW+9ukXbyw7kRtF+WPIHLf3eoX+5jTNYyx+hTb
	 weOrJ7TIi+gsFAFf9LWTtiLmbe+namOMKoj3HKAKT8zZhN4FppNAUcVxypzLG/MX78g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782778;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lY5U//Y1MoIFQB+NMq1uCHmr9m0HETe5o13kE0TkWj8=;
	b=YP1xj6YN1D9BsVf7K5M1w12Rdkx0rqoNGbqknfepwFihDc+v4nRPaP5KGujPHILn2xpp
	 FnJ7rYwgO4WV6L6O3puHSOvY41pRlZfVNXrfkG7IzyZ2sgI+7DW7E25Yd8tetv9vjdnmd
	 qeRuYZ4Uxt7ifjpt2FJd4DcNSuplryKnxc/IbB0/RykV/M97wVcszxwjQ7QV6ePvarskD
	 VQtGuvkAdf9KoJWXt6XWTD4Yba3dgwr2BLC0iVt81dXBfDO2CgzhYt26ENFEyxi7gi9V1
	 5yA4tymMnF+AI3M6sDep3MyBfh3FnePS8y6gWwUpNqw/4KH/GtcKkQYRoo4IOPPpqfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=avzUtr3n;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jWMyMXIo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD3606A329
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EBD3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=avzUtr3n;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jWMyMXIo
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp9SD2268650
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lY5U//Y1MoIFQB+NMq1uCHmr9m0HETe5o13kE0TkWj8=; b=avzUtr3nZXCAa9A4
	fuB56zcDLfz6KUeZQLgboRX+pXGjRywxmybliYiRv1AQ1m1OaMTk1ukT6MTqP2k3
	8Cq04pcryUblS1gl/0bA0cjsRywGwNr6fVCXtdFFTizxtux1LgyM4d046TpQcXv5
	U/C9IjuAFcTkPJBPuvNzoqrst8cgOIzZUPORcgcwgZU44MgMiBZTe+aq4EO5PzEm
	0NFoBcL4SrhVxFD+PjSolfypgrZ7kRg9yA7AXdRGauPAKolxGeXNWdpGwoL9dnut
	joEqwxaLezUrTXKMCdKawSX1vSewY4glR9e6ZzrCcwp6okqlHhzs7GAIbMOXJt5R
	iQwijg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhhky0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:32:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3854627c1c8so10645887eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795782777; x=1796387577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lY5U//Y1MoIFQB+NMq1uCHmr9m0HETe5o13kE0TkWj8=;
        b=jWMyMXIo+0uTLf297gVrQN8phdqy9X70CP7jPRdd8IQjFX/dUGmosrK8z0BAIome1Q
         DOFWhYLekAtbCw2szPxUSWRHN1FXPQqJ8qVvV8+ZUnVFD7vtiBQqRCP5f7z6c/BnP/R1
         imdshENiXwZyhsekm/KQMcPNaevAuBv7VrHKwk3B7M0naYMvWoOhRzIyeUyM/P93iT7S
         5WpRaqkLIpB8ZC5PZBbDY6wjwmrzmLiKkIsxhJt2T2bJN17fz05+rxTa/ZFEEgDdRDlC
         fQ8bksaJwYfRH5yK6RuyHeUgb+RhtboxwNvQ3HXu5m0WJOQpcxxTJQROxF/0VY9+msfA
         B5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782777; x=1796387577;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lY5U//Y1MoIFQB+NMq1uCHmr9m0HETe5o13kE0TkWj8=;
        b=f7P3nxXy3rOQ5WZVQmezdfhRyV7pAUCwVQm5guRaWT6eAW9tJk3/d4/QlLH2ObwPto
         5bxC5CFgBCXnC/KA5VsdG+le8Rv0Ze12DJPIiKJqyyUP8EZlFZU8TBrUWs5jT5yc6VK0
         ZwEBm2UKZWCj3avxtrOZWrFo2ljLoZWjv3mN0Aw8uo0WQJidJcCUNMZnaHyEhPX7Kjhf
         G+8SUCC1/61OJAt7NbIAbMZAD63NZ4ODLMrCJE8icxJ/sAy2+gN1JLLFCZGLkWt8CpIx
         M4YctE5N8Jsiuv8LQ/XuuIoy80V3c6+meWU3A0D/KY+P6Yr/1hPhcJhUtwlim9HMKem9
         RScw==
X-Forwarded-Encrypted: i=1; AL+hErEoo/5BUdFOFUanuCPWhHr0s0kuiclNf52d73NKLZpc6Pwjwi4b8IwPNMvZr9ayQ4P85iIPDso=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GUvZcJTzx9qyctAoPQX0E/Hk47g9toavzZIHxPQCvQY5rZei6
	GCC2OidZBTKxsOp9IC0+adBEcYTu3/fkndsFD1RMWcUsztNIwDoC6httgV/yHpG29QZX/WmaBBY
	t/RTUn6HchUHiJiSOm/xBDnTk/J2sdN5zQ9d0OACmwAF2SWFuRyq1639QeC0=
X-Gm-Gg: AZFdTZcqsUUiFEdGtsxVWMJlerDza52xyjJuWemM1oLwKgnKz2xJVgSs8qGIbfGSrBv
	1H8EqY5xJfqn02U/fegVb/cDjjZeaR/ZyQ5/yCCuXUpKX6ArF52dJDw2RwQAEqWirEvB8nUr/Cg
	eiiXw6HIHlgQ6i3nM9o7RtEiSc59FomAUZgl6Bt26Yk99pYY3VxhS7y9RvYgUcnSk3EmX0TtEA+
	Baeec0yrGaLV1PDLkfONLPAOb5Iup1VVx1mCa1SeJbXjkI6QS1gztJkG3je/VlD1qi4gOemwdCT
	ouEQRo9WVTndScIeIwcNq1eGqbCyq8eDyfQMjchbEK353Pby8kXiBctSCUu92BZTqtgaRrKf0pL
	+R8iukhJpO4JBDko94NTXAygTI2I2UCHbC7SMd7QhyKQSDuu2D8Ou78j7EKeX63385siIFIZUKC
	XPCKCV
X-Received: by 2002:a05:7301:6187:10b0:386:a193:7eeb with SMTP id 5a478bee46e88-386a1938b8dmr19602458eec.30.1795782776507;
        Fri, 27 Nov 2026 04:32:56 -0800 (PST)
X-Received: by 2002:a05:7301:6187:10b0:386:a193:7eeb with SMTP id 5a478bee46e88-386a1938b8dmr19602440eec.30.1795782775925;
        Fri, 27 Nov 2026 04:32:55 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm39048211eec.27.2026.11.27.04.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:32:55 -0800 (PST)
Message-ID: <576033e7-e52a-4ad6-a594-d64b3fe9987f@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:02:49 +0530
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
Subject: Re: [PATCH v2] media: iris: Fix out-of-bounds read in timestamp
 metadata fallback
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Birk Skyum <birk.skyum@pm.me>,
        Deepa Madivalara <deepa.madivalara@oss.qualcomm.com>
References: <20261117-fix-oob-tss-v2-1-8bbf753a4ee0@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261117-fix-oob-tss-v2-1-8bbf753a4ee0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0OSBTYWx0ZWRfX1ZKLH/2wzN+F
 3sbeNvOC5LsjjyCOo8Z9THLm3wVeywzNWGGY2oMocXgN2CQgR69sALJrYSAsbOo7sUnQ9N25FEi
 rZ6FQOxE6NjVOHUjynQ+N/zpvjBYEZ4=
X-Proofpoint-ORIG-GUID: mG3jpHHBgTy1fxgMJqZ_8pMqwCit4U2Z
X-Proofpoint-GUID: mG3jpHHBgTy1fxgMJqZ_8pMqwCit4U2Z
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b097879 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OTlaKp2eM8LF8brwo7IA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0OSBTYWx0ZWRfXwtek+Mw0U1az
 U5qNVWfYGNt9YNxsCYIKtCu3UFk5Du1rWdKvbo4GEHXqal2PwFgfy5Rr2dm/VeTCPlAgfhitGKw
 gDg9IXp8X37yvfP38kUJtx048SLn4D8H6xwA8/mZqEiXJ6yCJOpMjXLBRRVTjIzolGUDJvUhh6P
 31889ZniM35huI7tAELBVcWFuu0VWoJ+JAY0EVdERKnAdV+N8uwC886xIvNWZINovqKrISzfOpl
 idp+1Vx5NHGPBS6hhRNXvJF3DokhDlvbXuyZyUMZwNyyHfzg9MypTaY4RGz9lXYNgV95yYaczyV
 A/jaydzZmirl5W+f1/4ioPMnro5WkEKK/yYfXW/+2ePItB5zhtal1eP2rTqpFJxPOnKoPyXZ/1y
 pVdHKh3cguT3ceyqFZlwZ2j7KxatxGG59LfyUtDgRO/o3Qyag/atOVZZWuOwwXpgCgPI7wtnpQC
 iHKlHBeD7yLnXXrm8cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270049


On 11/17/2026 5:13 PM, Vishnu Reddy wrote:
> inst->tss[] has VIDEO_MAX_FRAME (32) entries, so valid indexes are 0
> through 31. iris_set_ts_metadata() writes at metadata_idx and then
> increments it, wrapping only on the next call. After the 32nd input
> buffer, metadata_idx is 32 until the next input buffer is queued.
> 
> If iris_get_ts_metadata() finds no matching timestamp in that window,
> its fallback reads inst->tss[32], one entry past the end of the array.
> UBSAN reports this as an array-index-out-of-bounds error.
> 
> Advance metadata_idx before the write instead, starting from the last
> slot so the first write still lands in slot 0. The index then always
> refers to the last written entry and is never out of range, so the
> fallback read needs no special handling.
> 
> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
> Cc:stable@vger.kernel.org
> Tested-by: Birk Skyum<birk.skyum@pm.me> # Lenovo Yoga Slim 7x (X1E80100)
> Tested-by: Deepa Madivalara<deepa.madivalara@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
> Changes in v2:
> - Wrap metadata_idx in iris_set_ts_metadata() instead of fixing the fallback read (Bryan)
> - Link to v1:https://patch.msgid.link/20261017-fix-oob-tss-v1-1- 
> fb86f4cabf65@oss.qualcomm.com
> ---
>   drivers/media/platform/qcom/iris/iris_common.c | 4 ++--
>   drivers/media/platform/qcom/iris/iris_vidc.c   | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
