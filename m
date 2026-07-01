Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F2391E76
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879701; cv=none; b=JpDs9Qh/Xl5vxwFBOD41aH/90lHRo16/0OjbP0EmON1xPXuA1+yj91qYas1JY+9gy0tFmfhIwr2OoVyXt++bAOeYH4pUOPNaBPPk5zXp7cpt7Gl227GtC6F9zsZBV652t/h9HIfPBJPE4bkBAuL1pvu4d9Or8IqU0bRY/RCYv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879701; c=relaxed/simple;
	bh=ZUy7KFF5N05/gVxfiJeZnuspuVmxoUm4o80HqIfijFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V1EaYYOj9SBg1hbeILm1YJ/TEhBnkokiLkrK4CMgURUzk9vpR3cfh0gzuqoWVXIyZRGwri9fgLLI0gbRUrOCLu1A7XrRCGFUFqowPwgfP6qeZocr8Zlk6iqtgMDnGy4taxRoR3kOUN/3ZlauMjxdR4ziY95vggmV6q66A4JH0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hDHPWblK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UeYtEVPG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hDHPWblK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UeYtEVPG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612tPWF3940685
	for <stable@vger.kernel.org>; Wed, 1 Jul 2026 04:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4Zb97i0OtIaJ4qy3+GR60n
	BQ+dBCqeYmIUzW59vvjaU=; b=hDHPWblKUYoKCbXEl3mQjFR83kW3oALrFL+bkQ
	DZg4t7OwpJd0uFGEBdoD9eN55Hzio5W64ICBDYGINgM0swavDa3zc7rm1vRluzDO
	+u4+MegFOw5ijhfnt2Id6UusRRWbfsRMdVrVRHGvUuXiPENn/ueEZK3+G6Cl5XlX
	sL2jbKGVMNntBMEwQvM8I9hHMi/ZzthGIOxAJOK06UEqHvy8AmbtcZLo9bxWZKec
	ZhaFv22f3SQz29VaoXMIpW9RHsjtLGWxkuqm0MZxK4Fi0QnV68UoVFjNpKJAY9dD
	A5+iLv1Lhbs3jyv/UFpDCJfR8gtDtQ4zfzQREKrixwu/xgyQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy0kmf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Jul 2026 04:21:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30efe4c0cd2so73623eec.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 21:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782879695; x=1783484495; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Zb97i0OtIaJ4qy3+GR60nBQ+dBCqeYmIUzW59vvjaU=;
        b=UeYtEVPGYYQpGNGCbTJfeerijHrbTqC+U2RvEVqQKZmJvHQTf4gPOw2eUSbmWLph3c
         fohg8rlt7b2AE9zvYCfhgUjNUCsvDzx61FRV7VbcgQFQaZ9aMJxpfmNEl/dH5ddJ1DqV
         Eh+rxNVLoIOfZay0b1D1+2qRM/LQQ02u3OUghwN2C3dTzEealqJx6tfdQvDC12U3SGy1
         fUM4OFwCQunusMd8jaxHiATAi8SnfQYjFQcTX1Ov3o9egjPPgqYtB6L4fPPwgKMVPuof
         MTWI7bUdVkb6nHBKcFb3WGOyLKuorPPRBKk1h4YjLTHsi3lm7M9ndW54GH+1UU/fyXvz
         hsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879695; x=1783484495;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zb97i0OtIaJ4qy3+GR60nBQ+dBCqeYmIUzW59vvjaU=;
        b=TybR7Ai6PeR65MY+mX3iqnfKBULzAiWkjJk8zbHW6wkiSZu5tFmBPpk81SaHYVXU7m
         jfRphDYN4HkRWCp5a9gkYuNA8gAKZhOs8JlZX57U2OgJrJAQI42PgnDFk8EXzvWz5LOY
         E5zdIwHxRFRjzW6QLt0sPt7RaSOT77rLGpRoPtdwcJFatFzQ9PoW/eP/Dk5d711imBOG
         BvQf4N8quQ4K6T5/81ThwjEYlD+9zca1/q3LmhXW8LsZNEVPJQU1eZqxSsIKIumI20iP
         ycTM5gykYkS+uruHe4Kst4tsDPd8qvQSZsXadZX8TAqb3Gu/fzXXQip62zHukuQFjmiY
         0aNg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5MTK80ZPbwIuZr1MrOnqcnMK/PRtrSSkx1ZmhrUf7ZxACOt3//R3K1JmrRoyqk+EWbXQgnpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wqXrHCDLYpPgYHtLUaW1m8oBUk6EpAXDejp+3RTtigFgGRWi
	S1Fbn52qEQCUTztw3448vCOwtzwbhtoZHp4Xu35OHOennvEAMDsLiRO7xYCIth/4ud3iEV7OA2t
	ypvgz4g+glD0G8/b27dodkr3mIpcPy400r0qW6zMgLX+tqfP0U464Pk0n9s52WHhyoqM=
