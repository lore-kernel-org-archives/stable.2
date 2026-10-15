Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6792C08BB
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028331; cv=none; b=nXZ6w1K+6UPjt3ZLJH0mKMsyDoPrVnaXHlHR+7zEXRj5xLNIBF4M9xanj9baj8uIAIbR87St/6v94WzDSeTm9WdcvYLT3loNnQGaOFb3gDOquzdnvqxMakk2KH3KYDUKua4iVYo1GxoxvAVeOI5YHEU+WaLfJjFHMOszqbSjibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028331; c=relaxed/simple;
	bh=1GgmLeFnWC2w5RPHnjAu6+rSppEjKsnJM1u/ggqhPeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7mlGvxMEZlBbMAfJCQIJDT5QegsXT65JcH18TIwp0MLojAh2FNJW/5g4nfzh9JTEXf2vzfUD3OUuyVbb5ib9dLhfp15V8BUDozGgR2nF2YnJ3t208fw8IqQeGRJgGFSVIxrySJiUoS616bdkBwGMMhlkuGRHqdoy/uEGMtoODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b04vKikQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZSreFlGb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b04vKikQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZSreFlGb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F00R7L2121427
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QIhdkwrLd+/
	3owLQL908r6Nq0sAF6ZPN/2LcHn36TWQ=; b=b04vKikQ+bzVdguMzloSf/ROhZe
	fIDbkGwwSTMHNpJfWFv0u6PYinpHsV8kdANbaNsNZHe1ZLzlJno7KD6PPKRfCr3S
	0m4YI+QXKVSCjqt0pu+biwLpaGD2DstnR/lkXF0+B5+gh361AB35tDTtpbbS9m1G
	jvFs1jpPztYPajQ+A+4Y8Y6LhCFLSqfx7NortWn/QwQP8DtF1V7vSikg+NKRW6TZ
	XxdXTAsasnKJApjnIUbhmWnVopMQesSKyRSJJNVBzJOlYlpXLHQ6/VR4DIZHwW3K
	mgeolT7ckcbF/iyDAMtI9V3hHmTDeEkGeEfPS+FZVa/dyBIYCU7dfO6snzQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn08sr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:38:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35d4538fd74so4764128eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792028328; x=1792633128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIhdkwrLd+/3owLQL908r6Nq0sAF6ZPN/2LcHn36TWQ=;
        b=ZSreFlGbSvk4ixC3lTeW5HRkUHW3EDGx9J/QPEOnMrAvVPGM7yK6h/5NRRe8J/V0vK
         bi2or4kXz5UJj9lfoIEuFS2vI1YKuvR1gE0v/pHJedgErsuZjPblh0l/EHHUd4FUtKZj
         KD9ERJPRVxS54aQUm+OsFTTkGceAJ+DSs9+a0TnJMzyGT3a4+ir0DICjnMR+9K/jr9Zl
         wctsGK3zxEJdFerhQ3BGpOiq5GGMkUO9ELdtkFbFXPZtwJLIobhIqQUA2o0Oa/K/HktN
         xbXLHtuMhrO1WIM/J8ZyaDWjGHuWarVPhXsv7t8iGaM7kgY5iVMX2h9VmjDYJ0FXYNnq
         eIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028328; x=1792633128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QIhdkwrLd+/3owLQL908r6Nq0sAF6ZPN/2LcHn36TWQ=;
        b=t5LHNayJQW3ayTSwXTV+R70Wr10W2LYMCyhM7ZuoTocVXu5V4aHoHD8gqNLQZpPaz8
         6KFaJ2SU8ndfXVUO2qR0fws2vuPTNM/zpsGvkIC314C6v3hG9ox6IHvFRfwyMQ23CsoY
         YFxU7w/fy3V+SkxqNKnSynXJiaEn/8QAeu2J8dR/BRZqaF3KtkBzNHTjqhVeFpUvyAyi
         rQVahgeUYTvIhNmUJSVYV36Eq+hZPjxmHKPbrH/k2KKOMFO+dZiicpMMAbdfHuT1iS8p
         B/mMtc6BlqwHhAk3D1JqWG5dt3hS4Q+MF46jTdlnCdELQJrSx+ltRIB6qajbp+7snVwT
         S5fg==
