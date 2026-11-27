Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773061;
	b=NiTgmKLBLR8HvRKGyEme2H5Dr9fA9yakFDY7QilAkdsIGwf1HAob/igGaAJrx2J3+hel
	 CnMQ5D+dN9v7YxJRMS+0cnfpFdA1EO0JwWcRL11JHmSn9AW9oAN2ZVit18jQiwYKQ6ng9
	 mEAjwoSEzDJuSOYeACFHjypPlHhSbBet0E+YV6dJY1UV4an61Ex2VSw9X93ac9no4fQr0
	 41aOtqFr2B9VkTkpdjEWizdVEVL0Kuv/NUJ9PVvRQWy6ybhmBcRDAQbor8SdxADUyhXHz
	 hq0JBk2BgBLJUCEGy49ruVb+/gxsBySTuVmwS525DSP+mPfVK6YGtxBKfnWUWJyCbSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773061;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=A81/evmtXSXLzvLuiLw8StiMfkySlbyx4fD1Kh2PSYI=;
	b=OEBLPNgM5XJJSFF71TI2K1xlir0AO74DsPebGRuWmg8GZtx4vn8lGbeFbmv5LuUhuqhe
	 7mv0s9v8LZIj1E1xPrMZxuYXjBoGC5c9GBige4AHQl310ZkPOIsv8WkkZFZHLXMY1LB6T
	 RDFP9F1HGd+IAU+TBD90CO3ytaq2tSzu8jC86mom/T5MuaamDh+unZ4D2GJSTPPb64jol
	 iJMGPYSDZO4GwH0EPKP1Kt7+tDR28AyRbz8XMwe7cXSs9JbGEBI5Ms/u/zRxwqhowuISh
	 4y6dJEl3dlel5Q3STFx1g8sjaw9Wka5bNUN0zugNcCP29SzgAkQr9PhWTHEq86M9q+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ae64XGVr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jpXlsv+v;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C5606A329
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 665C5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ae64XGVr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jpXlsv+v
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7Gi262421543
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A81/evmtXSXLzvLuiLw8StiMfkySlbyx4fD1Kh2PSYI=; b=ae64XGVrDFdsC2dL
	t1qoaEHuj4sOmQrjztuSDgEtSAmiED4B/yJbpt4LmD/I2QKxe3JCAwjsBAbPQxgF
	BDFSjsmgcY1Js8BISsFGMrJ+WoMCFF0eN7a6ib28gMNobVKVse9odgvqrDPhu2KJ
	MmdeOcCS4TGPOj/dDhUUtLvFFt07ZwwUgjtvTA+xle+97EQ8TMed4z3nXgsePb6I
	XAXsIsW9YVokD/lg3Qcw3abpRLZCo84j20aEoF6dtMQHT7qBwu7B7alZ7e1YUieH
	GYq4Yb//Crc9urwpT0nIjHWPBwR7V/MUOn2tpKjI2UsH8xiUJC+C1KThXb73oD1i
	fFIy+A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf92wna-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:50:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdd77f53db5so4149741a12.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795773059; x=1796377859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A81/evmtXSXLzvLuiLw8StiMfkySlbyx4fD1Kh2PSYI=;
        b=jpXlsv+vMpOTJEguY99AhFXxNHoJ83C6PYEobd0QjtKeZIPZmYRVNE4v8EBZvRbUB5
         ckATbqDwUDiM9JuE7PR0kRPPgZHU+jY3PwGASJq8wEwm0vxOSvAlwdQI7VdTc2zOuDTP
         cHRXVG38YDBruA9S/8Q6+kw/lbCZEkILBtTCkhEhY4YS72CKjeCi15hB6SKXnjpuXE3E
         Epo8iznUpdDEtmMlrZEQBAcqYADVkHOpdQCBY53mJYnSGOqrnGBu7D55yhuQ9OEOt2vN
         x6Lb/uCu9gn6GFdimJ1cOHgvfpqNSRPWf0VAEA2GjOnuGw7cFyOfhKX3s8tk2v6URm+v
         5DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795773059; x=1796377859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A81/evmtXSXLzvLuiLw8StiMfkySlbyx4fD1Kh2PSYI=;
        b=ut+4EID/FSvRvvCbfFHIQooC2U2YDZNavjJGlvW+bkM39UmXZ4WDceUn11an6CbFbb
         cKcjGe/jqs1Y+6kTKFs4jeBCXK1asM45L3AMKRrRHgvmeUIyCS7ieiH7QwCctbft+Qts
         Crgw+ORiu5wVl52rb8rizekmPRidqRjW9yDKDz6F6Mcc/c5ZoMeOVGkBtbCu+ujIBiFI
         6bsEzzgv/Ib8xySPEjdMxXu6Scy7h95Zqc+EAVPdroH4ffZmdbss8DAsRfqkFShezVTI
         R6MCxgVQSeHRtJ5Ec5pQYuv917/mB0CgStYLkYNKR05Mn4fMWpwfeMHxnNBry3LZQYOC
         yA9A==
X-Forwarded-Encrypted: i=1; AL+hErExCqWYcx5bV9cxI+2BEhno0iFqOapTRC0bZoenJ5UcgalKit7E+1NFnlah2N/6GE5Kqzitj0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W1AWZJ5/B6cyR5xrQkDY8ZlOYDRBY/41Ex6ih0T0CzV/6mKjC
	I7bSbd4kWTCCxGK1F1ZKml57XsGD9I3FZ7JQUUGJV+wUYMpGifpF2qPQufcO+sahE3DP5uZ4+d2
	N8vCn/FwzPWtZXM3Vce33K0ZIFrB/DlQeCdsFpjWPfgvhEPOoV0BtIQbPfJ4=
