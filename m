Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285D2DEA68
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660771; cv=none; b=JcVpuisUIUeybHDoZSvwNwKp/ySMB94tw3u+t688B5zrnoV8GlUQ/+L14bEieAzV+fzIGLGlhLUxUkI4f/ywJxdu7xqa79ZwHMRMk7tsA75t2DtRwYU1HoW1oiEXXBjChdWC/F8ij/ony1DalQrd6A7MW60XIZF0zLzhfpNLFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660771; c=relaxed/simple;
	bh=WBrK6P1J5Sn8UyafewpSzbEBsFKxbWX5+iAjHib2raI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVGCMzlMiLlDImji9BeyA3LO92LnEPEJjpII1qUOLozA+pFo+05uWghPXVou0pmc5V39Alggf3g2lFC/DMSNgSQ1SLvBkPcxzvTvQVsz4RlLJAGyflwAnYqlSnkPLquSPYyVpwCv/lpkkbnWeQMpdg7gcRbmtPeUXxLW/AH0hLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WbHSujlG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJkCSU17; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WbHSujlG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJkCSU17"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47GA6420005
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+frg3gm10voRSH4KNBjLaqR7f6wGIX42XHmruDIkxw=; b=WbHSujlGrgDr8OaY
	WMmlKN6Jo9lkdsIy5AwBBFCxU9rhpxCN5ZEjn3/UGeC4RWJ30NVrxqLlmJsjDeaR
	XlG6wSbZExGK8jqW7aPv+33FL8X00noxrUd52MWHaBlq49eArmAXLTWLceySBuHg
	KTSK0i6qhSdiHbOJCZKQ359lZAtGNYXf5iCYO3JmVXRosY5XPzYv4yrr8juoBrgd
	xvQqdUM1eZP2achlYfNlAZ/9v8VWDZGg0SyYWYCyObiZMyB2Vz5aE2f/A4uDuq6+
	rZCi6YSE3psWytZ6wv1Bo6eU8MbZzB5Ha2CZo2qG58cQYs3FydzxGQQhXDzKdFMM
	H4ISCg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyxmu9uan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:46:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a082c014aso125965285a.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790660765; x=1791265565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+frg3gm10voRSH4KNBjLaqR7f6wGIX42XHmruDIkxw=;
        b=aJkCSU17L5ha0nMHgNNdoAgfxblO1Ylv1R7mdmasqxzaGsAHZQ9OZAA0KQ07e2WiUf
         LYqzotpLWt58Kkouf8F+T20gpELyQEMT3+KSLq6D/YWab1giJ/Hd50OuZn9d2/YO/avd
         dJhRjSBmeBR9mMGjHDmb+amluGI5nw3vH02ieqSBCMRpSX3mu/coqqPLNLwZaQcr4TRW
         SP19d1kncJFJRrrJF1OH3HK+U1lRDGLfJ9iWVIZnwEhsNSoefKdC75tVKRoau02/MYHh
         42b62kyyDc62UR5PVT9bhJDZiKrx27UYpyiMsuIW9mtH//Tq4XefLORQxlSltCmv2SYi
         XQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660765; x=1791265565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+frg3gm10voRSH4KNBjLaqR7f6wGIX42XHmruDIkxw=;
        b=l336Zm6+lz3PVEX8XpZv01JWRrMBc5yJOExKMscQ9XSPWSVdg6cuIelpnjtaLxRJrG
         gjDOzWNbrLoJBFN2Aj9+Wx5S7IgdgPJqTqfV+LR1Ag2bp9xcTv7NRnAAZJ4pWyFukR7G
         NVux5eqWV/UJB0ARDYplEvNfNyTaYSHVwePXkW3NQ42oCDD3/TiP0BiRQ8uRIkB2XNk4
         7SWNr8inas120Pewsw5alB6LzHpxCpN+HFUVU2VWIQqeIr/LZVQiptLeWHn0DW247uoT
         YN3iROklXG2IIXe3Qc8o+ZE9GEdrxl/UfhwX/U3FDHqWv2GuCLsBkQQ3kRzmpxINKOSb
         GXzg==
X-Forwarded-Encrypted: i=1; AKwUvByET19t7/5xqyQSTyI+UjW+kwnfEAzP+m20LlEPIL1dvE7DYWEGNXNt0eE/XTxjRD3fYBbiIZE=@vger.kernel.org
X-Gm-Message-State: AFuF++kWEkTnq8NLOPpUfgDgIRQSzVWhwHfLTiNtUe5vE1O7mVe0JTXG
	VpYVxzso3n9Ms3FljJb6DUwJpaLcxnyCZvRQ1f8AFvZsJol1L1y+kUlblcca0lM1GYjsLvODRLf
	71yyYwt4du6hj93FiC0uxdVXy2QocRUAWtfetILC7iHQr27LHrLhMozri6Ek=
