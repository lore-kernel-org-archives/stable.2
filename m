Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022109.outbound.protection.outlook.com [52.101.66.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58003D3CEA;
	Tue, 23 Jun 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213837; cv=fail; b=UHzigdjF+C0wasivDNOUu0EOC5o5c2hQX6r8PRhcWEAg+wuWYut8y6vatL2FRVIFtHhZHX9YOAYcnUA7EVxDgl4OFZ2pzlAq7QpRl1DXa1km8b11vDTBMUiUz4DByxcKBcMQ0wEwk8J/Bl4c5r2Klg1ahDQfYRzgGguFzmJwoec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213837; c=relaxed/simple;
	bh=Q0hmXLQEj/kmGWT0/bLPgfxY+1n+BLXkySRSEsh3S7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5059X2UqvSZL5k9xz+cTFYdTLoZc3RnRodnQ3SnX6DcP89OAmK6jTUL88dlqVcOD0tfG3A9kbk0B+JarU3xADN9t1vrCPa+m+EwiAeAyf+Wgbq2xBO/ObJw9Rwi1aHi2rXJM8AXxyDU4N5Pbp3wG+uDtY3FzwV57oC2c+8KqPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=RlZkGNSa; arc=fail smtp.client-ip=52.101.66.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="RlZkGNSa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnl2hPmlPgHDyEIy2MflL0CNuojXk4W5emtAMzTLmp2uMB4+7zXWmuWT83OAubUJaUOL9TMtZojRf9StKs5nNSSvAEmzIH/SQ7GPCKo3JABDAWzavZLX7W1dgagHirxn1WSvL5S2vrZtBi9ZlnLJ9w5haw3V8LvQVRrCzrs3nwpZs6CbeskQR5rSmzS4Fgv11/ykcVtfC0oT+5IQTJ9I+NOmHIZ+YV7DC4C4tCSmSW2sOD7uc1FczHSzGWTI/OYM2ct4ymUpC9+t6YjAFCsrl4aYbO17btstd9Ly7BnvR8aobPsNzM+8gGulD8apzjcjbCnxXB7MAb2y0xHP9B9nbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaZAMQMHyAqLlHABN23P+XeQj+DmC7/C9UYdZFOWjxE=;
 b=xJ6OiYJGRy7YSiZxFdz+c+YgyRqW7XsFnOl2/ty8ol56xKpfwwca8yIDRg3eFJHjUtd8ecakwKe4m7nXxqaPLCUV2hRufhAhOk3xsNm8icm2nmHxhTWqw57G4EsVEJKuC9r6Ggq6tdMvUz34FxTOuCmONvmbIYrJ7VuKfSod6yoYFaTQRY+NQycWqIZvoRsosL1UEstjrs8lohE5TTgcPThmeI3HbCwfykY7OmTcYibOIqEgZAjtg+GuTtVuREU/B2ovM/iExfUx1bbCVoZtTaLWIyTQZyG/Ixw3BOFCjHvrEe/9YofSXbh7lQuJHieZdeAzqC3dlxGt/tLquSmVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaZAMQMHyAqLlHABN23P+XeQj+DmC7/C9UYdZFOWjxE=;
 b=RlZkGNSaE+bq0Ip5ofZaTzUhwyRlGSR1sTH143kgJ4bNmuTKAfD1QvXkOidssfDhg7ElDDVhC3s3eEsmXClZ/0Xnm1zBHJPQoD79Zank1bTqT7ElYt2SC9PMKy3V87kSY+2HVVFf7TiDpWTYORDZGQyFLrHHy/wt7bVuEyRB918=
Received: from DU7P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::6) by
 GV2PR02MB11852.eurprd02.prod.outlook.com (2603:10a6:150:351::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 11:23:49 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::41) by DU7P189CA0006.outlook.office365.com
 (2603:10a6:10:552::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 11:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 52.138.216.130 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.138.216.130;
 helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:23:49 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.97) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 23 Jun 2026 11:23:48 +0000
