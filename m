Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220482;
	b=ZOJY2atnrv17krXBrlYbNKirwKp544L2g0kP8MG/RCSqEbo0QcvdpRJ4nDJrlFO/Ia25
	 plQn7PU9ijkI1XxJaMNDSHURj3MCSwiMFez4GJxaZVekTkSVSxWNG0lPG2SbWSennlKc+
	 FJPv4ODmF7BhlinIMxfe0kOiWh4eyn1vbccO4Gu74B2gGUPLE68bQLMeKPePBLblTl2zU
	 KyLaa1gD5Rp1AXI5M/E/G8zVLCZzg5Sw5HKi2gNMAoRTgixsGS+b0Ok4juigxyDY9n1Ho
	 oD5WyQ4rGzvAVIL+sWrIdEKwJNROVKbbddlSyYFCxl1A4GFZ7lbY/i8S3AbAgAIF6TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=t2ZX0e8EFrvoLvciQspYC+mP0B5TkSBChAwKdLI9R9I=;
	b=pLN5zvCQgGzj9E1DpvqQG9JpxJDcD5OeIZIWbcdq100sNiIrygpI9bGIQVLnIRBYrRtg
	 5oMC24gHfvpmTDC+ZOjSTHH98SdUfVQ8r4pcfr2ifUrsoH/yT79lUZXSYaUWwwCnB+EVc
	 Jt+FZmF1d3zAaHAKutKsHWlzCJ1S/VCilYfzVp+JPp0xGYIGMRtmv2FvKkrGgvvuU9pkb
	 /2m7rI4AlARg4AhP62R7cDXjG3C82LPtpP33WysK0rjQR38WzjGGJUZifGwBpEbCKVEkd
	 c8lxAhI1sVS8JCX146GIXX7Qd1knH2f4xWJdyCcnX3pIVkU/GzTB5PEWYlEzysyC6/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pwDlnO9B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E5tcU2NB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97CD606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97CD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pwDlnO9B;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E5tcU2NB
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A99ukQO4130899
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t2ZX0e8EFrvoLvciQspYC+
	mP0B5TkSBChAwKdLI9R9I=; b=pwDlnO9BdREezjAwNdBqm1i+3lbw+sOQtCtY2K
	MnJa/9ti+BcNGt14baW8Qi0Rs0vdQc/SmgTknbfDp85oOmr8pvXeLUDFpBcZo88P
	Y72b6+GwaIhb4wFYUh9otZZ0ViHG1ulwTzqxpc2pj4D59BjGwPJjgV2NJRfwhNb6
	EnXYzV0fRsaa8FjgX7WWDY7HDntDWtn6hwBpCsMvGn24U7ekaJq79lpdUjsHtX2+
	IuUpU2JHQo90/jUZ1ejj5udln23JDDheqv1V0EqgiIhd6WT7ZtaH+N7EF7qBSC+F
	SxhoD6DqxY34lLGmOBRSikPQ25c0EoJ31Mi87fnBaTvhcnbQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2h90c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:34:40 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ec8c86fb91so144284e0c.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794220480; x=1794825280; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t2ZX0e8EFrvoLvciQspYC+mP0B5TkSBChAwKdLI9R9I=;
        b=E5tcU2NBqIMtkjLEmN5VINUqFrfffQIi6yGC3osl4UwcC2cx1e4cC8zDoxtn6dC7/c
         DnKa626HfrpEFnML3J84LYG+jW7B29/NVISl4cUXMspwZ2P9aihhyJTEC+eNU3ytMytA
         o9ZBHvzda+qNumrQFWnacVtL5ayUTo5TZNdDZYrmMrZEkA6mz1Wb6Rs3sFMmYqAVejwr
         IpSJf3RcbJ7PJ5UOhdivuNer9N61bUGfYRM9SUXEo6HhO/HWIS2IlilV3SI8mPgd75ey
         NDUaYENjetZi88haRCenbYY/LlLRax4kjL8lFO5mhqyYvaxy1welWm4x1Zhl15GkgP6e
         SJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220480; x=1794825280;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t2ZX0e8EFrvoLvciQspYC+mP0B5TkSBChAwKdLI9R9I=;
        b=NAU8NGfLiMq5DhYUxsXZUiM0G7FNOocVzLW0j7fnolU8TdJR7oG7pi4kVmkd43M+0c
         FFrmISwFDM/U8bk81xLH+sUjhYQhDIzeIrKUfYOShVyNxeGaQBIoLCCgAKtM6k3JWgS5
         /Woq9TiChAWhvfguLJyaBRVDPOU3q/irh8/txhx+jouMMPKotMmclFfnCGccu1068Mqq
         ju/noWr7SBytbCdRprFTfqMZ3M/8BoTa3Tu/HU3TEjmraujp2k2z/Af1NJNHWVSJyC/5
         K4Z5CgdMgEq/ujcqifEDjb8OUbXR69V6iq42iGqIDBx0uUq0lT50WonuaNFu3pqzKdWo
         x8wg==
