Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBDF23ABBE
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514972; cv=none; b=HXupBezjXm7cNLGPp0m6hCe0J1Nb8INkxPXh+LOFHH4EkRV69jJGelvtgY+j41qSSyX7oUhkMUGQ5ZQXwy56iP4rcCDWiGQVpH3HEQP96t1NY98p4U7ZwSDyDz7kYEBouDwC0Tz6lIXQ5ns4Fmlwig/DNHfZ1V4nIHzu7ybPbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514972; c=relaxed/simple;
	bh=Zd01etCEfWO+CM27GNY1MbP+KsTaDAZ942YCw2f5G5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQ4rAWST9r0HqRSsSvuilj4rTwhpwsBOHJY/Lo2wiwJJ8SoO6Z4uOiBHdvmoff5nsdpNSpQmLr1GaypjOiR/G7IC3Z7JSXmGL76cUXs8ViXPg8lYhfjrMsG4/P5+60hJ6ciJ34rZyy4tOwA9oW4POqoIG9Be/OPmZBTn73pAYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5/Bdg9m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WLHxN2zU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5/Bdg9m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WLHxN2zU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNscH8657715
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JvsdJN4ylr02nfEuq1zebFxCT9Im8rIcShf
	jIkDDYYk=; b=b5/Bdg9m4rAvFnX8Hrx8VFWvIycY3QV6CN59DmJIfnt5spSzgeZ
	JMCE0y/HlQ+R1eAmP23djwOoz5XzaS72jDqjK7Un5Sg9nhlIAzKj5oG1kCLmIFbd
	F/NP8enz2ZHcI2w6X1zXc3lCmaafk3BcjugMMMNBw1V8iHIThB3d/8fis8BtsygN
	mdsQdRif6hBowTKxwrS+Rx032o8OWKwwNVo9e+8DTXFdztOJIBsU1dVGUf4XVo92
	RlIaJcuXQgNDEk2l1zYldDyaWwvuLzGyIAb6O3U9mRC7pcaEu9FIoSMS7wj2vDKn
	EaTTpqFnePwP4jeKOnylcu2Cld2FgGW3wcA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chm05f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:36:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e2237bc43so10159887a91.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 19:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784514969; x=1785119769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JvsdJN4ylr02nfEuq1zebFxCT9Im8rIcShfjIkDDYYk=;
        b=WLHxN2zUDI0iyaI4cxuAp9KLzfT7U/gTsfuBZ/xB9YcjdjAVRo4RNmJagfYkJFS4Ii
         WDeth04tfJ+2U3EtRTU8ar/nhqGUoGCIj8L0GgLJLsDpRgJSAApzK7eVm+h9ZeV+w9bh
         n8V3OwymZpcRIHUDoOY1+dbFWXxMNmdr4AuS22Kc3Qs80BoANrqmh/eJjxlBG38zI3HE
         8fVWV/SjZTAxozmAckesTuTb4evaVWxFvGFxfTctyq2jvQg3sILrD5vmFdelL+EAokAb
         6QdkJrxdR/RpsK3DI4+cSEhSRQwNlgipP2y3KazYJWOWA+53nTHHKpvX2vWaULAPnwE2
         s/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784514969; x=1785119769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JvsdJN4ylr02nfEuq1zebFxCT9Im8rIcShfjIkDDYYk=;
        b=IrHe+S2rMLlMx0TOAAmSgQaKU2PbfGtZFHVcZB9EXxTWSRZN/CQCcjv1fm8QrPf6Gy
         Vl/nqQDlxMcnsmTponD3QrGlTtuf4J98p00Sb47R62vApxOu9zdujY39eDd95XWKH0Fa
         8AjDroDJcIX1VBntnmJB4LWCmaSdOU4d6VRmdFBGT0z5IHNfAPZj3lqL7dFFm145y8Qi
         Yr5R/++3C+Nx1U2gn4xh0SinPwSo6K1N9mLPi/wGBQSDfK2sbaEi/VYtucejVU0WoJI1
         pJlH7BkF55imqV4Vcuc7a12dq9c61bqEaU+YkJFZQp4rAz/ItFTd/o/qje26T8L7yXHW
         vzUw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1eSaeWixRyEVAwsuVQ+YVfIl++TlnkAgfbr1uBfPZA/dDNCRMBjFDkSRa1lWTR5D6bVPdJu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpwNID44sT7p0ipW38XeOJj2b7ovOlx6UvDOIXUOpsLKhN4Gk
	BE4EKl0e5UP5hUxEtDHUH0R4nTlv0sd64kBa4Trl2dTREUJR4oSybUt04oWmnf4+BN4Umo4iARY
	8sm6pI2/3ueQEKU+91QbSpXjlpVGZZ3JD0mmu7vcf7pF4gAIBtLiAZXXIK0Y=
