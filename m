Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=60.244.123.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794971657;
	b=ywKpS+PekYFCcY9L3E0T+yy4vj+yOs/r3bK6GBPLcY9yiCN8h7npnMa2W0cMgmb9oTsa
	 U2gzrLSYvUjDlvV+tkz/sqxSlkFy+dwBjV9FcfodVlL8ci3BitCl55CL6H+weeTcfVCGC
	 7pJ3xmBtS2WrzJF7uxwREuE5rvtHQK7SBX7TX2sytxKMMIdrLHqICfdMZ8fk3PZIR34/i
	 YcEcFA0LxtOm1o+MdTRqefn73E9JEw1O5lq9l/YDkb+0MqeysdmKoI8oT2J5P6Pd3bwP/
	 ROmVCfMW86mR2ZXXbD7zpSxBWuNmsVRAlkOuJTgSKoVA5fahbx9Yknaopq3TcK6HFwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794971657;
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
	bh=nRxu80uyoFPR8LTbQrqJIBb5v5KYS3YE+Wo9FpD5T2c=;
	b=YDugxydQQyzuBBXWR5DqvNFcyzDNdHE5Xc8kSkh0x9H1DmEBKlPbeGtZqoaQiFPsOTdR
	 +iJHAX1alto0K7cvDLPC6fFQyGtLIiPw4QmCYwtsIjnzxXjEneedWjTpZ5KGp7ZqWClVh
	 7xTb+2oxbGQUo+FmYHkoO7GLGkguTDpZ2XvW3LDacYqplcsvu2YZPwPpYZfErW+2ENyoc
	 qKSgnPdQEWwuOMTFzPJWyfbzbGd/zaDxGDLt+Mpr6Lw6ZAvXmiAwO06Z37RpptUzUqFW5
	 T2FHaLSFy8NTQZB6RQJaVbQJrAj/E0tlhg1kz0+mBX8i1vDyewJn7Wb0J10nE3JotnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=MVBvNipD;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b="c/NqcBGW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D8606A31C;
	Wed, 18 Nov 2026 03:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C82D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=MVBvNipD;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=c/NqcBGW
X-UUID: 20b585c0e2fe11f1b1788b6acf885367-20261118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nRxu80uyoFPR8LTbQrqJIBb5v5KYS3YE+Wo9FpD5T2c=;
	b=MVBvNipDtLB18brYTVL4EYYpvESl7UrjcUL+Shy1quUNWYxz/TNxeJqBwZLr6KnGWRVev0u1ab0r9p0jaSzlPAEaQj+0C843I4nKoZ64fd+dfNJFLQxJwk+PRzo4+dRP0UQcR0UzIz6QOUhIJDbX+31fF0bBGkVPRuHdyfcXEyQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:7d68544d-b865-4ba3-9a09-7c699dfc178c,IP:0,U
	RL:0,TC:0,Content:8,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:8
