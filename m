Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B54570DA
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542557; cv=none; b=f0BtswRoIHd0tXoVAI6733/6rEdR4zFeFrkhwcfKC6meTH96simqHjlP/FMgO41fQ2XHhkKgGLNZ3gEG36pNm0y+ALE0DS61erF7B26ReWmAEnantKLj/67JgYqE5shpodhKYApPVKBQ16qARPxKUsDYxr7LyKBCSvOhWQXsrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542557; c=relaxed/simple;
	bh=glRF6SXq8hzT7isvMiN/sTwTgCB9eEEhkwx3le3NjAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=agd770ltzDsPCFC/tmKfAt0RwZqZvQGVU60byggeFUZzI+30rnilQPDWRMxLWGZQAl7PezKiUwpW4uCyaecOnH7VfMFhjnlM4CgiLUfYWE19F93NQ5COv8vYwfz+W/0RCGdqgS9SWjGnJt/srF2g8DliB9+gebUiwu6+RBQefxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X31cmoQS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=foXHt1bd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X31cmoQS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="foXHt1bd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDccxt104638
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JhKvq/vQ5caOkfZoCkRtlu
	iBUO4uFzn7wz+o7o8uvjs=; b=X31cmoQS2zUQ/XoPLxrxxHakpcDQ/4TEVEkGul
	xG5ndYE+MEsLOE/UUIPzioKq/vlU3fzXCiOTtq5rrZ+5IhR+BeTrfoDr7eehmVCh
	2cVMEovDG63lUCfbrwfY7mGUWekTJflK+3h8cmdV50S7M4pSC1dEyWYHQpFTYolh
	DU5I5XNc2au9tRCpnzanysbR1fIstDIIuXQjcJAx69kjyux+mq9/mE891qBhS0XU
	/n8IpNDOrt2mfOQeUU8WF3KPBMsDOhgM6ILh/IW+QAhQjprVPiptngP57cHG7i2i
	cacfU3JA414PtdzxjmW/v3046PJtKEmt8U1PG7zdewt78OVQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nuch2qm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:49:15 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8331536a939so9006427b3.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786542555; x=1787147355; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JhKvq/vQ5caOkfZoCkRtluiBUO4uFzn7wz+o7o8uvjs=;
        b=foXHt1bdP6fvM9/vFo28Hu1bySCJLGFTajvxHS9X/cL3vrhsT80AQlb/DYNEV0I6ZC
         12TCFd3ag/9wK9Su5KrwCqHWdZpRwIFVOql0OS8KXVx+Bh09mlgguJ/vjx6posEJ08ek
         6+O0uLEbEB3GNORcLo17fc1adcluSDys+AdMn/GHiuuBLUiyEV9nEmJqOdZfWsBVdLrS
         GyH5G/2iaCuQf4hUAoKg8xPQvc7famjDzZ5fEd4T1FMdH9FItiySVzFAH/KeYzaro0VK
         13UIF/yrhoZoCMlYjB0wgRLikgvVmA0B98qfdWrTvfq8YVCjGtMIh4sb8SgRW3nBWOxd
         vYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542555; x=1787147355;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JhKvq/vQ5caOkfZoCkRtluiBUO4uFzn7wz+o7o8uvjs=;
        b=pd4+sksdEfHxaw+KiWl5ZgKwXb2oTa2jO+3eFvwp+HSWmz+qFA4LxoAfg9hdaiU1vi
         9Szx0efw8sZTd/7oPI0oLel5KMQpkuRxaL51e+McxTcSfwzuEGNvz8sZ7UYc+Lsmt+RS
         s+bIN4ZDpi9lVV6XYn2J8XmveMTTUZSlUf4iRAmXWxmmKObTRVMbGtRPDydsmCOSKwDt
         xqcrPbwJyPxnFg0Sjiq8NA5BZRGAktwB7H9lKt75GKlWDrp7hVLFJJJk1KzzvCEbZm+9
         QNt8YsS9T96huD/LwJiCP39PkLuTRafTeszBx3ftQUhuHW+GNSorZRy7llqPqWD+d1Py
         zGdQ==
X-Gm-Message-State: AOJu0YxGRgkbOL23dg6c2RRzjR8kIVrOzLnA7dJkydaRm4gK0zH/nAI0
	kjL5ZD+E855gnzfp/ButvjaIRpG2CGlfnPUY3YER2k5UDVXE+leMgkbCbSOZflJjd0fz2tqPa0/
	p0j+aLrQCQZr+NzeW7PPJgCkDEDy8t1vXTUxRmJk0q2dSbK6sfVdR7TuFFu8=
X-Gm-Gg: AR+sD12xzQQtfRR39opqTZUFVYlAc7/2jP1NDHg4a7Icb8ufYJtAgMd4oHZ1PsNjDR7
	3+X8H56Y7VaZiGZ1b58ZtngbzeD7BKUulpB7aYYpmyD8n3ZFAwHNWCyV/65kW2c4cYKZEhI9MX+
	TCv0zBFo3I98pNgwPll0LCbrD1U7PvXMbqlV92+XW42eHBmhW8NXSjOYWr4J0lAJnDfzrRgkEbC
	vJg22T8vds4dnDUNWGD8cUQt4H4xG1Blms2OvyISc10syCYTbZ64yYkT+fff67K//pIUT2SIdpF
	sJ0kDlSrzcvUYNJuueADzaVXReSZrVPKCtUIvo9KjWkmy2WiveJ2hC6Rho3O4Zak6gX2SvvG4Qs
	Bv3MYeIVx5MbMVFM5bjNM9TSp1A==
