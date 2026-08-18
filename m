Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9830418A5A
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040031; cv=none; b=h92CXhHWmsFKts1PDfQw119icwTULTMoqapNFgeWj1jnUJJdmg8rYxhIkxUegAwiZg+s1A7YQs8SJiPMUDBCCzE0NP8v3xfr7ve7/jZrb1NgnUfiaE66BKYrXnNwYJxfRjFy74aUm0QJHP3dQ1KStKR6Ixeat6CU2dTJp6RyAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040031; c=relaxed/simple;
	bh=VVzeC9aSS7EbC4BDJCc55WZs27Oj2r6qa77M5GVXJ+s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OK7hKGjBrrYCoz8njtwieJfs3cUSNPx7P/BBqXeG2uPWyJOm5SJuFcOQQeT6R5aRCBdyN5PmKPj3AJAXugtLRLUids14EE53DFkAr2g7307ImH0tCN1dC3jNl+hty2Z7gxm1h/sSaIBu5MSsD8Qhp5vT3bn0J0JZcbsRujNjZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dAdQYCC4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F1J7ctmG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAdQYCC4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F1J7ctmG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I7jSFV185736
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jqXg/ZeJLcmznmPK72iIjNUSnrPmed0SSB5eff7oArE=; b=dAdQYCC4BGtD8Fij
	v8GEMlCGDqa+hmF/yht37SCxoV3BwJ4JKllbVUiyPXecQf2XyaS+3Doc2BecfLIi
	WrD2ynukMZsy1+h2Oz4Y2qcZZlH5uNw8tiCi1tjg0YQw7VenY/61o+Qaj47vQvlo
	YQloesozKDWfqs41/GxsbPlVkZYVDuNFdXy0Qp+ehwwBhdklWG4sDfYjiuzoq1Hs
	9kqwL7UFAOuAnE+UXXGtoINACCrEP5fMwK/sqo65erOsAhOo1xrunfTInrPIN3CG
	/8aLTcsVwccx6oi2O8ln6UeNyEs5HrW2eNaGXmeSqOr+Bx0oTL6NM3K3hxOf5npe
	svpDZg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2hdn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:00:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee1ec30f2so53282175ad.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787040028; x=1787644828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jqXg/ZeJLcmznmPK72iIjNUSnrPmed0SSB5eff7oArE=;
        b=F1J7ctmGQGDvilUuRvMD6qsYCrNU8XamrKwIXYRrMegovKFI5Lxlv05/SjkA6Q9Fpm
         5MPX9x4AS1oMIOT7h3w/kj1kw0xp8SJeeP6exFsHHpMiu6pSEUmz+AuBXCqNQT7uoe7J
         FqAHmlIKMrxPUXtsrnqsDbA/6VRoXjDx7xaZNXhlB8UeTagmb8ALqblRdK6tmLhOqX/k
         ayc4jJZQqlrDkgnWhUag6t3nF9JxJR/tF4PwXZm9VTfjWKhXdkgnQHcxrFKugltFTp1Z
         Pf3anEFbFcm3vT9C/ebh2Rumd8zBnbDq2Bycli+9RqrRleEUVOpjK/Su9KXC+7thJsGm
         LsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787040028; x=1787644828;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jqXg/ZeJLcmznmPK72iIjNUSnrPmed0SSB5eff7oArE=;
        b=jo2CScTHZ29MWfwH05wSbO8hH1KafQ0PHQAmUgm99GbE8CWv1FA4FMWba6cjlkfwqS
         6yPyTVlIiCjCrQuWw+Et3d17+dVRtqQAHNh0TINYdw4DDItqbfWi5pN8o96ySQSLcyb8
         dwGR2nmBgsNfEmfqyea4K7rfroS61PvDBr/kl1SMhhf9ejDC8uLUEwHD82BNipjC4bpC
         mrS6Imzlwb3wXMgEMYcVomfRaPbDCRHPiKxaVaEur6x6OOlkeFhBro6q8gl+wqOHelUe
         2tILHQtQKJ9cb141UydkK6m5h0mTB00ezDq/5xrawx6wDoyKJH6caMTQCekECZ+UZ3qe
         ta6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpTfJ8P5M7EbIdlBAp3RYbojRdqVLqlYtMEig89HgJXd3IsRYdrm+8Z/+LABeqjx2wDc1NDqoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dDMWcseR1Foy8fwh7qExWfF8RgbwQD4Cw5E9tOtGiDrE/LUx
	D6s82VsUjqkzG1vDeOZwUcsNkJu20caIP/5MyE2qZwqZGzpd74yO5jeXdAIEFYBA7QUrHxH2Nlo
	P6llw9I9KAN/Chx5XJo8eoG65OD2ywn9z7lQo7Urx8+Unp0iUiPG9S5ocudI=
