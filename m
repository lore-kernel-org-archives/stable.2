Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F02F8E98;
	Thu, 24 Sep 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236738; cv=fail; b=VXwH+q7MqX/Nk5ITdgTl0YnLefa8bX2Ev2Y82HylXk0SCB5P2RR8YWcl/waFztx4yzf7cic6KxJo9r2pFO1N1jqgbnH9llrvx5xjYJCEBCi8Uc72S85WEcdz5J8APlffeURSjtDNT15fSkLdcrqubHiPzrEDGZWqMfp7aHruYwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236738; c=relaxed/simple;
	bh=L4V4TzYheH0P56tcge8wqDkfuuL+nTwAtatp2lXe+pU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRyK9Qj4X0C2Ph2Yjk+dANg2t8TXqtNbssluXIJIm0uL2vAP76v3x6LP3Dt++JesO0nKWfQs7h/knSm7Jzx/3G8qvwM1ACUiRcK5ifHwhgpGEfU6+gMuENoFNatcwG+7UIrtzE5odsU7eFmaOYZRrNvypmaTqnqQnLAVc5fsiiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yqU8DsYK; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yqU8DsYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXtM2qDQH3/nJePqEIj28I+ihfZnY3VZy2v/qb5M+V2goKqEpkCkcpkaQsoIC5PWAjQOK2x10SBRtpvNVVw0xhHSlvLKfi8WVDcl2xfWR0dB8OH+fUF+3QupeJL0SjDpZrmA7v7zxZPAqArCG28TmGGZ/r3FbChsvpr09tX2G4+fSpXFNKSvJzq6HxOQj+sYRR7znTsFjKjIiawkMHF2YpII7AvkdEgMdsF94UiPSkSD9+aqoQQn/cJzW+Z4CEKvvSZ7oRMURjy/oOQTfV/wOWQnd+EjQy/QwLWmHNaWJJuaugxme5kCP0m1G3XvZPzYYKhaETwCgZRlEQcsrxgaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4V4TzYheH0P56tcge8wqDkfuuL+nTwAtatp2lXe+pU=;
 b=Co2KaieddOTKiYY1Gt2iWDDt9d5Ow1qoHGRVoeAcGlN3L5Q1Wt47+0/DF0DRwEq9raToObRsPYI882HIK4wfWqqhKe6kTMtjfZwMOmPhFO/TM6yfF95b/VQ8q+f348eyvL/VylAeZiJEL0hVeuuwY4cfIrSPPaoirSASBR3LqBoMz3QRyUAldZHmxaniRU9x9BiKkfplHFhA6a562vjc698zqj3+rOnT8sjxXKsNZw4ieVYmdWfZpUCYTSAnAfLnGjnv+7EeMPy52PVfZnIaa8RJFjFGCQiAMZyalEn7PfFqrCfPNoJnfTNNqrDwTehqMERhPJt+l+j8jIohxEx67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4V4TzYheH0P56tcge8wqDkfuuL+nTwAtatp2lXe+pU=;
 b=yqU8DsYKOwHWuXsoQFIb00kJ/fhnpKXiHkYU/m6NjGhmt93lyBJcbzfkwzQ/jfPse6quVNh29K0hJS7XohmvCNn/Y6TSm/al2GVl0J13LG5XAY3W03CJ1VRFLETbqjZm3V1dIW232ytcJWJPAhDC5/8OSuRyRx+mjvv7ZTXLQiS/Ah3TMpdqjGfaEUlbt1OrwIEepnFBqjcjHyflcJOQgrrQ5JygtGWg0VgHtqlK+t/wdQk7bVmjWH0s8x6bnLfNbjtunosqBXjginXASoT8QUprt5NDeX6wnmbzPxWRDP1tbERIAu5Xobv1xp/qSIHgqyf78/9rzSIJXfQevd9QQg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:58:52 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:58:52 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "hauke@hauke-m.de"
	<hauke@hauke-m.de>, "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "olek2@wp.pl"
	<olek2@wp.pl>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john@phrozen.org"
	<john@phrozen.org>, "daniel@makrotopia.org" <daniel@makrotopia.org>
Subject: Re: [PATCH net v2] net: phy: intel-xway: workaround 100BASE-TX
 Link-Up issue
Thread-Topic: [PATCH net v2] net: phy: intel-xway: workaround 100BASE-TX
 Link-Up issue
