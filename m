Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F94432EC
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134458; cv=none; b=BYdbzrd0cR/AWFVyO7dgGK1hayd0MjCiKMo43Bg1FipolZElaH+96DrJxjVYe55F7Y0iyneaVZW8aorG6F3g9mgVlVhumIRh6GNdow0+rNMUbIEWApbIZvKrV0ENWyvK7/umr9PpsHgGxVOU5qTqK/6F84Rd8w7obwU7BBXHWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134458; c=relaxed/simple;
	bh=XJWN1BvoT5IhpRMTZND2LW4/NsBs4iifV6qBjI2zMfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YelXO1KPWSAhQ/ClJzs0c6HdtSWGDPAsL/LUOP2ALK8IpzVItdLhSo14qRrX1Aqyb5kpQBaFMwl6lTQd9I67xRSF3NTob6N7SN6o2hjJ1Hu/X9BXkMvUHqIIESl6yksJB3lObVyc/2B/jDz57gcDfcpOFSpnr/7xALr9cON3sEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dpTFFS6r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X4AknG3l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dpTFFS6r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X4AknG3l"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JA7nAB2947166
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 10:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WyXlrGc8QuE8xEeFFlYq5l
	G8PL4dcVIjWDCzOztGOEU=; b=dpTFFS6rxOWCqpMi5h74Av6jdMAHZEpzurl/el
	bPOqx/YAGdNIUYCF1DO+o6A7KJpw5tH+2QPc3oP+EZo+rGhCn2DSwbxrm7XpHOcS
	Tu3WQysGlsZcuyzF2AnJX1ZRw2+//KRNXVYrPB3zfxRMM8dBAoDOgJpTpoOwepTm
	KPmnGgL+YS6IZRDeFN+nbS48dhgddpG614ClOMianwKgzJ5JCKLlOUdAsXeUW8Ie
	skpFGe51OVQokxEybkwD/B5J8okt1wdvA7ZlyYzz+HCuInE+6zgUktocLITLycQ5
	cauy0A7p6BvDzPczP+w52w7r7cfRKrcVhgySZoOHj6KLkleA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkamm8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 10:14:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e6d253330so1014442a91.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787134455; x=1787739255; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WyXlrGc8QuE8xEeFFlYq5lG8PL4dcVIjWDCzOztGOEU=;
        b=X4AknG3lqXjUesMaACgMkXZTuw9ZFFztV92h+a3e6HjQR5ip8p1HY2VqRTzMTKOoVu
         wNFOcVd83c+9TkWgbGyTq+EXvJM1pAQq5gDeitPzTlnrqFyVQCGgcLdACDJBe9MxEiQc
         krTdKwBzCJoo9P5dK0Y6CshzAj+EUY73fzdbP3ISr6rvZmq2xC/ll+zoTagfLLNHtEZq
         IrEqUnwI348MuTWKsU/rq/Rvp2Pc/Axwo6JKDO7mreCXH4zdH5tL8qmfu81LpsiDB0i2
         26aEew0unEOVy/X+pSEnjKqtza5F8sufKQvXs9bAGGKP8j7t7DdHx8VIB8vd3gqTlyYL
         TMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134455; x=1787739255;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WyXlrGc8QuE8xEeFFlYq5lG8PL4dcVIjWDCzOztGOEU=;
        b=Fufwy76vNBz8NBGIrmAZ8+GCzwV+/CGHGDk9Zg+eEExMsUJ/aHbYgzdiiIJBizgRSx
         qdZPv5GEwS8YI65SFMKQ3FRbJqyy8aYfYFlMDlhvDLT/TsKUcXmo6LMnEPGSIzSHKlen
         T75W+n+8Cr+2CF7UMxpzFJDOO79/tK+9cQg3cjRtMELMFdenKXZK5lh+HQ58YRvitDMC
         aEQ1CCkrKqeewi6Hy9dRC0lwxS4LfYRlCAWF1m8W00lvLz8Xnf1dJdRmfqLq1h4mFq6g
         G2dPem4r60Ah+KmI4P2GYRYK14YKnGxR1NIL/DIjvK9aeJpWVmiNu2hFbHTKuGCt5uRt
         UHCA==
