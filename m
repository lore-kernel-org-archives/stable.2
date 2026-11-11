Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=210.61.82.184
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377498;
	b=5Ek61ZxZ76dAAp1GsNlYPOx4ND6JqJPTbD0e+hMUrxXiq3ONBy9PzX6DArAS/AwPfQ/W
	 B0ccsHDVoJjiuVML85ufntfy45H/Mc8zZMwthAUtXBXsjXCeimcS85ygB8kVuCV0JtWXt
	 E/wG0FGBqWtfZXl13iIjKxsOGEUOVV3+MgJ3pgyaNf5p7ccKHR8ba4uhNXFJdcDcLmv/A
	 Z5Ewd9vkrrgZTEmklTKepxX66rH8jOz5++xGEhOQMjJCr3s2OV5Jof1PglE7A3SEf5txy
	 55nlmU2otSLA7ksiFHLdD9F9SkNzM18gHOMHLH4DchxrHsT7cOrJ/TEByoD1GIubF1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377498;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MTK;
	bh=MRi6Z2MynfC98mJXp2oM4bhjOtPXVQh9vgmCrfHJQ+c=;
	b=jsL2+4lSIHzuJpYBpgRutyqndMXhHXzVK6RlXYXBIUnixMFJE+Az1IIhnmYdlZj6ttSW
	 b/LwRvif91A+o3pGwBO9LOMJigOqWkBC2E5h3hZY9ycz9aRt86PM4c8144ATtEtVmCmJW
	 8r3WGx/212Lk0EILPzXq5LUw3EU1FeLuaIvpwmyj3Ii3SK1OEzRB3oJbcrEdx6FBDu/Wo
	 EHJKTGBRrootJJY5/xlvOoD6YJuR+LqX/K+oaT+wE51oWuBY1C1MmBbCW7hI1uRsrcFso
	 iN04MoD86ccCWYKPUVipMVfnC2hdmJSosWG4nY2R8IDzh/rZPMTwDRpnZaT2nTu/5ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=bHae4VOn;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=Y1cvZL07;
	arc=pass header.oldest-pass=0 smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77E606A324;
	Wed, 11 Nov 2026 06:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D77E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=bHae4VOn;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=Y1cvZL07
