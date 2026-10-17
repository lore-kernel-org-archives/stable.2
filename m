Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4A3D3CE3
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207025; cv=none; b=nQttAwFMEa82rFu0l8XzALjAVar7QdE2itVc8aPzSFCSjwZypyPXeYHWDddYxu3Xl3cSZnIdtf3TQ+B05nvXsf+Nh9rfxa2qB/NH8ZG3V8ybLVSUI54uC522cMS46OpLLFU2SHCBAUnMHBEVkGxizG40bSoCaXBynsnMcc5ZN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207025; c=relaxed/simple;
	bh=ebxY1nUeHm11IT8aZjhTxlVglYcAHiE4XzbXRK4KBD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7LdNLlIasVBXPqsv8U855UoKUSy4pH0QPHNH1V/UlcGOdJvRwoNp4daleg/dJLM367tCOOp3G2CdxbX1u9pWeLmHhKj1qpm6Xly/DuvU0h4qfTFDkg2qI7EhesgD9JhKxja/XEbtGBSAyzzWfJNztt88//XVJVD7D4ESVsnrUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ruxog8qx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YvTvusdB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ruxog8qx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YvTvusdB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H31I8T4087051
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fF7niJXwbnhKmIleucamElPfOhrgpZJPP4CoRWDHEMc=; b=Ruxog8qxRAwDbEsG
	ni/dGBqnQdAtWVcq9m6aNc/mlhEV8ZKvJRYs20dLrQPoyWrr5ITcVYT8xBu6K5+V
	MRpRORQjOVWYHkZ1asV6Jy/lTI4Wd+Xs/ZukBcp0+j9QbPZm+5sliaCnD/Nvf20g
	v6KgKpc0Wd5k8Ht+/t36b3+0Z5kATk5nX4bn3uIDTaD40svh6LVe/P41pz7O0qFc
	VXo4blSkneivQQRO2VVnfp/tJR0jEvjaTbRSIQE4wJNek7cwI/URWL/1ni0GvzaD
	3or2iLPutVZbgAC0/9TXFNi08Ti4/foS7oVNx35FEdKWsBUvpPdd3qywmAG6cDSO
	WtJKcg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yunhd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:17:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so1383605eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792207021; x=1792811821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fF7niJXwbnhKmIleucamElPfOhrgpZJPP4CoRWDHEMc=;
        b=YvTvusdBRqrOjJWbRnF71EavVd+rQtzQDNs4Hf24/RDXGtuIiwtRqc+wIawUKF94Jx
         okaLiC8WVvnEhX5KDVSP6OfBe60fvE8t0p67b7d5KajNj+HjmKQw/Oku0oDRNXou0OPo
         p5vlcIPk815vcoKyDeoq8ObGUJHaC1WB8r11C9akRKeQBzm/IrTmRlHyKrXIaUGbm5Wg
         wJLDsOJeDvvxb5EsmGaJ8WURGJNGrGza+WuQwXzhlVfC8oc+GE7hNKd0G8HrKRv01Uoz
         JdD6g3CdpWEus3/d7ESPx44zoytJMVy7aUQIqmgJTJQbqQbiYHuWJB0qEUIfUcRsJnjM
         erMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792207021; x=1792811821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fF7niJXwbnhKmIleucamElPfOhrgpZJPP4CoRWDHEMc=;
        b=RIznJSrCIN52coK8SAcGvUZ9wTPKdpQdP8bMkQ/bxbyPMElx/HsdnAPk5Esm2ZniWZ
         D5du754TAlfT3U2MwjrFmEOEj86k232obA0Jem2ESo+gSgQz63CoBWTzbN41D4SIAEZ0
         pXm999Fr4R3GmqVbsnUpGWTHY2uozfwU85eJnWj16VEcr53+X0+fXy2zVrSiHsQ5D+3+
         JG9CvAy+ocd8f0Gvi3n37lxrCvwWYZY5UBppL7B0NP9+iSjlsKuj51PLxaDFZL3Qx+1w
         x3VHI6NEE/Co+6SO8HZA0P0DdNz9G9LNrtmSBncCHC3kg1qWRhzSCzukUSAFhhW0u0ya
         DO1w==
X-Forwarded-Encrypted: i=1; AKwUvBwFI1rQV8aQVe11k1PiN+KOc/ryKCCguxGdwHT6yb4BfGBst1JI+zLd6+GGimKwUNNlc1O9ozc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1/5GfS6gg3GQTdxW1IGeIsWSlSjuQ5uJCkLiTjDhxlIiRICIR
	oykULLlMDrl6dyNWYhiYmM1oDgNddfBKfahEFL95bxwuLISYMECFDwNt9paZOhFvr2UWwb6kGqc
	0E/zIN3uzJ9YBisfDZV61l/SnGdvqrGN0ykjf07nfZKVWUEftJKHjraJC2YY=