X-Forwarded-Encrypted: i=1; AKwUvBzbJObkkOfEkNc8YoHKZ5wlsY8XfgN/mJNt3+DQErge/0wu/oaU5O9le505A+kCA70LKfL7MH0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfKViTRfrJ4n6v3Flotyiso6iWHuhQAG4cmiP710FXB1jafWEA
	j3l8w8wqvhhy4mb5Ugfgt2mvYqn1QYDQlYCVTcTkmo6bB8XRfcWIb3Z97I/9LjpS8vHgOXvCyPE
	5Wq9wdTBNe06JMtS3/dnpR0faMilM9xjUnJ4Wb2RbRfyI+dNHU4chrJIwmNc=
X-Gm-Gg: AYBFou1xEuhShlRdPn+iNqz8bFU49FHMI7PBMq45BT0wM/juPNDsnqHM3QeIMrcj5pF
	cdQQm+M8GK/AsRMQ0LHQH38bFQXP/gbdWW8RGz0isrLeuZZOIqfpmOVpd4RxrA+hJxgXXA3shpR
	cMINpWm3ojDj5sWPmS/p9QP2f48/HZhKNNQmeoE9sDkPzuCwG01Y3dAJ4+OjXETN4ICKZ8T+67g
	KiIx4FtLsWMk1uV/nBJLKxzXgkaTVIAo48vF9cG2Vl4PA+cZYFvimoANCwQn0XJAf+ZGsk2pgwX
	m9ObmuEeh/mwDI3zcHRg2bfWnn+ZKDOCVntoHVAKBBusoJ5giE4w9izOeTIgVDfjhxJ/CBB3xFT
	eVzk8dNVt60RZKLkycvYZLp8DqTTcX6HBWSoKNjTggLt6xvtn1BKWE4Nu1aQ=
X-Received: by 2002:a05:7300:55a5:b0:35a:29b6:b466 with SMTP id 5a478bee46e88-35a29b6c486mr14209892eec.30.1792028327919;
        Wed, 14 Oct 2026 18:38:47 -0700 (PDT)
X-Received: by 2002:a05:7300:55a5:b0:35a:29b6:b466 with SMTP id 5a478bee46e88-35a29b6c486mr14209866eec.30.1792028327240;
        Wed, 14 Oct 2026 18:38:47 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm56908182eec.16.2026.10.14.18.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:38:46 -0700 (PDT)
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
Subject: [PATCH v4 1/2] remoteproc: qcom: pas: Decide early_boot attach at probe time
Date: Thu, 15 Oct 2026 09:38:26 +0800
Message-ID: <20261015013827.716465-2-shengchao.guo@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfX3OPTT/aB4sbF
 2n3e5LuSESutk6n/fN0OceMSbeImbmr2NKmixlstghRYkAwZ2re16+tzc16cTkY6VC3PaLPJ30b
 iJIsi5gERlzYMeCX5zF8sAEUGbJf+37YSNx3fVX9go2DYsJSu8MG21N+JvKLuMD03PU3weUMwxw
 xosgn7gvtjhkZo6Y51uktvPv/w+O0yWfHmQnwKta3lw5PaoIQ8Ro7QTMy9/cfErhF/zLC1P1mpl
 MAFN5XVEmfWY0gwUq9r/jo2nCb/jY2sJMBPPDKAVdOqp812VyZ9IfqCq0F7F0gN9aFxK8y9+bD9
 kuFUj7Ff7EQudHELvKxZPwM+YMyk7oBIsdhscdboRMIkheiSxvzz3ros8077jtm0Cg/6NkYjOvb
 Gx+XH421yPtSQeS/KxasA7YEV1IK59w7ZYGGcpdnAyvMKGSrfBeHZnOZx3RkNXRyWl7/TxWvyfP
 kYxOe+K3KJv1R/bwpLg==
X-Proofpoint-GUID: jrbWkz-FHv4V1QnI6BWZA5nRrKl4oooG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNiBTYWx0ZWRfX/JbLO+tbFfus
 QHJmQIqqGktftipGckn06n24/lSEUxtvCPyWTDNDoIncbAKFJt+nEYywp95WnWvogmYLuTsnnT+
 6Oneovm8tTH9vrvLIoUAdqSaINFlCb8=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad02ea9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WnWnooUoZOtDcxsU7t4A:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jrbWkz-FHv4V1QnI6BWZA5nRrKl4oooG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150006

For early_boot subsystems, probe unconditionally marks the rproc
RPROC_DETACHED and qcom_pas_attach() discovers from SMP2P whether the
bootloader actually started the remote. If it did not, attach sets the
state back to RPROC_OFFLINE and fails, expecting the core to boot the
firmware instead. The core does not do that: rproc_boot() treats the
attach failure as fatal and the remote is never started.

