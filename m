Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF512D8DD0
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608705; cv=none; b=D5BE5LalkzFI90zGYhaWkDeuozeaChuH7Jz0JpAln7RLRpiExEL4iU1+JPOobi4ALX3mrxCdHrt/6OPyTfcKPE7hKYnysgfH8iJAMNazq8jlDDn7bz10piHSNLj/PAlc5dqgjPJoylZGpC9FmCviduzd1lQ0Q09sjp/Pr5HoYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608705; c=relaxed/simple;
	bh=my90AxcsOT0BM+hQjh9MNTinNSbEdC0lQeKCWBsWE28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctEac926OcxxIiSzGkIkZG88JxsdJq2QZrkTDbMbCTgWT8Zl92JreYMXrFjlbO3oZv/EpIhspK5f1JdHq8xn2UXnmZE8P1lwbFXG8gnZ2yMGEpPU8TZRC/BdpTv+GZv1hEv5FDMRza8RMUoUPqcvdRmzInFgIDObwWMq/7eBYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgDwNjjw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OgS9oD4D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgDwNjjw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OgS9oD4D"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GACTWE3474740
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1mC4p/ZORnTCo0N4Vz/PvLV6xnFXcvPjV/Xeey750iY=; b=fgDwNjjwMqTyQK6Z
	JwROqnBq6ifyMPf8FYZ0BMUTM+TNiGYFFM0KbbgH8C0AbdpOc/fFQKx1YcI71tQq
	U0OMrwJFlaRhbRUoRxsfUvFZ0FWGnyEJJUnj2z74Z/6mqd0g+gaN3e8hbVLMSdDd
	aQH2iKoECXSFDjptpP3UgrAKbF8rRqEVnbobqesPV4Yy7bcA5X7RYHDdcPzU03ud
	DskvVN7ekHxTpMh/CV0/leBaX71aBfBnwf9g2uq/VIi864hH0k9NV5RTcY2ogegE
	5Wy+C9c5QVWgUzHTTMFcBsjInP9Sdy48DnDsh3QuUxtJsmce7Q6JPMR0AX5S4kS8
	J6RFhQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52sr0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:18:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so7023186a91.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781608701; x=1782213501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mC4p/ZORnTCo0N4Vz/PvLV6xnFXcvPjV/Xeey750iY=;
        b=OgS9oD4D0YzDiXyR8tbOKDjuvB0i/1mMjmx38+BZ2ssFVxAi9+k9OMzKQmJj3qbBvd
         es0ZPnhMK4YG5HGie4+7YLFrH0XGLrLHS9sIli8CfgrglFueIsK7K6CgdysqeZ6SvGyR
         /3DLytIjRYzY+/PyA9FjTBCXokLNS/cV7B5fj1Mpy2t+3hU1ZcJedjZxH8189FU1z15b
         w/q+FSvf5Z+UomHyhOXe+Ts41qiC6W/wfSGmyjNAAm3vR6NrlrvvWG6JKD4JqV+mx/Pz
         058JVh1LcUZjuQdhRZuief8g6vKfJUmiVxaEEyB86cISTF+HzpJ6u8/cx7n6cZ8lLI8J
         eLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608701; x=1782213501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mC4p/ZORnTCo0N4Vz/PvLV6xnFXcvPjV/Xeey750iY=;
        b=np/Wj4lisFAr8VVEJvLkClDx0sMSyENzgBYLwCaoNkCgWOR/bUQ2FlFwappDqkrF7f
         lJKMLSLkv/YJeTbQYvUCvOsXAzkU+qcgbLcuscPhNmU0NMSTTIQMU7iGXOGKTz5J9M9L
         tlp5ao2kgpgoOLB9JL14MLv7YAKytWEXvooJYT/ZiI/xhw4MyYVHWyKpefRvyYMdEUSF
         rJhLjrEewqW4M6k62HKUuWDKzC+XQzC+4X9CdE3W6bfgzY+3UMW/G/9QlkBBx/zAsdBK
         8xB8BaeiI1SIqqaOLoGrzXMnAe6TY+paWdC06YtbrQwOLpoKA1AyS/F1zJqexLFvuGWO
         bf+g==
X-Forwarded-Encrypted: i=1; AFNElJ/1Z520ZOFtzHExDhdMr76FCph0SkXfZsYajHOg+u3ly7ptocIn4NKQRlNuHKTaKp3ghG1vpVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wWA2w3OImto1C4DDnTPiVDgCRlJ222jM8v5lJ+uQC8V1aw+y
	oDO4czpadiUAvNYV+BOpHzfmBrIZIHpwMCTWk4Xe1AwXuEyyO0lSk7OIjGuVsD/KoFnhkCdk9ZZ
	3UXgtmdleUj4DFuDuA6eoIucYrIgceB6StuN0y6RWF1oEZm4LaCcJgfoonDE=
