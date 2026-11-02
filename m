Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615305;
	b=pg6jpdqEk9qfwHbyefupkktLvqO89tJuSE55imJ8+oPd7mi3fj2WIZtgdPVgtdzQ8jRG
	 4C8ve1OHUBF8NLxYIEQZI38E/Y/yRtULRIP+z10Bv/NxEdi1lWjsOBS1cXDkPYTYU/mnT
	 PkJkqp8enQKKokOZg8Eu1zQ7dHzI7qTkVVvghAuXAyXa7ezQrl2S9DsWvT+XgAs0cpVon
	 8XfSf/L2FFdXfxIzuppQit9qovGa7qW7ms35BfNj0ikfMf2psS2NE1EmopUtLtaPXrSdH
	 ztMmjgo/q0bN3jckWZg1uSz3dP5qoE0aWJiQQxCoAc4MjlFux/6FlW5djl3BurXRC3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615305;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aeUXDPblcIqwhdqPiV3Uo8oWImfFiygj0BnOsQpFNb8=;
	b=u7S7EgFf8eNmGEOlv80sfhXyCS2gxlh9C4hVbGEMXvpBHu41nd2GcStjsqQcwHETWChe
	 OkedGW+0+YlsAm1XPxYohJHSVEr9rFKG9ONh2YxRm9llXoPqIeBpbRHOFV1atyopY56yq
	 qVUaN6b7qMxEM25fQu7GVdc6AKAsXoKuCAYgmqOFdoDcn3rATuVgT4HhVSa/9WSGWZxZR
	 0AkiYelAIcx6+LnGOfZV4YqB8Va6/f5bpEtf6UC8oKU7/H/i1ouskGB03NEH6DuS+cX5K
	 pp3u9vuDy8CEeauBUggCU62Z7bzge/ZRI9uMzEkQaLoWhAaItvNFPEeXLqxtc0aJtFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZIo1zEkC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HaCor6Gl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397CE606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397CE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZIo1zEkC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HaCor6Gl
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A6IA213981
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 10:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aeUXDPblcIqwhdqPiV3Uo8oWImfFiygj0BnOsQpFNb8=; b=ZIo1zEkCsDGNlgIY
	e1lMX32ec6bSl3Zd6XKcPwGwHS36fI4Zu1NsHdlte7sH6f3BXJ850YLwepje7NZX
	5aNU+NsPEwaZbsbCwrpsruzzi42oQjQsZ/5Ya4f2K4jAxcpegrLkvT3oRSfPHLrP
	/mIp5A1TaLlTLdK1Ozdu1c5txx6oPRBRHq4EsAJu4uqwDPVXrTysAYqyZ//TTi8H
	m1pY4ZuZL42a1ZNlGRgxgK1fAV5Sijo2WkrOJaMdyhzRJFeILd6Hd51g1AJilPyZ
	UpYahcbEu/S4/JVUZ9q6E1ic/mafticeoYNDj6u79isqzEmiKDHyQTNk6RNBofPk
	llbKtA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1s4sv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:28:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f3960dca5so13819785a.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793615297; x=1794220097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aeUXDPblcIqwhdqPiV3Uo8oWImfFiygj0BnOsQpFNb8=;
        b=HaCor6GlqwnzxiG4UND7bgA2SoIAEUPJrMq8Xu362lgm8J/MlIReeooHn3AHTCcwyX
         UC2/nyUEfPsHIcjVmNAW559WnFCdN799L41m2oHnZb3P06/lG14OgVDqXr5lEvVaCA7V
         v+xE9opW3md8czQugfRLD6QfT/R1YnuxL80LGgfQV15vXgmm/8raSQkIvMQFkRUnNg2V
         gXXoU1F8ZSPd0Xt8fys3GB2ZtilvAuguFxZY0cJECb8ceVhxdmqA1u4pOC8oR0S8Lw6M
         WH41lL9mf/N54qn4uGmxJRR9jwtLRhXvI1cwaSeR9YCj1AaYPhZ19UFrdddM+BKp6bP5
         Nq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793615297; x=1794220097;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aeUXDPblcIqwhdqPiV3Uo8oWImfFiygj0BnOsQpFNb8=;
        b=pDQXLAxA4WKAiXnMy+1HG75gZ4dufw7XcQP//8S43GtCkaQcNcHEw+G8HCdnFX95Xt
         IzLGmMCXNB9zFkmAw8rvhVm+I9zA+0Qu8lkyYdiHDUve/J/hCQ6ol2d6Cznl9kWghbGI
         zFNggIN8jUTgs09EXU5SqD8V2SoehAiCjrq5jYVGve1xJ2N8xZKItcB7+V9TuqFJkku3
         +8HZpIuyuhC6ISdECC7wrx4trg5qTTuMUAPUnLCTZS08vNb/kWFs/3an1TRAG7nGwXEn
         DjKpbqKrIKG0lOoehmG9EpcUopUr1PFe94GD0rpWP57SfaAcxaXM3gPY0FrLQ/Gjg791
         99cA==
