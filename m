Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102495;
	b=uRWD2VuU3smRMLZgGDTK/WJtogRkiqCsWLmXXExfJhaKnCPnluy894/V5qyu3n0KHo4j
	 XXxe+EQzyYl7XzVeeHwFhtsv44Y7ZjBjopTlcWjdxWKu9qIU3nqYfu0AiMKkfkC+mqB/w
	 rvcVfx9T5ma6vfCFIwOR5q4EQY5AyzAZckvEff2x503tBM2p6Yzf7K53P3GqbUD/BjJrb
	 6G/QrUZYNyVgfqw/cShPU+cMySxRimS2dpmxjpB2FBmVMqO3Tt/FF//T69QZ3X6nNnL5v
	 diw5csb2T/iqY3EmNbgE1e7bgO3HcQi4+JrhNoB++kjbP/gOXaUtSUXFHm/pagpocqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102495;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KNE237mj1MNRlMgpVoOvUADUwZrvTfIRUQM33z2ltSI=;
	b=IqyLpYg67MvCzgCYwiKlcOXXqB8nazmLSVr8R7BpQA7D/91Egq4xusKts1Wmuz1mKIZJ
	 jmIOMoKroLEFk7gok5JmOn6YEdpJ0kCCMpsRVS3+sLbEbAIWiAJXegjqebjcDBN1facMH
	 iNINL18PGwCRi39OeA3c9GAPAXS5V82nECUWc600Rad09765cSTSImmxY9gRDJhPO0KHC
	 WWCyNBkvgT7nThnHaoH73NZJyIHuRfAiGUj0SlfuCsGdmqLnZcMEOitoo09bMqc+DOSAC
	 vO0n/DMwcX3711FhSYOvy/4xo5ugaGyxVOKaKs8byCUumNthZ+zVRtMvB05ypJyvfwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a3jL96oI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="VAJtsum/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5671606A33C
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5671606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a3jL96oI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VAJtsum/
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe11o1921889
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KNE237mj1MNRlMgpVoOvUA
	DUwZrvTfIRUQM33z2ltSI=; b=a3jL96oIYi1MaDo2m07xgWy3ARXVIdcyH/IIHt
	xQX0JYNGBw0v6ChJnqI+0gMJcR3IfDzt6VlfelqZDY7meh6fcSfC2946WrDoaMlC
	foAOhZrevvo446fAl0owCfsTfQ4FhDDS/R5HYRmFeGLn/vn1O3R0pZ1WG1MSN+Gf
	Ul1NQX+0Mu14mu2VZ1mxAbzvk1hrTmkv1EjXC1qoZWMxbCBOZKFzMy1SQFN4TZM/
	S2PcIzu7k62KtqA9gKV33WzAalXxV+sIUI91vi9ds+qyLKUZ4kBL5HOMNF3/dkji
	OoCkbxWZrqadoauKWSkCcdX03LoN42RO8bnvr+zxw2/asd+A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq68r2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:01:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso3707486a91.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793102492; x=1793707292; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KNE237mj1MNRlMgpVoOvUADUwZrvTfIRUQM33z2ltSI=;
        b=VAJtsum/4WR1627U5fC/m+fcZBathrsL5yjUllNFwlvuU1mAyItiuDP2l8KauoDhfK
         6mHkeJp1EA9XwqyMCb4LtnlEjsgK1Bnq5ucIgFU6LXCn+mFgc0GaJ7hmKJJRoghsAgY/
         swJv8FMZpOM9L/EJ73+jIPdhqTP8ZELBUDRRioNvRtxlEAYBuqCltpDkEfecsfw42N4e
         hFxm+QMInzW7fUVA+xZqy6mPNJEAOstFGuuU7QroCcI2C/q0weOl6zJi4zJbex4hYux2
         pdXtx82EhTSVaqGITgVdKC1ckWjaPNuh0SQG3uQxN0v/jbB2nBQ+2uLQxM/Ug/dvbeq9
         NaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102492; x=1793707292;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KNE237mj1MNRlMgpVoOvUADUwZrvTfIRUQM33z2ltSI=;
        b=l7jqTS15NncIkHRZch/c+Wt5GkgBEeUyxGKjZY4YRkgaZ0y/bgFae4QrngCcztfuDC
         dtcNKx+RTr8YUJO8nw8FZ8wCbBQyJuMr/ORcTJzpraRUIhrxk+bEIGM7mtDcIlsLEdaO
         bmfD8gF/asx92OvdhyHFB67nDrizlak3uEVJvxgt/kJ6tuHpfZ/nLFS/AJh1OyvLPIfI
         hufWHBNgu20M06IaDXQDm02PuabNwZriYOnpwEFXXSS/XXi5boVoddlhauxqIM53N3PB
         rmYb6hYApvqN3UfNPfxgQT3DdejcMsEk4AAFcDqGYLyWlurbOSRSnHYKuD/CIStH9SmZ
         9bSg==
