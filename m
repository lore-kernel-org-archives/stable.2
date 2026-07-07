Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ADE3161A1;
	Tue,  7 Jul 2026 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391210; cv=fail; b=ok2PReXb+bFwOipQf0Om4+nHncDFeJ2Kbl8pXDgkZwxEv+3iFwLwv/2VI9YjYosIPAUMZKK5vz+cVk2SmDSxgUXRjBYWW4y2d6HJLWFbFJHwPAB0swBHmpAP1Gmc+XfZh+RDTKcKXRhJRv4pbQttwI4z+7Oyt6VnQNWRrtOFeOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391210; c=relaxed/simple;
	bh=Hjfg9LCCVvPxTb8Qc5LUlbydC30zU7Ubthyjj3HizHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DfqzJXQe6rkzWX3y2p+ZrQ+21zs0tHFqfkByFbrKdSiQ2Gsds/d6YUEb7Qg/phvQTN5muhoxCowTl1sfGaIRa4kIGuFVowwrxZxaoh6pGfaTwdUjm2TDfCp/NA9I3w0KpDfQuj0vUU/d/19KYGEcoOZfscYAGup6mkwz5w1pm3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=krAZ60wG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ov/G2B6M; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="krAZ60wG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ov/G2B6M"
X-UUID: 4816548a79ab11f1b1788b6acf885367-20260707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Hjfg9LCCVvPxTb8Qc5LUlbydC30zU7Ubthyjj3HizHo=;
	b=krAZ60wGBjs7LXXl6MSUF0OUoqN3DtSrUNVuJ+ot8mqmlCbn2SnMxv/oyvYFdkZdonYjM3mcmmR4uyeIHILiwmHS+0FE10CCdtq6I76NG4zwBjKEG+VbPPRWpbNxZYGv7h0yzFNk7N6zKazXRXjgBeq0jhZWoBVzj/yh4S00YKM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:e7321318-a50f-48cd-a880-29459a0495c2,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:d497b38,CLOUDID:4bd11582-6310-4e6b-a6b1-aca20d98ed8b,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4816548a79ab11f1b1788b6acf885367-20260707
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 456560974; Tue, 07 Jul 2026 10:26:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Jul 2026 10:26:36 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Jul 2026 10:26:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJ+YcyswxWIqE1cZoR8mI3cyFTc+xlMdmzl+zcdmmgPed5J99SYCOzFx0nXoU+m0h9gVB3qfSpFKxfUFQMbSmz29jTLL4wRG7xdlaaOlkVy5HkjNTPZpUAf9kpf1lcXnRcKHGZUtRN+0FwfZ+3XNLOUILf78eWZS0aKOfcZrRtQe9JrwxDMy2u+wBCLJ46BqEqKmkPXmXcncJtwlWbTgLGYLGrQgwoHx6mKkZTaBbXryEc7+tW1yW/gT1RLN+Qqh4wgkdYpuqKEcnfj/3P7EBPaa8PsYjcnH1w0Fn0PApQ6Lf7S6HmjCGfqN0iIud8CsV5oWEqYBETuR85p58MO8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjfg9LCCVvPxTb8Qc5LUlbydC30zU7Ubthyjj3HizHo=;
 b=Uswr9eHXSaV9/3m6ROKx/HA301EE65FG7dDxJ/Mm60SoTn2QnAWS/aMWIRLyGolt4XYKPqvGNg4UyiSmz2gTfbCyoRCYGoODqFaRDbkI5CABJpK6QJ8rowSWOQRhf09qvSHrL690sUl2+NqM4+J/UgEEDOLEorY6/xwgUEOQFilI0G1Z6fzA36szoMJ5JEV9hUYcf+J3IIShXR7uVztCxieuHwzVChxNG7NjWVDWOLWDsxRPY0Kk9zxHeKeDCI/lycDKRakebX+b0QaGVGi3APfaZe6BEpaGkVVkZRcpxLejqeHrlhoN6C6/Ghg+iq/ntyxkWLZFq3hYADs/e5iNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjfg9LCCVvPxTb8Qc5LUlbydC30zU7Ubthyjj3HizHo=;
 b=ov/G2B6MoVj+k11MwnLBUSEnfOCujf+j4fXH+KmIberBw9kMzC2T1v0QgnOksL3O5vtbsSeY8mGMlHoTobYYwqxQx3/mRBq/+WVyVkAEnPjIhv80PcEqAfqNuYuCjlZBp+qs47Q90DfYrf5DyCkb4aLFQm997H6z0KYgsw24aCs=
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com (2603:1096:301:62::11)
 by SE3PR03MB9562.apcprd03.prod.outlook.com (2603:1096:101:2ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 02:26:32 +0000
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0]) by PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 02:26:32 +0000
From: =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "imv4bel@gmail.com"
	<imv4bel@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "alice@isovalent.com"
	<alice@isovalent.com>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, "nbd@nbd.name"
	<nbd@nbd.name>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"willemb@google.com" <willemb@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>
