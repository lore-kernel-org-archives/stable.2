Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742763;
	b=EkKIsHEm6kmJZUQKvqS6KWBCla/5aBruOFO23OicW3XOR8VRRq8YAmvPG/AtrSxrXcc9
	 TMoVOUzF1syjoCcVz3lJklnMcDe7SJUUUnN8iulEhLHswPPV5V3zkMcgCbK54+XhnAFAI
	 ebfLQoz3Ii1opSvITYUdlWeVKZauZRqokzWDTcUK7LYX61OJCTAFGLMKoWSiNuucz+rGb
	 C1xPuzjk/u8XgCv64ZDKUjQcCKQ8lnSTZa1Kv2A07V4XWZ1ZR3lWVrTy6cTZo6aTYXi1D
	 RPntKZg02g8YdJiYTF+7DzGrP6XIqhxp5CJCeQ6U+u8ZCr3r3IDjAJ4UdDGgEvobmUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742763;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uU8ryexn0I7UdpzqrHG4lhMSHCO1ccEarOJ2Ag6hyaE=;
	b=dOffw/7nFDmBjzYWDAfw8I0LjbXnvhg4U06ftBynea3lnbDdcIHHMyMgcAEuB3st9xCz
	 LjCDav2zKIBF6OQbLWE1F/999nWCvvk9FOnnsO7xKZeN+D3MnttrFdy966P3EJl0b8nbd
	 LxbH9Rlg/L4QD5eFRo/H/UUf79SsB7uBpjSNUMKywEPFcW9HfLMGwZI6S6GyhNyDNVSOY
	 0nIgQf7emJTAMRkx2Od3JDGs3zo0nNLVcSHFrRJI4BmR9calHeyjtQMxENm98G9pCvHwH
	 RFNmPbbpPwCVZidxafzK6WDGdgVXkrvZiSh1/lPxafeV26Gum7QHQg5ee9LGgvRcyaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kG4s0kT2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z6tUCf1Q;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09442606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09442606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kG4s0kT2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z6tUCf1Q
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FOm61048397
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uU8ryexn0I7UdpzqrHG4lhMSHCO1ccEarOJ2Ag6hyaE=; b=kG4s0kT21uYk+jbh
	LbLcYMsll56FYoJQubZo/rQGOLrE0wF/AQXBWTQkW6AdTUcdAF/brlzuqJ2XpfSq
	J+D62aeNuNhkSWH5/iKjWcFRuTet9tibPVDZ2JYrJjCinplz1eKGzbMbrdyM5iY/
	7v0ord5ZH6FjxN+bdcylNfBatEDB8ne/GzCQaRe4mPW9jTGnKOe3ND4N3iFmN3rw
	RGzsM36qpKChaDjdhZyFfv+Oe1Vue+/1SXYOSgIiQ0m0Ok6XfW5uzRmRmQfTQy+V
	ZuI/cPo9MQZhRV3edOrsdDcnFE9YPVcMFuU9u0R8QBZR4VbuU4Cj+5gugdKSUTwm
	/5PFmg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjp8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:06:01 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-990758837bdso30713241.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792742761; x=1793347561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uU8ryexn0I7UdpzqrHG4lhMSHCO1ccEarOJ2Ag6hyaE=;
        b=Z6tUCf1Qe24S/l9pnoOdyW27NgnQyScVvOVOuK/yhYyCyeTdSh2aoaZuHNwnsHB2AY
         JJDmH9hTmd8XwIbT4zvVGkpqKQAWh+pyXsdyaIlC0cqFD3P0DjNodLfVEYNOmNA9Aua3
         9f7UqEZ9RhUtkFESTNWAasmIYLc+wcOw5WhcI5OHpmJt+51TbKL7cQqLHrO2JjE2KNr+
         e+4S3LzIGn0VbiC29qE/JOk1swoorSluN2XBVS2mQcC9BKgDAwIDz9qiKyqWYRj84BZ2
         y5Iyikq/cfhCsvGp/gJaYk7K6KNSnjPWOl/p9vWU7v4xKj/eTqIkfNtlypC6btb50npf
         3+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792742761; x=1793347561;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uU8ryexn0I7UdpzqrHG4lhMSHCO1ccEarOJ2Ag6hyaE=;
        b=DwL8/56m1pr9aTBkB9F5naMGOxY+Ei9OEjTKxMQlUAI51MvSq7opg87heA4x//lXQC
         c5TdzNj65bhIHWxySu7/J4LQlMS9C7ddFKlQTZC2InNzWDSFFCoGr7Ir5Ce5bkToKj9u
         2eZA3j5kWCOMNLEHHBLu+MMchDuCK6Otu/4zx61A3vKyLuLkvomhcwf91R79u6o0e44u
         NjmUgLey0s+vyyNYcYKxeMA4ov1s6w4GyBqKXtFWCiovvVK9s5E9jUf5zOv1ALmQY7be
         L9jGtYtjvU7d0ZpjqMLrfhJfSRHJ8Y4mbHpziIdsmhCIZZQq4mfXy0prozZ3+99VjbJq
         wp6A==
