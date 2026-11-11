Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=60.244.123.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794363597;
	b=eoP4YHadE6+MbvYonCDEvNsx0GvEZ2tokiOdGJdBm1dJMC0x/Ai1tp6BwpHIgjItjrzr
	 gky2xGpHZV3RnQmdF8U8wnfKpeeARDmcLMLhUfxnA+vJT5NL0PFtR6xQhJD3X05d9+Nnk
	 FStszoU7xmkF7XurChz+s1dLh/r2EmktHMW250lQusryqeBuHq6Qk2u9wvNuPGRXfjHlz
	 bOVwKFI9u6G9RZEHTWl+pvCne4e8DpHp1Lb3gyiUwv7hyliFnBKNYRlCINm9S35O7wBYS
	 UntFOFt4mWJJdTx5X1s5vpNTSwCmnp2/BlH4nyMS+QrDlFYn2lQ6Z6LeINyyQfPH4Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363597;
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
	bh=h7xfzXdrxEIeKV6hEOEEw0EDL9A6sSYsVU9YJTdU6Zs=;
	b=lHeo1u+bQdL2Fez267azPnMtdzz0CVufPF5zhe8giWEzHFm+9ZXxMFc1RPme7gz2rFXy
	 RsGhXvisYYP7CXoQRLEhsbhfx3wIs1jIBcnGVi9raz3xWVEqqi7brmc0br/Qnf5orzrve
	 8IrLEYW93F7GXCfEZE0y6Lmb4CplTr5xhtUEhCUf0BBBoXhOeTwyA5O6oqHnZmNQ6CVG/
	 SaRwjWw4S7vShVF63yJ8At1pc3wGBeeE0oxLjaz6AJAaIhJ2I7fwAfggAQgYt5crw7WA4
	 ISgf8cu693GV/zkQR5qLHc+9WlM3knLpdeXQ5L21l+ViyC63yW+BKpGCRuTwYFwy98w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=Kyey1WGF;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=Dj1rCile;
	arc=pass header.oldest-pass=0 smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F5606A320;
	Wed, 11 Nov 2026 02:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C8F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=Kyey1WGF;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=Dj1rCile
