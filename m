Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220040;
	b=uY4QPjxeU7nFawRG7BFJIFfQsIapgtOKLQSpaqzeyAGNROX9zJLBuj48Xg03mYwteEqw
	 AqGpXNXwJnJHtTTnqyMRlNC1z663lTy4UAhqjPaWYuRbArMax9FBQ9WknHZiWPFHT6qUm
	 5jITrAETyDdNDvNqZ2kvIj2qm7O9EuIMrJbeI7BI3OGRVjsJNlkj/y5I40dZ4l1Zlc6t9
	 m4LGNWEjt7KGh1XQWTe1sbXEbyLJGtB4Tvg9QSgW522DsBOfD8RI6AwJMdGcA3+aDsFfl
	 +yS1Aa3/TheH8dEIWV2AJe3wnSJD5np/e8g95hfAsBmoSBiyLqMcADTRtoSvpiNNytQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220040;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vxIqLlqHQBIFPLmScv9Sxb0MBD7maGPGOlcFyAlmpvE=;
	b=hGMyJ0Xwrr/CFDpCAe/AVTk0Q37ehzH3HUXjriNDDBH9H00tk8mSa05He0lRbMeQ1p/T
	 DrRQKUfG74wQghSPYhcgWjT9iHbCh+GcfzRPfCvyT6kP4JZ73iOUzB2AiGpbWSeNhsbDx
	 B/vLrumnJa5ZdREaW1bEhv6PZjBbF7zvZnxal6nJpoiaVhxlns5HAMKOJv97CmFn5i8RN
	 mQpNkOspMooxyiCFrJz3egOEFgm+fZtWnDfLkDF7+654HUNUMj7YiNKO6pU8Ul/jV2p5D
	 XCHZIE2MuY7WPsjH47Y+YqEfiExwfG32nBdTiCCVeri/37qzy6msps5U5FtWO7tNV7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m171uR2c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LHdODxl9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DD606D83B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F7DD606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m171uR2c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LHdODxl9
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A99uxgt3792123
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vxIqLlqHQBIFPLmScv9Sxb0MBD7maGPGOlcFyAlmpvE=; b=m171uR2ca1CIs4SN
	xcafXoyqukjRLI6SD/NAZ/g8zvLKvXx2YIXg6KBDXSyGHedk5OigdW/BtH/lvO4i
	KxxJxMGZc8cgLajkZOfGVbIDSct68GMXK8W/5e8qTROsFX2gBlYbHGsDhK7CfDFO
	85j3xeA8B6VF4z3jJCQZ9FI0OMfZP9j5nQRuM3qXdreisx+ffb8EjEsRqQWFudH7
	6YfWxqPLn8GQw88D0HUVsBKV5sxm9yOiV4NG8+lk+OMHg5el9G9bi9aEeTv/Abrz
	6g2VYI6u5V0A8ZrkfQi7+ayvlbCdX2roANFc/CwWJUT5Bp2kbZxkCdU6EJdveXrj
	mTKK/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsuagwy6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:27:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e92aad34aso193066085a.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794220037; x=1794824837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxIqLlqHQBIFPLmScv9Sxb0MBD7maGPGOlcFyAlmpvE=;
        b=LHdODxl9qIq3IXvYNQuJFNj8bJwlgEJW384iEea7qw2+16wrPLlJZnV94hrNWFwdPD
         gYBHI9FQ0A0vOt2kpzrFcdE7rZ/li+BAToxmtSJoff+AMY58xYDTGeU85Voe4zxAYkRU
         B8o/NyJM9u914NCKnwOlCvdkDwaTHYh6BtLV9AUqr1Fp6RGjFtXpgYN3kd3AQj+aVHRC
         4mQWZysWGoCtboACuTYG1B/J/AMz241o/eoP6lrMbhR5YfeujkNWcVZUhmuXj8zI/v4O
         L6Dk1OM4GY4k/J+ZTZ7xbsUiFFdoLudKdjrqwKzKI0Mb1og7e67tWPTZeL3vuXfysinL
         T3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220037; x=1794824837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vxIqLlqHQBIFPLmScv9Sxb0MBD7maGPGOlcFyAlmpvE=;
        b=s4YvJMUunHm6JYyHiKq5hoQo1ZUgNvgx5xIDfbcx8S8T+3Rw+co/FzTGnT7ZtGKeyX
         UCrVFo+WEIRiT04VOnBgx6lgxUGsgoR/bu2ctI7srfGE8PjG8gsnmPByyy3kPHz/Un/1
         Nv5RGA/6n3lWWCY0EypCdoRMUaIXXg0+DQd9jjXRh6jIqBZgpJmewr4vWxRgsyQXd/BL
         heIXndxegZh00xbztB8//Pji3zFgZXDQ0Ze94O19b5yTtl1+iZ307xO0bbU8vEDbgQbY
         4hD8tIRdmIY5SsyMLUjJ32Dz9d7vNJZyJk5GllcxCrzGKx/KFj2micM2zXSZHpB00Ix9
         mX2Q==
