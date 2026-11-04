Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806632;
	b=wCft5pe0GvXo2UKwj11QwRlESPpgbllCAZthEpv0aq5AY2Sl+aMuNNXUSbSSuR2UOrX9
	 xPCwpkuZWatkQcgbA9Dm1DG9JAO0l/Ily4vC5E3WKf+KiT9/ZdD7GNowP4g0Pkaanvsw9
	 brVjYKZ1pIXLHAJxmXWLfz9jGKArhrd1uwrikm2iYF68VLmDwgtmpEw6omV1IRUOaNQg9
	 L3M9L28pGj5GcT7ZUvNGmfgEOid7PeWox7e38HC+5qqkaeluJAttVRHtS/oAS0Mv8uLhA
	 JjNC9Da82EHM315UuV6qDW+vqVDm0wOOJVK1Bw3opb9IWP8ZBsAHB9NOISccX1DhgPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806632;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/wCpx7ZbYMvn+dKS5Ed45+HwLytHW0nEsPP9dFbtQpw=;
	b=4WmTnCRwU1TzEI8AVFBLjkzdylMAvttidxr6zAPAJnmU0UerDD0IlKQSeMITd3kyJCHN
	 Z/+ygffLMl0gY+mlbjvJgbgQid4898X3vMOc7Ew5mOkEA6xSVWoqE9TpnZFjuXFHG19NS
	 Nqy6oHJTtG/R9PPfitrwEbOnBoPbPrrEoMnlLVJJFx5xj5qY/bM+WS429GW7I7KK6Z4iJ
	 MYEjE+OA9XYd6RiXqubOfZpZpro0WVUuehc3CsH0jb3uBvaSXoZnXSU0EDjI7rrJqfYR5
	 S9w5BXtGAG1RUMwqM6ZItzBLClnURKJgWmVAqYIix0JKXEv2EzyTvfxb9Dsg3oHFa7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YBeiEG8T;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P2+QtTZs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F260A2616
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08F260A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YBeiEG8T;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P2+QtTZs
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bo4KY1387759
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 15:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/wCpx7ZbYMvn+dKS5Ed45+HwLytHW0nEsPP9dFbtQpw=; b=YBeiEG8Tit99pO8q
	CfIZVSNF4ZWuzBqjHTB2N2paNjFwWHK8RPV45aixKvUck7RkCcW/qWndPeMvl2rv
	yHEA07j9D0W67c9d6OpW5bOnL+fFadlax0jTomxNfMw5h30l2OJZo/BKuFyny1P3
	gXenoVw/guQPpOxP/l35j+3DaUxk3ZJ+H+j32IjVc2kpck3ZGZZyXkh9N0sxq3DC
	PTXyfbGYXk1/PZfmG45wtDWGINtoKDcHm5IGnVcUBVBmd3MWOniILpLs4rRoFaMC
	HJ387S4aFc7U8sGBCEsrlZWy1LbrF/tf5tywrXbYRq0RQayCJ3eJA9ySEeGnNiRs
	TO4wew==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsgatj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:37:10 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97e8be2221eso187827241.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793806630; x=1794411430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wCpx7ZbYMvn+dKS5Ed45+HwLytHW0nEsPP9dFbtQpw=;
        b=P2+QtTZsJ3uClm1xUMSnPGCrbvctppNNpqLpNJ10GngoWt/tC48379woMFaJWrWjzZ
         3Vmpu3F7WmSIuZJOb/koho9a7c+IOa9bRLjZTClOB4ju+r46NXUIvh8CXua49+UOMGCc
         EJAfQKh9Mk1cgzgPQ7QlA+nF3x+1kPiB8sEjb1wBka2Gr/lmssVsw6wBLlILmlOrbpxr
         ZGF1lpd3GMW3Tj8zYZ3m/n1Tfde7LmO8XMPcYXiPncSu/r0M8rULj4cX+/iuuq/7T13b
         sJcUPVz8QHtQey4pbqXwYJL/t7DOKumbS9TldrI0dbBV4tNkc3due5JlxvuhAQ3vuU5m
         5e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806630; x=1794411430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wCpx7ZbYMvn+dKS5Ed45+HwLytHW0nEsPP9dFbtQpw=;
        b=BsG7pmkUh0DQQ+tRxhATDXxKK0+jWgso6+i6X21caTx+fiTgB+88oPePSpMOksQlbN
         9sLXa6GHbGtMsgs9za2a9uA3n4ahuN3Ob+kOoiqQu05ORixqRD9UiTEzU1EIGKA7PJd+
         7BMkJ3qfBFdYcTaRXIhY7JiLvUzJzH/V1WZfRjlcW6UxRUOAFql0X06gblIfsTGEvOzc
         gwfpEGC/4Mx4jlfL2G0aUJVrqfHD+GrqN7GXIPnBjXqL+zZT6ESYu+lAR4hmaZgauYP6
         wlPOXgH+h6CxmOjawW3LZzHhns7ZLC7BU+RnIY8Br5LG63iIo5YX0NY70KTkRSQDQN/Y
         VQ7A==
