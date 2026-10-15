Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475C33C194
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028335; cv=none; b=KKxx2tG/OjGziRTtde6is8z6eMOdYBtgDZH9jnLcR+6Jde2VhJoyDU3zlbG3U+h1KdQeml076ySK3Yb6x1Ee4YQOgCjGkM2Bf4Nl0/btw6U6Q1nWTJgC9fcvnPm78TXajha+JgHhwWdLF3MetfRYxcOiDA2ZEnYueZe5/MVg0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028335; c=relaxed/simple;
	bh=s5sZqlYBQIoehLjlwTqKgiaGrWc1SI5qDW1XMRyABRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn2oOi06gWB3ZFvMouQjX58HrOr9EC5bup2Basg48Ykf5YdQESNxAO98rHEZ2HMy4VvYjcmC0j+FSO15jlaGg/KR61mu3VmlzmrrXxWGk2D1VSsy4nulLCKokJnYUFw11LrKhg5S1scpuS4UU9wjUHrKcCGx0gd9gJMmfnod7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hEWQKeJh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NBGyI7pK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hEWQKeJh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NBGyI7pK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EIi8P41555089
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rHDdrNQoCBK
	WKcv5fc1rtzAB4UD3f4pHDI81s24u/vY=; b=hEWQKeJhKp8d2HvTvsp0StyZPuz
	QKbTvKG5kCJKMGzL2VsiYzeLKdTQrnvi0PDx/LbeySi/DsmHe+4pbf4RPYf4gd65
	nfTUUncFRzIqg40TJCOwj0lJOU86GrtTtx6ejnnZtVpNt9xTtDVSZlmrmWj6GIGc
	DkNhPXiSYk/55kud5jRZAaz84bMjGFIc9OqS4rbopXqY7IKVl1ovbsjW63/sdZar
	Rzr6vd+3gPdkzg04izF91zTaqOr3LbpTq3LVC4d1WHmRTcw7RbXcb8k2SHXhObfY
	msc+/pAVhYtQL1VOQQ29fNne64nCeHCrCVPHa4DAdrQXG890HmAMXLUM0/g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80cu5y5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:38:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso8685813eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792028332; x=1792633132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rHDdrNQoCBKWKcv5fc1rtzAB4UD3f4pHDI81s24u/vY=;
        b=NBGyI7pKpHeQ3BOxVJFfwmyODrYJHarKWPXkgn0Q28Eq5J1C+qcFQsplAw3+ZE1xBR
         mP6Kh3jjUezr5tz9nV+KkqPwI5erKgiqFOE4DhLdE8KP8mVHQVT/95sXg1Grc+2L5UP1
         6C6U1khRPrrodO3GDpCTYySk/rMEwnBMnnslOztIjaJYsSNemdo+A4aQMIVRZU+4fkjd
         gEV5KN44RWW2D6w31LWueCU6kVukn1r+ae2TLlbBeIA+G1gr2SDfqaJfYtvxFQ6UrjOQ
         stoSPb56qqUuT7+shwDSeh7rE4SKMq0WCkOALysyGpDU0j/BGojBOL3CuR0Rt3J6csTy
         gO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028332; x=1792633132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rHDdrNQoCBKWKcv5fc1rtzAB4UD3f4pHDI81s24u/vY=;
        b=kOfjYb4guSA5Us6DKdQkqbGgdHGVYo2FdrFoUDfDtl0ysWGq/+KPN35+CMfKoDeHrV
         hnMxnpuVzkWc1q6/tdlcwRg/c3LeFn9O/sVjZEAhAMGsjVNQ2KtT2eef/TJ5SNgmbR/t
         Pxe7VAnvWD+MTEg8EzSEp/y87g+xM1cayycUOGVARFRM6774UTobQn35s0gPdbx/kPV+
         uMWrAMmTh+hTsQilh81/iSwhv6aVcXSCMeCJle32oS2ybO9QtEpQ3JVGKGzgUBuPc6tA
         XgFoEnkOpokjqZn/+XIv7NOP6iPqgQhstGhiyanLNgZOs2TRrlmTQPSbbed7z6GO0NKD
         xO3g==