X-UUID: ba8465e4dd9611f18dc8c9802ae25ab1-20261111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MRi6Z2MynfC98mJXp2oM4bhjOtPXVQh9vgmCrfHJQ+c=;
	b=bHae4VOnzsvlUJVVDylb9TF+V0AgYYdUEOral6UsZnjWopYbNtk285VV++O0Ppkljul3n/Q9l5J5MSux6Ae5WdttuaTy9pF//e2mqLenTFimZ/fuKcdBOuJj1arY6g11UaIFwazAbfoPg4474VOqadFctOAurocPIW2kNyzr9h8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:22a02740-c48e-4463-a920-07f654f752d8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0318ac,CLOUDID:6db1b130-f289-4656-bb36-27baf4489f11,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba8465e4dd9611f18dc8c9802ae25ab1-20261111
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 698419024; Wed, 11 Nov 2026 14:11:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Nov 2026 14:11:25 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Nov 2026 14:11:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ogu4S9QqzjqCWyMPaH75o1cRRSo7aNoWzjLLpZHSwknLBQHSoaaCve+sqv/Swhsc4aNEeZGcWIF4I2pb4PMUOQMNbQzahOkHsZ4rzT/iGR1Z/K3xnEKCrSBbDTEZTay+VZsAd5qusvcvW7QyaIh1PIFCvCV2rVuGm08Ejn+4SEuffqLj/FU3R2Q21aA+6LChT7bwN0fZakfX0SWBG4sk1Hw+l2AmcE/WwPUI2uuUMXMUBhc3BbL5hA9Z6eRnAr+xyRDUU18nZSvSwVz5x7vx30O+VgVZlBzzmXv3pPexZqnoXeJn1G3uU0uNIQnzKwzLnQxJ/g3FFDxlIz2dOE7DJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRi6Z2MynfC98mJXp2oM4bhjOtPXVQh9vgmCrfHJQ+c=;
 b=PkSdyk7aKsQ6mYv1SWpQzVbzd3gYpA2Xuc1h2W+vQKijMj/Ai/vEc8l0ksBu5bzzSnyjYxu6jomzMrTEEPz5iamewKRAMWslU1jjj3Fie5CwDLhZVWOZ5EJNirirlpXlbQ24TfmS/7g+Wi5K/3HhaERYR1dAaCfZ0Fu1locUYlOj7ssBlTJjBznAu6w6UMRbl+VwqplL/JB5CCX1K5MmYEhRCF0Gx2DYbkf8NpOzKEszfz6/pvB3Jt1K/7ifTsOgDcsD6PtOCr2/SqnjaaBeQt3Qxil1sjxYosP1G3q0GtE7lnGTszRimZCu7qb4BRlYYSRwWC9A5NumC74ClFhEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRi6Z2MynfC98mJXp2oM4bhjOtPXVQh9vgmCrfHJQ+c=;
 b=Y1cvZL07Pordhuar/M3nHf85KOhOgPLnINZZ+Qnnl5oCNz6KNphIaxmZO4fhlrlY0vdL9pV/cQqr0ZxeHXHyhxNW1KT/wyOJW9Kz0HdvWOu7/Urc3XUTYdB9FHAGdVOOJQurzvHQyQpyTMi5TkXlyPAbbubBcYk/MWk7114HHN8=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by PUZPR03MB7159.apcprd03.prod.outlook.com (2603:1096:301:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:11:20 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:11:20 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "tangbin@cmss.chinamobile.com"
	<tangbin@cmss.chinamobile.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi_v2: NULL check curr_conn in
 pre_enable
Thread-Topic: [PATCH] drm/mediatek: mtk_hdmi_v2: NULL check curr_conn in
 pre_enable
Thread-Index: AQHdZfig5rie6B29DECSbw2L5GkfKbcoev8A
Date: Wed, 11 Nov 2026 06:11:20 +0000
Message-ID: <b2fbd2478bfbf056f8e0d21d7fd280abbdaf9c4b.camel@mediatek.com>
References: <20261027094941.1862-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20261027094941.1862-1-tangbin@cmss.chinamobile.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|PUZPR03MB7159:EE_
x-ms-office365-filtering-correlation-id: 0f9b835c-5777-486e-f3b4-08df3fba9af8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|42112799006|38070700021|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: VqB0lSHUR96YJzgW63Q0YmOE7BStNCoVVYtOFkQbtLirPOG7mdONl4ynT/aVSV3RzKf4DMEX2G+MqtLiwUscYN0c0JmVuXRPQoGn82gVwFUT2kf8Vs1UbDT8nQFC/aTzK5nTa/BU0EF2ysiJK6oDvtn8mCoOjDvD2kKlv3XVbaxHFR9yILAXdtjDKiiZuHJDLB1vhq5R757VSzejkSC87XlcaqY9ZVnzENl+L8rlly81dB0eb4Glymz1gvyiLrjtgOIz4u4WqRZraepGmRXLjo/isw4VyluMJkUTSyRMQN7E74NHjYzu3UWF81rk9ozqjzp803LQS90c/sroqn33Zs9xJumdLoX1FbGPqO3oOSUNxj/i1rsvUlbhhlIrD8bWBC1ejCejQq1x782w5ThjXPtYzwUjpsqVgmd2aTjP8EZ4PN5OKNdfyQFFRMFR7syws9Kk25IAuHqXfU4KNHFSixQjZ0DBpPGUO1xjqRTNq3T8zYySR/Gb0UoWf07G/2hgJdDJPyuxHpNMqoO4kZqqO9kPznZqipDc7X6ZNmcMCM6ReJe2//mPUwYgsuqbABHI/6wv+LyE0AmisglebMhD2wH9z3AVsbWaL+QN6/jPFIqHvtrWxx1DgsLbgw+1f1piQeXiymGi/PtVOV859dlWUg/AUIK3VGzxUIq9AUUAIcsL6Yrq9AA7Rm9/h0+1gWFY+AwEnYNeERHQ0Wy0OU8E4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR03MB9902.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(42112799006)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1pDSjYxY05idXdwcnFZQ2tMNkMydWJpWk8wK0JYakJJV0VIVmdvbHNuampr?=
 =?utf-8?B?N1FUN2w4K1pPa0NKT2FMSSt2TVdiSkVCMUNBdEFZZFZwdlhJL3B0NDkvN3JD?=
 =?utf-8?B?ZzJieWRya05NaEppSU5LbDRlODM4YTJCZHA3eVpybzZPUjVKZ0s5c1VnYWx4?=
 =?utf-8?B?aUpkWkNySGVVZEI4dG95VzJRV3VQcFIva1BrWkdhY0VxNjZGcUhWRTVpUDNl?=
 =?utf-8?B?SmdXeTBjVU84d1VzOVJzSmY0WUFCS1Npck5Ka1NNTlZacit0R0tTSUNEc0hJ?=
 =?utf-8?B?WDFoRk5ET3htcDNXWThXOU5XeXZSUW9RdEh4WStIQWdqYlFYRjZPTm1VYkNO?=
 =?utf-8?B?UXBuRjkyUXVzQkFMUWN3UTE4WGlJK2RSL1lWZSsxbTRMTGl5aWcwV1Q3VDVy?=
 =?utf-8?B?OE1PR1gydGlsNXczY1ZodytTRS82WXdha2RuSURnckdLTGVzOW01QmNzVXZH?=
 =?utf-8?B?bGlqblZ3aUZGMjFnWjNoakJNMEJsU2NTQVBocEdoYU55OWJaV0dzNDZoSnRT?=
 =?utf-8?B?T0ZOV0xjY3pHTHVWMlBqYjZWSWs4dWpYdlRaK3V4VHB3ZnV3Uml3OExuYzBE?=
 =?utf-8?B?dHRXenRMMEZVdHpQaUhNamRQblhGemtZMmtWZW56ZUplMUlHTklrL1k4YXBz?=
 =?utf-8?B?N3hlQXZOdUZCbmRQdVdLR0wwbjR0ZHNNUXhZQ05OT0xFbW9nZGtVZFlFbzI4?=
 =?utf-8?B?czZ1MDl0VXpkYjhvQ2d2a3JlWHhRd28wblB2RTNaMWEza2F5eU5VNklub3Vo?=
 =?utf-8?B?ZFlqTE51UjBkQVpSbWs2cENsb3hJc0J4MWV6SWdFSUdSWTN5V1ZRdHRlOVlY?=
 =?utf-8?B?R2RpcEJwcTlJclE5d3dhMzBFZ1FWUWR4NTZmemxEL1ozbGpZazdzTkEzZjR0?=
 =?utf-8?B?U3ViS3lzNWJucUFLK3BPeVhCS0ltTExjeHlWS0NTekdQVWpRdyt3RTluN3Vw?=
 =?utf-8?B?c1VteEpYVko5SjdySFRsWWRiK1FpR2FyeDE0eVAzdHFoYnU4Q0RsWUJmbExF?=
 =?utf-8?B?SGRMMy92MTZ3RDNjeUFpcUliMEd3TExsQTkvNHNDcklKVjFibm05TEp0UEJL?=
 =?utf-8?B?NU9yemVJQUw0VDZnMkx3Q2FhNGlsUWlVdHkwZmVEVWxIZldMdEs4NTV4djlo?=
 =?utf-8?B?RkxOZzVpa3ZxL3hCeEhnd3JCK0JxNkVrZlhiQitvY2h0bDBhUUdGMWZFanVy?=
 =?utf-8?B?VlRMeVBQZVhIN2I4Zmd6bTJURzA1UUJ6TCtiOHY4Tlo1czQrR0JnNnNpN0dE?=
 =?utf-8?B?R0hPK0R1MzJaenplR29EaFpvb05FYnNQbFhDTEdGZUhCUHhHWEZKYkdwOXE3?=
 =?utf-8?B?K0tPaHN1VGlYYk04bC9OMWVzazE2R3Q2YTZnUjRkeFZMMjN2aXpzTTRNcWgy?=
 =?utf-8?B?dkUvMklhdVJVRm9NWUdkYlU5c01RUlEvVnpRd0plSDNQNnd2Z3lIZUt3Q2do?=
 =?utf-8?B?eTJabFhDNGJhRlgzdWZEZUx6QTNmbnhzZzZaWU4rVWZhbXM4ZUordnhlZ25G?=
 =?utf-8?B?WHBJZEZDOXpsK3pKWFNDZWc2eXM2Wll6M3hHN0hIVlg2bElmNHZoRjFEZ29r?=
 =?utf-8?B?V08yVlhoeEczUFBkVGpDVkdTUEE5MnV0MmJIaGU0TjdScW82Ukt6Q1RLcUFo?=
 =?utf-8?B?czIxUXNJWFN2bkh6RERJaGQ2Nk04TjhBVGpYK0ZTeUJnWERCelZZMUliZktH?=
 =?utf-8?B?bFhDc2d5anA1Y3NxR0dmMENrbkJoN3B2cm85UUdRc2JpbC9SU3FRVmdoTEQ4?=
 =?utf-8?B?ZHBpWVRQNFU5SlJITitaOWVZVWZ0VFladnNuZUxzRHg1czhRVzBqYXh3ZWoy?=
 =?utf-8?B?eCtNeWdsYllsUlBlaVRRTGU3K0YxRFdPNVhZcS9IeXZKYmdmaGwvc3A1QkY2?=
 =?utf-8?B?TmhpWWxwYlp0azdHdkVQcDl2UHF0dnhGTXNzTllwRDI5dUJKNU9CcUZZb0VX?=
 =?utf-8?B?Vzl1eVY5Vm13a05YQ2JlUlNoUXJlSHQydVZJSmhrTmdidmc3MkRDSHpCSm9E?=
 =?utf-8?B?RzdtUWM4cXVobDZFWncyNi91RjZKRm1sZkFvM0xkZVg1dXA0S0Z1K2VkZ0hm?=
 =?utf-8?B?UXlWRTVQUVBoRXhqaUpRcnM0MjJ3SHdKWnQxTGNJNTNTajdXbEh6bS9Ua0lV?=
 =?utf-8?B?T2l6bWNLOUVvbWRFN3BzbzJqcWdQczFwN0p2bHZQMXR3amZpNVZtaTFTV1Nr?=
 =?utf-8?B?WFMvakc2WVpCMkdReDcwR3l1VVZJVk1pVEVOYmQwM0xZL00wam0yemQ3MytZ?=
 =?utf-8?B?WTlpMXNMeVhTcUVIYTNFMk1wY2N2SnFCQmw4dDBBM1UvUkJ5VktEbDgyekNo?=
 =?utf-8?B?cWpsWVFUd09WWnhiNDRqbFFHRG1aS1ZOVWhPUXdzWWdBUGR5dE1lQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4CF7672C9A86447ADAA5211DFE4C107@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fnUumeMej3+xyRWZwwn2escOIjH5cqYwJn5wuszFtm8nH8NAaiihnV3mRHhzo8D+BnYreXIx1Fr6qeCxQacMVJPSLyAO1bHG9Q5Ei19Gqn2H4bC8Vcu29DLL/AuiNaPMYklm5xnON9FdLnFxBEc780vV955m6LZ67lnBi3ZnmDxnPjOJUdpTt1uXXvo/zJ7RgSyUv45RhY2Wkl2A2Ct/v7wiBq0aFAXHn24WFU7rHJ75+0EhnQ2/PNYvSHieG4SNNJNFhjrqxldZjAvYFBLcrCHVH5cN1Kme2eWHprSRiSNUXOqsOWPZMwlKbqRN0xpStom8x3n6NDru6Jr16H85EQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9b835c-5777-486e-f3b4-08df3fba9af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 06:11:20.6112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yiPrM+iJUHQcb247HmQ2i0OmK74Qkm6BnUXgKJG8LXL+jeOmIsnGg3N5s7MrayEfdpVfNlhqRxZTh4SzBkTwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7159
X-MTK: N

T24gVHVlLCAyMDI2LTEwLTI3IGF0IDE3OjQ5ICswODAwLCBUYW5nIEJpbiB3cm90ZToNCj4gRXh0
ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4g
DQo+IA0KPiBtdGtfaGRtaV92Ml9icmlkZ2VfcHJlX2VuYWJsZSgpIGNhbGxzDQo+IGRybV9hdG9t
aWNfZ2V0X25ld19jb25uZWN0b3Jfc3RhdGUoc3RhdGUsIGhkbWktPmN1cnJfY29ubikgd2hpY2gN
Cj4gZGVyZWZlcmVuY2VzIGhkbWktPmN1cnJfY29ubiAodmlhIGRybV9jb25uZWN0b3JfaW5kZXgp
IGJlZm9yZSB0aGUgZXhpc3RpbmcNCj4gV0FSTl9PTighY29ubl9zdGF0ZSkgY2hlY2suIEFkZCBX
QVJOX09OKCFoZG1pLT5jdXJyX2Nvbm4pIGZpcnN0Lg0KPiANCj4gRml4ZXM6IDhkMGY3OTg4NjI3
MyAoImRybS9tZWRpYXRlazogSW50cm9kdWNlIEhETUkvRERDIHYyIGZvciBNVDgxOTUvTVQ4MTg4
IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogVGFuZyBC
aW4gPHRhbmdiaW5AY21zcy5jaGluYW1vYmlsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19oZG1pX3YyLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19oZG1pX3YyLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfdjIuYw0K
PiBpbmRleCBmMDI3N2ZjZjMuLmM5NGQyMjA0MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19oZG1pX3YyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19oZG1pX3YyLmMNCj4gQEAgLTEwMjYsNiArMTAyNiw4IEBAIHN0YXRpYyB2b2lkIG10
a19oZG1pX3YyX2JyaWRnZV9wcmVfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+
IA0KPiAgICAgICAgIC8qIFJldHJpZXZlIHRoZSBjb25uZWN0b3IgdGhyb3VnaCB0aGUgYXRvbWlj
IHN0YXRlICovDQo+ICAgICAgICAgaGRtaS0+Y3Vycl9jb25uID0gZHJtX2F0b21pY19nZXRfbmV3
X2Nvbm5lY3Rvcl9mb3JfZW5jb2RlcihzdGF0ZSwgYnJpZGdlLT5lbmNvZGVyKTsNCj4gKyAgICAg
ICBpZiAoV0FSTl9PTighaGRtaS0+Y3Vycl9jb25uKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVy
bjsNCg0KSW4gZHJtX2F0b21pY19oZWxwZXJfY29tbWl0X2VuY29kZXJfYnJpZGdlX3ByZV9lbmFi
bGUoKSwNCml0IGFscmVhZHkgZW5zdXJlIGRybV9hdG9taWNfZ2V0X25ld19jb25uZWN0b3JfZm9y
X2VuY29kZXIoKSB3b3VsZCBub3QgcmV0dXJuIE5VTEwsDQpzbyBJIHdvdWxkIGxpa2Ugbm90IHRv
IGNoZWNrIGhlcmUgdG8gcHJldmVudCBudW1lcm91cyBjaGVja2luZy4NCg0KUmVnYXJkcywNCkNL
DQoNCj4gDQo+ICAgICAgICAgY29ubl9zdGF0ZSA9IGRybV9hdG9taWNfZ2V0X25ld19jb25uZWN0
b3Jfc3RhdGUoc3RhdGUsIGhkbWktPmN1cnJfY29ubik7DQo+ICAgICAgICAgaWYgKFdBUk5fT04o
IWNvbm5fc3RhdGUpKQ0KPiAtLQ0KPiAyLjUyLjAud2luZG93cy4xDQo+IA0KPiANCj4gDQo+IA0K
DQo=
