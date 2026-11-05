Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869995;
	b=SbnrAh3X1eaHUCmtmsuW9dj1CmkalHuvMuxY7nYvSJhZ9uZDASkH6IxDGrgRerxk6mYu
	 21WJJtnDSKW5zTXd9GTGbA0lq0zeBogC8WGocSWMsQJMV6BpRBMMdLkIl8cQWBKTeqQ1d
	 wwNvEcJ/rTUBC7Hx02VW0H1KXpXS3Mw3lfpBcc7sPblTpVOhKEdhjJQ8DT1qntQk5re0V
	 a+2f6YzpTSNsHa3Q3lO8HRIBDmI88ALFBx06l8AEzqkr6kih5ReF4hi0C4z+bY1oeYoJv
	 dn2UW26q5yUerNHOOpDekBQCcwRN3ln1X/JO4/DJg0cCUj1LQKH0xKZJ+KpEQgBos/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869995;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=q9yfY+/I3R7K6u83bmbStsO2lPmehAVb28U13aAr0q4=;
	b=4f37OUg6wkC946bsv/y4ze4GyiPGLKeNVnlk8OKGA6rw3zc46qyXIrpJCQd1NS4Gao9k
	 7n9brNG+jSpM/D47CmFYm2kzdWXD1k7LVIB5crByW5t3RUIv+aTSZ68sVZLAX3KlGnEQ+
	 NfCRRH3qliU4LZVy5oC5CSmUM9al22OddJioGZze/g+60cx9dlSSYFg89N6iXu/0sYlrP
	 6PBtYdYLzkOp86pmqnRq+BPvWLMwMBPbA578Bq0xBxx9NMzFHW3m1NdU7dDEqTjwrhPEf
	 gh/t7BOGtu4UOoOkgiag4svzboP+pGVG0EtasmA86SdxL6Fv7tH0E9b+i96rDLTUG3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VQY9vFS+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y1SkfBGp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4A606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C4A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VQY9vFS+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y1SkfBGp
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56U2P0565116
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 09:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q9yfY+/I3R7K6u83bmbStsO2lPmehAVb28U13aAr0q4=; b=VQY9vFS+f916fsBm
	rX3P5iE9IbgB/XThZDvdwekJ7uK6K5qkEEV/GOdy++Ybca0QLidKN3svnWQjIFuL
	e/sz8tVl5tbtUIEcZ4UNlG9au0DU5Kmq5aXsfIGhSmnn1vDPZ9rHxjUgt7uxhmGz
	vpJnyA3qo4Cv5bY+cZ0xVctvGrEbRZqgPWkyC0hVrK8MJ+Q+r+zejMh5GdfyPxCm
	g65/vC6yBgHSZByj+mjuZNByeCLUy49DmrLweKGzv2YsfzeLxooAvVsa/GMa7s7m
	zZfgkrDd1yaAEHWh+P2wJ+7/VkdCuHDoQx/CT0BKuBKe3D0mnR+aXtr3FqAi7tsx
	i5WkEQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaq8yqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 09:13:13 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-999bc06bfd0so838059241.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 01:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793869992; x=1794474792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q9yfY+/I3R7K6u83bmbStsO2lPmehAVb28U13aAr0q4=;
        b=Y1SkfBGpVwIMsH5vGDMeMLMNceqWWnCtDiTEny1XVCCdTAZoVtOyk04LAD6aJiJ/3a
         XaCOKjPhO62jZpUe9kd0kp+CweUBMZ7sMqijoOpeteTG3U++Sfk8hsQLumaUCeDNJZCA
         GITNfWKZgLnyiyvgav8rgwhJ/FyKHqtqVyesXQRQy/mn+TXN3HmBNSTJR5sCntmMOwNf
         zOPdiPgZRFmGGWQRC4qN0YIEMe9icI9IeJzM1qr/uwG6LyrySbvv9tqwmXKCPZB6U0hJ
         0UXp5oV1ChZYGKdVvpgQZhPnyfU/RDxeJZjheLeVcndLzxL8j+17WyUlEMDAFyMW/usy
         gOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869992; x=1794474792;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9yfY+/I3R7K6u83bmbStsO2lPmehAVb28U13aAr0q4=;
        b=q4AUoZAgrdtJGm7rwHuk3w2ojeYeWqU2ju56jJWFxVONEXWDGfFlCP/fv6TYUbrI79
         uopJ8JN68+zWI2gWJ/jtyby/5Gr88mNMWYKa4sv+4qBVtqf1j1TrddKBxfHJof3INN8v
         gItTe/edN4/Bn0/0QjjFu7VsvVuKDBc0q7i6VFhUJLhb89GHGKU/pGQqfegROtSbBlFR
         80m6jWEm+KECHjxp6oATZItWjIP0qXoVWAaJNs8uczrTm0m9DmNbT91U5ng7xHUy8oks
         XHLioU5XreuCF7B/5BCCv7isfQ2PDKXnnOiGufUQX/7HXNei48V5EBtVyNzuiQ4tlpOW
         2X6w==
