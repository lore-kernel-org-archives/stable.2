Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956D3B1EE2;
	Mon, 28 Sep 2026 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584055; cv=fail; b=oLqiolN38cC4Fkd/7M5zV4DUJFmRurPFc4q7kC2QoFjgdki6KoDh/QJFdHuOA+92mTHWTfR6ct3E/F1bGw+ZuThvbGT+J+NGPAVf8kpiMuVNhvbdNfIKu9Fzx8Zj6cjiIUWW+Iawqk//kYqEAGK9Gp15nEhYrsv60pLgJlv1HDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584055; c=relaxed/simple;
	bh=GneCCe6CQ67dxjifIznHKgDQrYMavMIMBxbOXmu7CYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CcoiFCjCSpH3erR0S3uXttSpUfVv9/Lt7ic18ith+oTPzE5pcEbM9fm4d4BRGRgiRHLzO62CqRuC3WY3m9zSCi0/7zN6COxkCFCSfLIqpZ0O2sUHC9zUaIkcp2KZt2aDoaQ++Zwo32S4wXi2W8S9Hu/Tp1XL/TghhSQNuN3fdhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=grnHxanY; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="grnHxanY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wyos3uV02V0WgBlkyAbugTCAp+22xT8V2aJBFni8ubcLqmWKoFC4szMLftmLQchxGbp3zJ3Q3uLhW0idoOiKcDAUQjo2p478t7mcQS0F5MhOnEQ4HaxyBydudidqxjBXB6aNRScnX5a2unxEC4ymkdSJKeVdBg7b9POCsm0XBdePbhU8tlHABuObweBgUsiWyxerNhFv9kjGZ2SAGFoujxsHy34L2i+eMqBTtrcKf9VMWK6quAJ8jGOEktVEa/RjD18a9M1+3vaWZ/fRqceqMChQzTJ1n/nefQv2iss0wSZ7n7oa5K71EDAqipIxGLE7Iko4kaDCHIFJKeqijvOIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GneCCe6CQ67dxjifIznHKgDQrYMavMIMBxbOXmu7CYE=;
 b=iZyAB+ZkODcq9EjEf0GI5WFWGW6k3igLjnMq09hxipnXSzppkj5kR7ZF/76HGuGhgAMX5vlqI66aXoV4pDAC5WyJqZUD8VCL+XEZC8587cJYGtgG/H3ztU8cGf5AWajN5z1IjU51raTzqGXMTPd8kzKsDrxZ+qH/5yfEaVIM0+V2zPRWPjmkvQ/ufFTEwgvUu53ETIBUh+lOylJKnlxpv5fkuBQzkQbumwNgHTOVauZd8oJQSBDHXdKZxqABl08TkgTL/R5YnL51l5F8aIFdYOvpt5UROXBM2TJk/CSbOpkBJ6j0/2iKdYnnsqLkA88PvHwLR5WSLP/IQK24To3Yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GneCCe6CQ67dxjifIznHKgDQrYMavMIMBxbOXmu7CYE=;
 b=grnHxanYyEzFF03kElwJEiKTATliJ7MYu+5YfGhEFznLkWn1BRkc9yCYJuzuW7QqOaJ4cYmTo8n2TDVOCOSk1Ih2pBrfRqNVolmWs833F+HZMYmGlWwSANHZkraeGqHQID3s/ylrX8ff7nq3kFm5qlcjvgiAVR4zKHniynw2zx5POmXdmMDydJEWKiynS7Hwo9wRFrl4Hl9Z1TjAFbR44sl/mswklQ2vWRITUhfrY4IVfP+M33SIDzdFxRx7D7HQl4X99L1mgPMkguiiPT64dGCRZxRcV5LjlJLTnrz+fNKIFPNjJllBou5OZPUsSSpNYF3t3f+AB0muVmuDrv75Bw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAWSPRMB0037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 08:27:28 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:27:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "pavel@kernel.org" <pavel@kernel.org>, "mike.marciniszyn@gmail.com"
	<mike.marciniszyn@gmail.com>, "lee@kernel.org" <lee@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "kabel@kernel.org" <kabel@kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] leds: trigger: netdev: Put netdev on activate
 error path
