Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0F4E36F7
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067162; cv=none; b=RAmdkuymbZyjL4UOKIvxpM/S6w/HmMCpC1tSzV/DGAHEXfvPYUWqX5EQNpN48msj3tWDX9xyZqDOP3xjlxfT9Az72xU/Or6Fvwj8jV1wJetABuzvxNn6olP9RhVJ2zLHBI0DT6V8Oqg2TShNYK+V/z3bcb1n5E8eaTNUHqsyUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067162; c=relaxed/simple;
	bh=sU8YM/Lv9jhJB7+qfaFKt+EHzA2IGo6EAruYWM5duFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qY85SxIWLl4UATuo0HVrnam/0ODM87/zR45NEYVp1U3yeoRY71GK/P5CVGXy2mTeITXE6buM3jV6lF4wnEWgco3KzcC1RzoQx+/HpqaN091Nl2K3PLn2ppQsBSU9mhjKEQGH3dly1xi/AxhaAW/HssaRhaAEY7FnPDTzttEwlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/97UB/U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vo1clkL9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/97UB/U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vo1clkL9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M8dTtU3675351
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=J97ImxahL1hnRJtJGqEDBE
	zyrU2Bx1f/aAi8m8fNvTA=; b=Z/97UB/UisEQfWAEsRn5DMNRWwg6jq8EvIZaxy
	P0icmhql58NzbnrB7HvHftyJCCkG4n57xxUtXN04Rmy07I5hGXGQUw/yYwuJRbh7
	bYZ9FvwTVxQzq4Ty8R/b7ITH/S22bZjnPYe+h+Rujf0v4XVbFt1SMFJraG/s4YYU
	YjvAEZ8ZYSLYzBhYpDX5XC2e/d9Qst61WS9TkJs57IF9qoHKchOQ96XyYZfA1DSa
	7oWgJ74vuZuMHdDGL1GCeFRgi3/pmHWRJbrlJkSx5T6IYn3Ix+/l6NQ/FpdebZM0
	N2kgTOZPXXfB0ljR98W9JatStppX0YMbLE4HFxSuVt+ty1kw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guha5saby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:52:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93be6ed214eso580692185a.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790067158; x=1790671958; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J97ImxahL1hnRJtJGqEDBEzyrU2Bx1f/aAi8m8fNvTA=;
        b=Vo1clkL9fONw7waI7ZncWgwVbueGGXEwtQqO2/IZk4rcQFWW+6rvTLhfqiCQHfS6+g
         TEyBZaX86iGeN5nN1haRg4dt034NzLftcK6eBP70u5lmmch3f0Bx8JVfKV4QOxmQVZ45
         TXhZDG1HPXLEJXmQanFeXPNWYCOSwzDL85I87JKLbds5d6il4Sn2bp3kE4yCwkhxr90R
         w7QtXPuBm37C2rk1XMAk8DvPK3eCkSueSfbU+/z3DpXNqvDKAqNTjW5VbgE2ewl+8cgb
         vskUf/5FvIHxvYQA/VwcTLbhlMreGAAiJADxy0TwvmDxVL5Ncw8TsGT/gjEa5MMsLP+q
         udYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067158; x=1790671958;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J97ImxahL1hnRJtJGqEDBEzyrU2Bx1f/aAi8m8fNvTA=;
        b=aerDbd7Zz7sKUS4sbOocLyc7Ecrcho8jOFj1R8HuQIKcFKap+qTF5XjK3ixWjfyDS2
         lYd3cVAS+A8stKu4PGq8A1eI8u3jQy36COJ7jh/4CFGMxL4UdzgriR7rCkiQuq7nAsiF
         8iIEpX+KmjgiVZDOcq93I6wOG/wEE/V6YuCf9Bbp1Qf5jOH0SEj7qI6+kMrkLq6uqCRU
         YVgvTWZu6EsRptO0EraeeDWeyqiqlExDlRJr59D9GvtmwLdrC9uIeCblUn0nQSCroSHm
         aXro/cqPEIDQJJxUK9XiYLbFNFGtxZ2n2oDcto2oY78cjI5Xywn+Uok43mSx45syVeZL
         B3cA==
X-Forwarded-Encrypted: i=1; AKwUvBw12zxUXvT6CRPO0IVFPhLKEYWFXmpjRhVxIxhAS2zEyHl6g0+wxuUeRtN1Qc1ofhqex5Oc9fU=@vger.kernel.org
X-Gm-Message-State: AFuF++mRbLoWSEeVp8zRgjgjlMCt64pY9ZTcpbed5BHEBRX0SyCQYo1u
	A12jwyZSZrqPOVFQ4BDSRE0MOkEqr1ULmijoUCYWMNymmUdebmaT9LkfarOGPetWsp3v9MaLGN4
	tYoFF1T/lG8u1a6edUj/87KD70MNV0s20TdFgXfwdutmmXJHGcoGehYMqLl0=
