Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559975;
	b=YsLAoezFyapDb5nt1g/lkPNy3UGlh0q8YoWzKxzR9AZVMFzy0guMAz0UKqmJygf78tda
	 j08mzRdeD8tQ8gs0t5kgV4YeZceYaHOZk+endEpFGS7z0jG6J2NIp4iemv5WOwz09sSKb
	 E/Ln8VdPqt4Clbbg5gw97fJ+ZV0/mWyfqJ/dWEJ8752vlHygRIAGdoBDlZ1r1Lb2lCNAk
	 qtcUI1mE5vvjB0/BgwIJBAMu3KESPVHblQXH9NP8rxUmzE3DnKuS0ZdVs0Xjs8nfcAEoy
	 B6ldb+OggDgCUQd1o/AGSxkdVIRhY1gHHykehgNHPYzVsWvjPOdDD1LLvEOgUeL255A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=33cTqS93VQUbbVeIcCrD75pZNgE7Uh33rHjvWjbfF90=;
	b=ZrqLa64yFIw0hEQCnbKuRuAsNAOEASMDISAnBj/kY2myZWYm6PMcVq7DajrX9NS/hesb
	 J9KFujaycytc7gx50rTNDSXi+7J7U+NdvVfRzxXMFCPz/cup97k1/xL3ZvyzaYBi4z/VW
	 krzUTKO8l1r/U2DKH/cxBMqhRryTjrae9RRQjXjQjf0YsvczUty35wZTjMxEjNOKkSmXK
	 x3MnA0xo+ETimsyDNjimEYpC8pSp176bWhqennsNXKMbhlyHrndA0WE+QNYnvsG9BsWak
	 EgBLCgmRziNE5CM7vvWqEYTBYd9ZTBvbKMw/7mlJ6vh2GFSK6idEiDBEZW9zIDDo3vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMRKsmdC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JFr9r6gi;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF1606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 19:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CF1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMRKsmdC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JFr9r6gi
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HRLIf2022048
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 19:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	33cTqS93VQUbbVeIcCrD75pZNgE7Uh33rHjvWjbfF90=; b=EMRKsmdC5woX7Uxv
	jv57183TZNgH9vN0WFV4bnXr5Lmg49w54lRk8ykXQx/Zjw4gAxQT1EWaIgqM/P3D
	G+7uHDZvRj7auKNKo36OIXN4cXjtNNLH6mgSG4wprpXrRuztiKLel4VbJS5ZfNzB
	MRROH2ai+wG8cj49u0REDHUD44jB2YRmkPJAzJhYaqtQ58sQwaULNfs+ocp3qMRF
	qD3SMortdMPufwuzEmmSBWNvofAV0t3U0uKdWVxIAEgRcdPrz5Xj1C5PTHVRWEIR
	D9fp/K3dh08G8cBrICIFFobK2KX9wIsS7iCZbyn4lm2+lfE14fLjaMw2tImJByds
	Wy5t5g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6m4jt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 19:06:13 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98c70917433so2418887241.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 11:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793559973; x=1794164773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=33cTqS93VQUbbVeIcCrD75pZNgE7Uh33rHjvWjbfF90=;
        b=JFr9r6gi2riSRIxDhhic/9hICwhKLS8MmpV+HZkmK8pRWr9ylADOzWp9sIlYgPJL/M
         1PhrRib6Jm0jE9VorFV/YBJxVd6RIJwRqWoEUks7pJMihu5J7Aqee8cw2zCZe4M16SUx
         MqmO7CdOI6JuFfa3hy/GwjLjyCcHTd95NMj1xMPUjFmMp7MPf5JtJY5db+A7hnz7dAg4
         +SxBJqhD/l6VOru0sOi1f+NeilU67YBNAgk1DZ/7THKJ5NolF3UNZ8dbq1FRjDi0u+sb
         AyZItlAcBtuDw29V/cpCU4GLDYPp8jz9a5+UTvLkmM3awKauLh3aLY+vnzoVJ6uOD172
         exew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559973; x=1794164773;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33cTqS93VQUbbVeIcCrD75pZNgE7Uh33rHjvWjbfF90=;
        b=o+0nVTgBCLDnDyBqKcGMoAjm78PNaoC4F6NUzI2o+oIs1OIIxbggPPLPX7G9GoKCj6
         svjKHv99gavIcryU1RWU8EF1O2iPDj+I7z7GwlRBzNBbTwIp6qdpaLpPoPhpFO+7ynhM
         xgv2Rb53QeJHXet09xDJtIoVCtb8lRDll0xyCB7Z2aeHjQUmLu5Wiwq8+yPhW9VK6jCY
         tjXTqF3va/Q8uhXPm5IRKsniYlUagIcbll6anbTkO6HDokwL1zv6mNN33a1dedZgfvgX
         sAgsQCT1Il+f5t2/gqd3kJPrxBMGPDSFwfDhUsaODG9mbaX4hPSJel+Z9iycZyeUKdhw
         z4UA==
