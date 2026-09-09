Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4C463B8C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943970; cv=none; b=qA716RxPZ9VGyRWlr1/1MHVKm3VWaBIw8oVejh7G6BBLP0+HT+Rn759sEY91ClE2T+GnbP6kF9V83Xq+P5O/QCz1VVBGK8RAdhhKL+1EK51BOa5z/LMGWj/PHjc7i3VQP9VD4Zn1bAeswIZZLCQtKgeK7YA3pDjC7w7EAe8RGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943970; c=relaxed/simple;
	bh=gE/eMmtioKrFG7+ooQ1VCIdr8s9ekUKmcIp2HA5Rzhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=On9s/9kTcVSsKKHVC5ZJKaMSirPxvlNvnwIUWIgrMS0orjAelkABCzgWFZ/HiSZFGpW+BKrY+cVdhS1p7rhvHthJFDsrJGWb2UW1D6COE4YaC6hKGtzPEYF/ATAMzxZzloAoZXl+DdGXN75T+qtMoOLp5iIwnDZ5BPgpZUeprm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K2AbGff/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvZAEMlW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2AbGff/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvZAEMlW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896kmU5045553
	for <stable@vger.kernel.org>; Wed, 9 Sep 2026 08:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3qOQRcdHXy4zUHj08w48xO
	+e1/T7rRogcnaSwA9ymUk=; b=K2AbGff/L7CH/CuxqoTkt/7eCNSTPg0YmdznfY
	iFEDEqSUubX3JxMTuobDyT7I2xUhsNIUM7LsgCs0RTaYpUQykUCwxAhtMi5CZ1nO
	03q/BaOps669d6T/7IXwb3s0teeI02+owFVz9DKnZoSZ1PIKfwZrxBN3nr0aEd1+
	BOYg3Rb1OOfF2UZ8k4wwCodcaBd4BG8WD2KpAlymSEpvboMSolNHkX0QGo5rdOcv
	rXaajteRWtxSoIM1kI1QiC6nI8ZafXqglAxrGgYSRSXyyG1D6wEPBbhMhRlZcay3
	R+Yqs3YbIOiUPy0Yz4wkQ6S8G5gKKHjpPclXFNvJEyzExgxg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqewk2pd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:52:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39af306c795so1027885a91.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788943962; x=1789548762; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3qOQRcdHXy4zUHj08w48xO+e1/T7rRogcnaSwA9ymUk=;
        b=kvZAEMlWsau0NfR73PJFTU/DCejDK2rvq4k3xFWPo6x+ruC9drYWGs/b2moOgMSaiD
         Ik6a4E+Kc1WjknrsES7NHn+E9bJKWRCc7MIIpE1YedLGc5y1EQhckxA203o2gx+9dlIK
         O0+Bvc4imORlPd/u5OM3F5ZOTD5nKjsYALYJSu8btt5bgbDt1W/DtBWJiBkxqpNvhFP6
         Q6vDRIr12xf//i7wVZ7TPLxbf+ZTSTiuKvEc5rv2CXtnvhKnkHsm0cWXec6NN6p9Sx+W
         p6pQSPSLd12Z2Z3Q/5UelD9v3oyOGPCOrBzhLzD9jCbyWlsjUqh0kX8LhBMu4K420s23
         gJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788943962; x=1789548762;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3qOQRcdHXy4zUHj08w48xO+e1/T7rRogcnaSwA9ymUk=;
        b=qLHGEtUI2B5ifI18dD6Pz9cPQ4mTnvLnH2isz/Sl6dDBwcRHgrzZTh3Bi/gRBNz4cR
         uTI1KB83PMdcIlyr3GEdP/YDhcTvQlmDlYb+I4I6O8qNJn/mFITChi0WrBxnqFaOWGAM
         NV49R7pOTn8Q5PK/RiwzVSx9KNQno2yshzT0VvNLyleJuVMzb7KUI1ZqOxQg7F+9m1ox
         S8W4hKnJM9naEBROda5lzac2IvLS3C+1qplta3vx5bgW93MOpTsmQIe8LjFgcYiinkNK
         fUyhy3nEVeBd25zZD4py7WIITD84o4U8uVK3xC6eSu5lSa6VbADiBUI+lS9De0rhwswG
         fMRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxE01ocgeXgz0EAKM8NchfeWQ9eZZGf2EWvv0LUHWQMXp6tayELagzLsAAbK9tQpgTXP8alZvY=@vger.kernel.org
