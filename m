Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8A499F0B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995432; cv=none; b=ZCEKXo65nrKlJxz80pHDxhxCXbi/YIb66D3XDUWu6cowE5UF6WTinE4b4yA9vnkp+grpeLPeyPI3VRO8dA+wqxim5xsucGjngyAYSQv5yyJYQQl8PdW/YuxGrCnzPHTFlwcWupF8aqmDQYFQf9a+7TXb3wlihv1/BhjmKr6QG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995432; c=relaxed/simple;
	bh=QfrTXcQngRNpU2ls/CDYcHleFEhM3JlCasK8Jr38Wlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c4n/KDUytXuLuvADviuDYjpVGtswndNQGOsk3hagwUXaU0JNmtwo31RmrovTBhZD+XGONpLZ/+AL7fxVCKUxD3vo37pQbP91WIRrMy8GJOVF32TFFn7CiJPDMq3GaS4Ne78fCForkc0OjpjXPr8Zvb+ypLaUnCxUS9A5t0uJuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DPkjx2pP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RrQ8tVoa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DPkjx2pP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RrQ8tVoa"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeAWW837792
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FlIP4z8C1de8scGveD21RL
	JnymW8TYexlSqaE8cPhRQ=; b=DPkjx2pPlMtwuGX0QXt/PuWbu2cDhz8Gsf8O/Y
	mgAGv4zAkmHj7f+CtZUyDYsC3PryFRLrClfrnCHcOnFt9PT4t1QKGKI2cBK04LFd
	+JGhYZIzg9U87c7Zp3JFVQlQyjjxUIXqZEHlRHIj3A5E/RbRELOTAINqzdH0L1a6
	gs3ABp/Fxto1r8xXKpae8rXedxe71QYaM6+cSnsBY02sa/2dLCV7octzBribtJBG
	C2suBacywS7QCUxTv1xOKGPa1D3eP0l87zXMmNd+qn18wghXTVjlpS8sD2CM94Lv
	xHHPQICBEtu2ITk2ZnWLPQ7rb7abjSk6+9K/LHQ6Onyg21Tw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hwc2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:57:09 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98304865f02so2545529241.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789995429; x=1790600229; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FlIP4z8C1de8scGveD21RLJnymW8TYexlSqaE8cPhRQ=;
        b=RrQ8tVoa/DAG45pNUX9OXUiT4Fzuu0BqVaeYg/F63E6xKtLwRkgyQvXxZanfxfvN8S
         vx/ip33KM/6S0SvKLumYFXy6j6WQylFAdjKMjXxJUv+OP2CeQxVNjEimFzH44lnMQZ0o
         XTtZ5XOWRENNCOgQQVIggywjCIqa7qHpSoLuDq/klZSdx+RVsGzfwRc2yl+9OjT9F8xk
         w7axz/jQPZLQiUk3uOuVA6VMFddh+g3HkDBq+vCHSux3EpuMyfplmoxzr3r0enAf2l6o
         hkdX0JPZnJDWCYRZ4BMaGjxZwRpWOCEc4eNs/nE8Sd3xYLfeGwG76NuaZdIqnuCgPreh
         5AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995429; x=1790600229;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FlIP4z8C1de8scGveD21RLJnymW8TYexlSqaE8cPhRQ=;
        b=rJwxRSfA8aqhLNgrXh9edDZJcduARNo3yOvrEIGagbqSinMH2FtlP8wUFP/28xznM2
         cF4wv04mLtcNTrEY7PGlGVdwuBHxvr7jYYgds5zZe2ScrlB55LudBU2D4vZdLk8VKEe2
         epq4omr0u6ViZCXlnikNjQ6+kpBoM+/x79ozqlIqrzd1qk4vjVtMG27vFgEXTXzT6qPE
         UXYmV/9xX9f6+aH9iwKedBY5uFQLLfhMK8XwLEllIlzpZt5ivwQM/QklJJ3YP8udjjxB
         2CDkId7+/tihbBlVF2PsBrYtLWv7g1EUYKTYywUoat310txS6cAd0AVVvlLa3rTD0fXO
         N84A==
