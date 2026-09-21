Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51F45DF49
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983389; cv=none; b=Pc0/HizjASu8G1WXAiAukyT9cMI3NvziuLRUu3AkWKKZJYyX4iKjht13hVqow40kXKARn8JMu+5+WWt8jU2Np5FCJnYOGPRvqzlgFvR8bS3qwdBAzQAyZ0dg1ORRzDrVG9F5o9SDDrwETuM1aePzvjHwwpw/raGaLqOr53K1su4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983389; c=relaxed/simple;
	bh=GluV7HK5SQgSmRO4is6PpP6MTVEpkepOvyKtPfeMqwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pw/mlXBPq26HnYkl8xhYdZigGnfM6TTA6ZZLR6NAsEHH3n7ZP5OdOGHDol6TjDsJ9zKOjWFu9ntYkGGvtvciQyhbrNPMaVw7q1cVdrdRKZbRvQr6AwhtRWWNafqG4m4k1Ykan5NQzoDbe0KhbKK5GZbU+a+jrgjRO5M0Ws/cilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVqAQ9a2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ohzm9p5U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVqAQ9a2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ohzm9p5U"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7APBr371183
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MjWi0f5HBUqKoCamo39fIuPiQh9wgKyBlAdXtwkyekY=; b=SVqAQ9a2ywFk47E/
	fli1WmAaCtS7rb/0Not2n24hYbW6vR7IkuDvCAPCtASm/sL2e0OMz+dWSKqTUTX7
	dwoMVMgx/aD0x1ThGHzekE6tdIlBtT4lIgAJCb/HYfvcxK0j23tXqdrzsCeGhRJp
	yK31h+lu8LtRPUwk5BQc49iI2jQi75589EtK1NB+eq6ph5aVPapOOdQOJRHHbGK2
	+iCXiJ9MIqvFhqHinaj8mETeMbbsgS6DE32rED9H+28N5j3KecvTguRfnKSFir7+
	X3vOYR/lmJqBQ+bslra9rRu6otej98Z6dPwQGexOGS2wxjULHe7SAtj45Qi3m2h+
	HRIumg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5h52r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:36:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93821883e26so126740485a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789983386; x=1790588186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MjWi0f5HBUqKoCamo39fIuPiQh9wgKyBlAdXtwkyekY=;
        b=Ohzm9p5U8ja+Kxg68C+ku/fBEvqJW7JXfxCpVK0IWr0l4seIZ53flOSj5Col8AHk7t
         XaJNTc9nN9NF495M0W3SzJMPldAjkJFqpfGWiAjwZt9TCAPEEqyjKOljXECqIsF3alwk
         DmE92o7Q3ZMT/42GQnu1lWe26gV436sTMVhZl1PH6uyVT7saCuPjYQ3yvAVMchjQUCTC
         kb8vylS7YyTkLtU5TZBJxWK2Acy2ZRV4m5EIdU2MeXaCDm+DmsRqTR/BIwFYK20VdU2h
         wZfrBRSSPZTf5qc5Prvw/R+RcMykieRSpSex6npwgAat3TKICfy2fPtaFrq7eiV2AUEK
         8DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983386; x=1790588186;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MjWi0f5HBUqKoCamo39fIuPiQh9wgKyBlAdXtwkyekY=;
        b=Ph0RlkyTK6u8p9rMV00C+WOGgMLrvNiKUji1HERn4wsMd7bXvyzEwmAs4BUWtwRQ4u
         uF+SEb7mYPOrT0cq+8paGV9KsJJdTZTgYssJLyyMyAXC4eyhapLbIzUWZ2CGrPpAaLqr
         2ugF6zAfjShqe6jOyCLT2BLkgAc0EhilGjMvw2E/CSrvDSguv7Vw/xR1BkQqy0iA2swB
         nxxkig9Rb69FaGuhT6CG4NfsmwL31nVQ+++3i4kmCH7YDDVrb+iQGSu0OMn6+2A8qYuR
         SBokVS3lAhsL79+Cn2L0JYHsWywiiFGI6aa2vlZEtALx8mG0R6vZ0LT3nO1T/8GpdsbE
         Abcg==
X-Forwarded-Encrypted: i=1; AKwUvBx/ERo1N4EoqjBLQGIrALeg4+b9ZnLUSEXPzvnbg/MG1l/TFFKhs5I+5aSBY4m0WfnMXHuMdhI=@vger.kernel.org
X-Gm-Message-State: AFuF++l5KM/jnpTK1LxtFdK7aT8GKZEa9kBmtWocw2hQQ8Elbl6bttqX
	+jOZ6z4S44OcPjSg5p972IishGvXvBkyi1cW2S2VLnrx25iS+eWWXeUSaBF2K1DVANMK8YPc+nD
	Wzjjpk1RE67sRGZ4TJapr7O4ZvvM09Hnbbdq+78h+OIygrnAeiQ0RkdfD6co=
