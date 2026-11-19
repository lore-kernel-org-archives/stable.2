Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088760;
	b=fTix21EbEDC5KS1G3h00Dcv4+1dp+YsEDeAvr3xzhPNnezG9qsVSFly1+KCjaBPG57rx
	 uAn9tDwK/IxK2aalK/6C6KCXHLJxrcWbq4lw/IcY9DeUjZXvySVxWXvBz215QVTj4z4e4
	 6/OZIoEdQKGE6F6/39UOQUfhb5EUV/A/1L4NTwpZRsAqiiTQ4RF7JjMznX6NLJYiG7wgv
	 EhMG0o/77Qi/j29GTXMCAduF7gIDQEf6TqYt9H4WpFcg6GbwfGB5GM19nStDbpPxu7LHt
	 /D1Qw5OapMro0YCl0xt+KYRPn1yinT+hKYgBOjR/5iSYXbeciu4+RoKh1f8bVfYtt6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cl2K1V+C1GydrvsfniG7BfW1zVvH/YWUHlDDFm15Zm4=;
	b=LDVJ/QdKZdnPNlyUCegXnFhd5KNG6Q2iFrnnwrbvp+/4fTVUAh5RaRf6VBhz1xNVrOk1
	 xxGshodLp1H3V86BYFENFAtQxACNlE42+Lsa3bOsTT7cO6GjPrYzOZFSDsTqJvaMu6d7Z
	 CV7iI1X6EVZBC6sBcQtRO3kna7VCf3pd3YplSKNVq46ubSzdr4kMctSOpRaArhEQ5qMVb
	 0omFI2vtO2eh7YGxPhmK39Wz1UQV/iXPyC2PJQTfgkVatUc2wwfbBIrlEQT71nUkZIknW
	 487ooN/kiWJwh2e4gfv2Gk7vXYddndjIhTRFnbvZ8VV2PBnW3MM5U+e1HeMMTRqN6Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=os0wq+nK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGLaGV0G;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DF606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428DF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=os0wq+nK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGLaGV0G
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBjxwZ3583624
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cl2K1V+C1GydrvsfniG7Bf
	W1zVvH/YWUHlDDFm15Zm4=; b=os0wq+nKvUOWxHdg/7HlQyP3T2DhzMkL9h21Zf
	6FDiIhePHOdDBwsltzVGClNMqFrK3m3uuoMP7Zc8pw2C9fgfojgQVQexpEIf0Mik
	AzbZCdEsUd7NRDXxlK7TJdIE0ZRm+NkF2N2sRgln2zC8mLJjKPC4nBygTTf13mK7
	JD5w+uLEjCywqgdbU8Q1J/6SBVx6oxfy8JC7sm5qwKbQbxLKjvFtXLUyAS6q4kKU
	gP9PobKfUkXfkuk9Zu0gyOGygUfGXtyzWH0MmVlB6VnLsfGKYFYUMP8OafUk6s1m
	f+KZGfaWZRjLCw7Kdfef+UCLc48LpLYWQVuOVslYgbaBVdqw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymgcpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:45:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso1655179a91.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795088759; x=1795693559; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cl2K1V+C1GydrvsfniG7BfW1zVvH/YWUHlDDFm15Zm4=;
        b=RGLaGV0G9BqZpfILaO7XjweZ8ZfmP++nY+XetoHBY8vfdcj3Se4BrOww7H8mRSPBt2
         1zH2rFuu7vydn2nnYARHGylIIvPnRaEWpargcQNvyTMovSpwy9I5v20c913WAwjiOkxn
         Zx4Ah6rxrsS2jG1SA9ZR+5BdburjFoMkVDXPhR+6a5mOq6qEtEOGRDMFjBUcw4qRxep3
         rXyswispz/67+pUzRtdHmZpaNddERfy97Lr46B3Ky9GYo4iQmVXe0mAI5sF/41ajEs63
         ZU3bdZ56+qjTHHwwR4nZhplrgoC5C2zLp8IItySeIYjbvKkcoorazktzlQvMnD2uUkBW
         RFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795088759; x=1795693559;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cl2K1V+C1GydrvsfniG7BfW1zVvH/YWUHlDDFm15Zm4=;
        b=G6dWnG3x3bCfmsULbMpU21S9bdGvs9/WSvCXv5/F/1Ohh2CVrrUJ/jfayfs/nmqSKl
         y+ZoUOyEy36WVNkNFZI2bqhP/KbbBi/klu2oBYVcbf0qhBXa2aOQP+ALVCj0XeSFk9P1
         qtOEh39WtDnFu+Ri7DQY3Y1JhKMzk2fEDFMCaXzh28MjLop7ZlcSHVTKPGdbJ293ekUx
         buQ5HtwcgulUbIWC5fbQwvDIQU/nHmnGH3LUaDBwoeNUf+5trQWwaWVYyhfu+jM0+1Xy
         ntAtRfPUjLTdHBA7SbbXIDVg12Ehu7F4TXl2bGoSgJJ8yyiI8lumfabIPzwNdfu6gLNv
         jWUg==
