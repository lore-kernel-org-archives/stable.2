Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ECF39A07C
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178961; cv=fail; b=Xsuv9SsuQkPPK0fuhDQHJgUPVOPg2gRmJN1720vaMQSS2mSAGJyB8z0d1Hkerg62B12NnzC67nlY1Vvb7Uqe7XMpVgy+ODe8YeYyDun7fjFmgs0X4H3O4VdPSedtRSndhNAebBp0grB3kQItS9uJrRgsWEK6uamVzh5EtUMQQqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178961; c=relaxed/simple;
	bh=5xN/DbxC3yTG8LIfF5uRno24t4EFs6Avj6BAkMcfAys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qupXBMpcsUDQcpjRbf7FqPJY771U+ossSz2dAxFM04hohrCy0acHQJJS8AYQTXeDyGB55t0ypm+38qwJ4WgcNGRA35q0c/CNX5fuQgLkBM8hlAFyXEdlE/oA5octnI0164HBiLJmD2WqJo6hdHVS8V8Ffu5bjJbi3GXAg8rCqUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gP8Xc6Bj; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WEcu1V2a; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gP8Xc6Bj";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WEcu1V2a"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NF7gOZ2273044;
	Wed, 23 Sep 2026 10:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=gHjvkJ/KKdXkRBZR
	i8fKRkMjA0qZR6TvAhyyHKFz50o=; b=gP8Xc6Bj01iFNoqWtz35zetMp61zwTI9
	8ClLfewzzIW1/chrrZCDmGgWIAr5mf0Wa/OBx5kSHNyJeAEJ26TZIOvL889PBZEh
	a8eETvwKkEUOFYJ9i2tnqeRA35qUDC+jLmKEaMip9t1OZLcL4QWec8Gq7Jr5Rayk
	58U/ZMIdV/SGz3tITqEG5mz76dgX3nVB5yy703ygNl3K6fZhSErjgm3sbT9IwvzT
	zq7YXll3kSF+mUTusT15bc4pwLiQ5J0301WGRQkJHkEqCxx7IaDUX+ue6gf8Ee+9
	MQ5U1xQiRqQ+7QlziJfwjCR7220leJ8iFW3PX5Mqs83QhCD1CbEwuA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021096.outbound.protection.outlook.com [52.101.57.96])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gsptj5q2a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 10:55:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDD1dQn9bUjceZcqwJbYdRp7r5gwLEihLaYyak1KDs6OVsNHWR034h3YOlZaVHKiHJqpkE7ywx0ivLbTGdgnyVD9E1x9VSLAYNmwqqelRdriiXYpeRLdqf0XnkhJwE9tyeLlUyFiePJDSDf6DwHG92ySxemFNhwa9FlT2JYcGiahzdraAGzQnN2EgTC7jQh8WkH3lfcKdFAbONDCSm6ELwuflh/2UrfZ7TZRgqozNAhAOR1B3kSIMR8k7iLQT/ZrOfJnyGoSby3+xoR1gs9h1QYHzDiro0i1sAgaIPaTlVoHEFRbwka9/sjnfTDBmVeIrK9FIEsBXtRcBBIwY/J+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHjvkJ/KKdXkRBZRi8fKRkMjA0qZR6TvAhyyHKFz50o=;
 b=Ilj92ZfUg8K4Hs3uKaIpWMhHU0FJz5cAb+namjUy1CvtCBmUxUL3JlRC8mN5kFdTDqeKcD/Kx69+fVIsCiwhkFlKGVseqCYj1RN7EKpUnm4Npyk/oqGIoq8yc7kX7bs26RG0+tnEb9AI1J8/tZLJ1AkudAfU+csmaZqJlNdIVz5+H0jRRfGAIbBeLlOTamBFES9LPKPRos+KzwsflIuR2T469dSAx8NQAbhkoB2j1i4zSRuaj7OxQx8zW+fueNa6AETezn5VTB/Fs0msFl/KF5LAGwkskwzLYi6UJuG2Nv0GvzMuCkGn1o+z84RFDwL/zZRD3Pckz4Ewb/9RUDdiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHjvkJ/KKdXkRBZRi8fKRkMjA0qZR6TvAhyyHKFz50o=;
 b=WEcu1V2azIXo5OLnOnZw61/oWObKyRSPyEZQ5DFfmzX/mrCZyYroG0yGRwycdTW1QKDx6i8haVJdYJShzxGT1wVZyfT9ulnDTlRD8ttS/78hjv7f/45KgcCYvxXIu8vZFUe1LoR24Qetsf8QbxJznW2ccEoZ/jvwLG6wlbXFxAM=
