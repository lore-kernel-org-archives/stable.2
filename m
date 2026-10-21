Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.165.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792567654;
	b=rb3AWveB37gL6X3JQoQQJqOoqK0O7v8zmB605sHinbaGekCHKIvhTGmkq91xVYQ0Ttxl
	 ZN8bsSkoB++RJASYqxJ4WabiBHUaafDGg+KPk15g6YhN576ilrp6DeN/6gTocF93Pv/ld
	 CRtFtDT6JJeeSyLKSFEV/J24EwHuZNEkd7gunZdxmWGuvEl+yCrcJDacn4tQtrnd0qyvD
	 eVdJvQ7z3C7vn7/kQOdfXCHW6YJa4t2cm9CNHP2X69gNlLhMGv9oZxnLIpYRCKvgw/aBW
	 dpyrJ/nBVdZG77uzQ/er8MMAK5kWFuaQoCLJsuW+T96oeE4HlZB29+GIz1f7xHb+KMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567654;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
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
	bh=Ed1YLizjhVK9k0gmvGU8o1YaZRyimmCa1mJ+0Ago8yA=;
	b=P9bmOHJ0U24jzpLK5UwdjYSrMSe50s3hILFYn5Z01tEifsR7rLp4HYue+Cf9wRFB6yMc
	 oBgyc1R0VGrHD1D+LlcyGoOmRl5wf7J4PKKrCO8csYqoBJJ6TIjgqJLuM08z0P995VqeL
	 KcJ5wZdAxHmhDGYhoKgenBn/9gE/dBLweHwlMquF+yBVgh0dCDUaBsCammT9vHejFV3zW
	 v45jDnzwnngPuoEQYynmSQ3Jc8yvrEuEOM348nLYoJ8vZZ2SMniTPmMKBEKFHgEWcHhH8
	 b/MxrPZqXmGQ7kqqEdHvhgkiyOGaK56rt+8o0qKrh47cbyvA93bqH7Iq3leFBxxlJwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=api-and-you.com;
	spf=pass smtp.mailfrom=api-and-you.com;
	dkim=pass header.d=apiandyou.onmicrosoft.com header.i=@apiandyou.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-apiandyou-onmicrosoft-com header.b=NhVvvSx3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.165.102
Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020102.outbound.protection.outlook.com [52.101.165.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC55606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CC55606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=api-and-you.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=api-and-you.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=apiandyou.onmicrosoft.com header.i=@apiandyou.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-apiandyou-onmicrosoft-com header.b=NhVvvSx3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcmWTTn4BLhPd28ofleB2yghg98xYI7BPaScMcSNUqgy++Yf6Qllbtq4IOpN6BJxxEA0GMDicOMaqCHedd2d+9IHmpwB8nVaiAZtr7LRttLu/yZuRL9YfgYY+gBW1jTrUQr6GX4tLY/5l7NLnbC1uETb2h06sjcki4O22Ha00Pzz1UqXkS/ZFhrBO2nF/z/poKlqB5vo+HeIW3Vtmw2f/hYBND2HCPfj/Nqv7euwdv1Xlbhd87O9pIFD/0h+64wyJQ42A6P8RCgVU8WDv7rog4hEzDSVW8HZ52N1AuBSnVk3G5Ct7uKsQTndBq9ULYqo3eT4jiWsp90R6FYClfZhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed1YLizjhVK9k0gmvGU8o1YaZRyimmCa1mJ+0Ago8yA=;
 b=k52qqMLkU6IjpHUEpkPRkXUHNMZ0dEzn/KQO0Efb57AW4S1CV51XkT5PRH4/zAMyKSps0Xme5ucODYChE3j4U5sVq5oAh1jEHEDa02u8uWO5h5GSm/o6ph0s3BM1y1ec7Lh80RaP1oPTZ21jD5nWdswCYkkrDutSO69nWmT3LJVw3vhLIzK0pN06u/EGvA1dnkgdsPH4VTWAlEskjSB6Pkbb661rc3Y2aczSFLv6FnXLsFcQBztbEZESWxneF5VKiu8+1OFRapV5LwF4YCEJIMXWGc0ptTTyOVqGClgtBcM+pKWt2AKhf4VcG/rmTaNHllUSoVu2xF6aKjtvxF4Pww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=api-and-you.com; dmarc=pass action=none
 header.from=api-and-you.com; dkim=pass header.d=api-and-you.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=apiandyou.onmicrosoft.com; s=selector2-apiandyou-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed1YLizjhVK9k0gmvGU8o1YaZRyimmCa1mJ+0Ago8yA=;
 b=NhVvvSx3SVAXZbHZ+8fIOOp74fDLWbPK+nMjIdfBxdt8pz88JChaTxrP9VhZJm+ptbsXLe23IXRKkc0iHkO+rVodS8HCez6wjBm/oCEqhkhFSKB9IqIshjd+C8nnjyM4n7Yi1tP+anK6CD+Z6KuBPt4EI2nIE9ShfxOP0H7SfyY=
Received: from PATP264MB4818.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:429::17)
 by MR1PPF21A78D74A.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::28d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 07:27:29 +0000