X-CID-META: VersionHash:b0318ac,CLOUDID:5fc70031-f289-4656-bb36-27baf4489f11,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 20b585c0e2fe11f1b1788b6acf885367-20261118
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1949330741; Wed, 18 Nov 2026 11:14:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Nov 2026 11:14:11 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Nov 2026 11:14:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT+dFU/2ti8xNIve+pr7Oojyu7+C0ZpGu3lNEJio5siQsSaIrmPFQHlg6o0X89t53nR+U7WYSoZg280Gji4hyTh9XphcVaOlsYytsn55TjIYbn8QuPJ9MXhMrYS9A/F3yv5Ez3lnL0epGeeZEho2WqesENEAFXVulC9nyGp0z8U0+X3qQMOkwwr6UTeACQmHR3wROFpRHkwcCAD9yYGBJ+TDunOu+vtnDaFLa7QUQF7Jkw7ftcZ4x1+GRg+tYz50K9WLlI+sJILjn6nZUW4qslHV7ogFQWuudYPoeiDCCCfQx+N5dvtTJu1DvAtlVkFbv27FHUbIQ30X4n2f5UwIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRxu80uyoFPR8LTbQrqJIBb5v5KYS3YE+Wo9FpD5T2c=;
 b=S8S5Ob1paGmvIYvBJQtLZQQtMyvOOaj5YAEnYTpNCuSBgcxp8WEX4nYwdCYYlZ4C873rTA/9fDIiOfClPMq3bvRA3lQ1TkMKmseLEVacneS9wnUdzLtftyO2F6xTjtyCjSfLyvNL8kjIMYw0vGgi5x55t0iMT8DFyCRiTnJ1xQz1EnKNQuq+fml0GMo37aY6BgZgbuk3a41zOPWplt7MdNgWtMBPfcBQdHF0GM6rwHWjfiL2BplgcT1s5Hr8gA8Gx77Ra21IchnHhwHzCDc9nIwKoCMt+ORqj0Tdxb4Hw1KdTL3LLTDZm0j1boGS9bCieRU3dECR7AKDjxiFX2H6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRxu80uyoFPR8LTbQrqJIBb5v5KYS3YE+Wo9FpD5T2c=;
 b=c/NqcBGWwH96Q6bO6+riDbDA50HfBhDqhpf474c4z6ZVUCjTVluhJy2zS5bcAr7ToKARf3NjacfNdjilizP98D0rKqnnZ3bSdcBHToggLojId2D0/Ck7Fe+0ViP2seZYcKkXlhT0oT6153hIhf/JKQ+Pf0v+6guRtrq1DoJs22s=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by OSNPR03MB10134.apcprd03.prod.outlook.com (2603:1096:604:499::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:14:07 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 03:14:07 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "bisson.gary@gmail.com" <bisson.gary@gmail.com>,
	"rva333@protonmail.com" <rva333@protonmail.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
Thread-Topic: [PATCH v2] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
Thread-Index: AQHddsFGSy5OtV+/m0a6QonFMFgr+LczKDuA
Date: Wed, 18 Nov 2026 03:14:07 +0000
Message-ID: <c0b742895da0e7d8e97e7428fa37dc67b461627a.camel@mediatek.com>
References: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
In-Reply-To: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|OSNPR03MB10134:EE_
x-ms-office365-filtering-correlation-id: 55282da0-34b4-4084-79c6-08df45220205
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|42112799006|7416014|376014|1800799024|6133799003|22082099003|18002099003|261009223027099003|3023799007|56012099006|11063799006|10067099003|261102123227099003|261028144727099003|261026140227099003|261022075727099003|38070700021|261022105027099003|261021121427099003;
x-microsoft-antispam-message-info: S3TOgZ3A/vgQ8Q9O4gW/e6pBMVovqylU9Y/O/jt1Ls6URGfsDxLRoKRs7E+oaPEWSN9zJ4v3dTBwlvHVIlFVcZ+IXBIwwbmXxs+Vk9tSThYuRrzRbXlKxcf7+9Dvd3+Gi+keXFSvyItGM5NZingrIq1PtXCdwO5855w2H92Pm2YjMNlk9sa20Od/HtiHBplfZQ2gBGffxTtEV3VIhhnAb5UMSVz63sHNNSw+lvTqwzhK6xuxi0ZxCIXnAYk54I2yox2xsoizZdCD9C6Nk6nSJJ6QVvSPoOsfQV3SvvSDnguXIsRucVaL612j0lJlgq48edZOGQ4B7EN/NjP6biJVOjuZrzvDA3NZ9XNb7JYCf6xlzfRcGwBbgd8gkybDKwy0g2I227YBlbwwpcXCJG5Ya6xnS338N7IjPZOgAD009ho0aYhEFO0qCBNqMfcEQvBrzONvRN8th9Z9YLzjQWQPng8HodL62zBQktUWhohf0TU8YYDsnY6K2fuMpKyNj3xGQl9OsTpuzX4s4MwNY4JcE36AwdAMqEn8+MWiv7op0vOwPi2dXXCh25o3+g6wcu2pcy6PoZCwRF/UQX8AYz2Q9FkKWI7tdJVSwDL/2Agv2dOHZJIATu7koTitY8KLsds17bMCV08dj3tA4kLdRkQsL6M3V/dEuWWMw4q+rAsZGr8aSHe2B2tvV3BjXHyUKmRRM9hemjd+qyt1a+jXqZw+H1nbXEP7YA9XS7th40xyn3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR03MB9902.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(42112799006)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(11063799006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022075727099003)(38070700021)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUlQRVBxRVVRRFcreWdMS3l3bmpmNFRVb1ZIVUVwbmgxMTZOYkdVeGhMZkxQ?=
 =?utf-8?B?V3VkWTFsZHJGTUZlWWxnYngvWDZxMm1CU1Y1Z3poOU5UeHZIeHRPa2wvMjlG?=
 =?utf-8?B?dHFGcVl5eUp3b2U3K0Zmc3JTRFdubmM1SXgwSTNYaXM1VEpPUFl4WHFjRDZE?=
 =?utf-8?B?T1hpeTJVUmVxL3YwWkVQVTFBbEc0Q1E4RFI2VTZwU3N1Y3JTbkkwaTN2Sit2?=
 =?utf-8?B?dy81dlhMTjVrSVQvRGdhVHJUa0JvbUNWWlpwRTZxUjdnN1pUeUhhMXR6elkz?=
 =?utf-8?B?NlBjWnRaWkZqMG93elNHVlFrVVFwTk1jU0VCWDRDdXBDd3IwRlZkcjJWWGZC?=
 =?utf-8?B?Ly9TL3NzVDgzeTRUaHltOXpBQU1QL01HS1NQbUpiRWJIcnRxVjhiNTNlQTlU?=
 =?utf-8?B?S2xodHZJS3Uvbm5KdXlQQjlBczFhVlQ3UzZMek5iSzRGQU9rQUdXa0NUQUFR?=
 =?utf-8?B?cFM2MVFNaVdCdFVpamxOVlhxWUdsZVF6THRUNWZLT3NZSTI3dEhNRHh1ODQ4?=
 =?utf-8?B?L1l2MW9HWXprSmJyQ2tVTFZ0eFRCN2pkMU1LSkVqSTVrYThPWU0yOHoxakxh?=
 =?utf-8?B?dlQxUENWYkkwV0ljR0N3UGFCcHJNbkJ0Q0p6LytNZFhMOEVJLzJ4U2V0eU5Y?=
 =?utf-8?B?bExNU1pnRFlrZkV1cXlQVkY5V3RkU2FtQ24xVmRMWVZoTVFYSDVNcmV4QW80?=
 =?utf-8?B?enhSZHpzcnVzN3ZIY3RGTGQ0MGIwaExzQjZ1VFdFWFdWTlc0UEpEZ1hMa1Qy?=
 =?utf-8?B?aXl2U3ZrcittcW5aYWhaSmVxbjlQNGhPd2lpdGxVVzlDdXViUlQrWGx5NXRZ?=
 =?utf-8?B?TDE0UVA3SnpaOGIxV255eFBRNGRaeTQ5MWdodlR6UlM5aXRhRkcrL1hQZUE4?=
 =?utf-8?B?Rk5yOHdqbVd5MnNRRldxbXhXQ2IxZlpFMGhQZnFnbzRJVWtPRERHTlFKQWc2?=
 =?utf-8?B?U2FDVEtuS2VrRXd3Uk9WaDlzeHdIbWVhdHI2M0dVSnpyRkIybTJWUnFHZUUy?=
 =?utf-8?B?Y3JmblRaeHF4OVJ2ZUFocU44cmNrNzZ0Mnk2Q05HTnhQcnliRzFkMm44bzJn?=
 =?utf-8?B?eCt1NjhXbG5MM1RScTlqWDFKSkluUk9XSDg0eFFneXF6RXFISTZsVGFBS0Rv?=
 =?utf-8?B?d01QL2p2YWZlV2VzVFRUNjQ3NkowcUhUbjVOUm1VN3N4NXVNRWZwS0xHd0ds?=
 =?utf-8?B?Q1VGeGdUamhqZGlKaElna2IxVlgrU1Jyemo4MDJBT1d6bUprOFZ6czVFZWk0?=
 =?utf-8?B?dlRSUW1UNVpyeVBxUkU1TklKand2OC83dm0rcTVNK0EwNXlqeks5Sm5OYW9a?=
 =?utf-8?B?eUxYSmQ2aklHTGZvMEtvcld1UHRZazIrdG5vL3dCVlBXMC9YYU1TaXFMd3h5?=
 =?utf-8?B?a2prdURYVDlUdHdvN0dZTkoyT1hkTENXajFJSzY0clBwOHZpYlEyUjA1bTlu?=
 =?utf-8?B?eXAwc0VBUlJLZUQ3bHRVc3V1UzdlUGNkNEE3Qlp2bmRNNjc0YzRwNUZsZ3ZM?=
 =?utf-8?B?RzJRY0tONTdJenpqNks4aGoyenk1anNlRlRpOE4xOWo2OEJSdy9hdmx0WHlX?=
 =?utf-8?B?UElOV3dNSTBza2duUk0yUmFYdGdNVml1RmhjcVRVdFZmSXZXRlgyYXNqYU9r?=
 =?utf-8?B?WTF0b21jaUZkV2IvKzExUmgrbWZyNkRVVEl0TXBDT3A4VUh5b0hQWjYyMk4z?=
 =?utf-8?B?ekJwcm9nN1JlZ3ZFWXdsTnJJRE1CNmhNdzk2STBkSHY0TjFGbXZQbHFmNUVj?=
 =?utf-8?B?ZUhsdGltUTZUUGx4YmEwSkhaamtWekZyVTd2MU04ZlFmT2lCdmpXWFdWaytP?=
 =?utf-8?B?MW9rZWtuUFlmYjdUWU1EbkltN21Cbi9sU2wzcS9zTUtJOElLMTllSUFoWGw4?=
 =?utf-8?B?U3JKMVRRc2dqS1hIejZoQjRyTDlxclp6S3FYNTNLN2haZmNXRmNQSnd6RTNH?=
 =?utf-8?B?eUZpS3lIQ0VOZitzakZMSFJrVHRTLzVwNU1yUkNOVjd3SnJEZVU0Ni9pTG9q?=
 =?utf-8?B?WE5IRU40S1pmNkVjSFpweGVrWmNaaXNkSHk5WE56V0h3VmUvQU5JaHh5ZVQ4?=
 =?utf-8?B?bGNrUHFWbkVNbndUMEJzVWVjVVBHa1V0WEdURGF4SXJ6N01RMEZlV2haNzdW?=
 =?utf-8?B?WU4xVXR6U1crWHpOQzRTUWNBeWVpQmJMcDVSZENGd2l6dFVyN3ZhT0Zoamx6?=
 =?utf-8?B?RTJIY1pYMzFsNzRuK0p0V3BvVVc4OW9EY3R6aVlLV3NjUGdSS2xCY2tLY1V4?=
 =?utf-8?B?d24zU3NUMHMyRGJWWS9FaC9Qc0cyejZ6MlYzV1JDLzB2cERjTWk1TjNkK2Fm?=
 =?utf-8?B?ZzRtTUl1SmdLVlpCWEpDR1pnQ1ZHMWlrYlRDSXZ6bXlwRlZmeHlCdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3BDC5D520D70F43B6AB01BC0656E3E5@apcprd03.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: bOtit1flFzycVbK8peDBxhvBEn42FjNClSm3CRLhXD4Ta3K88hqp3+PMm8a+ec5w6sa2TvR6ILbt2FC5Vlp46uyAtOiOChdhIL7+mrAUryF2tMfv75x9/KbYiv2ubNU4zEYNjyU27BockLM59df8OO+QBzD8ZrSmR0GnGL8JmHsHpEfo9fUcWr3nMw6iVP82AwmtcY9LelPU48MLCTREnN5JrJecUidJyn0tmd3n/8RI6fo/6/qH6ZqDjLUgshAWgC9uYUieOnfbVkcaINo7tPuYcO1/roqEG6sUP29V89p9/2ZDI53s7aqjv4N3S6COTtt1/veRDzPBi8pkc0+8kQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55282da0-34b4-4084-79c6-08df45220205
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 03:14:07.4657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bd9ksnNB3erbphNv8LpOQ9VmQpMoWRkwUFh4KGZ7/9aMqQqDuMYKu4Gpbh6oCPzzWS1CrKLuTM19alePnYhU8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB10134
X-MTK: N

T24gVHVlLCAyMDI2LTExLTE3IGF0IDIwOjI2ICswMjAwLCBSb21hbiBWaXZjaGFyIHZpYSBCNCBS
ZWxheSB3cm90ZToNCj4gRnJvbTogUm9tYW4gVml2Y2hhciA8cnZhMzMzQHByb3Rvbm1haWwuY29t
Pg0KPiANCj4gQ29tbWl0IDc2MjU1MDI0Y2FkYiAoImRybS9tZWRpYXRlazogbXRrX2RzaTogZW5h
YmxlIGhzIGNsb2NrIGR1cmluZw0KPiBwcmUtZW5hYmxlIikgbW92ZWQgSFMgY2xvY2sgZW5hYmxl
bWVudCBmcm9tIG10a19vdXRwdXRfZHNpX2VuYWJsZSgpDQo+IHRvIG10a19kc2lfcG93ZXJvbigp
LiBMYXRlciwgdGhlIGNvbW1pdCAzZTE5MWVkZGJkY2IgKCJkcm0vbWVkaWF0ZWs6DQo+IG10a19k
c2k6IEVuYWJsZSBIUyBjbG9jayBvbmx5IGF0IHByZS1lbmFibGUiKSBtb3ZlZCB0aGUgY2FsbCB0
byB0aGUNCj4gbXRrX2RzaV9icmlkZ2VfYXRvbWljX3ByZV9lbmFibGUoKS4NCj4gDQo+IEhvd2V2
ZXIsIG10a19kc2lfbGFuZV9yZWFkeSgpIGV4cGxpY2l0bHkgc2V0cyBtdGtfZHNpX2Nsa19oc19t
b2RlKGRzaSwgMCkNCj4gc28gdGhhdCBEU0kgcGFuZWxzIHdpdGggTUlQSV9EU0lfTU9ERV9MUE0g
Y2FuIHRyYW5zbWl0IGluaXRpYWxpemF0aW9uDQo+IGNvbW1hbmRzIGluIExvdy1Qb3dlciBtb2Rl
IGR1cmluZyB0aGVpciBwcmVwYXJlKCkgY2FsbGJhY2suIEVuYWJsaW5nIHRoZQ0KPiBIUyBjbG9j
ayB1bmNvbmRpdGlvbmFsbHkgaW4gbXRrX2RzaV9icmlkZ2VfYXRvbWljX3ByZV9lbmFibGUoKSBv
dmVycmlkZXMNCj4gdGhpcyBiZWZvcmUgcGFuZWwgcHJlcGFyZSgpIHJ1bnMsIGNhdXNpbmcgY29t
bWFuZCB0cmFuc21pc3Npb24gdG8gZmFpbC4NCj4gDQo+IE9ubHkgZW5hYmxlIHRoZSBIUyBjbG9j
ayBpbiBtdGtfZHNpX2JyaWRnZV9hdG9taWNfcHJlX2VuYWJsZSgpLCB3aGVuDQo+IE1JUElfRFNJ
X01PREVfTFBNIGlzIG5vdCBzZXQsIGFuZCByZXN0b3JlIG10a19kc2lfY2xrX2hzX21vZGUoZHNp
LCAxKSBpbg0KPiBtdGtfb3V0cHV0X2RzaV9lbmFibGUoKS4gVGhpcyBpcyBhIG5vLW9wIGZvciBu
b24tTFBNIGJyaWRnZXMuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KDQo+IA0KPiBGaXhlczogNzYyNTUwMjRjYWRiICgiZHJtL21lZGlhdGVrOiBtdGtfZHNpOiBl
bmFibGUgaHMgY2xvY2sgZHVyaW5nIHByZS1lbmFibGUiKQ0KPiBGaXhlczogM2UxOTFlZGRiZGNi
ICgiZHJtL21lZGlhdGVrOiBtdGtfZHNpOiBFbmFibGUgSFMgY2xvY2sgb25seSBhdCBwcmUtZW5h
YmxlIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUm9t
YW4gVml2Y2hhciA8cnZhMzMzQHByb3Rvbm1haWwuY29tPg0KPiAtLS0NCj4gDQo+IA0KDQo=
