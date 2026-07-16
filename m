Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210E27F75C;
	Thu, 16 Jul 2026 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169603; cv=fail; b=fCU80L9X19e9ulitMbpvMUEqjqs5nI97ghqcnGNV1ySz5fgJI1p0o/oDpiO/xjPotuYCxd76+IqHdNu8WX7aMAqJuwl2+fKhHFr5L8DK+DoJtCeP0NAWO4CtO0IPcEQadZSAOtu9r4ip/50tsLzQgkWk5x1+jocK5ojcAKSgPbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169603; c=relaxed/simple;
	bh=gmKxKxlXIl7CCvEr5p5553PlqVjCixHcjLaBZH4DGkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZsWOq66mq1jL3QD5vsnRo3mq1fNhXW3ZCBTW5RMyoAO9yaW0V2vXIii6hCvfGsvBCBjQyDBBuWvnQnc4ic1fbykW0ELLKT6Mnz5ElFL2PkeeWjfVXJodtFx1JnsSToaOmNbb2pGOZg/uTortRlgnAcAD6fmdsZMpb+/hluEVMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iQ2dErwb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pXByWOLS; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iQ2dErwb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pXByWOLS"
X-UUID: 9f8d3ace80bf11f1b1788b6acf885367-20260716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gmKxKxlXIl7CCvEr5p5553PlqVjCixHcjLaBZH4DGkY=;
	b=iQ2dErwbDnr57SewEIf+mvDaDJWKor9gH3t9pw4lYekr+fUBwTtaT6kXS5lKzNsHoC8MrCalba6/hRtuvnKC+VVup8a34oq6Pr4HQ7/aWOV7Kwds2nYPm6OxkoGbK9mdRM6Im3Gr+QnGC7yOa3zzxF8c98WG6S0ZUUYOnC3cRPM=;
