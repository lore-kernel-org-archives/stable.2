Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323669;
	b=d8GyZH+QXQd3zX+p4Es434vqvVqGi53VbnPVTJL9y4Fnw2NlUIAvLQHM5wVsMyXXjBjd
	 7Yrz1MAmn8Yg5qplMBeeQ8aVHFlaxImY0lJJaMyF2pTXW+qIFiL40NzgbInm0zyRbhy86
	 LjQE6F9JZJ7xt3VRgagUYg4hG0PicN1CFg29Aus8/Bg3w+VtJU5ZcFgvv7JicI/4NSahc
	 udM9ilSyihUAPvRxhrgWn4Yn93KFlhxT7XH1IwvAxvh1omCAy+pvXeJaSpeCARUCJlLTU
	 vQCtiM5lzhTdhx7sGGQB94rnFNAIHPcCGumYLnlWpB+0Ou8R3ZyBHWyd9LizgDTsPMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323669;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gERlYnqMraEDZsYQky6xL2HjZPffZDUJmiECrM+pxkI=;
	b=peRNKliX0ljPCVqJ6/H8UEJ+sn1U0ZXv3YBCdujnEu2H7ETsRpkfHZBoPmm1mpfkyTGD
	 TAISVb4i/6lKEsSuqc8kWJ0QWSnnOU0Sm7gN8iDlzeX+4ZNun7dI5b5m5WH0HwsRNSnWh
	 rdMmJNt1t6AyqB0TCs6uSea3TQ5XEylKXKsz5SHIw1eqKMqg6/OfxTXjuMl0mI8ZRl5bK
	 Et6PUrdjgeHdS0TIuKSLm+QLnZdyfFtUqX/pXtr1n/zRMiJYs+ZT2oUtckmFklgxQ/3YS
	 Ltgc1a/5N3N3gf9qW4J4qQjIKLDclt6cxM5UGk42iR3ypUxxShaxvSrMQ1Ldc5yCzCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e2MLxo4i;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T5V89kE2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077C60A381E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B077C60A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e2MLxo4i;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T5V89kE2
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAF0KDn2619465
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gERlYnqMraEDZsYQky6xL2
	HjZPffZDUJmiECrM+pxkI=; b=e2MLxo4iS/q0ToCm+puRAkVllrVerwoJKzEhJn
	SINSMVzJSTBcrgc3m4vxAe7e5zIPzjI42w5XVATd0nWntJsX1WtqEIGYS2eznIRk
	+/t8Hd4aGqoX+7yEJtXCBBTQaK5hLJs+9DfHdNkdnTahJvcH0tggzMkXXQ7v4QBc
	z9GQCBNoAMbjDs2kzrqEIdBJYGs/AKpS/es3FYl4415LVzVZQwnbjHO+HBwF3ckP
	sBt1L4uxjbN6lOZzx9wwA31LTXuwt9PwXnwl1+mcGcr0fRtGw7Acmll4mQ4lTNxg
	x+JYTPcyTBBQjKW3Y+G7bscp2iRh5JSfuk/y1KR1ISOy4SEw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkkqsv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:14:27 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7d2dd8c5aeeso400315137.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794323666; x=1794928466; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gERlYnqMraEDZsYQky6xL2HjZPffZDUJmiECrM+pxkI=;
        b=T5V89kE2YuJEVkUouEA1s75vF/ZdXVkFNK81Ral0RC5Hlf5rtGL/NGcsT7PcZ0TPcr
         lLLDnpiSSJSoO9te81WlODQD+CrUqFi8Zk55jfjzwwq9ypSZwXAXk7XHlkLL4XKy7PEI
         P3OXbgUSiUhpn33jEHXzTct1iLQgNCw/nx9uqYhY5oC7aX5bEbwIf9pYWtv9bLb6exAJ
         kl7DFGKsqva6Ab7ppjK+PP83oPeTqF/MF8Fil8MP9qU4miuYjFEqTZbbo64zFr6yJsIT
         yRcACz4tPCiu84AYFvcK1hktJwncfZsVdPk4vjNZGf8La4xIeoQWYtXWldIA5pfGhFdf
         /bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323666; x=1794928466;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gERlYnqMraEDZsYQky6xL2HjZPffZDUJmiECrM+pxkI=;
        b=WOmpEY6OaUi/ijM28eACxnKXTxI99jo/VjeWSbT7S6m6mjLbxngD0gUrmcSz3T6R32
         XO1QkVw0pEK+l7gN/Olz8vz6zEf5ZHHqhrtEvvb/fEl/EOf2/P4a+qfylujBww1N3AYI
         vrBtPAjhmxXB0IO0/zd+9wEAq62pOLpoQckC2cm8Om9hPWzHHNCIRoDE0Nt27MgX8Zwg
         Evz5/vnChSpCH6Ij96RwFo89SLYrGFdYLPkooimj595iqAifMH0KcPGtcksgZaSYB3ep
         ukUu4byl93ugzhlud1AEm6yJwmh162CHt8tTU5MshFoLkmrROWNCSAT+QoU6B4r4RDfP
         jCPg==