X-Gm-Gg: AR+sD12DecK/j7lmpFwtU3xvbAr7K99MKSiHZrvaKasZn/6/PDjfw9k+98qPicwegoC
	SDuxgeR73D7wgVpAsK1QINaxuLeI6nB+e8IQhBuSdVJGJsxcCjVAx+WmgJWSrdqJNUcI6IQlrO7
	UvlSraMceX2uMyzXL6fpaU59EATWBevpwyXLaw75gJvjEnuYqe/nicA1XmNsqTOP3mU2qU6Yo/+
	blczb08vFUY3yeIZPz+h15LECCGc8Ud40V2Qpelm/5O4PnGgfuzO+ILu12SgZ03lbeZ0DzQfJtZ
	HIfIkLcipPuPU1fy/7dGfHN672hYhrL8DRTe4WzRiUmye7xdanGbRRjWRibEPLRE7oJQMEoOzkI
	6bNovPw3yDllZxIGzHlHJ32mNdghcH2eSuCk=
X-Received: by 2002:a17:902:f70a:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2d3b0ad2b9dmr376240925ad.4.1787040028312;
        Tue, 18 Aug 2026 01:00:28 -0700 (PDT)
X-Received: by 2002:a17:902:f70a:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2d3b0ad2b9dmr376238925ad.4.1787040027720;
        Tue, 18 Aug 2026 01:00:27 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.138.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267ca93692sm12687431eec.30.2026.08.18.01.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 01:00:27 -0700 (PDT)
Message-ID: <c339cbff-490e-42fe-a461-042fdd6bfea6@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 13:30:11 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek
 <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <20260807162405.GA896590-robh@kernel.org>
 <c3hVumMy_QnRbUmbFTSWGjkfG7lPjGFEcZfPsZeGQ57nWKkhlBL3wgmcDcAgT9cNb8Ju3qZ_sSKgHk8vmow0xQ==@protonmail.internalid>
 <6ee7f32e-eb6c-e264-6f0d-541555f8fd62@oss.qualcomm.com>
 <56b3dfcf-b1ad-4192-8199-06c80cc5d124@kernel.org>
 <Gm8h4cjoxHsgA2enLuxEd_3c_3Nq_RVJ9PkosuciOEss5Bw-GbnVoJCzsc5ciseK-L6bnlf9dbkbbh4ui3PSOQ==@protonmail.internalid>
 <CAL_JsqLGOz7Fh=AsM+g84=Uko10YXU4QN1buApD3CJMkOmsebA@mail.gmail.com>
 <e5e2d588-cee0-4105-b34e-34d2718786ee@kernel.org>
 <xbzl4s37jr3uzsd23kvphiguxmq4ngkajju4ifg76kwqrs4xrg@2egp56nwrxgu>
 <0bccfd31-dbbd-4bc7-9d9d-be048ef22b04@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0bccfd31-dbbd-4bc7-9d9d-be048ef22b04@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1OCBTYWx0ZWRfX5auW20r02X75
 eCoibU892ON9/2Ml6jAVK/eYSLgWI0FUMbbhfEzwYSreVSDTkD/igO27KRp0fUa5yley7ES8dgK
 /M9OJmdeIFz8UrumIULJ7o63QWAr8VrCDp9n8ASC2WfuuQaldkuW2KY7iM9UTZQXaBo2GEXQQol
 JXBYHDZXxYbs4iVratQTcpLqoF/QxsdZC6qnj3UYBfwHkq/h2CChhKJ56Q1Up5lRaekLEFgsof0
 ANMMHhHiS0oFVhULz7AcXCZuPEb3g+KsEPLEpHsz7AxC+0gf42PmW2OEYRlRisP3T+cNUdbwV5N
 2Gui91QtDGT9FQWvqMCsI//Fb25qsJ/7J2yb/ikGN++x89g58DxWSl+H40CIcsLJ61VqnhEzrOZ
 SJ+JJrBnP3/bqdc0Ef2JQTuisS1k3RGqqWvPWlzaIsVlCgBOA2cW1fKn3zkjVPMnuSC0ct8lSPz
 t6xY7AyELlaD/XMU4pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1OCBTYWx0ZWRfX1itxcnV+xF5+
 0BcD8dq4JWSPSjVCj2gj3456atN+yA+dYtBBZTzlUI2KyDTY//5XvWID+AMn5bkg6IvJ6pS3PSQ
 xk8knHADmJ6vwbjv/HGQswmsiJDuQ1M=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a84111d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nRfyoPPwyR/Y6OrExC/i1g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=YG64nluAAAAA:20 a=sXFCB3fPxomcnR8swvoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: Y_8ZuczqSotzniZGlKOKTcszlusFAsLf