X-Gm-Message-State: APuU4Z/0MIY6E/jz3o6V0vv+dmixGqF2/jxm05EbtHsx8bbVdch4adD0
	JN2+UYC94gsk3RGBDrJlDRT08QKToKeCSvkRgiV3uaQdoLqo8YURFNS7mn671IsRabYS8lFlp20
	CGlpjfCbJ1+KdwUAOrBMC8Oj13N/ckTXwNgrWgF44ZYJsMb36mUBL2dqL2Uw=
X-Gm-Gg: AYBFou3oNFotjMnLjR3eNmThEU6/hqm2IRouzuo1f+dxeTc6oQby0QrK/BYoKbUn8Jl
	dDpIwELkHbuRzyi/B2nqHHQxQBKXK2myDdavJKA6auAD71JJwuvt8B9LpWDiUbDdl5V2onqkCIu
	lgh6E5eTcVGCv8ysMSFkrbu6IlXG+JVlzNhtm66ysRrp/BxD+7u2z40AanXUcOkXnI4CzuvsAr2
	lVpAm9TinEzsM696CKQchyC1/ZbZvz+9crWmGY3IAv5Ld/J9s5q8H42xgiNVTM1Fnv+azdbEgq0
	olalNrEcaYKao/jdz9wcMA6kL9RDsLAqz5uqF4n0I6KqyjCfg4P9A8yuzb9FMOngoiZ+TSkFjHs
	f03ohbqvHA2OCDCQ+xzhBqSkP6DXFuDk6wCuPJBJMsj82105W1CQsotHLfs+oIrqhYNP6iuOACg
	==
X-Received: by 2002:a05:6102:6cc:b0:7d0:3eca:a872 with SMTP id ada2fe7eead31-7d072711c8cmr3652910137.27.1793559972789;
        Sun, 01 Nov 2026 11:06:12 -0800 (PST)
X-Received: by 2002:a05:6102:6cc:b0:7d0:3eca:a872 with SMTP id ada2fe7eead31-7d072711c8cmr3652895137.27.1793559972307;
        Sun, 01 Nov 2026 11:06:12 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b725b8sm15616335f8f.20.2026.11.01.11.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 11:06:10 -0800 (PST)
Message-ID: <07cf366c-4efe-4a80-a094-5ee93a683720@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 20:06:08 +0100
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
Subject: Re: [PATCH] soc: qcom: apr: Reject packets with header size larger
 than packet size
To: Srinivas Kandagatla <srini@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261101175407.110780-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261101175407.110780-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7Vt6XaW-l8iNNK24NoCjn4JaFBJFD66b
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae78da5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5t2Un5gMkzPXvGO7pNEA:9
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 7Vt6XaW-l8iNNK24NoCjn4JaFBJFD66b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NiBTYWx0ZWRfX0CQyyI9/Rs3V
 MNKhF+6LoOUxRuUJV8PFmbDZ/Fu8C9bDrgCtXH3g4xScght0jhM0l+/xQq1+x+TeLpk1u2zhjbE
 r6ra/Ms2iKrosSIQBXdcLuY9ShXBEiQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NiBTYWx0ZWRfXz+wDhd2paOhu
 1Ve5M67j+5sk1u6wmdUYSOECdWokYgPnYKcgwvRWKhkRoctGiNZpLQ8pBegzMKosj4HgPbRGgGw
 1Jb8r0LBcKW0XoIrBqdlZhFEjpf9LVNWdercB3SXzeuHQaH6yLyuN2CO7e5H51uFssLaglohUWl
 DqAwBHOlMOdwJaruiZqZsWCINDk6blS20/1z+1/VBVDC6viEtbrZV34Rrfp1nmGX3nK+sEmqFXL
 1Pnz25/fy2dVps76NLxXUAycXk9jXSYNEdsNfz1Llu4Avw50rSC5p4pwjLCmVsovlLzCqE1QjIq
 nMoD+SoPeo5bCgM04ROF6YWAIce+D5lXS/woYGJz4+z4byduXN3BIZQAFiDvmXg8ADbeMxlg9j4
 C7hRUzv6LFMPwb2yEafEPr/cP3nTGYxGsYfnlM7ZD2b+IBDRfjZmYquSAQ5dprRVF9DY3BcEwNw
 6flmWs5nomiEOlPOjJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010076

On 01/11/2026 18:54, Krzysztof Kozlowski wrote:
> apr_do_rx_callback() and gpr_do_rx_callback() validate the header size
> and the packet size separately, but never check that the header fits
> within the packet.  Both sizes are u16, so with a malformed packet where
> the header size exceeds the packet size, the subtraction computing
> resp.payload_size gets promoted to int and becomes negative.
> 
> Further check "resp.payload_size > 0" would fail, leading to
> resp.payload left uninitialized (stack value).  Reject such packets as
> having a wrong packet size, although unlikely that firmware would
> produce such packets.
> 
> Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
> Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-82d40745-1593-4c20-8432-d86099836525
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Valid Sashiko review.

Best regards,
Krzysztof
