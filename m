Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB603ACA6A
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858469; cv=none; b=Gn/60Sca6mRvBT/oJFVCJ9Z4h/fQPqEM1AlH44XGTmuR7d1yMPsW76N5+dpsxg9t0w21F+EjEHWB3e55iMdHW0u46QiRfgBeafm4FEiCKhFu0DBxA52ZbXufaKcaoXIFwBsrKbcczqczuS3SO10jU6OJfeZLq8kn4xujMBi+XFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858469; c=relaxed/simple;
	bh=/InVEEvL2BDFOHfqag5PBcB5YAbkZtlMQjkqKfb3u/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWswAU0RGzlUKRGunypTJTXKZbAGUVoyc9laNG58Ob75r4esxp2j1TVPUYa084QcgmA+ctXhn+KqAXjEBrimWsj62wJffCgpfo6QOtolTAy8GbEsBNuula6vqMyL9pyY46fTCek+AZ/4lcVYE8nxFS/IQpJu44G+3/NJrEJNPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DD0kkFjt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O3GuHJiG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DD0kkFjt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O3GuHJiG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CAc5Eq2242984
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 12:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HfwZ/Ch0hmCLwy9ZofNn28jc
	v2cqQx6opUokqQoHzlQ=; b=DD0kkFjtoZArhuSik/sHzOWP+iDteAm1clFv6Ujj
	VtvFP6OGrPIEVz/pCMHrCQdeSwCIN1w8tNSjDYiQucU2Q8wvdxdinhU6rQVbNlP3
	Xq2YYTrrJOXmUJgTM7yQQYqRnucX9dN/m1ZqKrbZ2myX7aFZ6hJvHDyJFOTEyl+n
	JWiSyV20zzt+KqmSQnixiTNpEHCZH+DIVU8Z287m3jrfqqLPERygvcR1yPAI778o
	fc41bngUh/jQQ0y4Q/wzW3CzwfrOvzPbgHm8PqFP8DS2K1j/YxAscFFsJE7hFC8Y
	FqVZeLRthBxB238HvrWWbR643TDQNVh6Yw6Up9qZCiEMwQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekcjpg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 12:14:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e9489f62bfso39389856d6.2
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783858457; x=1784463257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HfwZ/Ch0hmCLwy9ZofNn28jcv2cqQx6opUokqQoHzlQ=;
        b=O3GuHJiG5E5olREM3CtRGf7+3oSdsx9TkTJS9bf1XETYxvfQf1lH6iPV14udj5LEFI
         WcivMN8ckAMMqECik6G95ZobEIErwiDcFF+hT5Lz5jPQPQsU0LC+8YfG+RDeSiycEs8D
         utv0bsSxW0ttdftGC3dQx22MGGGQ0+DGew06MG2Yd9GWopycbwskJRJCNKuybJwYr3c4
         yhE8UGoDzIgsrlg/nX7JOtxZ/Uopy+t8M0hnxQvT4jaJDwiu4DKu+TyuMnnDE6gvkIG+
         AbC/mqM7Oyf4A4bOvayRTFsCdLjceks7SFA8v1Oc0Smv6lCOk7/vGwZDB1yFV2H3r66u
         EHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783858457; x=1784463257;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfwZ/Ch0hmCLwy9ZofNn28jcv2cqQx6opUokqQoHzlQ=;
        b=n7BlA+oiTU/FeeNwp7mOeE+KNIaQNcBV+gwG5ZBCpb9otT9y71DMdBlE6j95cu2K/6
         WOnCY/XJlOAumCgDy0crgkJwoPX5koUmUEjtg70Eo0TDSXI3I9El3/wnGTlC5AYLpg9b
         j6Dg0Je14L0baurgjJfNebPCd83DuUJIbq42iaPIR+/hE1kG1RzMF8OiVAEkvTm6MsgF
         j8ffylu5vY7eqguYGrUkoDlUYXK8ROyqUODbFQLr7vEVG+Yshch5SA+d1pe+trw4jMIr
         WUQc9jCPIEuSVqqedxeSB5wgauLjNkNfNE6gOsva7miKLCyIFeVck+8QFGw/HC2WTBd3
         aGYw==
