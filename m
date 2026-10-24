Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837852;
	b=ZH/gUnHarn6QRFuFuRrd/Jc7cgXvucRz/4df/91uxDcS9z0SSvEL9kQ4g6AUBEXAluaV
	 Ma7L3CJ2IVAtJ9lj0ZBirOetu8Pf8WR7Tb/w63P8iYN+7WGH1zIFEpkpkOy0XmH0Z+gl9
	 yq1s5e95ZDE39Y59xokSU3HRTFWKEfkukhz+G3xBdW8TiVwzYsN53wIuWp6CvdiOk47Z5
	 txvDLA8zU4rbMiZKd9+A3xJZaUqGrwn324XRq5X9jMAYqqNEofXWnBIBaM/VzSr8pifek
	 YobcXa1RpyX1Ya95E/DSTaQ/QJ0JZ5rl13xC0f+hjJ2GA4v6Iy/v2wnUBQWdy8L23zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837852;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=A2cReWsSiTJKbfzFTEgcvWxEdzaCiferPXrh60qGdmw=;
	b=JXLIqcVws7yr4o86bEVHSz/HedxDl+JimDJ/xwqaRUR+zMrYOV283Qpryzoe+S8l+aYp
	 wCHgIBvi/svXxn5UO7i7s3f6h+SOQT8Tz2ETzHPbEfoKxAjRgcRyVAJpNpB6zbdxS/vBJ
	 VZ8xxVwjDQ12SI0iLvQiB1uo7pv3/AgXnhv37fBgs47Lq38ACLb+AB0Imb2DtAIY78Dy0
	 gyu6pq5pXZThurQPQjPpDUBe3blu51am4bLmnofPeD45fYjLV08Bf5+mpYKLwED3Z9D3S
	 rKwfpq8JuA0hZLWRLSKgm0DUXVVEBe8hFGfffyNd9zjSGVh8MFol8/HjGoqAwSU5QHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hbFw69Za;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SKIexss9;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EBE606A32A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23EBE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hbFw69Za;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SKIexss9
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O8ocAn254648
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2cReWsSiTJKbfzFTEgcvWxEdzaCiferPXrh60qGdmw=; b=hbFw69Za6+9aZVUA
	HqU6MRuyyTjYdXcuuPU8rrD8BRNE77vyWRfOoZcFb4RCcAPUd062hYBXO/QqDobO
	eYoR1KxBuc7pv32sv7QWw2jkpBsjnxF4BLvOkY0slRguf7UdN2kIWihywZ9AYOD0
	kHT/EGg8ATp50XwlJU+YX4FAtp6RLA/eioveQaC799vQn0EWFRd+Mrgxn8wqtdwH
	nBrMnHZde3C/QYDkfV5O11mf2M4oVY6Fn8KbeTbTVY7IaVM2j/tjKcfX6TTEAppL
	LOiCWUUr+23O2o441ldrvC/Ek68wNMdtAdX95yS0yPipsPM2L0Rr457a5DE/5L68
	1mR4jA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9rjva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:51 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-18b5ee75447so6377455c88.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792837851; x=1793442651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A2cReWsSiTJKbfzFTEgcvWxEdzaCiferPXrh60qGdmw=;
        b=SKIexss9vUcxOC/xT12s2bHjtSm1Admf0MOP8XoUqDVSGsOJoFvvI8pUkx2XxJD12R
         rmDEnrqKt9M/8UNUI6BgRoRGTDeegX0mmO9jQyEeYxICwG81XLEcbhC4x7stXdO6QQWQ
         N1vB9iNF8H8xJu3qQmn4NeIvPU+bxnJDVdVWlZCA4Jrfn0S93hkP4kcJMg2c2mXLMkt8
         A+dpQ8zWx53oCExcdPb+FKdlBoJaIsvcbK2vBOGAVx1cfDBfXk4qtu+dhzX1jjTnqTzr
         spP2Z7YddgMg238W6wek/DXiIoCSx70cRLXUPinLludxP9fQZJx+51jg/HOawltyH6j6
         aJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792837851; x=1793442651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2cReWsSiTJKbfzFTEgcvWxEdzaCiferPXrh60qGdmw=;
        b=hNZYeAgezETha+JQQpv4/H6/TDPDOuE9EHxSybbxqI1mTQQ8XPMdfiZMNbuYvDtfRI
         10AH1HNXuQCQpJX3wv1IIjAWTtGzfrfXD/u1vyrLZBSFVsn76xTHH5i0BA6qe6Y4cYFH
         9oMIW330Tmng3fet13cyNwjx/SEWbzsXytMlmjuY/2aAynp1Q6AMHnfVH/eMfdGXWQYR
         YIjdxnbe4nctUyWCrOvxMcC4HXi8GjSxxl3YlzJwRXhAKw3Z3s0emR4KmSJHuvsFOlxm
         txBVE7YjlaltpBnTxtXz6E8bt/DyHIOvecWow3Sk4IreB9x9OQ1kHY6AumI/LihU9d6E
         V/TQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDrbIGq1cIavmr+gTJSiqnMhckT66WB9Qc140uVcx+deoWuISbGVtlSxRAeRJ7Q7ghr5HPLSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaB6kumDgytFRMDh4ocx/4lLFuCUdZcBs1aRGM4/NVXJN6nCuT
	+cJKKrOYpNHwpLfqn8jFbBj1W5B4uHsAR+ZVgmiQCwSa1mOjo0Qnn5oaDYRcYe3ZlhPDBUvo3WX
	moSQtxQSxEIn1878Yrxlv17VyAhHBnr0xfo+qKQIcaDGZNlH/5kHgo/P2Cbx2TD7UBiY=