X-Forwarded-Encrypted: i=1; AL+hErHMeVBSnET7y9Y93drw6tTB2exVM8V3fPPNKpGrwu91OM5gUWqpn0l8XeuMKMPOaHF9npA3fZ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PQmK7SDeSdkFXEpkIzsOV+lrbWfhJ1nJJOSaNcsHsWSUvJMEl
	ascuGjdlJhUgsr7FRDsGgbzJ99GZqo/o3F9OG/agdTBHeqRhcndD7osEGi41I6yJpAYi3C+FlJF
	kpOeEVu4/TZi03WfdHcsSMWPMg5hg1MRGnB576hEdQjMyKkDYH5e/OT3VRJ3H6C79hk0=
X-Gm-Gg: AZFdTZeeHnL1Rx7Nk/1MrMkqdwsVLhiy3RNmttZNL9CSf/mFSGEGPqV6PxsslLwGAjb
	Uc5f28ysW91roP9CEG/fTlF9QV1d2p+wA68p2i1G/bAuZcE2L9gRh2PSRq+LY4HxbMKhkicn7Ie
	Lo3txMRhFy875Koyyi6gcclpq/9Vu7gkOipmd1GCU16vYT1IBJTPmqHgquOmW1qB+HbqrTb9MHB
	sqYQZxPNEtHEd8YVQAw4kyuzF1xtpqNBizQcqKrwC1f7RObpBpa7MiGAdbl9C572rer5/0zBrx8
	v9pJ2g1r8TqSReHNlXVGcYgpqYiv2evd5S5ywpCtBLq83gMOJGP/CDLer/9L1f1OtSh86pbjwCU
	2dHu3b1rzetsX+wWYaVNV1gsI8Q2Sq3JgXgmiHRzSxzekoONRaWro6p26Ur7BeW2Z4I8rCcM8cv
	DgTlj4l9s=
X-Received: by 2002:a17:90b:3890:b0:3b1:8300:f48e with SMTP id 98e67ed59e1d1-3b3d07b032dmr5632887a91.49.1795088758773;
        Thu, 19 Nov 2026 03:45:58 -0800 (PST)
X-Received: by 2002:a17:90b:3890:b0:3b1:8300:f48e with SMTP id 98e67ed59e1d1-3b3d07b032dmr5632867a91.49.1795088758281;
        Thu, 19 Nov 2026 03:45:58 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm2397030a91.15.2026.11.19.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:45:57 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v3 0/4] media: iris: Fix issues in the driver unbind path
