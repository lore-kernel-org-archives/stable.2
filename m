Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160568;
	b=2Tep8ujNeQE0uCuIEjFo2G6kpZkkPcS+iNCpd+STkbL7Cgv2QWkKc+2ag9i05yoPCbtK
	 1Ozrtfqk1QSgAfQKyzJOXN0AKWJqjLtqVgt9AkSBz5+/mgV3tNBTqnU1qlMz9iLVx2ACS
	 yydRYutXXGJCjPrBGGVzwZfoe6kCNmVirk7BPsvQ05Xz7HHq5WUwwnaJ5fWXQmPoLV+20
	 hDfgQ4wKQdZvfnWdQYUOAAEt/VwVxt5e3Z6hd1dDe2O60XSgdtGTQvIAdPiVdNfxXrcgI
	 +7MqmnV2jFH4j1bqtqQAdsfRV8D29z+7ndP0W1wGC1GV0iBgnpTRVBV7jlGBvq8hxKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160568;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3P3TooIy4YwC/bRKTvp92lrYDHs8AxA9i4f4CNemL4U=;
	b=ebtPF5jH9i/GBqgKvlaTcap9SzRpbRdB+0DpxMZI8MWjdUSbpmjBxzsqqr9hb7U84Ce7
	 Ht0gXRF0xUhW0E5L77iHVD6dcvACHzWOB0Wgl6dNc3WBkJu2ALv+TB7u9yTFkbKokPfMK
	 eXxVxd9qgJfCaEjsXQuYChGf6qLkHrWzTsOxWhcIHFAbmNEs+X/H8EXZr9Sy2BUFF9VSb
	 ID2FhfD7wJ1QEvM34W4enxRlGiOCuLAfPQxazKMS8v8K7ek/Sh92xxedenGWIEy/Pd4sT
	 Cky4pA619ZvD4lPCtcI038t8/Ssxxk9v+dzXQQGjR7foq4PjQ3u47gRvIvf5xN8UdXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pEPfKawD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Zn/CSdY2";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA260A2626
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45FA260A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pEPfKawD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zn/CSdY2
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fO73650516
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3P3TooIy4YwC/bRKTvp92lrYDHs8AxA9i4f4CNemL4U=; b=pEPfKawDG7fq90N5
	w4DnlJwKZNzf1oYKZLvKfZ/69TrOVh6/aOzyDAjfQUEBzh8TVC5ZRWXArcQgeNWf
	ay1JAWa4NhxqcoVzbGCK4DauWnh5ELVyzCB894yA5hjX9OE0jZtllYTTTmlu9KkC
	cZ5hEtKbBPknbi+6NmybKtXtQiGm4w1fhYcYG+STBj/2OvmCx8QycmnLKB8ovWLt
	KEdozHda5nRFd43Z+U9ycfFAIUctnfS/JrfupL8J9vcGIbbhbBFfoqGJ0vsxnmec
	LoboY6I/HW3ZjFkTCnWE5y7A3Iqm9GTaBK38cvuj1ydFjwqPsfYAXxsiJXUY7aUR
	J2+slw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fyjgdp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b4092b645aso769799a91.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795160566; x=1795765366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3P3TooIy4YwC/bRKTvp92lrYDHs8AxA9i4f4CNemL4U=;
        b=Zn/CSdY2rRD33exT2i0GuJ9euLTlMZEheBzHzR2kK3wLzDcYYHc5i2my6fX5lnAINH
         o8Q+GztoHnTAFPBEkTp4Uyy5ySxf/dXLaraSefET1WHNw/XMUbQfB/118hUr+FJFeftj
         28hvJxwfp310QBVlWnsGFlUKOHaIegijB11RzhomayOl2ctAvzS91Yx+YKm3FkcKLZ+Z
         8FBISkCbrDMpfo6CbGxiNiqZx7BlkGZHvNKzJuzGr2Tz1PSCsUihVamycPNf0GqhgFn5
         qyTtrDWp6HfiUXhZQWUAdCLgemBFHGmO0dVxqL3Fq6IHgQMCSXfoPkIx4nfY6U3LrBlp
         6VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160566; x=1795765366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3P3TooIy4YwC/bRKTvp92lrYDHs8AxA9i4f4CNemL4U=;
        b=PwIbm1kzaaFt3nH3IL8vT80rjAOmsras/LM392GJ3+W6oOxX3dgZ4uJLLHD9KN7a0z
         2zFyyCJFznq1+sB/9BxsNTnc8Pd0m5pmcQAnwXjX/WBF/1AkBGafZ7YpQFe2OmEghvy3
         EoyM9RkXfzQySiCNso4j47lMeO+oyDHxp5IKiN2EEHcBh1o/FvRzcnhLFcctwqV8bvrG
         wc4MD6rzi1weYTBKJ95mIgbyStXluSVApQ9nw2251idnp0GsDyh7T+eGLfFpM5Ft75VK
         d8t6EdF39POaKTLW5rdBPOj6Ao1mZ3VsLF7LKAE0u+j3WxWRKX6V2+TVoMTxSRbdMlCX
         Ijsg==