X-Gm-Gg: AfdE7cmdNls6E++g4XyDNGwTyFrvQliYuH7mQAS+PmAf1Eaq6f2yoCqlWzGsXGobey1
	cm+gpmFAw7rV+mWuJBam3QPS1aKZAZ6VZVDCA4bvsPPOOyGIhXnDy3ULP4Q3qYHzm18x/CslcAf
	Ot7vbFQ1lBCKVYJ5qSKpD4z7xHVAarW7nhlWYB98Bq3mpE/IRtk+w6rtLvfhFnzE2nthzlupzTT
	Q24A0+nfT8dUkmMuSsSHWNo3/Z3ooOvbq79CAFKTDwJGaqCgt+w1LtEpbHs8Z95rqxQ4ykAEOEk
	IsU0/bc12TkwRmv8p+W8IBNlxJCQsHhtiv5KfdbK4fkoJdx7MwtQgdzwKOFAOiX0O+PSjOyl5Kt
	XjteC4xc2taHklMB1aiC/tQp0/fvcD7MwtmC0ldVJjJGMvCY=
X-Received: by 2002:a05:7300:6c9e:b0:30e:ccdc:4df6 with SMTP id 5a478bee46e88-30eff273b72mr59784eec.25.1782879695393;
        Tue, 30 Jun 2026 21:21:35 -0700 (PDT)
X-Received: by 2002:a05:7300:6c9e:b0:30e:ccdc:4df6 with SMTP id 5a478bee46e88-30eff273b72mr59745eec.25.1782879694705;
        Tue, 30 Jun 2026 21:21:34 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm20562850eec.15.2026.06.30.21.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 21:21:34 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 09:51:28 +0530
Subject: [PATCH v2] soc: qcom: geni-se: Use HW PROG_RAM_DEPTH to validate
 firmware size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-qup-se-increase-ram-cnt-v2-1-0618a19f26c3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMeVRGoC/4WNTQ6CMBCFr2Jm7ZC2UDWuvIdhUcogNdJCB4iGc
 HcLHsDNy3yT97MAU3TEcD0sEGl27IJPoI4HsK3xD0JXJwYl1ElopXCYeuT09TaSSUc0HVo/oix
 0LhqR60prSOk+UuPee/O9/DFP1ZPsuNVtjtbxGOJnn57l5vu/MkuUeJYXXdSiUtSIW2DOhsm8b
 Oi6LAmU67p+ATtghJLXAAAA
