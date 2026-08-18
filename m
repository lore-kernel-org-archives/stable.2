Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802C140B6F4
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066037; cv=none; b=Q5LZA+Xxm+UvST7LKpCykEtJCrCMB9bdDgWu4D16AJIlAL++jNBOurxPJmYfgoYjacGAQC4G0hMGN2WyvN9iOs8LXGZ7z5/y7w5Y+FarZuvwqv51d2T86z7HepjYWWOIIL3wYBVaDj1DNduYx2lWKtHKTPTphc3kQrp+epK09dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066037; c=relaxed/simple;
	bh=1PTf8YbOWl7UXgO0zqjYib+M54r/rySJkiqiwmt3PHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3z9pQkoLgDwqPw1kySp0UC5qHNv7dH7GUZ01DyI0drHbT6S9d+oLvFcpZnqnhEPayFt6SxLu87Yp6LT90k2YK7DLZGlO3cAAZXU+CE/7ltBwsbHqkIIkmSjxoFWGfsvveEbOlulOjlahaU1O9PyyCDfCr6zORKs2qej7tCoNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1Zk5hXb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BmnhNg44; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1Zk5hXb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BmnhNg44"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IElpXq2157109
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g1TN/DduOHEbBn09XbvXQheB2KNdAXxnnAWHRO8PiL0=; b=Q1Zk5hXbl//CR2jl
	gtt0QM3i0Wg0+sS7S2lyzozDbyQ/QH949I9pg/Te0UCFhx0+u0opQUNtOQSaGwsI
	LKSaFQ20OBMVi3Utfp+bsTwNp4d2EajOlBVWXEGxacdXT438uKmaTGEt5KgkZZAi
	51InoeTR8NX32GEKs31v2mPqaUk8csJrU0jf4NNnyPyFpksXyIBcsMlNjI3082dK
	yCkPN0bSIwUZ0aRexDrbWnboCgXlr7nzQ+lwMQx6MF9o1ISzSrqogdr6FXGmh1qF
	xTRGSM8pZzNubflAaYM48Sh1WVACDgHrhw/j+A51aqzT1ERsSO0xTwuiCvpLbY4H
	/fmo5g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfng5dm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:13:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9309af14fd7so403726685a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787066032; x=1787670832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g1TN/DduOHEbBn09XbvXQheB2KNdAXxnnAWHRO8PiL0=;
        b=BmnhNg44y3/wpcvM/XA5s0tmEehV4thEXlpDfrqvdgsaw9soNsx4LICjJ9inPZpXyb
         oAm5Cv02EcqblensIfrWRRs5LDs+aszJbLo7CskZ5MfnD+3TVe1Ml/HZ88LlDtORBy4e
         FQPHM2khXE3pb68rShC+fDrSDVvPoFoPzv+Ru762X001g9MIScsfLV1NHglAcbXxbDa4
         YuGokcdgdFgFiGlLqOHhqOHEDpAsSWBm0Hb2NKdFoGOboGaWcfmxYCELTVPAX5c+zyzJ
         Qe/9AdBRGaQ6Wt8a5Bn7+zI/pjdLl1xtkupRXHss0FVVvL+hn80aVUQBPademM0lK9PH
         I/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787066032; x=1787670832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1TN/DduOHEbBn09XbvXQheB2KNdAXxnnAWHRO8PiL0=;
        b=O2rGjfn+XaezdGiBZOp9tJrbAJyBeSuMcRQXbpEva/pcalJHhOHyJj65Ue+Fyq6o9E
         R/AaeX2upsV3r/S0slEbwensURNrt4D1br01vXcBoXtuotQ2D+3bYzC7yFb48qpLwjEV
         bfc/Qfmb+ZJ2rZD9eBykDA6YB3JKh4cQn71slJfC9p+9o5OMwmeARbb7vxRHc5oaSrjp
         yvQ/vgW3v00BrwHlP16lK9j5kYc6On1goaOcb4z/bG6VnP7TOC10/fuOIBTm6ldXjGeZ
         HG29J2dssWXyQPy/bngv9WnlHB3UQr8y8OoST/TniSIf1FN8v7a9FQy7gh3oMbon5DVl
         ITFg==
X-Forwarded-Encrypted: i=1; AHgh+RpTy/Jspiw4ekqAlfNSVW3ITj4+o00IyZITseDTD4mg7mD7kg9iuYSr5cprB0uF9pwz75Is/m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8I4lL1p2dP/HavJdkTvi46P9GKOZbySmlM0pw2cKmy3BlxId
	jW+zGNIOmUqWPr1njoDcQ6/+Mijahz7zWMNhdD7y78JHurYGMFmEFkRvGC0w0UMAoWY3kJftfJ2
	zDjaUNWxc+4eJnUviZ1HwfWOF2Zjgdv++JGbUxRmvcGsuxyLYU7yQm52Ie8s=
