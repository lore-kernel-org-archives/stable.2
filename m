Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387974;
	b=Cjt5RLVCBn7PuuAX5avPVNnMv1qe2qdNUOwiX4vzcG11jFJmcrIQo0uiaIcfWT2NE3XU
	 yIUhYXGk5QBuOtbSaFFghui70qMelqstSx7gOuYx4ePnI4FC5lNBMvUzEDJhYI6TR5yQr
	 8IHeRVmMqZ44wJWSmg9IrlKodxpJHG+N8yD/j/QoaVOifPASGgHausxKoIY7aqh6XQUxd
	 zZ58oyCmQUVNJ0gpSLKddH5PzKp/W+Z0GIIcofY6LstmoJ08IIgOCck/Go/L4GHBvuLzR
	 5Ceyu7jlZGygV+o5KwPS3Hal5MEAhgNBlvni+QZUJL/fLviNn2rziFvQZ73RINatrRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jJ1JsynB2e3MSVjtmDprF6rlf5Tt+xzmdqIVfoB7kqw=;
	b=W4k4XD9v/5tVE413lGMJjUOtze9gBiGc8+zF672RJRm+KORxRUv4xxArtc22VIpbkANL
	 xC7ESK6OFWIseEezGnq79pfdeW6ydZqvuMIe608OK2C7UaxP5V7JRi7xk3o/iPsWSGqiz
	 29QmeKG2sFTVLeTCwfyGCzmpAUP9KqYYaVVFqIv9NZuTyvp7X5BdiETeosXjSYhrr4GOe
	 tl9rvrOcTaLmWVV36hfG+LCm1k+EZ9FBSpmpaEoFNjBnaGOdMlb8VTnNxP6iCOWlb7I+F
	 d2D88iRCW9Zp9l27r5jWyEK3C32t0aZ0RWsH/AJovRALLGmBBL9pxpmnRzXBmuTFx7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XihccjtE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=adj0M2qh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4760A260E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C4760A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XihccjtE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=adj0M2qh
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KMvp2017398
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jJ1JsynB2e3MSVjtmDprF6rlf5Tt+xzmdqIVfoB7kqw=; b=XihccjtEIN4XtxKD
	vRMPl+urY7YMWjchT//9LjOj3TLDp6PLFq0YFha1dzaWMPFP9CRiyRDgtpd/gAnB
	1GLPru7S83xGrutuFDuVy8hCC+pfCWpxj7oNTkbQFxVT7ZqrbtL16PemAk/htuOl
	nNx8wKWwaren12IBtH0zD70Vwa9IotEFHctnKf2DEunE6KlM9bxGqiTj9dL+KBUv
	xiv18RWaI6hbmZ1Yvzg3x6w+htZfl31HMIo0BMb0V66EsOxoGTrP8NOwQ6l1KL5N
	1WWk489iMkHxik0aIq9dgW97tGqoukzwnRMpetLtX6s2SvGGMPmnmAGZ3bTM5s+x
	+6SUmw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97cawdt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5061398eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794387972; x=1794992772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jJ1JsynB2e3MSVjtmDprF6rlf5Tt+xzmdqIVfoB7kqw=;
        b=adj0M2qhmEUYtVevODaBhqBffFSEcvVPJzlbMmwWTRl+SbMDG7T0eaYwZTVxf5vzET
         8UfccmIoDM5BG9CwlWTCZBUGKB3iauGk+rCqAwC53DQH70pmBVNwesZn9fksj11ftM//
         kOGF3YtgI+LhgF5Y2/B+ZCIdHoHpAaPLybKAQO3OAQucGA3HRlx4lTdTOBmqmvize6sG
         /cB59DyEY9MoDXX2fYIDSju1Nr9IMmypXl6Uaw2q/kN5IfI8ugxxTrzib8jgQ0u3hOUO
         BKuJcZKIfGjacs+NlA9UiyU5Pkw/T9oSIw2BlTUMrhKUnPKA7z/TpqD+qqbxC12zVgH3
         9CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387972; x=1794992772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJ1JsynB2e3MSVjtmDprF6rlf5Tt+xzmdqIVfoB7kqw=;
        b=MMDY0YQg8dTZlwZhCk9DF4VcAcl4ahyfpr/iTZ3Ar+CwKaIg8xW9lMNZQf6cxIry1e
         w3oyxgv6772pVJg7HuOOiUT9igEfWwmZ60Zfpir8e3/jDLMXjvfAd6QPV8xM91sMmHkV
         kphbvlK3Rqks47WMaBTWFecc6dHoto9odcP9iwgnXIcDeTdonXSGlhfLEUIGXBPI4B5a
         46SFnwiu+pjNw8IgYuI0/s0MdmLZItt1fIDV0kVe2R/DpyeqoaHU0N1+Xfub7fLCElDF
         BuODJ1jMXNn6QCVAf1hjvS2JAQIMzaWwL0QqkflW2FZJoSd1g96VVY4FI9QrP0Sw5bqv
         3tsA==
