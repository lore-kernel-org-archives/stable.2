Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806624;
	b=WgJ383LGaPurEb70dfptRk6ADXDk1fc6aokjVmvUurh786ah6eDNpTD23KF70IiUVeL5
	 oqQ4zQoyeAF1X7AJ0TaWCsPO/rsWh9KreHfgHKeP7pX4EcQ2u6vb/J+FAS0GPri9ekItu
	 9TArNXpN05P6NnFnMcpfk9XB/DeG1eXiQdfWQJZpQoYSxQW4nJjeagIhzn18usvV/hkiA
	 lJb0u2Z50eglGtl/DfIHMMifMpgJwIslnWIXpQVqWMxU1xkifRu6p29Bz0QAY+dg6/QPS
	 Ur9fGYafzYFcxHQ6uLbx0Y0RyAmmmeYT4fGTuDL/xYNwAkTwFLtCKz5nmQB8BCp+KwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qaKkZOLJT6rypFd2sX4FBnQNajzRPhE4C5UxTUP/QFw=;
	b=1js15NTRlQdf241LnATlIxM1tpUMqly59CLwnBjlRnCCLr6fOTUIbNViP3hhhc3095Tb
	 Mx9fEDRCQ7bn205wzSrMkwlO36CmURNSbLqgzIX0PrVr/hdN2pfQg4y1LKlsfyNM4kCG+
	 7Js8UgR2rOHoIifPBGWYlA2cnmkDTNmdbtXeKAnUYJO7BRx03TYsN0ltxV8cahc8g3A4Z
	 /p0yvyo26Mh/Q5iPUClowHEXbAOQjUHpVzFN8If/kqtxPin7asJeIfcNYGxxSsulYfYcG
	 4S2lYqeud+1r4plnT5Fj71h0sG5xZfrlLMAvE/G7Api6sxgS7mhuhA8DHVJrxMOzNZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SNd6UMoM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=knr6WHXT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC243606EEA1
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC243606EEA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SNd6UMoM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=knr6WHXT
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZsVn2284167
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 15:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qaKkZOLJT6rypFd2sX4FBn
	QNajzRPhE4C5UxTUP/QFw=; b=SNd6UMoMqmvr/CP7iQCyVCk6LSGAoORn7R2Nac
	y5Ma7d1tBYmLSheG6FjNLcZ6JNMFgKSv2CxFujtYmKUsp7zDtlswsUlLtju7k0eZ
	HZ6caqqd9KHrXqQi/PfBGalvqnu+4iCmjul8onMeMDEgkUnyUYBdsblgzLEDl+5r
	s9Om4VwGVKHuYZ4tOIQWbRDSqEU4YL0nDFWKGWQhnEHaPuDjQ91gN/1mhAKXstCa
	RnCA8YlXkEbregjKDf8D77VzBxgVJN8S5usaLm8AqEdWJURr76cduuWYzuIvRVlA
	VQVL5rj+BioH6I0pivUMm2cIJ3zsPhn7zk5L67eTQnpPqauw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr284schj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:37:02 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98c6374b678so694377241.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793806622; x=1794411422; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qaKkZOLJT6rypFd2sX4FBnQNajzRPhE4C5UxTUP/QFw=;
        b=knr6WHXTZbGcoLt+KCZmiBHx1w8LZhVWCZ6fJBkLcuBHEK5C1DWMHDMfW09aJ5mW8J
         /jzDAgqcW/HcjEtFK7QrGlW1Yz3n8yVDJ7Q+cIol94s9ShUuuKKeBPa+SJ41cTdxnm1G
         hCrI42Unnn0orog8Vv6Y6jQeY8oy90OCCWQ2qyXliu1QVHRU7p212kTEmTZJlebexSa7
         xAQQT1hT4J+NvlXnvFQ/rjExeCVsD/ffQlKOuoWgCXuFF2m6orcgjK8yuITbNFuRNfZN
         tl9OqTKw7S25zpkmGGUV1+YfPD4NljGy5lpLzcfVq5aKJUu9VBpV4eB8x4w3Woj9UiAw
         PgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806622; x=1794411422;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qaKkZOLJT6rypFd2sX4FBnQNajzRPhE4C5UxTUP/QFw=;
        b=UdpZc1yfdR8dRDgPGnWIb9FD5C3EqCSDyol3inxdI6wg6edK2C171/ca+CnpQ+nJzL
         XCdF6jKG6QZz2GMugGV4kIe/tE/KxJ3xqdUVLCrWHcOkJEwcYJ4+8myh7mB0lDSo5YQ4
         Mz1+gFJ6wbWCtXxP3FBSI0RC8oAf2QAozlLpOm9/yisvukkJepajgHhTbmfxJlPmx6j6
         PbNIhyTOK+Pa0hlQbJujRDlzEBK8Hf+ngDlJlEETv0TTSBaOg1GOmmT3N5bdIaXdtFLL
         /9dsLQdoHVa8jlvp9/8+BHmeIJs29XZWbLqILa+0ujHpnmcr5p+nl85dIgBkR+/xrGRy
         RE5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwKnpIZPK6UjbmhJZyT3EVGx66y/PGpHEwN86qEYL7nPR7h07uAiRrl89AMeaZlsvId6grT7TA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8i9NmlWnxDZsg7HLWtSo+yEHtKUyFtqGcbU+XqMZblbcLA6u5P
	xrJgnUicu93B8xnHFf/Xh1YtDXhWg8Apg9U85IKCJzRpPyQHiyShVOBBNGlbFDP+SDtsdObAPDP
	qW2Lgq5FyHgIMlGBMcfKBXXMsHfy8Oiia1hgNBTbbEb5bdQBPnwuep0MocZU=
