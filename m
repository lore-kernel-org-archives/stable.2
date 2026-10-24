Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837839;
	b=c2kvjYJDgM+5Q7JmYq/pe4TwleTRMlR2YPQn5M2ae8+Cpb/NCysNm9s7tGgGb7M1Ayuj
	 7qSK7clAxrmgub+Z18yvXDRMwVQpetAltUe3RtrA267GljnYNyBSZ6eg5I1xFH+giio7B
	 jlbHF6hfBB80KrnBLNo9sKH+HqDVtpN2JId1z3gxG0h9Pi8vYsfs2m90YhKPs9Lnm2q37
	 AE92Sre5L1iz554wgkuP9Kq880I9dxkEe+psmolWKW3wjcimnf5qy8f1R/awKxqTA//3j
	 w9HX9M+loGG9AJH9+1VuVUaiUSe8SUvdxsf3ZeVwSQcwKaUpNX7vJ0l2omEVmEhjmjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837839;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=V5NtsJrgMbZa3kkzwniyhCS3GJ4Nc1QusU2jPyKMY3Y=;
	b=0ajq6JEM0jWQ4lRc/oFXbx0D04mGgA2hjyReMw912YALGL0ihJnAC556y5g293c9D9t+
	 OkirA1zQOLwAVc3sWZ6E63Qyy1nwrsxxogatyuNPV6KW5gjwEhX7LVPXI7edu5Fe6EgbJ
	 C/SQn/GgH6qOcInnK02EfMwpzFB0UEZvddr/H3UPfxUBh5u7GWvF9n4DBSh52vuS0CKUB
	 GzGOuNsfqEwMtGqjl5+FCX83p3bBrpirL6LH4ujxHvQ6ayT7jusXwKt24r1ZA1CNmMirA
	 avYkWV9X0tIkQaU85wyb4Ezuaifk0Wx7loeNDDTgjdqXkvapxW0ogGNHnXqaupSlwGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ2tZ4Gd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DNIP3InJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7600606A322
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7600606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ2tZ4Gd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DNIP3InJ
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O8pGbN612963
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V5NtsJrgMbZa3kkzwniyhCS3GJ4Nc1QusU2jPyKMY3Y=; b=UQ2tZ4GdoWKQKtiT
	q+FZTNWFJNKLrrMOpwfg+zqTxl5U5pp107+K7cMGpZX8tnoz7m7YLu1flC5Gy/7c
	CP7YFWUmn4B/LFS1f7xo5wyECNEjQAjcm+NQz2Q2ZtR0hM3Gz3dKS82uahOA2aja
	KLPPObQYxkPKQKqfFX24DjEMwP2QR6tsE4HCYZCt7xW0k0q/aS1UJFcWQFt48gF6
	S1Ndk8KM0655S538UgpfnuQzJDsw0gpFG0jJNIeHBSKhxlvh95khEPk/A7nSuXdP
	U+RAA9f2iP/rqtnukJTSQvoJqBfmFwaPYk5JJY8LVefkBAB9t24G5K3DTcjH22kG
	J2AjsQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehgmrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1663fb7e005so2026854c88.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792837837; x=1793442637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5NtsJrgMbZa3kkzwniyhCS3GJ4Nc1QusU2jPyKMY3Y=;
        b=DNIP3InJdbU56PhpOpXEe19XyjPrZKBqGoD6PA2bzYvCiFGlhEby1qLF5X3ydoz7BT
         ZBDqVlsU5BTcmdXzon3dSPJmIAEwNs8bupiLDvhSUnfJIY2qN+OVeWcQSDKiAEVKf3eS
         bSJvlh9QcMbskm/4Fq7OA80v0/hbmFHS+SDePBleS4Rp1FpS01ThxeXn5DcUBdd7JH25
         8WQmh8tkCTGhkUayXaTACNDeJSx7r7Jzhp80ZxPH8//fOyi5dKwlzShpyJqR3U+VuOVw
         7Yea+6lqj6p1ITuUtI1oKM2S6CtBPMeg9fU4in8HgD/tIzxw5Cxg2n58A/cWipMs7vyy
         B7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792837837; x=1793442637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5NtsJrgMbZa3kkzwniyhCS3GJ4Nc1QusU2jPyKMY3Y=;
        b=z9ga9H/wFpesWvKggGaAFX7uRM68Muvqw0oejw22fvoZbAiE9PE4Iinti4vxMqmqgh
         UCQw8deKafbXctKhVKM+P6iQPJbDXoXQcSLrgQ2kMsKW7xk/aLZ8sufZLrsPfU92+zgl
         zAIKJlFdTrRn0QBHReK7a0OyUovAQn6Ms/sNy5Mi8S7juEKd1mVpvh0KBHypZ3QDNZRP
         P3pMfrGQuNCU6TsftBQoBmc0YO6F/+JgNOjngxYmg0nbSkeShtcT3pkelzFh7sMJKm70
         jWkQ+V56VdSkJN/rwAgSZud9yfzNeMF2843Pzwiy83UBx8Ln7LUH7gW/kDs6rrIIyv1J
         TDDQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3gG6miA3qJ+hvHCmAdkDowbpDknOB3GirIzCDhC3d+zofi2zk43mLF5iw64QR7nKYyHcMCUA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKes4J6OxZyGvlUBSNV+1/c3ebrg0Q5oRsiYtU/psI+wCW3ZOXJ
	trLukifWZJFpuFdcis4mbip8VLAIouTWrMTr+kMOYTMyOsMBaSOqCAAqvaEDAr6KewlHUJ5WmLH
	jRlVl9zqw57oxSO/HATN3XPzMatLTkEfc2vdx8VCQSNAssAOa79sB9+lM6sHWZKPCnPA=
