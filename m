Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489524;
	b=bVIMplGr6P5YD8kIRfVnEHDiv0PUkNkMX5pImgQziGeBO9JBMavZL7KG+sjxujko9M9L
	 0WOI37LAJNRBTw9/kBIpR0X4jCGyKQDtjZ0++eHzYKZO/JBnSqR9ZRBZvHD1S6vVFzVdj
	 x8xaJQLvcsSatiNygHs0oZVuGvaLIx9g2unIxBuHnD4DAnZ5mkkYUzfKSrgVR7Lg3v6DS
	 7xFCNDEo/DHEKtkfduoelxCKMWN16Tn3wiwcmiGwzh7u2/EXCnUwB+x/DjdurTjxo5ss6
	 USDnoazYgmTpBAA4OBO74fD5s2fb2yv81YB6X5o60x4xLBRiwwHXQAaQwmaV5ISwmCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489524;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xDEmza0Qe9pJQ58rhzT7ekkhyxXls7BABB13DbC82WM=;
	b=NXvZ+hwvFvHhVFB2vTbWc6T2mVx6gt9lfvPdm3bi8sNIWHxKSJtTUVWPu0eeeDdPMLTD
	 atXFlD8zVgz4T1h2tfVN6SVH2lAp+sou19XSyHi1YAoqPeSNH/9716NNUuLpOUmfuVMqr
	 5xF45Rh2jzIa9gJxsxAvY0XXREmMumkIuPfcWZJFyryceDbDtIDKD956sjUwvGjzrnd5c
	 /XtgCewVSJdAD+5+PUAG98coYNMMgZihlb79waDIbyVW6/wdawSl5RKJnw+/GtiINKfBJ
	 /IEYCMNgRk5qkEjQDKh/dLG1eXq0BGGVI0xQ3UceaDsTCCZjJsNv+rZAoeWYr95gYMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LffXCecn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SWBDeRP8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820F606A88B
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9820F606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LffXCecn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SWBDeRP8
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACBbCB0441531
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDEmza0Qe9pJQ58rhzT7ekkhyxXls7BABB13DbC82WM=; b=LffXCecnLuJWqkaX
	PCbiL/5J8Ih6Nxs/UP+CM7vECT9iwbAmKiFfeFPO12z5LGnjJajgdzsk2gtFebYp
	U0rdm6tLuNp5+jMuWyvM4wQYTMiy0pdN827kml8cRdOeY2M4HaymFJvYnogx9amI
	yUDzL5DHjUFd5Qvm/b3LyIQuNrfdBAOar8dQP0FfMRRyNlRDZRQfE2t/ysee8Pu7
	qnnT0TVJhKIItAMCA2/9Hgp5/GYXCUpUs3VXq5EdDQcd6OlUjzbkC1sGOafp6B5w
	Q1bB0vvI7qeP/N9vOvQYfC41VaHS8VgET40kuTx3DRmgDPAcxD+minMxKeXVMO6s
	n3aO7g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc1k7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a3451ea93so5712033eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794489522; x=1795094322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xDEmza0Qe9pJQ58rhzT7ekkhyxXls7BABB13DbC82WM=;
        b=SWBDeRP8HGmaYKgTOP7Tl/ctYB7/Df/nWGfpcbuwDaChWRnZyRSRVXT2MUj9YFCSxd
         T9cdZcoVwVvGTWAIioje60FrWIJfcG0pob3TPf1Lcba4p/PSFnMiutLPe1Ui7ZgYo70v
         RbK9/MhofnTpQuA/ia0sd+FFvzR825xL58i38TcxDXnzNT3pvI9/pB9Gw0w0EGPwoWVW
         Eif7y0BaPcIqCe3jNnTVIA2jyiKKhmjy3HKhjdFHtc0mnWfhcxom1A13q41uAFIjGGaF
         wV/IrOMsMfrpYdu/IMEaPI7WBWSmF3uqcAL2We5wOFHnU9CpX3ybUVPTnwESH3/Xzu1s
         22zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489522; x=1795094322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDEmza0Qe9pJQ58rhzT7ekkhyxXls7BABB13DbC82WM=;
        b=HgRnllGYOiah207pTEx7Ag84fJMxLCYStLoXnaLpu9g4/NYIOdoxKaa8jKpHcS9ITx
         6NusCmycTEyliJ3SovUNF8MuTuCrfiVbdEU8EbQVQx22WiN2bNCpSc/I7iLFMRBFanY4
         Bd/HAQWxLrPOXgp1GXF4pzE8r6OGZVqRfnoMMmCrwLh7sxKf1w4yv+oAI2Fkeeuy7Oe2
         s3XAe0ZvtNkiahj2HvqCCCIA/veCFDV9j1m2PuztSdHvL8iLxP9vD+nHH1iIYDc4PRx4
         sSJmKt+T8X4vaUERkJGjP5HdamHi2FK1+EgHwYPBl7gs+HL+4sXNoWatpBSaZ7B1TKFp
         g27w==
X-Forwarded-Encrypted: i=1; AL+hErFygtJPSYyqpJv9yJxznoUI9lf+xvD1+RovhLMLCbkKhETH28fX2gjmcK6Ite5FuBBfAPtLqGc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YYKzqt08kYgDAn2ZxEAia/Km+snv5rZgIBd7HEfIPU/VkBI/C
	PKWDvoiGOYbl6ko1IgY7poYH4i01iJu+U8fk3gZi/s9D1Zmy2WuwGLb/temXcOZI4Z2wJB6ebzQ
	nCvaaaihz3TgKeYHUK6MLJQ7F/C8j0SfAoU4D3hismFKy5Z8sjWh2fAImKzY=
