Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659496;
	b=kKt1/AGWvJq+GdkYKmZy8okurFngwtAfaBMcYoBjka+hryylGCWeA/T49VGJrJtdopNL
	 5xxCOJgCTAQa8Ckhh/beCU/VjuTxAV8rdeOFbym5wpV+NGZdt9CPotes9m37F4CTG1pyi
	 N4MJTvrnwdX2npurtJSkcgRFP1NjjINm8fOKo0MDjRq54/kX0HKVTgFxl8qpgNDid/gxV
	 dQWRHvA45YyOIdiSX4jfZ8ivuUpsx6XFUT4bbtOcQ9dA5Qmto0vbRh2m2OEwwYWEh8Cbn
	 WwpVIG/DAcBpP3l0GSaYXRiLqW0HgCHrwX8a3cUkC9SJ5x1+by0WaoZU9N2Jb7D6HfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659496;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XifzIrjO8Um2mjh4fUxoQvxrf1F5cyhzZDGnoH8FPys=;
	b=BExizSaigaBBpkzJc4nsQo9ujvVUofRmwS1pGidWJf9JHSDIV6CRhCh3h6Bmr2sV9Hy0
	 OhPSUC5nlzciu0zmdzovJlojECbBLJQEpa00XCA6ZOZhjPdBVJUfC9VVpmAWjmEWdFTMy
	 eLYTnkpPrCevRaKQdX/Eg6RaHgnIAnZDZe+a1p4eVgR/nC1lHQlpqMZnQU3k1HfImSf6D
	 J0Dom7nYLsvLMeJRjqgIvTnXXoMIxzxHCJOjJx/JMvdTvlSKey0ecwnwYQQJAQkeyz3Nb
	 lUWRjB3DtbjYfnQj9CoewsycobRXukUa2lk95LTdU0EBrPwhYdqWMP054eIt7Yd40Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VW6AFGvi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VPz17Ghx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53E606A336
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E53E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VW6AFGvi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VPz17Ghx
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M704I84110612
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XifzIrjO8Um2mjh4fUxoQvxrf1F5cyhzZDGnoH8FPys=; b=VW6AFGvidHvKBfhO
	WE2RWh5ufFFB60dLU7NsaPdLh0BQ7CmPsBiLA8z1hKO/mD8J+ncL8t2ggbVdStX+
	yNOPP50GMCKfoZV0KCNKWGtQ2n4WbKUcWN5f3NyQtd1353UuSqUAJiH6GDNN25Wd
	qtpM1Dq0SS4aN2/u4cL79iksf+oy5MNGrT6pZSvKU3UTsjyaNOQ7NaHKjcjZUe4r
	6a9OlV87KooNss2MJIbi5lVB6/xaP+Wx3cvMcb1YZDOMkgvtp+7x7dMsD05aHv/6
	a775mAlYqPyXuj+AoZUbEaN7z1JMUX8akZTW/axd+/isVjstbYu7yoOTbQLgvRC/
	jGzwfA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahka3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:58:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f62934ef6so145851385a.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792659494; x=1793264294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XifzIrjO8Um2mjh4fUxoQvxrf1F5cyhzZDGnoH8FPys=;
        b=VPz17GhxloW3VAoJa5fHOxzmYca5/oOSq0Ham9x5O1jsiSkJG+KYO+h13JTq8rNmLb
         UVJHU/cXoK5+e8SSPW6qye9zLxILJiR+4JeY4mTuqJf1io4ZRR4DZhhuoDSdMswW6Evl
         yq5SCLWyUJQo5NIUXuJUmr1I/NUrs+BItq1ZFlycODc3GbdDS14DEemz9FykePak/YUk
         Vk6QX1M8AZTvWBhRW45Wj4Vjy/dA6mEJXxAr7RRG3/TcnQ8Q3Te3hgFpLEdtmDQ5ztLz
         mv9eQaFG52+TAKQYw/EtgndZSBQBpZUo7q6rIJv0qKKOh0z2WVmLu+VKUWXk+xHPRZLm
         dePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659494; x=1793264294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XifzIrjO8Um2mjh4fUxoQvxrf1F5cyhzZDGnoH8FPys=;
        b=P9qYTb1u6YBgiO7deGJyRFzQgxQW+kdI3MUVgR/l3GBene/ENYNFg+4Ofh5JOVTD4i
         PHC+BT8mW7gAp2XYBXN3CdhUW7mC3y42w/8uKMIjp35N2WvGfXidTlhKiBMZJRnImgzl
         6twRHCgcgVUcsyjUANnajSM8TzFPWXsu1+iHPlI0/bpQdwVusPhEUdKEL2xnFYqXKwet
         n4cLnPt4eXXWq8HD/I2pASp++KdEorIgUje61TkV/ozHmzv6FPZGgzLbQK8ZfXLa1mOa
         T7ZkE+P3AVxC/GbruUJ1VrDTtY2dQrJ9XUJiEvBsZC5x5B/Hd06F4Lgov45eqGo2tz/3
         t56Q==
