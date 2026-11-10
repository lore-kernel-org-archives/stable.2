Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319899;
	b=JFKrG4r+DyVM3o0BcZzZc6m33ZM7EG6+uuhBn5Qc2wChwqDZRyH6wbWqzc6wcTgT+tYl
	 ZE+vK68xeT1RQDBvMvSo2ldZcNhHuO9+zCfqq7M+7bv/m81rmi7zL9epKiuXcL4JM+ODS
	 4VtPbx3Wptr82HC9tOnXYgiKoAJ2PwCroI2+FEx7W9Hxsg4hwvmtdETkwkg/sh9aptF7z
	 u6s0dSu4V8APoD3ysR+oTc+MepC80rXdwUSttvGqM475IQ73pLqn+vqvhW8Lx+DNyVOoD
	 sr2d4e/sdM3WbGEeOhzAWn3vyp70gVvIBZtshUHR7fKaJ0rKO0XJFrkNYUJkzB+uiBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319899;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lTHRqypbrm/tFdpsjozktQBusecaZUlVHszYpXh8lYk=;
	b=rKaNZvMwmC215PBkxrdhuW1ePk3Nd4kEilfU3MTdt7+knEq8af66G4gGZXyltCmtufRI
	 1EI7hsBqU7dKlFx16nuIfYPl8YEtDeN3s6xejIeXu6NKgUKsaU5P5JCMr1gGS/Eq/t+ED
	 4IvlVNy8ktGpgdziulOavQ/hmnhEhGsDaNBxUG4Rh7M5Rpx/tQlpMg7aoS0WiWJJHX9H+
	 Sn83+ipwl91t+hRrK25HLwIw3GwEOHGhWqxnkbbAZp9Pyy5Ujgue0/CqtWoYM+cZy+yOH
	 rAwKyJaFQTxLgEgbd4KcDAXpouXuQq2YB3wuZ/svp32CB5lLS5Iju4cf6RsaeoZqVxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FKubfPa0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DCuSKQ5z;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BF606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D38BF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FKubfPa0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DCuSKQ5z
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9wcb3195927
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lTHRqypbrm/tFdpsjozktQ
	BusecaZUlVHszYpXh8lYk=; b=FKubfPa0MKUphGJzWNKnpaPwS7kahB8Zq2+ILV
	VK/zQRqO2NbC2HEmbuSwS/4+rQ+1Nmg9rMvGYRuPnXRvXG5AHc0HYi3vG8lQlF4u
	TXvYyHVvghql8YRHpibxo+N65VMenstOUl+zrl+etsYWZyzGTOksEuaOwCilcApT
	K2bf6go5+4KTFooOGB88UbdomSjfFeeSK/zOrnB/lbVtmfcDHtjAyERc3DfGgiHP
	veRerr1v9yUnU1mGKbkVH07HE0+8nXk9Y6dKRABa15dD1IjoaBct9IQ3nUYhiFNj
	f2iF2DF9ptr4HYI8P+LBKwd01+yBueSELZZvrrtQQyliuUUA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv03cs2tr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-37549877380so1172909eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319897; x=1794924697; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lTHRqypbrm/tFdpsjozktQBusecaZUlVHszYpXh8lYk=;
        b=DCuSKQ5zGs1MkFpDCbxksYkicxFdFaR1La5z0928G6vBjb7osjBmgtBxFf08QP+97J
         /pNTZ7GzljUXBQ/nzWner4sPKub4nbbSp3g/FpeTkCz7rmBPtChcNzboISBy/CR5D2Z4
         2PI5UY3zc6u4PYBy3MrFexlDK/jK7/G/AnarKSVssL7PWDIcY1mH21toETzbkuAUmgkK
         rE5rXviMFX2I6IKwsh++u3g2jzBbrsfrZP7vHKcqZs4zqlyI34AZRLk2u2A5QlQL7Ks5
         IPun8zIh9j879FBXIMjOgLFEQR1BpFRIKUONd7764tpLDdh1KIC/Hs/Yh8xCu+zIYvub
         2/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319897; x=1794924697;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lTHRqypbrm/tFdpsjozktQBusecaZUlVHszYpXh8lYk=;
        b=TdOFKS6Z86BK0vfS7mM+lp5EAX0YmfuEMjnRpcacVz5Hrf5HPcAVix46PXqHpmSd09
         OdZ+E/Bkalpq0KUR4bjcSS1SHFyOF7rDtDAAtm8sFaCM+Kco3tERCOaxAKFSg3iGOCaZ
         FXub6q0R4z/j2K6SfSG9xPQ6Il7+kkG4tsONnBjz0XEzsKrl2cdSCGfSNF9Xr/mjBbGo
         WAR1AIqOpuIc7FThZ10ld0DGaQT5fDI40WS9fi00F2i2tLOzs1iDV/RV3HDLv91YcxPD
         VUEVNNTN5HWNyLKuT+U9QEBjf3Jm0ViTCQV/fKPcw6qQmnjXf0LQNS94riYMGaX3xBAu
         L1jw==