X-Received: by 2002:a05:690c:e1d7:10b0:81f:64e8:cac5 with SMTP id 00721157ae682-83103c1f064mr19514347b3.7.1786542554682;
        Wed, 12 Aug 2026 06:49:14 -0700 (PDT)
X-Received: by 2002:a05:690c:e1d7:10b0:81f:64e8:cac5 with SMTP id 00721157ae682-83103c1f064mr19514177b3.7.1786542554195;
        Wed, 12 Aug 2026 06:49:14 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830a349e557sm13393437b3.7.2026.08.12.06.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:49:13 -0700 (PDT)
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 19:18:10 +0530
Subject: [PATCH PATCH 6.12.y] dt-bindings: crypto: qcom,ice: Fix missing
 power-domain and iface clk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-adapt-ice-binding-for-6-12-v1-1-ba4374b81a3e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJl5fGoC/x3MsQrCMBCA4VcJN3vlkkoIbuLi6OAmDmnuWm9JS
 yKilL57g+PHD/8KVYpKhZNZochHq865wR4MpFfMk6ByMzhynoJ1GDkub9QkOGhmzROOc0GPLbE
 PqSeigY8B2mApMur3P3/A7Xy/XI3vrOt+8Ny2HXYY+nl6AAAA
X-Change-ID: 20260812-adapt-ice-binding-for-6-12-d68c3000bd48
To: stable@vger.kernel.org
Cc: sashal@kernel.org, harshit.m.mogalapalli@oracle.com,
        gregkh@linuxfoundation.org, krzk+dt@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com, kuldeep.singh@oss.qualcomm.com,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786542550; l=2568;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=glRF6SXq8hzT7isvMiN/sTwTgCB9eEEhkwx3le3NjAE=;
 b=GbN61FDTpdLUnBGiiH2n7aroWVbNGbT0UwwOl22eKGhhnjoUnMnSyhrNtSfsEtvTFoknvF6nt
 1rT8pOKlf2yB3QFutTVXyLIqVOIVJFcHi4C7pFeUNdrFI6iYjsGJdFj
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: hnzEJU6XVrfgFwpbB3KJRXGefiHXaunX
X-Proofpoint-ORIG-GUID: hnzEJU6XVrfgFwpbB3KJRXGefiHXaunX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMiBTYWx0ZWRfXx+G4rkbNywNh
 XmIeHBO7KrbxSCtjQ2eizfi8y/rF320ERye4cmrs0S8Q1VPlqG7Lk/jc7eZAsLq0yOY0kNtL+en
 /h8ThSmwzqiGQFpJS8PdGpEHsjWK9tUSIkyV1dqwkItndgX1FmmUEj3f1MhPsLNXp/BX2TKMox1
 rjaDKSoUW2N5f23OXts84WxF79BeT589/MrDfIPx+mzdXEiceXJA4f/G8BEuDgo99ReruXyUQ2U
 CNm3UJ345Spx31ugKabtZ8iVyLWIOXe/rTB2GXJSOQgQEggYsEd43VD/Bh4BiEhadzOHAGbL5dr
 mSywR1G3HaDwfAKqnlI26iIb8gcLnN0Sd3fy+hj8tnn4E1cBF1NMbXJ83eF3rHBc8kMs6FEUpsP
 3Jx+m1v0n7H9I4hMKQval3fDUdWCRi6mGBZbQsmv3n4Td9/xnf9VMikTW0NhzL2qlXQoinQd86A
 QiMqkRuGPnzX/Dtd4IQ==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c79db cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8bjPlFuPUBmd0CYxppgA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMiBTYWx0ZWRfX7E7d1tzVJJn2
 ny8OgyVUqWKQTw9ZXVg8xGba7gJeL18Bkw8KjwPuzmV2UG5zDVM05+QN3G5ZECaL6pjx6xDFK3G
 C9keXam/kmE7zKhGoy8Jr9sdUiHbVr4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120112

[ Upstream commit e27264daac7d9ce892a2a5b4a864d6d9a3c9276a ]

The DT bindings for inline-crypto engine do not specify the UFS_PHY_GDSC
power-domain and iface clock. Without enabling the iface clock and the
associated power-domain the ICE hardware cannot function correctly and
leads to unclocked hardware accesses being observed during probe.

Extend and fix the DT bindings for inline-crypto engine by allowing
description of the iface clock and UFS_PHY_GDSC power-domain.

This patch has been adapted from the mentioned upstream commit to drop
references to Eliza and Milos Qualcomm platforms which do not exist
on the stable tree. Thus, patch now fixes the original commit which
introduced the DT binding for Qualcomm inline-crypto engine.

Fixes: f6ff91a47ac5 ("dt-bindings: crypto: Add Qualcomm Inline Crypto Engine")
Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260416-qcom_ice_power_and_clk_vote-v5-1-5ccf5d7e2846@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
---
 .../bindings/crypto/qcom,inline-crypto-engine.yaml       | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 0304f074cf08..2793afc7f85c 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -25,6 +25,16 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: iface
+
+  power-domains:
     maxItems: 1
 
 required:
@@ -42,6 +52,10 @@ examples:
       compatible = "qcom,sm8550-inline-crypto-engine",
                    "qcom,inline-crypto-engine";
       reg = <0x01d88000 0x8000>;
-      clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+      clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
+               <&gcc GCC_UFS_PHY_AHB_CLK>;
+      clock-names = "core",
+                    "iface";
+      power-domains = <&gcc UFS_PHY_GDSC>;
     };
 ...

---
base-commit: 25c09b42358e73e1476e517b296edb6344f2e4bd
change-id: 20260812-adapt-ice-binding-for-6-12-d68c3000bd48

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