X-Gm-Message-State: AFuF++nHVjV1m9hl+KVG+SXWD7cpD6F/aSX7QYk4xPcQFhDT16dCqPKR
	s/KSrDjX/EGSgwglTTJ8opbeCYXcICMeEj+uFvVDfpRqOts3apu70i0bf8I/sS/DXl3JC7kgIDv
	6bCtX39VmHLeo0spO/qO+X38WDhNv54qkgMaIf/Rppy2xf3DX8iRxmdKdibI=
X-Gm-Gg: AYBFou0UV/vQHTV1q/6/HY7pOieTRWJ72hSfB/gZQtWlDfp5P4CLKT2D8sCGpPw60Ls
	iJoH15x5yu3JmoB1WdAg2yZ6hyYq7Ig7mJ/VfSwa1nG4qLgSqxYaClTGlhn9ge6uc+UYFx2Opgj
	ccmUT3Vev/23cLfCsxxv1R4wt4915VMCumZPSV/r2Hpy+GyUWWRSkZHjaWmmOsgnZuC6cQIWuVs
	hJBK8HL/nObY+dmbs597lZVnmbkL8i0uHp4au4gMtKK86Mp0Cv3P82ftbql3u/eB3VDXRuqRVVq
	h3/mUCFpfW+xW+AB3KZ4OdSJzrjYSwke3hHJdOByVHilHyyDgdzzmxO9swZQedEmUogEhqT4yMn
	nVXQLJmJ14oQrLfYGCBK4zvQPMi0HZD+gYPc54bUSFnWaYOAP6aKcroDTLiVBhZTBotkfHJZQ7w
	AQujA0RC9hOVYrZSdrNcB+
X-Received: by 2002:a17:90b:4c03:b0:398:bac7:72d0 with SMTP id 98e67ed59e1d1-39b3d86acf2mr24905155a91.5.1788943961389;
        Wed, 09 Sep 2026 01:52:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4c03:b0:398:bac7:72d0 with SMTP id 98e67ed59e1d1-39b3d86acf2mr24905119a91.5.1788943960785;
        Wed, 09 Sep 2026 01:52:40 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm66217574c88.4.2026.09.09.01.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:52:40 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Wed, 09 Sep 2026 14:22:16 +0530
Subject: [PATCH] drm/msm: split DPU core IRQ handler under
 CONFIG_PREEMPT_RT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD8eoWoC/x3MMQqAMAxA0atIZgO1lIJeRRyqjRrQqomIIN7d4
 viG/x9QEiaFpnhA6GLlLWVUZQHDHNJEyDEbrLHe1KbGKCuurJjoPlH3hU9kOTD2zgcyfrAuQI5
 3oZHvf9x27/sBpcSEqWgAAAA=
