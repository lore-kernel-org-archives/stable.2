Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023108.outbound.protection.outlook.com [40.107.162.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170E3803C3;
	Tue, 23 Jun 2026 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223337; cv=fail; b=OHELTOkpdLRAMBBauSuoqE1pAfa3GfgoPb03dlgU86HcbTCIHcJiJ5cgEYX4guhrEs6jetg0MEmN45qoWSOshILD33uSqLXKAhtCWgDDlucpVBjY0b0WithwoCHcC3Xh13fPNb8EoeBYPhLlFfrHIcq7h1ONWNzBBsUzGMEV0E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223337; c=relaxed/simple;
	bh=lvEh7Pl8cPcXd+fufBzsTZmn/Sgz23vrB3TQZXARF0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0AGPGJpkBXTxKvfYVo3AUMoC8yYSiDQTBNO7gIwIEMiME234tI9BRJnZ/eDn0kOOVLv3b53Jk8ZBmItHCqpryebuSIbDqORMf7EnljY4cOHkwFMeykUV+zHz6epf8tR6c6FM034wdRPm8m3n0LFBwW6aMdwPU33SYCbYlGd7u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=bev7hy4D; arc=fail smtp.client-ip=40.107.162.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="bev7hy4D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz5re/+aVyjRIqV/isHDmgiHK2kcIKak6dkJQRzeyO12doQFgS3tg4PjlVjH57F5UYhhGEd06skRQ8p5/+IB9gIk6nbZF5ACKr8dHRviIWqOUDtjQipsQh5eNKUiAspgyfG65WcVg14V0/a+OvfKWhPxpqZ7U3q8Ly3DN7brnUGAL9ri90Zih3BEXzBiiDfDVOXyY3qv2o76E6EZwsRzv+Boz4pOdzxsCKbCKiTWTmwFzP1UDF8qLniJ5m4G7OZ2YEA1FIy226E+NR5Akece1yEEPOHQhlX/25GCvFrca84JFxsg1x1a4NqKS36ymukReSg1yLga+t/nZHnsnD4+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvEh7Pl8cPcXd+fufBzsTZmn/Sgz23vrB3TQZXARF0g=;
 b=N79HXjW+wN03n93cZjK2LndWwlLXLRsOl5m/O37eYZmYIiiq/fiW+PUAi2j4z3sVAOVBaVDT+jgZmgoOi/etFXOUDdKPCFfJ3ggAu+Z7R9zDOYVZXpu34K0XKGX2Mc9fRmVrpM1EURCkpenB3TQz+k+LIcFOPt/U88nnj+3czt1I3Ngl1/1Q5TEmYr3qUs3lZkecRnh3jeeovagpReQdrt00RassbEDmgYp9GG1liaH7JzI/zoirO4ZsU+745Sutelqxg8I4Y5warS1Bwe2TDZdvJRa3iY8STe1OrsWrW7NlCjtJ6QYkPTIUO5lYd8lDTM+uEfuCCzdHpZdFPg216A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvEh7Pl8cPcXd+fufBzsTZmn/Sgz23vrB3TQZXARF0g=;
 b=bev7hy4DRDHO/mbwPrCjQsAFf/i+xoH7oBIWb7ylL5yONFkXmS5TCsP7JSYsKWAYyy1Ic3MkxUOnVCk1+BdNE3ybQM7c19/prlB0U9fiNo5DPzy4CU/It0rckk6PWd70shya3hfPX951oyg3SnZkjG4pCuX5pvWI0AUf1+7A6JY=
Received: from AM0P309CA0006.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::13)
 by DBBPR02MB10508.eurprd02.prod.outlook.com (2603:10a6:10:535::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 14:02:10 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::e) by AM0P309CA0006.outlook.office365.com
 (2603:10a6:20b:28f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.3 via Frontend Transport; Tue, 23
 Jun 2026 14:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 52.138.216.130 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.138.216.130;
 helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 14:02:10 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.69) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 23 Jun 2026 14:02:09 +0000