X-Forwarded-Encrypted: i=1; AKwUvByQkHqoBykWVQYSp0byfLeBSdgz+I6LhLvncIZKgrS8C6NDqh6ojSR5VENkiWkWRfaBlevCjwE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ho+8lNxFudA+8hpKbYkpSDL+nxLS+g74XnzgHHsBZXSRE2VN+
	lH9brEs82G5c3+AZf0RkCO9dl4JKLH95vn1aZ86Jn6S8m9XEXPuApc162h4iL0dC61URM9J4MSK
	VsbeKWlVLkCbOhfMX7q9GWSl9OMCfRXr2KzWEm+fOzSuZOqvG41TNzWmL81A=
X-Gm-Gg: AYBFou2U3Ad++wrQDJJFah4Jyk+OnbAVqQUFCb1NvcCyBaMCXNT4ntpADmSkuyqVUeq
	veiWPVzx1/ySFeAbf7tQx0SvS1KQ0N7PM+anRe/kj7u1GPgccb6naBtNzMi9gI5fk+flFzsG5XH
	zfdQyESlmXsRVqrehy5xZzxJ2828nVM5ONfHsB+FXjLZ53jgSVTTFq1m/X6UW12TN3W9ffVXSGt
	Ujd1D9N+hFOLcPyEZk82vpqcPSurMqM2y950DH7HY3ef3uRx74hMfZgiL6vG4M0YI7PUqHJKcXJ
	L+tQPn7YnNYT8SfklnfyKe87PT7vtdEODZnZIMQoY8yAHjhATP7iDga9bY3T8kpNA7WINC4kZEe
	3uueJ/o8DwKdUCG7JN6LROVGsn9cU4aRkann4Hah5LECuveV1lSOGobvT55jaCFSeot1B55IRN3
	LdAQ==
X-Received: by 2002:a05:6102:f12:b0:7d2:7c63:5a08 with SMTP id ada2fe7eead31-7d27c637376mr562785137.32.1793806630250;
        Wed, 04 Nov 2026 07:37:10 -0800 (PST)
X-Received: by 2002:a05:6102:f12:b0:7d2:7c63:5a08 with SMTP id ada2fe7eead31-7d27c637376mr562762137.32.1793806629573;
        Wed, 04 Nov 2026 07:37:09 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4107b7198sm30388825e9.0.2026.11.04.07.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:37:08 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 16:36:59 +0100
Subject: [PATCH 4/5] gpiolib: don't overwrite the entire flags field in
 gpiod_free_commit()
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
Message-Id: <20261104-gpio-desc-flags-atomic-v1-4-e23cedf619ba@oss.qualcomm.com>
References: <20261104-gpio-desc-flags-atomic-v1-0-e23cedf619ba@oss.qualcomm.com>
In-Reply-To: <20261104-gpio-desc-flags-atomic-v1-0-e23cedf619ba@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=qfnK8NhwXPiksOiKAVXJenfSAZexKhEl6VecmEIZHx0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq61Eb3dAXKfqdjl8aAODE9wErfP/LlakiYzGNT
 Xrms8M5YhqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCautRGwAKCRAFnS7L/zaE
 wzngEACuLXVyld0G8pZ9KX+6UAPKvpcseqf45H9ED+mQV6iMR4xcAgYK+PLET7Sc1+00S5EdkyC
 516eKz6qkWlCGZnIft0Gkb1aS6k1VlAVYqnr7est8NtRxvx9KvMoFetHFVSDGunpI19CslZAxvC
 h4eMjuyFDHuy/OO2LOslH2s2cwc2IpcQbQYKjuqo0A/XpQ9ciOh+WMaHkGTIFyOcCiENS/E3YiB
 c+5hv/YCl41EnVBQQpDBYi7rkW+twxzxiJX3BjDYKveo+8Qi2z+zvEWKKxcsV99yaYyhkeo0UYo
 W3ExghwYV/O/oqN5Cf2tqfTOdG3ot3ZTqlZ5P+H/a9Ns7ECQj1quNOD5x2M5SllYp8PSdljphwF
 D+wrlXcEEthNEDt9MRx+TWT35mIHtiwxZTEbaykQMSUxAaq0FF9pKcjNbDL8cThrN/7LdTVaAdg
 UuyzLCy+hgQK7rhxEqITBULffMQzSZ4Wn5NyEuMC5nygUY7oEY+f869kuCsj4w52yMF71Q0Nsmf
 VBG48NelChhyKCRzj5EwfikuXvrTb/NAJ6j3zA6NLPofKcIQt3tv5Q6LR4qaYLiNIlBNNHvgMz6
 k63sMDEYJnHmLO2XHY6O2byxISL9wO2kcROh5asZ4f8CPBdzCNrnDfdyTQYI37Fip1z3c3tQ0Z9
 sF2BVtvx3iAz3Sg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeb5126 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lCfYgqX0DhX4tC7hO14A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: BSl1pWVw2KzHnADBUbMXpxAa3hugEqG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MiBTYWx0ZWRfX8Xq8+ZL3XFTn
 g2+c3mAYEDViyJMNINhlmmm0mMCb3zpfnts0o5mgm1/PaJqRH+8YhNb/Jl50WBOtVgLARR51P4r
 qleOovQx/zVAqbSftESKRmN3USFZk7KjqLp86MS0Arw2IryVYODH3pRA0kqDZMmzJjy/dXcrWvC
 gNTLWgKBApNDp+WQlDsq5Qq9bks/Jhtj8jvBR6wYjIzkeZ06Q8YWFpawRtknQFjOoR8Q1aS80lO
 3DPtm1Hhe5qwNeK7Ze/m+Y7sDNkgQAwqjS+kNSWZ8lW6KmoNd3IOUQnX+WUXLsfaE6bYJ3MMijB
 qnjavO8M23yqa5wHAg+q0vWQxOUpNlhJSFtq1vU2OWbG9hSmEJ/6ABhewDAUm4s2VkjrWXWMp3C
 hFuq0ss2xB9tau7I+0eAheQ9JlS7HRazoxDCOEx7KCyAzJJS2HOzLrVn1ov/aUuiIMIJm0DxNoF
 /Q1MVZlLGJXlx4CzYpw==
