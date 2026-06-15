Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1E3264E5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781503760; cv=none; b=M13JU3oVF2sTiSWX3gRNxYfWabuzxeGS21MA5FbEnwSsVSEv7Qc+RkoeipnUBsKt2zAR84snD1rsejX93eXjb7Z/054D/UZmrl9KZmiyak4sv0Y+v1TX6z0VdS9d6DwKBsqG59VhjkildKM/PmhVdRoUYeJqTWgvi2Sqxs9NYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781503760; c=relaxed/simple;
	bh=PKgXeShLxwaVF7Anm07f409jvOs7I7Dr6y/VL6J/1Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iICvkP5wuAg+rshGFp9zaXpYK/frDZ9TZo10e2xPTpuuQb9fnMltDjGQntLT8F1oM9zJRVgiguARMU63Fa3g7I/Vr6WbEyqAJ/swmUKpAW/E+EWC2EvuOZ6VtKW6IUY3K9T7tPn/cIjcgpaM9KHeCPf5R2q3F6A0umqxnRIElAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPk1l+WS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1xbMGw4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPk1l+WS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1xbMGw4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1htoT2741829
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 06:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dbrKRlXF9XHpr7RYXjth0KtQKdDkWR8x8tS
	Y4BCig+o=; b=pPk1l+WSLZ+ykDB+yhIWI6qvYtp1eYTclvYXJS7ZQV6bim4LQAH
	7gaWpMOcagPltj6XRGey+dezLl4hObcOAODz2+Dol7qGKzif+m9SAs9Y/dKzCigU
	96qcun0jKsXnPM5fYnlYaXffErRiUVaHJQd7KcDz1K6eJhRPErqIveB+G9cxXhs0
	cnXCqoFCvpEADWsxp30N4DKuMwu5eKzI3KCIfN05aDgbG1yF+Q7zC7s+ndROJ/8L
	WqX8alAJFwV8EQV9m9P0pOL738fy/eFOxYRsujTbhSVP89FbZi1XVWvrSAndgZKy
	bbLOvLJ/+siCNNGvP1qFC5ujeRM71Bd5ypQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0g85t32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 06:09:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b934a336eso2409583a91.2
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781503757; x=1782108557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbrKRlXF9XHpr7RYXjth0KtQKdDkWR8x8tSY4BCig+o=;
        b=L1xbMGw4nqSuNxjx1Aal/IZSgkhGWA53kvI39qj+P58s3Olq1e3qJdQgkkPmsDAc+c
         ZtWmzi6GhLvgRmUDDMx6qi1CPEgcuuYMDnzPBHaqJcInYNz7tuW9t0p2Uf1187Fu748D
         pZd9lsIYc2yP+4saum6b3EHlVaHy8AfrINdfQkpoSiAxFamnO3GgDogGKCFRu335xiPx
         QF3BlEeh/BLXfauSS280flcjcA+IM8JE3golntCMnR9XJMO5cjnobbZ6PK8hfPPg9gub
         oKO2Ivot0UpUj5WB7jlSTcXGfVS8ET45IXtv0h22f2hMkNyrYz4/0jFQCtZdZw4skzpN
         29kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781503757; x=1782108557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbrKRlXF9XHpr7RYXjth0KtQKdDkWR8x8tSY4BCig+o=;
        b=tZFrm5LToEjZ5do1dLnYQ+lVBF7vAQGxNcq9YfCPTpUfWKmlZAH4vCKeObPJOzNoTM
         KZ5ZxKbDrIAzMWzaLNWu5YipeaE6MijUpvRtCKEuj6uVJ3OxncsZz8+D83l+GaWgra58
         bateGH7INn1uDZu1rn05S/Xl9IKKYoxEbHuzKX1JcyFF5WWn6HeCeY/FwjT2UuuiwHUX
         OHHVro9LYKIjx1W/69O7SUG7H/P529df3BR653vRe+e5zXBvv3rbM2ir93Gbz9sQsrpo
         ZNy/b/NdkjbTCllDnJmtyvkD/ggW+5tGfgvzfiOn7Y24/xFcMaAq+ShVrJ+Yak9Xnj8+
         gc3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8VDXHYcG04kZZ8tKJQm17VeYSX8+Q8C0iBgzrllxMqH/2TzkJy3j0Y2FcMdZx4FvmCv2VibuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0+z1p3NO0JqLUYApdO4KGyR7KnjYLZTnPwbEITcJyuCzlTm/
	XuyNLf5VbmPyIb88fxBp7ucoMOapsE2dgPI/y3sJN9/q1JTSG3FHtKKSGqg0MTeXXv++pWBcnek
	W8FoB4BgAsIiVoQa53MVraFnDDUTyQ3/ee2L6M5CEWA3YiCGfR6Lu9S4dZ3U=
