Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944663;
	b=CtvKoW3/OYtLXWjDzUOHumqOALPH7l82NIPSxQFgEjiQBG9ix7YNGHNcxvS0dPVSgq/A
	 d2+gIsjHmFqU3ge9fizi765aJdWN90jKU80R4pDqkbtvm5cl5D40VpZ+94veexrMiwJ5N
	 bDcoGzRDCSjDB6dAq7hYZRcQVYodYgrtyWN/graWG44uy0CrVVSUE4FrTnNWydD5vfPh2
	 /9l6tSpmcGkinZrUAm770gYYFRYG4CZxBEKNEEohBmbzSRfdCQXPY65IBu95I6PYYnIIS
	 jx/Lz7RMczbyWg1TubSaI7NpFO/OdqHb3akBDK63DUuO2ZUp/hoSh6v8EghdEK0Cd7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944663;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WV7zneRC344A/9TCGxrBaBRQlE+W+TmXdrUB/D/xHQk=;
	b=mISnYo5wRl80uJqSnSw4IpBjF+iMsSok9QtYy7cvJEWP/6fXiH22jr8FADqljLeCKZsJ
	 +dWla+ibh6MIvnNRmyFCqK5qj489VnQLlyRhPPu6+vknJgThWjqe7ryatbNHpa3rFHmXk
	 tSkjV9SuC1Lzf1RZSNLtzO/wTE8oTU+jsM4EmyOh80X0RH3gqgTXVmUzy6zTMu/na2+Uy
	 yvkCbS7hKNUvM+DzLQTVf/nKrVYKvnfdpnYt0BlMw/ZUuTxzLgS8yHEhpnH07wn2t9ztt
	 h7Ze4MQWZkKI8h+Adbbgd+SkTOhaVVog7PseLi5bBR7oJiQKFzmoLWLpbkvUmPK5nnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OLOzIAfA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.32
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443A606A884
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 19:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B443A606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OLOzIAfA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5rY8IPlydw/96CdM+F1n2HwqYgFHw9kOmYredDIgK3ORRRiS3IRu09W6MVIvvclGLzjsZcxZnhmJChMUiiKMImNiCXUe6IsGG2vag7ohGYi9whxDagZtCQ7vTDbe4qhLBRdzYs0X5IqxoBmsKka+ZzH7lk2+NRDThjoFQllFmKmQo9J/q38oAjcs/VItC8Ms2+yhkkbq6qoGYOibz49KZwF3Dh6pTDcP+Kdyz3PA0TsdVzfZLJoL2sM+zMVhWDaeWya2Slwlier+qJ+6fFS1cPHA5f//DViNcxUHaKTGDGiWJ2Y1vWo2vQqCQinJ5JM9Z20Sj0h2+oKwZ4q9afjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV7zneRC344A/9TCGxrBaBRQlE+W+TmXdrUB/D/xHQk=;
 b=K6m8e77ELbDHKoYp8UO8RnIbTKFIHW+jwnfS1Bcyl6LBqWjcaL1+frbmLNlaTFUV81ZwftQ0Z873dzdH5SjtF48DZZshqGNLjT1gpFu0n4+vz+gN8WUj9EXgD+mDf0l/lTPkiDJnAGetT5v2wRcRd64b2xWVqzFsKBkIwrJfH8zsp59rAcoIOVLD2iZN5G6dh0drEi2MLZDvYjaZtxZNOYkSzrK9M2yDC5RCemFpaR7BguSkDWBVDWjd9JPLQjpO3jFh3i7OZuQGfm2MAEkeii9p+vCBHPKmRD3D/mhmGusJnKP9xXZhk8TJ2WGp1a//vNFIdc5Da0e/Wa/sNJ4Pvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV7zneRC344A/9TCGxrBaBRQlE+W+TmXdrUB/D/xHQk=;
 b=OLOzIAfAUgUSAE/twc1CmGifCMvp7kK70iEr53Q6Ctl2u/gZCStbfGf6tOPWoKZMBXwJSMFJmxVZNT0fE5E3AgX1MIC9TRRGtA57hzjvk/d3Ooivu5Ca7g3EijOAbqrqM+wgXfw4KHOkSMRH42rpsJBW+ZkohpXkYRNcScP3g21VGJ5Kvt7CAvr0ypD8HeitqUxzsV9E0tf238sSxXOu6b6ifL+3jxPx9ktn0dAPcsVl6yIvN2jCrFy8ImbnGkOHpcIN6zSIPOH2kxilQftTWDoE+s3bou6C1H/3uB0PRrawkTqM/qqD+GCxQvIsz87wMcPvBac1ArookjCbfz0IGQ==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by DSVPR12MB502102.namprd12.prod.outlook.com (2603:10b6:8:3eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:44:18 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 19:44:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ankit Gupta <ankit6791@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: limit Write Zeroes to 65536 logical blocks
Thread-Topic: [PATCH v2] nvme: limit Write Zeroes to 65536 logical blocks
Thread-Index: AQHddjDOdyvXmVDgikOZVA24WJ1tTrcyq66A
Date: Tue, 17 Nov 2026 19:44:18 +0000
Message-ID: <4767b0f0-0c61-4d8f-9594-b4b4df432da5@nvidia.com>
References: <20261117011230.10288-1-ankit6791@gmail.com>
In-Reply-To: <20261117011230.10288-1-ankit6791@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|DSVPR12MB502102:EE_
x-ms-office365-filtering-correlation-id: e4bf20ce-456b-4004-96c5-08df44e32b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261021121427099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info:
 knaTLF5A5IjxcsE5sklvhpI7Cz0gHynyKg/3MUdaDZG9k34CxtH/JqI+k4eI3cRvCQqisvkK8s69LBu3z1tu/lqe6Zl/Xt18nljkzvvTcraG2JHNJWpDFBCc8/JPH7stIVpkLii/OBhSjMr3vQ3+0fgBF2sCKL66CggUkVQoJ1WL2lDXZHLtTIFFON+JSpEtMtqrB5OwDsS92lQxFg2xRwFXvdBj98c3W9HF0b/aImGASFpfsrr5FzsfzNWLFkFb44mNS4n/85s27CDPp+59vcDTeXAO08vd6Nnn6+e7d8O054as+F9AlYM8n7IlOaXWpweX13gpJgz9YMoJstv+jnIix/KfU81uz4s9hz11mr3d6VK69GFwZRPDSy2vZlnnWkomxwZLm6naInRDkhkCGWctVPWTaP+84eITgbqxpgy6qkTATZyuS7c/G2rDeJvFOhHrSpo5+iQoAAgdpXXQKRhmOIDALImW7HmBn8WGohte5D8bSmV7BoznFWLeQasN8IJkBVgHPlOM7G/XYledMm/gDUPdtsv/SnbzO7eGh12vsQqXTqPzZMxF3p5ueBOIxFLZp7wKJWfOXbQ/qZIv5SiabwO9doDKMd3JR/UwHvbuXmqVuTGr/YTCS0/8pCiC+6uhcuScGaAdSqI7CDNFXgiv2RikkGFuvMon/nZ7hshUputV4IqGq/4oC8Yh0PbrfF8/55PYIwwCzoxFM4f6EtxY+ZDXOGMsGw7myvLkNDI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2drU2gxeC8wNklFYVMvS2RPaUc4M25XR0hzRHY4RUZsQjlpT2NJcTVkMU5Y?=
 =?utf-8?B?aDdiYVJ0REZTWVZOVWYzdXNZSVFYd3pTbWdWd3hQQWs2YWQ5ZnNOcUh5c3FN?=
 =?utf-8?B?czU0amNOc252Yk9QclVFcVlPY1F2ejFuQmVpTTVMd3hLYXo2NlRWRkEwTjdZ?=
 =?utf-8?B?Zkk4RE5JY3VXbmRCNWNGT3VEQnNBdWRlNkJMaFJ4WTZXODF2SXhxQlhoRHVE?=
 =?utf-8?B?M0hxd2dqdGJydjFVbkRnSDlUTTRLWGVFcGVFejlQOXdaNm83S2FLRCtNOGRE?=
 =?utf-8?B?ak1IL2doTGlDK0dNU1dONnQwbGY2eFRuejVqekJXRVA0UEovR1dkUVhYUEYy?=
 =?utf-8?B?Rjl2eVg0bWRETVc2Y2R2NFdOY1BWd1NIUk9CSWc2bG9NK3JBV1Jjb3NtUzMz?=
 =?utf-8?B?UGtwRGVPakZSTFFST2FNZ1M0bmFIc0Z3S1NnNHM5MnVINmdhblViMTVDQW5Y?=
 =?utf-8?B?ZjZFRTlMK0U2bWY1RHprQ0Y4WDErVDNSeHZmeEJQR0ExbUs2N01UcnkvVFNC?=
 =?utf-8?B?N2lqaUJzczRkMmVzT1RwSGRjK2kxOXFIcnJvMEwwWnZoVllqTkFxdHZUQzI0?=
 =?utf-8?B?WUJZNGtGTUZEMzFjYXpCWHRITTRlWTJpNzN5M0d1N2dYd2Y5S0ZIeUxmb083?=
 =?utf-8?B?eU5QTE82T2l6cTdsVkhrdGZUQ3dtTk90M2RyMlM2bVAzMlh6bGY2OHp4UFlj?=
 =?utf-8?B?QjNLR1pjSGZrZnptdmpQY3FRM0xVQkVqMkdVenpJU1FqTkJBbUtmdytmRXh4?=
 =?utf-8?B?TG04Q1hsQ3dkMnJqWUVBeDV1R0IxS2N2WitkaVlLOThDaEI1UVVyaW9tNXJk?=
 =?utf-8?B?Ty9lcVJqNURGTkphS0NVNldrcFlKT0E4eWdwVUZnOSs2Rkc0TFlxclh3cnpw?=
 =?utf-8?B?clk4Mmh5Y2VUY1QxQmtUZ2ZxYStwdzQ4dnNpcGhHeWltVmdxTnl5eGNBWER5?=
 =?utf-8?B?N1JiVlIzUUl3NElldHU4WElYb3MyZWZabVVmNnFQeUlGdzg5S2w4NVZQWjBv?=
 =?utf-8?B?QXhhQ0prK1VQQVFuaHpDZkszN3NRSVREME11WXkxYW9hWVVSK0VQTi9icm8z?=
 =?utf-8?B?VjEzOFpCMTNrTHkwV3Vab1Y1TElXMndGM0ZuSFVGVVdZQ0lyWEhyOWszWWkz?=
 =?utf-8?B?U2IxVTNobUt1VVR6ajNxNzMvRjRDeXU3KzA5azh3azZOUE9kSWZqczJiNmxG?=
 =?utf-8?B?QmFLRXFZbVhPRnVSYU9Iei9HVDNpMC94UEJKOEY4emVQZUlOc045QVZJRUxp?=
 =?utf-8?B?NkxXR1JTMGxjU0Rudm80bTltTExRQTQ4ZDV4bzRDejIrRmhnVXFQVlpQYjVQ?=
 =?utf-8?B?Tm5LbnJGQkRtZUFUeVBDUzlpanZ2UHZBdmRKeGpnQnR3ZDlCL3MvSjBGby9O?=
 =?utf-8?B?ZTMwSzNqTExpU2c5NmxPTzR1OGlEeWdKdFFQRGN0R3BjakRaNmd1ejNWOUpQ?=
 =?utf-8?B?QzRiY3dzeExPTDBkaHpJT2ltS28vTm1qdlpIL29DRktnSi82UTVnYTZTMzUw?=
 =?utf-8?B?dWgrTU0xTDFmWUFRNXdNOFZsUDFocXpVYUwrNmtPSnpuVEgzN3lHaTYrWDU5?=
 =?utf-8?B?TVdSSk9qQ0xuUDFTSCsrTytHSHRqVk1hVU1hanNzMmdLQSt0anY0NW9yTEhh?=
 =?utf-8?B?TGd4UVA1ZVJTR2NrczdRRGhLaElQYU9rL2szd0dLQkQ4T3NYdm0yZWVURnRC?=
 =?utf-8?B?SWFWcVpkMUZxdEduUXZFWC8vdE5NRWxidFNLTjY0N0xpbzR0T0FWNjNwakwz?=
 =?utf-8?B?a2RtdFl1MHBORTJabG9GckowTUk0SGRrZFB4bVlGNzladDBzRmhQWUU5eXFN?=
 =?utf-8?B?ODJ2NWdOL04rZmtoM1ZhSW5vNnRIaXg1U2VJbm9EeDhEZ3ZRaDU3WWFSUDhl?=
 =?utf-8?B?WVRzeklobTJ1WENZNG1hRjRBRkZ6RTJzWVpLZzdibHNhZGR0dnJFQm10bkFu?=
 =?utf-8?B?VEdOUU9TeE0xcVRSTDBsUlVuUERwcFQ0UGlPU2wvemV0dzdqSWw1QkZIMktP?=
 =?utf-8?B?WFozZmxBdWxVRW9yQ0lHTjZadHVueERrdTRFMGZNcUppOFhNWklMU3J6TldB?=
 =?utf-8?B?MXovbmxnS3pFbFlZb0xBZHlUR2RNbUVhcE5hMkRvdi9hVnlLeHpYUnY2U1N2?=
 =?utf-8?B?VXZGOWJ1SE95cFVCQWZIY25iSDVtbWhPcStueVFTemxJT3RvZGlRTTJSMStZ?=
 =?utf-8?B?M0tVeE1uaVVHTGxXYXdTZ0NhYWk1Vm9vUTBhc2w1cEpjNWhUU3EvakJ1Ukto?=
 =?utf-8?B?K2lmOVFMWVFmZ2tSa1JZSTVhdDU5N2VFRndhN2ZENlRaaVRZUlV5R2NXRkZC?=
 =?utf-8?Q?9BiFPDFt1Pm/gtQ4ie?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E16A92CF23CE144BEBE471F36D4853B@namprd12.prod.outlook.com>
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bf20ce-456b-4004-96c5-08df44e32b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 19:44:18.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECExPwjG+Ax/TLSPf62f5/ye7tgtVJu/GImOMxytIUU8Q+hc67XHXPnQHXAHxUJ83b+8g3aKB9Z7HEw+ghoWLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB502102

T24gMTEvMTYvMjYgNToxMCBQTSwgQW5raXQgR3VwdGEgd3JvdGU6DQo+IFdpdGggbnZtZS10Y3Ag
Y29ubmVjdGVkIHRvIG52bWV0LXRjcCBhdCBkZWZhdWx0IHNldHRpbmdzLCB0aGUgdGFyZ2V0DQo+
IHJlcG9ydHMgTURUUyAwIGFuZCBXWlNMIDAuIEEgMzMgTWlCIFdyaXRlIFplcm9lcyByZXF1ZXN0
IG9uIGENCj4gNTEyLWJ5dGUtTEJBIG5hbWVzcGFjZSB0aGVuIGNvbXBsZXRlcyBzdWNjZXNzZnVs
bHkgYWZ0ZXIgemVyb2luZyBvbmx5DQo+IHRoZSBmaXJzdCAxIE1pQi4NCj4NCj4gVGhlIG5hdGl2
ZSBXcml0ZSBaZXJvZXMgY29tbWFuZCBlbmNvZGVzIHRoZSBudW1iZXIgb2YgbG9naWNhbCBibG9j
a3MNCj4gaW4gYSB6ZXJvLWJhc2VkIDE2LWJpdCBmaWVsZC4gVGhlIG5hbWVzcGFjZSBxdWV1ZSBj
YW4gYWR2ZXJ0aXNlIGENCj4gbGFyZ2VyIGxpbWl0LCBlaXRoZXIgdGhyb3VnaCB0aGUgTURUUyBm
YWxsYmFjayBvciB0aHJvdWdoIFdaU0wuIEluDQo+IHRoYXQgY2FzZSB0aGUgaG9zdCB0cnVuY2F0
ZXMgdGhlIGNvdW50IHdoZW4gYnVpbGRpbmcgdGhlIGNvbW1hbmQgYW5kDQo+IHJlcG9ydHMgc3Vj
Y2VzcyBhZnRlciB6ZXJvaW5nIG9ubHkgcGFydCBvZiB0aGUgcmVxdWVzdGVkIHJhbmdlLg0KPg0K
PiBDYXAgdGhlIG5hdGl2ZSBXcml0ZSBaZXJvZXMgbGltaXQgYXQgdGhlIG51bWJlciBvZiBsb2dp
Y2FsIGJsb2NrcyB0aGUNCj4gY29tbWFuZCBjYW4gZW5jb2RlLiBDb252ZXJ0IHRoYXQgbGltaXQg
dG8gc2VjdG9ycyBmb3IgZWFjaCBuYW1lc3BhY2UNCj4gYW5kIHJldGFpbiBhbnkgc21hbGxlciBj
b250cm9sbGVyIGxpbWl0LiBUaGUgRFNNIGRlYWxsb2NhdGlvbiBxdWlyaw0KPiBjb250aW51ZXMg
dG8gdXNlIGl0cyBvd24gbGltaXQuDQo+DQo+IEZpeGVzOiBiOTRlOGNkMmU2YTkgKCJudm1lOiBm
aXggV3JpdGUgWmVyb2VzIGxpbWl0YXRpb25zIikNCj4gQ2M6c3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KPiBTaWduZWQtb2ZmLWJ5OiBBbmtpdCBHdXB0YTxhbmtpdDY3OTFAZ21haWwuY29tPg0KDQpU
aGFua3MgYSBsb3QgZm9yIHRoZSBmaXgsIGxvb2tzIGdvb2QgdG8gbWUuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
