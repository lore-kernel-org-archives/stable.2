Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619028;
	b=HEg71Qbs2D3MM4PYcKabmzdLbmrfCmew0yZZOv4nmYpKmFsdn89psfOCJ5e1meFCGFH2
	 qOINUp3mBiomUf7f5DvmB9xgSYC7XjbI07FIP2aAf98ctnHO5a2Mszf66SiYSM7D2DsZ+
	 l+NJ7KzpA5nvgGJulVqkFBN+hoGQWuF6hd8hM3kbXPtwb2CRwXkBFJoRuzIOJSCihREdF
	 jZkBxQ8DNZlz1WdUdLWLnAxMyaMUzoxo5On6V7wbvqmoJBzaUIVPPMBrI749jdD7YK1r1
	 MJcsmhiFXk+y0sr5EjzybSSB1wyq9F5a6PyYTVuFolJ0uJ82RqPKuWSY8JthaMZRh4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619028;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2WvmVx0NUl7jiOkggCIKKfZSszuZz9bNRR1+QpGBv7o=;
	b=l1OKWcngAi4ahDaDv6mOtq5Q8LcNQlQzTwVBw1NaoW+RcI17akQl7X0CiLdlLLoTgj9r
	 lnHz0Bmygd/vNDEGyHFd6unDez4gfxH3o5w98IRRaPf11YQdQI/wJlMXqDZLMHYeKDGn0
	 czpDojdY41GDxBr5Es9y+qUty4waSRKdSdOIIyQDp1WvV2rTElZ3t7dQ7+RxV2CL9vS4y
	 KbPg69B85pzrhid7nDOPTvafEnc1oEpB8kFiQ1xnHgq78BBR+xxYCn2WvoBeZhP17/jgM
	 WZuuYkMs78Hx8pWRipao3E4GhFcIEyGjo4xtZO6nRD8Zuzs6ft5BSNjIXEYXu1YJdBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HhPsOlni;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lj6WQf6w;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22780606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22780606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HhPsOlni;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lj6WQf6w
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APELxle724351
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2WvmVx0NUl7jiOkggCIKKf
	ZSszuZz9bNRR1+QpGBv7o=; b=HhPsOlniS/1bo9SPFygtJ1UMVjLDlHfOGsu521
	07xuiUj/ItcEcIuZ0mlfh4MUpOLvrIpgtllWc5DgPDN22xKXiPpkOS53ZAHU0twQ
	Eb12SNxPv6O1nYcpFzNchKeEHTDeMlgv7NQtVeDGmYw/dnr7Ertr6+s0HkWE1FBU
	V3d7ZxMDh//2XNJiDGBNIZx6dwgtxlFNeWEmtcSEdLSr+xrNxDczSNpyDIV8qGUZ
	H2JflxdTBlRr9zyQ68WFXbKechWNk2K3FpAY3GEb9rFjqV4TNDVPOm+YJHvNJDaF
	FoDoKq9e29OxwrwV9C/pswkcKHF9Dj53KXF2Qv3fZ9szA4wQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxrp4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:03:46 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-71ae9b6983eso2947535eaf.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795619026; x=1796223826; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2WvmVx0NUl7jiOkggCIKKfZSszuZz9bNRR1+QpGBv7o=;
        b=Lj6WQf6w74OtStjo9FavlQy5uo2YAxyeoFtldmyEak7FI+/K0wkWiLYxvZJ93X8BP5
         DEMZBQERHpPmYAmdBG9hCoU8qoG2PRmDwlZ3gkVk9yhTs/dZG3n3CfsLi9tbx2GtrgRx
         t9IdhX1TE5D3UvDupJMNDyuBr/LYSbDsT3hr6HRf1XpFNUs5E5LXbWw08XBVT4EBvOFA
         qkYS/jEW49VWjeTP8YiDcuFw7YCqZLwzJFRJC2vMXyg3iATpRikW8GUA552ZQvDDZYcV
         voOiecvaWKM30y05tt8N/A6lhFC3z29x139rBrhcSsWBEKLboTU6yGvAGadv7wcbELL5
         Udgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619026; x=1796223826;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2WvmVx0NUl7jiOkggCIKKfZSszuZz9bNRR1+QpGBv7o=;
        b=ytPIFDdgT0cbuL6180/KQU9DKq6i31EsU9oGcSpmq4V1+P63gPPS9dGwpsXcMXjMbZ
         luUeLS4eC3xIzaBcEvYolHYru2F/H2vmyQpk2u5LCix1ntisiASgAdczyRVOUarFV5Jo
         AmEJ6Q8wijS/rTiy42ehN2bb/AdEanbew3YKsEp7AdrGSxU3IqW8CATeB+eTXnVL/6fM
         x42pDhVmMsYJxsgqvwXmhtTySAtgj+XpfaPjL0coU90SwdpIxCX6ItjK0awzGky2jS+K
         SWyUEVvx0nvOvXg/nGZPTpeZmRPaa01qBcvR8mqR6z4Wn6WmGhEjW657Pyrc8nbypqSm
         Eyaw==