X-Forwarded-Encrypted: i=1; AL+hErGvqYazm3uyJLVPj2zH/3jnDMLqrYcmpxkElDigVYyZDZ8qNvqPp4iXIDIBXqDMcEDwaf9y58k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZXd57rx/pXNcUEa96Nn32+XUhqM19/PongXdUUr2Yjo5AlEIu
	3Hfd5vD8/GMXGYPSzBSSYFCeX4WuUdVmP/VjlsW3MDO/Ig3E2eRtwxgfhgGcCG3+5JISqSMB8oh
	1hvOkeeWItJoJnkxtQUjFfPDLlZMS+0BhbEBoyY66YmqDSkPs95bT0WEivwM=
X-Gm-Gg: AYBFou1d8kI9E0TErE9acbUJ0xlw1Pquq6wR9i/3j91xdz+bIW44V5UDFbTctH/maZr
	DsCbK194aU70noI1pXlea2xU20Ky3HhZOlTO54hXk8EfkZSftKj3I9OMoce2mhKcgWswHsamTno
	YEL7rlM8CFptmitV43W+R71+AO/rZzgarHwuAcPQeBG1ExQlpcqyhb8BvaQrwFmCs6UL1V06Ol+
	zKqgSjfFVZYqvbhGMqj38AicDTxI7oW6gosM+uoXhkelthperqFq+wVzwYYlpkQUIFrxgmrhWYL
	FcB105k/iI4k7AnaejVmuchGkLt+5thokDa0hu0K5/qulDZFTmYy7RYH/9qWtJrjJlmBmFxChJI
	aHfDPawTjVPj9m2qP5LYH5eu5WGsoi7zwFuT8JzuqQP8JNZ02moato35d5G/wYEeITgrdfURciD
	aFZKbCD0WhEiMVwP3QnBE8tHkot+olTTe/2iVyy7rH3Q/f2piuDQTaM1clWNkm2Us=
X-Received: by 2002:a05:620a:2b46:b0:93f:e52:40ec with SMTP id af79cd13be357-94784916c8emr463470585a.81.1794220037333;
        Mon, 09 Nov 2026 02:27:17 -0800 (PST)
X-Received: by 2002:a05:620a:2b46:b0:93f:e52:40ec with SMTP id af79cd13be357-94784916c8emr463468785a.81.1794220036886;
        Mon, 09 Nov 2026 02:27:16 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad4d1sm237381545e9.5.2026.11.09.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:27:15 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 11:27:08 +0100
