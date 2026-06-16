Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D1343D85
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612575; cv=none; b=DnYb2dcd0OpO8DSK5WN188+7IytdA+XsRsExNQsE89hMw/0UNeyMxuKnp22L7jUc+rU47W8nLtpCmK34bWRu9zvxa4yxWaT6HPOn9hBQgIsvBRmjeNT7O4On+rJyO3L9bnKS+QHUnrZwRhOF+Aw0ls4Pc6Hrl3DIBW+G9GLgXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612575; c=relaxed/simple;
	bh=D7NXdzkCcINECpn3/BnF0aqzW8DC+JtguYIvQdgYpTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrVTHPoAwr93h60v7e7su2oFL4o6uzYYJKjjWSLY57qOiEoRg2nFv2J2w9Lv9Pvie7qC3wmXWtfBZRR/dezpDqCHxBJogVtBFxOoSz2V5ZHwWeITPdb8aUUYrj9lIkpiapYQ/CIee0d2wdL78BY+pLBu8uLcAXh7Tvi9RAvEU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5Ji00lZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JNZ7kJK4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5Ji00lZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JNZ7kJK4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GABosc3384159
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bcEkcPtMtutFQ0nojyplD+yn0BA2r3GEybBSJI5Xbag=; b=T5Ji00lZ0+MfQp6X
	1Czl+gt8xy30ur9IlOuLgACtwG82+77wZ42OSb4Xn7bndEYGfn7w2pVwuRWdW3kD
	fmFL9PnPEZQKtabuuqogfY2fRhc6bhe1FzoeORITtmmd0RNGMMIKyyWiZ6W2CGSV
	4uxNhRVOEoMRVFctwqkOt0mUxSzPwMuve5Biexe/SxIBXNB5uy5/87SjdpUKbQAa
	4LNDjsZB1HCpOvFGhMYWqhH1YQeniRk4gvip/W+pSEfUmhSpNruOr9Q626Q1ycag
	T4SQuxVAqRgEhaWL6mRcqujeOtuFj1Yuw1s32MtGxiuW9NJmrcIdnSSda65ZZqGs
	TDQOtg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ep9btw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:22:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9157b3e5182so15789285a.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781612573; x=1782217373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcEkcPtMtutFQ0nojyplD+yn0BA2r3GEybBSJI5Xbag=;
        b=JNZ7kJK4AU0fYxQ1VJt/PgO3IbGIzCJ0aCf9/pXNEqd+wqGydnuJAGL3e0h+vGKvKl
         ZKUfFyuQjo7QvYclZ2XlsfnCK5BBSUb7LMOwDv/hm/Grywj/Th8eG/3rsuNCT3c+Ks1J
         aUpwBnkEOqnHJPREc4iXiCEM+GBCNNA+owhWVoDt6aNzZOZ4MfbJYRi+gzQRXkeR8kaG
         yFHEWShq94k4AFYG6um+al+Ga5xGj97MvrFXf8UXIUoeKjY9iR+8WbSX3wVelauGXeNH
         8XLimEvuI2tuhpzUBvLivU/oArlidhYJY8A2ECjfxezA9hHhQPm0EEht6hb0IQKBBx5w
         hy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781612573; x=1782217373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcEkcPtMtutFQ0nojyplD+yn0BA2r3GEybBSJI5Xbag=;
        b=o1dkcT2v6D2PfvQbHvbpG7yiEEOqncK3GxN6n6L5XQBffznODieKEoA2GFALDt0g9G
         kIaGqX8HU6qp+x68+Zp/8wKHw26BS/bO5ZU13t3MeKs/rfg5jw4saN/6qC1x6gTzBwTt
         8eUncQNNjm8hS3pFI/8vJdyUGD94mGrysYmEBZWbKYQgKft9QryxSzDb1JcF432bVYyC
         7yHe4lcikM78pbYWHOBctXsJZwPgZ3l2mn4Klxb/BJagx/09bSAbaMg9memi+uSaf71U
         cWATwteDwIT/VPiqQo1zF/ayRzyTAN66Ly2XC+QT+LU4r1dOmIMUXb2UbYn6JyPAFCc/
         qbWg==
X-Forwarded-Encrypted: i=1; AFNElJ+tIeie5tIOcNtR0ICFNqCbmU32Ta2WPK+CR3cMVpI8gW5K+1rJba4gG3BPAAXENn3P6K4cuEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcak0Di4BRhyNnDtEPsbesgp5WU9/89jRttE26lBl4g77HfJr
	B+iQXGl0LqPiq3Vk1LPHJgAynmwfnx9aT+wk9whYeIfCIikTr88+PQwDnzFPW8GtXSszYka6/cL
	mcnTy7b+dG92UfJkQ/4bNOuhRJUrWFV+Phjmy/IuKYusZu55h0gGflbrujwY=