X-Change-ID: 20260909-drm-mis-next-split-irq-db46ae06c24a
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>
Cc: Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        venkata.valluru@oss.qualcomm.com,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Naman S Thaker <namathak@qti.qualcomm.com>, stable@vger.kernel.org,
        Vishnu Saini <vishnu.saini@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943952; l=16204;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=aYrdU9KBnj3O0kg0vVqxBRbkYHEpg5FguJC5y3U4NV4=;
 b=QHVHRQDItEyuAHB1QMB/MYQNGxCHaHhXQS/HWHfIxj1pG/KFbN1G84viX43k6qSbairrPuaN8
 vAE8uc/Soj+Bw56VZ46QLyjobXATOKUREgcxJpDwOsGfsEFZHArWoAP
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=cpirVV4i c=1 sm=1 tr=0 ts=6aa11e5a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=cd_FAbpdKhHDnuU-n-EA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: -2nmyGifQqpHvwwWwr7I4rCsLDNA8FZg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA5NyBTYWx0ZWRfX8XbEmwk/sIRX
 TTQqHKUC95nKBqKzBjeXLtwKgerUu3/nIQJRVheRs+wTbjZNH0/2DVQO863MMBTzMLe3zS5mViC
 tqRf+jKb5vWfC8btKSVpO56Hhfl9693ojgj53i6rYB4+XeD6TiwO5ylF9CWiXR1iF+61alitXkS
 oT33d4YOdbzmDqYyGOXQVzciszwcnWF85kdxp1Hk/D6ESd5u96g5zs2q4oq5tgjM4UDHqqN8eP8
 f2lRCNIcbeitf8kL22OPY8h0A2b/e9OXWyvGS9AiaBXSoIh3dUKKfmqtiTAZwCmPgNjCLlO9mh4
 brlK/arjcb0cL9lRVrxnD5s6P20KwnQTXJHQw255O88MrvV/f6094re5kabFUB6BJW09BV1pCe/
 Ca0sJXb6WB7SabLNSB/weCcFs+TqCr+AKAfGV7WerGniPTSGfAu7Oe3AALR8NMc5qNx7iR2Lj9c
 rSRB/IWRekNX6V9JSgA==
X-Proofpoint-ORIG-GUID: -2nmyGifQqpHvwwWwr7I4rCsLDNA8FZg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA5NyBTYWx0ZWRfX1sBZMAY/VV0O
 Lw4iXtrg3dbf1jZMtXNFVLGP8VypVL/CvYfZjVKJIxnO37W0KcrwScJ6vX8x113thZtdDPrGopQ
 aK0HdOGrK86xjRiGplQRFm7xXF/YaeA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1011 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090097

From: Naman S Thaker <namathak@qti.qualcomm.com>

On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,
but it dispatches per-encoder callbacks that take sleepable locks
(spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
through vblank/CRC/writeback handling are sleepable as well). Sleeping
inside a hardirq handler is not allowed and eventually crashes the
display, which is what happens after running GLMark2 for a while.

Split dpu_core_irq() into a minimal hardirq handler that only
acknowledges the hardware and records which interrupts fired, plus a
new dpu_core_irq_thread() that performs the actual callback dispatch
from a real, preemptible IRQ thread. This split only takes effect
under CONFIG_PREEMPT_RT; non-RT kernels keep dispatching callbacks
directly from dpu_core_irq() as before.

irq_lock is changed from spinlock_t to raw_spinlock_t unconditionally,
since the hardirq handler needs a lock that never sleeps under RT, and
raw_spinlock_t behaves the same as spinlock_t on non-RT kernels.

dpu_core_irq() itself now takes irq_lock with plain raw_spin_lock()
instead of raw_spin_lock_irqsave(), dropping the irqsave/irqrestore
pair it previously needed as a bottom-half-safe spinlock user. This is
safe because dpu_core_irq() only ever runs as a primary IRQ handler
(hardirq context on non-RT, forced-thread primary handler on RT), both
of which are always entered with local IRQs already disabled by genirq
before the handler is called, so there is nothing left for irqsave to
save here. dpu_core_irq_read(), by contrast, is called from process
context and still needs raw_spin_lock_irqsave().

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Cc: stable@vger.kernel.org
Signed-off-by: Naman S Thaker <namathak@qti.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h      |  10 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 128 ++++++++++++++++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |  11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           |   3 +
 drivers/gpu/drm/msm/msm_kms.c                     |  32 ++++++
 drivers/gpu/drm/msm/msm_kms.h                     |   9 ++
 6 files changed, 170 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h
index e7183cf05776..383e89813db3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h
@@ -14,6 +14,16 @@ void dpu_core_irq_uninstall(struct msm_kms *kms);
 
 irqreturn_t dpu_core_irq(struct msm_kms *kms);
 
