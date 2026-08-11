Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF6306774
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452135; cv=none; b=swVLXGZrp+XNKxZjYb+F8u6AhQS/ewTGr6wgdjun4O+csuawMEDnoEIHQOu62Q0kriMMamt5wFiZzRUxFlNXLQqNaw7Zxi3gCRf9ntdGLX7sPw5UdWU4tJL2uNoHFjAXiBEyaIWuKugaTDDW57UeYH3cl3aa9t/Hzu+3DsTxPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452135; c=relaxed/simple;
	bh=eidZb4zvZq7KecO/wJjalrxzCKhi9hoyiPdYriKvyy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsdifK2WOAacRrauGD25e8TYEpOgjxvcU2XQqW0DlTwpJZgG3lPMQG4m/CHxdzmRKk/nI8Afjn+XRmllfZTeJ6A+bq1ewzngkywyRQc5R01NaWtyuVT50Ojr7+S21Y5pOoe+yOCeRn6KIS7DyYcky2RY/GSR14r8XAHPMJvx6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y8j0hori; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XgUlL0Lu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8j0hori";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XgUlL0Lu"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BCRG43543240
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ROY1PEGKINwAp3D74TLO5acMpAX59A9RymK2laqree8=; b=Y8j0horiPqcCf+ns
	zZs2LzI11qEEncRkh3cGYtta4DTPZUqP6l7LJhLSqhxGCu+2HuEOOaIFhcQ4Bdil
	f3QHI4A9kN5IHsO8opSYqmWe8HOKojQYZKvHnBFiylhWm+KXXuvp930+o3/n3HA3
	UC3WJAKB6LrgGxtd/QwMSKug8yFJvpySr43n+fIcrL/YBX1TepZDiUeUmVBWyWgM
	iMHR2A+wWiSJ6irxcCRBbA7E5eBmKUzfgJGlv9qoQIEpnF/B5ndkJU+i6nJ2EQn1
	EU+toplNVuapx5Wy10WtRzpVEz4KjljsLH/kCAKH3rVASHubzF6CVAdauiAJ979s
	ujbv1Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv421r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848474825ffso1138749b3a.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786452132; x=1787056932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROY1PEGKINwAp3D74TLO5acMpAX59A9RymK2laqree8=;
        b=XgUlL0LuWvVcDBfWuAXeqiMDb2sx1zLcTMVPdfRbaPU7bTJX8S3QD7FfxXKpj860iF
         ffcaBl65XZytbCTKTZj2Rt6uW00yrH9jo77+SnpvPcrZaO4UUMdK2RVPIo0MHZ6Ez8uf
         Tjcbxg7INY23yUCiy4VIr3+JrUwTxUu2wi0LR63mJYTUQzAdT1YR6b3iA37LFwK4LpHi
         eW1Du+M9qhr6NFTXJQI0cCNQDBYyRbl1mI2kP1HBlJ9GJAZ1BXVyx+tzW6rASiEFzuLS
         gxzMmdnZtbmJ1uIn8o5qla6+KNUsrpi0vNoslsCYoKs/IBECV7CSN6kb1q/6fzkrTAsI
         u8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452132; x=1787056932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROY1PEGKINwAp3D74TLO5acMpAX59A9RymK2laqree8=;
        b=HrHVBc+1acAOSWt85ML03dPF/p7CJucLYnDpeGZdFvX2I39pIP14bLdH11JkaQH+Ck
         Mi3nwu2Hr9v8CjRzIE68iO1raqi80obc/Rut8OoYVp6wvhXad3xeh1HT1xOUjbu7eLkv
         rMFEzqtcnsIDZoUv1WkSIRWWSKMtMUScNIuW7fhCdfBkgaFBZTHdUR4FIqEGzSSZa3hf
         XlCLlydF7l7y0q0JAyqzuixe3W8D8lLjCA+nOLK95zLRCr3RlwOaY6f5QxBS366YC8WZ
         da4KXEH4RvMRchMLCa3XqO68yr8Etbv+jrDh83N/Ak5XazPc1/GyGiWyQ1awlFZmDzN9
         MHlg==
X-Forwarded-Encrypted: i=1; AHgh+RqPG0MGckLGToNBDd1gCCy8iek8lV3NfjbOeRog6UvwMSuh9kc/QM2Y6dqvvLHpn6KvjgahqEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEm0namAfOZiml9ySgbQwKJv82is08LLjDHMzikex8Uw5k+hl
	b256OWcHVM6+/gu1054jSxtzUTBgC1WvdhlPlRj+0N5yiTBHjlymuOZisWnp6gFMx9mNgF8b1on
	vEvb9O0D3KClPpUNnoyRrOuncufB/xxiQKzMdaBpoyf281T8SAGOJcOocWuM=
