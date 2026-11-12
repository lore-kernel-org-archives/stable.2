Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489629;
	b=Th3JK6EHcy56ahuR94dNZoIjgRK52J+5BPdQkvRIsBjgnXeksiADeYw9ZKOpz2NJBzlN
	 cEasrty+xJ1YtSXRSrjPb5Zg19gxEB3Q7mtXMpDHfG35zSyMv1w6mArOdGGLaHAYqQDq9
	 CNo2q0h7iq204OgagpSL2+VjLEmEN0p5b7ZjWAcYSkFlFcU4sLw23QtW1PEhkgPEDYA4B
	 JjFJq8tfyhcZWi7Ksi2ZAADzA95Ve7YElFXJ/CQbAYfyS1HcMRdcTwHAAgM3hpUYLj4yu
	 gI8L/PQdgD4o3Pr7fisyJ4GMQ4yn2eIbwDKGSewTLmkHRSYLxZ3Azqi21EQzmwgQPzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489629;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sOHdKOtYrE6ti1WsC9g6oDfDHzcpc2yHQ0W/WOvdgbE=;
	b=1B36gpb4LS4Yi5czxuHL4iMPGNVfpxFPocUEgLs5PktxPy3M0ksuE8Ylsaf+e8BEduQ/
	 xe1Shucz9NxmeAp+ME22Jz75OZyK9IUiZa1cuSgGVNMJKu4rTZ9zHKpPwjJzE6GBo08/8
	 1jF0cuinNawsS+ZV6rGnUr04xcy3GrwPHyVbvWJ/QUXQbqEfkhfOOnyoKTvXVxGIfCTVh
	 Mg5rONCJneQvB/k7NK3EQ8c2duYnbhOla/9LnbnswJc6Xu9rlaOl5teE9xaprATwcrP6C
	 GoQpdorlP1psWuh4wTfXFC9viLsvv0iZ7OUCNImRKxKzgCDYONjNdde/vw6ShJ0MP2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RTDMxJkF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X30QB+oW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142E606A8A7
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D142E606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RTDMxJkF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X30QB+oW
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACBSwR43477469
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sOHdKOtYrE6ti1WsC9g6oDfDHzcpc2yHQ0W/WOvdgbE=; b=RTDMxJkF508Dh42y
	BaoG1QT6krm5io92kTIWgovSydZvkRbbYWPAylkUMdx52dharX1koMAVwtZ8+VeZ
	tTRuOg2fyUhzQwuoHPinJzOnAjKIgfZQe0eqIYiwp2LgsDb29upW5LCIcEuQwhB4
	6O5XBOmxtOjBdzSJvmmbseT34r9CvVjI7luek1oKTBU7L26D68Li2d7kHtOhi7gn
	87EbdNi97UAlPilkGjWSj+bK/8BkXN1WA6E0qQg//+AIQaZ0TzmQcSeYcBEUEEt8
	fMl79a7n4O43kEZoHcECn50f0r2uCx2VhHXdtwBAb9xy4+DPDBtGjH7RFjyD01NN
	i+qfTA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yuhp73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:20:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f33438950so895177085a.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794489627; x=1795094427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sOHdKOtYrE6ti1WsC9g6oDfDHzcpc2yHQ0W/WOvdgbE=;
        b=X30QB+oWTGZo0rVZrGSxIHhR1caepGSKXiWRJGfgnXlHlILQ8+fcRaVJKEnUQIYJcp
         qWB2xRu6r/prtd+CAJljvP+l16wvj159B5a7be1OykQZx+dmE1m01XYOEsD23ZvLW+5f
         8JgCozWYTLiazqfPJnne0ZLOy8JF9lhnU2okAncLMwdxMSp+5lV2EPsGSXHnCP+Yxwqf
         R+wWZp9tQso5u4t/vjDDg22U2HaUJTqTvyFFzU0M4UOsHjwfYCqxpB2OyZCHgJUAI7N9
         89vo9TGbW4Vq0Z9xovhtf6s00UFLkwDXfJAMS6ie39Vd5j/ZXzVQ6KRGc4qPHl7qKl5r
         REVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489627; x=1795094427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOHdKOtYrE6ti1WsC9g6oDfDHzcpc2yHQ0W/WOvdgbE=;
        b=CkV9GqoKaMqieIAg3y/l6eIl6xNW1AHBJARRG+5ojbhKlth8QGF1tcD62qh+wuVMSV
         RFtwhWP5bTnNq8VP+M+NsoIYcyDrfMTgciLijc80wPgk0dvoNsuWLIqPzszTxoJ6S6T+
         KKibV1gQXAi3Nwwc+rdCS00Es/6em0TOs5thBFVKk256qZjstd0QpO5vj1hhVnABnoqk
         UAFvDELzDCjLEuNPDRSKZ8wWpZ0VksvLP7jSm9FsSViHC5unrPL5fTkN0diluEYrwJ3r
         EQ+4GyrbgMngJxgSAUgyGnYNeP1ByhrnMSD0+WEo1mqdZOK0FACHb6c1HacoO+pUl68J
         N3Sw==
