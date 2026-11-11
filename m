Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387968;
	b=A4J+JfDhjbu33x8zfZEaUcci803SA4Kky6gJybwrM7CrN6yhD8Oy+9JIDPHm7ui4SzJf
	 wvUl5uvAMUrvdhNOGNgshvHp9B5pboNZYu/vu8o41jNKG4Nn3bowUCYU3bJ0p3kHJzbu+
	 6z7t+pmd6fWx7gMJA7oNTfHZ4y6boRxuQfCbG9MqHaF4r1hL6ISu9WDmcLc5qFs3VjiDj
	 uGeJL/e1lEwus0IV1BlfgN8OSfhw+qqZYfxaBRy4Eb90F033cgySPiy7r+R12rAeycaV/
	 qhpbDrMeGvEomekbAPm+bkcr7At5V6+dfPyfoubW1EF9W3TFNAp+F2vyMI3N1SFAEiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=c2+O61po/qgeRZ/vxjbjMcpizHGeOeHqiFLuuqZeIwM=;
	b=F96ktulU3EGSMttDcmin4OG4+pllD8eFJ6xUCMbOdk2z6fF9P3SNE9osWXHQNJ2HzUFu
	 5v8P6SaY+vWcjBCMrTY1zZVqIdSneYio7ujQxZW8P05j06RHEZe9u7CUe78077L1Zjrll
	 RfUYTaVcYZArR1ENek7TAVI7jmBo/27M8giZdzj04quzeYbP/RGWaE81hnX8inSmeJGc3
	 JOnEqCm9JrCqnFfvb1TVp/2L+G4lzBu2HWjgmy5wYpkpFJH1KfnW4iHboH/JHZxKnL3Rz
	 UEDFhKD/cViAaZvi1w+Ec0OOPC8MAsEmutG5H9ZPoJg4dUaIj1SGG73r1cuOHfkbeJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=anEqYTPa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AeVfdIhl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A8606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED4A8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=anEqYTPa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AeVfdIhl
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5Kago864255
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c2+O61po/qgeRZ/vxjbjMcpizHGeOeHqiFLuuqZeIwM=; b=anEqYTPaWIqAkDRu
	6S7fHNjqfSWpLouJSWMnbgusPQ7MalNnFBqYofreoGsTUOVpK26AjA6QvBmYJntX
	lKslOP8aF4LM1tXEQD3ZM/xhR+ppVNhOW4QzXw5O8Px6WMHHv/2aHKQ+SNp8VI13
	ZEK0ob2yQjc5F0UemqDvB4DxfMMzdsgLAE3VLRxTutrDwKMXbFYkZJPitxpSbjTz
	K7gVue75K6WrNdbdp8a6vxacH0iktiEcAWc/Xw+GSHRo+hiQzr+hnP4BJ0xxbKrW
	kVNJM8DIRDC2gEOJlA7oyIkuCVZCwZZqTFKH+rOB2sn9nwcpIV1S/UrHa0YwpzIA
	Re/bOg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawhd9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3425098ae4bso554317eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794387966; x=1794992766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2+O61po/qgeRZ/vxjbjMcpizHGeOeHqiFLuuqZeIwM=;
        b=AeVfdIhl4f6jjKCxjRfq8OvMI8tKLLBFZ5uOn1KWTS31+ygzwkvP1Mkp3j29hfn4dv
         n1vqLGcpLz9kX58pl5xi6UVHQHUzBcI35IOuWnbGJvbywirgYgd1t1VNa+3PGel5LFFr
         v5R4Ij/h5l0KmVgv6lRL9J6Jd++boaynsHAy3n67dPZ/f4V39Sh7p74hpwawqrcmwlwS
         VhHmYjm0Sc7bK8RDqBQsg+0uBH4TFeeFX1p7y12Ti2/7Pea6moLX/fnVl6gp6dba6Oct
         J419ecW7c46bzH8zglzOtWpwJpJQXIiNEOMI3x4Yze6nVMFVvopObZ1uexnSc+gKnvq1
         5f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387966; x=1794992766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2+O61po/qgeRZ/vxjbjMcpizHGeOeHqiFLuuqZeIwM=;
        b=lC4LscipIqBV5jrn1PJP7revD9XE12lI7OcYxcAnvzCJKfq2GQBhkfJdMCmd8nD8jL
         wcxTgTIzRKld1uKCrpYOSvc7U2dbDw9tW66uU0XgZcOmro1GBmENDmKhmwnRZB4sZ7ao
         UVu6s53LIdTAa8Pyz/ljA+i9eVZDJiOWNK4heMafTd1vseVL6VEIJyzTK3iJFZxLEUE9
         omztxhWNlKAA/UqTKnTyw3cTXkXVctGY8BHxMxyfCpeWZhhVo38subu9pvamNP1Fp1yl
         4jVB4axNbV/FOPYhe5DpXt1s70CIiN3Qs987eM0AQSkmltQmblQgcAhGiwkPT918rDu7
         TfHA==