Date: Thu, 19 Nov 2026 17:15:29 +0530
Message-Id: <20261119-iris-handle-unbind-v3-0-52d467a13907@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAFnh/moC/22NQQ6CMBBFr2K6tqQtcQKuvIdhAXQqY6DVDhAN4
 e4W2LqZ5GX+/28RjJGQxfW0iIgzMQWfID+fRNvV/oGSbGJhlAGtdC4pEsv0sT3KyTfkrXSoSih
 KBChBpOIroqPPPnqvDuapeWI7bktboiMeQ/zu1tlsuUOgtfonmI1UsgB7ceC0xbq4BebsPdV9G
 4YhS0dU67r+AFDEpzfNAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795088753; l=2349;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=/P2Y5/7trPmYQVLg1UXQyZX0w+9QilRr0lKIvkPBL4I=;
 b=hI5HHtCMwWBWfndFvyi4JmCSexNKPJH8f92JgZvqylo6fwdxs7rwn8DIgeMb5h4Cvy/ieWaEv
 pRjpuL1CmhUDoN2TZdiEhJqKAOihI4188iUL/VfDrsZubRsC2TSjbn4
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfXyGyS2s8tsyld
 rF5wyIPwdqF4mLi4saLdxRD8PgQt4enSJwhKK9laN2getqLRX0gbohGsgm3nu9hidkDyS0elpO8
 9lCYbU6MHW9NBtAtRVN+oRBvv3yRICA=
X-Proofpoint-GUID: u7TmmS4Wagydh9J1vZi3IIjnU7oR9dIM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfX1c1HfOdlhlmd
 81Pp03dFOWI/o7qGEsXNENxBQik767KdN+oR/MzqEs4i1gkCrWJvo3o49l7OExHKvG6zDuYi4mD
 XLkviDK0depf8iYzkRajmhPZqeftefbtmNtALGfV7IL+kkZstT8xpAj59FvKDiEHBVzi1Ulmpll
 qwQgalfv+1b5bBik87sS9WjU5LbI7wxJaKMU9/LpCI4f6nCMXPES1Ollmv1DfwIMdE+KYgmoqqX
 ue7s4oVmTX0n2lMS8f3/FqM0iLcgstaZbpnAPUNT1Ej+IZII1tI1ifGM4WFb4mKp7njy6v3AIZu
 UMBewa3QwUffT98ltwgOjs/u9XWbSZJb6WwUTasjROc8tpXrcxhMnkPDmqlUbfdw9W4cqbMsCO8
 PxptZvJReHh+325PU3Lb91+tZpQIW7ttgbqXYIFO4I9nYeN11y/kd+8NOaVF8qfttayjHot+9fb
 ynQrpEOBGO9APeIsXaw==
X-Proofpoint-ORIG-GUID: u7TmmS4Wagydh9J1vZi3IIjnU7oR9dIM
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6afee177 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=6I88XT8292Qb7oD-W5sA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190046

The driver unbind can be triggered through sysfs while a client has a
video session running. The devm resources are freed when the unbind
completes. That leads to use after free for the running sessions.

The core and its device are now kept allocated until the last file
descriptor is closed. New sessions are stopped as soon as the removal
starts.

The system error work was only cancelled during the removal. An
interrupt could still arrive afterwards and queue the work again. The
work is now disabled.

The runtime PM usage count was dropped twice when a resume failed. This
happens for a command written after runtime PM is disabled. The count
underflowed. The reference is no longer dropped a second time.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Changes in v3:
- Ensured that runtime PM references are dropped before driver removal.
- Dropped the unnecessary interrupt freeing change.
- Link to v2: https://patch.msgid.link/20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com

Changes in v2:
- Updated the commit description of patch 3 (Bryan)
- Split the interrupt freeing into a separate patch (Bryan)
- Added a new patch to wake up clients blocked on open sessions at removal.
- Link to v1: https://lore.kernel.org/r/20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com

---
Vishnu Reddy (4):
      media: iris: Fix runtime PM reference imbalance on failed resume
      media: iris: Disable the system error work on removal
      media: iris: Fix use-after-free on unbind with open sessions
      media: iris: Wake up blocked clients when the driver is removed

 drivers/media/platform/qcom/iris/iris_core.c      |  5 ++
 drivers/media/platform/qcom/iris/iris_core.h      |  4 ++
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 20 ++++++-
 drivers/media/platform/qcom/iris/iris_instance.h  |  2 +
 drivers/media/platform/qcom/iris/iris_power.c     | 24 ++++++++-
 drivers/media/platform/qcom/iris/iris_probe.c     | 66 +++++++++++++++++++----
 drivers/media/platform/qcom/iris/iris_vidc.c      | 20 ++++++-
 7 files changed, 127 insertions(+), 14 deletions(-)
---
base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
change-id: 20261013-iris-handle-unbind-fe09689e6696

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