CC: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5] net: gro: fix double aggregation of flush-marked skbs
Thread-Topic: [PATCH v5] net: gro: fix double aggregation of flush-marked skbs
Thread-Index: AQHdDPoFYAnLjExxf0qT6ZW4HhBkSrZgsVaAgACkvwA=
Date: Tue, 7 Jul 2026 02:26:31 +0000
Message-ID: <dd5beba874024856f4743b6ae1936a6f432333fc.camel@mediatek.com>
References: <20260706034611.360-1-shiming.cheng@mediatek.com>
	 <willemdebruijn.kernel.27b4940999026@gmail.com>
In-Reply-To: <willemdebruijn.kernel.27b4940999026@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5622:EE_|SE3PR03MB9562:EE_
x-ms-office365-filtering-correlation-id: cdae4c5a-c1a5-41e9-7f4a-08dedbcf289c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|38070700021|921020|4143699003|11063799006|56012099006|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: L0lMW8WP9AsZnH0pvXwOBeeUiTELeRZNgisZT/FlCZXY0C3spql86nfrdR04fb7JhHX2IjMevdKrNKqrzKCVN9jWjscgiaGlAd8ASuCazSNyI7zJCUIDSfYtMUjC4/9ntNv4enaPdE0cNFWfd85/M1tTQ/iKjJ7BG1q8zIDcvURTOGnuQx7RHzUkkUvUfdgbHjFa+FscbnjcUib9tW2CdG9qPIPTlkXykQhYLpsr7su3vXdoplCf1CDoKU2l3qHeDgGQZEHTvpDeCu+CAChZIgr53hnnH+RqK/Hdn1ajIYqKxh6CfcePHK2ctEt4ExMlUNkm18CA2n8wuQDqZRofRnDnBznfuUUt7QvYvYB9S9nO22lk7Qg/0+LG1oDV5tzHz6snWzQc8IS1D9daXhgzhazud9vV0Eh1+WEJ8Vv/pfordssPGGARkt7gKBzGZU3YgpH7qS7HZeNSmC8EgEhKkCkS4AXKsHwrRJfBd1MHLjFWj/q94WhG6QPoXXBo3s94TXxPZU52my1zsHZZQRlt5DMEpuUOLpVkaHxPbapGSWrTOUaSp0CDVYHAqSSuzeVsGDhODyBB2MIYqa+5wpgO8fuj4Wtho0YRN59aeZqAGPDyUWNoQvWSkEdGIevNiShjqyKZEbP3bxv8v529DQe0MLSCwMFiX4Ijd7wFvpkIqF7QJTpDk/ptlaGkrKYQKr6Utm1Q4ilRWp0q9QmbC+iWCxSFQfpg/SBsryBAcak8jOHNWgLUI8H/LIqJ9LnhvMm8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5622.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(38070700021)(921020)(4143699003)(11063799006)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1ZRNEh2MTMyOUtNVDRENTJZdy9mMVhaSllSUVZWQzJ6a3A1SUhhYjAvcEtV?=
 =?utf-8?B?WFB2amUwZmdjYVp4bG54M21nbGtieHVxbUN5SGFyK2tTdUxYN2RWdzFzNkVN?=
 =?utf-8?B?dFhoODI3RFlaOURuc2VFWE9MZ1ZQb1ZNdHM3Q0lCamtUQVdKZ3J1Q0R3ZHpi?=
 =?utf-8?B?QndTRlpqN2cwaWJqaFdCSWtFdDhZOFgxYmlFR0xWVmEyVkpjVDNxSFdKRU1D?=
 =?utf-8?B?TUpDT1ovM3JVelVKMEwwMmVaZ0RLL2V6bmVmR0k0NEJiSzB1R1dsb2lQSTRB?=
 =?utf-8?B?ZWFxaEFNYUh5eTJZYU5TcXVPdWlDU29laW84YXhYN2dvVFdscmVSREwyNkxl?=
 =?utf-8?B?TkVXeDIzWVlNR1owcURGYUpxV29wcVoyQWNWQWQ2RWZkUlpHRXdLbjhZeitI?=
 =?utf-8?B?T0JzS0V6dUNqZTAwbDR1R1RIUGJTY2tYN1VGQlB2SlJ1dThQM3JlWU96VmZM?=
 =?utf-8?B?ZU5yZTM4bFJseXZ6MVNmcTF6NExEbzBmTDRDTFJXQTBiVGpRMlRIM3R6YlpX?=
 =?utf-8?B?b01ST3ZZWWVKd0NCcDFmYjlGZEUvWERtQ29rU3I3Wk9sZWk2UUdFL1Y2MG1p?=
 =?utf-8?B?L3JodTJMcmduSGNNamFVODZpUHNHa3IvcWZ5NkIzREJadGNPMTlDNTN2U1Fm?=
 =?utf-8?B?d2xhZFBjeW5zY1AyVzJERlFvRTI5WHNkcEUybzczaGNvazJWUm13bHo1c3gw?=
 =?utf-8?B?ekFWQW80MlJVNlJlUSs2a3p1bnlxSk5jdmJxUVZJamZJcXpTK3lNOEgzVXM2?=
 =?utf-8?B?UjVHbEFRRVQwMVpBT3NjUFZNZHZHRVNvRGt0bUwxamgwSlFybHVLcnJqcHlX?=
 =?utf-8?B?QTlVTUxENng1dkM5L29MWlV3L3JucDdvVmxQd2laSUtrNzYvVk54ZzRObm5V?=
 =?utf-8?B?VTF1VnZDYUxaRXhXRUtrS2R1dTBpRmowZnllcGZJQXFJM1BKR1VVaVRGZ1pr?=
 =?utf-8?B?c09aRHBIMjdMY3NqSDJuNTZRaEJ2YjcrU3dZa3FTMkM2NDZsUWMzOVdJUExt?=
 =?utf-8?B?RVZ4RnA4TmNaS0NqWTNBSUVUTFFlSlZwWWt2aFhjZEFMMC9MTUhZa0xEdlhT?=
 =?utf-8?B?ZmtJNGlmNWRERWRQUFF0WnhCUFNVYmNFTGxNalorbXNiZmwyUXpFc2F6Sm1y?=
 =?utf-8?B?TWxrVGxnZGdxN0ZZM1VqT0I0NTFXV1Fuc2VGL1BzNE1TSHJrRlpBUXdvV2RB?=
 =?utf-8?B?RUVaNDJTOVNPY2xOSzhtTmxuWFNENEd5OVpLeU8vbFhJN1ladHVvWnc1cUkw?=
 =?utf-8?B?M001dGRsTWx2K1JNekkxTThUMW5VdmtmTTVySHBvNXp2UlFsRXkzdTlVa0Vy?=
 =?utf-8?B?SmQ3VytBaXN4cTdoUWJHTVp4N1FkZ2VoYWROaU9WQUt0NEhqcVYvMGhGK1dO?=
 =?utf-8?B?ZHhlU3dUWmMvMDRwbHlENEFZMWNDZVRUL2I5OExHQmxmdWpwOWxLbDE0ZExM?=
 =?utf-8?B?SitNelNnaFhTUlQvajBRbmRsWDlwV2J5UW9FbXBwSVhweTREYTZQV1N2c2dP?=
 =?utf-8?B?Zk1DTGVDbHlUSm9UZnBiZWhVS0gra0JReDJ5YVdqOUFTYWREeHJUMmRVRUpG?=
 =?utf-8?B?Z3lVUGU2MEJvN3IyclF2UzFQUFAvcHA4cmR1U09YdEt6cHdSODdIZzVHYVAx?=
 =?utf-8?B?Wi9HK2tMajJ1ZlY4KzFSTFF4bTJtVW1CbTgvTWcxUktRa0NOR1N0U2t4K0Nr?=
 =?utf-8?B?T1VacE81dGx6R1JlN1VIOWsvTE5xM2k3RUdXSFV2SXh3djVRRDhVb2lZNTI1?=
 =?utf-8?B?ODd3RloxbGRkNTZ1QTBFWUR2Vkx2bC9EY3JLcDY3TisyZGN3eUVqZjVXazNs?=
 =?utf-8?B?TjRwZlAxbmhqTTN4L1VlWW5jWU9GTmhqL2xNbGFCM0d4VG1ZbDZCWDhoY0c1?=
 =?utf-8?B?TVcxUnFSYWJxS2FWanNHSTNEOFo0ZkxxaThrUUlLOU1DckhZSUdXbGRFc1VV?=
 =?utf-8?B?aER0UmVJRVJKZFdMeW1qWFFWRDc5L0hFVW8vT1hWN1hmUkllTk9TZFhhME9X?=
 =?utf-8?B?MHNVeTRKTDFocWQyclJQZ2VaK3hsQ2NWNVhjSmhRMmRzbE8ydTEzTjM2U1o0?=
 =?utf-8?B?S3VvaFdqYWhaOTNkVzdYS3JzZ0IvdUQ5dE54M0VPKzlWWmo3LzdsZW5GRnhm?=
 =?utf-8?B?bEd0dXYrbEZ5K2FFTVc3UXhCUGYwbm9QTmQxR21DaExvSll5VEdkN24zMVBL?=
 =?utf-8?B?bk5VZDVKMjMvNUlReEFMeVhMcmRHSXphRXd2QU52dEdjbGtrbEErRFVlWVlm?=
 =?utf-8?B?VlRyK2h6ZnlRcUwyNmJ2ZmJCTGwrRVNDTDU5ejBTcTZ1UG0rWEpQOWlvTk5a?=
 =?utf-8?B?WndVQWY1NWZ1TDRUb0VaeVhZeDhvRDlMRG1yWUphUHdRTWtWMFJtTzNLaS9l?=
 =?utf-8?Q?UOrksNLk9iM4yVGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16D02E46BA88134FBFB3E98D400E10C7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dxoMfv+W8o3qWdon7yesdSFX9alax9YvlZiw2ve/6K8Zxk5gdSGAukgGZpiIAzik4j5zgnf9eiC15FLUhBjXcdBk9uOapdwDy/rpr1nFiYUJV/MdHRda7PtpNKOKi5/F6n3ynmJkL50fauhqCXXJO4u+S3snEQjup2CcHQNIEukqEYvwq23t0mbKkkV4kC9EQf4IjlRHd5IcR2O4miOZ3rpaPIh5rMptLZQbOXrwh3NHx2ZFyllE6Ihxow8GrfkHn+XcWrfEfMeMTzdXIBCkXFFphVloHxURXWBaMKFWltH4gBjG+theDgm9UuVwHAJmxaY5NHXRu0DwTDyvR99n7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5622.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdae4c5a-c1a5-41e9-7f4a-08dedbcf289c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 02:26:31.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZv6FIRpTKscQ8UoRf8xo4OWZnP2FI6LffGmcUTkJfGTRm7Fu1LEf8O9a9N+v0Wagqv41sjd53mkUEkUqSwKtjFyiPcALfx/fKBEJotwWEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB9562
