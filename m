Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837866;
	b=C76iymNchCuUqsiEN8tSKoXLrODfBo9wZjdgnD/8Vt3/dUOchaKscjgwmfprefk6p/zZ
	 4IYtsd307eotWpQS8Dq6OZBIFu+NB6jEDV+qpXR/4XcJ1mk4dBBwIFt624HJ86TG9+Au7
	 mlG3waQgR/eoJ7gzkirXIanVmJGwE5FClF9nbMf1s/ejxBEA91VxZhTKFxZX4Lp3BxYhY
	 qoJz9lYhd2hIxaDXt1qwZF9HgpW8IzqoNfz7E++kYSfFmiDjpI6L5spjBx0kLPEea59EQ
	 IHElvmiE8iyprKpjJxxX5MwDp7+/SXI7Tf5q2mqbwrAixwqH9rFvdo1hjaXJDFcRH2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837866;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=v2cWzMxdz49LlUxnsYgt9g2fXHwV78MHTKVlbjWBzDg=;
	b=RB1Y30rNX9Nml3McQHr3Ia1A+/uFCMvEdhOvkyE5D9+lhok8O8+cmZv4NT6Iz7PRJflQ
	 81g5tCneWNAFU52qFtxlVQDfrHcFKkeVSm/dvqMIr0GNWiaYONfHPw/TUATvsKbEQfGOm
	 ImdfKCNDmxI/jvHah3bMtfCITzdjmyhF1Sop2NG1WyBBNiCJydHr5L0+4zJdr1hM1U+cK
	 0u8tfX8rG4R0VGOwhGLJ7lfEsyCkgXYqDdgRhkCYuz9dJoRmsP1HIcbY2A5qUvSbT3beC
	 GM+I1SCR3mES5aD5+ii9LFBSeKaCOoDek0Oblp8wJhVwn+la8cqWoxLvDDGiBWaFNHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U9KKr84y;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cLnl+2PG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC8606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22CC8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U9KKr84y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cLnl+2PG
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O8oCvI1628300
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v2cWzMxdz49LlUxnsYgt9g2fXHwV78MHTKVlbjWBzDg=; b=U9KKr84y5PWzaPth
	kjI0kfOxaZWo/SSWkkmSBif1j5+1AIoDV30Zu3OSVHHGoom0l7Fa6N0Y3lpnK5Ka
	XNwxQTS6O1mMACKgLVxisNCiusOGw5DOvygKF/X6W0/NUYfuXwoFlmF4uChhaQ4b
	+tzIo8foHWTVgmDgppZl9SBWywS63F/7EQUhOd4sR8d5RLdg7p2hST9LwE8+P6LI
	XZmpTTVYfRtcFS6TOKTureE8JjD9otAW8Pj5Q3sRoa8+ESVhaIvLj9FyueP4wZM3
	mw8sl0tLD/YI9HZcbJK7hz9R7bKKgAEJd871hcRG+WsGbgNeRW0Go/f4krIF2+3d
	9+pQYQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6gvf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:31:04 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-151ba226e1bso3388877c88.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792837864; x=1793442664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2cWzMxdz49LlUxnsYgt9g2fXHwV78MHTKVlbjWBzDg=;
        b=cLnl+2PGjN8JGsVmssHYuAjbXLYONUHysdE5JNdXCciFrOjeSpufz2dTRGhyGvPN+C
         630pCMhTxM3vz1YKfyExCsxGCSliAv23X7I7FRFex3+18nNj5phsAloH/A4hItIMdGXw
         ngxHVzs4+ZCBh2gQZh87JgHXpMwqHefTIvGE0IelUC25c6A+GTD7iGKZtpvwqt2BUzYJ
         kpTIIhOFhO2P1dy5/SsZ0rsn1EAHmxNmE1/xFf9RsE+8EqZYw9IAKftTRkkY9kGrKoEQ
         QJbqkKYqN1kvjp0/prVXa5dolUQ2lK8XyXnRn5UpeDgTcsmLPP7MxkfHASsU1ffpQKSC
         FrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792837864; x=1793442664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2cWzMxdz49LlUxnsYgt9g2fXHwV78MHTKVlbjWBzDg=;
        b=o/rXO2rnSXd1FVXUw9beBQWvAt6vjL8CpmUyNvBFZd6qm70yYeWMIFMiaE4TIS2Ufc
         ZjmO7+Ou45epQigENnXxkv6Xy1/Gl6fBCjDV9kOPJzwfyYsbs8+V3CKOvkhk2eHESSxw
         CKCFYi2do8kt9VaqeWd99RYEzvZuUtA+6nAwndtqfOwLHy5tmvljEn4XLxxu+qCuA0EN
         QERLqEwl8ncm65TuwytVHpbiT0EYeqo1qi/dBVS1GOZSj1BraRzOcAinpm/YzVChi+Km
         H/tyBfAZkXphz4mwo/myaS0t4yUGcEGkHxvHCTvWfri2rm0fT7AnnLC1JDhTYw8zOq6j
         G0kg==
