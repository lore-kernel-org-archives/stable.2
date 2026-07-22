Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB967479871
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708900; cv=none; b=g/70eFEHPZy2SdhWLJXYHJMXpYHsAnU3z7IL3nBuoxRyKFVvnFo3ZeYwKJbRKzZjxaelu4yeuK9nE5RgejtYwmvBp+WJydw5ZqUmq03SKlbYj/Jq/WVecsW3O3qjZCkKxxl1tzUHi84qfvGMQN7uLvG/p7g3H4eT5vt9t8H1C/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708900; c=relaxed/simple;
	bh=TkK8+LPz3NLYgchZpLtTgVE409WX1AzhZy1O6ggVhyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urMqGC0kmK5YAOrIGud3G12LTYGODlzBoJR8IBQdd2vDynDwB7WlAU83NzY0pQnRLlFfJRkLg/0eBWiUMKgodeHN9AgAjEgRAR0vKBoKBWq6fVyPBzKuofqAqPynkleRCXphSzcGfXa+kzdAz9lESq/a33nLzZI2RzuOfpMZcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkhDpZ4t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KuFeEGAg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkhDpZ4t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KuFeEGAg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M7CGkn131675
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 08:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIsymjFuprG4so7Q98HuwxLOIzy0qsmeHV37HSxMH4Q=; b=TkhDpZ4tS7+g6FSu
	V7hA31jvtXYwG8KYuedqPWY2GzKy10BPTSi76qlCpspHrBvRIpDD6sZjr8tRdJyD
	5SgMYd+5tUtvFIDkcPUR89Kej60q2/cRRhTMCmLCdTGmXacX8Skz6H3KSqYwF02E
	KuQS5Tw5yjxdY3+IWY3rCoYvAyp+VLz4uO6svqk8oRV7umNEedPcP4tytvgAQ/D6
	2L7ulhngw4C6rA7P4W1zZzCJSAOhIa+TEDiJ/ZJ1zEQZoXZfCdMyndzNnV5CGCcy
	GjBKW7wLRhJIDe4XFZThZM03+utPhHYrJrUFW5giJBeoVJdGpBvbwVvGmPqzednG
	3SExMA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjs928abt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 08:28:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9309b0f05fcso114742085a.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784708882; x=1785313682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIsymjFuprG4so7Q98HuwxLOIzy0qsmeHV37HSxMH4Q=;
        b=KuFeEGAgvF+vZl5wdpo+I3s3KtYfiXzcl1ww7ofB4rGIEgf1f4lKntUwH8+Qodz/38
         iZ5+iwh6+7VbQ8XPb5uL/L7hDYXCFszuGXUP+UwYcxygBKByO9F+Tp3jWNuiR/FrnGSO
         EgGWaCUOA4NUqqjnbERY4WysIH1tNTvrb3DePTQtHBoyQN1D20jFU9RwRrjzgxMHeS8U
         /wk6z9pcd/oY0fR7jhHmM68Es5TWt1h5SBUthFkp99/bixn2+ng4Jc2LAUW3RmNuFPSY
         Rl+MprY+5WFtKYMvg5KEXjmh5wcClNCrvBNp/uoJBCwx4M7d0erpjZx85N97yHecmvtR
         Zg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708882; x=1785313682;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mIsymjFuprG4so7Q98HuwxLOIzy0qsmeHV37HSxMH4Q=;
        b=HcHo6cBnhEj87jl+/rwaP+hVN2uxqLBQjtUMljq35+ZGg8Ql6sckIqdsWb9H4V5rMB
         jeR2V3fQdPxU3VeF2mTCRE4YRO4DA3vD2t0a/Q3PXi7TlwWyGtd7i2bD7c4n3PJmV8+0
         RRGO6uRIR9Iacii2WAVrzKhs+ZJEcV7I5tEhTTEoMS0p+BgQlSq6r1zLshV4WMm06rxa
         kEua9GcxZzLWic1/hX7yx1YvOUdkuyxUs87+m//WTKGPSimRW0pEjd8bPh+4cvyD1czN
         7ayZ3JNHM6i2pmPlYY3aX4wbVoxT7frP3iLlvaz7iQBz29HZIY6Y1RlSMVmJaPQX6XnZ
         MokQ==
X-Forwarded-Encrypted: i=1; AHgh+RqliCYTK5Jxblr3/y4xDFh3EOPf4XcNExkC+95kKzgvdMfZT3dYuamPoHWfmXm9ACxuQTmlTH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxobmDh7bSXylCkDdxD2tyMojt0oQ3v68f32t+Ix1xGt8hhPPk
	1W5nmNfvuFyBMIi8XiI7Vo6RdAwk0MGGIcZRWIGfyKmz77/XAWld9/1PRp2UkvH7uouX14ahOuT
	4dZOwNJS0MVRpUK3osMy6+JgULPWybETSzJYW2W9GFUqA7RPWoDvrPlQDJdwSTAPJRcI=
