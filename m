Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947720;
	b=kYTzfyH+A4jgJhj6zqYM4c3EFjKuHF3LjiVof1L+p+YNHW9GgbZ92sZGBmPI9H8dt1ry
	 J0HkK4cFk8BEUtbb/br54irL6Y4KvOGshArTTqrrMSsVBO031pbMZ+7Wx4aIaKA4mOYrv
	 UvLtxJkFYm4M0E5rt75zXiaaaIedEPik3auycGz65XvuNnCwmBCFbb4mSiDFR5tFia4on
	 ej1l8NZ4OKKwddJGVYI4koQulLwJiUiChA8+fkmNx13JX8yztwgn/d7eovF+V3DLx5uz8
	 koddKOdaObCEZ1aMpV2REBVQSsCF2st7fDuOSgjHHNpXdp3IgLHKMAf5tDdXJuuSHxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947720;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yC4Ixl0yXMVt9ps7yzBx2x4QC7PQ27qXmobL+RWzIck=;
	b=aArSvPuM485VLTAw0U3aT7MpnwVyscaUHLj3XB+Xdw6f8FIcXDHHhVvLykNyqxpc7WmK
	 HnDRv+isIF6QnEwu/hhxxKoAJRyuMhLrpnswkmEW0++HFJmMKFxtnlTvF8Z3A1QNKU5tm
	 GLDJSz1yQBOb8Gr4bQUhyZFQ8QEj6pUhsaIJh3nG2tilxYm3WsPyx27a3b+jqnsSBJoXe
	 uPAS2aqnyPmhNiyd6qnfI7MEmaaQMT5nm1W2SKBR7VRyFIrMpMV51p2+pxnP3QaQOYi5U
	 z+lafrFdN8cx6QqL3YNKPMMd4yVelV1dHt3bScIIO9JwDsRDQMoK1B64oLquZMero9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=owac0YFS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmdILhxn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19B606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD19B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=owac0YFS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmdILhxn
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69PFis9L137598
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yC4Ixl0yXMVt9ps7yzBx2x
	4QC7PQ27qXmobL+RWzIck=; b=owac0YFS4DUXO5Y1TyTE1MxsunU49C97lX/k4N
	HIhbbMP2Clx8mwx51sSR4YtrOG4TtoI29MZgU43J/tZLp1jKz51cs0NdpGMhPhHn
	cPP1ZbX+8p6XWHjZeNo3W2CNrGrc6mRa33AtQ40t4+laQtQE4eht1fHNIqYKZOM7
	f1mNR95/H/oFUnhZdgajy+k3zSk6wcEiMdXHAz6wFPnQVKud+sfOKttuQBNm8tgI
	3lD9sQBi0guYgBgb8BWH6J9f9wIl2N1b7LY2jXRj5Ah5hBWRpq20AkgrZOwWNMhl
	4i9dIcdCKmFZIvm4ZVeOIsfpar93ooko2baqMQo+ArebZYow==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehkcr5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:01:59 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-18b5ee75447so10041496c88.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792947718; x=1793552518; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yC4Ixl0yXMVt9ps7yzBx2x4QC7PQ27qXmobL+RWzIck=;
        b=TmdILhxnW032sQxpPg06VZKZraK+WCg1PCCuxnKviSMq11Hq8T9AsX/Mf5LcoEz5jJ
         7GgJh9vSuT6aItpMTsTKMZslYypOjLGTVoUkcrK1v0ypgU0q+iWVPCiFVeqN9PA0Yaax
         Qm62fB6AvZlXzfiQ7KI+10kPdPnbjMSlSH3tPL5BLLIUDRNOSwx4pj8Ei8vaadQbbmRu
         BtTEQ9cXZg+y4mX4On6fYDJ5+j/8frUUIBNr1WYPkw7YIwCE26+mFC2GjRrUMMvfadcY
         VsMM0VRHwMXYDoOt/73ZpcQA4h5NfKe373UhW3YTkkwpVUwCgiUVaLd67o8JSuZWHvVv
         HX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792947718; x=1793552518;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yC4Ixl0yXMVt9ps7yzBx2x4QC7PQ27qXmobL+RWzIck=;
        b=IjrISWXSdLCvtJopXFAJ9L8Nbp0z54opxAFHvY4JjqOacBOQS7eWfZn0uahoFAAEYs
         csCiSPC55ZOuoppACvXN1YFoZMIBgxhJPDlBQKC78Xuh5qdw5suFIjg9eWsrwqpFjddZ
         p3/LglWn5Z61rU8bpmaSHIbzZae7CI1X31COA9Qzize84zI/u5kZY4ysNkpy4DFWeji3
         WRSRGFVceBlFI4bSYrptZ8kqCIf6Omj1QumO/X5+5uPeEfIO/4RstuLA5P8IwhJ96UZT
         +wDxMv+qYLT6nKsJgoF2LYqxosmyUpVrBPcTE4ML8Sd0t6D7khtxzEKROSaftaqrNP4I
         xj5Q==
