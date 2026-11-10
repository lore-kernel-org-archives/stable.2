Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318436;
	b=HCIf5xR9HX4sA5FGEgZ9XSMvw/x/2/v8rELrDjMs7CkspFQZyPKVZeF2SGN3u5JhSUxw
	 pWTihSnGL87QVmFsDgTMx07nCBsLfvD7haUV4P07zSx0dZD/nuFTIenNsSpjbSEDIP+R7
	 UzbsMfyTsqUspxlcfhLUta7LM2MX7hZ7YkawnwTJpqnBjtnSfrWAdnj3jZxMxhYkEv+2M
	 zs11RqVHcbluV8E9dJ1QrhJ40qULplJzKAW/LWeDgHKbU/xNBEqkiTyvW5tMZG3fmoLLg
	 hed6jnzqpx8olkcOtGkzwytq7sAaSP0OBvEQk15pNFN0s1rY+S4VbRWG1TfKhCG5Pcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318436;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wytSs7MahgtYGzkZdLfHUX/IsEktfM4Edh5KjgwtzPk=;
	b=FZI7pHIn9/3FmNN7kMDSXDFD1B0gqAEguH1GNr2swO727MJCU8araX7dzpGrDLDzI+ov
	 SCde/mqDS+g2d8NOduK1LokOH01PWV2BQuW1/bgBj3g2Txg4G2MVrayBq8kwMSX650K+s
	 KvjnbV+au00SepGmrgmh9uCOLz9Zmu93CRxKbaoAHNzyWxT7gPkh7TSHx1sDrtmELDocZ
	 eDx6MWsWJqvQH2wsBHjvfmiTAXHBPksaK6rMGYkz1vnpUkTvlt0Q8xLedFrONESPN90Tx
	 Tm6PcnUiCMkLe+JyGT3x69+s6CJQWTmGraBhFZOYxUIkdH5lA14sEMTU3Q8luolIo6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YIZg7UNt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEnRc3D1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF50606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF50606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YIZg7UNt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEnRc3D1
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAF0J3839661
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wytSs7MahgtYGzkZdLfHUX/IsEktfM4Edh5KjgwtzPk=; b=YIZg7UNtDBKcGzss
	JFMpYtUnfBoGK/V1JTJDWd5hEzeZGADkLJC1tUKofivDR3aHahtVKxV//ZTMGTUj
	VjbJ6+Ju8+1VpQ5rFH1vuDPScGr1/W8yL3ajwc3IhGIrMQaix1G3FIjCWu0rFPOM
	UlyMzKZhusRuqj1eoi8ae4hiINWA8vy+mZUdqjHXvu2RcbWObOwJVJKqTvfsBO3c
	2mwjyEeScxrmL3FcCyDl417p3HNoTNOHzSnDJYvQ0HEv7Emz0b3EnTSnQh8CA4YR
	QVEldW3hUUT0dE1F5f2iLW/3IYaSGTlwfs59KEGeblRn5YSY3rXomeOwp1VJV9II
	3socOw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg3mm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:14 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99859876e19so331287241.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794318434; x=1794923234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wytSs7MahgtYGzkZdLfHUX/IsEktfM4Edh5KjgwtzPk=;
        b=iEnRc3D1NcsZPa0rVSWZhET2AcUno/lCKQZka4e5kJUceQiuvjuOV+DrkwvsRGWWGw
         i2CkSa03+hIy8eco8EmkitZrTLyP5dKOOdsrpnjszjTsdR2L1cgISrIcvN7aoW5fpmwh
         lOPYtAcuTEQvivY4r8ayKeeVG0rq2FPyIeHr8mY8WSG+ZDUi8eNk5f59Oxh/ee3IEntp
         R+JLtsL11UOEl6mYdyg+UMoxUk1J46hTKG2sYOs1s2yjHChLemKn4nTcBzGtyYZZNIa4
         C3deeYlblqRKb8f4wf9j79Cm+JuB9bzZNiuehdn+kdXOGlB9Knw47wmp8XaIhmA0LbP5
         o7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318434; x=1794923234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wytSs7MahgtYGzkZdLfHUX/IsEktfM4Edh5KjgwtzPk=;
        b=Ps90LqhotMeZrX6Am2V9U8VZFeXHd5TyWMb2QLAJayoNChWmGKB9tMoLQozgejXQS8
         rrbz0aEPvP+dZGBhbWGMrKPPcD0vDgHE0PwDgZ/17/x2cspRvveiQWz6Jtk2TyPnMNwX
         8nsEI5XFvdL+YmLX7bDvK5Xjcy8F7Zss7xdOidrGSHzQYxQNTscQyqxmj2zBRYgtmK1v
         p+sBkihMUY7mDmgAMLtWJlZMmShsi25JcA3ZN4PtRzXyW9LdnVOc4IPXJs+HUgy1chb6
         /s5+ntbGo8/e1wWXRpEOSr9aOF6ss2DGq6Uq/0x1jSvYpjDfFcaXNqgQ5bqA9V1KNZWg
         idSg==