X-Forwarded-Encrypted: i=1; AHgh+RrQywl7kJ2MjmPF1yHIWlL+STN8RDQkjByHGu88zIVbmFX9v/qVEW8XldIsB5qc+AyV2wl9aq0=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ1aTwoH4UmNt4V4dqseXiXVYGbuFr0STxmNJZCobmLtJCbUzQ
	iucUo6Ltj38qFezPG/4Drpzh3rlxp9gi2244+7XNncTOqbcA/lvLkHvTmmq6TV0PlWx2RzNCZMA
	DHAP08zu5EDbsgLF9HxYxAhH8Fl2+3P2FmMCx/6ewVCVplk4Hn9O5NrajLfV4gR1cDQM=
X-Gm-Gg: AR+sD13nnyn23J3HprUUTB8dMo6MLRBrHMxSjhVvF3KmkQYTW22Mla0tJy9dxAufW68
	ppBI25E0vZHr2r6jyrhmpLG25mAoMdguVo7+Njx1Dp/CbtszyEx3R3Ou7mVj4C6sRZDxE73m2cF
	NVlXX8bxiZK5SHvapNhCSwhKjujBLS/oIdJFhrmfsE8L3wE0cLw1jesRa8RIStvliNA2Dg3NBsC
	sbhXSwlS/7vi+0XlaeHmQ9AdGfKw6d2q5x2XascVgaZLuI3kP8EvS6cLzCuIH5O5a49BIP5luJN
	BS1lXlQ26MHKgfR65+oqEfonf22StZiPWxSuV43s2AqfSkYYVb+wxmrJ1ltbHR4yZ6JwwA5J744
	7sc4HOzZArQEjMLseFkwx22oYDwg0ICC/dv0T
X-Received: by 2002:a17:90b:5550:b0:38e:4f31:8412 with SMTP id 98e67ed59e1d1-3957f993466mr5104988a91.11.1787134454847;
        Wed, 19 Aug 2026 03:14:14 -0700 (PDT)
X-Received: by 2002:a17:90b:5550:b0:38e:4f31:8412 with SMTP id 98e67ed59e1d1-3957f993466mr5104911a91.11.1787134454207;
        Wed, 19 Aug 2026 03:14:14 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10d475sm6332438eec.18.2026.08.19.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:14:13 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 15:44:09 +0530
Subject: [PATCH] soc: qcom: geni-se: Fix write to read-only firmware buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-fix-write-to-read-only-firmware-buffer-v1-1-be86532fe122@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPCBhWoC/yWNQQ7CMAwEv1L5jKWkQdDyFcQhTR0wggQ5KQVV/
 TsGjjPSzi5QSJgKHJoFhJ5cOCcFu2kgXHw6E/KoDK1pd6azPUZ+4SxcCWtGIT9iTre3arnPXgi
 HKUYSdH3w+85tyVkDGnsI6fJ3dDz9uUzDlUL91mFdP/4iOA6KAAAA
