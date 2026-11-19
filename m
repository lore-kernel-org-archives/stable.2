Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076806;
	b=sbTzNLnO1uDHrQzVlUXbVsRh4++YcazuQUb0Bt9wj8dAAVzNaRs1u6eeKL/oG1os6/Nd
	 sZDK71SEpXY6d906Y6SXEXP/57HBEanCV/YUmq6rtEZqO09iWlAozcB+rqlKGsn903GYP
	 ncbTUn0UY/kf2qYmeFNY6uDdTI1akqsnApU+dyX4BUPhIs3GmSXrBx+0h4d7CdC5Mmz5f
	 TVfX94OPiNjMpva/U6XjL0TUiCjcWD5GAMrOr0E+auTl62lmTtTyockXKlHSx83JzydEo
	 GoxKQFhhQk0PhI/VQYgGVxt8leNnAdQ+cQRWzdYkHrT5bxog8PRteY9r2CQNBosYT9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076806;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=F8GWse/FZkpHqoIzSRRy90QZ23uRt1u/gc+qU2cET1c=;
	b=AhBZDlt/YEe0k1xxZw4u64q5r1JI/rvaIkSjaF7JcHbTWCsepIsmVzzLzcJGH6YmTIbr
	 o9rsWnriy8AU2Ia8cZPkxfk08fea8Oyr+zKgOugednS1BYJAruJH8f09hQfrFC/ZQUi7x
	 UJ257kXWskWVby2TJCMeDqLLr9dZJEb67uKtL5F32DMFxUUy7tlllVs90/aOtC7PUuxgY
	 uTEPWX5p7WSIQTOalicuzt1UIZQQ44YBPwQC+NesjMLGSWOA6qvUPuML8AfAvpji6kmkX
	 9b8yjApIe13KUtENwIeRuu/8VBkZtrALnqWK1UIW5aG/r7xxe6cmRVHdO+9TvCyq3pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FWiV+r3R;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XgBKVTo0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADA606A331
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAADA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FWiV+r3R;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XgBKVTo0
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6vGL91681211
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8GWse/FZkpHqoIzSRRy90QZ23uRt1u/gc+qU2cET1c=; b=FWiV+r3RZtlNKwfT
	1py8YOPAZSkDTk9EwoP6seWbhh9wci4VXLG+Yhql4WMFWgYCqW1RPcs2+/4hkpQE
	0iLmOgP3PMplG1FkwGSRW2GqoHtk5mBAjFHjJ+VUE+CEP2Ez1Vib+yLlrjApeX77
	KLtXo5BeOGbrkyXkhaZkaoP/yWrFPVm/dLvGOUGCiSsmZu3PSm32og8V3u+Erf/o
	9zh7at3qP2y/UJyn0y9TknF4+nTqvy0mbDJIDzSUYvMdbEfd8lNXLORVl2CKeIwz
	ZdUw1/Q9p9ESZUldTslRRf0Lpg6V4P0P5CFd4c0EG0R9l5czLVKe6+GamPLiR1jm
	6vQQAA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdcss64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:26:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9495c71055bso423675485a.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795076804; x=1795681604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8GWse/FZkpHqoIzSRRy90QZ23uRt1u/gc+qU2cET1c=;
        b=XgBKVTo0E/d85n5nMEcW0Tg21wqoL44fu2Ve02YbNeQigm4JLzuVoBCLM/V31CWSzp
         ib2N5M+CkbasJ8dtGS51zc8CUsyEqV1VXTJ6Zx0shPqW/hkxlgZzWnA2tjwKZltgQEqH
         OL42tX4gh/CarIQMbwevHSZ5Do0QKywk8/xVLbumgBtt0/1Kx1atnzIiwXE1TYWv3Q+9
         DKNT6X7d2FyyVL0od9n6cXQxPHu7ninb/U9I9JCq8o9i9AcTx2O9dobV2KAS3V5T8GuD
         QHuxYbIYw/reTCcKdvrzNXpsLQpRqG9bx3l4RumHsaApvFGNkPRuO+fF4Fj1jCga/bdG
         AMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076804; x=1795681604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8GWse/FZkpHqoIzSRRy90QZ23uRt1u/gc+qU2cET1c=;
        b=TgxLsTF6ezXhv8eZLrbHTe+PFL1m28vrXQH36GJ6EuSkKiLIUWPS6ZsfRbrtJy87Z8
         qBO+JXCSwOJTnDaKl0BtOHNnHeDsegOtdbL0h39Bzf8r45De3zjKnjNtd5zr7EIBU4kI
         d+FgUItfOu6fpcTHTjAZAgyw0WjJ49U43cpOzc03jdGTByhR2Zp3/YRQsYPAEWsQDPq+
         6kPluo8hw7OIZ8ky2OZZeS8GodwdfI7l0n9YCuWjBbZPa3RssRxQwrtlhk3y8CwwqfyR
         a/czRTadKRoqCYl4h394o905H5GXbnqxlZg+WGoT5noeyQtRA6G3AeRR+bam7YOukJDa
         mXow==
