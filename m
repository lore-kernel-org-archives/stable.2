Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1972369D57
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522195; cv=none; b=r4Y9MnkSa+jp4bOvmuAf7ewIr/T0qKcGJ7PcfyCVKQm7XpU/EGw7ZRow4KPhdbtZE5x4sE5GvnN+/oTuo4FWnBI0opv+iVRJPrikwxWksjqIqdVslMlT45aRXe+MFpZYAMAet5tkh3e0k0dh88uUyC0GNCFF8CQBrcE2f0/CiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522195; c=relaxed/simple;
	bh=ABWnGsy9J/aBpR3bz2vspwGz7dNQEU9mA02+SM6zBCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCLt5VJSw2uRja/E6C6G0PDsflkpLVD9XU62NKfkLSh0xl7H8jNrXiRXhfueiEWRpO5rZfWf8MOMbB6emZhuvyfY+rMADioALCpXC6C+yygpoBiQm+CzOaY2Fg1Wop2QFc+IaX0RuLpDx9hatmm2HzEk2gVIWF/duG4NsqwrS1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LhxLBs9W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kq74zxUe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LhxLBs9W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kq74zxUe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOB6l1399391
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gyNScZIZF6mo/dgFtciHSO1E8I13BJdXx0ih4EmXKGs=; b=LhxLBs9WJnlSuGS0
	uk/cmOeGQ1McHr3PHiu3Se2jsuayO8eVU1ejQ95m6wqr49nNIc/HkGvxOwBuwmb8
	mdYle8x6mvIuvWylhFX9vi+1ZIKv/fXe5SUbAc2kQ/B3lLnOrpbtXJIQpCb5w+MJ
	IphlJlJgpwXBrCVMsAlnq94mfQ1y3QOpGzRXg1nPB66pAtFwgc600HjqhKPezknu
	hkOi0N/lmtc45YbaYeJerk1WJkcp47xGwuTSW6gMKawzS5LnLYOFvVaLm5+XzDj4
	xO3MO6fzJbk1A91b/QC0YYPDAfrLLvpwnkRkfEZbR6rX8l9hrEmvYAtRZqoL4F+e
	LIBopA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1x9u2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:23:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so2066075a91.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522188; x=1786126988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gyNScZIZF6mo/dgFtciHSO1E8I13BJdXx0ih4EmXKGs=;
        b=kq74zxUe5qBaL+WXgXSh6ORPm1eOdBPPaGKqru/2kYa4MGcl9QlcNdrknn0SmgI1F0
         //BQ22AR7MSMDoK1t2jDUXoMB9c047ln7Ykz2LJxr83vnZG19oMqAybQyFpfUYtUYjGJ
         5wlX2NsMAgxLwLYy8l6XvO7PjTAgCrrwTHZSEYsylV+hP7qLfY3Yn8qoqojWr/a1Fyoz
         Qq4iOsNRlSuv7sFUYf6LRD26VGO0mok/RiK9z6bF/UpcWPeKDL1sMYAy94H2r9X0CTdP
         YG3NhKincAp6Xm7WfR8SDptAmes0XxUsUWhPeemvaw9bC4b2IeNO5KjO7riKZQyMHzsU
         yTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522188; x=1786126988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyNScZIZF6mo/dgFtciHSO1E8I13BJdXx0ih4EmXKGs=;
        b=GvHA9KOUKqP8c2e7PsWPaPeeaPCBmOdiGjv/vStJi/7/vKDgNaK+guyjhQu6uCwdP2
         tEuO14Emdt1qVK2A1iKJtaGQZl/ycTNhRMv2BoU7jvyRsknJAc39DKv9j3Ck8+nCfKnC
         apXpzS4I2cHNfALu1bR6W1E6c5fnvYaawavwZtccSa3e+OGTFWYhpveR5MDAHzD9D9bW
         w9kG6UtEIRCIlXgIjub5RJ/Nc57eInsJmSxjlfvFvzW6V21Y+if6L14cYOSabTfZCm9Y
         dt4Lt10ytZcIAoy2KycSgecXbyTVKpq103a4BoDdMHouqooRnOo6OFS4DFTa2RXZeYWt
         61xg==
X-Forwarded-Encrypted: i=1; AHgh+RrUWMdZc2dqDfm/p5K956abtwwSD0HoKTGCQe0uzfhaW7U0U0la7TWkgAW06hoWpt4Y1YrIBb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tY8v4+UdfsVG6qJ6IUgaESreEVMh6ZUpJeZ8bvlzbhiff9sd
	k3BITxJkSEfa0qPrigpM/uVvsq2YwMFLXJW5S7r6Ul+b+cc7jAsPeGKEcbt0zfPqsJlvCQCT9TC
	sprcT6CvXLYJHIyX8qUR0i1H7FoDUuFpqRDmcPWu30EeoUqIG3jJoSdpYsw8=
