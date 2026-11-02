Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615834;
	b=H7TJQ+TOesnQp2Wyc8EEJSNpeo6rw/9+TPVl2Iu+IryMTevhfvIeZciA45NKWYXRR4ax
	 Qh5HF0GdgINqBZ3MKqcvooKGXoGMgSuJYWdSVJ2+E4YPoRzgAcUw72tVGzLcKzEzWLpj3
	 pzyJtTHiO3ZUN9BeNhJF/NVscTbL8Ct5VLnfdt4TDYo6dKs8UZ/V7mOgD4X76SUKNx/Yh
	 qvVsCiLX7zCLC2KDCgL0BcxBmcGwSwbTM2JI9qXPJhz3utv+mGdn48IOpUIYjvaVXXVN6
	 vJ3S1X20G9xdZeCNqFXSD/zb9t+xxhZZ1mpTgv6BOofh8RAc99NZ/G0PMXPL1RGtEqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615834;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Uem9Sk5u5wAym4KNtUXWwa5Ya3q2ExNebAgCwip5iPI=;
	b=SeGSAIrQZI/KsqOTKe7FXac8RE9LjTuMnul5vrk0XkjCu4gM0W97SGIaksk4U+8+6S+g
	 oESJMuMFce5xiWmfVzQTpdJB7DpDqNVAKzZ0/bjHOeIGhpE5I5OCVMf8l+DslmhqstivM
	 3T6UXes/1qfEGeQCiDybM3lF4WBdIbn11dnqAXZoUfo9fyAobjDJLcb3Z3nR2RVP6Fj2H
	 51wOR7B6hFYZUR38u6BhHFN/cOu/DPQF1+XJ5e07sJ4JsN8BQufcPliPrcY2nhVKqV7wy
	 KvaFVubVxbdhMyp2fd/s4b9n1xf5shGFNKmT0LBZUe15gveC5WwlWSLC3LSK9w15eyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EVu4uLh2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z+gHfoIp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B00606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B00606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EVu4uLh2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z+gHfoIp
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AOn33086539
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 10:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uem9Sk5u5wAym4KNtUXWwa5Ya3q2ExNebAgCwip5iPI=; b=EVu4uLh23CyAzH/P
	QSvqOGuYNbSUbidYYgRyPi/SyESPzukZ2e1DhRUJ4M0u8UlGHLy4dorkvTOM7d6D
	E+ukEU1SUF2GmQzTFM4vUJYtUcEmMchVuplK/4SxDn1t+A5q4UPnkXGPavMh1KB6
	6wJwZwpI9t0qGr3tqnH7NfBNlJbs0YflkSinRl2c6PLWU35Dy5q3L2GkRDceYOO7
	03Bz3Cvu2gmVrt3Lpnjx0zztTlcSZVneDhUFfBixop+x8/DH0J1qWUVBgi6guye0
	ukUmVYmdEh/hW1IfMpCiLmv4whOJqhwfxV1o0HhKgFppxt1ZlDFr76Zfr9LM7m9p
	C+CXjQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka61ce9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:37:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb7f9bb86so577810385a.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793615827; x=1794220627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uem9Sk5u5wAym4KNtUXWwa5Ya3q2ExNebAgCwip5iPI=;
        b=Z+gHfoIpRgik0K7mLyBMTdpSNAqu9Qb169VaZQfz9/Ei0oyOoqBA6163Pl6lyyTVmu
         cIA0lCAK9tKLMlVYOfHwXHOW9OmbxIxYMSOJl09gzfTiKaG2AJHtZnD1RKaDdIcsN7Wz
         sd+AOMmKcgC/ZF721BShUl7055PHI+r1N0OuZzAiXQHNH7g1I675rXbTO1ZmSGT7WJ3B
         b6wgnvOBsgzBAMDI98TxNdfNL+G2jp6LPdPVhNX0sswIJ4wY19owpgp2tKfAJZt/+rj1
         1ANUWSZmNlUQw6KopktZN+pdVGY5ppGcr5XxoaabkCaBVMnjFTXw8c+C2MfY3OLquWl6
         Vcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793615827; x=1794220627;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uem9Sk5u5wAym4KNtUXWwa5Ya3q2ExNebAgCwip5iPI=;
        b=Ub5w8A+NzP67E1JB3UnxiJOlmexBDXDzSuyHKHreailjAjXA2D35YVM7XZbGqDoq4+
         YfODaP9pjNy+t3MMRl8WWpx2CM8VKdk4AnM0mGZATEbFkKQxum+8MpiAf0NVCpBrz7o/
         ayCH9bgeLXTxmV61mGIgqd1/f4VCcX6XHnw9TQGbRFegsLj0KgOIf4GaXqgeADioT/Qb
         JbuVBhqfqYOMBrs1jfKxwkoF80C5q0w8krJMJHFud1a7NGNOBbsDd9+lzryJN2/BT8fD
         F7y5m6fglPkqfnkOmgdO1OR5HlriNS33XRCjKSfNkE6QXkD1NfWPF2xHkumdfaBIpyuG
         1grA==