Thread-Index: AQHdSmdjXc6kPiU8yEG8+UTEOsjRwrbcyIAAgACXxQA=
Date: Thu, 24 Sep 2026 07:58:52 +0000
Message-ID: <4435ca2c56fb396ce3ec653cc6826e86d8488f1a.camel@siemens.com>
References: <20260922075251.23386-1-alexander.sverdlin@siemens.com>
	 <179020414050.2160803.9286678901573366174@kernel.org>
In-Reply-To: <179020414050.2160803.9286678901573366174@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAWPR10MB7127:EE_
x-ms-office365-filtering-correlation-id: db08f6cc-8913-4a9a-6f9d-08df1a11acd4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|56012099006|6133799003|55112099003|22082099003|18002099003|18092099006|10086099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 o1lkF7CgMASE6K/Mc6/UieJqoXqQrglGHkFwEl7LrWH7StDsybw/gdIrOZmUm2Q0mJEhghjANgbto5yP8UoTm/GyHlypTj6VmIh+CQJRBPD+wxjRnF2OrWk5HvsFP100mhUQnimwwQ1CHEK7u3EOC7qegXQh1zb8BVeOLhhxNFVDUDJXXdGATyS4Vtp/RNGnP76vDGKH5IQZlN1jdvtRXASypp/Hh/x/saDTuSVirIFL0A208GTFWQYOvhvoMdhitcpvO5PySOmAXAGX7M/DTSpenmhrWKNPTOK1gXTDcHvm1ZaNSo1mLd/+EpbpRW26lCZeAIs3JKGT6bNDtjqT90KeE8L/8jOawjoc1cXY/M4XcXbucd0OUNkY4FkoruRz0YP8rImdcwqO2WctsqDBvkmXYzEiF3Woz9CkGvzijGyOQfNwiyK+eGjgR5GcVZfiWHKmRsH42Ps7ouoqeOjzSqCnPhycoZAxkbdqTWa6LehV4N8XrO/MZdOwhnTuBEzxrequ1HD0hYPuQf24nTXzlYii95Rh9/HyMIVQ+8LtOkojSNZhP2W0gNR35kMI8MCwtm9NFUZqIFCSCjGNQ5RJqE747/NrQpx2R5B6n2/MC+V6Qa4Q90qt9v0A3QdHzeB6B2hr72rbsNBTXpMy73UVkc8L7zjS+IhRfue5gGjsgkI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(55112099003)(22082099003)(18002099003)(18092099006)(10086099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3VVVHlOYk1CTFlUTFdqZzJlZVdGMHJ0TFB3VTcrWEZmL2l3ZitUSUJyL3Qv?=
 =?utf-8?B?d3JxRjVldGhJemJOZUlPVHNyUFo0R3VGdkthVUE5KzM4WkpTVXNFRjRyT0k0?=
 =?utf-8?B?K2FSSmorbFpEQkxQMjgxaEpsUTBPNkVuM1FZcys3T0hTOFdrZW1tRjlNYkts?=
 =?utf-8?B?V2IwMFJra2pKaVBEMit1TUQ2djBadGRhYnRQMDg3SkVSYldsTVUvcTJiWDZU?=
 =?utf-8?B?cFZNV2dsNHNaSm4rcWxBSlYrYzFCdVJFMWFJc1psRVBpVFZ4RjNocmhkSFdr?=
 =?utf-8?B?Yi91VnNkNXNFQmpYSmlOMjVweFJqOEVNNytBRE5MZ2dwS0JyZ2QvN1ZuVzJP?=
 =?utf-8?B?Mmd2aDVVdFgvSmpqR1NMWFIzMnhzMHhrc0R0aXVySTJtanZPUm5oVU1TTkhr?=
 =?utf-8?B?cThpV0J6a2dLWmJya1MwV1NJVGxsZkFVdWVBdWlrTGdYNWpQU2J6blhZcGFm?=
 =?utf-8?B?dUl5U3FEd09YUE1DZUxsaG4xeFQraXZKeGs1YWhnVE1TRExkYzZBUFFkV3Vh?=
 =?utf-8?B?elNnbjFtM3J1R1JqZGRLZ1RhNUEvM0ExdlhUUWo1UHFtR1NZZHRvejJXRkJU?=
 =?utf-8?B?WVI0ZEFzS1hoM3E1M2tiTjhHcjYvY2tQekhhTHlYUVV0eGFHZWx0K1R6TlRj?=
 =?utf-8?B?RW9PaTV3VWRta2VHK1lObXNUNThnbWRQSG4xZTJTRSt1bWdhTjBzL2xsS1RV?=
 =?utf-8?B?ZSs2NHY1UFB6TzBsTkU0MCtiYkljWllwT2NRQ25hbXcvekM5d09QeVh3b1VD?=
 =?utf-8?B?Vkg4UjJCQWY4TzJ4T3ZLR3pqUDU2YnNodmkzOC82cnNwSG5tQmFRcFhBelNt?=
 =?utf-8?B?RkZuRTU5MmVDc3VMVzlCeVFYOHdZN01qQlg0SU54NDNkY2RDbnRSaCthczRE?=
 =?utf-8?B?VmpmQ2ttYWVhcTBWUXlGMXVyek8rbXRlbjgyTzVvMkkvNk50ZzZNS1pjZkR4?=
 =?utf-8?B?K0t0TDRBV3A3T1hoMlk4SHVXUGVtTm9KWjZCdjk2T1NneUlQNy9SWGV6V3dH?=
 =?utf-8?B?dG1kYWFHRXd1ZnZBbGw2ZGYrNWxxZ05HVjUrdStKa3ZDeFBGa0haaDY5bEg0?=
 =?utf-8?B?Nzc0Tk1KT1p3dlBQWlVoMHgvMHFEZ0RKK0t1K1J0cG41eHdyazV0d2JZdDNu?=
 =?utf-8?B?MW01ODBuckF1VUppRUhwaVk3WVR5UFJCQVN2ZW0vSWFvT3FCT05DWi9WR2Mr?=
 =?utf-8?B?Um05VzdreC8wZ3hTLzNPYVNTeVZSWmFLL2xERjFiakRRK2lLaHkwSy9Ec1p5?=
 =?utf-8?B?Tkk2dVJneUJKOGVsLzhtWktpTncwQnZsMUNvVDJEN0NZaUhicEllL1BUVW5l?=
 =?utf-8?B?aE8yaGtkNVQ4QWxIOXM2ajJrdllYRE4yTDgreStkc25RVktESjk0SGd1dXBC?=
 =?utf-8?B?L0lJajRZMUM0bzZDazg2aEorcVNtc2NtUEhwMjEvNzFZUXRQQ0MxZjc0VGVi?=
 =?utf-8?B?ZHBMb0tZTVU2Y29UaFNHMmRPQm41Zk1VRjlFd1dUWFhVNjRQSytrbmduaTd1?=
 =?utf-8?B?NWlVcDIwYmpUNGl3WXhNWmhrTWZpOGttelEwcGdZWEJiaGVtZHNGT09CdnFC?=
 =?utf-8?B?MHUwNzFScmNGRnpFZXVocmg1eUJsWGJvdzF2bmg0TVJaR1pCZU44OWtaTVFO?=
 =?utf-8?B?TDJZcHNWTTBkSFpjVWQ5QitjQWpNOTkyamd6ZkVoM1RwNWk3YjlOSUNPclo5?=
 =?utf-8?B?dHhPV0lTL0gxVzhDVUJlczlWVE5qNjZNMzQxakpORHZiYUxIU09xREcveUxk?=
 =?utf-8?B?R0lUT0dWaHMyV0JDZ1hpV3E5dmlZM2x2bVNxZUsrcXh1TXJOUVVkTXVLSERy?=
 =?utf-8?B?anNCd0NZUWxXc09mbVFOTTdmT3htS0N0bDRTb0I3anprVkVkQXh6RVlTNC9E?=
 =?utf-8?B?MkVqR3ZPbVlOOXFXa3JWY1N1LzFjaWV6bXlXQUREY3d0WkR1RU9jZndxUWFj?=
 =?utf-8?B?UXZBc0V0Vk84NHZKKzlzRFNUWjEwWS94WDI1YWs1UHM0TGtaR25iSDFWenRC?=
 =?utf-8?B?V2R6WVc2dW56ZzNRbVVtSVpubXBQV25aQktYTTkzekRBUTlXSk9rZGIzTUQr?=
 =?utf-8?B?VUpJR0wrMURrOWM0YjQwT3YrOFdMSWhhNXRWcklTUXRzemxSSHNnbjNYajlV?=
 =?utf-8?B?Rk9aOWZPRHJ2VGY3azZ1NWt4cXVsUmtjUWZ1L2J0TzhmVC8reFhpaHVUWmFu?=
 =?utf-8?B?bFlaNGV6Y3N2TUdxdWgreHpXNmZtak9vV3Z6WS85R2gyOFh1dWhGZDVQZkhK?=
 =?utf-8?B?N0FQa2RxZ0Z5d05RVGtSNXNienU4c3dId21LeW5NN016UlczemNUQ2FnQ0xL?=
 =?utf-8?B?US8yaGhWeDFUZVZUYS83TjRDT2FMZ2hJSkVRQTIzWmoxNFFuSWxhUTB5dlh1?=
 =?utf-8?Q?OpqEU/pt7MLSSoIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C05427D4A666A241A917CBBD39D36B04@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db08f6cc-8913-4a9a-6f9d-08df1a11acd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 07:58:52.6170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRKp4yFhDBtW7YWBGo2gohZgpNEu93RnHHXWc1puecYcJ3m+rgsjW3omytm9h5VD0ANXFmQgLwQcTF8LxYH2HmG7cbIT3pxEqlLLIxo9o+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

SGkgYWxsLA0KDQpPbiBXZWQsIDIwMjYtMDktMjMgYXQgMjI6NTUgKzAwMDAsIG5ldGRldi1ib3Qr
c2FzaGlrb0BrZXJuZWwub3JnIHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0
aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAyIHBvdGVudGlhbA0KPiBpc3N1ZShzKSB0byBj
b25zaWRlci4NCj4gDQo+IENyaXRpY2FsOiAwIMK3IEhpZ2g6IDAgwrcgTWVkaXVtOiAxIMK3IExv
dzogMQ0KPiANCj4gSWYgeW91IGJlbGlldmUgbm9uZSBvZiB0aGUgaXNzdWVzIGFyZSBsZWdpdGlt
YXRlLCBwbGVhc2UgcmVwbHkgdG8gZWFjaA0KPiBpc3N1ZSBvZiBNZWRpdW0gc2V2ZXJpdHkgb3Ig
aGlnaGVyIGFuZCBleHBsYWluIHdoeSB0aGUgQUkgaXMgd3JvbmcuDQo+IElmIGFueSBvZiB0aGVt
IGFyZSBsZWdpdGltYXRlIGFuZCB5b3UgcGxhbiB0byByZXNwaW4sIHBsZWFzZSBsZXQgcGF0Y2h3
b3JrDQo+IGtub3cgYnkgaW5jbHVkaW5nICJwdy1ib3Q6IGNyIiBhcyBhIHNlcGFyYXRlIGxpbmUg
YXQgdGhlIGVuZCBvZiB5b3VyIHJlcGx5DQo+IChvbmUgc3VjaCByZXBseSBwZXIgc2VyaWVzIGlz
IGVub3VnaCkuDQo+IA0KPiAtIFtNZWRpdW1dIHBoeTogaW50ZWwteHdheTogd29ya2Fyb3VuZCBv
bmx5IGFwcGxpZWQgdG8gb25lIFBIWSBpbnN0ZWFkIG9mDQo+IMKgIHVuY29uZGl0aW9uYWxseQ0K
PiAtIFtMb3ddIFVuaGFuZGxlZCBlcnJvciBwYXRoIGxlYXZlcyB0aGUgUEhZIGxhdGNoZWQgaW4g
Y2FibGUtZGlhZ25vc3RpYw0KPiDCoCB0ZXN0IG1vZGUgYW5kIHNraXBzIHRoZSByZW1haW5pbmcg
aW5pdC4NCj4gDQo+IC0tDQo+IA0KPiBuZXQ6IHBoeTogaW50ZWwteHdheTogd29ya2Fyb3VuZCAx
MDBCQVNFLVRYIExpbmstVXAgaXNzdWUNCj4gDQo+IFRoaXMgYWRkcyB0aGUgTWF4TGluZWFyIEdT
VzEyeC9HU1cxNHggZXJyYXRhIHdvcmthcm91bmQgdG8gdGhlIEludGVsIFhXQVkNCj4gZHJpdmVy
IGJ5IHRvZ2dsaW5nIENhYmxlIERpYWdub3N0aWMgTW9kZSBvbiBhbmQgb2ZmIGluIGEgbmV3IGNv
bmZpZ19pbml0DQo+IHdyYXBwZXIuwqAgVGhlIHdyYXBwZXIgaXMgd2lyZWQgdXAgZm9yIHRoZSBQ
SFkxMUcgKHhSWCB2MS4yIGludGVncmF0ZWQpDQo+IGVudHJ5IGFuZCB0aGVuIGNhbGxzIHRoZSBl
eGlzdGluZyB4d2F5X2dwaHlfY29uZmlnX2luaXQoKS4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3BoeS9pbnRlbC14d2F5LmMgYi9kcml2ZXJzL25ldC9waHkvaW50ZWwteHdheS5j
DQo+ID4gaW5kZXggYWZiY2VjNzExNzQ0My4uM2NlZTMxYmI5MzFmMiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL25ldC9waHkvaW50ZWwteHdheS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvcGh5
L2ludGVsLXh3YXkuYw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiBAQCAtMzI2LDYgKzMzMSwyOCBA
QCBzdGF0aWMgaW50IHh3YXlfZ3BoeV9wcm9iZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0K
PiA+IMKgwqAJcmV0dXJuIDA7DQo+ID4gwqAgfQ0KPiA+IMKgIA0KPiA+ICtzdGF0aWMgaW50IHh3
YXlfMTFnX2ludF9jb25maWdfaW5pdChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICt7
DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCS8qIEFuIGlzc3VlIGhhcyBiZWVuIHNwb3Jh
ZGljYWxseSBvYnNlcnZlZCBhZnRlciBkZXZpY2UgcG93ZXItb24gb24gdGhlDQo+ID4gKwkgKiBm
aXJzdCBsaW5rLXVwIGF0dGVtcHQgaW4gMTAwQkFTRS1UWCBtb2RlIHJlc3VsdGluZyBpbiBlaXRo
ZXIgdGhlDQo+ID4gKwkgKiBsaW5rLXVwIHRha2luZyBhIGxvbmcgdGltZSwgb3IgZmFpbGluZyB0
byBsaW5rLXVwIGFsdG9nZXRoZXIuDQo+ID4gKwkgKg0KPiA+ICsJICogV29ya2Fyb3VuZDoNCj4g
PiArCSAqIEFmdGVyIHBvd2VyLW9uLCBlbmFibGUgQ2FibGUgRGlhZ25vc3RpYyBNb2RlIGZvciBh
bGwgcG9ydHMgYW5kDQo+ID4gKwkgKiBkaXNhYmxlIGl0Lg0KPiA+ICsJICovDQo+ID4gKwllcnIg
PSBwaHlfbW9kaWZ5KHBoeWRldiwgTUlJX0NUUkwxMDAwLCBYV0FZX01ESU9fR0NUUkxfVE1fTUFT
SywgWFdBWV9NRElPX0dDVFJMX1RNX0NESUFHKTsNCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJcmV0
dXJuIGVycjsNCj4gPiArCWVyciA9IHBoeV9tb2RpZnkocGh5ZGV2LCBNSUlfQ1RSTDEwMDAsIFhX
QVlfTURJT19HQ1RSTF9UTV9NQVNLLCBYV0FZX01ESU9fR0NUUkxfVE1fTk9QKTsNCj4gPiArCWlm
IChlcnIpDQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwlyZXR1cm4geHdheV9ncGh5
X2NvbmZpZ19pbml0KHBoeWRldik7DQo+ID4gK30NCj4gDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0K
PiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2F5cyB0aGUgd29ya2Fyb3VuZCBpcyBpbXBsZW1lbnRlZCAi
dW5jb25kaXRpb25hbGx5DQo+IGluIHRoZSBJbnRlbCBYV0FZIGRyaXZlciIsIGFuZCBhcmd1ZXMg
dGhhdCB0aGUgZGlhZ25vc3RpYyBiaXRzIGhhdmUgdGhlDQo+IHNhbWUgbWVhbmluZyBpbiBvbGRl
ciBQSFlzIHN1Y2ggYXMgR1BZMTExL1BFRjcwNzEvUEhZMTFHIHNvIGl0IHNob3VsZA0KPiBub3Qg
aHVydCB0aGVtLsKgIEJ1dCB0aGUgb25seSBlbnRyeSBpbiB4d2F5X2dwaHlbXSB0aGF0IGlzIHN3
aXRjaGVkIG92ZXINCj4gdG8geHdheV8xMWdfaW50X2NvbmZpZ19pbml0KCkgaXMgUEhZX0lEX1BI
WTExR19WUjlfMV8yICgiSW50ZWwgWFdBWQ0KPiBQSFkxMUcgKHhSWCB2MS4yIGludGVncmF0ZWQp
IikuDQo+IA0KPiBFdmVyeSBvdGhlciBlbnRyeSBzdGlsbCBwb2ludHMgLmNvbmZpZ19pbml0IGF0
IHh3YXlfZ3BoeV9jb25maWdfaW5pdCgpOg0KPiB0aGUgUEVGIDcwNzEvNzA3MiBQSFkxMUcgdjEu
MywgdjEuNCBhbmQgdjEuNS92MS42IGVudHJpZXMsIHRoZSBQRUYgNzA2MQ0KPiBQSFkyMkYgZW50
cmllcywgdGhlIHhSWCB2MS4xIGludGVncmF0ZWQgUEhZMTFHL1BIWTIyRiBlbnRyaWVzLCBhbmQg
ZXZlbg0KPiBQSFlfSURfUEhZMjJGX1ZSOV8xXzIsIHRoZSB4UlggdjEuMiBpbnRlZ3JhdGVkIHNp
Ymxpbmcgb2YgdGhlIGVudHJ5IHRoYXQNCj4gd2FzIGNoYW5nZWQuwqAgT24gYWxsIG9mIHRob3Nl
IFBIWXMgdGhlIGNhYmxlIGRpYWdub3N0aWMgdG9nZ2xlIG5ldmVyDQo+IHJ1bnMuwqAgSWYgYW55
IG9mIHRoZW0gaXMgYWZmZWN0ZWQgYnkgdGhlIHNhbWUgZXJyYXRhLCB0aGUgc3BvcmFkaWMNCj4g
MTAwQkFTRS1UWCBsaW5rLXVwIGZhaWx1cmUgZGVzY3JpYmVkIGluIHRoZSBjb21taXQgbWVzc2Fn
ZSByZW1haW5zLg0KPiANCj4gV2hpY2ggYmVoYXZpb3VyIGlzIGludGVuZGVkP8KgIFRoZSBuYW1l
IHh3YXlfMTFnX2ludF9jb25maWdfaW5pdCgpDQo+IHN1Z2dlc3RzIHRoZSByZXN0cmljdGlvbiB0
byBvbmUgUEhZIElEIGlzIGRlbGliZXJhdGUsIHdoaWNoIGNvbnRyYWRpY3RzDQo+IHRoZSBjaGFu
Z2Vsb2cuwqAgSWYgdGhlIHdvcmthcm91bmQgaXMgb25seSBtZWFudCBmb3IgdGhlIFBIWSBJRCB0
aGF0IHRoZQ0KPiBHU1cxMngvR1NXMTR4IGludGVncmF0ZWQgcG9ydHMgcmVwb3J0LCBjb3VsZCB0
aGUgY29tbWl0IG1lc3NhZ2Ugc2F5IHNvDQo+IGluc3RlYWQgb2YgInVuY29uZGl0aW9uYWxseSIs
IGFuZCBuYW1lIHRoYXQgUEhZIElEP8KgIElmIGl0IGlzIG1lYW50IHRvDQo+IGNvdmVyIHRoZSB3
aG9sZSBkcml2ZXIsIHRoZSByZW1haW5pbmcgZW50cmllcyBuZWVkIHRvIGJlIHdpcmVkIHVwIGFz
DQo+IHdlbGwuwqAgRm9yIHRoZSBQSFkyMkYgdmFyaWFudHMgaXQgd291bGQgYWxzbyBiZSB3b3J0
aCBjb25maXJtaW5nIHRoYXQNCj4gYml0cyAxNToxMyBvZiBNSUlfQ1RSTDEwMDAgY2FycnkgdGhl
IHNhbWUgdGVzdCBtb2RlIG1lYW5pbmcgb24gYSBGYXN0DQo+IEV0aGVybmV0IG9ubHkgUEhZIGJl
Zm9yZSB3cml0aW5nIHRoZW0uDQoNClRoZSBwYXRjaCBhbWVuZHMgdGhlIGluaXQgcHJvY2VkdXJl
IGZvciB0aGUgbmFycm93ZXN0IHN1YnNldCBvZiBrbm93bg0KYWZmZWN0ZWQgUEhZIHJldmlzaW9u
cy4gSG93ZXZlciwgZnJvbSB0aGlzIHN1YnNldCwgUEhZX0lEX1BIWTExR19WUjlfMV8yDQooIklu
dGVsIFhXQVkgUEhZMTFHICh4UlggdjEuMiBpbnRlZ3JhdGVkKSIpIHRoZXJlIHdlcmUgb3JpZ2lu
YWwNCmludGVncmF0aW9ucyBvZiB0aGlzIFBIWSBJUCBibG9jayAoaW50byBJbnRlbC9MYW50aXEg
eFJYIFNvQ3MpLCB3aGljaA0Kd2VyZSBub3QgYWZmZWN0ZWQgYnkgdGhlIGJ1ZyBhbmQgdGhlIG5l
dyBpbnRlZ3JhdGlvbnMgaW50byBNYXhsaW5lYXINCkdTVzF4eCBzdGFuZGFsb25lIEV0aGVybmV0
IHN3aXRjaGVzLCB3aGljaCBhcmUgYWZmZWN0ZWQgYnkgdGhlIGJ1Zy4NClRoYXQgaXMgYXQgbGVh
c3QgdGhlIGxhdGVzdCBpbmZvcm1hdGlvbiBmcm9tIE1heGxpbmVhci4gSSBkb3VidCB0aGF0DQpJ
bnRlbCB3aWxsIGV2ZXIgYW5hbHlzZSB0aGVpciB4UlggU29DIGluIHRoaXMgcmVnYXJkLg0KDQpT
byB0aGUgY3VycmVudCBwYXRjaCBpcyB0aGUgc2ltcGxlc3QgYXBwcm9hY2gsIGJ1dCBhIGJpdCBv
dmVycmVhY3RpbmcNCmZvciB0aGUgb2xkZXIgU29Dcy4gQnV0IGF0IGxlYXN0IGZyb20gdGhlIFBI
WSBJRCByZWdpc3RlcnMnIFBvViwgdGhvc2UNClBIWXMgYXJlIGFic29sdXRlbHkgaWRlbnRpYWwg
YW5kIG9mZmljaWFsbHkgSSBjYW5ub3QgZGlmZmVyZW50aWF0ZSB0aGVtLg0KVGhhdCdzIHdoZXJl
IHRoaXMgInVuY29uZGl0aW9uYWwiIGNvbWVzIGZyb20gaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBN
eQ0KdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSB3b3JrYXJvdW5kIGlzIGhhcm1sZXNzIGZvciBv
bGRlciBQSFkNCmludGVncmF0aW9ucywgSSBhdCBsZWFzdCBjaGVja2VkIHRoYXQgdGhlIHRvdWNo
ZWQgcmVnaXN0ZXJzIGV4aXN0IGFuZA0KaGF2ZSB0aGUgc2FtZSBtZWFuaW5nIGluIHRoZSBjb3Jy
ZXNwb25kaW5nIGRvY3VtZW50YXRpb24gZm9yIG9sZGVyDQppbnRlZ3JhdGlvbnMuDQoNCkkgaW5k
ZWVkIG1lbnRpb25lZCB0aGF0IEdQWTExMS9QRUY3MDcxIGFsc28gaGF2ZSB0aGUgc2FtZSBkaWFn
bm9zdGljcw0KcmVnaXN0ZXJzL2JpdHMgYW5kIHRoaXMgaXMgdHJ1ZSwgYnV0IHRoZSBwYXRjaCBp
bmRlZWQgZG9lc24ndCB0b3VjaA0KdGhlc2UgUEhZcyBhbmQgdGhpcyBpcyBkZWxpYmVyYXRlLCBi
ZWNhdXNlIHRoZXNlIGFyZSBub3QgdGhlIHJldmlzaW9ucw0KaW50ZWdyYXRlZCBpbiBHU1cxeHgu
DQoNCkhvcGUgdGhpcyBjbGFyaWZpZXMgdGhlIHF1ZXN0aW9ucywgYnV0IEknbSBoYXBweSB0byBh
ZGQgdGhpcyB2ZXJib3NlDQppbmZvIGludG8gdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCByZS1zcGlu
IGlmIGFueW9uZSBzZWVzIHRoaXMgYXMgYSBnb29kDQppZGVhLg0KDQotLSANCkFsZXhhbmRlciBT
dmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
