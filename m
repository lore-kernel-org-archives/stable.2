Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016000;
	b=ZIxYB/ILLef0VZV2VDnjT8gOzTHMrdhtCjcd0LCFvJrrkH/5YuPhR28PBhfbrXQOh99b
	 wj3O0HhA06weO+bdnErGY3Prfs3+UihLYgvUc45yBlQ/EYbElItC7jQS8YDjZbGwRn7J4
	 FfZNuug1bQsJxlMEJYb4TDbGbWkYstRabhUna2AeEWiF253hBmaWkvQWMFT45eaW2AduG
	 /2O/9rCSDuOtaANJGUShCtkNyayQU9TivA4iyrWdnotU0B68kszLFTBsFiijOikKR4C62
	 D4N4Yti0ANkJimhhTt/JsxTMqCqFhzpg/6QhtTUmE+alf30dOamFGL33igoB4e1X7lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rtWr3blELUAHMd45WIMqDWi1b0Xo+6vTP24A83n8W18=;
	b=yQuYEJI12rUHs5e8OP6EL3bNEZ5EeWwKZ0B22Y6U43gRz6URyDmbNzJ11gJofgn3p6yi
	 A2IqsYj7v2m4Spu0dnVbYJ4J8J5l5p0mOEIctm6GgE4Rba2tqVM0w6SlyfVbMaG5z/ZVS
	 OmkGqVu2mdfeA4xl7ajGRjhawSoaS8rS9G0GWaN0P/t29oP272cBeMpH1PXs3JF0VqvC2
	 ihLwKR1zgSRi2joZwkYLR+iC2bgVQQSMDWbqsSbIqgLlxPi8oXhOWZ3duVHnNmHLw/RO0
	 SGHKfpzLyuhpxysFDNR9BqdO0sQgzd94cM5hp/hWz6MkIGQ3jWZYSg+1Pzvh7c9d4pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fu3kWOGP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TUdgz9t4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD37606A327
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECD37606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fu3kWOGP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TUdgz9t4
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAso3a4131369
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rtWr3blELUAHMd45WIMqDWi1b0Xo+6vTP24A83n8W18=; b=fu3kWOGP4Y6+tgGV
	FGGexaLb2UWT9K/cdofXCsW2OUbBfzOiD3adU29s6Ci/Was7o3avONGS3ytVbR3L
	djyGG2ZI7saajUZWdtTHVksfEzvQFmgeaoAOIKITuq2I3NcBpqRYDaqyGQ3+S1Ed
	yVzs4FPv+HCMsWR4yjd4T8IRT28gZH6M3dOh6gcIwfK2inOpxwkbN4BbqERcpwdt
	7ygMzCQzov35pM8ceIuYK5k6Rg2Q4maDpR5M0gJGp3VabfGmbde7P9eAy2FPwStj
	2n/uL9ltB2ls5YSDcu4xn0pCT5nR9GvQuyiqmCz6tFuDnI6gEJdBx6jnLJz/TLpB
	jg1kjA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q0aah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:59:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53630cded29so11531551cf.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793015998; x=1793620798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rtWr3blELUAHMd45WIMqDWi1b0Xo+6vTP24A83n8W18=;
        b=TUdgz9t4Oei6GrVCCkpAU8y36xJW7Rwo1tV8bbR6t5Wz2VYAmdOoAo0tnEfkt0LHox
         rRYvaiZz5Qkp+aEf+S+bcW3Rde6FtOZYSQsaKp4hZXmzadeLde1VVvOcdFYVHjY4kHuJ
         g9elrcOOUC0Ul0aUv737ul7gAmT8gHUc/skqLVLItkxRb6Y2mSNgi+inbFL0DRK3alYj
         pEyMNRdSsd/B7Uy+JKdg9QuRKeo/JnpolTEMjRAvMyDXx9xLTNSME3pkbkbsGDSyNUrc
         vEco8GvUl9a4Cgmfg7yOvqLcqqh2XBpox2QjC+sdrY3URyRaC9TXj8i08wRp355poano
         bgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015998; x=1793620798;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtWr3blELUAHMd45WIMqDWi1b0Xo+6vTP24A83n8W18=;
        b=GBv71xaQhYLqoCwTO7ZcsCLpM1kmkZUgXqExuopWzT6GC1URadK+tlpZw3MRrgepOS
         SXp/EjtBMBajA2B97L9rVisNSPDoKcembmFdkz2U9TqdgKm6xssGl00Lfe5Qs1/nlwBA
         /BJ8dk9v8NmazvBJt4KlOwrre5R5191DCglCSHidX5SSx6M2BxfRbh7yT8OcSGzVOjrZ
         PMwzLGfyiSkIWbDSG8EfbI6crViqyf2CusT52bI72it0a7rLiZA+3hHLatmKDHy8Ck1W
         UNxCs/O0xic5v/RlGLiy3nC4BMPmC8gcklJEUoxT/FLtxVzf7aezT9tcgJ+KmAFuohJv
         aMrg==