X-Forwarded-Encrypted: i=1; AL+hErErPuIZfas1mARje+vqmmhK8GQVMmmZSpn2fNFjxeZcdoihgEqz/E6JxWCb2q95Y/qv0jPifQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AcS9AwrtZxzuaeo71+25NN1Wsd14KfKX8OiDefF2RpgDDaX7i
	LHVTwNgiFgMIpyI/zmLlQhx79jAcn7ndaVb6FwU3ITkTsF8E9HDoiVX7/o9m3cG6He4eR/LKLDk
	PVUWkYrNMmXx/YhXRsjLbdz0SrUa3dmMUHGUZZjY8gK1W6hvKoVIf6b9WqI0+Q015F40=
X-Gm-Gg: AYBFou1uuy5IUHNB/3EkDRUKqSqf7PfXOgJiGTAbBhxeNcD6b8d3xsMrOqeEzdV5XSK
	xDlXci6VtUBQdiPRVRETr20hVnwhdNE09zrXIjO9WJXou/w6EJM0ejlFOuXdgPi149dSN12vBBm
	RoKaguIGLeE1tDPvDm7vIC4IPBnPNXDiM/mmnTDJ8SHsU3hHyC5GKZ+i57ve5UUZczx9WvvR9c/
	CGkr2hIdnEBdlzUPPZzzB1A/Dhd+WNl4PqZWnr+uOCQowwWw801uX1Snacy4cUeYA/qvJb3eMK4
	9BBWa3hYXzQyPVxxJZJ/05NkxvU4MS4AoHWjKljkh6FSAW0ycdGNM6HfT0wNdUrg8uegNF/FAb6
	nXP3NNpWxmpl1UC+3NyOdvS/OIfPwfv3GXnFEBHOngyAgRnxTPyshy+/DuA+UB5p2vWbjHrTmMP
	ZvwTT3+w==
X-Received: by 2002:a05:7022:3c81:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1b3c03804e0mr1486662c88.47.1794387971742;
        Wed, 11 Nov 2026 01:06:11 -0800 (PST)
X-Received: by 2002:a05:7022:3c81:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1b3c03804e0mr1486634c88.47.1794387970925;
        Wed, 11 Nov 2026 01:06:10 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm16915277c88.11.2026.11.11.01.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:06:10 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:35:16 +0530
Subject: [PATCH v2 3/3] media: qcom: iris: Fix IRQ disable depth imbalance
 on watchdog interrupt
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
Message-Id: <20261111-fix-disable-irq-safely-v2-3-8e13f68c2ef9@oss.qualcomm.com>
References: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
In-Reply-To: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794387948; l=4319;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=Pn+BycdBF2lPz8nDDl76Efbp4QHBy13sSbzbrGaycsQ=;
 b=L+P6AIaTos40tTr5PAhIMgkr6l6HSfbthXp0pc4dep8UZVV4lNLPCMS2Q1qSUDYztGXT8bSj0
 sY901x5DMTbBKhC+8JpiO4BMQ8WKUvECnND6WIZVlLWMhHBLmioyFMY
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfX881m2+MBXRKr
 EoGBnwWV4s60Q52V3J6iATLwKUCrFQA2D7jyToy484tlrlJCcVp0XEP5sav6jIDTDhLxSk3O/4e
 6Nj6IX2adoj7/A+2xiBGZ899lNgfc47vl7Lo4EuphCcvjxloy6HRLuT7QrMv8ZRBELcxSc/QMar
 v+tRyci1X344fae3OpVKK16IXhkNWe8JgKgJtoR3CgpRc5RanBVMi7OwuPmrOr4g8vGhXRq2NV4
 wIUk2IHcTATsc0dvJcdnCpXyTDR8h8Tg2H6klOdYR1pHYLqrF6/15yLgGBaywf8JAQThtq9NuRw
 z6tqLYvJf0ATAgwmvxq6h75d7pK8PmM9R1AKqypFlNYL91t27MMzI0ThCAQ7Ui3cfqnRUJJaYeA
 W4WELAohV9pnDtqif9mVi8Gq3a4r8j0fNIKa2J+KtSBLdyWiTaFN3XIYeDpdZYwdKtJlcoNvi6H
 YiIj+qIiB9PXkJXLNbA==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af43005 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Np8CHIPbezt7dn0wI3IA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: FiiajygGq4u8y00IAb9ISHyXZcyhHy-X
