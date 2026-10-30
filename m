Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391374;
	b=QKcVnnniOSWxaah9grAl8+UpZrCRNSh7j7th+NNvU5JjOh/aumjD1Sq+7diDqGIou1MV
	 sg4m+r4QofjyRx6Gz/TYph5tSwpRVYj27D+h0icWwIj6kioEqU9dsQVq0uoH0+tFFMyUw
	 gV4M4O0lpSwYMGhgX8ZYGSUxvvHeF/iLfF6DxC2+9zM0Tlh9V2Qk2qFh+rQm9CxACHYH3
	 lPPnNJDW05G2t+nT9rst8xltADWUcP/KhSHNqFYNz1Ymu8P5wcMxtSD9kJfN5gUj/kSSN
	 KYJIMhMJYCSr0TKeI/odxm5k2A6uXcWUFrMJy4dO+du54XqNLXR+VKN4PY3GMlCGkaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391374;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iIw1AGfeQ24ouNA/iY8clW6tbpIonHWmuXJGVpJDMOg=;
	b=z3qltMrnLpxJvThCJ9zyVGi1NoRJNrypIM08bVn2Vp3eeyg3o8bOz6Z1Wdl5eP6DaGNQ
	 BBJoijJZU1bGDU5jya58gTNFGDgBs7bdNPFpy1JRHzVW9G4qdfCEuBqtmvbOoh2De6AYw
	 FxEIMwF9My8k8My6vU/hR+mDoriqibm+ge7HhmLpcICxDHX2UaMXoOmqoKQLiBWfWO+75
	 XtOxZ0hFn23vsCbKJK4ncFesr/HiuMp8YTHKCwXWyKiMpOYx1hW3tLGeFki6hVZnYkp4u
	 4nXHjhMizwBc/+wNQAuCRpx/DRk5FYG+nzZvhZdc7OHMHOw/3B2Exrw75DzfDWayaPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y2By3rpc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cpWupy6B;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27325606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27325606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y2By3rpc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cpWupy6B
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UIch0v4118800
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iIw1AGfeQ24ouNA/iY8clW
	6tbpIonHWmuXJGVpJDMOg=; b=Y2By3rpc7rwdDaOKxjNQr+9JnG0lqBg6CoEt7Q
	9vDNWno8OuKYksU5HtCWDhB+B/FMgivOFsp14z+YVvg6PZ/zigbU1txciILFCjyU
	mGew3cHYgqULwSLLWfkAjeGB7UZv2NuQDXkjUJqiJTqHxLvDcK6En6/24Jb1gkYL
	ldj346GPRJAqXtC9oXo2xafsYsn5X/6P68K4QHBfpLlqh/HV82io2bM6wXbhnkRj
	BajudzLF/M9fhnVkbsqHmCwtbrUWfTyC88M9tdvTZsc86l/44MqQbq4sV2Cs1fLj
	iMVzRUzkB7/4/GFtZHn3QtypjVzUmCxXqEZ0woQgI9L/nZ1g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0pu89ge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:16:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3662e7a9299so4088985eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793391372; x=1793996172; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iIw1AGfeQ24ouNA/iY8clW6tbpIonHWmuXJGVpJDMOg=;
        b=cpWupy6BpbSYkkQGg5D6yGVwW0k60foSVeQx7wLQK6Q5vgb5Ar7Zo54wLndwkBuyj2
         ecAtxUg3FC7yYFjhG1jqmiXkWF2Ui2TajthAYNf7NeByaaGvQC2V6cTXwqGgdbBERGmQ
         CMSnaiUlGIHu/icjz6FhDZHlCsJSN2R01zmSqdDdKTAm11f2B6cAtZni+TTsNXx7e16F
         yi26wr0AB/Rvx1is6FuF9GKjP0s++G1uaBZO3+rNkZWl7y6HOvbcEuFOCeerU565d7sB
         5Wtk0Te0tuaZgj8vQklkoXCePmos9+dwQYlPk2LNbs3gz6eFUQaL64+XwrwNPvIQk+iV
         OehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391372; x=1793996172;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iIw1AGfeQ24ouNA/iY8clW6tbpIonHWmuXJGVpJDMOg=;
        b=vPxrbGM11vIGIi02w07x/s/TLJHlb010yGIfZwTbG6oMXmv4wo9FYBHibwG9C0lZrG
         cboBUh9rt0tcYFaOImk/1QMoMRw15kyHC7bfDr43tCVi9d1PoCl48f+V7CVHvEhi3twV
         JSIU61+hHzQTcLz7nJOu/uHO0t6Or3NKYI3cFuscdj/PT2qmt4lF0cAXos5A4xEuGpmF
         G+FaLibPYnUd5biaTN8WvcRFAJi72xSDXdgJeTHHmApdV6tsoSSwVrhOKQxwskQEUF8f
         aeM1whtdldySOtp5E43sAsyNWDREh9XI5fGcD5PUnVUvBNg463mM6bRvSimg/ph2Z9D5
         VO/Q==
