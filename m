Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619691;
	b=hOcU0J/qfO2nC2+/eyEBPGC/VCxEAXiV4INBm0MdDbAoHtO19FPtb0fbja6+t9TH1SuF
	 Gbk/MO2HagNefRPc9QcV6C3LWvrOA35850D8CBSakfO67JhqI/tx6C1g/Ng/PFbnkDBaW
	 R2hRiXkctrl+PSOX1LTnAf1CfCD7T+bdCtD59k+wRibo9iIbKFwM3OFp5IUKYOaSL2rdS
	 Oj5Z4W0d5uhLMLOFt8vKW58W6rE83uR4r+9a9CpKHeaei6SP6fqMSt/kK5bACUPDI5xSp
	 aC3PKSeetR8HaSj/49CiUtVWcIwLkPnlVIIyeb0DmsjxDwvDaN9tgoKhYtmeJa0Yzsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619691;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DfILuvUDP/rD7AiORGLKXm/sfLDG2w5A0n5tcVIlud8=;
	b=o3IuPup27L6TIUrQ310ihlXdUQy/Jc4yA/wbS7FOIb6qpee8LHFXnJNGIMBjIQgbLYCm
	 0uvPGYKe8K1Ejs4JK36BVLOT5gB8MlhiOorkp7HE0+Eqhw2ay3kLPdIOc/5/RTiVZRMja
	 Tt4gFvg3PUW+hArICNBciHrJnAWwC674aMIS1RtZejBctlFLjkqHdrMwhZsnyrP7UPqH4
	 GXFysFQ+kDwJIDf0u+MoINmeN/tQKO0wvNPmG0W1bW2xC2KRCSsdoQDSxW6s/Ue/Twqes
	 OC27iSqFcn1VSpyZHUf489Bm0YkiVvUtxzLf5TVgHx0wn0TtgMBZb7Dzi1wekZAAD3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQOd2vIc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEY7hCov;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD75606A32F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD75606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQOd2vIc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEY7hCov
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A6Ux213981
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 11:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DfILuvUDP/rD7AiORGLKXm
	/sfLDG2w5A0n5tcVIlud8=; b=jQOd2vIc0qSvFzdlIoWJFtraM0Wj2KSCXgKGds
	Xb879iAh6AtMO/ZtVvJNO6VM/g/Lb4mo+xbiUIM8MqpZgujL1FA0L3ZLxNDN9wsA
	RTsN9cO9hQSLGgk/n5nKM8cJquLI6LJvHkOnJZSwQESoGLK4nbP2kCzOIiSuEJL2
	1mQBRZ2hjreRZq6xFh829XNwbn0THf4vT8oD4Iui0mrzhMRAiMqgDmEBsqfdWxVv
	UQt+nvikhQi1W1HaowRU8H/fGLTnGaN+RysSsdi4P3To91dGN5UVVvQksmISSBnL
	x2TJFqDlNZXxo2sg6Y2+e4MG/GwKiLzUmsVLVlfTfXCQ2KMA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1sdbk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:41:29 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-99062be02ddso328457241.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793619689; x=1794224489; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DfILuvUDP/rD7AiORGLKXm/sfLDG2w5A0n5tcVIlud8=;
        b=OEY7hCovYWTKdNqHJmzc2O0JAXc9FTPYxagmtf1XQGjSg/koaOkJKfZFvGaCL7oWYV
         5r1FN4ZP8IQNv3IhCrA1t7T0DMzaWoqPY7v1brYq+MUfNQyPnrpAEtg/Yb1HVkIgafmi
         PV8FC3K59CSXStrGkD98vOONyDPvCyilVE6Swj1HPgsm615sGHcbHj3NADGDMJn9qoW2
         nBQSibwe/s0t1+ixlCLnefBJ6uXClLDEywcVeFtD1fD8oINf2jfEnap1JeD+cdnZdX/q
         2SXu20xY2OMlOdBRxInqSt6MMCBokKB9660ZT/5zTkZRGehaDNDjtOedIB+gX5u7mVtI
         gBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619689; x=1794224489;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DfILuvUDP/rD7AiORGLKXm/sfLDG2w5A0n5tcVIlud8=;
        b=PIQZBDzgqEP+6X5GJk62vpfVfNEyoo5FVwLDWRFBlFV5TSLxFUileyZ6PMh/y+Np/x
         AzccWTGojJjNXHWhtNBKRJoPQ6WIZ6UglHhcQppeQ2fh1qMmibbCoxXXv15K1FIcUMeC
         FgYmNEdnKp8+Htlc1Hroymldq3t2vZgTyS0DvbhJMgWVEYCGkatdyB+zRNvYLe6JIqvy
         pLEtqufbJLXE04xT13hlEnXFyXCkuV/PUx76LtIFU2hN8tyAb6SupRGEmZ0f1Oj7gtuM
         VZ4T0ltnUKabxsk6T/O2eAX6yR+l1Mz3NuDHI39/YbBpkKUCgzwOMxAcL6pVhTJEbRNe
         1ttQ==