X-Forwarded-Encrypted: i=1; AL+hErHXcMArQs5Kd9bSBEM5TScmZJQqSK4kcJqjmXkVLj2E+ik5mT8d4Id+hZXJ4LIm8bWxfloRL9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jh7QRDQjK5JVcbiJwsamGHnZGv4wPmu07VujwZ9oI+RmKE8q9
	GVwPRcW1CZ5MuNqOJYYJLq8aTPgRt0h/0EUBjv4UlcC/SDFSCKP+om/boP70M+Wt14Uj4LyKUHw
	BTUWCDDCM18+NtpFu13dmd7P6t+hWQDX2yn/zoGayeCMPCLJBswkDn1Q1ndo=
X-Gm-Gg: AYBFou3aF1CtW0SJXehFKUHU6AvZ4JG8kVqGrX4sKEhLyi2BoMdGVWKE7AqoHJAoJDH
	eBmuAAOlXsJgexwMyv+Rpe5ErnNJQ0OMT7MEnMFZ6bpDis0eWQnaH82JDr5a6O9DGS2dhgVQfQG
	CxkC1hb7eq9lGiSAwmUbgnfr2Q6fTTx3ghHOVHeDa/zzNgC/6HDuLZullw05uvPMiR04Mf8Khfl
	pgQuxwsJZQs2dlNEGo8TDL9691B0OpXZpNUFVSq6WpX/u8JBSmDclyfdrngwZJtijh9/7l3NMI8
	uwAjPo4FXQQPBpKjbxGyMxb48C5SLU9bzb393YdzSPFt1uGxrV33fxiHVq2lNAjLtbsGJRlEJkX
	hxf23548ioOHmd5QUd/ZtXxUUhub4OKNow1jhFz9aecwU4SdgVNmdO92cJd1GDSGV8PVM6JrRLp
	vcFgITw0CAMS74mSnMoM7M5Ywmvr/uq4vIXPggvW7ygheJHPQNi97ZdbRs4GqRyxw=
X-Received: by 2002:a05:620a:8018:b0:93f:4921:6965 with SMTP id af79cd13be357-947b00b3c2amr815416385a.61.1794489621904;
        Thu, 12 Nov 2026 05:20:21 -0800 (PST)
X-Received: by 2002:a05:620a:8018:b0:93f:4921:6965 with SMTP id af79cd13be357-947b00b3c2amr815410785a.61.1794489621347;
        Thu, 12 Nov 2026 05:20:21 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a495csm16744366f8f.55.2026.11.12.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:20:17 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:20:08 +0100
