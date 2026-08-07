Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9132481A85
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107944; cv=none; b=Cbjazx/+DTMGXXk29TWtDndRty8DZL9zMmXj09DEVDbptAMeWJHx6D5oVai/lF/6ZJL0A0XJp/eFClghHeK/cqDAEzLKNJDEIQDnZhC7Tiv/LXn2monbL9QQJu+dtRN7AQJbksQ724quZesS7z9e3O7HUP37gzyJG5wQzTpgg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107944; c=relaxed/simple;
	bh=HYxymFoJm6RTuaDqJ7cRBG+V1mDHMjPSgSeI7t5ZWK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0VwOkcNxJdU8UevGaUT31Ul5xx03vN44BgCyOxstjDNFEVDb18Vory7ZDa1Eqf/bQ0PN3tO+/vMXcOjIgXACr99Oay8pswP+AI6xFDBTB6lxSF1sv1DDvx3a4a9UrZoaNoN2p6+0hxk7yJueRWhqvS5ej5kce2OcqxnBcaJzsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gv9eNFme; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gzNc3zst; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gv9eNFme";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gzNc3zst"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgcQg1004540
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 13:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPSj/US9YmoirR4APoqZkFkgfkruTVQ3Bn0PlYTwpLo=; b=Gv9eNFme9NRtsz64
	WtQXMjIWbpJKt2IURqnywaVa1kqIKm8HVzxpy9TIH3+XxGH2rb9gYjT4onAqPnTh
	BkYxZrKZXJG7aLH7w8qhyyYki3/4kGRnjiVfgdZo2AwEKdazFKGKT9PIbc96zMGL
	uYet+/wowckoYnQluPWFzeCnXCduzT//yRMTczEBeaejfSg9PkzXxOq23c0Haxcr
	u1Dz9FJTFtX/I7eoJn25l8CFNKgfU59I7PyLjRys92HxhB9sqD1ecAZCkozaIxOG
	OnKGAuXsVwAdz4UILFnGaV0nntXBVQ15MEkl+E/AJXagzfN855hwmrYGih3+RnSX
	adpABQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6fv42h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 13:05:30 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c110ad1b2fso568674e0c.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786107929; x=1786712729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPSj/US9YmoirR4APoqZkFkgfkruTVQ3Bn0PlYTwpLo=;
        b=gzNc3zstz+vE6hgheZny7F/f55fcqggkyW/aIjhmtCEIStj5h+nQgwSvzK7+eLoCUv
         ZQd1k8gI0vplzlss/5mqhzfx6gC6mR+y9thawd548kAEbOZHOK668p1gjbixPe7yjlKL
         mpsyDjrakOeFF6cs5riw6sVztMi13Omy9MlkJdObKY39Y/gsIgbAB0/cMo9pwjBBnvDD
         A1sMhBhcULEsCkCPHOgKXbQiqpu8HPQnYKpg4a3Y8XSb4p59OvrOXqxdvMhjZhA9zcWu
         KJMyiLkWJjQdsh8MCFrh06nlhFAlGGe0/vakb5lV7V3AXbCCitM75MgkKSKToyfguzrv
         +aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786107929; x=1786712729;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPSj/US9YmoirR4APoqZkFkgfkruTVQ3Bn0PlYTwpLo=;
        b=CDG14KzszixhCVluwGZ33L/UyJaMgJ74m6xxfJU0A3eDgCub6gcDE7YAAWzhuRlmkO
         Co0xoDgvfUwVel/+6Qsmghmo0as/arzO68ZbIjytH+1xis0dJYhJVbdj4zwDOdQmxnjm
         QbtEAykWDkAmZXzKLrqhVxIIkQB6M6oE/xJRlD0buX+3Z4b2G64g0fN4XIJc17mpiAf+
         AEcBQzIInuheksAx13yQ7VrdiRKZwq/PxO9BrmwIK6ISzWEdXz2hf2fQ6wxsTV4bk5sc
         FPd5NZ2JXl+8gifhXioejw6cnldwKLDwXvdabQxQoPozVod9KmO9wE3JwfTjgxhFEMf/
         qIHQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro07MF5AF0cxDAEzFSiVDkztIFpjv/p/R2Hm9I28HAEdcvy3Z1wpeWzLhyrzG34ivQIVM/w7qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRitLoTKbn0YMeSktwH92hi8Pgj/j9CzjmRYvTlTYOkLrI8987
	gG9m/AwuHrVfnMTT1q8Lqlq8gVZxC9ZB2SBu3yJ1NiGorVthAv6fSRDqVu3rAUPSERzyWDWnsz9
	57WO/T1ot3UReNVFJNeKI7sM5lnue/Zap1YHvJk5ivfLyG4+H2Vp4xYba+fU=