X-Gm-Gg: AYBFou1q9MFvQcrw3o3GAN+yJZWcSLcM53yufPqSSX37F6dJ3ptsj934QFUVhD98p5F
	Tuxj5flpEMJw8uNlnH9MkLd1jv8yW+DezXHEvcB3J8DGVy9aPbV6imTYtZzNK/z3iSo1ugf5HF0
	e4geFX9E8rZoq0jjwb3KtOgTl7iEu86UTG3I9PNvYO/tnT3RL4tnONgjXBb1QtvaYcXQ66he7Bh
	QOf1MeOC6acDcZYdN2z8ZgCQ/pLu6/2U7LlOi75U9Aqo0noNXjkA59YXPAY1+LeFUmEi6l27MnU
	iryx39mRHbCN98X++K0IxME+xdX60tVky/F6Dm4opNQGmFZ+qfNrN3BMiQ9bmfxz7tQQ5+b56+y
	YGx2iJAQH3PvWBcD8rn+tTAey61D/Vmx0bLcuzfXB95k9FxSkv7BJv9oyEzF8ryd0o1Tz2e5t+5
	3DXA==
X-Received: by 2002:a05:6102:2d0e:b0:7cc:174b:f7d8 with SMTP id ada2fe7eead31-7d072247ab2mr6925495137.1.1793806621671;
        Wed, 04 Nov 2026 07:37:01 -0800 (PST)
X-Received: by 2002:a05:6102:2d0e:b0:7cc:174b:f7d8 with SMTP id ada2fe7eead31-7d072247ab2mr6925480137.1.1793806621215;
        Wed, 04 Nov 2026 07:37:01 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4107b7198sm30388825e9.0.2026.11.04.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:37:00 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/5] gpiolib: improve concurrent access to the flags field
 of struct gpio_desc
Date: Wed, 04 Nov 2026 16:36:55 +0100
Message-Id: <20261104-gpio-desc-flags-atomic-v1-0-e23cedf619ba@oss.qualcomm.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdR62oC/x3MMQqAMAxA0atIZgOtiqBXEYeSpjWgVhoRQby7x
 fEN/z+gnIUVxuqBzJeopL3A1hXQ4vbIKL4YGtP01poO4yEJPSthWF1UdGfahJBo6FtniYI3UOI
 jc5D7H0/z+35cD7SOaAAAAA==