X-Forwarded-Encrypted: i=1; AKwUvByBQEcbEJ7vTbe25GjbTvObERco9b9ZAWuZMPSx7Tb1lyFSEPAdSsTK+PrHq+T79wT3An2cEeA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiCdK1Mu08cEvLBdTmFg2Yyh+NutBta8u8+QY50yCfoG9eMiB3
	jxnuwIN93suw490eCRFIsbE2tBNDU/zDpycU/bGTqvACxbyKTMplNZhp1rQ0uBbJtpmcXlu34yS
	3d+R28uG6WlR1eFR9Q7wmZnF8NoiNxnyGqigi7jlm0Wu2Hj7Q5MFyY/ZzWJM=
X-Gm-Gg: AYBFou1IugtxlW1t+7VocNxMcTjjhEUdcOf6XRC1OWHKRyWOfi/m6B3fMNlo+Tt9HpJ
	HWD6kSxmXwUTdZY1B5AkdO/1hEPDh2tOrkzeR0+vb8ssHnlqhrcmDsGIAS5/ywDtuEmr/15i/NK
	JM7WPP/PvSyyUcKHGWA/8o3gUzw+vd0ydxLnZN6OwlmJMfbIjkpOFA8xC07CLo5rrgzKTZoLhtW
	9eDtTbjbwYjF3j1Qbj+Duorcqlx3YGS9Lg4psGNVcuKyj6hIspNYM3xD+Ro4TSjS0rxZ5Lhd0jV
	gDDNQ/W5uX/NzvOOJgAPfnZDdVos7RvrR6XQ2vSQl3cH6WVyTevC+tyTDaX4Eo/A+bS8jIj/ucJ
	pFdxBdtd8WrH3Z+nIcevX002QcVZUpNK4V5hLKD6XjEbrg0YD7eio6WHsTmUtNDzLN7nc0CqZan
	h6Llgenw==
X-Received: by 2002:a05:693c:65d0:b0:369:f7d2:d7a0 with SMTP id 5a478bee46e88-36a423c5d12mr4990139eec.25.1793391371679;
        Fri, 30 Oct 2026 13:16:11 -0700 (PDT)
X-Received: by 2002:a05:693c:65d0:b0:369:f7d2:d7a0 with SMTP id 5a478bee46e88-36a423c5d12mr4990110eec.25.1793391370995;
        Fri, 30 Oct 2026 13:16:10 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428ecb61sm8357156eec.10.2026.10.30.13.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:16:10 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 01:45:48 +0530
Subject: [PATCH] Revert "media: iris: reject open() when the session limit
 is reached"
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
Message-Id: <20261031-fix_v4l2_compliance_unlimited_opens-v1-1-f20cc9231ee3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPP65GoC/yXNQQqDMBCF4avIrBsw0VroVUoJOhntlJiEjIog3
 r1pu/wW738HCGUmgXt1QKaNhWMo0JcK8NWHiRS7YjC16XTdaDXybrfWG4txTp77gGTX4HnmhZy
 NiYKo8Tq0pkFtbtpBKaVMZfZ7eTz/lnV4Ey7fNJznB0JYd5SHAAAA
