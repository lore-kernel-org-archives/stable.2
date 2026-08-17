Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B7429027
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976946; cv=none; b=Ot0e2NUjAzdbSJDfd7rz8LL/y48tvGX8mbcJatUkL9M2fjo7RPCRP5E913biNZ2fVPu1P8XfIoUEL+0pr5d8oZkvaUHix+RnbIQoCFXnx+Xy2X/pD1TtkPqtT4PMw5pV8lTdS1AW/mzq8Cx0sSqh/LKde0gLrRz3gM0x7zaj22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976946; c=relaxed/simple;
	bh=UiTjHfYjpPtQv17SamOYFpLTKfUsC0/r713ZtcvvPBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBg0KY4KwUp9uT7g4garsqfznQaFF6WvDWSKFB5oQJnUDL1yjGwtGJ98fv5ahrp8z32/aLAATv7DkXMpxVOvlwuATvtCOgbR7PRa+uqeuZaMTtrfVfKF/B9XJqxl1CJ55RYnO/Ahd7caS6ZJNAc+Y/v0ais8T51PiLzfrev3nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OAtRnz90; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bm/gQf0j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OAtRnz90";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bm/gQf0j"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD6BS81193607
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PmRFHo2gTVo8kNvX8VrtEOpA3zAcJQk9MWz/79eUlwQ=; b=OAtRnz90yH/3NuRA
	HXvzEGVIS1T1ClFC/1wxOPD6ThrZjd6dqH+3OMsivUW0pQqinzbvqqMdoQaOUgWd
	v4x60tkCMNNJhDvb+X6HdBWN1+rCjw8F8T7fvIM73/2twwXVP1G9CHwgSWnavTIj
	o7kaPCn1L+Ed9pittAZ/qBhSdO6LjawsdvM/mVjefCMIHoJwgLvuXLzDYqpHM100
	0M8bAuWhnI5eZ3HV/3dJ8w2wsEJxv/m038LXdbWBXJh1Qn/poeBKeaYG/O3pVW9t
	ceAg08N2s/dvmCVz+CeVixzH8UqjJoSnFikPjRxf9KApM6a07HHUD12lPuy2kOg8
	bdtw+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wke1pys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:29:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936cf9b6f32so19857085a.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786976942; x=1787581742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmRFHo2gTVo8kNvX8VrtEOpA3zAcJQk9MWz/79eUlwQ=;
        b=bm/gQf0jRETtEjv1HBjerLxYca8Xs25zaBR790JKd+IiTUVPLn4mfwHIK0ri1TH3uS
         /MELNIwEXgH8Y5mzA+E+U4mzUTBKfTxL6LZM6CTMECPpi9pFtUg/9ilF3t0uOoeSJLi1
         BR4HYmHrNXVnJdOMExUEWQpjwOP6kUjHf9uUceA1CU+hnbCpL+MQKAOV//vU/DDNpVUd
         ct+Z3ooJqC4MaXeEtKwFEtjlx+rFJObS8vFpu2GNUjnQmGzn5397Rt96/qAWh2gWtNpN
         sWhrtD8vg93bNeTcLffJrxOjG9YXm656a2yWKW5d458Gx6WdJRp77CB+q28vqwSSh15M
         1lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976942; x=1787581742;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmRFHo2gTVo8kNvX8VrtEOpA3zAcJQk9MWz/79eUlwQ=;
        b=emuFuV6ozartGN9Lwd2p0Qe0mBdUzqHt1L1jlQ+qQMTpkUO4K1czE0pCuPeV5nHf0x
         Wsp2xDdewXq5MIj81ZXJS7k8iFUP3rSTvjNznh+KKNjOm96Ad0m9VdaAEtdfwqo9sAmD
         mkbi9zXb4Y+FMEaQ1IxYdmfUbYmKIflRMiydTDcY6G90+Att2aboLgPJmb15JwdUZfZF
         TS1AkNNb/YgYqnzcqZUa962CWtUI1srchMhQPwwDwEXGU54LWBBEEBTcvQeo/ZT5+CLB
         HBlRShGgva9aCxNQ/lsBh97JdvIZPhq9SPix47vcgwIqfjoJxyVoCr3jLirVV2oCarGw
         RWrw==
X-Forwarded-Encrypted: i=1; AHgh+RqEvV6E0YKl1RVOYEDvrc+WhBRWUxtH9dgPVTlU8fBeqt64DLRDQMH1NjbTl2fK/0nkoPecU5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmA0ALF/n/RcYcqY/dJmU4Uy25pAIE475A0diKuB0yzCEm+Iqk
	f+CfxdCobb4ayMZTJDG37u3m78PRrije4IVykz/ev5pmQC6kVMepLCbUhfYC174n057Qf7dEb0w
	/hjJHBnK2/lepi/spL8tUHtZKBtkhG3opTVGDDgIjAXVMIkXzgQ0G45qTLHJOl0UDdGA=
