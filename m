Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE53B9D99
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522156; cv=none; b=OE4LfvxEMHXEYtnBssFdHRfzm7wiEgDoPDsUeOvIflky6QRfkpQiu6F83BiAdOT1vB8fCVS380sIp9j8Bd7i5VODLAipNF+PsmhDD3r3z0gQPcjicFOyjvDQKNH5R6O7W+X87AAIFlg6MyyegN4N7avPgdguzS2GyvvdaX/B76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522156; c=relaxed/simple;
	bh=a0ATk3tYVSrtgeuMvbPBlDi1nHjZwNSQAI8js52OIz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IiQMQeaoAT4Q4am3mZZf/Qb8UBM7wjmCccb5WF10p3+1cwGGh8qs2Mz+J4hx3qKSY8qLXApGKeF4bnsXCPKjcQ1IKzAWzmuF+Ygf1XYj/yBpXFYPngP1it3FrgHAFFuKW2c92uzf+drdn7a0N9/sUAq7qiWj03FchfuIPcgdmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M7JBAzrk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eWtJlxm0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7JBAzrk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eWtJlxm0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFO604070877
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sdXY6NU9196DZT7/AEYC5svZxkExmrTQxBpeNlC9LLs=; b=M7JBAzrk16aC+Y4r
	qX5/uy1iec0BdYRClRgYKxmcJjqKpvHzNDygzC7v4k8KAEII1zQ763gDOybiOI+G
	ucUsR4SsdDqonvlVL9E0WjImL70LwEU5dV7aHmQSiX4J3VdPW7zwSPOKE18ZIYr7
	ow3IWN0GGJkzcXF6AGnS8Cz+hxRTn2eayHPrGICurLSjN0qVn1jL/1IKK6Ml141b
	HQ/8sqLi+v0jc5v7PQ7V3EVyqZv7bEcsuDH9Y7ThohbILm8rN13igO7fRe5XiJC3
	cWyAAGYxzgV6ZecVMTNpzJJwSDgmW3eTGdjxJSIZLb2+0KXXCTKWwYcg0AavjaVk
	IliCbg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frtyqhvx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so3117067a91.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522153; x=1786126953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdXY6NU9196DZT7/AEYC5svZxkExmrTQxBpeNlC9LLs=;
        b=eWtJlxm0UTF7eosPWW2rCo+CBGAkOGaEatvkPSIrAdG4yi37iYADiJBzLo/Xz14KYP
         lHzljhI1VcSF4dP6vNYbJ6LHa/OElayH2Kv0pGZ3BkEbx7s8CT6u0eXUHVQoH6haMgeQ
         qWNw/1NH2sTs5diouVmckhGkmTiPaqLp4hy2IhY6+c+veID1e4xPlPv55dbP+k2Ox8VH
         MOHfy02si0G5GYAmtO2sEPUaUWzmE3Ej6f3MDEEpzNitsHFMANjgojVqUeK7VtDJ8GMb
         KmrA1l+7gNwajCGRPjY5VfyECKDYSIi4KP8okN7WUgHtuC+aRUT+TPMu+XGZN16jfiTw
         +dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522153; x=1786126953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdXY6NU9196DZT7/AEYC5svZxkExmrTQxBpeNlC9LLs=;
        b=U302Zj2PDFDASjraR/zb/UZDcuZesKLVNMTsGOfIJsK99y2oFOSB9yBIqlF4WQJWCB
         xr41DGzth67A5y2b76pjOqBOsi91VaeVChMlUJXAS9TOMMxdzFmIdcba+rsnYobr4fuH
         LHax/w2dvTQ4hqCZOG+TwFhP+jZ2KiN71wIBClwGFaPn6XeXa8SgNfSFpyOiG9Je3GTI
         XNmtDUZbrKJaW+oHHnjhWHsh+5J0nPXKcwAn6QHbbPXGWcuYNK6t1r/M2ceALaBBaHY8
         dR66qADbPaqZhvBgb2gN8HxXYpY2e4lnEh63Tjz9LGL+epNxaX/O5s6rY11yqvfg7s7v
         mC4w==