Received: from PATP264MB4818.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e552:b6a4:1ef0:34f4]) by PATP264MB4818.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e552:b6a4:1ef0:34f4%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 07:27:29 +0000
From: Thomas MISCHLER - API AND YOU <thomas.mischler@api-and-you.com>
To: Christian Theune <ct@flyingcircus.io>, Sasha Levin <sashal@kernel.org>
CC: Zi Yan <ziy@nvidia.com>, Deepak Nagaraj <deepak.nagaraj@baseten.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "mfleming@cloudflare.com"
	<mfleming@cloudflare.com>, Kaz Kato <kazuyoshi.kato@baseten.co>, Stephen Day
	<stephen.day@baseten.co>, Greg KH <greg@kroah.com>, "1151281@bugs.debian.org"
	<1151281@bugs.debian.org>
Subject:
 =?utf-8?B?4pyU77iPUmU6IDYuMTIuMTEwOiBrc3dhcGQgTlVMTCBkZXJlZiBpbiBsaXN0?=
 =?utf-8?B?X2xydV9hZGQsIHBvc3NpYmx5IHJlbGF0ZWQgdG8geGFzX3NwbGl0X2FsbG9j?=
 =?utf-8?Q?_backport?=
Thread-Topic:
 =?utf-8?B?4pyU77iPUmU6IDYuMTIuMTEwOiBrc3dhcGQgTlVMTCBkZXJlZiBpbiBsaXN0?=
 =?utf-8?B?X2xydV9hZGQsIHBvc3NpYmx5IHJlbGF0ZWQgdG8geGFzX3NwbGl0X2FsbG9j?=
 =?utf-8?Q?_backport?=
Thread-Index:
 AQJ9H4ufAJCaAvPEscKHWyDdUqKr7QG/Sn+hAkSGMaACwzJ2aANJLCBtAs7xv2IBECTCfAGkx4AmtUt5M+A=
Date: Wed, 21 Oct 2026 07:27:29 +0000
Message-ID:
 <PATP264MB48180D3DFF94FB287D09CE64E0662@PATP264MB4818.FRAP264.PROD.OUTLOOK.COM>
References:
 <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
 <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com>
 <CAL3JwHN34En=iiEB+Zyxo3=_xfODTY_k_kddb2njN+AJwSCnnw@mail.gmail.com>
 <7C66B0B0-1F43-41D9-9B4F-89956045D81C@nvidia.com>
 <2026100327-shrine-refusal-0488@gregkh>
 <2026-10-03-1-daily-reply-0006-re-kswapd-list-lru-aca1f2d5-6-18-queued@kernel.org>
 <9479A92E-645A-4A30-8332-212707E66A35@flyingcircus.io>
 <BC985D55-6DAC-4897-A3CD-51FFBB33FEA5@flyingcircus.io>