X-Forwarded-Encrypted: i=1; AL+hErH2SMcK77FoKZHIeNpAFBoPresYVjQVtqNQoRgPCXcpyOOKDHYu3xCCwj0am1f345fFAvAFEU8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uapns7W5x7W0OQbJOpFkV0E8J2GqHdpAJl/zyzgaC1/5mzcUq
	R5kE0quDifzqzJ+GjS5nGtuSCuTRMJ/Dm7NNpFRVo6hFGjfz4mMqeSPKIHkw58JdTTgJg7qvocA
	ObvWZoiYbfvdqIxl/tbbUxiWsRXY4veqDJeKnBpgTgrrXBI4RoKdR0WVmgZM=
X-Gm-Gg: AYBFou3ZAufgY9e2tuetAKxO0LmfRh6r4dyOTKUgduOd3TJLPBed/vx13jOSMuevyOo
	uqPxoakj+6jbL2AJCbx5BAICCYOuFzHvDlUnAeJyC9dUgBjPpB0cQjhy6Ak2UUHItECylhHUTDm
	TrHVb6+pRqHUYwjO5l8O9LqzYkTDVNarRrnZcE/m12SD+I/3/IpMl8aSdLxJRAJUkaSOPG3UvrA
	nd/aLp/rmCNo15rvXpFk/2OXIRQyvqHwPPrsgHK8XfgM+eV9YVG/NavgkdCfPWBUrmlk7hpavQX
	uxJCcbyA4AIdD4q9pcxhyW45Ls+g9J720RowMjI+mP2VIPw2LnQRuyf6pmIROkydjZa7ZBv7PqV
	mwzA8bgfhpsWE/TGTz1B+w4dYBH/wYm8oQiwcXgnY+uukvuq6TzTQkf/B/jJVE2wcy0HtgS24xg
	SlJCkKpb//IPu//kovD809TiMVl1c8982HMdSwNiAZRPCpaLteEKuaVdbKdFiF9bo=
X-Received: by 2002:a05:6102:f11:b0:7cc:9d47:9c9 with SMTP id ada2fe7eead31-7d301c1781cmr695800137.35.1794318433870;
        Tue, 10 Nov 2026 05:47:13 -0800 (PST)
X-Received: by 2002:a05:6102:f11:b0:7cc:9d47:9c9 with SMTP id ada2fe7eead31-7d301c1781cmr695788137.35.1794318433396;
        Tue, 10 Nov 2026 05:47:13 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02387ad9sm75913445e9.5.2026.11.10.05.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:47:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:47:04 +0100
