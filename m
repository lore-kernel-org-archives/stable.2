Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2023CF05D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512565; cv=none; b=IdSwyMHBZDcplXuPnK1+SElkH3/4K4l9wuiuLVeGSuTuvIme/0kJgw4nkzQr8iJklAgmsar0IIQtSKblmDBPAZ1YgWZCoLIp1Mi5PAADQxlunNJDGhr83Dt5FIlbhQyAdusZfOAFFHb75P1vDeTzXuVfUpLkWrOi6jwyNrRlgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512565; c=relaxed/simple;
	bh=hBDK+t7sZBnTDtOjkj84KsZOBvFHMonhdCwtWPz4c5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XYN0xeHh/N08TumyvpMVn8yOBb2e6A+BKeB6a7ACj3ZK92XtY6MfNeznP3GSvHI7avSMrxWP3kDpX3mi+JCxrh7k/HMBMzgRseQdoyuFlBq35tQPJXJ4AYiXXXDdkDyB61l1WyI+aCBwSSR2yIhK+adY1U4j/tF9gOTcxE/P+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AAyL/bzO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RDwKELJN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AAyL/bzO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RDwKELJN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6LjuQ3853226
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+gZ8mY+aqE/4HNVT63SJJoWIum6T+x00lgzmR2pD3I=; b=AAyL/bzOMh+aA+RS
	Ho51Z4g3xDhJRfaVgx1y96drsYgH6F63x/QiIvWBv6tV4RpUlxDxEGFmD/L9KvP9
	DJLaCAKrQFZQXBllZML2fSxVfELKbMEFazsXnTrAlJZzuujWr3CwFteWVe0sOYNT
	beeMKT/LhGrE+lmrBieu6hOnjeVPi4GHN1Zq3IgxbVqUG7g+qx09vq1xHx/Mn6Ml
	bl4wxXulxs/uxKYpUiBRI0biqQSMWs1GK+CP43r3qZJ4XGzK5a2sYxMVmqCwjKDS
	YjbSso13dZSQMhWRFoCi6y05i8+KxTsT3pZPnG80zNQra0OMaMlGZuTzOqSMfJYG
	FuJTpA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gxggp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:36:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36b934a336eso2522035a91.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781512560; x=1782117360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+gZ8mY+aqE/4HNVT63SJJoWIum6T+x00lgzmR2pD3I=;
        b=RDwKELJN7jIqYmh6NrxjyDvwSGo75W6Fx6AYBAw/vhhBgdPIuo6BkIFfe/WYLZXMGw
         9YMiINZrP/Azbncg7n4IM5tPFPI1BYmtbiHE/on1XUsLgSg7TOv3duWjebj9Xatjqlvl
         DawgMbqy8Tbr2WWNnQNX5aD5fG++TqHYcF85tzM+eRP3mBLAx6HzOWSVizNZ6XfneX8I
         wh9HiIWFrMJsXTiGSi04dGruSsQJqubVqRewDc/pixgpULR8sB2vdQmmj+2Yp/i1PpNE
         VqkyxzBN2Cz1GamfylLT3SaIIsVMzkiA99iF7ByH0g+Jg5izZ0UhMXtbw7zAKKNXKAay
         agMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512560; x=1782117360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+gZ8mY+aqE/4HNVT63SJJoWIum6T+x00lgzmR2pD3I=;
        b=iJpihLl+91xOx+yrHCoMbp4AY2Mk6E98QDeMskIUwt3riuSv+kc/ZQJEBNgNd99St8
         cvR2WjUXuTdVRFmBG0Z3V4Q6ih843mHfxSS5xn76Gx8I6GChbHGlRFvdeUMQGFHZ+d/E
         /MwVULfrZXHO5r9KwYu++XiJyVRrjhlR+afNChQlv3f+Q/Xny1JsspMmoxSDklQ3Ih+e
         FCPxo8MCjJT7iCZEfhuHGZjaagd7TwkqPOZI9/Ds89ZEsHWgl0O9jY9aFUPet1rSh8Kl
         UbhHaxDCU9gyA3QwCqkFNO0XSVfs0azLkihld+ATo+GvymYvouDwhTf6HD59Y6dff0I5
         s35A==
X-Forwarded-Encrypted: i=1; AFNElJ+SHU4V3/w2QQOh0Unxt/6TpKmwL8J2JlIkmf+pMH82oaIvJREx79s/L2bb1fzdZ8rJgWI1Dt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIKVHR7bRDfSRd2rkI+TNNasrDB7uI7EtbGmm1wNFjrlUeQJZ
	/6MlsO82T/NtmHhMdiTCwWZba5l/CVKL9k5o7CYDw6GZVYluNdgHWCsvNNI7LOT+eMEIPtAdBwM
	FcAaEgF7X7P9JTrufavY+qeCN4vTAr233krm/OpI/iaz2N20tGOG7EEW/od5LNEfOrOg=
