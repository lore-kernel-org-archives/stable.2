Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794737190;
	b=GDg+TxTncjffBKrpPh5WXRRMelwTQVYX6G4zoT9fKMR/TRsSr6G5HI2T6dYZZp0Sp9HT
	 vPKWbq/jg8IuqUD7mJl7fhiMLrkJP8UADPI5PFk0idGM2ZD001EIl4VZoxjg5AqLUdQCD
	 fZVwJ0xHH5TKZELFfYivF3Aqu1sNR6mLjFf3oOc/BzctTUyzKcCm4DHgL3fHRgniDtHpo
	 hcEbUpF5jr1I0aKXf0owN09NmxKaZSGWZIaQk0dzCgN0yc+dxmzUxVDi1cUJyIdGVYA/M
	 Nd+jAin4v+7vU8hQgjCZAm5gqqPk+zoopPn6IzEftpzepdCGiLxe3qvXasvs+6FJvIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737190;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nCs/TbK1Q7g/vF7JeKiOZLVwlnDyGK+NAQzmLpONZCg=;
	b=NFJtDila/nksZ1qDOL9nMF3cWcLsX+/nrNTThuN/RQflTe1v949/4UuiEz3cIPCWzGhp
	 tuaEaklvy5TFrRBr9TdcqMuJ74gOzncxTgq9+lYTRZdV4zkSvwIxyZTiQ9C+AvGYJrvDV
	 qbp79yfZAdVwQB3F9a/+fUMrpH/pq3ZiUPkg0u/AUEnW2FxAdPRZSyrzGU0bYxK9pAd/l
	 nqn5QNWOIhk1AM1YwCjvVi7c+mEMOuJuzhGGTj7tKXw5o3W4wRQ7KIG4JNml8JSjkkosx
	 xD0BfA1y3CF35rBPS9qMIF18hvx0utICTexbzwSBVzk9oHQfX66kH4XR1S60/2HpQQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJhS6VOq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H854WM9m;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB513606A32C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB513606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJhS6VOq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H854WM9m
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF7wC4H2205769
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nCs/TbK1Q7g/vF7JeKiOZLVwlnDyGK+NAQzmLpONZCg=; b=mJhS6VOqqT5s6RYS
	IZ/goJ+6AJo7F40qNhP0aVD4hO1jV7egquRQwB9YB4R3hpWFseybL4ohva+84uxu
	FsiUro2LAwyyHlsHQNBgcnTes0VeHiBvXQhqVj7urF0vNJx0KXJdHmmUbKOD+0VB
	8+beuCnZaxY+X0OA+rwqLCZQTQfrBjtOGTnlTUxVIao4a+nBM8y4K0Wfd0BmmfWz
	gte5MJZ8vhCO9J+4PrKtIzwiP6sjh8q6Rgr4LfBkwTV6ZYnu/9twHCMUgdhNTreK
	89zGyGLBgv3n99oc6XS3TToNTC/36RsJnwDzwZkcerHTuxiquDfB+9KujyhE8PEt
	51C6qQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk22r2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:06:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91e98bada22so47668636d6.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794737188; x=1795341988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nCs/TbK1Q7g/vF7JeKiOZLVwlnDyGK+NAQzmLpONZCg=;
        b=H854WM9mSmc8X/BzAxncKlKYhigjoXrQ+t+VZGBH+hPXmkWgF2rAjCVcJfaauvl568
         9ep62vCYUZ296SVXRW734CnF+R17M4zjt7dnaFY07eh2n0TTTn/eFq1Aqs+NLCj9dxdu
         5kQ7rp2T+3wvP/gP142sSbcBddPW5A1QUHP6czFTcG+5MNIjgEL2ufovvkuE+umYnx1p
         tvTrMNLA3QvDUXrpZM5b85iDvZ5FUNJqJwB43aYuQsF6bmg8H7Rv4/n2YuOMBbheBxvr
         aAV7Q/df7GzdGrpgl8ceuBaLpKSW8jBMFB3P3XSmI36YZnpgz02B0XqiVPqGg+MkFwxc
         nP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794737188; x=1795341988;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nCs/TbK1Q7g/vF7JeKiOZLVwlnDyGK+NAQzmLpONZCg=;
        b=i6/rNCxo1DfY8sOYldbw/z5u06GCmEK2AHHJB5ysfN7+ZBL3jjNKlk59MvV3lNp+B0
         4YfCUKdFvLsHM0cRCgtgwzyzB0LlKOFB6p91hQ0+kCkJhAM+VLANCTDvfTXvV4tip3uZ
         XZ23DiyYv4ambYbnB1+rfGoqvz2SU6tceoXJLjqXlfecQPEqOChftTqcF6TwyCnBQqHN
         E2Y9AEeZR6q8n9ECaqUrnI6wkZmjpuq8nRjS0H8TslF5MftsFbjOzbvdtkX+JsNVZ9u/
         qBSArqD+1rlmw1cRaqQzUk1NSJsGYCL2UMx6QG8c0gkZgk/FYS7coW2qzVubox9sd2ly
         fxFQ==