Received: from CH2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:4e::29)
 by CH0PR19MB5283.namprd19.prod.outlook.com (2603:10b6:610:f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 15:55:39 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::21) by CH2PR02CA0019.outlook.office365.com
 (2603:10b6:610:4e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Wed,
 23 Sep 2026 15:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Wed, 23 Sep 2026 15:55:38 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4040E406541;
	Wed, 23 Sep 2026 15:55:37 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.12])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 28D3182254F;
	Wed, 23 Sep 2026 15:55:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: stable@vger.kernel.org
Cc: vkoul@kernel.org, broonie@kernel.org, patches@opensource.cirrus.com
Subject: [PATCH RESEND] soundwire: bus_type: Create IRQ mapping before calling driver probe()
Date: Wed, 23 Sep 2026 16:55:31 +0100
Message-ID: <20260923155531.2195255-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH0PR19MB5283:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 31a90ec8-285d-44f0-b194-08df198b1d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|61400799027|23010399003|16102099003|18002099003|13003099007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9NYiSL0e57VPabhQUEZFCtq485Qea+fidg1o6BC0pUN7OPKI/IjLWIWmVTBn3307SRMHAiaYwUJ8qfhGJcTiGO6QYcvMeUQAXSYUOSFAMoi6ne2+/YGTKVC2Kg3t4F3RQI45qgNQz7x1AXJOg3tC0FFAN02BanGxKmtZpBcwDug9s7DVtGm0FqKQYkqx5FPbOVEfGN+LOTk4ZQJ4d73/G5MLLQKk1DmUAKc6eucF/dDywttNLHHBCpPX1mfqU3QmjaZ2vZKNBz34HHBcaC0H4jDTqgm0ENW+/ZHXKRx45hoFCirYNDVxtCYt9Urhx7ax1npimtSCCwBgteT1ZV1xu0D6ZQtaUEFpohv+mkXG7b6Gfh6fC68IRBx9OgKNjDX8K/1uxZgkbVT5b8PGtQzbtzroLMaih45lk1tV/LYNuyp40nVpM7jjjGZktSspLjGEiMyPlpgtu0mgxVjoBeGxF9sdl1lV1AQG2FH5FZDw5OUBP79elnah07MiNEdCHHX312VFRCxlRXRLCSxZI3M8pgqjZO9jpp3rw+BD1MVpa7IXzAB9K1qqjLoaukPzyXX66+rBXXXAryP+BAFK/mkQBnWlLmlqWQInBgxKswqJhsruequ3045m0Fso/tBsPTcTSIYSCJ45Jtc0cOI+P7Ju9w==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(61400799027)(23010399003)(16102099003)(18002099003)(13003099007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EgexwAerPgnwR7EASc4TYEmKfYzimJND11E/0GGamWK3DEhh/7RLjvDHcNs9BTQ1CqixLQUoHKNvDONkDRNmv8oPEXzd8TT28qmH7fTZNauCwQy/IgdadMlOcHD13hvCkJ4ywgV1FfMWJHeoVHZWYQdDdX36eW38q7vUksG3R7Wjz63CIsvTZc4/YwZMzMFqtSsgUJjXkmtOytnq1aAbafBvasyhF2sYctrQIJ3mQ3mDE9G8ZOVtkQqN19T7sjIgId5JjpDnsQe1CADBcEif4s9Q2ukxrw8zWAjvcrVuj7Rh9oLRnv2A4757E40ZDuUC36x4sgVolPywwWP3G7vmwLJm0NlE9tHCDlVItSrhfGiqo8dJ8u1dZw0msR4EvDDd2iuJ+MThDiFUaiWcExTbGJxmiTDxBahXv2HNIHw5WHyIkSsJX3/cXAWaM7jze3KI
X-Exchange-RoutingPolicyChecked:
	htu+TAoRCecchQ9Q0N7ZxaDMZVhcVbCWHLOxki7bl/mAkYSSOTrJqA8KFcwZ3MM9Qy2EfcKPzTiB2Z4XNDwO5AQny57nlHLUMtlBes5dlZ4N1372DcfBa29eXCzZ+61B51cDj45JYyYSVOzIWodUI+ddQtSNBEJtCZrHARShN3MB3F621yuY9o5c58Fvglkkk8Fe634mK+bXTKLRSmMOnMOMEnaArftJoGpneI3JNOIIk0KidqQygPihMr18jKI+aopqgsoOCh1+qv+1DXSOaEG/R0ArjbDMKeoOtrhrL5lUJ7AidkUe1fTn2/IZgHze+u+hYH1yBSMVJrdvBlyk2w==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:55:38.6580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a90ec8-285d-44f0-b194-08df198b1d14
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB5283
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX94Q+b5rIeLLk
 dG8aq85rV/A0qudtCC0dTBi+ybaDHiUsxvMSB5pJ1YYLdn0L63VyVC9m/ogrSF6ajQxMpvE+NzN
 wY4Qm3y4xRn0lQEj1kIK4UXffhufXDA=
X-Authority-Analysis: v=2.4 cv=fuZJ914f c=1 sm=1 tr=0 ts=6ab3f681 cx=c_pps
 a=YSKqEZ2efjUEYtK1eN1cHw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=bC-a23v3AAAA:8 a=w1d2syhTAAAA:8 a=VwQbUJbxAAAA:8 a=lJT6-VWALbPN8-qIYjgA:9
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: LaOPZ5ope9DwGyFPAnZ9D3YwXAGkwl_m
X-Proofpoint-ORIG-GUID: LaOPZ5ope9DwGyFPAnZ9D3YwXAGkwl_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX3HgUVzxkWyYI
 j626ALb0QCRCYiZ+G+IemaCDfauNFF4/WjnfFCZCewDOUMU6sW9RART7leDX5bGJ2puYMKpxSLI
 ADXoFs6PnBFEig6Cn35XKQvRurDTpMa5kMhy7qjrWsV4FPwt/0K0rIRncHLLPdNgVa0EHDZ5mIv
 jAW0LfFPYgJvTcitPYangoEe1ME3Y9oZOeREinzRckg2xr8aPCivXZ49cU3fpQqZ6BzuXOyCqEs
 YTAniLOmkMftPHAyQBk+VoCsIYGz0xqaCjw3zT/y7myJXmmClxMJH9jGZEmXuBqR4ZTkxw6WfhF
 EE2W0Z7TAF/oh6X1OuT0V0RjFWXF7emG4u33xzClGnpy6FtSG4QI3F/8j5R56pypvhpwOK/lcMW
 pdTlWBpbpNjE93ahk83SnWgxNqqCMI8888FtYQm0Sm4M+FCcnQh+4Sr8+pvyJhecCtfqB8cveiE
 A1JwaXrcK9D4S6UEBfg==
X-Proofpoint-Spam-Reason: safe

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit ee1811eacdbba15a374957c2bcc6ba7102e2b781 ]

