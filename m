Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023130.outbound.protection.outlook.com [52.101.72.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38B492E2A;
	Mon, 28 Sep 2026 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588800; cv=fail; b=osIwc5tizkQcU2A4ytD/d3snnGbYgRX7JOhVZ7Je1Mm/lfXbncDQKKCli/GibBtc614RW02clHf+yi77wbCZLNnWZsc6RTAOdCikZsPg955CTWldREQl5ha+BzfC46T5dOyQfNz1zDJ3gIvnpQszEogmYd7zO5R1SMOlzVO7uNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588800; c=relaxed/simple;
	bh=nsa7j2hw36Mmv26JG8VNexH9lvOmDUDGr91uiN6MOow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0mkajt0AlkPIBYsexMvf4PmuzzyRl7S5Lo1ZyzlAIp3Eq3P98YSBGAj3RuVVcMXQFGnNbPu3IwrWelRFNgpNSDIsNaooeubUMOm4Vjpb66nNQKfXWg/4A2Hxf1D0QRbauPpE0BxOKZ0d8h+2WNR7DEG+ThLzGIP0vEcrJu2eKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=Bz69zX6u; arc=fail smtp.client-ip=52.101.72.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="Bz69zX6u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJGd69g9OFLt2KhsqMzY64KbsSPDPx4bL7E/U8nE+kZPe+RZi88nDYVh6UAW4UCl7ZO+c7sx8fBNYsJRO74Gh1w2aRnC3mddnR0BvfjA2SbiV+okGyV/QCtUIAClRp72eD6lgqyFEsPi0sakqDN8HcmGDLX2HswuTWaGK072HPmpaJdqLe3JNeNQx+Fc38bXaGwb8kmWUNU5vgK6Myiy0zQvyF5ny05uDP9PdM+vOZw5SxUifx6uRXfV3zK9q9tkArVKywaQgaALZheh5JChWm6xoWr/ByclKokmifwv6XFXPthuZjjio4RO8OMeCq6MIhnN+suAWGcFGXUvQaMbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/P83rFvKQd20/0T3KZslJ5nA3so+FACb0HPfBilsmY=;
 b=QXdAcF5NZKJwml9rTcaOjy4SH2yxr7p1ZwKL8SFl5lUxbpgjtcoOD5OiJuc42I4iCqXASXtksIc83RLD20lq7sPmFJpGQVDN23JevVH2z5h5vV+PuA3IE+m/qSEdhqiFqYNi/7P5LinPvxkyEVf+v+BEIPQ3Yum/aBsvkK1xK4fM2pSsuEo6B6bq7HAnz57tRGwlqwEeLWnmcZtTN08QvEmdde+UFrT9Efw1FHP6MvMlMlX4lXU4yZz+aHSRsPrnPFUxY5FhZ0BUlqQvwBvpueRXqYzdNLddSwd/5U2gs+WCbx7XsstKvIiDn5aO0Ioy4zmIuo+yigiLou85QF4URQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/P83rFvKQd20/0T3KZslJ5nA3so+FACb0HPfBilsmY=;
 b=Bz69zX6uhlO21gDHrahJJ26mQpsTdFioDCuV2ejwrYyIiaVqW4qSKyY5VLypNFWMt+agrwHuOFcCqJ0L5PRSV8zwFlEpSPXmzZO6YK089jVNfbrpvpFDSTDH3oX61E1oMTbdFxRSedsXPNW8B2gHHvskXkEqIcCd6AX5SbeuCMs=
Received: from GVZP280CA0050.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:271::15)
 by DU4PR02MB12079.eurprd02.prod.outlook.com (2603:10a6:10:62e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:46:32 +0000
Received: from WA1PEPF00009B3A.eurprd05.prod.outlook.com
 (2603:10a6:150:271:cafe::2b) by GVZP280CA0050.outlook.office365.com
 (2603:10a6:150:271::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 09:46:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 WA1PEPF00009B3A.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 09:46:31 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.102) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 28 Sep 2026 09:46:19 +0000
Received: from PR1P264CA0111.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::8)
 by GV2PR02MB419788.eurprd02.prod.outlook.com (2603:10a6:150:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:46:14 +0000
Received: from AM7PEPF00000055.EURPRD83.prod.outlook.com
 (2603:10a6:102:2cf:cafe::7d) by PR1P264CA0111.outlook.office365.com
 (2603:10a6:102:2cf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 09:46:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 178.15.18.66) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 178.15.18.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.15.18.66; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (178.15.18.66) by
 AM7PEPF00000055.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.496.3 via Frontend Transport; Mon, 28 Sep 2026 09:46:14 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 28 Sep
 2026 11:46:13 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, <david.laight.linux@gmail.com>,
	<Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL
Date: Mon, 28 Sep 2026 11:45:26 +0200
Message-ID: <20260928094527.3413351-2-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928094527.3413351-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260928094527.3413351-1-paultyson.mbewe@ziehl-abegg.de>
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
X-TM-AS-Result: No-10--22.781000-8.000000
X-TMASE-MatchedRID: xgjD+b8BcNEjT1OtLjNOO8FwCSR9lLGIA7zAJOd7U7GO46CtGFNzgB6x
	6GATv0yu33N9hXGm/eBrBIZaYgb6df713DZdglzA2fOmnfHgOUoKfUYWORZ3hY73XtTiMnCgOR9
	TNr9jiqpZz/xdoRU2o/GNtF37Q9hm0l0AwoUm6S0ftZuMZfm2SU9Xke28M87NCw80CQ95LdC0WV
	EGd9ktR/CiYQ9xUzmAYsRtQSiXxwevrjrl9OcF/dcjNr80SqOVgT7JgSKmNS/PxctgaqKz4WACf
	vAIOBO2kvfSBv8G5HjTWEuZKnxXM3kkrpVn/L8lju2XlcEx9HQta64Tt5lszJASM5lkTKECfDRR
	zBqJajaC4coG9a/q4eL95qFX87s3vYow2p/EmQJSU7TOghylToHV87ajhAZwVpazjfYi2Wy6dDg
	bOwQH7Hi2yHSIHoZsnbZX7Kshm6n9xFOSC4OKya39Nxr6In/3fH+EesxtKNVRCkSxJRCOByAtOk
	0TFyJTeNIWTzSSH53yHvs7OKapzNvUNTm/lfkGlEJO70qtU7ajg0lrtKMWyiT/9g75F2ivWjsaY
	I4lh3U7nRP0DvgcK7YURQHAp3zKlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.781000-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30224.004
X-TM-SNTS-SMTP: 3F89CB6A33B9F007D644A902114BF5708E525AC512F01AA78EBDD95BE15A15292000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM7PEPF00000055:EE_|GV2PR02MB419788:EE_|WA1PEPF00009B3A:EE_|DU4PR02MB12079:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d2fa9a-a2ee-41b5-44b1-08df1d456095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 fzHq9YnApnTuw++/TZMhvgFoNUDivB9UK+0SzAXtXKw3Gm6gD3G9xMTaPtNw60B8wdIsMMI6dy6/vROkVYgf9Wqf0flf3fatoJTI9JSZ1xdpS3BZTFkykiDVIGhEXNccy7PgQFYUFk/gyq0f4RBrASyFXY+juLb2nlQOBB+SAJ98oxfWxsl3wZrGPQeQvgRnqxmkkRPWbm6lkXrf33EXY5eVKUJ0W74H6ksuzUgHortyZgRbslNGXBmRzD8yrpleTlALH0BkSGvHSMJp7vgtnXrL27epwn4qpimLinL0q6NoDpxm9xSyO5sGjb644/i7rHGQr5vL7Q7Kim4fd9GoT8Ph9J3rv91A5Im9eZViItdTJNvAiqeGCD70R1yCxoe9l00KGN/AuIN7LgHyFZ4XEmYlvbqTaNVR+2ycAa/CrkrHcuNtyCvczttFxR73egVCVCPpB1nuJUyuYXL0GRp8DSEf4zAXO2rO60VviuGFLVJezyqvT7z24rYvf+b35AIjVmpDMoUs5G02Z7vcj1WkrkcWBYCXZLxz+nibnhqkDWyh+oiKfoONbNsjkCWhql907pdt2rBVK+9n7NozBWdLGZwsYZg0FjS/bRtnz/KpTdxyuQYHHNKbj/We41sKibI1679sBGuHFd8O7BfkDipmxfOfPRMlpkc0cbFbe7MZv2U=
X-Forefront-Antispam-Report-Untrusted:
 CIP:178.15.18.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: H+HnWjdwYNwBhPn7lMXWa8tsmL2JKH8Cp5UiydBPdmkwkDg4alCTdbkTd+LMCRxHworGLjCgYGjSRsP5snlct5bYnEEwyYHU7f6JxzE/KIUX0deXGoFQ3MxvZZfndzjY8AqP44nwwqHndDjSBgWf9HLO0NdePE3f5Lpa47TqyJdN9sEO25k8/4no6FpcWWHRPKRN0Mei8rXJIyqscWrhLnSi+ZeZ7fQmyhu5MpYZ/OPb/Nhl7/DZZmK/GW2v24xRPQaf2TDfdXtcmVbovebFekyQ/uckPwxaPNhD0bsHoXHOBCRsF2dkW995DemLZ4MEFMVFxvymaIjB9ombB6KzWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB419788
X-CodeTwo-MessageID: 7c9a734a-c0b2-4248-a4e6-a4f2421d3f99.20260928094619@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 WA1PEPF00009B3A.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dd149dc2-61c4-4e1c-47ba-08df1d455632
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|23010399003|36860700016|1800799024|376014|35042699022|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	U7IH95f2BcV3XOUH8f3HSL/VZZznqxpqwyBDDU1g0oH0HOs16fJWNyE4kw09w9+p53BUhEpvQZ6ILdnCYq+dUVqJ2IefD/ZWDqwCazyoo66EwjCJQzkYs7xyKR/+Cp1qNRzZYjnIyLxQ5R6yT1I/bzNw1J3Mty7+iG0+P7AXlrvPeuuoJjb/z1RSbk3VTbQZsRswxjoc6M64tQwvCccIc6d9Ot7BVaFgrXdaY5j5bz2gRyHDZjzO9jeq9jN/Wsv+aymChKJlc0UUXDRw8yGuVYEc/e/sbwfZYKqdt6UJRYyrVyAPyOcLuVmzMmIAaj6vHDW+TK5XcTsIvFc0ZeIcAFqCjKGnM9wEoEcdJG9hLn31jOo0VnCmroHI9fWzyixUXi08gJKRfmxCdBnjmxF0njVfFFOs/+T9u9atYarpPdlQW61cipIs52nF5CbwcBCydgefTJdTlxuF7/8MhU9uz9f7aFj2fLHzhqy6moCMftTafIYTG6au5NWYha4lHTObRb0piQGpVXSTRoALV1crxMHnNdKvhw2eA0hPelfVW0BNpE5vxmA4h0aVz1BXYfNmypMEgJ0vNJKR6z+ZeL9rvL+tdr/FJOzHU5BzoP9e49OnfD7/i7fn2mgMKQeU9tN13Bcwbr+Nn4w/nkAl+YLRdZqwpcS8eY79ka9g2Ydc9+c=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(23010399003)(36860700016)(1800799024)(376014)(35042699022)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CaR3rAaH+liaZbk9+EcTcxPkFJ2DER8f1ilnY9natbaWQsf9wQMPYXQSmskYK1+7zahQ/IPg/8j36/JdsPMGOCGyKVA/HE3QYTcJ9f2kDLrC+dYfTGvgwBnJuWKBAnY2kVXW8iaEKQGFmnbKEUgwqX5wi6E902tK6VIh7qV6V1yJQSoUhUOhnaq8pv66IKHH116X5GRqT2obNyc1LD0d6qxsrDIZ7dq4968dlcdPUWLOqU9FwhfU12DgHV6kOrHeOYADYMdezwM/eRVq+z0O4Ii9KJFyzbhC9JONtrfGvIiOmMrAyvj3nfLAgYLhboZImQkSjV5RXTJrNVjzaL4+52M+DrSp3UqN8AifbCHimtqsYfKf86XLv4f063th0aF4DL3cbDg1IeZYh8tcJjlMDdXaOmXhZwGiAkea42+UghSmSZKyG36rhY6/DBKytXmi
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:46:31.6861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d2fa9a-a2ee-41b5-44b1-08df1d456095
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB12079

sc16is7xx_handle_tx() reads TXLVL once and sizes the hardware TX FIFO
write from that value. TXLVL reports free space in the hardware TX FIFO.

On this SPI-backed path, hardirq/softirq activity, RT scheduling, and
waiting for synchronous SPI transfers can delay the refill while the UART
continues draining. The TXLVL value can therefore become stale before the
hardware TX FIFO write completes.

One failing ftrace with the default 8-free-space trigger showed:

  tx_start       txlvl=3D9  txlvl_read_us=3D580
  tx_pre_write   sent=3D9   pre_write_us=3D16
  tx_segment     sent=3D9   seg_us=3D364
  tx_post_write  txlvl_before=3D9 sent=3D9 txlvl_after=3D12 pending_after=
=3D29
                 post_gap_us=3D12 post_txlvl_us=3D130

The driver read 9 free spaces and wrote 9 bytes to the hardware TX FIFO,
but the post-write TXLVL read still reported 12 free spaces while 29 bytes
remained queued in the xmit kfifo. Even allowing for the post-write read
window, the hardware TX FIFO had not been filled below the 8-free-space
trigger, so no new threshold crossing was expected.

The captured failing samples had the same pattern: data remained queued
in the xmit kfifo while post-write TXLVL remained above the hardware
trigger. The hardware TX FIFO then drained empty before another refill
was requested, producing an unintended gap on the wire.

Fix this by re-reading TXLVL after each hardware TX FIFO write while data
remains queued in the xmit kfifo. If TXLVL is still at or above the
trigger, top up the hardware TX FIFO again. Stop when the xmit kfifo is
empty or a TXLVL read confirms that hardware TX FIFO free space is
strictly below the trigger.

Stopping when TXLVL was equal to the trigger still allowed TX gaps in the
tested workload. Continuing until TXLVL was strictly below the trigger
eliminated the observed gaps caused by stale-TXLVL under-fill.

Program the hardware TX trigger explicitly through TLR using the same
constant as the refill-loop threshold. This prevents the software refill
condition from diverging from the programmed hardware trigger.

Tested on SC16IS752 over 1 MHz SPI on an i.MX6ULL single-core
PREEMPT_RT system, transmitting RS-485 at 115200 baud 8N1 under
continuous Modbus RTU load.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
Link: https://lore.kernel.org/linux-serial/20260623112225.82386-3-paultyson=
.mbewe@ziehl-abegg.de/
Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
---
Changes in v2:
  - New patch arising from review of v1 patch 2
  - Added a fresh TXLVL read after each hardware TX FIFO write
  - Continue refilling until TXLVL is strictly below the trigger
  - Explicitly program the hardware trigger from the same constant used
    by the refill loop
  - Corrected the root cause from trigger-level margin to stale-TXLVL
    under-fill
  - Removed the max310x comparison

 drivers/tty/serial/sc16is7xx.c | 38 +++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index fa7805d2cde2..1f7e98c2b570 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -216,6 +216,8 @@
 #define SC16IS7XX_TLR_TX_TRIGGER(words)	((((words) / 4) & 0x0f) << 0)
 #define SC16IS7XX_TLR_RX_TRIGGER(words)	((((words) / 4) & 0x0f) << 4)
=20
+#define SC16IS7XX_TX_TRIGGER_LEVEL	8
+
 /* IOControl register bits (Only 75x/76x) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	BIT(0)   /* Enable input latching */
 #define SC16IS7XX_IOCONTROL_MODEM_A_BIT	BIT(1)   /* Enable GPIO[7:4] as mo=
dem A pins */
@@ -647,6 +649,21 @@ static void sc16is7xx_handle_rx(struct uart_port *port=
, unsigned int rxlen,
 	tty_flip_buffer_push(&port->state->port);
 }
=20
+static unsigned int sc16is7xx_txlvl(struct uart_port *port)
+{
+	unsigned int txlvl;
+
+	txlvl =3D sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
+	if (txlvl > SC16IS7XX_FIFO_SIZE) {
+		dev_err_ratelimited(port->dev,
+				    "chip reports %u free bytes in TX FIFO, but it only has %u\n",
+				    txlvl, SC16IS7XX_FIFO_SIZE);
+		return 0;
+	}
+
+	return txlvl;
+}
+
 static void sc16is7xx_handle_tx(struct uart_port *port)
 {
 	struct tty_port *tport =3D &port->state->port;
@@ -668,13 +685,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 	}
=20
 	/* Limit to space available in TX FIFO */
-	txlen =3D sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
-	if (txlen > SC16IS7XX_FIFO_SIZE) {
-		dev_err_ratelimited(port->dev,
-			"chip reports %d free bytes in TX fifo, but it only has %d",
-			txlen, SC16IS7XX_FIFO_SIZE);
-		txlen =3D 0;
-	}
+	txlen =3D sc16is7xx_txlvl(port);
=20
 	/* Handle circular buffer wrap-around by sending multiple segments */
 	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
@@ -687,7 +698,14 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
=20
 		sc16is7xx_fifo_write(port, tail, to_send);
 		uart_xmit_advance(port, to_send);
-		txlen -=3D to_send;
+
+		if (kfifo_is_empty(&tport->xmit_fifo))
+			break;
+
+		/* Refill below the trigger to enable the next THRI crossing. */
+		txlen =3D sc16is7xx_txlvl(port);
+		if (txlen < SC16IS7XX_TX_TRIGGER_LEVEL)
+			break;
 	}
=20
 	uart_port_lock_irqsave(port, &flags);
@@ -1139,6 +1157,10 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
=20
+	/* Sync hardware and software TX trigger levels */
+	sc16is7xx_port_write(port, SC16IS7XX_TLR_REG,
+			     SC16IS7XX_TLR_TX_TRIGGER(SC16IS7XX_TX_TRIGGER_LEVEL));
+
 	/* Disable TCR/TLR access */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, =
0);
=20
--=20
2.43.0