X-Forwarded-Encrypted: i=1; AL+hErFke61JmDCVUO5dXfdRs+xRlv9j3Ja/P/oT18l6AAbQ2dCzVxGY2Von4vuN+Ve4vfl0GeQPR6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sYq6l4SXqJDZ0TMF4zW0q34cDGCerR2StSR9NJuLT9HK9OmZK
	3GuXjuEoH/v2LVmtyB43coHxr95D4vVobAh+hhFMYA62RuGyNxLXjxe36YcAwbGoTWFvj39rGWp
	WTr9SKVmCReFaIDhRotRvshGzJ8mmI1FO2/D0xVeoOGpYfnaHZZ0xmcbU1Y0=
X-Gm-Gg: AYBFou0KgDzWuH2AfNrTEmAUoUtUgg1T7kVwI+cZRRCis1Gysm84SfOPHidojveiVxI
	4ehaVTEceu1B+1xd4NZP33X5C8pkDWQN20vydgV8ek/01yh80vPlF6712HKbOUhC41Ye3k5L6pP
	XvaGk+cFRu9udFijrUgYaM6jIhbldayAQdFJIO/F4c/M8h+4cseT9xM3qp1BZvFRlk2Fyz720Yo
	BS9Pt2n2ZmKJXHOebbMLhwjh6IKZ+Fr167y5xx8rbeCE7f9BvQYjof4qbOub2qgFSvcJr5QOL9v
	OoFGDnrKu9ViPa6fHFp+76VVCMLimp9cUGU6RV3PyBAzYdaYi3ZmZqoMu7moRSP/Hb8CxhcsK7U
	3tx+6qOEBeqra2uuGDREouhEyN3mNEvjZANR1jry/31ybg0SlHbBd6BhdQ4Z7Cyrho1TbAR+7bv
	TrQeA+KA==
X-Received: by 2002:a05:7022:ea8d:b0:1b3:ad6d:c806 with SMTP id a92af1059eb24-1b3bef38a68mr2414206c88.18.1794387966189;
        Wed, 11 Nov 2026 01:06:06 -0800 (PST)
X-Received: by 2002:a05:7022:ea8d:b0:1b3:ad6d:c806 with SMTP id a92af1059eb24-1b3bef38a68mr2414174c88.18.1794387965515;
        Wed, 11 Nov 2026 01:06:05 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm16915277c88.11.2026.11.11.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:06:05 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:35:15 +0530
Subject: [PATCH v2 2/3] media: qcom: iris: Wait for threaded IRQ completion
 during power-off
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-fix-disable-irq-safely-v2-2-8e13f68c2ef9@oss.qualcomm.com>
References: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
In-Reply-To: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org,
        Joonhoe Kim <26rote@gmail.com>, Birk Skyum <birk.skyum@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794387948; l=8457;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ie7piPfDXDS8UR9BP5QVkzgHcWgnEpckhaDMrLITMUk=;
 b=WMFlJ9pQcQuN6MDm0oNa7PR1u2pOZb6FAJRJwqMhDwlTSbLUgrfbc5knmbdVhNDdBsSFYqcff
 ixmllaD8hjPDjv9DloR+v19NcuLaE+RbojjmMwomdv4kG3NAJUaxwEl
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfX6Gc5lL6zjyN5
 tDL2YhKDfRT3H93Npnvhz+lJf2S2tqXhnIpglW8tCa68421uAyFz8wn+86pJW+W4430hYQ/BKmw
 5qzTyN4Dv/mLZ/xCVlsaSY5+8obJoqU=