X-Forwarded-Encrypted: i=1; AKwUvBzNLrIW3R5oqOqTedH6Qcc5FbE5qscjmCDFf8zOq81neByMOfdQVBTL47uSFQn+Z4GUg6pSqAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRZMSVBFtsMlIdUoybsmX1AuFGOHmaK2r38V7gY9UfRkuI7Y5s
	Cd/5qIyPpuWVG/GL3PemdbxESmqxeZhZwJRyAqf/LH7RiyqPh9sg+bPbjcV5YoA62MjUgesPExw
	vu34T2yZqtCh0KWhdWcYQ6ULLT3Pu3sWlxePVe0TcJ/PYy4adjMEhT7+qCVc=
X-Gm-Gg: AYBFou0PLISZzO9O5yICbiczsGzKBUDRNNV0RCQ9OQF/njZhcVS3A9pXCoqihoRVxnA
	SaU24p6pm3D7c9ucc2yhWEJMS91YVu/akmTZ2JqSrscza01P/MBXQuzm2KgqRabsuJPKA9a9GYl
	lJikVdNHuhZYjNoy3zVX36mf8R06oiLV1MFm+TAbIOps3SInCvN2ahLY6Er/zdOcCNHWB9IvLiY
	PektV7RkhjE10Lco/VnZmQUC2OxKg8v6a3OaUU4F3FqtVVBcySqHPEuqjIqvmA3w6ynzRUx9Ugu
	ViCK+kifZH+/zIWZsnI2vm918/XR4dPIS/ku8S6q5mY3V372JMDb9IQ/Oc5UtRr07MORHOJ4njl
	y0FfRaae5Tc4UvuoYRfYljGc2J6KGohXdpNHZtOTOHUcUKD0vOCulw2dO1OG/wqRj4yhAYDzwQt
	GIvGJJISN4QA==
X-Received: by 2002:a17:90b:4cd1:b0:3a8:1943:cb7a with SMTP id 98e67ed59e1d1-3adead44808mr7390146a91.18.1793102492449;
        Tue, 27 Oct 2026 05:01:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4cd1:b0:3a8:1943:cb7a with SMTP id 98e67ed59e1d1-3adead44808mr7390113a91.18.1793102491931;
        Tue, 27 Oct 2026 05:01:31 -0700 (PDT)
Received: from hu-anupvish-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40651560sm3672037a91.13.2026.10.27.05.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:01:28 -0700 (PDT)
From: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 17:31:22 +0530
Subject: [PATCH] remoteproc: qcom_q6v5_mss: Fix proxy regulator array
 overflow
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
Message-Id: <20261027-b4-q6v5_mss_proxy_regs-v1-1-6c5557e42462@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJGS4GoC/yXMQQqDMBBA0avIrBsYQ422VyklaBx1ClU7U8Ui3
 r1Rl2/x/wpKwqRwT1YQmll56CPSSwKhK/uWDNfRYNG6FG1uqqv5uDnzb1U/yrD8vFCrxtZ5gQH
 xlgUHMR6FGl6O8eN5WqfqReG732Db/rMFwYp6AAAA
