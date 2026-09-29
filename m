Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1EE3F20E8
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790656146; cv=none; b=s2Yy1zrZkyos3K63qZFGvRuz1cyUorukINEmWevmRdkZtkRs/PyZOhF9urehIuACI8viJ9KHjd4RFq4CD3C0QidOOxk10CFYfxnCvWeXW/QgNa4AHnugeynwofSiglzD6IGP+KCeaD4OPRN9IeP5puhxNTRMlZEEPAG9f0TIdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790656146; c=relaxed/simple;
	bh=aSeBGV8VMkTSrgHkv0/PJ4kG5TxILdtIp9OP7FPqUBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qYWSqlP9OOUGUmZjZQDFgw/XzXQtMXf9T4d0QH9UQsJHOYYJq2eEVM0t/iuXQWbyr0VTvoHraaVp/+M/uAwylR43DGblcMVdzJyRJss+DKUNm+Kbv4UUO5i8jU9tPnBTheCMrektzLdGQ2TrbwjjA4eYsTYFoQapi1Tf+rqmBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N/fkupnm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DinOBioq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/fkupnm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DinOBioq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47i5X4052976
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 04:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fWDgBGmsTa75wGoRn4sLRTH1YxnI16xo8wweVmrzI60=; b=N/fkupnmm92kBOJD
	17QVIlHe3eCaZFq3zfKRIOocSI20dZ+XJl5mtlyYYpRhYTw7CFyuPyxPe19c84kP
	jXqyb2GK+JvOAkJiZ3A08cDuhYHq2o2SQT0YfeUJurcFjnYJ4aeBCGjrGRYmje/u
	fNDlV7Fakz3KJiji7AXgaobjeMhmnPJC+/HvG+rTYTmFh0sGYUPbUC4z/tAS28Nf
	9BFLn8yYoM5h8Qdt226cvjw7TNiFB6dHqzZvB23sYu+sm6xCyxD8pdt6eDyEzg9p
	dQzafYbcK/j6apI/K0c0opEYkszljJuFD2ZccFn/ZsiUCoYw2M09EuFEYHfKCcNi
	NAvslA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg2jk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 04:29:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91431adf55eso69558006d6.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790656142; x=1791260942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fWDgBGmsTa75wGoRn4sLRTH1YxnI16xo8wweVmrzI60=;
        b=DinOBioqsD5xr7Zm8EM10xrm0jGB7lW3KHwahx/2mJgiJqJvhq1QPjw4VxCVlw2LlY
         ICPWSkIfHDaxKqFT92teeMXklDmZgWDfaJaC/gXqJ6D5qdNkgN3b6lWvUHcZPpiHaBhA
         QUoA1Id6X0Ark3yA2yDIYvVWC+57X6Pksiu/7biOWwjb7APdgUzygNHCTIGySj0uZxYz
         FDdST8jGsJsd8K7Vecho9duyX6wwP8RvOtQB44q3A+VdlKdrjbfXrTT57R9w9KEkbpHo
         ZcJJCHzEZ7TMbDjBgVF9eH0xMt3srUG22+Ztcg2M4yBPvYThNI8YVkIKrqXax184YcEO
         10QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790656142; x=1791260942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWDgBGmsTa75wGoRn4sLRTH1YxnI16xo8wweVmrzI60=;
        b=PyBzrSKk0V63zKjZsv4sSlwsc3/iHxHWF1/YdCzjIVsoBKUe8JZvnezJ8QBb3JvfHM
         Wn7chq4fanuQPWLfsGQBg/VCioDc8jtvOXN6HwD3zkqRUHOlYDJEFCr3KHsaUYzxLDNL
         CALGIsOnYpAHIOQMiBXFFxZVhDxBOCKu4XqfSPgeN0eFbVdlHyxB2TmSXWYbZYYEts/Z
         hNqu9Bv3FxCsd1H0S12wWX9hwJS5Pl/jaxAo31j8F2IvRgHOgCtdUcB/LtsLbHDF4pLo
         h+IyWEBsDCbo14RUecTBxk4wJSNqABtCbolx/Ma8ktP9Yj+BeBIU67ak345Nja3z74vn
         B7Cw==
