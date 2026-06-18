Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D83B47C6
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772555; cv=none; b=sxMx4x9bVqbc8DbPfKNc0+X85nCbqlNN2z7wPuraYOmdunyBN9RpvfuiMCtUVgZqB3ROGkbDBG/XObDCoOMGGqGD89YIUWmnt10UaNVCoQErUpSaup0YOgvqbdAXjovdgqmexE7XHp41xB6EPVpexk4/1wrLwr+rJIcDyb71mBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772555; c=relaxed/simple;
	bh=vwZ3ox+S8EieIsKYJeZmQbcya6G6wNYQsljtLPXCGxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBOc/PGE0voJHMUR2wX9bNlmONF4UUuvhYU6LMdBiEHPiN1H9OJZ8Q4cVgk9gluePVJ/mbLTnrKXMzNtlZ6yZBCKXi+c7/ctitL+jDeFXrg7calqkKmXlMoL4pVVM1NcknRV3iuKXVyT2jAeyTcwRBYfd2Y8IK+eN89fCdB9Lfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K7/9yTiB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eLaoBEDe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K7/9yTiB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eLaoBEDe"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8G1j51157459
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+bHBfnOAx1pzFWwgZXfmA4+mbnnhL+GXgdNbrmQVFYI=; b=K7/9yTiBl5cqHQg5
	fvVraopTRGu2bBf6exdrN6Q7F9Fewv2IYgq2+73Jjjit2s9x5kQtkAt4wsxSL0E5
	RmAwUof+CnqpAOVBuQx5P71IDfIrK4eGaza1dGlDUYlpY/vYvXj7C3mRNSeDexNG
	XrtdMpLDxPJt9I5XhfTNRO+si8a+LumH2ska9EZNN4339ySmmwcAoV+f8S89yXgF
	TdcmVzq0gHX8+yCEGvLrK0JiFuDdoFXunCj9w473ozI1NnK4n/kPDU3MEOs2jL3c
	qxdZyGf4ZtqbkCjdg7HPuCHOzvk0rCIzJLmGGRNP7EggezpZxXWuJClP1r8stgm6
	Mz/WjA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a2kqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:49:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9157263095fso18970185a.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781772553; x=1782377353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bHBfnOAx1pzFWwgZXfmA4+mbnnhL+GXgdNbrmQVFYI=;
        b=eLaoBEDe1w4x6U2m/1h+ntxHFwnG6AZwiB/Cgdkq12aC6TvFE6V2JAXXqXpAOGJ9M0
         5tBrSKytprmobrr/gct5dddaywFh1Jd5BeWd/Xxev2BgaBN1ZWBZ70bCCYAO07xiSxuW
         RpmNd7QHGzCQjUdvGQOfhrZXNYDczsQb9S+jvLzyMtfBRfJ2zYcj7PonXVfKMjAQHysX
         3+arkQ2UpssZltjpo65Q3j5+fNeEUvf5/E46LnrKZSyx4pp7XZgH0bw7k247hXqwFN7e
         c8QdfO3LGSZjbM0aMCeUdRgFyV7kZFWjCEVe+A3T2MWD3QWvwu3yosXEP+c4KExtML53
         ufww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772553; x=1782377353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bHBfnOAx1pzFWwgZXfmA4+mbnnhL+GXgdNbrmQVFYI=;
        b=oN46+MylRgMbptoLlLeZenvu3SL21buPQcmaqYpc1Je526omPX6QEfgD4+ot4zXwGp
         RN3mabbytVAALydkP5CRleXju3hz6Z5RcG3hzrOsZjDR/YwEr/TDPEoLFadn7eCQNTF3
         IOTwYPYGx7VeHaoPHtQ2rTcF5saUIKdpA+iY/dbA6hQeo1sKI5gN3Eesmfwx9EQSvZ0J
         yL0XG4b1p5iT9v689r+2NQhtFnVZ/O8hkrPPW1T0p3AIEIj+O0H8Z/CJeqlY2nHEtdn8
         aEBgmBWsYfe9OC5cDN+6LKCBtPUZWwZaLL5kOSxrm1nfsjDq12pPi8w5mU8PbMu8QTSF
         zWmA==
X-Forwarded-Encrypted: i=1; AFNElJ/w2VZPySXVb1CRRTAYtQBXynK49KU4QH8lA6tU10Ce9AEP9ekXwykWBg8vl6CayLdcydprbh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1z1Tg00gIap34DkOPXMN2RK7sNm9UbnvBmQ8C5PrkGdcVBZU
	efLTuVfgzQdS8fHKzeZS6oV2/eKqw/euamhoBzUmKstj+7I9x8gQ82LTdOmAb1ab8KyscAl8Wct
	Flc16GGAWhBx9nGop8jpXGU1pzzAKOwPWDzwfQQRJJWgE0Dy6AmYL2Y4PR8A=
