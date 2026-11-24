Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507250;
	b=dHF9EVV2uG0SFhfBcIlgofUPx3D6LyjsVX26T6Qkse3TH6UBrYXi8Yfmdp/bGBT82fHT
	 Nro1f0pt+bEuikCYOkzgPDoIeAVLlbp6Gm0A7dXUmr/F1nYIeTxj+EMB8SOpmutTpTUIx
	 X2lV1wdhz7RC1+Y8mZ8LRsEMCPnqNZuI4pb2sZiORvVa6fxRGAOdhkHQBOB12ksSH3OQc
	 mFq/Li+MMXXdCOaYRgB3t+MbsiHRoLnUSa9TCP8euNr8Q07HWlvrXNoFIpYwUgoMnljuu
	 kut9I4CjaQqqw/fht3/r9XiorQCHQ9VHOhLS8GfPRJrCsk3fyKjzq7CKVm3R5eLKLzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507250;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xk65ykRcNkfmB2miDZ4hlop/BJQ7fyy9s/xh6mOzPcE=;
	b=SL7AzyX8XSLSDvFKUxgNZ7FCq2GZNPrQGIXI312hY9fXzfob24JR1He/Xg8Gugejli1p
	 A0pvOne+EQQDgJiepG5qNf41ec5nZG3NbPA5/HABRfFtYPxB1J4Y2kJqliNG+A4V2PNYR
	 5q4dqJMPfREualCKOkHA+a6craDwAr6JbOIA0jSVHBlmYy6w/cKm1hWWg5yUPx+CkGQxL
	 aMoNwBdGblFNIiYOZ9FyBL1Oelmp9cxej31O6cM9cXA7qook6RPMbtajEQVS0Y43tvhJe
	 9QPWvko4EriLQNXuglg4J1LfaP3q0uEadWAhl1WGynlAPsmRM19J5kbMg4SUAaw5YcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eHSYT5xs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NC96AtXF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ADB606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15ADB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eHSYT5xs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NC96AtXF
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k5Z03225364
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xk65ykRcNkfmB2miDZ4hlo
	p/BJQ7fyy9s/xh6mOzPcE=; b=eHSYT5xsoI0ufPL3DMV9mwsQ4epnELh1ghJqtG
	NZqGjsUKR6hZwIIiVNJghjIucPl04inv/qahoJrmX7K8kUCSWlS/LTxtjM+oc25n
	NbwxZxTWhccX9NCpRTO0zrFlUmH4w5jeZlXSCXqF89g4q//QIh237Mh9huuyeoCP
	V7yKFGk7njyfBUTAVUQO5ekjVR4lHU3slQv8dTG1IXhlSKJ9f9RMecmQFoSArVjY
	KPqFqSf7xZ4V6pS+Jvwsw+nzzPlDjgELX0HH2JXHwGD4lxz+/nCfMxrKveAxOTf7
	PRxAbkkAzrCSDJcJs5k0HX9SusDU+OezU1x+u8f3h6HZ2EfQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f1v6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:00:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b3fc6a0083so3836823a91.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795507248; x=1796112048; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xk65ykRcNkfmB2miDZ4hlop/BJQ7fyy9s/xh6mOzPcE=;
        b=NC96AtXF48JpkmhnZR8Z7lEdIwuWvMafoDGncAA9FaRF/QCMdK/vXrXxV/5njfjsWn
         7jd6rH6DOwU3y4LPLjEb9qfKb4SAyB37PL6WGcFDLlFLt47ogC3ok4NjMIDrJ9D3pP9P
         ocEsfy4QmLsWx1GymJ5A8002lguBTKv/pD2IIoNtksEeKd+MX5DwzODWnlJ8TtUbahxQ
         AphMaK8S+aBh6Y7A01n+HrkXmQSTueSq/ZTtnCkNWyEy4QoP+DJxva5Rxx/Swb51b8hm
         SmWvZDTnvFUPnleizdi6S/jIgmkhOgNAl6hOXzEe3I1AUFH3WtHpWFsm6m0IqdoEmIx9
         SO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795507248; x=1796112048;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xk65ykRcNkfmB2miDZ4hlop/BJQ7fyy9s/xh6mOzPcE=;
        b=hwD7jgkzSvWhe5xRCjjQWP3g+ncfpVy1tU+4RU3sTgioxznFrM5i8k80W2ZTe7sw8b
         NWwaBQs6put4oxpzfHp5+0DV/gC7GJqwnzghvBf/Y7vNvnguX82TOYK+VXZexxWU78j6
         OMLNEKAmuCUyuZ/rwYhzrD/ggvKOosx5fy5nwRTtOlWWIOJOH38f4fICxLGBJfQ2I4dy
         YK7HRbBgPSrxL1/ZkpOPlnVfEf5XKbP2c7NC3ESHiPD86PjW/Cc2CYPe607jKKd/OA2+
         JO7MZVs/JO9J3djZwTkm8bQsuu1Y3c1br8DBSpkBHkTQFIsvi9RQsiUTDLy56n6banfr
         7n3g==
