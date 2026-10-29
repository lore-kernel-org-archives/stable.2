Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243537;
	b=W2UP5hK9Zk3d75caAxhyHCNMp0rFkOTyawewowU0reBVK/f6F+kiGXbI2iIeqjAlaaAv
	 H7Or+Acy3W2AxLpSDoezxjspPk5wFXX5MrreomIRFieRRBO96HNZyg7twYjsHatSq2xEs
	 twxFBkSPWEX/kkISYLUtR3oiEKc0i3N7rfYY2c/ZFZy7DCh3SsvGjh3lZduEBwOKNe0fE
	 8rWXYeKBHrIa3R3VP5TfMhk2/X5dMTTYLwQTLIFUgr0+52BnOK66Hr39B4TYdm8pfh9Wu
	 vfcJKemh8JfAGV9f6kcnKDfTMeWwBbPb+piaSwqrL1uu00ferJQBxRRXbcJed40zHvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243537;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sWFtIw7fBe+RZbcQ8738GTs4fQ/rDgZ8HgatAU488Zk=;
	b=e6ApGHTa7WMuwOUzCAePzzuWT32e/0KMbPnFUgqzAMKZSo+QGAKty2Qvtx92DSTtHB2I
	 b+NVO8hclI3KBD3l4yk5P6txVUxmsObqVuG5na7s0RzlpF9wygDEZWBIb91l+0X4LMz2m
	 8scJr5KjI4EAmbw5ob7OEpir0IbMgBOMTjfRqUpa//055YgGw+5xrsyUfIzRmcfde/asB
	 TYdqcHKwFLQ6rUjZEaMK2SBcRiKGtl6vmJuQYs3VxyBZM+HGS3Kh9KXsxZisAXOVHVKi1
	 M45K3sF9c5WnYxjVyzKb8qYP3E43Kubg2vZpwMUr0dmCHgWF64433UztVee47bCXjUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cdGaSOVy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZD6KLixm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70366606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70366606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cdGaSOVy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZD6KLixm
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T1jeRa3947995
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sWFtIw7fBe+RZbcQ8738GT
	s4fQ/rDgZ8HgatAU488Zk=; b=cdGaSOVy6dXszkHtSR+9sOCOqFzz5UcJU4jgJq
	rQrs04VP76FahjdJ5r65DHif0IWcU7rcqwcFHZK/4Yvht1INl1/06PPEgKDpXn2R
	fbGh1OjbQEGHcX/jrV7W9Pcl+z39tK4buBKDQHtso85TIMoxBG7wSHdjkNuDwhZZ
	cXPHcWsBttD/MZntdIZ1IhmpKVhNYfThtKtkrM6sPXR/kjcGjwUVILL/j4pTSF/f
	HxOL2CW8Li505LPaNYR6hGd7peNnYdUP9R3pMICw3LeFjCGa6wOYCSaxIbPkrASZ
	ZGOpX8MIENmt8gAseoTg3CPQkDhb5CBsMod6xnJyIYI2iRJg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkneusy7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:12:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a1e2485fdso3584239eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793243535; x=1793848335; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sWFtIw7fBe+RZbcQ8738GTs4fQ/rDgZ8HgatAU488Zk=;
        b=ZD6KLixmKrwhjYQ8RcKxoFmhsqMQY7pypv3IpaoKNQ1dY3e9yJTT5xVBLQBRh3GKXZ
         jhLK2uK9skSvma4Aoo7jStsvTGBg/b0kpJLS9w0OTtYhs8YsE4XpEODJI3GmmIfhlrzd
         PnZ6o3YvDj+Oz/LeAswEaYx4cfsvs4GPAVmgX671J9hH1pmEJafZ6QtbsifSZqAWcgvX
         cn83GV7NOryhiovA0GGRYNSBAUGPJvXw7lWOYCiM2KP02SSVw3vCexniUxJ0fP+0IzLR
         /G3yrU2O84MF3QTDnrhOyTxtJsfOyVigAsqGoZNsTtoPV/o/vm/+wavnlsEGAuxBX2X1
         nOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243535; x=1793848335;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sWFtIw7fBe+RZbcQ8738GTs4fQ/rDgZ8HgatAU488Zk=;
        b=if7vVvVATzpL0DdriXqI8TvtHJxdnlqyCqa64mKNwGjLvFxpwAhSyA1sT+uVfl4EcF
         T74xvVvgiVCyqlZOvojnWhlF13eIpViTQcdaOaFg4PRKdTQRF6Q0RwqQ8qXKCsl5vuh0
         LwjAHvABWJ5EY7ap1YXsWbQPh3h1i7J8Nj0HXpgGU8RWnLdBKYNZb7F+V9olmYjIZAqJ
         7GAGZxBEjy6rcYrNsQeafSI0+WOlDsOQTSQhi4ouBz48s36aOpOMHfR5K0JFXbkGGeIQ
         QnIHFoazd13xJdu3Sp8j/QOFBnfhwLl3QfmvyjKX0QvafWySE/cFuJn8oDhgAeuOqbq7
         xqWA==
