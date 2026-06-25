Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC391EB1AA
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782362020; cv=none; b=IGI6YKvlBPRVm1NTS4CjLk5zk2YzRZhPByR1YNoI3Rro7WXivkaFfJi0c/SSYY9lVHbRTx1DQ2f/QqmF3frW7rSgL1OadcNzKEW0KG/6rsvUSaPqKRtHYgrrXTvyNkdrY+yvQYUU14AqOzEicvB2i33BAB7ykInAFku6XCRHrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782362020; c=relaxed/simple;
	bh=di87V4TuWc8GxaW2bpmtLqkg86RNsVY13ZKDNnUAke8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwgZ/qhLDNvaoWPXv7BJSfdqtkGEqkaPWHKJ7wELKm1UUDbKnDXEfXlVi1x399A5YOCLEtJtKlGVQyk2jKJQwkpcDW1sexlnhYJbVJdJQkcLPNvGj+Yodw+fTzKlQSXxOAtMc/tBDyoI6la1J0SoCVM4rxYxqkGsIBrQ7wTa+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EWmExZUF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PWSH4snW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EWmExZUF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PWSH4snW"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3eBTN559066
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 04:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0+FT5jSvovKl8mmSq0cLr6FQpeeAxgbMVrgag/p1Y74=; b=EWmExZUF1I3+nn1z
	iwUXTnwl0sTFyMMiydaHqbC2SdsIEEj/T8YdA0Z2lp9x3g3z+5Ui/Yf29u7CFRd5
	ZS5eTePRAFHD4tWDh21LqlNr5oZ9XT+WpRLtFVXeGX+Xd/lAN4oQjCt6SH7RNL58
	HVWk6A6aVw8rtbBP4920wvJJ/OvKNmEvg8tqX7PwzWtJpH4utoGKh4liwjunQD6W
	J1bJamDStUNdGsziDCsoXAdLkCoa5aVVxUPCrj4l4CHPzQflZ37lDDyr5EzbErq0
	bFebqKrzn9MWtRi6HN6cfCv4Qli7LfXjyTV3+WLyuM5Cb6VFHglxqixqV6Q2VFnY
	nv2AHQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0d454033-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 04:33:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c011c7cb9so5194252eec.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 21:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782362018; x=1782966818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+FT5jSvovKl8mmSq0cLr6FQpeeAxgbMVrgag/p1Y74=;
        b=PWSH4snWfILMzzVwiN+0Bwajlw7779aLYskcLfRHl0JNnfB4QW6AgHRo7WRIFqSlSN
         IscHnOQCASaLJAQTe2BkElc8W6J5PXQpUM7hjL9/tHd7KsxqhWTc+J+F71JQtQP3m332
         7asklkRRdj16d/bN+gxfDUeXm0VmuHYS5Yip+ECcHFFmcf33NvizxnRSer7rMZPPyCLy
         oLFja2eyrfEVfDhaJOKPZwzXVL/SPXhpSswEAuNbNL50X4Ds4itnoQAG+NTBXT9OEEYG
         zFrXYidpzqwPxy6KAHqoRg5kJ9wyujVWcM/VIXlENW+KHgW6LMkY4f6MXz6Tp9zYJwET
         QawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782362018; x=1782966818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+FT5jSvovKl8mmSq0cLr6FQpeeAxgbMVrgag/p1Y74=;
        b=AWyE1k1lfI7lkzjKCcdFICAhSzFHVzcb6VuS0LrYBGDayL77KuIY/5TkySmJWKzh45
         O0vYTr7FcY2g05syveCnM2IHbRuMx1JIHDVehT4gpiE8BQ5xYZXC7k9iwtgxYjLs6zkM
         zSQcm563SA4o34rTftewhtKrRDuVy52j2Q4dVdwCBjYjnPcHOjE92c5oX14MTfipbPQP
         OYQC/YCHs2MJRmA0EX2UIk0Re3t7Sq19sLRv2bMpJA5cMauu8Y6gkJvVTtB0UJLPIctC
         1iR/fybcy10y95kRXPwFp3AzxzVlGbBo5FqtfjQIjUrljjZdQjuoCTd0G3+x2Y6MJhMO
         pPIw==
X-Forwarded-Encrypted: i=1; AHgh+RpQJEf41jot42m2dmE3U4hOZWkajyeBT9rMLm7oj+0irLm22UAjXR6Ai7dJJgjHFecAp4wUR/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGOVdrl2o+4F+OaPmFb0qDSbOJknQP6C1BVZqAfQOvxM3Hvk4Q
	zlmLW8aa41yXG3guvg33p3WUFqi/G4wn0Cw0RQ56noVKasDM75Qzjccl5E2oRzZShl/XdnxM616
	XTWFbvh0VSXlyVGlpfly80LA23dEbjc2ifCcPduJhvSe0g+JtgFdj+VeR8yU=