X-Forwarded-Encrypted: i=1; AKwUvBy8nBw+W37AdrmaAdAa052gx2G7A937wF06twsrHEqSApjjELyQC6xIGCTsAhowGyothZaCiu0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLndJttcLlqQ0z/eT4c5oHFGy+ju9q09yzhQVmP4Jemn7ZJYTCW
	BxKS6JcPaQipi5ggXCD9BkrA3ZAoaTVC18Fc6tC7m5cTqYHGNWvcVdoUdagyUwjdOMtK7t0dujo
	3QcS19HTT+aqtfMeDe3B+SKDxHh4geqIko1GnScVNuDcrW8MqbZ3JaUVvyVQ=
X-Gm-Gg: AYBFou3iD78eEO9YNNfNPeeenrOI/X3JfQA3NASP668xd8ML/dVfjrL4ArFpdAeL4O2
	HBfx8GbpXCMWkKegm5+nJ/mv3PKfLJta1CTzYaKqg+GoHTS7AVK/BSRxMq1DeoMa2CJrCzfU4cn
	zJx/Z4FdexB8+8jvRhaEL1tfNQf1qB8RiuKydWfl3oatiEA/Zke+YQpmaDZwqLar0cfosHEn96P
	uzPgkx+j8I+RnxcY/kIx9TswbwF+XN0s7QaS31671q1FDhCiO86t+xEZCpVjU210ctNXYc8200u
	FcReRGWV93Ptss1EztIHOC7ksE4gQSBd4cmGwJO8o/lSdEWUGctczylLzFq2VNUOFZy+Y/uXXmx
	P9TNGNeEfUZ93IYMr4ehV0qprkfOlbZq1xZP6KFy/LCPKs8JBIA7mxJ4nl8qeiOUXDhs3iLg=
X-Received: by 2002:a05:620a:a29b:10b0:93f:1a1a:2974 with SMTP id af79cd13be357-9442173715dmr1545381285a.6.1793615297390;
        Mon, 02 Nov 2026 02:28:17 -0800 (PST)
X-Received: by 2002:a05:620a:a29b:10b0:93f:1a1a:2974 with SMTP id af79cd13be357-9442173715dmr1545378385a.6.1793615296942;
        Mon, 02 Nov 2026 02:28:16 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe10055sm368851566b.43.2026.11.02.02.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:28:16 -0800 (PST)
Message-ID: <8f91b302-8cbe-4bf6-9558-041ac10f4696@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 11:28:13 +0100
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
Subject: Re: [PATCH 1/3] soc: qcom: smp2p: Fix use-after-free of irq domain on
 removal
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Chris Lew <chris.lew@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261101202404.156522-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261101202404.156522-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8SqzeHcJOjkco-xNPAphEgy2TOcuBjIk
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae865c2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=iPxsRg-7CK3qk8vLE2gA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfXw9JQq7w/7bAY
 fA25rFsyoGpCVa3rk18hGZbEOnUy890AXRsYs4OXGqa5QrkVCXi3Q1ijul6+mDHo3iFFGuXrpce
 uGhginagdQaR9bRkmRbJNnTpPaLSgXTsl93zfaZ1NTFE2EcAIEe0+Mj4eJQfHEXhRXIuHzFwCPz
 Hs2qhLFYeQ9cZGtIOtW43ilWKEjoJPb3XdHYyNcLNtiBz1HXriSuY4qTiug94H133JbnpmIY+5/
 Px60sUZoes33OLS0TCIGfCH9nF3up2LIwmwIq2QURPlx6njYp5/2wZQpGwjaGFVzCNn/PftdVxe
 omjFS1G/yI+9iTSvAPEaOxVN2wg9TNosVh4Lt84ygbVGxczP7yE0fx7mvzsvdB8xEnpECFcTaOH
 TBpKzjvrYLzs5VyKkHqb6o/2GWpH7GmsT5u3k7QZllj49mOjbI2CaBT06W3IPiTdXGk8Si7zeP3
 XqOShw7oFOg9rKGH/OQ==
X-Proofpoint-GUID: 8SqzeHcJOjkco-xNPAphEgy2TOcuBjIk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX/RfQGPD8awwG
 1LV/4EhFyzhb28uixY3BShGQ20vMOhJ5p++J/VyqgKu+169dNTy+5OeqCJi4yChmxrCG0Fs7r3T
 4xfUzq1fY0vI7yCGDcoP34uGoCeTUsY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020041

On 11/1/26 9:24 PM, Krzysztof Kozlowski wrote:
> The SMP2P interrupt is requested with devm_request_threaded_irq(), so it
> is freed only after qcom_smp2p_remove() returns or, in the probe error
> path, after probe returns.   Both paths, however, explicitly remove the
> inbound irq domains, unregister outbound SMEM states and free the
> mailbox channel before that.

Sashiko flags an issue with this one

Konrad

