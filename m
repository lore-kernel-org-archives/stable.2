Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220042;
	b=XoS8p+VWh0r186CtvqBfWHsR9lNdP5vL6MIWafphoaCM4At4BuhlweQWzLmph66FgIB4
	 3rEdB4720sRPWDFdUOFBJPdsYy5Prq/waQDylALhUnlUavDjE/5Z2beUgiHL24So1TQ20
	 P8aBtFq2XN1lCgIXpj2eIL+kIVkhQ028h3FybSiNOimLlR7Asy0RvnjMJ+u2L+qIeT1Ma
	 gMFzPYtVOMs+airIvBPPuJ8z3BMW8IAshJd5U0NzToDdT1Q1pMlhmQDmRjP1ymGzV4fsR
	 2cWE6fdw/Ka6CziXo+uVNRzv6qvzle5oM2eUZ+xQhnUAtHezeyvtWwcrvlno0Gl3hrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220042;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jc0wRqvlZzje/aseVvtvfLBJ6kcDSv4zDujObU0BrpY=;
	b=E+Sz5eSNfBTbeVi97KWu7jH1KBiQZJ0IY8kGqLYvOzC/0WpSBogyzwInVZn+bFr1izE9
	 QMBfGUIioDiUKOpYWVq/1Pt4q3QVkW++g+kQuIGTE7//fajNQaTsroHdrA7p3rSNssbeZ
	 vJUoEIL6HnSXepRgZ5VkQl0qY3V+1mNV1B/zSOATRY9tCxWBGahUNPQO70CCgHaTrxLyE
	 dYpaLM/SZtHFWKWKd6mAOZQ3cV8O6IspTcuWbbqCdwrxz/5BYCnfjGJsVb09orRIFBuIa
	 2nKdyouOHflyL9N/U8drmuWWadnxp02qj7fMjyaL6p7xUKCMD2MEO1gmZnNUs0LgmTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GjyQV3Zp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Y/56Fp9Y";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7E606EE92
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD7E606EE92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GjyQV3Zp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y/56Fp9Y
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A99v0fX3164520
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jc0wRqvlZzje/aseVvtvfLBJ6kcDSv4zDujObU0BrpY=; b=GjyQV3Zp/PN2uSrF
	d0X5Zos1q8cTXCom6yje3kcUbAFxd8p8AhO2ozmx1ZWJDsbYdax1VAi3NO7ALDWh
	HKRbhV52SVNLznFVXAHUVj8tqcXXE0Qeuqqd2TKmqyTy381i7qcwINh3Q18B+hb2
	8itr0T3X8t8lp6/v70uRitGczt8QGWwaIYqlt/5BWzzKx6ZpMuyZW2GklBulm85c
	bDLzUMjj1ApRJ6fc/oMUNlJ0e4aliZWfg5oYRIyGTWGPxyD+HDkCr3T8vuFThJC8
	QMHhQDdBluiK+ZsNwnHtfN7fMq6fkZEazHpL7b9zOMytTxv5/GJJAeNyTMsSmEcn
	yYOG5A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99npe6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:27:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91eb556c8a0so14221356d6.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794220039; x=1794824839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jc0wRqvlZzje/aseVvtvfLBJ6kcDSv4zDujObU0BrpY=;
        b=Y/56Fp9Y/Yz0FDx3q0JfU1FLdFkBf9fkO4KznYTsmwfQNGivVyGFM9vUK2tNc1Srp5
         F2byidFoxrCeaenKc+HJ2xJs5UgvI7E1ZrIqepYHODnvIQDn43lKmrwOm+hDgFagZ+57
         a3E9xSU3yCa225aBK6RyhV6ArXlz6q8lOsIEuDXtH4/tztwRMLaaWSMpYNGUYONnmyPh
         1PI1WdjQFEnc+L65NrKIVDmdRTqpSJUowlEZXiWlf0favvAhYuWNr4zZ1Xe1VypTypFt
         6cDQEYNIxXRB+RvOouU7sf4dryG/h3F7TR3nUgz/SZe8JQEUygEuUY+67IhiO3Eus22Q
         ho2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220039; x=1794824839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jc0wRqvlZzje/aseVvtvfLBJ6kcDSv4zDujObU0BrpY=;
        b=WZuHdm+xFXHrD5VS8Hwmn9hx2iRyS+VHIM6ueOw/MmCghXyqpPqA5Lc6/cs1Rm1CCK
         Ct7qXr/ROvB9sHqE0TsjRvl2Doi9nlTSFY7LQUGcs/yLlnWiSQ1P+tJmR9R1cz2eDBWp
         /lXdFXH9H2XX8efLyYC83v0CgHdcv8OrCODIKc0dmoxuX5FgIgkIT3QsyDLsK5TSmx5e
         wEFl+g6kqHHnY1B3yxL/RVBiUv4YWBIRaGzlx2UdMiNm7b3/XUuLek4a9A+WyY8olO/J
         dlRZZC/V2oVIHEAkxVGsnc33f+eU7+OORRBl/CS3svAnzAx/7YTlNIxUFpnJ//zCAgvX
         29sg==
