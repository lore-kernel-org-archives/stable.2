Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739844;
	b=WRe7YF4eLYTCHeLswX875j6g5kAHTnvK/vOs5GP2cDhfp7vglS3vmdVyxjlElaRiolAI
	 wEufDV8ToMqGPLycnS1KufNby8lMEJt4uG6wKVD8BYYYJjY1SiY1GuCRm9l6I9hKUObw2
	 QfiZga6FcB5O9m0gygMiIDozXHCQeXJ5qKa5SljJW0cFhOhRB0SAU0GbHWlgrvi6wZb3K
	 kt+nEmZSdGvcZ1WvWZaQHtcEDWAzECner+hB3/CBNiIP6vIL16mkvVSNyacMjzu0GjNHz
	 LankUfCxm7KszvBJWB2gtrRHogIqx49Tmvp2p90KqEx9LSb2tLJh71ttscRg/tpzLjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739844;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yop3kT58qwR/Xl9syoWFG9U+E8lkKWEQu0m0TSWLIwI=;
	b=sOEAEVXX7LVozgS5KzQ80mTqLTrJ0MmV4qTFwJi82jovUStFbb3Y3/TdZJSIWvzML19N
	 2iyEKG1I3IUa+rQA4K0TF/2O3MazysmPgVy/FOU4F9s34B6K8ogwdwTBmXLWlR9SK/fp2
	 uhftOToaWIwyNB7iucXv6qRQt1XugiheD6yRU13QLJmKLZdvRdsU78cv6Mqkh+AzzhV1s
	 Jk6vUo6b631G6nPbzZcw2sUzTgUgYq7thFFqz588OAeDq9xTBvoeGYnVAcuwfdt0re1YH
	 rVDGcYUuJhL7AE1L+4npV1yaeSrpbq5jwZutmqsBMTebmogzQD3nUEZLTQ0sEfPjBug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ijrvIHpc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y3Yv73kt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0D606A31E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB0D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ijrvIHpc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y3Yv73kt
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF7wUSt2140658
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yop3kT58qwR/Xl9syoWFG9U+E8lkKWEQu0m0TSWLIwI=; b=ijrvIHpcx1qBsm/w
	KRn/rKQhmJIZZITCLfJn+vXLjrNa2aSnNocDk++/FFjH8WFcKFnJZmvTkHV8phHo
	yAZRwMNRh8D24gGbCJKSGCx2qfN5ykE5WBjtaONIySRe4rV8dn66JkE4coiUAhzZ
	r7uctxYvOOLF3Bm+DaVZ0IcWMtcIEMIFx0CfvnBkAf+7XXoeTB4ztux2iYFKSjoN
	C6NPO+7OQoB1srHqlrsVtKkF7JTCroj6nK7BNo47n9V3pNhnN0x36cgRf0O32VFD
	N1ioCfIXFOPcve9Ncw6f0cq7I7BXsrvfrHtPD76rptnj1/vQ0MzMKT4WI9y8DJ9C
	eDJosA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjtw7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:50:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so667509085a.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794739843; x=1795344643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yop3kT58qwR/Xl9syoWFG9U+E8lkKWEQu0m0TSWLIwI=;
        b=Y3Yv73ktyBlryfyygYNaH8G9mu7fuR/HKeKj/XBwmDXFnjO96byQy3FHuxR6xRs++2
         ts3CuhlfLUUkr9QwiXqU4FBcY2Nj5EvVAWnV4Q8Z8AEloUeYD3HjVlep4OmmoAI5TI/5
         F9TI0UzZO2VqCdQ+Gfckvwgn3F0UiGO4hxrmwmj1hQRufmZk+Phi2zYrpKP44yr2gX81
         58WC50y80efXQjIaG9lM0V2WWdNhbF5P405sU4XADsFiESbM0FrsDTP2Yrs+iHAn+6Fm
         EXu2ZE+jwhiGZlCWOEHiQOuGi7cl8R1aMgQwQnUe75amxrK1gJLrIX7mDJYUo1EPZLB5
         TtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794739843; x=1795344643;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yop3kT58qwR/Xl9syoWFG9U+E8lkKWEQu0m0TSWLIwI=;
        b=KeAx0YlzsbRnr9RhhgaTuEQHrMulAFlUt6P6mu1bhOARZSveZQHPF5QqTIOGHDMAP+
         GtX0tlNdRzs2cFEfa/rRe0I75MuTllDGCPDFMHAVmODyP5sxPuGoa0GwIO/CssceobfZ
         z73MUucgujqVR2IKvdqD34Ykdu9vvt9mlTVdowwUA++n+u/qLCZZUFKbfQEp0dkhv5BF
         hZrJQNGUOFkivvJN/TORY65k+gyp4STK6BxmzVxCTSbq4Kes3aZIh8t/x2GR5kM4B8dl
         Rkaq5C8b9iUa1WxuTN/gSfwye0h/2Wg4A31LdjADieNR1+jz2HKbddk2yMjg8r+SYABI
         qg8w==