X-Forwarded-Encrypted: i=1; AL+hErFhuOMy9ZkMFK2YSwqlnHnoEEeriQsy7iIrjsTIr6iA7h8CxRKDdWpCy7AS+Y2T67yuz2+wdVw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ySz4LHfxSi7jJT8EcuSDBEXcbUpNmW4vMbsYHK6dPYxEbt/S7
	/TjAFbFAHxPu0DaxxwlyesrDJ619Zyed4ouKcjnjj6h5ief5mQEzXYffcFbYWoJEYie+N0Noonc
	L3qOK3/fClJJv6s30zlf3YcTQMkNjkl3XDSjlnvk+rlgb/OJJdodTUrDovkY=
X-Gm-Gg: AZFdTZe7Rh4gjErzH8cn7jdrtkvWTod1qIlwECrxAObbBJ409Hjfsx2Z0yrAjAD9RmK
	0W3xv9lDmysLT0uP2QnVzg41298h0qSX0Fb2xDNCTGR3UirjvCDY9f2PI66vG7L/pBVEDtDmPQl
	WbeJ9S9IBw72Kcj2x8z7Avytnu6bJJCaqtpxr54LET3AxinSPypidfQGvFscGsd9fG5u5V3Zp6D
	ErgJ7tzQI32McPqLDQclKK9/eMSGkvCjO7zd+omXWNVonUF4lIQkUhqsecLedxGIZEwoWs4kWyg
	7ihPpHxJhBUmX5CNjI1SgK/yWzzumqxhak4Xf2C45GRBJnDIvTFfzsnK8W64Jijcpetp++LVj48
	HsvseR9uTLA62sL/Q2wTIOBHBeqco6KmZwNudpY8/SsB/aNQC+BJBclnq5cuPe+m3EFIvM9USxd
	V4TnidLj0=
X-Received: by 2002:a17:90b:4a48:b0:3b3:c675:d923 with SMTP id 98e67ed59e1d1-3b41c908109mr1955437a91.28.1795160566234;
        Thu, 19 Nov 2026 23:42:46 -0800 (PST)
X-Received: by 2002:a17:90b:4a48:b0:3b3:c675:d923 with SMTP id 98e67ed59e1d1-3b41c908109mr1955410a91.28.1795160565766;
        Thu, 19 Nov 2026 23:42:45 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4323bda5esm119935a91.3.2026.11.19.23.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:42:45 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:12:06 +0530
Subject: [PATCH v3 3/3] media: qcom: iris: Skip register access in IRQ
 handler after power-off
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
Message-Id: <20261120-fix-disable-irq-safely-v3-3-82f9561394cb@oss.qualcomm.com>
References: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
In-Reply-To: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795160546; l=3824;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=iXUOI58v6kMBfsFr8HiiRVJVTLJdxn/a84melQWTXhA=;
 b=HbLLiFbKrXMtrwVZkPPtoPJGi1LMi/4DLPd6HugzGcTU1AZORkd2TKLtQvMLMwjC4ObdWw4qU
 COXsa4UV4DbCZ7QTI/Q3LqUY5vFzGMdO2MBLa0j5zQI+pewmUnvLUyE
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMCBTYWx0ZWRfX1AezxmvaydEe
 m0t4aFFkwH9065ZmSAybDp092Tgw3PDBq/l7h5NQEVDCradwLrSRN0aALXAdmMCmmwz534i5AEj
 eItATsWlJfuHobzdp1DKdRW89yAoLW8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMCBTYWx0ZWRfX7nJLAv0cpkda
 sfQZT10lbYKRFpjbW+eNFSzbp0wOhvMK8w2Q7czS6lg7gop4OPUjF2+kXaORzfzg9GQikRbNzf1
 1yW7/MQowqO7ERsCIP94jUomtr9gfi9Ng872t3QW0t5+70Qe6gnu/dqojQi8iCOXcWkYmfq5hiL
 6D+3ks2yIt9dpwytmzBc76eLGcOLefyoU5zXiiv4YVk7sqfqB/Q3JMrQMZ/X+sODzkXSNnHjhz1
 IHHQeVxu1+CL/NZ36GctYU66LnHBaVkUDDBJ1iZ9uoatNTLVmAk4ZOyftFbQLbt9U/Ubzikzc8o
 DEljcZ9a4wG8lkg9RWJc9YDFvdAkwr3N55/Kpx0Xc0g5scyCphYfCiUhUhx6dgSOc0YSAtsiYl1
 bzjNQ19Cco6yC3zXg5+MvkkSAYYmdp9/4YkgneLxZInpCdG2XyR6QIDg0DADWAOKB0sGmW6/2mK
 fhd/AP64H9LfrUS4hwA==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6afff9f7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=acxGgeGPnh0hIPSWkr0A:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 0G2-iqowDCtp68rG-7L6HanKsjtZu6Je
