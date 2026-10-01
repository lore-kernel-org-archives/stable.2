Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861252B1E3
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867869; cv=none; b=OXDbPvlo2wvs4wX+5LmiZFTXgSxN2Kj/rXkzeOkIqJlPc+hURkv5kkOB2CYwVfkzLr/GueL2QqPCfDFdATHMdx9btm57dZNXEssM3/+o4Jc48mERtZRfiR8pY4EuLyoAForL+JSbSj552NsLp5cjNKXGFjVhmTmp8FC4+KPiISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867869; c=relaxed/simple;
	bh=8dHYACbENe9zIoAGRhAgln4ZTQ3SD6S1Y3LeTmOnvdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K92wjCHbDAKC4Ph67Z9t/PXSJ9oGleflLwMLwPTDLdp0Mb4Ib0rX8BCEQAyD17DALBAa0+EllYrAAUm8oNcx/n1pY3KtiaNYL2HpjdRg9oGu5a2ax+lVSq4xvB/dKGH2hHew4A0Av/6/X6+aw0dtXDBECNOhYVwWZTykMmrKZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3pxM8rb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GDfIbQCW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3pxM8rb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GDfIbQCW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DjHEJ2830059
	for <stable@vger.kernel.org>; Thu, 1 Oct 2026 15:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z75d7BZmsuPtkFELP6Lw+MIVZj1WwEl2DQAc6UBl0iE=; b=n3pxM8rb5oirjqrh
	sI/x0fXeRdddLrtPgYuf51dpFq007o7b1KoF3vnqSy+9Lsuc4Uigt6cef86BRR/n
	Mp77f0kgRSS8xVTHuEfNLVBBZ6uqf7IwdJrL212dOkXh7hLkvs2Nb6otGO1BRJ4b
	19Zyqs1blpXSTcEK8IAp9TQuvyRTdfDxy/MkPplWQvzvRM13pEMfPzqesrQ3M5z3
	CVd9WDhWthvKPOWxb9kn4ezcn6Pxw1DFavi31/q05E8bS+X4Ke1Gf0Kgk4/ZW6jw
	9kGWC1SvW/0theLm1nRIhfskRlmeMhsWkWLUdEEI3bNpp8M36Iq0RMnVXs4VFskD
	VJQHPw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5bnhf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 01 Oct 2026 15:17:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34344599f01so7634635eec.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790867866; x=1791472666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z75d7BZmsuPtkFELP6Lw+MIVZj1WwEl2DQAc6UBl0iE=;
        b=GDfIbQCWcWK3pSVhUWgzCMqjBvTa+oHLyp7Y6r3mu2j1KwaVQrwPDp6u6zj6hHyBJ1
         MWOoad9ubmxPlL+e4kUCANhv36wMER26fc/vwe2ffnchMFwWIbjGVIYr9GwDq3amsNmT
         4Mh4wtLbTzstom9rkGsJQ9ovbwIBnTh1Vnb8QGwtXD2Y9RtlZNlVVbBQjZZbWQx5WGVN
         9/cbsgcWDfewLLN3RFMbIF53lIZu2/lFZaj0nOSzhKufwdlI38rqvrcIm3X2STkrb2dw
         ggSfEpC8icZyTO7EsGjKPpAWQg1WdqS5wykgx8UZfgGHmh9Ps6OX8677yvj7V1EQPpAP
         XVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867866; x=1791472666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z75d7BZmsuPtkFELP6Lw+MIVZj1WwEl2DQAc6UBl0iE=;
        b=uNgWGOlPuKCsSiBwfkpk4QV3dytyAgKIpXEE6RdF5KO1QMQGqqZLOUNxtMSjYFUKLc
         RsNKpd+w2CipxjAcO/l/FOrSaOBzUmjpTGYPJqonYO0OadPnhsjYRUWryWCqS+EakaE8
         E/DF+5QavG87kfhGnAHgobjNZiVAQZaIufehlr7rCzuhUNIJpXKY4vCx8w5pRcq47pKN
         7glc6tYsy5tQoeelcabxkY8tJlzskTgolM1vQdCNZIPajh+/vbWREgWHeYsaoJGNNoAV
         a/WHaxbJEFDYIPrI9Ngvn3HSgpe6tXxSbygmStUe31kzS2Hc79b/sII0ikykjuMK1FpR
         84hA==
X-Forwarded-Encrypted: i=1; AKwUvBxYgdxRBKF6/UmzRl1hAnGQ9mf1MbXzuwRxbyT8ehHK2NsBa4rG0IXdYCmfKimojMSXaYrW+p8=@vger.kernel.org
X-Gm-Message-State: AFuF++lA+UEJuRVMG55XrbcPhn9FPsoY/z86SaL0Ci9rKWvjJ0D58wHO
	4aQHyeMvAO4h/58M485kk8sPsYiSyQ96RNOQRrNLwgWdj3wyUjfanDxEt48i0L/ZARGBEZtxopc
	mYekCPQUaBBptf0N/jnOAtd9/hD2lSZtL87E8V5KtMGw+ohXT4mhbhJsBYm4=