Subject: [PATCH v12 1/2] crypto: qce - Only register algos if the user
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
Message-Id: <20261112-qce-fixes-broken-label-v12-1-7b5b9c7083ed@oss.qualcomm.com>
References: <20261112-qce-fixes-broken-label-v12-0-7b5b9c7083ed@oss.qualcomm.com>
In-Reply-To: <20261112-qce-fixes-broken-label-v12-0-7b5b9c7083ed@oss.qualcomm.com>
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
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uNWdf7JMTPD50Oq4Q34RGGw6aCVGFgeAIRGofUpNzcU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9b0JlqMlRyBVpFc0kBTJiSqRQUy68ErqMNtxR
 wWCrVcf9EuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavW9CQAKCRAFnS7L/zaE
 w6arEACorZuR3+d3VjlfFgy8L0TymbxxLQjd/fjA019WVhb2ONi1ho9cV/b7XiBgidpiNufnH67
 bvQBcnu867YgJe1vsh4hc0DBLnCufY66fk5SePylcV6oAirKwoHY4/kG9KpnhDj1oTOwnA4IFhs
 K/fzmC9PoPAN51Xa7rg+oltR/p5rp5uqBBnOyZvd+ZsEVnFvfA/zIMcHzXs3wdgCsI/nTMWzGS9
 leSaSR5m6f89F/pUDDl0oO6jjKrFhTG1CbGwkgAmTRo7nfuG2cqMoh2i3iGY8iEL+EkmbH2WAG/
 /Dp9ffP3b07xP8jHS0FHDOqFLvsaVc6nGKWkhxhsVQU4lLzTwn1AT7sNUlgKROfI/tZ7iD+3VFD
 sSR8klidK+ywgzSP5dyUzOvkjMOmRirQbYT0rlaSCe8HhWDSRz9rt5eGEQIP+NbZCV8IjgMIm2q
 6vU5KKIpbQweuGP1PPQDMAjlFWLQpxwftmSUB+Q65KwaUjX7lov0hO04rtNkrq0Krwvch2sUVXN
 9Kshp07fgmVrz/O6dujFwyfGJPie48+kMzD6rzGOIRGaqZ10xc7YW12IUooa6SZScHdaIOtAM01
 YBUOiwoWw4Va1FwqOYSVkGCHvLGUfLs291wqvCDlt05OFwrWugQfTiflKAHs4wEDFDTv/ZmgDFU
 0ThVkge3KjgRyYQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: R8L7twB1R1bfxXXjpK2WvsKfSlqB1Uhd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfXyGRJNxptCXQV
 BjysOUiyo/tRrjGFLY4L+Xd7dzf+EGE3kjoOArEw1Qa55TtPG45LRXoqtJKKXWIXYzOxdO4ltGG
 OslIQr6TWpffXyTcnISFlN4WzjvdmSM=
X-Proofpoint-ORIG-GUID: R8L7twB1R1bfxXXjpK2WvsKfSlqB1Uhd
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af5bd1c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XywcRVADl8Xu_msC9vwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX2CbfLBfku+X/
 lTRu8ysDcTg6tmBah7G7RfPXIKEeL2Lbde0m5o5W3M3jBV40qhMH8enX/kOs//vMVQMGivXlA2w
 OSB1cT7u1KrdRbQrPaIup++UB08V4OWVXJ3U3BP+bT/Kcpqu9Quw8RJMxCYGMZOSv4P+QbaJUdC
 stIbkWO5fygkhx1Somv5dNW0MnuZEX8OiNWzrjX4AH70QfPeELGM0L6OXxQ1v2At1JXQzJgv7uk
 YTxh11941QzkJaMt5VKSZW1xg91b3qJKHTC2wEI7YDXx1Ck99SG/QLQQlKfRWH/+/muY8LK0+Qa
 OFRLaWHGbO4AmpNKCiq89aoWdZ8r6WgPCXuRnqUav0Cy6wxuKQFywdGbnTGKyAf3fzzDckZRYqc
 BUxaLJwmrzEiQ7Il9uFOPrAQEFw7YSnFJtmQNhdyu2H5r9SkT9o+dbHie0sFFpzy5S4rlFQZZQD
 hQa1yoEZG3DmVOItVbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120053

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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index a009c791417b707c5d4e98fc30111863dd8809fa..ddb4df3d227f801e566422491b488c5fcb777717 100644
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
@@ -22,6 +23,10 @@
 #include "sha.h"
 #include "aead.h"
 
+static bool do_register_algos;
+module_param(do_register_algos, bool, 0444);
+MODULE_PARM_DESC(do_register_algos, "Enable registering the crypto algorithms.");
+
 #define QCE_QUEUE_LENGTH	1
 
 #define QCE_DEFAULT_MEM_BANDWIDTH	393600
@@ -259,9 +264,11 @@ static int qce_crypto_probe(struct platform_device *pdev)
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