In-Reply-To: <BC985D55-6DAC-4897-A3CD-51FFBB33FEA5@flyingcircus.io>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=api-and-you.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PATP264MB4818:EE_|MR1PPF21A78D74A:EE_
x-ms-office365-filtering-correlation-id: 39631f60-0278-42da-5e6e-08df2f44c3af
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 57b/VlmiYWkGRJBkDVaHGl8YxU051fdwWnpLHmW94GOY1t+qYh0/UdFdWK5v3oyrj30ET4GpAiUryaVD9PLzOuRKUSotSvDTyYVwNte/Nm1jehHbl/qsXGaiTRtf0qJMJJH6DA8h2dR3TEu1KvNmPvQJf40lz6mKJwnnt5b8yZyBK1fmkWcJqDqc4t5Hns/qJerLGTlHt1NA+lZVx0bCRDJV5uZA2BNeY5OjnVa+QhSsBwyOkuM13AchuntQZBW08xxblImb1t0vfaawXrE7+sZat2zNN5YIFzk+LpymRJObXbaEY/m8FwWJ3nGdaqXd12IZvDgM2ngA/zqLxgsgacu9PoZsHP0Tjgmwcp4Phrk2Q35lQIyCoeiR44cu43VON2ER1+TKvidt6+LOhFZ8OG0VTuXT+hZB9myO4hqrEIlSy8cCVm3S5RQMk6r0R3WPk5eLjlKS3WZwhF0qmWV1O+DCGRppOzcpOUUutHS8/GQ+aQqzh7nhxt89l31eVNFIM2mrePv3KGhHKnIvbDPZH8Effd9Z1iMu3WbnswSyAezrwi3wsJNjoYd5Y4W+uh4yTEP265VVwrSYQ0RweqhOjsCPglctXaE0meRaI3/Anc/x0y11sbF3MsKbpTFL1sfe1WWsKuIN8uKDBlDa6eZILNbVJJkf3iU9vbLIxtjUtRI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PATP264MB4818.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWVRT293L2g1T3ExSnk3K2tUNEZsQnlzRXc0UkErM0tFMTFjQ0hqZjZ5VnR6?=
 =?utf-8?B?cGM2RjRRQlNwWGp6eGFSZmgvcmJDN3lRbG04S2JmNVRuaFBRc3dqdTh2NG8w?=
 =?utf-8?B?L05rSFh2NDZ6RDJtMWxvS0lYcWdmMkpUNm1BRlF3VDFpbGYxUk1aQ2JkZUtF?=
 =?utf-8?B?YlFsYStKYXc4RHJ5eXF3SW4yUlREN0FTVFdxZXZnMlQ3dnlpZ3pDT1VzblQz?=
 =?utf-8?B?cWlmUm44blBVRXlKQy9zT08vL2VxcDdXdExFSURPdVFicVI5enlCVDExMnRO?=
 =?utf-8?B?WVZ2WkFXS1FmanFHWEtSQmppVkYzbFJqYnZqcDVoOHZYUVpORHJ1UVJ6MnR1?=
 =?utf-8?B?TnFLSVFiYzZUL3VrV1RPOWJaOUl3bGJ0QjgwQnE3L2hIbEFmcVVBWGllOG5Z?=
 =?utf-8?B?a2t5clJ4RDIvVS93M0pCbHlOT2l3Z2g0N1E2V3phRlZpNGJOWjlXcWFUTlp6?=
 =?utf-8?B?d2daUFRHTGM1RlQzcWRWczd6dkVWWnNqaVNYWmJDN0ZlRnNUSnM2S1QrRG9K?=
 =?utf-8?B?TnVqUkJjclpxVXZ0YkZGSEZUYTFSNEFHUFJzaDJyQWJ0WHZ6ZllFaDYzSjg0?=
 =?utf-8?B?Y0F5Rk40ZHREYitkbThkVmdlZDBoYldTNk1LbHlWNHMwU0kzcFdsTzBUWWtp?=
 =?utf-8?B?NVh6L0RZMXRQQkdBTzBwdDFQUjNDZEVPdGdKakVCVmI5Q1ZmcHY2ZW83QWo4?=
 =?utf-8?B?dWpJdWZ2OWpxWC95V0VvcmpJLzc4VzVQZCtzdDdSOXVJOVNyVW16bTVXYnZw?=
 =?utf-8?B?eHhYZWY5ckdHZjQrYXphRWk3WkkraVBoMnN6ZjZMNDdsNVVvWDJCMTNJR0Qx?=
 =?utf-8?B?OXh3R0RUbGo5S3duaGJIL1V1TEpObXFxN2VtYUY2aDljdHdDWFRXUWhhdTZh?=
 =?utf-8?B?c0U2WGdXbzUwQmZ4K3FpbXFGK0NUVHNxUytkMlBBSzAxc2FhUS9NbGlQTTdq?=
 =?utf-8?B?YlJyMkN3dzQxd3BlRVh2TSs5c244U09sYk5aM0sxdko0cUU3cFpBTXltdE5G?=
 =?utf-8?B?Q1EyNENaalpCVEJEY0dEaGIxbVVmbTR4OVBTdktHY1oycDZiYkw0akpuMXBL?=
 =?utf-8?B?cDlJdFRTK1VYenN3NlpsdVRuWVBSditVWkFpaWRNeTdkb1g4QW9EOUlvT2xm?=
 =?utf-8?B?MFU4ME5lTXZrcEZjMldYMGRodVRkQ2lBVDdOQi8wbmx0K2V2WWJacVc2c2NR?=
 =?utf-8?B?RE5qeEZOb0NzNjdQWTM3VHhUbnJ5ajh6cFhWZzhRMGp2alprN3ZLOGNRZyt0?=
 =?utf-8?B?YWl5SEVsZkpzbjJTOFowTEhOWXpPVExWQW4xSkt0UmNJN3hQNlZtek5sV2dm?=
 =?utf-8?B?NktRd2FhR0k1ZUFyc2hTWDlROEdkV3ZTRzFxVUNiVE9lekRaaEJGZEYvTGFE?=
 =?utf-8?B?VkttTXpONE9RdG9zUnd1NWlxcXhsajAyL09DR0QzRVl0SXo0UjRGaHpHZXdZ?=
 =?utf-8?B?VTg1YkZscUVVLzBTK2wzbjh3ZUcrSUd6bkhadUxkbW9SaVZ3dnA5eXRiTFI1?=
 =?utf-8?B?d1lINnNXb0MrRC82SThjdzJ4R3NDWGN0WFNSU08vc3prYmo4c3BwbTNrR3Q2?=
 =?utf-8?B?N0hsWG1RMHlDMkZ3cGx3cmZuKzdteFU3cnFNNzQrMUs4TkpSNGs1NkVEaEdW?=
 =?utf-8?B?RUZWb0pBTkU3MVpBVTZFQ2hVblZBazI5cUNabFZDczg3RVl1UEFTR3g4YUJi?=
 =?utf-8?B?eUR3Y2pYTml0L1VzaUJ1M1pITGRQd3kzaFVnMmJOWWMwRE5rM210M2xTM1FT?=
 =?utf-8?B?YWhKUHJWcUhNcStlajREbTBJeGgwdi8wTnhHOGxmWlNSVjA3ejhPakNlWFFE?=
 =?utf-8?B?bkZxUzZ1Ymo5Qjl1anZjVmVSL2tNZHFlMUZWVjVPVnF4NllycWtqOUZUcTRE?=
 =?utf-8?B?OGZ1WEtEUGpXYzRWbG9EMm5BbFpqdDljM0duTTNtVnc3cEczSm9remo1UFNa?=
 =?utf-8?B?clF4czJmczFCNzJTUG51bTJtdWs5MjNYaGVOTUdnU2dwUWQwaHViK2EwSldT?=
 =?utf-8?B?L0pzcUN3Mi9pZlhCYVV3S3NLYjluQjgzb01jOU5OdWQ0ejc2UnRJU01QaXFp?=
 =?utf-8?B?Uys3bEJkTUVWQmQ2dEVaYXB3dndSVHBOaXpLWkMyL2VLQk9VTWlMemg5SmZa?=
 =?utf-8?B?ZnVuUDdEQjlrcXloQkx2UVA5NHNtZUFHUFBXaWNRcDQrZnc4WlhWekczY25P?=
 =?utf-8?B?Z2J5dytUcld4OEUyOUh2ZmlWcVJia25tUEtzdDNvbUhCLzgzOGhrc2QvUHFP?=
 =?utf-8?B?aEphcEpoeDhGK0MvV2tJMDhUTnEvdkFpUjhZdWtWSVVIU3p6R3RnaXAyYU1w?=
 =?utf-8?B?enJHSlVCWVVXdzNiZkdyNzkyWGM3Q1RabzhsRTdBT2JOdDF1KzNXMERKVm1X?=
 =?utf-8?Q?UhpiuttW9PJKKxLM=3D?=
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
X-OriginatorOrg: api-and-you.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PATP264MB4818.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39631f60-0278-42da-5e6e-08df2f44c3af
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 07:27:29.6932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7edadab8-8a99-4262-9463-71d417b61508
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mv7XnVelOYTu1NYWdAGrxGTOeAU1HSqujST27MYE49yD2a6ssZq4eGf/HzffiApQkYerVKCwe1d3tnZclBp59Dw6zS3tm4JT93Hraik48xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF21A78D74A

