Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B1D1DFDA1
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957548; cv=none; b=JY5ha8eVAvB0A6XEx+CqcWwENQKbjlz38BeoWpZpBudWhIgXcsMG9aVZm+BrWc1dbOHQK3ZVkBnTG5nPDkkzMAHDiExm5Vi29+U3PyQq6NrU9GdkYEYyPtU7RPIkS1Q2dIHzqRywQGkKzMT+jMCtjOxrDbsyK/wGfVYWjYQhCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957548; c=relaxed/simple;
	bh=ADwhdkKTn5GHNWbLluUbL1o/AKqzjesY0iUa8yttyt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmYAlD+U9TTgXS83Pa85dp+D1reya/0TqXe+lhH+VrWh9XcXU8cIClzBjevwIUWT4Wpq/uK2WRnQNDn90YeXYoeHHcmQ5/k7J3d17SwbYO4XRJwjGHEWnxynT59JHEUetBTEGQUdxd4VFAGD6A+B5nYtvFK5g/Ukz972jESi1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bIOXbWAp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bIOXbWAp"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFFc0B3915569;
	Mon, 13 Jul 2026 11:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aMjtc
	hFzHwe/cwdDIiCXRO1rposh02H5h+xXsuj4Oas=; b=bIOXbWApw2G2YGAcCigAu
	oT4QP9d1quyu7EpysLS4FDJdmGVq6uV+p33S00NnHlgZXHJGkNJWe1iNR2dQoxpO
	gnxiLFwmUtbgtOtwa7vePZR6xs8LGTtbiv2OibFd7SkJjA05dyOxrIwEjDv9qq7U
	Nzt0l7dLN/IesKGYTc0bNuZxDcqbhArHiU1CmnAwNPaw3GLDKVpWOjFRveUdit2z
	yBHnxXVfOKU2fBFSF8QwqOGwv1C+cEMBvXXdzpZ44G3Y9gOgl/ntxpGQIHCxMSre
	FU8DPR+PGHT07vRpxnL1A8W7iZ6aeGviVXXe1+4MdaK0bklB0OqE02YNlDko9UbO
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fcx3a93w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:45:44 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66DFjhQl036392
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 11:45:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 11:45:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 11:45:38 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.243])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66DFjU3A022625;
	Mon, 13 Jul 2026 11:45:33 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: <stable@vger.kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, <Stable@vger.kernel.org>,
        Jonathan
 Cameron <jic23@kernel.org>
Subject: [PATCH 6.6.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Mon, 13 Jul 2026 18:45:26 +0300
Message-ID: <20260713154526.100997-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026071345-neutron-revert-03cc@gregkh>
References: <2026071345-neutron-revert-03cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2NCBTYWx0ZWRfX1g7r2ffERTKg
 GxFNYG/x/pZ/DXkvhsGZNfp5wgFvG3N2DshBov+4pDjVT8ajXzTTh+B2cay0CBnXdt7he6euumG
 k1N4ga39AUd1+ffvsCsYo2xKFO1ukP78KYBaKgTO8LUfkwSZe52y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2NCBTYWx0ZWRfXyXIByCzHDaLa
 BATMgoaCSRsD58lfyLAOvN4SdNoMiWXxGYr5i8r0o3SM+djyiw7JRxe2cmhuFJCLrwI7eXXQL8/
 LwjxrjIirZN5Kgkj8+flumcsQAJCL7DwIv/83v96ovedQUpqqBaZuNJEbxhoDvc44Iovpakt1gz
 cm109ZBaWlY96SFqR0G9ktiiKIECHGFZ9GS0hhwh06siAf6e8cR4FprGgaS1GkC9FzIxQqYXpV0
 plxBwKuoFveyPPooYhFMYpE+tYsa6tkvpcapGm8IYOjJRQz/amq3tb5kPJyOTTRUCt+O/k1VVWA
 OnBOkPKN1aYsh0g5Rs+zKH3thlBO6NLE7+3okguzwoGSHybOh0milG/5AYucYBpih0zyX+J9RKd
 FjuogA8x+3XSOBHASVBA0KefBU3cSX5Os8jKAQLBCpsz/AuJs0KB+gGLE/z38RkC2yz+sq/OEOD
 6MBg+5Lj1x9wHUgoqkg==
X-Authority-Analysis: v=2.4 cv=J8CaKgnS c=1 sm=1 tr=0 ts=6a550828 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=itsfFgpfY7t2nVq4jXIA:9
X-Proofpoint-GUID: rd80hS6EXsRF_jtTIxLAdMeKqylQHR9d
X-Proofpoint-ORIG-GUID: rd80hS6EXsRF_jtTIxLAdMeKqylQHR9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130164

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
  which was removed upstream ]
---
 drivers/iio/temperature/ltc2983.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index fcb96c44d954..193645db94c0 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -751,7 +751,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
 	struct fwnode_handle *ref;
-	u32 excitation_current = 0, n_wires = 0;
+	u32 excitation_current = 0, n_wires = 2;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
-- 
2.43.0

