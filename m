Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D53E7166
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561068; cv=none; b=tDRghIqvDgwrmEHJikY3oy/obgx4TC7E4ffADQZF4vpUxJtRpuaqngAJmz/i1lbbwQmc0kKxS/3bPXJoXccJa0QQnjAGw3xTYc7ThjpSJLPas3mvuadJjBkpAUryXcam/OglLNiE60mmoLG8ppP+UkcH8u4X1BqUZjg9FTaUYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561068; c=relaxed/simple;
	bh=8LDC1fIZw0VxIOIyC0NqqLsIOXCsh1QsQbMQUEg97ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1HOrYBFf5b9Epo4fFVfoFa8hrZs63XOpArZCAwz656j2gkfDt7HItyd9q7SpZBn/OyEfSDKzXlyzKSKM/JduFab8//5GjhkrFvXBJZyjT7hr02uXl8ge8YilZMUWRgAYnLT5Nsv/uJq2fPIoXxtb9m3obl/hjB/cunk0aHSfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0rP1khS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Is08U2Gz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0rP1khS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Is08U2Gz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RFXs1008255
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRC9/nnQFMJjzCuQLMerdD5jbZ2DoD+xn4FWz1VE4JU=; b=U0rP1khSVvAPRnwE
	xK6VLxvFpoygXy72UCylJkNiHNsQFo8nymrX5leovkgjM7NCE82lca3/TdpIP4aE
	v7K027GBXgoLk0nYuzzL76XufILLmW1Fe2CaatawxuouTfWMlZya26qKqfwSyVBY
	1tDcTgyBtRQVJ3hr1B4mUcbp9yxG5nV6X2+zAZ0k7WcYkdVDbzgVQROnUjDjiTOF
	bGX4YmTH2LvQ+ipWenP/IGPQrAeOYAHPHOL+FUsyTVHm26u0GrnzltYhKv3Zu8oX
	/lckpaPy2YxSqYvKcsCIwSqKFMVAcbMcIV1bOrBkXZrtkRQ0l+kmcvN2hxjvx3eC
	lYzYZg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74xhe1q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:44:24 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-74ab6065f97so73722137.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787561063; x=1788165863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRC9/nnQFMJjzCuQLMerdD5jbZ2DoD+xn4FWz1VE4JU=;
        b=Is08U2GzVRuYm4Fdnx1PsFNBjICmeDTaR/LdVKe9mXnH20dchYTTjDhQMPA261WsLH
         wz/EkEejUrcFeKpQ6OtOdhaDaMcUnDUA1lmK8jCrat3v9gOGlNDNTL5hH96jlqC8H2BI
         Hc7OX2ejNezRsxKlL8CFTlqDpVEULT6Q1Sk72cTmjbEuIUP5otcYEtPJtCD6t9zfcFLX
         mjvHCYW58uTT7kD37myhPrbeN1zUO1CFIPwz6gRT5smeTo5Y9muRMImVT3rnEMRIB1rP
         6kN1oeIkMctVzlUh9bG9Et1/aGeGtBlmQ1u3/2Egd3UogcJaH7/FcLdD/ogpWGhbsyFW
         CHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561063; x=1788165863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GRC9/nnQFMJjzCuQLMerdD5jbZ2DoD+xn4FWz1VE4JU=;
        b=goOgee7bzqu6HUuUBDXPkle4E1VuSE6K/ZG93hy4opmIaTqhoVjmpxX8GIJK0c3lLO
         AOv6I8hO4Odz06ZmvfSnVznk8AEuZ0OAyXpGRTnsUIyZrxiN7ZmwVBxIpfAJ3vNmhfqN
         npdFALQ4UEIDmEfj2ez/SI+qb0a/vosx1aMsUkKc5qvhU2Zw6sQiACLrP4p2rb5gjKRH
         iCc2DDbBNQ6dNJsbyguvNoGoj0BrLS3M+UbSRNhLGZU2+W3JC9zNV/oOZx3AMWvqUAtB
         G3DntqJ+GfjtiXN9Ztb9nR1dzBrwDamzUcWJBi9bSqwWmiUid4lS9cnuZ5x+4WxlrGcP
         e6Wg==
X-Forwarded-Encrypted: i=1; AHgh+RpLrZTH9eEg7zZO11FVB9afJgrjhK7/LKKvEqN3v78W9oVT5BgCjeBpbNCGpivuNy0av2Wa/RU=@vger.kernel.org
X-Gm-Message-State: AFuF++n3Ji7i9FoH9OEYeV4bcc/cnsPBJC4Z6qY2/9BG5bSb27rhom5O
	C/6NZKZ2p/0RoV2MTW0s1odgKbHu05aWh/J93I0R1hKcCkmEEWdCV/hFwm9z4BJWV2O/mh5get+
	WHdW1W2AIWs9FzaXq6KC+/SS/w5S5AC3ZN2vkmF7A67XWBeYmWeeiWd4c76c=