X-Gm-Gg: AYBFou1bH04ZFpkwXfh8YN3iuxQ5ZezhhuIf9UHCtdy/t9F3ig43JuMOOT4l+RF+TkU
	vQHdNGYXNd/LYXZf8IGouxIAOGusO2gNYbNAGE8wKpQAX8mVVbveMMK56I7YitoVBwDj29j/Bas
	/oAHCYQyImWIf5evK6j4lc4JGTMrGzOBLc9GQCBPv0J90J/xM0i7mN+123/jnBSwGx5OQIQDFWD
	qvr02ve8FPZaGd0vO+Z/8K/cn/Py+X2EETO/UxBgASp1lYas0v+vjgidcN19OrQlRnBurKXqPAh
	NzieNtUh6l2e0fQMjDlw/Mjjh3sT2ltiwNPY7W+vu+ea7VnUIOMcleFqLYNuTZj3YgAhbdLDJmG
	OUVXbL2vWFdubNWjylsGz9LR22AI=
X-Received: by 2002:a05:620a:26aa:b0:93b:d7a0:d9e5 with SMTP id af79cd13be357-93c19a8404bmr220516885a.63.1790067158072;
        Tue, 22 Sep 2026 01:52:38 -0700 (PDT)
X-Received: by 2002:a05:620a:26aa:b0:93b:d7a0:d9e5 with SMTP id af79cd13be357-93c19a8404bmr220513885a.63.1790067157597;
        Tue, 22 Sep 2026 01:52:37 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862774882sm3474043f8f.13.2026.09.22.01.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:52:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:52:28 +0200
Subject: [PATCH v3] gpio: cdev: fix kernel stack leak to user-space in
 error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMxBsmoC/43NTQ6CMBAF4KuQrh3STvl15T2Mi1JGaECKFBsN4
 e4WVi6McTPJm5f5ZmGOJkOOHaOFTeSNM3YIQR4ipls1NASmDpkhx4yXIodmNBZ0TR7crHQHPak
 OruZJDopE1UUpCpURZwEYJ9qLcH++hNwaN9vptf/yYtv+xXoBArCqUizykpJSn6xz8f2hem1vt
 zgMtukeP0QUP0UMopQ814lELlP8Iq7r+gaBIhrCHQEAAA==
X-Change-ID: 20260917-gpio-cdev-stack-leak-fixes-84ad8918a6e0
To: Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4833;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=sU8YM/Lv9jhJB7+qfaFKt+EHzA2IGo6EAruYWM5duFk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqskHPlwALBUVkGjciO273cIlD4YYwi3Uy1qm+6
 0rttrnA9BeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarJBzwAKCRAFnS7L/zaE
 w88YD/9CjWvrB5amDTxr5klpVw5NyNyw/pAkycne6omU96TiwhQJz7/8+K/mGTs2ITr3BNZ2irX
 SPpKLGIypbIzz4x8f3t3GMF60L6dELSU4eE52a4+jLGUgeBavvDmUKk88bjQNF6YThLFIJ4/9jm
 gLjVK3Hhyc8+FNXuJI04pNRi16qV0KpGJcx0QGPNKnPayNQU8Rr4wqo8ylxEQefzuXkmHoWUJMP
 F3JOEe/UBy0E1WEeVsO31zK2Cblyr+k4W6nPrdVCyQwpkkLSja4l2ObBgyAK6/iuqaF2fug/0TF
 nMP6/FzimwQLwX+FVnRWsyGPrPpyJ4WWaTe5FHTE1cw3jqx23WNuJ03bJts+PJP6NtLJ22FX97R
 p3Z8sFmrZjMEgBDNIymINgKmAzTYrgOh7JuagvQiezxbNBtVHcQlR8ZWhsnW7m5H+eZDCkTpUWe
 bCTzKE9s9A7bskB5FCMZW3uerzA8ZcfP22Em3nX7BLxVqdMGs0ejKyPuY2OjblHQY+espYeg0L3
 BqfThKZBC1MbwQxTvxbR8zImpM0PxARYDJUDGsMM4fNY2SOI6aMHuSFG/l4iav8LnRRFeIZ1ZS3
 fkVl1DPjl8xlBavfAu1tV6KN0SGMxj1tg5WGKQ1XNkMs0/FXz6c7iheTcYbOiITc+uGyuxP7Frr
 SoY1GiI3f47zSlQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: bWpe_r1mySl-RKIxWvwLfjFwHLw-rhwk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNiBTYWx0ZWRfX9QcIJpMXZNa7
 l5xwWRHDreNw+IJGbw/WSDxriYxL8xDwYe0SCaP37sgRSJT4f43M8ur6YzXyu//3XfXAMUp2gn2
 aGftYvSqxV/2Fo086aodz1kE+YBcrZ8=
X-Authority-Analysis: v=2.4 cv=U+4Hnuru c=1 sm=1 tr=0 ts=6ab241d6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=SbMoOReDAAAA:8
 a=1lYKK9CxXCv_yy53LZkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=FO4_E8m0qiDe52t0p3_H:22 a=9N8DiX9at80mjW8aGMU2:22