X-Forwarded-Encrypted: i=1; AKwUvBykosC+CZZ/Z+Z61X4KHqYYIPmz3/MJUjxHWHyU+Y7yMdgQKWMaMu7JtZtyli8xKA0emgl45k0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1a7RdcJYeX/h3yiBWIzEjVBpkB8nghPaUuMcUU8v5Qd4Ll2Yj
	esNu9C5DAAY8+Nc2V9aPm0BbwcrKbStNO1m+rfoA/+RvZsHL97N77ecZEyvtz4gjGkyZsyjcCjc
	4SGlzro9JYjOh9FM6wP8CWek0dYtmtfOdREZJhXLm8lQvUnMaruJT8+GFnuQ=
X-Gm-Gg: AYBFou3I3FC2Qx8tlko8FD9JJM9id11j+qK2iKi3SxlvQNm1F02THtbU+IHhE8lRklS
	cCI0hSwd2coYbfIckYXO00cJVTOPLuJAYhiMU6D34gzKkIBBr0uGrxMbK9yDtB03PUHkiDGNTJb
	OaddP9SC/panxmFe4tqWdMpfw7fmOSYVDgN8YVxLIzxf6/LY6wuXY8ECxDDpUCSvjUc+cMcvGQb
	QFQHE5DBnjmIBzjyqRtH6Xw7HaUQw+QB/zp4kDrQgFCTaOXe+BbLTn7k9NWSBvyjNf4OfKhuxLS
	pGwsP2thk7I+k6gU47QRH4COe2Im56JBb0LxoJo/6iNJpafv5eQmz4Co3WD6tiC9/ILzVKKa/qT
	XvNsMibSIC6IwAyJU1rSfocpmbqaGCBXOTA8=
X-Received: by 2002:a05:7022:ea4a:b0:193:9aa3:4748 with SMTP id a92af1059eb24-1992a250624mr6956632c88.1.1792947718117;
        Sun, 25 Oct 2026 10:01:58 -0700 (PDT)
X-Received: by 2002:a05:7022:ea4a:b0:193:9aa3:4748 with SMTP id a92af1059eb24-1992a250624mr6956585c88.1.1792947717240;
        Sun, 25 Oct 2026 10:01:57 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5a515sm15783683c88.19.2026.10.25.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:01:56 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Sun, 25 Oct 2026 22:31:49 +0530
Subject: [PATCH] soc: qcom: geni-se: Leave resource management to protocol
 drivers
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
Message-Id: <20261025-gen-se-remove-resources-handling-v1-1-e81da6707b5f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPw13moC/yWN0QrCMBAEf6XcswdNoBH9FfFBk2080UTubBFK/
 91Un5aBZWYhgwqMjt1CillMamngdh3F26VksKTG5HsfXO8HzihsYMWzzttYnTTCuJ3TQ0rm5N0
 hjPvohxSoaV6KUT6/xOn8Z5uud8T35qV1/QKQIG0RhAAAAA==
