Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EF485939;
	Wed, 16 Sep 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549072; cv=none; b=eVYNrvss2qAvmXOiaB7LwaYz4udH5+jcAn1QCxAKMVlC5WS9zUmBgX6P4rl4J4vwup6GGnpsL7Zx4NvIwf9rqXaeTWtfDt4OO5qxSw4eoRidlT0iteUyKQocy8tfTsE2HZiDftFqsyyv9UlLQ5qG+F8cnfePISrd4NHvc+bW6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549072; c=relaxed/simple;
	bh=ZFsnv10b3I7EdjKsa23Ymp+lKDaNuAm+7Mdrw4VcRvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKa60cNeRHFMD/N1tLmSE4yg2KbJFAXM9nqVdbiLaTQrM/GyAEH436NipaAEUnGWf39xRlkPQAff3hbhT3kNqDxWCgn/koFKzOIqDNjRZPkwD3rfhAMsE9GAhjaarhNToJeRgYovT0vioo8P4hylIKs9JoC4CBLmsCacmXXF1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mz3NSDTE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mz3NSDTE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G69dNa1163413;
	Wed, 16 Sep 2026 08:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bdM4hjbMxAysnl7GgPyr+jTaRcFsj7rj26I
	X2wnPqL0=; b=mz3NSDTEAMnqvQ2T0a41VRg9gZo0GsHfOMC2tihFYqRHSawPayo
	2vJnxwX38gO4qmTGZ+bdrURDrMHZOMLwAnN9HoFGaHesYdW4wUeyCKsatB96y4AW
	mkvfy0M3R2EVulLY9DRsp5YjtDf1Yk7Zupwir6Ak/QWR9UZJA0yVkSE7H3GEmNne
	5P0o3BgFJBY6GSQB+DDdJkbjM5EizpAmiEA3GoDbRaOSoX2CVfdinOLijkbVLgHo
	fkZ/5nfBYIAFz62JGk18wAfLJ41KFzHPSmmtFd6nS1VuXTlQtZZ7LoZ3fCxrsEZw
	hjAhe4Hbc6vJ6Kz+oGnsRcGYBugmdMzIL5g==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq9n63rd4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:57:27 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G8vPex1071615;
	Wed, 16 Sep 2026 08:57:25 GMT
Received: from ap-kernel-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 68G8vOum1071606
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:57:24 +0000 (GMT)
Received: from ap-kernel-sh03-lnx.qualcomm.com (localhost [127.0.0.1])
	by ap-kernel-sh03-lnx.qualcomm.com (Postfix) with ESMTP id A90D94055A;
	Wed, 16 Sep 2026 16:57:23 +0800 (CST)
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
To: linusw@kernel.org, andersson@kernel.org, brgl@kernel.org
Cc: pankaj.patil@oss.qualcomm.com, maulik.shah@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Subject: [PATCH] pinctrl: qcom: nord: fix GPIO interrupt target width
Date: Wed, 16 Sep 2026 16:57:20 +0800
Message-ID: <20260916085720.771498-1-zhangfei.gao@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=BdVNQbt2 c=1 sm=1 tr=0 ts=6aaa59f7 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=6wNvA0c_i9Qvwz773BMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNSBTYWx0ZWRfX6ml1FjNllDsi
 FW/hPti4+p2XwmsknSGfcMjNdsHSjWf5l2BBlbM0TgtY3luSwtAO3y3VYEFVs8rYS7vpTeNl6wQ
 /mdbpNXH8EKcayqaiNM6rufVFYlyiYGvdC5Li2Hg7upaUt/1UDayTTFnFaWfuA8B4ZbqTrrH4HM
 W7I2C+m4J0jDSJjygUAMpmkYNVqJTvbIfrMl0H+5ZLIdVJF4qIlsZ1OHYfwXcJL49FKXGs9XYkS
 qRbrAQLdWOrSoe3bBk57WgAn6vsEPqmdHu4Mdk5nZDxYqo6mmmczmSXzisIFKRI1HExsPrLtYN4
 8mqF9bunGzMt/S4g1MITMh1IBs0/BOqcQZ1DCYuGZNaLNw7ofExH4R8qasrs6i/pUIq6Ohjlpke
 mOfjrIeVtBPZqMav4c3MYLKG2piI/v9ag1TqdG5qUihGqQ1DM8BmRwIEqQsEfOoBboTqx0v5CMA
 iTqZj6YIZAkh7xc5XMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNSBTYWx0ZWRfXyppRl0kUMhQZ
 jxM6IL66OSchp0qMPFzKBG9UAnNvzuPh35MZR4Q2lcfRkSivwYN3lLC1APdKcEJruutntw79BD2
 1CiCWh6/0NPDPS569yc/qyqQ1D5VMC8=
X-Proofpoint-GUID: vIZQKhA0YrCzai_QXubsuD7EongZcgrV
X-Proofpoint-ORIG-GUID: vIZQKhA0YrCzai_QXubsuD7EongZcgrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1011
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160115

The TARGET_PROC field in the Nord GPIO_INTR_CFG registers occupies bits
11:8. Describe it as four bits wide so the common Qualcomm pinctrl code
clears the complete field before routing an interrupt to the application
processor.

Without intr_target_width, the common code uses its three-bit default
mask. Since GPIO_INTR_CFG resets with TARGET_PROC set to 0xf (NONE), bit
11 remains set when the driver programs HMSS target 3. The resulting
target is 0xb (HPASS_DSP_1), observed as an interrupt configuration value
of 0xb1b instead of 0x31b.

The GPIO interrupt status is consequently latched, but the HMSS TLMM
summary interrupt at GIC SPI 208 is never asserted. This affects all Nord
GPIO interrupts using the TLMM summary path, including the Ethernet PHY
interrupts on GPIO55 and GPIO141.

Fixes: c24dd0826f06 ("pinctrl: qcom: add the TLMM driver for the Nord platforms")
Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-nord.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-nord.c b/drivers/pinctrl/qcom/pinctrl-nord.c
index 7f37f8e819ba..010760cf0bf5 100644
--- a/drivers/pinctrl/qcom/pinctrl-nord.c
+++ b/drivers/pinctrl/qcom/pinctrl-nord.c
@@ -32,6 +32,7 @@
 		.intr_wakeup_present_bit = 6,                         \
 		.intr_wakeup_enable_bit = 7,                          \
 		.intr_target_bit = 8,                                 \
+		.intr_target_width = 4,                               \
 		.intr_target_kpss_val = 3,                            \
 		.intr_raw_status_bit = 4,                             \
 		.intr_polarity_bit = 1,                               \
-- 
2.43.0

