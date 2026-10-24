Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837826;
	b=cTHKrG29qscBqhysiv7Ql+Ycz/CAanQmGtAsDaFEDN5VRxqH6Bx95FYgHwwckS+wWkxT
	 9zf9RvtjWwyKi8gqZm/OYmgT4SDB5LCtWQl/3NMysfPxNaPtyetGguV6e1MfDRKBk0Dni
	 KbY1zZohji9OjDZqYUuN0TLNFBdsVn8Qg4f9ubJ9od7fYdnOzcvLuW9FVgyH6RYWq17fr
	 NwHuqKO5opzDzW8V40AMxAy0IN4bkb23M0k7wTueRDB+ic7QAKcABkGzApDJhDkGOLwyI
	 UjGjEcBRmnlbMXzvaLxkLTOpsMgXlWkRiSkjn3gVqN6EJ8nJPXcHAdlHMyIvCcT99JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837826;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/wVlxKd4PkmwhXBNUJ7fMa3qr0NTWTnVoH3SdzxVHFs=;
	b=PHXbwOVSOucXumP6buvwP3EBPfsl5vTbp+bArzWgwPix0JU2aSKfWMLdylSTM5QeOp0m
	 JrG2Q8RML6rck7Pp43FXP6tWG1EhCWPgrx052b9px4g81wdhpeeveLlopc8yINhOovSaS
	 iSkkr0ls+hH9N1HsjTutFNPJNS3aqH6cRAaqgz6YgD5NO0TFuw0FvPiRL+fyQIiAhcXkD
	 IU3xr788BbhMLmOzKfUtay9e/4xJ/lFtL7kGvvKaDmx9xLOP8+erQ/IbX3D3cIKmFW2/Q
	 uizkmIlvH3/OG/F8vwz7e7uPZTAzU4bmnCaCbOux6PceT1Bvu0yckMg17PgQgeJ+YdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JR4Hm3zr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DzzHCrAO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1305606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1305606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JR4Hm3zr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DzzHCrAO
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O8obtb3828800
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/wVlxKd4PkmwhXBNUJ7fMa
	3qr0NTWTnVoH3SdzxVHFs=; b=JR4Hm3zrxlzl2KROHpnuo/Y+G+xQY+Rh91SDxh
	ON4UdTwTEdaqJo9iJhSEbsGUlpGIbY4BuOplsSdlaKfUjrBRDh/MsilEspyGibnn
	mxm/tnTSi9buCG6ZktCy/Bovfn6T69LLChKI/WW0N4xZSoVs4fsrvQGscgr7O4wC
	hz+Xz9p7GHUdM7xI/Dzyb4MKTPYdOwEdD9GrSF6y3vG9NUHCrF8meBfKP7g2m2uU
	4X5u41o4jum14bv0E5/llNPLeTVVoKPsdgWMGLSC0XO1YZqi2x433tWiTAgeyQRI
	xTsMeiItdEBRC1FOz9ru9KgfikouDDoiEV6FNMkAUCpqu/ww==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnuk8kcw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-18b5ee75447so6376319c88.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792837824; x=1793442624; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/wVlxKd4PkmwhXBNUJ7fMa3qr0NTWTnVoH3SdzxVHFs=;
        b=DzzHCrAO+wWJ9hl3A5fYeXoASNYXjYMfuiSYwyipIuX2XjjkWba5XHXufvad2eus9o
         6IKLtnCgbBddgkktNkNKKzYoNcs0Mgq9PMXRSYcSM08eFur9NOO7n/Fgj8uBxzP9VRrm
         6k/qJtNWqnNwB9bZx5qd0dfUfs4mre4PYTSd+Twp+p+RnH0P0DqStDSMoUv9nsuILfLt
         Zwaaqq5SDaqzdZcj1Re7UlnYDKZfv1xMLxE0sCZ07xWVOU1S0SxUcdbMA2gOthX940OD
         eSYQTgjZlejz//UT/2NN3r6AJxGyeSozWOJwTYIHCttcTPis8iZekjEaSsB7uXNs+Uzg
         eZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792837824; x=1793442624;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/wVlxKd4PkmwhXBNUJ7fMa3qr0NTWTnVoH3SdzxVHFs=;
        b=gTnntlJB44IxQT0b7CsYrNOwg4g3WMVLRNJepkALZteoZ4npWlQzFaclR/qqis8QyR
         IRd/Oh1VYCCk4twvQnQbebz4gVtTzTNZjE6wvSdPr8TuBQY3lZCzRYnxXHHMNrUtcJH9
         WB4bmuwW22Ee9OBROdhYaxu5k1WBYr6qVIlw4YOi/wIW6XBfX0rYj/KIS/IbDneakMRG
         rbRRnQ+xIe13NCSJLGHIAxGWw0tA3FYLSm0flUgj3ORIyB4SCgQJ4PLH+JpsJGS6/fbx
         mfCBP5sFKXaVlnmtYk/mZrxZnhSJOqoBOhh0XXmWpl4lOekdpEwe63+WID/4rVNqziQ2
         L12w==
X-Forwarded-Encrypted: i=1; AKwUvBwPB46zGjnpsQ60zhYW7UgHMlLaU2fcJRsQo0p0zm1uLOXlLWwo4tLVX4BwFo7e3Rx3yz6G5Ec=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbRtbvAV6061r3CPFchnH+qSbnYKhpHQBirh3O6K0p+/o1PCA4
	yJQZzyf8sy4bPTz4K2ra0/IheAeYlrJkDvVWu/ypFjkHn4ZBOiQIc7mIXhpczsSHN1HAVmvVgjN
	9TVVOydlflvc+G8f2poYp4M/Zrx2dcsRNgj0wgXUiv6IIYyWTV7p6z4/Htfhf5bLtyJU=
