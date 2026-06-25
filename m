Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0A3749E6
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374362; cv=none; b=rmqpPjxMPaa7+ap7yk3N+rwu37sTVYEyBVzzwjSshq0WBsWK4ccd5lr2fmITD/bvsOBu6QJSFPSmHjj7ugucKh0JjA+uUH8cNyWItMA4KSui7LyuknDcjeJkY7LqupWW6Hy20iRXeCsXzujVRwlvYUCBxW95HfFgtjoQPCfKmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374362; c=relaxed/simple;
	bh=z/WYgAPYjwAq4I23XYwEmqwh3cYJlJxhp2py1iXT17Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COQN000rNlWJ5GrMpUdLh7xo/6HUEWwO3yVZbueDPfAR8IBE8vJszWO/M51Suy0nMQLg2NTHPBui9XRNIefW/dLUXAeMkE4FgIxXaneWkZp2qyqCwT4vambIPb59gx1nkKcXbUVQmlJudMXwHTpoiNDwsTUBOi4lf9lxVnkADkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QyUc/VMk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YxBHHCxu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyUc/VMk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YxBHHCxu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P7SP5q2762971
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bt52y0UxYjJxGefuoc5i72x0TXQgvEF722OpeKsWqXs=; b=QyUc/VMkWOezro87
	GzYLcaU76xRkzFuqv1/JyXF6K1s1nl94FasXPwSZHvFTI5F0b+udy7aoGR3bxw8Q
	fkXHt9/43wd0pmpdIq69xX5cB/MerZXHZ3BFmssDa1bjbc9/1+0EWU4se5Uh7EOM
	wzRWyW75R0YpPVOX86h4J6jURLzKzBv58DcUX9rETq4SvG72p3m8MmBFrrJ7gVtw
	GfPg7SCwU1N9eky1dwf1DBN4dZvsv2UasotEfZRNMDj5xMWfvzibxR2z67ywoILF
	Rrls71YMMj1hfIUx7NI7pILQ3+a7iS9yOPoLpRM++Q2F2C8qMFtAVdTwPZGA3vdi
	vh2jOA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0yynr3sp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:59:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5198e72249dso1877931cf.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782374358; x=1782979158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bt52y0UxYjJxGefuoc5i72x0TXQgvEF722OpeKsWqXs=;
        b=YxBHHCxuQyhPrVId/jrGuHOe2MLRJzga65SYw2YWSQOTYr/a3C0xfB7F+UF4sKcxnt
         4gReACjtP3uPWl6P5gG06u3+wv4dCUCJTW5/wSXlS6EDeJhYadvXWFMils7oGusN2QJn
         odmNSPT19cbbV9qQgFqMy76z+3haZnKOjyvQZpHIwhe1EQkNwaq22zfRz5fyuGK7X1Ed
         6ugeqwjwb4cXeGVDs4O2PsMWku7h2PbQqjGnFJRn9GW4oa20KJqDpMPoSUFikjaEGwda
         Sai2wWysmcs1YNaFiRRT6dglp67WhuIbpQTsGjqqnrtVv0D9hVQzYNktfng91QiMnbhA
         At8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782374358; x=1782979158;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bt52y0UxYjJxGefuoc5i72x0TXQgvEF722OpeKsWqXs=;
        b=ogpMVshudpGKI/S7FqrpniSd0sylSzt1OxiptKCGTz4acKGChvk51WHHhGTTTQNicY
         Zr/EsALjYA0kxeTu8aPSkYKpRYlOa2pdLguo/TamBg8SygbgBEph+2o3JF+Y8YrfYSB+
         UkK6Rgw+O+CDzfSKmaW+KQXLrlHQmKU76gQf1S/JJi/cW3MrVVyhpCIomoHG1w+yggZC
         0hNL5FO06xiSrkPN7pDaiI56fSIx8OrpSpFN/f7TPLlhX8qPKH5r5+agh8F08iWJW8RC
         +dQ4/pMQm0w8RnDdByNW0MHprVAlpVWXMi0H7M8qwGFqSIHlUKhmtz55D/HY9U2eKaJ3
         abAg==
X-Forwarded-Encrypted: i=1; AFNElJ8DpBFn6fGS2TGqa/9eYxv6W4MFyG/FPq9oIj+0O3doxhtbp1L/tTfYH1/4rrNJqsWwTtTEovM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoMBfwEO4uad+yeYHZk3oM+F9ThRPqCXJqNDdx/Jmkeydc6ap
	+gcJ9xxpLp6W7CoEJh6fn6tmFPJofuxU/XO3THcImcIZoYtJvnq/JVj7KvsdmMx4NmGMzIdzyaA
	rzzyNLGKsbI5CNC1uFMvhD69Cf843eOVzKPdAfyq7bZg3W0gpPzFMa2bAXhw=