This is hit on Nord with firmware where XBL no longer brings ADSP out
of reset. The remote never publishes its inbound SMP2P entries, so the
very first state read fails (debug print below) and the ADSP stays down:

  qcom_q6v5_pas 4c00000.remoteproc: Failed to get fatal_irq state: -19
  remoteproc remoteproc0: can't attach to rproc adsp: -19

The ready, stop-ack and sysmon shutdown-ack signals cannot change while
Linux has not yet interacted with the remote, so there is no reason to
defer the decision to attach time. Check them in probe and only mark
the rproc RPROC_DETACHED when the remote is up and has not been asked
to stop; otherwise leave it RPROC_OFFLINE so the regular firmware boot
path is taken. The ready state is read first so that a missing SMP2P
entry -ENODEV is treated as "not running" before sysmon is queried.

qcom_pas_attach() keeps only the fatal check, since that is the one
signal that has to be acted upon once the rproc is attached.

Assisted-by: LLM
Fixes: 16472c99f469 ("remoteproc: qcom: pas: Add late attach support for subsystems")
Cc: stable@vger.kernel.org
Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 64 +++++++++++++++---------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 2e1e39826ffa..89450cbdb1ee 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -550,9 +550,7 @@ static unsigned long qcom_pas_panic(struct rproc *rproc)
 static int qcom_pas_attach(struct rproc *rproc)
 {
 	struct qcom_pas *pas = rproc->priv;
-	bool ready_state;
 	bool crash_state;
-	bool stop_state;
 	int ret;
 
 	pas->q6v5.handover_issued = true;
@@ -570,42 +568,46 @@ static int qcom_pas_attach(struct rproc *rproc)
 		goto disable_running;
 	}
 
-	ret = irq_get_irqchip_state(pas->q6v5.stop_irq,
-				    IRQCHIP_STATE_LINE_LEVEL, &stop_state);
-	if (ret)
-		goto disable_running;
-
-	if (stop_state || qcom_sysmon_shutdown_irq_state(pas->sysmon)) {
-		dev_info(pas->dev, "Subsystem found stop state set. Falling back to start.\n");
-		goto unroll_attach;
-	}
-
-	ret = irq_get_irqchip_state(pas->q6v5.ready_irq,
-				    IRQCHIP_STATE_LINE_LEVEL, &ready_state);
-	if (ret)
-		goto disable_running;
-
-	if (unlikely(!ready_state)) {
-		/*
-		 * The bootloader may not support early boot, mark the state as
-		 * RPROC_OFFLINE so that the PAS driver can load the firmware and
-		 * start the remoteproc.
-		 */
-		dev_err(pas->dev, "Failed to get subsystem ready interrupt\n");
-		goto unroll_attach;
-	}
-
 	return 0;
 
-unroll_attach:
-	pas->rproc->state = RPROC_OFFLINE;
-	ret = -EINVAL;
 disable_running:
 	pas->q6v5.running = false;
 
 	return ret;
 }
 
+/*
+ * The bootloader may or may not have started the subsystem. Inspect the
+ * SMP2P state, which is static until Linux interacts with the remote, to
+ * decide whether to attach or to load and start the firmware.
+ */
+static bool qcom_pas_is_running(struct qcom_pas *pas)
+{
+	bool ready_state;
+	bool stop_state;
+	int ret;
+
+	/*
+	 * Check ready first: if the remote never published its SMP2P
+	 * entries the state read fails with -ENODEV.
+	 */
+	ret = irq_get_irqchip_state(pas->q6v5.ready_irq,
+				    IRQCHIP_STATE_LINE_LEVEL, &ready_state);
+	if (ret || !ready_state) {
+		dev_info(pas->dev, "Subsystem not running, not attaching\n");
+		return false;
+	}
+
+	ret = irq_get_irqchip_state(pas->q6v5.stop_irq,
+				    IRQCHIP_STATE_LINE_LEVEL, &stop_state);
+	if (ret || stop_state || qcom_sysmon_shutdown_irq_state(pas->sysmon)) {
+		dev_info(pas->dev, "Subsystem has stop state set, not attaching\n");
+		return false;
+	}
+
+	return true;
+}
+
 static void qcom_pas_coredump(struct rproc *rproc)
 {
 	struct qcom_pas *pas = rproc->priv;
@@ -1024,7 +1026,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	if (pas->dtb_pas_id)
 		pas->dtb_pas_ctx->use_tzmem = desc->needs_tzmem || rproc->has_iommu;
 
-	if (desc->early_boot)
+	if (desc->early_boot && qcom_pas_is_running(pas))
 		pas->rproc->state = RPROC_DETACHED;
 
 	ret = qcom_pas_setup_tmd(pas, desc);
-- 
2.43.0

