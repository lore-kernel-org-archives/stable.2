Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFFD1ADFE4
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652065; cv=none; b=WQDjnnvk0s8+S4j1tIWIUS0hviY2T6dO4c9UoOY6qMqo856ecNjiLXZlkDleYlj5YCjJ07RtAOmCQ3YavcjgwFeK+5WfL+lh3YYS3tvaHChm1VUTRVK9Ih7xthTKxAp6pZCipGNAznPZ99lHgKLMfyWnBsciWGAnzFGx7J2h/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652065; c=relaxed/simple;
	bh=7qGfQqNS9ydusBK8Xdl6zQRC0MGGIKcZHzIJPyGleQQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BcLwk1TxT5E+u4AkXl6NtxtMH4x4+Wqed1kyegChWbsnvyCWvlO/ncC8/NBlaDzwc9viHMYc5dhtBQvG9RaRvItLuF6jS+8Qv7aKm2xTELldWkp/SaG8ZfgPpH9sFA+VseVaXvMOwbhmwznSXdolO0De/Th856MRE9vEfv2SyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I4AbOs+2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heVCuf1E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4AbOs+2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="heVCuf1E"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A06UcV3357461
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u1SBCCFLx4Yl65ZIU3T88g
	9p4TgvqnsbLOSECaXWRNw=; b=I4AbOs+2LFwJy5ph1dd5oaxOE1W0NHyugL6kQC
	gToSpmBpoZiHAPWnkPcdshEfirsJ/+6pp3e5h0SkI3ixTn2YgUVU5SAKy3mhHPt9
	pTjizNJ6VWs2O84uA6b5L5yBlbsuA9UXkJt0y7kEV6Xbu3nb0LnsH5aupu0c3bJC
	WxQKRYjQrS1OpK14n1rRRn5ESGKrlGm4E1ZKs5d9WCACX4WsLCidHDlxEtL4b9al
	X6X37CNnvgc1NE0Ty3QTKmNqkCZ6mLCkGbk3dZC5Gbptgp9GlwdN7LJki/7SEG2d
	0WenEMJ4GXDPGfqBjgxSMQkNAHMIqVmD69Va5LnHai5OG0IQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe8ef1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:54:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so672486a12.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783652062; x=1784256862; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u1SBCCFLx4Yl65ZIU3T88g9p4TgvqnsbLOSECaXWRNw=;
        b=heVCuf1EHqrPkjC8QgBItv2nL9NJwAYPxHQVJC8n1D3gEWoMNDWBDpdG/YQICUECTX
         bg688kiGuTllXwXd4qz67pNdcnzxEhuR1KSEneWQzrI5kXHAjZPKlmioMi2BZk6LxbXA
         9iGafLdNcnwHSi9ZUeHIzHg19wuwhouPiatV9i9DR4LHhzJEQ6IKfC+9ZXP3YwQF2FKf
         5rZj6FPpAyAoGCVqWvJ6Q0iP9d/cWjV1IS5IVyQ0R52PZ525XAR/u00UiQ8jQwq1FaHG
         G5LGEFb222Btz+6XxDQD3Z6GhcAl6AZbD7PQO0N8a8hYtTuT8oleFhSjN3HxOiKEPdBn
         oMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783652062; x=1784256862;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u1SBCCFLx4Yl65ZIU3T88g9p4TgvqnsbLOSECaXWRNw=;
        b=BbWDJkd2CyN2G44p83VGjVUoiqtMakqH0pjBYZNqPmlMUvqqm2kw1HFj7QL5eKurJU
         Ze8Efaj6tYx4s90RNEqHLgr+cJEEODdO4D9eNEz5J9Cwkz3EYpEyAv67l/7fs7SbxvIR
         G4GYDFWV5caJZk/z5Oi7TOYVW8qEqPfztQr65NcEHBV2MUuWzzFyso1UxvvjHcOQqH+F
         uIxRpAaykU5slVhkfChbjf2gqielwv/XAZNZsULmWOiQ2O4lUVmWb151kbVPpiR7l+KV
         eRNQeiJZgga+Ru0eJH3XVx/yQDzbT7UrPyBDzM+U/W6EMMSAxaIDk6Ko8wDswXQNFXQK
         TenQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0qnEjmtk7tgQtOZBkmwnk4McYO7AYT27CfdYlaIa8DwreWavVVughYHUD+BbhlYwPjIucCP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJV9U1b2hIWrsgv+DK4/fZY00a+rlzC/rdukwQZrwFfoc+jeua
	tGH8sNhmQz9mq5KQEaa+hqKZInXoHFdqnXkTltUG+W6YTISLbm/y0tHwpgwdvUsI5pC8lTFN+z1
	Kn93t3iI6JcH9/LNUTpe1N//vPiLM8RMMDaj4Te0SAtfwyHLbLw2A8VyCtcM=
X-Gm-Gg: AfdE7cm8YeHaARGE0ZyhSVmBceBkmUZEaccNTkQgSo1WZTwflDvxq548ecHUxY0P+DK
	IAnZzeTT/Mn7bLsh2KOh2309dkzohrnoBOvn5+WsqfEjrO5jvP1IwpY6o8iup6u2gF5Hzd8+u8x
	1mGz13sS0no9sifvuJuBdVHY9YsExHCJ07cblxcpEl8DYGIjOXSQYSTYbb1eQFaPiQ79Lv9UHD4
	8gxUqzMT6elmQ4LUzehcptw4nX3rFob4vgFD9CLOQldwIoagQLkbB2KYf7lii/a9vS+7+Qw1uI2
	yx8bY9jdltGX287rvRDOkFzTCqKbeTcGc8GBEBlaj6BUejwEPyZvwKtyyZAE/twmwY5HHvqjeUe
	2rF2Li4LSYvcUUwQIjDZ+0XgKKuCiPHDDlsWOmKsbNOmq