X-Forwarded-Encrypted: i=1; AKwUvBwwmpKPe+2O3R/oRUEwBRjoEfeOaSNW2i6kiLRMffYrgDYJ4FTLHUokr0IuXvhqSKDyuhYtx1g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLm3cQNJCOSKTmZ0gsgbS3TCw8UKcoVZIgjjSyfr8AQfxbuaccE
	igm9xCLC4rN/43/Idc6TsXLxVL7zI6ef6aTf2vQZ5gv2tzkTmtH5kgXN7s64haFwHMz2zjWt2PS
	Nv4NpTED9mgQxmSvQxVp4odb6OINPzGafNeXoXDkZ1ZR0wZig8C1HJ36B4/MwEjsMwE4=
X-Gm-Gg: AYBFou3xYOey40se1an/OeHUllb11ip8ARe0l3tvCS5Tj/PZdmx8xdgofwXY/8+p8pK
	B6xuxd6bvae2ADhB8cqeQ4fkwNWok1wxjUEkdn9yXrPuq31wrtwUJhVYCquFNPQ3gkTFtqHICo7
	BS1Mg5tiOn1Bv3C5Us9/8Z/KyuGX7uh+sUbVVysdidIvE7TfrIcU0I+TQ1emJxfWIkeuI+FPySE
	HoUf5HkqgOLBLm/tmtuh1kGjM+Bfs20cidj7liMA15E8QJMx+H28Jcx+vqzCmRrrCz49MbweNfb
	Eu5L47yz3L8xRLmSxi1FoGaZe5ow7GuuiAccRWaLcWXSMUfM0YcCHji6K8x6s/Dp6g8QSrC8I3f
	cYvNb2VKxmfy7il/HbwRyGOgBMENhwRIiVNAT3AnnzgI9GM2e13CQu0ln+bp4CGhu+hCl3x5Gvg
	==
X-Received: by 2002:a05:620a:6406:b0:93f:2b23:4820 with SMTP id af79cd13be357-9442177e71bmr1490845785a.48.1793615827474;
        Mon, 02 Nov 2026 02:37:07 -0800 (PST)
X-Received: by 2002:a05:620a:6406:b0:93f:2b23:4820 with SMTP id af79cd13be357-9442177e71bmr1490843485a.48.1793615826944;
        Mon, 02 Nov 2026 02:37:06 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm18907414f8f.47.2026.11.02.02.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:37:06 -0800 (PST)
Message-ID: <cd3f4711-50cc-4a0d-9f15-455cec5cc1f4@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 11:37:03 +0100
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
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Chris Lew <chris.lew@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261101202404.156522-4-krzysztof.kozlowski@oss.qualcomm.com>
 <8f91b302-8cbe-4bf6-9558-041ac10f4696@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8f91b302-8cbe-4bf6-9558-041ac10f4696@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Z8gKgNqeYLjZgRFPFZ4hMok1KOVc_MQn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MiBTYWx0ZWRfX3lCe3L4MIq69
 41qidrWh2MKt1i8h4Jh2cXE7gcGmgDghf26HZS6AFwWrzVOGPwEyyHF35nA7svlQ7aq8IZrAzqu
 OapK/YmX/G6ThVecOXyoX7PIbVig+wY=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae867d4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KI6MEPFJG_Ll42QlAT4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MiBTYWx0ZWRfX9q08x2NaJmS8
 q+NMx+fuFqI4O6L+BohcNN/pdf+0DDASaRr8OWm/ZyHucstwJo4qXdVu4CPteHtuarf90MB+cAW
 wpVfe8FmkSxjpzqwoTfSrDsOsa4D2Ew9Lgd02n2ZFbr324RAIaGXu6Y6mUWTvH1xcQyzIv50vIO
 1ZgjiU18p0H+slrVWn1l62b2xEFIHC2CnVwRqQ/2/J8h5jf+1SX6qO8vUNoBL19kHPTQAuwSCpR
 dPrraITCeQvElVRG7iWFD8hN0HjciXahyu31a7GUrfq7PyJY8Iom6QS0b4COFLe5D0so+SiFRPa
 TFuThpDP9ay762Qk6/Tdhc5gd6aQ1qDWjYlk3u7sbnKJaBSzF3w9Zt6WkagW7FoBw16mlCpRt3Y
 oOgNmd2yy5C0n1D1HtsViS6ZPE/gdExa6tEXe/GlYdzXGElCyDA6BDuDaiiT17K46qPh0+CElt5
 KIXencByF2VsOlpFzXg==
X-Proofpoint-GUID: Z8gKgNqeYLjZgRFPFZ4hMok1KOVc_MQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020042

On 02/11/2026 11:28, Konrad Dybcio wrote:
> On 11/1/26 9:24 PM, Krzysztof Kozlowski wrote:
>> The SMP2P interrupt is requested with devm_request_threaded_irq(), so it
>> is freed only after qcom_smp2p_remove() returns or, in the probe error
>> path, after probe returns.   Both paths, however, explicitly remove the
>> inbound irq domains, unregister outbound SMEM states and free the
>> mailbox channel before that.
> 
> Sashiko flags an issue with this one

Thanks, Sashiko did not send email about it.

Best regards,
Krzysztof
