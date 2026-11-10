Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303498;
	b=mxOkKc5NFHqRGglvI6E9J+GIsMco0SlTAgL7VfVHEYm9Fwr089vOultqYWl5c0zBXJv+
	 Fw405d/N5Mk8CHKgFCJgVAm3sGivj+nmNf3OovMwjMBcT8Np4TQqq+CN4bH5YgKHdVJS+
	 2r1DZ7i74p2XboPbpxehpHIwxNp21cKIU7eDdWVMHwO/koSYrUuyPYuV7JfWs1sB0wlOr
	 qxVkU2IusTRkc1+dCcI1xxaGI/9piKo7b1+pOywnsTJ+JuIfrJmIUj7iWEGQlh94oHHnw
	 TYWSVUwP3VQaYLeTlpFi4Mskg16ywOavTrV2dSVl/viLZeXnD7dhQ1EWRaBTUD7sj3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303498;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GskYWq0okKXhChzrerCcQUfZoiREEqMRqr9GQwC2w8Y=;
	b=2SVGRF2Y7nEwB6leZQ9cROYjEySCgMsKqPdR8YnWAfzYAfnH0iwbGt3QtM82/IAz8s4c
	 CwfxKWOsO5Z7N94j3SEusUUaL/reKxdJ7JqycWL9+5Q8M5s9WnSSzKHE5BppsCngevZf7
	 CK3piBmrZy1Z91JfDQy5FkeaCQI/Eg4vobDp75TAqHk0klEYXjH8b2hEZe1dRX8JkbPv8
	 VOBMSNvNtrPBTM2+x4CzoVzWDzirow68RnqSZdQEcjIIRVtQol8GPc5/d1H0onKbBJwPR
	 +ZhDGtOixc9I4AxG/HsbFAQMFyl2cUe/rgtQwXUfn1FrAHe/5niBzxLkkR/pqtgORUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aPRTJKQK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A+oBaOUE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57DA606A33F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57DA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aPRTJKQK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A+oBaOUE
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8ZVOU1916724
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GskYWq0okKXhChzrerCcQUfZoiREEqMRqr9GQwC2w8Y=; b=aPRTJKQKR6HnNm3p
	Gn15g8HiARayyGrzaj5nAYiRG0y7dT8nL+GHvjo4p0HoMMCw8DmC8U7ANF4BQcNt
	ltqASJN9ErdsKbznmMz7xAPyhW1I/ipXWhY2j9iFLNQuNYqC6y9iYMa3hZ4iL3vq
	POk3f53z2MUVV23UG09gEsewNU7Du/ZtYfYtaayfa0VPrgTETc6cNeOVuDho9wZo
	o+5VdL/vphdenyjg99KhEKaLdMvAB0Xv7rNiRakhV1A1QxCso/R0yseejdX6N8RO
	r4Mw51kwJjikBlGp/zUOMfas2Tffl6AS9lD0lIlTB1xBqwAimXMdeqbYU2qh8nfO
	d1Y6Jg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw487w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:38:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f322ef7d3so424189685a.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794303496; x=1794908296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GskYWq0okKXhChzrerCcQUfZoiREEqMRqr9GQwC2w8Y=;
        b=A+oBaOUEayRVAO2q7aC5BPNpGEj/oPc1TFNI/Pl/fRTkPoa+9eG/8MXnVWmqYI3sRS
         Tgc3BdOAvUoaPj9QQa8qGcb9cd0UlE/Z9VjyneGK16ZHR4P6i0OiWjnJEXcsTt7/S/BK
         30hlHXPTEwtytZPt7e8CZj3zW+L86yOWNVysTXY8i5JfJyYRzLcVaPcMb+UWUjx5sdW1
         z4T5d1QkSYe3iUtTTb8UE9Hd6J01WK/BfVXYcjXPc2aNyCy78APeDQjaPaeClh+okbeX
         t3aeu7x2XYPTnC3rbfcTgmLUVH0uBs7Nns7jSqhnv9gPDvBXxbpJeAg3HRcIzzva3V7Z
         CzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794303496; x=1794908296;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GskYWq0okKXhChzrerCcQUfZoiREEqMRqr9GQwC2w8Y=;
        b=0TLXWanAjyN+jCKxFkZO1PpkdB81aFCOfrtRWnrCQ5L9+N79yLWZkeUsI486FvLZSu
         baxEny8aWSkWWKjZAUeWm5woVhonUyzkt5WY1DnVz6JrhRTGFDy9PdrMSLFqnSwwy1Z7
         tY2ta/0B9pOx4bTPZMHp+8u1t7O1Vrv+yd3gDFJSVkJR+H2LkNBfhZPArMTrV0EGxnP/
         IMp/vd4E7kfhijMo2OXh+wRILe9Mn9ClvcM1mnEzdTiVHVMzu+2WIc3eNEVLgzVpQfgk
         FbPwb4admxXAczkgsDy5lm7HzL+txerIRreZwDQ1+8atuEC2PjoNFIvUgEO2tU1Ns6wt
         sDag==