X-Change-ID: 20261025-gen-se-remove-resources-handling-d2196f7c25d6
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947713; l=2930;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=6JW/djw6dTCF/7ZGylf7GTqpGywoSaSaOyRPyUnMUss=;
 b=R2XETQTkjObqFm78AwDWWeGYBSLyBccXIteyfAExZ86jjiIPTIeHWEgAILpyivFab6TSW3wCM
 1yeY9NmjZwKBBPQRVuwLn7VQSg9bpObGykg7vUPZ9vUWPF/xACsHGnY
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDA2NyBTYWx0ZWRfX9umKx0BMau2N
 mrqH7DLKG247XklA5SiWsMrEoAr4XFsZD5tbpLCeJJFYKgB66n0FoMzbsuE5usS2O9DB9QBdX73
 ntyiMNteSsSqz6ADu5j2U0nva3fMv4E=
X-Proofpoint-ORIG-GUID: _QYCxy90aBtqvMe-SRWbZA_Uh8koA2MU
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6ade3607 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DVgANZ3ww1WCvfZeIL8A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDA2NyBTYWx0ZWRfX+PcMNZMXy6p/
 GzLtPHYEiFAVGL1yAsM9floRGGbZEfsISmWOHWTZtlA7ettbTTjYuI3P6UlTW8ziD5X/65pUo7u
 FsUBQtjywRKoTgvt8yW7qeXHrMQToqEn6GrBFXmIbQlVchjVc5/d7CrFkrkcuXnnJ2TUIcTct7p
 p77PfTv/OCCHT+JNkPeyRkxHbcnkM5Qw7MFbLi9oIBX2DoSZbz+EkZ2O1AV16bKYzlIS3Cl8Fcx
 e15A/5Ab58Hi4cd95payx7j+8Pps89g+qqnRU5bRKY8hlTgl5+QuJKdXojjM+ZNWWNN4QCk2UN6
 WPUhmTtFDyAsqjQCQoWQjuhOmMCXo+j6vwhKjJxf5Tzzz0MW7EloA29T6kkPuC7+XT6R4k2hPgl
 GXwr2/MYi8o6Fztf54NQqU88eET2njcjQsBiNC+AGVMaeORX/ilG8NuLLXkL/2h3285idlAnhiH
 Ag9JniPl39WvDL+kgtg==
X-Proofpoint-GUID: _QYCxy90aBtqvMe-SRWbZA_Uh8koA2MU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250067

Protocol drivers power the Serial Engine (SE) up and down from their
runtime PM callbacks. Firmware loading runs with a runtime PM reference
held, so the resources and interconnect paths are already enabled.

geni_load_se_fw() redundantly enables these resources and unconditionally
disables them after programming the firmware. This drops the protocol
driver's ICC vote while the device remains active.

Leave resource management to the protocol drivers and keep the common
firmware loader limited to programming the SE.

Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 074087c592cc..ebca60c8496a 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1453,18 +1453,6 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
 	cfg_idx_arr = (const u8 *)hdr + le16_to_cpu(hdr->cfg_idx_offset);
 	cfg_val_arr = (const u32 *)((const u8 *)hdr + le16_to_cpu(hdr->cfg_val_offset));
 
-	ret = geni_icc_set_bw(se);
-	if (ret)
-		return ret;
-
-	ret = geni_icc_enable(se);
-	if (ret)
-		return ret;
-
-	ret = geni_se_resources_on(se);
-	if (ret)
-		goto out_icc_disable;
-
 	/*
 	 * Disable high-priority interrupts until all currently executing
 	 * low-priority interrupts have been fully handled.
@@ -1514,7 +1502,7 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
 
 	ret = geni_configure_xfer_mode(se, mode);
 	if (ret)
-		goto out_resources_off;
+		return ret;
 
 	geni_enable_interrupts(se);
 
@@ -1541,11 +1529,6 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
 	else
 		geni_setbits32(se->base + SE_FIFO_IF_DISABLE, FIFO_IF_DISABLE);
 
-out_resources_off:
-	geni_se_resources_off(se);
-
-out_icc_disable:
-	geni_icc_disable(se);
 	return ret;
 }
 
@@ -1559,6 +1542,10 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
  * UART protocol due to lack of GSI DMA support. Requests the firmware and loads
  * it into the SE.
  *
+ * The caller must keep the SE resources and interconnect paths enabled for the
+ * duration of this call, including holding a runtime PM reference when runtime
+ * PM manages these resources.
+ *
  * Return: 0 on success, negative error code on failure.
  */
 int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protocol)

---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261025-gen-se-remove-resources-handling-d2196f7c25d6

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

