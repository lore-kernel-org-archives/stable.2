Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=60.244.123.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794366007;
	b=M0FY9nWbX7TbPjAN1QDC70pafJBVTTabPNqU3SmoSI7cdMEaKe14CaVDL+42FdrhOBft
	 ulrwdOeU8VT4tp5lcFLTXPFYXFgQGxhsLj2CloKGhtFEe85YcxaucsDgMjLoXl9cSowz0
	 cxvuHX0s/lzqU/XvAeDAia/wnSaUU/D/JGjEjSNA/80ZtjTYyjZsMsM0Pv1LxQy4xCTuA
	 Sj5RZmg/+RhBpG70OaZZ5thUaoxWkjtG4870RZrpp6VkXE8UTTH7cXIP3QnbK+qD0uoBI
	 EUkwS7Vnq21KP8nK+5QmbO/W3ctDJXNNg3DVw/57nfUhP6dJSd8+dz+icKyp4igEQDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366007;
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
	bh=hRcWzUGJSUPojWrz+zCwuVFdb28Qz76tpXzDUkH+H5A=;
	b=kRbtqc20M/vZftPOfXZ3xYRcuJMdUaEw1+3f/NS2duEwgNdg5O92DZtMzHRlGaHMY5uC
	 3uPR3Sq47P6R4QpXTIFxylhIkNzJFCZLTvcdrX+c1aspR+9f/74z8opXCoYiklnyFzRKG
	 GBTCWzrmTiYGUvbRHC7EOlDWQtER8Cq8MqEIUhbOQu5+PFIE04hSVFq3wT97pS3R31bi7
	 cPlDLWPVg/EywUB3HnPsPfi8KCrUL8VCuUMr2tfQRTOMaIfGr1moJ6ec9AI+6SJu9I1t0
	 1a30UmzJ9p60OynBBSwvXidtMpR/7IcfUwkcPnS5jUla/YSNZQU0InN2zc0XvHWK1GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=JVV9Q0YP;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=Wd3kC0kx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF789606A320;
	Wed, 11 Nov 2026 03:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF789606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=JVV9Q0YP;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=Wd3kC0kx