X-Forwarded-Encrypted: i=1; AL+hErFARzouiagpMdD88tDKPnSviNCmLiy8GGxoIe972+LY3UNUUDUm7wv5eAW7AR26WbscwXH+psA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WwNHv4zZrc73SFooWSZK/a5x7okxj2xu5uAfJITgxjiSsvT6f
	UNa6XsA7KSnTMqtC45C59It8vmkwFfNmgiwEX/x8f4eSjdgB4TDDlXF9zGaeqkpdNIs30aVMwIF
	Stwq0OGiCxVvdVG4zQ8mCng6BVdFYvQwuXX97YhHSNPnDdLsvZqjWdV2K4UH/SyVgfFE=
X-Gm-Gg: AYBFou1qT1OCtQHlXvr4jVvwVXaANLQv4jOS5vzsd78aaLYwHTKZ3HsumnEoMiPy3li
	/mjMEL8ff+GS4mFHYFEAYjDNu5jfOfZvGCZ8agD1EmX2cY/71DfEXUVdeM3AppUAfGmVEMBTm8E
	Jn353vyy47eLUg2Ua3c7S/liqpUtn0iXsok6ZxA4QG0lCo0qHwqw+G46xCPZTLBOkW+m8OC7ygJ
	tzrXr91K+1G6D5K7p947rde2/Yc6Omup+R7KQgIEFj34altXomGqmxiTnThIZTqaK8O6FOyJfj7
	+HgktbparBBXRLGKiBRihg6FSnvz0pz4GpzlNGxwUlZ4l3nKvH5gv7uJgMRWtG+2tEPwtnFhAtV
	ckEu/Jn3WM8GwaPaBXbKa5frG4tnp8osiK82LQCR95nPcYyeGNfy68okM1Wdfq1P/+2mMdtrq2w
	KRKDCmcbVa3LwCEDSYY1e8EnS/e8UXrONlAmsIXkqKWI9yjr5lZ/gxDZP5Tc/zih4=
X-Received: by 2002:a05:6102:6f07:b0:7d2:da5c:6f73 with SMTP id ada2fe7eead31-7d301bdacf3mr846976137.26.1794323665685;
        Tue, 10 Nov 2026 07:14:25 -0800 (PST)
X-Received: by 2002:a05:6102:6f07:b0:7d2:da5c:6f73 with SMTP id ada2fe7eead31-7d301bdacf3mr846961137.26.1794323665153;
        Tue, 10 Nov 2026 07:14:25 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba023a1fcfsm29388665e9.4.2026.11.10.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:14:24 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 16:14:19 +0100
Subject: [PATCH] pinctrl: qcom: spmi-gpio: don't cache new config until we
 know it's applied
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
Message-Id: <20261110-qcom-spmi-gpio-cache-sync-v1-1-190440d0ef3e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMo082oC/x3MwQqDMAyA4VeRnBcwpRb0VWQHl8Wag23XwFDEd
 1/Z8Tv8/wUmVcVg6i6o8lXTnBro0QFvS4qC+m4G17tARD1+OO9oZVeMRTPywpugnYkxjJ5eKw3
 ODyO0vlRZ9fi/5+d9/wBeY7dEawAAAA==