Received: from PR1P264CA0072.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cc::14)
 by PA1PPFF94441E0E.eurprd02.prod.outlook.com (2603:10a6:108:1::266) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 11:23:41 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:2cc:cafe::92) by PR1P264CA0072.outlook.office365.com
 (2603:10a6:102:2cc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 11:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.6.247.99)
 smtp.mailfrom=ziehl-abegg.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 217.6.247.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.6.247.99; helo=mail.za.ziehl-abegg.de; pr=C
Received: from mail.za.ziehl-abegg.de (217.6.247.99) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.181.0 via Frontend Transport; Tue, 23 Jun 2026 11:23:41 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 23 Jun
 2026 13:23:40 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
	<stable@vger.kernel.org>, Tobias Gannert <tobias.gannert@ziehl-abegg.de>,
	Joachim Knorr <joachim.knorr@ziehl-abegg.de>
Subject: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent underruns
Date: Tue, 23 Jun 2026 13:22:25 +0200
Message-ID: <20260623112225.82386-3-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX01.za.ziehl-abegg.de (10.1.201.105) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30024.005
X-TM-AS-Result: No-10--4.312200-8.000000
X-TMASE-MatchedRID: q5UJ2wehuDckDlvy+ffZUzZ4NKr/TszH7814D0cDbtDKAd0YkM9ab5j2
	vOXaN4CszPfm3fNtqgKn580SYyFa2PS+I4N0lniB7yR/hLt1y2hBqFX02wvtDzJl3k9vFQK8lD+
	GIBs9iQepD+/GDBR8n9akduhEokwBo91Bfe4M/hNch/PYekr/BJQLKJadRcalLgvRN6KVzVH7WV
	YxF/s3BHFv5c46i5n2F3jricVIA+fHmKc8+sjQVFJTtM6CHKVOgdXztqOEBnBRCkSxJRCOByAtO
	k0TFyJTl/ETfolbQGB2AlnmjIjYf9vUNTm/lfkGsB15x1ZALMW9lzVGWamWgOH7RHkgEpGyv9rS
	d36EgULQoHBWslVIiAe98bp28iq6V93NVRFdgSdDxHBP9yEsTZFFWyA10lpHJQrjMEMuzZp7suh
	/AKf/E3DLHVQqp8D4H//4RiQO7F0oFPancsWKldnNPL8uqbTpqqX6uXlOMLLzxM9/7084CIf4l3
	W0tVe7u49q1sWEC7dHBp5ZT1n34TddPuHwt7TAxYVzI3UCCaY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.312200-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30024.005
