Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626806;
	b=2WNStCv9wWaB2Mt/cYS7HTb7CP6lKWofDPuKqEDHEtXFsuVAt/zvPYOIwGrU4Ox2h9TS
	 Bd17e4TytDyUgernEx9mUK9uUR4LLPP2VlVggse6dsSqay/67MpvIhOOR0rpIjhiJuyrp
	 xgG2AmFEMLQltgqhElus+NATs8n4aRNSIfM+VKTA+8VGFDqVkQ1IOqnpiCMZMRCQEA0Vs
	 xvvC0IZ/rp1t8CQUjTIUJbxhg0P4GVrEWNMH0zP8A5i1kXHL7Qu0+09NmWwgOoc/b1Eqw
	 i/vQUDDbU3XJNcYIYs2yJPlN0L9B58iX/IJEuzAji7e34OCdkTl/9Lm8AafPe8xz9Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626806;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KIf4+Hyju7Y41HcbRBU7z2Zakj8G/vHRwpElmPeci6k=;
	b=O17DT4q9RlO7XcYNOY3agJGOCMfrPGI/0iGytL1bKIv/t87azB+aypN5tY0QEi3j+isO
	 6yTES+57Qhf6bJ3gJ7fX9lylJz3kTzJvcEB1ZOujD4asFfaDjD7bsQUltWp0pFMQsWL6v
	 zMfUkhNkcMQOV9FXiwXVq0IJZyWNE2yzCpbhnoDpTKp4jCVfVSNm0HF8Zylr/AjebwiVL
	 +kP/866xXpy2Clu8Odpy1mu0UIRf7L1Iui4M1ZRuVuKis3PrFArfpi4Gr1/X2TokKrnEq
	 GVxDcD1OIBhGdgAONFkHmNb1RYsxxDfDYmUK12y1iMQUaKt1YPiOpezcP9x92q4qB6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jj4Lun64;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ViE3HMoE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220FD606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 220FD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jj4Lun64;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ViE3HMoE
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAQS3364626
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 13:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KIf4+Hyju7Y41HcbRBU7z2Zakj8G/vHRwpElmPeci6k=; b=jj4Lun64U9km35pu
	uaAExj3y1GIIgJvsuM0V/FvV6FPoGuh1MaQN17vZILYbvJYR8gI3e3Vav9C6Ai1K
	IwrRijwwSjY92Yua0V6BsvHJXuYPGnPqz1OoG5dk2VGtYzhu8ty8oc+6qLoxRAX3
	Ne4fwOLujSkNlghItLg+qGbBseq4JLREuV303/9+Ps6WmiH3wq177i0fJmZtUdz4
	AgBcVODEqS9kk+sL/+T6Oe9VnfeO+JBjsfTWb+u6E2gz9KSk0ShtZp9cA4vPFbqO
	B01WadFAeHb/9c8QLnQlXmeyQCtu+DaQDo15xYRxuWcc3yFQEjvytORcaqq583Go
	wI/mvg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6rh7v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:40:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e49a1d3b1so733608785a.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793626804; x=1794231604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIf4+Hyju7Y41HcbRBU7z2Zakj8G/vHRwpElmPeci6k=;
        b=ViE3HMoE8Lq+BN46kGfNy6dfvxwSLjmt48ktgwyKWnkTFIaupGVN0WujJjIoRTZufE
         TJPokCaPwL+7z8B1PHIeB/hmS5I27svGbry0zfFD03q+IS+QaCRYPoJb2cpgPdU329Yw
         V4El7k2RyOGqLe3vpjepFQGKb4WKI/Imjxd1rIILM5A6B2NypWHhUbzHPaT5cm/gkcLQ
         JqhH91mFhTXw4ZiML7FGrYxDmavih4EBvgWglia7EWd6ArgwQGpc0+IXJylwoSdaYYHt
         /JMaldB3aAiIagneOwMmEVtqyTTTj2wOQR16CT/Hg3FFoLpuhp+jZq3Uu7UeeGILNyrp
         eJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626804; x=1794231604;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIf4+Hyju7Y41HcbRBU7z2Zakj8G/vHRwpElmPeci6k=;
        b=grvwdH8yfMM1kyws5GadX5Jgej05E5/QPyaCTvy5GaEyaIXpixYZIEtMG7kQur57ED
         fq17Kgyva0ML1kadA2AhqKeObahG9Mmwo+KegkAhu96zYY/M/wlUMzLoW9hEqD/mbG1c
         eyItsqfkEmgWhtKZWWrjATqeUJx5A0i92F3qhtYWgAfXYlCVMVe6F4cPLrW5Icb+J2Qq
         Vw5uPCEXWZrJpmoMocNCsN39VkC3Dq6gdortLahFx7kdREn5DvzngfTPgiLzQusJ1lOy
         x5dl8yHsVyEZIa1DTGY/XFrAuFomLxAE7PCsrUjZsheLKxNqqzr39RU1+uK835GDjvo+
         efxw==
