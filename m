Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795769363;
	b=EG/Ha3sFxt9wjxXF9fDT/Wm7GnXZvBwkVlj0va/+K1ruNJ7+w4s1Qj6c/Mbg1Oz5A92f
	 KD22sUAYT+dSqotWKQoZS6jYq1mC/HCrk+iTensRQJFVJ7mbb/0uJdhFa3PWOGZg2pkYS
	 B3hijx9QgSY3PS5niUWS2c5oSwb5uYT9f53nwDqdCnLB3Wgk4uAndRr0f+N5JE1HIsMx/
	 2HiV5EPp0vrMO5ASmmOXsS7GNfR4EupFtwRdFPdAZoNmBrsddws4WM2hxz2ZUHQldii1F
	 DfNZZbCBgDLNkuIm2ytKP5m/mRvTYaozD9DSIQ8OgzfzmapANc/zNc/70851Ftzl7Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769363;
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
	bh=9ANUR3fe2JSdhJbss9qSWiQw0GYAhDhjifaKgQ51BMo=;
	b=LAnv+tXfGIr8M9ctuNKXUogGETe1OretN5wb1AZXcaezviYXoaH0JZo0MaouSJ82XLYe
	 JzaHCNQLTWnyzMAwouHfLz+EmpUdY+7xmqLxCOr9Q/kteAeH2jm5r2xaL7fqds69EK/Om
	 8Bbf7nJQrBPlXWylIOWNS2bu7TeVsZUAomxiCzMamaKmokWEBnotbG/ulLxXxDxiUYlGV
	 TX0f4p3VVcFISkAmntOcKMd848rIoYpjv6mMRcILIxLUMtQu8fByT+r+ncpD9ilH56IAm
	 o0g2a3WeMZz3rf06hTZyRY2vkRFiT1djf3PyEO1ut2bROiLXIP+XohR9OB9z6nDtCAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=NTwb5ON8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.141
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE460A2620;
	Fri, 27 Nov 2026 08:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42AE460A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=NTwb5ON8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHFX7Kv5jgS3v9E2eatDNPeWMVJqEOES4L9/Bd3g0Ii+yEqoRd8IpOqlX/ezJvvoV85rqEeoY0FX3K/fRB2+7QpVZvmmfK4EVoDQMf2g2fC49pPuVTR9qbc2XA2twKkOK+qBRs112TcOnprwe7SawsDiOuF8wyukLvqDF60Gh9ixxO+qf+SCbVz/0F4JxFV4Ze2r5j1fvuTXeUZy09lXhX7zqPEBshpXrFs3Slqwg6RCyPuwSGINPD+Y+8xVlPR2W3Z0HeFoy17r7ODv5EaEi4OfLJ0lUG8Ay59R9kHHUP7IwK0VGB9wPxj9XZmc1jPgSR6eAX7EwIwHbh6YOUQamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ANUR3fe2JSdhJbss9qSWiQw0GYAhDhjifaKgQ51BMo=;
 b=RE265pm8A7zR/tSpraYFZuNga4JTm7Vztx6ZhnuZ3f2bGO+ZOOMkqmM168LNJnRud/DEnqNraOrwy7S1WYofgW+SQDaC57TPR1nZqiaxgprHmBKXQPzbRal+XPCCXCYtq89S8j4SGpzTkiRV+hZfs4PhTLNOvWm8P2gaJQEhK8s4xzC2z6J7FxR1A4lgvzyruW/ChPVwZuqBs7wN6ddlBfzbvgNYyHvwaDs9EzykRKUlwEvdG9/Ib66WUhYS9kwi0Yf/tRs6ihhUQr6sf/H63NBYOZ2Zv3347z5bRTaeXt/7uZERllsvuztdH3OTG338V8vMn9LEK1Kc3wEYzRZs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ANUR3fe2JSdhJbss9qSWiQw0GYAhDhjifaKgQ51BMo=;
 b=NTwb5ON8+4ucBGgCuu6d9cHmxPyqf+6yfGn3K15EKdxY9JJNsxBXQguYXhuaTWJZBmy9orXKPtfIYmjuQxNhvaoq39A5bhFTTmzz10Pf44w63b4zfGPZB4yRqTSkopTFF3YwDM7MAVM0LvlUDzejr5F+krrrBHajg7c+eFY6JorXrHM1Ht0Mip96GCeHgt93cPdN/uwxzGjbrINFJSJ85Q0cOnVfnjgreLqwGLNt+eTnNbTlNDMuuE92/JeUeHVpkagr3PY++A64Vtj4N7NgdRTV7Ss3KLkTOxSDqGh7sNC8UYkYiJcLUOybqtt/fjqYcE4c+ldYJ8ivrhr1kq3Ofg==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by AS5PR05MB11846.eurprd05.prod.outlook.com
 (2603:10a6:20b:6c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 08:49:21 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 08:49:21 +0000
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
	<p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v6 1/3] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Topic: [PATCH net v6 1/3] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Index: AQHdcakNcmyK0Xj4XE6oHWfwUJ/SSrcu5x8AgBLNb6A=
