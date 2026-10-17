Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DD3D1ABD
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207037; cv=none; b=DEu8tFP/VfKi3LOzsbmJyvgpxO6Sj6JPRRSCXpDnLGKPxgBI4dPIoVodPbuX/18m2imd2haC+L2sdDx8Tl+Uo0izfZNQe7A2mdgNVB7o2jkFHFJwbFnAllIZyF2BKqR127Ch7wdWCNVmkip2w+MBAaFB2XLvUPybu2Mf6uLpaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207037; c=relaxed/simple;
	bh=hVspXbe0sCkaXoj1fe7zHKMem3/ix0mWkb/2R8o/yYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQayWVM+GDUm95o8RnDcSrJcx9IxRaVYuzJTRyRQy5sykSV1X5GjSmy1MT/3Zn74jTIN5v7eTHFmWMZ8gP4AJdU/9XLIuz1MxL246sdjnfQZz9E4oatjQFO9ABedVa4gXlrZUniwOlI7+L0Yxff4I8Dv8fqCTcWjn/XrhEWvDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bc3bPlBr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ajmV5Y/A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bc3bPlBr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ajmV5Y/A"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H31IkG4087044
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WeN0lmGHanzlBT6I4estf/cTW+4Gl4FJbWILgGaJfb0=; b=Bc3bPlBruErJq5pZ
	ytbBCffRYXKrvyZZcKBAMIrg1FH/dhBTal+A9LXmRXDcD3GgAq8dkaZ3xN5i5CZD
	6M6/l+xbesCflMIGzFEvwbTLzbD+RGxFqSFJ9oqrAcpx54UP9TOkxxJ+m18KM7gM
	ywQopcPYTI/0lIv8AsShnXoiM4W+3zwRJeL6kamV2kWfW1U0FuRWO1BetOsHqReR
	ouLLaR0iM+o19LLDWcPLWrGbmIlBORvUj6clCJfwKEk0xHjmF8awRe25GePv5+sG
	ySvZ1lHl6WSgd/Fm4FY2boCTwu6VPO2otyU4Bd43iHGuwHnCsFp8jm958vjLfro9
	+TK8uA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yunhg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:17:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso894559eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792207025; x=1792811825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WeN0lmGHanzlBT6I4estf/cTW+4Gl4FJbWILgGaJfb0=;
        b=ajmV5Y/AmsunrUTyCsKVNrtT5sQ2s6Zr0SBn6Cy0QK9vrIkC2FIYklabwQU9j1vSM1
         qvxqi+px1wlAer1Wkdm/zOhmvDxw2aIHHSt7ZSWtuhnyY1VLhei8Z0NBNDYIQkjjKZss
         UL8sC74AfVbiRTfb6Qi4LE1Wdq8Kjn4RmREZD3ZOble+xnIfEc7PXyPyvkgxMQ1uXXgd
         urkdoyjU5xoIJk3AdpqbA+KDtbBmdaLeBXoRpWKvA2ldu0FHUHYizeyQKremOQZTjaze
         vTMGjkIQ9ZnrO4n0RGPlfs+7WzmqMID801xgQ5dgCgPZZjoPawRfb04sfpvlWqUbTbpp
         aYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792207025; x=1792811825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeN0lmGHanzlBT6I4estf/cTW+4Gl4FJbWILgGaJfb0=;
        b=rHVRCCfljB3d1yb3SObefdhlC+5v4Ko2bFw8e2nmEYgyqnmA7N+tZNMUa+g/mxqvIb
         tP/kdhG+L85t2/Qc3t9dL8dFCsms7lRF3iYHdtsLN4lMpDeVvVBT7Yl1mPKNiz92xnss
         weQYBfXs3dLyFP5aP8bEVvId8GA6hKCtJnuWWIjR+KQzTb1vK9XtB/GPzUdsIugNYd3Z
         huBMau8U2hEB4fkV/pp+8Qzw2DRPR2O48ZQqdUjD6RSLJVA8Ywjl8PsQ3zlTAha52gwE
         1+Z6v51sIindVzGc0aRrmXzdzc6AuS41SjKxvc3U37YWxFDTv17i/ManuuT7O/Ll8+UC
         HmWg==
X-Forwarded-Encrypted: i=1; AKwUvBwsDbwt3pI5JV0TTotdnGT8H9rD1SHZMxvGqMvFJVjXL0ssCCibEsj2NLZeTN8BGtOYPELuEQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJntJ/WRyawM7YYnLoDWqyEB+hBDlqR9qyQOWshPzOdOtIx9aZ9
	A1gP1H15LOczAdfkcO+MDiob7zz3bvF3hOE2M/RAFWTdwXMul46hSw4Rkkf99RoGWwCAq17KyPK
	30+9w1YVTriQ0Le0dmG7fZ2gvJOBN9wLHjLfWDeEfUZK5HPHqhRKqyjDnfjo=
