Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9649EC63
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997756; cv=none; b=JMRdgaqZF7CgVBIEgmYz+l8TD0Z/Sfjfwn4lEyfPmy035NVrh/yItn/hwNSdGycKcYglEO9PszKaDwXz/CfjJ/H23GRsD9STSJmNdkgvim4WXre67wnlJyySPVcj9N25Bget9MSO9SdTHUDqPu+zpA2XIpFkD68wG4ce9QjLhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997756; c=relaxed/simple;
	bh=Pj6ozmh9fsmLs7MZSns+mq0MCLoIzeXiXHUT53zAR3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzypAfoli17EtK7EDlAAbuDU+0eWbi8U4HmGAj7+9ds5wkTKwT7myQAD3g5rgkHX7WkIteZQnKyCd0e0xH2UEb03m6601JBuh+l51PfkgSmbNyHwF6Ss9zE85OqNHOUWjJABmJXwpP+PmHDrmjjD0EGtBADI8PoiE9v7trrUBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hSviSdN5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XYj8E1sQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hSviSdN5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYj8E1sQ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdxJb1413957
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLvo77jmnPz5fCIObaCipUUFD6x8vLYstiEjZostQ1w=; b=hSviSdN5LN1yE0PV
	q3rwlw+kWayzSE5elW84oTO05970RHEikA/vhSuK0powQP21hkIGjvGCnzlR4tsy
	Qw4Y76vuFRjKM5/XIlD7GrNLt03yDOApO1S5FpyWYYLcULTA0kRFQDPqAsiGPweU
	7Hc/q3GsQgb21s6v55WlXD4LiWNUIck51lGfvv0Zad6PeKjliUk24EwcA+sI6Zjk
	yAe+twZKvvY3z+Yku6LeEcAhEXHrYU8/WDOEa6IiV3WgZtAmFPOprMpI2ztbKRzB
	gc6j5A95eWxpfnjFBnOmFpLB2qgZ6KM5fsfmuB0xSYFzjI0PFmoUZ4QMixCgWOcJ
	pz35OQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d1fr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:35:51 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c7d6767d06so104915e0c.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789997751; x=1790602551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLvo77jmnPz5fCIObaCipUUFD6x8vLYstiEjZostQ1w=;
        b=XYj8E1sQalTzRuRwDZayLUCDekSLftrDd4dO1PhiHU0gtXYYYM/CxK1nsle/yxfoQd
         HI6SXIUgQSp+pYoLAVtFK3r1PTczdBZLO3S4j3/SwXFMQg8oyuuvIaFO38HdkZypi+dd
         VZxlYPQkzGY2GbdMYfQevUrq4GXJ3iOtfmtzePZCjJpmRR7MPZYnMqV1R8jKlQaGRpYq
         XO40ae4dC1N75eNPSzyMIq566OW7gCkPEC2/qorhFn2JtTe+13QBCoruxBwoa+Pyg7VC
         VbO5mKktrFJZ1El0aVuPO2opboI+pWIzoR29OuKV7kno+vkemkqr2MuBL/IMwv9Gy8RZ
         L+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997751; x=1790602551;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLvo77jmnPz5fCIObaCipUUFD6x8vLYstiEjZostQ1w=;
        b=Q6HUSRMmjS8SgmbttS8RjjBT6ii0pRXyAZIzhuxgeiHoHUfz8az4tkfYCeTjAsf7Wk
         i7hYwJ0siRlPNpUYK8jt8yh1+FRpA6ucy0n+Ve+cjRQGBYzNnoALnMU7nqqsx8W6NHIR
         D7yddXT5LXijOloMD7jgTjE8Akqe3Y/GuJTgq7HRasLnv8NLtvny0DBO5hH4zLzRH4ps
         Of6rQW5xZY/pUt1ZJ26ZGZ4qAOjVtaYwPUfv5Zo0zm/NdlzjlXjqafyoU9M8yLmS2lON
         P1Hgw0T5DqL64wdqb/M6pb8+18bWkx050xH2iAQGQ70PvWH66F162TMTAq2hxCzDPUgG
         tt7w==
X-Forwarded-Encrypted: i=1; AKwUvBxo5BtggqxOXWmmt4fFLZfHCvhlwHLEKV8nDbDZbtMGFh5TuBcrXku5QrqXHwTwEaf6kkmDv/I=@vger.kernel.org
X-Gm-Message-State: AFuF++n4KTQQw+B4KGjYFMwBrAilkcQkcmSzoZZFZx9z64PF3OMx20V5
	KTkblw7lMa7DS00o8gsKVsx0Zw7soRfgDAZUwXF3iWRA6+qIaAu7WioZ33h2bG7sO8VadSmeryS
	r0gUEeFAY2JX+wtn6xZWpx4VY//cdynkzDwIBY+nFxAoY7y9rVtSnHeOh8zg=