X-Proofpoint-ORIG-GUID: bWpe_r1mySl-RKIxWvwLfjFwHLw-rhwk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNiBTYWx0ZWRfX1qxswkkZ+an0
 4dbnx/pQNVhukU12YXXC/OWayd+V1THLjaPfooDj7E1f722/q9OsqC0moDSVVZwgZHOXAC4B/rx
 yUIC/0BsTWdB0PsQDGiBUYuBCs8noDOdbAhNh+rradVEsC4HQUO17IvzdxAGdT0YTEhl33j/Cie
 O5ysl0HXxrXMEBuffiIFgiUOD9UkLLGyBgnFDkfQxNf27FFxY2d8f8CbuKrBQNE/x1hZAqDRKBf
 b6ZdCtGD37UtF8eG1s4X49+zBG58SlJaPvG2IHvIcRlFrbH92oHP5v2+3iYroRt3pi1pKb6KcZc
 FiBut5MC+zpb8wUfp1cnjovuTaXbiu5bxRvTgwMhjulzK44w7m8CwWTIsFLDqYy6ckDdeQUnO6s
 AvjEi0Ar3+9agXblYMqjCv61rU/OnbRnjHSBqVFZveFx3Nc0YWq9obE0dOMLMWXvm0rpNEIIM8c
 4Rtdfzfz99qeTayTaUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220126

If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
return immediately before zeroing the info struct we'll end up passing
to the user-space later in lineinfo_get_v1(). This may leak the kernel
stack contents. Make gpio_desc_to_lineinfo() return int so that the
-ENODEV returned on failure to acquire the guard can be propagated to
the callers.

While not strictly necessary: move the memset() before trying to acquire
the SRCU read lock too for good measure.

Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260912123529.7951-1-tzungbi%40kernel.org?part=3
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v3:
- Don't emit an error log message from the line info notifier if we fail
  to acquire the chip guard
- Link to v2: https://patch.msgid.link/20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com

Changes in v2:
- Make gpio_desc_to_lineinfo() return an integer return value so that
  the error code returned in case of a failure to acquire the guard can
  be propagated down the stack
- Link to v1: https://patch.msgid.link/20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com
---
 drivers/gpio/gpiolib-cdev.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index b5da6e8566dcd777ef4e7784989b722416c07fd3..270edfdc5da203d072eee362aead0a55d9247fa4 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2174,18 +2174,19 @@ static void gpio_v2_line_info_changed_to_v1(
 
 #endif /* CONFIG_GPIO_CDEV_V1 */
 
-static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
-				  struct gpio_v2_line_info *info, bool atomic)
+static int gpio_desc_to_lineinfo(struct gpio_desc *desc,
+				 struct gpio_v2_line_info *info, bool atomic)
 {
 	u32 debounce_period_us;
 	unsigned long dflags;
 	const char *label;
 
+	memset(info, 0, sizeof(*info));
+
 	CLASS(gpio_chip_guard, guard)(desc);
 	if (!guard.gc)
-		return;
+		return -ENODEV;
 
-	memset(info, 0, sizeof(*info));
 	info->offset = gpiod_hwgpio(desc);
 
 	if (desc->name)
@@ -2260,6 +2261,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 							debounce_period_us;
 		info->num_attrs++;
 	}
+
+	return 0;
 }
 
 struct gpio_chardev_data {
@@ -2311,6 +2314,7 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 	struct gpio_desc *desc;
 	struct gpioline_info lineinfo;
 	struct gpio_v2_line_info lineinfo_v2;
+	int ret;
 
 	if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 		return -EFAULT;
@@ -2328,7 +2332,10 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 
-	gpio_desc_to_lineinfo(desc, &lineinfo_v2, false);
+	ret = gpio_desc_to_lineinfo(desc, &lineinfo_v2, false);
+	if (ret)
+		return ret;
+
 	gpio_v2_line_info_to_v1(&lineinfo_v2, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
@@ -2346,6 +2353,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 {
 	struct gpio_desc *desc;
 	struct gpio_v2_line_info lineinfo;
+	int ret;
 
 	if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 		return -EFAULT;
@@ -2365,7 +2373,10 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 		if (test_and_set_bit(lineinfo.offset, cdev->watched_lines))
 			return -EBUSY;
 	}
-	gpio_desc_to_lineinfo(desc, &lineinfo, false);
+
+	ret = gpio_desc_to_lineinfo(desc, &lineinfo, false);
+	if (ret)
+		return ret;
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
 		if (watch)
@@ -2491,6 +2502,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	struct lineinfo_changed_ctx *ctx;
 	struct gpio_desc *desc = data;
 	struct file *fp;
+	int ret;
 
 	if (!test_bit(gpiod_hwgpio(desc), cdev->watched_lines))
 		return NOTIFY_DONE;
@@ -2521,7 +2533,13 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 
 	ctx->chg.event_type = action;
 	ctx->chg.timestamp_ns = ktime_get_ns();
-	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
+
+	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
+	if (ret) {
+		fput(fp);
+		return NOTIFY_DONE;
+	}
+
 	/* Keep the GPIO device alive until we emit the event. */
 	ctx->gdev = gpio_device_get(desc->gdev);
 	ctx->cdev = cdev;

---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260917-gpio-cdev-stack-leak-fixes-84ad8918a6e0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

