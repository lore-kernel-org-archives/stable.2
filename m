Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5237377EC3
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956077; cv=none; b=CJSXkO4qx3CXRErlcguWoptKtutJilvai4NWgCS7r0Dhm9sjTZgNK0oFCLdGuu4wEfqMjXOyeKvOE2Bnawjf6XEVdaAuXmiAa/l62jzfJ00AzBrv2ivVBcAQbaCC8v1w71Yw3AARzODj6f0Wazxh9cDxg2/wbjkwzxvzMrICQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956077; c=relaxed/simple;
	bh=P9VdsfF8z3q0Uk1mscnPeVGuUtGpCeVajhPpCxRHHIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIRZa7zcO0wOtk4ivDeVMuLbUH4mDQnMokjDANWnPM2qnFUhiCLmRq/hEXwSdNLgOagtuPc02QWn1qe7S4r8bYDDWkZ5N1IC8pcYWuj1Bm1Rd//eeQUoUHBMvaTPC+eSJE6QTbbN+TfHJ6XXq/4Lp0cj7IMOD7O0gIyLTDptoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YM46QrAR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YM46QrAR"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFG2TM3993000;
	Mon, 13 Jul 2026 11:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fKctk
	rASQeetK5K9tNmHrfKZuF44L4mxac57PJoTUKI=; b=YM46QrARCz0OQ/SvHFHSX
	ahVO9c+oWqAJboZmq5mGo+OIoYgr68QlGkDymIz1dn8/IG3QnpFUUUMqD9w43TgY
	RsV3083bE96Mwl5yx6KomnO2kuBk4qp268rH9WA+j/XEsRy/SQRbgd6bKQEEit9w
	5kboumRh39WDTicuS2CR/jO3Z27wngzt4YKfQA4N4810aFBAm6zEgytBD8TstvpF
	v+Ab0J6uijVEMEFGujsJUKyhxjDoZi3i+89Y3IYY8dMzzziIqHitMLNkVMOG/itx
	uJahCfaZ5Bh9NneMhj8HkOKhIDtNkW8Rk/GnOT43ZNRyOLnGEPiOKXA1haJgwmGz
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fcx3qh1h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:21:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66DFLClD034514
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 11:21:12 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 11:21:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 11:21:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 11:21:07 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.243])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66DFKr1h021760;
	Mon, 13 Jul 2026 11:20:58 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: <stable@vger.kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, <Stable@vger.kernel.org>,
        "Jonathan
 Cameron" <jic23@kernel.org>
Subject: [PATCH 5.10.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Mon, 13 Jul 2026 18:16:13 +0300
Message-ID: <20260713151613.93022-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026071327-overbook-grandly-b911@gregkh>
References: <2026071327-overbook-grandly-b911@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cqirVV4i c=1 sm=1 tr=0 ts=6a550269 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=itsfFgpfY7t2nVq4jXIA:9
X-Proofpoint-GUID: vTuxlJMbtsow36mdOgwBI9XmlIFsTyb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2MCBTYWx0ZWRfX4PnlP+AjD/J3
 L/BTfChtfHvdg5EiN/IJxmmRqweBmoLQpGdj9fsrxX4OVxnq1kWYUC5rEVxQkNudQVW6kX4LIST
 iIRhAvqAX62/JOHeI+VkxQg+DJ92cGiJD/AoZt+ItdWRNH5ffvVwsP6H4UCnPyASnrNI7ssMhWK
 cExPYNKE8czESX6LQ0Kdv+yaZWAN3PN5pBMJE2lx6Ec7t5FzMg3CGQvRfAOGp6IZYgwv7h8Oi9Z
 6pdm4RMtBpoED13c27sG02nt0PiU9Huc+JWa6HlAC6/01Tnqy80DbH3U4cRmwBcgCLOpDCYfL6y
 B2rMu89t42kb6Na80Ui79imasxF2IKsTriUpCGUBDjonSLwkLXS/E8A96QVyvl16RgogeYddae5
 K3baXE62WLXWWEy/Kl6ugiUvDW1CYEUqc+pJHRvON9C4UfM70ujvhSpufHLYwO+GjN7RC1gq56X
 vUBfMIK0TlYfTDTr27w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2MCBTYWx0ZWRfXzpqj4ceSjFD/
 QhzQFi1CLyMsmtFc0bzf9orlFiIUNlDNrOwVEpFkI3DU8k16XmUTEPLXghzKfWecJ3c9cqPBDwV
 JWmuO8w0E1nycAZyfeYy9qGxO9BQ/KkIPQzH8Phm/HMS4HMXuUmt
X-Proofpoint-ORIG-GUID: vTuxlJMbtsow36mdOgwBI9XmlIFsTyb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130160

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
---
 drivers/iio/temperature/ltc2983.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index b2ae2d2c7eef..2fafd9040ad8 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -697,7 +697,7 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
 	struct device_node *phandle;
-	u32 excitation_current = 0, n_wires = 0;
+	u32 excitation_current = 0, n_wires = 2;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
-- 
2.43.0