X-Forwarded-Encrypted: i=1; AHgh+RqCmLRhddDEybIb9kiteIrYpEp8Kp/XOptSNhuULcWtw4jc6kZyQy0qvAMpYlJjARiWlCO68wU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9y2ar5R+OcbvW57ZkGAvsxK+6qtGuFK5mrLEdfoMUJ6WSJcZ
	tJAZNkPr0awCtgmraJhO7ozWo8yGsbqf6SU5p8LzihXz/W6sxMYy/a8JrXm688uzaQoJlxIoly2
	QaonB7wSM/N5i9YWN9NlZPty9+rk65tNzqkIsm1ayXA20YHyLRUDECHurSe0=
X-Gm-Gg: AfdE7cnk16lp6VQ9RNS0nbTnja+MSukJrKLD6TtkkN6uetnoBMQUfBLz/WfQSBmsqvd
	VZElB4xxSLVh7dc8YoyQfB5dF/1mGFPtK82jEA8DbBC8WAG3MN2gqtIEOb0xcOv7eq4NIAdaSyp
	DwBkrb6WZR/lg6108xlxjDL3e9QhAD4V+zrBOkBP9NZs0l4i4IrMyIkHvZ0I6IlOpB1H58hekfQ
	3HxntI5ESSwcu6qxzRLBWb5XpyE48STVs7ePhq5empYFxqUdV+bmvWY4BO6dFOMp9umjWGpcZq4
	WKIXhIL4LUnJ+Ug2FyhN2932cod4/qFYZhhPGj0MK0a4WJ6gVT9sXYklF2wTKkaFw2qjmlSe47x
	vGH/XK00QgxNfOnNVYuCQD1aDYqJmr8JklhS4zOpGL8HBE5jt1zWxxLSI2o+wYzf8mKQke4Mr/8
	Q6Pg7ZhguGORjuAgiUyKGj21Cz
X-Received: by 2002:a05:6214:468a:b0:8f0:a2c5:9d59 with SMTP id 6a1803df08f44-90402369c1fmr71343866d6.21.1783858457533;
        Sun, 12 Jul 2026 05:14:17 -0700 (PDT)
X-Received: by 2002:a05:6214:468a:b0:8f0:a2c5:9d59 with SMTP id 6a1803df08f44-90402369c1fmr71343576d6.21.1783858457034;
        Sun, 12 Jul 2026 05:14:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4f901sm2091705e87.23.2026.07.12.05.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:14:15 -0700 (PDT)
Date: Sun, 12 Jul 2026 15:14:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Val Packett <val@packett.cool>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bryan O'Donoghue <bod@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
Message-ID: <zaigjwjpldnsrzsfbyolnlvblteav5esfstoib4m3eusc67a26@jotedakvvo7m>
References: <20260601041336.9497-1-daniel@quora.org>
 <ecavEnqJTDXvfFykc9uJb5No7ioighpjrCdw2CFZ4c8Izr5DxpTs-606Bg7K0RtHTaOqksWivHxWQLzMBP6qow==@protonmail.internalid>
 <20260601041336.9497-2-daniel@quora.org>
 <ec7c564e-745a-4998-af9a-e9632fe063f7@kernel.org>
 <CAMVG2ssnyH=KUKrdfnUOtPYU7p17inyzcYWcKhT4EAZxDzDjfg@mail.gmail.com>
 <cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com>
 <ff3748ef-cf75-42b3-850c-b8742a814920@packett.cool>
 <519CAAC5BE344EB7+e6d7f90a-e481-468c-a987-dac3c69d7362@radxa.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519CAAC5BE344EB7+e6d7f90a-e481-468c-a987-dac3c69d7362@radxa.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyNyBTYWx0ZWRfX6A9BiZvW8Ocu
 NMUe5lW2ab0bHIjjop6HeDnMMn8be+XjLj3yqLR99pjtExiGjkD5mVF9/BU+dL5EjVX9iHrF/ka
 vIy55/imfY8k6MWoexrRf5cWTXMhkzCECr5R5fikdGBmqcGsari+VWV+G28WWVjZYjjvsjfrdrA
 LGppqa9pcjZu3RfZQxu066cU5AHGsGftEybakBGy49za8QP46RUJcQuYalCWI5dcGu9DmffZrJJ
 KI8d6uw4kT3XMonM4hOyi4ZO6a3WC7halVnDrWi2s9ug2wIAEVZepamIHf0NW089dVuzb54nqyE
 +FGj7lUapdEkVguMhRgvfiQ5bIZIIq1pKauc+6vS6WqhIQIPhtZQw1m3Nwix6ROYGgVpadvpPf7
 kI2Hzc+uaDxDYv5huptbJsbV7fwIbFmIYX5mk0k66rxg5sQRig1YaUQ/wJZ9v7IDOR1cS0AYD52
 VFQzraTKMqp90WLJp/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyNyBTYWx0ZWRfX8ENP0qE1Jl5k
 1ebI++rE0tx50Q8S1YcxaERWhDNaImVffdkCJ9+MjoxcKR7fNJCdSZaPYuAJRCjyg7VLefnYOev
 ua3hNRa9AOp/gt4/bBbDCYwjZ0yb3eM=
