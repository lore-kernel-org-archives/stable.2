Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6D361DB8
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956982; cv=none; b=V9pq5POjEsfecjEKiDNfkSanS3/8bYq+AbiNtMLByVUvCN+CFptgqhupqpbYmrCkKkBkUNGcXFWcaPPTHL8CqPDuJJaEmtENuOkky+D2PCuQcXg67KJFx7+TMY8V//pQE6NNhSs7Q5+oniBjgWuw9yC10nsSH7XuAsNrukoDrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956982; c=relaxed/simple;
	bh=TRkNrea61MTGC0WbTqxu5ZTOLj+heMFFmWWEsy3iL9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZ1fmrsg1hbnXIdWCMRYm21OU8agjgHd4uW2ECcyKxNyYsR8aIyyxYXs+//tqtLsRESRoDnKEFZPmInVoKMthi2OEO036zWC0AFXrOsFLUylfeHPapbvCrBY/Zmzj1xZ0r9hgmcZnsOX/W0TcsLadVjkDfcVHFDL+aH0vCQsYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wLSXZm3r; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wLSXZm3r"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFGCJK3842157;
	Mon, 13 Jul 2026 11:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RsVwF
	EU/U6VUV2nnu5ttK4Zhhcv58LE+sWklRt8+l5Q=; b=wLSXZm3rMITXZdxcC4ciI
	QVXGJOAbCrOiUae+7mPcNKYGad8DVTkuZaXolx4V0xSfl0jlDr7Jq4ZI2U8Lggq4
	m7DYDtH0KGb0c5Xgw8J5TaV/LMMGmx9q4y0zZtlTYsqfcLI3/bJmHXJUxVsfm9Qh
	5VreTPaDsdewG0J/81dI3vjMRHDr+8DxpebBYqFxit2LpjVzsiNCaiHvWd7/ObXz
	Pq9kgQRtpBbxguhSWflbJBxICav7Atrk1pJZfzqgAru0GFNpF2keavmej5oG+ZGe
	RuaMJjQDutCdflnk1Tgk5WDKozB1dEYNZ15sUtlb7l/Dc3v74ZMQlFUC9wHrgXRv
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fbjr16w7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:36:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66DFaHJF035817
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 11:36:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 11:36:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 11:36:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 11:36:11 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.243])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66DFa4lp022312;
	Mon, 13 Jul 2026 11:36:07 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: <stable@vger.kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, <Stable@vger.kernel.org>,
        "Jonathan
 Cameron" <jic23@kernel.org>
Subject: [PATCH 6.1.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Mon, 13 Jul 2026 18:34:41 +0300
Message-ID: <20260713153441.98488-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026071357-boat-germproof-a30c@gregkh>
References: <2026071357-boat-germproof-a30c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2MiBTYWx0ZWRfXx0TLYtpN4fQ3
 j+5rJHW0YpdIQYWv9n0OpD07b0BiZDTyTuq4SFsPz1QCDf/52t0ttel7aYYGQDxD7mjkygTuoyf
 HFUS6Cx5LXrml/P4n2r2WUVPHUS/Ep7za/8gd3Hhq627+5yljw8O
X-Authority-Analysis: v=2.4 cv=Ovp/DS/t c=1 sm=1 tr=0 ts=6a5505f2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=itsfFgpfY7t2nVq4jXIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2MiBTYWx0ZWRfX1DGCM0Qo3Jd4
 VpfEDnihszhl1FKBzCuQg4I1B8BktM4OuBQrKzLmnPPfAA9BLYqa/4mJhHlpDyRiWBU2RVeoxal
 suWbK4PPfnhMqZnY8XoEy2Jm8MLDRwQfc/+huoFlXRUDIskrNz95DgLYxP1bpbtB0r/mZ4YlsE+
 sU8a9QblxWjSUVTPI7Ey946YHyNGHfVHKYk4NLzzyNP8r/10pvK8TGYw1z8CWyYzOe1jB20BbeQ
 Yrcmidh1mg8ikIfIO5U0bgky/ghlJ/8AQskpKGVD2PJ1SGKC9f61qPpCnY3TWbsdSy9t0WLWmPW
 DrRDGF+SkXDyYR0K3ZqCoeHM/784dAQnQJhvoC4rnYLKG7zXgHkCWhkI2iRGTwxeXto9BiNdaUT
 sMykkjXIeFhJjr3h373IUpzeKQNoiD0nLt/4hDr6YLNUZ37abhL84yNGQgUZpXTB8UbGGDO+eNo
 /ShJ7MAKL37LHsE4ciQ==
X-Proofpoint-ORIG-GUID: ukG84yGZPbrM6JRlEm-pUo-_cJYYip9K
X-Proofpoint-GUID: ukG84yGZPbrM6JRlEm-pUo-_cJYYip9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130162

When adi,number-of-wires is absent, n_wires is left at 0. The binding
documents a default of 2 wires, matching the hardware default. However
the current-rotate validation checks n_wires == 2 || n_wires == 3, so
with n_wires = 0 the guard is bypassed and adi,current-rotate is accepted
for a 2-wire RTD.

Initialize n_wires = 2 to match the binding default and ensure the
rotation check fires correctly when the property is absent.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
(cherry picked from commit 434c150752675f44dc52c384a7fa22e5176bc35a)
Signed-off-by: Liviu Stan <liviu.stan@analog.com>

[ Liviu Stan: resolve conflict - keep fwnode_handle *ref declaration
  which was removed upstream by a later refactor not in 6.1.y ]
---
 drivers/iio/temperature/ltc2983.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 1117991ca2ab..b37c1e60b328 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -706,7 +706,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
 	struct fwnode_handle *ref;
-	u32 excitation_current = 0, n_wires = 0;
+	u32 excitation_current = 0, n_wires = 2;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
-- 
2.43.0