X-Forwarded-Encrypted: i=1; AL+hErF6nl0hfZVKZ130lh9U4OtJ9/CPxUR3K7q4PGHU+CwAcDHuDK/xF3WfNiNmDQk4rs2GRpcXvrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Zl8GfDRtqq4CNTPR3B1nVWQEtbufRP2wZru0xsx6ET62ko2lo
	d9Db2JWL9L7wkttrYsyuu7Ph70WSw9jnS2MabmhSY0m9+/zZQOirSi6yk1p1xKeff3AjNTQds7P
	SjqeP9ZzaYWI7N9p31eKtOEd8wGW3Uk4DzhT80h1N0YpcfJwtvrFZInRHuys=
X-Gm-Gg: AYBFou1WiMkKpt8rYOW/jiZim2MJ8ov9teesg9GBWtB/GDi+FFJygIA8wZ9k1kAI8mD
	au8hG5L4yCiNxpaxD494tE+iLTW2MGWzt7bLWm6ICru0G0k2t5MIY44iYta9prpK8yqkpAqZG7Y
	8fvwW60929lef3qB/DcA6OEFFv0A715Z01FMpJgJEDtNrfYBgn15z1OcnXY6FHon5NNZ7ladKNv
	NLaYPUbNB+/MnqysYsLA0oZNbZ97k2Ol/yXIHGtzeohgJvLKxIAzj/6TbhEJRuVWxf52sPmsw2a
	Ozoa4cADjj6LtCkHPBM1GCjA3sr4V/SvOljYtTzV+aU3OEDj8S2rWoAvWtgy/28XAi+mvU63fjv
	qm5tlWrJGI74L7idQd6xX+ssK/PWOhPwQostasFsnNNvjEgeRnHvLfxp91m5UFMNgFsX/Zni201
	ZiAeL0kBDfsyXE+Lok9b7SjQUcSLDrNEhg6Y2lSzjefXgugpZ5QunDv72Lh0qibos=
X-Received: by 2002:ac8:5ad4:0:b0:533:7a4c:d8ec with SMTP id d75a77b69052e-552a50ab7c8mr54500421cf.43.1794220039135;
        Mon, 09 Nov 2026 02:27:19 -0800 (PST)
X-Received: by 2002:ac8:5ad4:0:b0:533:7a4c:d8ec with SMTP id d75a77b69052e-552a50ab7c8mr54500141cf.43.1794220038696;
        Mon, 09 Nov 2026 02:27:18 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad4d1sm237381545e9.5.2026.11.09.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:27:17 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 11:27:09 +0100
