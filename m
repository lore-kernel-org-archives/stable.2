Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023126.outbound.protection.outlook.com [52.101.83.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770824F85CB;
	Wed, 30 Sep 2026 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778786; cv=fail; b=cGZeNg2pWM+KWKvpJmHviZUUNBqMyA9bwPAgOWZwDHoCpOkeqJ5ykLA0rIX+h27rTC6SY9UeBsoN/sJiP2/yBZKS5yoLMjxc5QfJxz+TqWJxEhEYdRxggDld98ujtnjI/4BXUtZRrEvnsG0j1OOCr29qe8gl4gx0/hgrZnmO3GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778786; c=relaxed/simple;
	bh=LaFrgfl/UpwgQ9XWp449aC7jDGht//asKTbTJGcpcBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSWvAPn3+U6uVSmZRtvoSpjdtszWLIe884Drj2gAG0J3cYkBMK+XYM/Q/M/ElKhdRcNX5s74CE+2KCWY19p5pn2MapPMJOZo3BltcKS+c5PMxeY3ODaFkr0oG5gxo/cWxFBxb1PG1rB6lyRcNF+FSVH3k1B7zSQiZJzroSgFUUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=Q+dNXP1R; arc=fail smtp.client-ip=52.101.83.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="Q+dNXP1R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsrTo0ISqteuI8II2UJVm1U5FcPTAumOdzN+jDwFizRkgJEF4FHUEg6TpzoCHCoOq4A1BCH56dHhc1fEXJz/gQ1J/xfR3cvz6Afstvqi+lh4J6e2LJ1bRY1z+H9dgAnFklEUlXPK8r/Rnh7GrsajC2e7P06rva70y8/O77KD/OFTr6o8F04ATrMwgtQsw16sEvs784KHCcFLpFmBnJRWAczXIXVCzLcaKaPLKdl4TprMKcGKMXbKmVXkAcsGK1wHAkhLcREyct6bjrYTx4bh0Ya3KSxa6GS0V3oq8eZlyZRf8+QTc7BIvNt51l2CiE927cIWxJCnf8Dou1Q1OQTkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+mQPH+wldOP5OTU4U4S02nRYOQ0U1aepB6W5ABJ+v8=;
 b=c062b7ZCspe//rO+++zBSkVTM/2+Y22L6jHqsmITpY2XUnYekmygOTwX4xnoll4mt/yc2Bqo3fdvjRk7cIpbcP4SaXdaeZllac7S5nUI3VNP9q3raYKBosSBss3Bc9TcrSLMEYjA3xRHPcgBf4M0MuhlsqECHcdPJF2kTvJPJgN5nSK/zlMISxQrGaz6ES5Nme0Z9qBDFlGRmkeCnM9ZP2+sHCuUBJ5WRvMm8JP69X3njS1iApmgTLJJVfr/Cfp1e++WiAShYAKiHPiDBrKfOJM4d4v56rZTiS5Dlc30WEbJNEV3ZM0kqs4c5ccPStE08FEO0n8W3kAwIGMYKZzY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+mQPH+wldOP5OTU4U4S02nRYOQ0U1aepB6W5ABJ+v8=;
 b=Q+dNXP1Rt8jRFx/xuIZ59W9cyA8ZNYvlwbZRD0jJw7iQaAp9CZUKlodF/Wqs2Jw6eWLz6TAJ6TqqysNyk+aSXXpOMhtQTxB9u5kKYY2uymdO2C2qmneXYpMucDEH80mN3Or5g2d+AWgXYOIEEPlF8lrsvZ7lfOsni0irshWDtw0=
Received: from PAYP264CA0002.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::7)
 by DB9PR02MB8085.eurprd02.prod.outlook.com (2603:10a6:10:300::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 14:32:48 +0000
Received: from MI3PEPF0000855E.eurprd05.prod.outlook.com
 (2603:10a6:102:11e:cafe::9c) by PAYP264CA0002.outlook.office365.com
 (2603:10a6:102:11e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:32:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 MI3PEPF0000855E.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:32:47 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.70) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 30 Sep 2026 14:32:46 +0000
Received: from DU2PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:10:3b::21)
 by GV2PR02MB8723.eurprd02.prod.outlook.com (2603:10a6:150:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:32:27 +0000
Received: from MA3PEPF00000403.eurprd04.prod.outlook.com
 (2603:10a6:10:3b:cafe::49) by DU2PR04CA0016.outlook.office365.com
 (2603:10a6:10:3b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 14:32:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 178.15.18.66) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 178.15.18.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.15.18.66; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (178.15.18.66) by
 MA3PEPF00000403.mail.protection.outlook.com (10.167.241.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:32:27 +0000
Received: from vEX02.za.ziehl-abegg.de (10.1.201.106) by
 DEKUN-EX01.za.ziehl-abegg.de (10.1.200.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 16:32:21 +0200
Received: from localhost (10.1.200.37) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 30 Sep
 2026 16:32:20 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, <david.laight.linux@gmail.com>,
	<Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>, <stable@vger.kernel.org>
Subject: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
Date: Wed, 30 Sep 2026 16:32:07 +0200
Message-ID: <20260930143207.542930-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DEKUN-EX01.za.ziehl-abegg.de (10.1.200.169) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30228.007
X-TM-AS-Result: No-10--7.852600-8.000000
X-TMASE-MatchedRID: W8MMVQu10crIEK13nCa2RdwK3aKXLlLAOteHVGUMZ+DlbwjdfEVENEBz
	kHVLTkBx4AQ6En/+N1aoPdIvr1LpWlL1WjDDWM9gwroDo7M6Ycy9TAVy0y48Gznirt1Adl4gSNz
	OYgASIP7DEdyTYYzGzQ2FPEakzVvqfJYE9GoWRJGxkiMlzRAr9kGoVfTbC+0PpK0cdqYqf3M46j
	ujf3NZ6MUonAf5mkE2gaDFHNp6hidigYd5ESghxvbi+YTr2htSEpRQcMr0mi6QpDFuPdGIG8Kkn
	/6EKqY6AJ+dkE5Z75Xpm4uj63ofZwc3lNPNcuKv7ND4Jg1WJzJkrVIXZHd52CLQjDgKVqdpF+Ho
	ebVMgoqXSxBP5Vyu1QKHgUKFyxe5ErUTZibbWusZD7bjq+6lMGzY00haS8Qo2ubnxCjreJ+QCE1
	6wMewAEevSD5H6Ph6XAnTnuWOS2YYm4kJO8JPiWLK5A5md0r9rg4L214qcZ9kUp6L52G1+K6lWv
	16fBXNCtlseMB700p4i3RbjFwSVAPvYWsaPNl7S4W/MRhJ1X4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.852600-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30228.007
X-TM-SNTS-SMTP: 496EA56AED87105DA6F5646B52F3D0DCDAA0791D216D6D68CF234FB0859411CB2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	MA3PEPF00000403:EE_|GV2PR02MB8723:EE_|MI3PEPF0000855E:EE_|DB9PR02MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: e1793546-86b1-4152-a2ba-08df1effb32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|13003099007|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 8npYHBGJqloe2RHxoq/Cbc4/lCLHvejjSUCAgqlmINUZFx+jnjNwkbYD8H3UXa6omJ+3RSnSeRZ4cckD4BgQ5JpJ+LgFstszpboGV73OSoXcO5q9bzbBQdSrx9H0/71KLgxE0LnlXIuWKQXYtZmRnndAIIYdqlYCGHmHVj5TtpxJaPBKe/4ngnSn+T4yyN+jYurPxpdn+MvVBNYSQUo+Wi8t1dIzXaOHM7xXWnP8TKaJmy0nmG6ghDavNKVK+vbgrW1VGeZhfaJRIhGFIuBYC/cw1MN5gq2lDW/biVAvAnIOq1KKrK/YGet8tiw4NEINgEPcZ8IcvmWf1Hw+vsJX/nvQA5lfE2uN2GtSBhk2gpCyJB4CHeAIGB04923y8P/PKKkYWSaUo9MhRsodWlwwe80IOFl53nSf0WT6Wy/hN+w5yLnvgh2m0yZWde10tsGlsBK/0lOSnpsg2bsGTstR04H7aoNaZ6saxOAAJaIbwjYTFSNIIasR3rT9otpZLx0zKe88Ven7mUxdpdmS7NbviweKV98a74HZaJ5OVnCADvMVM9nFLNB0EV23zVuQDLiwPj1oPF1FuPHbnLl5h5vvzH/Jl4CDp6dLcRH2MAq0s3nRiUU5mQIGzVswMjiOHNXTFS+b9IoLWT+leXfNruZG5NCnVOPE0v7IYYAos9V3hcY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:178.15.18.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: 5oA5viQ3/NDMms0xvBnPFkaO4yOzl90HMT2TFA+5lGGRVlbRJHHgVv9W6SezV6ZXHBVs/yqMxLWN5V1DMP3Pvol7wEC5HG8yGLQ4X4Lgle4B+PcssGUwqjhUwQ28hhh4GLr9ATH3KC5kaB8L93+TCF1E3rgUTyMzrYr7vVL2SdoRWoWTktHqDElQil61cfEyvCfpjfjNDmt7qmTCLS+W+gmxVt47F/DFiSUJXWEy42QoOmVaAey6dynsnbghU4vNFKlCWhBWdKn3xHOwRrfb6fP08C1y88hi8fXiNuGaHyMUEQW9TzRmVABZQInZIFDr/o8HdEwxExnq6HQdMbgrCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8723
X-CodeTwo-MessageID: 6c495f71-3cec-4b87-af47-4fc8b01dbbff.20260930143246@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF0000855E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	887d2585-04d0-49b7-2499-08df1effa6bf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|23010399003|36860700016|1800799024|35042699022|376014|10067099003|3023799007|6133799003|56012099006|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	FYdKK/7cAzMVGltHVC5nTBFrGrz0xpt5obHXQmoSP7CYJif9wqBdyvA06fOgbk0Xw6jxC9Iu3Mj6+r9acrjwBEK5GXQ/CXJ6xZnOufP5oaWze0zPhET2GvXJnUkZXHJ1o0zc0y77gZGsfHMMMN8kMUdVMBdsogVsNZCWVyLAMIR+Cebpv1VWJ4u7foLrLuRtzrQKFOtnrTUT+8o+A0Jz6xoMa/YCYb17vZ2STXKJWYc8eKMUxA4FMMvaOTiYgJXr+owNAvybR1vy71/QpeRfPpsFL+8gEIzOJhrGmG/69998vFdN1LMt11+OtwlnxEsb5m4aSUskRXlAmToN6rXxFimQxA+J3ezhD6Nwdnk+EANqexQnc18u3bAQ7TdFi+FxB/YCwNqQk6DOjzZNiJtanl/VGzO31SZ+l1XqonyQa3+7wIQFprsGW5LoYsHq4tHfeljm3sXuplBE4K3ExiyMqMjim27MZ+UJJmaIc1YA+tm/WlhIEF+S60fDsT2eZxb9KdctuhowvURxVsHnOvJT6ShD5fcwk6yn7WQPm+BhkchttN+16WlAxYyp3wLKdsLfrrHhzcxKyUjW0LnL9twvRZWcdzErtPPgr5zRo036xeEfZttiQjlUwrJpNS9xk5/BiyX0DYAMwaDBnCuMzXbT3cJbV8BjWJ/VeUOOsvlFeos=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(23010399003)(36860700016)(1800799024)(35042699022)(376014)(10067099003)(3023799007)(6133799003)(56012099006)(18002099003)(11063799006)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TocPAP6gmrXkHMejlDXVHwl+sSqMkLApEFO9Ld6sEPZCt1RTuuZsv6R7iOwIWMQgdG5OkmuGAjvbCY96qmvR+f6kF0xKrbhT8YhHHrDw/BuqP7rNBnemkXI2H0wg7Im+pXPc5Or1TTbrfMl2O2kxdWcw8irQjrEXGIWRpBKOrUMaoBWLynQAfjGj3mH84c7lViGkEuInd2DSIqUmo0vbKJsY9bzEuLNhZo5y844HLiq3E5YHVRx61dduGmKdiw/eVcYwwXJ2ClKd+myJgdU3nfJU9PbJSMSscOsCANsvWiq3xC/5VVUA5er69UpiYNxBsSvcKnwvbfei3zehLAZnVI9N5oefZ/sZCb+123/7ffA4teNGN8aBJjAzgwqeE6h1b0gxC5VEiMijuPDyRccsgEK0ejeSaJeknix9f4L7e6gfbr5Uh0/S8sXpwEF11PjB
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:32:47.7678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1793546-86b1-4152-a2ba-08df1effb32b
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000855E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8085

kfifo_out_linear_ptr() returns only one contiguous linear segment of the
xmit kfifo. When transmit data wraps around the end of the kfifo, only
the first segment up to the buffer end is sent. The remaining data at
the start of the kfifo is not sent until the next TX interrupt fires,
resulting in a visible mid-frame TX gap on the wire.

The resulting gap is unintended: data remains queued in the xmit kfifo,
but the hardware TX FIFO drains empty before the remaining segment is
sent. Such gaps can break timing-sensitive serial protocols such as
Modbus RTU.

Modbus RTU requires a message to be transmitted as a continuous stream.
For baud rates above 19200, the Modbus Serial Line guide recommends a
fixed 750 us inter-character timeout. On the tested 115200-baud system,
oscilloscope measurements showed mid-frame gaps exceeding that value.
Receivers using the recommended timeout may therefore discard the
incomplete message.

The incomplete transfer also causes unnecessary TX interrupts: instead
of using all available hardware TX FIFO space in one go, the driver
requires an extra interrupt to send the remaining segment after the
wrap.

After the tty xmit buffer was converted to a kfifo, the driver used
uart_fifo_out() to copy data into a linear staging buffer, allowing a
transfer to span the kfifo wrap-around boundary. Commit 133f4c00b8b2
("serial: sc16is7xx: fix TX fifo corruption") replaced uart_fifo_out()
with a single kfifo_out_linear_ptr() call to remove the shared TX/RX
buffer. Since kfifo_out_linear_ptr() exposes only one contiguous
segment, that change lost the wrap-around handling.

Fix this by calling kfifo_out_linear_ptr() in a loop, advancing through
all contiguous segments until the available hardware TX FIFO space is
exhausted or the xmit kfifo is empty.

This fixes the kfifo wrap-around gap independently of the stale-TXLVL
refill issue.

Tested on SC16IS752 over SPI driving RS-485 at 115200 baud 8N1 on an
i.MX6ULL-based board. Oscilloscope measurements confirmed mid-frame
breaks at the kfifo wrap-around boundary before the fix; no such breaks
were observed afterward.

Fixes: 133f4c00b8b2 ("serial: sc16is7xx: fix TX fifo corruption")
Cc: stable@vger.kernel.org
Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
Link: https://lore.kernel.org/linux-serial/20260623112225.82386-2-paultyson=
.mbewe@ziehl-abegg.de/
Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
---
Resent after fixing the mail configuration so that all CC'd reviewers recei=
ve
an unmodified plain-text copy of the patch. No patch changes since v2.

Changes in v2:
  - Corrected the Modbus RTU timing description for baud rates above 19200
  - Distinguished the xmit kfifo from the hardware TX FIFO
  - Clarified that this fixes one independent TX gap source
  - Corrected the introducing-commit history for direct kfifo access
  - Removed the max310x comparison
  - Addressed Hugo Villeneuve's review: clarified that multiple segments
    are sent, scoped tail to the loop, and added the requested blank line

 drivers/tty/serial/sc16is7xx.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 7107a0fb1e7b..fa7805d2cde2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -652,7 +652,6 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 	struct tty_port *tport =3D &port->state->port;
 	unsigned long flags;
 	unsigned int txlen;
-	unsigned char *tail;
=20
 	if (unlikely(port->x_char)) {
 		sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
@@ -677,9 +676,19 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 		txlen =3D 0;
 	}
=20
-	txlen =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
-	sc16is7xx_fifo_write(port, tail, txlen);
-	uart_xmit_advance(port, txlen);
+	/* Handle circular buffer wrap-around by sending multiple segments */
+	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
+		unsigned char *tail;
+		unsigned int to_send;
+
+		to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
+		if (!to_send)
+			break;
+
+		sc16is7xx_fifo_write(port, tail, to_send);
+		uart_xmit_advance(port, to_send);
+		txlen -=3D to_send;
+	}
=20
 	uart_port_lock_irqsave(port, &flags);
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
--=20
2.43.0
