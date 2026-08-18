Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBF451980
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066042; cv=none; b=Jnt1AbcEdRJxYlSsJxfMuTSt60gBqP+8itngLOu5XuyfN/or4WpXWT0f4UJAqtQzETyu4FxvTxoRPsROOHVLqStU0X/7hYjZGj7HKeaoSs19T74vfB/f95eZknIQrA778QoKIl+APuOVhMiWCCD9oKYxzTXKxnirC+OhH+CGCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066042; c=relaxed/simple;
	bh=D2to+qdFUJIyRn0gO0bPSz/9KSto6nc1kDi6S4cQSCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tj8dX80rImSE8It/ajDL9/LHaN89uTs4vV2nTQHljJh5iMKfCNlNBbGalqlY4j+0Z6PsFDjFqo4rRifmVs15pHzzuIsMtLiHhNHdMUUmB0x7TeqKb0o3c52q6pafNakUsC7AJh8azcG/eSPF89RgsuS7OQAiM20jn1cq/l4qPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3fiog3g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bmexIi81; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3fiog3g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bmexIi81"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IElqhf2157121
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wCtpXxUQCEA8WhSXbgymO2TVAaU6id4xxMyC/S5YYf4=; b=Z3fiog3gpR5J63/e
	7CCWAel77dlY9WkrBJ+wpdtWVpbQEyxFPQBS7AlcOKqsQnzrb0VTKpVQRCOXx6Ja
	K0BiGsqhouF5lBpY1Vq84i5y9xfjf73D6YirN3nMwgXEsb47IBhj5J0PU1uOImQ/
	S+ic7msXJsBNo/4F4aGJvMc2LHNKMVx8phj5zTXIgCzv0js9KNuS2DGSJwUVkPsQ
	6BhrOqQJEvoMJfIjYJc4pcn4OTV2Op3KgJfX3uKzw7ziIWf5nnTJD092lhFw/V5j
	8/JXzjk82bl28WYDIep2rXpg5mUeB+J6YhxUABqC7KWwG8GxzDA88F7ZN9yPukVx
	huKIZg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfng5eh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:14:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930a098ea19so663929185a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787066039; x=1787670839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wCtpXxUQCEA8WhSXbgymO2TVAaU6id4xxMyC/S5YYf4=;
        b=bmexIi81xSeEPhKngnOQsFHhTLLCE/jcYOvLwXd0RWQu1o2blqL/0zIV3TSjXVttQW
         6I4ktV8sBOr+6fqoIpIrly49/kVa39ujWJqmKsYRSZBThz//dEMzLxZfRi8altcDsYjM
         WN1pbaxEt6dphGRaClcSa5xGw5ANZKYEPykijgXlC81xqXGLMgkRGqnUxHq8/6xtjVLw
         5RorqDHFwC3Cv8VPioSuxwMoYLFBIsm2rub77cdjzEtnQBemY5Ri7TIn3Eo7d6jR1nVN
         MuPOSHHI8wg1/PE+BTRbFUpz8ZIWI116/dVGSj6cEtrbbtmDzaWQxXeGE8YOKyx7ZdHp
         DbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787066039; x=1787670839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCtpXxUQCEA8WhSXbgymO2TVAaU6id4xxMyC/S5YYf4=;
        b=mqhTvkg6Z8SInkzdwe5HUTy+YswWKrT8CBhKAtCU8n2YZfRct2jCJWaGkTV8Yh5ogX
         Y1H6dmjLLOgG0vJxhdiU1KKm6WrE04vuJiQPJhh1T7AGmenItPyIv/ww6Jnk68I6CElx
         f7Z03Hyv6s/c8W2GbnfcL0vDMNgS2tAA6FFviJbAFnAv24zHQPNWuzIpVsJIewDK07P7
         HHl01hlHUIkOgbwnfwUeZyBs2X+BjvujM4/3KfRwUKT6nsgr8lDm5nU1u0QhhF9wZY+B
         Z+1OkA3MCtXF1aZ2kDRIRv30Sfl9goUk8PiFCiGMCwsPIVMbV1F3BfkTUFGkpthtH8kI
         I1Zg==
