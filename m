Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40331409E01
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294206; cv=none; b=G6XZgBa5BkPEmhmdAn5rmIg/eb+tiUCqvhuj1ojZMybWthjwwdcTv5tGtybwM78ZlJgFjxl39rgYCdGwdcrbRnttAF1x/FJpFvGS+Kf4taWXfIWCPK0w5n/O9v5CDyu1pK368QMHsYBVhf/KGUAtr5PtTY5p6qZFFfDBAluDRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294206; c=relaxed/simple;
	bh=iLOd5yAhK5P2AM+amPAmfpxXe+Bhv9OynPfLmQn11oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrCiZBG8IXPkFFA79XVRvZRg08wTq7T/hdfmz4ZLIM578MvD29Dr1z8QqXKI0y46ax09oQ/EwxlFNZzUSyOuJHYNBAtkZk1dDUB6j0qAj/L3qqiHzX2tMbArQ/mycikac7KLa7pwe2/MGnCBBcMJVMTyGi0cB3NVQEmANKZnHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMln0fvs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=duPizQX7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMln0fvs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="duPizQX7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5Tadv1042233
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fjlnSLWR0ywZS5UYemIa8tk6i7wCrwYGJGzNfwUbZLo=; b=DMln0fvsaaYAjKBJ
	aKIqN8JpY9uoAt8HeBmmh4s6oK0uPCEsg9HDwoQw+YcZU3r0jbCUP/kYjwLWjYUy
	rjmdi5zI5Q0BbPngDgWp6zQuKvFQ9bXgLZsJRk1QX85TzBtLfSgMdu8e+0ARAlH4
	fKvL9bpu+g5QyO656I2If9CRbCjZL2f6rRr2GzlKU7IxThPCOwn8qQCN0POSwaH3
	xYtQapv+GRQY54hlATql8TpYLkOIrYhru/rZaHDdfU7ZihCH0SztE7XaiVM5PN1w
	ZcegV29Cyi9uRX9UAtlRge1NGk7jVXVWwczX9ENlpgCenOM2QBiW6Kd6t6m06ipQ
	CVcQdA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fue0anv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3954def0191so1066411a91.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 23:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787294201; x=1787899001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fjlnSLWR0ywZS5UYemIa8tk6i7wCrwYGJGzNfwUbZLo=;
        b=duPizQX7HvuJXpd+bFCIda7ZkOfaOAWUU2Cx1H1KFnLQ+Yr3sclxHdAl7+JiSoVNdy
         GNifc/RxvZlOjaIrfKFKbNNEPZkn6BsxsNYquk6mPj+dYKo9cjwW4LN23PSR8bj694+m
         QtuDdLdOI9BqUmFs/cNvjsHnn5A2qu0ZAnoI+nXBiatoM5FVU+WurGxg+Jc3l/4Nuei8
         5TPsfsurnE32lMp5XKEY5XV/jsFfPj0DM3Tp/4b5BMJYzqSgcfDwAgDZM+9jghUfVAoo
         PeHdxA/UCtoKrMu4nOBhWXZeIFqRcdwI+uvUiwzECpuTdVcY69lbID2Czxi2h4DAKLgp
         RMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787294201; x=1787899001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjlnSLWR0ywZS5UYemIa8tk6i7wCrwYGJGzNfwUbZLo=;
        b=UcC83X2AD6X0rAwE8P2TYr3/ol611VHs7MdMKhdU7pkgItR2BVJz4IrnVGgcQpu7kK
         SNWKsc24+zsesMMCqhX+RTa2SbY6rRKpfKJebT8t6rDSm9jz3aoycaZ/EP7e4F2xlYS2
         MIxELRFi+vTNNm37U1GUhqvEaG7LDeGQgfFn6xuJIDYsS3T5XY9bGAWbdT3TwBSDvEjb
         rtdnMrKeUXMdL93+czu/wP/y+5uUTnHs/MMOmBy6jZ2gSYMC9BFy3Pp5s1T9Bn91eA+Y
         8lyRhAqeL6CYa00jO48k9FxPnsJmNb+AzK1mjjjNgCwGdng/IEwmfRC4TdRHLg0bKbJZ
         I8Uw==