X-Forwarded-Encrypted: i=1; AL+hErFlSB3qS7FoZxkKnmZLYHp99KZ1WijWKnWSGjG/ch/KVW37adpBW6bcPxwVqhUU5qH2rMvFHdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tBS+FuhJs5pQgn+dHjcLgjoIn47RzWy5yExcd59E5jghrQYKf
	iSzfWmbeK1YUACg53Bv2r9CpuBTrZ1v7K7P+gQ7Ry6p9uzmA3t1uIW2IPCIJgTlYE8EiW6sk1cG
	WsoSyv15tMKfyJuvtv1NLPL8g6AG6vw3TtpQNVYnAI0j1p4jsBDJFXxgeBZg=
X-Gm-Gg: AYBFou17MeZ00VoywmaJe+hYQSZDNnYrk1G7+NM3Gy36qr8Mbj2ghjSNDiwRCiMhEZW
	+6QkBG+N/H08ZyvFo99Sgu3uZ4tD/7sq7qqx2T9nESMNIx2NMnn8fhOw0bE9rAFvjfToXaznzv9
	mZ1C0gAunpNj5Gtipgg7inLYTqcPr+IrSp2tnbxcY+QtXMeaGxPr9ziHn7tvWWzsrrHz3m4w4Rz
	grgY4DBEUvgm9ypcH0LsOtRnMtGGcx5U/RTk2VtObaWV+mrPRYoO7sFvvE9XJb2mgxpiDC90XOK
	8qJo5pEw+W918I/2T7ILY/OUwjMIOgckNiFWr/mfSa58EIR7VXi8nzsFPU9Pl3oANe1EtlEeVLZ
	j8RW6G0mkwlwKn8UdzwaculihYOg61f3x3RCUaJpbayZ0DamsWPjZ0UhtWB6t6K9FsUsj6cZslA
	jd/ok3lGBlUFc4dwAG/HcCvSe7+iscu/ZclkDM6xBcDyugQnoN+ooDPslwkOcDWDA=
X-Received: by 2002:a05:6102:604a:b0:7d0:5688:f511 with SMTP id ada2fe7eead31-7d2db157523mr740254137.16.1794220480074;
        Mon, 09 Nov 2026 02:34:40 -0800 (PST)
X-Received: by 2002:a05:6102:604a:b0:7d0:5688:f511 with SMTP id ada2fe7eead31-7d2db157523mr740246137.16.1794220479561;
        Mon, 09 Nov 2026 02:34:39 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597371cc4sm8835752f8f.36.2026.11.09.02.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:34:38 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 11:34:36 +0100
Subject: [PATCH v2] gpio: mvebu: fix sleeping-while-atomic in
 mvebu_gpio_level_irq_mask()
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
Message-Id: <20261109-gpio-mvebu-sleeping-while-atomic-v2-1-41f070421e70@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALuh8WoC/5WNSw6CMBRFt0I69hHaRgiO3Idh0M8DXkIptlA1h
 L1b2YGTm5w7OGdnEQNhZLdiZwETRfJzBnEpmBnVPCCQzcxEJWrOqysMC3lwCfUGcUJcaB7gNdK
 EoFbvyIDUskdbibZvNMuaJWBP7zPx6DKPFFcfPmcx8d/7hzxx4CCVbbTmpkVZ332M5XNTk/HOl
 XlYdxzHF8puPC3XAAAA
