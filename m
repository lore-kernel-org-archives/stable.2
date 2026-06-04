Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0E3D8915
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555151; cv=none; b=B9G/cLJ9spkBjxukC7yjFtilpCf2ngqAAx8rKdGHFWEKrU3btrUZ4xmo6bJX8aqlDSp+vcsL0X+qkIPsoocbthv8bc8Q+hNFAfSME1WmEYRiEfGCGvvvBv1sbrg7d1AYjxai8+HiAzRk+hcFouMWC7yRTFhk35Sd4mzPcmzVJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555151; c=relaxed/simple;
	bh=RaeoiWH7Uun9nxt2b6Nvp78PFkfwJ25ykblxc3Xp0J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNmL+JsI9bP9ImSOft9dH2C772RH1wup5jIz3gjNN8gzJIhL2ROtYHlY6s5VC6tYsBMwPMoobBEwAqdvS2iJAa2J2Cfp21t6WG4IvKvB0Wi5CQYW+qP2q0BEYJ6Po/Z6lY3uYPZ0oWYOZad1OF3+SDDrYsLXhqvqr9cR2oa0zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NdVTgoO2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GEuNBgVt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NdVTgoO2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GEuNBgVt"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6545PgOx994536
	for <stable@vger.kernel.org>; Thu, 4 Jun 2026 06:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vjgpy0mZThcuqyr29c0w8qcQHkkM1zFN58HHnPnYdxc=; b=NdVTgoO2lQY9HAMW
	bceRRxyiVHKXuuIpdj+fyBb/fnbGH7EvL5p+tnTo4lQHcZlTS54Ihr8vAUQ1+uRf
	8gadpLf/GyGxNspTt8KzGglUCBBigBC7go+asz3V1L6n/dP3WjDkqvvRBASbaCmr
	nHO2ycIC00kzwQiTz1BRxsi83g9hfOJxm4F9MjWXgRgXjnQ4S67Cj+LImSj6O0Pp
	Xf0Fcdf8DXS/+CAoVkp0L7abxxxX6/BQc4fE5maquWwqQwkdEWslKutDWsM3a95w
	WyCNiMd0i2jCInd4NdBex/55UpoIhBoIefAvtyREsNSjMauUpBvwi9PyYGE3ATMl
	Z5/mrw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek374r78h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 04 Jun 2026 06:39:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5175bb9d47fso8073611cf.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 23:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780555147; x=1781159947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vjgpy0mZThcuqyr29c0w8qcQHkkM1zFN58HHnPnYdxc=;
        b=GEuNBgVtA7wyV7QbfGBAWNjW/WLHcsp2GYgkIaXqokz3MNRGbsUpI+Gg1ZGhvvzmnU
         LwRlrL32nsdcybd8PNOHwUWWiP6IIrfUN9SMYZf7wfjPU/vVU1RDBq5lEcwYUmsrOIG9
         79LY+4PtM06Jh2Z2SBX/UStDSL8QGhWQwVfbeA7YNoZiVcJQ4ERp2DqGpmfB44MFWmA3
         17a95IqBtV8yHfz7mAzJm7QDNL/CaGpYdfaQgj+HYZkegySKkKrvOm0DGv5m2Or4NrgX
         Cxxd+LCdpjeis3mQjT5Esjl+drMu5x2eJsVFN+KzIjcW3iH1LhIhfbfgugXwo1NK+zbC
         wPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555147; x=1781159947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vjgpy0mZThcuqyr29c0w8qcQHkkM1zFN58HHnPnYdxc=;
        b=IPQvcNBuhWaUE4Iie9RRZBiAjYk3V6aV1UnMrfzSIBReDILnYT/LFBCkkhs9FYZjGV
         NJbuakz/Zm8c/tbXoOIE1pXEhV+za0jXxNhIAEd7/UwW0/uVGVIgRmxJR+P4HH+TmV2r
         rqtG6mM3csUNVKnbrh8T/Cr6kKHHfvb/gjaBNlSQn4ujtN+2wvGDzbpOoav20K2tQmI5
         os0Df+hiN4gFBOzxYDoVIZzKaweu6nWgsh3qgRfyyZxPU95sYt3lL66iS+0ya/sTtD0i
         j0UA7iffmMeWV2FkZO1GAoxUSlU7tRkzp7NHMwZHP7NeDexYyjQxf0Ds7jcnd0643Dow
         m99w==