X-Gm-Gg: AR+sD10zcyQ0sfzb7VGXDpaCcmsgkTtMKckRmEPE1Hwx+RPJUxyjgi8xSWYNIt2z1zQ
	/ERlgu60f1j3J2/2wPmu5cc58BKYnpZiL0X2ncwfAjr4U2mmH33MjuTBkUQgXYv0buaKGeW5UUj
	H/xCYEDgSlWd/nAyNCXHrhWcK/T1QPpbyUH7Yw0CFFwi/Nv3yVpfGWB/9E21B/L1g8K/4OvN/4F
	QoKnBmHvOn3rT/pwEeUjr/0jssYDqINGEUAIGD/aPBsTFbPYQ8i/hqDF0hYYaKY08DB7xg3+DCE
	WvwkcuvsDURKeSrnPjK/5aELOMNq9lh4tFaLq/v9NQPE92VK7Kmbe2mG48L0UFRGtrMQDAQYTAL
	L49E0p4gU4eMKlyeLxDCwjT9jk389rwWJsQ==
X-Received: by 2002:a05:620a:4014:b0:936:cda2:bd4a with SMTP id af79cd13be357-936d234d86amr3442267585a.27.1787066032108;
        Tue, 18 Aug 2026 08:13:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4014:b0:936:cda2:bd4a with SMTP id af79cd13be357-936d234d86amr3442259785a.27.1787066031704;
        Tue, 18 Aug 2026 08:13:51 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3158asm13111105f8f.7.2026.08.18.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:13:50 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 20:43:22 +0530
Subject: [PATCH v2 1/2] media: iris: Fix iova allocation from restrict
 region
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-reserve_iova_in_driver-v2-1-5005a1154408@oss.qualcomm.com>
References: <20260818-reserve_iova_in_driver-v2-0-5005a1154408@oss.qualcomm.com>
In-Reply-To: <20260818-reserve_iova_in_driver-v2-0-5005a1154408@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787066016; l=6296;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=1PTf8YbOWl7UXgO0zqjYib+M54r/rySJkiqiwmt3PHc=;
 b=NqHVvSjCuArsqoSpdCEB/YOCBZlPQuP/4Em+Ep5pR7c5Lmeiz99oOo75TQNrfNICTnKyAwFcU
 DbpLUJ+WDeKDSqr3yYpcohY4XKqJ7dIJrw4+BbgrqC/XlUjk3K35up/
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExMiBTYWx0ZWRfX70e+J3nT7D0q
 4kxHbHsxoexvIa32BmLoBLZqP2wxtJnTlSg+g+usCegJedhjqWOpnhp2bN78KcV2ZfTxUeqFtTe
 VgERp53YwKqJUlfDBWRX1XprbUJi0cs=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a8476b1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qCMCQjtVS-vTbDhzrxIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: IWS6YYV_vvGQmoZ-KhlYIIKJEVXoE-KV
X-Proofpoint-GUID: IWS6YYV_vvGQmoZ-KhlYIIKJEVXoE-KV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExMiBTYWx0ZWRfXz0NFjxkVqOG3
 KJ6YhcGWzBD7FbXq2mhaQhjeZMUf6WrZBN4TO91qGwDVOT7boIk52m/7mXLPWZjUp7S8kHqKyC+
 FT73tWvQVEoChJgQBy+Xmj2I7QGDQsHInwkBhlEckWhJUu0m9AVCsc01xwBafKGl7J6tOG+Wvsc
 6VESMFBVF+edIFge+OnsRipteySwW2LEMNtB9nMo1iv2fd9It23/5vVmYf2C0RkkEkLeavZCS1f
 2meIvFY/XgAL0J8BFpJAlZmtYNGcTowRRYBX6hwbJ1q4y7HX9eU88iV+Y4LRW0X6cau1/HIVCsg
 IIkwn1M/qsM2EAo0P2veF2wrUooyWj3TKKHUgyLl5/0Al4OvVGUinHQAhlIOosQQyDW7aJvtFfL
 7Jq8vYkCEO3f26B4JVd/2IxnsNWNXJVl/LHDJGFVTiKhB0gVVxtAld9RJ9qs99EdddEZN5WytDu
 iGiPqwm42vcp0ggc60w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180112

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+