X-Forwarded-Encrypted: i=1; AKwUvBzEIcNg0o6H0LNKiO5J3pc4gsugpFESd6I/78km0PzJbkxPuvW5TXUY8KVFLl3MbM9qjjeZNaE=@vger.kernel.org
X-Gm-Message-State: AFuF++mhILcqAxFVfIqS+3VcV0BbZBVX0cRyS/9VMh3LuM3+YBAOzWzj
	k4zNazPj1BGrJAZVnVtfPsjS1Y//5p7FVi9aNSL8crG7Z3VZeRlVaVbLR5ksZIVs6A0y6SIjBRX
	cZ7/LsqrEmrZ+Eba7C9sOXDXsFrAnm1n6/YLESKfspPdFsKmDlWsXORP9K6E=
X-Gm-Gg: AYBFou3MkL0sK0yg5WfjGMiRHWZUDGprZ3dWIoGBtFrk+0QaTE3lHMxgkl4fXoMD7MF
	oON7DcoTRPxRGXXZv1ZdKYKro0X+Vq2DTHIIGMmzqua8t6u/m97w6PG15ImR67nvsyAeIzt9C2J
	qJy28P+ibzjTniS0VuYNFyPN18RaeqcW+n+5AJhUjMe4theDmdrdzPufRYClHKf/kPwaQy/rdie
	qH0XcNhHVmo0nH2LjINxkeWgkYhDXmZF8om/sPkhTGD6MO4kBhJXt6hhdOXQ+WzbtxGlddJe5LW
	j7sQmRNkfcIwoWyYhcGqgq0/PkF5sixi75sgxAqa51gLkO4zTw7GTzhJfU3x1x0cSm0EOLYbHcT
	FyFzdaHdO8sAQf9g+sxhwARMZklwspxiFkVS5TXr9sV+niX6IYj9xbPAu8Brnlx4=
X-Received: by 2002:a05:6214:6187:10b0:917:8238:2320 with SMTP id 6a1803df08f44-91782382925mr34606296d6.37.1790656142177;
        Mon, 28 Sep 2026 21:29:02 -0700 (PDT)
X-Received: by 2002:a05:6214:6187:10b0:917:8238:2320 with SMTP id 6a1803df08f44-91782382925mr34606096d6.37.1790656141676;
        Mon, 28 Sep 2026 21:29:01 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:29:01 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:57 +0800
Subject: [PATCH v7 33/35] drm/msm/dp: wake threaded handler for HPD IRQs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-33-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=3017;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=aSeBGV8VMkTSrgHkv0/PJ4kG5TxILdtIp9OP7FPqUBI=;
 b=xy+JB5mpVmGt+3/yWFmznUuwQ53lLquWq0Yx7BaW5umA651LMuHClsVgbrilUuPTJLH+j/k2N
 NVs3qwQdrzWAb1u6kuHTD3N6BPTvCIKIkCCRddqmm6YWxjNX5/+Ywaj
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX0+3jdbRVWKIe
 rJiRU7UOUREfxaCDTSo9gZyhTmuVmCeTML+Mer/01RLPANzUjwO/RxB/4gWgxqHTA49/Y9ordq7
 hBuOHfaS3f6Boy2PiFfI364gwubA4DQ=
