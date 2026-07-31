Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06C45199A
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522176; cv=none; b=Od5HN6cHd+al2s6vvRiCf8x4fyD66JVulNDSerYJJJz/RqkzIL9mLpo+ridnnS05QLhfKjt+ljbwFhi3XXCg42kv7UcAyawAbazc6EsymodeHj+2bE+mTP+qK3TJOeraI3qlILGwv5xm+ApvsN+v2vfxhakduswWDu8u+U5BN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522176; c=relaxed/simple;
	bh=bpZUDSDe1YBY8ECN8OTOUWJTi/KZ4B5ccQkOA6CUnRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9iy94Q/+rzuHENKGxVMrrA84Y1wjhuGZG3SCofD5ZBWRhjlAuuw45gR543KnCapsoor4Cd0nn7wt2iSl/t4PXn8UPKEdKJEB4WVLArkLscFwMMdhTmIFTpzjNgafY6tUQokOZh2JVTjW/JnZwHsrWd8R8tJ7Hoj/wmlhXJXXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MRAop/Sz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bueCLSJZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MRAop/Sz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bueCLSJZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOlmo404139
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yjpjbceNMhq5SUugGyKVzGCpZa97ECPfDLce9QWLPh8=; b=MRAop/SzLVcEf/v5
	hkChfRdh0HPVqcUZaSqhGH8PVy8YZRTqSCryyx8imqpc+X0UWjnYgFGOtNi/Rv5s
	DcmjL0wvtZMiGSQfo0zG54ClFQ3r0wve5H8/xx2fq3Z1Np5GCSwmaKZfbpPHMAHJ
	IJYD6CkQtXcLXvoHHOUgrb56qjAjctgssnatUrpoDlgjdOS4Phskju4rsgMqnFNl
	TpC0J/auMqvoal8OZlinzSgN3auJBWD0Ie4NSv5hCdZLT7gOScOQCGd83nTvotF3
	DoJQ4bhOekHPasQN+r3lYakrHKICJ0NAFkew8o0v4/SOYZHGQdqQXq8eT0O2PmlS
	SxMpow==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frufkhr2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85798977dcso1999451a12.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522174; x=1786126974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjpjbceNMhq5SUugGyKVzGCpZa97ECPfDLce9QWLPh8=;
        b=bueCLSJZBGOO+ii92D7CdC2r5kjjXFikUSdnOuImVV64KB3hpvTaZgtMUEVCDp0ZN0
         TINvnsOK6vcVmZZr8E9aLgbdz5BSINB0k1xQSS5ZHpEVgYYJJZfheEN+6rQPNoYQo74E
         9yzN9zF2rfjWmjuxpN8Jw/EC6FmmWuWlqVmkVoxxMOhzLpPgOIeTfJk0v3ce3uOSG1tq
         gXgMIHuGk3dvmrEACzUDe0BQQawEQ5DROYdLxzZ+3XwfeCtq/szqeGOUEXH2NS3LfKI6
         mbYJEqWr/v92CxDm1hlDi3EDlm3wKGPk8A/4XrlyiNX8x6lfQKzYGc4z0QRZVNWOho2r
         hQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522174; x=1786126974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yjpjbceNMhq5SUugGyKVzGCpZa97ECPfDLce9QWLPh8=;
        b=LA/zI+BXoRYwJ3smbx3IXRJr1V6U64A3DtDrPpOFt3FkYH3ZRKIRnu96pgC/Od0wjg
         DNokNLrcqh/cWYt55K0v6Gf4zvrrnYFKBVo5ykGGztNmIV0fVRJTlJcD/vz2izhWGPyB
         XTCUvj1SQvYHDDNv/S0Defq7bj0D7yjAgzQ7jBnvexBX6KDVyWJw1kfBcKXh9yfSlRLr
         /Y1elEKv09+ra2wnxEJftODb9CIMMWEeVCTC7BUQq/O0LUT45E8blynA+7pQXPKmIJ/t
         lMQpt3BaIt0ZF2QoLj/EMIY8bWPr8oCinupMK64/L0cgZ1diOyKLT4fo5vTD26jCO8Ep
         OZdg==
X-Forwarded-Encrypted: i=1; AHgh+RqkSD5HhCEwxGD90bap0wXXm6zNKyUxSsYMIbq+A09TJeRoPnTeLS2YpF9TQUMOQjOXBm7cw/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2U7q1WxiQ+t7w6tG+KdvWSXk7BOsARv/niZf4sVGJplbyuCrm
	YU3o+8auFLBn1ZYVH3mPwpR8MjmMsTy3T1wt7RnjJjwRcj6LZjbGZ6bnFS46D5v/8e9x1/geZG7
	gO1ZsVSba9wawIaeyiwNT8K4z0SY84TAfwlYr5N2AjVOJg18E0S4Qot1MkAc=
X-Gm-Gg: AR+sD10lopeFYs2WrkFlAt1ZS+MujZuPIWUdiK79tlP/ULoKdt5887d6VqJ8QrmK05x
	dPVzwKoXMKznGHfl8AHM1m8mt0AZGWJzKzF40tx5ZRIQzkUSaaE9kWIJJAP0Vfv4r8GYDeWTCdE
	Pc5yZXeeNDUqBczFSZpThZqWGHA+wT0Mnwbyw+19x29eILzVudG+y5dtdp/MOUpeJckIm/s6aSK
	54S923qj50hJacysD4iRXcXrBL/FY07nw+AO/iJ2ps5/skfsjc1YsGMSTwEiaH6q4rhswX/iQjI
	Cy4TrAYClSByBeP4E51C8kADZx6T0b9f6JsIkc1jmIrPJv/4fgqdqjUoh2+E63SvEn7t39L0bYn
	q1Diuk+3v5Xz5vA1bpD+KoXmZuENuJ8kxsIY=