X-Forwarded-Encrypted: i=1; AKwUvByva9ujjbb76VuRqHfRPejl4xXeQHMUsXdyd2LN7BYbdReeLXyn2h5tyVDiqCu6Ba2rYEizo10=@vger.kernel.org
X-Gm-Message-State: AFuF++nAYipfkc5zpMmfiNRPlGZXyBcALO6VrZVcERfabPSV4wpSFnB0
	YSoaz41fwqofzj9nUmwnJvPn27HKGK1F5dIt5aKpJIRzV/SNj0ufaNjJgUsMwJXSg78FjbBl0ac
	A7y7z6yVBxBsCZ7F0LBm4nTNXmaJX4FbrDWin1jU+4gsuLya4opJ247vEmT0=
X-Gm-Gg: AYBFou3OBACvGPec4bdjJ6+AMNIPBgyZbrfsZceJ0icorpRqQm7uC66zTPjeBiOeKzh
	Ft9l+c/xpCaUcbmX6q6kJrDbP5LFJeLpGMxn4Hnty8GMT9lqWVqa4qUQ/LRCZu9m1wui2wk9O/p
	u3bntWfCVmW1R5IqYCkbXUUr7xK+7M+w9tzXmTEU9kaaNK45OiolndyEuWEoWqy9lbIZnXxPvVB
	SMbnes+iw6KkwUH5pkQWhyxDbesfaoy7pCH0u6PVQOWG2sb+O+jfEvGIe+5nUAxQkTCTsP30pdl
	Fm2ZKm0EDZHJ7zcbM7rswUW51lGNBZj56UCPax5sFzVoBfGgXvRXVlfwlSes9KNe4w6xF5m5fzv
	8xs1aONmM4hprMQpCedZnO8bjrnM=
X-Received: by 2002:a05:6102:38c7:b0:7a1:88cc:6787 with SMTP id ada2fe7eead31-7a55b951a9dmr4538095137.12.1789995429341;
        Mon, 21 Sep 2026 05:57:09 -0700 (PDT)
X-Received: by 2002:a05:6102:38c7:b0:7a1:88cc:6787 with SMTP id ada2fe7eead31-7a55b951a9dmr4538073137.12.1789995428850;
        Mon, 21 Sep 2026 05:57:08 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35239469sm302965966b.6.2026.09.21.05.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:57:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:56:58 +0200
Subject: [PATCH v2] gpio: cdev: fix kernel stack leak to user-space in
 error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJkpsWoC/42NzQ6CMBCEX8Xs2SW0QWg9+R6GQykrNPwUu9hoC
 O9u5Qm8TPLNZGY2YAqOGK6nDQJFx87PCeT5BLY3c0fo2sQgc1nmWlTYLc6jbSkir8YOOJIZ8OH
 exKgK0yotlCkphzSwBDqC1L/XiXvHqw+f4yuKn/vXbBQoUDbNRapKU6HtzTNnz5cZrZ+mLAnU+
 75/AfPHiSvLAAAA
