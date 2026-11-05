Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867394;
	b=r44DfSI3tiS6CX9OftXx5lSXkeq1am5ll56UqUA19uEdHZDbPrDKyXItNcJZT6qjM3pZ
	 C1yZezjHjE71Y8d3ajMYgNErP/ZE5EVziGxQHdDKnbCWIewvgrPBPVKCX/zpQZcYMlzjm
	 +pj6pnajmJFxGK0+Mg7ToGOu6zqsLrC+5UiCrI2ZclRmvXuCe4aLcP6yV6JKI00HovqNz
	 hrq8fkkzCODqdrTkK/WlAB1R76FgjIDJhQwm5JWC3WsSTf9JSmRJEXOvDDBdR1+n6Ufpw
	 7q6WUNi5OamGhJKY8QslRyFH/Nzun4vWAkRPwpQfeLgj1jpx1YXIxzSE8u28Aj2URhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867394;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FMGEReJTj+oAHaCArndjVTrwh1iXUa0fwaYYB4jT5wI=;
	b=uA7vYMCSmxtr4L0m6Vl3ntrCc7mJUHtkB+lPzdRos7aVS8wv/4AJ1ZmZqIcOjxrvRvNq
	 L5Agd+dpfCogsURIFaAu2REvXNZWfVcTF1YdV2YVK82zthG8hdGHjO7K9Mhy+YqwOTTlY
	 dnLK7Nfu974VKa7KPMmusmEl5HMydPY6d0eA8wF6JqE5x+jiiAZ9+yPOJzXsr9h1+gIYE
	 hn85DlipjXyaPJOZcGv2DpeTUHJyEpiqWA/nJngJBzztHqXF+gYBdh4/JTSqD3/m0dZmV
	 4G8p5nZy8PbzSDUprOgoHAInYOcpp1X7vE7BpMn29BPoSHsHqtOZB0f1u/lfFdHMkxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p4L8Q8px;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CxkcaZYc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6A606A339
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F6A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p4L8Q8px;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CxkcaZYc
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UZUa3624817
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FMGEReJTj+oAHaCArndjVTrwh1iXUa0fwaYYB4jT5wI=; b=p4L8Q8pxyOPFZ+ir
	eqN/r/lNwi3swCV84aPKoqPV0iwM7IJSMMyMI8OCd1Wld/OS+BWIk6eRpz32L0hM
	1ciTqMhj3+L1LXWzOnLj6al7CGulHEnTjXJbVYkCLalyHo4VZUlsXCeifVkT8ADF
	2n0M+X2qHHnRYeNjLiBQRyWeFbZrJFPm3eKk5UJempKtHsL1VxYryR5EtFhz2bYN
	714qVSBbfHMmzzjUKAIeWSjzLChnw0JUODUcpk1m+nvPPMBrJuBAN2/o/tTPhUBQ
	w5W35zJeX+/hP5kQePdIlHv61UhWercsx9Iw4jUdgJAAArFq6XAOCBFXUy/u1M4s
	QOB+3g==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6br40ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:29:53 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-990835cec5aso359379241.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793867392; x=1794472192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMGEReJTj+oAHaCArndjVTrwh1iXUa0fwaYYB4jT5wI=;
        b=CxkcaZYcxDWTogOMbKzhvonzzJxwOm7AXipmYe4HnV6cJo9TgEWdsUsKgwkd5eDGbY
         TMjaB2obzaxa0TQ0DH6BeiEl1QnFd33y+UJ8p23ddzsJE7ahJBtqmwgzQDJs5qt21xPW
         sawpDzueuhFw3m6jCl0v7GIUT2cJ0qrlqFRinliZDrRYsxeqfJ9To/f+loh+tr6fYLKM
         O50Rq75bC7ByaJ2OYDZYPY6yAyGG1ij+JwjxiFyS+A69Mm2bSWYXzIvl9Uh695Tl6WxL
         6rrmau+bOVkN+CHX+rwbI4Ms+p9axmJaNT+5JaGXnlvKWiBk1LOi5P0aFyBkAYYEd8DI
         4B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867392; x=1794472192;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMGEReJTj+oAHaCArndjVTrwh1iXUa0fwaYYB4jT5wI=;
        b=ReKC8AELhDq4s4lK2u4oCBt7QWRPkmcKBe5YTFf4Hf1yFWCLmhdgdmIfu1pg/iXGNC
         7719r9F8iyKJqYqlsrPmFiAwFAsezVkzUmoiWf2XryqqBG7k4rX2tRikFvYNPhluKGJw
         9PAooKe/TWFH8NGLUtpMMQBWR7LgZ9KHiFrI5zQHWw0MCTZ8ZQg6Gc9BV/KrRShBQg74
         6j0IhQlzW/xA+FebXFLwpCQNd2VAh5szI8Bar+jkuFEtqHSwboYqTiN8jCO2l8peZ8Wt
         fo+1i99jFeOwjyhr8P0hH5XZjIvAeftlptqflYxL2+tOhVsiFDBfFuZ6PPc7aHJYgMmq
         F16w==