X-Gm-Gg: AR+sD12kJLf+TaMDLz93+va72xcIgTqie1ecLIMh1+EplLKjk6WZvUYDPmNUw+bNWpu
	s/sY0RpPXPwDGpaLMkhkThbyUNykppP76+OCKWzY/MpAwQwSST5PYfdfWAhG/P68UxirqmEX2m2
	bssn3Xj3uRzxUbw6A9k5w7BpQ3HbEo7qPgPT3fLhVdZ768ADh5G8odXbU/P8i+RLFevbBJhP0xn
	E+U0WBkiTqnBFLFHDe1DjuFd8AztbDB6i1x8/zLzyl3CL4k09AbMu3EZQRqgznpt4rhBdMf3eCJ
	/M1h+jsvZq1VlaMUS226gS721PBiEyeCalClT6PUc1xx7F+QAWFyUsypoINII31VTJe/psZvuqs
	I/BIuPH9a519LWERXttNODJkz
X-Received: by 2002:a05:6102:6893:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-77a6433632emr3272588137.1.1787561063294;
        Mon, 24 Aug 2026 01:44:23 -0700 (PDT)
X-Received: by 2002:a05:6102:6893:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-77a6433632emr3272574137.1.1787561062820;
        Mon, 24 Aug 2026 01:44:22 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm7562369a12.9.2026.08.24.01.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:44:22 -0700 (PDT)
Message-ID: <06acd175-0078-43ce-ae58-567005f62562@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 10:44:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: qcom: nord: Split QUP1 SE2/SE3 into lane-pair
 functions
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260819152356.904023-1-shengchao.guo@oss.qualcomm.com>
 <000076bd-b3fd-42dc-bd43-96ee9492a638@oss.qualcomm.com>
 <aoZVKWTtdCQSSvaH@QCOM-aGQu4IUr3Y>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aoZVKWTtdCQSSvaH@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CJaMQr3-URiLP77llMTzRWhfBtbdtOhy
X-Authority-Analysis: v=2.4 cv=GdQnWwXL c=1 sm=1 tr=0 ts=6a8c0468 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=eCN_Hj2St81N8EpzqcMA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NiBTYWx0ZWRfXx03V9D61YiHs
 /Y6xLcaU/XQVtnYtiT8mV6XCE1DU5QdxN371lpifMnI7Vt2EKnxyZajNwgElt9Y4ZbRzWe68o5M
 rIRxNP1ZTiJ127h3vnVNHpoTaAQoYqjdyPTmhlR8Ap0Q7IguB2Pi++217OWcH7rSv3+7Sb6b71t
 hbSxzlOxz5hM0220+p5CfopdGhsJZvpG/XjcROsZ/clMc5VFzRU9bVWexmxEhEC/v5CXRlkoukd
 mVOuB1NLxrVtf5XDtv+3CcN0yn53gPq7D1CHmpMyi47P7RgbfbxbxgQPzFoQUYewNa+e3bWF2IL
 FsARR2QBjDkscreKGWMWFy4HyR3PQuiACbhM59itWJOVqdF+ik101tCqmWmanVqlqKuOTuwNn2b
 lLSrxIVHstbQokZTC/CDNZs6V2GMSdKwabMLkE3hUBaqPGmfH4ZBNgwIAI82DMxNc85djY+qJ1W
 Rm9n6z8oFjBk0lF1H0g==
X-Proofpoint-GUID: CJaMQr3-URiLP77llMTzRWhfBtbdtOhy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NiBTYWx0ZWRfX4wJrnOoOQafI
 A/xtJ+k+oxQK69bk7xmPAYhzpI0HmVHWhkY+NFQPAkk4GDDaXS/gR8SdyQGWvJTqmgUPmUNn1PJ
 PFhTrmEpq+BP06P/mDF3vLWtd49wS2E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240076

On 8/20/26 3:15 AM, Shawn Guo wrote:
> On Wed, Aug 19, 2026 at 05:27:34PM +0200, Konrad Dybcio wrote:
>> On 8/19/26 5:23 PM, Shawn Guo wrote:
>>> QUP1 SE2 and SE3 pack all four of their lanes pair-wise onto only two
>>> pins each: lanes 0/1 (I2C SDA/SCL) at mux value 2 and lanes 2/3 (UART
>>> TX/RX) at mux value 1, on gpio127/gpio128 and gpio129/gpio130
>>> respectively.
>>
>> [...]
>>
>>> +	msm_mux_qup1_se2_01,
>>
>> other drivers where this is necessary stick an 'l' before the
>> lane indices, e.g. se2_l2, let's keep this 
> 
> I can see that for single lane function. But for lane-pair function,
> it's not a new thing with nord, and the naming convention seems to be
> without 'l', based on what I see from shikra, eliza, hawi and maili
> drivers.

Hm, seems like that happened by oversight, but yeah let's stick to it
now.

>> The bindings change must be separate
> 
> I understand that's mandatory for new feature changes, but for such
> a bug fix where both binding and driver changes are closely coupled,
> it seems more reasonable to not split.

Up to brgl

Konrad