X-Gm-Gg: AfdE7cmBQb9NRNfX/iUYh7YwRxfJH41M3cUvAjqshdNpIayErufgviru0L91dxxX4lq
	dJ3OcE3up4St0y4sPsLIJNqVVN/T21nETSpfHdB1VVrglrvPEmPF8XQhAQnnZSlvye8SoNGbeF4
	NX6r7k2z1QokESo2eeEKfqeBahivp0be2hztmp8KCXiFQaXcZ0y28ZlfH1vaEK+CyyrNhW4Fjse
	8dck0wQCRTZgJbygdigpiNpOeVjLzm3+sB7xYh5Kmg7f7XyFHKSJQMP6kupX7yeJ3phd4lx6TQZ
	qmlswXr2EiSgFmhs6Ugped6pMcVELsvmCmdfCUXNF/YI5b+AjBSweG5WeQEnYezz5kkRogWesiy
	a35pUmMrHeu7Ztz86iEjvFGs1SjWgSRBJBL7liZQ=
X-Received: by 2002:a05:7300:7308:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-30c84e2074cmr1135173eec.11.1782362018187;
        Wed, 24 Jun 2026 21:33:38 -0700 (PDT)
X-Received: by 2002:a05:7300:7308:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-30c84e2074cmr1135135eec.11.1782362017677;
        Wed, 24 Jun 2026 21:33:37 -0700 (PDT)
Received: from [10.218.15.172] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c664sm4251756eec.8.2026.06.24.21.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 21:33:37 -0700 (PDT)
Message-ID: <37f34aff-c68f-43ca-b23c-500cc9bb119e@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 10:03:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pinctrl: qcom: Unconditionally mark gpio as wakeup
 enable
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
References: <20260616-enable_wakeup_capable_gpios-v3-1-fb59647d89cb@oss.qualcomm.com>
 <d9e778ea-8a67-4576-9c96-9cfd859a266a@oss.qualcomm.com>
Content-Language: en-US
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
In-Reply-To: <d9e778ea-8a67-4576-9c96-9cfd859a266a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAzNyBTYWx0ZWRfX2Vg6t+FbXv89
 A7JWouo4xTiLl/969gRuWEM6F7MpRyxFQEokOfFIBY4CsN0YBy3qg126Pq8BaD5Cx2CgQMUVKhm
 G6QEp2CxF963wRGn5447yRkzjwigEGXke6BoAKd4y+BpmrfdhIwtsK1fDSAEdReR80PBWlRKVIC
 6qfSi6A5mKHdI/SKpGO+ebBwbhJ6u0aSHTb2coiYDZQkeTlo2KLo4+ohCGkwY40bAQuNUIaY6YC
 /PZUQI8eJ37b6AlZRjnT5jy750t930OC5WizUz4q+/kwDBlHCjkrfwiNWKPrwIsYTyAjLJxJZky
 BYXdFDcICyXDQq1Mpwc6AvbIZggsJTC2XHJ71H6dyht/1NgXFXHSVUlctuOd0LLYAM8hhlfEU5P
 XodVyDhFMuuqE5ZuWQUht8U25g3cN1fsD8m9Qd0qpIN/9Kd7gdPEwfycdTc9mbHa/jz0qtIfr+m
 8y/hWVFumPQmYFtewgA==
X-Proofpoint-GUID: MXeRSx3CexT0ucmAH9-b1jgy0eiLWQ1Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAzNyBTYWx0ZWRfXzTGTHNzYHgsm
 Sme696fVu/RlQikSJtx9nLg/Q3FdCt7dv5PSAUVt8shJNO/vQf5SYTPIC/Tfebq/YR1bpUnC9Ia
 bB6djdAEXu4H3LvwbXyOCdr3215zguE=
X-Authority-Analysis: v=2.4 cv=Ar7eGu9P c=1 sm=1 tr=0 ts=6a3cafa2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=K6J0lT_fCWCxxGhrr3QA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: MXeRSx3CexT0ucmAH9-b1jgy0eiLWQ1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250037



[...]
> 
> This is a much better commit message, thank you!
> 
> One question remains - should we set skip_wake_irqs for MPM too?
> 
> My understanding is that no, since the MPM HW is simpler and doesn't
> have a register for acking IRQs, so we need to do it from the recipient
> (TLMM). Is that right?
> 
Yes that is correct. skip_wake_irqs is set for PDC since PDC can handle interrupts
during active time and SoC sleep time both, so any wakeup capable interrupt source can
be handled via PDC at all times. However MPM can only handle interrupts when
SoC is in low power mode, it does not have the functionality to detect them when SoC
is active. skip_wake_irqs differentiates this behaviour.

Thanks,
Sneh

