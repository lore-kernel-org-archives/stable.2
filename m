Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5E3EF0C2
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543293; cv=none; b=UP57+O2sAuyM0vFaAhbZ31ncBfSGgVmjPYDExoZraTqc0adbAJU0zHOvQ0PVsU/wgnJ1ODuB3YB3uBgx+xGYSODSSX2WkYRCxsSu4UYhm2KH3Bb7uVu0xS83pIMZXPD4vMRSCDI9B3G7wXwBFjStE08xkyYu2czaIcUtMSbkwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543293; c=relaxed/simple;
	bh=3dCWnOJrLyNJEihuCtBFmI1B0PCLOw2IdTVUvMwqT7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uV+MzKwiSnCwC8EReGSdZENOhqrXgpz8ks0tViz/Ewvj0aBk6EVqvM8pdjmsidzMKsHjlOvKF9BCIrHWkRqiEjNDyib7dokBPqS3K1+AANvHL8478+YiXYgqLbTd+x3ejuQcZgwZMCNRffwkYUwSZP//aNTxclEiPZPYA0pA0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bc71RvME; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLoYFuAl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bc71RvME";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLoYFuAl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDc5JX3875922
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dt1GET3R6/6Z+iOREfRu34e0pr+BS7qqETIu0IxNuuI=; b=Bc71RvMEFu9tdn8A
	pqqezGXdcWyj7+3GckVytsb8YtDaJEhiUkstVJqQCJVN7dPsPwM5ybEo3vu7ZCNd
	jUtdHlMsW9g2jBAF9d9V6RKC9dZ93BZbMo9Dm7S6kQmkAwXaJ80BuH1jqCkHDh3T
	Jv4OFOTb67xijHDw5Up3DBOVTvpKy23rKyfdRGLiJiYcsXkgK9B+m47w7ulbJm84
	emDfi4zg3kxTAybv4cw4bewoUcUSnuxpSKkCBzF1mbAYjQ7QayYyC+GnuB8ArIOD
	v4kLUKaoHJU6J+eqzaE5rq1k867sMgkVucZd5FMUhmNwGvnY2UYDta+OahCN9gzs
	RNk4rQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1j66h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:01:25 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e7624e584dso1364882a34.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786543285; x=1787148085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dt1GET3R6/6Z+iOREfRu34e0pr+BS7qqETIu0IxNuuI=;
        b=cLoYFuAl2ZWnbJvKW0oEdjbmmmexLj3d68jxT5tUmGfLcywuO0sj5hPrU8F3sL2QLx
         5LTKh/3qHUkK1WP4i9gDSvWargECd2JzGow3+FgvKS0nGdqcci/UMzg5Q6Pu/Y281bTS
         OVj96qpFGComPPv7G0/8scHfM2pnQtpFGvsQ9dA0Rkd+PnrjVeKQxbnGHOg2LH/oD9j/
         KzE4HmnqqONMvQHfS38iVQ6EzYsKMWebKA91NzvuYAZsALtYNSqaAjMNFRcJ/Cit0lqB
         o6taEJYgLnnrq+z+gBllUt7fkJWz2kEFTUL45TROn6I+f674Sl0/xLLEuZEboCZjfIk2
         Q2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543285; x=1787148085;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dt1GET3R6/6Z+iOREfRu34e0pr+BS7qqETIu0IxNuuI=;
        b=Y/ksPf0xFh3vcSIwOcskKjUWHj0GAaXHj9GDlqgjJuwEw2bDy4MDk9KZl61t0Buatu
         B9NvbzCVPa6hrLKB6zQPK0AjoJv3eDI1F5wk/Hp/c98tAhDrYs+qx6vX1CD+y3CkhPRS
         Zpcl1qXZfLLMAcuWyzern4D4+e3HCelebdUB4cHyYwnKlSpHDZ4Ika1Vwl4AERQs8KpA
         K4C/cshff3aEwBW8Eh3Fi3GXBto/utxFoJ5UKuLHLA9U6fLXyQ5SepN1QDyGAlz58vix
         byX4xfrZDPYo9NZGmGU4MZGiTyV0GxJuv9XT7zMIK7anmIw2PPyX/9kJq5krux5onkug
         P4ow==