X-Gm-Gg: Acq92OG9EclGvS3Yn34jMXxLy/RhkRse8m5qX145XwGKy5UysLVz+tPRbY62DGbUQtZ
	4NiCgI1tWk7T21IhGXbBzvBeO+xksAJzECAAzvOuqnb0vlm6Iaujx3EIt6+OjJqFj0sZnXytp63
	Zd5mbLBlsLKgmQSdpdm1MMx4KzeIglqSADtYHyPA0jXg5JdLh3/0BZSHPrMKLWVitT8+8tgGB5p
	2LgmSQg8BZ+QTT4VKNNRVHhOE+Qsu00mzvj8UNOcxQRFmNY8EktAKi1f9LhcRcydOSJ+cu793QY
	PSzvD87ur/DbRnKnCGZL+MZ2zrpQ7CNgkkuTWhcmL5iJ0xGo8PpZ3bS+aKUat08b39CMCTPGn3Q
	RnrkUzPcrk3hpGhEOa5r0XsexKyw2tSY5wrzJsSw+v4MgaNTUjiNuBjqs+W1XTeAJnBKmCqSjU5
	7pgm0Z4+AK56MzE9xqDZ2iamOkcurwB1b/1ZzZCu6GaN7XwLcLg/k=
X-Received: by 2002:a17:90b:4c4b:b0:36d:dfe4:387c with SMTP id 98e67ed59e1d1-37c2bc7a4fdmr9216738a91.10.1781503757250;
        Sun, 14 Jun 2026 23:09:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4b:b0:36d:dfe4:387c with SMTP id 98e67ed59e1d1-37c2bc7a4fdmr9216714a91.10.1781503756727;
        Sun, 14 Jun 2026 23:09:16 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2678375fsm11063580a91.17.2026.06.14.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 23:09:16 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: vkoul@kernel.org, Frank.Li@kernel.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>,
        Lakshmi Sowjanya D <lakshmi.d@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        stable@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v7] dmaengine: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
Date: Mon, 15 Jun 2026 11:39:08 +0530
Message-Id: <20260615060908.1263171-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OOoXGyaB c=1 sm=1 tr=0 ts=6a2f970e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=8AirrxEcAAAA:8 a=qeNJoaxpl3A19PTdgUYA:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: j3pBxc5bt-6-J3wPRfrLc3CTcmAF1H_t
X-Proofpoint-ORIG-GUID: j3pBxc5bt-6-J3wPRfrLc3CTcmAF1H_t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2MSBTYWx0ZWRfX2LQdRq4/r9fN
 hUgDxxSLg0jC350sIU93N6itR6ZdmtZBEaVV+wg/WYsTJoZf8RKiJcogWmh9ExZN0sy2f504xnR
 7Y/GeOZ/6kAth+xqX6oDdQegwYAfGkJItKmSMWQvSBtOVJS7pn+BTwB4Zp9o8vwgb6XBbI0mALy
 XwlZgmyFonGWRcr7terdgci/aBkOxdRI40IAAQSj8H4aERAQrOclRi5MBw+jgUMGpdjWluSys1j
 iwZufKrDH8OenI+82buP6Nqc92sj5S6VwTzaSwzXYltu+Xl6d5P9fhVKH8lYLtL8LVbm1TslEM8
 droq+qMm3+bmo2TlMDgAiFemiJnHKvSsGuo/cKUfZbGtiXi7HCT+Of3qWfQjiHDjevqZ5p1tzE+
 PcFPXpWOxEWdE+Mw0My8yKaIvPBA5jSyUCKUTaHLBSf2LLHLeDe6uFEKMH1/xyvIZ35rJOL0T7f
 sFHICzU2ddEz81KieOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2MSBTYWx0ZWRfXy3ugoaULKID2
 x6x4e6/673K2/cNL1WVyMlOXZN47X4hZd+ELODfUp/ATzm1MO7TZ/yyf+JiH7ne3d4ByDI2EOg+
 hGfzKi9lEfgPVQ6aFEyHtmiIn2Rz3tQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150061

From: Md Sadre Alam <md.alam@oss.qualcomm.com>

BAM version 1.6.0 and later changed the behavior of the mask field in
command elements for read operations.