X-Forwarded-Encrypted: i=1; AKwUvBza3qgFL/JzhfGSDh1E6MaNg+cJHEw0YVYJnu1+6qLPCCXvkDndapUK40u+/7WCbHZyJztAImY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vzbhO8Cu1tpEMssaxmipC4KF03u3kjMR1eTrjBwGz1jLxsmxx
	M9suNe50Fh4dbHactey4d6F4apoUs9hYpOr6tZvWrFZnEm9GtcfjceszmK4kCiNClJdyWcV6Gmm
	H2qTDp1uf8qDY8YF9sT2U3yTBXhFZnhe+608cLICEDgwhHv9d6tTEvfJTYzk=
X-Gm-Gg: AYBFou3Ii/ucsomkyWBN2j4LejpwtccN1HHiETYoFRgmymqCsqCjjBcSWnYnGHo4NLR
	Qk3DwhWkyhCp30Q5EUwy8QcexL3h22dNYrZSS3Wo3fpA10A14GDDTZe78rGIiVVXT7jy36NJZ7T
	8jzGpBD8egp4qTn9XAaT9ltq8m5110+xpNJ40pEG0Yb2Nwv5yNvRKNt9a86RI5DssQLp80u2leU
	1vlrmK/oPZmGR4rWwR7dyTVcHbw1kOG3D8Gb72iZdUS18+t1l0+GIbvXMdClmkqoC80GcwTE9q9
	dVCBYZUu1uiyaf7RnvnndhZOKnU3kg52Tg2zYow4mEH4QlpBfIunGthAonXMyfTUqP00KV/to1m
	mabYvSDakXVttneq4UZ8CuyDvC+FuGlvQ+sYNNQJtL6u5PObBxP434B/uAA==
X-Received: by 2002:a05:6102:5487:b0:7c1:75c5:c4c with SMTP id ada2fe7eead31-7d072605206mr2815187137.25.1793619688655;
        Mon, 02 Nov 2026 03:41:28 -0800 (PST)
X-Received: by 2002:a05:6102:5487:b0:7c1:75c5:c4c with SMTP id ada2fe7eead31-7d072605206mr2815175137.25.1793619687806;
        Mon, 02 Nov 2026 03:41:27 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d511sm19275953f8f.8.2026.11.02.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:41:27 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 13:41:17 +0200
Subject: [PATCH] power: supply: qcom_battmgr: Fix pmic_glink client
 use-after-free on unbind
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
Message-Id: <20261102-battmgr-client-teardown-uaf-v1-1-972fc5a5e0c9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANx26GoC/yXMMQ7CMAwAwK9UnrHUhMDAVxBD6jjFCFLkuAWp6
 t8JMN5yK1RW4QqnbgXlRapMpcHtOqBrLCOjpGbwvT8613scotljVKS7cDE0jpqmV8E5ZsyHvc+
 JQiAK0Iancpb3bz9f/q7zcGOybwnb9gFbkk3sfwAAAA==
