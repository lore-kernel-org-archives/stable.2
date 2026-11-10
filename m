Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319920;
	b=A23SLlKCnOz/AbeZzI/A37tburmB0ntU8sgwPhKM8dEtPNaJi4xvgBTyv0ZSOS4nODuk
	 xSX3KUNZ76JD/pUoSQqOo3x5nPr0bn0YQLNaWZeEQavovFQVbcSk6lS4Oj/jmQk0x3trU
	 5MXiP+GMSHU13RM8k3h4aTnasupxAfT1U8K6g3vtZ846kEx5b7iVEHFNbmoko324EiZZo
	 OPlyjmWJcLvHzpwjbEt7lI+yag+JGZOiqoD+QCkiVH47uScqWCtwRJmIdfqWNRzG8be29
	 LpuM6P+pnUBh4F4lC7g/b9mYn5bkvCMxENfXV+ejAuBKbPsS1/01BhRknqvMRSyJhXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319920;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yA5vX9qeRETjTGDhFHRbt/eU0bx3os+jUpLOPDfLilM=;
	b=ytHqfhnE1nygQv1524xWkjdgbtQ3NvWdHNltPCPx+kwUJyWgo/27WWvkb9vKv2Isd2eC
	 Sl/7saIK2vaS1KJTLtz0ADKdunoYOKImHhtC0DPkTovD0dhgAch6HW9Png/Bxb0xOrcqb
	 PmxdjenDFZjkwqJpd0ozMovDd1wu9fbUkdF44BpgJWMegnhAv1FzKK7kWXgwiP6jorEJk
	 vgcLhNsOejZmgrXt3cthfqQDwYuQ3OvgwtcmeUWJ0aDPWXTOQdeO3lHZTGFSGa9FXwEBN
	 5NsXMZWIyjTIJ6RpKKsEfGJV4BYxDRfmZNVHXlcbndgMznlZuJTrDQA7f6lmG99FA/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPbDPbbO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fdx522Aj;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690160A3819
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0690160A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPbDPbbO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fdx522Aj
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAGrn3178211
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yA5vX9qeRETjTGDhFHRbt/eU0bx3os+jUpLOPDfLilM=; b=LPbDPbbOP9fP28+0
	FbsJJLXydj54lFnKGF1psb43s0LwUkFHKzC1V/QJPbX1yaZVM1ppYVChRuh+Hcsf
	oJzsqb6QrI/wdhblL6wTpb5ShbDXtzBNylOa9gi7zzf7vWEF68qVIE6TP5lArGVw
	uE7XnoDGQkG/YA4fSm8/LQdW7eDEHop/OEePqYW6amsiHZllo7PGOGmtKtsbBq5N
	BgIQirao8F8QOveb6Wj62Kbokxi8MRc9sMVBM38GixZnb3NsIDw1ubLKd2dwSwA+
	At6kLUZQ+h786ckdg+Nu1rk5SpMV/+T8lQtPQO3toBdiCVGug0iLQDwaK6i4ucqM
	H+1nwA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufs47s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36de26cb4b3so2738169eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319918; x=1794924718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yA5vX9qeRETjTGDhFHRbt/eU0bx3os+jUpLOPDfLilM=;
        b=Fdx522AjDV41gcXBiVCi9Lt1/YuZLWVJfBi2EIh8H6BgskifqkOcADubVKDxuFc7FP
         qJTjFCupHZ8IpWFEEuOmhJnQekDE5siumk1G+Y8YK0jFIWhrhlzjF4QGSFcV1KKwKjT4
         DMRH7kYih9ebN9G+94DobM1lJxl6ngbDzIrKCa0brhUnFLKZ5WFHGFqgnWXGr1Z/lUYb
         +FlIioo4i1SwqQmNRMS69OFm8z/eJfQ8UpLBa1AIWYfb8XTTm6h+7i3F64fYwSO9vFkN
         K72ZaVBMVuV88SjLzBfxVWp/1/2h6WdX6KuvB+Nbws0xy06WSr3yszZo6FxzS1KYuR4s
         Yyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319918; x=1794924718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yA5vX9qeRETjTGDhFHRbt/eU0bx3os+jUpLOPDfLilM=;
        b=DTjbJt+FZT+H0+C+0DTpzrFMW7n8IRE+iGV1HnQrXKDtUS7zai+gWvZncLV++Eauoi
         Q0HaCMcU/4EPA2JB54UxzaOBBpT/33hXu/1SsDLsCWIpxMbFQizWjT5wXP+TAWTgfKTd
         Bdl5DQBDH3QdnSJ4zfhk/yAS+/9/h242QqzHp0p/Y9Qr38XDRkMCjt0dA0R0d+jbhk1U
         0YQxWJzJw2LjwnCQ6HCv0J622niJf1nqAMnfx3IqOTk/MfJl8uAGARjWxfzEqMYBgdfx
         pvGheKJhrAxivLZ3WffdjAzgYNachWHxurPr1Gdh/ayOExG0WSHHJjAxIfXW9FqAeC4H
         hkUQ==