X-Forwarded-Encrypted: i=1; AKwUvBw43QWsvwgu+rhTgkkCP/gtfBmwV0zfM8WzcZJNGMCy0/qULmz7LO4A0jYAjIjXTWQbfZjwHl8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1cZYiIP/xWv87TW9TaCWYmBFkMuXUbzNQ404fv1WegR8SHdbh
	DEwRMlscuwIqe7zQ22AwbSwQ+v9rwuM0q6PIo12tJxsKVeTqgicd6Dvq7mXawT4UIULT2lIqa7h
	onCYWY7bHgECsaNNsIp9RmKg75cHcybTXBqkP+lPf14TlQTVdk43MnaOHIE3JDcU9cI4=
X-Gm-Gg: AYBFou3d1D/CRb4L6sA6rbQnFMBe7EVvituLuM0EzoPdt69nKJov2kDBGohC1Zd+IAR
	bYiqDXUFoEs1WVazNhKwY0S08KtYUV1hIU23hVdaMkJvZMBH/VrEdSADBRsC1JsKMxQ/vzmlU5v
	Ut6KTSTO+3ssEIfFeu7+v+3i2NROTcZJZ/5h6tzYYElg7Ydc6ABg0hjS6ecHiiOzuTe+4B06MN0
	1n8+cLC29QU+e2d6z9OIkCaiV1Riq/uyP/euVEclYnm7O3/MLxMzbQMyQbZmTocLcW8KdChEpNZ
	pEZ9C8QPfD/COKbqS3sHdoO2utsYIt9LqzvZQ0K4lVi24Kjfp9fAzR1esOaM6PqmGInDDadg6AV
	5FMT2x5v38pAZZdxp4Bnvwok=
X-Received: by 2002:a05:7022:7f15:b0:15b:7f7a:730d with SMTP id a92af1059eb24-19937022745mr2295233c88.28.1792837863886;
        Sat, 24 Oct 2026 03:31:03 -0700 (PDT)
X-Received: by 2002:a05:7022:7f15:b0:15b:7f7a:730d with SMTP id a92af1059eb24-19937022745mr2295193c88.28.1792837863277;
        Sat, 24 Oct 2026 03:31:03 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:31:02 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:12 +0530
Subject: [PATCH 6/8] drm/msm/a6xx: Reset preemption records across suspend
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
Message-Id: <20261024-assorted-fixes-oct-v1-6-2977f974ddb7@oss.qualcomm.com>
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=5843;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=SthhH9Xamlk9NrsaGpi/oND+ZDdZF2KSfjmw/AAnxHA=;
 b=PSx6InzKK71G+dn1jQzEco3V0sgJ1aEwgIYvi4eoohcktnzB3AQ9dM4n7vIeDINeVguDYQlsd
 JafN2HN+tzfCP6Pw/CC2380vywRtaur2MBRVHYIrz2j4ElbjZ5MUchF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: dhiIrAPnxo4Y9fC-8Y-tvBCGFlTPCBZq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX1GASIxj+erVl
 g9tnp5+QC/O5eJS9QM5ySPagiQ6lorp0NkVZn0UQbmTUH83sirHE21Q+jGttFBtONQG3eIqp/Yf
 pU+vrAFmFQE7jm7EapSoZSNYowe+kQ4=
X-Proofpoint-GUID: dhiIrAPnxo4Y9fC-8Y-tvBCGFlTPCBZq
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adc88e8 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ALv2hRvo4tV7SHe0QXEA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX718lSticuPyn
 /mBPzbscP9gOc0LIGvC0EXSI1L1+HJXgQPcKUilqBfHCQatX5e7LXOrQbFBBopnJG4VNNzRN3SG
 9zoIngvESPx3BzMUOIXUUmhjC417HoV13kF07p5YnPKToKTTRaKFkdOwCxBiRjLs6RCF/QWI5b6
 O4ULnf4AMtns0Lgke3d6+Hd+c/mXiCPxDkYaQm5F2i/bnWfDTtBYcFWys3wuM6c/Xo94b+hi/Oc
 3ZJfvetQjs3satKpfcl1HZM/z4Nn7Z9z5qcv9I09D5DAS2X/0erjlmi5Owqoy9PgTvU3ANPlO/0
 EmalB1ue5Izsr2Qctos3CFlU+44l8LGZHbhqFjebOSsBDmivjolNnmDDS1zDmlPFQEQlkK6T/ZG
 kx/Xru8I8oyWjeJjQyAkJYEGwgnvTPyO/X0AA5+S/7T07POlRxdQgc6+oWR+z5n46zPAKI6ebtG
 sbbvUj/7QKRUVY/aBCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240041

The preemption records are initialised only once at probe time. On every
resume, a6xx_preempt_hw_init() and a8xx_preempt_hw_init() refresh only a
subset of the fields (rptr, wptr, rptr_addr, info, data, rbase). Whatever
else the CP wrote into the record before the GPU was power-collapsed
is left in place and gets consumed again by the CP on the next preemption,
now carrying stale context state.