Thread-Topic: [PATCH v2 1/4] leds: trigger: netdev: Put netdev on activate
 error path
Thread-Index: AQHdSaw0y6dec9EvD0Kx9I/YHtmVfbbijxQAgAEj94A=
Date: Mon, 28 Sep 2026 08:27:28 +0000
Message-ID: <cff6e9fbacfcde5f1bc3243789d1d5aa1157ec37.camel@siemens.com>
References: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
	 <20260921093249.3481413-2-alexander.sverdlin@siemens.com>
	 <13e58137-2104-4ba4-9d41-e30ba5dfb367@lunn.ch>
In-Reply-To: <13e58137-2104-4ba4-9d41-e30ba5dfb367@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAWSPRMB0037:EE_
x-ms-office365-filtering-correlation-id: 9244fd52-0d86-43f5-1fc5-08df1d3a5518
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|38070700021|4143699003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 11xQqmJNnd87LTB6YQw5hP7RQCtM76HzQeHsbqIhKU6lH9tLFnOBXqxKqQ4QHZp8RPzJd/HRphuQVh0iAqF0tAO4uat5gOFNYNgbekBvChDt7VbJx9MMASmAxmk4QCIpQp5ARUqQDvJeSbIUleDKVOidvxLwgsM5/ZcCwKDFUVQ09CpPrQxwZTAKaV7UGTdfbkWwnMoPq8v4gaAjXfNQ2lGTrpqZ+spi0YNvikVPPqFdtmrOlYq2bKdAaqwooSO8rbM8kfKW5bHZOdrJ3bKkpJlZ9nmlo9ELUan+8zAXWajT4Jbk709aac/Lfn6pZOWQehrY9xnHtaYVUmajbFcdwyNkCybL4fZwAesIrKvgefDSdamza70z5rm4qBDU/f7xurESEDhSQp9PdDq7nzjPb1LSL8j1q02kfaCAUNmnNX0eUUkEpuDNjOeRMzyFZqCMWgwXxWD0IPkYTnscgCINiDmwjgYT9/W51/A6FRTOygR5O75Kk/B060EAkb03B39J0CWzQCo2j7sRcakyKPLXcKj3Dbbt0xL2Fq1yYI4FOKeiA9i8HI46Yzv5ce9bMMycuD8gayrvonjXZOehMqodN2bj8+lVAIbffG6WHE2BirAsvVV54WPiqu8xaSOUdjZo5cXdHLuJvdKZ0DLqYg3PzgR62ERjU9f2s2Ad3JTzqDg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(38070700021)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjBaYi8rNHpDQTVuYTNyVVVLOUpsU3V4RWsyUjhCcnBhQXljMTUrMDVkamVC?=
 =?utf-8?B?OEh4SnJtenE3bjFmbU9XVDlqcW1HNWRGSlFSb1E1WSthZVBsQnhoUGFMUkZw?=
 =?utf-8?B?MUhqcWJNVDM3WXFlRlBtWHJtUDdYaEszZEZvTXB4aHVHNTZZRkR1dTNrdDQw?=
 =?utf-8?B?bDNIdkxSRHhJMnEvTE1IaWJ2akxOejk4T3pGcUx2Z3FpMGd1LzZYTFppcW03?=
 =?utf-8?B?VzEzSzVFWlJJRVZxTlVwTk83QzVZT0lUSUJNMkRJN0o3QVVRYnNGcjdNTlNz?=
 =?utf-8?B?aEdmMFJ0R29hUlRPWVZEdnNaWGJmUjVLa25zTnBjTmFBN0ZjZG1hei8wOVhL?=
 =?utf-8?B?aXpQY1dkN2F6ZHRueWVzK01vYjBEUEt5dEY0dE56QXROcG5BVFp2TTlySzBu?=
 =?utf-8?B?ZnE4Qjk2TjMxN01HZXVuYzliWkJucUVOYko2dUFIZTh4VGxzaUtMTUV6YlpK?=
 =?utf-8?B?VGFzQkpKUi82NTRiSTJ2UXMxem1wNFpiV1N3bklwRWpKNmI1VnZHT05GVzNw?=
 =?utf-8?B?aEcvNkV1ZzUwZHhyaGJsTzZxWWFqNloxeHFmUkQyUzJsY2RmVDNSZWhyaHcx?=
 =?utf-8?B?cnA1S1lxc0l3WnFTQTVFMWxjQzdqNzNvOXpkYWdJNmxFdWpaSCt3WXR3aXNu?=
 =?utf-8?B?L0p3TkxkTEJTL242RFJwS0Mwa2x0SmVPNWpBNXkrd2xPQjh4cWdieDNBbnd5?=
 =?utf-8?B?RDNaaHAwU29BUXBRZnJZdmFtM0VlMVlkcjdjQWQyd0R0L2hKbUZLS2praExM?=
 =?utf-8?B?NUhvNWYxRWRrblJpZWM5WUtKVlJSeThMR014V0lSdlIzdU5WQ3k5T1NMeWFD?=
 =?utf-8?B?MEVib3QraFM3NnphYzBWMEJicnV1Wi9va0Z3ZVNTS2RWT1FNUGVjVDhIVmw0?=
 =?utf-8?B?RS9xZHUwQXRMdXBhTlBkaGZKazlabFdXMUhobEJIQmI1VVJJZkxaMG5PQ09w?=
 =?utf-8?B?amVEazcyUk1QV1RCT2t4RG1ESWJsQ2xockkyeElRaFExN3pmSUFRM05oUTZT?=
 =?utf-8?B?TFE4cU5keHNMcmxscmtvZStiZlZBcSt5ck9oTDkyZHd5TmxiVWIrSHZROWlF?=
 =?utf-8?B?YUpsYjFNSEcrdEx1SXVMSHQxN0FqZ3MyM0h6V1dya2ttOVJyNWlTZXRkQmU4?=
 =?utf-8?B?dGhtM2tReFhWc0V2TU5CUnBxa21VbFlhdVdmRHE0dHk4bjgvamFObTJ2R3Er?=
 =?utf-8?B?dVJXS2VuZlVpM0xWQ293TXJoRzV1ci9LZW9zMUxIRTN3dVdKTmJLVFZmNCtH?=
 =?utf-8?B?cFphQnZ3bVM0UmIzemk5RG8vZDlGYUFrTWM5b2RVT1gxSHJ6bkJQTy8zQ0tz?=
 =?utf-8?B?VFFscXpJK1YybERRYnY3V0tBTi8rRGRxTW11SFZZTWhRM2Zqa2RMdTI5THRS?=
 =?utf-8?B?eWF4YVc4MTNlNlpqdnpqb1lFcXhjNkhXckdsWDdTaStaQUgvL3pjK2lQVzlm?=
 =?utf-8?B?USs0Njd3bUtZZi90TElVN0pTdkhwOXpsK3VSY0Z6WWg0b2owVG5GYXJpLy9W?=
 =?utf-8?B?bGpsOUFaZ1BPWkFpRnR3NWVRUjJNV1RxV2NiUzVVQmgxa0NHYi90dDVGUnJZ?=
 =?utf-8?B?SzFXcXdWdDV0a0Q2UkFvV3pMemVXbE5UM21nTTJtdXdQTFRkbnhWMkQ0Qy9x?=
 =?utf-8?B?MVlha0V2NWRSYUt1R2NHZ3VHQlBrbmVEZGJVaUhKdnBQRzE5V3JiaWVFSWRx?=
 =?utf-8?B?dWtyOHk1UmluUys1YmE3bnRTQjluNFZxUHI4RnVoNnhoTmlmWmI4YUZXency?=
 =?utf-8?B?NDRaK2FnY1RYOFRIeXRFSHExNnlHTEtULzRCSEl6em0xMkk1WUxia3Brbmpo?=
 =?utf-8?B?ZTNzV284VUxCNXJxdUNUU1JnQTJzakNHOTltclIzWUZ5RGpGb3VNU0xqcFFO?=
 =?utf-8?B?NDFwcC95bTEzNzFSbmZ1Q2htVWE0TW5obVI4TUwxanJlK1IxeTdPWmxYWE1Y?=
 =?utf-8?B?V29HYzFwOEZaNlRoOWMvbGRyYWNwRXBleUMrTXNWT1lWc1ovOGtWOU13V3Aw?=
 =?utf-8?B?WUJpZkswcFhOYmRqMFc2UkYzK0FxY21sUzhZN1BiV041WG43bVVVWGhFb1cy?=
 =?utf-8?B?eDRuYmdQUWo4T0s3cnBQYW1lRzhBdlhpVlM1dkJJWGdsUHlEbllNM3B3U1dD?=
 =?utf-8?B?NWYybG1NallNbzNRb0VGT3NhbjB5RGp3dkxraC9UVGwxZ0IwMEJ3UHVUSlZN?=
 =?utf-8?B?VUY0ZWpFeVY5L1VzN3ZYdm5DbHJ3V0p6NC8vOXByekZwcVhJaXZ1V1pxdHlv?=
 =?utf-8?B?a3hmMStYVkxCMnpvZVdmZU5PVHlCbWt2bmxmSjd2NTBiMUZwcHFkT1p4Rnpa?=
 =?utf-8?B?ZWVxWkU5b0JlVjZwclZ0eHIxMUhvUWhmR2htM3BoSHFxbnd2QnZ4Kzg1eko5?=
 =?utf-8?Q?FKjccaJv+NJJRkA0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8F092194613C14B95807DED90E512F4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9244fd52-0d86-43f5-1fc5-08df1d3a5518
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 08:27:28.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miIU/NY75oONA8RSZFjSvZOxlc/sxsUBVoo6b/iBh5Sy1x6rJ7tu0kRgYtu2EdNWOti0igmO0xLtXmRGZWzr1EIWJDJ1VixIdmmOKv5N6ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWSPRMB0037