X-Gm-Gg: AfdE7clOHIfeiUFraECaZHNPd7Ipx7PRNLf+XDePZLWGFGRzXZuadYKYu1Ma97Plu0J
	5ZZGsCRPrKitqvIDnxsSvLpHHo80oPMOlZgKcl+RsOH3+Ou5nMM4l+FLAiu7XZ5uSpB4MGMOD1w
	UsiuaWJ6Kj9a88xyPrRzRmwG5CszSLgb/xr5M5VseSqf7MB7rpxgCsnsJBBmcQk57JZu0rhE3Eh
	vv6W1pLyOEWIM9MzQVgiQTOCLaZmEZkp7ae293ho9wx/odASnV2WUyb/B4aFP1wai0o5bR0fW3j
	QPk5xE8Vo4bNLRs3rgeEC2pWelqrz3qEDugvFHZN2fZVSIn/b5pEum9U3yecDceyX+827jFZWsz
	xLAQ4PPHmQi5MH5IcCBvi54BKUcSTMEyJ5Gf9+ha1b4U9Lh3Gst7SYbCR4e9D
X-Received: by 2002:a17:90a:d2cf:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-38e4b446353mr12364876a91.11.1784514968634;
        Sun, 19 Jul 2026 19:36:08 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cf:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-38e4b446353mr12364810a91.11.1784514967443;
        Sun, 19 Jul 2026 19:36:07 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29e340esm24646932c88.5.2026.07.19.19.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:36:07 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@sandisk.com>,
        Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kumar Dwivedi <ram.dwivedi@oss.qualcomm.com>,
        Anjana Hari <anjana.hari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH v2] scsi: ufs: dt-bindings: Add missing mcq reg for qcom,sa8255p-ufshc
Date: Mon, 20 Jul 2026 10:35:52 +0800
Message-ID: <20260720023552.2667237-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyNSBTYWx0ZWRfX0DMayWIl//cA
 1iUhLc2U6Mr0YbCQNALdCpIa32UwHvQ0ffPkR7EZOtWfrjH/Ycy+kH4PsP7M0DOQSYQgtiq/wOQ
 l+knbqSNQCfBicG/B/ViYvlWbmP4vvQ=
X-Proofpoint-GUID: NrCsLH40i0H5O7GzYIjoSyyEukb0iKCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyNSBTYWx0ZWRfX3fwqscj9hE4V
 owOnwmIH+Y0ZpR3wqb99TG6Q5jm5wXUlVCU10rxAyowbbetvUWVXo9L20RSYyr8I2s93d5PJilB
 8y6krhPWvO5JBogC0TzXWlriBFgtlbpk9gQvwcZ3esXkTjiOWnvYFnQy+2kmBc47Bvx19sGFpcI
 EQLoly8nOr5THDPEnKUhbBQ1523s8ogyJZA12qbnXV5+OxRa2hdYc+C275QDBUhmebG7MpmwV2u
 5suzJE+NbiBgrnkFw9BuPK/ADIIzbLr6Vwp8DNCbFM5v4+DQmjYM0ofGARXz9OkZgHOghj9JpOE
 mFdaMy0WA+YiARyAE6/mJxX8BmS6f7qhPd/JClLKIj52KsbRNNZHytyLi1HrCFlQhF9HDXM0dF5
 O7TdQLjl7uM/XwYyKwDSqAFSOymBMZuR5cwYg3U1kx1Hn5iyfoyKXNIyKz1WlV1FPHwtbN25x4R
 yyw4p6H0IvIgG9aaBFQ==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5d8999 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3miq8Qb-Iyz2LYAwW2cA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: NrCsLH40i0H5O7GzYIjoSyyEukb0iKCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200025

Qualcomm UFS controller found on SoCs SA8255P/SA8797P has a MCQ I/O
address space. It should be defined in the bindings even though Linux
driver currently doesn't utilize it. Fix the binding before it gets
adopted by DTS.

Fixes: e2725ed2a7fb ("scsi: ufs: dt-bindings: Document bindings for SA8255P UFS Host Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Changes for v2:
- Recover the newline which got dropped by accident
- Link to v1: https://lore.kernel.org/r/20260716083313.2367249-1-shengchao.guo@oss.qualcomm.com

 .../devicetree/bindings/ufs/qcom,sa8255p-ufshc.yaml      | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,sa8255p-ufshc.yaml b/Documentation/devicetree/bindings/ufs/qcom,sa8255p-ufshc.yaml
index db165a235cb6..66d73e9025d6 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,sa8255p-ufshc.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,sa8255p-ufshc.yaml
@@ -18,7 +18,14 @@ properties:
           - const: qcom,sa8255p-ufshc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: std
+      - const: mcq
 
   interrupts:
     maxItems: 1
-- 
2.43.0