X-TM-SNTS-SMTP: 053DDB8CDFC445236748F2C390F8A0893967896AABD8A6E27DDC1B18A7F2C7772000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM4PEPF00025F97:EE_|PA1PPFF94441E0E:EE_|DU2PEPF0001E9C3:EE_|GV2PR02MB11852:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3ba97e-3987-48a5-bbe4-08ded119e603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 ur2YwWt1IMTX5u0IOp5B4uyRhDkEaiye6nh10cxKNH8mDY/lJ9gW2eY2wvq8wrOZJBu9d/FI6s4Hb8ajYL8/g7mwGodXIPjS8Za8m5U//sMu7pOWfoqNb6XGUNuarsiZOPhDTLaQGxBj1BQyKqh/pdRrhHU7JR4h2UuT0cxJPaY/ERkRLsBzhoa/W4M8g3pMsDGMcmjTD/gbNFWNr2GsgAWgE85BEwv3dX7ao474SYk6i96TwODmzozUCW2ScwvUE5tXLgpz4fRLKm52uTS5DSjVFnmd0JeOvhhczexrHG2tlv2e+ntm7o9VgdTU6Z3Yk2D6nWycv1sXpkC/DRG5B1J3WOEmtHpiwXUjFk3O+8T4i172CSf9qKawKOJOU029u+W1F30s2DsGcBE0dZQdlyCfM4ocUYxv4rlW3E6pVJYnTbvq3aFVVGQdKKePMLXEJws5sqDoOh2SE5Z8ZkQC7nwJIKH2JIM1W3XTUceJCc39Ezhy51TcDFHOFP+qKUHoflI7dipGtrRWO8MwTsqoDb0rSfeeYKdr7fDqDv+E/K6qUKkO7ttBtV+YTLr/vDUezRGZMWfYRKGKAmn942ISLgtqi4Q+qbPiWmvNeiOf/PijeCY/dlM7CpxhHlGixCOYc5jjQ6uxMn9oqOhlBrX0S75FxE87pC88IiUY1/P9+XsbKn/yIYUezx3w2Aj2QYTbWf3O5ZUct5+rPVSNBuAFUw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:217.6.247.99;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:nix.ziehl-abegg.de;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: RwhqzAd1NdFplAICPeJoSs5yzRJWe5PZloMLar5WFfQdfEp/rLGKj8qvPXdTfBb/+ISyuNgk68SdZWDKdSojRhzboL5ybt+pb9Oz6n8VpwfQCLDmEMc/u/JEVMIjIU/OJLtpiaQXVkf67asi4UisFR4EwcFBCaAcZmzIheHAz3yonGU5f+4+82wMV+05+inYon6y1m5cIROef8tBG+iCw9fZazR+dw20SvVVXwjcXNt0knGMNDP0pJeDuDPkF8s5QHyMO/icxUrQF45me5+Iioy+sQFPsb0fZBZfYLSBSBqrPCA1mgV7XCtzgQaICwo+soHn485X1+bgF1dol3tVKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPFF94441E0E
X-CodeTwo-MessageID: 7f96e497-eb27-49da-a459-7e4e6d72fe6e.20260623112348@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f851a209-4f5b-4ca2-c5dc-08ded119e151
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|14060799003|35042699022|1800799024|376014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	0BW+psEpnRyj9X2BKxxZ4+3NnjVCUO0GS6qgx6HbM/mnWWbHfCVKhh31IFgN3yrO9Hkp0N2RDW6ZsCyTlDS4rDw3Oq81SsbVvyxwTSBOwbHF5yJaFxUFaP8Pvx4/mxB1rcHMSY+fIkmBc+HXWmAnGIPODd6oPWCyZSWK+chBfp+PAEtw3YxwHg3BM3xbaM8qkwJngifwbXUnYHHevYs5jCEWTQbr8Vlt4zYESPgVNsW/rqI9NwZQb9dNAKKL/OvfU1h3upnGlQAr8fMGAhHPz6Cq2u3y6cxxnXjalLot3u6V0y8buqX/s9A+W82BKr/MAvGBLGGuwJz1xP9zkqPq9NGZahPy26FpOeOwYu4GR84cCl2E5LHFb1VOo+vnE1co3CZwQYx77nN8nSr8RaFGunhHwSI3bBULS0LQCIDoJS7Rp9Jyy6GE4Wy01dqOTxQDfZmMfdIg/RUnAF1fi0x0iehdYRN689MzeNhntmYxpD3NapR3iFE51HK8rnsi4xJecPZshdkyrjcrF3Y3PU+UyNtayTkqFyRuePTAQfqj15HEEuV10mEUxIsEtZId22wKofhWh7crlBPQ9SSvwdbboCAUOrXxSQFNFBpuGwkdaG6Yzq3Qk6WlcQwXSeBYBYa+9OjMOBf8Ebr5ytkfqrGA5uE+LT0RM0UiNC7AF4LYx3A02X5Cz5vU+Dip+uA4I1T408kR10eL5xtyJGptmAuIgw==
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(14060799003)(35042699022)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LYIgG8He2PzKfhJcUYH9mD7IfyHKzx1z70tnI6vKzgL+0PsqvrbjgUQ1ja5wNuuLE/UK9DVegfN1GiCkJyF7/CQAjSXhGTzLV52VQl5dbeQ4h/oK+ICDakg5QXWfbNc4aXqQNMvPliHQa9t/lR7/K7wo6UQtWW5QIRTuJCiSB0xdAxmVuQ7S/Zw2efroU50sbpVFQGIuDfQpu6FDNx2688GZmpjcYZ5Upa2GHNnsPj4QOkbGFI1yKe/EGH9AIhE673bTzTMv66ZVwANilYg+YIjH+ZCWJ9HG0MQqIhkA2bCR3QI+cLnLWylOB2DDMqmNYpBzFEhnHObxzJvcSz3Fes1ysUB1tBmL9w1PeTD2z92huUglBEY30OwJAMpyHfqxeODh3+M1fvPww3qscx+rvBnxX17ScUQUCLIGH1pwnplh0+XiUxAIUd5RExUtT7mV
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:23:49.6466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3ba97e-3987-48a5-bbe4-08ded119e603
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11852