Subject: [PATCH v2 5/5] gpio: cdev: don't overwrite the whole flags field
 when configuring lines
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
Message-Id: <20261109-gpio-desc-flags-atomic-v2-5-c4c54b476628@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8034;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=fVhmjZYt0e+VV07UFHqrVusazPl54UkYh4sJD9+7jGI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8Z/7wPZRBDYNmLOGXhhvjPAYkPfLE2szCBNct
 NREjp6NcJ+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavGf+wAKCRAFnS7L/zaE
 wwiVEACoQ4czedNhkQyaceY6VcGY+uONsKxeHAkQiBqz7dqTJsiqcYWQiJd11JwfO4BRuqGvgXg
 D/ouDPeDnEvQsEm49z+O9Iahi7SgT6QcPmYx4FRz4/oKZFYfce/C/WVcdzrLjCwBDRWXnNx7vo2
 TUDKODhiBx0eOrfBXkOFTpbz64k3QnGkIhm7ZK5P1liJ3gzo3dXIE101jCRbmvYe+5v38kyq90v
 GYU6cc456G3KmgPMF57Ym175tx+k3eez9QEWPgUvdKcLL9wzAqtEqpa02/XQxKtWf09XPtk32LT
 nmE5OSvn0fegiq6D3z8AmnhZ6FYK75ydPnVtt6L37QOag8w/N4+IvVJNpyhkNeyu22B7G1UQ9mA
 qEdD37Fu8qpTMjFg61IxYBXkFGCuiRRyp2pcJ+1HJSK1VgDYOxWUTIRlS/kr1fqoJ3e5vbBlrbW
 aZ8VxMN6DSUsrZDwADaq25K5Iy45XCfMRRKcYzHlEOJ2cdyX9VFtHOU/RK7CpL5B0NEZhy88vtP
 x1gDeR5o3UAlBDAmEQYSf3OpXzS66RXbOwLrMxZIwe9FHlIR2LoCrgr6pHCYvpuiyta5as7XfQW
 Jfnv6RhSumIEO9qwTD26gPcrrque6Debm/HGsnZJuhM05OrW2Y54nS+AxpYRk4QbJiKs+CUMNAI
 0SZ+KfPrPfTwyLA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: EczE_bKReTw8bGrXod0udsZslXmyFGbk
X-Proofpoint-GUID: EczE_bKReTw8bGrXod0udsZslXmyFGbk
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6af1a008 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=FxeHtzAkRt4RPYSLnXUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MSBTYWx0ZWRfX2MwlBwuTDR+3
 nBZ0aJhYf7z+ul2xigAqFTy/oj1X/ceswe5Z+FvH0uj2pKGw16R57d7nvOUP6Uy94M37AbghLZL
 DzbP/3D8AgLLBVesrmn30hZalkhqgAutIqthM74qxZNSw5TuEIIiPYG20Y2nAkZbP7/BBTXQw/h
 zu+ufOUJCuOIHxxpMdBmsjKdRELiG/oWHBe2y9X2eLJvGgoEK5NBdGmR77FwOlB3Dv8mjmxfGOP
 OHKcWnVj5Pi7GX9BzFhh/kLLs19yew8ftdv8grTrvUKlKKnHOTts4aZVniLCr26P3THC6nHIknr
 F8XyYz7LpwXnxAIiWh10tLQkSGGg5oNkYgKrt86/5OfgjE4O4DEr0yCPh7P/mo9HHMXIBkztdCA
 cnaRlAfGPkBGYG2b+KjkStWezi3i16YsRhVrpzJtP9X+HL6QqVM+7XtYedtSi9bbxrbW7e/mk7h
 1gVBexjGUdeHdvwTcgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MSBTYWx0ZWRfXzjmMn+XOvltm
 jQ1dGU0KCC7Pi+JscqffnfACa+AfhaG8ht0fAPoyxsAJqMtG9dO6X2Acnj90QUn1UNgKOKJLpmX
 QGeG2S5JxEwqhaX6YJ2DlRRKdVyMcc4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090041

linehandle_flags_to_desc_flags() and
gpio_v2_line_config_flags_to_desc_flags() read the flags word with
READ_ONCE(), modify the local copy and write it back with WRITE_ONCE().

The per-request config_mutex does not exclude sysfs, the irq core or
drivers touching the same descriptor, so bits they set or clear
concurrently can be lost.

Build the mask of bits owned by the line configuration and their new
values locally and apply them with gpiod_update_flags(). The whole
group changes in a single atomic step.