X-Forwarded-Encrypted: i=1; AKwUvBwPK/7cDqs+oErZAwgR2sD7GZ7raJd6szJg+9IX2XYpXOtZ6PWp5lFWwavDxiF/LY2OG6qhYkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Orqt7QYoF+Q9RoehkRX3GpUxQ1It1WZedqYjwxc9tkF69/b2E
	BDGdhzTWvSqxxzpuFoeOru5AzTQq5fSEJhdS7FFE71EoC/ZwbGCRbAC1qVgzCdXdyFBGS+0AY9v
	xVYbGoe+UT4KEINtshibTfTVV01rlbbVGcLs0cXr7+0kIIPp8w/zzbKsGdEU=
X-Gm-Gg: AYBFou0yxI2nUHw+IMNk/csjtv3Ar3MAv3YjUIkcMGBGZD2SciY3PDxWVEBXsg8JQo4
	7Zu2ON1kVrgOC8Polxn4E8DEXF7IESSf3OB5M4ndmvzU+XyJCWwT1CW71N05blpq/SPEa6TjQMv
	onkhY0UqCRvEzZCAZVeiVQSz0rkstuH33njqyJYT6E0IXAW05pmcywtsg82n56pfJ3jk0r2ZdqT
	2MNajhVKGGWQv3GH2THYsFi3JT4fQT9caZIzn3CALeq3ZQd/VT2xsFKligqtHilPL2YCBwaI54T
	NbIGRPH3oGnb4XINKcCsJxSbtpS/xoaBBowk5x76kZ+qK0pZMTvUV7k/qmWnQSfND+E3+cbS9Ia
	y/04ptmo2QhnvLZ6cdh95AIIbRVtWj+0TCj3PNieyKtGEYxxYdW3r0xmaSrLF8LU2UjgSNSZdgQ
	==
X-Received: by 2002:a05:6102:a181:10b0:7d2:8735:49f6 with SMTP id ada2fe7eead31-7d287354e7cmr708755137.42.1793867392582;
        Thu, 05 Nov 2026 00:29:52 -0800 (PST)
X-Received: by 2002:a05:6102:a181:10b0:7d2:8735:49f6 with SMTP id ada2fe7eead31-7d287354e7cmr708746137.42.1793867392116;
        Thu, 05 Nov 2026 00:29:52 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecf8ef85sm9375427f8f.27.2026.11.05.00.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:29:51 -0800 (PST)
Message-ID: <5de385e0-1ed7-470f-a172-bc7c8762e0f0@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:29:48 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8994-octagon: Fix side touch
 interrupts
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gustave Monce
 <gustave.monce@outlook.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261104191700.676773-3-krzysztof.kozlowski@oss.qualcomm.com>
 <31d38c50-665c-4f1d-b191-55ce5d38660d@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <31d38c50-665c-4f1d-b191-55ce5d38660d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX7MVc095wpMLr
 poArRix8dOpG7lLIXCl/L3QapnpnCcK5Sd5rIKjxeAOPlzH6HYRUo/yZRDc67J7GZIlMrx3eoWa
 +YFYNER1ZzGuSDpZZJPdbJEE7pesNgyUy2QOk0zlCDuSv0vH30xS86fhuxIJMTegrUwFtrFbglV
 cMKhhZQCxtKT5gBnIyOiZ6IVlT8Ed+MHtZ3g+rmDz2BGVO5k27so8NVFsTnoxlPp5uH0PINcG24
 X8NJPisvTwgmmxAT+L0/NCMafI23fAZwIpvY+2kGQEO1mbHc7yAcm2M5ZKK8IOG15QrB4uluwjr
 ul2DMPhS2Ex+AdNKsaw/7yZAPT0MZf826rQhISxXfopjGC7A61HKob7WgRwoQVug8509nEQknF3
 wNVzo+toWrDMUNTCtVmZyaX7I8gcl1D/8qH/rY3ieL0L5aBXG668TQ0/qhD7peZiGhhWCgzLv5o
 cyprD/J5Fe4JhUIXIpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX0ICIKHa92ldC
 Y6luVT1ta4z877uY7WFx/ei6vRQg7QyWDXN8/AeUYP2BFP0aqtuB48aT5drlebckVDVk2brVAg1
 3/Lc4DdjKNpZQ8dy7NmlPEuYrVG7MvM=
X-Proofpoint-GUID: hMRvFpDLcBTzAwGl0F7a7Hc9dvMul_YG
X-Proofpoint-ORIG-GUID: hMRvFpDLcBTzAwGl0F7a7Hc9dvMul_YG
X-Authority-Analysis: v=2.4 cv=futJ914f c=1 sm=1 tr=0 ts=6aec3e81 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1eH2j9bIuW7Q0crD8LEA:9
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050033

On 05/11/2026 09:07, Konrad Dybcio wrote:
> On 11/4/26 8:17 PM, Krzysztof Kozlowski wrote:
>> Interrupts property takes a number, not a phandle.  Passing the TLMM
>> phandle made most likely the interrupt as broken, which could affect
>> touch operation.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/bug/linux-759fcb27-d081-4ec4-9683-6667b54fa3dc
>> Fixes: c636eeb751f6 ("arm64: dts: qcom: msm8994-octagon: Add AD7147 and APDS9930 sensors")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
> 
> fwiw
> 
> https://lore.kernel.org/linux-arm-msm/20260911-topic-lumia_drop_captouch-v1-1-6f92f1f3c6d3@oss.qualcomm.com/

This solves the problem :)

Best regards,
Krzysztof
