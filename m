Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016934;
	b=Ykf0Y4IaZeGKs39B/HmelRACpQpga6HTD/4CWftXDZHxIbzIaZxliDvywBFnr4TyfmxB
	 MoJFglNqYE2/7Me+qTW0ijgYKs18Q6hNKTnROsdVrcYJGmEY7kvilHKg7olxZaiAnmqLA
	 xNTA6QaiXSCoQqZTyqyir2fVEs0Y6dQFh9h/1nXuX5s+OfLBNV7Hp8HONe6kLybMM4IPz
	 EgDYke4lOy3ucYXjD8RXoApSnjMLlvVxkVlT8vk2/QFW27dpg7NdjK6wNEvTyTYmbElk4
	 sCe5DXzu5I9t3SPkOU+UQD1Luh/VWq69DIzug1SH8Ly2IgMwCCadWr22STA7eHnOyOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YmcQx9OcgaD1ZkmOw8NwOu+cadyxIp1x2breeYxHURY=;
	b=1dpOrZpHjlK51PPUvtGjc6D63Cda4yfhUvHNkjN76Q91Nr03R2r2foV+XlTaskB9pO4r
	 bmLGiBZDtTZ184VPepCtsAoB8dw1+Nmo3c6/lIfxujzf34Kr8zDoQRmRlpAMuwz/Mx475
	 Oso0rK4Fnj74pUxVMaJBNZpOaVTa34KNORNDfc/FxED0Mrj98PtWf6yr0ijPM+yATzpj8
	 V59bd3/JgcxY+SW/D8HAyqzynSOGCWVYeY+QqMK9a7Pc6NxPi2PMXeskuWZvNmdFb1ggD
	 zntRI0LiGbrRbzGfEVTh4aiclgxBCKeLJw+7fqjoLcOlnL4RWVZCy+G5YKR7MBfBMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="gRo/l0Xs";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PsekKf+x;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EB606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 212EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRo/l0Xs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PsekKf+x
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAt1J24131942
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YmcQx9OcgaD1ZkmOw8NwOu+cadyxIp1x2breeYxHURY=; b=gRo/l0Xsb7hVMkRX
	1EkygAHZF0+2YgS/MpowSWWROkEhf+LNkEtrcEsDmhhQGc9ipXwOfyg33Jw4M8Q4
	pwCpwRV571v8rN0ze3xBYb8+j682Yi+SRuTfpllykIWTNWeOVzUVYLrcQgq5pOdW
	Yen1WzKtuA102L9t2pZMX1q+9vC3WOlREjDaJX9mdw4v55TwpjaBtDjSvwAmd0Wy
	tUFCnR2nq/FW4ghWfszlk67ejCrxxL00zH37LgVSnmLlAqfTTV2XVvqXIg0R70cS
	yw2KH9ZC3xEs2BrpOESlqS5KqMcTKhtcpCUOawvD1Ca003ZYh0GznlDkcg/zwVyq
	DjO11w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q0c1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:15:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb1091fffso22285085a.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793016932; x=1793621732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmcQx9OcgaD1ZkmOw8NwOu+cadyxIp1x2breeYxHURY=;
        b=PsekKf+x4eWHyEPw/DQs478VuQdoH8mpoRUNVD35qHrlTzZEZonP/R2uWCpgAZhVoV
         fv1X4yjcWTmPMoWXGkqoJLBXQcT5wW63nIDK7qiTG20KjbnyuCabMI2zOeTHf6YfsZKM
         UTPMjUgo0FPFhwhyk7ULqOfhkaHn52E8Nyfch4tfcXJnmd61XaFiBaJk7rf3fBOpeWJA
         UUh7LEqtFTfteEHX2X8FvcmG/4zOw0SSiLMN6c8jJD46ocXIDInUXSoOhVBz42sfm99E
         DKl07WsScVD7tTs0RYZJzOpj2KykL+1+daSaOs4AJTQI+42vWmYnaVSHEFDxO+KV0xUm
         MSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016932; x=1793621732;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmcQx9OcgaD1ZkmOw8NwOu+cadyxIp1x2breeYxHURY=;
        b=iWSNKcN/2XieeQ8+t8MUCXF9O7HKozUS55kGlnW2Iwr6z79aiChkrsPZUJeZynG/oI
         kjTLW1rSm/rgGv1NasX5cEXfb1I+WtsH4yq2nzQ2j7T8RGuN+JsXnVoyJF7sInVDIV1u
         hTFHr9XnlHEjuwOSHHR41OMWlboA73q57aHshRJF6L0/XZ3B9HbQkngSEt9+ZS9umcUb
         W8JJ7zblagL12Qw8fvHtSbU49USKV+Z9sKfUOAqmYfr9JqznI1PVYYWXDtXkKxnVFxq1
         IwqZ7vU7435fGPA9pjk4PyL21nMpXJmWNTqJ1TBurFpCAM13WZ8cfIy5AzyZ5BINChZ9
         zYWg==