X-Forwarded-Encrypted: i=1; AKwUvBzI8Ipvk7vz+wotV6nkdUJH1q6uEe/h9GtrcvQz4eYWIm9yLlJuD0oalYiWG6c0MC23YJXeIZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnEYGeJA13leRXe6gBQ5GU3vPmxdik/LcnhCDIAaMiB9ZYJBhu
	BFxypbFJxAJ+D0sUnwzzbFK/arXiD8VbwMNhx9HlCuanioGvA3G9a3a49YFJTaM5k9reZzwEhvF
	XnJ4jvGoV85hJdNUlJqHbzLw2t/7ORGHm5blw59iIxf7D+W0fn7UyUeah6Q4=
X-Gm-Gg: AYBFou15/ApMzConFwNUMoX4U8Qi6zGKjzVSjjyrENnFr77XgIza9dzbzyCUXJcDmlD
	oiFUOYGkYfS5vDuPToU42V6l5lPW7q8i3Omv8a+oSwXC865OCRty/2dsT7NCGl4J4OF89KzAzsT
	lzzkIVmw28XExqG19ICoyFCHDgIpckti3/Oqso6G3Ke5USc3Gth62dXq/MDAONCtkib2e2p97sS
	Z5qBVMGGvO+g/JXJ7u/UzVMqUd/kmKTPAcQT4FzGEQbLZKgsCMekjVjlRS7dTXYvq5FZ0ydwrRu
	4Eapqh1Y7bYmsSZ85J/gsYnN10KFFZVE7J7PyAKRHQ0GFzTopV4DA0IICvnTuyhsPq1GMlufPlD
	tMDECBZFl3YZ6p+mMg+hxOu0yYRCO
X-Received: by 2002:a05:620a:a89b:20b0:93f:3120:6c84 with SMTP id af79cd13be357-93f57f1cc67mr569441185a.36.1792659494193;
        Thu, 22 Oct 2026 01:58:14 -0700 (PDT)
X-Received: by 2002:a05:620a:a89b:20b0:93f:3120:6c84 with SMTP id af79cd13be357-93f57f1cc67mr569439885a.36.1792659493799;
        Thu, 22 Oct 2026 01:58:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b28f70sm61625525e9.4.2026.10.22.01.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:58:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:57:59 +0200