The THRI interrupt (IER[1]) fires when the TX FIFO free space reaches the
configured threshold. With the reset default (TLR=3D0), the chip falls back
to the FCR TX trigger of 8 free spaces (FCR[5:4]=3D00), causing THRI to
assert after every 8 bytes drain from the FIFO.

At 115200 baud 8N1, 8 bytes drain in 694 us. On slow single-core SPI
hosts, the combined latency of an SPI IIR read, TXLVL read, and 8-byte
THR write per interrupt, plus kthread scheduling jitter, can exceed this
window on a loaded system. When the kthread cannot refill the FIFO within
694 us, the FIFO empties and produces an idle gap on the TX line.

This violates the Modbus RTU specification, which treats any intra-frame
silence longer than 1.5 character times (~130 us at 115200 baud) as a
frame boundary, causing receivers to fragment frames and report CRC errors.
Oscilloscope measurements confirmed a 757 us inter-burst gap during
continuous transmission without this fix.

Setting the TX trigger to 32 free spaces (half FIFO) via TLR[3:0]=3D8
widens the refill window to 2778 us at 115200 baud, reducing THRI events
per 256-byte frame from ~32 to ~8 and eliminating the underrun.

Only TLR[3:0] is written; TLR[7:4] is left at zero, so the RX trigger
retains its FCR default. Only TX interrupt timing is affected.

While increasing the SPI clock would also reduce per-round-trip latency,
the driver should work correctly regardless of SPI speed. The fix belongs
in the driver.

Tested on i.MX6ULL (ARM Cortex-A7, single-core) with SC16IS752IBS over
SPI at 1 MHz, 115200 baud 8N1, 256-byte Modbus RTU frames under production
load:

  IRQ thread (irq/134-spi2.0):  ~15-17%  ->  ~5%    (~67% reduction)
  sys CPU:                       ~51-61%  ->  ~19-28% (~55% reduction)
  load average:                  ~2.0-2.2 ->  ~0.65-1.3

No mid-frame gaps observed after fix. Without fix, oscilloscope confirmed
757 us inter-burst gaps causing Modbus frame fragmentation.

Cc: stable@vger.kernel.org
Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
Tested-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
---
 drivers/tty/serial/sc16is7xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 395a219280be..476e0dd3fa7f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1196,6 +1196,16 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
=20
+	/*
+	 * Set TX FIFO trigger level to 32 spaces (half FIFO) via TLR. The reset
+	 * default (TLR=3D0) falls back to the FCR TX trigger of 8 free spaces,
+	 * requiring ~8 SPI round-trips per 64-byte FIFO load. On slow single-cor=
e
+	 * SPI hosts, this accumulated latency can cause a TX FIFO underrun gap
+	 * between bursts.
+	 */
+	sc16is7xx_port_write(port, SC16IS7XX_TLR_REG,
+			     SC16IS7XX_TLR_TX_TRIGGER(32));
+
 	/* Disable TCR/TLR access */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, =
0);
=20
--=20
2.43.0