X-Proofpoint-GUID: p9NYqPuEDaMcGsP9DqYjncsLoxtKAVZg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX1lIyS3h+l5JC
 3nw0RE7uIwTPtzlCupW9SGXdaKdp1A/FxudP8nAYjukK+PMmu4ju3eVkLKriaawyjg5XLm9x6tk
 fHQoycGmwEanMVvitUh1etwHhzZx9F3/9EXqvDemQRt6uUOS7czvLOZVx0PZP8Yev+tvFz01z4Q
 NBdqWlgcOSFcG2Yxt6Uvo/CvgElrMEG0mX1g0Vyt+/J+dalYPWEohN9bwsu+W3xOqDC4gzPXvHg
 epoCnnkRdsF1t20L6ZioUdI/8xNVdoHDXHFSSfCgrrzrQ5ci8opm25C7pNikTxJz5hYRQ1Ycc60
 zLVe3H5x1q0lMgH2gz1N2vz/++0pd0J7LyehD4XDY5vCwNn7qrrIRRfe4GDYMNcIEstrYXnslqV
 u9NqWAyogC2WSOWjm2FJ/DSi3pTktE00qhqESlzs7EfDwdvPDixYMcxlIjt3BG1mobC31Xf5/aC
 efvl19EIlOHlP6aNFUA==
X-Proofpoint-ORIG-GUID: p9NYqPuEDaMcGsP9DqYjncsLoxtKAVZg
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3e8e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rr3H4PImTD0NAioKu5AA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017

The primary IRQ handler latches HPD status for the threaded handler
before servicing DP controller interrupts.

When an HPD interrupt was pending, the handler set its return value to
IRQ_WAKE_THREAD and then ORed it with msm_dp_ctrl_isr()'s return value.
If the controller ISR returned IRQ_HANDLED, the primary handler returned
IRQ_HANDLED | IRQ_WAKE_THREAD instead.

The IRQ core wakes an action's thread only when its primary handler
returns IRQ_WAKE_THREAD exactly. In that case, the HPD status was latched
for the threaded handler, but the handler itself was not woken.

Return IRQ_WAKE_THREAD directly whenever an unmasked HPD interrupt is
pending, after servicing controller interrupts in hardirq context, while
retaining the existing IRQ_HANDLED fallback for non-HPD interrupts.

Also report STATUS2 interrupts as handled. msm_dp_ctrl_get_interrupt()
acknowledges every pending STATUS2 source, including sources that need no
additional action, so they must not be reported as IRQ_NONE.

Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 3 +++
 drivers/gpu/drm/msm/dp/dp_display.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index f1642413e4a3..53dd7a23e091 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3051,6 +3051,9 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	isr = msm_dp_ctrl_get_interrupt(ctrl);
+	/* All status2 sources are ACKed by msm_dp_ctrl_get_interrupt(). */
+	if (isr & DP_INTERRUPT_STATUS2)
+		ret = IRQ_HANDLED;
 
 	if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
 		drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 327777f5c95e..ed0b93e3bd08 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1089,23 +1089,24 @@ static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 	u32 hpd_isr_status;
 	unsigned long flags;
 	irqreturn_t ret = IRQ_HANDLED;
+	bool hpd_irq_pending;
 
 	hpd_isr_status = msm_dp_aux_get_hpd_intr_status(dp->aux);
+	hpd_irq_pending = hpd_isr_status & DP_DP_HPD_INT_MASK;
 
-	if (hpd_isr_status & 0x0F) {
+	if (hpd_irq_pending) {
 		drm_dbg_dp(dp->drm_dev, "type=%d isr=0x%x\n",
 			dp->msm_dp_display.connector_type, hpd_isr_status);
 
 		spin_lock_irqsave(&dp->irq_thread_lock, flags);
 		dp->hpd_isr_status |= hpd_isr_status;
-		ret = IRQ_WAKE_THREAD;
 		spin_unlock_irqrestore(&dp->irq_thread_lock, flags);
 	}
 
 	/* DP controller isr */
 	ret |= msm_dp_ctrl_isr(dp->ctrl, dp->panel);
 
-	return ret;
+	return hpd_irq_pending ? IRQ_WAKE_THREAD : ret;
 }
 
 static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)

-- 
2.43.0

