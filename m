Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806627;
	b=VS2dty58WAdu8dVC2st8ZGGL8RhG+gADh6q1YiAumUO4hFy+/xGf+5TKip24H2DDsFBP
	 TOgD+X7ggpuMuKTNPYBjkIqS6YF3rwjm4267Cl5UhsHxQOl6bBBDZZ+caDUh4QngnZgrc
	 Qe6yp8X7T3JxwRLKiiF25AZs6CzYOmDt5dOtUuILAqtDAdP/8Fc/6rzONCOwPWaq6IIO3
	 To9Dw90oa/xz7IrKC8w1gCug6jTFEFYTV40JhYBlqjP6Up7YcLRMKpNYhUeCx62Uf8PzH
	 8MUVtf51tYMwqNZIQTSsV+5qP7DWwL+oWmIykU7IdzOpMWAUfMKQJVHjS9DpfgD/ebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806627;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6VkGul/A8qLYHFVGluV9qcJV3TfbgVqP3JtUTvoLxT0=;
	b=DfOpaZUEjj7QrUCXoX5GFPMLNMlqICFng4ZYwq7yZ3eO6dKYDnP10WQ98vSvtcNTP1gb
	 2utN0apDjirimbN7/QufzRaAaqXh0aziykXv27nPcoW0NA9RYc2Z1a4ez/xTDZhE8us2y
	 9TETCbCOzM+f+EmCFzfjSoefhzpmvqKoEN5EuOyR+2frSf3j+0/OcDG2Ebyk+UVehpv6k
	 13bw7FvhKXi2/OCERhlKCAq8iPDZMT4tn0l74Fukxb2VmpAKt6HNDP5TBK4SFdscvnZqf
	 ln5dx/Vh2uNnELq6GGg0UbcSd0fxLp7Fyol+npaSpD8S7K2G9H/PmAXECtD+wbhcSeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NReqiMPk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Q2/yXPSi";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A643606D815
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A643606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NReqiMPk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q2/yXPSi
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4EHu7N3019317
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 15:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6VkGul/A8qLYHFVGluV9qcJV3TfbgVqP3JtUTvoLxT0=; b=NReqiMPk1nrl9oR/
	jprGixl394gSRVV0EDX9mAImS8lZmyupSE9k0SjyfOZPj97Dp5XVkqhjF6Os+GZm
	AHTd9m9E4OQ74OyOSrDkK3v2MUXKBYg7P4DYhojGSVXl1cIyzLy8tH1dEsVgNmd6
	QN6ihMwCebWtQFGvVX9WXH+QaZOYBV41FKjAUmkXx4DdAeCiygdq2StTodqVO+tf
	zTrWEe1SjGn6XKa7ouGws8oSPB//D/p+VZ9OxCpHpL+zlt5DkuYzAgFIdaIUpgyW
	uFuVoYzjH8eHriMWGz1pouRRX1nkazjbHaj/mT1Rrl6cUfpsNQJPMW6yEx71hTP2
	CmQ0Hw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bj09hn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:37:06 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91256a7b7b3so14152226d6.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793806625; x=1794411425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VkGul/A8qLYHFVGluV9qcJV3TfbgVqP3JtUTvoLxT0=;
        b=Q2/yXPSiYh8RgBANaBtaR9NtCARbFjXm4e69Hyv3cAKKLfy65co44XEU1ZnbprHCgt
         8TvvPbUNazkKSsG5Czksi9NeUlq+qOqzSXb1ThhagLhkahWttPpzBgi/WG6RlDsoCt2k
         xWEEJA+U+EwCLFqoNpLX2ic3NgjnI23auiuPPIRTMZgZH43g1VPF/P9MZHO/8jrT1/p8
         Lv2f5IRNJI0m6Gb0FnqvJMbNYviA+VmGCCTfS4Oke+zn4qDRsAVPoi2jS5prRZyQJhJz
         yBEQgwGOE8oHHWoHxxqn8gmhK8sKOhFNAdzmTeG6VBP69roT27lREvXEy+J+AkhBuOpw
         NFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806625; x=1794411425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VkGul/A8qLYHFVGluV9qcJV3TfbgVqP3JtUTvoLxT0=;
        b=zN+8kVjYBohzYjfSORBCt8cf8xngw/BWssHyFISY+g9GfTQJ+xNFLd4WEtC6AP+d8L
         5inm/f+DQ/kLBdI3AGRSDFdmdtNiwcyd9hRLeYzsrIJGDKayeQFq50J4v5Kci0S0f2C/
         MqJuq3/MTyu254LTkBYN1AHqdn+kL+pXKscwSn5omBxWXBJ9rdEdoRf5c/J7m5xJ/PH8
         mJX7LEJGat2UDJHKVbnTGIwh/iZ8hSDD1ENyqsAyNbi+10OZAiFXigUVS/Z0GlkWAS9b
         pjPJORpLwAUSCdTDGGjjhHdjyU2BmIXu/W7T29JUQPzUq7rK47KtNjzofZ1GKYeAyZHd
         Ucrg==
