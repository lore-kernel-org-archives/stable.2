Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391596;
	b=Xy1On+gCXBLh0HHJWj2zV0yL0AffJKFpNS+/Yv3/TNccDCvUaLTR0DgpM+cTwS6rT65u
	 Xstrj9lWd38gDfvzr/EB62h7G8nJI2hjoDKk2R/bzWYbFb8AJGGzfVV7EsG6+Mu2yC05r
	 E33024RGj9C1ocO9YYFWj81RVZTvvrlcwslwgX6pkzDaoFNTKT7WYJDsiDAjca01vkA7c
	 escoI98BHtlPaacYlw658vp7SPEUeLH4IVUpwWK5cIKNgp4i9EXTB6JKEr24rIuMzxWcn
	 qFH4r42l8CIzq5PIDXLd8xdEf/DAHQJFIXnUBtfYz3UAGfT5Ro6PSEMFw8sFMb7mMaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Dqy6zyuLBCwAdtPhdOZplOyEgkf/hkcPoJxQXGo40zA=;
	b=IlZN4MAYkKH0RolaxcBIFGYEmErkhOcvN3IeSUdjBw9k0UNG92BOj5sCcZ3X1JCNpYtd
	 GayKpK5NIY7AiyUD3KJJ2ANTcACqdc+jiCfjE01SBDKWRCblDKfWKC+PO91yyXjFjPDQa
	 9YQqZ1zggNkMw7o9/mmU4QV8XUs4SSCZcPSIblrzVjy3/jbEDYFo544XhIqKzuGEaBszN
	 IR1gQ/utlC58rK22T8oJ6Q3BNVbWgwBpECAcNIae7+oI0y2Gmpuv817r7aJpr9CfiDMJv
	 yErSPYVFQQEfOXEHCwABB5jTGrRiIuFgLrJsH5Gamrj3OM3jDtcgd2TEGfS3fIDp5DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="KHi/hL7Q";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gfBdm2j4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B7606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A04B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KHi/hL7Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gfBdm2j4
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UIhUq8941901
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dqy6zyuLBCwAdtPhdOZplOyEgkf/hkcPoJxQXGo40zA=; b=KHi/hL7Qrdb3RLH8
	H2PwyMvxxHdNyzd/HCkNcYQ7v77xFqg/AhqMQiwZ6UFOGU5uXhLDzYDXm+c4Ngzc
	V66neTPztiJxr2tWfeEV+Tv304E/UWrBZqNWOqwrswVqHA5XdbhJTkQ7JVtpgm3f
	JPeSGwZwFo+4dilSG2e1aoJppwwChXKHTtdhaKuhkvuzHh6E9YbtOKdvgFqR4Odn
	0uC4RjY0EWT4vyzkAIgK/UHiGYx4z/fuQXRY6GTxMz+kusbH/qLlbdANv0MRXQ6c
	O1eBuz6YCYYQGx88r14WyMjAqprVl5CLUekw3qlxUVVTb7+MoNklXhSF/+/DkxZ6
	zPxh0g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0s3899k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:19:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a223755e4so4323037eec.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793391594; x=1793996394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dqy6zyuLBCwAdtPhdOZplOyEgkf/hkcPoJxQXGo40zA=;
        b=gfBdm2j4zir9TDsSLp/K8Ff10mf5dW3wVc/kciv3Vp9l6u+zpxdn0QqmQ4CoLLhUS6
         XHQ33EEw9D818pQpmCnryXPNoHbr1q1Z1zE9rUiP5QdEjRHdzbKe+VSHg9HD64u/mpoe
         v84pGSOd/eayunXZZ3is1gptUjfuWiKfqTZG5+bd5P0T6XefLxYUfkJ+j3Njwt7IZoII
         3A2PMcWQ1/0mSlyolFolRekCF5lf/xSqj/VRLrk1nxERnxZhG2K53gAq7XRqZ+U8JH0I
         UO4Per497PWNB/vx55wEQv33tUXFEdtERGhZP8/F+iAZq7z2J+0QgIfCeTF2Hu37y+9u
         M07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391594; x=1793996394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dqy6zyuLBCwAdtPhdOZplOyEgkf/hkcPoJxQXGo40zA=;
        b=yVAsxYUMOZoAR5eHWecovMu3WanHyhMWK5jdnaVJxzmPhLdAO0zRbv095lj0PFJoxK
         9h1gxB1r5RPns9K7MICcsNbJjWJl4qFX7YaffiBdTYj2xyY0KQRETJkFLuT/ott7Pxb4
         K862MSEm55ebH4e1vEyT6pVw53yKbcjkWfpwN1gflZFEwdAVpK8Oi+UNE450wveYr4KG
         3I3uCvdNpej9rFZF3cYb5xvv7nJGsdoo2FscTN62itMV4tOn44Fz0XESW7w4X9yL7D/o
         f2DBS72vo1l+BYhzlw8SHc1ZOWTEC4/gae05KDfJX4wywXE4uw9gdmxfzYKZTEpbqdzw
         Ce4A==