X-Forwarded-Encrypted: i=1; AKwUvBwWoP0s0GosR0B/puTKQfe9i5swjQcATRNVTjAYIKr37G3LoYqaay9AVmC5leFR/FlbTvJQG/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9RCZkNj4ajzVflvrAiFFn/j/n+0+o/Mtwy7mREO1gLW/o8x97
	h+jC87vmZrI681Yx+avkAYq/H9zwHzMeiK4MSvYIoeV9rsemwHd+Lifc7yVq+c17pjoKFfe4vN2
	s3lD5Z1FKhVDclFGAvmOee4R0DNdOnQZJduATmw+RvzkcSjIc+ZZDDvcsXk0=
X-Gm-Gg: AYBFou1JY8adQtJfC0yHKp+E3xiTWEeGZPURJ+1HKIwUUALQtfJCJxjDxOoJV3JFIwY
	uZ17375heMY68pthQJrBmm26Pk2UtkSzqdGm0+Lc7qOE2BJqb/LPobvcHoc1GqGi1tcw6ifP353
	a4J8oDqCM+ZNZ5Dk7TkdVA4tc5SVznyq3SKSn4uGQNntzYMfpGOqVbugxIohxXkgDN6dLZCwxTc
	VJ5bhzLiABfnF/X1YTreRbgkTAXOmtSpBYCCW4cn02L+4STQNGe0C1o1za5dJjY5FUDAfCTB8RW
	TsTqGzbMIqqHWuXq2V0i2aGIgEetpAiLfkjpFgTG0q4u+HVeF7bpSbgBlatK1wkkmCYOhRhz59t
	1gRPIitYISGOoRyaMtg0V4bHFU9DeTmEicE/8eJscv3UMwHEXf025OLz36VA=
X-Received: by 2002:a05:693c:4146:10b0:35d:ddf2:e986 with SMTP id 5a478bee46e88-35dddf2eaf5mr5332916eec.11.1792028331807;
        Wed, 14 Oct 2026 18:38:51 -0700 (PDT)
X-Received: by 2002:a05:693c:4146:10b0:35d:ddf2:e986 with SMTP id 5a478bee46e88-35dddf2eaf5mr5332888eec.11.1792028331036;
        Wed, 14 Oct 2026 18:38:51 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm56908182eec.16.2026.10.14.18.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:38:50 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 2/2] remoteproc: qcom: pas: Don't fail attach if the remote has crashed
Date: Thu, 15 Oct 2026 09:38:27 +0800
Message-ID: <20261015013827.716465-3-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015013827.716465-1-shengchao.guo@oss.qualcomm.com>
References: <20261015013827.716465-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfX0fhPLwNjry9I
 s67fmXT7UirrXa2sh5S19oW9m1klTqLkWf4qjz6+zUjyZ6DTYiI2Xup5A5waq+Y6snKJHVWNtca
 6SmrRxHclsGMUDrYlIRe5o4Oi5ZhlL8=
X-Proofpoint-GUID: q8S-l0WeZT2YxaaBwuWeaKQ1i5zMb6cr
X-Proofpoint-ORIG-GUID: q8S-l0WeZT2YxaaBwuWeaKQ1i5zMb6cr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfXw3JZdApfoaWn
 sMqiRdoDczodEFF/qweT2g67UH4kNn2431uJmKJozTm2t2c/NHfkGpIsleb3WC4FotQTg/0Cssw
 0Acv35sIh3fKSVCbDdY/cTBejyadu18D5FDCAo44homGG2ZnkBxFF9kz5LoM7arRakV1LJcsLCn
 NRJi5G9BJclaZOwSGL3vOhYuj7BMaiWvcSniNHVGnVOg/ka5uadXu/d72Eo4NKCfOgILMPMyjzE
 zyK3SuUi2XkNZVeQ1QclYOb8GKGEbqpTlNufBS5bywbXw8o833cFuUImdwfTGef0EnIMhnOs5TG
 GPVjZiyjnlDhZjkweFXWYpbZFdEdGZZQu2kOo5W8gAkcRrCzsvCiTdl/PPC8/Pgk/kP4kiUetgY
 Mywv+TfJmaOlKmXNRdHoNDM2mjRHakrMvwEgjdkRdHrwxCleHX4kQznLrRc3u/moikNGfRCxWL1
 BSIC6vxIJqrHsswo/lA==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6ad02eac cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Hl7sYoTBFiHLiXpXmLQA:9
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150006

