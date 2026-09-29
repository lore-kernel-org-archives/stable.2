Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FFD53F6A6
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702850; cv=none; b=JbzMHtal941rBORGvGBiQBq6ksDVLzPeMwjUf5ET3faKtpSBOPKdtIGmRvZR67fJj0Q8+NOcvnPdxMFlzY4oSVj6A4SDB2G9wswrJm2Pe8NT1JZHaM6vGvJxwx24jsZjgxQ66nrxb+4GKN7LW74soaQuzp9/4wctMf+91clKxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702850; c=relaxed/simple;
	bh=XAr0ib5BIPLtsY2IvBczHBGu8cAfEMxCkyCJpApDgVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K03NKGILTdxoPdsEZW8K8ttAoBB3GKEbIpCKkco+JYgbpd8fLMXrbfzPFMjPDbpcDJWhKx7NCkaYCEbvVXeWJq+lUoZ2B0LVO29f8H8lOSfJ3J9YnC98pN3EHE58w+ZsJpMUQ3KQ+4rm7mMan+h+rWxgOtWMYXWDJEuXl1PB0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b0PhfIzm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hUD5+ZOw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0PhfIzm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hUD5+ZOw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqmTC613838
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u3SUEE7AbKzsNjWqdW9tpkLCiHmZCXAa87H/nM0eXMM=; b=b0PhfIzmOk/QmqOk
	FVyf9GPr4FheKSIazX6ZpB5hFQNl6tKAh5GNR/d/ZVbzld3wLYDvfdGjOyQ3voKI
	XJfEGMIT36vPoGXzXRJFpyFaCryKIreS5dNbSqvqXRR1TsW+odAvrfpYModnZuhA
	dZDb6IvoP4Sc6Fk06dQRWW2Xbp5ITvRx3P4n94xXEaatFET1PQFBtZlq2xEvIpH/
	9XxzPTSFCkSyf4/AWpb1CxgjGQguInWfBvsNK5rYdhbQ5+kBbjEI7kXOh1lQPPzA
	NA6GdmQ7BdgKVKd9JLAKEPxGFoYWVT/utozk0x0IY+o1HAP93KM7G4qSUQdprqbB
	z1KXMg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew3ueh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:27:27 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so3133335a12.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790702847; x=1791307647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3SUEE7AbKzsNjWqdW9tpkLCiHmZCXAa87H/nM0eXMM=;
        b=hUD5+ZOw9duAcXWgrj+h1HLpr5mz/H/Ga4fOH6wz9OGDeraqHCDG0ImFKqcHJgM7Nl
         ka0s3sjt33uFU7UEh7UvPigM64YSckhAkb1CaWFlPZFq3HJhesl9Vhmm8sJ9MZ8SbnBw
         hRCV5DYBcVprgZNG/zy7+JMHS6Hs06pc2IdzagMqiTo+3WIjWZ9nrq8r19F00n3JR5PZ
         OR5Qh+HLIpor2VxO/S6+Ah4EN6Mt1ss/p19nJfsIhuU650DrGdTfmofoDsqlU6nTWX+6
         ts/4SeWCC3PVddWyQ49IsmGUwawDhlNAqur4JPzMqIHitMui1YW9eXnI6PFY0BxZGvBt
         JGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702847; x=1791307647;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3SUEE7AbKzsNjWqdW9tpkLCiHmZCXAa87H/nM0eXMM=;
        b=gXnD7cDD2jRmbHcFrKUCKFbXCbCAOZqppRMyhGB++Q75J0uITraicrpbnReL98ruQP
         P2eiFvXE3Ma2JoMsLSHyxJKzWCeapdb4gWwzudlQ8XExZoFA2c41ZoK3Dv7+JKlnxV/p
         rDnm08hN9xz0V0Vrhf1VE0Iv6pjYtiEac2t0Tx+LxWpqrAwew6uj1WfGHPEQO8K80nLt
         a7Mp5jVAF3hL6cDLvtHuKOCgom1KJFxABVVCGYPn/1idrDLSCvMMKFbP08m8CWyXDijI
         ZwNrzvI/4qFlxmA0Em5mpiRHgNphES/dE266VjFmP1/c9WjmQeTXHR9v7ngHwD89144G
         IWUw==
X-Forwarded-Encrypted: i=1; AKwUvBySBIS1RroFyi6Gja+bgm0OR097F+jf6E0d6KxQlQ08IsHvely7Vc5U0ZJbttKhPRNvrlfubfA=@vger.kernel.org
X-Gm-Message-State: AFuF++lncTQ2s/S6yqcYviXzHBgKMIPLjCdsOFDHUNq3cOYWHzjZwVMA
	JaZML2/5lO3nY1QZiaMaKCk/WNYKTEzdvMGhhFv4T5stfhhRyzWeCS1SCixd2DWYvAkWrZ6L91B
	9NuMdJW6De48S31UPY0vOJ0svFn1H5IoK8tPeKOF+qJ/trSB76KPMYpkTZDI=
