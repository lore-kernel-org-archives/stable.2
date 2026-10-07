Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACA49158C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372716; cv=none; b=TlJTpxjKv+aKQHQEzOVaw6VyY3SITQWU7l/shrhiaE3Qu4JIfzRFNKJ3uh/G99X1C1+0R0XxhZb7Kv+pSn7u91VRYMedUN3T7KAe/F07Tk1I/tcH2CMU/Y0aMpZ8BSVzXAvOLD+nkIXMfG20rlL/zwwz8LzwJd6fmQ3ECnR70wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372716; c=relaxed/simple;
	bh=OJRJ4n6Rjp8IwVJxm+5+cJyXLWroXFMzWgufd/STv+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVGYU76ir7y/aN/Sn5zk30fZ5Y4wPYt7+zH4luwDvCzprGf0/KwiLYau3OshKRh8W++Opf5ednJ8nOhNYsMC2Mwzh1M8ijgf8iw4Oj/WRiYjTyVOjShGeJxh+mMBop3CJgv01b7zNrFj6bYXWJTGm2DWlf+jPPNYA3djAn4Reyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gB+2k4nU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fOicsOKl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gB+2k4nU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fOicsOKl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BV65m609851
	for <stable@vger.kernel.org>; Wed, 7 Oct 2026 11:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ziTRJRTyTHrXpykIexrVW5H3SlT4DMRvLBq5cG0RzyI=; b=gB+2k4nU+XxnX+n9
	czX54suZ3o0DkYYT11zAuwdCULDrb7tG/X9J8VnRTDvDgN3dp18utPmWBErIGMaP
	str95OM/0kIwrWVct2IVvFZUM+7ze5diQ4YkKbspWS6ZeBSn3kYOS/bKzQvUca+R
	aZQ6iJSDqh2/dBFpVGDrLtl/hCzC8lFKRtAqJ0Iw5SxBQJrSqqDjOfEy4997YK+D
	uWA24ql0Z9mzchJRpQmcBOOQ/xanKQI0u37f6iTarIDvCUEXSlnOWQx5DIWvPlsH
	xF4a3DjV+CVai0dQQnQDwmPcDMb56JCd1v93k3K7SBKJ3SIagJImomZd5BSaIsR5
	U3c4SA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc597bc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 07 Oct 2026 11:31:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a4aa263a4aso4044570a91.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791372699; x=1791977499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziTRJRTyTHrXpykIexrVW5H3SlT4DMRvLBq5cG0RzyI=;
        b=fOicsOKlV9ZODf0o2njrBIDqhQvj/lawDyR0WIo9FrKiqhuvJ1khThUMxYme7/GeYF
         fG4I1barvVNbPC7mWummvI5KZssBsIZXjFrC2rzsG17Xr6QQVAddKRsazTecwtEuJzJO
         5bkUDo/I7UnSyCxKim8FnHL2NXr0yFyvMxh0s+cMS7DkUjJOqMsZG/df8DmJJokOcsrn
         //wqYsxmuW+Nvby5YqlNQGSgpmAGIm8rOl+fzj6BR/Y+Fiwpo6ftf1Iyv0OcyLHevuOX
         k/qL8W36tsxSnux/bsoBaDnW+YOyXW9MxAFW53uIO+ytbTC2EghdVogWVwMOx9n3pBor
         S3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791372699; x=1791977499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziTRJRTyTHrXpykIexrVW5H3SlT4DMRvLBq5cG0RzyI=;
        b=OF5FhIozHcKG9igfhL0rdwMrs7D76+6YO9Zepw97RjKxgdYRKgRNcN1dyg2pmsxQPk
         1RUR/fgLwO7yL2hjwQUjcaso8EZoP9PWOV/Z8aOrG2jFKwTcDhIeZh4+2PtngYB1OElq
         T9r3ZtWC6XuVdGUerbvuuM/PipueMry39FMC+A6ipU38AWoTo6ujsorszhG/HvHpKGFD
         OK9MGF00r0qCDbv6NvILNgv61GXKapBcWu8b7u0YEThyPttI7lZpp85O+C8BgIXXZYEm
         KktSTYsvuLi+i72dv9Om6U/Qs0EYiTk/JWAlDyf4gnAW2RKouldWe34fOGlG0sL+7W7H
         VuFg==
X-Forwarded-Encrypted: i=1; AKwUvBypvLeE1O5CeREg5fhT1/FodcbPe4CzyN4Y1gxXREzcY9oB4CBfyAlFzDnWcxKPOqvHWoi3BpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx8v1lCpYNOc6dwANvNr+obGkuKdslSScHCK6pVEXqaXJQRtwB
	YdpDLbRGrkpdcK+M679IZqavDQjmmtdl9TxVAaXPvj7HQs5+rGkFHrDblV4SQJssPdM0NeIvuwP
	9W21ja28vdW19xvJFn9N4IHqVB9wqRUH202lpxJys0dKvCc8Qv1OYLRGptyc=