Date: Fri, 27 Nov 2026 08:49:20 +0000
Message-ID:
 <AS5PR05MB11020E7B4BB91C3DCC722AF2CB9412@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261111-igb-rx-ts-fix-v6-1-ba5b9903859c@aweta.nl>
 <179473557433.2199510.15562599161772023793@kernel.org>
In-Reply-To: <179473557433.2199510.15562599161772023793@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|AS5PR05MB11846:EE_
x-ms-office365-filtering-correlation-id: 282026e5-c247-4654-7447-08df4c635450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info:
 c/Jz07/SdDGahBqMS3iVLmKGSVN4exth7QyMC0qp2m+xRk2kOlg9UI6pocfWjlPFSoXYo66IhnlBkGaHlBPTDGh7frPu3sbc7TmRHPIe9GX4t6PWHV/oj4p1FBTduMXUocJJ841ECuFwvh9WGgfys2SfxT/ByrNsPY54/+bgkDWb3xqj0zxPspmAWSSP4yTdIEIT61DjG0YT7GF4Neexio/BQz56LOvw7IdKSyCqJoYxsxQOBXSK0AVrvr14aBP2UgcrsoVA8t34hAfNmR/EUSsZ7W7FUBRI7jk/QznaZVbujI1p6RuK9puHWhOpJpFLbzTQgLZ+6DoaWhBa6pBKAQ7tXLkyYlLYkH0ONca/L83kdr4i+lUm5EvlTEv8lxpthrRqlnVeCq4qCRlft7OmuBGCQkfdaxG+VQNsOwvR2177fNjenYyNudjKxeOw14bzFyiP4dGdJRd753iIOOpY16gGCd1ClMqCFjW8fv4OYbQa8Opgfhv+v8RE+IKQyAfO6hc1Hb3nusxobUqHCETcvW/Wf6G2evSsowm4nNg5lSIYRX9jfJjJth0sGaZ9defw4wu1xZz4MtRiS6UOUzcL84FZvXy+J9bKo7czy0ykNnwe7JaMbwMD4YK+8ytnSZOt7CHJzGmpK6xdbUmMgUbW4xOk4L6nURQjqGj6D3ObTzk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHY0UmUwZFBBRXJGVmlMdGFIbzd3MVhrV2xmSkZiUEJzOEhrMVJ5TXFiTnlZ?=
 =?utf-8?B?RUZNdmU3ejg3NFdxZFpRVHpJTFFUc3JFcmZyRFNjRjh3NGwzYkk2QWNrbzNj?=
 =?utf-8?B?UGthOVRKZ1B5S1hLUDBCZnFSYXRuVjR6QUxNQlA1QWhUMVVyc3dxUjZOSjVF?=
 =?utf-8?B?R252T1NzTmtsbVRIcWk5TW5oVkRqc1QvTkRROUR2dEdjb0toVHNLZEpsVWdU?=
 =?utf-8?B?TlNXNEl1ejI1eW9Uc0JlalhiajJQbTY0VnJZQW9FZ1pDZHNjT01FUFp6S2xO?=
 =?utf-8?B?S2t4QklYMEkrbWxlWWRweW1PRGhacDFUUkQ3VkNDWk9nNUZqbGRaa0g2b3dH?=
 =?utf-8?B?V0F6blowNjNnUHhWdVZReldBMUQ0a2wydEVwaXZwQlNSWDNObUt6NGxlZUp4?=
 =?utf-8?B?ZlY5UERBOUV0QVdPZ2FPRXhoMlc3TjN6WW9wN2FUME1UTHJmbW01ckhIcUdu?=
 =?utf-8?B?cmQ3Y1U1a0t4ZTZ6eFMraThMbEFSUzAzSHJHMzhmUnFHeUdoY2Nya2R1OHlW?=
 =?utf-8?B?SU1QRURHUGVwMTN3N0dnaWhnWm02UWxoVWhBMUJKc1NwZnNPMHk1OCtmcjJB?=
 =?utf-8?B?dXVuSU5LcEFzYVExV21HT09ya2V0VGZGdm5UQmpoeUFyMDZ4T3ZTR3VXZ0Ry?=
 =?utf-8?B?WEU4WVNLMHRSWlpSUkIrcEV4dzdTRC8vZHdFb1JXS3dHTUdDM3BEMFliWUtP?=
 =?utf-8?B?bjhxRHkyWjQwbmZRc2FSVWppVzd1RWVIanluZFo4U1B4Z1I4VGRobXpHa1g3?=
 =?utf-8?B?VWJ4WklHZVRiTXB1alZ1WkJvems3S1R5ZEhFbGg2c0pUeUtnQkNVSHYwWGsz?=
 =?utf-8?B?NkJ0Q1BoVzBVSWNqTmFuSndSR09wczZjZys4N29EajNnQ25JenphSzgxb2tG?=
 =?utf-8?B?cWNpNUcvWWJPV1dDSVhqR2FOWmJscHp2aHBlaFFJWnBoMUMyNFFmM2JOS3U4?=
 =?utf-8?B?S3ZsTUV0WnR3ZWdrSDBSWE1Pdk0xZlFpTTFrY09wZys3L0R5SkJJQkpDcTB2?=
 =?utf-8?B?SHRqcVlRQnd0eS9OS1I0dmJBVGZVMFdDMFhWU0I4WWZ0WUdDVC9CVlc3am5y?=
 =?utf-8?B?cHhPM0F2YVYwdmVwMkxMRlIvd01IbTF5NUZKU1JtVzl6aUM2aWlseEZEaEV2?=
 =?utf-8?B?L05hdDhid1RxczJHMUNJYWJ2NnhwbkdJdTVkKzY3dnFpajM0ejQzMVFib3RQ?=
 =?utf-8?B?QjhpcllxdHYwVm1tcU5IMWxwUmgySWtlZFBnQ0pPeE1QcTdjbFRBV3lJMFhL?=
 =?utf-8?B?TndrM2lrR2dxd1NkazcwUkhQbzVKYndCaVhJeWZoa1pkMlZSSEtuaEZXMGND?=
 =?utf-8?B?S0xjcnkzcjNKS2g3cVVPdEtQZWY2Zk1kT1JTUHFFQ0MvUWRoSUFNajFUSGta?=
 =?utf-8?B?RUw0bFQ1TGR2ZS9xVjJrRzF3SlNld2E0M1J1S24rbnV5TkFoV1krL3F1c3M4?=
 =?utf-8?B?d3RzQ2wrZ0tSKytOU0ZrQmludWVFSDlyNkZKUlNsbHhtYUJNbk5tSkgvSm5s?=
 =?utf-8?B?NW1JTFlVMlhEeHYzT0xMblBFaWI3emZxZFpSamE3cG5vSzdHVFZHVWNNRkdN?=
 =?utf-8?B?ajJuZVE1N2hFazFvQmpXRENzR3hmR2RtOW9jeDhkVk1TVlZNQVEwM0MrMGg4?=
 =?utf-8?B?Mnhxd3FWQnliMFNqeEdTQzlFYkFqcDlnYjZkeEFOTUdvYVBDcStQdmlnVUlL?=
 =?utf-8?B?YUdSVHY4SHBRUHBzaDNXaFMvR2RZM0pZSVJrNFA4VGZxUmp3a0ZWM3lhTnha?=
 =?utf-8?B?eGNhbDYwU29yUk93ZS9nL01zUUJmcXF6VDhHU1VKMjN0LzlqKzdzWjVvcE1N?=
 =?utf-8?B?MWhvUXAvTjh0U01PVGRieG1HTGpNckVBdGFOejhDQ29HNkhqdWlLRVYyR0hq?=
 =?utf-8?B?aUE5amRNNFVYNW93OUFkeU51RGluOC80RjBNeENXTjVxTllXY1AvVmszamRS?=
 =?utf-8?B?OVVuSkgvK0pRWlBwRUVESlh6K2VMQloxZXQzKzMyZ0x1QUlUL0l2dDhhbjJS?=
 =?utf-8?B?YVZJazF6bjluU3UwNlNyMFVtL0haTktnWHRlMzFkYmljMWFyZFhMZHZQdU1p?=
 =?utf-8?B?SmNPbDRTbEVQZHBLNkV4U20wbG9QK2ZTdlRZbjlBU2RnQ3ExajVPdkk2Uzhl?=
 =?utf-8?B?dCtGcit4UU1iZ0ZiUXdiYnNFclU2ck5TVjlSeGNYNXdVOW1aK3dzNEpKK1dY?=
 =?utf-8?B?eEUrdC9peHhudWdoUE90cUxHM0Z6dTR5MlFWQlViY1BudU9VT3paSmI2dGp4?=
 =?utf-8?B?ZUhReW1uYjR5cFExTCtXRUhPbmpkVTN1WVlDUy9lYTNyNURmYnRFS01kQ3dU?=
 =?utf-8?Q?L2m0Wa3zTTMK3h1apM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 282026e5-c247-4654-7447-08df4c635450
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 08:49:20.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YS53j+GVauzhijsBfc5rwPo0NIPO5Bhmfn8tl+HgseS3y6JfXtCJSv4LlL5hcWRaePiZefaBEINgvEx1BFAjgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR05MB11846

