Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A4409271
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256094; cv=none; b=mKeYXWjzr0XUr2EmrT5ll6aGSaenVwD1fw2FU8xOsk3Rjqk5EbuxmCWEYXRXmdpr+Kabn4pZ+LV7B7Bof553XauAUJ06ohVKcsMdy/z+dNGbshhXO5etV06E658nX8UhbyNnMsDfvP2gp3RWsdtopDKgPmkQwNUKZojNHu4dk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256094; c=relaxed/simple;
	bh=csDK1asu+J99UxcUD2zs1IVeLt1lcmHdJd6E9VSfNXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ig64MfsT27R85Rk5fGvwasLEtQhA62xsnosPDiz63bOjtPMMvLTtz376F1uoC2bGULjGB/UcoIILBXy/XMaaM39X4sOhsN2wvtaUMWtBGKBS5Y/KRIIdKXLMeRZAZHfnip5Bfd1dFNv7HQbQWqPBh7LAVJuV9UMqDYmuwJcfAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WCC3njFL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O7r2JecG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCC3njFL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O7r2JecG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68179CuE2061537
	for <stable@vger.kernel.org>; Tue, 1 Sep 2026 09:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zhS+QGab7xfzSqgIoLvDCDDrYeGT7IjzokHtqkg4lrU=; b=WCC3njFLqLW3i5Jv
	9NBVbDViHxwdVxRkoD+Wz710nIf+1RbkamjKcRobGQAKWA2xl80l3Q3A93qA1CYt
	GeVaIGH4O7o3pZ1vJzAUIwGWG162xpqKn2aeBNkj1rdj/aKYCwcDZS+EquLYMZ4I
	1fgusuRVYU7ruiezn2nJ/7EIYgCQjcXSDv40lj3D9qbjs66LYGV+woZlAmUZlcVa
	pylq/wPX0jlC+zHORn4J9hNVK+5XG1eewmmOUh/kdwIoi+sx9ep872G12WkRdziu
	85N/JPAHgrR/SmdhRqZRAIhuDgKptrIJZgxygRbU6PaIl3oeA5uwxDLXObcikPQh
	+a/Tfg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh1d3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:48:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93102454272so88010485a.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788256090; x=1788860890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zhS+QGab7xfzSqgIoLvDCDDrYeGT7IjzokHtqkg4lrU=;
        b=O7r2JecGJ2QTi95GiXEEqo1F3IYChnXOyO1XQjl9yRJeDM1Ybtkjy8SCtUm8RWIFsK
         NrZxlXIRV447vjwqk81J4dMcmQBj+JnbpY/zUZw8hBiz0Orbcguw4Rnc8kzBg1Vm8xH3
         2oyOY2O3HuKM0XpajC+onlC5c4ex1RSdg/nGzu7Cg8QfDuKj1ItOlXfgDgJwElwaZxlH
         dAOKjrl7pu01/6ja7VjDbrqo0VGO1dWWJYjmAxexTTZWGNFjujoruV7UIkzLUl6H0qRS
         d9zTSwPQFsv4poCV3zBsGxfaROovaYtNQ0Z/7WvL3qu+Mj/7GXBYW3xpqnCM7BIfcWpc
         GJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788256090; x=1788860890;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhS+QGab7xfzSqgIoLvDCDDrYeGT7IjzokHtqkg4lrU=;
        b=pRgAnwD1GeFVDDanP7Vdt9rrVwM7wOD5SGMkUBJUcYOz73QrNVc6tlVBguvFPskvW5
         638kpjx0hDUiwC0DWd9VfjJ8RsDi5owlc4mhl6EbnvuWo+eJtZFjMg8ydD0EuAYpyQUM
         9D28ssYJDtuwN7DlZoZCZobkIsOV4CQOH4vlkz9pPSa3XhjBULf+Rtzrb9NW1C5vMOT5
         TLU0agLlulloo0QYXJwrNQcX4w57/oXeheq80/wmLNEA2KcrDWNGl8XTHVN+sf4egU/Q
         XRNiIvLYSpxeDHqaaxjfVaS86+xs4B5uPKwHdNHmltuxX8S/QCPbXVOApwx47x4KuLxl
         1+fQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqewd00U3VGnl0waO2WVKlzkTGT0Nd28cBL0zZgtOgUTOqwiGz1jRwUfx881UiqPbXJojwn/Ws=@vger.kernel.org
X-Gm-Message-State: AFuF++nBDce9jPk28rQs2wDwrum1ivmGcVJEK8tqpF3yGCSgq4YY04ps
	v8BoDZgPL4wsbe6dQjb2tnuB235SLuu3/A17eP2kjJeYSNqy1mWgBkEBVPKWpeW1FcOYvDnORta
	fdopVe0NI0ATBqKu3/5zGsXBziumDRVAiuBVlJ93YcnlLeek/GIyIW0hxYL4=
