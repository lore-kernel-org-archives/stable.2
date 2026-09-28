Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023114.outbound.protection.outlook.com [52.101.83.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0347F76D;
	Mon, 28 Sep 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585790; cv=fail; b=INUVmhFbWmwJAywH/fwQAERTQXgU+UEqZA6pEosaC4gns5j8OUloud73XDI1ZC3LAKT0x+GnV9uny6DKLmLI/xMPZ4V/aDUjc6ZbT0xqsJK4jA/EivlgiXTibRneRppO9FsJfH2q0St+Av2oaUnlhCR7V5+eKc+WlyWKsnshC6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585790; c=relaxed/simple;
	bh=S464YIw4m9Bo0zEOkrWsmGuz+wQka1iKhO/djdkFQlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d8+7l7PbvWQmkw7RYMd6HeiiBghYntLEKAUG3xnMFFIqkVzreHmPPOnmTtDulixAFXsbVt3SXC195mT0I7uw1BA+Q0EqwgSGQROoSu83GJVO4tMCc9/UVEBZJOo0xfPlQhHD9t/Qh3sH/AQwIbf8PXzytIN3Pf9YPsCHodYBH54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=jVDaw4Lf; arc=fail smtp.client-ip=52.101.83.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="jVDaw4Lf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoeDMh4NuRUNftK1GBe2P+GbNTBltJ3jZEoXPSVz548nS220iqtg/LeaoT61hmGwgo+9fCs14PLNS8bPSESP2hebnlBtpHlVrR5BLPqrEmKST0E4jgWMcqSWSyreyO448hkIOHzEuklz0arqUSawqelQSGluTqfWRa+DIaegAQUWTE6f9/X6rDvfv2zQTRI+gFb3wqi0rFlblGxW+u6H1RveQ9TfzeMv2K9h9PN0/2sJ8FSvWVCELzEfFVueZZeaO8h0Z5nRyw0ewWJI9TnAkYqDjJDtICcl67GpElvo6EFXwqcO/Vkbx8HjUgomD1CVpVhQEbSjNOP64GFVszF4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSIQvgk68ADZ6hnkXQ7gR6xxYu8W6UvZh80DzHSmimQ=;
 b=rUnQfZdPqvD1OK/8c/huUDcvZB/UgFWK+Y/N0AwsNuxEoFZrlCVacZBjsiZQCcACuN3CRowaFzS7wTLVoqhzWuQc/s00RycfvmPpaWXyL06SVxVBdfgeZUkLeQNea9Q7+hgQxRGGdOIiJmZsFdTIj/VpbMBjO7zAqIIvTM7Nm/DcLgknIog6n5snekUHPt0NBU2EST6SJA/D2GEpEPM9c9eU4i5P1Etiaobo51hqVmmLWwNvhU6hXAfyYDwwgyoueXxLgnCU/vVusXFxilpZP4UHZ7EyQyagl5dTHXsv0RL0u6BiGdVIwvpN0Sw5sOtG0x+Bpoq2DKZ17QE1TkgE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSIQvgk68ADZ6hnkXQ7gR6xxYu8W6UvZh80DzHSmimQ=;
 b=jVDaw4Lf2ZZm4BclEfQO0dOepe3BQ1Ho68Aj+XO8rWgRKJBGiTxgPQYJDHxzRNHlPQkEsS1/zozvSv0WLvv3JbbyCOWhMF99JdVNwmVcp9Eg1+TAHZOuPPs1iOVmtk0d0SdY3pvj6WaYNhZceVQ99JmavIjEahIQ3qlf+nAIV8o=
Received: from AS9P250CA0002.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::6)
 by AS8PR02MB9187.eurprd02.prod.outlook.com (2603:10a6:20b:5b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 08:56:20 +0000
Received: from AM7PEPF00000050.EURPRD83.prod.outlook.com
 (2603:10a6:20b:532:cafe::61) by AS9P250CA0002.outlook.office365.com
 (2603:10a6:20b:532::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 08:56:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 AM7PEPF00000050.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Mon, 28 Sep 2026 08:56:20 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.52) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 28 Sep 2026 08:56:18 +0000
Received: from OS6P279CA0059.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::16)
 by DBBPR02MB10770.eurprd02.prod.outlook.com (2603:10a6:10:532::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 08:56:13 +0000
Received: from CPH1EPF00000521.eurprd05.prod.outlook.com
 (2603:10a6:e10:31:cafe::5e) by OS6P279CA0059.outlook.office365.com
 (2603:10a6:e10:31::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 08:56:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 178.15.18.66) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 178.15.18.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.15.18.66; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (178.15.18.66) by
 CPH1EPF00000521.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 08:56:13 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 28 Sep
 2026 10:56:11 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
Date: Mon, 28 Sep 2026 10:55:59 +0200
Message-ID: <20260928085559.3341419-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX03.za.ziehl-abegg.de (10.1.201.107) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30224.004
X-TM-AS-Result: No-10--7.198600-8.000000
X-TMASE-MatchedRID: xm/AKV1+13TIEK13nCa2RdwK3aKXLlLAOteHVGUMZ+DlbwjdfEVENEBz
	kHVLTkBx4AQ6En/+N1aoPdIvr1LpWlL1WjDDWM9gwroDo7M6Ycy9TAVy0y48Gznirt1Adl4gSNz
	OYgASIP7DEdyTYYzGzQ2FPEakzVvqfJYE9GoWRJGxkiMlzRAr9kGoVfTbC+0PpK0cdqYqf3M46j
	ujf3NZ6MUonAf5mkE2gaDFHNp6hidigYd5ESghxvbi+YTr2htSEpRQcMr0mi6QpDFuPdGIG8Kkn
	/6EKqY6AJ+dkE5Z75Xpm4uj63ofZ7wCrakag8ujYBS4BO08ckOB37bQADgKr4CpIfHsTRJvxHtx
	9qt/1r+xQ8t+/wTTMuUTedInjF4ziRz4gknBIqAIjw+vaMoIm/zUKvBZSHFYEgg3cwDHl/2jYFS
	FiWs3onGDuy8y1qkuImxnQvgkai1WB15Xa8khtlmblT0sEa1ozzsqyMJb8JpZCp8ExgdxTMsDlZ
	ROI5+mJMs/b3X04Tc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.198600-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30224.004
X-TM-SNTS-SMTP: EE38A320CB9812DACB7A0571106706750F70BD986986C2348BFFD11D4105D58E2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	CPH1EPF00000521:EE_|DBBPR02MB10770:EE_|AM7PEPF00000050:EE_|AS8PR02MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df34d5f-c7fa-42f1-873d-08df1d3e5d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|13003099007|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 IN0gkqBw6jUxwb1v38AaH9mR1SDA8dL3nOqG3pMVqCRuJzKjzUj1HPFLgOkzXtoMmI6XZ1fnBT1l+vtnDrHPcFiHu8X6+NNenhKtREMy1ZtySBeNVyhRhWPYe71TLO6wxjzo+HIT26uXcFjyo0zqEqsjVakRz/gvQva2rPCnlPG475vidpBAsvkD50dJcPcduwLQ2wcjOmKOEa5ZmOcOUWj+2y7tC3SlzzR+T82IInmetJZiFNCokMnTvJAwAIB8ioR8WdtbPnIGDuT+/1qXrm/RTaKjG3MadSYeQfuSuH/qo31E6v+0lRN9qoRi9VEWDEp4Z8Ne6XS8snUZ+lu6aOyBKFz9BklawfYBkOqQ13eDAz4r0sqVTlO2J+DBZ96SObB/Gw2VFn1aqQptrOyExK4eMW+GfVb4YE0a1UBziSh0bNj1f7XIkOi/15XFl6SoP8Nz3Y1DuujRcL/ZlAkbwZvv9pumw/qUJ6kl26tnDyCfEPYZvenbcgbZX7cBY/qqQFrEXHNUWKMcW3Q4VrweIzNnM02Kod/XrTfL0HYd24NLUY1K7oNxHmSe/6DeVRnrBXjQf+1XMJIvtA2l6WWYcVFDD+nvJYXAvf56Jr2KCpGQvuQLYldicoKAMmZoYuXzFk4FX3iqXj6G+95UdqVZvkXWITUGT7Bl9Fm83qoBUc4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:178.15.18.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(13003099007)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: HKGBftR7Jx7zfPFZLgKGKixfZUc7rPNALx8IW3gts0Le0vNhg6CVEX/0iQCotkVv6cevhYzXxc39n0U3kH8HVlSv8DxYSNEk4DvV0SUddcauIW8zfDfVlgNWtFyPH1EKKwI+bzkgzpbz5gue9STvnaeWQUnmk1LW947Fr6OSSu2+EQO26vRdrpq73ptCtH9tbVPxYKynLhFFjnEGhTH1B/HOBNDZc6GZJuYM5CrwiOwAz19YnzYg7sluoHHjygW4k8HLUcIMUYpnjiGdmEZRT+fvzE/EmYKhKetp6cEpYc9u60WcIXBv4bwRENb41Yjbxf5HnD1pXxqEr2CqMxMtfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10770
X-CodeTwo-MessageID: 874cb772-03c9-431a-8a57-0ffa31776297.20260928085618@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM7PEPF00000050.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9bb412e0-7a5f-4755-e297-08df1d3e5924
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|14060799003|23010399003|1800799024|35042699022|82310400026|13003099007|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	tJhV0FTmG+eSAAbIWcYBfVNI5Vy+28bHRlZqmd7fHKimHPByBRN3IAWJxyltti+F80XWRwgGzb5/+zJTXRwZIpCvMFBpsQvz5CEjzItm7vjJWUaCo41/MHT6haYtize/7CZppsDlr4kEo4CPDNxcpPt64vAbN5RtJ7Fmb288iGKbo42cgDQVyI2vJnnt+1iFy/nmcG2Z22Oo66WIiy4ezQRvy5YYl3c7xXEtovoD10o4aVvSsm+GJnJFR1lg4x5Zcd4Yi0MWaGbtl7rBXCaNyjPjUPNgLHfDjKFLbMpd3f3WvApR0TE75TXVpG9x8t3lGz1Z24DbxQ+y/V+Fo35CiIv5gHnfGzTkOA8PiCg2dSayORxlfzZ/ZnM3BwMjooT2N9AyyOJxJGRBaTd0dOeibPcT4+wc7fj4tB9ov61QNizCd0/xdyzAZX/i9pawgS4YDMidfijno1aOfhNSjbVz9et9w9F7eS/MBQNr4GOMMC/NvTqtZ2XP7vjlV/TZl79QGc+XCBNPiePA1WbksBDYIDjPgCxnC/Dfvwk4YiuYD428qfy8Qll0V0r+lgg2EYyLP9Jw3Sx3mQ7sMbYWHgX15SIpCJlLGfoIklbGaYL9lt/EyjF61Bft2gZTx6PVwe0Po0cWJCVr1FXMDTby59QrdeABOZX9rO6mj8JhZJPOphg=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(14060799003)(23010399003)(1800799024)(35042699022)(82310400026)(13003099007)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dHqW36tbp2rBx7F/anQxcWLelLYFBsNSHon4l65SsDgQoMhG5e50ZQBYF4ft8atDlN3nDtEwPQvGuceQMKy1ZSn8BFmvudI3pOy+lYuhnConc/7fRC9r0vuybzX8tQdtniSDb7qDJczdcDk79VbOoBwCQnbmscl2R5u1m0jOdUDRC0k7XMSBdgQFGXjIUyVXi2QqVKLCBNwM04PP3snPwfdLcmfbjo/PU0FNL+QpKjGQj59NwQj5G65T9VTgloWy3AZG8Yy5tIGP7cLBpVASnh3eZq/tSfJW3b/Tfz7zfKsjycha6JX9hMII/cogrOlUz0MlRht0zJ166OPeP+FF9x6mzN4yiPko7YzI40bA0wyTmsWSb3LDIabNd/sWWkmTP4yv4I1XRVD0/TY9X7Oh8kc68xa1MeGwRO0J1sYcVmMsUGtA2KvQq5Rar5HHnVfQ
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:56:20.2620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df34d5f-c7fa-42f1-873d-08df1d3e5d7f
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000050.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9187

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