X-Received: by 2002:a05:6a20:cf8b:b0:3c4:2b8b:e17d with SMTP id adf61e73a8af0-3c92a8b795dmr796767637.58.1785522173706;
        Fri, 31 Jul 2026 11:22:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:cf8b:b0:3c4:2b8b:e17d with SMTP id adf61e73a8af0-3c92a8b795dmr796735637.58.1785522173252;
        Fri, 31 Jul 2026 11:22:53 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:22:52 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:52:19 +0530
Subject: [PATCH v2 04/12] media: iris: Add helper to create a context bank
 device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-vpu_iommu_iova_handling-v2-4-da52b5228dbd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=3855;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=bpZUDSDe1YBY8ECN8OTOUWJTi/KZ4B5ccQkOA6CUnRA=;
 b=I5Lfpjtuqvt9qfOSlAXNtjo2zhc4Rg7VJ8/SxcaEkF8e1vS1pz/2idzbikFx+IyD7KXD2f3vs
 j0YmAO/1z5eCAxn402aAwwLkvKPrssanD1bahkLPn/PuVcuIbGpNL8d
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX8nysCp6rbZ/a
 W8sIkYA/shO7iiBccCLHNG4zHCd+JWy/9VCV8+I4Hx4EdfcDlGYoOwc86rbGs09BfalXz3HuXQz
 o9Uejx0L7ECZYzBJgb/onzUMenmD+90=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfXxkYuD/pW16mV
 yz1h1HFzBnxXwcdhpad17Qs3TfkPaYqBaYoSMbnJ+lQTlLbT1Hp/3+pcDXEDX2pfZH89AtOCh+j
 qqFa1WIsIS/dJwfAcfT64A1FKHz7V0uVW/lz36hl/VnD1ODK7k/kHIwuaQ2A8pNLBwohDP71lLj
 chB4NFw8wsWmfVeKjEhYVldHSuUMNAY1FdetbvopifACyqnzhs+sZXnZmeipC5muxD9zeVP3Alb
 Z9DJorepA8BJUXCyVHNs8oGtAuLVctByAUD9vOY0Bbp7kVGy3ETG6sfSI5gr3ZR0Lry63RUom89
 FyrHi2Fbw0A8K3Pw2hjeR/LWPZuYmWVWSt1wgCbV1NEDjMY2TGppavoXvY+m7uKoHqT7almlHIz
 zebf5hcXN+RrVM4wT1wf+cBUeUaYeEkhyC0Dxi6GpzdKlYBHxs4xH1cC5DDr0Eulag5oqV/GRAv
 vD17LG+wYR9S0xIdSrw==
X-Proofpoint-GUID: oaO43NV-aCEe751x5HduRdMC3i1DV0Xx
X-Authority-Analysis: v=2.4 cv=BpOtB4X5 c=1 sm=1 tr=0 ts=6a6ce7fe cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=vkKLUbRMwET9CpguikUA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: oaO43NV-aCEe751x5HduRdMC3i1DV0Xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310141

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
is restricted to use 0-600MB of IOVA space, while the pixel stream can
address the full range. A stream can only be confined to its range if it
has an IOMMU domain of its own, and the IOMMU core attaches a domain per
struct device, so each stream needs its own device.
Add iris_create_cb_dev(), which looks up a named child of the iris node
and registers it as a platform device parented to the iris core. The
child's fwnode is handed to platform_device_register_full() so the OF
core applies that subnode's "iommus" property and the new device gets
its own IOMMU domain. The DMA mask comes from platform data, and the
segment size and boundary are capped at 32 bits to match the addressing
the VPU performs.
Return NULL when the named child is absent, so callers can treat a
device tree without context bank subnodes as a supported configuration
rather than an error.
Backports are intended since the first DTS of 8550 binding schema.

Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_resources.c | 28 +++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 872bd09656b151eb9ed5eda2f9774d3095d3aeeb..9e02a92baae75803c2c12a2ca994006987c69596 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/devfreq.h>
+#include <linux/dma-mapping.h>
 #include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
@@ -137,3 +138,30 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
 
 	return 0;
 }
+
+struct device *iris_create_cb_dev(struct iris_core *core, const char *name)
+{
+	struct platform_device_info plat_dev_info = {};
+	struct device_node *child_of_node;
+	struct platform_device *pdev;
+
+	child_of_node = of_get_child_by_name(core->dev->of_node, name);
+	if (!child_of_node)
+		return NULL;
+
+	plat_dev_info.dma_mask = core->iris_platform_data->dma_mask;
+	plat_dev_info.fwnode = &child_of_node->fwnode;
+	plat_dev_info.name = child_of_node->name;
+	plat_dev_info.id = PLATFORM_DEVID_AUTO;
+	plat_dev_info.parent = core->dev;
+
+	pdev = platform_device_register_full(&plat_dev_info);
+	of_node_put(child_of_node);
+	if (IS_ERR(pdev))
+		return ERR_CAST(pdev);
+
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
+
+	return &pdev->dev;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index 6bfbd2dc6db095ec05e53c894e048285f82446c6..ca53c01f60aef2040002f526b8f1b6a9094d1518 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
 int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
+struct device *iris_create_cb_dev(struct iris_core *core, const char *name);
 
 #endif

-- 
2.34.1