X-Forwarded-Encrypted: i=1; AL+hErEkLba4tW/s3Tb99vd6kJEOzbK2osqmtBLR8ywKfGWqcvPGaxpowcd7WjUTrLcIEX3wmHsZKJU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LF3Th4D+46hrQav42fII2gzXA6ZOFKET7CUiedZiwlR3D6772
	FwlbmRIJn6aNS2YSem22HryKo+psnm/swBIVDscZSUCz1BWW0LgTYgAERoT6hZXLDzexe182Q+c
	pDA+FxTSLCzxf/EsmLUWdo+VQJQjI10+N+614CGWYDAukMlkWuOeDCsolLrs=
X-Gm-Gg: AYBFou0ee9N/KJ278h7raW9foN8i2Nt1mLfEj8steV39d96Tsln9A9frlyPYfiCT4a3
	7iZN7HauK5oTFrsSKNmYkY43mNcZgGLRmJ9kgiarOuWCpSDlS/G9heJKOj2fEbuITGAOIqb4BDl
	vNdYljdKKgOIGd4phaLmTcg+Mw3XV5ScZoiGAd/7fXJMG9gBy03DdJwOSr4SfACaZUch2AkRiGD
	4WFwTaInUnJ0oiFcLoI+qApx6sBZo98/gQScQN9Y2do2UXm5qwdC1CMUYDpUNpYD2kVL2ZlhCoq
	EWcxgSSNOiUnDFP05bwOqzgRUPQReekLlRkhVp+Ie5iGZ3XN/lf7GaHA3y1UnEOjvhUL3yOwGf/
	uh1WmCPToMxrNZ3MrYVTUwcGafVET/dehVNxSe5Dfevim/AcFBKx/gNTMovVGNHUwtZxPc5aUC+
	k04iqrBKEcY7Rs8ZYrKA==
X-Received: by 2002:a05:620a:2890:b0:93b:c537:fdb8 with SMTP id af79cd13be357-9494ba4b5ccmr1184790485a.6.1794737187888;
        Sun, 15 Nov 2026 02:06:27 -0800 (PST)
X-Received: by 2002:a05:620a:2890:b0:93b:c537:fdb8 with SMTP id af79cd13be357-9494ba4b5ccmr1184788685a.6.1794737187463;
        Sun, 15 Nov 2026 02:06:27 -0800 (PST)
Received: from [172.20.10.5] (82-132-234-47.dab.02.net. [82.132.234.47])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c236124esm3177401a12.6.2026.11.15.02.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 02:06:26 -0800 (PST)
Message-ID: <9cde423b-e71a-4038-9e89-d6ecd7da5399@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:06:24 +0000
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
Subject: Re: [PATCH 1/2] ASoC: qcom: q6apm: Guard callbacks until probe data
 is ready