X-Gm-Gg: AYBFou0TIeLysX3Q48DR0kpMdwbBXb3KcOZgVw3mWw9/uo39FUmDtR+c1bwUAszkOZ4
	fw3U/Fr9NHUdnwF5AR1LmUTyKX9J368LQWNyfsXZ2SIObdaKYc6/b3esko1q7MXwylpUxcvZKAs
	ClcHT02/jTZanpnTjvPKBWLBKy34mSVwk+ycw6eH+pFB35hT+mLfofeyJ9SHmhNeuo+yrdTKobG
	HOw28ncPLFxiM4FuDlp81/gazZ7sX/AbeDX8pvaudWJ7aOb5W0nDWHye3/tXXTQJw3h2GObAJrQ
	r59qKwjYX/DQlXYtxx4cu5j2RiqaP9EQRGZVI+pFUfv4JTTSGn0zG4U9XcbyrcdEapqeQfsW3zg
	911s0Ui+Isx/Mn0eWKtbWO8B+9x4128mRGA==
X-Received: by 2002:a17:90b:5887:b0:3a8:495b:d65e with SMTP id 98e67ed59e1d1-3a8a0509324mr1473444a91.6.1791372697106;
        Wed, 07 Oct 2026 04:31:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5887:b0:3a8:495b:d65e with SMTP id 98e67ed59e1d1-3a8a0509324mr1473424a91.6.1791372696629;
        Wed, 07 Oct 2026 04:31:36 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046fe0d9sm8388515ad.20.2026.10.07.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:31:36 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 17:01:05 +0530
Subject: [PATCH 1/2] Revert "media: qcom: iris: use disable_irq() during
 power-off"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-fix-disable-irq-safely-v1-1-45746f9a92de@oss.qualcomm.com>
References: <20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com>
In-Reply-To: <20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791372685; l=1211;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=OJRJ4n6Rjp8IwVJxm+5+cJyXLWroXFMzWgufd/STv+8=;
 b=Z7GoTmlct4HZlMxWwHDHbrNoLZPNxj554mA5a1vTb/et2ymndTTHPJpHgH1Vzo+2yKEBfGRJ0
 VBrv65Ryv9YANHRUUFJWfqQJmH4ig4O0VHNeZgwGxA+S1eiXju8dxqm
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NSBTYWx0ZWRfXxgHukM9Q/KrW
 dR4plML3UJ0UXqdV2zW4d7aHSLUV1vSoH8MxG091FPPMFm85Zf0R+2eIyJrCETbn/mvCOmKB2rQ
 FvGKDeFVfvJ1qkGTPVz1P8ZvbGWHM5E=
X-Proofpoint-GUID: W9_wjxagLpDxFZKfQgOsATt9rrLV9YrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NSBTYWx0ZWRfX3H/5TCoOzC2B
 mBI8Ju/QEoI1LC5Y7oMCsEjA4TScbkUBX4sUQwMAqKx958zgQw1nA6+A5hTs9cSBvKW+PinJGqU
 OrZ5fctGnjJh0GjjPOfB0Bgg1bccJEgG5eR5nUbALkdy1coh6qGVd0Qkm+Cg2nFKroGXGtGKw0t
 aZnp85Woz2Lf7KrYL5PcPwp+bJmrXKoanl9tEkvYH3ymdzDtVgU+vH/GZ/eyuXKnNlm+A7D58UK
 J4ThM2c6BEmEIb4g+w9lw17yRYvdbMjk8jRz6dwVM6rNodIUg9gX3zJPTDIPrrfhvGEuogr1YJ8
 TA/IVndnR06Q2GGRkNVZ6LNZd/A1ZFkEFhoS75/97KNM0tyxuziK/xr39TZa3eYIPOzNAxi9cVx
 /5Vs4U6QXW7Z92tlQBk2oAjswRnpLGqcNBnrozt9yZMHOVLkU6HaB/Re3vyD3wneCE6tf3Nr+SC
 Vk1tqC9kRAHQ9B1REXg==
X-Proofpoint-ORIG-GUID: W9_wjxagLpDxFZKfQgOsATt9rrLV9YrR
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac62d9c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9tjrYt7ayRFslicBUeoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070045

iris_vpu_power_off() is always called with core->lock held. The threaded
IRQ handler also requires core->lock to proceed. If the handler is woken
and queued around the same time power-off is entered, it cannot acquire
core->lock because it is held by the power-off caller. disable_irq() waits
for the handler to complete, resulting in a deadlock.

Fixes: b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during power-off")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 243bd845349f..1e183fc4e58c 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -240,7 +240,7 @@ void iris_vpu_power_off(struct iris_core *core)
 	iris_unset_icc_bw(core);
 
 	if (!iris_vpu_watchdog(core, core->intr_status))
-		disable_irq(core->irq);
+		disable_irq_nosync(core->irq);
 }
 
 int iris_vpu_power_on_controller(struct iris_core *core)

-- 
2.34.1