X-Gm-Gg: AYBFou1XnW2veF4BgfxGgJIFctQbGHIPF/eJW9NRK4ue/m2nPdJgTM28Iua2SLBZtSM
	8TsyMskcxwdzU1gc69OJd7rQhQ8cjb7UmUFyQkxEnZn2YHJh0foBAQ+rPfJ318Dh9f4JqhKjfg0
	F9o4Wgvw0mMAs5I5OmDeGTQxC1kvVH5KArlrHOQhnmQOjpvngIs4AVX2zMSfLNX0RRzkT+P0Cwh
	xl6kDBUdxkRm60XTGweYqBH69/u6B3BnU6r+vr5Ckb3r2CIxUDEcjHK1dgA7bbZybJ7kpAjtV8Q
	yCGvmyxCJ+0oHdxehvrw1FQ2PfHbf0g0chtSP1SWd53mropSF9ZOuD0v9+hcrpxpmkWXFPn0uu5
	nmCnQXHozsRQsnG6ocmzW6YBlpdfINpsJMw==
X-Received: by 2002:a05:701b:2406:b0:149:1feb:6da4 with SMTP id a92af1059eb24-14d332a2be7mr5529563c88.32.1790867865917;
        Thu, 01 Oct 2026 08:17:45 -0700 (PDT)
X-Received: by 2002:a05:701b:2406:b0:149:1feb:6da4 with SMTP id a92af1059eb24-14d332a2be7mr5529516c88.32.1790867864864;
        Thu, 01 Oct 2026 08:17:44 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f246d32d2sm115700c88.1.2026.10.01.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:17:44 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 20:47:21 +0530
Subject: [PATCH v4 1/6] media: iris: wait for vpu NoC to enter low power
 during power off
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-kaanapali-iris-v4-1-642f9ac5e699@oss.qualcomm.com>
References: <20261001-kaanapali-iris-v4-0-642f9ac5e699@oss.qualcomm.com>
In-Reply-To: <20261001-kaanapali-iris-v4-0-642f9ac5e699@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790867851; l=1647;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=8dHYACbENe9zIoAGRhAgln4ZTQ3SD6S1Y3LeTmOnvdg=;
 b=qI7uh9hIv/aQrenh7s8qnXk9d8g0oBd/jRZobYKoOWZGmFV/sfosia37/D/0XzHURMkKXWwpE
 rfB+CYi2p8KBxKajQR/gp3O0/RdVCbEDvOXzWT8kvFntSRHm8hasXNf
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: 41XIs1O-IfA4mMUIxXCmsez3agg5tnyq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MCBTYWx0ZWRfX9hGpiBmzGwy3
 X8ncp29/lIfBvLUgtgMvokGO4LPd+fKZYuQqlPRCJtu1HHVBo2Mn+AL9TEp8kDhOfwJGK/+FW2Q
 mXYS/fOyF32KvFnagDppMqdIcttgQBw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MCBTYWx0ZWRfX33zNjRnWzLW4
 z6E9luhFnRm03mybtVDpmxKY29tjrrQYClOD04VwTUQE0KIFV2nwicQBj/bUTGkDxBAOW6r2sDq
 AHZisgMtdEh7serOgCKP4SceetVseq/8o8hTd2pWCWMV2ulY/iMaDKpWGoDGMT8bIVsA7FQOToK
 Ug17XXXZlTrgjctcEKEJ9gNFsjgrX4cYnbgT9vh7glygOwrFGaF/AhLFdFF8W9KoCcWcejvbhm2
 iwy9ceopRd6WeLMnYwF2P0OjbK+8qQQTkg7GbvYeOITj0ynk60Bmv4L52Qf6Lk+S7NdhD4pANRo
 PnGl/UqzZP+xa/5T3zOAX9jfXhFQJ26y6jNMwNKyy3vUQwrjJvKvSEadnhdSs9KP7TWu9NIGQcl
 ObNoggob0RLajP60L7i5qEJeZ0gERNZ0aziVYlckYkMs/cTFLzhZeFAsA7mmSZZkL6yH+Z3jneZ
 ZLEwyt0eg+/R5Mx0OHg==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe799a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rujDjMnGqJPd5R0KWf4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 41XIs1O-IfA4mMUIxXCmsez3agg5tnyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010060

The recommended hardware sequence requires software to wait for vpu NoC
to enter in low power mode and then deassert the low power idle (LPI)
control. Add the missing LPI status poll and move the LPI control
deassertion after the hardware acks LPI mode. This avoids any pending
transactions on vpu NoC before shutting it down.

Fixes: dde659d37036 ("media: iris: Introduce vpu ops for vpu4 with necessary hooks")
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu4x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu4x.c b/drivers/media/platform/qcom/iris/iris_vpu4x.c
index 02e100a4045fced33d7a3545b632cc5f0955233f..32a161c8d534a34eee4e7778426b4947b6c17003 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu4x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu4x.c
@@ -316,6 +316,10 @@ static void iris_vpu4x_power_off_hardware(struct iris_core *core)
 	if (!handshake_done && handshake_busy)
 		dev_err(core->dev, "LPI handshake timeout\n");
 
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
+			   value, value & BIT(0), 200, 2000);
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+
 	writel(MVP_NOC_RESET_REQ_MASK, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
 	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
 				 value, value & MVP_NOC_RESET_REQ_MASK, 200, 2000);

-- 
2.34.1