X-Forwarded-Encrypted: i=1; AL+hErFb8cXpF1qpZlxOLbO4jvSd1Z5/ZB6dekhm/Alxtkcw52K1dOVeMY+jvdItgD+PgJ2SPRzwVso=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yf1lfYTh5dzAMNRouqZHQgo47n+zOG32MfZvpu/AGT4FI2qJT
	uQVDyQjYYioi+IXC6O+iecjaxiCCPV57lw/ESy/hrfEqI2uyCxuwmjA2+ApyZWqqH9i0Qm+yVee
	OvYzEWido4KJT6utG/hYwJEeveSG9rqyBCDHNnP8ZJhZzV7MYXpazOiGCxvM=
X-Gm-Gg: AYBFou2sBkR3ZPc32zBe6zDdLdfGMb2iVegV8ArF0mCJksP0jMnRe9U0auFQ6n4ltis
	mVDaqFAXyw1G+t3akBzRO9Us3Ai4WJL7ZC9h+t7OU1o5rffNKBSPSCkNJNV3/L2JlpqEzTCAdNs
	2iTYhjjyYOUvot5a3doEgbMSRFGWwVlx9bzUvVKpG6+5ptUU86ZfY3ukyNeNljqpTLOESO3QfWT
	ixNz1wwKzkal8e1zhDj2+204PmZTuVxJXNL3+fOT2i/iXncWyPRgswZenbDA950UUAYTkoxuipR
	7qGsTqGFjdTsC75z4Lirnc5s/16dKJgXJj7KZqe+FMcCXurEVe0sHJhb7t5D1EPll0bUzPlaxhV
	xSdffIbIbskSPZW5un94Wv/n/E188vIGKtNZFWhFUukiQzlqJ2nEnkz/J5j3vQHCJY3nHXElTT/
	ozIpaJpmM=
X-Received: by 2002:a05:7300:da01:b0:351:29c8:643 with SMTP id 5a478bee46e88-3751f46823emr3330531eec.18.1794319896525;
        Tue, 10 Nov 2026 06:11:36 -0800 (PST)
X-Received: by 2002:a05:7300:da01:b0:351:29c8:643 with SMTP id 5a478bee46e88-3751f46823emr3330483eec.18.1794319895810;
        Tue, 10 Nov 2026 06:11:35 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm8059128eec.27.2026.11.10.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:11:35 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v2 0/5] media: iris: Fix issues in the driver unbind path
Date: Tue, 10 Nov 2026 19:39:48 +0530
Message-Id: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAKwl82oC/yXMUQqDMBCE4avIPnchprA0XkX6UM3YbpFYsiqCe
 Pem9vFjmH8nQ1YYNdVOGauaTqnAXyrqX4/0BGssJu+81K6+smY1LkscwUvqNEUe4ILcAkSCUDl
 +Mgbdzmh7/9uW7o1+/pXoOL6KhYKvdgAAAA==