When qcom_pas_attach() finds the fatal SMP2P bit already set, it reports
a crash and then fails the attach. The core unwinds the attach while the
crash work is queued: rproc_boot() drops the power refcount back to 0,
and __rproc_attach()/rproc_attach() unprepare the subdevices, clean up
the resource table and disable the IOMMU. Once rproc_boot() releases
rproc->lock, the crash handler finds the rproc still RPROC_DETACHED,
marks it RPROC_CRASHED and runs rproc_boot_recovery() on top of that
torn-down state:

 - the subdevices are unprepared a second time by rproc_stop(), so SSR
   and sysmon notifiers see a duplicate shutdown;
 - qcom_pas_stop() and the subsequent rproc_start() operate on resources
   that rproc_attach() already released, e.g. iommu_unmap() on a
   disabled domain for rproc->has_iommu;
 - recovery leaves the rproc RPROC_RUNNING with power == 0. A later
   "stop" via sysfs takes power to -1 and returns success without
   stopping anything, so the remote stays running. A following "start"
   then boots the firmware again on the running remote and fails to
   re-add the still registered subdevices:

  sysfs: cannot create duplicate filename '.../qcom_common.pd-mapper.0'
  remoteproc remoteproc0: failed to prepare subdevices for adsp: -17
  remoteproc remoteproc0: Boot failed: -17

A crash found at attach time is no different from one reported by the
fatal interrupt right after attaching. Factor the crash handling out of
q6v5_fatal_interrupt() into qcom_q6v5_report_fatal(), which logs the
SMEM crash reason, clears q6v5.running and reports the crash, and call
it from qcom_pas_attach() before letting the attach succeed. The core
completes the attach with balanced bookkeeping, and the crash handler
then recovers the subsystem through the regular RPROC_ATTACHED ->
RPROC_CRASHED path.  With running cleared, qcom_q6v5_request_stop() does
not wait for a stop ack the dead remote cannot send, and handover_issued
already prevents a spurious handover on stop.

Assisted-by: LLM
Fixes: 16472c99f469 ("remoteproc: qcom: pas: Add late attach support for subsystems")
Cc: stable@vger.kernel.org
Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5.c     | 22 +++++++++++++++++-----
 drivers/remoteproc/qcom_q6v5.h     |  1 +
 drivers/remoteproc/qcom_q6v5_pas.c |  9 ++++++---
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index fe148b4b3775..51b24cbd4336 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -147,15 +147,18 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
+/**
+ * qcom_q6v5_report_fatal() - report a fatal error of the remote processor
+ * @q6v5:	reference to qcom_q6v5 context
+ *
+ * Log the crash reason published by the remote in SMEM, mark the remote as
+ * no longer running and report the crash to the remoteproc core.
+ */
+void qcom_q6v5_report_fatal(struct qcom_q6v5 *q6v5)
 {
-	struct qcom_q6v5 *q6v5 = data;
 	size_t len;
 	char *msg;
 
-	if (!q6v5->running)
-		return IRQ_HANDLED;
-
 	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
 	if (!IS_ERR(msg) && len > 0 && msg[0])
 		dev_err(q6v5->dev, "fatal error received: %s\n", msg);
@@ -164,6 +167,15 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 
 	q6v5->running = false;
 	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
+}
+EXPORT_SYMBOL_GPL(qcom_q6v5_report_fatal);
+
+static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
+{
+	struct qcom_q6v5 *q6v5 = data;
+
+	if (q6v5->running)
+		qcom_q6v5_report_fatal(q6v5);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
index 8991ff090579..a0507860a21c 100644
--- a/drivers/remoteproc/qcom_q6v5.h
+++ b/drivers/remoteproc/qcom_q6v5.h
@@ -56,5 +56,6 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon);
 int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
 unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
+void qcom_q6v5_report_fatal(struct qcom_q6v5 *q6v5);
 
 #endif
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 89450cbdb1ee..c50744bee506 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -562,10 +562,13 @@ static int qcom_pas_attach(struct rproc *rproc)
 		goto disable_running;
 
 	if (crash_state) {
+		/*
+		 * Complete the attach and let the crash handler recover the
+		 * subsystem from the attached state, as for a crash reported
+		 * by the fatal interrupt.
+		 */
 		dev_err(pas->dev, "Subsystem has crashed before driver probe\n");
-		rproc_report_crash(rproc, RPROC_FATAL_ERROR);
-		ret = -EINVAL;
-		goto disable_running;
+		qcom_q6v5_report_fatal(&pas->q6v5);
 	}
 
 	return 0;
-- 
2.43.0