X-Forwarded-Encrypted: i=1; AL+hErEgVTYvoHk1Zpn++O5iVSlzBXtB8FmBVIpMuOnr8pJIesuenFcfzmyGdn00g3wXUd6QmOQUzFw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mnyiMHoZ3NwYNEMp4Mpr1c/cMQ4Y8X+BXG4WRRa4esJofUFTR
	lHK+X840VXvb1yFTDs9gfLAutF4tYP3FaWjOdoDmJPCNp6MYSK9swELNphESqiVH/ygvjkeArLI
	TQGeoH8kRXeqO5D1kAGMczVOHnwWs0Y242QvEtRl2MmJlOG6jAjb5rXtCTQ4=
X-Gm-Gg: AZFdTZe5pkRG0SY/HzBHjXKuod5GwCs9PUOhhuMSNIno0G3r0yMyVK9gbM4NxRPEBui
	Ei6Oo60F2HK15vAWhx2/JugIYAitTLI1nRWo7LvGOWTVtEVae/FTfFXc1XwrsN+TXCK4m8Eis8g
	gcEZdMv0gwTic1J+HkLoFKtw9GAhASws77+ZbyIJPhy1WrCqkDEov747BvNRrTYNk1NXX1/2Fgc
	c4mEoJMxfCyROMVZZ7rBzIiIGWiQWedO2F1t6IUOK9u3VS7mib/+6xLwXRkXSTp8uIbgbm8dLtA
	VdiUndryVt3GdyU4yiiZE70Td+LiScHlzHXdyjVwb9ngMHqxtZn8XThVFtodM+hW4I0uVVUMmYU
	iz3kGZNZ8AFZZ4zDiRd/9U1ClUFuGW8/9N31sNhMra++CAdG8u0ldRtH18kXQf9cbPpQsMnx8zQ
	PsaTwZClxp4XrVcCwDsuBfUce8A5XiqypeSPkbaBhheqrAL5sV
X-Received: by 2002:a17:90b:288e:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3b41c9cf219mr11444777a91.26.1795507248156;
        Tue, 24 Nov 2026 00:00:48 -0800 (PST)
X-Received: by 2002:a17:90b:288e:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3b41c9cf219mr11444729a91.26.1795507247541;
        Tue, 24 Nov 2026 00:00:47 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm22621605a91.1.2026.11.24.00.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:00:47 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 16:00:40 +0800
Subject: [PATCH] media: iris: fix deadlock in iris_pm_suspend() with
 threaded IRQ handler
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
Message-Id: <20261124-disable_irq_fix-v1-1-d27f44f7eacf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACdEBWsC/yWMWwqDMBAAryL73UDeVq9SRPLYtAtVa2JLQbx7Q
 /2cgZkdCmbCAn2zQ8YPFVrmCuLSQHi4+Y6MYmWQXFohpGaRivNPHCmvY6Ivc1xLFyRPLkSo1St
 j1f/jbTg54/qu4+2U4F1BFpZpoq1vlOgEt8rqLvrUBh65b+0VRVLWGNTBpGAxegPDcfwA4nTt9
 K0AAAA=
X-Change-ID: 20261124-disable_irq_fix-a042ac20facd
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795507243; l=3831;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=RdIDSS0YAAwoPS+0Bfg2V7Xz0q62EGYt+OLZau2scTQ=;
 b=ZR5qXB65LMBhIY1k/ZGP0uN+Gz6M2HVYL/b5NNt2Wq1/nj4e1jotWQ6YPOIr+q7IZzVfcdSJ2
 2QBxtCDFknvC8uikf4v+YmPnH5xr7yubrBYPYGqlc5D5GvZrakgiy7n
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMSBTYWx0ZWRfX98hSH+pnSgvj
 GPTgHK11zzqxuJNqEz0Jsh4dvb29qpii9Rb0wf3czAyHiYKa1h3GtTq37KnCqwgfineWWKSJYBM
 /RaaMvD5+HS5u6uMsd2B/YrHK/9RfhE=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b054430 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=EmWklCXODhzPg6VfJcIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: GgJ0Z_N4xri49FCQ4ROvs-knmUojS7r1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMSBTYWx0ZWRfX4B0u1H4knSCz
 riTyE8ZLcvFJevzbU988SKFGAwlsl2xbaoQSQ8jDJOYXvYIl4mek24PIwSN1S6PuGE3W++rboum
 9vFSeNazx2fx2qc5ODvfYl+3/XK/MkzRLN5BbrllK8jHMWFeS2GUEZnmfSMAa5ThedJRuTm2TPW
 vaouBjj7Szru9HnjmxdG+DDgi/kZ4VO87dy8sk5ZzUrrmLCMSRzc2laRFKmaTmxgkI2fyWY3qFQ
 np/5wWX7WMWrvl00bO0kICDhgpQLXxqNSaXI2ISDouf8i4uQdxkpqVfFFerz90pWwSK80a9rWbF
 vSinkO5lW8vsk9yusY1OFlvANVsUwsHC79SWdOIEAyJmOAS28w4d2v41jQmUndLMGyN/LKtH+yB
 aWVYPweB0bFEz93iI95rrdyomufgsCrdVETNW4FM1gD1Ly7O15jZFMYlJoPmFJQf/kSL5VC6XcA
 Pi9+hjPPNbDtHcEkdIA==