X-Forwarded-Encrypted: i=1; AHgh+Ro9JNgtVOe8TPN7WdILnDyiErLmo2ApPAm/xuJDbjQdZiHvQDc7UaxjWCBHWE8Sd0RTnK48ngQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWZQlY5TlaGfJR/2vj5QXhD8LNPWc8rC2WgtBfCQAeiZjwcG5
	ZjGvGIwSjMan0zBynKdXXwOC1g0tPJYu6ZOKHtUX+jLdo5QOqSe78NDnlCzkrWPKYNHoDucF1fp
	JkOYjKTm1nTlb5hddSuZFAAasli1l/qYYd722UOg6kGe5ZWcccMxXBJIprTE=
X-Gm-Gg: AR+sD12MWtK+v4za7c3S6U95XYhFrgA/MK0RTh3rQts+2mZFOCxVPtwF1Z1sGYyDSDF
	uCKbM/bh1ZvyBjYI6b7nN9LtWpCiHIxtPLB1tdfrG7GITBH1+zPFmg1x1HHbQ5Sg4sUv9/01E+8
	76nXpwfk+M6ZObqdI5HWx4cSP7qnxb15e4nipzP0XOqQajiujd58pEwyU9iBeDXcf+Sl/sihs3A
	XRYqYzC8WiCzCgfB9IbQTy+nd8X/nQ9UtY88EnAvFuh1494Ei9Jwd8jh+0RTbmWbtibhpbmFVWf
	nr27M6O/Zlfkc9r0Uw9aQca6xleCv4AqtLh/9Mv6TQpK3Xpx+T62f+WBPRCMfoMAEv0eo0zTXF/
	0+Qa+Bo5DLe/olSrsh68qjw2sB8f5gswNahE=
X-Received: by 2002:a17:90b:50c4:b0:381:bc4c:da74 with SMTP id 98e67ed59e1d1-38fbc5131a7mr787884a91.32.1785522152732;
        Fri, 31 Jul 2026 11:22:32 -0700 (PDT)
X-Received: by 2002:a17:90b:50c4:b0:381:bc4c:da74 with SMTP id 98e67ed59e1d1-38fbc5131a7mr787835a91.32.1785522152201;
        Fri, 31 Jul 2026 11:22:32 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:22:31 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:52:16 +0530
Subject: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
In-Reply-To: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        stable@vger.kernel.org, Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=5507;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=a0ATk3tYVSrtgeuMvbPBlDi1nHjZwNSQAI8js52OIz8=;
 b=ep5X6Q4d34zjZ/Rq4dCXMv8EsiMMgQVaepnfDXg+AaDrX5bITgqOqDcEEgF9I90CnBQtlbmzl
 kXd+zL4ooYrBPIx7zm1/V6IKF5KUvSqf3GCfgXOxNqk9QgKqaG05jS7
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX11XSAm5h2v/Q
 F4BOuHGSK3VX7qMDxJPk+0PnPNNMZunRUf/tSPUQhXGwd0PN+UPHHCbqDFIsryYWgANvpFKEuFD
 H2EVL/t124u8wRYnhWld0UpAKuopoJoxPr3kJ4L0grzQSqGOp+tB366WtBJ6woxpgtNZFRogBLl
 9Z4zrVoJypQB4/wNzG/Opj0HkB6Wna272mt/vhyDd/QxsNcgbWdxT00WUq1jk5ms2XaABiH4JDD
 3kYaH/zc/dmrbZWHCfrS1f/xHRvj8/XVub6TT329TW/qzP2j0kmtBA5tcau1i21axkRbXDdPEIx
 7pNoOFQ5HrNqhw6ra2ocvG8ezC6ojCXOOL+6FJhK6Wsv4eWjy/FJtyH6k8ccrZyZ4NQOHJcmZVU
 w2pcux0xAOchb6krKM6Wp1Xg/oOV556MomYV1tujlokA21sn85R5DlPTXBKA5DBllA63l8AUHkn
 6eg/j+ZV8uJ/wx+eI8Q==