X-Gm-Gg: AR+sD11udacmbD6dhrnhmxFLV+tPljY/ZnZQRE80n3W3AJw7reUHVz45x4kbFWpfCu6
	+DfhJmNbaUtPUsG5MXSeNNjZ8SVHa+zxknCueR2+uc8l26Px/lHzlsShZNivBqtsYZaWlPGPmZX
	iPkXU6BQG0uFiW8IKmMDW/MVZiU55KFMFqpjtt0/MHCtofGlWjGW4yHtYAblCT9eZ8iaSN83RRF
	hbOhVs15IVKrS+tYQ7gS6Ly2bVmG3x77Y27WHN7QdBqAUIZ+nFmO5KfFaaE2ulIM97c0qI/ce3P
	aNW124ook8M79soAUQceqY25Aw0z1OHQEXDxTJfwt+5KynIT+5ZmPWxMpe25dKFi1IjC8vRgDMH
	BWMbhxNo9rQxv6rJnVIlbK7Nc
X-Received: by 2002:a05:620a:4725:b0:934:95d9:85fe with SMTP id af79cd13be357-936d2382755mr1936462085a.3.1786976942677;
        Mon, 17 Aug 2026 07:29:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:934:95d9:85fe with SMTP id af79cd13be357-936d2382755mr1936458085a.3.1786976942327;
        Mon, 17 Aug 2026 07:29:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8530d3bsm829709a12.10.2026.08.17.07.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 07:29:01 -0700 (PDT)
Message-ID: <bb0be682-c3a4-4669-89af-94a9c2653177@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:28:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] power: supply: qcom_smbx: include base when petting
 watchdog
To: robin@snyders.xyz, Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        stable@vger.kernel.org
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
 <20260812-qcom-smbx-fixes-v1-1-eb48246be599@snyders.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-1-eb48246be599@snyders.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfX4fZWRnlMzRV7
 ax3bDqPbCsAyU+9QUKfmiQ07eg5ZdlQGTM3lanVzKCs2vy/WWvHgpydDMUHqYsP7HJVfiJA6d7X
 cZlSpGPLxJYOfdyrS4rgO36XCXkKistB7j+6NZzZKY2P032YOcmf6jmp6U1c9hZe9fFmKwYkGlA
 zstRBbjX6eHh69KhVsj3MyvTu+6OYWeEX6YZfl+5BwM5pnqfHdO/EgLXnXKZQwyhoZDPQhqInhT
 HzP+8Im6gU1PG537v1ATdtVXGdOzxtkUblhh2iGSt6v1NAe1ePB5OAO3OaZPw1d8AxmZn1bQ/vj
 dG79+aCBMNYdY/CcxYo6vfVb4e+HJkn3FuppNbOhw5XBllDa+5n10+WzK1/lIHi6HbTAPanmPn/
 xuCILxfMhVc3YGCSe1NhSQm2PY42YytdD0vgRo4bAhmKk3SFqz3Xs+6Qg6UM5TudpoHYuE+etXN
 NFEeBakjiYvp/UA/65A==
X-Authority-Analysis: v=2.4 cv=QetWeMbv c=1 sm=1 tr=0 ts=6a831aaf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=OsHF4jKAAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4rSUyN2hDD0KhXNsd_QA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=aAwnOj5LE8VeXseigifb:22
X-Proofpoint-ORIG-GUID: aY-jJJKxLToz7-keKZ2slsKm311N3TM4
X-Proofpoint-GUID: aY-jJJKxLToz7-keKZ2slsKm311N3TM4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfXwI5cdZ6xU/Q2
 lcMSZcz+evvm+TYGyf8MV2Wq6zClD2afAzC4ISCGiyvWq11TDwjhw6PaYflII6KrqZj5Q4ROnAa
 c6K7lnFzX/rBRcKIH10GP6EI7YkbXRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170111

On 8/12/26 1:29 AM, Robin Snyders via B4 Relay wrote:
> From: Robin Snyders <robin@snyders.xyz>
> 
> BARK_BITE_WDOG_PET is an offset from the charger peripheral base, but
> the watchdog bark handler writes it as an absolute SPMI address. This can
> write another PMIC peripheral and leave the charger watchdog unserviced.
> 
> Add the charger base, as all other qcom_smbx register accesses do.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