X-Proofpoint-ORIG-GUID: GgJ0Z_N4xri49FCQ4ROvs-knmUojS7r1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240031

Commit b9c2215bdedc ("media: qcom: iris: use disable_irq() during
power-off") replaced disable_irq_nosync() with disable_irq() in
iris_vpu_power_off() to ensure the threaded IRQ handler completes
before the VPU is powered down.

However, this introduced a deadlock. iris_pm_suspend() holds core->lock
across the entire suspend sequence, and iris_hfi_isr_handler() must
acquire the same lock before it can complete. Since disable_irq() blocks
until the threaded handler finishes, the two contexts wait on each other
indefinitely:

  kworker (pm_runtime_work)         iris_hfi_isr_handler (kthread)
  -------------------------         ------------------------------
  mutex_lock(&core->lock)
    iris_hfi_pm_suspend()
      iris_vpu_power_off()
        disable_irq()                 mutex_lock(&core->lock)
          __synchronize_irq()         [blocked: core->lock held
            schedule()                 by kworker]
            [blocked: waiting
              for handler to finish]

This manifests as a hung task with kworker stuck in D state:

  INFO: task kworker/u33:8:178 blocked for more than 122 seconds.
  Call trace:
    __synchronize_irq+0xb8/0xf8
    disable_irq+0x60/0x88
    iris_vpu_power_off+0x6c/0xb0 [qcom_iris]
    iris_hfi_pm_suspend+0x44/0xa0 [qcom_iris]
    iris_pm_suspend+0x6c/0xa0 [qcom_iris]
    pm_generic_runtime_suspend+0x38/0x80
    rpm_suspend+0xec/0x6b8
    pm_runtime_work+0x118/0x128

Fix this by reverting iris_vpu_power_off() to disable_irq_nosync(),
which prevents new IRQ deliveries without blocking, and adding
synchronize_irq() in iris_pm_suspend() after core->lock is released.
At that point, any in-flight threaded handler can acquire the lock,
complete its work, and return, so synchronize_irq() is guaranteed to
make forward progress.

Fixes: b9c2215bdedc ("media: qcom: iris: use disable_irq() during power-off")
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_probe.c      | 10 ++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 343e44c6b9c46190a4fb3a0055ba012b16011235..5580094d427429d610d7d0aeb85582676312707a 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -388,6 +388,16 @@ static int __maybe_unused iris_pm_suspend(struct device *dev)
 exit:
 	mutex_unlock(&core->lock);
 
+	/*
+	 * iris_vpu_power_off() uses disable_irq_nosync() to avoid a deadlock
+	 * where disable_irq() would wait for the threaded IRQ handler to finish,
+	 * while the threaded handler is itself blocked waiting for core->lock.
+	 * Synchronize here, after releasing the lock, to ensure any in-flight
+	 * threaded IRQ handler has completed before returning from suspend.
+	 */
+	if (!ret)
+		synchronize_irq(core->irq);
+
 	return ret;
 }
 
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 243bd845349fe7359d9616e12c83eef44ff8d55e..1e183fc4e58ceeca4e9b3cd103344f45a3d841c8 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -240,7 +240,7 @@ void iris_vpu_power_off(struct iris_core *core)
 	iris_unset_icc_bw(core);
 
 	if (!iris_vpu_watchdog(core, core->intr_status))
-		disable_irq(core->irq);
+		disable_irq_nosync(core->irq);
 }
 
 int iris_vpu_power_on_controller(struct iris_core *core)

---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261124-disable_irq_fix-a042ac20facd

Best regards,
-- 
Wangao Wang <wangao.wang@oss.qualcomm.com>