X-MTK: N

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDEyOjM2IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IFtQQVRDSCBuZXQgdjVdDQo+IA0KPiBTaGltaW5nIENoZW5nIHdy
b3RlOg0KPiA+IFRoZSBza2JfZ3JvX3JlY2VpdmVfbGlzdCgpIGZ1bmN0aW9uIGlzIG1pc3Npbmcg
YSBjcml0aWNhbCBzYWZldHkNCj4gPiBjaGVjaw0KPiA+IHRoYXQgZXhpc3RzIGluIHRoZSBza2Jf
Z3JvX3JlY2VpdmUoKSBpbXBsZW1lbnRhdGlvbi4gU3BlY2lmaWNhbGx5LA0KPiA+IGl0DQo+ID4g
ZG9lcyBub3QgdmFsaWRhdGUgTkFQSV9HUk9fQ0Ioc2tiKS0+Zmx1c2ggYmVmb3JlIGFsbG93aW5n
IHBhY2tldA0KPiA+IGFnZ3JlZ2F0aW9uDQo+IA0KPiBJbiB2MyBJIHJlcXVlc3RlZCByZWZlcnJp
bmcgdG8gdGhlIGNvbW1pdCB0aGF0IGZpeGVkIHRoaXMgaW4NCj4gc2tiX2dyb19yZWNlaXZlOiBj
b21taXQgMGFiMDNmMzUzZDM2ICgibmV0LWdybzogRml4IEdSTyBmbHVzaCB3aGVuDQo+IHJlY2Vp
dmluZyBhIEdTTyBwYWNrZXQuIikuIFRoYXQgZXhwbGFpbnMgdGhlIGlzc3VlIHdlbGwuDQoNCnVw
ZGF0ZWQgaW4gUEFUQ0ggVjYuDQoNCj4gPiANCj4gPiBUaGlzIGFsbG93cyBhbHJlYWR5LUdSTydk
IHBhY2tldHMgd2l0aCBleGlzdGluZyBmcmFnX2xpc3QgdG8gYmUNCj4gPiByZS1hZ2dyZWdhdGVk
IGludG8gYSBuZXcgR1JPIHNlc3Npb24sIGNvcnJ1cHRpbmcgdGhlIGZyYWdfbGlzdA0KPiA+IGNo
YWluDQo+ID4gc3RydWN0dXJlLiBXaGVuIHNrYl9zZWdtZW50KCkgYXR0ZW1wdHMgdG8gdW5wYWNr
IHRoZXNlIG1hbGZvcm1lZA0KPiA+IHBhY2tldHMsDQo+ID4gaXQgZW5jb3VudGVycyBpbnZhbGlk
IHN0YXRlIGFuZCB0cmlnZ2VycyBhIGtlcm5lbCBwYW5pYy4NCj4gPiANCj4gPiBTY2VuYXJpbyAo
VGV0aGVyaW5nL0RldmljZSBmb3J3YXJkaW5nKToNCj4gPiAgIDEuIERyaXZlcjogR2VuZXJhdGVk
IGFnZ3JlZ2F0ZWQgcGFja2V0IFAxIHZpYSBMUk8gd2l0aCBmcmFnX2xpc3QNCj4gPiAgIDIuIERl
diBBOiBSZWNlaXZlcyBhZ2dyZWdhdGVkIGZyYWdsaXN0IHBhY2tldCBhbmQgZmx1c2ggZmxhZyBz
ZXQNCj4gPiAgIDMuIERldiBBOiBSZS1lbnRlcnMgR1JPLCBza2JfZ3JvX3JlY2VpdmVfbGlzdCgp
IGlzIGNhbGxlZA0KPiA+ICAgNC4gTWlzc2luZyBmbHVzaCBjaGVjayBhbGxvd3MgcmUtYWdncmVn
YXRpb24gZGVzcGl0ZSBmbHVzaCBmbGFnDQo+ID4gICA1LiBGcmFnX2xpc3QgY2hhaW4gYmVjb21l
cyBjb3JydXB0ZWQgKGxvb3BzIG9yIGRhbmdsaW5nIHJlZnMpDQo+ID4gICA2LiBEZXYgQjogVFgg
cGF0aCBjYWxscyBza2Jfc2VnbWVudCgpLCBjcmFzaGVzIG9uIGNvcnJ1cHRlZA0KPiA+IGZyYWdf
bGlzdA0KPiA+IA0KPiA+IFJvb3QgY2F1c2UgaW4gc2tiX3NlZ21lbnQoKToNCj4gPiAgIFRoZSBj
aGVjayBhdCBsaW5lIH40ODkxOg0KPiA+ICAgICBpZiAoaHNpemUgPD0gMCAmJiBpID49IG5mcmFn
cyAmJiBza2JfaGVhZGxlbihsaXN0X3NrYikgJiYNCj4gPiAgICAgICAgIChza2JfaGVhZGxlbihs
aXN0X3NrYikgPT0gbGVuIHx8IHNnKSkgew0KPiA+IA0KPiA+ICAgV2hlbiBmcmFnX2xpc3QgaXMg
Y29ycnVwdGVkIGJ5IGRvdWJsZSBhZ2dyZWdhdGlvbiwgd2hlbiBsaXN0X3NrYg0KPiA+IGlzDQo+
ID4gICBhIE5VTEwgcG9pbnRlciBmcm9tIHNrYi0+bmV4dCwgc2tiX2hlYWRsZW4obGlzdF9za2Ip
IGRlcmVmZXJlbmNlDQo+ID4gICBOVUxML2NvcnJ1cHRlZCBwb2ludGVycyBvY2N1cnMuDQo+ID4g
DQo+ID4gQ2FsbCBUcmFjZToNCj4gPiAgc2tiX2hlYWRsZW4oTlVMTCBza2IpDQo+ID4gIHNrYl9z
ZWdtZW50DQo+ID4gIHRjcF9nc29fc2VnbWVudA0KPiA+ICB0Y3A0X2dzb19zZWdtZW50DQo+ID4g
IGluZXRfZ3NvX3NlZ21lbnQNCj4gPiAgc2tiX21hY19nc29fc2VnbWVudA0KPiA+ICBfX3NrYl9n
c29fc2VnbWVudA0KPiA+ICBza2JfZ3NvX3NlZ21lbnQNCj4gPiAgdmFsaWRhdGVfeG1pdF9za2IN
Cj4gPiAgdmFsaWRhdGVfeG1pdF9za2JfbGlzdA0KPiA+ICBzY2hfZGlyZWN0X3htaXQNCj4gPiAg
cWRpc2NfcmVzdGFydA0KPiA+ICBfX3FkaXNjX3J1bg0KPiA+ICBxZGlzY19ydW4NCj4gPiAgbmV0
X3R4X2FjdGlvbg0KPiA+IA0KPiA+IEZpeDogQWRkIE5BUElfR1JPX0NCKHNrYiktPmZsdXNoIHZh
bGlkYXRpb24gdG8gdGhlIGVhcmx5LXJldHVybg0KPiA+IGNoZWNrIGluDQo+ID4gc2tiX2dyb19y
ZWNlaXZlX2xpc3QoKSwgbWF0Y2hpbmcgdGhlIGRlZmVuc2l2ZSBwcm9ncmFtbWluZyBwYXR0ZXJu
DQo+ID4gb2YNCj4gPiBza2JfZ3JvX3JlY2VpdmUoKS4NCj4gPiANCj4gPiBGaXhlczogM2ExMjk2
YTM4ZDBjICgibmV0OiBTdXBwb3J0IEdSTy9HU08gZnJhZ2xpc3QgY2hhaW5pbmcuIikNCj4gPiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW1pbmcgQ2hl
bmcgPHNoaW1pbmcuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQvY29yZS9n
cm8uYyB8IDkgKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZ3JvLmMgYi9u
ZXQvY29yZS9ncm8uYw0KPiA+IGluZGV4IDM1ZjJmNzA4ZjAxMC4uYjE1NzNkOThmM2E1IDEwMDY0
NA0KPiA+IC0tLSBhL25ldC9jb3JlL2dyby5jDQo+ID4gKysrIGIvbmV0L2NvcmUvZ3JvLmMNCj4g
PiBAQCAtMjI5LDcgKzIyOSwxNCBAQCBpbnQgc2tiX2dyb19yZWNlaXZlKHN0cnVjdCBza19idWZm
ICpwLCBzdHJ1Y3QNCj4gPiBza19idWZmICpza2IpDQo+ID4gDQo+ID4gIGludCBza2JfZ3JvX3Jl
Y2VpdmVfbGlzdChzdHJ1Y3Qgc2tfYnVmZiAqcCwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gPiAg
ew0KPiA+IC0gICAgIGlmICh1bmxpa2VseShwLT5sZW4gKyBza2ItPmxlbiA+PSA2NTUzNikpDQo+
ID4gKyAgICAgLyoNCj4gPiArICAgICAgKiBQYWNrZXRzIG1hcmtlZCB3aXRoIE5BUElfR1JPX0NC
KHNrYiktPmZsdXNoIGhhdmUgYWxyZWFkeQ0KPiA+IGdvbmUNCj4gPiArICAgICAgKiB0aHJvdWdo
IEdSTy9MUk8gcHJvY2Vzc2luZyBhbmQgbXVzdCBub3QgYmUgYWdncmVnYXRlZA0KPiA+IGFnYWlu
Lg0KPiA+ICsgICAgICAqIFJlLWVudGVyaW5nIGZyYWdfbGlzdCBHUk8gbWF5IGNvcnJ1cHQgdGhl
IGZyYWdfbGlzdCBjaGFpbg0KPiA+IGFuZA0KPiA+ICsgICAgICAqIGxhdGVyIGNyYXNoIGR1cmlu
ZyBHU08gc2VnbWVudGFpb250Lg0KPiA+ICsgICAgICAqLw0KPiANCj4gU3VjaCBhIHZlcmJvc2Ug
Y29tbWVudCBpcyBub3QgbmVlZGVkLiBDb2RlIHdvdWxkIGJlIG92ZXJ3aGVsbWVkIGJ5DQo+IGNv
bW1lbnRzIGlmIGRvbmUgZXZlcnl3aGVyZS4NCj4gDQoNCnVwZGF0ZWQgY29tbWVudCBpbiBQQVRD
SCBWNi4NCg0KPiA+ICsgICAgIGlmICh1bmxpa2VseShwLT5sZW4gKyBza2ItPmxlbiA+PSA2NTUz
NiB8fA0KPiA+ICsgICAgICAgICAgICAgICAgICBOQVBJX0dST19DQihza2IpLT5mbHVzaCkpDQo+
ID4gICAgICAgICAgICAgICByZXR1cm4gLUUyQklHOw0KPiA+IA0KPiA+ICAgICAgIGlmICghcHNr
Yl9tYXlfcHVsbChza2IsIHNrYl9ncm9fb2Zmc2V0KHNrYikpKSB7DQo+ID4gLS0NCj4gPiAyLjQ1
LjINCj4gPiANCj4gDQo+IA0K