X-Forwarded-Encrypted: i=1; AHgh+Rqqr445bYUMFkdV8HJZGluL+MscRvdK8TNkjF0iXRSTQrmvKzr9Asayub5ogsC7uENDhG6k6gI=@vger.kernel.org
X-Gm-Message-State: AFuF++kJCHlYgfqlzON4HETLvQ2oS8u1v8Qp9BAGmtKJRBtf9ko0f+Tl
	nq9V5WJs2PK2dvptMQubOFSMza3XXXrsKuTQUYst6bIXm/qqzTyMfDppEN2EXbDcRMNRWMSqYV0
	uvW2CTaedsEhbDp4gfNMT93hdOVf0BHKPkTIjSp0okJtmKt7eCBPtrwiJfxk=
X-Gm-Gg: AR+sD10Wta7Au18dAW4TMIG63iQvgooLxriAxfl4PrOAxAcMQi6hbDQ/ZaMVpRGcUCa
	jpMc6uH3Jh0koaxeou9xrDkLzkrlLyXY3OdrgPD9esjhr2lLZY1lL0BroqCoWFDOUJoLMGJT9nq
	1aMUruw5GURTGuZhkiqC1kk3S46sZgp4hgZxhKTO1Dm5fNu6ntY+7FzDCSXPCAm5uVWh4aOrbEB
	swy62QN4v389cWMMQbPUF74V/Ht10iK29JmtycFSRbRZNlLxrUAk0V0Toc5JPbkOlOIuXHQybFh
	dYOfQmXSkGelVSuujKZPEwuCbMV4FWMTeKSgwRInbOar1FS9BqWDFqxIQICDNZxhiV3dQgKf7c4
	85Mf+Yfp9qPYdQM6LIT1viJ0y1b6cklB7/2qL
X-Received: by 2002:a17:90b:1c90:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-395c351d788mr7451307a91.6.1787294201407;
        Thu, 20 Aug 2026 23:36:41 -0700 (PDT)
X-Received: by 2002:a17:90b:1c90:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-395c351d788mr7451223a91.6.1787294200881;
        Thu, 20 Aug 2026 23:36:40 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c3da9csm1787377a91.17.2026.08.20.23.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 23:36:40 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 12:06:20 +0530
Subject: [PATCH v3 4/4] soc: qcom: geni-se: Fix write to read-only firmware
 buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-fix-write-to-read-only-firmware-buffer-v3-4-43e6a3abd651@oss.qualcomm.com>
References: <20260821-fix-write-to-read-only-firmware-buffer-v3-0-43e6a3abd651@oss.qualcomm.com>
In-Reply-To: <20260821-fix-write-to-read-only-firmware-buffer-v3-0-43e6a3abd651@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787294183; l=3808;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=iLOd5yAhK5P2AM+amPAmfpxXe+Bhv9OynPfLmQn11oA=;
 b=rXFeKi5e1CFPsN0AH08chsQJ2dOpv4QwjMLEg/IdQLXylj6qU9RjFrMEUGl6eBUlfZY8VUnyg
 lhxJa0pXbVpBTS98NE9EBLLvJwb3GoRCbSNgO59JF6LictlPvYMEL3w
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA0NSBTYWx0ZWRfX2S6mwiBTinvL
 x4mt4wVYOtr68NNR8f2P5obM6ZJ4UrmJK7Tw1IDignZRQXo4nJoACO/sAY7aiHN+OeRlHOsDQ3P
 KjEBO/j1IIh7M98MK2Fwf7SICKrB8Rw=
X-Authority-Analysis: v=2.4 cv=U9+iy+ru c=1 sm=1 tr=0 ts=6a87f1fa cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jfHSOdyuYKquJek64F8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: whXF17TN9Hwr2XUQr3oeP1_HfhYeVgge
X-Proofpoint-ORIG-GUID: whXF17TN9Hwr2XUQr3oeP1_HfhYeVgge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA0NSBTYWx0ZWRfX9xcDaGuvZeAM
 EJHe1kra8o0dYUy8qEcrpQPjAcfYCU/MKpw0FXUFbShMCKekzU6hKsTkegIKgwqX1RdxRu831Bn
 Uo6NPCRHZE1ZwEmjW+kUFFkqb5CPzTMfGDXHzA2EPs5yMQxxqtz0vtY+9xjbMK8ezSKha0hPbrg
 gAIGzjDJ7IlIyrynvPMV2HOI66sxFW3Xa8awwQ8t1ZGO+fKZ2C1IX9Rd+a0gCmyETvZr1XDhUVw
 340DmeaBfFeMzRyPYrDdFl9pjL1zgijbVIzzFOvbY4hDLuzZK93QBv/yFh4Fb7mYPn9gxliCvv8
 /OOdcRaTjlEhvn47YtxvmJDnLAkCgegL0GsbjU8RCITFkelmhdoNN42QSftfzSHurDLo18pL4Qk
 YZ3ixffsE/aDWaL4A+4zmrtcwhBXf9c7qcqiA0gBY14x0MFO5GYoe4QYc7XTTGTTpy+V+G/ApIg
 DOzswJ9xVNZAfW/L0dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210045

