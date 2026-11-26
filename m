Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702274;
	b=Cz+R3i6m2iVze9vRhkpAWU9GqMHHj+OECVK44bS6y6Oa0HZicp5T0BEv8vbnftpASGTX
	 3iTjuJ3QH0N8y2s0cL5XJ8izS7amlBPs/hlsoBHjjdctaycTI0AdGpXoaH9rSHkypEhdO
	 IBbptsJXjbs2/+a3ibAoWe+j+fr6+Sos1ewzt/5RYBMcwzwcft9yu1Jnbte2F1D2sl+ao
	 6wrKdTF0P0JTlplm6e8p4QtnsSJjveQXJpKeqyUn7bfNvONzhkqJ8N58BwhLRsHrY0S85
	 DU3990zK23H4rVD5SGduy8sqsGK1onUdCUsgwhWTq5kNX5kyMk7j6Qrx8BbY2FxyQXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702274;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WbQv9VmMv519RrDxoB3V8STwBIfdnMTFREJPjfzwsyI=;
	b=r0/mKlV+KsbbHsCIgOtiyLmAl72nb/b9XBPDkaBR9XiBgkhFK7ErJgXWoC7OIydPS5ru
	 No3RlpmhoCB39r82hT9O/gemV58YT/WSEYUg1+59mlEqMYG8WHUrc7XWJkjS4R9smEZlI
	 sPOBiVhxXdUX29n3UX9Nc5ToEdXMPU34iyFkL4j6PlRfDVbU2qyLnC8yjdIkBSxeedaK5
	 V6VtWWOkykIpGDeVroyTUDuRYP2pIt/84dGOvPte4eZVt/oKdwPnguKeuSmUfZr2Wj2lI
	 L3C8GUj3T5VM6vp+iLnVriF+cBn1usph7sfELxUSmmIbCEYrJNrjV+4FZt2USZ7iNZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YrjLyzQb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YjWFp1I5;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21688606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21688606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YrjLyzQb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YjWFp1I5
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVSJ02785126
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WbQv9VmMv519RrDxoB3V8STwBIfdnMTFREJPjfzwsyI=; b=YrjLyzQbPQuqAF13
	fLqFZi0YYUDLach/z+WWj8mJg/W+n5athvKnEyI9CHfbsjKmmOqTqaXzkk80+iCG
	rTweA0qcoZvgRjLPgMoQL6kxZR3/yYbTtYTv6Vopyox86SWAcbW3ZAa6iuByCBhz
	c0WVYOZZTeKEZtyqLjd40ceb3chelKE4TlGObJXbtCgrn0C1Jz1ryuQU5ZeVKwd1
	6+edBF/CTISzVEEy4qaflp02Ji+Ogm74MuZaNRK+KX+hnfT/OMHUivSNdEnEuUTN
	vLPbK3Sd9YEqLhAIaIW798IJxrObK6Wlp5yJCbEQCaSU7JHBVEFiLN5ai/L4uT4F
	jSxj0g==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qfb7xy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:11:13 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b50256700cso98729917b3.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795702272; x=1796307072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WbQv9VmMv519RrDxoB3V8STwBIfdnMTFREJPjfzwsyI=;
        b=YjWFp1I58/mqA91rEGT1Lmu041a3W4FfTDKTOy3LG/46I+WBHjG4M/ihqpyMEL94P4
         zWfOkMup7PuxWN9WXrUPTpHETrjUS0KkGbojmrBo03FONWxfDsceS2Pqqr6RbfuEl0wK
         JoIFsET6LdQ067Ns8DLsPU4jw9wc4rY8etGWcrVXzTfjsLi4ReD520n+ljQi5Aa7e9WU
         pN1YmGj+UzemiTrxO3KAZv1Gohlk2q+gCU2FlXGnhgs5bDmelPSB0MYzraQHV2nzeZR9
         dUzoe4uhbo07zgmjrdlO4sE6tq+fNTa0C7HyU/W4WAzwpZZLByFVNlKQtoQpkcNtQ1e9
         RYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702272; x=1796307072;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WbQv9VmMv519RrDxoB3V8STwBIfdnMTFREJPjfzwsyI=;
        b=gMLAPmKAPx42kB8auHRbv+b4x7LTG3sVNd+VFmAk6JLxrG204YOUtCzM+99nBdnGRW
         vyGSly9cHzV3KoSqC3ATzqE0tGA3zeLYXVaxZ3CxKWe4LzhMmhZfmk8taR4GPZGGg6oe
         NgCVWKEvbkC634RB/Or7lVoFqLg88oVlR8/PGtEYZ8mLJP6GH8tRyRqh1UJu1u0vZOPn
         3B+qn1FJNlIOB8h4qj3/JlkRmU6Qiqmflz2Nk9QHovYzF/JC1DgB0hmazC4V5gm0bpFx
         JmRg3OvunPpVylh0VFrEqCUFLaCRty+lI+Q012F3JE2cxn4Yst1Ik7QFVJMvYwcuB5tu
         xBBA==