X-Gm-Gg: AYBFou3TgD+l3lwjD78CtGlsDjMOLpOIosfBVIuISasd+wB3IaCRVml605kjIJPCrAN
	rhwxNI4LkGpaH1UT/HRPw9n5Mpiwpt0MEwt/yzruJJM0cDmRx/JHOceG4u1orz+Fn9Tw2Rt1jNq
	+5GX/QDSlB3q6/PS86r6Io1L5R6rJXvhRMFIkzbS9H8eH8wM54cuyZceQJgGmVIJH5cOtm1tR9S
	ie6uBcZ1pVkEeGDk0Ub1wWfawHu9T3C13Ab9CEiDhWAoLLf5BJKy7YTO63p50WVXZaLu+PyRj1r
	9R++Hrx+JirZGWt5gG5/8zjvUkiWo2x7z9HJcB2fK/nh0ZoY5RsN5kYl6gGYr2S1XbP3Rl01O8U
	aptXpVKV7JwbIwzt8YGMEzALrZh7Xg81v+A==
X-Received: by 2002:a05:7300:a209:b0:34e:3ce1:39f8 with SMTP id 5a478bee46e88-361a19608b8mr2124028eec.18.1792207020802;
        Fri, 16 Oct 2026 20:17:00 -0700 (PDT)
X-Received: by 2002:a05:7300:a209:b0:34e:3ce1:39f8 with SMTP id 5a478bee46e88-361a19608b8mr2123897eec.18.1792207018058;
        Fri, 16 Oct 2026 20:16:58 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm10969995eec.4.2026.10.16.20.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 20:16:57 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 08:46:17 +0530
Subject: [PATCH 1/3] media: iris: Fix runtime PM reference imbalance on
 failed resume
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-iris-handle-unbind-v1-1-7809148eb90f@oss.qualcomm.com>
References: <20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com>
In-Reply-To: <20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792207006; l=1118;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ebxY1nUeHm11IT8aZjhTxlVglYcAHiE4XzbXRK4KBD8=;
 b=4on817X1smlVhSSD4Kkz2zPLwdTPYF/RXT5oFt2TNLcRb92fstFuv6Gy0X25enDrkWmdpTEGt
 yomUWzuF3w7DLR+cRKDjONMBFuzz+NcBLlqZbLbQd8YESvoyTn7qIQI
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: Ce82pGJNnreo3tUMaBL756dnAOWfjesY
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad2e8ad cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ohPow3cFOKvdjjdYMLAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAxMiBTYWx0ZWRfX3PojF5bUdG5g
 n+45d2Pe392cz2jP/Ktcf/5JFHDNS6whqVV4DRVGELliNLJOdxF7wGDNqLU2asXDBG/8cR9IoNW
 lrLQDQL9QtQvYmWuOSi9XMTd7dXLXP0=
X-Proofpoint-GUID: Ce82pGJNnreo3tUMaBL756dnAOWfjesY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAxMiBTYWx0ZWRfX1Xx4/2vUyVjU
 yNY/AxLU0QqIwEkOSsEMo+HJYUl1DCWpy9z+NeINPQDZs9kUTypnBk3WoG/Is+VqoSK8e27vJ0v
 4u7GILhF2N+C/0H7js7rZTU4+AeQursyVEfD2Mh1h+ynFn9HSJt49HcAy/CqcYm+pN7gYxYtVdV
 u+uFjq//XxHq941eZmj1DPVlENq1iPZD9T46gqIPtJO1bnyYO1meX0qH+HcXRZhe17YRTPvds75
 6EzOCIOdtlnuA3k1BM2MYG/oPqed2+7Hdmn6bNPkhnJ8V208A6Jq6FBVx0RgeIIwrxo6AZOJ+QC
 8FvwizlEKe8b427NQlUItXZUWJSsR+0tore0vYlz8TMU5mlngCzy6tT1fscrR3J0yPnVimQSn+6
 JpdgC+JrN2dSkP+WaQzO9HB8Vc2npGGUywkrELOV6MLrkQWKz/MSq3VK/RikBFLf43W1qgnFysy
 E2Ecck7S80QYWJlp3FA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170012

pm_runtime_resume_and_get() drops its usage count when the resume
fails. iris_hfi_queue_cmd_write() dropped it a second time on that
path, resulting in a runtime PM usage count underflow warning:

  qcom-iris aa00000.video-codec: Runtime PM usage count underflow!

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
index bf6db23b53e21..545bbe75e1740 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
@@ -132,7 +132,7 @@ int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt, u32 pkt_size)
 
 	ret = pm_runtime_resume_and_get(core->dev);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	mutex_lock(&core->lock);
 	ret = iris_hfi_queue_cmd_write_locked(core, pkt, pkt_size);

-- 
2.34.1