X-Change-ID: 20261105-gpio-mvebu-sleeping-while-atomic-3b3fed029f7b
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Hxh9rk/pCtJYsrmjhty9vdemDvcmIp/ljH/sA20N6C4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8aG94Up3Lzad0RsvbdM4bLqJQ67FLi1v37A4t
 HGjsWMf1mWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavGhvQAKCRAFnS7L/zaE
 w5dfD/9wmmg6dH0EWa0/q5db/aolzmv+mxMBV+gKuTsTszPNTNPSrO0yByGZYJNHmrl/2XheOIb
 rYc02cscE3BTa1Uv/f96NY2kKFDwjcs++kDOMmgutOBlWO7AkZE3AQizIbJS/Kg7rZrurfsFCFM
 WDKOC4utceqbkCP3nhbJLljvNBJ4Na7tMWA74iYtuWmK1t2Nz0NfBJJyzmX7qSQCTLEztyUr6oX
 5WCQyTmgkfM8ugqL7vkmSOWpFXp4S7P4gS/PL9VXAZITSLxaNa6nGBTGdDVgAxYs5w2bwLpiwdy
 kpbsLMKsK1WLuKiXm32r3wC/bMWBqiSvRauRx3cwUSReFmzQSLfL6l51X4FawWYquIVPclvqox5
 tDsdJEe/c4Q9bmFnb0qx05nysgz5TEhMo9ZyzuNw81NSuMrZt4afnEsRX9aNQP5whobx4D9LFu6
 wWBEvkizh7bA6vbcI0mdsW7ePlyJOj2sKqRopEMLS0+5moq4HhQhLlAZ3gezDg6YyG4yHE49ZPE
 kPVs/82P+wdnAOslA9OvhhQg20SMFUrQkqsI29USztbcya0YmouW9BtgG3sGZQgGtL45ujD94dN
 Q02MCjkxXRtpRPuwzAFkjimjAChP+KInK+Gbc1akAN9+88UD7NrY1sZQdMA+xfo/02eZYgQVII7
 O0sqgQ7uRiFyReA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af1a1c0 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=H-Sc7SN9zJm5jhqahJIA:9
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MSBTYWx0ZWRfX9pVj95YBsYaL
 nwuiNIm/kfQPTmActHp/K8lZqDgGqTtyp1v0hRmatQHNnopZSKGGKSTVI2UlgZ3ksMsrnMrMH3P
 wdo05epC+6+iHz+UppQGi2CE95kyWA+Eu+JYGBpGGww3VPZZY7ZAbSKKy5t8qVGGFvlq3mmdyJT
 s74vZl0+rD97ZIo7mByBaTyrRM9vaB37BFKJtpATGIkXqNNALiDpvspVcDJXmYkWpbr80ZWOP2w
 Q8JcWg3jQwUeM+yG2cGbcRf/PFhLJNZxhwCSZHbZyQ1muULYx2m3vjHC/u0T1Y5rMBryxp8IbsD
 5V3lzeuv6EnGsrB7riG66uBZ/TuKPtFFT4ER/KPIIus68mTohFWKLrXiDwOcBlTBJLWKUKjSP/L
 g+nruRqRFcd9odqYMQwiorKrqH3+W6JpeOcaSd2jbO/CqFDHukZeuBgcdG/SVO8nqSdSaPhpMoo
 Nt0x5ixTDBjASrrGp+w==
X-Proofpoint-GUID: 21IDOYCVq-1-6DRTjq0UwXFEMMH7yWK4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MSBTYWx0ZWRfX/eHVblafJviS
 03XgT+1M8HqQnZDuQcPFsukJ2SWg8KCoCQgJx/ah+JWyMTBGgakI/NbRGvuogw7GPMpvoF2pH9y
 t9e809KLHWAEUyxsJ8u9NM5dbI8EA4w=
X-Proofpoint-ORIG-GUID: 21IDOYCVq-1-6DRTjq0UwXFEMMH7yWK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090041

mvebu_gpio_write_level_mask() is called with a raw spinlock taken but
the underlying regmap uses a standard spinlock which can sleep on
RT_PREEMPT kernels. Add the .use_raw_spinlock attribute to the
appropriate regmap config.

Cc: stable@vger.kernel.org
Fixes: 2233bf7a92e7 ("gpio: mvebu: switch to regmap for register access")
Fixes: 4d305c227312 ("gpio: mvebu: name regmaps to fix debugfs collisions")
Closes: https://sashiko.dev/#/bug/linux-6bee0c4f-384c-494c-868e-07c420195d13
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Also set .use_raw_spinlock in mvebu_gpio_percpu_regmap_config
  (sashiko)
- Reference earlier commits (the actual culprits) in Fixes: tags
- Link to v1: https://patch.msgid.link/20261105-gpio-mvebu-sleeping-while-atomic-v1-1-3ad7bb1c9e36@oss.qualcomm.com
---
 drivers/gpio/gpio-mvebu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 267e6d5bacd0d1c9de0ebb7e21233bc9e2cd3bad..92ce02441cc9923c51b3d2ec9c74578a0a5e859c 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -603,6 +603,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
@@ -610,6 +611,7 @@ static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_pwm_regmap_config = {

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261105-gpio-mvebu-sleeping-while-atomic-3b3fed029f7b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