X-Gm-Gg: Acq92OFY9vZP4zf8DC4ZD3xVIK3dee1HMSpRSuKR8RXLQrNLff7dqtDeCL0VgepgprH
	APtyDbkxAJnNffpetbTFEPeCCHexqaVm+Mltv5dut4W6Hn47V1akjvuVNSsKzz/P4+yosE7w8uA
	bY0FMi/2cacYLQUWym7IPkpWKtlARbERTIm97t0e42Nf75wXqruTIYiRpFJrajjy1tsl5MJrGb7
	aDCu4SI0cGFsZ2+fBUmKOs+BpU89O02Hxkwy4BEkfZEqKrOyrCyZixOqnvpElFAFaIz8HIX3ZXj
	jEvXyPBo2sETd3AgU+P9lHEcQwppb+wqCmwlmjijGDc2TS6zB8HoPUq+qgWG6WQ4fOKK4NOky6h
	a5RJ3LDbVffYY/SxqHSbQxzl/NmXWXMyyGEI=
X-Received: by 2002:a05:620a:3910:b0:915:fad5:9096 with SMTP id af79cd13be357-91f2ba5e3bbmr276505785a.7.1781772552891;
        Thu, 18 Jun 2026 01:49:12 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:915:fad5:9096 with SMTP id af79cd13be357-91f2ba5e3bbmr276503885a.7.1781772552496;
        Thu, 18 Jun 2026 01:49:12 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b22544sm897196166b.14.2026.06.18.01.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:49:11 -0700 (PDT)
Message-ID: <d9e778ea-8a67-4576-9c96-9cfd859a266a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 10:49:08 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260616-enable_wakeup_capable_gpios-v3-1-fb59647d89cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a33b109 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=rd1qytcpxr8NqP3Khf4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MCBTYWx0ZWRfX56JBYjpj9fbD
 w8GYao45XRr1v1aEFyxRm/GhHYy3U3MFEHqAIh9VvCEulKUUGPJhH7Qz4bI2Z0uCvzTclnrbBxW
 8wXJ41k7IhLJfRVJcotaesMOUTBafes=
X-Proofpoint-GUID: 7wPwHLHXoJCUgVIQmutXyA6-YDm8M5f7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MCBTYWx0ZWRfXz38Ljk41dbHs
 8AoJF/eMI4qWx2Af01mnFcbaO3Lskk13rtw/8F8ipTDK03MypYojw+atcsqsAuWyEv5KqRbhdC2
 dPe7/BkNXWslF/PN+/u1yoC0kGWux7vO/onlVZ+vNlyCIxoOEEUDPvWrCmzGPwSfknpcuTqBr5r
 NRCD3tt9vm2mMRticg5Sp+UAOVhyJEM/Pf3FuMfKZ2fzL9PqA/lfzS7r2SnEGT+Wa7K/+8DnRSW
 ZF1Tc5uHgjaedb5/wWKgRcKuNuCSLven85hty6SPwSN2f0Qe3C2kJkHPv473lMBUtCqmJSaiV8x
 NqWRRQc7jcO1d15yJXmepajhy0VAew+1QoiZFThBYeKBkTiSg4TO5UjDp/oomZ5zm8VxwLzHI/k
 xuXkXCbl2EkeW9fvwjoKNMCiCvob+O24C8GTbcAE7PLWcrHQwwzNinnUxyOdwVl/Yz6ONtCuamx
 cPDcw+n8V7L7c/ZOLEQ==
X-Proofpoint-ORIG-GUID: 7wPwHLHXoJCUgVIQmutXyA6-YDm8M5f7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180080

On 6/16/26 1:54 PM, Sneh Mankad wrote:
> GPIO interrupts that are wakeup capable need to be forwarded to wakeup
> capable parent irqchip. This is done via writing to it's wakeup_enable bit.
> 
> Currently the bit is set only for PDC irqchip by checking skip_wake_irqs.
> skip_wake_irqs is set to differentiate between parent irqchips MPM and
> PDC. It is set when the parent irqchip is PDC to inform pinctrl about
> skipping the IRQ setting up at TLMM.
> 
> However, the functionality to forward GPIO interrupts during SoC low
> power mode is needed regardless of which parent irqchip it is.
> Without the functionality it is impossible for MPM irqchip to detect the
> GPIO interrupt during SoC low power mode since for MPM irqchip the
> skip_wake_irqs is always false.

This is a much better commit message, thank you!

One question remains - should we set skip_wake_irqs for MPM too?

My understanding is that no, since the MPM HW is simpler and doesn't
have a register for acking IRQs, so we need to do it from the recipient
(TLMM). Is that right?

Konrad