X-Forwarded-Encrypted: i=1; AKwUvBxn28d9Hy3s1GMiCN185aUj8tLS2NSMUgj4v8LkawoCElAEfDiCOt9FqJXAlzA+usSOtG3MJEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1ljNkqYLQjGxFufXvfVmb9hxKc7nCNLwRu85MMh7I6/wllk1y
	JWHVj/gM5rlDfm2y46ItymDXRbF+IIX7JrvSK6qXngJu9jds3DThmCqcfn1eMPF99yM6UTx3nhW
	VjZEkefjqa1/1CSUa3QdDHDY+IsHRC69N2nX+DKVRgCKJgXhOmfg6BFJiUU0=
X-Gm-Gg: AYBFou13lfV3fSOCwHeBR3F+qLcQPglFTawkKDcz44JXH5b7ddJvr0SDPUOxPGHTE+H
	63Yk9vtv0jlfNLngQ2HdbQjlEEXg9DBVM5d+a3jy9BKzNc+dxvWgaqRoZwCX/Q0RXJBV19ILSiX
	0FYqK82qTc4tuob2yxY+qkVpkJzfKUGKZH8P2fQeGoSF+6+vrNERk0ZN9IrVyJsIUxa1GxCJFKd
	R2jS6+vA023kwLajBciE105b50NKbvTflxqzvPJL6eH/shAVxjcu5dqPzyQm2rptQVwQ4MEV2Cz
	G6g9ugF/aIEixQ1aA5Lz4CZJXLjVx0RVGvxSuqJDJyRbDvoT06jOiLnfvSbo2Dou6plyDIOw7nD
	HycdeeF9/HKyC4QJ2/+DjRigtwEp7p9S3iFF9xybSbMM86Kze7UvGqRTQQMxnjxo/BCZcGE/qIQ
	m2EosXIQ==
X-Received: by 2002:a05:7300:471a:b0:36a:2382:7dab with SMTP id 5a478bee46e88-36a4232cda7mr4616484eec.6.1793391593934;
        Fri, 30 Oct 2026 13:19:53 -0700 (PDT)
X-Received: by 2002:a05:7300:471a:b0:36a:2382:7dab with SMTP id 5a478bee46e88-36a4232cda7mr4616418eec.6.1793391593086;
        Fri, 30 Oct 2026 13:19:53 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca82sm9300197eec.0.2026.10.30.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:19:52 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 01:49:09 +0530