X-Forwarded-Encrypted: i=1; AL+hErFBPhOgdnMzmvWv280MteshLEYIk4++Js8eDAMClcbW/dNEY7AosYuOkL4xVDaTMLXjTjXkuPQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BW5VtkNpzrFtvfKVyJT67jzR+FdRkYMaZrlK90bvd9t3c8kft
	GMYoqH+fIaPkkRXe9U/VATDbjuUHURU7EK9tIpruZ6+CBzKSbf1r3U8kFFHFPRSogCaU7nmdENd
	zG+7QljIjDYm4DtXX4ZNrnYg0mnMsjaf7cabNtOqvWCbeSifPzqFpyW52BtI=
X-Gm-Gg: AYBFou1C6FhMS5tJcPIhjkcbhNvXY+g7d62WQTb1oRqg0umvFj4PE44wS740KISFYs4
	wNBc3frrLNF8H06X2sw9AR8MJYJ9WB20cLPYmgaILbQRqoI7TFJeV9rtV5CG9nJl3dFaKILjZMK
	Yy5IfEL3MlYfDMxXkWa8rlEdB5me5TD1aH2RnN4+AO6whmjlm+Q0GmmH9TaukXV3pqij3S34c/S
	iqn1lt7nq08l9DOfXnCHferxVt02bWCXBy4KFJ0oIDRzVo8Cy4dpyM54kTplBxchc63O+6CvTS1
	HyaghDaNET3+TXeggUrXyjitCcPBQcYZ8JFBxj8FAzgkG0MibFFXNwL3FCN2S7ecspDJiGTSLEl
	bED2ieDi0CixPJyOVmHpmbx6L+QVMZEs5tGWqUp7TQVJhEo0xIdEQsEbsli9O/zmk9NRBJLM40U
	1nzP38FlI=
X-Received: by 2002:a05:693c:394b:b0:36c:49a7:86ac with SMTP id 5a478bee46e88-37520713cbamr4276275eec.37.1794319918279;
        Tue, 10 Nov 2026 06:11:58 -0800 (PST)
X-Received: by 2002:a05:693c:394b:b0:36c:49a7:86ac with SMTP id 5a478bee46e88-37520713cbamr4276232eec.37.1794319917540;
        Tue, 10 Nov 2026 06:11:57 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm8059128eec.27.2026.11.10.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:11:57 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 19:39:52 +0530
Subject: [PATCH v2 4/5] media: iris: Wake up blocked clients when the
 driver is removed
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
Message-Id: <20261110-iris-handle-unbind-v2-4-86d5f6f1dea8@oss.qualcomm.com>
References: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
In-Reply-To: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794319890; l=3688;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=p29h8OBXt3F9xRaxGiuMS+CHBCIAi6zq9MGnLRFIvd0=;
 b=vaPc6dJN89IQWMT5PNXwtXQaSRSLYKjRFXub4X8WJJ1lqkgjB+x+fhyNZFZFb3LflnFtcULr+
 NparqXkVY3rB9W4O8bkiQXc2XVAAVYUchtvuLb6Q85g8Ay6jDeiNn+a
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: TZTL7-4bK943EVDAEvMBHtOo2EilcQA0
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af3262f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OLikLUY__WNYvvbHpiEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: TZTL7-4bK943EVDAEvMBHtOo2EilcQA0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfXzx3jiKgSIVRP
 0pcC2sts6iMWyR9Eg2MIpHeVCCXvvQKvifrS7uIEUNb4Rbe+AAVkx4Zx/evBM3r6UQWNCVVS5af
 VOFPUO9jaFA/HsIHu7OvFDH7M8A+hHI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX7KZjcO6j9nGD
 Q9YUe8xitjI8dDkDBVZaXA4G0hBlgYoJmBM+gIDYEJsGRf+PgQjqe/etqCnPw+end4CWQMt7aU5
 kfSxJFlICXrSkVikyE7OlXQGLlA6EUyAq+17NEgrfmlaizFwp/TZkOjXOu4wdDWtcfYasCHfKhr
 +SvzBiZCaXswd4v/jqXLr78rkZMH+MmdNaJr84N4OaP3H9+6qzdtZcLLfqjZvaGElgQSkkJ7TrG
 g99UXNqJV8FKtWvvhMzAWkcQbzMyDyNEpTFhiqbwmvQC6/C5G32PO+dwvnB3sQFzo5PR+qR9KqJ
 OXx3/PbXGzuItEogtYfyyEk1+CIS6/KIzht5FlBtlVUzxHk6mo32KJOr4onE/KWR3FnzQ8W1rl1
 cdS+1S1b/9OuoL6HXqqgY+7bbAA46qvUokRPEaRRxzv+l3WHEOtXrUsVN7EhNbTx4yKN4S88CuE
 sZuxIF8xf63KgXtT81g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100056