X-Proofpoint-GUID: Y_8ZuczqSotzniZGlKOKTcszlusFAsLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180058


On 8/18/2026 1:21 PM, Vikash Garodia wrote:
> 
> On 8/18/2026 11:53 AM, Dmitry Baryshkov wrote:
>> On Mon, Aug 17, 2026 at 10:54:47AM +0100, Bryan O'Donoghue wrote:
>>> On 10/08/2026 14:47, Rob Herring wrote:
>>>>>> As per the reserved-memory.yaml schema document, the iommu-addresses
>>>>>> property for IOVA reservation into /reserved-memory is allowed — it's
>>>>>> documented for IOVA carveout reservations:
>>>>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/
>>>>>> schemas/reserved-memory/reserved-memory.yaml#L56
>>>>> I think that is an entirely reasonable reading of the text
>>>>>
>>>>> Quote:
>>>>>
>>>>> "If no "reg" property is specified, the "iommu-addresses" property
>>>>>     defines carveout regions in the IOVA space for the given 
>>>>> device. This
>>>>>     can be useful if a certain memory region should not be mapped 
>>>>> through
>>>>>     the IOMMU."
>>>>>
>>>>> Which is exactly what this series does. Excludes a specific IOVA range
>>>>> from being allocated for this device.
>>>> But if "iommu-addresses" is the only property of the reserved memory,
>>>> why put this property in reserved-memory rather than directly in the
>>>> device's node? I'm only questioning where is the right place to
>>>> describe a reserved IOVA.
>>>>
>>>> Rob
>>>
>>> Back from the eclipse, sorry for the delayed response.
>>>
>>> Ah I get you.
>>>
>>> Yes.
>>>
>>> I take your point. This is a property of the node itself; the IOVA < 
>>> 600MB
>>> only matters _if_ the venus or iris nodes are enabled - otherwise an 
>>> IOVA <
>>> 600MB is perfectly fine.
>>>
>>> So it follows its a property specific to this node not specific to the
>>> overall system.
>>>
>>> Yep, I agree - its a device/node property, not a top-level property.
>>
>> :-)
>>
>> FWIW, I think it's a proper way to describe it too.
>>
> 
>  From my readings, a node defined under reserved-memory can have other 
> properties like "reg" alongwith "iommu-addresses". Are we saying when 
> *only* "iommu-addresses" is there, then move to the device and when 
> other property is there, then move to individual device ?

sorry, typo. Pls read the last few words as ".., then keep under 
reserve-memory ?"

> 
> Again the device may have the "reg" property already, in such case, 
> moving the iommu-addresses + reg in corresponding device might not be 
> feasible.
> 
> Regards,
> Vikash