+#ifdef CONFIG_PREEMPT_RT
+/**
+ * dpu_core_irq_thread - core IRQ threaded handler, dispatches the per-IRQ
+ *                       callbacks recorded by dpu_core_irq()
+ * @kms:		MSM KMS handle
+ * @return:		interrupt handling status
+ */
+irqreturn_t dpu_core_irq_thread(struct msm_kms *kms);
+#endif
+
 u32 dpu_core_irq_read(
 		struct dpu_kms *dpu_kms,
 		unsigned int irq_idx);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 5b7cd5241f45..95b016e8d7df 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -322,6 +322,52 @@ static void dpu_core_irq_callback_handler(struct dpu_kms *dpu_kms, unsigned int
 	irq_entry->cb(irq_entry->arg);
 }
 
+/*
+ * dpu_core_irq_dispatch() runs the fired bits for @reg_idx through their
+ * registered callbacks directly. Only used on non-PREEMPT_RT kernels, where
+ * dpu_core_irq() itself is allowed to take the sleepable locks reached via
+ * those callbacks.
+ */
+static void dpu_core_irq_dispatch(struct dpu_kms *dpu_kms, int reg_idx, u32 irq_status)
+{
+	unsigned int irq_idx;
+	int bit;
+
+	/*
+	 * Search through matching intr status.
+	 */
+	while ((bit = ffs(irq_status)) != 0) {
+		irq_idx = DPU_IRQ_IDX(reg_idx, bit - 1);
+
+		dpu_core_irq_callback_handler(dpu_kms, irq_idx);
+
+		/*
+		 * When callback finish, clear the irq_status
+		 * with the matching mask. Once irq_status
+		 * is all cleared, the search can be stopped.
+		 */
+		irq_status &= ~BIT(bit - 1);
+	}
+}
+
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * dpu_core_irq_defer_to_thread() hands the fired bits for @reg_idx off to
+ * dpu_core_irq_thread(), which dispatches them from a genuine preemptible
+ * IRQ thread instead of the hardirq context dpu_core_irq() runs in on
+ * PREEMPT_RT.
+ */
+static void dpu_core_irq_defer_to_thread(struct dpu_hw_intr *intr, int reg_idx, u32 irq_status)
+{
+	intr->irq_pending_mask[reg_idx] |= irq_status;
+}
+#else
+static inline void dpu_core_irq_defer_to_thread(struct dpu_hw_intr *intr, int reg_idx,
+						u32 irq_status)
+{
+}
+#endif
+
 /**
  * dpu_core_irq - core IRQ handler
  * @kms:		MSM KMS handle
@@ -332,16 +378,14 @@ irqreturn_t dpu_core_irq(struct msm_kms *kms)
 	struct dpu_kms *dpu_kms = to_dpu_kms(kms);
 	struct dpu_hw_intr *intr = dpu_kms->hw_intr;
 	int reg_idx;
-	unsigned int irq_idx;
 	u32 irq_status;
 	u32 enable_mask;
-	int bit;
-	unsigned long irq_flags;
+	bool wake_thread = false;
 
 	if (!intr)
 		return IRQ_NONE;
 
-	spin_lock_irqsave(&intr->irq_lock, irq_flags);
+	raw_spin_lock(&intr->irq_lock);
 	for (reg_idx = 0; reg_idx < MDP_INTR_MAX; reg_idx++) {
 		if (!test_bit(reg_idx, &intr->irq_mask))
 			continue;
@@ -363,6 +407,52 @@ irqreturn_t dpu_core_irq(struct msm_kms *kms)
 		if (!irq_status)
 			continue;
 
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			dpu_core_irq_defer_to_thread(intr, reg_idx, irq_status);
+			wake_thread = true;
+		} else {
+			dpu_core_irq_dispatch(dpu_kms, reg_idx, irq_status);
+		}
+	}
+
+	/* ensure register writes go through */
+	wmb();
+
+	raw_spin_unlock(&intr->irq_lock);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return wake_thread ? IRQ_WAKE_THREAD : IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * dpu_core_irq_thread() runs in a genuine preemptible IRQ thread (woken via
+ * IRQ_WAKE_THREAD from dpu_core_irq() above), so it's safe for it -- and the
+ * per-encoder callbacks it dispatches to -- to take spinlock_t/rt_mutex
+ * locks such as enc_spinlock, dpu_crtc::spin_lock, and the various DRM-core
+ * locks reached via vblank/CRC/writeback handling.
+ */
+irqreturn_t dpu_core_irq_thread(struct msm_kms *kms)
+{
+	struct dpu_kms *dpu_kms = to_dpu_kms(kms);
+	struct dpu_hw_intr *intr = dpu_kms->hw_intr;
+	int reg_idx;
+	unsigned int irq_idx;
+	u32 irq_status;
+	unsigned long irq_flags;
+	int bit;
+
+	if (!intr)
+		return IRQ_NONE;
+
+	for (reg_idx = 0; reg_idx < MDP_INTR_MAX; reg_idx++) {
+		raw_spin_lock_irqsave(&intr->irq_lock, irq_flags);
+		irq_status = intr->irq_pending_mask[reg_idx];
+		intr->irq_pending_mask[reg_idx] = 0;
+		raw_spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
+
 		/*
 		 * Search through matching intr status.
 		 */
@@ -380,13 +470,9 @@ irqreturn_t dpu_core_irq(struct msm_kms *kms)
 		}
 	}
 