X-Change-ID: 20261104-gpio-desc-flags-atomic-cc963a1ccfd0
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=C0TsLY/WDXWzyDJzC88M19ROyZcPTlo0UPHlXxPXewg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq61EaCXVyTKKnSmhQSlczgLfJ3oZRSbDR4yhex
 xcs1pRzcVWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCautRGgAKCRAFnS7L/zaE
 w7MRD/4t0JVWEudwhEu0Y4ohvGw7dr+eNtwsG+eNqd6FpScFT74Ri15eE68uj+pRdMt8QBP/Hnt
 U4f+MV1JHzJVwlUZDPyfUzU6Ti7qO0o7cZnJniRWcFoJCXe1OdEBOJqmw0yV6DKG8NbSWNia8zK
 nCV5toEPjBRNQv9VQ6kX5jfKJ1yZqT9jU/hi8syr7AsbUXipZdW0h9KcfkEB16p2YE/+EP//cb1
 low8gHRcD+VE32QwbXu6oJltiHJa4leTBjJhShY/l0xVKuBY+F1dsre1ogMKLl8mLhBYtnm3zdT
 G/fyFSd68/D2YcD+3JEQTxPRKutXXyV/iyvhDL7P/QyWATUzpBCV3HiTz+U/qgkmO1Rs6+VjrSS
 u7C7Qe4IlHRxVtDYpAn9EYQ5paYl0BXAbl1HepWqJWna75myjYI8afJvytbzVATm16pZ9ew9Gt2
 qqWqvnJ7S2jRBNiZifnOfs8xTRGkAnmr2KTkUHnJrjxrm5We0A+/jyqqBu3bbiIy21QDsHC8BUs
 Gcm8D8vXMtnq43EU1zw069DvDGEvw63j4nJp3Fcnhbanb0+IlC+Yw6lomezqwEN2qUgV+F5lX2B
 k43Bz6PwCtIyTmr4fkoT73GbepEsFcFXt04LBAoMJBkWuw1J980gOEpM0wbkevWdcZJg9sy9ygT
 leNfqdGYTwHKAnw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=JdQpPkKV c=1 sm=1 tr=0 ts=6aeb511e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bXYUuKcbincyNTxPRNEA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: gK1D4a7FzeQC_xsegF2v9BCIj_QVeKBv
X-Proofpoint-GUID: gK1D4a7FzeQC_xsegF2v9BCIj_QVeKBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MiBTYWx0ZWRfXzpOKMDE6sWyF
 Ld05jRhzLk4dgEhhyxaAGC2VXuGyat/1EC+Tk1TWoK3ldTjZh1KqX9XEjYtYFcUBMJTJIB/Vchu
 Aty8GUbFOxpqCKQdnEO7+oR+J5jp0fgl2e39NHlSXbb4iCZpg6mXhIuH2NfPDiECHxwpb8j9Wgh
 Ofz0vyHATYIULlJIo45n7e0IoytdyumGOdk2sBbuNEMZU39RLsKpSZAf27qcXhOwDLXaq9L5oY/
 ZfjXX+09WIwEsbG/XOA3TaszNnt46Ly864oP2HfGifu2Dp9DjD/TenTTaTb7tf2Jw/UQYUAssgk
 9PDNKj3Vn3SSmIsIe407xrBQd3SW/RJZjJQG/4Ns1jAP6wuOyFOHWVbhrE9KXC0/CC6GRe0h1gc
 8bCq63NOOUMN2i8CiEpMhcfxpa4c47vi/t5qr6H8eF3S+ZD6CtM0dK0kN+Fxijh+HVsZxoqj2pw
 q9LgU00BDI5A0xB6KMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MiBTYWx0ZWRfXyJmFCLBoCQOc
 Df+6FSKlNlmANd6oqvU5XTPgNUEDywWPdnY+azIpiSbfrauE6/YsMF/7J9TvZ7EWYyg/4XDnwfl
 ujl4FqZ5ZFfFWQf723pVhMTM8mjHcqE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040062

This is a follow-up to our discussion[1] about desc->flags and possible
races with users who don't/can't synchronize with other means.

It's an attempt to use try_cmpxchg() to update only the required flags
atomically where needed + minor fixes using atomic variants of bitops
where it makes sense.

[1] https://lore.kernel.org/all/20261015153714.GA105746@rigel/

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (5):
      gpiolib: don't overwrite the entire flags field in gpiod_get_direction()
      gpio: shared: use atomic set_bit() for descriptor flags
      gpiolib: provide gpiod_update_flags()
      gpiolib: don't overwrite the entire flags field in gpiod_free_commit()
      gpio: cdev: don't overwrite the whole flags field when configuring lines

 drivers/gpio/gpiolib-cdev.c   | 118 +++++++++++++++++++++++-------------------
 drivers/gpio/gpiolib-shared.c |   6 +--
 drivers/gpio/gpiolib.c        |  29 +++++------
 drivers/gpio/gpiolib.h        |  21 ++++++++
 4 files changed, 103 insertions(+), 71 deletions(-)
---
base-commit: f1fa734d14164cddc063dbf2138c2feb38baab42
change-id: 20261104-gpio-desc-flags-atomic-cc963a1ccfd0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