iris_remove() does not wake up a client that is blocked in
VIDIOC_DQBUF or poll() on an open session. The client stays blocked and
keeps its file descriptor open.

Flag the vb2 queues of all open instances as errored after the core is
shut down. This wakes up the blocked clients, which fail with an error
and can close the file descriptor. Skip the instances that are already
closing, as iris_close() releases their queues.

Fixes: 38506cb7e8d2 ("media: iris: add platform driver for iris video device")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_instance.h |  2 ++
 drivers/media/platform/qcom/iris/iris_probe.c    | 16 ++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vidc.c     |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 771269e705d9..cb84753e4f91 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -50,6 +50,7 @@ struct iris_hfi_session_ops;
  * @icc_data: structure of interconnect data
  * @m2m_dev:	a reference to m2m device structure
  * @m2m_ctx:	a reference to m2m context structure
+ * @closing: set on close, skips the queue error during removal
  * @sequence_cap: a sequence counter for capture queue
  * @sequence_out: a sequence counter for output queue
  * @tss: timestamp metadata
@@ -98,6 +99,7 @@ struct iris_inst {
 	struct icc_vote_data		icc_data;
 	struct v4l2_m2m_dev		*m2m_dev;
 	struct v4l2_m2m_ctx		*m2m_ctx;
+	bool				closing;
 	u32				sequence_cap;
 	u32				sequence_out;
 	struct iris_ts_metadata		tss[VIDEO_MAX_FRAME];
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index dc83daccea5f..51054862bc64 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -12,8 +12,10 @@
 #include <linux/reset.h>
 #include <linux/soc/qcom/ubwc.h>
 
+#include "iris_buffer.h"
 #include "iris_core.h"
 #include "iris_ctrls.h"
+#include "iris_instance.h"
 #include "iris_vidc.h"
 
 static int iris_init_icc(struct iris_core *core)
@@ -259,6 +261,18 @@ static void iris_core_put(void *data)
 	v4l2_device_put(&core->v4l2_dev);
 }
 
+static void iris_instances_vb2_queue_error(struct iris_core *core)
+{
+	struct iris_inst *inst;
+
+	mutex_lock(&core->lock);
+	list_for_each_entry(inst, &core->instances, list) {
+		if (!inst->closing)
+			iris_vb2_queue_error(inst);
+	}
+	mutex_unlock(&core->lock);
+}
+
 static void iris_remove(struct platform_device *pdev)
 {
 	struct iris_core *core;
@@ -278,6 +292,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	iris_core_deinit(core);
 
+	iris_instances_vb2_queue_error(core);
+
 	pm_runtime_dont_use_autosuspend(core->dev);
 	pm_runtime_disable(core->dev);
 
diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index 04bd37b93445..bb3519eff3b1 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -312,6 +312,11 @@ static void iris_check_num_queued_internal_buffers(struct iris_inst *inst, u32 p
 int iris_close(struct file *filp)
 {
 	struct iris_inst *inst = iris_get_inst(filp);
+	struct iris_core *core = inst->core;
+
+	mutex_lock(&core->lock);
+	inst->closing = true;
+	mutex_unlock(&core->lock);
 
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	v4l2_m2m_ctx_release(inst->m2m_ctx);

-- 
2.34.1