X-Gm-Gg: Acq92OEOiIDR39uwrQQ5om9NBi0Uj+PGTDejtzWdwe3IDNZTdDWLaolFUsmD9OhsNxY
	EZYKfqSnBuzmc8v44EbijUt6DJt85ZNMGQf7OgBbsJxrNV+gjK0IUZbVv5bT9BFS7lK+OuyHXmn
	3OaGZOVXzmHNLK8WkB43SgKZus3kvWP/M0Egjs26I0UmWVLcdDJ4mZfQvrhu8jg+e+fPo7q9Gqs
	QUp7LnA2SXo9CgmJtjEOrdI+GYlspG2Xud9SqCUUZWrguOcLCMh1vFj6jIIWlPZyWoGfKcrlUjE
	W8pmG56NnDQ/sEqyvHT1YDsieH04mf3FoxStevYCxX0QFml3Ix7j+om8/C9fwXc/5EiimRnp/9L
	5vMin4dF0leULlXchdrWOdKItG9z1Ye8/iIWXJ/afEZRL1kywQCsebB/C29MXGOJN2868C4h/LO
	00VtyU7JIPHiHDOwvU00sLWwRUT8/0asovRxeMpLvI8jfVwlHJ0YpAGyqT
X-Received: by 2002:a17:90b:55c7:b0:36d:b680:3036 with SMTP id 98e67ed59e1d1-37c2bc42809mr9306045a91.4.1781512560483;
        Mon, 15 Jun 2026 01:36:00 -0700 (PDT)
X-Received: by 2002:a17:90b:55c7:b0:36d:b680:3036 with SMTP id 98e67ed59e1d1-37c2bc42809mr9306018a91.4.1781512560005;
        Mon, 15 Jun 2026 01:36:00 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a210ad64esm9558974a91.0.2026.06.15.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:35:59 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:05:47 +0530
Subject: [PATCH v3 1/3] regulator: qcom-refgen: correct the regulator type
 to CURRENT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-ipq9650_refgen-v3-1-5f611623629c@oss.qualcomm.com>
References: <20260615-ipq9650_refgen-v3-0-5f611623629c@oss.qualcomm.com>
In-Reply-To: <20260615-ipq9650_refgen-v3-0-5f611623629c@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfXw7MRMYQ2hAvv
 aR/j40k8//M22bUjHHin12tInGslmPyDG1TEBjX3tqyS5+mKM9BiYmWV/o9W8f3ySqj0fBInikY
 PNomC/bTlm6kEAzElc7LDzujyg9U8/Y=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2fb971 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VkQhxhI6jZxeKeB4iE0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX22ZcODNhFze+
 1tNoC7mOL/6Qwx4N92sK7/nnW7WBd75N1I1C+roJ4xKa0ZlSoc+DzQsCZ/sx6ptnAIv7BzDeQec
 bmmqF1Vw3M4KPyXS8Lo/4xpeIl490Bh6Cx+IOOHB1MpTu50qMdFGoZTzqgyfmKhI3PCbljc0v3P
 wG9bLtu+rbue6M4Vnu/cwA1npgSZLwqZGrH7ApMEjPWb8vZJSHN7z/Vs7iLEIgj7Hoo784weMEa
 q1vjx/88GljeTyN+/YHPv4g9ETRXEsIS+R58P9hSdFKuuxGa48D2SjhLir89yeCdbFo9qR9sVKZ
 y1aLidZ8bB8AmsMkGsCV8ElU66yBFBUIzzANTNTql+82poTBlMrW6WgJWbyealxo0Pix+Cg9nsb
 oopkRZvNlaIeWuwi0Nn1UouwMlkIVmvcgreSth+9HLIf4VrCnqhlh8IL0XNNgDDG4NpXYbgYKto
 ZFuTmGe+IbvsFABdktg==
X-Proofpoint-GUID: Gxl75bBaAnjDnFbYxYzm1lq5ctRD8qxw
X-Proofpoint-ORIG-GUID: Gxl75bBaAnjDnFbYxYzm1lq5ctRD8qxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150089

As per the REFGEN IP team, this block supplies the reference current to
the PHYs in the SoC. So, correct the regulator type to REGULATOR_CURRENT
to match with the HW behavior.

Fixes: 7cbfbe237960 ("regulator: Introduce Qualcomm REFGEN regulator driver")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/regulator/qcom-refgen-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom-refgen-regulator.c b/drivers/regulator/qcom-refgen-regulator.c
index 299ac3c8c3bc..6a3795469927 100644
--- a/drivers/regulator/qcom-refgen-regulator.c
+++ b/drivers/regulator/qcom-refgen-regulator.c
@@ -66,7 +66,7 @@ static const struct regulator_desc sdm845_refgen_desc = {
 	.enable_time = 5,
 	.name = "refgen",
 	.owner = THIS_MODULE,
-	.type = REGULATOR_VOLTAGE,
+	.type = REGULATOR_CURRENT,
 	.ops = &(const struct regulator_ops) {
 		.enable		= qcom_sdm845_refgen_enable,
 		.disable	= qcom_sdm845_refgen_disable,
@@ -82,7 +82,7 @@ static const struct regulator_desc sm8250_refgen_desc = {
 	.enable_time = 5,
 	.name = "refgen",
 	.owner = THIS_MODULE,
-	.type = REGULATOR_VOLTAGE,
+	.type = REGULATOR_CURRENT,
 	.ops = &(const struct regulator_ops) {
 		.enable		= regulator_enable_regmap,
 		.disable	= regulator_disable_regmap,

-- 
2.34.1