Subject: [PATCH v2 4/5] gpiolib: don't overwrite the entire flags field in
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
Message-Id: <20261109-gpio-desc-flags-atomic-v2-4-c4c54b476628@oss.qualcomm.com>
References: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
In-Reply-To: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=eW7d6lPWl7JriaxL+uhRZPNurMSB5KL7r6fnnNoTZzc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8Z/7NZwQ0eloe0hUFedBEHfBkhMOZQUx7lAkp
 NvmON+qYaOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavGf+wAKCRAFnS7L/zaE
 wxR0D/47Vd+uhH4UtFj31MSdEIBL4QW9yNIK28Urt611VYkzrDhSvWvWheZ5dw0Vw5Useug87DE
 GeWTeqrPu0mUnCvYbfwe/LEsQP25WY7ADS4t6GggvUxfB03MEhzzN6+RFBQnsPJbVeUcCDSCeRV
 MtICCjMme08661JY70THwjgTHkquCXJH3wBFaZrRsQyh2YkTXck0OijP58PmZcXvicdWfAquFFG
 7Hpt3swV8EcbP/bQgRGo5/ZufyzA9rsbIv7pK1Qhln0VwXXHlu8YZtqPuf0a0h8BRSuLRom4Dkx
 DQDzqf0yQWdTN1gQWaofFGLHt3YUTrKOZoZe8A5clxkz4BqLNNxS/RWd707rX2N3aQl0vkuka5z
 KFnF7iEXbEcgDUJawtS9jurDP7eKXGNri65arJ0zi+6si4BTLOWJWM9Jz0oCyUMK6ln0zqeuDp5
 KLD/Sikzb5uJ6s2R35q3GSveTyI4r7kvn97edFOFyc8kSnzXdKkaeTOum28lQ/mPckn6odDrdY9
 4AMBvu8YPZnGK2oLdapMOQ7/mtHMhjZfeQUXUD6Z1JVw8KtGepQCMT5V84xL71MfskIwDNjEJSl
 rBnYLtijSxQ0guZlVKt1gYvvFNv4teZRs+ge/VjaXDIsPOODEtEnh/Vl+YuzI5NNudaSO1l4uqm
 No+4QwkmGC2uv2Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MSBTYWx0ZWRfX31eN3wuQcer0
 MnONJZ/5PSl21jO5gph627EOhocXTD8ckw2f2RYsW7ZQbwCOokX1jTnVM56bcF6luUV3ofKYDiU
 AOPJDmb06+1GP2FTqF817YVpMdOF9vI0zB86cXuvk5EEkaVKsHGpmYiWGL/OumQwMs9LzCiS2WO
 +R6Af3l5ENKvFXU6IQhim19V5glfYNuyBNY1SjJAxMFbIu99At9sXqSGus+wxXeaPGNHXKYnudf
 IgTpzc5KIflTYDsPlsPKvLO4xnuO7r7bZmUO8nqMUjJrsnadYFMLFQy5HiD05X6BVdEffVh6eYw
 YBpSaVQs2QsnKiqLUWedYj374nnuuOz8YkEmjlBQpnHUY59cy8nn06FI5WKNc+wYyjHofrXqs7j
 ex4xqFTN0xAE9PUtnkZtbgXkD+oi/elukIo98Vv0jDNaRHyHIPJPys59Cj2wncbii0Bg52DcA8X
 EXEI3bqnR3bZyYHZ44A==
X-Proofpoint-ORIG-GUID: 01GIhgKQCrzMdghI94fIqaGLmeuJdFzM
X-Proofpoint-GUID: 01GIhgKQCrzMdghI94fIqaGLmeuJdFzM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MSBTYWx0ZWRfX1Biaf0VJlfiQ
 G9K2YnTuPu5A0Dc+eRnKyRk1G/uwYFnL9MDL1H/sey91Lb58xnZxePergYjnvBwDALhToRpDyEY
 RKpOnfxlOHLPodYU/3i0vI/jS1BLMS8=
X-Authority-Analysis: v=2.4 cv=V8LoQuni c=1 sm=1 tr=0 ts=6af1a005 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=obTuVQ2JAUH4m0gggDsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090041

Use gpiod_update_flags() to clear all request-related flags in one go
instead of risking racing with concurrent users and overwriting any
changes they could have done between READ_ONCE() and WRITE_ONCE().

Cc: stable@vger.kernel.org
Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index af2d67d977f4925558ab77c34b37c3c29bd12a6f..4c9c524389ca13e422bca8c217b7f47477cc0dd4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3,6 +3,7 @@
 #include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/debugfs.h>
@@ -2696,24 +2697,23 @@ void gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_GPIO_CDEV
 		WRITE_ONCE(desc->debounce_period_us, 0);
 #endif
-
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
+		set_mask_bits(&desc->flags,
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
 		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_RELEASED);
 	}
 }

-- 
2.47.3