Subject: [PATCH v3 4/5] gpiolib: don't overwrite the entire flags field in
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
Message-Id: <20261110-gpio-desc-flags-atomic-v3-4-2f463bce8086@oss.qualcomm.com>
References: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
In-Reply-To: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+7HEOYQ1ox7kOlfRzmeCQKPq1CmvSqUEEvB/5aEZEUo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8yBYrywnZ9aWE2gewHUDqnZGE3CrsSQzAF0yx
 ihOo8La4EGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavMgWAAKCRAFnS7L/zaE
 w6eSEACDBXBXoY0UAKzn412ePTCqZDS/jJWY78hlmSpAg8jx2cwLcwUcZXOWiZiDDwFtxK6C4MZ
 8mTiVu8CaJz/iHxXGE65w88MwbQNBQYtYUDJYKN1TalNLPtmBHcvRT1Lylb4UWHEj5qrg5wibhv
 WqxSCumOfTQB/sowqulgaZNkj+XN25uZGKFRssPxaKktU/48Y5jSrqHw9uNs2RWbeqFSJR5i7Ni
 polrmmQI4bDhHaghhbCPWeLkiepnrNZ8YSVZaK54m5eWN6Whs7iKk50MURIxEz+9aQ8G8b367ov
 V6aygZke6/OBIv2nsxuO7jPDI2rFYSoIe24C1M+5Tbqtt496yE+87WnobtI4xjNeW1AwS+wDlLB
 flNj/jmWW/0MG/DcOWno1Zwk6o2HaepcVKrP0ql2ltzE/vLjBS2Mb4K4cN7aHXByl+46NjbxpT/
 h5Qw4Zhnb1b0qctdPbnIcViCEwjDPUVKqv8Qa2ZsNzV0wsUldPYAiGLLVk3zqrjtM2VHBRcI1v+
 92lBnUlcsdDQ5ykQYUC+olGToBL/JLWCa/bnF8fJFBlAZO4WclqfL6LZ6l5LJW48P1plyIwd/7F
 JMBHfxFEqdIJFknBoE5Adn2fVitvh16Hm719hcDmzAVlbjGv0vZ6FXKv/DPdyQdVSZNCVIgKpw6
 MPQihoV6IIToX3w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NCBTYWx0ZWRfX/2EgicWhKgLl
 dx4/9DVtRmrMDlbZNPZMgjIQCIWf9ri9UKzYz2HdyVhx/gGMAHbAlVEvC6kibunRFITIbEaSIxC
 DlNo+DP7W3+gkizAJMkQxao7ns81iDHE30GOeNhowMWGkVIIaKsctZNHCzfe4IDum68Lv+JRiLm
 CN/HRzKmpodI0FE86WBYyJ+VAbKqYYjlHNkFdMzMawGlRKb5h5e+qvwBs8kYeihDnwbSBPaihD1
 4lPa7LJh19Y5gUBm/Vz/Vxdb+IOVayICewLVb+tcxIKSEx3ZgspOpv378FZ8Zsfw+dsYckOCuRZ
 mOhHmJX4u5RCLMkNpYnssjRXuGexhhK+qpYsz0vcLSzO8nLWvL81jWpDON/rM8/HN0yKtSHy5l2
 RFUglESDLbVnokktzXAK2oL67LfLog6XvRyz06cOzYoYbuYDzvRBKbCSNbCJIkejGIIJdinkNwa
 +2efVTgqkvX7DF3g+WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NCBTYWx0ZWRfXwWueoiXkXy3Z
 P7qQlIUGxweI9dSgWPeLWtoTFbyrfJBzf6wbyFztR1BSrRqPPon7CemrgX4eEKMH4TUK1yNE4l5
 LDbuBPAYq/0dtfKIZPKhiQvXCfW/+ts=
X-Proofpoint-GUID: IJhV1jos-Bp155rR7CzruQej6Q71QkdM
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af32062 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=m7D0vEob7tz7g0OC2VgA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: IJhV1jos-Bp155rR7CzruQej6Q71QkdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100054

Use set_mask_bits() to clear all request-related flags in one go
instead of risking racing with concurrent users and overwriting any
changes they could have done between READ_ONCE() and WRITE_ONCE().

Cc: stable@vger.kernel.org
Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ce8531a8e95dd3bdff7ca32f4e486b329a19afaf..9ebe1d398014a17bb14e7c62a35478c497f6155f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2702,24 +2702,23 @@ void gpiod_free_commit(struct gpio_desc *desc)
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
+			      BIT(GPIOD_FLAG_ACTIVE_LOW) |
+			      BIT(GPIOD_FLAG_REQUESTED) |
+			      BIT(GPIOD_FLAG_OPEN_DRAIN) |
+			      BIT(GPIOD_FLAG_OPEN_SOURCE) |
+			      BIT(GPIOD_FLAG_PULL_UP) |
+			      BIT(GPIOD_FLAG_PULL_DOWN) |
+			      BIT(GPIOD_FLAG_BIAS_DISABLE) |
+			      BIT(GPIOD_FLAG_EDGE_RISING) |
+			      BIT(GPIOD_FLAG_EDGE_FALLING) |
+			      BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
+			      BIT(GPIOD_FLAG_EVENT_CLOCK_HTE) |
+			      BIT(GPIOD_FLAG_IS_HOGGED), 0);
 		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_RELEASED);
 	}
 }

-- 
2.47.3