X-UUID: f9525ab2dd7b11f1b1788b6acf885367-20261111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hRcWzUGJSUPojWrz+zCwuVFdb28Qz76tpXzDUkH+H5A=;
	b=JVV9Q0YPh+VatAWKJO6lDQ1BCYpP6UxYAoyXq9YTxAd2sDzHsQBGeK+cr3cg4U4SKBGrdKKehEyE49fm4Occ7zV4+GSuUX1aPRy3xX/oZ6IkXJ7lZYRnxO1emyYoBTHHKae4iIsXHVaeRNMzxNAyNcriQa5CtNlbzveqW088wek=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:ca3d02bd-e0b8-4e09-bc05-e7ae4c5b0892,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0318ac,CLOUDID:6d89af30-f289-4656-bb36-27baf4489f11,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f9525ab2dd7b11f1b1788b6acf885367-20261111
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1061686805; Wed, 11 Nov 2026 10:59:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Nov 2026 10:59:54 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Nov 2026 10:59:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyLOp/oCRRDq4WPBFC24Badwz2eLQeNcbJOrzuQGQ3YsZejXGTCNedDzOYEnwJfjDHYmSAGZT3ui4Tybu/qSqr3Q4GqOYffL/vaY7sr17H6jFeb8H5J+6eXwgwMFK4wXykwfF3Gh2sflqpSeLiO0nzUGW/y9qanOSK0vGJatpkyCTfIlA5NoFsA5CqkmpmQe0W7i/LSiK4bFhd804Y9BkDFW+MRcyQg4QNIFSh1AYY8bUpMdcueuDZFJPxkdvvT+TRwEcnDMB9O+RQjxxDZ/F2iv9NPgRGYzBkM5rI8qRxHq47qp7L8aAX2KfvkyWzVYFa8tCFY8c5tDIDW59VBDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRcWzUGJSUPojWrz+zCwuVFdb28Qz76tpXzDUkH+H5A=;
 b=n9FAcddAxSWJb0jfR+3iRefdPKl90PGlbQqxwkhs79rsmlfDoamZ+5trx1ndrvouqL7wuslAzzDsMguh6iNYVOea1di6rijGozMSool/yE2ENLQfxsOW2dqtQdMZOkU9XZVDYJramcLtaVTtMQ3gzi1Bw/K5cWEB7V2K/fafwhPV3eADqSAR8rWlq5pvCzAWmN3xGqLJWCZISBVfvN2CKbFMtZSZQEgPqGTQCyGspspgCOFaQ0nyRnY17r/0k5kvX3klosm4Fyng9b8d9GDEeME6o1jb66SzeaT6g3dA88ultq3ygCXFsa4fGEtc9OSD5/NOXNdwthm0KJxB19nT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRcWzUGJSUPojWrz+zCwuVFdb28Qz76tpXzDUkH+H5A=;
 b=Wd3kC0kxcQ8Or3kpXi+5EoTOijOmrqAjBNd3P7q/NUHlLnjIpxkOGs+W60k/3oeT51+5i6WLlsqvSkfXAaZs1raChGkZ9fC22fEHlAdnNAz/tXqLtNfui/h/uOyQ4UFUSM2vV7RAz+ObAOqC6hyXLiv8UODIfvj7AMSj5WJBZfI=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by KL1PR03MB7972.apcprd03.prod.outlook.com (2603:1096:820:f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 02:59:51 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 02:59:51 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, =?utf-8?B?U2hhb21pbmcgQ2hlbiAo6ZmI57uN5piOKQ==?=
	<shaoming.chen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "bengris32@protonmail.ch" <bengris32@protonmail.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: Fix handling of long packet
 reads
Thread-Topic: [PATCH RESEND] drm/mediatek: dsi: Fix handling of long packet
 reads
Thread-Index: AQHdbTL7YTCXG1KxM0Ok117KYC2WHrcoNwqA
Date: Wed, 11 Nov 2026 02:59:51 +0000
Message-ID: <7bd197e91dd3998272d2c9de2edb38a885cab9c5.camel@mediatek.com>
References: <20261105-mtk-dsi-long-read-v1-1-0b6d9b67c011@protonmail.ch>
In-Reply-To: <20261105-mtk-dsi-long-read-v1-1-0b6d9b67c011@protonmail.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|KL1PR03MB7972:EE_
x-ms-office365-filtering-correlation-id: e3982f4b-1221-4632-12f3-08df3f9fdae7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|42112799006|38070700021|10067099003|56012099006|11063799006|261022113327099003|261021121427099003|261102123227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: 4Iv2wnPfA9LPNbX2UqPvV4nceCoIrcULyKTYgMzqitevOYvQRd36JaVICV8x2H1Vp8iWGsXLbr00sie9lf3mfFEUJ7oQez7JSMks/WItmFW3nQSiC4L5DAw+ymKtrsBsDBxGpnB0cJNHjn1XFzgwk7V6Cw/nwP6oqRugf/w0lbBk0t+R8GmsiLIqtQ+s8+GWq2+ss28qP6YEmOPanBjzOSmlRnzBDP+g+S6HcL2RInTTCLabaQ19wXS2SFENqO6fNUu1zTAMSLxNDTOMembUuBoilTc0L9knC/A4wqKe/O+jv5rVnIwwiYk1VlRTdvJd8QVoVzZjZ+NmQKbwCbhqCeDB9k5XxaUpE0pVEshNhDJDY1JR+BjpMsqK6vH0MRI37KHQR/J7AfvqPr3NGNkzUVNV5GAHtXYuLsbqYgeRnEbPf3xlI+7x/g57on3kAMXVuepq3rFm4ycJd8GolmOgj0Y6HDhdmLhKkIuqsjgNMZtRHFSzVlkqtgOYC2YNBn9hESv4E4WlRFZ3rgB0WPynp8KtO13B4vNGPTO7INhChe/Z/5G17aq6tZoADvYYlVtyyAyoMtrN36v7zozYyHViZZCrrYzL+KQQXZDg4iCjJ/ievauCPk9xIs44WGFejgPVFUAUCtbDCa1bbicbTS+nZpmnYbdoYF/rEqwg3G4lxuyihZJP6Sfommk8Wiu7CH02A2yEP1vVcSkksHmp4qiksA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR03MB9902.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(42112799006)(38070700021)(10067099003)(56012099006)(11063799006)(261022113327099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0s0NE1mbmJHRVYyZnNlMGhFVHltSHU1cm8yTmxNeHdVc2ZaNjB2YjZDUFYy?=
 =?utf-8?B?L1NsV3pPbE9nMURxYnpjeGloSEQ4QnBPb1VONmlzNVdaRDJhdDJjSVMrczRI?=
 =?utf-8?B?NytKUWNudVgxS0lTM2NITjFIaU1GUGtTNDBZbndvUGhEODlzM25wQWV4Rk5n?=
 =?utf-8?B?Z0RPeUY5UDZIaXQ4elBNTU8rdjkrcmtVVFVKTTErM2swbUs3NytlRFQyWSsr?=
 =?utf-8?B?dUYwY1hBNXFpQXJjWGthbXBwTkFrbTNndVMyU0VBbjdHRWpBa3krYStPRFRk?=
 =?utf-8?B?UEVvYjRNUHZKTU9zRjdzSXBjWXUwaFJoT0xTVXFaREZsUy8wUEhyb2ROQlZk?=
 =?utf-8?B?UlpydG82bXdsM1FUam1lTCsyRk1JVTMvc2EzNEczZVEvNjJXSGFXdDRUaUtI?=
 =?utf-8?B?ditrUHA0OHZieXZJYXU0dThIUFVPelUwZFdSQkhMYldwZytwU2Y1M2tTTitX?=
 =?utf-8?B?UUV4THBzWitsV1FJbUl2VGdNZjBDQW9wbkVFdHVpVjllT1B2KzBRdk1GaGZS?=
 =?utf-8?B?RzFvTnE5U2xKZ0p5YmtnNStUcGFPOE1obmxLZUE1TTRqSG5TdWJwMFR6dDRR?=
 =?utf-8?B?S0xUOUloc0ZyS3cvbGs2SVMxLzBxN2h4M2VuWVN6V3RVanF5cjBLVHhwM3pI?=
 =?utf-8?B?L05oNHhqTlJoR2I1TWc1MWlsTXR4Wm5sVkprZTMxZTA3aTg3RmN6QzlCdjVS?=
 =?utf-8?B?NzhHOG1ScEp1OExNbWtpeUcvVmpHSGh1OWJoTWwwdCtBT3QwVnZ3L05UeHRQ?=
 =?utf-8?B?aFNoVVZDK0FmK0p3dVVnajhNMHg1KytTS2dZeDFiRjN0U1N6MHBnMk5sMHo2?=
 =?utf-8?B?OXdidjFRVG9iR0svcUpSMTErQ2I0UWVTYkZQc0ZZYmgwMnNYOUFkTFkrV0Qx?=
 =?utf-8?B?ZHNCZjBVVXVGQlI5V2h6Q0l6SDZURmkyTFhiT1R0dERpd2p3dkQ2N2VYQ3Fj?=
 =?utf-8?B?Qmxld2N6enhvc3lOcnUzNmZTNVpDeGtFWnBKOGJNVldIcmV5dVNMMmZtOGVw?=
 =?utf-8?B?YkUwL00yYnBUcURIRElUWVkxQnRBd0poL1BLUm1ranBrZ1BjeDdrWi9oMlRM?=
 =?utf-8?B?eERDY2Z5OXBRY3BJUEdmZURzSEE5MFNlckhwRk9DZkRHdnhuNnduNHdhMnRO?=
 =?utf-8?B?OGxGaE5rQUMzSUo4dzM1WndHWCtvajQ0RTJrRzMvS1NTd1F6bUpNUzdLczE2?=
 =?utf-8?B?REYrQUxGeWdtaEJwaCtEcFVSdWk0eVE1bEkyRkR6T1lXRnhGbFljcVNJamJp?=
 =?utf-8?B?NW9GNDF1bGJqRGdoNVZnb2JmK281QU1IdEc4c0REdzA4L1B0V3FUMWVKYkZE?=
 =?utf-8?B?bGZrQk5sZm9ZMzN5TlBwazhaRGtNakJYTkRZb3BlZVJBcmxLZ3A5MGNDK0dj?=
 =?utf-8?B?NzViYVFiMEZCVDM4UGt0ZlZORnAwV05idlBRNlQ2Q0hmTmI0MDlFRDBRamk4?=
 =?utf-8?B?OXJNVVZub0RqRk5MYTJybGZTR1hueDhPM1h5ZVFlb0s0QXdOY1F3dzIrUTZD?=
 =?utf-8?B?aE9YNDJMWXBUMG5VMXdXWitnVlZJcGtxLzdwOEMydFMzb0tXK1dBT3pKUnhQ?=
 =?utf-8?B?UmVLT1I2UUk4UVdhUVpBVUU2cG54VVlXd05tRWhrdWFTN1cwNWdMMUF2cmhu?=
 =?utf-8?B?NW4xUEU0MnlaV0Uwa0dBWGhFaXpvZWE4YVdFYU5pZlBpa0lWcUs3Tk1PRkFn?=
 =?utf-8?B?ZklyOHJ1dXgwY25rd05OV1kyeUFFcGo1WXVXQ1IyYVViNVlXeElnTWE3RjVp?=
 =?utf-8?B?VWN5dlg2ZHFrTnQ4VHRZQU5KRldhYTMxU3EyVFNyWFlmVk13UTRyaS9ycmpB?=
 =?utf-8?B?VEdDZU91Zzd0bnhrMHdzZE5oQ0ZhaXpOWUJCSFlzbStNTC8xWkZwb25uZE5i?=
 =?utf-8?B?dUxwLzNEV0xndVlabFE0WEJhNjdlSmVkakRCckR4Rld3aVlKZDlZYjZSSGcw?=
 =?utf-8?B?YXdJMG8zWkdZbGcwMEJGOWVxaEk1WGR1VzlSNWYrRUhnVVZ0ZTFnZE9iaUxO?=
 =?utf-8?B?Z1RtdVlIY1hGbzFVaXp6TVhQWHJTVDhyL2FoQ2NreDF1ZUpwWHRZcUZvZkRL?=
 =?utf-8?B?RlBCMHhDN3pVaXJyTWlhMkZSZEw1bHBYMmU4ZnBRWTZiRUtCTURnSVdxaFYy?=
 =?utf-8?B?NmswNXVGMDJBUkM3ZDdRVHZ4Zm5zOHN6bmdjL3lMMyt1dEZESmVETm5oWTdK?=
 =?utf-8?B?WEdydlpGTkw3K1EybG1jbGt5Mmx6dWZDSzdDMVFSZnlSSGtjVjJXeXZ6OHdW?=
 =?utf-8?B?TytBWDF6c0dlZGFMTjV5WG42TVFCRlNiajZUaGZJYmNWeS9leVJqQ05EVitk?=
 =?utf-8?B?RXlEL3RtNkdoNVpqSkwyaG5YRDdwTTJ0aDRRUXJGNUh0bzJNcThhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEB83C42A735ED4F8BFF33FA468B2170@apcprd03.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: EId8Yv0OhCGx/8C163/azNimszQA3tLKOXbTu/ZWtTLGDYJfopj94guruCqmEDXaYkAXgNORFRdNtc5MhAXVMP/BnYMv2F4kFagZ2DPKxSEL4fvlPP1tps1aoYw/yarnqhbvPyHDs9DPxN0xYlk8Ijfk8/SJgjhn95gOQc6OlgsfEbFE2IVMtMt2Cl09QCQNZPwANlA8G8lQ+kY+6vS5qjNyHa6f61UXcpjXKFCge9KKQRhN8qijJypCUf31nN+66vG9E5SG52HnQy59lcL16MTRkhJzRWyFXfZo1Wo0phR+6ALTHWsIEi2opoTwxB08ZYvuwgrVLjEmgLszHOGBiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3982f4b-1221-4632-12f3-08df3f9fdae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 02:59:51.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ONhTve74wmatYT6YZX98jlZvLHvj91ShQCv5nqGFYj0N8VSdzdAAiXhFPFgfG1h39Rr49pJ5uTfW3Ftqkpn0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7972
X-MTK: N

T24gVGh1LCAyMDI2LTExLTA1IGF0IDE0OjM1ICswMDAwLCBCZW4gR3Jpc2RhbGUgdmlhIEI0IFJl
bGF5IHdyb3RlOg0KPiBGcm9tOiBCZW4gR3Jpc2RhbGUgPGJlbmdyaXMzMkBwcm90b25tYWlsLmNo
Pg0KPiANCj4gbXRrX2RzaV9ob3N0X3RyYW5zZmVyKCkgZGVjaWRlcyB3aGVyZSB0aGUgcGF5bG9h
ZCBzdGFydHMgaW4gdGhlDQo+IHJlY2VpdmVkIGRhdGEgYmFzZWQgb24gdGhlIGJ5dGUgY291bnQg
cmV0dXJuZWQgYnkgbXRrX2RzaV9yZWN2X2NudCgpLA0KPiB0cmVhdGluZyBhbnl0aGluZyBsb25n
ZXIgdGhhbiAyIGJ5dGVzIGFzIGEgbG9uZyBwYWNrZXQuDQo+IA0KPiBUaGlzIGJyZWFrcyBsb25n
IHJlYWQgcmVzcG9uc2VzIHdpdGggYSAxIG9yIDIgYnl0ZSBwYXlsb2FkOiB0aGV5IGFyZQ0KPiB0
cmVhdGVkIGFzIHNob3J0IHBhY2tldHMsIHNvIHRoZSB3b3JkIGNvdW50IGZyb20gdGhlIHBhY2tl
dCBoZWFkZXIgaXMNCj4gY29waWVkIGludG8gcnhfYnVmIGluc3RlYWQgb2YgdGhlIHBheWxvYWQu
DQo+IA0KPiBGaXggdGhpcyBieSBjaGVja2luZyB0aGUgcGFja2V0J3MgZGF0YSB0eXBlIGluc3Rl
YWQgb2YgaW5mZXJyaW5nIGl0DQo+IGZyb20gdGhlIGxlbmd0aC4NCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVzOiAyMTg5ODgxNjgzMWYgKCJk
cm0vbWVkaWF0ZWs6IGFkZCBkc2kgdHJhbnNmZXIgZnVuY3Rpb24iKQ0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBCZW4gR3Jpc2RhbGUgPGJlbmdyaXMzMkBw
cm90b25tYWlsLmNoPg0KPiAtLS0NCg0K