To fix this, zero the whole preemption record on suspend and fully
initialise every field in the hw_init path.

Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
Cc: stable@vger.kernel.org
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 37 ++++++++++++++++++-------------
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c | 11 ++++++---
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 92e8c8abb86d..3e4afaa5345f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2248,6 +2248,7 @@ static int a6xx_gmu_pm_suspend(struct msm_gpu *gpu)
 		for (i = 0; i < gpu->nr_rings; i++)
 			a6xx_gpu->shadow[i] = 0;
 
+	a6xx_preempt_record_reset(gpu);
 	gpu->suspend_count++;
 
 	return 0;
@@ -2287,6 +2288,7 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 		for (i = 0; i < gpu->nr_rings; i++)
 			a6xx_gpu->shadow[i] = 0;
 
+	a6xx_preempt_record_reset(gpu);
 	gpu->suspend_count++;
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 79912a33e17c..62a19e22e230 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -305,6 +305,7 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu);
 void a6xx_preempt_trigger(struct msm_gpu *gpu);
 void a6xx_preempt_irq(struct msm_gpu *gpu);
 void a6xx_preempt_fini(struct msm_gpu *gpu);
+void a6xx_preempt_record_reset(struct msm_gpu *gpu);
 void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
 		struct a6xx_gpu *a6xx_gpu, struct msm_gpu_submitqueue *queue);
 int a6xx_preempt_submitqueue_setup(struct msm_gpu *gpu,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 1e599d4ddea1..df8d4f3e8d4c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -140,12 +140,17 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct a6xx_preempt_record *record_ptr = a6xx_gpu->preempt[i];
 
-		record_ptr->wptr = 0;
-		record_ptr->rptr = 0;
-		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
+		record_ptr->magic = A6XX_PREEMPT_RECORD_MAGIC;
 		record_ptr->info = 0;
+		record_ptr->errno = 0;
 		record_ptr->data = 0;
+		record_ptr->cntl = MSM_GPU_RB_CNTL_DEFAULT;
+		record_ptr->rptr = 0;
+		record_ptr->wptr = 0;
+		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
 		record_ptr->rbase = gpu->rb[i]->iova;
+		record_ptr->counter = 0;
+		record_ptr->bv_rptr_addr = rbmemptr(gpu->rb[i], bv_rptr);
 	}
 
 	/* Write a 0 to signal that we aren't switching pagetables */
@@ -163,6 +168,19 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu)
 	a6xx_gpu->cur_ring = gpu->rb[0];
 }
 
+void a6xx_preempt_record_reset(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	int i;
+
+	if (gpu->nr_rings == 1)
+		return;
+
+	for (i = 0; i < gpu->nr_rings; i++)
+		memset(a6xx_gpu->preempt[i], 0, a6xx_gpu->preempt_bo[i]->size);
+}
+
 void a6xx_preempt_trigger(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -302,8 +320,6 @@ static int preempt_init_ring(struct a6xx_gpu *a6xx_gpu,
 	a6xx_gpu->preempt_iova[ring->id] = iova;
 	a6xx_gpu->preempt[ring->id] = ptr;
 
-	struct a6xx_preempt_record *record_ptr = ptr;
-
 	ptr = msm_gem_kernel_new(gpu->dev,
 		PREEMPT_SMMU_INFO_SIZE,
 		MSM_BO_WC | MSM_BO_MAP_PRIV | MSM_BO_GPU_READONLY,
@@ -329,17 +345,6 @@ static int preempt_init_ring(struct a6xx_gpu *a6xx_gpu,
 	smmu_info_ptr->asid = 0xdecafbad;
 	smmu_info_ptr->context_idr = 0;
 
-	/* Set up the defaults on the preemption record */
-	record_ptr->magic = A6XX_PREEMPT_RECORD_MAGIC;
-	record_ptr->info = 0;
-	record_ptr->data = 0;
-	record_ptr->rptr = 0;
-	record_ptr->wptr = 0;
-	record_ptr->cntl = MSM_GPU_RB_CNTL_DEFAULT;
-	record_ptr->rbase = ring->iova;
-	record_ptr->counter = 0;
-	record_ptr->bv_rptr_addr = rbmemptr(ring, bv_rptr);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
index 6cb53a071801..0e0503ed54a1 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
@@ -121,12 +121,17 @@ void a8xx_preempt_hw_init(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct a6xx_preempt_record *record_ptr = a6xx_gpu->preempt[i];
 
-		record_ptr->wptr = 0;
-		record_ptr->rptr = 0;
-		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
+		record_ptr->magic = A6XX_PREEMPT_RECORD_MAGIC;
 		record_ptr->info = 0;
+		record_ptr->errno = 0;
 		record_ptr->data = 0;
+		record_ptr->cntl = MSM_GPU_RB_CNTL_DEFAULT;
+		record_ptr->rptr = 0;
+		record_ptr->wptr = 0;
+		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
 		record_ptr->rbase = gpu->rb[i]->iova;
+		record_ptr->counter = 0;
+		record_ptr->bv_rptr_addr = rbmemptr(gpu->rb[i], bv_rptr);
 	}
 
 	/* Write a 0 to signal that we aren't switching pagetables */

-- 
2.55.0

