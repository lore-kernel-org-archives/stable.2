Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1142DFF5
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532249; cv=none; b=EjiipfXOTbP3WpMazTe144YfVlhaOTVlt55sISBn4ET5Et8Y/yQ0kIi0awBt43zR8Q7xzMLIJPoowpVHRN5O0RIWaXYNr43Mw+AFmnuRPnvZNWHx9Hq5Ba2licv6l0u8E/FIEP4k47EXKRqiTb51qG3F3S+9nIN2yu743jTLlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532249; c=relaxed/simple;
	bh=kezCxwKujVFnkMUk4rC08TaL66oxCbXBQxapiV1nUK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLxBOv5ncdzQMz6hQV5uKFPG7J902mGk5Ml+vxvxVFzyuuH5oKfvRrRRmX1MU7bB9P3g+PZ8k1btA3AUHHWjqzr1xjSkw1GdYCMHcXOD2i5QA23gL+IftitWzx/8l8t7LskTY1vyBzOeFxhM+iMyEGPpqI1rwyz20T1xjyhYi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMDa+KCe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LPVCDLnc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMDa+KCe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LPVCDLnc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9fpcc3777822
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x02gBLy0VRXgfeuvUNzOZdb8suVquv+njmaVZIUVEBk=; b=pMDa+KCefXMLzbhd
	yJj+VaDtiItYShwaSIqX2u7/+NW4UzlzLpId9MBpZSQHX7ngKP2V+nMKpFWevjmw
	KkfiMSN9vDX81ree5UPCC3SL+z9PWa+tCYekZJnIse6CcAUvohUdkyHtx63iPLl6
	MZrtQvrju5bPv6iskP/rRQmzv75IYLW+9HSwRU17kb1RuJDXzcQrZanaG7Z39JrQ
	Ggf1THBQUkXKvXtB+F3GqNNDFWapIGAVZ6tfAESQRhssnpGs5i97CGbDu5ul2MDa
	fBNATV+OsqXO0YKWP5IY01nGesyW4Ouzs71A3zTFgWLHAO+RvrPlyc9Q0BrlcKK8
	IxKODw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucgenm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:57:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484b9fb055so2057152b3a.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786532246; x=1787137046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x02gBLy0VRXgfeuvUNzOZdb8suVquv+njmaVZIUVEBk=;
        b=LPVCDLnc4qWtAPicGIdFC4oBc+tNz85dK1EUcuvVFbtV/Sz0VduHbHhWWQMhz/P3Rn
         nhnJSjNw0sYdsNgV2h4xJNX2A1WUGH07YBrAZJOLAfrteg4eSq81VXp0eYRU/giHDiSQ
         8xEXaMzpmDs7HGVoo8udcJH0/aqYNgZ1USYqFEvkdx4fBpWISAQY5O09dH6rY/homhfQ
         Fob6kXM5YdD1Cv7kcSTVdEr1Lu6At77sjPbZmPva9+1WCK7Q/ikm+3+Nw1GsOR0vPlcQ
         CmqvTNi7E3WybojCr7fqakb4UUPDgi24ouIs45gE5YxvJsrEfo19mwL7A9oPiR246b/n
         P7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532246; x=1787137046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x02gBLy0VRXgfeuvUNzOZdb8suVquv+njmaVZIUVEBk=;
        b=crWWP2Ei4EvAARQ0kJS03az4xFIjauxP4nRsqs9/IZUerey2XbVX396GDOOq17+hIC
         xe6VWe1SXVgMmoio99K54lTQZrBe15BcDFKln3eriwUWtUscH5WZJIQsE1DiPGY6ne+/
         QgBZ03v2sMsLQPj0l0nmZc05nn2KYuN8l8wXfxNzRnb36apwrQKcq6uJcknkA2OJzXXv
         IS9+D9zhZVK2ftTv1lgoLyr+BlSAwdA4LT/R2vCxQpiGu7bKF0zBHiaCb2WU2ys3osDu
         4H5IB8aHWIY/Up34PwKrFnfWHTPzxIbaCZEQpbyco285Fp9NsUdrBTajGV+T/cUCOA8s
         5Rfg==