X-Forwarded-Encrypted: i=1; AHgh+RqtcDDznq/CLKpEfar3b6SpHcTfBbliWowhjAnnmDQhVAHIhKS95lMixlqbOCuoYV5OfJpnf6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkrLy2Ot4lqjoA79gvIOjQFzlevc0LbEs0phgS8gBM+y0E0xI
	4I7ooirSm5BXEBpsEzpRYugqdepCs58ZYM7gW2a6dWRvAl87ZScxMIQ/11C9EZFBuUd0VEJaNPZ
	7RY5suCx8wTh23eBSUvP2CDBm5aBX7al1ZH0kthafL2XWoH2weZrHjOU8nEI=
X-Gm-Gg: AR+sD12BSuLZNXqz8ixyGUV7/OoxZYxfOTuSZVYFrMIcgpYnJAudOOVVEowFQ0vNPtE
	skuSYYawOE6GGzNJOWjqDIt2a4H8NiztPQP1zSd93H9Dw7Mr6jWlcUayGTA5Rc90ySqZzMyH4D9
	kf1ncGxsNAUDnHcjx+1vlZKduudrRxNciCopSmu/+IrRtYzSzJQR29S+x5STQQUYHoJtDCaTM4R
	gj3jdMcCKSdQY3xASKyU/LFNeoEn0a6qyIuFscXFkfUm6a6mnXzBbBffRybtt3CNGJSHYyTZ3cI
	Ytztm7VZagoGbdOjYagd1ML0fD2ZsPuTz1/6J99q8Vu/rCsdniXeSCwcUwkrhjssMr83oXEnEYt
	AkiMgMMk6ZTglWDK3vvR+rD3T7vFk4W35HQ==
X-Received: by 2002:a05:620a:72b4:b0:936:cae6:5869 with SMTP id af79cd13be357-936d23607b3mr2667722585a.46.1787066039414;
        Tue, 18 Aug 2026 08:13:59 -0700 (PDT)
X-Received: by 2002:a05:620a:72b4:b0:936:cae6:5869 with SMTP id af79cd13be357-936d23607b3mr2667716085a.46.1787066038938;
        Tue, 18 Aug 2026 08:13:58 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3158asm13111105f8f.7.2026.08.18.08.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:13:58 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 20:43:23 +0530
Subject: [PATCH v2 2/2] media: venus: Fix iova allocation from restrict
 region
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-reserve_iova_in_driver-v2-2-5005a1154408@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787066016; l=6186;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=D2to+qdFUJIyRn0gO0bPSz/9KSto6nc1kDi6S4cQSCE=;
 b=cyF1gI48/ejxw8jwVxPUy8tI2Ux5AK3JwWjAy26p2TYMCW0mMm9/FvQMBKK8/xEypMGQL5emd
 12WCyoQ1hpzCOtGk6jBKOWbDfOiq49P2gCIEThD+m9GwEPN7No7nqNc
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExMiBTYWx0ZWRfX70gBcTBJp1Sr
 vKtDCut46A2mi8J2ENPqzO9UzBtJ/RAXbBftB0JBevPtJxLMJ9FTMlyLCd3Ur31ezw/vYMNq99O
 d15oEv7klYojUz7k32HZRv3BcxCusQs=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a8476b8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qCMCQjtVS-vTbDhzrxIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: bjIfSHA0JhhWN4Rp8owpaYa28kfa9ab0