X-Gm-Gg: Acq92OFruw6sIIQxjLNa37/jC4QWF41cubZHj9mtMUQrnjf0GYGnsjPeX+3dm4PgtGT
	zmRsn4TVLCVG9S4+xPMzDnTFFF9OX+FNU5mTRSHDT1cPIUyyNt9nk2AIxo0IgahxkgPq/jHunEj
	DdqhTkYipdjGbo6r7G2eBkUM/n/wezMPFXyLqBH6dXCyIpgZJ1/OUE+AAr2TK20pDnWuQTFVqGO
	ODAVUuYDV6n2ygkjMSGPE1FxH6vVpjAVr/UBsMPr+X56f7AOYVDbgpbLSisbMLAS4GzvHQiOjiM
	lTvJbBlHlizE4v7MfNHtWgw7Zb+jrQLnpB/4krfGWvIkDqy6gN7p0RASa/IpYefKxJ0EmTRWqN9
	dXk6q/8E53ACIoMjJ4t/qDsR8zkIYvAkx6lww8Hfa/nDWhtdRgA==
X-Received: by 2002:a17:90a:d40b:b0:36d:6315:1de4 with SMTP id 98e67ed59e1d1-37a036ea1b9mr19181546a91.17.1781608701107;
        Tue, 16 Jun 2026 04:18:21 -0700 (PDT)
X-Received: by 2002:a17:90a:d40b:b0:36d:6315:1de4 with SMTP id 98e67ed59e1d1-37a036ea1b9mr19181517a91.17.1781608700654;
        Tue, 16 Jun 2026 04:18:20 -0700 (PDT)
Received: from [10.218.15.172] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ca7a7sm2624672a91.7.2026.06.16.04.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 04:18:20 -0700 (PDT)
Message-ID: <f6dd1ea3-52f2-40fb-95c4-4e15618aaf8c@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 16:48:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: qcom: Unconditionally mark gpio as wakeup
 enable
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
References: <20260430-enable_wakeup_capable_gpios-v2-1-8c26ac795318@oss.qualcomm.com>
 <2ba8b020-c8b9-4c60-9fa8-545642bde1fb@oss.qualcomm.com>
Content-Language: en-US
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
In-Reply-To: <2ba8b020-c8b9-4c60-9fa8-545642bde1fb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfX653mCAVs1kKN
 QzBksz8G9ItS1MSf/gA/kOtYNN6pZcAZGUnouEjjsYBAtkoUNIHYoNq44hQFiSsW1PCS5A+ZRRd
 HTxyUSHoPutxIXhD7GX4qpmYkRaQmUc=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a3130fe cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Ye5m1eMZPwjv6mJ2BMQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfX46uCbmpvPBNQ
 F3Ee4jccj+lzjC3tzAWJ1aNX/78avAj4qeNrFeDQzFoj1nacTF5iYVrlonnOLROM4I1HC+0vL5v
 wfKc6TrQR6UbouGpw+cz0trNJd9i9f/wvGEyAqSBhSTA/FfInzwYCUMJQfChIGjLv7HK962u7AF
 E4j08WRpab4ZEt+ruTsBXeqN1zhrRuQgo+MCFH30i7IERkyVY8M89g0T4L5p/qtAqHLZtByZ3gd
 Ozz4LLr72cK1gC/64pihObW5wgz2Ext3IJ79GNN0c193LbvGTr2cg15se9bQDiuEFxdI3pJrUVx
 MJwqzCcNuGYgDd7YNffqB/5Si1YSO+jYekDLtrVgCJGGMJe/kLi5ugdiL/WwI+CDB+bCzksxUsG
 iyJEh8NGaPCCwGlyHPuWbjoysY7jqD6ro9Do2mF7dbLRgM9Z/3wkXLWKtk6I+TUEJassKIcnCN0
 A2rYAbfxNFJffWSE/rg==
X-Proofpoint-ORIG-GUID: 1v1sjV_k4T8UY-HpcWN7btyRfA2lv4Du
X-Proofpoint-GUID: 1v1sjV_k4T8UY-HpcWN7btyRfA2lv4Du
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160114



On 15-May-26 5:02 PM, Konrad Dybcio wrote:
> On 4/30/26 11:20 AM, Sneh Mankad wrote:

[...]

> 
> $ b4 diff 20260430-enable_wakeup_capable_gpios-v2-1-8c26ac795318@oss.qualcomm.com
> 
> [...]
> 
> 
>       ## drivers/pinctrl/qcom/pinctrl-msm.c ##
>      @@ drivers/pinctrl/qcom/pinctrl-msm.c: static int msm_gpio_irq_reqres(struct irq_data *d)
>     +   /*
>     +    * If the wakeup_enable bit is present and marked as available for the
>     +    * requested GPIO, it should be enabled when the GPIO is marked as
>     +-   * wake irq in order to allow the interrupt event to be transfered to
>     +-   * the PDC HW.
>     ++   * wake irq in order to allow the interrupt event to be transferred to
>     ++   * the PDC/MPM HW.
>          * While the name implies only the wakeup event, it's also required for
>          * the interrupt event.
>          */
> 
> This is not what I asked for.
> 
> Instead, please focus on explaining what skip_wake_irqs is, perhaps under
> what conditions it is set, and how that differs for PDC vs MPM
> 

I raised v2 in reply to Maulik's comment. By that time I had not seen your reply, apologies for that.
Will raise v3 with added description.

Thanks,
Sneh