X-Forwarded-Encrypted: i=1; AL+hErG+BzMZdYDKK4SeXOul2mndRODnWmrFIuzLx7+pDQsNcO/WL1FdwAM/x/hk7lJt5HT68ZNmf04=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DEak7zmvSlAuuRVKfdSe43y+Qj1p52385wS3b9Qv5KvZVfgah
	lW7O7FTL+iHUOHpAKS46O2eEpj4sGahRCXSvBiKNB25fTXfJMoF/LyDytq5AjAOvbCNAdTdP1lj
	0/TjkYHExyKCc1+fzXaf/Je0k0fJeA07+ZsYm0ADX0EYL4b+tEsJrP5zqedQ=
X-Gm-Gg: AZFdTZfvHiy9GQT0NzVAzgBb+UU2/Gyi64ye9vJmEB13Hkvpll1TL57P1cPzLjlwuJQ
	xRKGwUD/VZ+BFLOfTnPeOa6g6HuZeJxYK76zNNRhXdITk28nHPIHr3MZmWhqoXeazprmDOulcjP
	LKCeaaEeZeHjGSPnZzprPrJZ9HonVyK/oeLJnKeuxH4KV0K3vd4dNf4Ir+/8ktFZrLyriT2MNNy
	JCq5cSH/9+E2BoGlXuQPtB3Bn2FWpP62Oi4STm3Uan+4+tOiQ/RgXVXUR+x9zRmK7fccq8qezw9
	zFGAg8k9IB269GUjoSCkYvsDbx9b1mnS1h3R9rTaQAAfrlu3dNfyz0GDEIYXMVcX1XFDAjXNKmR
	8O64WXllxvtfsVfRYPeflrSH3zaSemq3hsRJGSDrKE7zARBx8njNytPoSukezOXYuclM0r6Y1zk
	VfIUjpsdAFA2C5nY3VlmVOV1kaWxJi0RcgaMoyiJEebg5uk3BGCvj0UK9Bx7TZZw==
X-Received: by 2002:a05:690c:9a8f:b0:8b4:dc8e:2e6f with SMTP id 00721157ae682-8b520514f25mr71918357b3.63.1795702272519;
        Thu, 26 Nov 2026 06:11:12 -0800 (PST)
X-Received: by 2002:a05:690c:9a8f:b0:8b4:dc8e:2e6f with SMTP id 00721157ae682-8b520514f25mr71918127b3.63.1795702272013;
        Thu, 26 Nov 2026 06:11:12 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm42005648f8f.2.2026.11.26.06.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:11:11 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: aspeed: Fix potential coprocessor bank map leak
Date: Thu, 26 Nov 2026 15:11:09 +0100
Message-ID: <179570226688.21819.14587859111511548697.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124135833.2275409-1-liguangshuo@mail.sdu.edu.cn>
References: <20261124135833.2275409-1-liguangshuo@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9SgJDQ0goW6JgaMa-ePfDAxkUn5yBotl
X-Proofpoint-GUID: 9SgJDQ0goW6JgaMa-ePfDAxkUn5yBotl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NSBTYWx0ZWRfX8uXHSK6eWblY
 jtQdG4Ci3eE1b8krMeWc6KPAYQMY7RILpBmKlcdIIJJLCbOsZuvDNfAf5k9jFhUbWbPUyVJf0sw
 AVJcKx/lapxCU5x49TrfRng/8ZXLTcs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NSBTYWx0ZWRfX1mMjQGOEJU/0
 RWbO6hJIBA/2BH4lv05ylsAo3yvCkLRkcnQFtafCxWwdD2YadJVOEoNpmS7PAQJRfbh1r+e452D
 5VsuN4RkcmTk0jIQoGQciHKZWdxSjC6CXA4jtwsJoukwE7VpuBuJjA3duoMLAEtmDBg6vrKUnlK
 ZRFes/eO5zDdPRjh8Sx38+EWe6YZGi6rw0VB1HtIZUYcDtvOQWON7fyYyJgrDLeYe3e1HISS8a3
 Ap1GcB+KKF5N1/5nucjlm2enRW2QLyzq8GJ3k2u/Ude9MlbQTVf+gj+fUjdUYxH7uJvQgdaPvgQ
 83utPT9vZ8NB5l19m8tPbJZjCAYdC1PNM3Pz3iSk/3Fgfq6t0p/wUaAmKWhMORztpnxFRcmNWHy
 5IZb8DJTuyc5x5chreE4utaSpqLUWkFgdHz6fdzZ+tVg18Cjbh0pNAr2olTFU6cL8SfYQ+Bbj9A
 ex+TGkZXwmKmVc2UAWQ==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b083e01 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TMjF35BhI2Zkm1y86xwA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260055


On Tue, 24 Nov 2026 21:58:32 +0800, Guangshuo Li wrote:
> The coprocessor bank map is allocated lazily but is never freed when
> the GPIO controller is removed. Its only owner is the device-managed
> GPIO private data.
> 
> Allocate the map with the controller's managed resources before
> registering the GPIO chip, so chip removal finishes before the map
> is freed. Round up the bank count to cover a partial last bank.
> 
> [...]

Applied, thanks!

[1/1] gpio: aspeed: Fix potential coprocessor bank map leak
      https://git.kernel.org/brgl/c/f18a4698b0124f77549c23600fa5105bac2951f2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