X-Gm-Gg: AYBFou1OgKJUWzV6lwf1uw9RDPaGjbAB9KslWvzlvOK0ypXF7/qT6aSHQEHXM2ka/eI
	DOaiHDpFSDltyV7+2b9L8cRA+B3v6/3LWLQwCvKbZO+3FtQRNeOB4XV6msQ7Wg+fhBFlcIx/gHN
	gqXUEDU8gOd18+n6g9rO/mGq+0QiXRcPHL0QnOG/ab6e1HjvpSDemv/J92Yuh55tq1Mvd3Bcl1V
	vjC8+u27AeJmuC/z6VJKhLNeZNRIJBj3KojyPtSYgcy4rtKDaQpigkTlKGGofrjdxA+mAVjmGtK
	9Gnc7g/PBy4t6eCHcWfTzA1zzIRzBY52skmyCP11fALPmXKYplNYX/JnDNZDKRUk+QXLCtfjuoN
	OW3uWQauib/EsQyZ2x95Nzhw=
X-Received: by 2002:a05:7022:4198:b0:14c:be8e:69f2 with SMTP id a92af1059eb24-199363a06f2mr3358624c88.21.1792837850621;
        Sat, 24 Oct 2026 03:30:50 -0700 (PDT)
X-Received: by 2002:a05:7022:4198:b0:14c:be8e:69f2 with SMTP id a92af1059eb24-199363a06f2mr3358566c88.21.1792837850081;
        Sat, 24 Oct 2026 03:30:50 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:30:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:10 +0530
Subject: [PATCH 4/8] drm/msm/devfreq: Record idle_time at GPU idle onset
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
Message-Id: <20261024-assorted-fixes-oct-v1-4-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <ltuikov89@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=1385;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=B/7JK0auHlH1E5rs71vnCUiEOGLiVg3K7pfC0lEPdGQ=;
 b=OHcBZxDZNTeCg15sZVgW9W325yRHdMZt7Y5EKtm8SHncpfDafjAKZCIaSdMq/XWwJEHRJ3iWF
 s8jSVSyR42UDmFDV0cQIE4lrEBBUQUKAG7jkIMW2a0xZrPPBZ0xCjcb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: AszikJX2jAZti7Y0I0bARqxUdZ4kGX0A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX+h6fniTVQyjs
 PC0LYKI6ZbZQ+LwsgCdavuZ4Gl55jitVi805xGveyDIVmWelJO12f94tJmyj7YHFUVY1jDZuNmW
 fh9/gFXVRUkLfyRh9sRXzvV1sUepX//SNOPIcoSlk6WiW82+jFxIPQNTTROeqqaFqqe6YiHvlEP
 hBk2KB8B+VMefOS2e6QBnCB/ObUEsmxVmchFSV1lGp2S8sbzeWyJXMHNBg3IPn4xQwL1G6qHmwP
 VS0plU1Z5c8qB5zc2UFp8zNJxa8H4lyr8ZUbFyeZbforAqdgzQbsW27FbWpj0JMXT2bSjT7lRCB
 QzUXD6zVRrQz3FDS0Zwvm+XtjMpORjmLp/dl2/HQkHXFu4z9UX63gxiCvjhw3V38N9+SuqL4Mo+
 1inX7ZiwZwgYMqiyD9MC7/YlM5nVrhhLyIFIcuRo02kRoRmj82ZBwkOzDzmi7fP8Gqswa8dAsJE
 48jPzvjdN+PPHgZPwAg==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adc88db cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=8Gjds2nr7p1U5lpkA6QA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: AszikJX2jAZti7Y0I0bARqxUdZ4kGX0A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX8GiFLVycDU3q
 tRb56xUcmLXhZKS9dbgkDN6uU3LR9Orgs0QBH5bNhiHkvFjqC2qak8Bvmrr2LBKTqZWPs5RNABk
 HhaV3lRZCoQTCjbWh5L5Y8ZRpUNhcZw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Setting df->idle_time in msm_devfreq_idle_work() means a cancelled
idle_work leaves a stale timestamp, causing idle_time to accumulate
across idle cycles and potentially trigger a spurious devfreq boost.

Move the assignment to msm_devfreq_idle() so the timestamp always
reflects the actual GPU idle onset.

Fixes: 658f4c829688 ("drm/msm/devfreq: Add 1ms delay before clamping freq")
Cc: stable@vger.kernel.org
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 2e1d5c343272..f3c664b20a1b 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -357,7 +357,6 @@ static void msm_devfreq_idle_work(struct kthread_work *work)
 	if (priv->gpu_clamp_to_idle)
 		msm_devfreq_target(&gpu->pdev->dev, &target_freq, 0);
 
-	df->idle_time = ktime_get();
 	df->idle_freq = idle_freq;
 
 	mutex_unlock(&df->devfreq->lock);
@@ -370,6 +369,8 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
 	if (!has_devfreq(gpu))
 		return;
 
+	df->idle_time = ktime_get();
+
 	msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
 			       HRTIMER_MODE_REL);
 }

-- 
2.55.0