X-Gm-Gg: AYBFou3P9mnDo/bfLmRhR9YjGk7+mBvmO2Tt9vjfFQG8Ia/yVOYz3qtPnNYdy1K9fC9
	BYj0TRJIRKtfPGbHTg+AsgBaEkcCqVPknREd/1n48sll3mZ7mNTzd4YDibcX9Uj58EdcY8+TgCO
	PXPc2u0NyTIEsgtEzo+/i1560myUz8ObkuNArbN/UOZxwmAmVieXZ3/5yCY5lDG/Ff2nXPzOZ6w
	pItI30QXiOAXe+CXhXYt/swQ7KWmIrkyC532xSGvEh1uyAuvPng50bYFfAcH3bHz3888t1KL/Ur
	f/ua4U6ugk48FZyHqYjpVsZcjxI717/0YC1LB9xSS1UQHB6c8i7b3mzj4fZZm1ZZmC8ZorhbSr3
	3OlmX5pDlewtUvmE4JdiVQYw=
X-Received: by 2002:a05:7022:e806:b0:145:287:ce91 with SMTP id a92af1059eb24-19935625d41mr2734517c88.14.1792837823969;
        Sat, 24 Oct 2026 03:30:23 -0700 (PDT)
X-Received: by 2002:a05:7022:e806:b0:145:287:ce91 with SMTP id a92af1059eb24-19935625d41mr2734484c88.14.1792837823386;
        Sat, 24 Oct 2026 03:30:23 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:30:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/8] drm/msm: Assorted fixes - October
Date: Sat, 24 Oct 2026 16:00:06 +0530
Message-Id: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAK6I3GoC/y2MQQ6CMBREr9L8tT+h1YDlKoZFLYN2Qav9xZAQ7
 m4jLt9M3ttIkAOEerVRxidISLGCPinyTxcf4DBWJtOYVjfmwk4k5YKRp7BCOPnCerJXDWvRdh1
 V8ZXxO6t3Gw7OeC+1XY6R7k7APs1zKL2KWAv/+2ca9v0LYIEbl5UAAAA=
X-Change-ID: 20261024-assorted-fixes-oct-1f981e99e677
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=1607;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=DyAgCOzQ7jVke1cRXj/xTsJaF/hpi2aekJSSNzd4H64=;
 b=eu3K02JLEDdzVu5Op//bUgPkD+OTgh73R+Jfv3KQZyWrr6XdtUexLwemhR2MynagjAeyPluZt
 ymCt0lsJwx2AGx3D4eD5EXwFhu8lHy0I9Lhp7eUEkpOJtwiJhFqc9nI
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=Z8Z5j3RA c=1 sm=1 tr=0 ts=6adc88c0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=HoIANuw4g2egeWD1xvoA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: Ow50iA-ynpRG5agizGSf3nhp6pTlnECi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX1THYLi9UJLbn
 jh/+mUEJphx03vEc/GAWND9Y5YH5mNQReWfW15RcrTRd12vggid8dcmjS2MM6S5hs9zzmTedUII
 jYCR/qR56HT5CilIRqImcvJNG9btgTnVPCal/o2j8r5Rl3ZEuDjAkI3f4zJXwJd02zhqx+0/+Qn
 9MdItSyhnD7eh9WL33H1L0zFM69fABE7iQjZU6KvrwQvBSt0obsqVKMjWohw1BtPiQlMAlK2GXn
 eh1RHeYA6dGWzC72WzoqKX58g2FU7loRQMLGkAvgnZaPTX3gY9Sx10QzgaA3QJr5Dq0O0rTf9ux
 5XrTSbe24i1dekLkqAUx5b8oysC6klV5Zlh/2mchw+DkZ0tKDHU58dve8u0poiT888GRq44qCqb
 3XpN/26+b1lWNGvil/2PQQm3HJ2CZNxgnv2uW8LdoHW/advxrpejwUBTFxZb0YmNUoGPIKrzQ0q
 QAM7H3mOhP6GcqLtcLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX2AeBmi/uwi9f
 YOQoD72e9PQHygIpCnvg22O8OsDFIllNn/3nyyv46S9Sg0cCiMsCCYMzT9UL6Xj280SrChMQsW2
 pkgHG9PLpMdm5tMYmPEJDRsOPMyCIPo=
X-Proofpoint-GUID: Ow50iA-ynpRG5agizGSf3nhp6pTlnECi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041

Few assorted fixes for drm-msm driver lying in my stack.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Akhil P Oommen (4):
      drm/msm/a6xx: Check BX dependency vote index
      drm/msm/a6xx: Reset preemption records across suspend
      drm/msm/a6xx: Request CLX enable from secure world
      drm/msm/a8xx: Add AQE firmware to Adreno X2-90 GPU

Jie Zhang (4):
      drm/msm/a6xx: Fix GMU shutdown idle check
      drm/msm/a6xx: Fix stale boot up BW vote
      drm/msm/devfreq: Record idle_time at GPU idle onset
      drm/msm: Fix sched_prio inversion within a ring

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 31 ++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c             |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c         | 37 +++++++++++++----------
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c         |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c         | 11 +++++--
 drivers/gpu/drm/msm/msm_gpu.h                     | 24 ++++++---------
 drivers/gpu/drm/msm/msm_gpu_devfreq.c             |  3 +-
 drivers/gpu/drm/msm/msm_submitqueue.c             |  2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  1 +
 12 files changed, 73 insertions(+), 43 deletions(-)
---
base-commit: 77cb3534193b758eaecd662a610a3a1bffde43ed
change-id: 20261024-assorted-fixes-oct-1f981e99e677

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