X-Forwarded-Encrypted: i=1; AKwUvByGaQXo3ladb2NDjyFGGfuQTBpC6/SE6ZRYBxMaeIrt5WoYvXp4JMH7zn31S5i7KH69XJ4XJw4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNqkeqvgx2PloPNFA0OrL5Sew1m45DGB9amZc2O5IuPa0NnN0p
	SitN/aSkLSokZ76kfOKmICcdo8TuQ59Nz60FqbTL901WDITPU1hll4141eqbNaToxKBvuZ/Ysze
	RhfeAYivOBDppQW10k1G5wFQyVYP5DU4lXudh7ij9SQYZxE+2D590uEmvZjY=
X-Gm-Gg: AYBFou10M1k6ThYTPkC3V5VgLkVew4SJw00JcSQyxghVhzZwVj6l9O/1SxLUXjIlb1I
	1ZVLfXpakM5h+mZZvXflAPvydswPYDLA68z6Y+hH/GUh2onu1WJPm1O1G8UkgEfdXiIZTzd+OQW
	EvtYpAvtHNnN353zpYujea/UXkMULLqknQCG+Q+Mf1gp5ySSA/M54DCoT8OtoAf5VPcYPzeNE57
	kmdky2mwwJyu0FgmYDUyTJIyUEX37Ru6NYqaDyjLqZhHiFdYfHjEM6w/RbA0nMLOFH2bG7N7lJ6
	RnjZ/+lwHaCBRe1O/eZI+9JQZlWGyRV5erUFh8IjSaZ7DLs/oQ38i7E5013p/8x1APD2UJQNdLf
	3nwIc6LlSUqpBWXGHGyv80A==
X-Received: by 2002:a05:620a:7302:20b0:93f:211f:7ba4 with SMTP id af79cd13be357-940ef945ddcmr961459985a.5.1793016932180;
        Mon, 26 Oct 2026 05:15:32 -0700 (PDT)
X-Received: by 2002:a05:620a:7302:20b0:93f:211f:7ba4 with SMTP id af79cd13be357-940ef945ddcmr961453885a.5.1793016931605;
        Mon, 26 Oct 2026 05:15:31 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a8b85fsm1495986e87.55.2026.10.26.05.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 05:15:30 -0700 (PDT)
Message-ID: <09a09f96-7572-4f11-924c-49f7fb21e2c2@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:15:28 +0100
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
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sdm660: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX8f3NAUTv0WX2
 p8SezIu800XjJTM81x6oCkC9TQq26x5sb7rqbORGdUO+kIVWlmv2BitzrOPQlbq/AlmhR7KrVI5
 VHpUpL9OvL7j2vk1y8xFiHH7NGUaHhY=
X-Proofpoint-ORIG-GUID: Cwc-qGudzkITAlhOkZ2fjfBQM1I8a7yP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfXzWKWarf/tGXq
 8Uy43IDjDI2oj4v0/lZCeKv1z3EvHMcFPVc7ek+azdFo2EBM8P7xXvZSaw9k3nmulbftIF7uqM4
 s2DhgAtFEn1jv497eOVuZuChC30EtPWc8p69v/QN/qRYDTanPa80fFCDIlNmbBy8E1+kyRyut4v
 v7sn/0asMrRFbcaJZ15ijVcIUN/uffKgtklZacS+umfsQqSLKBC+ydMx9AhdZKnFzRYHsmVF9qa
 E6sI0NoaFE4UOQpZcFVDeDKQ7GNFXF5s4gCT68nXTYDTMf/JMnHuikdWT4QoGO7AfZpS3jJtD+D
 Ijec8FqneY9dADicGEvzciAzKHUPZia3nZ/GRCMriGiMnumVt/W1Gp55FgYKpEVFHm//vwpMIHW
 BYp5eT1u8vBM49EovANoVwiyUu0ZRiDh4LbJ5Ffc9Eb6JzVRFjfipukf+wRdrWZebEsQn0ae6Wu
 ocM0OpDWYvUOJFrkHpw==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adf4465 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ssGiREWd8Ca_oH2jvLkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Cwc-qGudzkITAlhOkZ2fjfBQM1I8a7yP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260048

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sdm660 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 708ab9d3bc5b ("arm64: dts: qcom: sdm660: set cdsp compute-cbs' regs properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm660.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
> index 0fca9662c64a..723bffc99b67 100644
> --- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
> @@ -386,12 +386,6 @@ compute-cb@8 {
>  					iommus = <&cdsp_smmu 8>;
>  				};
>  
> -				compute-cb@9 {
> -					compatible = "qcom,fastrpc-compute-cb";
> -					reg = <9>;
> -					iommus = <&cdsp_smmu 9>;
> -				};

On this platform, it seems like the secure ones are SID 1/2

Konrad