X-Proofpoint-ORIG-GUID: FiiajygGq4u8y00IAb9ISHyXZcyhHy-X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfXxdTKwyd5n6op
 V1ySTA5cXbgmjH0hddxIXBqHRXFjszWlqa0ogIbqKCVunGe13/mWwA1LlFuhq2S+vwo5P7IMww8
 vQhSOizXQUHWTh8tL1YiV/VUeoZT3po=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110036

iris_hfi_isr() disables the IRQ for every interrupt and the threaded
handler enables it again, except for a watchdog interrupt, which is left
masked until the firmware is reset. iris_vpu_power_off() decides whether
to add its own disable from core->intr_status, but that is only updated
by the threaded handler. If a watchdog interrupt is still pending when
power-off checks it, power-off adds a disable and the handler then skips
its enable, leaving the depth one higher than the single enable_irq() in
iris_vpu_power_on() can undo. The IRQ then stays disabled after the
reset and the firmware can no longer be reached.

Make the depth independent of when intr_status is read. Power-off now
always takes one disable, paired with the enable in power-on. The
threaded handler evaluates the watchdog status once under core->lock and
sets core->wdt_irq_enable_pending when it skips its enable. Power-on
drops that extra disable together with its own.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.h       | 2 ++
 drivers/media/platform/qcom/iris/iris_hfi_common.c | 6 +++++-
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 7 +++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index 0b1b9721e6f9..1909b91deab7 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -73,6 +73,7 @@ struct qcom_ubwc_cfg_data;
  * @lock: a lock for this strucure
  * @irq_disabling: flag to indicate an IRQ-disable is in-progress
  * @irq_disable_waitqueue: waitqueue to wait for the IRQ-disable to complete
+ * @wdt_irq_enable_pending: enable_irq skipped on wdt in isr, done on power-on
  * @response_packet: a pointer to response packet from fw to driver
  * @header_id: id of packet header
  * @packet_id: id of packet
@@ -121,6 +122,7 @@ struct iris_core {
 	struct mutex				lock; /* lock for core related operations */
 	bool					irq_disabling;
 	wait_queue_head_t			irq_disable_waitqueue;
+	bool					wdt_irq_enable_pending;
 	u8					*response_packet;
 	u32					header_id;
 	u32					packet_id;
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.c b/drivers/media/platform/qcom/iris/iris_hfi_common.c
index dad906d03fdc..7a2969579697 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_common.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_common.c
@@ -100,6 +100,7 @@ irqreturn_t iris_hfi_isr(int irq, void *data)
 irqreturn_t iris_hfi_isr_handler(int irq, void *data)
 {
 	struct iris_core *core = data;
+	int wdt_irq;
 
 	if (!core)
 		return IRQ_NONE;
@@ -107,12 +108,15 @@ irqreturn_t iris_hfi_isr_handler(int irq, void *data)
 	mutex_lock(&core->lock);
 	pm_runtime_mark_last_busy(core->dev);
 	iris_vpu_clear_interrupt(core);
+	wdt_irq = iris_vpu_watchdog(core, core->intr_status);
+	if (wdt_irq)
+		core->wdt_irq_enable_pending = true;
 	mutex_unlock(&core->lock);
 
 	if (core->hfi_sys_ops)
 		core->hfi_sys_ops->sys_hfi_response_handler(core);
 
-	if (!iris_vpu_watchdog(core, core->intr_status))
+	if (!wdt_irq)
 		enable_irq(irq);
 
 	return IRQ_HANDLED;
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index fcf060a72c4c..0ce5094c0bb9 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -244,8 +244,7 @@ static void iris_vpu_disable_irq(struct iris_core *core)
 
 void iris_vpu_power_off(struct iris_core *core)
 {
-	if (!iris_vpu_watchdog(core, core->intr_status))
-		iris_vpu_disable_irq(core);
+	iris_vpu_disable_irq(core);
 
 	iris_opp_set_rate(core->dev, 0);
 	core->iris_platform_data->vpu_ops->power_off_hw(core);
@@ -531,6 +530,10 @@ int iris_vpu_power_on(struct iris_core *core)
 
 	core->iris_platform_data->vpu_ops->interrupt_init(core);
 	core->intr_status = 0;
+	if (core->wdt_irq_enable_pending) {
+		core->wdt_irq_enable_pending = false;
+		enable_irq(core->irq);
+	}
 	enable_irq(core->irq);
 
 	return 0;

-- 
2.34.1