X-Gm-Gg: Acq92OESPpwYTIr+ShQOibhOdduYAyK19cYEYMMMpdIHX+CNLGe+YdoJmfn8gwxZXYe
	EbjrGSkpchxuOr/hz7rxBpkPs0vG4pya3XyK3RpzUihODIYQxsF1p+q5WSu8tEanMwo8/KCiPaQ
	VC22YShBwPgvHOV4IRO3ockjnb7bBz71Akg5P2Iz2dCZ8vhOUALcXTFbokwHhY8sIPu27kUuCsH
	VLjpp5xH5LxPbVUDfCUwxqq6mKcPyCgtMTp+rhohWoDCqdzfJPIN4w6j6iDPsN7dsi6JevVy0fL
	lnP/h0AmgAPpKfLLmIJUPzIZjQpVQ1jgK8EiLmcocznwU1W5ppOA8diLGsC9uN7WaM2YzJmN5CN
	Etyquu37gNoorNJTsAS3Nyw5GoP861oIefWtWazawFK4aLA==
X-Received: by 2002:a05:620a:40d1:b0:8cf:d289:d0f3 with SMTP id af79cd13be357-9161bca6345mr1765200585a.4.1781612572828;
        Tue, 16 Jun 2026 05:22:52 -0700 (PDT)
X-Received: by 2002:a05:620a:40d1:b0:8cf:d289:d0f3 with SMTP id af79cd13be357-9161bca6345mr1765197085a.4.1781612572365;
        Tue, 16 Jun 2026 05:22:52 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb5103710sm636854066b.22.2026.06.16.05.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 05:22:51 -0700 (PDT)
Message-ID: <38dcea05-581c-411f-9196-caac9562d412@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:22:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: x1-dell-thena: mark l12b and
 l15b always-on
To: Michael Scott <mike.scott@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
Cc: vkoul@kernel.org, neil.armstrong@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, wesley.cheng@oss.qualcomm.com,
        abelvesa@kernel.org, faisal.hassan@oss.qualcomm.com,
        linux-phy@lists.infradead.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org, val@packett.cool,
        bryan.odonoghue@linaro.org, laurentiu.tudor1@dell.com,
        alex.vinarskis@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260521010935.1333494-1-mike.scott@oss.qualcomm.com>
 <20260521010935.1333494-4-mike.scott@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260521010935.1333494-4-mike.scott@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31401d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KdsBoOkKT-vHJQxM7ZgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX38ZA7gDbxky4
 4HVQOkHIjHzO3TkUZMRmoqLYcQ/Mwn8ZtXOuRj3Dov6zClLU78NO4gQX0rEaKNVOTnuvVkj9OLn
 Og/sRu+BLKmLDhKb4RsC11sCegWqLyQ=
X-Proofpoint-ORIG-GUID: arKmEafUBv4v6cz-9grDBsSlpQGCTj1N
X-Proofpoint-GUID: arKmEafUBv4v6cz-9grDBsSlpQGCTj1N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX1Ib44sQ88DnK
 rJ/Vs+A2kvw0loRA2rJ+YD4aVf+jg19U5LpDHIQFqtDI4tTu3OkfMZU13Szh3K0ADjrMOMznQsE
 aXO5aOqjlTlm3lRpQxiXgb6CgxLB+newT+7t5qD7B6YTJnIPbU8014H/NNTy9znYuns7yEppctz
 E5NZFmuWC3MKVStUHlmOWNuw+XlN0j7Zc8xE6JSJNyeWYytFxGEZsyx747qbTjed+UxP1mhcCC5
 665D4HlcbdWGh6ZhXKaM2Ahki0X5Tdq5EzW5GxNiISYXiU4co8xmg7nej/Dxuj6eqSTLIPjRu6E
 ENAx3KGBpM08PMwx0gN3TDmZS7pIEP0bYqrN5ISTmt93A2DNoK599eqtZFSrhm0AEfI9o9ce2fX
 HHKQr8qMqJ8OYmg4XO1GHwBKrDVTiWtUn3Xf5grIzccz9WvVFJfdfx0yV7D8nq1xi0I5TA1Malb
 0y0ehy+0cknKu1zeENw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160125

On 5/21/26 3:09 AM, Michael Scott wrote:
> The l12b and l15b supplies are used by components that are not (fully)
> described (and some never will be) and must never be disabled.
> 
> Mark the regulators as always-on to prevent them from being disabled,
> for example, when consumers probe defer or suspend.
> 
> Note that these supplies currently have no consumers described in
> mainline for dell-thena beyond the audio codec (vdd-buck/vdd-rxtx/
> vdd-io on wcd938x), which can release them when the codec goes idle.
> The board-level gpio-fixed regulators that feed the Type-C retimer's
> VDDIO and other rails are not described with a vin-supply link, so
> the kernel cannot keep their parent LDOs alive on its own.
> 
> This mirrors the same change Johan Hovold applied to every other
> X1E80100 board in a March 2025 series; commit 63169c07d740
> ("arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b and l15b always-on")
> is representative. The dell-thena board file was introduced four months
> later and did not inherit that change; this patch closes the gap.
> 
> Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Scott <mike.scott@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