X-Forwarded-Encrypted: i=1; AL+hErGTJSA/iLdSTutwfTwkkNlvg8oJdffeOxYMylVwkBDyJifZIHZf+fwuHt6HFZE3iYTz7RvHEAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/O4h0SRmWmeF3j/rc+w/O40gEq1Cfp/CpgQ/mWgjw4i/wXT0Zw
	r7EWd8a6cUjS+M2cN49ENVBgs5OgG0OnwMjY1u0YzoBoAWq6HD/iXeNob63aXlCOfVyVBf5SXLb
	oX7JW44c6R9mImEJeacYjeKpGAIDM5ozsV+peSs22PnKYuwrlDuliepqf9Yc=
X-Gm-Gg: AZFdTZcIFJqgDesXPlluOLruJd2/DSZ/atfugFh7F3R3MnJNxOmUgKM4eFQZeUOUyxO
	VeNv7pxFBeOvVOPfYQQUjOedCj6rulDDYBe8FuIEAf60BupOB4+B8AndwMVEed6wHiZ/AEPrRGT
	yr9UjwlE0u7lJwmmhYIRZZUmPmhZp8gwcDOk4eRdFZNwZ5aKCd8ZjYgY/BGx83fSKpS5+V/whSR
	tzXOH2UGebHbJMUAEcjrYkyftPCaZROA9bIiYD6XW0nOU/TctNIfk8BDC1MSSDDj9n4C3Wnv2Y3
	FuD9kb/s1lDXzMyngbk3FTyv/ytIege/VBKV8WBoRZc1uk7PY/lSdRTu2ZYWpMYYs4sE4+pXXSL
	nn5KDgv/ckSIiwVMFloHQAmlXgBqlHkQgA6HOGrzEX3pJU4NICdby2PJp1pwZlkGjJen7QaES1F
	SzWcvHv5B57vOEGypd90K1w5pg3QIo7v+RX4+7jvHEv7ZiF+8FvDKByLyUGmuvjlA=
X-Received: by 2002:a05:6820:2206:b0:71a:f637:e5f4 with SMTP id 006d021491bc7-71b3948644emr15664861eaf.39.1795619025712;
        Wed, 25 Nov 2026 07:03:45 -0800 (PST)
X-Received: by 2002:a05:6820:2206:b0:71a:f637:e5f4 with SMTP id 006d021491bc7-71b3948644emr15664811eaf.39.1795619025174;
        Wed, 25 Nov 2026 07:03:45 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm36291267f8f.33.2026.11.25.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:03:44 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:03:41 +0100
Subject: [PATCH] gpiolib: use the of_xlate() result when hogging lines
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
Message-Id: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMz4BmsC/x3MSwqAMAxF0a1IxgZs/KFbEQeizzYgVloRQdy7x
 eEZ3PtQRFBE6rOHAi6N6vcEk2c0u2m3YF2SSQppjJGa7aGeTxcAnrFt7LxlkbaSsqswFUKpPAJ
 Wvf/rML7vB18SqrNlAAAA