Subject: [PATCH 1/3] media: iris: Skip redundant decoder input config
 params
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
Message-Id: <20261031-fix_dec_seek-v1-1-cfedf0c267ee@oss.qualcomm.com>
References: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
In-Reply-To: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793391582; l=2308;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=J+3ZsNvdFp2OxHwNoqL05vud6cfNJiFhDK7G5hBgPFY=;
 b=6S571aqhfJ5YJwehy77XWoQ85ejcyXyUVLjoWWjhnPXbeza6WEjZz9CDIoLDe/8OAuoiY/cvI
 MaPULRwlQiEAKzD3uELQl5xhtL2q+d00mo1f5bIyUWLAVkAhSN/iGff
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfX5NjTEG6DvfCT
 2Ea1Ih/0y3nEaC8RQktpMO4+fiV/87C0XoqvuGaOLrCWUVm8lDl2sHPqR+9BqQItFx4zd01O8O/
 0aye8BhZahrsAXQpDePK2b3tHIT/0rVgaO3FKlXTscHKeszTzGLzfv9g0nO1eIFxftO24h2rydo
 gat+qhClt9gW/HMiZaaz4FAcrYXik6ru8o3cu0Q5cvG/qMLqJPpJWaqEh8RtavP7zF2Z3VfxtvE
 gFoqnQ1wX/RgbIM3cQYunx5prbMaLCLOnvtwKv8zh8P0nCJSU3P/zqGCNcoXXxrsmxz1K5sa2jn
 0atuN5gjC0b9wo7EKSF3eGHCq7zHP9R3o+IerxXLd1zgLoQOc2uhDgN5M32Hxx31lyFMiObP54S
 s8E1J2wdEe9NxWrh4w6oe9tP0tiWN/Y5ZOxDND9erMiwC+6B7ElpkYVehcTS6ImhtkV0xIISCsm
 nXC84Kfm9oAtZ3wllRA==
X-Proofpoint-GUID: H5vPVwTE0kUfwtnj2nE275LzVug5qeT6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfX+k/R42jHesvE
 e7fey6Q+LkILtjYt+T0Aby6bb1xkKwT+JZ6/Irgrp0j09kw0WWLcMf+ONbs19eQlQHiMiV9o7TH
 N1kfXyidY/XJhbGAOadDPNwT8Ep8pgw=
X-Proofpoint-ORIG-GUID: H5vPVwTE0kUfwtnj2nE275LzVug5qeT6
X-Authority-Analysis: v=2.4 cv=XMul2ghE c=1 sm=1 tr=0 ts=6ae4fbea cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cPfzbt1C_6B9HWAkqhEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300081

The decoder input configuration parameters are sent to the firmware every
time the output plane is streamed on. This includes streamon after a seek.
Resending these parameters generates a port settings change (PSC) event
even when the input configuration has not changed. The client then
receives a redundant resolution change notification on every seek. A seek
hang was observed when redundant PSC events were generated for the same
configuration.

Skip sending decoder input configuration parameters once the input port
properties have been programmed. Reuse the existing ipsc_properties_set
state which tracks whether the input port subscription and properties have
been configured. This prevents redundant PSC events during seek operations
and avoids unnecessary resolution change notifications to the client.

Fixes: 025398e9121c ("media: iris: subscribe parameters and properties to firmware for hfi_gen2")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 388a36ff2b07b..fac61ece177e9 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -668,6 +668,7 @@ static int iris_hfi_gen2_set_super_block(struct iris_inst *inst, u32 plane)
 static int iris_hfi_gen2_session_set_config_params(struct iris_inst *inst, u32 plane)
 {
 	const struct iris_firmware_data *fdata = inst->core->iris_firmware_data;
+	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
 	u32 config_params_size = 0, i, j;
 	const u32 *config_params = NULL;
 	int ret;
@@ -693,6 +694,10 @@ static int iris_hfi_gen2_session_set_config_params(struct iris_inst *inst, u32 p
 		{HFI_PROP_AV1_SUPER_BLOCK_ENABLED,    iris_hfi_gen2_set_super_block            },
 	};
 
+	if (inst->domain == DECODER && V4L2_TYPE_IS_OUTPUT(plane) &&
+	    inst_hfi_gen2->ipsc_properties_set)
+		return 0;
+
 	if (inst->domain == DECODER) {
 		if (V4L2_TYPE_IS_OUTPUT(plane)) {
 			if (inst->codec == V4L2_PIX_FMT_H264) {

-- 
2.34.1