X-Proofpoint-ORIG-GUID: -fPg3Z0FLkTig8Z-NSsPhjPWGCVa4JiA
X-Proofpoint-GUID: -fPg3Z0FLkTig8Z-NSsPhjPWGCVa4JiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfXzOP9iAQSwcYh
 rvSD8V5ZyEO0QZA/LjCHP88vllKKMNsszQyaerPaQuQSTgcww578byzePJxxSIM/d+mEW6joyXO
 HXgaxon/m0H4q5xwkK4B5NYr3WSnSno5m+yYsIvWN3x6ZlF7Y/sSV0OmJpSxADHIP3aQTVwvQJ3
 csOKXgn3LYXU5OEQsGMZiF2XFQFmgwiRWhk6oQQnpPiyWEF6lQUNpHYX0es/VmK5v24FmvPDcF+
 n/NT/chhkwjhSiChKn9uuJQGe3bL7oHHwrS5u7ulSgtBP+t7dMMGiJ7mG9DFZNCJcay+a4W2yi4
 oC3fL059RuB5rX5A8qYqkYTgxtX3dy1yCPBbDFQCbs7Q7CQC7gMKUpY/YgjD7rBTY+WjAkfashZ
 ljk19I/xW734MY5B3zwjJOxS0BAvTFAI24HCdw7WusLrn54F1wt7vxqx7UGJr5yNT8HmCw6DTMa
 s9WHNu+2atDza40qURg==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af42fff cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=m_RbpQ2zxIAPIIsuggwA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110036

The VPU power-off path calls disable_irq_nosync() after powering down the
hardware, allowing a pending threaded IRQ handler to access powered-off
hardware. Switch to disable_irq() so that any in-flight threaded IRQ
handler completes before power is removed.

However, disable_irq() waits for the threaded IRQ handler to complete,
while the handler requires core->lock to proceed. Since the caller of
iris_vpu_power_off() holds core->lock, calling disable_irq() directly can
deadlock if the IRQ handler is queued and waiting for the same lock.
Release core->lock before calling disable_irq() and reacquire it after the
handler completes. Introduce an irq_disabling flag and waitqueue to
serialize concurrent power management operations while the core->lock is
released.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Tested-by: Joonhoe Kim <26rote@gmail.com> # Kaanapali
Tested-by: Birk Skyum <birk.skyum@pm.me> # Lenovo Yoga Slim 7x (X1E80100)
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.c       | 10 +++++-----
 drivers/media/platform/qcom/iris/iris_core.h       |  5 +++++
 drivers/media/platform/qcom/iris/iris_probe.c      |  9 +++++----
 drivers/media/platform/qcom/iris/iris_resources.c  | 16 ++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h  |  2 ++
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 16 +++++++++++++---
 6 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.c b/drivers/media/platform/qcom/iris/iris_core.c
index d558475986ff0..f81fb6d42557d 100644
--- a/drivers/media/platform/qcom/iris/iris_core.c
+++ b/drivers/media/platform/qcom/iris/iris_core.c
@@ -17,7 +17,7 @@ void iris_core_deinit(struct iris_core *core)
 
 	ret = pm_runtime_resume_and_get(core->dev);
 
-	mutex_lock(&core->lock);
+	iris_acquire_core_lock(core);
 	if (core->state != IRIS_CORE_DEINIT) {
 		iris_fw_unload(core);
 
@@ -27,7 +27,7 @@ void iris_core_deinit(struct iris_core *core)
 		iris_hfi_queues_deinit(core);
 		core->state = IRIS_CORE_DEINIT;
 	}
-	mutex_unlock(&core->lock);
+	iris_release_core_lock(core);
 
 	if (!ret)
 		pm_runtime_put_sync(core->dev);
@@ -55,7 +55,7 @@ int iris_core_init(struct iris_core *core)
 	const struct vpu_ops *vpu_ops = core->iris_platform_data->vpu_ops;
 	int ret;
 
-	mutex_lock(&core->lock);
+	iris_acquire_core_lock(core);
 	if (core->state == IRIS_CORE_INIT) {
 		ret = 0;
 		goto exit;
@@ -96,7 +96,7 @@ int iris_core_init(struct iris_core *core)
 	if (ret)
 		goto error_unload_fw;
 
-	mutex_unlock(&core->lock);
+	iris_release_core_lock(core);
 
 	return iris_wait_for_system_response(core);
 
@@ -109,7 +109,7 @@ int iris_core_init(struct iris_core *core)
 error:
 	core->state = IRIS_CORE_DEINIT;
 exit:
-	mutex_unlock(&core->lock);
+	iris_release_core_lock(core);
 
 	return ret;
 }
diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 3e4cf652bf39a..0b1b9721e6f9a 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_domain.h>
 #include <media/v4l2-device.h>
+#include <linux/wait.h>
 
 #include "iris_hfi_common.h"
 #include "iris_hfi_queue.h"
@@ -70,6 +71,8 @@ struct qcom_ubwc_cfg_data;
  * @message_queue: shared interface queue to receive responses from firmware
  * @debug_queue: shared interface queue to receive debug info from firmware
  * @lock: a lock for this strucure