X-Change-ID: 20261125-gpio-three-cell-hog-22742394ea02
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, stable@vger.kernel.org,
        Norman Herms <dockseed@proton.me>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4782;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JOFHXo2LvlDk+FFkBfNrRUjsN9R6frDp2E5bOozo+qM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrBvjPIeEutoW5F8W2VXPI6p1fcryHxsG1Se6U8
 ZhF7t7Y6cKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawb4zwAKCRAFnS7L/zaE
 w1HyD/wMhQgjXwRkMbrg39Tg7f6BTVs+X5FvoU0boYFrYyeDYxKzVwcR31NiDS0emq1cU0H1JsV
 PkSferrG+XISR16JBCdaeaVAdHmhTQyoNQiwSM+/uV1Sktwi7KFNzThOJ+AC8SvRqiO349TclhH
 iDX8vDl/fEwnroUgWZFEGlp2o5nDMAegYWHQOH/iZxTIoF7urlk+6iSE0B1+X8LDzJKIpAPbVLw
 0y/q9FCWVxdU240jhxcVwxvCZa7w6RCkcIuHx8yGOK2Iu21pobeTnB+SXoHb1N/m2LWZC6Jt2W8
 P2fY+NdoUB4tmfaTDQxncCu7iiR4PFQcPanwlqVorb9yckrlXsicQrfh60aoHVP/cNf7wpC9arB
 /PzWEVd1poWGGpSAEf8zTA51cJqQKxo2TD9UQZqKcDmfCHJRFN+uSyk+uLCrKxTM4BP57syjJuD
 8/8HrZb6tsFgPYZW/kHYkjdkdftQpoRz+Vdo7WiuK4UgU1CIHg0nsFYlHkf0vr4sS7WOFrcwWU9
 aifZUznT5AB/XV5LJOY8iVuzCcW9EXGBKgzjSfyhSs/M7og6NiJH0KABoqTIlvr6Qm+LKYW/+yT
 ImcuO7jOx9D0Twbs2stqmjTTc1Mf6cJk8PFq4ijN+31mbVdLxTMq2v1yRXnk3RRYv3XZrXHjINl
 RkMuxT5kSJ6yRPg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: qPHo8G7zSQJ-o4oztr-xcIeqHE3yHRUl
X-Proofpoint-ORIG-GUID: qPHo8G7zSQJ-o4oztr-xcIeqHE3yHRUl
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b06f8d2 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-_O2tLMXsRGhU8GF7hkA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OSBTYWx0ZWRfX1jwMwVyzDdHA
 U6TjUf2jkw3fSvGR+yH4zt7vNFNFCAc7m/1KSY75YrksxKmqkex0QEp7Od8s1qI37YBOkBsWsaq
 ZTeUbKDUToI3V7jB/Ed4bTv8lCSJb9a2Oid3/x3E7RJREy5BmpuWuxPai1dF0CqsPzwJ6s6cjBu
 PkhU7jaZFBsfj0xhuezakO8tfmvr3ddrlfZNF/araMMza2O4warOTPocx5tEJ9e05fPNJUPZQvT
 Q/pD3C5PTFXvMerTYj2tVpc2jEEftomc+32Gxel6v6CqSao/fHZhNA1F9XCU4u/FWDpt8WvuOzK
 win6zmReySUqCF7R/5TcZmW77DSkglHIpfkqp3sfRJ1bgLsFmWWFOKLry7cLareREN8zVgUVcx2
 VpkGU5kVocJEWSiLohGl+zEdUmP4WiS3z9/NpNNsPaIAnlJSoHmJkump4xHlPR+LupzJteKHPYD
 fkUSxnnYv83UmeQ2C/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OSBTYWx0ZWRfX84jiFxw21C61
 XtdvMog4i2LSNjSPUZYSjsEDaKf8BKo7Pgm17lcqIaRZ/UKzUudUuJjOo8IoA4tiMvk/a+c1LS2
 kDQI4Cbu+Id88W5aLEJp95LwwhECBdY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250059

Since commit d1d564ec4992 ("gpio: move hogs into GPIO core"),
gpiochip_add_hog() takes the hogged line from the first cell of the
"gpios" property. The of_xlate() callback is still called for OF nodes
but only to get the flags so on controllers that compute the offset in
of_xlate() (sunxi, Qualcomm PMIC GPIOs, tegra186, ...) the wrong line is
hogged.

Use the descriptor returned by of_xlate() for OF nodes.