X-Gm-Gg: AR+sD11Aoy/zARlr2qh2wh5A1rG5SvNvzxOsx92UVCfZNdgGX3JSNpcnHR2jJFmAjdQ
	rjNA1AegJ3a5ei91cR0UCBoZ4otlarUZEbAGmSWYEDVTEgKb3e0O8mL/ixbRCOD3LKNlZM9dm+n
	6MUJRYZgxtaOAWrZ0P4Piy55FD8TJYYFGMrk9e1hsLFafh0H0K0Uaj6tWVq1HP9yL2Hrb3Gqgvj
	47uGdyZGLzhX7LGqnqT7Gt5QwHN4MVcMW3Hv+Il8PeQljmO6eCEDBdVUSpGvwzQPs749GrCD34Q
	3KHAykNwKkK+N0X7pVWcisw8WZ12NlGHDOF7hPMN5dSORRc/wFvK3LKGSGsvV5JGIIDVU3XeUIB
	iSEU6pwCBS8uYT5DJoBaalg==
X-Received: by 2002:a05:620a:1989:b0:939:4a24:4de4 with SMTP id af79cd13be357-9394a244ecemr463035085a.5.1788256090144;
        Tue, 01 Sep 2026 02:48:10 -0700 (PDT)
X-Received: by 2002:a05:620a:1989:b0:939:4a24:4de4 with SMTP id af79cd13be357-9394a244ecemr463031785a.5.1788256089635;
        Tue, 01 Sep 2026 02:48:09 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee0b330sm547429266b.1.2026.09.01.02.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 02:48:08 -0700 (PDT)
Message-ID: <558d9ec7-e5dc-4257-9ef4-c0433a4177c2@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:48:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: qcom: nord: Split QUP1 SE2/SE3 into lane-pair
 functions
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij
 <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260830030201.135637-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260830030201.135637-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NiBTYWx0ZWRfX53IF4/bUVCc/
 tLavllV5MfQyBwb79sfqK4Zig9mZaUkTu/l781MBSHEVnL09HfrJUcVNcTPBIcedIjQO+VamYkJ
 rwoQrbVJSpaASD2MakVj2sG1UeBrpl8=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a969f5a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2HO_7AbmPCLmE9qJQqQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Acp6xUS6RfCIByzWgTFmC65prDfxeh9S
X-Proofpoint-ORIG-GUID: Acp6xUS6RfCIByzWgTFmC65prDfxeh9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NiBTYWx0ZWRfX3b8rq+Pca5nC
 HKJ00MMEjkBjTe7DW43nvABsWI3XCsMXCOrDYgvMGuBn65FILrrtgXgO8I8ZNskhoAccZvW22SG
 vwKkp/JQMaOdcEfNVZZS2ANziTtGCTfbY1+W5xWU2S06SN6ETh7GcQmP5mDgTLH58quZPy0kjKk
 CJ+AhPrx4gRUHqFy6pN4i0ENOuRMGCPRExgWQFUA2Rd2wSJm4XBQJ5mDLWnjF+ek03xseHg3VVY
 9H6CsnFcwrgrUZ0uUnGC/o47UNYaiPfjVct91fK+GiAkgBkZfIAbpf5RS+TolcBmU9KLhAxr85X
 8PrmWppdYtIkEJ2jfCWZgoz5dx8YM1LEmpZf67mwYLduMtLuCaF6HCKQXqDJ7xRPOTG9wuBtvCa
 RRmVPu7zGGo2saIZ1T4un8eqsgG2qPMErltOsqRoYGmFMekN8bgOCuj5GYRsD7zLkODO4dx8hEw
 rMr9z1rJN01livLpr7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010086

On 8/30/26 5:02 AM, Shawn Guo wrote:
> QUP1 SE2 and SE3 pack all four of their lanes pair-wise onto only two
> pins each: lanes 0/1 (I2C SDA/SCL) at mux value 2 and lanes 2/3 (UART
> TX/RX) at mux value 1, on gpio127/gpio128 and gpio129/gpio130
> respectively.
> 
> Both mux values were named "qup1_se2" (respectively "qup1_se3"), so the
> two distinct lane pairs became indistinguishable. msm_pinmux_set_mux()
> stops at the first entry matching the requested function, which means
> mux value 1 was always selected and the I2C lanes could never be muxed
> out. In practice i2c9 and i2c10 got the UART lanes and did not work,
> while uart9 and uart10 happened to be muxed correctly.
> 
> Give each lane pair its own function, following the _01/_23 naming
> already used for the same hardware arrangement by the shikra, eliza,
> hawi and maili TLMM drivers. Both functions still cover the full pin
> pair, so a single pinctrl state per protocol remains sufficient.
> 
> Drop gpio129/gpio130 from the SE2 group list, since those pins
> belong to SE3 and were never reachable through the SE2 function.
> 
> Also rename QUP1 SE2/SE3 functions in the binding doc accordingly.
> 
> While at it, add missing "gpio", "qup3_se0_mira" and "qup3_se0_mirb"
> to the binding function enum to get the list complete.
> 
> Fixes: c24dd0826f06 ("pinctrl: qcom: add the TLMM driver for the Nord platforms")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
