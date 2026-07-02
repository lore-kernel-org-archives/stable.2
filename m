Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B87243964
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971371; cv=none; b=GwiaQHpw2Z1IDRfvzG360ooMY4234zsJJXPH2+1gvATJ1KemZcaTd01b+Vu96AVncqDLtSXQnvlL/yQTde4fwhMt560dyb7JgvojZ4wsujEbAFcjM8DJPp5W3wk1zGHruBOJEUfPwafbUtvEdP2MZnnDXm3nVefZJ6262adRxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971371; c=relaxed/simple;
	bh=aJnuu0wlVteHr2Uj7gxZfX8Qm64eJYYGerVwVSmxCes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOZChyBiJZ6xk1X0VMvARY2s2ktMN47PmYD2jHBMi8kvAz3axUnGbnp/ES3N/0RBIIEG2by49ciMY4wUPoOT0VPSWYsNtzZGN9oa2SEffS6tQrYEI0hAYnsqCZEzWJkfjt60qAD3L6c+X+ODUKBa8FGGN2gdEV9LbUAh7hUWER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkYbyi3O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hhH0r29m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkYbyi3O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hhH0r29m"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624mavF3489492
	for <stable@vger.kernel.org>; Thu, 2 Jul 2026 05:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d8sYBEuVXBBjg1Rwjktg9Va2aFEZkAw8WMxXti82Ue8=; b=AkYbyi3OZbk58kOr
	te5Wkq0Ir5KLHGtOon2VuWfjfRVYPtMHBtXco4xvObvw+7IlwMmXVO/GPFEdlCZF
	MypwpKwh/B/85UF7D4T2vJkrXjAy4LIYvw0JcX4MhIYlgyYuBaaF8NtLNKdX6QAs
	3HGCORrLIFYDeX3Uqg0iCTBZiM/HYNKccYJvbEjBTWjPisc4XcqnqUwjtBxpXOPF
	QtKPF3XEprAzRBLCo0BlZRx3xc5Wh0n74B6c4B5Cy5fSg00js9XfIRpKYzZ99VrZ
	eDJQW5caPJcVzsoVVT4q6KTsKBXG0pC3+si4MgoCGFxDkgwHMTc8542YumOfp2RH
	b3Y6Xg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98g5kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Jul 2026 05:49:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c9960cf96cso22158575ad.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 22:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782971368; x=1783576168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8sYBEuVXBBjg1Rwjktg9Va2aFEZkAw8WMxXti82Ue8=;
        b=hhH0r29mpw03ste/8Itn7Pcx/F6UCpUTdq7/iQFYxGPfXv8GAHGrBAqZnMYeJeCebJ
         lYhCvMJXzC5/NhLZyKIDNvNfL0Pc9Io+Q0hoSRtxMbe7VMvCcNcil2/ETE8ClrOrcoyZ
         B9G1b+/7mpg26QR/51qrHn91MKkMCq2qwADHLR575bDoL0FjugjnyX53ksLh0EM/tJrx
         5oHtqqvHFF+IHeHImOKtVbMj8zHOWREiOT5FMnF0B0BK2aZibwDoHGaES1FjXYUx2Rc7
         ym7HVGpfBACji+EI5imdorERwT6KZVXjQZlh/DlfRhvKYZffiIF2gV2ET492QlfRQjS+
         sXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782971368; x=1783576168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8sYBEuVXBBjg1Rwjktg9Va2aFEZkAw8WMxXti82Ue8=;
        b=WYojLMa5VV3PCrn+vrsCZpigPdOWvvH3xqNB1uzi73KtHVdAHs1nQpytfjkg70wLVZ
         mVsy7ahapIBjqM72CP2gCmEksJ4iSVAqG9ioTwdLMm4bFvDcwuzE0EwdDkEp4T4qcTIb
         MsIhCISeFxltz2Wj09J4UMJflg7rSQ32YmOS5mWPAy0Vdfzd7+wsUfhpu+seEdQrOCyA
         ++H7R1LV9fk1cg+c3yy7JC+vl+dh79XPVmJaVnahVUK5k4ETsFEqAeyu2bRlJs5i6/RB
         BAW5LvIMU94JZImvvoqW9KneRxYFO59pIGHdUl9GLb2SNGqCY9DfgaDeHvYWL70mlxK4
         BrHg==
X-Forwarded-Encrypted: i=1; AHgh+RrfHuY+xpAsFJ6202+iVcnrK1lp1srk2yW5+r4XSKOlhJH+npUzaBIgQxSYL5r3iLHhV7DjvsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2te6ntydKuvBONuEVYsHU0SzR2jau8a9vYGXjiFF1y1WtLotG
	GP34T3qMkww8PfmiV3YPiCfGuhY2hc/w8FTxb79RHs4YZ8UGxPwHx91II6NQmuk+tILZ0zH1K+T
	PVPFPNuUsVPgsiECCWXan8ero0brX9bT4VYdHo/q+C2JpKtqUDKg25hR9o68=
X-Gm-Gg: AfdE7clOkoQ1jASkSe9TG57efatvsBL32gmtZUCua0mrfva/YzK+6Q/2fSNZtAKUYoD
	jXdKqzE1bZIant9wlXpWfNlqYl6sZn7jlRm/SauAjET9uDXRw5eYQLNV21cTxVIxKRzE1qaITTa
	9mRQVu+yyLAiwqU+LUTsaNvELXyC5CI8YGo1kllnhm4drcAKnVc+O8L4ilzJ2g2uaoNUzAvUYsq
	pTcXex0diLWVNPVX4darBjrMeuEz5HYy7eqrBO2PrlNw6p7wxFIBV3aWVAYmsD/EwvjATqHXJ7T
	UJG3ZHzQTyL4fDPyARsvSfqnPDEvm/+GhWXYlwmG848DnXnxGj4fE/MCw7857ezcsAtqoKuqwMF
	BI95+VI/XiznC8O4sOsb7yfzpaxP5UZq5YgTQhfGSQh4e