Cc: stable@vger.kernel.org
Fixes: d1d564ec4992 ("gpio: move hogs into GPIO core")
Reported-by: Norman Herms <dockseed@proton.me>
Closes: https://lore.kernel.org/all/qh4LV99kGaQYdQuGbsPX4b9Fm6Cip_Ow7ImY4icfwI8IsbMQy_09FovZY82b-_HVkDmR2ELMlKe8bzCuBB5NpaZizoO-s4tc11zAX30FDhw=@proton.me/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-of.c | 10 +++++-----
 drivers/gpio/gpiolib-of.h | 15 ++++++++-------
 drivers/gpio/gpiolib.c    | 14 +++++++-------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 8bc4562608e1141983300132b90758ce68d7625d..072f84a83c3c657baebd88694f062849b7526a79 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -749,9 +749,9 @@ struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
 	return desc;
 }
 
-int of_gpiochip_get_lflags(struct gpio_chip *chip,
-			   struct fwnode_reference_args *gpiospec,
-			   unsigned long *lflags)
+struct gpio_desc *of_gpiochip_get_hog_desc(struct gpio_chip *chip,
+					   struct fwnode_reference_args *gpiospec,
+					   unsigned long *lflags)
 {
 	enum of_gpio_flags xlate_flags = 0;
 	struct of_phandle_args args;
@@ -765,11 +765,11 @@ int of_gpiochip_get_lflags(struct gpio_chip *chip,
 
 	desc = of_xlate_and_get_gpiod_flags(chip, &args, &xlate_flags);
 	if (IS_ERR(desc))
-		return PTR_ERR(desc);
+		return desc;
 
 	*lflags = of_convert_gpio_flags(xlate_flags);
 
-	return 0;
+	return desc;
 }
 
 #ifdef CONFIG_OF_DYNAMIC
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 9ca540d93f93be9c1b4791c7add0936527646849..347b82f9e3ff4dcca6b919c058270cc721c81541 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -25,9 +25,9 @@ int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
 bool of_gpiochip_instance_match(struct gpio_chip *gc, unsigned int index);
 int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id);
-int of_gpiochip_get_lflags(struct gpio_chip *chip,
-			   struct fwnode_reference_args *gpiospec,
-			   unsigned long *lflags);
+struct gpio_desc *of_gpiochip_get_hog_desc(struct gpio_chip *chip,
+					   struct fwnode_reference_args *gpiospec,
+					   unsigned long *lflags);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device_node *np,
 					     const char *con_id,
@@ -48,11 +48,12 @@ static inline int of_gpio_count(const struct fwnode_handle *fwnode,
 {
 	return -ENOENT;
 }
-static inline int of_gpiochip_get_lflags(struct gpio_chip *chip,
-					 struct fwnode_reference_args *gpiospec,
-					 unsigned long *lflags)
+static inline struct gpio_desc *
+of_gpiochip_get_hog_desc(struct gpio_chip *chip,
+			 struct fwnode_reference_args *gpiospec,
+			 unsigned long *lflags)
 {
-	return -ENOENT;
+	return ERR_PTR(-ENOENT);
 }
 #endif /* CONFIG_OF_GPIO */
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c09342fc52cb7fce163e807ba134ecd0e1389436..889ed7e420c19c9a69c9149ead3ea370d7cbbdea 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1036,9 +1036,9 @@ int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
 			for (unsigned int j = 0; j < cells; j++)
 				gpiospec.args[j] = gpios[i * cells + j];
 
-			ret = of_gpiochip_get_lflags(gc, &gpiospec, &lflags);
-			if (ret)
-				return ret;
+			desc = of_gpiochip_get_hog_desc(gc, &gpiospec, &lflags);
+			if (IS_ERR(desc))
+				return PTR_ERR(desc);
 
 			/*
 			 * If no line-name property is present, fall back to the OF
@@ -1054,11 +1054,11 @@ int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
 			 */
 			if (cells > 1 && gpios[i * cells + 1])
 				lflags |= GPIO_ACTIVE_LOW;
-		}
 
-		desc = gpiochip_get_desc(gc, gpios[i * cells]);
-		if (IS_ERR(desc))
-			return PTR_ERR(desc);
+			desc = gpiochip_get_desc(gc, gpios[i * cells]);
+			if (IS_ERR(desc))
+				return PTR_ERR(desc);
+		}
 
 		ret = gpiod_hog(desc, name, lflags, dflags);
 		if (ret)

---
base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
change-id: 20261125-gpio-three-cell-hog-22742394ea02

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

