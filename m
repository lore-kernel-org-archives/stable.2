Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793682958;
	b=kxwqAX+KGuUZAbuch8TLGO9oNp+viddwBo0qU01c5N7Ya7/01cQbrpRBxW2r4K7/hLJu
	 jSjxSQ+68j3hq4QAme3JEjC4FaORlTVSeeEBqndyID3l8Ul1hEmJZ0hbbL1ktrHEPU7C1
	 hlEyhsLoASuA3ttbpOOMzHKUFTe8sySil4Su/NHmRZItWWi251Olq5HwNk/FunRCQuJCO
	 7R5Of+sBHS4DMPXHvxf+RtqFhrJ6j/QXbrXwrjPf2nPNvIRm45fElfvtcyxs5knfg+PzC
	 Hxykqt3hGDGcLE9iSNit8cgth4bYhsT1YffO8eT9+X5cg6SgIzGyoLziSV2yn0t4UlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682958;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xTRrlyDoy7EVZYwU152JYLRxtMJGNPslDC+aQvpyMkA=;
	b=alZGZM3dSyYvfq56GTRKbGrrAJzcMLwaaCSIW/3GjrrO0hXmikbb+lZUf1Ea6L3hOhIE
	 FsnHddPe/ze+t6MSQChwrYPSe3plAIKCYlszg59GxKrQiWOy/kIYnqHueHPIEHYlFMSD8
	 qchq+w13ujcUnyhnca8h3MMTTT19QAcHC/fndJgzpSKOEbas7BkXTULPgXUJTtKO3MKcu
	 zBmjnl6o39LZLHG/nG9bidgB+TaFeE+F6GmfGcDlXchslOMLi0vhRCmWi5Z4kCGabEKI6
	 qRy5wFlGdJcLJxBHiMq8pu04UlE+vkT52MyUgRNGBwVL9GteKvor0VO1soWddXw6JEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ORvIJS1n;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FE+alEup;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA22606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 05:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA22606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ORvIJS1n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FE+alEup
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A32C3JT2106827
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 05:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xTRrlyDoy7EVZYwU152JYLRxtMJGNPslDC+aQvpyMkA=; b=ORvIJS1na4Fn+v0g
	HinKegmpNDkvU7G0tetJOyhqavkqpXre145VlmM0+jKXaQHMghxlhdRejYPvQZmC
	6nS4kryPLvxWJZ7YjUx3cgOeoMANYeUrVffL23zQoA0eta6Nk4inQANaoxJIAFOj
	6Na04QeZmKDxauru1pTAUmhHOQyG5BwRFxFJ36vrx3LjaskEmacpDlHLcm1DjEWa
	dDOoi9ocDLvy5TaARCk0nZY1PU0y8TffXMSLCjSBerZpeD/w2E4Ov61E6XzEw8tG
	D170URgRj8ylBeMEtmfx2rK6AAVo+SMtdWHXAVtmw5WP4qnteHwGNybPaxTs08bC
	OC66vw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m98j7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:15:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae73921fd1so3136414a91.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 21:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793682955; x=1794287755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTRrlyDoy7EVZYwU152JYLRxtMJGNPslDC+aQvpyMkA=;
        b=FE+alEupiVxijjhG4JjH+aGSk4hEpVFNZ36t5rFp3A3mNElh8ZiQZFC1qGwusqiV8M
         pADYaIxg4rxdM1Ku8DVzrTNHdYGbI3/X0OMNyE5P1YRi409n+QwKFEryZHnoUY952HX6
         G1oM/eEXxnSG1uEuTT15ydHu30vtEFLLdRj5vgtJqjiefg8SAnK2uaR2M9CkGKxOx19Z
         SPfgDILFeGkvXyk/FGZxvIDOo27EY1jM5Ty0Pnn1jJWnfJBypleq/q+gQUlo5th692c4
         Ll9CNanx+sRvjVf3j30fPcwWtymxvRs7Y8I5RjO4D6OqUGgmyUFTpbkrj2+aXhuDI1Lj
         MHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793682955; x=1794287755;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTRrlyDoy7EVZYwU152JYLRxtMJGNPslDC+aQvpyMkA=;
        b=bz7Kpf5ZtqbgMGut4RfGhczakoSqyOgz2L9wAOOopDNHlGtp5Q4BMRaHUGsezVJNZE
         L1FghUn5HCffhHTTNNozcuwE+x27kHilLPF45oEPtlQCMsSmcDUWsN8pYYa5AT5/I4r9
         8SOybxgD+htT+3PhDK3TUzmRvXQwMwZN0HPzNV2A+zPUrZz21y9rFnC74PvZddBE0kkk
         wJE+9MgUstz5LyorcLzqzbBatBb0LXLq1zAgJqKFIjNt3vNnYtuDGZPfZhZIzyZn0JJS
         vU7CGOo5U3CPm+7mBrg5nhU+2yKG2VaUuXPrBMmip4OPMgH0Sz7AFE9WL/2CnTy6EhJr
         8bvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzarvizedrg06SwmmQndo4md22t/CGZTv5KgyyBx2mhCLgiREq7XGSpuY8bg0PMgxoT2d9a3dQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NyfCJFeVoT8oxlsLrYloMn5X4lSLKHH1N543uErYDabaB0FH9
	qBe4N7/3KMxNYL+TSaPRkOVQF2ZexP2HBGmqr3ATxyQNuaIsEl9nSWG0U4vfBIeNhFY5FaPggKM
	msl01hEgepVq3O8xTxVHEBWosDaLS+BK0X6743hrf3KaV+wCWhSw8CDsZbcQ=
