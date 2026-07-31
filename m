Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92E369207
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522200; cv=none; b=c0Zx/+ypttC4P4WMhhEPphOnym+YW15uozmYdH0geyxFyDXQX1o56hFqNTFZLNlka2/9FsxcsHuUpFDttv6CBrugWmV7cUpQ95T5k6p3AlK0SwS1B6KFu7TEwmN5KOVT93abq0iOf70qfrEpsrsjL9/nuBCLIF/0zOmvzIc1ARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522200; c=relaxed/simple;
	bh=RGTIQ+EkKAwvbuWT1JSlLR0/n48W+JBU7qKtrCaPp1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFLIgxqzyRUyx8cpaNZhS774AA7CNXjkiLmlR5j4fYINtXEQHXAEw45PuQKj/zQtvzAv8uixOQk2puBKcx0L7w5gVh4Q8eL6l6xkBNmMg64TvhfvMF3dnOXtSrZhK03sXWmB+O3RfBmmaxZ3QHtSgXOY4ekCsw1CQ36sj0n9P8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G0iOBeWz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bOnRcQwl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0iOBeWz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bOnRcQwl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFO0pC700510
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TFGjkvD83Z1gX1LMlkQippx2OwmX3N8h5/9DHjEVQFo=; b=G0iOBeWznQNdKIkJ
	+G1ZysmDQSUzo0rlf/AtBJjv7vqXLI7hncqLeo1oe6EmRLXRFFxMFSMSyjGKvJlO
	BYOfuoRCblv5f/euIEMTvBqqsxxsc517KU1S1f0b577d8ZohXXG8KyctVg0WmBEb
	u4y9o845NILRkoJoNteDcD5MONKnqQS0ueJERkDIbZt9t+cbNlSVmuLAM1BnTnYm
	awYtuik2jDZypXZBgEM36PBZUtWdkqenq9RmmXn5/Hvsbx9U7vn8eY8DHUImVr3p
	JUa9+xlXSZjjsEa1intmFQd5Bg0tzx2zQtvAvtUVff0YWxn08yzzuUiC+B5wbVOe
	TD2HWg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1u1u8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso2570361b3a.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522195; x=1786126995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFGjkvD83Z1gX1LMlkQippx2OwmX3N8h5/9DHjEVQFo=;
        b=bOnRcQwlkL99tIuR2jDVKOH/LQRj6XlFjh7DbaqxGX9Wayp4Dw4J30KYPjNKPnABG8
         FTi7EiAqmBNMh5wejmPs6hBmH+ZAS0YkxDhG9mxkMXa/ZkJ7IN7XFuUyPVANx70okxZF
         L8kEs/Aq1xB0prXGzvu3ZxgnnmyaS/KJkal12kqghgR4xbfMjcP1pt5krflq9GKOJloi
         hoogX60Xv4n12Dz1+Gpe9VoKqJqTKy8efzwROwKpGuCYGaG63o9DvsHKoK/qZiSIciN1
         0aao0iok2c1tBHCiJT84NZgLzcR0wAaquvkJB2tngfB30ulAKoyh+lnPBRTVxXsdyQvl
         Iysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522195; x=1786126995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFGjkvD83Z1gX1LMlkQippx2OwmX3N8h5/9DHjEVQFo=;
        b=kmTaT+U89hcRHVt9x3T7sDvVOD5u2n/qfqO4YSldy2sMMsx0PaGdYMPfl6TKN7IbRm
         cT0aOGGMMeXae4tcWNL9QPTFDsXrN1KLiHCq92eQ5rcYFGO+ZzeVBzHG4a8DdzF95Hv+
         ZhGupSrw/PyVO6IH+iDMAiJkcYUqbP0FL6Z5T5iAUPHNsvSLIB3DbBPseSIpF/Kg5goh
         EwXQOJ00bRKfX4zD0z9KdgjdfSPUCaTMS03rKnXP9bUv2Qyj5gzG2hqfvdXPUqmwy/x5
         n7+klUebVRDvKBtkjsuA+06KUZn8uM/Y5nsbq+ikGLSLxVzbEYJlvLoXx5kW1LPtQUrR
         O+YA==
X-Forwarded-Encrypted: i=1; AHgh+Rokb459lrFc7m+1OqfdFwSXXhkBZKst7yv05XQJy7q0AR/mMX9oPV7jD6Mhds7sTe1dgHL9oNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFS/W18S4Xl3I1AviTMKscpHdLuFsI+sSvTANAVgBwqsx3IyX
	lr2+rRZvQ+00RPX4P10ymieipS8OQq2QC0cbDlPrm57A4gpO5OQIf3spyxXfQFh+1nzK51bRrHP
	I164pU7qfbCiX05YFLMAoYxN524r7faeYcDtHX7tj08dq5dMqkdprnNdm+7Q=
X-Gm-Gg: AR+sD11+r4xigAXMiByA10tb6S9KxGo7cm19hOE75pbN0W50TSxAeGlCfow2/a1dHFj
	++HqlRkgQx9RKj6taqFXFB6ALqIFN6TrxX6Hla2JeWZZvVKWETP5kwIgoRStVLbJ1n6gedR/ufX
	YDVsQqrYIK/yFl07ze6RCKqJnxAfWk4rftfE6LdXMvNJUyO27PK8Ktp8xYokZxKNQT3G9ckh03S
	9GYQZfbpbcqS0XIiwj8UZEQWd2yQrWsMY+RTuFxeQlmF3YdoUILVZ94Tss/jaowiBMYKGfkgZsh
	33svWfb+7R/25RyBGqtflKGF72kBjabRNB0Xf3f3mTteWL8HUUuHDj8Z2hvjemnf9t/T3nZIQ89
	l4uMb+hyT97OJ50MQoaZso4HwrGCzDumW/Qs=
