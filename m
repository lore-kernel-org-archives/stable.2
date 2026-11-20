Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795172840;
	b=q12STf55h2nPle6P+tyvjjAxhgGK8X4XLVBxeQdVgdnC5NybLf61/BHMpojJ/dZtkVI3
	 JnrTU1FinN2RuYj7x4ksobe9EWL2q3oReE5tsyHcAQT5vKM3iissAiAYE4u0YO82tDKDF
	 ouwXnuIYVdSsCak9tHn+KyV6tRX63FzahiC4VTAA3sD/r1VtZQA1/fNUtm6OEfbjL1ihL
	 v6knyN0sCswJbQtjzlf2JZYLaAC5sqvSyUGGJkLr03AlhXZ+37G2O4LwwT4AwkIzlLsL8
	 fRrkAYh3UNa6EX/nHgjmzWcpYKpKNIkeBc20AsgeKyumRJ11ER9m3qPU/+9wmVaKu5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172840;
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
	bh=KEQvRAcTyZLYEL61AXeUCCmn4XJnvv3DwjzprrKl8sI=;
	b=TTArIjTNePMxKveAWmgxCCCQan3HPPCFtcx7uMMivgxq5Nd0PfOcFjCV+emJF/GRJMq4
	 XmCfSjTSiwiGuhUrZQXabkSmy9josKNWBz8ExQ0lajTiXTisF/uppEAhAH+GJ2f69O3IU
	 MZ7vBE4BxGG0MD56QI+TB2lVlO5EBXEsQPBl+f8KbZXUtYauzXWv4HEHEJQyLYoHenD1O
	 RQ7phs/tJvVgSxfHG1D6VcJNkdtWtGo/Be8lMsZkPsnEEHT/i7QXpMc5COsKxVA9svAx1
	 7S6MO8zDYfoiV2tQXt8/wK0cEGAKBtskS55k7m6CtzH86pFvxRW1iRZKfOgkmdVzbvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=KS8f4ciO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.108
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021108.outbound.protection.outlook.com [52.101.65.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895760A263C;
	Fri, 20 Nov 2026 11:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3895760A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=KS8f4ciO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUP9spFVJHhxuvSZ2lFAqR1fAAyXif+MopPtIP4aS4XKwoOiOhIvUZEWzShbXClWlpbEiYep0H5cdX2eK0INeSDUBYhYQkIoGyZ2ksPZfeFXREbhKnB41f89ZuKMoJTmZe9nJz8fDGcv4zyxSSoy4GtCjexms9dbD7IGxTgf1Zj6XczI3OC/QVbhD84AkDctg16QDKZay/U/HwGbWMjhzaqEXEeujWapMXWnbsv82KTBHXA3XMbWb8vlW1VgfXMs/vphiIHhrERt7ncQsONh99Ij1qqA2f00AICNakpAVxMGG9IehYjcti2wLW5NA1DwuPzQNBJPOwijdLlfBK3Cig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEQvRAcTyZLYEL61AXeUCCmn4XJnvv3DwjzprrKl8sI=;
 b=J0+t0+DHmnUTrlNByVXN+2Vyv+zCO+8qGV+Y5fbpHMU06ClIBEKGk94mPI3KRhwXqVAln19VdPYVdHN2lp7ijHx+ClhGkQgJMPYpoyIASXLCP+47YJPkDs6CygGTBCHbzydMK3HwjwSjbSRf7a4NJk8KOhgvTMMwtoeDiqhNGpaqJFMeDwvziC4bcsh8eZ/HRyctoQpdWxqvDscjJE97DxMFOjqotmzZ6x7fY8sEYfKxW9qoUiLd/z+goJEVs8yfgdQddlay8yA66IzvoCLWmIyv2OYniodb5UxNxGQ0a5MORvbT1yq963iaFY3cJFrsaCX/jRyfixR27U1d/n8LVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEQvRAcTyZLYEL61AXeUCCmn4XJnvv3DwjzprrKl8sI=;
 b=KS8f4ciO+VjhZ4Nl3nQtNAx8voB9xAtyBpwltHH2CszbfB78mJtukHKQ+4S41PHpMEFBFtx6Y6p/oZil2lkDLKlx5+meMOdx2OLKOH5JPjRJq4s5dWjzufZZz2K6maxoeNv1F6WXO//MSqnKBAdkbvY2HiLWJfJMJge2xeAMnlTEkqq3+9qrLzbW7pJGtun71AF2peAvTCKJeP+8oIp1AxOIn7tC7w21ggapVW0TXVfmE0NMWxRGJVs1Gr0i9Ey7XFQbQNaee6pZDfKeSUN2/MKJFkigKRZd76CTRGHK7AOYojjKFdH+Nb+5CeJPS1351zVtBeDiBX5iTgfumYS4wA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by MIWPR05MB401878.eurprd05.prod.outlook.com
 (2603:10a6:290:d9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:07:17 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:07:17 +0000
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
Subject: RE: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
Thread-Topic: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
Thread-Index: AQHdcakNwPgs9FTQsEys1XYyFZRXXrcu5yEAgAfzaTA=
Date: Fri, 20 Nov 2026 11:07:17 +0000
Message-ID:
 <AS5PR05MB11020A6B850A86A21A2B5E1C4B9782@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
 <179473557614.2199510.972066447270237709@kernel.org>
In-Reply-To: <179473557614.2199510.972066447270237709@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|MIWPR05MB401878:EE_
x-ms-office365-filtering-correlation-id: 1a6b3540-dac1-4a87-5a9a-08df46f670c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|261026140227099003|261026121527099003|10067099003|261028144727099003|261022105027099003|261022075727099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info:
 D3v69QyPfvlLwXWts2NQ12FNkIO/HmQczISqrDVuRceTBPifO2s+LVGCqjZh1xmYmDRojAcCGYAoh8mjHk7nVfRoT9yzQ11xxh0ULR4faw1enBYCzS2HNV89WSVcnOEcu8WD28QRiS9W5CHj0UQfBFlWW1OqWu91JdqIi7rOalCnGFZsO3dzCpSEZHS1ZjHSaXaL9c/EsdMptWmWgNlS6r7sNh8Hz7JG/Pf4tc9jHia7OMfFvWxZvzO67Yu9qSJP6CO/pSmP8OkOVY73mtZSxCjOOceaDozhFlhBNfF1Cc9vv++AJaaP6j0Fq9M/UAMXQ5wK4c2+t+SeFBfX0THqJk/haSj/V0aL1o9kn6A1RS1GHrnHmlvMSrDj/uRu7QPXd9ZAilO3Z8A6o2SZiRRCeFUaYtz9FEL+k3QpLbh1D0Rpc2TKisxV3MFKwUR9voAHQcfSCBYzpU8DMkjjxNZXw/+Ej4JR8a7oF850VI2mdoIPIURuPfzd1LDV31IdSrBiyluzgJxCFNyDvTuUMFb8/S/qESAF8qAZKzbaXnaaicdIt37lXEBsJzmvxsQsiVuKwL1cglqDU9tmnYugwqDFsD4ET94ecNPyiU1hpaQctCIGWDfZIbZY79QKor9LbBFBU6Jm7dx+da/9WXJ4sfSjqeGuZ8rZZGqyG7VQ++fl5HsrDkWS2jM1bxILGXD33UqaR/ZlIFs/TwlkpIL8VjsaM1K+LDovO9D24JfvBGl2th0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(261026140227099003)(261026121527099003)(10067099003)(261028144727099003)(261022105027099003)(261022075727099003)(261009223027099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGt0WVBDVk1sYVhxc2NUbk9GeWxqMFRkMzVjNXptMGNpSUVBQ21ZOTNmRjhi?=
 =?utf-8?B?ZzF1MmFRV1BsWTRMMURQcUQ5eEw0Q3Q2enhDUjc1YkQrRVQyVkdzVE1aNnZy?=
 =?utf-8?B?OEcyQ2hUQmJMbEZLTENLTEgxb0VqTFZnKzljZTdrQXJGcEd1NnhEemc3UUs5?=
 =?utf-8?B?K2lmN2h4eEY5N3N0LzQ4WWRORzh0NXNlY3Q2QXJMcGpXYStvUHZuNVZRNy9u?=
 =?utf-8?B?Y3A0aDVtOG1VaEVkNkF5UGV1KzU0ZUxHTG5BaytoRDZFV2RvbXpvVlMrSzdH?=
 =?utf-8?B?YW56M09KOHh6Y2FCdWRrRjZUSjhiYWhSUFNGUWd6WXB5ZXV0V0RPSWl5TE52?=
 =?utf-8?B?WVN5K1NEMUI3RGpzR3hramhGdFQwRm5aOU15YzdKeDZNU2ZqZUNxMlFYd1Bv?=
 =?utf-8?B?dVYvUnc0UVdESWR0cENGM0dLRHhZK2ZxeWlqZk9sRHMzZ09HaHA0cGFkcVo3?=
 =?utf-8?B?T09mVmI0ZVhjTU5oVmcreE5nTkE3MWxVUlN2c0t1S1dXbUcrTFlTSHdPeHNZ?=
 =?utf-8?B?emMzQUxoZm9tbldybnZXNko4SzZwQlRwa1o1a2gyV2ptQ0M3TmZ2NGN0U29q?=
 =?utf-8?B?bEQxOFVlYVo5TDlmUHNLbyt0UnVWVExncDJJUDlIeVlNSWlDbmQyaFhSVkNw?=
 =?utf-8?B?M0ZIQ3oyU2lSTnNUQWJkVGlTQ2FOVTZEdUlKQmx5bzN2Z082U1AyWnIzUUlR?=
 =?utf-8?B?ejBibDlkUEhxZG1YR3hCRkdRcUc5ZW9UN01XTlhiRE9heVRYSm5DQ2VGOUw5?=
 =?utf-8?B?SUZSMTRvcnJDeDlWRUh0Wjd3Qm9pRXE4K2tiK2VjZlNqV0dab1pTOXVMRDdL?=
 =?utf-8?B?TnVybGtyb1k3bFhyRmlZNWxETG85NjJCWE5DeHRFVUhpYTFEdDAxSW5ZQWRi?=
 =?utf-8?B?NkpIcVRrZFA5TUNzSnZCNElPblY0TTNyZk9WZExSZDV4WHp6UHB3YzJvck9L?=
 =?utf-8?B?cUY4aGFxU3BSVkFiRVd3RnVDc1JlL01jUlUzMWw3aGFIU1ZMZEVhUUZBWEgv?=
 =?utf-8?B?UDdoQTY1NUVtM3k2ekVsUlhRalV3OXFwRTZwSXQzR3hLNjZ1dkhvVUNNK3VB?=
 =?utf-8?B?alBHWlhCRWp0ZVpLbFBGQ29MR2FEMmtudTBJaUhjQnhFT0tua2RvRFM5Ui93?=
 =?utf-8?B?SjlmOXVwbFRRRGpqZE9TVUhTTGpMeTl3a3lDVzZwUVppVnJud0hlSUFFZGlS?=
 =?utf-8?B?eDdXN2ppSUVJTUxYQWJhOUlmWW9LT3hleE90K3pPdlNNY2xZd0VZcjBRM2Zi?=
 =?utf-8?B?SzFmY0dJV01mdWFweFFsN2NyYnBlTnpvcmMxaU0wTVJGQ2VzSWdtamxxUGRl?=
 =?utf-8?B?TGo3UkkvTkgvV2U1SWdaWVVzcFNEcXdNekVSNGRKR2daV01nS1FTckxKZzFp?=
 =?utf-8?B?KzQ4WTAzbGVTQ014aDRiWmEwU1ZWUmVCaitJTXVtUXRvRVFPUDJkUnpGTzhJ?=
 =?utf-8?B?YStIWS9IU2hvZXVXaHlSYVRCbmY5ZnZ4aWM1TnZodE1iaHNEeFhJL21mUXVH?=
 =?utf-8?B?TExQdVgzendRL3hMUzIxd0FFazN3UjhkUmxkU0d6YUV6Yy9pOVlwVFRRN3Iw?=
 =?utf-8?B?dFlmaVYxS0RGQk1Zc0dKQWNsK0NVRnA0d2tDWUlpanBVRityczdFT2ZTaEhG?=
 =?utf-8?B?S2U1czcvT3N6clIxM1NaUWw3ZHI5NHpNVlJFcFBqZjBqeXRoREZIblNlSXBD?=
 =?utf-8?B?aTI5S2lBKzNKd3ROeUZKbTA0K09ybHRnenZNSWQ0Zms2T0RsVmVKWTFlS2VC?=
 =?utf-8?B?WHhYdjNFV0JPd0dRTWp3eHR4WmtYYmY3VEdlMTdYY1BTbTF3N0VUUHRFWm5J?=
 =?utf-8?B?QkVQam9YbGtFam9hTDVuWmdkN2NYQ1VTT0ZQSGFxVm5laVQrS3FUTU5nZ293?=
 =?utf-8?B?Q2lyUFdveDJhL2YyUFB2ZDNEalBuVm5nTjRTWDJsa3k3T2RWVFRTTXRVL2hT?=
 =?utf-8?B?NHRDeERCWHExcG1nTWc5NkpJcEY2VkQrcEMzV3BqckFLc1R2ZHVyUVVTS1VL?=
 =?utf-8?B?ektrblZmNXV5elZFSkVJSHdoMWljYno5ck1kR3pwd25ySFlMQVZWWU5NQ3Bt?=
 =?utf-8?B?Qmw4KzRxZ0hja21DUUxKUTlENDNLUGhYYisrVEF6L21TK1EwenBnYmpSbDY3?=
 =?utf-8?B?NDBZeUdaako2V3pSeWtvMkV0QjNtZnhqY1ZGWXlQdW1OcVMxSzVEM1k5NHJ2?=
 =?utf-8?B?L1JsN0E1UDhESXlRblRBQ3lWaURSa3dyb0lXWElVNGtidVdWaEY3YmRCcEgy?=
 =?utf-8?B?azE1SFpvbUFVMkFJc3VtZ2FMeU5XQm1LV1dSOURXUVV2L0VIQmgyQ3RGdjdV?=
 =?utf-8?Q?HPiLOlpF3bmYB+8dyl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6b3540-dac1-4a87-5a9a-08df46f670c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 11:07:17.7238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaS+aPKK59df2yod57my7T6j3TKTLYDAH1/si8g8m++V9L0RLw9XQVVUhuqOdzxTrq+xzoVYVQp0cCmMLaQYjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR05MB401878

PiAtIFtIaWdoXSBUaGUgbmV3IFhTSyBxdWV1ZSBjaGVjayBzaXRzIGluIGlnYl9zcmlvdl9yZWlu
aXQoKSwgYW5kIHRoYXQNCj4gICBmdW5jdGlvbiBpcyBzaGFyZWQgYnkgdGhlIFNSLUlPViBlbmFi
bGUgYW5kIGRpc2FibGUgcGF0aHMuDQoNClJpZ2h0LiBJbiB2NyB0aGUgY2hlY2sgaXMgYXQgdGhl
IHN0YXJ0IG9mIGlnYl9lbmFibGVfc3Jpb3YoKSwgYmVmb3JlIGFueQ0KVkYgc3RhdGUgaXMgc2V0
IHVwLCBhbmQgZG9lcyBub3QgcnVuIHdoZW4gVkZzIGFyZSBkaXNhYmxlZC4NCg0KPiAtIFtNZWRp
dW1dIFRoZSBuZXcgLUVCVVNZIHJldHVybiBmcm9tIGlnYl9zcmlvdl9yZWluaXQoKSBnaXZlcyB1
c2Vyc3BhY2UNCj4gICBhIGRldGVybWluaXN0aWMgd2F5IGludG8gaWdiX2VuYWJsZV9zcmlvdigp
J3MgZXJyX291dCBwYXRoIHdoaWxlIHRoZeKApg0KDQpSaWdodC4gSW4gdjcgdGhlIC1FQlVTWSBy
ZXR1cm4gY29tZXMgYmVmb3JlIHZmc19hbGxvY2F0ZWRfY291bnQgYW5kDQp2Zl9kYXRhIGFyZSBz
ZXQsIHNvIGl0IGRvZXMgbm90IGdvIHRocm91Z2ggZXJyX291dC4gVGhlIE1BQyBmaWx0ZXINCmxl
YWsgYW5kIHRoZSByZXN0b3JlIG9mIHRoZSBETUEgY29hbGVzY2luZyBmbGFnIGFyZSBnb25lIHdp
dGggaXQuDQoNCj4gLSBbTG93XSBUaGlzIHBhdGNoIHJhaXNlcyB0aGUgWFNLIHJpbmcgaGFyZHdh
cmUgYnVmZmVyIGluDQo+ICAgaWdiX3NldHVwX3NycmN0bCgpIHRvIDIgS2lCIG9yIDMgS2lCLCB3
aGlsZSB0aGUgWFNLIGZyYW1lIGNhbiBiZSBhc+KApg0KDQpQYXRjaCAxIGlzIG1hcmtlZCBmb3Ig
c3RhYmxlIGFzIHdlbGwsIGFuZA0KRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N0YWJsZS1rZXJuZWwt
cnVsZXMucnN0IHNheXMgdGhhdCBwYXRjaGVzIGluIHRoZQ0Kc2FtZSBzZXJpZXMgZG8gbm90IG5l
ZWQgdG8gYmUgbGlzdGVkIGFzIHByZXJlcXVpc2l0ZXMgdGhlbi4gUGF0Y2ggMSdzDQpGaXhlczog
Y29tbWl0IGlzIG9sZGVyIHRoYW4gcGF0Y2ggMydzLCBzbyBldmVyeSB0cmVlIHRoYXQgdGFrZXMg
cGF0Y2ggMw0KY2FuIGFsc28gdGFrZSBwYXRjaCAxLiBUaGUgY29tbWl0IG1lc3NhZ2UgbmFtZXMg
dGhlIGRlcGVuZGVuY3kuDQoNCj4gLSBbSGlnaF0gVGhpcyBwcm9ibGVtIHdhc24ndCBpbnRyb2R1
Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBpdCBzaXRzIGluDQo+ICAgaWdiX3hza19wb29sKCksIHdo
aWNoIHRoZSBwYXRjaCBlZGl0cy4NCg0KUmlnaHQsIGFuZCBvbGRlciB0aGFuIHRoaXMgc2VyaWVz
OiB0aGUgZXRodG9vbCBvZmZsaW5lIHNlbGYtdGVzdCBzZXRzDQp1cCBpdHMgdGVzdCByaW5ncyB3
aXRoIHF1ZXVlIGluZGV4IDAsIHNvIGlnYl94c2tfcG9vbCgpIGdpdmVzIHRoZW0gdGhlDQpwb29s
IGJvdW5kIHRvIHF1ZXVlIDAuIEl0IG5lZWRzIGl0cyBvd24gZml4LCBzZXBhcmF0ZSBmcm9tIHRo
aXMgc2VyaWVzLA0Kc28gSSBsaXN0ZWQgaXQgaW4gdGhlIHY3IGNvdmVyIGxldHRlciBhcyBhbiBv
bGRlciBpc3N1ZS4NCg0KPiAtIFtNZWRpdW1dIFRoaXMgcHJvYmxlbSB3YXNuJ3QgaW50cm9kdWNl
ZCBieSB0aGlzIHBhdGNoLg0KDQpUaGF0IGlzIHRoZSBmYWlsZWQgcGNpX2VuYWJsZV9zcmlvdigp
IHBhdGgsIHdoaWNoIGtlZXBzIHRoZSBWRiBxdWV1ZQ0KbGF5b3V0LiBJdCBpcyBvbGRlciB0aGFu
IHRoaXMgc2VyaWVzIGFuZCB1bmNoYW5nZWQ7IEkgbGlzdGVkIGl0IGluIHRoZQ0KdjcgY292ZXIg
bGV0dGVyLiBUaGUgbmV3IC1FQlVTWSByZXR1cm4gaW4gdjcgZG9lcyBub3QgZ28gdGhyb3VnaCBp
dC4NCg==