X-Forwarded-Encrypted: i=1; AKwUvBydnrqegRKAAHypxJ/RCl89G/HIt9i+HFqNm3oCh9dzT0J6W/qMOCbHuPwnOop5eIG5ifywGRQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2i/EP4RCMIuUIjxW9el2IgtsmMVuqAo/4bvTiaf37yynTPmaZ
	aA5sUOX1gX13dRAFewKsMU69a1cTtky7d3JMR9VX/2STs/hVR/MEMTIn/fMyJjVOjGB+jmrKunN
	aqHHgikCFPZuO5+2yxGReyJXD37brY5GfZhlUHJjCXy32eN+pyjmMKRlqRG/jstf9HWE=
X-Gm-Gg: AYBFou0onajYWFe4YY7/LNNUw5jVLwEIZOyQSvycDxAg5zeqqHEADNoHdghMtEXRF4O
	0j78wNQZEu926ob0FndG59OweCVMwnMEYx4LJ9v5yAAQWQdsbvF6B2dhIIOGYHKKA9W3taX1kjB
	+56kVeaHYd6LbC3V6wM/AqVZxEgUEKLFZfkYjcDGmtsznTpUcHsl2XO/Xep/CIj3RKPQ7Ist/GH
	pAFY0SqGqWlSXRezSCblfBxkwFHMKOuUPTrOYvQe5P9PZv2b2E1wPvm2zrnVs0xCUyX0MYetwAP
	/I1tQXODVxYp26ZHsW0fnSGWabi/pUn+W/Xkq95Gw1337FooAZ3LUWCm5/fQwKsadM0okPa0LZ+
	sGPTKVuvqdMjmS62dJanwTA==
X-Received: by 2002:a05:6102:a189:20b0:7c8:3b8c:82ae with SMTP id ada2fe7eead31-7ccc32bcf6fmr479057137.2.1792742761094;
        Fri, 23 Oct 2026 01:06:01 -0700 (PDT)
X-Received: by 2002:a05:6102:a189:20b0:7c8:3b8c:82ae with SMTP id ada2fe7eead31-7ccc32bcf6fmr479044137.2.1792742760678;
        Fri, 23 Oct 2026 01:06:00 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5cfba36sm74805266b.79.2026.10.23.01.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 01:05:59 -0700 (PDT)
Message-ID: <fea00cb9-3ade-44ca-8eff-e2a387074b4a@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:05:57 +0200
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
Subject: Re: [PATCH] remoteproc: qcom: pas: Release DTB firmware after load
To: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022-b4-qcom_pas_dtb_fw_release-v1-1-d92d84a05544@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261022-b4-qcom_pas_dtb_fw_release-v1-1-d92d84a05544@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXx9igYxAOZzM1
 NHYylBCAxJLzlJv17bbQftsSms9L6WuZTYn+5FTg3SAUfmQZ2H/p4m3q81E6vTPmTb4FlBwfiPQ
 02iLAVmIkMs6Ab5xSekr6W5mGLi2CxI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXwdf/I0qVe4s6
 9hvn7rCaBlitFTRvZ9wXaGb2f8lkqx13fEhX1KNWE4a6aijFMlSayNGzkspqzyAwRJk+mWXiDGc
 ubaP5umz/r5kLn/l2wXcyTe0O0beLHgnNpc/exmDCLcqeP84b9YA/EaQkw/z1+mYHmSpIl7oqyt
 XGj3eI54OYLtzw87JnglmOiEVAoIuW01YIfbjN2Pg+SI4PMRAIU6O8GJAXDVPlMAVZfvKnHNDDq
 zObKuYR5c6qHeNRZ552EPc/QkEHWd6eLJEmApPUobrTE2R6dULL7kHrS/IKnQ7vb3/IhFjzEKa7
 F8nGAiB27Y/Lr9YKZoTbMd4bfbIbSN2Kai91OngtOMIAcLaaEtdNy6LjSjMxyOoXrAR3GThFtea
 f6c7J/6miwev1UCTH99ERwb2Z/yhnKd162DZ0Dnl/j/cV2+NknvwfvHJjv9e0rbJMhtRhbtHhk2
 QWiyy05VDS4Kiw/lbiQ==
X-Proofpoint-ORIG-GUID: ToIhxqTvpJZLE-iOWuxCFPTh5rULxEe_
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb1569 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OpgpJtwNEdfdaaOfhYsA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: ToIhxqTvpJZLE-iOWuxCFPTh5rULxEe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

On 10/22/26 4:54 PM, Anup Vishwakarma wrote:
> qcom_pas_load() releases the DTB firmware only when
> qcom_mdt_pas_load() fails. On success the firmware is never released,
> so the DTB image stays allocated, and each later load leaks another
> struct firmware and an extra reference to the shared firmware buffer.
> 
> The firmware is not needed once qcom_mdt_pas_load() returns, since the
> metadata and segments have already been copied. Release it right after
> the call, on both paths, and clear the pointer.
> 
> Fixes: 29814986b82e ("remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
> ---

nice!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