X-Forwarded-Encrypted: i=1; AKwUvBxLpecf1QNgkVKkfFO+sIkADDd7zLiAxIr919a26eyH6ivkZlIBtOxeXYbQA2KRicdQi0LUnrU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QQPiAAanCZxBx9Ts9jEljh4O/Bv96eAK5NSYgGEzTxN7G/pwY
	+3ujoS0A8XcPhBx7XL53pIcyMTyJufUox2WFPwLplLr1m0XDQtbQ6+9z2rl3hmD7ZU4dg8O7PSJ
	Y56u0zFKX8drmOm/iwG3kzmlktJcCTj+pYdPtgzqJ1Miv4AFTxB/cFBfrmUw=
X-Gm-Gg: AYBFou2HrQqcqhUhgXaUTPWU0JOI8+XTEl9e3Dyt3DhZr5RBTUTBD3+FsMLSRT/5skZ
	oqJrO0/ZX3m561iPIq0QRj3ztA6AClv1SqiduSj+0ypmuBEyJFS2oMHhGC1CbU+V8V/y3MG5lp/
	D/uq9mfkIgJ19VB3N9zDS5T8+V8P0H7yRN1DqPe7w783RmhlXmuMFcmmw8Gy7id0/LEL//3pNvX
	RSiGjsxSiGS4UQ0KTj8tTay8YkT2tHRIoulTHqIObhVEpM5RK40YVc3xv6kl1mxkwzfSED8Ld5M
	pmxvT3qVqUWk4Zt070zX/mNU/UJvq7cK2gpJjjaqrP64S241JVdNTsqaU+OJo/sgsIUQxr0STMd
	iIOHzpnqiDC5i1QDiKNHCzyC+RtT72SdXYW2qeLyZWcQXvLPwrH3K+LVQT0oMOR/h3qaDdKSx9V
	h/dQ==
X-Received: by 2002:a05:620a:8806:b0:93e:4d74:68fd with SMTP id af79cd13be357-944217b2aeamr2673124685a.65.1793806625234;
        Wed, 04 Nov 2026 07:37:05 -0800 (PST)
X-Received: by 2002:a05:620a:8806:b0:93e:4d74:68fd with SMTP id af79cd13be357-944217b2aeamr2673121085a.65.1793806624817;
        Wed, 04 Nov 2026 07:37:04 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4107b7198sm30388825e9.0.2026.11.04.07.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:37:03 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 16:36:57 +0100