X-Proofpoint-GUID: BSl1pWVw2KzHnADBUbMXpxAa3hugEqG3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MiBTYWx0ZWRfX5dpvXBRG4jiQ
 3HVJ65nakCAaHbDm7kJ92cgy7Qf5BjCT0+a9F831N0WtuYC4+eMLQMwgMiL8WZ+m0f1/byDsb6U
 VYjfpoFPmzcIAGEuyrmMMIofxitZrg8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040062

Use gpiod_update_flags() to clear all request-related flags in one go
instead of risking racing with concurrent users and overwriting any
changes they could have done between READ_ONCE() and WRITE_ONCE().

Cc: stable@vger.kernel.org
Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 63b65b646fbcfa9ea0f724d1d3e1ac22ba28f638..28d4cf0cef70f437dc4271f82975d09dc55125ea 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2693,23 +2693,23 @@ void gpiod_free_commit(struct gpio_desc *desc)
 		if (guard.gc->free)
 			guard.gc->free(guard.gc, gpiod_hwgpio(desc));
 
-		clear_bit(GPIOD_FLAG_ACTIVE_LOW, &flags);
-		clear_bit(GPIOD_FLAG_REQUESTED, &flags);
-		clear_bit(GPIOD_FLAG_OPEN_DRAIN, &flags);
-		clear_bit(GPIOD_FLAG_OPEN_SOURCE, &flags);
-		clear_bit(GPIOD_FLAG_PULL_UP, &flags);
-		clear_bit(GPIOD_FLAG_PULL_DOWN, &flags);
-		clear_bit(GPIOD_FLAG_BIAS_DISABLE, &flags);
-		clear_bit(GPIOD_FLAG_EDGE_RISING, &flags);
-		clear_bit(GPIOD_FLAG_EDGE_FALLING, &flags);
-		clear_bit(GPIOD_FLAG_EVENT_CLOCK_REALTIME, &flags);
-		clear_bit(GPIOD_FLAG_EVENT_CLOCK_HTE, &flags);
-		clear_bit(GPIOD_FLAG_IS_HOGGED, &flags);
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
 		desc_set_label(desc, NULL);
-		WRITE_ONCE(desc->flags, flags);
+		gpiod_update_flags(desc,
+				   BIT(GPIOD_FLAG_ACTIVE_LOW) |
+				   BIT(GPIOD_FLAG_REQUESTED) |
+				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
+				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
+				   BIT(GPIOD_FLAG_PULL_UP) |
+				   BIT(GPIOD_FLAG_PULL_DOWN) |
+				   BIT(GPIOD_FLAG_BIAS_DISABLE) |
+				   BIT(GPIOD_FLAG_EDGE_RISING) |
+				   BIT(GPIOD_FLAG_EDGE_FALLING) |
+				   BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
+				   BIT(GPIOD_FLAG_EVENT_CLOCK_HTE) |
+				   BIT(GPIOD_FLAG_IS_HOGGED), 0);
 #ifdef CONFIG_GPIO_CDEV
 		WRITE_ONCE(desc->debounce_period_us, 0);
 #endif

-- 
2.47.3