X-Forwarded-Encrypted: i=1; AHgh+RrBHqQE9WBAj7NrPDrKyqOuxg9WBGKFCAGMn8AQJTmJpa3nTf6w50lXVhLn9BA72rtKDRFt/BA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5sVNQYLKDtuWqkBkUqy8oqyaVqqQtgHDuOuYExdgQOv/s0NP
	SlSW43ng+2KB0D161z1mvJX29+qc5pPK8x8HonvjtyV15dlU0DLKyO1XtzPlpXhzdNV63rntgAI
	PqquZnszWQe4Cljwf30x8zyv+87i2InDb4xdllM4D2UzA31nIZkiWt65lrAg=
X-Gm-Gg: AR+sD134YrYTL+6Y+zwU/y6vcpn0bBFoOFQP7wSbz5IyIy5vfbG+dceoYO2pqyG4cE7
	1siV5oNvalxRIFmPdjhAQ/7fUTGOiNsenKhz/PwEcb4shO3HErPUJ3H+CXxbspPqSyXqsVl8gsO
	ZjsejcT9TUWdCDnXRgibNHv9jbzEYqqY0cfQZLVJJrgbBxzH7deveX1be77zZqsg0tYELeWnpcn
	TAQDsWOpsD8lkMhbsxO0xiU7q8gmghr/iOSX0b1eyCUthQNn5sTSPuiTIFwwr3gMSt8iYlQyZfB
	7lCuH6N3gNcywe5fB4wX3sEF6kMOfhfqxCJ4u6/4Dvks0NdEu6QJzXua148syJx9X7GPsV+QCYE
	+VRwrC0rrDljLPjO3rR7dA1FVU/secfvCEw==
X-Received: by 2002:a05:6a00:1910:b0:848:56d4:3288 with SMTP id d2e1a72fcca58-84fb53c1f77mr4459328b3a.4.1786532246156;
        Wed, 12 Aug 2026 03:57:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:1910:b0:848:56d4:3288 with SMTP id d2e1a72fcca58-84fb53c1f77mr4459291b3a.4.1786532245714;
        Wed, 12 Aug 2026 03:57:25 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1d22247sm884301b3a.15.2026.08.12.03.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:57:25 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 16:25:58 +0530
Subject: [PATCH 1/2] media: iris: Fix iova allocation from restrict region
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-reserve_iova_in_driver-v1-1-ed62f801275c@oss.qualcomm.com>
References: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
In-Reply-To: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786532236; l=6825;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=kezCxwKujVFnkMUk4rC08TaL66oxCbXBQxapiV1nUK8=;
 b=oijVYccHHkemEt1Pmc9kwYcAW9mO/AQLofcMdPpxa+xzwCOOK69KK/yTJsizc2DiDOx04ATOW
 bNp3i/Y/O8xD8CkZZfyWVfOnIbm2zd8UM9R1Yuc2zqLr62bAI5B6lI1
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: LJAhMn7xNj-Fs7evSI55hcCwbxzLd6Z5
X-Proofpoint-ORIG-GUID: LJAhMn7xNj-Fs7evSI55hcCwbxzLd6Z5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4OCBTYWx0ZWRfX98KQ95mJ/dRG
 GZcHn98kvkJVoHSgXyfQLqb4nrNbABPZKWtlLvLbTmOIQF4//+7lwNkC0udCaQVb0ZyFAxGobJR
 l5s8wInPohBVVq0btYiGN9x+UhL749yDHH/+oT9vjUsOTMEeyGsDh4dFHBEn2HzhIgHkPwe+gN1
 bIJfi7AcPGUCXi2y2797rUwOypaqYhMI2SzGyjyfG0p7On5Si0pvErxSUeYGYBSlqiM3viIYH2k
 9VOEcnaotCQgeAQqBRM9x2QWUiPDfshN8aYpssai9wgujkNzXHbgpegPYbiY7QCFvO0syMGZ+lS
 yLMz20igKaPKbakcmNZmG6nEKlBBOVH3AmFiWg+P9FZZd5muX58SoqSJvUVpwcv0Kw7MOt4ouKU
 Od7WmHXbC7oB9Jln4D02VBCR9tzlOgihnwUKe38jcF4I9GTFKw1Vn1vxUK+EDIvwjMkVtF7clQR
 yJn+iJlZZle6y8YPOhA==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c5197 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dm53AvHgw1VIgxztvNkA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4OCBTYWx0ZWRfX+ShPNTIDoYh0
 5Meyvy8BwPqo1klgh28DRD7nT+TfY1y8bHuY/xsNbWD+dtdll3iJoPUFWKMgYPK+S7rgURPvps9
 fpx8LvV+mX5PRbcgVgDJvJ1MBcGaUXg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120088

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
in one IOMMU domain sharing one IOVA allocator, so nothing restricts a
non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below that
boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots.
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