Subject: [PATCH 2/5] gpio: shared: use atomic set_bit() for descriptor
 flags
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
Message-Id: <20261104-gpio-desc-flags-atomic-v1-2-e23cedf619ba@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=sMmWnya14YIAq0vwSErMArXF2T6bT5ovzCJ95r5ENFU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq61Ebhf0q5C3a8TYWNX2m3wEDzl1DfFdXy/QYM
 Uc3c12MwyWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCautRGwAKCRAFnS7L/zaE
 wzcED/0WO1uAMKKGnyIlXKcueWgZ7lHWtYfTCFx66uukryBrJITMHy8+f6fTDEbV8kABF9vWNOk
 w3BhSDj8lL4Yb0/RuS4b1tCqLyjMQt63kup7Gh5h8KWNYzwkLrcZhRllGt1nUQfeeERmFvWpXBl
 2eyaV5pbmnH90iW+SKYhehkS5IzMu4UwH3SCvdsTf/FxUPGs9C9ZE9/bYD/eKtYPsQzibVLtJCz
 GFGsuPrZ56I6fq+G9TPRnVBvJqJAsUE6V+m93hVGSxBhXiiH7meziX88yT+uHnxy7rkHb94jsRx
 FCVO6ai7oqvANh/LCAzixbXKyPvLHcaRzYIDSTZugikWpkbWKrA2TwBdGiPBQPazC2ybp0pfMXD
 zZWUiW4+WV/mieoxu9s19Y+CKs24GRIgIp3H1bQ3lvL6eof/oVMsKUragftcx7J2uLR852Q9B1z
 qd7izYni6PdlYL0ZMw2cUea1dhnDs3fmIeGWjvGKLugF/M4W0YlQsLvYXMMylesl2lrkWVhlL/Z
 /oMK7BP3Oj236LzYPEhN+mx92x2lOUFJpncasU3dwXAYRcqD8XCmBk95O6VciimEAOjCYbv8okv
 TQZByt3KdgcJxbrPgBOmvkdN/sVXQsQHLoNUcJe5rgYJr1Lb0I3Sm3iTsHZcsBPC5f3OAzz0KTd
 E54ilmx+nQcmN3Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MiBTYWx0ZWRfX6OEritRrNcp8
 kzI6/H2rl3+imhEGvPQlO6RobwxK0ZuuM7kLR7IBKIlTomQeqLcUBbqjWyVuREw1gBY9wJs6EMu
 U3VImwCsNXf7KeHyLfw6ArE7+fou5thOucrotgRLs9I3us77p15Mr2ekCI/XwcWsEXu5VvI8WIH
 ZbLxWEZsugB69mtFOuN6mxInetLKMbEcX94SAoSiG0CgZZMGnxS33s5/i/CgSR73HaaHHtxE7sI
 vzZaH5Yt5ZidtviqaTl5wOB7xGRiAqP0At8z7rC8V+t6wMjZGgh/f3qonzVorH9BktzQgMNgzqE
 aDZSbwQm47g7u9RsXYI+vnOAoUAuiQyUOFkmt4Xx5p8ZcZCTHKXKlXexLJT2iKiUBoe04vho53J
 iGvtkttp33GffKstLjBZ+IDd0SC4Y95JDDQeZJTPgTVjt5j0uhrExxVA+WH8nKcbrDHyOE6q9XC
 au6+CwTLPcgHjs8VhFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MiBTYWx0ZWRfX8ZF1f0JKJ2ui
 j7KMtMIQLuk7StDY/ZP1bqLQpnZFXAdEzmY7UHR9fAnC5R/aJmcFgofegIgn8jOl/Sd3fxD6MZm
 CJbk0qMEf/9rMrVJ7ZlnEoxRLvBhuBQ=
X-Proofpoint-ORIG-GUID: ZNiTt_fD5IO2lz_-bPYIJwUB0rc7Foca
X-Proofpoint-GUID: ZNiTt_fD5IO2lz_-bPYIJwUB0rc7Foca
X-Authority-Analysis: v=2.4 cv=N/u8hG9B c=1 sm=1 tr=0 ts=6aeb5122 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=H6RLajfuJ0QrpAsTGAkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040062

Use the atomic set_bit() instead of __set_bit() on desc->flags so that
every modification of the field uses atomic bitops. No functional change
as these run before any line of the chip can be requested.

Cc: stable@vger.kernel.org
Fixes: eb374f764a70 ("gpio: provide gpiod_is_shared()")
Fixes: 310a4a9cbb17 ("gpio: shared: shorten the critical section in gpiochip_setup_shared()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 8c9ac9d9330490b17fb3936b8758beb97a308a15..d94fb94f31c2f487d2e45924e11c33570466a0f1 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -532,8 +532,8 @@ int gpiochip_setup_shared(struct gpio_chip *gc)
 				 * This is a shared GPIO proxy. Mark its
 				 * descriptor as such and return here.
 				 */
-				__set_bit(GPIOD_FLAG_SHARED_PROXY,
-					  &gdev->descs[0].flags);
+				set_bit(GPIOD_FLAG_SHARED_PROXY,
+					&gdev->descs[0].flags);
 				return 0;
 			}
 		}
@@ -573,7 +573,7 @@ int gpiochip_setup_shared(struct gpio_chip *gc)
 
 			desc = &gdev->descs[entry->offset];
 
-			__set_bit(GPIOD_FLAG_SHARED, &desc->flags);
+			set_bit(GPIOD_FLAG_SHARED, &desc->flags);
 			/*
 			 * Shared GPIOs are not requested via the normal path. Make
 			 * them inaccessible to anyone even before we register the

-- 
2.47.3