geni_find_protocol_fw() casts fw->data to a non-const struct se_fw_hdr
pointer and writes back the rounded-up fw_size value:

        sefw->fw_size_in_items = cpu_to_le16(fw_size);

The firmware subsystem maps the firmware blob read-only. Writing through
the cast pointer causes a level-3 permission fault on AArch64 and
crashes the kernel during driver probe.

The write-back is no longer necessary: geni_find_protocol_fw() now
propagates the rounded size to the caller via fw_size_out. Remove the
write-back and make sefw (and the hdr pointer in the caller)
const-correct.

Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 11ca8223fbcd..6ac2bdc16984 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1238,17 +1238,17 @@ EXPORT_SYMBOL_GPL(geni_se_resources_init);
  * controller. Validates the firmware size against the hardware PROG_RAM_DEPTH
  * read from SE_HW_PARAM_2.
  *
- * Return: pointer to a valid 'struct se_fw_hdr' if found, or NULL otherwise.
+ * Return: pointer to a valid 'const struct se_fw_hdr' if found, or NULL otherwise.
  */
-static struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct firmware *fw,
-					       enum geni_se_protocol_type protocol,
-					       u32 *fw_size_out)
+static const struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct firmware *fw,
+						     enum geni_se_protocol_type protocol,
+						     u32 *fw_size_out)
 {
 	struct device *dev = se->dev;
 	const struct elf32_hdr *ehdr;
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr	*phdr;
-	struct se_fw_hdr *sefw;
+	const struct se_fw_hdr *sefw;
 	u32 fw_end, cfg_idx_end, cfg_val_end;
 	u32 prog_ram_depth;
 	u32 fw_size;
@@ -1290,7 +1290,7 @@ static struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct
 		if (phdr->p_filesz < sizeof(struct se_fw_hdr))
 			continue;
 
-		sefw = (struct se_fw_hdr *)(fw->data + phdr->p_offset);
+		sefw = (const struct se_fw_hdr *)(fw->data + phdr->p_offset);
 		fw_size = le16_to_cpu(sefw->fw_size_in_items);
 
 		if (le32_to_cpu(sefw->magic) != SE_MAGIC_NUM || le32_to_cpu(sefw->version) != 1)
@@ -1299,10 +1299,8 @@ static struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct
 		if (le16_to_cpu(sefw->serial_protocol) != protocol)
 			continue;
 
-		if (fw_size % 2 != 0) {
+		if (fw_size % 2 != 0)
 			fw_size++;
-			sefw->fw_size_in_items = cpu_to_le16(fw_size);
-		}
 
 		fw_end = le16_to_cpu(sefw->fw_offset) + fw_size * sizeof(u32);
 		cfg_idx_end = le16_to_cpu(sefw->cfg_idx_offset) +
@@ -1437,15 +1435,15 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
 	const u8 *cfg_idx_arr;
 	u32 i, reg_value, fw_size_in_items;
 	int ret;
-	struct se_fw_hdr *hdr;
+	const struct se_fw_hdr *hdr;
 
 	hdr = geni_find_protocol_fw(se, fw, protocol, &fw_size_in_items);
 	if (!hdr)
 		return -EINVAL;
 
-	fw_data = (const u32 *)((u8 *)hdr + le16_to_cpu(hdr->fw_offset));
+	fw_data = (const u32 *)((const u8 *)hdr + le16_to_cpu(hdr->fw_offset));
 	cfg_idx_arr = (const u8 *)hdr + le16_to_cpu(hdr->cfg_idx_offset);
-	cfg_val_arr = (const u32 *)((u8 *)hdr + le16_to_cpu(hdr->cfg_val_offset));
+	cfg_val_arr = (const u32 *)((const u8 *)hdr + le16_to_cpu(hdr->cfg_val_offset));
 
 	ret = geni_icc_set_bw(se);
 	if (ret)

-- 
2.34.1