While at it: rename the functions whose semantics changed from
"conversion" to "flags update" accordingly.

Cc: stable@vger.kernel.org
Fixes: b7adfb6076ff ("gpio: cdev: update flags at once when reconfiguring from user-space")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-cdev.c | 111 +++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f68e33cbd7d4cd5153e82ad77768cf52a90601d6..50baee455283c3aeb25ed92f3936c5f6a5b215bf 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -3,6 +3,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/build_bug.h>
 #include <linux/cdev.h>
 #include <linux/cleanup.h>
@@ -140,24 +141,30 @@ static int linehandle_validate_flags(u32 flags)
 	return 0;
 }
 
-static void linehandle_flags_to_desc_flags(u32 lflags, unsigned long *flagsp)
+static void linehandle_update_desc_flags(u32 lflags, struct gpio_desc *desc)
 {
-	unsigned long flags = READ_ONCE(*flagsp);
+	const unsigned long mask = BIT(GPIOD_FLAG_ACTIVE_LOW) |
+				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
+				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
+				   BIT(GPIOD_FLAG_PULL_UP) |
+				   BIT(GPIOD_FLAG_PULL_DOWN) |
+				   BIT(GPIOD_FLAG_BIAS_DISABLE);
+	unsigned long flags = 0;
 
-	assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
-		   lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW);
-	assign_bit(GPIOD_FLAG_OPEN_DRAIN, &flags,
-		   lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN);
-	assign_bit(GPIOD_FLAG_OPEN_SOURCE, &flags,
-		   lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE);
-	assign_bit(GPIOD_FLAG_PULL_UP, &flags,
-		   lflags & GPIOHANDLE_REQUEST_BIAS_PULL_UP);
-	assign_bit(GPIOD_FLAG_PULL_DOWN, &flags,
-		   lflags & GPIOHANDLE_REQUEST_BIAS_PULL_DOWN);
-	assign_bit(GPIOD_FLAG_BIAS_DISABLE, &flags,
-		   lflags & GPIOHANDLE_REQUEST_BIAS_DISABLE);
+	__assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
+		     lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW);
+	__assign_bit(GPIOD_FLAG_OPEN_DRAIN, &flags,
+		     lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN);
+	__assign_bit(GPIOD_FLAG_OPEN_SOURCE, &flags,
+		     lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE);
+	__assign_bit(GPIOD_FLAG_PULL_UP, &flags,
+		     lflags & GPIOHANDLE_REQUEST_BIAS_PULL_UP);
+	__assign_bit(GPIOD_FLAG_PULL_DOWN, &flags,
+		     lflags & GPIOHANDLE_REQUEST_BIAS_PULL_DOWN);
+	__assign_bit(GPIOD_FLAG_BIAS_DISABLE, &flags,
+		     lflags & GPIOHANDLE_REQUEST_BIAS_DISABLE);
 