Received: from AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13)
 by DBBPR02MB10482.eurprd02.prod.outlook.com (2603:10a6:10:52c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 14:02:04 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::92) by AM0PR10CA0003.outlook.office365.com
 (2603:10a6:208:17c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 14:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 14:02:04 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 23 Jun
 2026 16:02:03 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <david.laight.linux@gmail.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>,
	<tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent underruns
Date: Tue, 23 Jun 2026 16:01:55 +0200
Message-ID: <20260623140155.13258-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623134536.24dca506@pumpkin>
References: <20260623134536.24dca506@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX04.za.ziehl-abegg.de (10.1.201.108) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30024.006
X-TM-AS-Result: No-10--5.456700-8.000000
X-TMASE-MatchedRID: zGP2F0O7j/txHKHpX0oMcrIyl8KAIcW/QinanBDzXgsa1Iq7e41rkTbg
	xjaO7eSabnKetJ56BoDg3LwHQOjOpacZiLWmzAWeGwz+ElW8loYl2xL4j2+PvPc8c/vfJy26rpc
	vzpnWNDWqSjAZXm+xdQFjXO4Zuh/Yh0GgNcfPVcMsDsHTZnsguE3xQHD213pVVc6oxg15iGYRLj
	qoJJt/9XwuCMDi78rn6cJ/6QfST1xxg7svMtapLrAdecdWQCzFy4offpx2osgdvJ5FXBr26iqPj
	kt+BdQJkhQkxSlr8zb6PUYfmQa33IVf4EIbU8RC
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.456700-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30024.006
X-TM-SNTS-SMTP: DDEBD63BF77FBC392D55F3C3325E0E467738DD4656FAE4C2DABAFFF9F80E8B0A2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS0EPF000001A9:EE_|DBBPR02MB10482:EE_|AMS0EPF000001AA:EE_|DBBPR02MB10508:EE_
X-MS-Office365-Filtering-Correlation-Id: f2334d1d-0dd8-4cab-7d0d-08ded13004c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 8W5De4bA6OlxV/M50sVI8XI5q9B2x50Aka1+S8IADNjt1CfSwUiQ5yXqm3FSc9XUwx9SdqIfX+UcefHhGRQ+qRTdWi6eTX8X3ocAmscB9d8Nz8piQHXtCkyvTGLkeSBbkWfNTGdtL+16wMxYxr6DO+DSRHNPXjLx9GUddBTOVjWMs5fJUzycZsoOXjK0TR0niVmQAutiNAt4XNMUYqQeAve0HumpES5Upp1NWVDwvoZ3HgH3f3gB42U1/oYcN1EicdfXOUCcCThM42airSgRzH27dKt3BwEkW3VPAvtI2fB7bJit9AB5Jym86kVovgwzuXraASpkP6mDpEEalE8+sR8ulNHlzcqIQZpN7pt3TxTMOfokxO5QFsxSz9iYyGn7wcRb+jediu5GJ6+LNaRUKbasjnv/hO/Esqa3D+CwHO/JVvnloXn82IdT6C5X5sj9PnoaRztjIs/vNlUsGXCEKQYQRYTmZoAxXP4jvlNvvAR1zoXhqKdbGn4ZAoQqpbf0uFc1SS7K9ncz3KVlhCO4e7gwTO+FPiC+u6GQqKMNzIo/LrC+IJxf8bHwqBNvvP96Q3Vh6dZaYuh8c2HsGkTIEpc96V3AlB7Ou26c1nwQz/BZ/+KBwYA/aHY4M/u8KSXbgvQI79+DNtCOtxkFHVe2mpxuL4Ezt1rYriUERHkotZ+MiHpmzgDC+jZ3xt1NvizY
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: rnVxjVdERLNtdyVeBA/C5TUuEWvE8KiohtH/wzeRQm8VbUHjYbm3n4u/7ISgEs6aIzhTGwSlo2sR69IkRD6rHiQ9Zrgu2n9pnMbVMAw7yhzed8UbaeZ0cHUolnSPvJbc32izAfUfH6/HBM9QB2L+Hcuhik2IJyxfQIcPZ5XExOw1MHwnhq15x0GTcgNCHV5AP3h11bwsQdE+RKTwVpv0jIpfdh0PQIuS68k2yx+KYX7r3hfkrtNn8wc8tsCMBhW9TIOIYLtsfEIVLq1FR4TSS9pgm1psSu5MzLO1xx+viGE+TF/CdZ37ruEXyZy4pah0fDMp9Wy12nF10MV2BFxJ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10482
X-CodeTwo-MessageID: e2f0ee1a-8c90-4dcb-8c87-b668000341eb.20260623140209@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	58a3b6b7-ea10-4668-8314-08ded130017e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fKXaYARt2ORASEY5n2cfREEj4z8c106la7owECyfW565HcdxE8odBFEvSf5Bz9Dwuuq7x5psmPKiiDHp9hOjMUcfAY/EEoHYilrCJW/oNDvNdrNBTuvzboHXu/d/tP8WXRluubPE1HobJwlk2TrQlzuNC7u0FxrtCww+Z6fJEY5u5zOcu1ZVCn/2Iy+AblcF12emuSLWtJm5qmH7vbefT4SjQfWAZegli0RJyR9SbUUhWZzqKt3ON/4Hq/VQ/q3F466QJVMqyoCwy+HGvoorFnfGElGVkFF2WbWO6h68OHzNOv5eDrEeqcdgkYvXYtXubWx7ZWhimhvdzCN8Xav0Qd335sFFYl9hmpptCChRcbFzXlyHSxoCaraf8QgclQ+1EIOKWe58APpFdCsCrg/ZvMCkZ87+5tPEqnFksihDuJtdo6VBNO6I2rENHzd++ip/SmM4dzJTuz4i7PaikBW+ovfSp3FXhPUd8dJkU4mYY9C1j1imT5p3GSEw3MtAerq1uVPJuEwK8yOSvmubY/9dVxrThLl4FxzC5nCviMV4cuSq+5lCn0VnYMXLb9sRaaTWrstUmmJZz13q38ZEqugbdkFdTDF5a5omiGgFlbK4ozowfpxcaIyMW8i/y2U7dGdeFq4ihYdH5n2ggEvCbWr1zVi9BOtbJCh2+FfUnzh4VN2ygVVn98YKVGpPUU+Mc3F0
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RgvGfsDy5nhVlKXPkgSezAygtsiJTzRUAWXwiXcoPZBTX6srPXOlB4is/eHPfyEhH7mVjTOAo8QlXiUyfCcL5M38ePl6lvWY58NuMhR3Tqwh1Lrrz8BfBSbgyM0G7TvV5WMphgYcSBq2zFBQaLo1vBEZLRJU77TsS+NSUXIHhWsr9UIXdnUfNrzdjPmCc3mtXmXXDSz/NJmZHwSUhLmESNGu5IEWKdiNBKSHnLC72KG5GJbC6mil2pQvppUPiTwPuQM7vxYOyKjxSbNX6LcsbZEQl0P6TEN6Vu4KVaqVmsGz7Z5cmu2pM7gxf638WFNp9ykUyCynUHmCA8mu5nZU6u20UZgd9HUWEW5m2J8Mfz91K5vmfnQW7yYkYjguhDqqdKVFWSSsZ+FpKa9a2LeULzJPh/EzmJkLb/dBTCebAq6kgK6Urm5B5tcg14ltVpwc
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:02:10.1205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2334d1d-0dd8-4cab-7d0d-08ded13004c8
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10508

Hi David,

Thanks for the detailed review.

According to the SC16IS7xx datasheet, the TX trigger level is defined
in terms of free FIFO spaces, not remaining data. So with the default
configuration (FCR[5:4] =3D 00), the THRI interrupt fires when the FIFO
has 8 free entries, i.e. when it still contains 56 bytes.

While this in theory leaves enough data in the FIFO, in practice the
system has to service many small refill cycles (~8 bytes per interrupt).
On slow SPI hosts, each cycle involves threaded interrupt handling and
multiple SPI transactions, and the cumulative latency plus scheduling
jitter can exceed the available margin between refills under load.

Increasing the trigger level to 32 free spaces reduces the number of
refill cycles significantly (from ~8 per FIFO load to ~2), and increases
the amount of data written per cycle. This reduces scheduling pressure
and, in practice, avoids the FIFO draining to empty between bursts.

The current commit message focuses too much on the "refill window" and
does not explain this aspect clearly. I can rephrase it to better
describe the interaction between trigger level, refill granularity and
system latency.

Thanks,
Paul