PiAtIFtIaWdoXSBpZ2I6IG1pc3NpbmcgSUdCX1RTX0hEUl9MRU4gcm9vbSBpbiAyIEtpQiBidWls
ZF9za2IgYnVmZmVycyB3aXRoDQo+ICAgWERQDQoNClRoYXQgaXMgdGhlIGZpcnN0IG9sZGVyIGlz
c3VlIGluIHRoZSBjb3ZlciBsZXR0ZXIsIGFuZCB0aGlzIHBhdGNoIGRvZXMNCm5vdCBpbnRyb2R1
Y2UgaXQgb3IgbWFrZSBpdCBlYXNpZXIgdG8gaGl0LiBpZ2Jfc2tiX3BhZCgpIGhhcyBsZWZ0DQpl
eGFjdGx5IElHQl9NQVhfRlJBTUVfQlVJTERfU0tCIGJ5dGVzIGJlZm9yZSBza2Jfc2hhcmVkX2lu
Zm8gc2luY2UNCjljYmM5NDhiNWEyMCAoImlnYjogYWRkIFhEUCBzdXBwb3J0IiksIGFuZCB0aGUg
cmVjZWl2ZSBsZW5ndGggbGltaXQNCihSTFBNTCwgb3IgdGhlIFBGIHBvb2wgbGltaXQgd2l0aCBW
RnMpIG9uIHRoZXNlIHJpbmdzIHdhcw0KSUdCX01BWF9GUkFNRV9CVUlMRF9TS0IgYmVmb3JlIHRo
aXMgcGF0Y2gsIHdpdGggYW5kIHdpdGhvdXQgWERQLiBXaXRoDQpYRFAgYXR0YWNoZWQsIHRoaXMg
cGF0Y2ggbG93ZXJzIHRoZSBsaW1pdCB0byB0aGUgbWF4aW11bSBmcmFtZSBzaXplLCBzbw0KdGhl
IG92ZXJsYXAgY2FuIG9ubHkgZ2V0IHNtYWxsZXIuIFdpdGhvdXQgWERQIHRoZSBsaW1pdCBkb2Vz
IG5vdCBjaGFuZ2UuDQoNClRoZSBjb21taXQgbWVzc2FnZSBzYXlzIHRoYXQgdGhlIGJ1aWxkX3Nr
YiBmcmFtZSBsaW1pdCBpcyBrZXB0OyB0aGUNCmhlYWRlciByb29tIGlzIG9ubHkgYWRkZWQgd2hl
cmUgdGhlIGxpbWl0IGlzIHRoZSBoYXJkd2FyZSBidWZmZXIgc2l6ZS4NClRoZSBjb21tZW50IGFi
b3ZlIGlnYl94ZHBfZnJhbWVfZml0cygpIG1lYW5zIHRoYXQgdGhlIGZyYW1lIGFuZCB0aGUNCmhl
YWRlciBkbyBub3QgbmVlZCBhIHNlY29uZCBoYXJkd2FyZSBidWZmZXIsIG5vdCB0aGF0IHRoZXkg
Zml0IGJlZm9yZQ0Kc2tiX3NoYXJlZF9pbmZvLiBJIGNhbiBtYWtlIHRoZSBjb21tZW50IHNheSB0
aGF0IGlmIHRoZXJlIGlzIGEgdjguDQoNClJlcXVpcmluZyB0aGUgaGVhZGVyIHJvb20gaW4gdGhl
IGJ1aWxkX3NrYiBicmFuY2ggd291bGQgcmVmdXNlIFhEUCBhdA0KdGhlIGRlZmF1bHQgTVRVIDE1
MDAsIGFzIHY0IGRpZC4gVGhlIHJlYWwgZml4IHJlc2VydmVzIHRoZSBoZWFkZXIgaW4NCmlnYl9z
a2JfcGFkKCkgZm9yIGFsbCBpZ2IgdXNlcnMsIGFsc28gd2l0aG91dCBYRFAsIHNvIEkgcG9zdGVk
IGl0DQpzZXBhcmF0ZWx5OyBpdCBhcHBsaWVzIHdpdGggb3Igd2l0aG91dCB0aGlzIHNlcmllczoN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MTEyNy1pZ2Itc2tiLXBhZC12MS0xLTdl
MDY5ZWFmMTZkN0Bhd2V0YS5ubC8NCg0KPiAtIFtNZWRpdW1dIGlnYl94ZHBfc2V0dXAoKSBub3cg
Y2FsbHMNCj4gICBwbV9ydW50aW1lX2dldF9zeW5jKCZhZGFwdGVyLT5wZGV2LT5kZXYpIHdoaWxl
IGhvbGRpbmcgUlROTCAobmRvX2JwZuKApg0KDQpUaGUgcmFjZSBpcyByZWFsLCBidXQgbm90IHNw
ZWNpZmljIHRvIHRoaXMgY2FsbC4gaWdiX3hkcF9zZXR1cCgpIGFscmVhZHkNCndhaXRzIGluIHRo
ZSBzYW1lIHdheSB3aGVuIHRoZSBpbnRlcmZhY2UgaXMgdXA6IGlnYl9jbG9zZSgpIGFuZA0KaWdi
X29wZW4oKSBib3RoIGNhbGwgcG1fcnVudGltZV9nZXRfc3luYygpIHVuZGVyIFJUTkwuIF9faWdi
X29wZW4oKSBkb2VzDQpzbyBmb3IgImlwIGxpbmsgc2V0IGRldiBldGhYIHVwIiBvbiBhIGRvd24g
cG9ydCwgYW5kIHRoZSBjb3JlIHJlc3VtZXMNCnRoZSBkZXZpY2UgdW5kZXIgUlROTCBmb3IgZXRo
dG9vbCByZXF1ZXN0cy4gQWxsIG9mIHRoZXNlIGNhbiByYWNlIHdpdGgNCnRoZSBzdGFydCBvZiB0
aGUgc2FtZSBkZWxheWVkIHJ1bnRpbWUgc3VzcGVuZC4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdA0K
aWdiX3J1bnRpbWVfc3VzcGVuZCgpIHRha2VzIFJUTkwgaW4gX19pZ2Jfc2h1dGRvd24oKS4gVGhh
dCBuZWVkcyBpdHMgb3duDQpmaXgsIHdoaWNoIGNvdmVycyB0aGlzIGNhbGwgdG9vLg0KDQpEcm9w
cGluZyB0aGUgcmVzdW1lIGFsb25lIGlzIG5vdCBhbiBvcHRpb246IG5ldGRldl91cGRhdGVfZmVh
dHVyZXMoKQ0KZW5kcyBpbiBpZ2JfcmVzZXQoKSBvbiBhIGRvd24gaW50ZXJmYWNlLCB3aGljaCB3
cml0ZXMgdGhlIHJlZ2lzdGVycyBvZg0KYSBzdXNwZW5kZWQgZGV2aWNlLiBTa2lwcGluZyB0aGUg
dXBkYXRlIG9uIGEgc3VzcGVuZGVkIGRldmljZSB3b3VsZA0KbGVhdmUgcngtYWxsIG9mZiBhbHRo
b3VnaCBpdCB3YXMgcmVxdWVzdGVkLg0KDQo+IC0gW0hpZ2hdIFRoaXMgcHJvYmxlbSB3YXNuJ3Qg
aW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBidXQgaXQgdG91Y2hlcyB0aGUNCj4gICBzYW1lIFZN
T0xSLlJMUE1MIGZpZWxkIHRoZSBwYXRjaCBub3cgbWFuYWdlcywgYW5kIGl0IGNyb3NzZXMgYSBn
dWVzdC3igKYNCg0KRml4ZWQgc2VwYXJhdGVseSwgdGhlIHBhdGNoIGlzIGluIEludGVsJ3MgbmV0
LXF1ZXVlIChkZXYtcXVldWUpOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYxMTA0
LWlnYi12Zi1ybHBtbC12MS0xLTcyOTYyMWI2MGVlZUBhd2V0YS5ubC8NCg==
