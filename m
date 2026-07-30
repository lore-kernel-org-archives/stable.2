Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521F3E8337
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401711; cv=none; b=o90EnaSKd2+2mpqQhNa9bxZvHXSv0FfYZvOvqCGC7Yf2kKC151LmVit29SyDWfPQI0hU4tOZ6enZxMylG4TejkdguEmmADOZA7XUMYCC6SztxMZ1fDVi0nd3WHyJ1NyS8VvzFU4/u/rolPqGuq9rsSrFqkRxqbdfeyC/4IxFe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401711; c=relaxed/simple;
	bh=yDepBW5TSVc94OiLvHOHEAUQ8yFpRuoV0tAB6eQp938=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0RcFtKdbYDjt5SRlcvHUN5metVAIzhUe0wTCrvufvTiKVbcMGFhJRIHsIQS3KOvVYnX7RqtMK1RX3TF5j/JRHMx7CAkZwlQYs09xpIrwaBtw37GkTxtZFHE3bsbwyeLqa/KN3WHyMjEJearg/J16Qo9CsnfwJAvjUrBfg9g6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FnCICp6x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F/Ih63y7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnCICp6x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F/Ih63y7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U8rFfC778117
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=q27uNBvFXFR
	sroY+VuQWDXW0AfPifGEAVBg+r1u2k74=; b=FnCICp6x1EvRaFuJTDANCO+SuUM
	86eisML1GOvNCBZdrGkVaeFayoZsZLtM83bWrv+z+qCvOPVkCetV+TeEigvkjcdZ
	iwQS2lyi3nqpH576qen+UC2JaEJbAGCBn6rYk1S8wG7ADGv1SPwMb7kfGrc9WwNV
	sXe0iRxMzh56SDQh+jFigb481hBcwMWaNuz+Z27hviqYnmyUWVXMkoF/Yr6hgF2s
	XtncElsgENYHGg2CedZa8L5sWhub1x+m8DmyK/zN/iSSmMTh91azKH5dQOBVVOTl
	WG3f0kFWezpwHOBQ4XKPM1OPZumjeh9XnKYnf8j8cQaZc/QJM/DxY4+kl7Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3gdr094-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:54:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so766105b3a.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785401690; x=1786006490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q27uNBvFXFRsroY+VuQWDXW0AfPifGEAVBg+r1u2k74=;
        b=F/Ih63y7DRXDBsYRk7YcWzG3h1tNnvyT5u/q63gH2LD2GqmAAB/yWsG34POCg3Q525
         X8dmZYDW5atrFcvLTjYXZwpSy/dnywvt2wJUMr+vZyk0VNXqNA19vj18gHBXebyz4J2y
         CEeoOBsBo2jF1uWY/Ya2EzDEaYH8UGf9LQyeX6ciQkx/OrkaEPcBsGyfiTtr+hsDS75/
         Z5X2M9qc7Nf7d0CoJTD5Pp6UhqgLVD4+OV7CG62m9FxMvmeXxNOBFpi3uZgLgwSppCVF
         rIwOUtFjdHYnaPmlOkqIUqZl1N2oOcfWI9MeCeW2f8ZZ/HXjoAtLRBbIIwgtOUgg6Ejn
         w03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785401690; x=1786006490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q27uNBvFXFRsroY+VuQWDXW0AfPifGEAVBg+r1u2k74=;
        b=IeeM+MNMV+bZZi7op9ZIjLTkMQrB+ZE9bp1qRJxEYeAYnPVCJINs9uwj3kmRTaTDwe
         u5cRxUH0Kcvg5GoZeRmr/ZJA7A8gX2ENhbxfpgbEfQLDbGgTiE/190GTj8fJ/x76exCH
         JrvmWpKXhNx9QGai9WxBRtfoZ/FSS0DvaiXySNB2HgalHQBfqIfnpcMEGO5+x6CK7MXq
         0V2SOLWUK2Ci1nqhVPyWxEPaDZy2bRgvtwLDCyNfNgR4YKl3ONOfmiEZhSDjOjMD6QBZ
         muxGJhmWwy76MPi+JEy+kCBoOwRefpuUnkHKbJRAkp+Yt1W6he+NTdk527kcRuJPXmYW
         O2uQ==
X-Forwarded-Encrypted: i=1; AHgh+RpW+xbLVcmOWX9bprP1OfDHPTp9aep1BvmEv7y9dIH7iHA5DXZWh4lf+/Kv6+kh/6LXMRAX2gE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8hLvxkVmMzQuEEVfE4ZVaSl3hweLRmC9exKNTnniQsoVyM7T
	+7pjYaCBEyuvYsMBQc1RbZjhh7KPnaGBWYRIIOn+euTYE0JzqX1R7gNbiYiZ6JPJT5NSgC9G3LZ
	58pYGl2hXH2AKxKyONXmK3Q3DRPmUC2z/DVJnpXxF+EgIX0PTy5cCJailSxg=