X-Forwarded-Encrypted: i=1; AKwUvBxHNoabO/T0XmvA6a8qKxSNvwip9KqYLDzxLHQ8dxIgsnv83+W98dPMuJtoP9/NtthvHM5yzHo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5r9SdV3meKAgfU7ln3yJEOPLOc2HUksykGCIi8wSBLAT50diM
	c5QxIeyG3tm5hINgn031IWrTORjKKA25h9YXMKkrkSV7zhGaEJLET1d/nHYuyffh9LdadWHczjS
	cMqFWmGa+ssUbYkpadJ1f4aNwYuIr11WmqPsWriz5OssPINlGaEukDu3V++E=
X-Gm-Gg: AYBFou3bRzayX1r99dvicRZIDD84P7QfIxcX9DgLcQL7N8dDuxO4khpt6imIaJ6t5Ja
	KVM4+BwIBMjyHPPkC8jmI2u1CneYRvG6Mw1ILK4Sloej7VLItb0EpjO99qLQFcBS9tRFy6ZNYdH
	NXBXS/IemvwC4HXK8A42SFpPyMDTKQmRAjlAvdjvMHQ/ovTYNP2bj2OwBb4VmhRt04gVDSnrXcc
	4zZWuvxjbADOBETyw9pZy10Me5yUpSpwuu09qd2Z54KdJEPuyRQTQLySIic/DzfH81XRj8s0Fso
	3JDIL47ZuXir72PrS+3KgR6wdt+NiaQ23rMsxDnFIDILd8/hxhriQ7R8CnsRX7VW7/D3EkiCh3h
	CMnr3ktoIsdIGS7KVeHFBAhm/TSlZXHjy1IOlxDxt8OQZe6IIMiL5QsVmfqYACwtmiStoKL1Kzp
	AqPYOi0c3wsn9SpvCtp/YwWss6aI3Lf+10ZxoouBbgWEbfD/fP
X-Received: by 2002:a05:7301:1708:b0:369:987f:d15e with SMTP id 5a478bee46e88-36a202871c0mr5670440eec.2.1793243534884;
        Wed, 28 Oct 2026 20:12:14 -0700 (PDT)
X-Received: by 2002:a05:7301:1708:b0:369:987f:d15e with SMTP id 5a478bee46e88-36a202871c0mr5670395eec.2.1793243534156;
        Wed, 28 Oct 2026 20:12:14 -0700 (PDT)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bc445sm11151663eec.1.2026.10.28.20.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:12:13 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:12:00 +0800
Subject: [PATCH] media: iris: fix ltr count rc_type validity check in gen2
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
Message-Id: <20261029-gen2_ltr_fix-v1-1-6d5518d59b9c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH+54moC/yWMQQqDMBAAvyJ7biAmYXX9ShHZxK0NVG0TWwri3
 xvqcQZmdsiSomToqh2SfGKO61KgvlQQ7rxMouJYGIw2WGtDapLFDI8tDbf4VZrJ123wQi5ASZ5
 Jiv7vrv3JSV7vct1OCZ6zqLDOc9y6CkdN1rLQ6BAbxyiMlttGSIi9E0SDjQ4E/XH8AG9ruuGqA
 AAA
