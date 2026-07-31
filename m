Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833333A59A3
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495774; cv=none; b=KBDqfcrezh92WuvdD8/2WLnT6svO4ahKS/8koPStUOBnZeg/8U8x38lyEWZxLH5wovXrNbE5ZiX8+Oo8pUhH/UseJ26GBVCKZwPp2m8qfUgWGOP+xIEkr9qlmATIjE9nCM1iG300c+1cQvTPetCocVaIcKNaZ6PXFqTebK1iWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495774; c=relaxed/simple;
	bh=kOOmbLFrG8QsZwkEOkrXY4yYRRBcRDCtei1KlyOaFog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZd5dK7WQFxyG+6O9/f50R7/Eoo4geYNb/nsUylfnyYwTCWNZRjnFVM2BuI0wyrc/CbhLXRjoZj5V9n3HyTXpvbwTGHC119EVaLL5YpTnMNzy/aCDji2QvnBgjVHFBm0rG5vz6lTaa4iMCP+udP9pOPBYccu/1Dka0a/cXox+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HwiQ9wyI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hHMKfKQv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HwiQ9wyI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hHMKfKQv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAgoJX3669756
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GLY9j9Bk41aAiT69kbw7H9yfLznQqyIDZa0bLbpKQhs=; b=HwiQ9wyI4kUtSogO
	w0Ia0DA0/+zGXersKzKidABSr6xm9ehcho3hsRW6Lr8wSYDmlGsB/C+LYkNE4I90
	8Z8TNpGnhtf17noY9yQdM9VIvETkgkZc3g6RInUt/vlMvWbLwtbuJM9lgE45Y9Tl
	C1jLNB+jdXpyrwxZI7s0EVu5mquTghI9OUUDbxQkYn/V/eQBxkBrWq7FZQ2ieaYJ
	kClnM1TuBbmDJ5PBI5HcoTEIAxiL4LQTEzg3Ubpu/E60TGM4bEV5vN6wn1i77YhK
	YzK8caDKz/lVmDGPHbjCQkRKzQK6yNVpzgAsHWxtvYfAK57GaUEjXmTDH0tFjo+7
	/B/Otg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frt6qg2cu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:02:50 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a442461e63so63350b6e.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785495770; x=1786100570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GLY9j9Bk41aAiT69kbw7H9yfLznQqyIDZa0bLbpKQhs=;
        b=hHMKfKQvOmfHG+MUIgfDwyadSRt4lBkLkYToViTCcIzuFsVqK1nJUHz3GircyY5tGU
         6WkJDB9hMPwWJL1PvH/LMYgiepO0zj9wt65cZxS0jr5iDyO2lgT57cM7AD20pog5Uio0
         AZWE8BJRR9W/7cVEY49iQhZaj5Ti7IzfWhdsp8a6UZwj9EVgUY+D8TznaPNKrW1NUjTE
         sZqJZsYtEto3IEM/UOINd1Wjb8TkVblCq61q54XLb7b2dpTGFeXOUrbo/HSH91oNyHtG
         tXbhLHwx3f+koAgnaayB/dn6gv9iZ01bZstzu+r3nxX1x2Uq3sGU5gg813mLFNd2pP4Q
         hahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785495770; x=1786100570;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLY9j9Bk41aAiT69kbw7H9yfLznQqyIDZa0bLbpKQhs=;
        b=Q09UGmU2kQOapaYTHzjJpOiGajo2aDAmootnwVi0Qhf+F/hSuzv3V8JpeQ+JAoyd/w
         SKZYixaS/3cCZ0ZR+o74eXjWrCWblFVW4KdBHUbPRr9rtFPEbGDXIdJu2mCPrt3RZRyo
         QXfnSXMtLmgrbUCIQng6ePEFmxRbdTo1FNzxFWaEF8zvjPSdPC2WiGXVEkz7XdeOKjhK
         GBrE5MfziGaMSeiampXLrhJHyAIcX+UuJc4T5TclXlDrfl0eRBlarG9EGyYBc/qpm490
         wlkvB7gVI09jFSBFxrdAlVJkiH/mUiPM3ka/jLrFCeRprZaZ9onVgQcc2l9NPrLhuc2o
         +JYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxGc5j959mIrEWCTqFs+xMyUZq134anU2iRryIfEixQLk5xjjAypUcR6OMbTRGsGXwnoyYlc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtKJEgbNhMJQpFRXpO4wXu4oNtdOTPKSszMsTeT7hObtdcoIe
	1ju1Ids5PsaWsBdGu9DyjDvHPOAT25SzH4ZE/xidRGzCZQVvdMtg+diU24AemUvZAPcfzFZL10c
	fWBCuJ7j4rs0db9afbmFZRmCEKYJZkdxAcQKVAGfmT63j6D6dlCzVof3dP8w=