+ * @irq_disabling: flag to indicate an IRQ-disable is in-progress
+ * @irq_disable_waitqueue: waitqueue to wait for the IRQ-disable to complete
  * @response_packet: a pointer to response packet from fw to driver
  * @header_id: id of packet header
  * @packet_id: id of packet
@@ -116,6 +119,8 @@ struct iris_core {
 	struct iris_iface_q_info		message_queue;
 	struct iris_iface_q_info		debug_queue;
 	struct mutex				lock; /* lock for core related operations */
+	bool					irq_disabling;
+	wait_queue_head_t			irq_disable_waitqueue;
 	u8					*response_packet;
 	u32					header_id;
 	u32					packet_id;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 343e44c6b9c46..f6684ce09334f 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -288,6 +288,7 @@ static int iris_probe(struct platform_device *pdev)
 
 	core->state = IRIS_CORE_DEINIT;
 	mutex_init(&core->lock);
+	init_waitqueue_head(&core->irq_disable_waitqueue);
 	init_completion(&core->core_init_done);
 
 	core->response_packet = devm_kzalloc(core->dev, IFACEQ_CORE_PKT_SIZE, GFP_KERNEL);
@@ -379,14 +380,14 @@ static int __maybe_unused iris_pm_suspend(struct device *dev)
 
 	core = dev_get_drvdata(dev);
 
-	mutex_lock(&core->lock);
+	iris_acquire_core_lock(core);
 	if (core->state != IRIS_CORE_INIT)
 		goto exit;
 
 	ret = iris_hfi_pm_suspend(core);
 
 exit:
-	mutex_unlock(&core->lock);
+	iris_release_core_lock(core);
 
 	return ret;
 }
@@ -398,7 +399,7 @@ static int __maybe_unused iris_pm_resume(struct device *dev)
 
 	core = dev_get_drvdata(dev);
 
-	mutex_lock(&core->lock);
+	iris_acquire_core_lock(core);
 	if (core->state != IRIS_CORE_INIT)
 		goto exit;
 
@@ -406,7 +407,7 @@ static int __maybe_unused iris_pm_resume(struct device *dev)
 	pm_runtime_mark_last_busy(core->dev);
 
 exit:
-	mutex_unlock(&core->lock);
+	iris_release_core_lock(core);
 
 	return ret;
 }
diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 883ef7e752915..6c92857a6b8eb 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -16,6 +16,22 @@
 
 #define BW_THRESHOLD 50000
 
+void iris_acquire_core_lock(struct iris_core *core)
+{
+	mutex_lock(&core->lock);
+
+	while (READ_ONCE(core->irq_disabling)) {
+		mutex_unlock(&core->lock);
+		wait_event(core->irq_disable_waitqueue, !READ_ONCE(core->irq_disabling));
+		mutex_lock(&core->lock);
+	}
+}
+
+void iris_release_core_lock(struct iris_core *core)
+{
+	mutex_unlock(&core->lock);
+}
+
 int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw)
 {
 	u32 icc_ib_multiplier = core->iris_platform_data->icc_ib_multiplier;
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index 6bfbd2dc6db09..6e1a5e734925f 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -8,6 +8,8 @@
 
 struct iris_core;
 
+void iris_acquire_core_lock(struct iris_core *core);
+void iris_release_core_lock(struct iris_core *core);
 int iris_opp_set_rate(struct device *dev, unsigned long freq);
 int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev);
 int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev);
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 1e183fc4e58ce..fcf060a72c4cf 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -232,15 +232,25 @@ void iris_vpu_power_off_hw(struct iris_core *core)
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 }
 
+static void iris_vpu_disable_irq(struct iris_core *core)
+{
+	WRITE_ONCE(core->irq_disabling, true);
+	mutex_unlock(&core->lock);
+	disable_irq(core->irq);
+	mutex_lock(&core->lock);
+	WRITE_ONCE(core->irq_disabling, false);
+	wake_up_all(&core->irq_disable_waitqueue);
+}
+
 void iris_vpu_power_off(struct iris_core *core)
 {
+	if (!iris_vpu_watchdog(core, core->intr_status))
+		iris_vpu_disable_irq(core);
+
 	iris_opp_set_rate(core->dev, 0);
 	core->iris_platform_data->vpu_ops->power_off_hw(core);
 	core->iris_platform_data->vpu_ops->power_off_controller(core);
 	iris_unset_icc_bw(core);
-
-	if (!iris_vpu_watchdog(core, core->intr_status))
-		disable_irq_nosync(core->irq);
 }
 
 int iris_vpu_power_on_controller(struct iris_core *core)

-- 
2.34.1