-	/* ensure register writes go through */
-	wmb();
-
-	spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
-
 	return IRQ_HANDLED;
 }
+#endif
 
 static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr,
 					 unsigned int irq_idx)
@@ -410,7 +496,7 @@ static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr,
 	 * under irq_lock and it's the caller's responsibility to ensure that's
 	 * held.
 	 */
-	assert_spin_locked(&intr->irq_lock);
+	assert_raw_spin_locked(&intr->irq_lock);
 
 	reg_idx = DPU_IRQ_REG(irq_idx);
 	reg = &intr->intr_set[reg_idx];
@@ -466,7 +552,7 @@ static int dpu_hw_intr_disable_irq_locked(struct dpu_hw_intr *intr,
 	 * under irq_lock and it's the caller's responsibility to ensure that's
 	 * held.
 	 */
-	assert_spin_locked(&intr->irq_lock);
+	assert_raw_spin_locked(&intr->irq_lock);
 
 	reg_idx = DPU_IRQ_REG(irq_idx);
 	reg = &intr->intr_set[reg_idx];
@@ -554,7 +640,7 @@ u32 dpu_core_irq_read(struct dpu_kms *dpu_kms,
 		return 0;
 	}
 
-	spin_lock_irqsave(&intr->irq_lock, irq_flags);
+	raw_spin_lock_irqsave(&intr->irq_lock, irq_flags);
 
 	reg_idx = DPU_IRQ_REG(irq_idx);
 	intr_status = DPU_REG_READ(&intr->hw,
@@ -567,7 +653,7 @@ u32 dpu_core_irq_read(struct dpu_kms *dpu_kms,
 	/* ensure register writes go through */
 	wmb();
 
-	spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
+	raw_spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
 
 	return intr_status;
 }
@@ -616,7 +702,7 @@ struct dpu_hw_intr *dpu_hw_intr_init(struct drm_device *dev,
 			intr->irq_mask |= BIT(DPU_IRQ_REG(intf->intr_tear_rd_ptr));
 	}
 
-	spin_lock_init(&intr->irq_lock);
+	raw_spin_lock_init(&intr->irq_lock);
 
 	return intr;
 }
@@ -656,11 +742,11 @@ int dpu_core_irq_register_callback(struct dpu_kms *dpu_kms,
 	VERB("[%pS] IRQ=[%d, %d]\n", __builtin_return_address(0),
 	     DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
 
-	spin_lock_irqsave(&dpu_kms->hw_intr->irq_lock, irq_flags);
+	raw_spin_lock_irqsave(&dpu_kms->hw_intr->irq_lock, irq_flags);
 
 	irq_entry = dpu_core_irq_get_entry(dpu_kms->hw_intr, irq_idx);
 	if (unlikely(WARN_ON(irq_entry->cb))) {
-		spin_unlock_irqrestore(&dpu_kms->hw_intr->irq_lock, irq_flags);
+		raw_spin_unlock_irqrestore(&dpu_kms->hw_intr->irq_lock, irq_flags);
 
 		return -EBUSY;
 	}
@@ -675,7 +761,7 @@ int dpu_core_irq_register_callback(struct dpu_kms *dpu_kms,
 	if (ret)
 		DPU_ERROR("Failed/ to enable IRQ=[%d, %d]\n",
 			  DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
-	spin_unlock_irqrestore(&dpu_kms->hw_intr->irq_lock, irq_flags);
+	raw_spin_unlock_irqrestore(&dpu_kms->hw_intr->irq_lock, irq_flags);
 
 	trace_dpu_irq_register_success(DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
 
@@ -707,7 +793,7 @@ int dpu_core_irq_unregister_callback(struct dpu_kms *dpu_kms,
 	VERB("[%pS] IRQ=[%d, %d]\n", __builtin_return_address(0),
 	     DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
 
-	spin_lock_irqsave(&dpu_kms->hw_intr->irq_lock, irq_flags);
+	raw_spin_lock_irqsave(&dpu_kms->hw_intr->irq_lock, irq_flags);
 	trace_dpu_core_irq_unregister_callback(DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
 
 	ret = dpu_hw_intr_disable_irq_locked(dpu_kms->hw_intr, irq_idx);
@@ -719,7 +805,7 @@ int dpu_core_irq_unregister_callback(struct dpu_kms *dpu_kms,
 	irq_entry->cb = NULL;
 	irq_entry->arg = NULL;
 
-	spin_unlock_irqrestore(&dpu_kms->hw_intr->irq_lock, irq_flags);
+	raw_spin_unlock_irqrestore(&dpu_kms->hw_intr->irq_lock, irq_flags);
 
 	trace_dpu_irq_unregister_success(DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
 
@@ -736,11 +822,11 @@ static int dpu_debugfs_core_irq_show(struct seq_file *s, void *v)
 	void *cb;
 
 	for (i = 1; i <= DPU_NUM_IRQS; i++) {
-		spin_lock_irqsave(&dpu_kms->hw_intr->irq_lock, irq_flags);
+		raw_spin_lock_irqsave(&dpu_kms->hw_intr->irq_lock, irq_flags);
 		irq_entry = dpu_core_irq_get_entry(dpu_kms->hw_intr, i);
 		irq_count = atomic_read(&irq_entry->count);
 		cb = irq_entry->cb;
-		spin_unlock_irqrestore(&dpu_kms->hw_intr->irq_lock, irq_flags);
+		raw_spin_unlock_irqrestore(&dpu_kms->hw_intr->irq_lock, irq_flags);
 
 		if (irq_count || cb)
 			seq_printf(s, "IRQ=[%d, %d] count:%d cb:%ps\n",
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index 142358a105c5..2bd16f9341c2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -54,14 +54,21 @@ struct dpu_hw_intr_entry {
  * @ops:              function pointer mapping for IRQ handling
  * @cache_irq_mask:   array of IRQ enable masks reg storage created during init
  * @save_irq_status:  array of IRQ status reg storage created during init
- * @irq_lock:         spinlock for accessing IRQ resources
+ * @irq_lock:         raw spinlock for accessing IRQ resources.
+ * @irq_pending_mask: per-register bitmask of enabled+fired IRQs that the
+ *                    hardirq primary handler has acked in hardware but not
+ *                    yet handed off to the IRQ thread for callback dispatch
+ *                    (CONFIG_PREEMPT_RT only)
  * @irq_cb_tbl:       array of IRQ callbacks
  */
 struct dpu_hw_intr {
 	struct dpu_hw_blk_reg_map hw;
 	u32 cache_irq_mask[MDP_INTR_MAX];
 	u32 *save_irq_status;
-	spinlock_t irq_lock;
+	raw_spinlock_t irq_lock;
+#ifdef CONFIG_PREEMPT_RT
+	u32 irq_pending_mask[MDP_INTR_MAX];
+#endif
 	unsigned long irq_mask;
 	const struct dpu_intr_reg *intr_set;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..f85218494665 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1072,6 +1072,9 @@ static const struct msm_kms_funcs kms_funcs = {
 	.irq_postinstall = dpu_irq_postinstall,
 	.irq_uninstall   = dpu_core_irq_uninstall,
 	.irq             = dpu_core_irq,
+#ifdef CONFIG_PREEMPT_RT
+	.irq_thread      = dpu_core_irq_thread,
+#endif
 	.enable_commit   = dpu_kms_enable_commit,
 	.disable_commit  = dpu_kms_disable_commit,
 	.check_mode_changed = dpu_kms_check_mode_changed,
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..f7d045f283ad 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -42,6 +42,20 @@ static irqreturn_t msm_irq(int irq, void *arg)
 	return kms->funcs->irq(kms);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static irqreturn_t msm_irq_thread(int irq, void *arg)
+{
+	struct drm_device *dev = arg;
+	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_kms *kms = priv->kms;
+
+	if (WARN_ON_ONCE(!kms || !kms->funcs->irq_thread))
+		return IRQ_NONE;
+
+	return kms->funcs->irq_thread(kms);
+}
+#endif
+
 static void msm_irq_preinstall(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -76,7 +90,25 @@ static int msm_irq_install(struct drm_device *dev, unsigned int irq)
 
 	msm_irq_preinstall(dev);
 
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Some KMS backends (e.g. dpu1) split their handler into a minimal
+	 * hardirq primary handler that only acks hardware and a threaded
+	 * handler that does the actual (sleep-capable) callback dispatch.
+	 * IRQF_ONESHOT keeps the primary handler running as a true hardirq
+	 * even under PREEMPT_RT's forced-threading (see
+	 * irq_setup_forced_threading() in kernel/irq/manage.c), the same
+	 * property IRQF_NO_THREAD gives the backends that don't split their
+	 * handler and must run their whole ->irq() in hardirq context.
+	 */
+	if (kms->funcs->irq_thread)
+		ret = request_threaded_irq(irq, msm_irq, msm_irq_thread,
+					   IRQF_ONESHOT, dev->driver->name, dev);
+	else
+		ret = request_irq(irq, msm_irq, IRQF_NO_THREAD, dev->driver->name, dev);
+#else
 	ret = request_irq(irq, msm_irq, 0, dev->driver->name, dev);
+#endif
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index f25b31e502d2..f0396cfbfc0c 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -30,6 +30,15 @@ struct msm_kms_funcs {
 	int (*irq_postinstall)(struct msm_kms *kms);
 	void (*irq_uninstall)(struct msm_kms *kms);
 	irqreturn_t (*irq)(struct msm_kms *kms);
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Optional threaded companion to ->irq(), used only on PREEMPT_RT.
+	 * When set, ->irq() must behave as a true hardirq handler (only
+	 * raw_spinlock_t, no sleeping) and hand off any deferred work to
+	 * ->irq_thread(), which runs in a real, preemptible IRQ thread.
+	 */
+	irqreturn_t (*irq_thread)(struct msm_kms *kms);
+#endif
 	int (*enable_vblank)(struct msm_kms *kms, struct drm_crtc *crtc);
 	void (*disable_vblank)(struct msm_kms *kms, struct drm_crtc *crtc);
 

---
base-commit: 730c6d8072d8d9a6dbfd06c7c5ab4479167a792a
change-id: 20260909-drm-mis-next-split-irq-db46ae06c24a

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