X-Forwarded-Encrypted: i=1; AL+hErE99LL78rzEqFYNtw1FVeTHwcyVyJXsR0+QKZrAe+RgGPddAKwaK2WUQbT23ERkhksm0+XXBU0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9B5Lp4m9SRP1GmHe+k8/MIsoiPTRX8zIaXK3jCmelNhVmwm1CH
	7EFCAlzzVrBqYslb2xupOVRgweDYnrRRfDJitAhWw2wB70LcawZzI3xQHiz8QZ6Vsa3oon9olYN
	qJOFfNqP1WtoRjXmzI1GTJYoOWri0xwjj5/ogKU9qS479pEAPoYIecTMzOHtSFpUNyyOG9A==
X-Gm-Gg: AYBFou3cubZqhoZHY+qJHi7jlnsjE90mVTGFaqHG69TTKFTWI0I14SGHVnSB+5HX7VB
	3KTRlFujUqnu4Sh+dApWfMihBhvWXSiQmMXiBiyel5guBKxjVkSasdztWXlPpRrFrp/XQLIag97
	Ezntv7dLjcKX+LvRvN/ezxm4DxIvKcjbSLpoQcH7K+kJ+hljr+BPRB/jotsU0SAdF0ZagHycR4r
	KwMTybRzX40kI7Eu9LutowloiTruFdPFNa9GCm0mKKvmD9uTPadXFAuV3zpgrL+H4/csaPrP+Yn
	V17uoLp7ZQHXZ6QIRZUKimDdLRD+HAynu02S4ZY49kfu1lM/ky3wkurms2j234y0vTMWBnpoC+h
	MX9DZ18G8z3m5QAWN+lX940fPIrf8bCQEI9X9NhP9pLQwOL7d0prkVROp/tNZxaAXkQ7vl0qpoM
	OGc4b4Ba/k8LQuMMfA/Yt/cqBVGPLOrQquewDf
X-Received: by 2002:a05:620a:1d0e:b0:93f:34c9:9248 with SMTP id af79cd13be357-9499971d885mr862085285a.22.1795076803812;
        Thu, 19 Nov 2026 00:26:43 -0800 (PST)
X-Received: by 2002:a05:620a:1d0e:b0:93f:34c9:9248 with SMTP id af79cd13be357-9499971d885mr862083585a.22.1795076803407;
        Thu, 19 Nov 2026 00:26:43 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:26:43 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:28 +0800
Subject: [PATCH v9 26/29] drm/msm/dp: wake threaded handler for HPD IRQs
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
Message-Id: <20261119-msm-dp-mst-v9-26-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=3017;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=1XWb8mR9FYw/3EXAUOxkw/H8bP728zpMqkwMJ+1kf7E=;
 b=5Le6Ow7xDjp7G1d+34n2dhDxOimAVUJpPTRb+B7nB643hXwWmX1xNESzkxoim+Af4c/zSgvct
 O27nfarjCEMCTfn5Y2SI9LsyEWTBTnrKBPfNUtkUhN90d0gNTgbDjgE
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: FL0pCcW01OG9pvaLtW8rEl9ajH5gMvss
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5+FxFA43Lnym
 ouTtCEXHCwVN+33rgZkYwQIn+SDSgsN+XYnF5fm/fYSm+I8Mg2bN1NxEkYdSYFevc2aTGC+72wE
 RVSUMoP0YisI032x3oW/2gwprrignXw=
X-Proofpoint-GUID: FL0pCcW01OG9pvaLtW8rEl9ajH5gMvss
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afeb2c4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rr3H4PImTD0NAioKu5AA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX06UjsbZD0Iii
 5EPoYz2QrvGKR7cgLVmOj0TMQsqQ1+a3BmhMNjnUxN1whBDQ2eob/w3hKnFb3X+oyobj5HCPiC1
 P73UrSaX3CC4L1Q+MvFoY9VDZq53BtEDldN/CaLZC30ngZNerdPKQjj9ZoPkyAvaCTcUHPgRb1U
 pXP/hgpKUUrZum50nyrEGgX6+XfdC1DHt16mWt45T/sP2FXguo4NxHuhOzRRhC6xyy5v/vnnZdS
 wRBed7Sheof261wV6o/laRdW+8f3Ds42b6lMNwG7qqAhI+dup5sFcWdCPoDwbD+TdGFHhWx/aew
 gEAdvmZVlHDgD+2ZoEoaonkkk4IwfEd+10EeTfNWz2f/QE+IItV0twbkLF4yJtJkmWiDqtb35e8
 /mfos3RqlXxunK61tdcZ/HBuCq49/KKQF67mEQs6FWBo8lx5gzDfw6VHs4rPbWLtwBANVs6/rTT
 Z60/PTWTg+u4jKS5xzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033

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
index 8012c3d47711..bf3f1b35abdd 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3021,6 +3021,9 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	isr = msm_dp_ctrl_get_interrupt(ctrl);
+	/* All status2 sources are ACKed by msm_dp_ctrl_get_interrupt(). */
+	if (isr & DP_INTERRUPT_STATUS2)
+		ret = IRQ_HANDLED;
 
 	if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
 		drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6f1f9dd3660d..ad8c30a8ea79 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1091,23 +1091,24 @@ static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
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

