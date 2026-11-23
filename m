Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448335;
	b=Q4xWwjU7o4o2TTwYTOa9Y3D6Nm1ClC9lxr7MiGtKsQnS+vg8wyqmDtIPzo3mGAKAJc7V
	 T/v0AO3Gf4lGAkHCRcpZHO0ZAIuyWg+xPsHp5jCZ137OKWDyraXAICWG2/ITvl6DgRsfq
	 jWdOS/Y0VrR6qceYqb4HEzIuwonL+VQxZ/vshovsrjhkFLLCHEpSoqGj1mvwTa5xSNpYD
	 i2S3GQbJwW54dXpn5wXRO6uE4Wlw6BRuk/a2BxAnZfiXoUC8zgtgh00ARLVeeT85jg7Bf
	 0VNkX6a6T/5PedyhwW8PB6l6Ng2EbxeoethsHVPfhFxQnX5qYY0N2+xFTyV5rkOmwvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448335;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nwDysrxowIrcL6nfomWCriBbdPh4cWHD6+FT8Zt6pqY=;
	b=R9iPNgPTMXFi6Tbh5d45vit/eZAT+uNrKsr9RpGsfgLTQ9eynEtqlzIjGUalEd3RvF9A
	 X5RJP0/P564c763AZJghCnDKKS5E/4J3/ONndy4G37GgSL6P/B4MUTcIpsWvMfERKyVxZ
	 IjsbLHF/zGtANCBfohnOty+vLmkKb66LrQGHQcj1MJO/4ZRIV8mGO1/C2CL8k9GErAZ88
	 kHQO8rdwcOuT1MBZiwlCgJbiujpwINePTd0Te4rHClsf5Zk0+dfMXVwhbZKgJSuVgS+5w
	 uIJppNvRfp+R/GscSw/RJFJSu+JVjpQCP7K5oLQPf7F47gWP/abCMEnKkhEI+qvEZEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="etiSRN/Z";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WT3oz5rQ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B43606A680
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B43606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=etiSRN/Z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WT3oz5rQ
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKssR1974152
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nwDysrxowIrcL6nfomWCriBbdPh4cWHD6+FT8Zt6pqY=; b=etiSRN/ZbBaGQPfE
	PqfRvVxzdf8I7UEJpZ95lYWONGlz2JsFbKdHzfBUlUXKEjec85yz8hBhWOcomrTF
	y37JW0So8DEWJsxGF0cipPSqiVX09gBwWww4iyjJ+90vgzEJcSFvLgq6eSVF1iYD
	z1fDYSoSGOlOr5tBQmAxpfLjSV8aI+kOxausb+34GHglWm7fTelZU2YiWDrY5LwP
	zJfR/QD2+wXLZAdu+jMzGoQNantoQJYhNTG3Y2UcmYmACqoW9LvUzCPmpwx6PVhM
	bUpTBkoJrZGe8WZ7Dxy77gHADmSVE4eflJKJxCIi6h9z8yfsTkjWyJN5JxRCoHGa
	yOm07A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7us2fv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:38:54 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eab0ea26afso101370e0c.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795448333; x=1796053133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwDysrxowIrcL6nfomWCriBbdPh4cWHD6+FT8Zt6pqY=;
        b=WT3oz5rQ7gZbeAz44zHnkk6iVJXeK3DmzpH8P/CO9zx+F/I0hwXuL50IO7BWGxxx4W
         u46zO4eoBXlJH+t7X4co4f6Z8vNwWaYBqN8nCoiQJCqOyh5BM0DzjFvLrqdMTN9V0PS2
         HEvohFS9CFqFnEXVyVsjIjUDzrb9Fzl1I/n6ghiy7S1/TdZjXsOJVeDI3T+uG2ZrNV6Z
         dC4DCsPlvD4UsXL5jgFLwR3jW1DIjOgnK7Ylzkt+i0slmZNfZi2qGwHORpWXekimZkpM
         Zf9OlFN25XH8G2v4Lo+PE4IJANJ6CAIR3bY+YrgBkSrWR10f8HqzRM/Bz0oCd9lAg14d
         zneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448333; x=1796053133;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwDysrxowIrcL6nfomWCriBbdPh4cWHD6+FT8Zt6pqY=;
        b=FlWL7aUk3EuUGGxIr9joHrfm0IBmEf0JNmfF7rhGD8ALUEwrHvGc0QnmzpITTTxIHY
         qL7MBTaYkK4fwJQBXEchvdv5JMsWM0bc5tLxUSistj9P9wrHyamxgofP+j+jVzFSCTM1
         9VWmPJ35woCfiYAF2+ebRnWWRvD4R5kDdh9DbnIaXACB/go49OyqCRnroOBpHsiegUcd
         /ApLI5VZBVQ9gRh6Zlewu+2V6nPiSRC9tjS/CTPBdUHaMnC/ePvWVRRKhWV1fe14YvRO
         OuQhl7MvHg2wraUpT3no6E5Fd+Z5l6qusjg1zWlMvtZzj3/TbwefZXyI+kRBv3oTnAOl
         lVLw==