SGkgQW5kcmV3IQ0KDQpPbiBTdW4sIDIwMjYtMDktMjcgYXQgMTc6MDIgKzAyMDAsIEFuZHJldyBM
dW5uIHdyb3RlOg0KPiBPbiBNb24sIFNlcCAyMSwgMjAyNiBhdCAxMTozMjo0M0FNICswMjAwLCBB
LiBTdmVyZGxpbiB3cm90ZToNCj4gPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRl
ci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBXaGVuIGh3IGNvbnRyb2wgaXMgYWN0
aXZlLCBzZXRfZGV2aWNlX25hbWUoKSB0YWtlcyBhIHJlZmVyZW5jZSBvbiB0aGUNCj4gPiBuZXRk
ZXYgdmlhIGRldl9nZXRfYnlfbmFtZSgpLiBUaGUgcmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVy
KCkgZmFpbHVyZQ0KPiA+IHBhdGggZnJlZXMgdHJpZ2dlcl9kYXRhIHdpdGhvdXQgZHJvcHBpbmcg
aXQsIGxlYWtpbmcgdGhlIG5ldGRldi4NCj4gDQo+IE1heWJlIGl0IHdvdWxkIGJlIGJldHRlciB0
byBhZGQgYSB1bnNldF9kZXZpY2VfbmFtZSgpLCB3aGljaCByZWxlYXNlcw0KPiB0aGUgcmVmZXJl
bmNlLCBhbmQgZG9lcyBhbnl0aGluZyBlbHNlIHdoaWNoIG5lZWRzIHRvIGJlIHVuZG9uZT8NCg0K
QUNLDQoNCnB3LWJvdDogY3INCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcN
Cnd3dy5zaWVtZW5zLmNvbQ0K