X-Change-ID: 20260819-fix-write-to-read-only-firmware-buffer-39ca7834e310
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787134451; l=6151;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=XJWN1BvoT5IhpRMTZND2LW4/NsBs4iifV6qBjI2zMfw=;
 b=/ZbMWmWy3RTSDpidjEkNI4IOwDaaKuLyRajUDax4ILIM5CORCFh2uZmLxW/A5HIHjpyFnibye
 LW1029UrxkVDMWLkws59MqV5T0UXgNdPyNFRwFGy83FNJntQ32+n0BL
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=PoGjqQM3 c=1 sm=1 tr=0 ts=6a8581f7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vYMVkeVgrru7TWDvU6YA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3OCBTYWx0ZWRfXzwzAVMh4PRps
 WeGFKVOlBTv8yH9RbSsvyugakhQ5TuKP/2uXKzVQ+Bqq4NwRMGOt5gAtFEmByKH8HHlNij4URtL
 PLbsXWY0YJxAmGZIVT200mZgZpCPI2dbwxN6h2W7DTzrYaWJzv7ocPKjfVxhbuc6sMnX9PqFQbW
 hjDyyy24IANKCWagJBSNPifTTXQasnaZDR5EB+2m7pTmVUH6uidYWn1hwHSbfSYdUhMsA/vMz8u
 qNLY/6hbAajvmBCsiCG4kqC2achwtZnRkeiIhXzBl/7ZzikIQJhCFT88CpJhlrjfgOaHhNaXOdc
 7WeN0zu0E+++GEuDFeJl4F1Z3KISfXGZQ/DyNVQ9dWNJKp3AaW4SEzgRnYv3VMYjCF8gJj+4Xmf
 oOXdbBXj764WrNkKW5+nztfQNzafdySnA10Hd4MxLiY1Tny2rPx40gUWzi1I8wcKSYvbeEmeA3R
 fHKiErsIWrp089cnBmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3OCBTYWx0ZWRfX8NrtbFLDmQ+8
 CX6WC/u/E88yq4lHpTjVIypYc6sJyx/hPtvaxvVNRwTeoMYHODNrkrR2awG9FSxNtVbiO5BpN6G
 HVxeKv+tD3cP5ESgQfeDzE7S8UV4LTw=
X-Proofpoint-GUID: KTUndX_bD2oQSJsFaqf8rG6eOHN1QWT4
X-Proofpoint-ORIG-GUID: KTUndX_bD2oQSJsFaqf8rG6eOHN1QWT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190078

geni_find_protocol_fw() casts fw->data to a non-const struct se_fw_hdr
pointer and writes back a rounded-up fw_size value:

        sefw->fw_size_in_items = cpu_to_le16(fw_size);

The firmware subsystem maps the firmware blob read-only. Writing through
the cast pointer causes a level-3 permission fault on AArch64 and
crashes the kernel during driver probe.

Remove the write-back. fw_size is u16, so incrementing 0xffff wraps
to 0, letting the bounds check pass for an unchecked size; widen it to
u32. The bounds check used the unrounded fw_size, so a segment with an
odd word count can pass validation but trigger an out-of-bounds read
during the copy; round up before computing fw_end. The caller re-reads
fw_size_in_items directly, bypassing the validated value; propagate it
via a new fw_size_out parameter.

While at it, fix serial_protocol being compared with le32_to_cpu();
the field is __le16, which would cause the protocol match to always
fail on big-endian.

Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 46 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 873bfbd6b2b7..16f7af8a33d4 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1230,25 +1230,28 @@ EXPORT_SYMBOL_GPL(geni_se_resources_init);
  * @se: Pointer to the serial engine structure.
  * @fw: Pointer to the firmware image.
  * @protocol: Expected serial engine protocol type.
+ * @fw_size_out: Non-NULL output parameter; receives the rounded, validated
+ *               firmware word count on success.
  *
  * Identifies the appropriate firmware image or configuration required for a
  * specific communication protocol instance running on a Qualcomm GENI
  * controller. Validates the firmware size against the hardware PROG_RAM_DEPTH
  * read from SE_HW_PARAM_2.
  *
- * Return: pointer to a valid 'struct se_fw_hdr' if found, or NULL otherwise.
+ * Return: pointer to a valid 'const struct se_fw_hdr' if found, or NULL otherwise.
  */
-static struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct firmware *fw,
-					       enum geni_se_protocol_type protocol)
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
-	u16 fw_size;
+	u32 fw_size;
 	int i;
 
 	if (!fw || fw->size < sizeof(struct elf32_hdr))
@@ -1287,24 +1290,24 @@ static struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct
 		if (phdr->p_filesz < sizeof(struct se_fw_hdr))
 			continue;
 