X-Change-ID: 20261110-qcom-spmi-gpio-cache-sync-6941bf152459
To: Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=AGIBWyVLxOcee3LP0QFchKj3y11Zq68hX0i5sAO9N4w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8zTPwpa9C7UysIkP3amubYJsjDnBP1JBD1TGw
 8xNAGrtTGqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavM0zwAKCRAFnS7L/zaE
 w5qmD/wNGYXeofKHZyfg4uDHBdwphbjUi5BXcppbofa7dLzcF9ihdFXVJdzakcW79SNmbY1axWF
 8INVJk+/bfuVHzbuXXZeldzDJ4e9tYg06TDPVzy1mVtXXtiYS1PzugwAl0lPpOPT5GpdKSO/snZ
 iJXwaut4grWGf/SvsO/FroNGpIB683ULB9gWXkF7oczNszpIxUaesb8MrCsnxe/qYFI42L83Sbt
 v2+jipdDoLfWXv8BvN7rsTsRPfVFcy+1IvYyAHIPOJuX+JcjUUmHBwOUZlh05u5/88z1KLnLNLr
 ZTBngLBP2AS8EBIEFCHMgv+geeSxPeCN4aNfhu1VELUBnJIqiE2km2VXrfIo6NBdQAKFldRNz9L
 CM/0LExU/ReSPaWUiWv3A6sjQAzqXsJo00KXb82oqRepXhZ5xnuW0k7YTusvuaAbUeHQdOucpbc
 IPSVoGlEUTICJ15GWELYRNkjnZIPCFsrgbMZ8cwnu0zJESt1JfHUmUlpl/DDVUL1G7nmIlVEjzK
 JuWDPaqLBldLnZO2bjUMsrhjBVT42tUmfX5AZg4KoifZrDxVvza42OXpds3WDR6VXVfw/1YHqy+
 NlRX6QtXtv2CGHmthosNe6pzJE4G2xkA1dWRZCOOpDZOsI21/adEjD15eX7K5yEOiSdyQic/DOE
 h9YV1WBE4bwhu3g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 6ElpwAXd_VY6RO9DjzDxwStAGUQIKbpT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MCBTYWx0ZWRfXwuJcaY36VyTN
 crBEhJRKNUmqZ7JQ7PXpKAyfo5hHONwU4Lf8Dp8xhXAU7JmTifCQRrVktUGJ+CrnzbQoLp5EQOx
 RoQqrUZwVwUbfZEKtUfpA0sdXnUtwog=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af334d3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Gx8430QjnXqzkbs9h0IA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 6ElpwAXd_VY6RO9DjzDxwStAGUQIKbpT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MCBTYWx0ZWRfX9wDWotXdaVEo
 mOtQLXoa95JnAVWsL5NZBXCO2WkMO0SPZ053smTEndRW9WnmUiG5+hlsuUjAihWLrObq15jeo8R
 63DxlkPkK/Ba2URhMvblye3R8+vqmTHdm9Bx/sFqisEgxDYNYLQQbTMzfUcNJ+AYW5UCLw42PB/
 1oQyeCSb8T30xo2/YSXPKmukuj8738QGlwinQHdNpqBc9vO8dqJzjIjhNB+gPQlaCDObJaMRb5C
 uFlY1Ig1Gg12+SOyaDUeR6KxiCQmR2CkCzY0K2QOkNhy822RM6SeK+Bfm4lKLpS92qHXWKN5Ugt
 xqW8FbIdp08UjixO2Scc6IDbj9EB8kNQ/IuRbm1ri8p0DfS16vRqWpZjTX8pecezPRM9IlESwSp
 2IfCjapyK+WP3AYdHKAKjl0EEP7RpkNAa6iNSYw5W4AMsRs1N22TQ+hKs0naBh3svbSqFu7ziNR
 yuxaoEzSbpObELbM/lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100060

pmic_gpio_config_set() modifies the in-memory settings cache before
performing any register writes. If any of the calls to pmic_gpio_write()
fails, the modifications are never reverted and the real state diverges
from what linux stores in memory.

Work on a local copy of the relevant pad and only modify the cache after
all writes succeeded.

Cc: stable@vger.kernel.org
Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller driver")
Closes: https://sashiko.dev/#/bug/linux-49f0403d-732b-497d-980c-109c36c92597
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 05291b7397d6b15531e66f073b8771ed318ed5fd..7c4266efaa27619508f0cc3cee8f8a607f7bda57 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -480,12 +480,14 @@ static int pmic_gpio_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 				unsigned long *configs, unsigned nconfs)
 {
 	struct pmic_gpio_state *state = pinctrl_dev_get_drvdata(pctldev);
-	struct pmic_gpio_pad *pad;
+	struct pmic_gpio_pad *old, *pad, cpy;
 	unsigned param, arg;
 	unsigned int val;
 	int i, ret;
 
-	pad = pctldev->desc->pins[pin].drv_data;
+	old = pctldev->desc->pins[pin].drv_data;
+	cpy = *old;
+	pad = &cpy;
 
 	pad->is_enabled = true;
 	for (i = 0; i < nconfs; i++) {
@@ -651,8 +653,11 @@ static int pmic_gpio_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	val = pad->is_enabled << PMIC_GPIO_REG_MASTER_EN_SHIFT;
 
 	ret = pmic_gpio_write(state, pad, PMIC_GPIO_REG_EN_CTL, val);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	*old = cpy;
+	return 0;
 }
 
 static void pmic_gpio_config_dbg_show(struct pinctrl_dev *pctldev,

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-qcom-spmi-gpio-cache-sync-6941bf152459

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

