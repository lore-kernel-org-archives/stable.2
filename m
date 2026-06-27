Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8323AD51F;
	Sat, 27 Jun 2026 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782562812; cv=none; b=e2FDiZ27oS4RpEprqEftde0cOZnilzPRp9CeL9n33THZfCZZysLLZewvK3z2uv0Qct24WOh3pm0KG4YxNI+raCGD7bZGMCMHeZYH7vfz6iVwyX61d+kJ9W0H6XOm5RIEdpquKhTo0PbdcHjQE5BxDoZ7hk2YAbl+4M231zcPSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782562812; c=relaxed/simple;
	bh=t8dpMT17hkzMMN+PsIDonumo4SS2Hi0jPaf3p9pBhvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBgRuJBeBU6X8o9YAHdzmIqQGeHbhuZ2emgU4tFAjtx41NRMnqAboMxBMpAaAIOT4+3RLYx/53N7dPQ+zcgCq1zk8+bBERyJk57yw6YXEpUfSlMbR7NTNdbZjibs02BAQ3+eAeNi/6B9JrVleVt2MbeRWiWFwE2gHOzkj0AE5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpsz4t1782562789t7a7c9406
X-QQ-Originating-IP: MMcO3H5Updz/13KjiVzaiYci4ttABBAs/FU7yjHTTeM=
Received: from [127.0.0.1] ( [119.98.234.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 20:19:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16511041071073179787
Message-ID: <B5AFFA6368F94E1A+32e72222-ece6-42bf-8191-518165c1ae0d@radxa.com>
Date: Sat, 27 Jun 2026 20:19:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fix DWC3 core register size
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260626-sc8280xp-fix-dwc3-reg-size-v1-1-ddcba897b19d@radxa.com>
 <f07dce35-f807-48bd-a04d-76d69ae74f37@oss.qualcomm.com>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <f07dce35-f807-48bd-a04d-76d69ae74f37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OW3qjH3bC/TAM0qq7Xz5O0C3MwjGIodO9xyC32ek8j/8rfjvTnxSiL4F
	vJE9emgdAkTMUQLrXbBZFAFG0W90iI7ZuW+qFEZsQPShjtmpVnOEKqE6/rNLWnRBw7Scvv8
	PP3SYf8Xj5ZgLTt4KgVZBjxHvEKp0LQzumepgeKnsZ1OpD3wOQx7U/WLItHjESgGAAJn0H6
	XhQFXK/AHRktSF8dAMe8MKZ9+KjHIxnZWswTY6BQBTMdyLwee01/7MU3vrWmqsLoNMW18mb
	raSqK9VtZEnrvq6BCvdjK1JO4yP60vKElJ15Kg7aR8JdeLBVvnUGRpre0dLzgg6+C0H+bLN
	1coqPBiM2zxdHjd28Z7sgCN2Gc//97XNNO0Q4vAbxHENNv25+qAMz0TDn5oHZC5sRBUszL4
	QYJXceAaeFSoVNHsbeN0FyCmiOP24WxonMCq1NyPg84aZV3zuM4uwAHKrzFeesUE15XgrD9
	8JJGlvH5bKgfQ6/Lr2YMqnMxYk4whHvDO3+rbLhJd7vtuUdgY81rvZy0gQOfK/fV+lG2mXX
	6P+BCq8XtJqVbzePhiSS0Efmmshmk0gEj2sBK6sT33FwxjSZE5JAEgu2wQXyCshK1Oc1a0Q
	rrACn+B+KgDUYNLpOoEVp4RqKvYpkojV3v+3SmUkhV2bI5vyPTVZyMHS89r4ZKa4mXE3mlB
	vHUVY5RcFSLj8m7dz6RKm7SChmU7zWZRS7ArC3k9rn/3Yl6V0ubW6uAvNWzdSu4lyhbhVCm
	JKDMEbcvAprWMedf7+PpgtWiWRa8AiteB+4OJvogFMxvhXfGFgF+xKIvox/jlHhXLHa7zAl
	tWEqrGdiM+REpWWO8JZWB8Eud3w7MRGAHw7n2nVO3VMlA1eXAqmmhqMABpSxwXe4bWKphPs
	jyHkuDnylty48q4CibYvU077hJLcXQjR6XTaK4DC9XfS+X75qg4Hvsce8RCl7O0/KFP1krG
	PVXvcP6gGzGe6L0nTCTMGbqIiK42KpJdXzJPVgoKaIQbA8QTBDa9+D/p9aYzlz1bUc9CO1M
	ltHEq9F8DpFssiZl/oTJPh+TUscId82eqsizSSFFW7eTkkQQ3/xIF1QfW+Gn4=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On 6/26/2026 11:21 PM, Konrad Dybcio wrote:
> On 6/26/26 5:07 PM, Xilin Wu wrote:
>> The SC8280XP DWC3 core register regions are currently described as 0xcd00
>> bytes, but the hardware register block extends further. In particular, the
>> DWC_usb31 LLUCTL registers start at 0xd024 and are accessed by the DWC3
>> driver when a controller is limited to SuperSpeed using
>> maximum-speed = "super-speed".
>>
>> With the shorter resource, probing such a controller can fault when the
>> driver programs LLUCTL.FORCE_GEN1. Use the correct 0xd950-byte register
>> size for all SC8280XP DWC3 core instances.
>>
>> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
>> Fixes: 3170a2c906c6 ("arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Xilin Wu <sophon@radxa.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index a2bd6b10e475..d06f79b7680c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -4034,7 +4034,7 @@ usb_2: usb@a4f8800 {
>>   
>>   			usb_2_dwc3: usb@a400000 {
>>   				compatible = "snps,dwc3";
>> -				reg = <0 0x0a400000 0 0xcd00>;
>> +				reg = <0 0x0a400000 0 0xd950>;
> 
> Let's do 0xfc100, the QC glue driver already does out-of-bounds
> accesses into the base+0xfxxx space..
> 
> Konrad
> 

sc8280xp dwc3 doesn't use the flattened binding. Using 0xfc100 would 
make it overlap with the parent glue resource.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>