X-UUID: 5fe99a3edd7611f1b1788b6acf885367-20261111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=h7xfzXdrxEIeKV6hEOEEw0EDL9A6sSYsVU9YJTdU6Zs=;
	b=Kyey1WGFrJmcSJFPFpHu7l8+/BeDB2gaF8uR7d2H5k1bgFCWHXFySeoqb/Xx4GYKsTGred6PFD9dVnRVGlFPOoclNK4jo1M7o/h/Qg+2k1Gc4GD9TdLQjngLxftRLQRimrpK4xsJfcgr9mKUU9eTVjkYtgIrvijh0w3SSaH5v8w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:b6e35225-bbe7-4b3b-94fa-cd844023a20f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0318ac,CLOUDID:4128f245-d055-4698-a3f4-1bdf91644600,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5fe99a3edd7611f1b1788b6acf885367-20261111
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 177013776; Wed, 11 Nov 2026 10:19:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Nov 2026 10:19:49 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Nov 2026 10:19:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9igq+2gTu84NnMweXyFG5aWqjcg+VY7QTZkU/vnUi+z9pccCiYL4uBzXmTTxqugxQfB58uZ1lu3dTXQYsIYJPlEt7d+Ql+UU/D5znw7BwYzgTuWMg+3158J276Qku5sfCJZcUAbEQS5xh4EoVqZhcf00uadV4QRGqAVL8Cs9uBCTrBcRhoWsikkuhSoZ6U80/I9GOfStlgkPUTlgHiXPmYw0veq7tkCvMvCHbnVWw0nnz/b5ct3m090vWGB2RBS8f1Lr83m+eczi0dbmwHYnv56NW1jTFwrb10A9ql6ifVaIkFpvkf2rHLNBJuwm6KS2QOeCo8ATtUwLEgWptaM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7xfzXdrxEIeKV6hEOEEw0EDL9A6sSYsVU9YJTdU6Zs=;
 b=ZKEUXMgCmFTujnuzIb1kb7/GQlqAtZsTrr8Sfpy2YIBuLsE11fag6UQCoTkXyY2PLfiZ7bLInLU5aIU130xSiYxH+e4k5pgVqnGLeLdBHkHigtQVEN4zJKsQ0SdkYc2INRFfgogOzRr6SNR7Pd0XqhDzlkrKqIn4w5O26GzOjeAYhvFj/XZoKnElPe9Z/xMSodagP/UH5Ceej5NSoMzYm6sCh5w1fyONgCRpk7U8i+PJD2/GsVKb+v+heTufVNDK5ZbRnka4ku1E4M58naUoka+MEF10X6bUp1QvZWPM9RXAakleypVIB6wa4tlx1zTZman6tiETj1bcrIzCLYSS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7xfzXdrxEIeKV6hEOEEw0EDL9A6sSYsVU9YJTdU6Zs=;
 b=Dj1rCileZP9tbFvo69hQsAGuTdz0xEsB38O0RFR87+Pni0nPsQaW0b/WvS6ia+u8vjRdg963vToGD1cM5A3ZFn1zLc9Jebb1g/NzBzJnaqwcsa9xjoICeeWvCIrGiovXfRV+AJx9INCjzQTHyyQcmT9iKMmu9h7nO+9eqsWYCMw=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYSPR03MB7910.apcprd03.prod.outlook.com (2603:1096:400:481::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 02:19:43 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 02:19:43 +0000
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
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
Thread-Topic: [PATCH] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
Thread-Index: AQHdX80W4ofQrBCmkkuGDRhz4dBY+rcoRp+A
Date: Wed, 11 Nov 2026 02:19:43 +0000
Message-ID: <c08f04c4b2719122a02c01734f56996bbc600b1d.camel@mediatek.com>
References: <20261019-6768-dsi-fix-v1-1-3e5616b45a67@protonmail.com>
In-Reply-To: <20261019-6768-dsi-fix-v1-1-3e5616b45a67@protonmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYSPR03MB7910:EE_
x-ms-office365-filtering-correlation-id: 2e655e80-76ec-4fad-9fa4-08df3f9a3fca
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|3023799007|6133799003|38070700021|11063799006|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|56012099006|261102123227099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|261022075727099003;
x-microsoft-antispam-message-info: re5PM9C2ltD6AA1AhK2beFt9qVC/tuqWcBCgck1q+pw8kapaMewbz7SoEOpfuNL9uAH/ZxCL4G9inKjhAGOJxq6TyXMK5/fvIxvscDJP+7mlCH3gb28bMrOHaSOoPyWJnNXXu77xu1UYF1q7ClF5Gff+oEQS0mRSvi1t+ihljzTXwb3b+welJykn84Hilrxhph5rOqt/XE91CnVqVpVdEusKb+Q8nd2EzCOfpT5ffejJZI3uroA0efoe+wvoTVu5zHdFQAYjKmegfCjsiC5xbdTX/AMWMm6fgsGwmutlwbBTSFC6ScuHqj87bDtBpqWGZapuuIWHoJKoLTJAIeZqhSp41aVUVHTvDRztHcwM++/ULVhuz3d2/UF7HsxGvhpskFVHiTUs0EVUtmN8Wm+k0bmQFLd0Tfypyj00IPP/yEskGjEob+a+Wb/joyXHC0RdWdBiGrKeqUQ5uHprlqqXR/w4dhd1WSF28K21wg5YtHpn9uK0Y6pPoOyFrFjIYrjfnBpM+X29rsJAS9i0BopmM5lnsM9DK9S0Ahnw2pHZgw4Lh7jzLmAJ+FIA4DnGWyy+1UhoINqOJ24VF8WXYquLD/vhkZhiL9nHU0uICnJBZdNmgB51UX7qJ9dHL49KTou3sSz8OB7qH+TiOP3rDGZXwADiOn6mheEkQLbdbk6tW36SFzmvv1QUlcKcc9nfsRFeiFBOfkGKufT202UfWy8P3YN+34teJ5lpSwKpj0DTLds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUYPR03MB9902.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(3023799007)(6133799003)(38070700021)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(261102123227099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(261022075727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWxCdGdqTkd6TXNWa1NXa3VYaVpPditaaEpjVFlFalZhMjBRdWxCWkVLbkwx?=
 =?utf-8?B?VEVmeDUzK0c0c1RublZETmFuQnRMdFg3TFMyYTEyVnZQazkvdXVjWWpJRWFH?=
 =?utf-8?B?aWQ5RmpsYnFuRXBISjhiNDM2eTZrUU5ZUUlzOXpUbXR1UjN5Tnl1SFFXVnVy?=
 =?utf-8?B?UFBUWFg4dWtPOTNKdFlneDBmNTNtTytDU090VEpobDRtU0l0aURRMmYrOEpM?=
 =?utf-8?B?QnJtTVlLbk51SWoxNHFHL2FGcUVac0tMV1dDWmZUOCtyOUprNHVRZ1U0dy81?=
 =?utf-8?B?LzM4dndUOFp4aWJ0WjNRUWF5bm9tMEVZQ2xFemJrVnBPVW9wRllvcnVFOFNo?=
 =?utf-8?B?VHBaT1hib2tpZS9uTmpjZW83SE93RzNWRlorYkxSL3o5SGRmazF0ZVFybUlE?=
 =?utf-8?B?YUVjRWZsR1BaRG1sTlFGengzd1dIZEwvdUxqeVlCa3BIc09XRm1FWmY2R3RQ?=
 =?utf-8?B?VDV5SEx1MnRzcVVXa1k0ZVZ0Q2Z0ckZ6UFU3d0FieFpFS1BLdVA4MFdzR015?=
 =?utf-8?B?UWY4N0dpUnlseFNXVkpuUG5xSDBpME50Mjk1ZFBEQ0x5S1FSK1N3WTFnb0hu?=
 =?utf-8?B?ZDFXczRPdjl6b1NkTmEyMmpGTVJCUnlsaHM3emYwb0lvWnNldGZnazVraHVS?=
 =?utf-8?B?WDR1aHUveEhPZERnTWRQcGwybm8xTm1UYU91UVN4WWhCSW11dFVRYzhGbGph?=
 =?utf-8?B?UDhiUHlXeXBsQXIxdzdOQ1A3N0t2RFd5elo2R1hvZzFTOUFsSW45ZituWGRm?=
 =?utf-8?B?TW8zNnFZQlllOTBtV1pYN3hqZXZWVml0L0Rvb01LQlBYNm8wV0R6bnhwQUdU?=
 =?utf-8?B?WGJRbXA1SC9laHJqUWVpemE2UThZVXFwTkU5bkFVTmJ1VEM5eTlkV2t1MHRU?=
 =?utf-8?B?Y2REdzc2R2FzQWovSkF5bGNjTXZUUDllY2ZKZ05RTlJ6YUs2a1VsR2FtaTY4?=
 =?utf-8?B?N3YxbGlQRXI1Q3NmSlVpYkFkcHVhbW56aVhCNlJTbzlpR1BsUzhtTHFBTHdw?=
 =?utf-8?B?bmJYTDhjL1F0YmlCRE9RanM1Zy91eEdhbjVFK1pNT3ZHL1RjenNHL1h6OXlp?=
 =?utf-8?B?a25iak9RVWxjWW9odFo3Q3RWWDFPUUE5c20velA5S3FiREtWRkk3K01EelBR?=
 =?utf-8?B?UnJWbllZQlo2L3R3WEVQRDd0bkxRdS9Tc2JVNEFhZ1dxRDhyOGh0ZVAyNFlr?=
 =?utf-8?B?eTBzTDZFY2tuV1ZQT3hxOWZHZlNXSWRybndVTFZlL21QN0tGemp1MlBpRGJD?=
 =?utf-8?B?bzFFUW5MNmxYc3g5QmNUT3NTa01tWFhUUXpyYnFDeTBIeWxIQnUxdkZ6c3dJ?=
 =?utf-8?B?VzRlT3BSZjRJZGxETUw2L3JCUDZ6dFhRd0xvbEMzTXI5dk5GT1ppeHZuWFFa?=
 =?utf-8?B?MXZlOTF2ZnI1KzA0YzE2U2ZWSGpQZDBwdlRTclFXajk4My80ZDBkYW9BWFkr?=
 =?utf-8?B?ZE9JWDdXZ0l1SW5WTVd5Skw3NVYxWVhsdlowd25jZFh6aVJqWFlGMGdqNDQw?=
 =?utf-8?B?ZUdEN3NXYUExODlrVmZrZ2NOaG16eXVYMWZPZy9OdXJVWG85eFphS3djNGh4?=
 =?utf-8?B?TDYzd0c5TXh5eTZvTEYxT1dSTHNJUzBPQ0lZMDJvQ3pFOGlXUkZON0tza25Z?=
 =?utf-8?B?QS8rdDRFRWxMTXZtNzdMdlRqRnpzVXhhZU1BcHVNdVFheHd4dGZqMitSeWlU?=
 =?utf-8?B?ZUxaRzhoOG1aOXNEYThtUlVDTmZ6eUVaWVJ4dlJjbmtkdzNKK1JsZFdHb3k2?=
 =?utf-8?B?OWp5ZmlwWXhRRXNVdCtZS25Rbm1GMTMraC9JakRjVCtEcVFYQTN3Z3ZaYk9F?=
 =?utf-8?B?R21rS2h1ZnBJOGlnWnJIZWRHVzNCczJKZ1BMY3lsbVpTNWo4ODdFSUpPQlh1?=
 =?utf-8?B?Z3ZyelJXakNwa2hGVVROYUl0cW9CN1hMSzk4TlBOUndodTFWMHVXakZjTzJP?=
 =?utf-8?B?bnZPSTY2VEZDZUtod3VTcU9Bb2d5UzdHM3dDRDYzRXRDWUkwcEtxNThqSGRH?=
 =?utf-8?B?anlvLzlTcUE1WUYwL3RHdnJHNHhTUVFVRE8wWC80b1N4cmhVRStPb2o5Q0hj?=
 =?utf-8?B?emp2UzZ0RVlrSURtUk9CbmozT0NmdXBETkRacENnZWtzOWVXckYvNnM0eVFR?=
 =?utf-8?B?RHZ3OU9ST1QyWWZXZFo3bzFuTmk5Y0FGaENuVkg5VlhFcEpYYkVrMlZ3NDFL?=
 =?utf-8?B?ckFTcGsrYzdwSHlRa1JSRlE5VGZ6ZTg4MHdPc3FvQTEwVEUvT2FwRTFiNGU2?=
 =?utf-8?B?eDZQMG95T1VEblo2RENHSjl6dTd3cTkzS2Z6UkxsU0Y1UlQ0c2YxRkN6Z3BV?=
 =?utf-8?B?MmVQRXVuWms0Zi8rZkRzeHNkV280V2ZKVFM4NEFFUzh0TlFGaklSZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AFB046E73B0E24397CA083E16EA6EF6@apcprd03.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: m4JDGFGvKzgIcg6y6qWF1oIA3+ozh66VkhC6+C0ONHRc18KhGsOkPpyUeqw4DghlujYvHoLIZrPgHI6B+rxbgyUsRSDLfGdP8BkOOj2Qsbqph9iaaoH0GdoJiW/ezSgVlggVoZ/0pVLWa2UZi13VgILdEE0EhZ5PC8YlaHuLjM28Wb6kut5OsIPdfFM10NzUphCg4pwmMQ8IzHCo4Nvg4gmc4L+i229U0IWJdAiu1Odmg1cCGaNzQg6y/dRAuTZtr/cZQX0G9DdgK/zWj2lcsz41VjVYTmdOEV5seyN/O69bYMtXjLoaWnqKhL5Lux16R44ipfGj4/B506t4MmRLpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e655e80-76ec-4fad-9fa4-08df3f9a3fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 02:19:43.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3BDCcBpMAW+FVmXIoUSlkMpXGDyCfwWjnNgf1IgrGZmYeS/DQqUu51gzr2NnFlnY6HyghEkA7d7Tnws3031cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7910
X-MTK: N

T24gTW9uLCAyMDI2LTEwLTE5IGF0IDE2OjIzICswMzAwLCBSb21hbiBWaXZjaGFyIHZpYSBCNCBS
ZWxheSB3cm90ZToNCj4gRnJvbTogUm9tYW4gVml2Y2hhciA8cnZhMzMzQHByb3Rvbm1haWwuY29t
Pg0KPiANCj4gQ29tbWl0IDc2MjU1MDI0Y2FkYiAoImRybS9tZWRpYXRlazogbXRrX2RzaTogZW5h
YmxlIGhzIGNsb2NrIGR1cmluZw0KPiBwcmUtZW5hYmxlIikgbW92ZWQgSFMgY2xvY2sgZW5hYmxl
bWVudCBmcm9tIHRoZSBtdGtfb3V0cHV0X2RzaV9lbmFibGUoKQ0KPiB0byBtdGtfZHNpX3Bvd2Vy
b24oKS4gTGF0ZXIsIHRoZSBjb21taXQgM2UxOTFlZGRiZGNiICgiZHJtL21lZGlhdGVrOg0KPiBt
dGtfZHNpOiBFbmFibGUgSFMgY2xvY2sgb25seSBhdCBwcmUtZW5hYmxlIikgbW92ZWQgdGhlIGNh
bGwgdG8gdGhlDQo+IG10a19kc2lfYnJpZGdlX2F0b21pY19wcmVfZW5hYmxlKCkuDQo+IA0KPiBI
b3dldmVyLCBtdGtfZHNpX2xhbmVfcmVhZHkoKSBleHBsaWNpdGx5IHNldHMgbXRrX2RzaV9jbGtf
aHNfbW9kZShkc2ksIDApDQo+IHNvIHRoYXQgRFNJIHBhbmVscyB3aXRoIE1JUElfRFNJX01PREVf
TFBNIGNhbiB0cmFuc21pdCBpbml0aWFsaXphdGlvbg0KPiBjb21tYW5kcyBpbiBMb3ctUG93ZXIg
bW9kZSBkdXJpbmcgdGhlaXIgcHJlcGFyZSgpIGNhbGxiYWNrLiBFbmFibGluZyB0aGUNCj4gSFMg
Y2xvY2sgdW5jb25kaXRpb25hbGx5IGluIG10a19kc2lfYnJpZGdlX2F0b21pY19wcmVfZW5hYmxl
KCkgb3ZlcnJpZGVzDQo+IHRoaXMgYmVmb3JlIHBhbmVsIHByZXBhcmUoKSBydW5zLCBjYXVzaW5n
IGNvbW1hbmQgdHJhbnNtaXNzaW9uIHRvIGZhaWwuDQo+IA0KPiBPbmx5IGVuYWJsZSB0aGUgSFMg
Y2xvY2sgaW4gbXRrX2RzaV9icmlkZ2VfYXRvbWljX3ByZV9lbmFibGUoKSwgd2hlbg0KPiBNSVBJ
X0RTSV9NT0RFX0xQTSBpcyBub3Qgc2V0LCBhbmQgcmVzdG9yZSBtdGtfZHNpX2Nsa19oc19tb2Rl
KGRzaSwgMSkgaW4NCj4gbXRrX291dHB1dF9kc2lfZW5hYmxlKCkuIFRoaXMgaXMgbm8tb3AgZm9y
IG5vbi1MUE0gYnJpZGdlcy4NCj4gDQo+IEZpeGVzOiA3NjI1NTAyNGNhZGIgKCJkcm0vbWVkaWF0
ZWs6IG10a19kc2k6IGVuYWJsZSBocyBjbG9jayBkdXJpbmcgcHJlLWVuYWJsZSIpDQo+IEZpeGVz
OiAzZTE5MWVkZGJkY2IgKCJkcm0vbWVkaWF0ZWs6IG10a19kc2k6IEVuYWJsZSBIUyBjbG9jayBv
bmx5IGF0IHByZS1lbmFibGUiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSb21hbiBWaXZjaGFyIDxydmEzMzNAcHJvdG9ubWFpbC5jb20+DQo+IC0tLQ0K
PiBUaGlzIGZpeCB3YXMgdGVzdGVkIHdpdGggdGhlIFRpYW5tYSBOVDM2NjcyQSBwYW5lbCBvbiB0
aGUgbXQ2NzY4IHBsYXRmb3JtLg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHNpLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RzaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBpbmRleCA3
OTYxMTM5MzMzYWQuLmU1YjQzM2YzNTNkNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RzaS5jDQo+IEBAIC03OTQsNiArNzk0LDcgQEAgc3RhdGljIHZvaWQgbXRrX291dHB1dF9kc2lf
ZW5hYmxlKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAgCW10a19k
c2lfc2V0X21vZGUoZHNpKTsNCj4gKwltdGtfZHNpX2Nsa19oc19tb2RlKGRzaSwgMSk7DQoNCkV2
ZW4gdGhpcyBpcyBuby1vcCBmb3Igbm9uLUxQTSBicmlkZ2VzLCBidXQgSSB3b3VsZCBsaWtlDQoN
CiAgICAgICAgaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJX01PREVfTFBNKQ0KICAgICAg
ICAgICAgICAgIG10a19kc2lfY2xrX2hzX21vZGUoZHNpLCAxKTsNCg0KVGhpcyBtYWtlIGNsZWFy
IHRoYXQgZG8gdGhpcyBqdXN0IGZvciBMUE0uDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAJbXRrX2Rz
aV9zdGFydChkc2kpOw0KPiAgDQo+ICAJZHNpLT5lbmFibGVkID0gdHJ1ZTsNCj4gQEAgLTg1OCw3
ICs4NTksOCBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX2JyaWRnZV9hdG9taWNfcHJlX2VuYWJsZShz
dHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiAgCQlkcm1fZXJyKGRybSwgImZhaWxlZCB0byBw
b3dlciBvbiBkc2lcbiIpOw0KPiAgDQo+ICAJbXRrX2RzaV9sYW5lX3JlYWR5KGRzaSk7DQo+IC0J
bXRrX2RzaV9jbGtfaHNfbW9kZShkc2ksIDEpOw0KPiArCWlmICghKGRzaS0+bW9kZV9mbGFncyAm
IE1JUElfRFNJX01PREVfTFBNKSkNCj4gKwkJbXRrX2RzaV9jbGtfaHNfbW9kZShkc2ksIDEpOw0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHNpX2JyaWRnZV9hdG9taWNfcG9zdF9kaXNh
YmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6
IGMwM2MxYTE0NTA3ZGZhZjhiODU2YzI2MDhmOWFjMjE2MDIxZmMyMjINCj4gY2hhbmdlLWlkOiAy
MDI2MTAxOS02NzY4LWRzaS1maXgtOWYwYzJjYTJiYTlmDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IC0tICANCj4gUm9tYW4gVml2Y2hhciA8cnZhMzMzQHByb3Rvbm1haWwuY29tPg0KPiANCj4gDQo+
IA0KDQo=