X-Change-ID: 20260522-qup-se-increase-ram-cnt-14530f035b55
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782879691; l=4656;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=ZUy7KFF5N05/gVxfiJeZnuspuVmxoUm4o80HqIfijFY=;
 b=rZ03gOXzLxls7v6W/U5pzv5KdSDyMXPnEhm2TK/tyKkMdYCIuhg8SAYoWxvA/W5j9zJJKsDsB
 qqwISOshZMtCTgU76SX1qq/BNmvBtcFHNURqtt2N9gdtphiR3UEqa6E
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: oj4Wjj5i2yllxSIpLxb2MMcvcuMXAZyt
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a4495d0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=FX7-I7kC4UuLIknBy2IA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0MSBTYWx0ZWRfX7MDJpPS+vGh0
 CEjJ7bC2ODvN7NClGf+3noMckg+PUltaPhUfzLVwpTHg9YT6tRxkNgvpvgJThKshCZvtxAZPCvK
 UtGx28Jyn6i/fdKECr3N8j5wP3ndsz3P4fuLW1GP9Ltfs1mI2z1olZyHloFe9ZKXhTdL38eMOst
 GUM/gphxq8NAbCWZAG3sAShuAqIq1ZtSglqAB9fPDVROoiErE+CMK984XVk9zfJxT5Hs7AMWHQo
 irESUZX6E7Rl6X50UC4d3TdAWqicHg6Vbue4J3tWnB5kARicJVIftdkySydwVhPL3pzUZsrYzDG
 fXyBNUnJ1ONYuKr1wXb2z11gr4YV2NP7LiddKTd5TzSVc2T7IzxI9tkklD8P7cMvUfAS3/81h49
 l0wCJP2FQXApy9MmPvqfSgxsAvPQurS5NuJIwBDbOYPnYRZKK/8xHMpTW10vlty9+jmP0oMuAlD
 m7wE8BPh9MNOLGNKIZQ==
X-Proofpoint-ORIG-GUID: oj4Wjj5i2yllxSIpLxb2MMcvcuMXAZyt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0MSBTYWx0ZWRfXw9esChVtSQiM
 r5dKTMC8GFY9RgzChU8T5gY4mid+p/KwXDsUlS0aLYqce0Mi9F+ptxiL/jc1ZYKlQGF4CxyO4CL
 W5qEclM4W5DE2aKbCcLEA6fuuSn4TbE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010041

The hardcoded MAX_GENI_CFG_RAMn_CNT limit is not accurate for all SoCs:
some targets have less CFG RAM than the constant implies, while others
like QCS615 need more entries than the old limit of 455 allowed, causing
valid firmware to be rejected at load time.

Rather than hardcoding a constant, read PROG_RAM_DEPTH from SE_HW_PARAM_2
at runtime to get the actual CFG RAM depth of the hardware instance and
use that as the upper bound for firmware size validation.

Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v2:
- Replace hardcoded MAX_GENI_CFG_RAMn_CNT with runtime read of
  PROG_RAM_DEPTH from SE_HW_PARAM_2 for per-SoC accuracy
- Link to v1: https://patch.msgid.link/20260522-qup-se-increase-ram-cnt-v1-1-71854d0b2ef0@oss.qualcomm.com
---
 drivers/soc/qcom/qcom-geni-se.c  | 23 +++++++++++++----------
 include/linux/soc/qcom/geni-se.h |  4 ++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index cd1779b6a91a..87907f559bd4 100644
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
 
@@ -1066,10 +1067,12 @@ static struct se_fw_hdr *geni_find_protocol_fw(struct device *dev, const struct
 			sefw->fw_size_in_items = cpu_to_le16(fw_size);
 		}
 
-		if (fw_size >= MAX_GENI_CFG_RAMn_CNT) {
+		prog_ram_depth = FIELD_GET(PROG_RAM_DEPTH_MSK,
+					   readl_relaxed(se->base + SE_HW_PARAM_2));
+		if (fw_size >= prog_ram_depth) {
 			dev_err(dev,
-				"Firmware size (%u) exceeds max allowed RAMn count (%u)\n",
-				fw_size, MAX_GENI_CFG_RAMn_CNT);
+				"Firmware size (%u) exceeds HW PROG_RAM_DEPTH (%u)\n",
+				fw_size, prog_ram_depth);
 			continue;
 		}
 
@@ -1193,7 +1196,7 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
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