X-Gm-Gg: AYBFou1PwnhJtwRzD47or7/MaUTq1qtf3bYSsPHdIpp5W6sk4vpwc3HIcX0jMZeJdg2
	ST592weaSngQ+ScH3u9gQgA/fmg/yCcVOp9J5pXikI33azo48E19UIsXYTaEkDpjOUP/ht6xxZI
	rQGGPiGCr85I+en/gu58Ijnh0vRWD95YXBBanlsUfIVpvtW5gi6PSc1XglLDoIANE3XBvKdg/cZ
	cx5Oa13sfibSBfgqIqn9RliLb5TQgqd+3I/kZ0AmBTJv2wmCLF4fQfbpvJf/lbsth6DnPbh7Kxi
	4sTnb2v3bnzHeo72KFxf55amM1jO/iOhfMSH8H6OO593PTMq1/A+8v1z+/2X8TMPToLZLBPp/bl
	BwasCtwSYnYqRQjNogiPW6Fs/h2OaVvktb2eI4XQ1g2JylI/KBcUoyt82alSGOg==
X-Received: by 2002:a05:620a:2b9b:b0:93b:c6fc:71e9 with SMTP id af79cd13be357-93c8bf447famr274500285a.25.1790660765545;
        Mon, 28 Sep 2026 22:46:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2b9b:b0:93b:c6fc:71e9 with SMTP id af79cd13be357-93c8bf447famr274497985a.25.1790660765060;
        Mon, 28 Sep 2026 22:46:05 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00ed06ea7sm31492735e9.4.2026.09.28.22.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 22:46:04 -0700 (PDT)
Message-ID: <8eba263a-c233-42c5-842e-7487ea36d5aa@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 07:46:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] thermal/drivers/loongson2: Correct thermal sensor
 registration loop
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen
 <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <cover.1790561983.git.zhoubinbin@loongson.cn>
 <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
 <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com>
 <CAMpQs4+uWMfFib7MhRcc7o-QMXkFrFCtdcGj04y56u44JL4iOg@mail.gmail.com>
 <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com>
 <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX/6dS5rC/iHYs
 zylzWpH4v78Vh8Ev2usH0JvXvlqh/hf25tOaajWtT94gVuuILKnM/NXChUG+CvC/sdijns922EH
 OiHQioxEzIcXTZMgiVpwn/jC7XCoTyKhw8hTrhfZKBfL1npSr5h5E9qbj0G3iw0ZukpjZDctBoQ
 Sf1WL709WTlARuBxD9NlISb3ktJbTmm/13KECmApXdrbujVnDMet4FAcK9FXb6bhP6KDWnWf8mV
 khWwKBO6NP883qmTIZRkVlM5JO67/Vu3GfCg3Y33Aop1I0LZTuqkFl1iIc7Zjcl8afLZbCcKOVV
 6EgB8mSS8NbBAbBsVV+15+D0OzbiqLnMHC9JE9w69mCcJxwsoOX/NvE/39IgTZ8k6JqvPhRJ5pj
 JLJnG0owR+4nN21J/90Vchk7fgGbqoYGsZO2svuEbIYQmtSxa7cwasdur8Kl8721hCjNuQO1Khh
 0mQWpCaqRYo6AwyTfZg==
X-Proofpoint-GUID: gcrqJHQ8z6C53RYyr9AnXBWYedkgr1yl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX8pxBK8nLpKxg
 tFdI1lymZRVK8Dk1yhC01WZm4aGiGPMZdektLENBXG4MyF9p7QPr70ORFLOEoEBllGFOrISCjEZ
 lOyjAAH+EMgbrOm946B1+g82svmleRI=
X-Proofpoint-ORIG-GUID: gcrqJHQ8z6C53RYyr9AnXBWYedkgr1yl
X-Authority-Analysis: v=2.4 cv=c70+0h9l c=1 sm=1 tr=0 ts=6abb509e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=Ewyx0iL5S_KfCDCwH-MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290022

On 9/29/26 05:06, Binbin Zhou wrote:
> Hi Daniel:

[ ... ]

>>>> Please make a less cumbersome and implicit checks here. For example
>>>> count the number of sensors and then do the check against.
>>>
>>> I thought about it, and you're right—I made the logic here too complicated.
>>> Let's use `sensor_count` as the counter. Is the following check logic clearer?
>>>
>>>           u32 sensor_count = 0;
>>>
>>>           for (unsigned int i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
>>>                   tzd = devm_thermal_of_zone_register(dev, i, data,
>>> data->chip_data->thermal_ops);
>>>                   if (IS_ERR(tzd)) {
>>>                           if (PTR_ERR(tzd) == -ENODEV)
>>>                                   continue;
>>>
>>>                           return dev_err_probe(dev, PTR_ERR(tzd),
>>>                                                "failed to register sensor %d", i);
>>>                   }
>>>
>>>                   sensor_count++;
>>
>> If I'm not mistaken in the previous version, the loop exits at the first
>> registered sensor
>>
>>          if (!IS_ERR(tzd))
>>                  break;
>>
>> Here all the available sensors are registered
> 
> The name `sensor_count` might be a bit misleading, but here the loop
> exits after the first success:
> 
>                  sensor_count++;
>                  break;
> 
> Let’s rename it:

Can you clarify why only the first sensor found stops the thermal zones 
registration ?