SGksDQoNCk9uIFN1biwgMTggT2N0IDIwMjYgMTM6MDk6MjYgKzAyMDAsIENocmlzdGlhbiBUaGV1
bmUgd3JvdGU6DQo+IFF1aWNrIG5vdGU6IHdoaWxlIHJvbGxpbmcgYmFjayB0aGUgYWZmZWN0ZWQg
bWFjaGluZSwgSSBub3RpY2VkIHRoYXQgd2UNCj4gb25seSBzYXcgdGhvc2UgZXhhY3QgY3Jhc2hl
cyBvbiA2LjEyLjExMiBidXQgbm90IG9uIDYuMTIuMTEwIGFuZA0KPiA2LjEyLjExMS4NCg0KQW5v
dGhlciBkYXRhIHBvaW50OiB3ZSBoaXQgdGhlIHNhbWUgb29wcyB0d2ljZSBpbiAzMCBob3VycyBv
biBhIEtWTQ0KZ3Vlc3QgcnVubmluZyBEZWJpYW4ncyA2LjEyLjExMyAoa3N3YXBkIC0+IC4uLiAt
PiB3b3JraW5nc2V0X3VwZGF0ZV9ub2RlDQotPiBsaXN0X2xydV9hZGQrMHg4MywgTlVMTCsweDgp
LCBEZWJpYW4gYnVnDQpodHRwczovL2J1Z3MuZGViaWFuLm9yZy8xMTUxMjgxLiBBbWF6b24gcmVw
b3J0ZWQgaXQgb24gNi4xMi4xMTAuDQoNCkluIGNhc2UgaXQgaGVscHMgd2l0aCB0aGUgNi4xMiBi
YWNrcG9ydCBHcmVnIGFuZCBTYXNoYSBhc2tlZCBmb3IsIHdlDQpoYXZlIGEgcmVwcm9kdWNlciBh
bmQgcmFuIGl0IG9uIG9uZSB0ZXN0IGd1ZXN0ICg4IHZDUFUsIDggR0IsIFhGUyBvbiBhDQpsb29w
IGRldmljZSwgTUdMUlUsIFRIUD1hbHdheXMpLCBwcmlzdGluZSA2LjEyLjExMyBmcm9tIGtlcm5l
bC5vcmcNCmJ1aWx0IHdpdGggYSByZWR1Y2VkIERlYmlhbiBjb25maWc6DQoNCiAga2VybmVsICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdCB3aXRoIGJhY2tncm91bmQgbG9h
ZA0KICBEZWJpYW4gNi4xMi4xMTMtMSAgICAgICAgICAgICAgICAgICAgICAgY3Jhc2hlZCBhZnRl
ciB+MTMsIH4yKiwgfjI0IG1pbg0KICBwcmlzdGluZSA2LjEyLjExMyAgICAgICAgICAgICAgICAg
ICAgICAgY3Jhc2hlZCBhZnRlciB+MTQgbWluDQogIHByaXN0aW5lIDYuMTIuMTEzLCBhZDgxMjgw
NWZlYTcgICAgICAgICBubyBjcmFzaCBpbiA5MCBtaW4NCiAgICByZXZlcnRlZA0KICBwcmlzdGlu
ZSA2LjEyLjExMyArIDYyZTcyZDJjZjcwMiArICAgICAgbm8gY3Jhc2ggaW4gMTIwIG1pbg0KICAg
IGFjYTFmMmQ1ZGUxNyBhZGFwdGVkIChiZWxvdykNCg0KICAqIHRoYXQgcnVuIHN0YXJ0ZWQganVz
dCBhZnRlciBhIGtlcm5lbCBidWlsZCBoYWQgZmluaXNoZWQNCg0KV2l0aG91dCB0aGUgYmFja2dy
b3VuZCBsb2FkIHRoZSByZXByb2R1Y2VyIGFsb25lIGRpZCBub3QgY3Jhc2ggKDMwIGFuZA0KNjAg
bWluIHJ1bnMpLiBEdXJpbmcgdGhlIDEyMCBtaW4gcnVuIG9uIHRoZSBiYWNrcG9ydCB0aGUgcGF0
aCB3YXMNCmV4ZXJjaXNlZCBoZWF2aWx5ICh+MS4wOU0gd29ya2luZ3NldF9ub2RlcmVjbGFpbSwg
fjM3ayB0aHBfc3BsaXRfcGFnZSkNCmFuZCB0aGUga2VybmVsIGxvZyBzdGF5ZWQgY2xlYW4gKG5v
IEJVRy9XQVJOSU5HKS4NCg0KVGhlIGJhY2twb3J0IHdlIHRlc3RlZCBmb2xsb3dzIFNhc2hhJ3Mg
ZGVzY3JpcHRpb246IDYyZTcyZDJjZjcwMiAoIm1tLA0KbWFkdmlzZTogZml4IHBvdGVudGlhbCB3
b3JraW5nc2V0IG5vZGUgbGlzdF9scnUgbGVha3MiKSBhcHBsaWVzIGNsZWFubHkNCnRvIDYuMTIu
MTEzLCBhbmQgdGhlIHJlbGV2YW50IHBhcnQgb2YgYWNhMWYyZDVkZTE3IGJlY29tZXMgYSBzaW5n
bGUgbGluZQ0KaW4gc3BsaXRfaHVnZV9wYWdlX3RvX2xpc3RfdG9fb3JkZXIoKToNCg0KLS0tIGEv
bW0vaHVnZV9tZW1vcnkuYw0KKysrIGIvbW0vaHVnZV9tZW1vcnkuYw0KQEAgLTM1MjksNiArMzUy
OSw3IEBAIGludCBzcGxpdF9odWdlX3BhZ2VfdG9fbGlzdF90b19vcmRlcihzdHJ1Y3QgcGFnZSAq
cGFnZSwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCwNCiAJCQlnb3RvIG91dDsNCiAJCX0NCg0KKwkJ
bWFwcGluZ19zZXRfdXBkYXRlKCZ4YXMsIG1hcHBpbmcpOw0KIAkJeGFzX3NwbGl0X2FsbG9jKCZ4
YXMsIGZvbGlvLCBmb2xpb19vcmRlcihmb2xpbyksIGdmcCk7DQogCQlpZiAoeGFzX2Vycm9yKCZ4
YXMpKSB7DQogCQkJcmV0ID0geGFzX2Vycm9yKCZ4YXMpOw0KDQpUaGlzIGlzIHRlc3QgZmVlZGJh
Y2ssIG5vdCBhIGZvcm1hbCBzdWJtaXNzaW9uOiB3ZSBhcmUgbm90IGluIGEgcG9zaXRpb24NCnRv
IGNhcnJ5IHRoZXNlIHBhdGNoZXMgdGhyb3VnaCByZXZpZXcgb3Vyc2VsdmVzLiBJZiBzb21lb25l
IHNlbmRzIHRoZQ0KNi4xMi55IGJhY2twb3J0cywgd2UgYXJlIGdsYWQgdG8gcnVuIHRoZW0gdGhy
b3VnaCB0aGUgc2FtZSByZXByb2R1Y2VyDQphbmQgcmVwbHkgd2l0aCBhIFRlc3RlZC1ieS4NCg0K
VGhlIHJlcHJvZHVjZXIsIHJvdWdobHk6IG9uIGFuIFhGUyBmaWxlc3lzdGVtLCBhIGJhY2tncm91
bmQgbG9vcCB0aGF0DQp1bnRhcnMgdGhlIGtlcm5lbCBzb3VyY2UgYW5kIHJ1bnMgIm1ha2UgLWok
KG5wcm9jKSB2bWxpbnV4IiBpbiBpdHMgb3duDQpjZ3JvdXAsIHBsdXMgNCB3b3JrZXJzIGVhY2gg
bG9vcGluZyBvdmVyICgxKSBpbiBhIE1lbW9yeU1heD0xMjhNIHNjb3BlLA0KcmV3cml0ZSBhIDI1
NiBNaUIgZmlsZSBpbiAyIE1pQiB3cml0ZXMgYW5kIGV2aWN0IGl0IGJ5IHJlYWRpbmcgYSAxIEdp
Qg0KZmlsZSAoY2FjaGUgZHJvcHBlZCBmaXJzdCksIHRoZW4gKDIpIGluIGEgZnJlc2ggTWVtb3J5
TWF4PTk2TSBzY29wZSwgcmVhZA0KdGhlIDI1NiBNaUIgZmlsZSBiYWNrIHdpdGggcmVhZF9haGVh
ZF9rYj0xNjM4NCwgcHVuY2ggYW4gOCBLaUIgaG9sZSBpbg0KZXZlcnkgMiBNaUIgYmxvY2sgYW5k
IHJlYWQgdGhlIDEgR2lCIGZpbGUgYWdhaW4gdG8gZm9yY2UgbWVtY2cgcmVjbGFpbS4NClRoZSBz
Y3JpcHRzIGFyZSBhdmFpbGFibGUgb24gcmVxdWVzdC4NCg0KVGhhbmtzLA0KVGhvbWFzIE1pc2No
bGVyDQo=