X-Forwarded-Encrypted: i=1; AFNElJ8WwC2bmHr8ruStFQTClpYsxG1DQ5BPOWSHGjv0UamXvqqj8xjK/Ak4mL/CmPQXng0dicJOkBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtjlU6ZxDGNhwcycG5BYgmxfl0c62xjG/d+FhgP1Ly9dnvfa1
	62TCtXyOsF0IIKaAbH99u2TcbhkpnuIbYPe8g3WcPxzcvJqNcaUqBdxbLGCNv6G9UAAVNM2Ix5P
	dGV/NakVh5bJ3O9hNKa0XJWFLkQ5b8lvSwcwm/KkfaP+vGIn4jzp/g4iHXZg=
X-Gm-Gg: Acq92OG6ucIq2HvsG+uODU3nMeDyyVvLiLS1w+m0NeIetVnXNTG05g2Enp7SF5ZY4Vp
	rf/1o7qfwYb0VJSF3/pSro4G4+24GhnvsXqRDmujvlYBkcYOPejIgwSV/IVn3vK7+XhlApwCY2W
	0wSmtagVhmlWadbMElNOeJ1glktG5sgkCkTDxJbSE3kj0HWPj6mQr8hmdiud7F4aSfvtII4ft+4
	+9bWk37y+VxbrZyqTBPKVKDaHX1dPq5tmrZCmZbg3iakeHA2+wfOdP4p1xFY2+4LluI0im0Hs2F
	JXa4OwY2ptF9hwZfJoJbWrayzZbeeYbOJ8c3EPcz+uJCb8MBfISda3t8sj1EVJa8OiLsAyHCxJK
	e1SIREfPZn3tBlQYMXSukoy08A+P2JPqiKuac81eXHuqAJttPe2ga5xAHVUKxW1JmigE=
X-Received: by 2002:ac8:588a:0:b0:517:5afc:ff92 with SMTP id d75a77b69052e-51778748c75mr95741591cf.58.1780555147014;
        Wed, 03 Jun 2026 23:39:07 -0700 (PDT)
X-Received: by 2002:ac8:588a:0:b0:517:5afc:ff92 with SMTP id d75a77b69052e-51778748c75mr95741251cf.58.1780555146520;
        Wed, 03 Jun 2026 23:39:06 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.249.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1f97sm273228266b.60.2026.06.03.23.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 23:39:05 -0700 (PDT)