X-Gm-Gg: AR+sD135a2h3jjNs+YapD6zRWjLe1bt7aMR0/4xHjKLg5Rz60d556pIwCR0/epGs62U
	FWB6vbbC7GGqWcOE5+LucTCarRA6EV1go8CCJwx+WX67Hi/P1Fhm7bnmyXZq8ptguQmEvjDfY8K
	DSXeG9i45gY2GFODXiW5j6qicPLjtBwIxpQaTHYtvtCjKQNYQ7ep2f+4DpGHFOsVf8MkyrgkQ/O
	rx2aTRcZBfMzBRLRUi+1ltiTDF/IrcGH7xMybQCQM5+BVD4AdiMTuW6BMCxhuyCJUk91Y6f98m5
	EhjR7HmiY9ZNkuSJiLMMxH9JJyOeMlFv8c+Islt+toFyTUKxIy6xsmVqj1Sjuv64OKgHjqSqDLr
	CyYIxqQ81rShFJdjXH9Xtmp+1fLBl1EJAJNar61iNQHTlPM3XkO+0kErcL/5R3LtQArQjzq6W
X-Received: by 2002:a05:6a00:21c8:b0:848:452d:9a14 with SMTP id d2e1a72fcca58-84fa8b7ce83mr2802180b3a.16.1786452131733;
        Tue, 11 Aug 2026 05:42:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:21c8:b0:848:452d:9a14 with SMTP id d2e1a72fcca58-84fa8b7ce83mr2802106b3a.16.1786452131144;
        Tue, 11 Aug 2026 05:42:11 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:973e:782a:16ef:897c:10dd? ([2401:4900:1cb5:973e:782a:16ef:897c:10dd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9526492sm687974b3a.39.2026.08.11.05.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:42:10 -0700 (PDT)
Message-ID: <8a6581f8-e9e3-4c02-8d26-245c102e7428@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 18:12:03 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i2c: qcom-geni: update frequency table to fix timing
 parameters
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
 <20260811-ipq5424_i2c_scl_updates-v1-1-bddcb2ceebda@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260811-ipq5424_i2c_scl_updates-v1-1-bddcb2ceebda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfX5Do9BZ3HYUNT
 DhCyFBSw7i4NVIUz4NrHw3aZFDJoNXOK/yKVEPtbsqUUGNPy8eEoPqigsm1EWUSv9vSOeAjGoWI
 mcFUf7eyLIIZkDL32mi5jJKVlAlSR7KNvAyhxM0RRR/IkNWAGiEzS0NG1787G64X+Ftxru+hdVJ
 yDKLO8Eyxg1JEpSUyJRUDYuNA1b3I9fMC3uMPjhJ2XJ33JDx2mRbEOLM+2XlO9Hl9YXEAoZdfjw
 MMMpbbuvaQFPK/fhFks2HPTXaBYgU4X2G4C/YJKSi4+fidqYuJHNNhYev8tYzwyVfprjC5CCDlc
 VH3PpGIzT8ZhFSzS28cDCr5tFBIKnWbYp/QrZ9WRRFmWsY45CP1IuIMH7gbQrvVQ3LxU3yWwkBF
 kJ35DQkhAY7ox/uLMHGh5yTyk/NEwBuMCZ3z4LlTB8Cn+5WByIoi6uZBVCLSQOaeL42MvIG5yhK
 /arp8eXtMP7fyp18ThA==
X-Proofpoint-ORIG-GUID: cohM0mO7bhi6DclJ6n21yKJW5FKBJJqa
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7b18a4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EE0sPqqNSvbv8NVRKTEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: cohM0mO7bhi6DclJ6n21yKJW5FKBJJqa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfX6izp9pyquomI
 aU4l2XFfSLtzVMWpARJaM96PWLK1U0gtZ79/OyXruVtZ8NTBoWARbzAi6V5yDyXtv6rDGl4S8Kv
 s1gX5GPxcoY8vJr7weUJSNmdMK5kzdw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110106



On 8/11/2026 2:53 PM, Kathiravan Thirumoorthy wrote:
> In IPQ5424, to meet the setup and hold timing requirements in the
> standard mode, update the frequency table with the values recommended by
Changes are fore FAST mode too, please update the commit log accordingly.
> HW design team.
> 
> Also remove the stray space in the I2C_MAX_FAST_MODE_FREQ entry.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 85c34532849d ("i2c: qcom-geni: fix I2C frequency table to achieve accurate bus rates")
> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 658636c1ee0e..00013b41a6f5 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -188,8 +188,8 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
>   
>   /* source_clock = 32 MHz */
>   static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
> -	{ I2C_MAX_STANDARD_MODE_FREQ, 8, 14, 18, 38 },
> -	{ I2C_MAX_FAST_MODE_FREQ, 4,  3, 9, 19 },
> +	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
> +	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
>   	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
>   	{}
>   };
> 