Call sdw_irq_create_mapping() before calling the peripheral driver
probe() so that it is possible to request the IRQ during probe().

Previously creation of the mapping was conditional on the use_domain_irq
flag in the driver properties. But these are filled in after probe(),
which meant it wasn't possible to request the IRQ during probe(). This
was ok for MFD drivers where only children requested the IRQ. But for
normal drivers it led to the non-standard behavior of having to defer
requesting the IRQ until after probe().

CC: stable@vger.kernel.org # 7.2
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Link: https://patch.msgid.link/20260810104045.60701-4-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Backporting this to fix a race in the SDCA class driver. The SDCA class
driver probe kicks off a work item that will request the SDCA IRQ, as
the code here registered the IRQ after the call to probe, there is a
race resulting in the SDCA class driver not getting its IRQ if the work
runs before the core call to sdw_irq_create_mapping().

This seems to be showing up on a few laptops on 7.2 so would be really
nice to get this into stable to stem those reports a little.

Thanks,
Charles

 drivers/soundwire/bus_type.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index e73c1bea90593..d61a97c5b41ef 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -105,6 +105,9 @@ static int sdw_bus_probe(struct device *dev)
 	}
 	slave->index = ret;
 
+	/* Create IRQ mapping now so the driver can get it in probe() */
+	sdw_irq_create_mapping(slave);
+
 	ret = drv->probe(slave, id);
 	if (ret) {
 		ida_free(&slave->bus->slave_ida, slave->index);
@@ -117,9 +120,6 @@ static int sdw_bus_probe(struct device *dev)
 	if (drv->ops && drv->ops->read_prop)
 		drv->ops->read_prop(slave);
 
-	if (slave->prop.use_domain_irq)
-		sdw_irq_create_mapping(slave);
-
 	/* init the dynamic sysfs attributes we need */
 	ret = sdw_slave_sysfs_dpn_init(slave);
 	if (ret < 0)
-- 
2.47.3