X-CID-CACHE: Type:Local,Time:202607161039+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:980323b7-c386-42f3-81cc-c968edc9b8d1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:19be513f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9f8d3ace80bf11f1b1788b6acf885367-20260716
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1385318797; Thu, 16 Jul 2026 10:39:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Jul 2026 10:39:51 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Jul 2026 10:39:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiGy5jX+lJDg6U137HTPBEK8xfUjRU9J2iDLQXnaNC1SYadaTxQ4zSOvBZCUnDbuRE/toOb0W1IHPoqXVZODI4gFtFRA+P9z1XgDX5bFJ+ha3Vg8w9QXaUtLqgnqaa/8Z78sne2zXF4j0/OkfScOPXF3DysK0emsLDKorCxLhz1pQ+n9CEhNpUAzsz1LyC/PYGJjachMSE6x/x5TkERkKUagZjtFTM6RgeeoOAvoewctbBwK2N4rTuJr7IL/u/Z08cCkiJ1p4cjiH1OoV1W8fKEp8G3/qT3JPSFF3zk8TssVkruMc8MzMCcLrY0aOKS1SIJ2zK+GvEbisursQ0dccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmKxKxlXIl7CCvEr5p5553PlqVjCixHcjLaBZH4DGkY=;
 b=k7Vdb6sfae00qzOMLo8iqKqf6drBC8gH8fIHqdBzqQNhimllHQ43L+4tt7X+wBjWjzY1b+9DkAsbVqJnGZA2nWTYCbLwPPFmtn5k2KRmdAh2lWhr+pMKpMW9nVwQtEB68R+5HHrQ2BVX5toqcSsHL/rS0ZHtihEJ8zvJWf0ruMo2U6udlTF9Eir1Uzs/Cdh1+Z/eKvTGxzf+SRKBidEwtm1eJKS90Y17bvt1729GdX7poUwkcBfAy3nzEG3sozUZeflQ49rftlxVPq+xzBIcHiRD7JERdccVJvbH5ijOvD7xoP4kO8RmNY/+aImE4olpBOvQJXquk25fPC2pxyHKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmKxKxlXIl7CCvEr5p5553PlqVjCixHcjLaBZH4DGkY=;
 b=pXByWOLS/Bpyb2Cam19HYqiyvYe22+o33oY89oZVSGyVbPOxoQ0+4GTxK7h5A8ISYhplFHZR6Hk7vNtBULQ6jIbpv2OJhf8WAp+OyHjMYwGegvn/X7ReB8RbFAk6zUquZTgf0REYgz/iQUZgxsGSGNQPOckISo+MHUDCEbTUjPM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KUXPR03MB10455.apcprd03.prod.outlook.com (2603:1096:d10:66::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:39:48 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 02:39:48 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"lgs201920130244@gmail.com" <lgs201920130244@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "johan@kernel.org"
	<johan@kernel.org>
Subject: Re: [PATCH v3] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in
 v2
Thread-Topic: [PATCH v3] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in
 v2
Thread-Index: AQHdErtSNnNlJRT9x0a40OU1Rz4IMbZvc0YA
Date: Thu, 16 Jul 2026 02:39:48 +0000
Message-ID: <75b8f2813c3a3f114be3dd55831751752172d04d.camel@mediatek.com>
References: <20260713112957.884640-1-lgs201920130244@gmail.com>
In-Reply-To: <20260713112957.884640-1-lgs201920130244@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KUXPR03MB10455:EE_
x-ms-office365-filtering-correlation-id: 08b1ba0a-41f4-4365-ced9-08dee2e38138
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|42112799006|366016|1800799024|38070700021|921020|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: muyvSUnOaoNscSRO9smR1/fDjMEaiRphizeT+vg3r0AAYnXXYOUiR4uwXbgqo2OukbC24c1JUhN5hx9Xa6kdGuabj9hXJ9bgP4U7ILXSQs2cPvQH5m/TGfFCIUKhd7yEbHQfWYNw+aso6LBpGUuQy3wf6zHZ4Wp3AhCmo319i/Wjg1JGmYbyh/LSKOCKTMWHBhRV03Ypwf9qekZset0/1uTFYZJuChC2cHGWH7bTUYvppmX12zbaiZLN65fgOPddv0EbT15SvKXeLJ2VUXaMW6J53ANyWkCqDeC/EXn7aM9DdKEkosPkv9StXbeEFPRzXZ9A0jt8Z4+UsHMvcLxDuRHhkDjNu7BOlk88mUm4S3aE563wfVHKMd4zmeI/b6HpN94nayFHfRliG1Aa+spWIGnXzSV79Auj84xbcPHnJvzv0e2OG6iXZeMAa5vN5YOv01RYKuKIH2Syli9h90ODTVT8XjpSBeEuG2HixcX10f86oFJbEd/PPCIZtwJ1dFcCnmLYs3I9gKIIm6MiRM4Gdjsm+Xgwfb8WK/7phm2BvsBu/MZr3yqDLVYxz1jnvW7IzqWY4lLIhgvoXPJiOSowyfJtVKKlZWEYGvk6763RwznEwi4quSdEEI4OzmZ63IiUOjjROobcT6Da+tQYLUxaky8A0w3oBEevQQmm6ox6crk3W/7PN1n0jaWMEW40uayZVYXq3Q1hgNkR9+SODWDEcDb2j3ta5z91A7XxYjY7yaA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(42112799006)(366016)(1800799024)(38070700021)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVZTdWthYUxHZW9ZTlNza09FOXFMSVlMQmJETWNlK3FjUjk3OFZsWHh0QnNl?=
 =?utf-8?B?bTcrV01vN3JiN2JSa3FqT2dwUGZBVVJoRGZRUGlrNU9HWXhQOVZYb1ArcWta?=
 =?utf-8?B?ZU9YVi82bkpGOENIRnd6Mk1YYVlQaHVLZDYzU1JUanJnMlBNT0U1U2hXa08x?=
 =?utf-8?B?ZHNUOHZFVXczeWNhRUFKUFlGNlg4YUlKK1JzTU1JQVErV3dlNWc2N2F4MHd6?=
 =?utf-8?B?cjRBSmdHbGdSWTl2SitqZkE3WlU4eGdrdjlpTCtJWURJUytCT2xZeGNpK2pN?=
 =?utf-8?B?aTVCM0g2dkZBQVVOR0FhR1VBalJTcTNmcHFobHNkMkxHRmNlL3ZLeUd2WWQ4?=
 =?utf-8?B?R1ZkK09IWEU3VmVVck8vZ2dXUERMcXdhMGtqenhGSFB6SEZEdkM0ZS9MYURt?=
 =?utf-8?B?Sm5zT2E4dzBKQng4SGZFYUVLTlg1aFNCZFpNOXFiSk9UUCtOSmlZekxyS0VI?=
 =?utf-8?B?RjZ1N0N6dTdMS3hwQ3J3K0ljNlBoMC9jVk9WU1Fmb3IwdG52VERsWTh5MDhX?=
 =?utf-8?B?VHJaWmlCNVdNTlpCWkNrWWtRbHZEZXRJRHI5QWZIdy9LTU1wTHFXMUg2SnI1?=
 =?utf-8?B?MmhaVVF4MWs3cUR3ZDFQVFlKRnNlZmN4dHN3MXRGSFdQaHBaOWQ1dzZJdXYv?=
 =?utf-8?B?aUcxM01TN2ExcWNxbGRLTGxlNXdRNTNaS3h0amJXVWRMMTR6dDRqVUxxMnVU?=
 =?utf-8?B?U1NTalFEYTltaHFsWUlTYzh6eEM4ZENweHpJbmtuWUJQZlpTNHlVOXF0cVVN?=
 =?utf-8?B?OXB4YmlxZDMzY2V1aUY1WUZtUTNXcERLYXpDb1U1MWJ4Z1VmMjEvc1ZKNUpI?=
 =?utf-8?B?eS8wOXVaY1htMXc1TWlvOGZYTVhsbGpXVUlOaFZKRDJuc21uaElLazlzNWtw?=
 =?utf-8?B?UEhoQ3VEY2tCV1hPZGJrazFmWWJFdTRuQUxsMmwzOVh2RlpvdTJjdStiMlYr?=
 =?utf-8?B?NnZXYlVqRW82QUI2U3oxYjU2cXBDMUlIMFdKQ1d4Tm4zeVpwQ0tZTER3Nmlh?=
 =?utf-8?B?dGF0RFFiamU1NVBuWVNTMk5menl4NmowcEZseVFHOU5zbDlPZ0MxR0tSclF5?=
 =?utf-8?B?VzRybko1dG9kNXlmbGZ2VGU4N3JZSUNkMDgyOC9FSzZILzY3N2pGRmU4OG8r?=
 =?utf-8?B?Q1NETHRjNGxieTc1dFRqWHl1Q29aemNSZUtzaVZRUnB4Rld1d2FyWldwbGhv?=
 =?utf-8?B?bHlEZ0dmaDZJbDNOZWNIN0tDMFQ4OE94czNWNnpGaXBmajdrdlVVcW9tQjNE?=
 =?utf-8?B?QVdyTWdYQUx5cEpwYjJhb0ZTMGZkdTIyQk05QkJ0RDJBTWEvelJXbjFNR0d0?=
 =?utf-8?B?M1FPank5OWxva1JqTEpLaktWUTA1SDFUSVhtaWdSb0E4NmlROHRsaXJIYmhn?=
 =?utf-8?B?WjVsdHlGL0tVb3BVWWZ1RFdxZ0Fpc1pucHFrQmdSVnY2S2NNRnFMeU1EamZN?=
 =?utf-8?B?ODBua1c3SEZVYndEOVU0MnZXZjBwWk1vNythbFZndlE2bFJkUUlLU3VyTnla?=
 =?utf-8?B?elgvdXMzT3UxUGVQTm9LYndsNjRnTU5NVy9vSVRUdFFmM3RSRm03aGdVUFda?=
 =?utf-8?B?TklWTmtZN2ZlM2RnWmdQRzZTNlJHa25HdlEzUGRObUs2dnNUY2hGQW96QmdD?=
 =?utf-8?B?cDRtV0tHSHRsOUxKbld6M0k5QVlVWWxzM0NoS2I4cmUxOFpHTnptRmh6aDFQ?=
 =?utf-8?B?M0xIL0orQzZYVWIzVFpCditPdWJYekx0L3M3VWhnbzVYRWpXSUJKU05BS0VJ?=
 =?utf-8?B?aFlHQThUSi8xM2FpREI0dDFISFpEL2M1dWxOcE1MQnNGRDlST0s5N01VM0E4?=
 =?utf-8?B?VXdybXBqRURGaTFncHhCRDF2UXFqY2MzV3V6QU41aGdSSUxvS0J0R3NBZDhE?=
 =?utf-8?B?REQvUlMzclFtcWQ5NytpaVgxc3VBelpOeThCeEhQcGFveWtCak5oRWpITCsw?=
 =?utf-8?B?cHRXVXVEZ1dWYmExUGpsWFQyQVI1eXJ5UnozWUZSRWVjZUFkNVUvM2xNSjUz?=
 =?utf-8?B?eCtRZUg4TWtkM2tya0xzQzgvTHlyMnFaZGl6c0RqV3plN3AyRlVtbzQ4V01i?=
 =?utf-8?B?QSs3aElVMk1lV1Nkc1c1ZTRURmpCblFjRjNYVGhtbnpJU1htQ1RCdUdUU3VM?=
 =?utf-8?B?bWt0eDFrT0VzYTJrc1B2L3NLRXZaMGVUamZRd3hoOVBrK0hMdkFFaitXS3VN?=
 =?utf-8?B?RGRoMXhPTVRxNzNPSlArQ2w1ZjVjVDNOS3RWcDhCakR0N0JUN1kxanZHL3RC?=
 =?utf-8?B?TXc2ckJHVXVldjk4UTYzSjNZckNkaVphM0xhVGdIb08xZGZtMHZkWEpwQ2VT?=
 =?utf-8?B?OW94MTJ3MjA3a3ozSkVQbVVzcjFNYUpxWXloQmN6SklJUnZwRHNrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59CA6687C34EC442861AD9D677A099EB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rw4m2zBXz6yWEujaVHr1iNvKnqa6gH4EWNxtC5hxGQ3JqT7ZW+N0XmJhqZCqRTy7kuJbSyWkTjlRjYXT0M2HGI5e8rRnP2jqdt0HonEC+3oGmaxKEibrwPX4g38E9MbEWEX/Vk3qR7QQKrGvJ8QSDW1i9+tUonWy/G9jMlNSZnyj5YUbOykEHYanQBoO9TTQMpXhXLHN4mYXR8OwqpBVRkNfxeRK09iBnOnChUSuGrxDs3W2ZR0HKA2Ewtn4/Txksl8AbwNr8A2b2cL2AepNna9Uy0ugPwAw3X0oEtcAHHku4XZw/ig0IDgAkygs8rnOowSXZGEP1YNBTVz4fo6ZfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b1ba0a-41f4-4365-ced9-08dee2e38138
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 02:39:48.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEwYVaPvejoEjS9kPVee1vWj8kuCHJCL5xZGW3oOixTwCp55QMUPG6df1i9TaO0khavj9l10lQXx5o4lxP5TcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB10455
X-MTK: N

T24gTW9uLCAyMDI2LTA3LTEzIGF0IDE5OjI5ICswODAwLCBHdWFuZ3NodW8gTGkgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gbXRrX2hkbWlfY29tbW9uX3Byb2JlKCkgZ2V0cyB0aGUgRERDIGFkYXB0ZXIg
d2l0aA0KPiBvZl9maW5kX2kyY19hZGFwdGVyX2J5X25vZGUoKSBhbmQgcmVnaXN0ZXJzIGEgZGV2
bSBhY3Rpb24gdG8gcmVsZWFzZSB0aGUNCj4gYWRhcHRlciBkZXZpY2UgcmVmZXJlbmNlIHdpdGgg
cHV0X2RldmljZSgpLg0KPiANCj4gVGhlIEhETUkgdjIgcmVtb3ZlIGNhbGxiYWNrIGFsc28gY2Fs
bHMgaTJjX3B1dF9hZGFwdGVyKCkgb24gdGhlIHNhbWUgRERDDQo+IGFkYXB0ZXIuIFRoaXMgaXMg
bm90IHBhaXJlZCB3aXRoIG9mX2ZpbmRfaTJjX2FkYXB0ZXJfYnlfbm9kZSgpOiBpdCBkcm9wcw0K
PiB0aGUgYWRhcHRlciBkZXZpY2UgcmVmZXJlbmNlIGJlZm9yZSB0aGUgZGV2bSBhY3Rpb24gZHJv
cHMgaXQgYWdhaW4sIGFuZA0KPiBpdCBhbHNvIHB1dHMgYSBtb2R1bGUgcmVmZXJlbmNlIHRoYXQg
d2FzIG5ldmVyIHRha2VuLg0KPiANCj4gUmVtb3ZlIHRoZSBleHRyYSBpMmNfcHV0X2FkYXB0ZXIo
KSBjYWxsIGFuZCBkcm9wIHRoZSBub3ctZW1wdHkgSERNSSB2Mg0KPiByZW1vdmUgY2FsbGJhY2su
IFRoZSBjb21tb24gZGV2bSBhY3Rpb24gcmVsZWFzZXMgdGhlIGFkYXB0ZXIgZGV2aWNlDQo+IHJl
ZmVyZW5jZS4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4g
DQo+IEZpeGVzOiA4ZDBmNzk4ODYyNzMgKCJkcm0vbWVkaWF0ZWs6IEludHJvZHVjZSBIRE1JL0RE
QyB2MiBmb3IgTVQ4MTk1L01UODE4OCIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IFJldmlld2VkLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1v
ZmYtYnk6IEd1YW5nc2h1byBMaSA8bGdzMjAxOTIwMTMwMjQ0QGdtYWlsLmNvbT4NCj4gLS0tDQo+
IA0KDQo=