-	WRITE_ONCE(*flagsp, flags);
+	set_mask_bits(&desc->flags, mask, flags);
 }
 
 static long linehandle_set_config(struct linehandle_state *lh,
@@ -182,7 +189,7 @@ static long linehandle_set_config(struct linehandle_state *lh,
 
 	for (i = 0; i < lh->num_descs; i++) {
 		desc = lh->descs[i];
-		linehandle_flags_to_desc_flags(lflags, &desc->flags);
+		linehandle_update_desc_flags(lflags, desc);
 
 		if (lflags & GPIOHANDLE_REQUEST_OUTPUT) {
 			int val = !!gcnf.default_values[i];
@@ -339,7 +346,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 		if (ret)
 			return ret;
 		lh->descs[i] = desc;
-		linehandle_flags_to_desc_flags(handlereq.flags, &desc->flags);
+		linehandle_update_desc_flags(handlereq.flags, desc);
 
 		ret = gpiod_set_transitory(desc, false);
 		if (ret < 0)
@@ -1216,37 +1223,43 @@ static int gpio_v2_line_config_validate(struct gpio_v2_line_config *lc,
 	return 0;
 }
 
-static void gpio_v2_line_config_flags_to_desc_flags(u64 lflags,
-						    unsigned long *flagsp)
+static void linereq_update_desc_flags(u64 lflags,
+						    struct gpio_desc *desc)
 {
-	unsigned long flags = READ_ONCE(*flagsp);
-
-	assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
-
-	assign_bit(GPIOD_FLAG_EDGE_RISING, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_EDGE_RISING);
-	assign_bit(GPIOD_FLAG_EDGE_FALLING, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_EDGE_FALLING);
-
-	assign_bit(GPIOD_FLAG_OPEN_DRAIN, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_OPEN_DRAIN);
-	assign_bit(GPIOD_FLAG_OPEN_SOURCE, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_OPEN_SOURCE);
-
-	assign_bit(GPIOD_FLAG_PULL_UP, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_BIAS_PULL_UP);
-	assign_bit(GPIOD_FLAG_PULL_DOWN, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN);
-	assign_bit(GPIOD_FLAG_BIAS_DISABLE, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_BIAS_DISABLED);
-
-	assign_bit(GPIOD_FLAG_EVENT_CLOCK_REALTIME, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
-	assign_bit(GPIOD_FLAG_EVENT_CLOCK_HTE, &flags,
-		   lflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
+	const unsigned long mask = BIT(GPIOD_FLAG_ACTIVE_LOW) |
+				   BIT(GPIOD_FLAG_EDGE_RISING) |
+				   BIT(GPIOD_FLAG_EDGE_FALLING) |
+				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
+				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
+				   BIT(GPIOD_FLAG_PULL_UP) |
+				   BIT(GPIOD_FLAG_PULL_DOWN) |
+				   BIT(GPIOD_FLAG_BIAS_DISABLE) |
+				   BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
+				   BIT(GPIOD_FLAG_EVENT_CLOCK_HTE);
+	unsigned long flags = 0;
 
-	WRITE_ONCE(*flagsp, flags);
+	__assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
+	__assign_bit(GPIOD_FLAG_EDGE_RISING, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_EDGE_RISING);
+	__assign_bit(GPIOD_FLAG_EDGE_FALLING, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_EDGE_FALLING);
+	__assign_bit(GPIOD_FLAG_OPEN_DRAIN, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_OPEN_DRAIN);
+	__assign_bit(GPIOD_FLAG_OPEN_SOURCE, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_OPEN_SOURCE);
+	__assign_bit(GPIOD_FLAG_PULL_UP, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_BIAS_PULL_UP);
+	__assign_bit(GPIOD_FLAG_PULL_DOWN, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN);
+	__assign_bit(GPIOD_FLAG_BIAS_DISABLE, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_BIAS_DISABLED);
+	__assign_bit(GPIOD_FLAG_EVENT_CLOCK_REALTIME, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
+	__assign_bit(GPIOD_FLAG_EVENT_CLOCK_HTE, &flags,
+		     lflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
+
+	set_mask_bits(&desc->flags, mask, flags);
 }
 
 static long linereq_get_values(struct linereq *lr, void __user *ip)
@@ -1404,7 +1417,7 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
 		 */
 		if (!(flags & GPIO_V2_LINE_DIRECTION_FLAGS))
 			continue;
-		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
+		linereq_update_desc_flags(flags, desc);
 		edflags = flags & GPIO_V2_LINE_EDGE_DETECTOR_FLAGS;
 		if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
 			int val = gpio_v2_line_config_output_value(&lc, i);
@@ -1660,7 +1673,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 
 		lr->lines[i].desc = desc;
 		flags = gpio_v2_line_config_flags(lc, i);
-		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
+		linereq_update_desc_flags(flags, desc);
 
 		ret = gpiod_set_transitory(desc, false);
 		if (ret < 0)
@@ -2055,7 +2068,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le->desc = desc;
 	le->eflags = eflags;
 
-	linehandle_flags_to_desc_flags(lflags, &desc->flags);
+	linehandle_update_desc_flags(lflags, desc);
 
 	ret = gpiod_direction_input(desc);
 	if (ret)

-- 
2.47.3