X-Received: by 2002:a05:6a21:6b0f:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c92a5d6d28mr787363637.21.1785522194702;
        Fri, 31 Jul 2026 11:23:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b0f:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c92a5d6d28mr787325637.21.1785522194176;
        Fri, 31 Jul 2026 11:23:14 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:23:13 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:52:22 +0530
Subject: [PATCH v2 07/12] media: iris: Create pixel and non-pixel context
 banks on VPU3x
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-vpu_iommu_iova_handling-v2-7-da52b5228dbd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=3503;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=RGTIQ+EkKAwvbuWT1JSlLR0/n48W+JBU7qKtrCaPp1k=;
 b=4D+inkuCsQ4brG1HvaWIVgq2VQcr8M7tu6Cw6rAFjqj3Bu1oOO9t+552xWUItuEtz5TI2C6fi
 KD7FEZaRHNJBsKCrE2JgUV7tVrr3HCOyIkHbRMBVjXYd5A+FRGUs8vP
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=H5vrBeYi c=1 sm=1 tr=0 ts=6a6ce815 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=v0Z7u7uCyoCEKL_A5NIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX6d3jHd1tJRzs
 LdVgLpgMfpqgrs7AhNCIAx9hvZ6EQ2/yy/B4R2rMYNzvN6p7WM0NN811oIKneuvWpFKG5gWrjBO
 nTh5AHOJ5+Gc+6bS0m9PsWttABbMtl0NHiyR4xzRop7l6WllxbeijEjHVEaPLXuOAOndsvwmEWf
 aTdD5Fug0w+O4/Vjy0dbWvjz77ZfzbsyO+mHu7QCIEjyLa0SW7tEAJ1ITCnOJTOtAaPRB9Ml59Q
 Qbd9TAxNluOrosQYs3ZDu8dnw2jkq40APXr5fuFMnMd6cnNLOqZg9gH3ic7uQyGmyY0Bvg/dOfi
 HVgLdc5HRZMgeIwj+9Azj66EIjsFVYusqoap66lcsjwzVKYsZFq51NdncII1I4Puc/yRK7GGtnh
 tUJCI9EzYQUYN55AJfVCdeQJK/iBmz4pvhZreInbB+fqYPRCl1+bnB3Mm6s6Flupb5+cIn0sye3
 LTuSwBN7O8h0or6o5BA==
X-Proofpoint-GUID: MUwr8df_9jYDe626SlQZObFs1ka76xvE
X-Proofpoint-ORIG-GUID: MUwr8df_9jYDe626SlQZObFs1ka76xvE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX+jNmefhsGfHj
 ca/gfbJZP/bvai50jYcqylR+2DOuulHtE/jEeDxlyCgiIAEW8Zi6q27aMZ2Hy2DkMmAw5UWNR8U
 fxs78TM0jSpRfMfg03EyQQb8TIx8wKw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310141

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
is restricted to use 0-600MB of IOVA space, while the pixel stream can
address the full range.

Implement the context bank hooks for VPU3x. iris_vpu3x_init_cb_devs()
creates the "non-pixel" and "pixel" devices from the matching device tree
subnodes, and iris_vpu3x_deinit_cb_devs() unregisters them. If creating
the pixel device fails, the non-pixel device is unregistered and its
pointer cleared before the error is returned.

Wire the hooks into iris_vpu3_ops and iris_vpu33_ops, which cover the
platforms whose device trees are converted to context bank subnodes.
iris_vpu35_ops is left unchanged, as sm8750 still describes its streams
with "iommus" on the parent node, and the fallback in iris_get_cb_dev()
keeps it working until its device tree is converted.

Backports are intended since the first DTS of 8550 binding schema.

Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 3dad47be78b58f6cd5ed6f333b3376571a04dbf0..623a0f8a7982c0b5c2e3741a34c1367e9aaf4e27 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -254,6 +254,40 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
 }
 
+static int iris_vpu3x_init_cb_devs(struct iris_core *core)
+{
+	struct device *dev;
+
+	dev = iris_create_cb_dev(core, "non-pixel");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	core->np_dev = dev;
+
+	dev = iris_create_cb_dev(core, "pixel");
+	if (IS_ERR(dev))
+		goto unreg_np_dev;
+
+	core->p_dev = dev;
+
+	return 0;
+
+unreg_np_dev:
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+	core->np_dev = NULL;
+
+	return PTR_ERR(dev);
+}
+
+static void iris_vpu3x_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->p_dev)
+		platform_device_unregister(to_platform_device(core->p_dev));
+	if (core->np_dev)
+		platform_device_unregister(to_platform_device(core->np_dev));
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -261,6 +295,8 @@ const struct vpu_ops iris_vpu3_ops = {
 	.power_on_controller = iris_vpu_power_on_controller,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 	.set_hwmode = iris_vpu_set_hwmode,
+	.init_cb_devs = iris_vpu3x_init_cb_devs,
+	.deinit_cb_devs = iris_vpu3x_deinit_cb_devs,
 };
 
 const struct vpu_ops iris_vpu33_ops = {
@@ -270,6 +306,8 @@ const struct vpu_ops iris_vpu33_ops = {
 	.power_on_controller = iris_vpu_power_on_controller,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 	.set_hwmode = iris_vpu_set_hwmode,
+	.init_cb_devs = iris_vpu3x_init_cb_devs,
+	.deinit_cb_devs = iris_vpu3x_deinit_cb_devs,
 };
 
 const struct vpu_ops iris_vpu35_ops = {

-- 
2.34.1