X-Proofpoint-GUID: bjIfSHA0JhhWN4Rp8owpaYa28kfa9ab0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExMiBTYWx0ZWRfX6BiEQbMorrnp
 9sl1BIdOIfBKgafjqEMg1n+UyEdvq3l6JtEoEYsokfSKbQvTL3KepXM7O9js7D73Ak6VUaCx2/T
 dCK5ZeImFLewt2mVtlpEe0xnsm6ZNqEzmfeoINE5rHUn3yM3NAhSQvybtU/46+kVroJF8nOkZY+
 REfltEkFxYE8LI/7AksU+KLTRaMf1wOzav9dAMzTkHYsKR6IqDRScFuSQ3GuFRfAaU4jO9sbv6/
 vLNqKS595STL1vVJKCD60ZogSMuZ1ip3eNYIi5r9TiKNrJ1l0XTC9Po1cdzoTFOQNm8YFfQn/M6
 dm2ok51Z/g4OWQWzWJRgreKAYObg7+3cIGC728FO8kTuYKqaOOxuaIz2Uor5ok02z0lc4Gy3Isr
 WmkEhbbH3h7phKiujvdhLTFNNtrW2QsNcdI/u5WAqYKrzkMR4us1pKFmIzRf9ho+gY8hhFSi4PA
 Lm5y4hy23HxwBBx9ZPw==
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

Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/core.c | 66 ++++++++++++++++++++++++++++++--
 drivers/media/platform/qcom/venus/core.h |  5 +++
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 243e342b0ae7..2a0ab553c451 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -377,6 +377,57 @@ static int venus_add_dynamic_nodes(struct venus_core *core)
 static void venus_remove_dynamic_nodes(struct venus_core *core) {}
 #endif
 
+static void venus_unreserve_iova_region(struct device *dev, struct dma_iova_state *state)
+{
+	unsigned int i;
+
+	for (i = 0; dma_iova_size(&state[i]); i++)
+		dma_iova_free(dev, &state[i]);
+}
+
+static int venus_reserve_iova_region(struct device *dev, struct dma_iova_state **iova_state,
+				     unsigned long start, unsigned long size)
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
+	venus_unreserve_iova_region(dev, state);
+	dev->bus_dma_limit = dma_limit;
+
+	return ret;
+}
+
 static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -421,10 +472,15 @@ static int venus_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
+	ret = venus_reserve_iova_region(dev, &core->iova_state, VENUS_NP_RESERVE_IOVA_START,
+					VENUS_NP_RESERVE_IOVA_SIZE);
 	if (ret)
 		goto err_core_put;
 
+	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
+	if (ret)
+		goto err_unresv_iova_region;
+
 	dma_set_max_seg_size(dev, UINT_MAX);
 
 	INIT_LIST_HEAD(&core->instances);
@@ -434,13 +490,13 @@ static int venus_probe(struct platform_device *pdev)
 
 	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
-		goto err_core_put;
+		goto err_unresv_iova_region;
 
 	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"venus", core);
 	if (ret)
-		goto err_core_put;
+		goto err_unresv_iova_region;
 
 	venus_assign_register_offsets(core);
 
@@ -525,6 +581,8 @@ static int venus_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&core->v4l2_dev);
 err_hfi_destroy:
 	hfi_destroy(core);
+err_unresv_iova_region:
+	venus_unreserve_iova_region(dev, core->iova_state);
 err_core_put:
 	if (core->pm_ops->core_put)
 		core->pm_ops->core_put(core);
@@ -562,6 +620,8 @@ static void venus_remove(struct platform_device *pdev)
 
 	hfi_destroy(core);
 
+	venus_unreserve_iova_region(dev, core->iova_state);
+
 	mutex_destroy(&core->pm_lock);
 	mutex_destroy(&core->lock);
 	venus_dbgfs_deinit(core);
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 46705a666776..30b8cababe86 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -8,6 +8,7 @@
 #define __VENUS_CORE_H_
 
 #include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 #include <linux/list.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-ctrls.h>
@@ -30,6 +31,9 @@
 
 #define VENUS_MAX_FPS			240
 
+#define VENUS_NP_RESERVE_IOVA_START	0x0
+#define VENUS_NP_RESERVE_IOVA_SIZE	0x25800000
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
@@ -250,6 +254,7 @@ struct venus_core {
 	unsigned long dump_core;
 	struct of_changeset *ocs;
 	bool hwmode_dev;
+	struct dma_iova_state *iova_state;
 };
 
 struct vdec_controls {

-- 
2.34.1