X-Forwarded-Encrypted: i=1; AKwUvBz9wn3R2EeBFkCDbCPSI7cz2O+dh0SljONV0+mZsbGWngC+NgCHUGXHyjG+Fnv4VpzZ32uMBo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sUS113DiisaQI0jG5cljf7UmuXshAYThOp+2ElEUW08atNOEN
	7N00hR6hZ43rYaa+2hY1wxZwbCh/Q0U5q2Ji+TEXeabG/upExKO9QRHh6uMsG8ELwVHDweFJ4am
	ABjbAOoAnr1UTzY+f7HZuoC2k8F06L2GmfLCauzcP3jpPpkmx4pREZg9+xQ0=
X-Gm-Gg: AYBFou3AvKjigQei+6N2WK1iVxpMeFbHGKFSIRt6Z1dQHQh52zrck0pS9F44vXn9GXj
	N/4iSjvyMgLuuJFPjc2pMY7lASZyy8JMHtlRvA5TsuL0So0h6ps1B9IUz4tTkMud83gIDDDAaj3
	0UL6JkkC6lU2vcSpdb6sACk2hrGpCkX7H/qnmX/6IUnflNOmycirZeUSglz6hCazkdnk2eh3sfR
	0ooN5nElLKSldQstAHolLZnKPOxM0JtON/yJAlOd+mAa2UzwKyB537sXIjHLTlfAW4nYZYTstwv
	q0ms07Akf86VVzqEfofzV5T7QH52SnO7KdrDEzcRf/gyF1VgKcNzxJYmMpt0lDAvbXjQwxnkLL0
	G+KPrvdtqu/d/VOp3ISlwAMKvxotFlfzQJn2RpgHUW6s34/ZWxXoXJ9pKiO8WkyVaYkAcUKIrNb
	MD
X-Received: by 2002:a05:6102:5243:b0:7cc:115:ddf4 with SMTP id ada2fe7eead31-7d072cafbdamr8260484137.25.1793869992540;
        Thu, 05 Nov 2026 01:13:12 -0800 (PST)
X-Received: by 2002:a05:6102:5243:b0:7cc:115:ddf4 with SMTP id ada2fe7eead31-7d072cafbdamr8260470137.25.1793869992117;
        Thu, 05 Nov 2026 01:13:12 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18175bsm8523052f8f.7.2026.11.05.01.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:13:11 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Aaron Antone <aae@amazon.com>
Subject: Re: [PATCH 0/2] gpio: aspeed: Fix lost interrupts from write-1-to-clear status bits
Date: Thu,  5 Nov 2026 10:13:09 +0100
Message-ID: <179386998646.14190.12898260042958043905.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
References: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
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
X-Proofpoint-GUID: nj-qneBRFl5BpV8upfEEbF0QcT6-vzSn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNiBTYWx0ZWRfXwfFo38r9HQGZ
 KDjLCONzozTrSUOTeHlEGmE0W40Vv1Sw0RFdwkBXu6EOPqRAoZzEQkqGRI9EPymFLgFYOK+XqTG
 RmbHGMTP5w0JLR6H0jp6xRfLaNcXRJI=
X-Proofpoint-ORIG-GUID: nj-qneBRFl5BpV8upfEEbF0QcT6-vzSn
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aec48a9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=voHqOY2aTaljLMbC2lEA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNiBTYWx0ZWRfX81f9R+fmamU6
 rEkDUf/hoO1bWXYy4hlyurAfKyZHT+LgyxA8E/r0dR7Hsv2xz4wTKKA3ilIiMQ1rbUXR35RVcGn
 kHJ0I4SY527kYOp6t/8UI08eA+nIf+IjDv8hYmPSxefY9HPafEDSjvBP8pliF9cRHE6csJpC9pB
 GCejWg2NB0UDLU9YTdAzuTaCN8wiM6MLkiYuQ/MtWiorGUTs1suFS7sCfDEVMRuOXXa6q0xup1q
 u90DsiOn4jiGVUNjQEgVITrnDLOLTH3crf9o11KFtCPmnpO392PImsQRTiT0nN4tqXpQi7+2mWy
 VFC7SggIwFyRMujRE0aosYxeajQZzWGkiq5P7x9KUAPwMcu8XDLWbfwj3B+7SwiVmcvtDISpTPK
 uBhpaCQiYrXvpnCsb/Yjm8hSc70ajA30uTEizhk9nuusD2B8lxpnDnqJipyEdNnFo7vUCtDUznx
 2SXBZUNtQeciZ4ykHhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050036


On Wed, 04 Nov 2026 11:58:34 +0800, Billy Tsai wrote:
> The Aspeed GPIO interrupt status bits are write-1-to-clear on every
> generation, but the driver updates them with read-modify-write helpers
> that write a pending status bit back as 1. Each write therefore clears
> interrupts that have not been handled yet.
> 
> Patch 1 fixes G4 (AST2400/AST2500/AST2600), where the status register
> covers a 32-line bank. Acking one line clears every interrupt pending
> in the bank, and an edge that latches after the handler has read the
> status register is lost. This was observed on an AST2600 BMC with two
> lines of the same bank toggling together at host power-off.
> 
> [...]

Applied, thanks!

[1/2] gpio: aspeed: Clear only the acked line's G4 interrupt status
      https://git.kernel.org/brgl/c/5d362564bd2982def7e80d7f1e756a97440c7adb
[2/2] gpio: aspeed: Preserve the pending G7 interrupt status on control writes
      https://git.kernel.org/brgl/c/18cc1d1ad94df8a6760fff2617d3d6923550cba0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