X-Change-ID: 20261027-b4-q6v5_mss_proxy_regs-2d780c0095c6
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Luca Weiss <luca@lucaweiss.eu>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793102485; l=1400;
 i=anup.vishwakarma@oss.qualcomm.com; s=20260805; h=from:subject:message-id;
 bh=TJzPJNVsxPFGtMeNzrXT5vOZP2+aBDhH2ctGaurMUUQ=;
 b=jWhUUIWporDqHDdpejnELQLUFf//pLhMvR5mqllgDSbaBgGClVK1s9ny5BdYA/5+aFfwP3LRm
 Xa0GRyOmqItDfaSCSQir1BbZzqlMbnA1+IB1FOZXkP3Db40jTkQdbTY
X-Developer-Key: i=anup.vishwakarma@oss.qualcomm.com; a=ed25519;
 pk=Y9ilCu91UQrzHOM14SG2IjnmQ1QSroH5uVeBSWEmEDM=
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0929d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=isYqYfF-chSf2xzEknkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: t7n0DiFZbh2B114CVUY2dfpBqc0eZblE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX9r17kIidAPtk
 1Dl3QJWIsZZ54aGihz+49C4c1CoLxHgBCL6W2sWMMag3LuTBo1ISDXcM+vT128RR8mi4hrtjR4V
 spRt9NVqNeSyIvExX8nanCo+f6aLJv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfXxpbrzCtFR/tD
 nrVk61vMB3WyMvW1jZGf+sC6AEoNXTmNwhN87EvHwmJlsL27q1RHY1xZHWXwd10i3VovNWtI9zw
 ychC9DG549bHV/V05BQ1B+3sg05c5EkDpLkKVbesyS4h8qsJRb6EvpIZLEAYfdDu9+Qf6dlyIv4
 TmiTqE/snNzFRl+JetlHTNz5/hAvu5k9jEnTyAQk6019C1+6rzoOx4E3pynHlz8eFPpG4f43xGI
 DaAu2gVAJKA+P0ovZ8eABZ8Jx9LwZ3AjWvivtmTLJSCZp652j29XLVrufCo+FFenjMTYsTbAG9t
 AumKIs3PEoCQIsA2hNDVy2KdaCIWNoG/6nt2QLNejtSy/jsf8A1LPIWI8GYUn0klMZUfU5QQwhO
 BYAjiFM5hnJ/GUbCUcIesGzpfqAp0qW4mtqZ0SSl1xr8fHL4JI4aAgewmzKXc2zFqPaWBfLl71r
 lTb4pLm5yeWPaChyu2w==
X-Proofpoint-ORIG-GUID: t7n0DiFZbh2B114CVUY2dfpBqc0eZblE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270047

The proxy supply tables of msm8974, msm8226 and msm8926 list two
regulators (pll and mx), but proxy_regs[] has room for one. The second
entry written by q6v5_regulator_init() lands in fallback_proxy_regs[0].

On msm8974 with a device tree that has no cx power domain, the
fallback table then overwrites that entry with cx, so mx is never
enabled and cx is enabled twice.

Make proxy_regs[] large enough for the largest proxy supply table.

Fixes: 4641840341f3 ("remoteproc: qcom_q6v5_mss: Handle platforms with one power domain")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 2f71ed2feff6..7dea3bad9f5d 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -216,7 +216,7 @@ struct q6v5 {
 	int proxy_pd_count;
 
 	struct reg_info active_regs[1];
-	struct reg_info proxy_regs[1];
+	struct reg_info proxy_regs[2];
 	struct reg_info fallback_proxy_regs[2];
 	int active_reg_count;
 	int proxy_reg_count;

---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261027-b4-q6v5_mss_proxy_regs-2d780c0095c6

Best regards,
--  
Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>