X-Change-ID: 20261102-battmgr-client-teardown-uaf-f532fdc44cc4
To: Sebastian Reichel <sre@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4946;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=x4fAiWwCWzADg3m0fRd4Wwzu9DytOUqrL7kGuWcpYQQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6Hbleob7tW6ZrMlRVyafq9Zo2qBIBRsM3WdQH
 +kJcv40kJCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCauh25QAKCRAbX0TJAJUV
 VlFpD/414DQ0ZY+4lpuTbLvFvdOUtv1fxWzc8zIF3CvpB2iQHchcbcLUDWmXA3LkmVOgWYqPtKA
 iJJTfht9oYaFJ7bKqbLKCcY0Mi2KPGxfvLW0wEvtFMBzZDT7lbG0c3ldAKIkmxa/ZuxSrdpXdAS
 9JsFRnzxfn0t6k/rRs+3jAGzTbmH3tdtozTzWJflktYMx74Mj1I1dmKcKYHI5FvfxK9qwt8gDQg
 HQzZxteuhyQ3cOKEpB9ZowIopN1B21XXSLqusz3pD3xOjOzXqJABlxN7YCMhUr0/YxSK8yfydZs
 DezFnJhgYZ20y6uS7heAY8aQQp/IOR2Ob7s3BjogGYaZhPf/0LeG5v/VIwu8rt5EcGeR6xC030J
 UrVhqHEK4ls3/D/u7fvE732ltK3r/SvfOitB+dpIVSXbYr9o9SpQqstE4akBDwrCtkcXIDK4OtY
 T2Mm4cWFjrhP2f3KK55IZL+yYCaMboNeaPwkG5nJm3Z/aiAqI/fuk2B/Jm27owzE1uazXgGCCpz
 ln/ZLWtm2/RebgxP9F94eKP655xBD6YncNnOgJS5P54zPCqBnNbUEuu5/H7s3HAvS4M+aq+hFty
 O+gj3T5UWzmZouOL5ocpJVf0nujT8f/ygirJYAAvuWBTq0k6yUCc2JD0ZP5WUn9obSoOA86xpJs
 OMeR84AMnxg9BzA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: 3RQ-k0I4lpIwHS0UQuqgVj8Oc01ZOSkz
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae876ea cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ehDivE5OXch7XbvYWcoA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfXyPJxnOmw2+bD
 DYaUdn7N9dSZPV+NX76+cvFDSaqRA4aP27UAxCtmrpOPqDqAXzqtjDCpUwmD4yGTf8hugcuzrZs
 k0pLCFrV3CDRvyaNG6mwFABTXXM0n7VGS9wDzjPPj1RNyR6CfbjOG67XgwjwS3dYjiN9fn2ki6c
 Hu3pkXm0/ks30m7VU1poJvouHSY6Gk5vD0RgS+CPs/xKaaemRXXavJUHhfu+zVfy1zJb/8tFgjd
 FTVtsaD2fw93STU7LbZDzlUyCAkIOtrEuxJ8ZWZEHeLP79pF08jb2XNQ6AentTHxjdZ25TpCnrE
 4xY962EUa/QFLXUC79M4yrIW5aEq/9wNpFutodgz9j213n1hxvqcJYwzZdxTWgt7GiDae68Zj1P
 d6MKVtbLvAQnIeq1kxfvfLT/Uaiss+yO425SrFc9P+FC9p+EDkRd/yh2bkUye5Jm6dzz3HUo4pX
 OHpOnBTpWLgUhoyD2vQ==
X-Proofpoint-GUID: 3RQ-k0I4lpIwHS0UQuqgVj8Oc01ZOSkz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX8tc7ZMUjI8AB
 HF8thgAQdu57wAcEjnbf0nzBqL+O/pneVtw/L+OkHwwyeWiIH2qShrTygBn4eVgFoEuHm2PmGxi
 fGVYkC6Exbk8b6LJYlUsp3VphJwJMOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046