X-Proofpoint-GUID: HZKrxxOLhpY_GoTxAsXot058l_g-G-9B
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a53851a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=nl5WK0wFAAAA:20 a=VwQbUJbxAAAA:8 a=pLiI7BJ3y60Ur7kopoMA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: HZKrxxOLhpY_GoTxAsXot058l_g-G-9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120127

On Mon, Jun 08, 2026 at 12:17:57PM +0800, Xilin Wu wrote:
> On 6/8/2026 11:48 AM, Val Packett wrote:
> > 
> > On 6/4/26 3:38 AM, Vikash Garodia wrote:
> > > 
> > > 
> > > On 6/2/2026 9:05 PM, Daniel J Blueman wrote:
> > > > On Tue, 2 Jun 2026 at 18:27, Bryan O'Donoghue <bod@kernel.org> wrote:
> > > > > 
> > > > > On 01/06/2026 05:13, Daniel J Blueman wrote:
> > > > > > On X1-family hamoa platforms, Iris DMA below IOVA 0x25800000 (600MB)
> > > > > > triggers unhandled SMMU page faults
> > > > > 
> > > > > How do we know that is a correct address - does it come from qcom
> > > > > documentation or trial and error ?
> > > > 
> > > > @Vikash, beyond your comment I linked in the patch [1] kindly cite a
> > > > source for the different stream-ID <600MB behaviour, and share
> > > > specifics, eg if silicon, firmware, or driver and constraint, defect
> > > > or otherwise, so I can include a definitive description.
> > > > 
> > > > Also good to know if my workaround is good for long-term, or on the
> > > > other hand handling streams <600MB is important/useful.
> > > > 
> > > 
> > > Thanks Daniel for raising this patch. Did you also try the memory
> > > fix i mentioned in the bug [1] discussion ?
> > > 
> > > Coming to 600MB, this have been the VPU hardware restriction all the
> > > while since venus days, and since address could not go deeper all
> > > the way lower than 600MB, the issue never popped up earlier.
> > > 
> > > Consider the memory layout split as below (Iris device range is
> > > capped to 0xe0000000)
> > > 
> > > |-----600MB-----|-----(0xe0000000 - 600MB)-----|----IO reg--|
> > > 
> > > 0-600MB range, VPU hardware would reserve this to generate different
> > > stream-IDs primarily for internal (non-pixel) buffers.
> > > 
> > > 0-600 --> VPU would generate *secure* stream ID for non-pixel buffers
> > > 601 - 0xe0000000 --> VPU would generate non-secure stream ID for
> > > non- pixel buffers.
> > > 
> > > When many concurrent sessions were tried, non-pixel buffers were
> > > mapped into 0-600MB range, and VPU generated secure ID for those.
> > > Since those were not associated with the iommus configured for iris
> > > node, it led to USF (un-identified stream fault) and device would
> > > crash.
> > 
> > Umm.. is anything *actually* preventing us from adding the "secure" SID
> > to the iommu node?
> > 
> > I just saw a patch for sc8280xp that did just add an "extra" SID for iris:
> > 
> > https://github.com/strongtz/linux-radxa-qcom/commit/
> > e92850f792498c3a72d72d667503a29bf6bb0a31
> > 
> > and I'm wondering if that's about the same exact issue.. (Adding sophon@
> > to Cc: here)
> > 
> 
> I'm not sure if we're having the same issue. Without adding that SID on
> sc8280xp (HFI Gen2 FW), it fails to decode anything and crashes instantly.
> From the trustzone log inside the crashdump, I can see that the buffer isn't
> actually in the 0-600MB range.

Hmm. The decoding is working on Lenovo X13s ([1]). It says 6.18, but it
was the Iris driver patched to support SM8350 / SC8280XP, which I posted
some time ago. For the reference, the firmware reports the version to
be: video-firmware.1.1-b158087140355883dc40b004032856a8feb5d565.

[1] https://github.com/lumag/fluster-tests/blob/trunk/iris-sc8280xp.md

-- 
With best wishes
Dmitry