Subject: [PATCH v11 1/2] crypto: qce - Only register algos if the user
 really wants it
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
Message-Id: <20261022-qce-fixes-broken-label-v11-1-0d33c34fd0c3@oss.qualcomm.com>
References: <20261022-qce-fixes-broken-label-v11-0-0d33c34fd0c3@oss.qualcomm.com>
In-Reply-To: <20261022-qce-fixes-broken-label-v11-0-0d33c34fd0c3@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Birk Skyum <birk.skyum@pm.me>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2114;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=W2vrkLJdRUgwbRgUUdohghAMPZS39GSW1r50SY5zt0A=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2dAhq4Y5Rmrd7hbC87snEjHpGkuQUqK4WRtnk
 NxCvMnPL1uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatnQIQAKCRAFnS7L/zaE
 wyMoEACM4oZvzD9i8QC1aYfvOs5DajtJp9MEM6MGeKA4kxme/ayD10a+lSzmOLT/EqlYQz2F6tI
 RF0QNFJgnPzxzkoZOuTXRRq4+axxcWxnuSxhXsbwxCf2KJtw4+LqwKV2//rKjsiMGuGjAY4rkb8
 45VFhuktgEGhyWu6mMRywmgIXqI7q8hWOOLuExFo2zCj5ye5PgxmzxSqyswJsR2WjWVrZwthSP6
 W3uNPvxtqc+vzEKm83IuL/HuKJcjccBbNm//v1xnGGvw+doBuG1sz07ni+CX2o3G0TJk8GGZ1hF
 VmlDJeKVC+0fqejZvvmyWMrGLQTIK8h/Qa2ORWR7OB1NFOwoX2uB0z1cEI3Fkkl2W/CFFNN6Dyd
 xbv+B1pdCNjdLkN3akbEkzsl80K07HIPD7+Lp7PKnP8j/ZaWX9SpWlJtu6u3Y3s24nWb4xAAc7E
 hRNpyXc44jUJWJmRxy8t9bBS7WDgSTNpycyyNZqjHfBpnWhhd8BR3VQmaI+MOyzOFQmaTPgaHrG
 4oK9ehRydsGwNd/D1OBR8WMjgjidYafL4RIiBzQiJBXlVyKTS+lJp2bjGJF3XJ4w9cuvh3DSdQY
 qrx21B+XD3kkhKDJJPr5JLue0ZfXG96/3dzgZLM1eDc1siik+1vNqv6YoR8eJKFk1peVjSZpKJ1
 AO7u43TGZxiZ0pw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNSBTYWx0ZWRfX2wc/c3iHRlxD
 KPdnBQU/nlpV59bl+M//m2x+O4apbMuyw01Z9D1Z1P6MS+i8cSXmvz2Y6z5YCXKJsbRk1z21hyA
 GHD6tbJnZ6n0f3sHG/NQgTZI9uifOdSoESi/92eNUhX2SSb0fancL231XE380rwVnyRujIh3Hmn
 ZnorNUzK1dNSVg6tbDsaQZSukdJ6/DUypkkO4Gpcz4FJAyKWz0vWdPDFVpfeYxOSLtibAL/L0Ri
 VUmeTc5XhoVFozJDuvOWlCEo9MEkJ0FSfKMACfAh0YDxNScLUFgmNqLRJ0yD1ko7zIbehPzNNvi
 dMEeSFSxAebQGGlMW1b/3tHld4velddbCPPrmEx0KJjx9++2kjPRr2RUcYUs5PUxSxAOFhsfqWF
 6AjZ7iBs1wPcwv3pJMS67duOWkp5UGGiQmGnmD4IZMjo1uonBOWd9Dev5JNCYKHEjqsfcnrMEw1
 Un4qpOx5tThdez+AtxQ==
X-Authority-Analysis: v=2.4 cv=H7FOUOYi c=1 sm=1 tr=0 ts=6ad9d027 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XywcRVADl8Xu_msC9vwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 2M4Ch5w05Yv69AXOfIQ3g99g3AZTqLXD
X-Proofpoint-GUID: 2M4Ch5w05Yv69AXOfIQ3g99g3AZTqLXD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNSBTYWx0ZWRfXzqlE4pzEl7v9
 yGKsKJ1wIIlYM2EuTz79ggep1e4BruYVC0cxSUxaPVWHGJwwv+MOZWvtHMc1Xqwf9cQBbvgomOq
 +Qti3lUDWM8CoUHeZODLV/Dr8GjsrgQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220035

This driver's crypto algorithms still have a few issues that need
addressing which don't currently trigger any self-test failures. For
that reason: don't register the algorithms unless the user really wants
it.

Add a module parameter to the QCE driver that by default causes the
driver to *not* register the crypto algorithms. It will only be one if
the user explicitly passes the do_register_algos argument as true.

The power-management part of the driver is kept as is to allow scaling
down of interconnects gating of clocks by runtime PM.

Cc: stable@vger.kernel.org
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Tested-by: Birk Skyum <birk.skyum@pm.me> # X1E80100, Lenovo Yoga Slim 7x
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index bf3c1bc3ba7bde5e5d08e06071c67ba77af95695..5b1bf7a50f88c890da1f0820fb9e070b3d3f4708 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -10,6 +10,7 @@
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -22,6 +23,9 @@
 #include "sha.h"
 #include "aead.h"
 
+static bool do_register_algos;
+module_param(do_register_algos, bool, 0444);
+
 #define QCE_QUEUE_LENGTH	1
 
 #define QCE_DEFAULT_MEM_BANDWIDTH	393600
@@ -259,9 +263,11 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	ret = devm_qce_register_algs(qce);
-	if (ret)
-		return ret;
+	if (do_register_algos) {
+		ret = devm_qce_register_algs(qce);
+		if (ret)
+			return ret;
+	}
 
 	/* Configure autosuspend after successful init */
 	pm_runtime_set_autosuspend_delay(dev, 100);

-- 
2.47.3