X-Forwarded-Encrypted: i=1; AL+hErE5UyjcdB2iqO8zoQUDoAtHkOJAco7XPrjs9tYNW1l5doiRFsg0pBqZxPpJeLmShXy+/gJqGwQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LFLa0Y+nvrmYVdgfOjrRy1l9s9Ah6bdpg0MAXoinWaxjAYxg7
	Zvv7dVR+21yv72kyZIBNEv8PePtP0mUF6pLHT/jq/osjqx2VqxsKaZAgSPKlWoY0tRi6I7MOtbh
	z1ZwyvfpC0CbZ5Yl2jJ7ShH6s6EEYyZSyr9TbiJHZXa2MI0h7UltqTYOW1v0=
X-Gm-Gg: AYBFou0YEaon8gVvRcNK9Zc5jNK8jx5HvAFPk/aIHmYHZ9S8+OYxpFJeQEU/mQGOrTP
	EpHew89nNIva496Bz4bCMzIhJE0AOZrKyuXj3SGTxhQUm+wBvTxRgIRfjTm57OfORLVf5cg8n9M
	r7sTa2lmBJWHeSLVsSHi8J/WyEnvSGIdb9N0zn3B9S9TV4wTOqxinO+/7hruK6NOWatsDAxjPgl
	Nyo3DWQFHqEIw+mOnpz/yey+ZQOwIXF5c5qax7GE4+Fswh/adpm/xoR83sY7L57Sjs9QiCxJ/0F
	WWBV91d3BsnhDKIr/p1V4CnR2FpsZNWu9zXGHt7iyHN0tLbCGixJk/eFOO3xelUPDYnvgr7aEuD
	lJ1T1AQy3GnSiephrXRvtUHv5cRTlp4ZismIxQwvsbKAFqYPwIsa8n0MYsWXIFeLD+kqkJmRqAC
	SdDNVQYDmDrRUqzhiSM2OhVGnPYfW+Av2rU+UAitxXKtmJ/WOenfTSakgxIFqTcg==
X-Received: by 2002:a05:620a:46a7:b0:93b:d7a2:83d1 with SMTP id af79cd13be357-9479f3c5fc2mr320945485a.64.1794303496186;
        Tue, 10 Nov 2026 01:38:16 -0800 (PST)
X-Received: by 2002:a05:620a:46a7:b0:93b:d7a2:83d1 with SMTP id af79cd13be357-9479f3c5fc2mr320942885a.64.1794303495699;
        Tue, 10 Nov 2026 01:38:15 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm53126545e9.2.2026.11.10.01.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:38:14 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: sodaville: fix use-after-free bug when registering the irqchip
Date: Tue, 10 Nov 2026 10:38:12 +0100
Message-ID: <179430349031.42519.17560346076327838160.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-gpio-sodaville-use-after-free-v1-1-f572f40feedd@oss.qualcomm.com>
References: <20261105-gpio-sodaville-use-after-free-v1-1-f572f40feedd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfXxTYA2ARdWqbi
 C2C9/2JX9REuDZC0guE4VaZwKHZPgnYomnZ28FXK5V4D6tH0xrRk3qWDW1waiN4XgPmamY9W9pm
 iDLroZnBRuzDjzZPjboSUOKNDUMduf97ikSQMC4oST3gCO33TSYrIN99z2sc+HnebJzLYOeqZyi
 iI1GQgDLG5KqhGOjnYO9oZdQBNf8hteHNZQYmfYEGDfxcrrynbnLWh7QcCbfG8UT06yP7ic/ECU
 FqmfGfypc3v0CNO8u2FbiW8o/cU1BUqpMWvTIBJbBSH2KqYYnrY535c8KJS/rRDME5u1xalE/qg
 VqvXpY8kj4gCHaG2nvg+Em5SC5kTmifjlPNVxotklddbhWBYuq5dvJHC422827kj/1QHFKH0DiO
 mJ/rMEZT0z1eAScvbTgDJd8zkIR50smFufLOR/h2vj7mtgN3KxXe6TCCZ0g3dHizAaYA7xSYwdr
 nQ+GOcpZ8cO+wMcTh3w==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af2e609 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Le8wEPVksgxnqJZgdr4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfX0EZSwuB6AcPK
 voJO2jd8Raa448/tGE5UTnyPSluRJAzR/w9tupyGz0mNlW+d0LnJ6wlUnC/Z5dqgJ7WrGuuPAU5
 fBWDWMl7h96oGFtXZl+JXUX1lOoElHQ=
X-Proofpoint-GUID: huKqvdr98l1Jmlsm4Uwgd0nExprvpfj4
X-Proofpoint-ORIG-GUID: huKqvdr98l1Jmlsm4Uwgd0nExprvpfj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100038


On Thu, 05 Nov 2026 14:14:27 +0100, Bartosz Golaszewski wrote:
> In sdv_register_irqsupport(), if irq_domain_create_legacy() fails during
> device probing, a generic IRQ chip is left registered in the global gc_list
> while its underlying memory is freed, leading to a use-after-free. Use
> the managed variant of irq_setup_generic_chip() to ensure that the chip
> gets unregistered before the memory it uses is freed.
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: sodaville: fix use-after-free bug when registering the irqchip
      https://git.kernel.org/brgl/c/ab9102375b7c77e0c4d33c7594e514454dc9f2b3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