X-Gm-Gg: AR+sD11CtGbeTZZrTLnbX/HDCrggH3exMSiqwifqGcFa0yfVm9NKSy6UTr3ZYrlOgPp
	xa0QMnIAcGFMjGBu66e/Q6gx/thCHO2DSzLa/vdA0nm/GCbxcwKs/S47zGjph6v00xJMnMS0uw1
	I76NlwNvhjnWx/3gVJw2UgWY2vt8JxAsHmuUNeAIOK/m6H0Z/XaQMRHcn7CcoWGWsrbzFrj77pc
	7T+mA/hyku6VzQo8TmKKYGXXgzEwcZQ36W61+Ll9T6+9BY+PjE0b8V9B22VsN54GNWB57OssrgF
	fbbysu+hssPfqMXZ7ESxDfBBx/7aTOtU6/Wz76NkLNwmRXfww64L0guN9KOuoCOrNmIoDLELYXt
	lTvWOOQlZ4WWpljrz1aT1Yyqv1G+UhEDn4/4=
X-Received: by 2002:a05:6a21:998c:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3c92a7bb473mr770799637.36.1785522187604;
        Fri, 31 Jul 2026 11:23:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:998c:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3c92a7bb473mr770767637.36.1785522187182;
        Fri, 31 Jul 2026 11:23:07 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:23:06 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:52:21 +0530
Subject: [PATCH v2 06/12] media: iris: Skip DMA mask setup when the core
 device has no IOMMU
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-vpu_iommu_iova_handling-v2-6-da52b5228dbd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=2020;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=ABWnGsy9J/aBpR3bz2vspwGz7dNQEU9mA02+SM6zBCk=;
 b=BBD6R3QsRS6fozOLoKfFWE3T5NkFM1rlNqFYFJdcwqrSf2O+PaAs8EACW74TtFdD48K/MoISu
 8Z2GdTXWrYAAihSsbVdpgZG5wgdUIfHxNeDWpDYE992i0IdCOwIf9mY
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX/DOjVETT+E52
 rd1cQTcvYTjPFkN6S7gk4jeMeGx+7BVsWWNa0HhPQqi8Nkrz+wID0EIRVPcHLgeDVdnGbxi/sv0
 8BBAuAISg1xN1pJw+XUjvCqBtDeyNkg=
X-Authority-Analysis: v=2.4 cv=GpByPE1C c=1 sm=1 tr=0 ts=6a6ce811 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=rujDjMnGqJPd5R0KWf4A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX39n8TtdrkY2i
 ThJSNJ9XrKHyAfBxZ2hIKnrqgEw8PAdapH0U4RgEgOgppjjsueNxBtyip+hM2ug0euV9v1kITCh
 x2cHEgVEdbdr8UeD4daKq6h35IjK1USdI0WbpM36ZyABpiQZE9j2pIb5ILVIc7XeF1AfCM3ZasP
 Qmv9Ya1/Eepl81aCoJacIsYTUwbdNkFJHO6NMSg0feCGANK6MMAqZc1mqRaVlkqVv+8jt9anDXO
 BSqUN7Xxa9SDWCAzQK64eXe5TxvYNZoQ9vAnOr7WO03tLjh1i20XdIyl50Lg7oSRUVFMBDQyY9f
 lEhDksEKo68W/o1DqYN1d/29ubN6/+NE4Tex0a+qhKrZu+POHqH3Px0nMUs6j1GoVMHnDqyOxKJ
 xJauQiKh9rnJpsfJ+WeI2mdEaqkpfhlV1J2Dj2JL3qZ3Byl4avxgByu2oSZhgr5FAddUnVBEdQh
 mkfmYTkkWaDvXN/D02A==
X-Proofpoint-ORIG-GUID: 0KYrVlXIAY5OsVJ6Ck4fWjYHNG5OgALF
X-Proofpoint-GUID: 0KYrVlXIAY5OsVJ6Ck4fWjYHNG5OgALF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310141

Once the streams are described as context bank subnodes, the "iommus"
property no longer sits on the parent iris node. That device then has no
IOMMU domain of its own and never performs DMA directly, so calling
dma_set_mask_and_coherent() on it is meaningless, and on a device with no
IOMMU it can fail and abort probe.

Set the DMA mask only when device_iommu_mapped() reports an IOMMU on the
core device. Platforms that have not been converted still carry "iommus"
on the parent node and keep the existing setup. For converted platforms
the mask is applied to each context bank device instead, in
iris_create_cb_dev().

Backports are intended since the first DTS of 8550 binding schema.

Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_probe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 2594f5a67378af9a547f23dec2d2c057506dda65..c40c4ec44e83e4aa212b58a19b64d46a3d9f16ce 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -310,9 +310,11 @@ static int iris_probe(struct platform_device *pdev)
 
 	dma_mask = core->iris_platform_data->dma_mask;
 
-	ret = dma_set_mask_and_coherent(dev, dma_mask);
-	if (ret)
-		goto err_vdev_unreg_enc;
+	if (device_iommu_mapped(dev)) {
+		ret = dma_set_mask_and_coherent(dev, dma_mask);
+		if (ret)
+			goto err_vdev_unreg_enc;
+	}
 
 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));

-- 
2.34.1