X-Gm-Gg: AR+sD12Rx1/0PQ20zUlDmsh8zSOqN7FB288lMA7Iv679u233Mzm9RsGQtABXusmLmp+
	GndoXTVmCIfUALJNMoTwpdmT1+rRHhsbRmp2y9QYejOvxpj+aBIY3fPJgj5wG9UhmGBY6ITau23
	S2pNDoC7ZLELV/0WTH0x+w6rOZveBUjTzOh8zlDh0ZAN9vg0p4dk250vlwbqpmoAf3tsU37LgCe
	S2qOC19/C4Z3fVsnK6Jk4qDI0hML4MFet55Sg7VzrJaZEB+b3qCWDzCrqudInToA5AnBKXX2OBZ
	QXD4zPpvk2LVV6d5rJSfnWiwi8ukrDXWtd7ossG4Q2LGWNIaACQ4ntkIEpW7lBloZGOJxuex/OB
	CWhKzg2Iy5MUkpI3aAuLV0/298lbXaTSRPYxzgjUei6TtQQ==
X-Received: by 2002:a05:6122:6609:b0:5a0:370:f12c with SMTP id 71dfb90a1353d-5c409440bf1mr405011e0c.11.1786107929346;
        Fri, 07 Aug 2026 06:05:29 -0700 (PDT)
X-Received: by 2002:a05:6122:6609:b0:5a0:370:f12c with SMTP id 71dfb90a1353d-5c409440bf1mr404933e0c.11.1786107928770;
        Fri, 07 Aug 2026 06:05:28 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145971sm5546657f8f.8.2026.08.07.06.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:05:27 -0700 (PDT)
Message-ID: <d490d92c-01eb-4cc1-8b03-fe39ca087412@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 15:05:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/qoriq: Disable clock on resume failure
To: Can Peng <pengcan@kylinos.cn>, rafael@kernel.org,
        daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260722075625.452684-1-pengcan@kylinos.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260722075625.452684-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMiBTYWx0ZWRfX6G7i9rnphH7M
 VibWkMMNlJ81LcNCQjgKfcoSzL3F8a5WEefmW0ZEi3wJ/yyAthGfLINBCynDP4qn6xAQzjX6vKc
 I/I7hLi5pv+fF5bc/Ol993+CqEN5D87utSaDiSVFbOC227LvCJXjJ1SYQm23tKaI71B1WVAmtKL
 jGHR0RONKAGDWo41FS2uuuVVPxIY2gvyP6S8pbQRg2z5wG1AadtV3DzUwlW2TX2u4ISXoAwk1a3
 6O7uvODsJsI4b9qvyl8yk5uezF2saLv6qwJvP2/rnlbq/T2BpRIc0AR9rw8+vBX1j0nbphxeEVl
 ugIO4EpsELBjHqz/KAnoXcPSYtlzyA9eZjQutLXgcA16ethTM9dg36AGTFr3ngnqAGaikYgX1vv
 aZMS8NE4TDhttSrUTv2ms/WJ+3dQMf2GbETkfc30nG1cKOE1TPavpIraBCvxeWMXGTLgxwocDpv
 /LGNwgA/CbHiV36ukVQ==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a75d81a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=DKkMA6O2ID4Q9JsdpvQA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: JmspF_0xb5Rrb6By592IIp0EnnJzHiu_
X-Proofpoint-GUID: JmspF_0xb5Rrb6By592IIp0EnnJzHiu_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMiBTYWx0ZWRfXxAMGRPePl07F
 O5prFw4UQCCqT7ecv0ESWzZwjbg6NAxUvR3nUUbjXvuJ+U+35YWX8kHR5m1d5+zGK5Qc6Z0IUJm
 dA31YIsMQg3wW3A6YcEjJZSyC8+XVxA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070102

On 7/22/26 09:56, Can Peng wrote:
> qoriq_tmu_resume() enables the TMU clock before clearing the
> power-down bit and enabling monitoring.
> 
> If either register update fails, the function returns with the clock
> still enabled. This leaves the clock enable count unbalanced after a
> failed resume.
> 
> Disable the clock on those failure paths before returning the error.
> 
> Fixes: 51904045d4aa ("thermal: qoriq: Add clock operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---

Applied, thanks