X-Forwarded-Encrypted: i=1; AKwUvBxuPbp7wpCf8JXRHSSLLhc5TsQSUgvxZoi6MiJSF9D5pxwv2/z7v9cboW7tPSt4sf6CczYjO5Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0lNs5AILzgaTgo6AGlLBCRadKaG9HXaeoQI12M8Rk3y7HRe0c
	ocpkI+pb1hf2tEAJX31bBR9DsfX7eJ8twy3ZJbGgcZpp2qtGSwnQvlWG4aGqWePTZMuyTY9fNnO
	rQkbi73BBF8KuyjdOS/Bux4QA29AI2C0OtyUFu44/SHgBEscHSZKuhYp8I3g=
X-Gm-Gg: AYBFou2qc85/ZPeAFFGQLvfp34um6chDngwDez8/QdrsIhN/pfmnNIvMga1Jsn33l2X
	J4crI6ycX6+Ok6SkezEv9uWW4RTZkUgf14CxGcG5khFttGS17i+efEWRbEWx8Z60ygCRcrRHlZW
	WPu5j27spvIvcEXHEIBjhg1vCicAiJuPzPL67sQ5sgu75M5b6DiLG2uD463a1yIQyCUJ4r6MzWA
	9xNKRv/Z+6WoUt2R4RD0avLe+eIUtXGZu1cvM7ClxsS5AMTkTjpYb25ZgScmkCqhbApLjmTFEc0
	gRdVhBax6EKPjLwc+9dkmKboSAPvO8UvAuYMD6Y6eQoamocBOIJ3ro9h7Zc1X0DiHpYS4ZH7mD0
	ixHInVjD5H5qUm6FJNq3unxjnYkmhTvVWvuxP/317eahKcK+2Znou1LujmRFqeiVEVKoQm4xcJA
	==
X-Received: by 2002:a05:620a:2614:b0:93f:baf:279e with SMTP id af79cd13be357-94421588032mr1733671385a.8.1793626804259;
        Mon, 02 Nov 2026 05:40:04 -0800 (PST)
X-Received: by 2002:a05:620a:2614:b0:93f:baf:279e with SMTP id af79cd13be357-94421588032mr1733667385a.8.1793626803802;
        Mon, 02 Nov 2026 05:40:03 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aab10sm266325425e9.9.2026.11.02.05.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 05:40:02 -0800 (PST)
Message-ID: <03698f9f-2e70-4e64-8290-84315e54a5e3@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 14:40:00 +0100
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
Subject: Re: [PATCH v2 3/3] soc: qcom: smp2p: Fix possible out-of-bounds read
 with too many inbound entries
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Chris Lew <chris.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261102133531.173434-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20261102133531.173434-6-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261102133531.173434-6-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX+zwLeEtrZ+mV
 FRr414WXb/EQkj0TycE90PzP18M/LFb7cCI7pS2zAoOGVIloPVCf5mcCKqqIthpYAttT5bQuMV5
 ct4VhlT+RAYcf8qc5t4qCv2V5Fd6JCN4avQoM/x6nJiffmpFW5sk+mSiN2CwjavSsDCwwY1ZlIF
 bfAm1+6OEGM413Km0uLnsnL3m0sIhKthmkPR2JN/BNjUJvcVq6E45DzylkWOeU8ilXr1xsDgFnk
 eEzl3NgmBp8WObpBYGSaNwJZ/nXkBRT2FZKy5E8RUWDDb3I9p/rBlClNVayUl9ywZzBXQYdM0lo
 oyMQ9DZ2wpjnc3inUV/f3SH5kgd+gCgOY1/RwXKPSexMLVAPevAx4AWztApfns6kUeUgmgbgybu
 HatkK2MHc659vS85+q4k5E5iDwci596vlIHzPFIk+Bg12uBBFYC6gSu0hr1JW2Zt4bVeH9Ct5+t
 bVIEzBI4SJ//df/Y7NA==
X-Proofpoint-GUID: QSFDLdmNCTlOU8K-Z6KeRIAriXvrG6Wh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NCBTYWx0ZWRfX4v26F5su4JXq
 Ixux5GrnduxBd5/Zi6u3KIp82Yeyu+mCF0V4jRUkYVUpd2odM8+tl9OsQfxJE8bZ3WpsuhsOELn
 lFGaVIqKJNxaL+PDPfRER/TycQOEyrs=
X-Proofpoint-ORIG-GUID: QSFDLdmNCTlOU8K-Z6KeRIAriXvrG6Wh
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae892b4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UsLgiRDap3Yzww6lrMkA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020054

On 02/11/2026 14:35, Krzysztof Kozlowski wrote:
> The inbound SMEM item is populated by the remote processor, so its
> contents, including number of entries, should be validated by the
> kernel.  Number of inbound entries is directly used when iterating over
> inbound data structure, so if it is higher than actual count of elements
> in the data, kernel would read memory out-of-bounds.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-b79427c9-5d22-4b48-8ee7-1d7808101e52
> Fixes: 8a9a7b9d14c2 ("soc: qcom: smp2p: Add irqchip state support")
> Fixes: 50e99641413e ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

I forgot:
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Best regards,
Krzysztof
