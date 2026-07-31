Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E843D51D
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522163; cv=none; b=MHAIyyxWXDx3kweJ4YUM57TC8vwPbVTqe9xAmd1ymz7lXAbSDZwicEL6gklAIppm3Cn3WmbCv0+Os4zcZHw0+Q5LK2AXdxudtYSpWijjyJpO9pT3uBDZKN9irc2PjteO18n3g9fjEq4mDfsEhl6OQIK87WaNY6RRYQTiMeJlKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522163; c=relaxed/simple;
	bh=FDjUsMwZemAtA5V98H6C5SOpf601ryPQ8mhR3sDy0gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jik1iNRhZyYlreTZp1JjgMtkDAfUzfC8qtAew4slrQ/9JEr26VH/mSklJGvDWNNinrtQZOObI7ARTh+VmR2CbtoGGLRKTZU8j/hL31dujmZ1X1qqcY/doD++OJGqgAj/c7YN30RgGFIg6lqVPzv/1/MfflSqhvmJ02TvBO+8I18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NDM8NutR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T19NvlnY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDM8NutR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T19NvlnY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOZEw507832
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jFcxoWFN30lGUo2X6hPNuacFRgxp79wPAUzKUa5k6L4=; b=NDM8NutRID8jMBKk
	AqbP18KkYnG3S+bE5zdhV9Woi0JMeadAOcDWBu/kpKyU/0cY7Gdcn6sKPsHHcqe2
	EqVzwlOOAzF9ld0sVmtv26IAa/9myszdiQe+rGsEXddotW8zZ7Bol/j1stfYH/Sr
	phWQeXrWgAB05yyoQMtafsN/7DEV/C0IAsSjlljAJCQovOpgVtLBaNq1Do69FReF
	fZXhJwdiGGHc3MhohBHgqgnJqLJstVcb6Uzv6GKxu5wIiTxTXOftSnfN5aNqfk6t
	+x3vTh31Tqy1BJi+f8Y7oyTFHFGVcxYXhgN4dtucDU8LoLgryrvvRSxLn1nbDfeu
	bJFCaQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru131v88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1794172a12.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522160; x=1786126960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jFcxoWFN30lGUo2X6hPNuacFRgxp79wPAUzKUa5k6L4=;
        b=T19NvlnYCHC9c2q9SBiobPTFxQbKhrA8bn+vhbaJfp6rZF+tnoP2nxyRackPWrr/r2
         tO/guaZ+RwlT0Tu0dx43V53ZNp1v+pZehRs7TKP4t2dCAF4hMwtOOSfQEfCKrwAmWoqH
         irH6yokhVvBvS1WQwSvUS6sJ4zEB/BgB6/hY5z7Mpd6xONCqZFR1EIISR2z7t9dwsZAg
         Wz9KRHv2nkH5s0y4l9f13LLqLMOMOkBt27cU6Lpl9SZlW9txKqaSdi7m5bmzIIrnP5Bo
         b5TODZqMZR3QTm6CUZvMWxa58N9gxwZgXmt5RsNu2IXdGQYGlJ02hwUf3+e04MdjKzll
         NEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522160; x=1786126960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFcxoWFN30lGUo2X6hPNuacFRgxp79wPAUzKUa5k6L4=;
        b=sH/A+Sksop4cWsZ6v1phyW0SMGckhp3mcj46Sp3G2m2b2b16oGWWWZ4SRAjtZdaZXC
         8bD0nAWToLqNpTMK3VQxu4QB68Owh/KWqjxFxMsP4FC7I+Urt14hkBJ/3Kd+9lj9KMGY
         wJqptQ2dBH6hmz142xPozQDA9O20HPzVqgOWG/g6npw5VO1uUmfVxrakOc8Ry4sm+oYQ
         D1rrX1GRh3L4uUSUu+TE8aGFTqZsxfVjcXu6i35Nxjztx9Ty/5flketg5aUS7APnN1Vg
         cuF5bOIwrCTKrmHIlFOJFmJ5opvtP1O+OywAXJaHkOvq40jxCDBwSgsXbcuIgpqNHt7C
         tBQw==
X-Forwarded-Encrypted: i=1; AHgh+RpLAn2yXuM7f7cKAT0Jc1XmG6fdKg4OpgFQcqgEtw4pC5t9pbtpjINDR3dikLbV0sve3CY3Ui8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi+uEwJo2uPHhLGQUn14wb33pc1BES6AjmlEgAg6Ebwn3QmyU
	a6Mykqa8iH2D40eFzVkr4lNKhn0ww3nkeVvR4vGDu4rW3LQZGd7drrQE6ZdnxctLYMjuMgYGGS9
	QLg3yhz37MJd3R6qgzhg81Yy48fC3a+4LuVwNKMuj7cJOS59Xkzu3dZAyGPEN7dQ+g0M=
