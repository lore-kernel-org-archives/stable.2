Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567643E484
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543090; cv=none; b=FT6C5SQGKaZEhkhid2d9qIbxe3OChYDLYQwfnVTbNJ/DdgiB+7W7TTETrHtva2h6tHYNhOXqr2YpH2+D5Bz6I9T/pj2puGBjd42Y37S3E6bCZm6T7yHrSiZ1X95TrrOG0oMLYDDt9incmaC7doZILd7IYWGMaEYnJyKzbPAhBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543090; c=relaxed/simple;
	bh=y8YJuHjJp5nliQQZQqKJZ7rEiPlO/qO/ie+etWJp2nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fy3X8BSZ7opHe+gx8YJbgD8glKd0IwDmpYz7AWhS+dwfQst8jkM6+Kbmzt9gqgh/iGbBZazaEkCt7hFLUadVBlk6y6IjuzmnzQ62D4mH8fr+wCm6biN/kHE+NWe0OkuJJDz4XDNT/pMUvJ8zchuue8i7MLDVXHKrPlghM75acK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQi2bjMy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpsvRl8V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQi2bjMy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpsvRl8V"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbufx3194375
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cwVHkbsU99RexfG5glIklr
	Z34hl+HQeHwP6E+VqfC0g=; b=nQi2bjMylW1ZjWG0OpA/AzlOJothS/BaD8KhWg
	XM0/4Cry4HSHNU0CFBjFgB/LLZb08y7YX8Ldl8g/mKZsHfz2nW/kwaOcc9e58EHS
	OGpQ5jCJI+V6pFXtzBQPU23vVHlztCaXUIU95LjYBupoQwcjx+tnGNNXVfM2f6II
	57jWq6YJ3/b9hyYmazPPDaBxDLZTh7Y3oqcNBNfh+d1dmXWPCQGqf3SiYa5+W9X9
	xAcF1LPN7lKl3/87gSODGLDXqXzlQFjNCB7t94KcVM/Cv5u5PSPqxZV5XW1MIX0m
	CwGZzYsOIFIcLb2LGlRMnNITHQXnQTWjeLuMTXWi3uqzGP0w==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd9dpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:58:08 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e6bb29581so29101067b3.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786543088; x=1787147888; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cwVHkbsU99RexfG5glIklrZ34hl+HQeHwP6E+VqfC0g=;
        b=HpsvRl8Ve3CExj1NiLyIluh/n30zlIx3+eECSEp35ocAS+ewnMndtcOVhJSy/5g7S3
         /CFLaqTmHlWJGXssZcvVfNnt91FcMlKgm6t3vC+wRr+zKBGre/qiRfzaTVU0JINGTQsy
         zji7rkfgEY33BkU3UjWB7uc9Kje29XgeBsWUcUV5cEf1TQgOVlHYgk5IsoHwKa6gVAu/
         JX3sTrn9mLWH7K2iYKZkPNN/zRzCefdNeoVfXaohCsy8EWEKfwdhcXNpFQ+Ckhr4eS3U
         3u/AckS9QBZdITOgMOuCq/GzBY5K9CF+jhZU5QrEzU5nBn1smAxesaV7otUFXndLpkVy
         AVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543088; x=1787147888;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cwVHkbsU99RexfG5glIklrZ34hl+HQeHwP6E+VqfC0g=;
        b=pJsI/od4KymUGJel7WBCBv9nLTQ+ECtRSiWdo85t23UF+srQpceggFtjZ72AFvWxi2
         Xht9sO9l3qgjnBHQgR8IajZz5VqeWvHrWQ1kMEtL8OBHX/9WDxAL7JDY5wpyMlxZNbKs
         ZYOCYm3mam5szdP+yKJuNjbzQjXmtDzA0XtZcnsM1Bsx9xejFfbdNfECSpPDnmkTpSPl
         FgbSTtxptkh0YoyQxhZu5y/0dG5uhkdIq+wkaprYGjLSZ/4uTVNF1YN6Jvtlldr7yvcY
         ZkSEZceBLov+BxHH0yllvf+J2H00f0NFNNLwP7KbGBrqsx8/GS2rBYqvqWxIYwqdX3xR
         phZQ==
X-Gm-Message-State: AOJu0Yzn8/wCOZOiXJ2VNNbZ64N77uoh1Hnbtuzbj64XydCzBwpptbTh
	7daY3Z4l+rCxRdwtkAzeeKXWRVFyPb20HQJw3MEzeKfA/T1+ZkQ5FC0LRJ0DFFZiqJrgiizlpey
	6Mr+stSYVy+11gl+XRXr8/mdCaB7eVHenN0uECXoqBdileAdb7KEuntCTHmQ=