X-Gm-Gg: AR+sD10XX/qQaDJUUfTtea31nhKFz7LlxHUsQIWBg/aUmgSLkKZivjzAVNjZYk+DMTe
	zM0vNPFTAzKdCK8dDvbN8iT4VgPLz/cqG4PBfQKMrRro1dg6AZ1+5XatoSSYWmZZvo3KQZuPV9n
	a9rYrW0emhRP7THOZlLHtBJ7OLPPasFO74PkjQhyu+p1+CWRJgRYv/ciB6MbFPtnbo0NSYqnLeF
	UT0ls/JWZDo7h/oape0EYJwPnPoCpHhrjIT16CxZqAEvr5ti7s+wiZhrpItxwG0VL9jRKf6mj+y
	pA7zDJdx/LzqxMDRt7E8IoMwB/i7OqR4h6Rcuh3OR64fmJ9OYq5eP1N5mmKZ2KCCp0x/JA7lWjK
	WkYKJIGhl0rsNuo/3QSoJyKxWI10=
X-Received: by 2002:a05:6a00:21c5:b0:848:48d0:934 with SMTP id d2e1a72fcca58-84ebdf7f73fmr1398134b3a.18.1785401689844;
        Thu, 30 Jul 2026 01:54:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:21c5:b0:848:48d0:934 with SMTP id d2e1a72fcca58-84ebdf7f73fmr1398111b3a.18.1785401689364;
        Thu, 30 Jul 2026 01:54:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe23120sm2774402b3a.11.2026.07.30.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:54:48 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH 2/3] remoteproc: fix pm_stay_awake called when work is already queued
Date: Thu, 30 Jul 2026 14:24:36 +0530
Message-ID: <20260730085437.1240215-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730085437.1240215-1-mukesh.ojha@oss.qualcomm.com>
References: <20260730085437.1240215-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uotd_Zt5HfjlLXOrGwqozZQVTogvEt64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2NCBTYWx0ZWRfX4Q5m5jgqjVwG
 YMDD+8CQxTg/g028QRcijebALZVUnufvZldKOsaBB6vUM1pzEz4/mNSJVICJAbA7HVaZlmLzh//
 O+8JjfOa0J0ueNaAsmlndmSd2fYYRvaMAllvCL2PZJlgv164Ve0O3jekm2IZIICROkCUJXH25gi
 qg1xP7FChlijAXve8NisEfbQe0vgPhOEgOO9mPTEJ+KmO3qes1n5IoJXS8C6m9gtlcw93tqMPQp
 iGNVSY0M2iIKx64BVy9qq6s0PEG8PyNn7NevVxzlFsmszIdo5t6p4iCuvNhdpAB68/JdDjwmTII
 nPFxseueXkdLsXzVMdqvTitnN1eFelWJvb4gvnd2/zJsYGmavFQlcP8Kh10Ag4uZ7gRPw6WV+Gq
 wbpcCACFB99dHwGkUDqEuuORWrqqYK/eJrIpBu1bersO0lbZ5+OxGvSInrJnxPUKCicjx/u/bw0
 oNAzKKVU8xaVyvgBzAg==
X-Authority-Analysis: v=2.4 cv=feydDUQF c=1 sm=1 tr=0 ts=6a6b1162 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZZkLIo522sJWJ1NZv_oA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2NCBTYWx0ZWRfX418anijXaS5m
 +OnYoNSSIc669v1cLt3oaMG9Yp0OTZXtKaO5eN7hzdiQ7mOHy3d1Aqt3r6ar3TlAsSDKj82WO84
 tFMcoRDh2ik/Z7NRRDBWKbedmpi3rIs=
X-Proofpoint-GUID: uotd_Zt5HfjlLXOrGwqozZQVTogvEt64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300064

rproc_report_crash() calls pm_stay_awake() unconditionally before
queue_work().  When multiple crash sources fire simultaneously (e.g.
watchdog and fatal interrupts), the second call enqueues nothing because
the work is already pending, but still increments the wakeup source
active count.  The single pm_relax() that follows when the work runs
leaves the wakeup source with a non-zero count, preventing suspend.

Move pm_stay_awake() inside the queue_work() success path so the
wakeup source is only held when a work item is actually enqueued.

Fixes: a781e5aa5911 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/remoteproc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ee9354ff69f0..9d36e2f06348 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2754,8 +2754,8 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 	}
 
 	/* Prevent suspend while the remoteproc is being recovered */
-	pm_stay_awake(rproc->dev.parent);
-	queue_work(rproc_recovery_wq, &rproc->crash_handler);
+	if (queue_work(rproc_recovery_wq, &rproc->crash_handler))
+		pm_stay_awake(rproc->dev.parent);
 	spin_unlock_irqrestore(&rproc->crash_handler_lock, flags);
 
 	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
-- 
2.53.0