X-Gm-Gg: AR+sD12Iqz84jkZ6vmL+On+5hvK//76/hkzlit1/dbYTO5EjM7BDxnCtd29jCiBb91J
	+JfCiSKkkTezkS28gOBqennTIL5fsRfqB5kv8tLqeQUuuOnj87b5m47ipDK3N70121s9q1Ag/RZ
	g5J1IUsWIh9Hxehr0IRg2ekexYj2PksIvgNRWlf703bbSIB+jUXrDAQNWTLLIfiljFsAz+fo70T
	rZV2EYEzgtT9zEHZi1U1NfCfoEdO4Hn66jOEqkhkfpHp+1aAAteTGCF+Qmo8J5Vy3cx6e79vQjK
	gABS7LLZo1JhAnGqc00oM5bas4ZpNf5oayuo+ooCGq5jl8A4RephFZ+wPl2FAni1naqSx33158y
	zLawOvOCwddUaKhuKyx1gJICkgZQcDFvi7KE=
X-Received: by 2002:a05:6a20:6f02:b0:3b4:b216:2b26 with SMTP id adf61e73a8af0-3c92a4c975emr759252637.5.1785522159600;
        Fri, 31 Jul 2026 11:22:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f02:b0:3b4:b216:2b26 with SMTP id adf61e73a8af0-3c92a4c975emr759228637.5.1785522159214;
        Fri, 31 Jul 2026 11:22:39 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:22:38 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:52:17 +0530
Subject: [PATCH v2 02/12] dt-bindings: media: qcom,sm8550-iris: Add context
 bank subnodes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-vpu_iommu_iova_handling-v2-2-da52b5228dbd@oss.qualcomm.com>
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
        stable@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=3406;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=FDjUsMwZemAtA5V98H6C5SOpf601ryPQ8mhR3sDy0gs=;
 b=8NwtVrMc/xdzHWtdsduk+gvBrMiZPJO6f2rWU9jEpDLWqRQfPrRCn720IBHPi9NsNbmx9bVY1
 9yMGmLZKnqmDN3zOX4nWV9AEQiX2ZmeSi7ib7fcHr4kUbovPIwrM1UN
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfXwhNU/KdD+hwr
 fBKHEZxnPGvlQNRNIlE9uAeX4iOJncoA94IoWgvnLgTAn8RlRLBAF1giSccp3BOzGaYtgjTQaoZ
 wkVRFS58Sgse2at/DiNF3PRDLAaKTaI=
X-Proofpoint-GUID: m_2efUd099kJJVs99L6OIu3dmIRH3yuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfXyOqIKD5ei1lJ
 qRotl59yFexdz8DGhwTUfBNuQR3Qn9yDsgeij8RVAQ7NcGpmKSTkoensSPAyboa56ih5xwww7FA
 2X+jLohHwgoOmMvmNoNtj4/YyD/jOsTIu0R8YkFp7lCsoNhzH+rKYKupqLpT8rusr8cP+AJA/ca
 PyyFZYd/1eyzonxP0ttJ8+zt4Fh36MXtS21kxP1imJL5JKUEcYBZ9rkErXP4LNKTLaiN3PH9wPs
 YwGGhcSyjAVPvKZ0O5UfFuDlxJX+BPi885lYSzI4cS1NEgbxIkza4UeO7H7SF3I4s0FA1mnrnTv
 M+rJLrsneKZTuwQnEritqdmraGum9KRhoUbrG1IyIa42vvfFsoEIzarKxc49DlTZ4HhKVWoNtrC
 q1iglUSX3pmmljbmby59RD5rFmc105JRP+n5J8FHzyyNI8yXTpnsXTrwy8/geQl27st39IKe8XX
 lWrMltZ6SqNBKkYHBzw==
X-Proofpoint-ORIG-GUID: m_2efUd099kJJVs99L6OIu3dmIRH3yuU
X-Authority-Analysis: v=2.4 cv=CYI4Irrl c=1 sm=1 tr=0 ts=6a6ce7f0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8
 a=v0Z7u7uCyoCEKL_A5NIA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0
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
non-pixel buffer above 600 MB. Once an allocation lands below that
boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Reference qcom,venus-common.yaml, which describes the per-stream context
bank subnodes, and drop "iommus" from the required list. The common
schema accepts either the flat "iommus" or the "non-pixel" and "pixel"
subnode pair, so device trees that have not been converted still
validate.

Update the example to the subnode form, which also picks up the two
supporting properties the subnodes need on the parent video-codec node,
'#address-cells' and '#size-cells' of 2 and an empty "dma-ranges". Both
are described in the common schema change.

Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,sm8550-iris.yaml    | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
index 0400ca1bff05dcef6b742c3fbf77e38adca9f280..3d8ff5677bd4fb7f3619a95b1c5f6f9eaf39b32c 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
@@ -98,10 +98,10 @@ required:
   - interconnect-names
   - resets
   - reset-names
-  - iommus
   - dma-coherent
 
 allOf:
+  - $ref: qcom,venus-common.yaml#
   - if:
       properties:
         compatible:
@@ -177,12 +177,24 @@ examples:
         resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
         reset-names = "bus";
 
-        iommus = <&apps_smmu 0x1940 0x0000>,
-                 <&apps_smmu 0x1947 0x0000>;
         dma-coherent;
 
         operating-points-v2 = <&iris_opp_table>;
 
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-ranges;
+
+        non-pixel {
+            iommus = <&apps_smmu 0x1940 0x0000>;
+            memory-region = <&iris_resv>;
+        };
+
+        pixel {
+            iommus = <&apps_smmu 0x1947 0x0000>;
+        };
+
         iris_opp_table: opp-table {
             compatible = "operating-points-v2";
 

-- 
2.34.1