X-Gm-Gg: AR+sD12DQCGe2iomBR7qLFYHvswwUNen5kFXsBGAO5tVtl3BctxtRQ4mcfAoM47FB4Y
	106Q5UeXxX9VHkaO26skDwVsF39LD/YfzQVlOw9kktUyg1RoB1Fv8mvotA3Msj6+QiSbppFQL4I
	cRzR0ipbKiyozwhljxA1i4bPESTjupSOp7IoqUJv2JyRl11uY3WH13V9qQAJRG2p5RIBdLNIMq/
	kxfK795dIur1iCzvcdLlEVHNxBoNzt46IX0qMxItVHssYmfbeOw99QEzy8xovC4S6VsSDhPBjry
	5YLZw5Meb9bvGYT7vsU/9iFg68O2XV3axHxr/581qoV0kcLN2t+wdcplZmCeuHNCvtddaymrMEF
	Shwj9wvTN4M4dynymy1vAlIjS
X-Received: by 2002:a05:620a:1709:b0:92e:705f:1626 with SMTP id af79cd13be357-930f458fd0emr196447585a.6.1784708882443;
        Wed, 22 Jul 2026 01:28:02 -0700 (PDT)
X-Received: by 2002:a05:620a:1709:b0:92e:705f:1626 with SMTP id af79cd13be357-930f458fd0emr196445785a.6.1784708882047;
        Wed, 22 Jul 2026 01:28:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34ba67f0sm621763a12.12.2026.07.22.01.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 01:28:00 -0700 (PDT)
Message-ID: <f54271f1-477e-433f-9839-e1111898088f@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 10:27:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
To: Sebastian Reichel <sre@kernel.org>,
        "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: jens.glathe@oldschoolsolutions.biz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <al6-IyyWYRnEW4VC@venus> <al-dJjzorP-I4Yff@gallifrey>
 <al_0LjwmfW-cECnY@venus>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <al_0LjwmfW-cECnY@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3OCBTYWx0ZWRfX112ro4fO6Oac
 bKnU+DRg1ssf3U/gSkf4e+j3RgL41+gA1cPCOvB7PgXQ8YZjFO4MhK17Dc/K8c85YKizWVYspWB
 pZvEDku6UZI6F4K/lGpJeUywgcuLNIw=
X-Proofpoint-ORIG-GUID: l-COyXtWqnnqGi8MHdNDdRBkxrTq3bbh
X-Proofpoint-GUID: l-COyXtWqnnqGi8MHdNDdRBkxrTq3bbh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3OCBTYWx0ZWRfX4jNnrSR9tTKI
 GZIveVtXrNu1pq62wNlkElLaxIf7BMwmWkltzVogILms/0yAT91IyqQAlB4Zj7+K2THQA3gQVvb
 xWC4i6153BWexGVrjcihDmao0xwpqRZ1kv1pMq/qm5dLbocImlFCYYC4qyAr+bB5ixegKT5AKum
 xa6g8TK5/lKjTj1CZQMzL9cUVSAAYBzwYfclGpizN9gjc/KzW+44We/wPvSYT44S3qM39aik6qS
 UpyHX7b0BI45M+LRwG/pg6AThosGdGalLDEoD0xece/l0UzsfL4XL1blS86GP0/qsJNwHd+WE5U
 UjT3zlG5QIzCvABQ0d5z6i3cwkGcGfx/4fwgQCEtKybfV7cdqpx8CiYGPMR1YVDCdiHtKmUdQEv
 WJlpA7TRqAOv2xSSTebB88+IFXpa72rNXQ12l+O3j/yfmv6g4be8Q5YPUAgO+8EVdAUO2JiOmnz
 IcPMr5a+C//X9JmdDJw==
X-Authority-Analysis: v=2.4 cv=QahWeMbv c=1 sm=1 tr=0 ts=6a607f13 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=B0dxQpQml5LPzYmAcjoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220078

On 7/22/26 1:34 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jul 21, 2026 at 04:24:06PM +0000, Dr. David Alan Gilbert wrote:
>> * Sebastian Reichel (sre@kernel.org) wrote:
>>> On Sat, Jul 18, 2026 at 07:06:28PM +0200, Jens Glathe via B4 Relay wrote:
>>>> On Qualcomm X1E80100 platforms (e.g. Lenovo ThinkPad T14s Gen 6)
>>>> using the Parade PS883x retimer, connecting USB4-capable docks such
>>>> as the Lenovo 40B0 via a regular Type-C cable (which forces the dock
>>>> into Type-C fallback mode) often results in working USB but no
>>>> DisplayPort output.

[...]

> AFAIK only Qcom and Apple M series support it. A quick search
> suggsts Apple used an Intel retimer in the past and a custom one
> nowadays. From the looks of it the x86 world cannot use this driver
> either and probably handles retimers transparently in ACPI, so it's
> effectively Qcom specific until other vendors start adding USB4
> support. The only thing announced potentially running into this
> would be the Nvidia RTX Spark, which first needs to be released,
> then find a bunch of people motivated to implement upstream support.
> Nothing with USB4 capabilities has been announced from Mediatek or
> Rockchip. So I wouldn't hold my breath for another user and still
> suggested adding the machine check instead of simply disabling USB4
> for everyone ;)

The PS883x is used on x86 machines too. Apart from I2C, it also
""speaks thunderbolt"" - the bus has a way for retimers to enumerate
and communicate with the routers (controllers) through a sideband
UART-like interface. But for that, it still probably needs the
platform firmware to program it into the right mode over I2C,
which Linux is unaware of (as it effectively should be).

FWIW, we do the same on X2. An MCU takes care of setting it up.

Konrad