X-Received: by 2002:a05:6a20:cc0a:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3c0bced4657mr11170289637.26.1783652062412;
        Thu, 09 Jul 2026 19:54:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:cc0a:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3c0bced4657mr11170254637.26.1783652061922;
        Thu, 09 Jul 2026 19:54:21 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm41843220c88.8.2026.07.09.19.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:54:21 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v2 0/2] media: iris: fix QC10C format handling and disable
 time-delta-based rate control
Date: Fri, 10 Jul 2026 08:24:02 +0530
Message-Id: <20260710-qc10c_fix_and_disable_time_delta_based_rc-v2-0-701d6dfd1ac1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpeUGoC/52OWw6CMBBFt0L6bUkfAtEv92FI08cgNUClA0RD2
 LsFd+DPTU5yZ85dCUL0gOSarSTC4tGHIYE4ZcS2engA9S4xEUyUrGIVHS1nVjX+rfTglPOoTQd
 q8j0oB92kldEITkVLz67klTDyUhhO0r9XhHR2uO71j3E2T7DTLtgbrccpxM8xZuF77x/vwimjU
 jaaS2ZsIYtbQMzHWXc29H2egtTbtn0BDfzktPsAAAA=
X-Change-ID: 20260707-qc10c_fix_and_disable_time_delta_based_rc-4d6172b395b1
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org,
        Gourav Kumar <gouravk@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783652057; l=1389;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=7qGfQqNS9ydusBK8Xdl6zQRC0MGGIKcZHzIJPyGleQQ=;
 b=nAEHoDGXaAtzeRSfV4ocLXAi+9AaeEm6snAXBGYCdEsLrZTFv9Jptlr1eXl2OBz0RCDcQPnm1
 DJMcj0Z3vIwDQN2Xm+xIEzUnSryZcM0pgF+nl9K5fgFlT5vw7Vd1JVo
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a505edf cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=bHM9EGv_eIyXTYkJAFYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDAyNCBTYWx0ZWRfX4eaXKdYWaap4
 WmOIRYpWS+vus7HvYEOHlaUe4Ly/elqpXd6A20TUsHJc7ztfVzcU8F9pt9db/0SPEyZ9HFQT+z/
 yKBVc5BwPJ0hKdPjc3bF+1FdI3rJtQQHY5eFPW6m8Yfz1RJtg93cqBFLOyzdW5b5K6Xo9k+MkxW
 BllIbGlZrmIROU1ny22gG1Ge21Xg3eeHR4a25nOPJuy0FyOVSQr7/2DECeyX3FikGxTAcZG++pJ
 pUx4JSGixHhL9XQp3PWyD/f2j/LUFPzX85zWQiAm2Rq+ewxm/rG0Q7VAasrCZhwDE/Esi4K56rA
 wOiBW1+clXbAgsUR0hF1ZICNNv1HXTX0IT8hZDHsCzx1lN7fuBcXyTuR/nL7OAZvI3YfN6cGCRi
 cAAwiAw1snW9/GvaS0ABZHDM67+j85arcOrDZYpQ0jOMpCeHUEa5l+ZguX3Fecgm7Ngj15FbCGf
 t1Hl5x/StUTPUEKt7xA==
X-Proofpoint-ORIG-GUID: 1RfQlU9Dlb_883gxIr8Hu4lR6_4tcQSJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDAyNCBTYWx0ZWRfX73yJcU6mQT4v
 VooH7grjqjAG6yytdgp2lEjuUIdtvPAVsMuGq0+BrFmel7JNtPTDuV7bNJTF86V0dQr+9kQX0Va
 i7T5rv4EJdO2pQybsc/GtNcER0HNW1Y=
X-Proofpoint-GUID: 1RfQlU9Dlb_883gxIr8Hu4lR6_4tcQSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100024

The first patch fixes QC10C format requests being silently replaced
by P010, because the bit depth was checked before the firmware had
reported it.

The second patch disables time-delta-based rate control for VBR
encoding, so the firmware follows the configured bitrate target.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Changes in v2:
- Updated commit description (Vikash)
- Link to v1: https://patch.msgid.link/20260707-qc10c_fix_and_disable_time_delta_based_rc-v1-0-33fa130bc535@oss.qualcomm.com

---
Gourav Kumar (1):
      media: iris: disable time-delta-based rate control for VBR

Vishnu Reddy (1):
      media: iris: avoid bit depth validation for capture formats

 drivers/media/platform/qcom/iris/iris_ctrls.c         | 19 +++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_ctrls.h         |  1 +
 drivers/media/platform/qcom/iris/iris_hfi_gen2.c      | 10 ++++++++++
 .../media/platform/qcom/iris/iris_hfi_gen2_defines.h  |  1 +
 .../media/platform/qcom/iris/iris_platform_common.h   |  1 +
 drivers/media/platform/qcom/iris/iris_vdec.c          | 10 ----------
 6 files changed, 32 insertions(+), 10 deletions(-)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20260707-qc10c_fix_and_disable_time_delta_based_rc-4d6172b395b1

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