X-Forwarded-Encrypted: i=1; AHgh+RrYnJcrxNoPR73h7uS645vugxxJn6tSDUceycz8Wzowav5KEaCboueudrTfztEJse6FezsQbU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0L79NLH9NVlb04G7K4QVBcHaJTwschVXO51tbStDu0ScnLY8
	XJX+yqhwhBfZHs4UjYcsupz5GKWtU1vVBuqBNtOUXcRal8lnugiLkI5o4zKB3hFxUjPiYSfwqwT
	VSZF1ZVluY/xReyu5G3ISoe8gLjUHAzta5fXjqdXSSEJufh/tU2tnfa63MMk=
X-Gm-Gg: AR+sD12eOpqvdTHcrbhtTHYbaSlPEHq/at6iEGUNsPOHH4p9KlV6BvkAOKDRiYCtinh
	qA6XOfIrNhE6aLvrBg1bxA4F0dbLUfub2fGd2apPHTB5V8sTw+Bli/OiSOAqBslusWAsaG3K8wM
	WcoI3OMnL8ZQgbTX5vL9cGvadUNuf9wTzh+G3Zm5SRth22wW3F45I7iDtZtXn0YeNa88TXasZ84
	a88Qg8BCOmRywSlgPXHarkaektRQ6+yRijVR7Zr1tyUAM8ndpA+I3Uex7FIt8xzC3c+zByE9jVJ
	dN20l5nyFj0yIQUg72PEKa+Ld4C3bXEsHm2Hu05rT3dpMtsfXL4WNT4qK2cluqbdzNXaco3wfuk
	R+yIL4FHK/vNbaXSjXbe+zny4Vn1B
X-Received: by 2002:a05:6830:2a8e:b0:7e9:cd7a:7c34 with SMTP id 46e09a7af769-7f3b798b150mr5219241a34.10.1786543283246;
        Wed, 12 Aug 2026 07:01:23 -0700 (PDT)
X-Received: by 2002:a05:6830:2a8e:b0:7e9:cd7a:7c34 with SMTP id 46e09a7af769-7f3b798b150mr5219146a34.10.1786543282715;
        Wed, 12 Aug 2026 07:01:22 -0700 (PDT)