X-Gm-Gg: AfdE7clNaUYRky8fRV19CJnnFUaQyF4iMvpju/d48M16PqEVEg4fBoru+GqlsXE3afN
	Gn8cxdaJMyjEG+CEJ4VDomoaGgPsXxxnVxGYOC+GEQtE48QOGVbwrLxSj3pFCCMNVKk5itzC/VK
	AEJYx19h7M4vhCvPo36T8110ChqK/Ee8x9X//ay4XX3pMGFCA8nk+o1uK/FPBk7Tc7mxqyEUE6h
	CXfj79Njn1OU96U9vsXIZVIBkniTsD5uM7uBvTxNy93GD6/JgVlL2FDst9iVkM+CglO04KIEE+6
	vjrkpgkCQWgYpbu8S4S/vuWyjX61nRO5QvEHMPB9J2sLS12pZiLzSb9zv0MPzsdkEZf4NT93K32
	6gAyMRudU16hgOiuMGZtlqB/DA3Q8U1E6iIk=
X-Received: by 2002:ac8:57c5:0:b0:517:6162:daf5 with SMTP id d75a77b69052e-51a72a47ba5mr10403681cf.3.1782374358310;
        Thu, 25 Jun 2026 00:59:18 -0700 (PDT)
X-Received: by 2002:ac8:57c5:0:b0:517:6162:daf5 with SMTP id d75a77b69052e-51a72a47ba5mr10403331cf.3.1782374357864;
        Thu, 25 Jun 2026 00:59:17 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe5f249sm120328866b.50.2026.06.25.00.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 00:59:17 -0700 (PDT)
Message-ID: <765b17f5-0ae1-4efd-8af4-9f9411862acf@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 09:59:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pinctrl: qcom: Unconditionally mark gpio as wakeup
 enable
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
References: <20260616-enable_wakeup_capable_gpios-v3-1-fb59647d89cb@oss.qualcomm.com>
 <d9e778ea-8a67-4576-9c96-9cfd859a266a@oss.qualcomm.com>
 <37f34aff-c68f-43ca-b23c-500cc9bb119e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <37f34aff-c68f-43ca-b23c-500cc9bb119e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2OCBTYWx0ZWRfXzgCgmv/8EOrt
 1rK4bLMKaQzd4ldwEZlqbcrdgK6hmXKmM/s7HJSnU1bQabDMpwaLksLsk57ySYbeYPSYCpy4mQ6
 Qfga34EGXdhbkViyEr5MoIOrlLs06k608sJdan/rAjChuQJPnAXHPpv9SSbYj8DFEax49TzOEun
 pKxdXQrLPPXCAesx9rdVOnh/e/HbIIPVktQn5lKrZjOxzYKXw8QLvYFmLAc9pUXLoPUCvasjQCg
 rvlYTIQrCuyhckvc9aV/ZwXXbkUlEy6D64qQF0sknBz/ZvrzK8w/1RyYMe34hT9y6vY0EcC1eUm
 +oZqU+MWhQrlDS8ZHaFUuboD+nxbJ7K0oAJM6+gHUnY2K/afIspDol3DpVhE7V5EncAqzG6gnBK
 4RRwBymv6BRZvqQdJHvD09adD8HqEhO4mAfe8A3u1wOUOC99Zo2cei6Qt5RJzOlKoF/kMtKtXa8
 t/zZKFhdF9SACY2LBxQ==
X-Authority-Analysis: v=2.4 cv=aoyCzyZV c=1 sm=1 tr=0 ts=6a3cdfd7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=isb_plKU-JZBI8JTm9kA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: _X2WR4H4AIr3dEhfnCUez6hjXSSwoZrW
X-Proofpoint-GUID: _X2WR4H4AIr3dEhfnCUez6hjXSSwoZrW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2OCBTYWx0ZWRfX+EW9FmFfjBX9
 KXRiCMnARhV+ExGQ1dJdEx6vyQc44CN0SoFNDMb777Zwu+NUU80eIMDRCy9SEziBp68rMNGh54U
 na9vI3v/NgfdvxrjNKnngY8Fvo4czjE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250068

On 6/25/26 6:33 AM, Sneh Mankad wrote:
> 
> 
> [...]
>>
>> This is a much better commit message, thank you!
>>
>> One question remains - should we set skip_wake_irqs for MPM too?
>>
>> My understanding is that no, since the MPM HW is simpler and doesn't
>> have a register for acking IRQs, so we need to do it from the recipient
>> (TLMM). Is that right?
>>
> Yes that is correct. skip_wake_irqs is set for PDC since PDC can handle interrupts
> during active time and SoC sleep time both, so any wakeup capable interrupt source can
> be handled via PDC at all times. However MPM can only handle interrupts when
> SoC is in low power mode, it does not have the functionality to detect them when SoC
> is active. skip_wake_irqs differentiates this behaviour.

Thank you!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
