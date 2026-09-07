Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDC379C22;
	Mon,  7 Sep 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776334; cv=none; b=r2ucGprGzmQi+jDg8dv9q1QiaJGJgAUCksV5mWGuLWPWNqD9cMvPc4D+glRTmeGZIGloR7LrUVzrt7rHBPicO59kU9UKCn8vZMKw+hQ0Zzubs9tYAsIRZpkx/kUTfqfnfI8fi/JEbNeLLXlrJRTUZlA2qk/vqWtOGJ63JR7IZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776334; c=relaxed/simple;
	bh=KAyCQdJzFzjqYUOhcD0oPKc3/rJgr9YdLJM+JH1GEkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP3bb1QM4SOpOh7cegTP111oGDo1we0Iu4cRgU0AOYWDFskoAu22kHBk9XZsiO10ZUaqFpH/FujGTwNNFBGQlqat/PFvc9zmlLElPsP8WbKiYvEdtbvjgLFBuwSG5WJoVgadhhhOMFeoaoMflGunhRnyQFTBeD34z4wzcXVcqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EIKueeFV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EIKueeFV"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879YaWL3717672;
	Mon, 7 Sep 2026 06:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3Lf7b
	6KXiIgjWP91CS7SgdoKU3dxg9cni7R+EoNCMsw=; b=EIKueeFVSat8z2OLAvay7
	sD84O3vmVZmTbBmine/hYoytwew2MC/tw2Rv6cPFSFOj41DBmwq8wjk+rqlZjdyR
	tOpNaTzpb+8rhPxzjn1sNPV8zbCOj+SS2IFNNEYX2PrEyM0Y4DgDTdN15F2GhNzp
	FAqPqtCq3Dg1NCkVEc83fOcuJ0jrt6kcdn+KsQpwcMkwNgdG1j74qAOLOS4GV36C
	PUSRh5Sx9lIuPHsVXAM6bVbf4+aMCRo339M1geRqYZm8nMmBQkbfAA73n2wUzw89
	zHSOPJsdDeSqfY7VfBsww2dxzxg17itTZ/wyGdFMT92Yvy4k0RUjFFDncmMxCCoY
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gh4dg4d7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 06:18:28 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 687AIQo7010530
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 06:18:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 7 Sep
 2026 06:18:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 06:18:26 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 687AI3Dd007412;
	Mon, 7 Sep 2026 06:18:21 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jakub
 Szczudlo <jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 1/4] iio: adc: ade9000: fix ADE9000 full-scale RMS and PCF codes
Date: Mon, 7 Sep 2026 13:16:18 +0300
Message-ID: <20260907101623.8730-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907101623.8730-1-antoniu.miclaus@analog.com>
References: <20260907101623.8730-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: OgbgRtMnkzkMcjuNLIeec3qnNqlCEkPf
X-Authority-Analysis: v=2.4 cv=f5N4wuyM c=1 sm=1 tr=0 ts=6a9e8f74 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=ViKl6yswhRTQ_48acFcA:9
X-Proofpoint-GUID: OgbgRtMnkzkMcjuNLIeec3qnNqlCEkPf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMiBTYWx0ZWRfX+clNOMwhLVoy
 lPbL0oa4TwBnX9MaIWddV6E6/fMcTbZVrR+/BuA77cCecZL8eWZkBGN/aVXUtrhNYCceTcc/Kif
 BvIl/GHR6V9afgTc1OZG8BxD4kjU26oUJlu3LDubdKYCtP2DaHu5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMiBTYWx0ZWRfX5MzV/EQumGoX
 hqk1EfppT4dE2gaRNYYui8L/8HBy6Mkq65KhW8rDqsEKxnU4cN47F1ZhOsnQJPzadRf6w+wlX3S
 s0HMq3m3J/+sv87epzevvgfAac2aWVaXt47EySKBogmOj8++stDnSnOd05GnTfS2a15z4xvR78Y
 NqPribjevfh28eZpKoUYDjLcYPKPuXqnCxtokbMW3O3aYRG3vpEcVbvbS9j+Nxr7HJi42elCaLS
 T8geM7eN/6ahoiYNgALacN7TCQNwPQymfJylwVD364IDIcssVN3Gt+gPQyluIs7WjYawkZfD6pz
 CC/Y+8eyXFAUBLSX1GS9EdYIo6CpeBreqSlN2nVAlZeaif5CSV72nU5aau/AxPu+jP5BH6yRvuL
 6ecWduaEj1Nm/jB5+c2atyYrbGH1LocpvAjqKzmMRb4i+0sBkNFdg3Yu9HEpQV/PpKoihM9G716
 fNjySh/wMHc6Hq3Uw+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070112

The ADE9000 chip_info uses full-scale codes that do not match the
datasheet. The RMS full-scale code was set to 52866837, which is the
ADE9078 value; per the ADE9000 datasheet the xRMS/xFRMS full-scale
reading is 52702092. The PCF full-scale code was set to 74770000, a
value that appears in no datasheet; the ADE9000 xI_PCF/xV_PCF full-scale
reading is 74532013.

Because the IIO scale of the RMS and PCF channels is reported as
1 / full_scale_codes, these wrong values make the affected current and
voltage channels read about 0.3% low on real hardware. The active power
(WATT) full-scale code was already correct and is left unchanged. These
are the same family-A values already used by the ADE9430.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Cc: stable@vger.kernel.org
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ade9000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index fd1362a98052..0f64bfb221da 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -677,9 +677,9 @@ static const struct ade9000_chip_info ade9000_chip_info = {
 	.name = "ade9000",
 	.channels = ade9000_channels,
 	.num_channels = ARRAY_SIZE(ade9000_channels),
-	.rms_full_scale_codes = 52866837,
+	.rms_full_scale_codes = 52702092,
 	.watt_full_scale_codes = 20694066,
-	.pcf_full_scale_codes = 74770000,
+	.pcf_full_scale_codes = 74532013,
 };
 
 static const struct ade9000_chip_info ade9078_chip_info = {
-- 
2.43.0