To: Mohit Sharma <mohit.sharma@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022144130.2443667-1-mohit.sharma@oss.qualcomm.com>
 <20261022144130.2443667-2-mohit.sharma@oss.qualcomm.com>
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022144130.2443667-2-mohit.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k1p0I5GDT5woMexkRD75YON9J9iLH0pN
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6af98424 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=AI3hfGQ59aOwaD8qyfpUrw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DoK0sgpsY2lmbaFclJUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MCBTYWx0ZWRfX667juBGSKGQP
 oV3j+l/+7RsXgNr+FRHwjjXYw82nAQfc3gRDKlNP3Wqh5WSHtJ0gbU0y7vy/wAT8Xkp/VkaRC2p
 vgFkhPHJGvIf/+KqexnjJ7/WzC+1YAbEUSraP+6KJqhxy+j7W6EO4AoYZNxl+5UKZ/A2/BOKLET
 PV6Nb30WFlErloeKCZMaQhRoSdeN/6zXQzSZCYfS5TiGtSoAWFfh6MJUT5FfocYb5/WdB0lj+jE
 DEkPn5W969fUZpKA960srQl6vvxAjE2LO7FKQZ3mPuTTY5i9y/RIDBhufMfK0ZE+IDiAopb5ybg
 Yy5kya5iWrznrBZUeVtzdRexyvKZ9PCjiVR05ePD4UK0uI4ne3M1DhRMsl0TijoLZqcv0dLnGgY
 n8dZTLgLEc/WmIWj/REGY3Y04aS4M0wY4TyNfEac5gpqwq9AksuxS65ihbo5RFaC5xjKPYeLuz9
 x3Oa+EWXJDMXGK3Zx5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MCBTYWx0ZWRfX44Cmd1lN5u4W
 2sDdH5DqXb6AxoU1uxWuNnMCJXhUbb358tw40xnSsvsW1tsvlSP+Aut4G9ISM5EO3hbmqr038Xh
 ewkZo3YTuvX7zUDV9TdVdJCTH3cEh3g=
X-Proofpoint-GUID: k1p0I5GDT5woMexkRD75YON9J9iLH0pN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150040

On 10/22/26 3:41 PM, Mohit Sharma wrote:
> The GPR bus needs to make response callbacks available before invoking a
> client probe because clients can issue synchronous commands from probe.
> This creates a short interval where a callback can run before the client
> has published its private data.
> 
> Make q6apm publish its driver data only after all callback-visible state
> has been initialized. Have the q6apm and q6prm callbacks ignore packets
> received before driver data is available.
> 
> Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
> Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
> Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/q6apm.c | 6 ++++--
>  sound/soc/qcom/qdsp6/q6prm.c | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
> index 3ec3c5a18c7a..dbebb643cd5e 100644
> --- a/sound/soc/qcom/qdsp6/q6apm.c
> +++ b/sound/soc/qcom/qdsp6/q6apm.c
> @@ -872,8 +872,6 @@ static int apm_probe(gpr_device_t *gdev)
>  	if (!apm)
>  		return -ENOMEM;
>  
> -	dev_set_drvdata(dev, apm);
> -
>  	mutex_init(&apm->lock);
>  	apm->dev = dev;
>  	apm->gdev = gdev;
> @@ -887,6 +885,7 @@ static int apm_probe(gpr_device_t *gdev)
>  
>  	idr_init(&apm->modules_idr);
>  
> +	dev_set_drvdata(dev, apm);
>  	g_apm = apm;
>  
>  	q6apm_get_apm_state(apm);
> @@ -930,6 +929,9 @@ static int apm_callback(const struct gpr_resp_pkt *data, void *priv, int op)
>  	const struct gpr_hdr *hdr = &data->hdr;
>  	int graph_id, is_pos_buf;
>  
> +	if (!apm)
> +		return 0;
This is going to silently drop the responses. What are these packets?

> +
>  	result = data->payload;
>  
>  	switch (hdr->opcode) {
> diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
> index 2042ff1e8ff1..5c927ebd81f4 100644
> --- a/sound/soc/qcom/qdsp6/q6prm.c
> +++ b/sound/soc/qcom/qdsp6/q6prm.c
> @@ -194,6 +194,9 @@ static int prm_callback(const struct gpr_resp_pkt *data, void *priv, int op)
>  	const struct gpr_ibasic_rsp_result_t *result;
>  	const struct gpr_hdr *hdr = &data->hdr;
>  
> +	if (!prm)
> +		return 0;

This is going to silently drop the responses.
> +
>  	switch (hdr->opcode) {
>  	case PRM_CMD_RSP_REQUEST_HW_RSC:
>  	case PRM_CMD_RSP_RELEASE_HW_RSC:

