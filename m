Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2A45BE3
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970959; cv=none; b=Q77/us3UsLzxZP2G2j8DXfp6gj81ICZ44hiFM27yDuBMInW0H52aiYzFWLQfqz0DKvJwAmBXUheQ/Pmcwbnt2a/mtyzmLGjExd2gT1xWAZ1l9zHB5bdY2vehX8AorIVIjSoVqfKApiNW4ebMoAJpTZ1558aC6vzSQhSMou9c3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970959; c=relaxed/simple;
	bh=IwvXrg0dIPgJykvQykhfVUpXGWPvFjbsikgQFQk84Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YQpaWH1eEvdH49aw/6sMx6frAMLexTKB4JSvERmRGkG1H2Up0fiujMB+oRc2DvnJrwJFBlZMQfo3tiSvY2tcM90d+WezKa7onOEmdnjoGCyTVRoOAf75mPZL0wRxk1I44z0ZTMEGZHukwPFHabcSjeeTKldGYbJOxEMec3iahmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZuhyAYQD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JSilZhFV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZuhyAYQD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JSilZhFV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KHmc3067565
	for <stable@vger.kernel.org>; Thu, 2 Jul 2026 05:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=74eqXp627irwHNqq2srOzn
	3dVll/4DEH91ga9hCgp+Q=; b=ZuhyAYQDRHp4HP3BYOB4v7ivFC48G7onqjUS5o
	siXckEGfWRxXVP2FC+ZFJ8Jsk9DKkzXG5p1K2xaZz3BtD3d+NhQxyQIgweLEjj1p
	J5KhDTRoUGb+6g7wdbG4MjibE13n7YUqGBTfX5D020Ze//7qJALIbIzJlJACGAWj
	kRmSqlOlCVFS3pzye7JwLLd0t66hEDtI5/99pCc9G/buWvvAn42uqAuMHv58Pm1S
	e9ZzRj6RwDUjpADy6UeEn1NvzHZhkuOndLB8PI1dNn171+GXujPuViAl1McSFxQh
	eT/ccBeHXQlgSN80CLDDKhV1e5t1L6JHqnmExmHWKydkodMQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510am0x0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Jul 2026 05:42:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c80be91ea3so29763945ad.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782970956; x=1783575756; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74eqXp627irwHNqq2srOzn3dVll/4DEH91ga9hCgp+Q=;
        b=JSilZhFVlfxs2vOReAJSLJqYyL/KC0bIap+Jdza40/4LXlaQ4dHotdtFuJt9YbymDo
         N4CKiThJJFIIaNyIn4XvDU3mZs0rBErRLHSNB+Cid5vOiHi/OyNFKb4jf1TkT5XqM7pY
         CY0PJ3j7cH3aXcYXO8cl2IMP0aAc1edw+rLhNqjAoqz4OZTJXKGg/g4jqSaOfwaJvxwm
         hyj2ifzrOC0ksJP3frxW2441p9udre3gykLN/62Yme77HdcI/pKvKnK1njCVDX8ArqPI
         1ytPnHZkhBoS8HAe+hwH6vJXlBduX9Wv399WUvvViP7ZCkQIUD4I+9zI+9MOQo2Q+R3/
         QKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782970956; x=1783575756;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74eqXp627irwHNqq2srOzn3dVll/4DEH91ga9hCgp+Q=;
        b=UkD4QRQxUIzMMUvyPcnmy84Ohb42zZtM+ZmkDN7puteZfiEtE7hCtYg/yjcanYIOLQ
         CAGVqP9GLph2S6rfKsuDqXARDLJc2iUTRhdPPJUQojjgi6r92vRSRczxTZkzXNBj47M9
         6XILuVGgfPx5h/Ssh9lAaagKIEx0xX6mhVjOYlWveL6+xdwt54LmBFbNlgiEelzQqOET
         t7ZRB3cpcuLAcREBuNVmBQS+9+5ck+euXJemdAq4mFztY9QtwICbmOy+O3wbB7Gm5UmX
         ZLgy+CuUEJbZDIbPrTdeNRiSVNl2fd7fRZl5RII1FPXllliLy/pBYC0xzDFR5F8aQ/gQ
         3FMg==
X-Forwarded-Encrypted: i=1; AHgh+RrSXqGmmEIUUdLbFOm8kUT3I2ewnelqNKFb5Pginht9vvT1ungj8fC0dmN9t2dqoV27HBbaWVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxLKu+8HtAiYHN7ECytguLzh2gvhEgLQXL1PflC24pp20yy2B
	piG9HbujDnx4bVZFY8uKkSkxprTqX0nKMvHFQ62rumkeuWT0Yf+aIc6utP/r2Qvk/AXWMpC3R8u
	cJqwUrXitrfErVbQyIl7VWBiHYkFFWxCBRqDvZXyUrTqtWTncbh4sOLnb9+O+5/ZSKAA=
X-Gm-Gg: AfdE7clk0DhdSoypbOlrbLA8qtmzuT5WKSL/Qcs+Mh0nMavGtp4v1Z3gQ8PA/czBDa+
	oGt2UPJqQ6GnXeSK2zmmiyDvAVebUFzHcQrq5KpdcvoE9NKmTYshiCSNpvLazYyqFLvEdf/LKF+
	EBNq7JLVWlS4mtGsS4e4F4rjpmgKbPEAZxIgKVq7eny7cqy9MoqYEOnEHXagb9/z8IqQfC5zS8J
	79nHcmXuoqSn97nWTxZnB4Qv99F4VQD15y7HcI5O5smjz7gHsgssyHMVV1OEXqO0it2P+DTp4JR
	twORjCCfthcwCuQFCm4AUIZu21yFgwzsh7VvJTzRT/T3diLXBYk39f74FlPF0HxhJk4FQnGEfRc
	uhJHAVGISidzhsOVVy726G3lZI5W7T5jRy7U0Qzl6r39ojrk=
X-Received: by 2002:a17:902:e811:b0:2c1:d49c:8396 with SMTP id d9443c01a7336-2ca7e6736e0mr49766005ad.1.1782970955758;
        Wed, 01 Jul 2026 22:42:35 -0700 (PDT)
X-Received: by 2002:a17:902:e811:b0:2c1:d49c:8396 with SMTP id d9443c01a7336-2ca7e6736e0mr49765765ad.1.1782970955021;
        Wed, 01 Jul 2026 22:42:35 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dadc8sm7967985ad.16.2026.07.01.22.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 22:42:34 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 11:12:23 +0530
Subject: [PATCH v3] soc: qcom: geni-se: Use HW PROG_RAM_DEPTH to validate
 firmware size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-qup-se-increase-ram-cnt-v3-1-80b363373a5b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD76RWoC/4WNQQ7CIBBFr2JYSwPT0lZX3sO4oBQsxkILLdE0v
 btQF240bibzJn/eX5CXTkuPjrsFORm019ZEyPc7JDpurhLrNjICAiVhAHicB+zj1QgneVwc77E
 wE6YFy4kiOWsYQ/F7cFLpx2Y+X97s5+YmxZR0KdFpP1n33KoDTbn/LYFiiitas6IlDUhFTtb7b
 Jz5Xdi+z+JAqSzAR1cR+lsHUUdKWnN6UFCK/ItuXdcX1n/KLCYBAAA=
X-Change-ID: 20260522-qup-se-increase-ram-cnt-14530f035b55
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782970952; l=4922;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=IwvXrg0dIPgJykvQykhfVUpXGWPvFjbsikgQFQk84Ic=;
 b=z6r8woHZOqMMV8HNYN/HAmVI9GKgPkjexyBvbM9mQatnwqqStjhy6koYsmUWLSU9mBfegUVzZ
 SaxAAwGNcPhD68spypRLKqqoEGkBRp2ynNUkMXOgdhYYnHMtCdUIHYQ
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: FCww9hNIZGebJbJZ_iFEEEdjX3DJ7wKg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA1NSBTYWx0ZWRfX08iZdtD/Q7On
 x0IlsOpm78oVfJgd2x5Abe2vpffbd3+dglVOgsM9FoMWNFyH64Ft07JEwoTWrdCdddBn2GahSs1
 ewUb7BEnmuWbFOR7HL9dnR9y6F5yzjrfjD1yiBSvipq/93FTOM9zyaw+ngH/C5R6T7hemV2OF8L
 G9Fav3Ux4FfR1e/vRaLxDrLUT0WpoVMCFfw1my21lga3kDVFfitqk4gdbtlUmzFwO1jgM7bYcXA
 Kz204sqh//Fn1UkOq3FyEanyN94qkT/mXIM5rYTKNJCTLNDqezEKXL7eZMsfDklWHXpVmyHdhaP
 ve+PFOowDEiSgC5hsbkeuAqA/FiSZR0Iu+eJQtPD8oa/6Myv47KycibuMw+thl/nC9ncDLAI6iE
 SfnFmh6v172Vx8YW9fs2SNU0PBD9lPgrZo90I06OVKwVNrsB3RhFaJXyJ17f+y/+UTZCrH/xi5l
 mZ6MyVGz8/1nREibI+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA1NSBTYWx0ZWRfX7kTc6wWTpFdI
 BpbsDOHbudd+0fMGCOnDM7yDop+yXF3TgibsKhctuOJ6Z5drid1S/gA/CyuLrfBg8n46lCRZCx8
 lEcIzSiuWggX9I4xCRZxrP+3f5kK7F4=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a45fa4c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=FX7-I7kC4UuLIknBy2IA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: FCww9hNIZGebJbJZ_iFEEEdjX3DJ7wKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020055

The hardcoded MAX_GENI_CFG_RAMn_CNT limit is not accurate for all SoCs:
some targets have less CFG RAM than the constant implies, while others
like QCS615 need more entries than the old limit of 455 allowed, causing
valid firmware to be rejected at load time.