In older BAM versions, or prior implementation assumptions, the mask
field was effectively ignored for read commands. However, starting from
BAM v1.6.0, the mask field for read commands is repurposed to carry the
upper 4 bits of the destination address, enabling support for 36-bit
addressing. For write commands, the mask field continues to function as
a traditional write mask.

The current driver sets mask = 0xffffffff for all command elements.
While this works for write operations, it breaks read operations on
BAM v1.6.0+ hardware. In such cases, the hardware interprets the upper
address bits as 0xf, resulting in an invalid destination address
(0xf_xxxxxxxx instead of 0x0_xxxxxxxx).

This leads to failures such as NAND enumeration issues observed on
platforms like IPQ5424.

Fix this by assigning the mask field based on command type:
  - For read commands: set mask = 0 (upper address bits = 0)
  - For write commands: retain mask = 0xffffffff

Also update the bam_cmd_element structure documentation to reflect the
dual purpose of the mask field across BAM versions.

This ensures correct behavior on BAM v1.6.0+ while maintaining backward
compatibility with older hardware.

Fixes: dfebb055f73a2 ("dmaengine: qcom: bam_dma: wrapper functions for command descriptor")
Tested-by: Lakshmi Sowjanya D <lakshmi.d@oss.qualcomm.com>
Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Change in [v7] -
	- Remove blank line after 'Fixes' tag
	- Add 'Cc: stable@vger.kernel.org'
	- Add R-b Dmitry Baryshkov
	- No code changes

Change in [v6] - https://lore.kernel.org/linux-arm-msm/20260611045757.2841252-1-varadarajan.narayanan@oss.qualcomm.com/
	- Commit message updated, no code changes
	- Pick R-b Frank Li (given in v4)
	- Change 'Lakshmi Sowjanya D' e-mail id to oss.qualcomm.com instead of quicinc.com

Change in [v5] - https://lore.kernel.org/linux-arm-msm/20260514-bam-fix-v5-1-58f6edb34969@oss.qualcomm.com/#t
	- Split the driver change into a separate patch
	- Update commit log with 'Fixes' tag

Change in [v4] - https://lore.kernel.org/linux-arm-msm/20260206100202.413834-2-quic_mdalam@quicinc.com/

* No change

Change in [v3]

* Added Tested-by tag

Change in [v2]

* No change

Change in [v1]

* Updated bam_prep_ce_le32() to set the mask field conditionally based on
  command type

* Enhanced kernel-doc comments to clarify mask behavior for BAM v1.6.0+
---
 include/linux/dma/qcom_bam_dma.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b..d9d07a9ab313 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -13,9 +13,12 @@
  * supported by BAM DMA Engine.
  *
  * @cmd_and_addr - upper 8 bits command and lower 24 bits register address.
- * @data - for write command: content to be written into peripheral register.
- *	   for read command: dest addr to write peripheral register value.
- * @mask - register mask.
+ * @data - For write command: content to be written into peripheral register.
+ *	   For read command: lower 32 bits of destination address.
+ * @mask - For write command: register write mask.
+ *	   For read command on BAM v1.6.0+: upper 4 bits of destination address.
+ *	   For read command on BAM < v1.6.0: ignored by hardware.
+ *	   Setting to 0 ensures 32-bit addressing compatibility.
  * @reserved - for future usage.
  *
  */
@@ -42,6 +45,10 @@ enum bam_command_type {
  * @addr: target address
  * @cmd: BAM command
  * @data: actual data for write and dest addr for read in le32
+ *
+ * For BAM v1.6.0+, the mask field behavior depends on command type:
+ * - Write commands: mask = write mask (typically 0xffffffff)
+ * - Read commands: mask = upper 4 bits of destination address (0 for 32-bit)
  */
 static inline void
 bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
@@ -50,7 +57,11 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
 	bam_ce->cmd_and_addr =
 		cpu_to_le32((addr & 0xffffff) | ((cmd & 0xff) << 24));
 	bam_ce->data = data;
-	bam_ce->mask = cpu_to_le32(0xffffffff);
+	if (cmd == BAM_READ_COMMAND)
+		bam_ce->mask = cpu_to_le32(0x0); /* 32-bit addressing */
+	else
+		bam_ce->mask = cpu_to_le32(0xffffffff); /* Write mask */
+	bam_ce->reserved = 0;
 }
 
 /*
@@ -60,7 +71,7 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
  * @bam_ce: BAM command element
  * @addr: target address
  * @cmd: BAM command
- * @data: actual data for write and dest addr for read
+ * @data: actual data for write and destination address for read
  */
 static inline void
 bam_prep_ce(struct bam_cmd_element *bam_ce, u32 addr,
-- 
2.34.1