X-Change-ID: 20261031-fix_v4l2_compliance_unlimited_opens-f5b423c1271d
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793391366; l=2893;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=TM5MeP+ywe4I5eSUjfCJFFS7wSDSIT7ACdjm5UAfaTA=;
 b=Om5CGeYYU8mgBZLHAQ+aNqYEeQGuT72prtMVsvsmo+R2E4pldgyAXAC8BJwSjgsKtDHmhnypL
 Rd2O/NRynxCBu8xRaA9JC3f2PGzS3xwQnmdt7W1Z+RBzSz+Au0/AI+g
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: cYMGSQj2fz8MrYOiaWrUjtUa_qCtJUWd
X-Proofpoint-GUID: cYMGSQj2fz8MrYOiaWrUjtUa_qCtJUWd
X-Authority-Analysis: v=2.4 cv=O92sLx9W c=1 sm=1 tr=0 ts=6ae4fb0d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7GKYziPKAAAA:20 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XbppLPhIH7o2zzq4e_wA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MCBTYWx0ZWRfX6pGuSxQTXOws
 tm+F3JtOtgvIRO8yL3UmYv69RIWRjpBLOuKu9FEtO6g6tUW7fOJtuS7d56baXi5aFsKnWKmaW9E
 SkwHYyFJrtTxMtuMSLhGk+9y+xSNpRGB6enM8obe/mT2btCpSmaysNWYV1HC8tzCpw4GB1J/BPY
 cpDnIZ/FczPnQDzgKSP8YpOniYPdf46k9gtdt33kuL3lALgeLF5VRCuSaEYqSBT9f6K/XOaEZiz
 9y9YswHYwXHfSh/+h4fz82WLM1YEqYt8jNxr57YWwH9GJEOczJCOmzMuCRpiHI49N4CTZGaqqDM
 ngjdQvyniTgx24ew1LEAgd7tk6QL3TSYBBKB/q8zdVD7r530AaUfQ7yTOf5/lhxZHRB4poA6oK6
 kcSuUhvycrme9qmxsbOlyGPWoqvPkCHwly8HBBaX3yIy2oKyoyZoGeeZK0hRRtsbWldgtF1CoVv
 fT+sT+70X6/46nlGG7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MCBTYWx0ZWRfX4ibf37NY0+Ci
 I5SWFaT6u9yElnzL/N0U58ULR6elIF+HpDR7NjtZ4bxQu0Scvxl3YcF0pUnHNNtBHgFRog8Yh7P
 YeDW5LSkW2oVzJLqd4ndqEbrn92H2T4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300080

This reverts commit 397ebadcbc21 ("media: iris: reject open() when the
session limit is reached").

V4L2 does not allow drivers to impose artificial limits on open().
Resource limits must be enforced where the resource is actually
consumed. v4l2-compliance verifies this through testUnlimitedOpens()
and now fails with:

  fail: v4l2-compliance.cpp(773): !ok
        test for unlimited opens: FAIL

Link: https://github.com/gjasny/v4l-utils/blob/master/utils/v4l2-compliance/v4l2-compliance.cpp#L747

The session limit is already enforced at the right place. An instance
that did not fit within max_session_count is not added to
core->instances, and iris_check_session_supported() rejects it with an
error from iris_vb2_queue_setup() and from iris_vb2_start_streaming(),
which is when a firmware session is really needed. Failing open() adds
nothing over that and breaks the compliance requirement.

Fixes: 397ebadcbc21 ("media: iris: reject open() when the session limit is reached")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vidc.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index 05aab6e3005d..a27db6cd969a 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -56,23 +56,21 @@ void iris_inst_put(struct iris_inst *inst)
 	kref_put(&inst->kref, iris_inst_release);
 }
 
-static int iris_add_session(struct iris_inst *inst)
+static void iris_add_session(struct iris_inst *inst)
 {
 	struct iris_core *core = inst->core;
 	struct iris_inst *iter;
 	u32 count = 0;
 
-	guard(mutex)(&core->lock);
+	mutex_lock(&core->lock);
 
 	list_for_each_entry(iter, &core->instances, list)
 		count++;
 
-	if (count >= core->iris_platform_data->max_session_count)
-		return -EBUSY;
-
-	list_add_tail(&inst->list, &core->instances);
+	if (count < core->iris_platform_data->max_session_count)
+		list_add_tail(&inst->list, &core->instances);
 
-	return 0;
+	mutex_unlock(&core->lock);
 }
 
 static void iris_remove_session(struct iris_inst *inst)
@@ -223,17 +221,12 @@ int iris_open(struct file *filp)
 	if (ret)
 		goto fail_m2m_ctx_release;
 
-	ret = iris_add_session(inst);
-	if (ret)
-		goto fail_inst_deinit;
+	iris_add_session(inst);
 
 	inst->fh.m2m_ctx = inst->m2m_ctx;
 
 	return 0;
 
-fail_inst_deinit:
-	kfree(inst->fmt_src);
-	kfree(inst->fmt_dst);
 fail_m2m_ctx_release:
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 fail_m2m_release:

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261031-fix_v4l2_compliance_unlimited_opens-f5b423c1271d

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