X-Proofpoint-ORIG-GUID: vn-JtslXBEk89-KDZRtdKioPzmqw6bOd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX5wILZIearkix
 fsPw9aGxCT8am7pKH7JlT6XW+fw9zmSJDkBz6l0CuElSniwnr3LS6ga5URGd+TxtIA3YYYys+sr
 hmEAHEtgTyvJ4PSpsAykvt7bUcbIu18=
X-Authority-Analysis: v=2.4 cv=YaGNIQRf c=1 sm=1 tr=0 ts=6a6ce7e9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8
 a=QIFuYXcbJTAR138jkCQA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: vn-JtslXBEk89-KDZRtdKioPzmqw6bOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310141

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
is restricted to use 0-600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing keeps a
non-pixel buffer inside the low 600 MB. Once an allocation lands below
that boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Describe each stream as its own context bank subnode instead, so that
each can be associated with the IOVA range its stream can actually
reach. This limitation applies to every VPU generation, so add the
subnodes to the common schema rather than to each SoC schema
individually. "video-firmware" moves here from qcom,sc7180-venus.yaml
for the same reason; it is the same kind of node and was already
duplicated per-SoC.
Adding the subnodes requires two supporting properties on the parent
video-codec node:
- '#address-cells' and '#size-cells', both fixed at 2. These do not
   describe registers on the codec node. They set the cell widths
   used when a reserved-memory node names one of these subnodes in an
   "iommu-addresses" entry: of_translate_dma_region() reads the
   address/size cell counts from the parent of the phandle target, not
   from the reserved-memory node. Pinning both to 2 lets a subnode be
   referenced with a full 64-bit IOVA base and length, and keeps the
   encoding identical across SoCs, whose buses vary between 1 and 2
   cells.
- "dma-ranges", empty "dma-ranges" states the intended translation:
   the subnode DMA address space maps 1:1 into the parent's, so an IOVA
   reservation written against a subnode needs no offset applied.
   of_translate_one() treats an empty "dma-ranges" as exactly that
   identity mapping.

The parent's "iommus" is kept as an alternative via "oneOf", so
platforms that have not been converted to subnodes still validate. New
platforms should use the subnode form.

Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
Cc: stable@vger.kernel.org
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../bindings/media/qcom,sc7180-venus.yaml          | 15 -------
 .../bindings/media/qcom,venus-common.yaml          | 51 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index b21bed314848480b82153e49602f0b19e08e7335..bfd8b1ad473128c974bce84639cb0aff59d8c2cc 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -91,21 +91,6 @@ properties:
     deprecated: true
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
   - power-domain-names
diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
index 59a3fde846d2196ab1e4588eb396012ba6860712..ccae41bed757bf3d9518cd4afe4565f043b45166 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
@@ -47,6 +47,50 @@ properties:
     minItems: 1
     maxItems: 4
 
+  dma-ranges: true
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  non-pixel:
+    type: object
+    description:
+      Context bank for VPU non-pixel buffers, including compressed and internal buffers.
+    properties:
+      iommus:
+        maxItems: 1
+      memory-region:
+        maxItems: 1
+    required:
+      - iommus
+      - memory-region
+    additionalProperties: false
+
+  pixel:
+    type: object
+    description:
+      Context bank for VPU pixel buffers containing uncompressed video data.
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+    additionalProperties: false
+
+  video-firmware:
+    type: object
+    description:
+      Context bank for the VPU firmware processing domain.
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+    additionalProperties: false
+
 required:
   - reg
   - clocks
@@ -55,4 +99,11 @@ required:
   - memory-region
   - power-domains
 
+oneOf:
+  - required:
+      - iommus
+  - required:
+      - non-pixel
+      - pixel
+
 additionalProperties: true

-- 
2.34.1