X-Gm-Gg: AYBFou1MwAuNQxISXwmS+F77u+1phfqI9gPjQn2IEkq30LnoBEpwwK5T/x6DXs81WTl
	luI78tK0nRN6BSX5f3mcoIMPWhXNueTQf49o4CJkcacWhXhq8s8RtuoeULEHva4veaBCFdN1ShH
	O1dmjcawSkrRL7SRaG8d8Fw3F0AvQCA5QV3HPA5inm8igDOGY4cKJFsNS0L9Kriioyg/TWFM6n/
	u20elFghZ7WLmjEZslwgkcsLoBeRMXCVixEE/DP7/hv0mCnAGEM3eab4F9kbh5WcECj+Rc9u2XL
	4ZlW15Qy3u+JH9PRbNzGnBNUGxdz7mO9WsywXpambHxsDH6Ji3ZnI3Je8A1RWH3RmacwjtkgZng
	5nTkNggUJBxic31RLeBGPNSzNtuQs3gH4IQ==
X-Received: by 2002:a05:7300:7aa3:b0:35d:74f7:3b9 with SMTP id 5a478bee46e88-361a224ccf0mr2068923eec.33.1792207024552;
        Fri, 16 Oct 2026 20:17:04 -0700 (PDT)
X-Received: by 2002:a05:7300:7aa3:b0:35d:74f7:3b9 with SMTP id 5a478bee46e88-361a224ccf0mr2068892eec.33.1792207023810;
        Fri, 16 Oct 2026 20:17:03 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm10969995eec.4.2026.10.16.20.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 20:17:03 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 08:46:18 +0530
Subject: [PATCH 2/3] media: iris: Disable the system error work on removal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-iris-handle-unbind-v1-2-7809148eb90f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792207006; l=1330;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=hVspXbe0sCkaXoj1fe7zHKMem3/ix0mWkb/2R8o/yYA=;
 b=MzOE2vjbeiHAD8eMD5zXsT56tnSTVTzlFXQQT1BOO+Zx3e+Z8ZyDeIfKEqnB3r0LbyHgD0v2r
 kF4egV4YjHiAUS5MEQKXGec4ziYkcrP/dT30+2UTEOjfeCdrEsbEeHp
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: Yzh6wThKeS7SicGrFdg8X2uBfehconL-
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad2e8b1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bZa8m19-NPAJ73ByzVcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAxMiBTYWx0ZWRfXxP36l9Q1tUK4
 w80ChQmbHPscyOg0cHq7efVV3PNbVHgfMDU7L0P8Aa4UuBGNz400RycPyzP5jLOq5lr5CigFl2O
 oHL/QnXE8a+FwiH5VCHYqfNMTxNb80M=
X-Proofpoint-GUID: Yzh6wThKeS7SicGrFdg8X2uBfehconL-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAxMiBTYWx0ZWRfX2t5wwzrdCraa
 JoMjTG8gr3W2a/TLWiKBojR/nqXMiORtrp2mXk74naRmKn/Eh4oDxio1XuxTI8GzQIvh1px6Foz
 H7fSP5Ogj5kZ2jLSdx3KZGHVlfcOLIly7ErJ7ZmFAEJm9buntK+UusJcxlrtgFmbI5ImCfPiSpv
 weTAvZkgKVJaCvjIWGOefAG3jkIgYs4enVEAlP6Az9KqNfJ1F1OnIDCdAlIAhBnG4KfYAbtug5T
 8jjALxovz2tyWGODzR33ZJ+CPrmzrV/lF0FXPbC8PctjKtqMp/t50S2nbeYsnRPseiqVMFYdC94
 1rp/55FQWBvLDjtxYWSEwPBdzwV8L4V+zELTRxZ1twH6h0QcayG+B6V74utR549hoGoYR66rNm2
 g3FNETm7x1VIUA+T7N6y01XXJ3jXtgYYjFSsz0iY5in+xciEC5g5KvU+oHqnE05bfIu3V9BSOQ5
 0oOSlsy3bBxme5rKnww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170012

iris_remove() calls cancel_delayed_work_sync() to stop the system error
work. This cancels a pending work and waits for a running one. It does
not stop the work from being queued again afterwards.

A system error interrupt can still arrive after that call. The
interrupt handler queues the work again. The work then runs after the
removal and uses resources that are already freed.

Use disable_delayed_work_sync() instead. Once it returns no new work
can be queued. The work cannot run again during or after the removal.

Fixes: 452480931648 ("media: iris: cancel sys error work on driver removal")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 41dec90f3e2b..4cb678bd56f0 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -251,7 +251,7 @@ static void iris_remove(struct platform_device *pdev)
 	if (!core)
 		return;
 
-	cancel_delayed_work_sync(&core->sys_error_handler);
+	disable_delayed_work_sync(&core->sys_error_handler);
 
 	iris_core_deinit(core);
 

-- 
2.34.1