X-Gm-Gg: AZFdTZfmfmTA5fQ7uuetPaAG3FCYeiBDu4upvbT7XE0MWmmq6RWyX8poQI8XyNpmTMo
	Or6uYS5uBr0x8ACm/iJ9dBUWiAOiE6nMMVJY0vfQQpbFuJlEuBuepS5NkSvFgqa6/DQxek223R6
	M8ab1/pGbQLl9rVhRkcHkOJqEp0UXbB3r2Nt3BE9ORUN/hygbtqNBCL2g2yhdiqDzdIHarNndJc
	Mn6woJ3OLp88ss8Ebaxu8qZWZqCbAIyhT/ottgxESdXQntBBsxC56zhfD7CEAegqbBdNkQF/WzX
	Pl8TH2TI6sa4ehcxxMjmSaux3icKnitewp2jsNISkXuLm1SFTBuKJRZFn2sckm7b4a4SOvbvU8K
	mhAVn+/aQMn7beKT14N9YWh2N31mLzc5BCYwzjP0cYg4QBW4vigogFPFOVK3CbCTqq9YEZSAHnh
	AnZwCiPi4zz+zUCmtdLjgDrQAQn1LqDrteLoHwRBrhmWksPyw6IeFWXqgJlRYxBdOK9HWSZPDqv
	Luc
X-Received: by 2002:a05:6a20:b40a:b0:3e3:37ff:3797 with SMTP id adf61e73a8af0-4014bc4bcddmr22367461637.45.1795773058845;
        Fri, 27 Nov 2026 01:50:58 -0800 (PST)
X-Received: by 2002:a05:6a20:b40a:b0:3e3:37ff:3797 with SMTP id adf61e73a8af0-4014bc4bcddmr22367439637.45.1795773058397;
        Fri, 27 Nov 2026 01:50:58 -0800 (PST)
Received: from [10.149.108.218] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c908a56acfsm11467784b3a.23.2026.11.27.01.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:50:58 -0800 (PST)
Message-ID: <920b2c6b-53c4-46d8-b949-9c50795ca15e@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:20:53 +0530
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
Subject: Re: [PATCH 4/4] remoteproc: qcom: Fix bounds check in
 wcnss_da_to_va()
To: Atul Akella <atul.akella@gmail.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, sibi.sankar@oss.qualcomm.com,
        quic_srichara@quicinc.com
Cc: linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261106184312.100-1-atul.akella@gmail.com>
 <20261106184312.100-5-atul.akella@gmail.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20261106184312.100-5-atul.akella@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VrAOV_kag2NgmxdZ5T9Y41zTj3RFrlDP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX07ofH7fKh4cU
 lt4u0sa9AghotX8AZWzNxcd5VkZmIeHRbfArYJPzdStlFnS4FoXh2GjnIJy1tvTYyey7NLBP7lV
 /Nb++500bOPf+RsW6UirX0Fcu2loReiA7Z9ggXNf+hOR/EuKM1I4b/z5c983akjkvzsnbfy6JoP
 7M7E3lqetdPj4o/lskqJWxtDW9omlGqxyJZVZ1v093iz4hcBdD3MAdyDoWSdavTkUaUAVwvlOpQ
 uZ6OALywyWa7etJ0s+0wtLBZ5m8vbo2FN4lctOQYMYe//eNtQAwy6fIrQtWMW1/yczU2+HCcm72
 5+asXd4tw76tNslIfaTPLU2KKP5Vo/WvfIu+GSozTUjX4LCR7Yjy1UjakHbGy2hv8iltty/0aWO
 aExcfO4lxr4GMqQeZ1SEMxLcwsBQWoBgxWmPPP3VJsVRL8WqMWSqeOBKg87kJxMj7qBhIfsH4AB
 EBy/L+9JOvU2ujOhkJg==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b095283 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=E4ycadI1TCjYcBWHacUA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfXyjS0p7xS/7qc
 xeReU9Zu3xvsVhmHjyOqOA1pBaleHUhmC7Q6grBtCTrAvezS2dbrgDg6TXdbJIHON3tQRxr/mRv
 S7pt+A8B6W84/Ijus4DY84lljtc6T64=
X-Proofpoint-GUID: VrAOV_kag2NgmxdZ5T9Y41zTj3RFrlDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270039



On 11/7/2026 12:13 AM, Atul Akella wrote:
> offset is calculated as da - wcnss->mem_reloc and stored in a
> 32 bit signed int, while da and wcnss->mem_reloc are both u64.
> For a sufficiently small da, the 64bit difference is truncated
> into the 32 bit int, bypassing the offset < 0 underflow check
> with a small positive value. Additionally, offset + len >
> wcnss->mem_size can itself overflow when offset and len are both
> large, providing a second bypass.
> 
> da and len come from firmware's ELF program headers via
> rproc_da_to_va(), and the result is used by the ELF loader
> to write firmware segments, so a malformed firmware image can
> cause writes outside the carveout.
> 
> Rewrite the bounds check entirely in u64 arithmetic. Reject
> underflow before computing offset (da < wcnss->mem_reloc).
> Replace the addition based overflow check with a
> subtraction based one (len > wcnss->mem_size - offset) so no
> intermediate sum can wrap.
> 
> Fixes: aed361adca9f ("remoteproc: qcom: Introduce WCNSS peripheral image loader")
> Cc: stable@vger.kernel.org
> Signed-off-by: Atul Akella <atul.akella@gmail.com>
> ---

Reviewed-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>

Thanks,
Gopikrishna