X-Gm-Gg: AYBFou1NPu3iEbTXOU+eOw1xWwC6vANWbKaSWUvrQASPMbAj7cf/2sYZvekzckZmnqW
	nqkSEU3JOnHT+1pVUlimyG23jOZQGcAEWCSXn9jCxosHhN+b4UUxEXCgNBwS/QSeAzVqAu8NBwl
	tWoORi3cJ0w0DiV3g/ZgljFLB92adPlU1rd4q7qTFCiGe1MuUyTXus80644dHZuABwJUhC3F+je
	E1xYi4nYgVLq8uIuaYmecZYtftYsHoCPhwjvjj8Jsh0lffc9JN7/Z7F6TVpF9ftR+u1pO0pvUSi
	+dJD7Yh5uhLwJcWeItykkFOhhCADtUhdvgkK1qfaaiiVJxfibdjunQ+xBeQpgeUKxWfSw2kuCWh
	dGcjWnFW/yiE3HpsRoNqIr/gOhT7jw+z/0Tj2ypjJnlM=
X-Received: by 2002:a05:6a21:398f:b0:3dd:85aa:d26a with SMTP id adf61e73a8af0-3de0e7f02e6mr14024783637.34.1790702846557;
        Tue, 29 Sep 2026 10:27:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:398f:b0:3dd:85aa:d26a with SMTP id adf61e73a8af0-3de0e7f02e6mr14024769637.34.1790702846060;
        Tue, 29 Sep 2026 10:27:26 -0700 (PDT)
Received: from [192.168.1.3] ([122.164.83.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8868c9d62afsm280619b3a.44.2026.09.29.10.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 10:27:25 -0700 (PDT)
Message-ID: <b77e8d79-fc90-4bf8-835e-23e84198a008@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 22:57:07 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/11] Add a few minor enhancements to the
 Qualcomm IPQ GCC drivers.
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <179065171028.2673486.10540547681271836423.b4-ty@b4>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <179065171028.2673486.10540547681271836423.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2OSBTYWx0ZWRfX+Vwwjr2Iqxbd
 TsJUAp9ciVr+3YO6p1MX9bE8Prw7V9RxhDpe9+BIqT7qL1nKR6xrKfp379brLS4QgVtHedXZWdq
 uC5ssDsBzcha+dnqSrhk8Q/cgKBmQKU=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abbf4ff cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=1HAn/k65X8NeSyO5TsuCIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NSf5Sc59ZZly-qZ_PXUA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2OSBTYWx0ZWRfXxjHCY7b3Z/4x
 Vf1SDg39OElzu6dUqmWgNrNR5+7A+QVEIFU/KpqfZGPjrdEz64u1rN2rMnOelRXCqE+uSaDO/WE
 XOATSOU2/mahxS34WmqfkbZmCbNkmJYUMHmQHwWwgfoLId3AdJGD/Q4XKKZsQA7149lTEUTA2ry
 lG1RBS8lUrV6f/JhqDibZFA+Cg7KJXHPk1KkFfsvxhJxlzVICTTb2EFWZBH4aT1T9R3YfQDkq3O
 TEVe1M7DABq4SV2R0M0oIGBzroJ6mEyMRIUpdW/yYmOjsIuv+XOwbRETt338bkxmaV2ryUjQyr4
 2/OqrBYc4xk+Ch+68ZCtjp7UbrbE7vezxsQY+AfUOIEszHckotx2eVickyHu9LkQF9uG8CYNs7x
 6SBowWlivk6UWiq4skoR/jsxOgrEid/CRLmzsa0GwHmyShic6a9kFe9NnaPwZcS0dnqlxbB1cVl
 yprKEMW17Fm3FFZe9rQ==
X-Proofpoint-GUID: 0SRA3_R2sY1N8B14vbSbAT-u-A3FueaK
X-Proofpoint-ORIG-GUID: 0SRA3_R2sY1N8B14vbSbAT-u-A3FueaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290069


On 9/29/2026 8:44 AM, Bjorn Andersson wrote:
> On Mon, 21 Sep 2026 11:49:33 +0530, Kathiravan Thirumoorthy wrote:
>> This series adds USB, NSS, and clock-related updates for several
>> Qualcomm IPQ SoCs, including:
>>
>>    - Configure the USB UTMI reference clock to 24 MHz on IPQ5018,
>>      IPQ5210, and IPQ5332 to fix USB enumeration issues.
>>    - Wire the USB3 PHY PIPE clocks to GCC on IPQ5424 and IPQ9574.
>>    - Add NSS MEMNOC clocks and corresponding clock and ICC IDs for
>>      IPQ5424.
>>    - Connect the IPQ5424 PPE clock to GCC and document the required
>>      clock input ordering.
>>    - Add UNIPHY XPCS reset definitions required for NSS support on
>>      IPQ5210.
>>    - Fix IPA-related typos in the IPQ5424 APSS clock driver.
>>
>> [...]
> Applied, thanks!
>
> [01/11] clk: qcom: ipq5018: add 24MHz rate for USB UTMI clock
>          commit: 0fe2995196a5973e226f506c9ec705f0dccec82f
> [02/11] clk: qcom: ipq5332: add 24MHz rate for USB UTMI clock
>          commit: 33e6a4864ddc4824f8a9505a97232b7879eb5528
> [03/11] clk: qcom: ipq5210: add 24MHz rate for USB UTMI clock
>          commit: 0336b65aef4721edbc01073dffdf9bc12673f0e5
> [04/11] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC
>          commit: 117d8d40be1ded4f35f3252efa83607a7134d5e0

Thanks Bjorn. Patch 10/11 and 11/11 are independent of the IPQ5424 
dt-binding discussion. Since those patches are not bug fixes, added into 
the last part of the series. Can you pick those patches as well for v7.4?

>
> Best regards,