X-Proofpoint-GUID: 0G2-iqowDCtp68rG-7L6HanKsjtZu6Je
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200030

The threaded IRQ handler reads and clears the interrupt registers
under core->lock. Power-off disables the IRQ without waiting for a
queued handler. If the handler is woken and queued around the same
time power-off is entered, it runs after the VPU is powered down and
accesses the registers of powered-off hardware.

disable_irq() cannot be used to wait for the handler. The caller of
power-off holds core->lock and blocks in disable_irq() waiting for the
handler, while the handler blocks waiting for core->lock.

Track the power state in core->powered, which power-on and power-off
change under core->lock. The handler checks it after taking the lock
and returns without touching the hardware when the VPU is off.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h       | 2 ++
 drivers/media/platform/qcom/iris/iris_hfi_common.c | 6 ++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 468ccb551ec3..ca1a55bec334 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -70,6 +70,7 @@ struct qcom_ubwc_cfg_data;
  * @message_queue: shared interface queue to receive responses from firmware
  * @debug_queue: shared interface queue to receive debug info from firmware
  * @lock: a lock for this strucure
+ * @powered: VPU is powered on, protected by @lock
  * @wdt_irq_disabled: IRQ was disabled by the handler on a watchdog interrupt
  * @response_packet: a pointer to response packet from fw to driver
  * @header_id: id of packet header
@@ -117,6 +118,7 @@ struct iris_core {
 	struct iris_iface_q_info		message_queue;
 	struct iris_iface_q_info		debug_queue;
 	struct mutex				lock; /* lock for core related operations */
+	bool					powered;
 	bool					wdt_irq_disabled;
 	u8					*response_packet;
 	u32					header_id;
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.c b/drivers/media/platform/qcom/iris/iris_hfi_common.c
index a27c543e75bc..b7be3ccf499a 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_common.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_common.c
@@ -98,6 +98,11 @@ irqreturn_t iris_hfi_isr_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	mutex_lock(&core->lock);
+	if (!core->powered) {
+		mutex_unlock(&core->lock);
+		goto exit;
+	}
+
 	pm_runtime_mark_last_busy(core->dev);
 	iris_vpu_clear_interrupt(core);
 	if (iris_vpu_watchdog(core, core->intr_status)) {
@@ -109,6 +114,7 @@ irqreturn_t iris_hfi_isr_handler(int irq, void *data)
 	if (core->hfi_sys_ops)
 		core->hfi_sys_ops->sys_hfi_response_handler(core);
 
+exit:
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 54ee7a671ef8..73ac63376b91 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -234,6 +234,7 @@ void iris_vpu_power_off_hw(struct iris_core *core)
 
 void iris_vpu_power_off(struct iris_core *core)
 {
+	core->powered = false;
 	iris_opp_set_rate(core->dev, 0);
 	core->iris_platform_data->vpu_ops->power_off_hw(core);
 	core->iris_platform_data->vpu_ops->power_off_controller(core);
@@ -520,6 +521,7 @@ int iris_vpu_power_on(struct iris_core *core)
 
 	core->iris_platform_data->vpu_ops->interrupt_init(core);
 	core->intr_status = 0;
+	core->powered = true;
 	if (core->wdt_irq_disabled) {
 		core->wdt_irq_disabled = false;
 		enable_irq(core->irq);

-- 
2.34.1