X-Received: by 2002:a17:902:d48b:b0:2c9:feea:4e50 with SMTP id d9443c01a7336-2ca7e71111emr48372945ad.10.1782971367881;
        Wed, 01 Jul 2026 22:49:27 -0700 (PDT)
X-Received: by 2002:a17:902:d48b:b0:2c9:feea:4e50 with SMTP id d9443c01a7336-2ca7e71111emr48372605ad.10.1782971367329;
        Wed, 01 Jul 2026 22:49:27 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dadd7sm8058965ad.6.2026.07.01.22.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 22:49:26 -0700 (PDT)
Message-ID: <46b85bf0-05e1-4df4-a72a-48957d01acb9@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 11:19:23 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: geni-se: Use HW PROG_RAM_DEPTH to validate
 firmware size
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260701-qup-se-increase-ram-cnt-v2-1-0618a19f26c3@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260701-qup-se-increase-ram-cnt-v2-1-0618a19f26c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VwWrjl1Z1ZSC4DJJJ5nAYtG-2RX3I2a-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA1NiBTYWx0ZWRfX4aB1w8x7bJmR
 MRd24yDYDiDsJcpOSgyGJZu6eV7Bvo/2FOFCeqCdU5ucZ0kZEtWoGp8+BB3Cu2IdMY6hRtqRHr+
 ne1q/BA4A9tiaE2DfUt7OFfFnqTKVSufYcyLYc1/0m0BNxnnOADCT/ZtHsDtqrQ9hkGHxbLJH8M
 UQucgbUZn5Td4laWMJgovAU1ptgyicyb6/rj9IpymCBIjdBJ3BO6O3a4MW1SrYtpkkegWzlonNl
 Jzblm9MR1QlM/hWFf9Y7A0zl03OHCkjQgykP12dlHhdXZ5+izn3yBJO8vveUe1uRU1BBhpZK9ep
 LwJ5JQWWu82QMYCKCRzgiNTJgjhqNsGW4CI/Vn7ot2BFQVHyzUsCedS0HQf4Z6buT0Kgrv1bxGG
 V0fCv8d85Un+O9RMGKlxbh0f7B87Qlj34Fcsz1t0+L7iE2GjrsThDf8GaYN9GisShdkexxyPNwB
 yv/RTSledBFo8VhXl+A==
X-Proofpoint-GUID: VwWrjl1Z1ZSC4DJJJ5nAYtG-2RX3I2a-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA1NiBTYWx0ZWRfX+4ldilWD78pz
 08aWPILlrXGB4aXXNUCnsDx23M5EfRjIuTxEm1ypqzu85jJIIN5g6BdQ91ymMTXdxvBCmTwAydB
 JcjkSsIh+ci9ErCSZQPbTesiOXh3Ayc=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a45fbe8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=1MucfLtolsqhG_ufqeUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020056



On 7/1/2026 9:51 AM, Viken Dadhaniya wrote:
> The hardcoded MAX_GENI_CFG_RAMn_CNT limit is not accurate for all SoCs:
SOCs ?
> some targets have less CFG RAM than the constant implies, while others
> like QCS615 need more entries than the old limit of 455 allowed, causing
> valid firmware to be rejected at load time.
> 
> Rather than hardcoding a constant, read PROG_RAM_DEPTH from SE_HW_PARAM_2
> at runtime to get the actual CFG RAM depth of the hardware instance and
> use that as the upper bound for firmware size validation.
> 
> Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
> Changes in v2:
> - Replace hardcoded MAX_GENI_CFG_RAMn_CNT with runtime read of
>    PROG_RAM_DEPTH from SE_HW_PARAM_2 for per-SoC accuracy
> - Link to v1: https://patch.msgid.link/20260522-qup-se-increase-ram-cnt-v1-1-71854d0b2ef0@oss.qualcomm.com
> ---
>   drivers/soc/qcom/qcom-geni-se.c  | 23 +++++++++++++----------
>   include/linux/soc/qcom/geni-se.h |  4 ++++
>   2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index cd1779b6a91a..87907f559bd4 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c

[...]

>   
> @@ -1066,10 +1067,12 @@ static struct se_fw_hdr *geni_find_protocol_fw(struct device *dev, const struct
>   			sefw->fw_size_in_items = cpu_to_le16(fw_size);
>   		}
>   
> -		if (fw_size >= MAX_GENI_CFG_RAMn_CNT) {
> +		prog_ram_depth = FIELD_GET(PROG_RAM_DEPTH_MSK,
> +					   readl_relaxed(se->base + SE_HW_PARAM_2));
> +		if (fw_size >= prog_ram_depth) {
>   			dev_err(dev,
> -				"Firmware size (%u) exceeds max allowed RAMn count (%u)\n",
> -				fw_size, MAX_GENI_CFG_RAMn_CNT);
> +				"Firmware size (%u) exceeds HW PROG_RAM_DEPTH (%u)\n",
Actual programmable FW memory ? something which is readable instead of 
same macro.
> +				fw_size, prog_ram_depth);
>   			continue;
>   		}

[...]