Message-ID: <cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 12:08:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Daniel J Blueman <daniel@quora.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bryan O'Donoghue <bod@kernel.org>
References: <20260601041336.9497-1-daniel@quora.org>
 <ecavEnqJTDXvfFykc9uJb5No7ioighpjrCdw2CFZ4c8Izr5DxpTs-606Bg7K0RtHTaOqksWivHxWQLzMBP6qow==@protonmail.internalid>
 <20260601041336.9497-2-daniel@quora.org>
 <ec7c564e-745a-4998-af9a-e9632fe063f7@kernel.org>
 <CAMVG2ssnyH=KUKrdfnUOtPYU7p17inyzcYWcKhT4EAZxDzDjfg@mail.gmail.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <CAMVG2ssnyH=KUKrdfnUOtPYU7p17inyzcYWcKhT4EAZxDzDjfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2MiBTYWx0ZWRfX/HXfpuIgmPR5
 KHuLkCAARaccXuMBV+xVymHcQ6C0UW7sK6DMTLLSwuYx/Sos/stjqpkzTA77kAtQfYtE7WV0bkg
 ZGSPEJkrscCE9pB50xtl9Q1iBOMyXLk0F//V7qApydUiFkj053y1ftobYu9RuEGcupCC7oSadfw
 5ScH/5q6wL75QxahKvfmBiIlASqW6CTKGALYs1st2QsJHPZy5sjqK6+ku0jVWvd3cgQlZ4momp9
 59b74kREgDc4QdAzLs+fjWJ5jwfNrAMwCTq0YHTGo1odeomYpnQ+cuXWKHegQwtYb01d7egppF0
 1D4OOd2nqI4CQZPfjSyiASMQ8bH/HLhBDMKu+2SF9orG787/XIQFWBjd+dOcqDhbUBNfA4P7ht/
 CFCGVr07ndn2jq7JpKyoHOUlUMljqZtZ6X9x0bdT4neLy+9PT4PzODV2r4dTB6mozaBslXzvXHK
 sqdkOLlyuJyOGE4Aj/w==
X-Proofpoint-GUID: k3wr2pHLwuCl7OfbxTJqQ_9hyUDNECJT
X-Proofpoint-ORIG-GUID: k3wr2pHLwuCl7OfbxTJqQ_9hyUDNECJT
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a211d8c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QLLTW4K7kuvKcNWOCmVsWg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=BHWUBWSSduhnyAuw9wkA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040062



On 6/2/2026 9:05 PM, Daniel J Blueman wrote:
> On Tue, 2 Jun 2026 at 18:27, Bryan O'Donoghue <bod@kernel.org> wrote:
>>
>> On 01/06/2026 05:13, Daniel J Blueman wrote:
>>> On X1-family hamoa platforms, Iris DMA below IOVA 0x25800000 (600MB)
>>> triggers unhandled SMMU page faults
>>
>> How do we know that is a correct address - does it come from qcom
>> documentation or trial and error ?
> 
> @Vikash, beyond your comment I linked in the patch [1] kindly cite a
> source for the different stream-ID <600MB behaviour, and share
> specifics, eg if silicon, firmware, or driver and constraint, defect
> or otherwise, so I can include a definitive description.
> 
> Also good to know if my workaround is good for long-term, or on the
> other hand handling streams <600MB is important/useful.
> 

Thanks Daniel for raising this patch. Did you also try the memory fix i 
mentioned in the bug [1] discussion ?

Coming to 600MB, this have been the VPU hardware restriction all the 
while since venus days, and since address could not go deeper all the 
way lower than 600MB, the issue never popped up earlier.

Consider the memory layout split as below (Iris device range is capped 
to 0xe0000000)

|-----600MB-----|-----(0xe0000000 - 600MB)-----|----IO reg--|

0-600MB range, VPU hardware would reserve this to generate different 
stream-IDs primarily for internal (non-pixel) buffers.

0-600 --> VPU would generate *secure* stream ID for non-pixel buffers
601 - 0xe0000000 --> VPU would generate non-secure stream ID for 
non-pixel buffers.

When many concurrent sessions were tried, non-pixel buffers were mapped 
into 0-600MB range, and VPU generated secure ID for those. Since those 
were not associated with the iommus configured for iris node, it led to 
USF (un-identified stream fault) and device would crash.

Keeping the region reserved, makes the non-pixel buffer always in the 
non secure range (601-..) and avoids the crash.

Downside of this design - It would eventually reserve 0-600MB un-map 
'able for all buffer types, like pixel as well which do not have any 
such restriction.

Forward looking design - create devices dynamically and set reserve 
regions for those specific device using the api [1], instead of applying 
one reserve for all.

[1] 
https://lore.kernel.org/all/20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com/ 


> Thanks,
>    Dan
> 
> [1] https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
> 
> --
> Daniel J Blueman