X-Change-ID: 20261013-iris-handle-unbind-fe09689e6696
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org,
        sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794319890; l=2243;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=BHbZn2I9kD+85QtPHjzm5ApKiJ90gtvlI/wqKpdWelQ=;
 b=MfyFw0HT8WKTM/5L249dWjJYgLTlji7av6UUC4FQZIENoLGer1bam/LLUy4fle4zoHHBr/34x
 Yp/fOqARIuKCBP5Fkxl1ZOlw1NWJ4Z0NPdHRnAoqO41d2EErhNcRGUH
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: 7YWb7Hx_yv9_z6DkmqCgHsYd-DvDkFCV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX3x3qzkOJcxmW
 K1QKJXhrotSC7JyBffKkemriPTc622SoBEYiKnDhsbWWpo+UHK5RNanD7Lf/PpfDvFJEUTjDmBK
 tz4ZkH/HFoSlV2B+/1wPBbhfdCd88Ag=
X-Authority-Analysis: v=2.4 cv=FuiQbGrq c=1 sm=1 tr=0 ts=6af32619 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6I88XT8292Qb7oD-W5sA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 7YWb7Hx_yv9_z6DkmqCgHsYd-DvDkFCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX0+nqEnEoDshi
 W8kWe9Dzt0fOkklyagBwSP1CGlSFCuHLNRACg0KweqykQwUFWe5JN7G0b8/J5FXdHk+RPJA+XOE
 O2DE+myJu2+15zaGIouy1ZzuofwH4o3BhDhKvviNLRbtYeXabeAj42VhpnehMwyLPFocJm6Wmpm
 50gCj61xksYfTLe7FSXtmHOpttR5b0E7N66/cr/7D36t4082uiC8iEItzzpk1z7o11BKJuu/zCb
 YPwP1HcdXF67myDo2Lw5NYmLNotf1CKkkKHnnd1madhPXyOG+EQlvJI/RQBZmZ2upPIYLa51G1r
 ZGe4HSGD1BJenpYNXqGVh/Q1HzIGw+Rwl5NjbHusvpid63uY5VcWlLrQvZN+XcsIN3G79Y/FUWK
 NOaq4JiYrYUxlryVWCyhGjuuXfzIICHCcw1JnrXINejb+ql0kpqO8aH3RymgDkUJLYUNx5UK/Ij
 6nzYYFFiYNhkcYDqs0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100056

The driver unbind can be triggered through sysfs while a client has a
video session running. The devm resources are freed when the unbind
completes. That leads to use after free for the running sessions.

The core and its device are now kept allocated until the last file
descriptor is closed. New sessions are stopped as soon as the removal
starts. The interrupt is freed before the core, so the interrupt thread
cannot run on freed memory.

The system error work was only cancelled during the removal. An
interrupt could still arrive afterwards and queue the work again. The
work is now disabled.

The runtime PM usage count was dropped twice when a resume failed. This
happens for a command written after runtime PM is disabled. The count
underflowed. The reference is no longer dropped a second time.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Changes in v2:
- Updated the commit description of patch 3 (Bryan)
- Split the interrupt freeing into a separate patch (Bryan)
- Added a new patch to wake up clients blocked on open sessions at removal.
- Link to v1: https://lore.kernel.org/r/20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com

---
Vishnu Reddy (5):
      media: iris: Fix runtime PM reference imbalance on failed resume
      media: iris: Disable the system error work on removal
      media: iris: Fix use-after-free on unbind with open sessions
      media: iris: Wake up blocked clients when the driver is removed
      media: iris: Free the interrupt in iris_remove()

 drivers/media/platform/qcom/iris/iris_core.c      | 10 +++-
 drivers/media/platform/qcom/iris/iris_core.h      |  2 +
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 17 +++++-
 drivers/media/platform/qcom/iris/iris_instance.h  |  2 +
 drivers/media/platform/qcom/iris/iris_power.c     | 13 +++++
 drivers/media/platform/qcom/iris/iris_probe.c     | 64 +++++++++++++++++++----
 drivers/media/platform/qcom/iris/iris_vidc.c      |  8 +++
 7 files changed, 103 insertions(+), 13 deletions(-)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261013-iris-handle-unbind-fe09689e6696

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