X-Forwarded-Encrypted: i=1; AKwUvBwPj87wFqgaj/x4U8u1owwu9DbCdfb0EjF0GgTTa63374ZMSi01Qg+zZWTfLUJfEL7o7tdyOKs=@vger.kernel.org
X-Gm-Message-State: AFq9FYItLO+9FWYqieycbKkesNSfP1HvUNwsNRTlwNr3lhrwOcH/GWUN
	2sXyAbOGtNcsuISwGv2R8Z92fhqxx22bz9bjJryvwJOQZHOsFGlqu3dNoVOiL3m6pAEs65XUhng
	sx4j/vY3amPasd0TqQdw0dGa7fNoXDOcqdikQtD53UMa8QHGE1JFh6qDBMnE=
X-Gm-Gg: AYBFou1BSeHIvbpirrhcGpqtzd/gAUC2/ynGL7dTGm6+dKb+W55XdRxKHX5t40zpodW
	xi/ygygfoX9yTOCbQb0mTP5KhVlCaphXAhHxIYD3HIUvQ7x+RB1sK1BI1gn1/kb00WYJNYIysGe
	appR0QSarO49BGTm9xkNsHc4pMAdTyBs2m8d5Cyi1FBdTpvwEZ5dCsD28ELl9UXcAbBFaRtaeLl
	jDXmtyHgCigSvv2VPeMAdED+X0Yh/XTwOqDTFq89iyhUyCNIfy6ghLeP8nL4T7adPOMgin0NDPD
	jDkk27qbxOOV5LFf41P+lPKW1oqH+0lOc6KJd9qvBcfUaKoZ9TvPY6PKQL3oJUxh5le1cersbcY
	+4Ejs0qRkOKSje9rkBxlB6w==
X-Received: by 2002:a05:620a:8703:10b0:93e:5a3f:ac13 with SMTP id af79cd13be357-940ef672271mr970545085a.0.1793015998003;
        Mon, 26 Oct 2026 04:59:58 -0700 (PDT)
X-Received: by 2002:a05:620a:8703:10b0:93e:5a3f:ac13 with SMTP id af79cd13be357-940ef672271mr970542285a.0.1793015997533;
        Mon, 26 Oct 2026 04:59:57 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b445990d9bsm3592295a12.30.2026.10.26.04.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:59:56 -0700 (PDT)
Message-ID: <e6b62824-8022-42bd-95c1-60322675d54b@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:59:54 +0100
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
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute
 CB9 entry
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
 <f0bd8179-f211-4d2e-bb0f-a419744de2ea@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f0bd8179-f211-4d2e-bb0f-a419744de2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfXxhz4yoqf/O8R
 Gv0nLIWWon+KTRqLNIFmcA5+CtSVHWuxLIsysCMcqgiifZIalUXt/Vvr5pSRqGpY7CjdcyoPhN/
 E79YEEI/pdbnLdyYXoNWp/xHdS7b24o=
X-Proofpoint-ORIG-GUID: BOsgCZo1KBFlWy8NUUAHhgYDlJvFniYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX1gtNLEMvEjEb
 NPNCD/N+kCBWZFpdqGZZ85nSedWtuVX7WhukVtESb1DVIitRVVKuvmrbNduIBou7qSExq5REJhi
 EVvpiFU+jdDVd82MZyw8eFa+oS2KRmCnN+ZaVR+xwiqT+6NlxNt2s0MJmivbQdUcnOO70TXGcy4
 eXazp+p4viF1OBncz2H7oS5Lsb8UF6vyPkNWUHkGfSKvoS+jKlR7DVFTYC17bg4DmGbKvvxKRws
 wA/ahITHzqzs1bx6TrEiTWdyxgzkPEMk6OFVwHJv7bPcRbR+qqWUoL4jZtBWHaziLSoRAx5cB7m
 UK6R830YRCWeHcpStLUDyDtN9EeE0pMwhvM8uox/Tp1MPJmWaD7y4x7GzjkssQeXfOVbvsM5+73
 dzxTSLVF1BM1ILw03TVj1/BRilCDxE2yQbrKKTdqvk2Ym1lF5w6AZar9ePuOY20/IjJOGIl5ZNl
 ++BokLdNuMqJk7vBEZA==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adf40bf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Y_fbMFyzX05j7FwaadAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: BOsgCZo1KBFlWy8NUUAHhgYDlJvFniYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260047

On 10/26/26 12:59 PM, Konrad Dybcio wrote:
> On 10/23/26 11:03 AM, Abhinav Parihar wrote:
>> Remove the compute-cb@9 nodes from sc8280xp device tree to
>> prevent clients from selecting a secure context bank for normal FastRPC
>> workloads.
>>
>> Secure use case support is not currently implemented upstream.
>>
>> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
>> ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Retracted - the doc says the secure cb is the one whose SID ends 
in 9 (and these should match the reg indices anyway so that needs
a separate fix)

Konrad