A series to reserve the 0-600MB IOVA range via "iommu-addresses" was
already posted here:
https://lore.kernel.org/all/20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com

Those changes involve DT binding and DT node changes, and discussion is
still ongoing on how to handle those for stable and for the upcoming
sub-node design, with no conclusion reached yet. Thereby a critical reset
issue is still open.

This is an alternate solution to fix the unhandled SMMU page fault
by restricting the IOVA range in the video driver, which also makes it
easier and faster to land on mainline and stable kernels. At the same
time the patch only reserves in the IOVA space without allocating
any physical memory.

Currently sub-nodes are not yet present, and only a single device is
available, so the restriction is applied to both non-pixel and pixel
stream IDs. This makes the solution unoptimal while fixing the issue
considering all scenarios.
Once sub-nodes for non-pixel, pixel, and secure streams become available,
the restriction can be made stream specific.

Fixes: d7378f84e94e ("media: iris: introduce iris core state management with shared queues")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h  |  6 +++
 drivers/media/platform/qcom/iris/iris_probe.c | 69 ++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 24da60448cf2..79bc342a25a2 100644
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
+ * @iova_state: an array of dma_iova_state entries reserved for the restricted IOVA region
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
index e4acf4a74f94..f44305ee81b6 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -150,6 +150,64 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static int iris_reserve_iova_region(struct device *dev, struct dma_iova_state **iova_state,
+				    unsigned long start, unsigned long size)
+{
+	unsigned long mask = dma_get_mask(dev);
+	unsigned long end, rem, chunk;
+	struct dma_iova_state *state;
+	unsigned int count = 0;
+	int ret;
+
+	state = kcalloc(BITS_PER_TYPE(dma_addr_t) + 1, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	end = start + size;
+	rem = end - max(start, PAGE_SIZE);
+
+	ret = dma_set_mask_and_coherent(dev, end - 1);
+	if (ret)
+		goto err_free_mem;
+
+	while (rem) {
+		chunk = min(end & -end, (u64)1 << (fls64(rem) - 1));
+
+		if (!dma_iova_try_alloc(dev, &state[count], 0, chunk)) {
+			ret = -ENOMEM;
+			goto err_free_iova;
+		}
+
+		rem -= chunk;
+		end -= chunk;
+		count++;
+	}
+
+	*iova_state = state;
+	dma_set_mask_and_coherent(dev, mask);
+
+	return 0;
+
+err_free_iova:
+	while (count--)
+		dma_iova_free(dev, &state[count]);
+	dma_set_mask_and_coherent(dev, mask);
+err_free_mem:
+	kfree(state);
+
+	return ret;
+}
+
+static void iris_unreserve_iova_region(struct device *dev, struct dma_iova_state *iova_state)
+{
+	unsigned int i;
+
+	for (i = 0; dma_iova_size(&iova_state[i]); i++)
+		dma_iova_free(dev, &iova_state[i]);
+
+	kfree(iova_state);
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -207,6 +265,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
+	iris_unreserve_iova_region(core->dev, core->iova_state);
+
 	mutex_destroy(&core->lock);
 }
 
@@ -292,14 +352,21 @@ static int iris_probe(struct platform_device *pdev)
 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
 
+	ret = iris_reserve_iova_region(dev, &core->iova_state, IRIS_NP_RESERVE_IOVA_START,
+				       IRIS_NP_RESERVE_IOVA_SIZE);
+	if (ret)
+		goto err_vdev_unreg_enc;
+
 	pm_runtime_set_autosuspend_delay(core->dev, AUTOSUSPEND_DELAY_VALUE);
 	pm_runtime_use_autosuspend(core->dev);
 	ret = devm_pm_runtime_enable(core->dev);
 	if (ret)
-		goto err_vdev_unreg_enc;
+		goto err_unresv_iova_region;
 
 	return 0;
 
+err_unresv_iova_region:
+	iris_unreserve_iova_region(dev, core->iova_state);
 err_vdev_unreg_enc:
 	video_unregister_device(core->vdev_enc);
 err_vdev_unreg_dec:

-- 
2.34.1

