Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574D381EBB
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956397; cv=none; b=jpRq8z24AwDLL4XAdQPoIbaW6CanX8tXWEyuUgrQOyNCZOqyY/lcT4sWsoVRxJiFzbFbabnyg5EARASHZ2NFH0mXZj0sLwWpYeVbqj/ulFhJvznrv3oX1kv3Uwak2wG1pm6a0z6PgpBfMfe8DY0AnHl2Qo+Tk7yJ70uV7CLMFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956397; c=relaxed/simple;
	bh=P9VdsfF8z3q0Uk1mscnPeVGuUtGpCeVajhPpCxRHHIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyfaj8wCrWQqxohI8cwcnVWfzLihH+MoKN+gwU75QYWQmcOULxxeuHICtBZ+7PcUDR6MKhXN9G7qpl65866ynYupCxApu7mBv8Bp1ToQdj+Ec0uTI6/Ups9Y/lpS+dto3WJ2z6ESXSKCJx0NRxrSt8FZ8BklWK8BfrI8EnsZhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g3NDS0Bd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g3NDS0Bd"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFFtXn3688949;
	Mon, 13 Jul 2026 11:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fKctk
	rASQeetK5K9tNmHrfKZuF44L4mxac57PJoTUKI=; b=g3NDS0BdCq09IvMPvdjq4
	EZcZf4svFyAgY1cpWsJT8p5FFlNQMdAkMyPaCkxVPl7T9c4cnQS8nSbzeNkCzbP+
	l6diz61FSpoNzmlIoaefUTbt0gFlB0qcqnQfSYecjA/YujRcYTygdBA+DncJprtV
	WulipefZ4/w8wey9c2LXQWS+/K9ThU2IASr6OPFYqEYaKr+9cWNy20xuii05i1jz
	RID/aWgtzNv6C4Z4OjQJNKpf6s6gbA0A9nOFjvpIhp2dP5tXeiYEKtX9gtX38vz8
	BJT3BRlKxZPvUEqIMz1XwBHGTplaih+/YyUCf5EpdYDzPslbEViHFzkyfLKWgxY5
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fc45bcs0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:26:33 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66DFQWS3034912
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 11:26:32 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 11:26:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 11:26:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 11:26:26 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.243])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66DFQG5Y021995;
	Mon, 13 Jul 2026 11:26:19 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: <stable@vger.kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, <Stable@vger.kernel.org>,
        "Jonathan
 Cameron" <jic23@kernel.org>
Subject: [PATCH 5.15.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Mon, 13 Jul 2026 18:26:10 +0300
Message-ID: <20260713152610.95791-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026071314-ruckus-bacterium-2228@gregkh>
References: <2026071314-ruckus-bacterium-2228@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2MCBTYWx0ZWRfX783mbHUozL/5
 PXlWs9cuPCAOShECiIiEsazuubcsC3ErMwUK4FjfVxH2yOPZWnxjTJREVKKkN4k2s5ylb8bwsPb
 U5n/Ha4Qc8dUPpwhpUoU25mxzh0nwUH0aqeSHhh+/8sFvxn++eibhDsm/GdLuAEctNZF9DBuGwp
 07UUTWWE0AqmDotUQiTXu3thNjOw5w3P9r0NsD98+O33g6QLf+/WQ0NTRvQCb2L1IqLaYE5G0mN
 HviL1LRFmOnReeDz3okWGqThiAd50yniRo098z4/lNrkjgvv0Gjz0El49Ouim3j88eG7XiUz0Qp
 DJKskADgfHRPQp+5u07SvXTPsD6GunR6kloAvaZ4OGxn0nJxniQTBq+THeEZ2hZkE6LTBfAKKBO
 IuGFd0F5tWn6RrlLDB86tFyzj5mUIlNCddL6C/RQezr9E40BOzhVu5k4vtdWQYQsXK1SmUCjepk
 WEbElTa3aAKzYOXMFxQ==
X-Authority-Analysis: v=2.4 cv=CcA4Irrl c=1 sm=1 tr=0 ts=6a5503a9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=itsfFgpfY7t2nVq4jXIA:9
X-Proofpoint-GUID: xAsVWQJJHvTkyAcqCju_nWmpzbR9WjJu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2MCBTYWx0ZWRfX6i3F7ygJui5o
 1h1CNjVynG6vsl/qALh1kaCMkAptVz2NaU/9Kib1gFvYnyXJ7HgvxhSeiT/e1PlQrMHaXBaNkVd
 S6l/w4VPY8IKmAKhp1Fbk/qnGJ/Z0l1HBUW8typbmjnQe2ym8+Mv
X-Proofpoint-ORIG-GUID: xAsVWQJJHvTkyAcqCju_nWmpzbR9WjJu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130160

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