A single "iommus" property on the video-codec node puts every stream
in one IOMMU domain sharing one IOVA space, so nothing stops a
non-pixel buffer from landing below 600MB. Once an allocation lands
below that boundary the hardware faults, which shows up as unhandled
SMMU page faults and spontaneous reboots.
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Fix this by reserving the 0-600MB range, below the boundary the
non-pixel stream cannot address, using dma_iova_try_alloc() so the
IOMMU-DMA core never hands that range out to a real DMA mapping. This
reserves only IOVA space, it does not allocate any physical memory.

Since sub-nodes for non-pixel, pixel, and secure streams do not exist
yet and only a single device is available, the restriction is applied
to both non-pixel and pixel stream IDs.

Fixes: d7378f84e94e ("media: iris: introduce iris core state management with shared queues")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h  |  6 +++
 drivers/media/platform/qcom/iris/iris_probe.c | 62 ++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 24da60448cf2..3e4cf652bf39 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -7,6 +7,7 @@
 #define __IRIS_CORE_H__
 
 #include <linux/types.h>
+#include <linux/dma-mapping.h>
 #include <linux/pm_domain.h>
 #include <media/v4l2-device.h>
 
@@ -25,6 +26,9 @@ struct icc_info {
 #define IRIS_FW_VERSION_LENGTH		128
 #define IFACEQ_CORE_PKT_SIZE		(1024 * 4)
 
+#define IRIS_NP_RESERVE_IOVA_START	0x0
+#define IRIS_NP_RESERVE_IOVA_SIZE	0x25800000
+
 enum domain_type {
 	ENCODER	= BIT(0),
 	DECODER	= BIT(1),
@@ -77,6 +81,7 @@ struct qcom_ubwc_cfg_data;
  * @instances: a list_head of all instances
  * @inst_fw_caps_dec: an array of supported instance capabilities by decoder
  * @inst_fw_caps_enc: an array of supported instance capabilities by encoder
+ * @iova_state: a pointer to an array of dma_iova_state entries reserved for restricted IOVA region
  */
 
 struct iris_core {
@@ -123,6 +128,7 @@ struct iris_core {
 	/* encoder and decoder have overlapping caps, so two different arrays are required */
 	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
 	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
+	struct dma_iova_state			*iova_state;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index e4acf4a74f94..6581a969fe3f 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -150,6 +150,57 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static void iris_unreserve_iova_region(struct device *dev, struct dma_iova_state *iova_state)
+{
+	unsigned int i;
+
+	for (i = 0; dma_iova_size(&iova_state[i]); i++)
+		dma_iova_free(dev, &iova_state[i]);
+}
+
+static int iris_reserve_iova_region(struct device *dev, struct dma_iova_state **iova_state,
+				    unsigned long start, unsigned long size)
+{
+	unsigned long dma_limit = dev->bus_dma_limit;
+	unsigned long end, rem, chunk;
+	struct dma_iova_state *state;
+	unsigned int count = 0;
+	int ret = -ENOMEM;
+
+	state = devm_kcalloc(dev, BITS_PER_TYPE(dma_addr_t) + 1, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return ret;
+
+	end = start + size;
+	rem = end - max(start, PAGE_SIZE);
+	dev->bus_dma_limit = end - 1;
+
+	while (rem) {
+		chunk = min(end & -end, (u64)1 << (fls64(rem) - 1));
+
+		if (!dma_iova_try_alloc(dev, &state[count], 0, chunk))
+			goto err_free_iova;
+
+		if (state[count].addr != end - chunk || state[count].__size != chunk)
+			goto err_free_iova;
+
+		rem -= chunk;
+		end -= chunk;
+		count++;
+	}
+
+	*iova_state = state;
+	dev->bus_dma_limit = dma_limit;
+
+	return 0;
+
+err_free_iova:
+	iris_unreserve_iova_region(dev, state);
+	dev->bus_dma_limit = dma_limit;
+
+	return ret;
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -207,6 +258,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
+	iris_unreserve_iova_region(core->dev, core->iova_state);
+
 	mutex_destroy(&core->lock);
 }
 
@@ -269,10 +322,15 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	ret = iris_reserve_iova_region(dev, &core->iova_state, IRIS_NP_RESERVE_IOVA_START,
+				       IRIS_NP_RESERVE_IOVA_SIZE);
 	if (ret)
 		return ret;
 
+	ret = v4l2_device_register(dev, &core->v4l2_dev);
+	if (ret)
+		goto err_unresv_iova_region;
+
 	ret = iris_register_video_device(core, DECODER);
 	if (ret)
 		goto err_v4l2_unreg;
@@ -306,6 +364,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_unresv_iova_region:
+	iris_unreserve_iova_region(dev, core->iova_state);
 
 	return ret;
 }

-- 
2.34.1