X-Gm-Gg: AR+sD13O1RnQyb9PoUXSYjwGI7Bzc2ro/GcaUiUQpPAaQ2yd9LkAzK5TcnyX/RH+sUv
	OAfRTgdLC5YHVqi6uxjJi/4yMQzCQ/E8ZFk6wQyL+VeC42N3sRzwD/0J0WGZlNKGER/wB5TV4fC
	IMYEpJpGzudRs3Ev3Mx4UiqKHz+FpyViNLBHFbSeNQsgVk6cclmEweKu7wpJjJJI20PTmyrA7r2
	NcrE79adKMfaTE8KGLtpzZwnzKraHzhPRkF4Aqs8gXl6o1kCCGUawAxQY3suWHBkqbzz4MkOyJt
	dnrdA3HbP8Afk5LgWKUKsyprDp03KwLCjgmvhB84cXc+MybZ21eyoyFEE76ttO8kd5NaqY+t1qy
	gOPjh7B9tc71cdEMUweYQRjBTPQ==
X-Received: by 2002:a05:690e:bc8:b0:668:10fe:3024 with SMTP id 956f58d0204a3-66b343462d3mr2062022d50.49.1786543087696;
        Wed, 12 Aug 2026 06:58:07 -0700 (PDT)
X-Received: by 2002:a05:690e:bc8:b0:668:10fe:3024 with SMTP id 956f58d0204a3-66b343462d3mr2062003d50.49.1786543087233;
        Wed, 12 Aug 2026 06:58:07 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830ab36d97esm13264237b3.42.2026.08.12.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:58:06 -0700 (PDT)
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 19:27:54 +0530
Subject: [PATCH 6.18.y] dt-bindings: crypto: qcom,ice: Fix missing
 power-domain and iface clk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-adapt-ice-binding-for-6-18-v1-1-e224dcf77072@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOF7fGoC/x3MQQqEMAwAwK9IzhsxFWLdryweqk01lyrtIor4d
 4vHucwFWZJKhm91QZJds66xgD4VTIuLs6D6YjCN4caSQefd9kedBEeNXuOMYU3ISBbbnolk7EL
 PAiXYkgQ93vwHXJOtTxju+wHo0WX6dAAAAA==
X-Change-ID: 20260812-adapt-ice-binding-for-6-18-39611eb7f96e
To: stable@vger.kernel.org
Cc: sashal@kernel.org, harshit.m.mogalapalli@oracle.com,
        gregkh@linuxfoundation.org, krzk+dt@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com, kuldeep.singh@oss.qualcomm.com,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786543083; l=2568;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=y8YJuHjJp5nliQQZQqKJZ7rEiPlO/qO/ie+etWJp2nQ=;
 b=/TRl3r6EZUCgfoPI0dTzBy5nORi+yY3ezXIYtr3jYt8k/2Ms1s1M4f+WvxZpau/f6j3Obsao9
 auxsalv2qOYA/D8BWvFD7WKxC3jOWUepGdl3ksNSKVe2oCrCGX6RmDP
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfXx3PMmWXaIqpO
 X2n/Rc0R4u2BWpClErTA9wOcQUGAaId4JUM5yyufZ+6eW1s0BkXfMt/d5sLxDw2gLZZx8SOd7cy
 BaaWPLsaE/q1iF/gzlLBRCTQkCir0hA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfXzc4R+sXnf6tJ
 3Kf8A8fffkUCNDqcREViItYxdbRWm8zNWSpBbjbpt+61SuasJjp/P/2rWR6xAjvHvTSlK8mWZPm
 /UiRWtc2Rrz6oWHeXerBNRJnkDo6rfpEO02jCuiX+Lcp8B+QQUd8SB+oMR/dzYhLU6p0e+4g6i9
 67px+Vq31HmMYKXvgv/LsEBILjNAkucNElnhegD5gznHHmv3TeGVRAXWQj2DrFf7QNJRZOILwlp
 cl8FQTmjvNL8aNKvxjaXrX2AIzLpQpYG4A9BH3h9ztAW3N5t/WHSnnPgaRjuZMkQkW/QwVfbSJ4
 RKaN7LjyJvDRvLBaBcxlH5YjMpQD/qkBrjO0vpKTxxTtidvQomMLCNUDIzIInoz7SmxeNiEQ2v2
 hWTtC9tvYPZ3Ce1BZG2795K+yYrfk0S1AkWPS0/zsq8cGx0sz7ERYAg4q+qBwDF8vXzMYpF3wcY
 4UDApOmYrY3XmqJRfIQ==
X-Proofpoint-GUID: daPc1S9PEah8Bt0WY0g9J5fG1AtSrHzK
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c7bf0 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8bjPlFuPUBmd0CYxppgA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: daPc1S9PEah8Bt0WY0g9J5fG1AtSrHzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120114

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
index 08fe6a707a37..70aa5193800e 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -27,6 +27,16 @@ properties:
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
@@ -44,6 +54,10 @@ examples:
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
base-commit: 1efe5d048a391de3ead2804b2e7f86376c356cc5
change-id: 20260812-adapt-ice-binding-for-6-18-39611eb7f96e

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