Since commit 4e40befedfc8 ("power: supply: qcom_battmgr: fix
use-after-free"), enable_work is cancelled by a devres action registered
before the pmic_glink client, so that on unbind the client is released
first and can no longer requeue it. But a worker that is pending or
running at that point still goes on to use the released client in
pmic_glink_send().

The power supplies have the same problem: they are registered before
the client too, so they are unregistered only after it is released,
and a property access in between sends a request through the freed
client.

Fix both with a devres action registered right after the client is
allocated, which runs first on unbind. It disables enable_work using
disable_work_sync(), which waits for a running worker and turns any
later queueing from the client callbacks into a no-op, and then marks
the client as gone under the lock that serializes the requests, so the
power supplies fail any later request with -ENODEV instead of using it.

Fixes: 4e40befedfc8 ("power: supply: qcom_battmgr: fix use-after-free")
Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org # 6.10
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Found while fixing the same class of issue in pmic_glink_altmode. This
completes commit 4e40befedfc8 ("power: supply: qcom_battmgr: fix
use-after-free"), which closed the requeueing of enable_work but left
the client in use after it is released.

Prepared with help from an LLM-based assistant.
---
 drivers/power/supply/qcom_battmgr.c | 39 +++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 636d6f6acecc..b37b2f665f7f 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -5,7 +5,6 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/auxiliary_bus.h>
-#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
@@ -339,6 +338,9 @@ struct qcom_battmgr {
 	 * firmware, as it then stops responding.
 	 */
 	struct mutex lock;
+
+	/* Set under @lock once @client is about to be released */
+	bool client_gone;
 };
 
 static int qcom_battmgr_request(struct qcom_battmgr *battmgr, void *data, size_t len)
@@ -346,6 +348,13 @@ static int qcom_battmgr_request(struct qcom_battmgr *battmgr, void *data, size_t
 	unsigned long left;
 	int ret;
 
+	/*
+	 * Callers hold @lock, except enable_work, which is disabled before
+	 * client_gone is set.
+	 */
+	if (battmgr->client_gone)
+		return -ENODEV;
+
 	reinit_completion(&battmgr->ack);
 
 	battmgr->error = 0;
@@ -1626,6 +1635,17 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 		dev_err(battmgr->dev, "failed to request power notifications\n");
 }
 
+static void qcom_battmgr_release_client(void *data)
+{
+	struct qcom_battmgr *battmgr = data;
+
+	disable_work_sync(&battmgr->enable_work);
+
+	mutex_lock(&battmgr->lock);
+	battmgr->client_gone = true;
+	mutex_unlock(&battmgr->lock);
+}
+
 static void qcom_battmgr_pdr_notify(void *priv, int state)
 {
 	struct qcom_battmgr *battmgr = priv;
@@ -1676,6 +1696,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
 	psy_cfg_supply.num_supplicants = 1;
 
+	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
 	mutex_init(&battmgr->lock);
 	init_completion(&battmgr->ack);
 
@@ -1738,11 +1759,6 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 					     "failed to register wireless charing power supply\n");
 	}
 
-	ret = devm_work_autocancel(dev, &battmgr->enable_work,
-				   qcom_battmgr_enable_worker);
-	if (ret)
-		return ret;
-
 	battmgr->client = devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_BATTMGR,
 						       qcom_battmgr_callback,
 						       qcom_battmgr_pdr_notify,
@@ -1750,6 +1766,17 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	if (IS_ERR(battmgr->client))
 		return PTR_ERR(battmgr->client);
 
+	/*
+	 * Registered after the client, so that on unbind it runs before the
+	 * client is released. The client callbacks may fire until then, so
+	 * disable rather than cancel enable_work to keep it from being
+	 * requeued, and stop the power supplies, which are unregistered only
+	 * after the client is gone, from using it.
+	 */
+	ret = devm_add_action_or_reset(dev, qcom_battmgr_release_client, battmgr);
+	if (ret)
+		return ret;
+
 	pmic_glink_client_register(battmgr->client);
 
 	return 0;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-battmgr-client-teardown-uaf-f532fdc44cc4

Best regards,
--  

Abel