Received: from [10.92.216.212] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3209120sm3282682a34.7.2026.08.12.07.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 07:01:22 -0700 (PDT)
Message-ID: <c8324e0d-3688-44ab-b775-82402a7f9c33@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 19:31:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0139/1276] arm64: dts: qcom: sc7180: Add power-domain
 and iface clk for ice node
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
To: Sasha Levin <sashal@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, vegard.nossum@oracle.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, stable@vger.kernel.org
References: <20260721152446.065700225@linuxfoundation.org>
 <20260721152449.211750681@linuxfoundation.org>
 <a0273f34-8596-4b6c-a489-66a4533b6dd1@oracle.com>
 <ab3c3006-bfa0-417b-86f7-95470c73e547@oss.qualcomm.com>
 <20260801101505-6a6d5089afcf@kernel.org>
 <1c1c926d-e0a9-40f7-963b-94677d29ebb3@oss.qualcomm.com>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <1c1c926d-e0a9-40f7-963b-94677d29ebb3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GTrPP55cIeEaogUDp0nFOL3x5SZsC8Db
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfX6cMRP+On9q39
 S7v2WYMrOz0I7iyME3kFBxuDjULlVYZZSsZHsAcFegomKdoanMKZnZV7I0AlsiLKbTcufcqqmUd
 6kmR7iwrILUFa3NREcd+Fl8MY0u3V/Uy7YTKUx7HgKQE8kygSUzMrE/UOfWuTsOSmEjJ22BJ6DL
 bYlFy19Z+YDZUT/+Yrv2oj6whJtlnH9trsR1BVW6VuYMn8Ac94X3kXcCulI0G98p+KS6dc8K4Tq
 tP4onbtfnvilsoXs8kdadouGb1OkrO7QjQt36kUINbqtnrKhSbKP62T6p/Pfe9otXBb5qQdPuVw
 2R74aJeYbQjLmUkO8ub3xIfupE6zkSfES5uoCf0UWe1TFwkbGzUvmaOd7bYZT5hFUwtR+HFbtMz
 DMruGJpg4rN6zNQeX56l1Lbd8l6jghGG8xwMHaerkDvBBv+fq5IrAFugsiMVAcfW6jHMIRzg/GN
 gzTSWD3YKkYfCeInwdg==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c7cb5 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yCuQjaVjHFs82LyP-Q8A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: GTrPP55cIeEaogUDp0nFOL3x5SZsC8Db
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfXy9FmaIB8iE5w
 KvIHuSbJFxPfVHlnQNZ9i+FEQ2vxhAZjSmt8BzB5S9eNzzRZoGlPK2Ay4iq9EjkL1otAxlQaKBX
 Zw+NoKOJKKtnKjsBQ9j8tokSYyV4Y9o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120114

Hi all,

On 02-08-2026 11:40 am, Harshal Dev wrote:
> Hi Sasha, Harshit
> 
> On 01-08-2026 07:50 pm, Sasha Levin wrote:
>> On Fri, Jul 31, 2026 at 12:51:25PM +0530, Harshal Dev wrote:
>>> The 1st can be taken on-top of the four DTS, since describing the clocks
>>> first but enabling them later via the commit is totally fine.
>>
>> Thanks for confirming - and no worries about the delay, enjoy the
>> vacation.
>>
>> 0d5dc5818191 ("soc: qcom: ice: Allow explicit votes on 'iface' clock for ICE")
>> stays queued for 6.12 on that basis. It closes the gap the four DTS commits
>> already shipped in v6.12.97 opened up, and I confirmed it's harmless on the
>> 6.12 nodes that were never converted (sm8550, sa8775p):
>> devm_clk_get_optional_enabled(dev, "iface") just resolves to NULL there, same
>> as mainline.
>>
>>> The 2nd one should be taken to make the DTS patches comply with an updated
>>> binding. [...] However, the patch must be adapted to 6.12 to not make the
>>> power-domain and clock-names mandatory for Eliza and Milos since those
>>> targets arrived in 7.1 kernel. Only the first portion of the patch is
>>> applicable for 6.12.
>>
>> Agreed, and that matches what I see: the allOf/if-then block in e27264daac7d
>> keys on qcom,eliza-inline-crypto-engine and qcom,milos-inline-crypto-engine,
>> and neither compatible exists in the 6.12 binding's enum, so it can't go in
>> verbatim.
>>
>> We don't hand-split upstream commits in the stable queue, though, so
>> could you send the adapted version yourself once you're back? Please
>> post it to stable@vger.kernel.org targeting both 6.12 and 6.18 - 6.18
>> shipped the driver change already and has the same binding gap.
> 
> Sure, I will send an adapted version after validating the binding with it.
> I will be back in office next week and will be able to provide the patch.
>

As promised, adapted patches have been sent to stabe@vger.kernel.org:
https://lore.kernel.org/stable/20260812-adapt-ice-binding-for-6-12-v1-1-ba4374b81a3e@oss.qualcomm.com/
https://lore.kernel.org/stable/20260812-adapt-ice-binding-for-6-18-v1-1-e224dcf77072@oss.qualcomm.com/

Regards,
Harshal 
> Regards,
> Harshal
> 
>>
>> Thanks!
>>
> 