Rather than hardcoding a constant, read PROG_RAM_DEPTH from SE_HW_PARAM_2
at runtime to get the actual CFG RAM depth of the hardware instance and
use that as the upper bound for firmware size validation.

Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v3:
- Shorten dev_err() message to "Firmware size (%u) exceeds RAM size (%u)"
- Link to v2: https://patch.msgid.link/20260701-qup-se-increase-ram-cnt-v2-1-0618a19f26c3@oss.qualcomm.com

Changes in v2:
- Replace hardcoded MAX_GENI_CFG_RAMn_CNT with runtime read of
  PROG_RAM_DEPTH from SE_HW_PARAM_2 for per-SoC accuracy
- Link to v1: https://patch.msgid.link/20260522-qup-se-increase-ram-cnt-v1-1-71854d0b2ef0@oss.qualcomm.com
---
 drivers/soc/qcom/qcom-geni-se.c  | 24 +++++++++++++-----------
 include/linux/soc/qcom/geni-se.h |  4 ++++
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index cd1779b6a91a..2fa6a45904e9 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -152,8 +152,6 @@ struct se_fw_hdr {
 /*Magic numbers*/
 #define SE_MAGIC_NUM			0x57464553
 
-#define MAX_GENI_CFG_RAMn_CNT		455
-
 #define MI_PBT_NON_PAGED_SEGMENT	0x0
 #define MI_PBT_HASH_SEGMENT		0x2
 #define MI_PBT_NOTUSED_SEGMENT		0x3
@@ -990,24 +988,27 @@ EXPORT_SYMBOL_GPL(geni_icc_disable);
 
 /**
  * geni_find_protocol_fw() - Locate and validate SE firmware for a protocol.
- * @dev: Pointer to the device structure.
+ * @se: Pointer to the serial engine structure.
  * @fw: Pointer to the firmware image.
  * @protocol: Expected serial engine protocol type.
  *
  * Identifies the appropriate firmware image or configuration required for a
- * specific communication protocol instance running on a  Qualcomm GENI
- * controller.
+ * specific communication protocol instance running on a Qualcomm GENI
+ * controller. Validates the firmware size against the hardware PROG_RAM_DEPTH
+ * read from SE_HW_PARAM_2.
  *
  * Return: pointer to a valid 'struct se_fw_hdr' if found, or NULL otherwise.
  */
-static struct se_fw_hdr *geni_find_protocol_fw(struct device *dev, const struct firmware *fw,
+static struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct firmware *fw,
 					       enum geni_se_protocol_type protocol)
 {
+	struct device *dev = se->dev;
 	const struct elf32_hdr *ehdr;
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr	*phdr;
 	struct se_fw_hdr *sefw;
 	u32 fw_end, cfg_idx_end, cfg_val_end;
+	u32 prog_ram_depth;
 	u16 fw_size;
 	int i;
 
@@ -1066,10 +1067,11 @@ static struct se_fw_hdr *geni_find_protocol_fw(struct device *dev, const struct
 			sefw->fw_size_in_items = cpu_to_le16(fw_size);
 		}
 
-		if (fw_size >= MAX_GENI_CFG_RAMn_CNT) {
-			dev_err(dev,
-				"Firmware size (%u) exceeds max allowed RAMn count (%u)\n",
-				fw_size, MAX_GENI_CFG_RAMn_CNT);
+		prog_ram_depth = FIELD_GET(PROG_RAM_DEPTH_MSK,
+					   readl_relaxed(se->base + SE_HW_PARAM_2));
+		if (fw_size >= prog_ram_depth) {
+			dev_err(dev, "Firmware size (%u) exceeds RAM size (%u)\n",
+				fw_size, prog_ram_depth);
 			continue;
 		}
 
@@ -1193,7 +1195,7 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
 	int ret;
 	struct se_fw_hdr *hdr;
 
-	hdr = geni_find_protocol_fw(se->dev, fw, protocol);
+	hdr = geni_find_protocol_fw(se, fw, protocol);
 	if (!hdr)
 		return -EINVAL;
 
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 0a984e2579fe..16d68622954a 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -118,6 +118,7 @@ struct geni_se {
 #define SE_DMA_RX_FSM_RST		0xd58
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define SE_HW_PARAM_2			0xe2c
 
 /* GENI_FORCE_DEFAULT_REG fields */
 #define FORCE_DEFAULT	BIT(0)
@@ -285,6 +286,9 @@ struct geni_se {
 #define RX_FIFO_DEPTH_MSK		GENMASK(21, 16)
 #define RX_FIFO_DEPTH_SHFT		16
 
+/* SE_HW_PARAM_2 fields */
+#define PROG_RAM_DEPTH_MSK		GENMASK(10, 0)
+
 #define HW_VER_MAJOR_MASK		GENMASK(31, 28)
 #define HW_VER_MAJOR_SHFT		28
 #define HW_VER_MINOR_MASK		GENMASK(27, 16)

---
base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
change-id: 20260522-qup-se-increase-ram-cnt-14530f035b55

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