X-Gm-Gg: AYBFou3oe7Bundq55v0X3c9mLYbKXbTBORT/B8yOb2jhe6nCgnPTp+zBv7VarA0IuM3
	+CjGW5w/kErL0HrrhkdgnClVItDdCoUu8aRHuF7rqZ1F3qS65S5taqcYhchZwRF2QakaUrLSS70
	IMo7YVuKRhzx0mvp87H/uVFN9wgsjU4cffac18wrWGEYJPD6AkLa7KiZ4DGGn/NVHMh1Mxt/PQz
	PnKnk0Rl3c2UpS0PkAlbcuxQ+Fp1j5Wp1VIFaHvlHIkCQDJNl5SOA+O+hebWNG2y+0AMMQTHwvP
	qAI8OqWMBJ0KSG1oG7M8MlxJ+2Yk/DRxA1OJPxvWicijBWWnEQ/CS20Pu9NDH7Irq3r7vUqDnAx
	spoUXAGMTkJoB3aPRFODIlDW0CQbByPKQs7nwFzhBBI0K6KOCtZSkWMelQoTkO+sEX0Ps9csCH/
	Lu0A==
X-Received: by 2002:a17:90b:4c12:b0:3ae:5572:c4d1 with SMTP id 98e67ed59e1d1-3ae8986e3bamr10861968a91.62.1793682955361;
        Mon, 02 Nov 2026 21:15:55 -0800 (PST)
X-Received: by 2002:a17:90b:4c12:b0:3ae:5572:c4d1 with SMTP id 98e67ed59e1d1-3ae8986e3bamr10861935a91.62.1793682954712;
        Mon, 02 Nov 2026 21:15:54 -0800 (PST)
Received: from [10.219.57.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5814basm2423083a91.2.2026.11.02.21.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 21:15:54 -0800 (PST)
Message-ID: <43f340a6-3999-4cab-90dd-2cf7a537f5a4@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 10:45:48 +0530
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
Subject: Re: [PATCH] arm64: dts: qcom: sm8750: Fix iommu stream ID masks for
 CDSP compute CBs
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        stable@vger.kernel.org
References: <20261029-sm8750-fix-sid-masks-v1-1-5ed50a1a0342@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261029-sm8750-fix-sid-masks-v1-1-5ed50a1a0342@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GqqpRZKU_Pe38f7sNwIXJlJF3ZhmhmCc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMCBTYWx0ZWRfX+LFwirN3crHE
 +72SAIDiLDu6Ix69hWSUfudIZXGyASPj1gikRog/igUQ7M5izHe+NiBO+ZhGtzuiumtnhIM5Sda
 O7uGpvSXGaWxT8eJEuhfwfwQ9I5w4/4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMCBTYWx0ZWRfX1BSo0XtpSNsL
 6hKJlVsjOETfIGWcoSQQbAgXllFU5GPWbhv5IYj3urbQquAyqOEZ2cffB/4KlNL53gZmREc3LLs
 Hh4KF26+Vi0Auv5I9u+ledU8XuyUKqs+lPgesMDOweJX4la3bChu1OAA9ArVu42wcqOHCFzdAcl
 sQKtL1Wu2BxyUK3ofoZU8rKad4YTIkT9hziwYjRgVwev9jWUE64qHxmO6GnzSHtWgYX5ITE5//P
 NBBBXyfXf4hGc5krRi9G5n71Jj14FF+PR2Wpq9Yel2OTmaZj5W8hWOeHswrcMD6yuLv5p9XlFOD
 icxN/OpFJ79XOHaBbDzAWFmYjc43O13wyzDKsqiVfSsvORWG7+gJUUEpKztJstjbwMR0EfOf2ei
 KUA5uev/SDH3EHMk3fUWgobzPLZWP396O5VzB0esgaVLthCKaCTJCuRKr8gD3Gr1D8UW+wTg7N1
 656r4k4flrFwW4BZxTA==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae96e0c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B0GhShHi1rKA2Csm87UA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: GqqpRZKU_Pe38f7sNwIXJlJF3ZhmhmCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030020

On 29-10-2026 20:11, Vinayak Katoch wrote:
> The stream ID masks of compute-cb@12 and compute-cb@14 are wrong, so
> these two context banks fail to probe.
> 
> Fix the masks:
>  - compute-cb@12: SID 0x0c2c, mask 0x20 -> 0x0
>  - compute-cb@14: SID 0x0c0e, mask 0x20 -> 0x40
> 
> Fixes: 58471055ae76 ("arm64: dts: qcom: sm8750: Add CDSP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