X-Change-ID: 20260917-gpio-cdev-stack-leak-fixes-84ad8918a6e0
To: Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4689;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=QfrTXcQngRNpU2ls/CDYcHleFEhM3JlCasK8Jr38Wlw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsSmecS6r35lxWm9qZdmzUGebrlA03CHEP7LNq
 PXeIomotgGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarEpngAKCRAFnS7L/zaE
 w8khD/oCz/n0M85aRs/Ana1PyMSA+3HSQkKmDoWLAoI3Wo/s5TDr4cA2ZlyGkj/qKALfHRhf2Am
 g6fR9g24hH9aDQH1tVLUI3o1sL4GfXoJLGOoIALPn30X3i1qyMkK2pEbyE5ZO2C7Hf+WXCne/Kh
 XzHel5dy3J192Z4uOO2Nh0CASpxIib7hU1VMWPep3bZPBGgjzKVrotSB9EGBvouiO/tmrQa4R6B
 umNqhyTap4uvA6gEPzJS6iVwS6I4eO1NnM2i0Kv3cHw6SOgKwmLu50LaIju1dSz3mjM/RkWtpCK
 OILRe3ZvUqc4WA+JhBZBQrCit7lisY1Py1mQQCZ7NB3qT222ABNJf8tt7A/mh8KjQ5GeOvtjJjg
 sg4JneTJ8zUHVMLPbyKlgs5rL2kEllG3G3t7faGPOp5OeXPMbpbC4B9YRoV93Rd+LYsU8sn1kcR
 ZqC8K1ngqIIxIlND4xBKCYnXRrSyWOYoCXRgBbjTEuD/A/Jl0WoPQytn3d6IPUqZl87R2sfszED
 bS4y2QYWS4kzHbLZ7sA5LfLZ3e44tVbMZCcHB713JVHZKqqAOiNujn4JuGj2KiKL3HAt1XcWZ8b
 4AWc6uwSlN5irtQU6o8PfHpnMQx4WJqCdz+4YEUem8km6DV8BUuSkCTN4rmtg+r3Xlpjwcxxr4I
 9B1uevQ8LHc25HQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab129a5 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=SbMoOReDAAAA:8
 a=1lYKK9CxXCv_yy53LZkA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=FO4_E8m0qiDe52t0p3_H:22 a=9N8DiX9at80mjW8aGMU2:22
X-Proofpoint-GUID: q9j3_ChCJxGj5OzpYzmhPmHlKQMVZDhd
X-Proofpoint-ORIG-GUID: q9j3_ChCJxGj5OzpYzmhPmHlKQMVZDhd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX9p4MRJ8dLf8g
 nBu5+2nPq/jtR+OfV++0NCLftm4yZC4MpdlYMsFg8s+Kthdrr2aE26c4QVFd1rOKcmUsBbiMymu
 cijIp4CVZVQEHwLeDdEqNiYEwnlUnQo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX5elWN419coKf
 tq9ht/mvgAkep+ZJq6wgY7vRCxiQwNqz1xj3QwylfNYXKFXv9nFHM0QJsCxXb+GJOzC2Xa69ycT
 yDSyaOo6pE85a4y6vnRNMwOdkXGSiiASk4iUwpQgWqMEUTDKYLkoYBHsZUBi0ZG3cOkds4LTClH
 hcKdPjOMAUO3muzRbHjts0rauEQ5ZMMMi1mJ9yURL4RwMogxvc2YBgZR3ytt2PBHIPb77aPke3j
 FRXkPNpSDiRHfKbo8AVl947lG1wu5u2C/pTJvQx2FEAJdfyZBM7NvFAZOzuhG6wNAkKOTtAOOHn
 TZ9ZLShYQTM6VzG9za+oKnoe/q8lzkD5uVBVdfaZdWzTl+X8F3o/lKvHVynC76SMtKuCrJ87nF5
 vIyxxYvrUCMound3xXQYus4trDtFQ6WcyxTiYmH6bFOxL8D+biDAI1VWge/2L8arHxPPxBfsNHi
 XCw7bIX7ELcpVXM3Lrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210187

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
Changes in v2:
- Make gpio_desc_to_lineinfo() return an integer return value so that
  the error code returned in case of a failure to acquire the guard can
  be propagated down the stack
- Link to v1: https://patch.msgid.link/20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com
---
 drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index b5da6e8566dcd777ef4e7784989b722416c07fd3..f8ef7367b8c856986237dcc3a425a7152fc2db20 100644
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
@@ -2521,7 +2533,14 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 
 	ctx->chg.event_type = action;
 	ctx->chg.timestamp_ns = ktime_get_ns();
-	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
+
+	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
+	if (ret) {
+		fput(fp);
+		pr_err("GPIO controller that generated the line info notification was removed\n");
+		return NOTIFY_DONE;
+	}
+
 	/* Keep the GPIO device alive until we emit the event. */
 	ctx->gdev = gpio_device_get(desc->gdev);
 	ctx->cdev = cdev;

---
base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
change-id: 20260917-gpio-cdev-stack-leak-fixes-84ad8918a6e0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

