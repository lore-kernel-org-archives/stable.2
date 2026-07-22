Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526235A385;
	Wed, 22 Jul 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712712; cv=none; b=JgPy9VGjjVefaTu+vioqf5AJuDcfPBaZkWqVNSNhsIGyv1PqpYYII0dy+lTQFUeOS7kwhnBqHOiAy0drHrLyV3MHIHTQt4Am11hKvZlRKrdtkJnjhiRyKIrIgeV96za6ifKb2K1ASd8ExfRJ4kJjKFX0H5LOJwImX743y6v90gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712712; c=relaxed/simple;
	bh=+MX8N44gzDm+IVN9Pmyk0LhrTfJFezuj789V0yncjqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZ/yW2gCMtXbV6LW2FEHj0AhJMtpLyYJbU665tslz2BpKKRkgpREvtzNcET9kQABzJEbNPOrpDqrt8mKxXqRfhT/pXgUnrbhItwH1tVdpJoWh7GlKaXiQG+TNBgWO0FV//bxcCRJqZ5jWSqRmkvvLibgGN9esIbcKRqhiC9bNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7Z1wu02; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7Z1wu02"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8xM5F412345;
	Wed, 22 Jul 2026 09:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jZuhYaMeqAy9ym3Y9m/YxNFsTgDrHOmzpmK
	fbULnzks=; b=D7Z1wu02cGRNkj8MZqQeY+9AlfG8VpIW47tkalLECuj5qfTXdj/
	MKXbsEbyLndDWzht+gLmoMrzXpvnIXFHrlgOd4AB01a6ijQ1mnyxNZ24c9U26aWG
	ogDhAeq/ZNqm1jsCzOBUzLXQ7jJXXRu1XYRehfa9VA23LAy0Za+orLSu9OQmIMk2
	MLEr/phPsN2cj4KwVCh2MXA55LbEdCDPNbpRLvetjtVbm/mM9gR1JaMJw/iuCYUP
	OOXzjNmTihY4Bfc6l1HZAtT1+9zRsIjUI5b7dh4IYnsHWjvMNn4LZQNq0QVVAEm9
	GrkRNhNoqmOkfS67BrWUp8AnZL3cvLdtW1Q==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdh563-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 09:31:44 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66M9VehD006549;
	Wed, 22 Jul 2026 09:31:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fgj3wg1kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 09:31:40 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66M9VeYn006543;
	Wed, 22 Jul 2026 09:31:40 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.147.248.72])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 66M9VenQ006542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 09:31:40 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 3994820)
	id 21E255C2; Wed, 22 Jul 2026 14:54:17 +0530 (+0530)
From: Vijaya Krishna Nivarthi <vnivarth@qti.qualcomm.com>
To: broonie@kernel.org, dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: konrad.dybcio@oss.qualcomm.com, damiendejean@google.com,
        Vijaya Krishna Nivarthi <vijaya.nivarthi@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v1] spi: qcom-qspi: Correct max DMA length to avoid 64K boundary failure
Date: Wed, 22 Jul 2026 14:53:58 +0530
Message-Id: <20260722092358.459943-1-vnivarth@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5MCBTYWx0ZWRfX/n/m7td2rkaq
 rsbASqAON2uhkK2+wp6/zMiJcr8sXAdbCQvJTyXkgDa3mlokhNLEhmO5BHbS793sz1YQSv26eG9
 4QCVShoqHkN2/aOZx9PjHvVJfYTU7HrN1zi+sAsbZN0GyHXLe8YbIOOMkQBQWpnht36utXAgvvI
 LaVD+WLnon4eMcqTH31t0at5lSPIKgy0qRatfNYqgGvnVSknrtzJvXajCqB+oz10AfwdC08yBEn
 j7uJTztdcCeIwmavc4CLXf0QBLilxaXJE1QMMvzpKs1njQv4FJo9bVZ09bkKqV/8tTab1QCYGgJ
 /CNf4cS+MMnGeFMp9PyLYypZaQT6Z2fO4BtijtD0sLg3ZMxMwxQ51M2/MbuMz67OsIa7GTxaWCw
 AX43AmvYviTDtp8uXtx+LDL0viQbO0SCSHhLnlxr6vmsB+ZBJyEjgASrfe0zoKbWFGsCc7qR4Ts
 nutVuDq8/UgJJYYx/JQ==
X-Proofpoint-GUID: cqO8lSdF5p7VUXfM6Zb4fl58UOU0N9hx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5MCBTYWx0ZWRfX3s5s0CTr/Yi/
 CUyGZgMHS7LL+Rod92Bk5rB5HsSyEJejbSWMiCR5H/bw37iHW8kcosEEDpNsevMz/jfokG0g6jU
 kpQ0x5JdJ5WYGkCPG2HCyd1IYX5e+KU=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a608e00 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=bDri8NSO9_2niQu9DqAA:9
X-Proofpoint-ORIG-GUID: cqO8lSdF5p7VUXfM6Zb4fl58UOU0N9hx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220090

From: Vijaya Krishna Nivarthi <vijaya.nivarthi@oss.qualcomm.com>

The maximum size for a DMA data descriptor is 64KB-1 because the size
field in HW is 16 bits wide. For this reason, transfers fail at 64KB
and beyond.

Lower max_dma_len to 60KB so larger transfers are split into multiple
DMA blocks and do not hit the failing 64KB boundary. 60KB is chosen as
a safe round number below the 64KB-1 hardware limit while satisfying
alignment requirements.

Tested on x1e80100 (Hamoa) with SPI-NOR flash (/dev/mtd0):

Without patch:
  dd if=/dev/mtd0 of=/tmp/spi_dump.bin bs=32768 count=2  # works
  dd if=/dev/mtd0 of=/tmp/spi_dump.bin bs=65536 count=1  # fails

With patch:
  dd if=/dev/mtd0 of=/tmp/spi_dump.bin bs=65536 count=1  # works

Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Vijaya Krishna Nivarthi <vijaya.nivarthi@oss.qualcomm.com>
---
 drivers/spi/spi-qcom-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index caf55a6f70b3..e9fdefa9d65d 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -775,7 +775,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "could not set DMA mask\n");
 
 	host->max_speed_hz = 300000000;
-	host->max_dma_len = 65536; /* as per HPG */
+	/* as per HPG, it is 64KB, limit to 60KB to avoid boundary condition failures */
+	host->max_dma_len = 0xf000;
 	host->dma_alignment = QSPI_ALIGN_REQ;
 	host->num_chipselect = QSPI_NUM_CS;
 	host->bus_num = -1;
-- 
2.34.1