X-Forwarded-Encrypted: i=1; AL+hErEiyxuk05GsJCfdGX3rc0F6HSYpYzOzyxeSPWtAq4+LmtT5hytirSBP/gfBA0EYoEWrLIw6vXM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dZZTjY9UkisBoqB6U416lk/8/G3gD9+Zk2wjE7fNRRorXtvU3
	thQqfcX4NuHpq5YH7+CJOdNKtn4kEuk25PYN8AnLCh9nWiztH01hGkUXqEwm8O5d4DCMwWnbX0B
	xaZCm6/NShaxNgv4xdAJg9EZ8bpN8XKbEXxtSxwwe8N+DZ5EM4RcFo8XER/Q=
X-Gm-Gg: AYBFou2BDq6/G1Fudox1G5vh4ZnMi7ELqQIPWZIDkcUVOxD1U/wkadPQB231TuZ76gQ
	BVDSv1um15t7WHnWYqEn9n4z/jPuqlAONalAJXiV4qmlagW+zKsZ26tEjzOneYiQYd2NKTsTvXu
	YCq9aZpdFBT2e+qZe3HFwn47GJUsX3tLq/4eyXZ3H1K6kXjMXQoI+wKSb9hGtI/4qVmDHBMRiin
	M4Xh3uHVDshJ8XMJTU8iQKIg4ovKOUioazmIzN54h2Awhyb89P91gwWOkFKYbCxS+A1DhMOyi1J
	saVHdjegVxTbQR/o2mCYq6gnUSOF7e0/HTpqalg5KTtQ4TJ6YifOa5k2iHf4xTE8cIeakTm0WKW
	kTH4vFwE/yQgyLIJkijDbRHnbx9JZbT67xbyzGJIJgcAf4oWUPzaQTYBLbAdaZQ7JYnfoUh5rHw
	6vQl0sub5oIye+yBAgyA==
X-Received: by 2002:a05:620a:1a04:b0:949:74d8:4713 with SMTP id af79cd13be357-94974d84d61mr209325585a.49.1794739842839;
        Sun, 15 Nov 2026 02:50:42 -0800 (PST)
X-Received: by 2002:a05:620a:1a04:b0:949:74d8:4713 with SMTP id af79cd13be357-94974d84d61mr209323785a.49.1794739842409;
        Sun, 15 Nov 2026 02:50:42 -0800 (PST)
Received: from [172.20.10.5] (82-132-234-47.dab.02.net. [82.132.234.47])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c2361242sm3272377a12.12.2026.11.15.02.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 02:50:40 -0800 (PST)
Message-ID: <f8d9be2d-b8a3-4f54-803f-dd9c974280f7@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:50:38 +0000
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
Subject: Re: [PATCH 2/2] ASoC: qcom: audioreach: only disconnect the route a
 mixer control owns
To: marcht@proton.me, Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111-q6apm-fixes-v1-0-1beb5702b372@proton.me>
 <20261111-q6apm-fixes-v1-2-1beb5702b372@proton.me>
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111-q6apm-fixes-v1-2-1beb5702b372@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfX3hpbCcBaWcOL
 OjdQVR7nRpuddBcR9wD9kJmsjGQWjso3hOr3iYRkEGSInT+e9k+80VO+67JEv+UpUmm+/JBBhlh
 WD71tng8oNmgvcTjI5eCCJsLfwi+OqXnzu//aPnoNGVC2lbz7Lws++j9ItFFrepJciL4mbIAoyn
 4piYTv6q2qKlKqMDUBE8ym1H+bNx8doI6Pl8zRrMvsOsEDTf+V5Oym5pJPlmPp8/9SLU2b1x3QN
 wC4eWefOwbLelowpOuz9yhypNknzEP7aogoGO6aDuiXqUxywD14g2OSjiI/ppjdel+8j/e9s2yr
 Ta2tWoF1S1iK2hMawRWw9G4GjY9lBIQzjEdjeVdHYGslc2VehZtNpPYNCgrVo92IAX0J0fATFgy
 brhy7vVQMMhkme/LrI1wANRXdEsXDI9s+7PlxSWTDwZMgZ5kUQpFCT2EIExKR/br+CzdjyqXH5Y
 SmkHEHkM5+6v9Gddoig==
X-Proofpoint-ORIG-GUID: aHLUQmJlu1F3XVe3RZAUvjGDl-nIFbKw
X-Proofpoint-GUID: aHLUQmJlu1F3XVe3RZAUvjGDl-nIFbKw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MyBTYWx0ZWRfX2SDRi1mmhK3H
 soiy6lVOU0lIUVBQSqCO4ZFK6sY2kDmSLi8n/VcyIGfmBKs0wc2KdLuRgwui4C9AedDvPKt6qh2
 Ax/Q+DFMz3J9+aIxum6ATLUMKl11AcM=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af98e83 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=AI3hfGQ59aOwaD8qyfpUrw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=zknksMb4cIbI7LntptQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150043

On 11/11/26 10:54 AM, Marc Herrero via B4 Relay wrote:
>  	if (ucontrol->value.integer.value[0]) {
>  		audioreach_connect_sub_graphs(data, scontrol, dapm_scontrol, true);
>  		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, NULL);
> - } else {
> + } else if (audioreach_is_vmixer_connected(data, scontrol,
> dapm_scontrol)) {
>  		audioreach_connect_sub_graphs(data, scontrol, dapm_scontrol, false);

move this type of check inside the audioreach_connect_sub_graphs itself.
--srini
>  		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, NULL);
>  	}