-		sefw = (struct se_fw_hdr *)(fw->data + phdr->p_offset);
+		sefw = (const struct se_fw_hdr *)(fw->data + phdr->p_offset);
 		fw_size = le16_to_cpu(sefw->fw_size_in_items);
-		fw_end = le16_to_cpu(sefw->fw_offset) + fw_size * sizeof(u32);
-		cfg_idx_end = le16_to_cpu(sefw->cfg_idx_offset) +
-			      le16_to_cpu(sefw->cfg_size_in_items) * sizeof(u8);
-		cfg_val_end = le16_to_cpu(sefw->cfg_val_offset) +
-			      le16_to_cpu(sefw->cfg_size_in_items) * sizeof(u32);
 
 		if (le32_to_cpu(sefw->magic) != SE_MAGIC_NUM || le32_to_cpu(sefw->version) != 1)
 			continue;
 
-		if (le32_to_cpu(sefw->serial_protocol) != protocol)
+		if (le16_to_cpu(sefw->serial_protocol) != protocol)
 			continue;
 
-		if (fw_size % 2 != 0) {
+		/* Round up so fw_end covers the full copy range. */
+		if (fw_size % 2 != 0)
 			fw_size++;
-			sefw->fw_size_in_items = cpu_to_le16(fw_size);
-		}
+
+		fw_end = le16_to_cpu(sefw->fw_offset) + fw_size * sizeof(u32);
+		cfg_idx_end = le16_to_cpu(sefw->cfg_idx_offset) +
+			      le16_to_cpu(sefw->cfg_size_in_items) * sizeof(u8);
+		cfg_val_end = le16_to_cpu(sefw->cfg_val_offset) +
+			      le16_to_cpu(sefw->cfg_size_in_items) * sizeof(u32);
 
 		prog_ram_depth = FIELD_GET(PROG_RAM_DEPTH_MSK,
 					   readl_relaxed(se->base + SE_HW_PARAM_2));
@@ -1320,6 +1323,7 @@ static struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct
 			continue;
 		}
 
+		*fw_size_out = fw_size;
 		return sefw;
 	}
 
@@ -1430,17 +1434,17 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
 {
 	const u32 *fw_data, *cfg_val_arr;
 	const u8 *cfg_idx_arr;
-	u32 i, reg_value;
+	u32 i, reg_value, fw_size_in_items;
 	int ret;
-	struct se_fw_hdr *hdr;
+	const struct se_fw_hdr *hdr;
 
-	hdr = geni_find_protocol_fw(se, fw, protocol);
+	hdr = geni_find_protocol_fw(se, fw, protocol, &fw_size_in_items);
 	if (!hdr)
 		return -EINVAL;
 
-	fw_data = (const u32 *)((u8 *)hdr + le16_to_cpu(hdr->fw_offset));
+	fw_data = (const u32 *)((const u8 *)hdr + le16_to_cpu(hdr->fw_offset));
 	cfg_idx_arr = (const u8 *)hdr + le16_to_cpu(hdr->cfg_idx_offset);
-	cfg_val_arr = (const u32 *)((u8 *)hdr + le16_to_cpu(hdr->cfg_val_offset));
+	cfg_val_arr = (const u32 *)((const u8 *)hdr + le16_to_cpu(hdr->cfg_val_offset));
 
 	ret = geni_icc_set_bw(se);
 	if (ret)
@@ -1511,7 +1515,7 @@ static int geni_load_se_fw(struct geni_se *se, const struct firmware *fw,
 
 	/* Program RAM address space. */
 	memcpy_toio(se->base + SE_GENI_CFG_RAMN, fw_data,
-		    le16_to_cpu(hdr->fw_size_in_items) * sizeof(u32));
+		    fw_size_in_items * sizeof(u32));
 
 	/* Put default values on GENI's output pads. */
 	writel_relaxed(0x1, se->base + GENI_FORCE_DEFAULT_REG);

---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260819-fix-write-to-read-only-firmware-buffer-39ca7834e310

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