X-Gm-Gg: AYBFou3T53ozvzEpYWc40LE+ueJT7pzjqNF68OKzXZ1RMLN/gnrkWnnsghlGkw8rbIV
	Y/SKGivWYLUtECuaLWLvvMtxDufj6t8pilsHUUywO5v+VPvtVagSEx2/XSjFxp1AHPczWi3dq3r
	Wj911188T3ZFG7aE3SxLXWarlB7Lx7tXoHkU1lHWa8vWQ3Nc7GrrrjkfUvq9ZYD6rTPLs1U3vrj
	mABrTj6pai1mSnsxxVmg7hnVZwGpoZZf3ZclrmYTB6tBM5UWePyegkVgXNI3+bDDVN38d45umPO
	8VrpnIcHBhDix4S5gSc4dQfEQfXEKpyKvXWXQ61xKpjaIAVVX9UYOgTtk44q8ao7Oo/HFRd2ynJ
	GakDUVibDkl7UEhwY1z5q26kx8HbHUMRiTZAokyc67MhFz3796UwP2uQL9cSp7wMFshvoPTve6t
	4+CZSElv4=
X-Received: by 2002:a05:7301:2311:b0:376:19bd:2af9 with SMTP id 5a478bee46e88-376832816ebmr5975410eec.5.1794489522082;
        Thu, 12 Nov 2026 05:18:42 -0800 (PST)
X-Received: by 2002:a05:7301:2311:b0:376:19bd:2af9 with SMTP id 5a478bee46e88-376832816ebmr5975385eec.5.1794489521438;
        Thu, 12 Nov 2026 05:18:41 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm43798356eec.22.2026.11.12.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:18:41 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 18:48:17 +0530
Subject: [PATCH v2 1/2] mmc: sdhci-msm: Enable ICE before enabling crypto
 support
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
Message-Id: <20261112-qcom_ice_pm_enable-v2-1-177e454d6f22@oss.qualcomm.com>
References: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
In-Reply-To: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: vXMPAkHSSaZ4FTAqSutgpA94AvwIVfCj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX9FMLUkHtJqzv
 S0PjO4J8kez89AbRAT+E2A1IL6uCFJfZS0GK6v7s1BdqON7N3VMeGE478C7JKTOACFxkA0vih0j
 0niIIxy3f9VyZp99QI74pRFQZGrrPXo=
X-Proofpoint-GUID: vXMPAkHSSaZ4FTAqSutgpA94AvwIVfCj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX4+gwTIvCZl9M
 ip9dBoLWVQBhKcO9wQGCDEe/H4CP+4AyMpZQK3Guly9PBUOQqn957ez125z4zX4L2AITv0LeL4E
 Pz6HKSMeIJckLX+XIbiLC2scHriW1g+bzLr1/uHpbdpBn5ClRMO+qSOHKv3TUewqbQRu6m7X5Tq
 6WOD9nlLLLVfT3j5gPxLFu5YfW0tb8yI05ds94QNbGmtfTtqKz8Ek7Fa08QPK4N0RHT0HnJ1dwV
 Z2zKFiT0Z9ZIIpQg1cI249QR90qXp8AM7iSFVJi4FvZ7OMMqBCFULs1n6bjzLYuANm1BD4NYtn6
 4VqPmmDii/FvcyFq5h4dMZncdSTo0H+Sn16someZb5sZJe8NWOFMlzFIrr+jPt+/pk0BgAq+ku2
 PdkWi9BWQSzRJiV3qJG5IjrqTzhA2YNGSllJ6w584SQjgGZq5M4WJ2pl6OoGurf+m6RdXkTYtL6
 zOtvhTRstj48A4putzw==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af5bcb2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jhS48lKipzocA6WHYXAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120052

sdhci-msm currently exposes MMC crypto profile and sets MMC_CAP2_CRYPTO
before enabling ICE. This leaves a window where blk-crypto can issue
keyslot programming calls before sdhci-msm has explicitly enabled ICE.

Enable ICE during the sdhci-msm crypto early init path which ensures ICE
is ready before blk-crypto can issue key programming calls.

Remove ICE enable call from CQE path, since ICE is now enabled
during SDHCI crypto initialization only.

Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32b1bcba47d6..b3e0356a03ff 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1928,6 +1928,12 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 
 	msm_host->ice = ice;
 
+	err = qcom_ice_enable(msm_host->ice);
+	if (err) {
+		dev_err(dev, "%s: failed to enable ICE: %d\n", __func__, err);
+		return err;
+	}
+
 	/* Initialize the blk_crypto_profile */
 
 	caps.reg_val = cpu_to_le32(cqhci_readl(cq_host, CQHCI_CCAP));
@@ -1963,12 +1969,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	return 0;
 }
 
-static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
-{
-	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
-		qcom_ice_enable(msm_host->ice);
-}
-
 static int sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
 {
 	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
@@ -2141,10 +2141,6 @@ static inline int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	return 0;
 }
 
-static inline void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
-{
-}
-
 static inline int
 sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
 {
@@ -2182,12 +2178,7 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
 
 static void sdhci_msm_cqe_enable(struct mmc_host *mmc)
 {
-	struct sdhci_host *host = mmc_priv(mmc);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
-
 	sdhci_cqe_enable(mmc);
-	sdhci_msm_ice_enable(msm_host);
 }
 
 static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)

-- 
2.34.1