X-Gm-Gg: AYBFou2vALP9eWikrYXtLNKNehYLH5yCendXKZj4m1VctiHq5zKT3rWH/AQYrK6UG6Z
	M9BDRrUoJvordE1KTQFEOy+3bqA7geQF83PZ54hXNYFpKk8Ejvbw5qblE77pTqBoUb0Ps1haGCG
	rkwmkNcaHgSEVP2hq9VIVRsn9I9epgfjfIR6Umi2APB2o3jLu1Ma3C0sAFhj9nnmes1DciUHUDY
	igZdCzHyZQC/8sI5v1k3RON1L6R7djOAhT0Iro5YToOws3eSD75yCe1l+DtC4RlY9862WjS9Lz4
	EY9NjNWiHvyn4QKoK8zpOQOYatSLWyTl272yoVNuVpP1c2buram67vL4q2uU7T02ySJR7n2Q9B0
	wx5aGSO9ZiA94M0nKCKvRrcY=
X-Received: by 2002:a05:7022:5f0c:b0:13d:19da:9370 with SMTP id a92af1059eb24-19935437c7amr1906332c88.17.1792837837165;
        Sat, 24 Oct 2026 03:30:37 -0700 (PDT)
X-Received: by 2002:a05:7022:5f0c:b0:13d:19da:9370 with SMTP id a92af1059eb24-19935437c7amr1906294c88.17.1792837836569;
        Sat, 24 Oct 2026 03:30:36 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:30:36 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:08 +0530
Subject: [PATCH 2/8] drm/msm/a6xx: Fix GMU shutdown idle check
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
Message-Id: <20261024-assorted-fixes-oct-v1-2-2977f974ddb7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=2051;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Ow0o4P+y/rXq/ok/jal9ZHL3oAONSo1ouiNN7Pv7Xiw=;
 b=juC5HV09ueBy7MXDLOeymT2cZOTCtGhYie/nkZhJXoUX2FN0NqE+U875EE+/PI+VSWr+VgsGM
 81kh3FlHmyIAM1CL2QC2acFv0jT+TZEM8mvP1lwKI2yVxveA0Vn4kaT
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX3dext5j46Q3Y
 Sm7qzhWh0VzymYnhB7d4YKZZnzi/PZpXyDV01LK/Axqtk8Rb8CQHR5BN1e96MFNX97SlOoYk6j4
 +Z/heIOeb9jq6/bCHyl1LbXhhrfkpTI=
X-Proofpoint-ORIG-GUID: LNuDURS4XbhqKjTEEOuz7Haebl8nnaWq
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adc88cd cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=l4a7mcJWk0S3Zsek6REA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX8uyqwe/rAOmW
 dCBzGOFkEOy29eVmV3d9svycId/F085lUGlAtc0U+FjlaX/Ejz7Wy/xLMsMUgsFY3p+aiMHHxb4
 YFKa3r+zQPx3BoI+nzC5YYR+1XpB2ti+vbRkJJfQrvzT9nCyUN/WK8AKZvZUonQDSFm6vqQ1M5m
 ocQCFePdbK9Wu2K3sM44x1jRPigwT/jZsMfxMX/b6efIJE8t+jCgeOENpFadXWrxKvU6p0f5tKI
 TkeI6L+HhONimA9v+owGWwrvIpKQ41JoSge5Qt8SsS240c/MIOnTYQKuirMjRX3DpAMu/jZKTYf
 GFjNe3WjmM6wWX9dlVbmsyxr8/MU/+TGlQgaDgqEV3cPqNIQtTZZvU0siA+raq6KpsC8CvwprMj
 3dgHn99kxpQcyeC3zYKXjLKvPRQ1oRT6QF/ams9GEqJJCDnC5RvYy17ALBEC311Lz004Tx+PBJd
 o2ytaTBQPhE3Yx3w9NQ==
X-Proofpoint-GUID: LNuDURS4XbhqKjTEEOuz7Haebl8nnaWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

GPUBUSYIGNAHB only indicates GPU hardware busy status and does not cover
the whole GPU subsystem. Use CXGXCPUBUSYIGNAHB instead so GMU shutdown
waits until CX/GX/CPU busy activity is cleared.

Also, increase the timeout to 100ms to match the downstream driver.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Cc: stable@vger.kernel.org
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 4 ++--
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9e02d6f939af..7e80670736a6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1461,8 +1461,8 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 
 	ret = gmu_poll_timeout(gmu,
 		REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS, val,
-		!(val & A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS_GPUBUSYIGNAHB),
-		100, 10000);
+		!(val & A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS_CXGXCPUBUSYIGNAHB),
+		100, 100000);
 
 	/*
 	 * Let the user know we failed to slumber but don't worry too
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index b3082738c99d..786fd7d2f674 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -224,6 +224,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x23b0b" name="GPU_GMU_AO_GMU_CGC_HYST_CNTL"/>
 	<reg32 offset="0x23b0c" name="GPU_GMU_AO_GPU_CX_BUSY_STATUS">
 		<bitfield name = "GPUBUSYIGNAHB" pos="23" type="boolean"/>
+		<bitfield name = "CXGXCPUBUSYIGNAHB" pos="30" type="boolean"/>
 	</reg32>
 	<reg32 offset="0x23b0d" name="GPU_GMU_AO_GPU_CX_BUSY_STATUS2"/>
 	<reg32 offset="0x23b0e" name="GPU_GMU_AO_GPU_CX_BUSY_MASK"/>

-- 
2.55.0