X-Gm-Gg: AYBFou0guA+Egi/GjWw8ta20SHrxoGuWjIggpo+snmDi0piMyQd+8vYSr7FYnFhb3GR
	wGuuNnSyu8mAcTp6ktsiWQK04ooomgE1pEJ9kyhgsZZPmyL5KWg2V5KrPNK+Hw0t2y32tdMLdou
	pxp9gVU7fsi37smXIKIx1nnKA9HpOZzMQmG/ss1q3rac98Digu/G1yEEdaWwcSQ78vexQvpWWPq
	2XIoldBSvuha3mbTA8dnsHXsEQrAeagKOgo5oekxPxADbGHJUTbT2vENT/YA6jeQzAX23/r+m4d
	bUXmPOjEOelL/G32L2UP+8BVsWNGpVqIDM5+PiEq8aoUCe3I69NdaEusKc/CluSUAIB3/FptYvj
	ODuxYPFoExx86Z4PCgCzWXg==
X-Received: by 2002:a05:620a:4592:b0:939:e9a3:3105 with SMTP id af79cd13be357-93bf58b5b11mr930987085a.6.1789983385865;
        Mon, 21 Sep 2026 02:36:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4592:b0:939:e9a3:3105 with SMTP id af79cd13be357-93bf58b5b11mr930985185a.6.1789983385494;
        Mon, 21 Sep 2026 02:36:25 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67c71c59sm3980947a12.1.2026.09.21.02.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:36:24 -0700 (PDT)
Message-ID: <848e13a2-e80c-42cf-845c-0c04a4547975@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:36:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0766/1376] arm64: dts: qcom: sc8180x: Fix the PCIe
 iommu-map entries
To: Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: patches@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <cc43fb43-b6cd-4d60-b077-5fdf7918cf8a@oracle.com>
 <daily-reply-20260916-0006-re-qcom-pcie-iommu-map@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <daily-reply-20260916-0006-re-qcom-pcie-iommu-map@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab0fa9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=FNc6Hk1cw1V3EZpLb8AA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 1BVWL9Al11C-xwG7ldIrup9-ajizDOgr
X-Proofpoint-ORIG-GUID: 1BVWL9Al11C-xwG7ldIrup9-ajizDOgr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfXzEB+J5RPPDGV
 KCY8/zHHsbdUWJbWhw/dCRr5XxRoPiRFxdf4qgWdthuuPauu7Tt9FdW2aSKHrrP9MQhor5j8S1g
 2ujcV+dmOEVhJoPOBkC5ZSf69/Bepks=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfXy4GSwfqimrSi
 E4XKIQCK77U7XwOEofzsc06j6WbK+AlGponL+69FU6qpXLmCvOai6ODg0xXx4gCJfMWaGWPaEjN
 /N/RH14yz1Xz0iSmxwR/gGhMdzmrEEN4gkK5d8eLKToaFHWycem7X78upExPbRaIhfzuj4/l0Gi
 9gaYFhdfkIHJM/4bb5WZFToHEeh25FoSHVZvlh8v7HAE9L88BD2YNMHsWHHpubyKlXfypBMyw6y
 VrSo80cLYvxl/gJ8lMfYKRQkCOiNgGEig02FhrXTamyOFA2+bQzbDQorm6xsO7JgMpR32igE3tk
 4hJVGcnNBr8Fo7TIfJcO874UlbLf3DwwZtfGefhISwt5jMZVjQrzzqbLQAN3ZJuttSPieVnon4z
 RMiYLRsfTBt4jCRbiyLRTuPRo8rCeAIw+5CBRjAbh4fOVzJX/CLdxvakHbOAoTIXGwrpRg+8QF9
 ++MnQ6atvQTrQZfJ/pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210136

On 9/16/26 9:27 PM, Sasha Levin wrote:
>> Upstream has the variable-cell parser and its API preparation series,
>> including ccb2fd725d411265df8f7ce12a66c226b16014e6. That broad series is
>> absent here.
> 
> Agreed, and Konrad asked for the whole family to come out of every tree that
> lacks ccb2fd725d41 ("of: Respect #{iommu,msi}-cells in maps").
> 
> Reverted across 6.18, 6.12, 6.6 and 6.1, 35 commits in total. 7.2 has the
> parser, so it keeps them. The msi-map siblings stay as they are.

I think the updated msi-maps parsing would be broken without that
commit too, no?

Konrad
