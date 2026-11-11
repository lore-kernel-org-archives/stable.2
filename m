Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.100
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379610;
	b=mOqfmmFi237XqbQRUf2kjwzLUsXFvtaYP4SYtRVlYBebQxuyK5vdd1VnsKWKrXR4KLfQ
	 5sW0PUGYmkph1IIaeM8LeBhdVSoox1mBj1V0ZUgDX3TcwtX6D/QFzzRobbuLZlQr9wHYj
	 kmLg+G/gQpTh0Q0oBRSuOTqVcQqix4NPcNgP3BcV9ZM66Cbby+272wE519fliTp0dyTts
	 wX1Y4bOjV4CtZrH6/fI/zzS/lkmY3Ufodc+6D8WlOE7I7bODwIglne+oq+PKqUH3ffUOh
	 daPdcmIjjeWIm4Ks4oLSAORBqAqbr+MuR2JXRsHrn07SIS+Q3GrUM8PRgqhen3PMgLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379610;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8wwjlyjRXD+uENX3eNALtOcWveSShD7H3BZvgI0XoV4=;
	b=Z4aSp4ypQwKK6aarE5Uh/332cAe3CEH+Z0SwDBCVPN9XytTrOLKLtT7zRYruTDyjvN5s
	 wL/CK+NGKCJ1LfpGNLZQqRRVeq8zwZxs+i5xp/eWbfkqIJwyat+UctvK18IiXkFFIpVgP
	 uJJPYdFRpnVGrPrnl5zOIdv0hWjHd183eZ7WIIZUUN5I9VcgFuLn1WB115r8N/GFBxJdw
	 dg5vFmFaNoBJoN+n453K6TEfVTWJKZMj9sDvfB1930kMlGT4f+I6Zbir9CGawk/yzaiQT
	 QyUmgfyTxK4feZmrcnuCrLwDJRAyP7s2tSkdzSeeX7sTbe66AZEvOaCBcpoJKqXSNbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=VYJy3q0n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.100
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021100.outbound.protection.outlook.com [52.101.70.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1179606A33C;
	Wed, 11 Nov 2026 06:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1179606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=VYJy3q0n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5W7E/opBUkXOhLW9+NelFXAsMoHx8NfhO8AdRhBY2bXOXicI47QRywAOUAXUPRBti7NIF4g9w9CgRJhgSXPkoJKv3vfhiShs9ke5N70CeFzq9QE1w1zKO2W0CG2J7gbY35A5WCuD8lY3gG6g53ZhdDTZCtUjZ5/UbyT3fh1gg+/LQ7Fjf2C8D/PQ5lIe1dOfpPWC9BeGqk3iVRLGd0HBUNKrR+JA+4JMo43D7N8dMhrssg07eZPnIpygt0d/mVLmpcGhGMRHZkPPPAnx0eCMoaoS+I5GRkA86AVK7xxHSvcGTGasNmbXrIkNSQNmIry37Z3kCisJI7Cpq2eN1c/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wwjlyjRXD+uENX3eNALtOcWveSShD7H3BZvgI0XoV4=;
 b=Xj8V0CExmt3RQCACkh9fsmOJApTjJQCPAcxv23VO+hVBN/QM90w1t2rK00vwCume/zDmV3BsaEmDiYp9pYMGnEC8Wk9V5ndBvyRS9IJ+og3aUy0Ds05RHq7HCOdTKqI2BC659GXtjF5bQJO5moQsXUdM67Tq4ih/qY2HdcAdvsJs7VMcAzIPqpgcVu4qtwfQC3Ygs+2y6tfkHvvcpfxpA86bC/DCVlLyxA6O9h7+OFOtpQ3bvxPrti3QMY223pLewYMV+BP0DptMEyOz91iffP6ZBtaLgTytLhSyjzUv7Ab/xnqnIxHU0ImIfjkaY9OAmbupLz4RLZBUkdSwdDNurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wwjlyjRXD+uENX3eNALtOcWveSShD7H3BZvgI0XoV4=;
 b=VYJy3q0ng4X+Q85CwQ5jNoUF0S8I23nYDezbPBc8aY5oG1n7W3X44JNvzCcbmEjyksBk2GDnILsZItUqdvGIJnS+Qp1UXAQCL7L/bI7xzkK31YEJWdRRBTWlzIRbKH1k4rAxKXFk666OYPFPzRlUXKkIC99i4kMTKBA1d1aZ7iEKb5X23IjKdjPWmRw72vp5HIMY7PA9+uBJ4UVsW8zYRkYnKTkQ89/NB0dWBgqkvOmHezEWYD0UCEB2oOM3g1ifLwoWMIAyFMxzgNwY3QCsXjgiAAAHFhPymwKIcK2zgu+1qkTriHAUa7gJKNyjGkEMR++45MexcLgk679d9tTToA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by PAXPR05MB8112.eurprd05.prod.outlook.com
 (2603:10a6:102:de::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:46:47 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:46:47 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "sven.auhagen@voleatech.de" <sven.auhagen@voleatech.de>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "kurt@linutronix.de"
	<kurt@linutronix.de>, "sriram.yagnaraman@ericsson.com"
	<sriram.yagnaraman@ericsson.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>, "p@1g4.org"
	<p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"piotr.kwapulinski@intel.com" <piotr.kwapulinski@intel.com>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
	"alexander.nowlin@intel.com" <alexander.nowlin@intel.com>
Subject: RE: [PATCH net v5 1/4] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Topic: [PATCH net v5 1/4] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Index: AQHdbCdcWmiAvdSZkUiihjXYKarcRLcjymAAgASuFiA=
Date: Wed, 11 Nov 2026 06:46:47 +0000
Message-ID:
 <AS5PR05MB11020223B9C97436DE9D0A219B9712@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261104-igb-rx-ts-fix-v5-1-bf4b4367129a@aweta.nl>
 <179412230443.994134.1015628730237451247@kernel.org>
In-Reply-To: <179412230443.994134.1015628730237451247@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|PAXPR05MB8112:EE_
x-ms-office365-filtering-correlation-id: 597b289f-2c41-4bfd-6d21-08df3fbf8e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|38070700021|261026140227099003|10067099003|4143699003|261022075727099003|56012099006|261009223027099003|261022113327099003|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 OiloSkqXIO8fDJdgOXX+japh7mG7ap6G2ChplnqcZQ5GZR4O3jLXl2lJa2Q8IgmfAGEIdftC9RFrZg59gMTib50LE5xusH0pGjqeD7HWwT7o+fhXANtF0m0Pt/KrleJG8DKUf+WCaXWoxnMtLuMcULXPt2Db6apIQ716ISOzgooW3VUDPbHnJXtCqqKF/oKv+Hge1AFK7ontTqurUqMHV78xQzTnorrT9M2gUpnyVoSbPaif0yELC8S7/3hWfujP1Uw58WodG2NpQvovUry3Diqo+S7V/A1nEy9JqAkeyHRQo9jnlTLvdPyrcYkG/YmGIwMOldpCF3GiRYDp+KV2wSn2rf/X0b2tBAk6J77SelSUubqRecUjhfalAOzQeuIaSTC/2RAJww3vuH6+aK/WYNxZAnrRjhtxAAxs/YarftnMNeCxuduExs7KTTHROVTqeMDUIcqllje0E3Eg9/xcSv/GrNhQPLrwtyCCcpmNinpdQDZ2XjMKuqnyfoAQUQ6aXGF5lYf05cHUnqoJyalRYyTVCQ0xzBHBTLVTO69PEIQ8iDcrGsBBlImq6HA4nH7rr9Jy4AM3p6+arrCa7qzFD4ZoLMI6Rqvrci3S/U/DFr4s7nDBg6LcH8Y2FlqIP51FMeP2Ig+GW1k5EbNfi0wezMUWwosbw5j2zWaa3X0Ugd47UkWfKjhmultM8AZ7llkU/Eep9MzwMBDT7M94oQRtIa3jt7tDV4T2dqC/jXspAmE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(38070700021)(261026140227099003)(10067099003)(4143699003)(261022075727099003)(56012099006)(261009223027099003)(261022113327099003)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU1qSVBXZzhrZFlIdDFzNiszbElYZUNWcG1pYnNaWkFPNjFOS3NuSkJOVXI0?=
 =?utf-8?B?QVVMTEhOUUJiVExUbEs0eU4rUDBrSmh4S2dsblUxM3JQUzUzVTJNeFlqOXZu?=
 =?utf-8?B?RkNReWxhWklUbFIxYzdsR2lQbW5HU2kyalJ0c1NROE9OVzNIb3l5N25XTStQ?=
 =?utf-8?B?N2tYMEJ2dFVaS0xWcmIzRklYMExUSGZrOFcwWUg3d3czMEJ6Skd5YjBVWWpL?=
 =?utf-8?B?dlhvcDU3Q21OM1pBNVB2S1hIOWhnRmVIdkVkSWF6eDJLa2RXTEtLWkVUZmRE?=
 =?utf-8?B?bGRtT3lVc0Y2MWowMHl0OVpmVC94VXZET2poVHhGTGcwc3NRL091bWtCTkRT?=
 =?utf-8?B?RTQrR3RhWUNNU0hIVlFjdWQxTVhZaUh5VHBBVnhNTmJYZWVpOStuRTdQUlZa?=
 =?utf-8?B?Ti9oaklQUjNsa0xqQ2ZPK3VjYXpQZWN6TE8xNjF4aHk0NzlQc3dsYVM2cmFo?=
 =?utf-8?B?N0tGSW9tWTUyWEVYZFVzMmR6aUhxUk9pVnFJZ01nS2t4dXFXVGhZRjFCL09T?=
 =?utf-8?B?YXZnRlZTKzNObC9VdnBVSXowNXdIQ2xJY3JjNWx4d003UGljd1M4RWM5ZDYr?=
 =?utf-8?B?S3pTYmR5VnB1eUlBRG1HNDBrbEFZZDdvUkE5Y0NydFAxNloyNFdqNjIzY0do?=
 =?utf-8?B?dng1NmRIblpjTUlFblVRTmdQMlFTQzdEY05keEZkRzVqa2ZQZUtFN1ZBTU9B?=
 =?utf-8?B?OGtLbWF2UG5PNlZTeCtwbXhXMXl0bEI5VEE4TklDVXdDZ1I0VXNTd1g0VDdU?=
 =?utf-8?B?VHJwd3hQdW1Vc2NTaXlBYXZGekI1YUlLdFYzOGUrUFJnc1JISmxiVkYxY0ds?=
 =?utf-8?B?azJReC83d1ZHMVNqQ2tFZS9TblpGZCtrL0hIM0lsMUFvb0xkdFNYa0VzaVNt?=
 =?utf-8?B?S0NtZVJmdW90S2FPRFhrY3VCM01KMi91aGNvbmRnam1UMU16YW9ua21zVnhD?=
 =?utf-8?B?Vk8wdVNLRndUSmdPbWlybU4vLzI5NUQvRUkvQm5rZ3VRZlBHS1hmU2pwMS9Q?=
 =?utf-8?B?YyszTDVodDlFaytkQ2xJTUpqd2hrRjJ5SGZ0SVpPVmhPcnhWRmlQUTNFQmFx?=
 =?utf-8?B?OFUyQjhoWmxZL25NZkNYZXZNdWZBQjBxaTNnTlBzcXYydk1mTGV3NzVVWlNk?=
 =?utf-8?B?dm5pU0lHTTU0cXJLUzAveUdjRndkbjJBektWSUtXRGlhSEJFMTZHWXFQQmNt?=
 =?utf-8?B?ZmtLSURlT25XN1ZKN1Qvakt0WXpuUzQ1dEU4anBSamZIUnhuNW03Mm92bVhW?=
 =?utf-8?B?VVZqdjRKdnlnNUYra3JUTmpWSGZqeFdtdnVRUFo0OGpCMitCMTlxMGFnalov?=
 =?utf-8?B?bzl0OS9NcUJnZkpsaHVmRlk1QXNWTUs4b1loSCtlNG91eG1yallPRGFsK2Jm?=
 =?utf-8?B?TzhndlFrVXRtTkxyWVZmY0VmSlVXY2dZM1ZSNys5aElzMmtrc2NSVDhDVHM5?=
 =?utf-8?B?aVRiZHgxd0VVSW0rTmZ6QlRLVWZENHFwclc5MmN3VkZ5MExIbHBCcElHNnBI?=
 =?utf-8?B?bEZRWHJpVE1ZbDQ4SFVDUEpaM290cS92MWs3ajVmNkIrQXAyOVY4TDVPRUl4?=
 =?utf-8?B?SXZnZnNidFU0YzdEelppNzFFUEg3enVsQVBtdmNSVThQc3JLRk5MTGIzZjRh?=
 =?utf-8?B?aDZIVWwvTGduQy9QTnVkaW5tTm5FclBKT1htNTBtSXEwamtCNVFyTW1OdFEr?=
 =?utf-8?B?R2pQeUF6cTFqbFJ1R0ZLd1NueXRVSUxOWWNCK0VyZEcwcHVOMlFnT3k5Sisv?=
 =?utf-8?B?NnpMRWl2OXc4cEF3bzZmNno5ZHlHM05meHgxNzBxRnpHc2U5SWtETDJ4aEU1?=
 =?utf-8?B?N2lYNlZZQVFNNGNXMHBKakVKdGhRb000aW1zdFVWODVydUMzODRiVldabTNB?=
 =?utf-8?B?T0hCMldMTHFPOUZOYS9lY3k2bEYzTDE3bWVqUWd1THFKdERSWEN5enBSOFpF?=
 =?utf-8?B?dlZWbWlsWW1vTjVQQUc5RDBmM09qR1VBYzc5NFlDT2dybTE0OEZBaWkrS01N?=
 =?utf-8?B?M3NHWnprNGdNK2JRN08wYWpJWmJWRXBIQitZVHVjYThMY3h0dExIWjd4dXFX?=
 =?utf-8?B?Q05BcHNTWFhSa3EraHJNU2NvcUQyOGVXUm5zc0w1MlliU2dHYXBVdFBXSTdp?=
 =?utf-8?B?Und3eWpTSzA3dU9hdmQyRVk0bzUyK1c1UGFYYUFDMWhmMjNjaW5jR1VQRDVu?=
 =?utf-8?B?Nk9yOWhrUWRyNEhxVk5FY2wxciszTnhKWGxLR29JNm9kTVBVZkFjbDhrTGQ5?=
 =?utf-8?B?UXowdlJHUFljaE92Y28xNDkyeVgvTHg4a0NTencwaVBLbHEwOGdPdXFWOCsw?=
 =?utf-8?Q?uO5DttbeFKg8R6bT8Y?=
Content-Type: text/plain; charset="utf-8"
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
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597b289f-2c41-4bfd-6d21-08df3fbf8e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 06:46:47.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVYPaBJBYaRgb5kYE/rRM5X6xSzVtru6F0d/p6ySTU7qs72UKfjt6F0YF9ycwQgW1jbcEltKj+Nu2D0mBoSQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8112

PiAtIFtIaWdoXSBPbiBpMzU0IHdpdGggVkZzIGFsbG9jYXRlZCwgaWdiX3NldF9ybHBtbCgpDQo+
ICAgKGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jKSBwcm9ncmFtcyBu
byByZWNlaXZlLWxlbmd0aOKApg0KDQpSaWdodDogaTM1NCBjYW4gaGF2ZSBWRnMsIGFuZCBpZ2Jf
c2V0X3JscG1sKCkgc2tpcHBlZCB0aGUgUEYgcG9vbCdzDQpWTU9MUiB0aGVyZSwgc28gbmVpdGhl
ciBSTFBNTCwgd2hpY2ggc3RheXMgYXQgOTcyOCB3aXRoIFZGcywgbm9yIFZNT0xSDQpsaW1pdGVk
IHRoZSBsZW5ndGggdG8gdGhlIGZyYW1lIHNpemUuIEluIHY2IHRoZSBQRiBwb29sIGxpbWl0IGlz
IGFsc28NCndyaXR0ZW4gb24gaTM1NCB3aGVuIFZGcyBhcmUgYWxsb2NhdGVkLiBUaGlzIGFsc28g
Y292ZXJzIHRoZSBzYW1lIHBvaW50DQppbiB0aGUgcmV2aWV3cyBvZiAzLzQgYW5kIDQvNC4gSSBo
YXZlIG5vIGkzNTQ7IEkgY2hlY2tlZCB0aGUgcmVnaXN0ZXINCnZhbHVlcyB3aXRoIGFuIEkzNTAg
Zm9yY2VkIG9udG8gdGhlIGkzNTQgVk1PTFIgYnJhbmNoZXMuDQoNClRoZSBjb21tZW50IGNvbmZs
aWN0IHJlcG9ydGVkIG9uIDMvNCBpcyBmaXhlZDogdGhlIGNvbW1lbnQgaW4NCmlnYl94c2tfcG9v
bF9lbmFibGUoKSBubyBsb25nZXIgc2F5cyB0aGF0IGlnYl9jaGFuZ2VfbXR1KCkga2VlcHMgdGhl
DQpmcmFtZSBzaXplIGNoZWNrIHRydWUsIGl0IHNheXMgdGhhdCB0aGUgc2l6ZSBpcyBjaGVja2Vk
IGFnYWluIG9uIE1UVQ0KY2hhbmdlcyBhbmQgd2hlbiB0aGUgcmluZyBpcyBzZXQgdXAuIFBhdGNo
IDQgaXMgZHJvcHBlZCBpbiB2Niwgc28gdGhlDQpwcmUtZXhpc3RpbmcgemVyby1jb3B5IHJlZmls
bCBpc3N1ZSByZXBvcnRlZCBvbiA0LzQgbm8gbG9uZ2VyIGludGVyYWN0cw0Kd2l0aCB0aGlzIHNl
cmllcy4gSXQgaXMgYSByZWFsIGlzc3VlIG9uIGl0cyBvd247IEkgbGlzdGVkIGl0IGluIHRoZSB2
Ng0KY292ZXIgbGV0dGVyIGFzIGEgc2VwYXJhdGUgemVyby1jb3B5IHByb2JsZW0uDQoNCnB3LWJv
dDogY3INCg==