X-Forwarded-Encrypted: i=1; AL+hErGDkEhtdfaK1FdZQFDSw6fOMxRHuG3HhYaBYoubGArNt9ahaeTkeJIKyAE75W1RgpBNfuPUBsg=@vger.kernel.org
X-Gm-Message-State: APuU4Z85AhbkN2mwtrfSMGNFIDbxyJCAfYtP6SWHHqW0oCU11sQ7vskw
	Dx8fvk5PycaA35qcsASCmEABasuCU/R6IPMzfev1C+O18EroX9mkHxYG7p5dFoYuA1Qov5KwBl4
	+V+aL10r17snceBz993ZqP8rpLDJ6/LpcFYkNBXPSMjS3LsRrWxRjbhtHe4Y=
X-Gm-Gg: AZFdTZft8NJ1ApdDqAQ+24xXnbPX6tgXzMaUW/Um/54496p/mhdavmugZln6EW82P6a
	IHIZn7cvfmmCaC2s2De6Op6Hqui1HmTIUliFMzmEOIjq8CzFOU326j4iLNrNF894FxoQP3hP+R7
	DW/Qx4Cx8rc1DpS5w3FqgJVoJXKbFVCyoViJn8arzOKcYPvGI/XorSAlEqewXROgmFr7UYc+4vX
	XTyHePUyVGTdDxn6QxvG8iRuIXvac5bj1602Ad+MiisPR52Mi6kcjlALvnghxb1jHHTMBaTCAYU
	wmJirB1g+sPZ3gY4UerNMcOsimGIbfgnnr7hQyg0ppDcFRvVTBGpCVoTynlcVIIyomuf4G78/i6
	z9+SbRf20OCM4H6uBNe7KfKCMXXnbhg+B/LXvgs1qDDOuNKm4CaAJtyKCpaoUk6OVxRfGzqs=
X-Received: by 2002:a05:6122:6107:b0:5ec:e6be:d626 with SMTP id 71dfb90a1353d-5ee8ae0f76bmr6871882e0c.2.1795448333384;
        Mon, 23 Nov 2026 07:38:53 -0800 (PST)
X-Received: by 2002:a05:6122:6107:b0:5ec:e6be:d626 with SMTP id 71dfb90a1353d-5ee8ae0f76bmr6871835e0c.2.1795448332884;
        Mon, 23 Nov 2026 07:38:52 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm3621677a12.36.2026.11.23.07.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:38:51 -0800 (PST)
Message-ID: <f6eec0d4-1d37-4bdc-b09f-8bec0dcb8dec@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:38:47 +0100
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
Subject: Re: [PATCH v2 1/3] ARM: dts: qcom: msm8974: Fix WCNSS wifi interrupt
 trigger type
To: arapaille@atlr-engineering.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Luca Weiss
 <luca@lucaweiss.eu>,
        Eugene Krasnikov <k.eugene.e@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, stable@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
References: <20261120-wcnss-series-v1-v2-0-3fed518decfb@atlr-engineering.com>
 <20261120-wcnss-series-v1-v2-1-3fed518decfb@atlr-engineering.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261120-wcnss-series-v1-v2-1-3fed518decfb@atlr-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2c83kMsjuYjMI_SvHdRxwW-bSxNOUmVR
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b045e0e cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Knk3v0qlAAAA:8 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=wt33j95wQlzQpC1BO6QA:9
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=L2g3GqtBoyQv0ocsUjqh:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: 2c83kMsjuYjMI_SvHdRxwW-bSxNOUmVR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MiBTYWx0ZWRfX8n+0xqu1KqAu
 b8odiTm3e9J0vvpslK3pZDOYXHiiTM/V6KjP55XnIEUf3PPdMGWdY46OoM/HR4BCEkPqdfT67uq
 TZQddgQOnFarOkyR/S+8WDDbaLBC1w4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MiBTYWx0ZWRfXwIaJSUaA6dzS
 h14sQdrwFULXb9u0HSw1B4jYRDqbo02E3GwE+w/8AMeiVUTiSDtQcdarTm21LC577AXJdoK6Tbv
 QH28MBVDmub8QbIkkInkr3TUQ0KXYzbSq2LDfIqu7JfYGnwY4ZGLhmYhpldhRxqVhHb+6PaaXoW
 8Js/E0tFF6u58s0rm7wueYVEoq3EkPs7YQhcr0UiihzrhkWCGHxXcGRwPB/jczQ0U5XpcsSvaM9
 cyzYN/2SstIUd7bkyNrCNj528jat8yHgsk8IE7DBZlC6BXUAZsZEw08xlMbS8sIb+bQWDCeViTP
 9R6sGEU61+Rdp8TPvfDs5AE5A2WSOgP7h4Azr66FTThuv9qPtPqkhF4qg9+tGbd9+LAFBotjUqx
 3UlIYcfhKhBPtGjYekDfcXWBTdoh73oyDfp/zDZAWQzX09+cpc0kqXIVRzmEbAyo1+AIrXAJgzh
 zUqOixj9ofCmG3MujmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230062

On 11/20/26 9:05 AM, Alexandre Rapaille via B4 Relay wrote:
> From: Alexandre Rapaille <arapaille@atlr-engineering.com>
> 
> wcn36xx requests tx/rx as IRQF_TRIGGER_HIGH, overriding this edge type, so
> the re-probe after a WCNSS restart fails ("type mismatch, failed to map
> hwirq-177") and wlan0 never returns. Use level high like other WCNSS SoCs.
> 
> Fixes: c7c0edecfba8 ("ARM: dts: msm8974: Introduce the wcnss remoteproc node")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Alexandre Rapaille <arapaille@atlr-engineering.com>
> ---

Docs say this is really a rising-edge interrupt - perhaps the driver
is wrong here?

Konrad