X-Change-ID: 20261029-gen2_ltr_fix-0a9b18cbe94c
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793243530; l=1372;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=og9/D7Lg6daQXDnJX52+VnaCLJ7uMVtaNZMFwQjQ3Ms=;
 b=RLUyu67R8d4oSa4LR8iwPBWBXDLdJVhpCfkcnWGCWnAiJcJoXS36bAhBnU3cdM6llZSM67TfO
 VT0FZu0rj30DsTWREGhkXqXihVNaZISOOqoEKgN4o69PqeO6ja8wgKp
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAxMSBTYWx0ZWRfXxdyViNzgTcOW
 1cbdBQ25YmFkkRTVmW8P8mfqq2s4LWuk8GKwzsh6GmTPTitL48DLetgJ4VjA3ODjGpaKHP1pGwO
 hCOBR0VO04Bi7knJZ7WWou+v9SbfrIbFSdfiWARlEAjLLicQG3cHf8k6vu1m8HtUo2h9ndWlPpK
 PS4oo7QmKvOaEX+qDb2m+kWIkxfXOx9oyCkXEajgLM5iLbtpF+Ckhatdj9YGEmdigUltfQv+TYl
 MuHMaNjvmc9NeDXWPP+1kZ+KgKD3eQPgsBeEnxd/G3rHMQTQKQ94ryGFg15OyVzfGAaq7GzLXJY
 SEnTpMHwyhd9TPpIiMTi7S7JzkI+RGp9EHNv3gSZ3EG1ITcJY8EnOjLfllwp2/o+lHHuo4C84Gz
 5BOFfexP2sG1VNQPU8ZaP9AZd7i+Gyxys7oJgK4ofnZfo2OJHfJRh+PyyBshkwR60oqX8J9IGA9
 dNkFDR7ystDcQJW/NoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAxMSBTYWx0ZWRfXyDM5dJgsDlry
 hpYMyUAQWo/gi2sBhBnxBQi9djY9ymUfkgwNSI2zrv1KEx+ubaY37PtwDj8ff95vs4Gukc77lPJ
 +32zfmRyHlApNleRNCPslrNBCF5GoD4=
X-Authority-Analysis: v=2.4 cv=LoAHWXdc c=1 sm=1 tr=0 ts=6ae2b98f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ddizOsny5C6_3mqkn2UA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: seq0w8YARa2XWXRQkToq5Sich_4wUxe2
X-Proofpoint-ORIG-GUID: seq0w8YARa2XWXRQkToq5Sich_4wUxe2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290011

The condition was inverted: CBR_VFR, CBR_CFR and RC_OFF are the valid
rc_types for LTR, so reject anything that does NOT match these types.

Fixes: 6870381285b8 ("media: qcom: iris: Add Long-Term Reference support for encoder")
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 4f2633bbb49f81f080ffbe91569d38e954ad15a1..2fd5cec16faebeabe69b836679db8cdbf89b4fac 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -1279,9 +1279,9 @@ int iris_set_ltr_count_gen2(struct iris_inst *inst, enum platform_inst_fw_cap_ty
 	if (!ltr_count)
 		return -EINVAL;
 
-	if (inst->hfi_rc_type == HFI_RC_CBR_VFR ||
-	    inst->hfi_rc_type == HFI_RC_CBR_CFR ||
-	    inst->hfi_rc_type == HFI_RC_OFF) {
+	if (inst->hfi_rc_type != HFI_RC_CBR_VFR &&
+	    inst->hfi_rc_type != HFI_RC_CBR_CFR &&
+	    inst->hfi_rc_type != HFI_RC_OFF) {
 		inst->fw_caps[LTR_COUNT].value = 0;
 		return -EINVAL;
 	}

---
base-commit: 6d0933ae9d46674a6ea63a87e9e9ab4e662670c9
change-id: 20261029-gen2_ltr_fix-0a9b18cbe94c

Best regards,
-- 
Wangao Wang <wangao.wang@oss.qualcomm.com>