X-Gm-Gg: AYBFou0KakF9YKY6F5AmRf/Ai55VCqbJg0pjWEIsRASrQNLAndXIbcLsUUI7BwlrXC0
	mfs5nJLUJoH0m2j1LWGEVcVlmsg6vhQFyqXN+cbl/nlG3msYaeJOYBspghM2ZEa5rvcriRA/SqU
	UvQwVuLxkTegD64fWI5Nky5c+svdYfMXefYX9RQwoCwEMyp/BOlQ5Oqip5+cJH9FXgS5pHvtnjH
	+ViV59+Pdut3XrOGCBV25Cq43bnD6Sxk8KoprlBFysRQdye0gtCCB+xFJ4myc3ZuljOtL62LBGH
	1nijVaVe3rUUbgNtkxs4XzRphNIoYaE8eq8O5/Rj1sIltsrNxbV3gzIFRlBqzQTNkjXu62NSz3g
	WBO+c3OnA+05hlK73U97BgA==
X-Received: by 2002:a05:6122:4a4f:20b0:5c9:ac9f:b7f8 with SMTP id 71dfb90a1353d-5c9b86e8c7cmr3529533e0c.0.1789997751193;
        Mon, 21 Sep 2026 06:35:51 -0700 (PDT)
X-Received: by 2002:a05:6122:4a4f:20b0:5c9:ac9f:b7f8 with SMTP id 71dfb90a1353d-5c9b86e8c7cmr3529489e0c.0.1789997750828;
        Mon, 21 Sep 2026 06:35:50 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dd344asm4368300a12.18.2026.09.21.06.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:35:50 -0700 (PDT)
Message-ID: <4970855f-37d9-45da-ae05-027a605c03f5@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:35:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke
 <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org
References: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
 <20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KmUe7fze3y-9ffJQz8dogcObA-p7be2c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE5NyBTYWx0ZWRfX9hSkWt6Ko3Cf
 LQ0zCN5nN87xaWKpHc5w3EVNK7DjNHdu8+DaCK5t13RQSwxo3d5tPKZWPVtF3DIFNtOvKGfhf1q
 bSWtjvl7uph4xUukf52kaEtDygBeSH8=
X-Proofpoint-GUID: KmUe7fze3y-9ffJQz8dogcObA-p7be2c
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab132b7 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8Lir4zOpp7cNL01G2WUA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE5NyBTYWx0ZWRfXzb40CUzQm5xs
 BwNLS/f3trOCNgFYDxt2/FPAJkg2GwfuFaXQv9WIfCDAgcdqMHP4yV6gQNwc0YU8twDBz3lu/Ky
 2B4X7g/RSPF7LHtf4k3Dn/XB7u35iaMCmu+PFP/sH5O9GRPX49CHxYrDm+q1A01j7sEKC7Z0Hjh
 jl0rvXgxIRKZFpRbpfZ5s73Lg9Z9LwsusDBO1dUOi95h0X0ahJBLhfD2wiPDrjpRRcNUrvRpfK0
 X4gelMmbZjxtcOs+zyi7pCzrhumMqu+3l1kfQuTUzLIZ9oHOF1RX5ealTh5yGy3FED4U2qNbPn8
 EuHwyXkiicc+Zs0QLa4oQchej0FX0MaFuMYzBSOcoNiqpITM703DgP3aHGG9wg87Im6oIDNk4Z1
 79t+V1f7lD6I1UcZr5/bTSvKxPxDIPEEXBUo4O7Lf0MLB2NN5hHqPKBRqEN3WKD0OQ+c54jr+BT
 YftH3iW7fUy2VfBK+qA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210197

On 9/15/26 3:26 PM, Viken Dadhaniya wrote:
> The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
> rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
> values are several orders of magnitude too small. For example, the
> 50 MHz threshold is represented by 2500 rather than 25000000 Bps.
> 
> As a result, clients using these constants can severely under-vote the
> QUP Core clock.
> 
> Correct the constants to their intended Bps thresholds so that the ICC
> provider selects the corresponding QUP Core 2X clock rate. Drop the unused
> definitions.
> 
> Fixes: 58ffbba6a399 ("soc: qcom: geni: Support for ICC voting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