X-Gm-Gg: AR+sD10LP1qwycIt6ahsvaabmr6Ox/Tv46F4cL+3SjyLWH0KO7+8PVjQK1arcry1B/U
	9/9f4FDbs3sC2+lnTKU15k2ipD5+PP9WvYzvAsHDXgxuBqgN9pMxk8bkYQ0jxZ/0shdOruS73BC
	lAG+zYPYTXkIdzaXHiuenHm5gJLchZZKqC2ctU99ulnzhiGkLzdNWjons9BkXuAsLi19f/qvlNE
	kE41sZ027C1DfYUali7U9TJm3A6roNnqwDH/dhKOmUNpsCzNQyHVM4nlW9Qz1IgYv1KjCSrTyUd
	Y3umQdMwzQF+3L5WsA6sw3D92A+wQnI7PXc05zFdJP8AFuERiw3AGsPocAkDseen7wSnZlwuuKB
	LTr5/jyfRErD2YgHIorEVWDcM
X-Received: by 2002:a05:6808:15a3:b0:496:d5:7b22 with SMTP id 5614622812f47-4ae4c44f120mr1014189b6e.1.1785495770106;
        Fri, 31 Jul 2026 04:02:50 -0700 (PDT)
X-Received: by 2002:a05:6808:15a3:b0:496:d5:7b22 with SMTP id 5614622812f47-4ae4c44f120mr1014178b6e.1.1785495769744;
        Fri, 31 Jul 2026 04:02:49 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b0fasm113417766b.5.2026.07.31.04.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 04:02:48 -0700 (PDT)
Message-ID: <96246a96-31ad-48d8-b32e-2c4df5830d96@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 13:02:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix use-after-free of
 battmgr on remove
To: Fan Wu <fanwu01@zju.edu.cn>, linux-pm@vger.kernel.org
Cc: sre@kernel.org, andersson@kernel.org, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260731022006.317192-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260731022006.317192-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4MyBTYWx0ZWRfX3Lh/rVpuvcPt
 50FGQQy12hWvA8k/PwtmOwVJRYgr7ogPk0OQAGVEZRUa864WhVYOSoqN9mdTHy24zpQFs4i/OqY
 xmOur4IgWqZpf9qMxXeFk80EG1ag6/hq72JU4m2gxOHssPSK9WOnT5Rm5Lvo0O6Qgp1VmGhi6cr
 lPs97zEwHknYYHjgyWlXnrlwZOTBFSA72ngM0Ftznbp0xCBAWbXGNxzSb8+LOZ/fID4Fu7IZ600
 hlXP4ewtI26V1Pw4uqeHGdWwQ4F0h0PwmWwgd/yKOawbQMENNWiSSVnUxFGgmzXkOVnO+91J3N9
 7SPGwdDEurkLzFi7KJm1EkxeZ7f/TSaLpboPATsXRXP7Q/s8bty34Cw+MdGCIgxu0AJ/w9wBBKl
 6l9+kOXncqyUqAJMSeAxeFvFxeJhKI7MaFiLP2yNpJiWDMxmw6U1EQ4eM5SnAXaccUK/NlfmTrb
 YNMOK4Di+HUDQKkf6Tg==
X-Authority-Analysis: v=2.4 cv=CvuPtH4D c=1 sm=1 tr=0 ts=6a6c80da cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aDI3_xmd8nExmCF51jIA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: 6gGE-T_E2BD2mE8nRUuADCqpr7iBcEtA
X-Proofpoint-GUID: 6gGE-T_E2BD2mE8nRUuADCqpr7iBcEtA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4MyBTYWx0ZWRfX3deTj+IHJg/w
 eb2wQREabUU53jos8yGPpBeyxTo2Mf62ZWccpKazOgNcxSXm3yLdIAKM5PJtRs2xnNje9Nef8ks
 WxJK4VIFyI6e3oxzcVznjMC/kQ6IEts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310083

On 7/31/26 4:20 AM, Fan Wu wrote:
> qcom_battmgr_pdr_notify() queues enable_work when the PMIC GLINK service
> comes up. The worker recovers battmgr through container_of() and issues a
> firmware request.
> 
> The driver has no remove callback, so a pending or running enable_work can
> access battmgr after devres frees it. The PMIC GLINK client stays on the
> client list until its devres release action, so a PDR notification can
> also queue the work while remove is running.
> 
> Add a remove callback that disables and drains enable_work before devres
> release. Unlike cancel_work_sync(), disable_work_sync() also blocks a later
> PDR notification from queueing the work. Store battmgr with
> auxiliary_set_drvdata() in probe so remove can retrieve it.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
