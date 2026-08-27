Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F23B47D7;
	Thu, 27 Aug 2026 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837126; cv=fail; b=t9pkMg/h5qsq8h5/6PQBQCDvQnlVgG4xhaCdgqVqo0a02gX3NrcMpTkVPrrzUoSh8YkEFUtDB/lktGTjUQtHAriL3kH9cxM2v4aTntSFV5Lu8Ek8k2fgc/ZKtuV79GwahnbI5+fT4iNk/lf011a81C+Eckv3RwXlWOtKNwnJaQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837126; c=relaxed/simple;
	bh=iXiHNsItO+WXd0GwHuT6wJkgdJd5/f3+WZJ+O05e98E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ODnhbXybu8l+OGVGU9b4YcEHZeBinW2R0cOMMp7tu8cmEGjaD5aNXDfgB3xRZERdkFwk/4TDRnWtc9Axq67uOHPJZMv3KIxuCah3niik5CV28RXt5RLw3vaSjjd46CgwHQT+Dage0EBovrqqTErUg2HXi/3/3GB7U0urqKcQmyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EjY03pip; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EjY03pip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2qgdJ0MrOa/dIYSXcdOBNA6uQtSScSNzv1SZkJJUKqqnN6PsXRitkguz9TYZy3ivTNoj4syOSNDtoUl28OPtJuPL/3iaFQPYvvfigwCQAPjmKrr7p6z15hpQr3/3cROx88DDsOAWN2pFAGli5ZbpF2EiMiBKejn1RUHE/hc+g++4VNTnB8ej0Ag9UzoFv+SjKft/aoPZTKkJQdNY/mbl+4sdQ8FjAIyYxuumczcZCL/jwwCwQAhlqppx7S83GqP23PPFnAvCRinkBj0cBvbYbQUXeA7qBVbE0NvCjLnQOA7JAlZcnlR9rtD2rI7Wb0OeSW++JLw1pa3PbP8A2RZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXiHNsItO+WXd0GwHuT6wJkgdJd5/f3+WZJ+O05e98E=;
 b=teS0LgyD1be96t4i48By8qU03BqRVoQYIvh0TaI9cAeWW6EG8yKj4tSFzo1LseClDMesSGgJy6rAKMNfd/ZUxekNEEuWNtmwrDZqtvHaZV1h8skJC2nROMG2PvnlL8Hq+nxfBxYuPPLmu5itttNXc8/ZpIQANurLDnDDYopK61v0npOQOKwSbEvHd3iAU9BCyNUA+O05oEba63pBYdJQ7b1E4zzXRmAPDmhswWnKYizm2FMz2cwMmfnC6PDKjh+XdFtTJSU61tAjQcRcQhUPw4jgim3HVHCvN1xE9FOiBEkF/sBRs5q/AX45dlH8A92mYhfPta6E4dQ2puNDqP3liQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXiHNsItO+WXd0GwHuT6wJkgdJd5/f3+WZJ+O05e98E=;
 b=EjY03pipfbq+ZK8+ynEcE2LIdzN+y7zofZ2P7z7MwUxeh1jqS97axpSq0JBX2CfSe4gDoL0I8LO9Lz+iKgXtj/0phIpC4RzujkMykyjYEH80bPKnCES3qotPpdXhy1ilhGNVfb0C0U28RAwYi4rBEQ5go60/0VjUt82Ep2HU/AEQFB5KuBEYmBV0PvGUk/wEB2GEYnYfZ/vkB6fFeORAHbTJ9/wgYSrMGlblNCgoA5VWUTxkeTDbX1Z2xMobh2RPm0S7O78Uyw5gCgG1ae37B9EnpCojNcOb24wjK0oimtdPvTdByXiIDNBO0HGqmFW2BCrTLEA7EhQQIYklm/4HFA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 13:25:00 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 13:25:00 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "srini@kernel.org" <srini@kernel.org>, "bre@breiti.cc" <bre@breiti.cc>
CC: "bre@keba.com" <bre@keba.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eeprom: at25: fix read_poll_timeout argument order
Thread-Topic: [PATCH] eeprom: at25: fix read_poll_timeout argument order
Thread-Index: AQHdNVRjpQ63VpyJ7Eu90/dXlUuxtLax5EGA
Date: Thu, 27 Aug 2026 13:25:00 +0000
Message-ID: <718c79d2ccfceb8d0286cf152dd4aa3f8b836901.camel@siemens.com>
References: <20260826121334.122881-1-bre@breiti.cc>
In-Reply-To: <20260826121334.122881-1-bre@breiti.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3146:EE_
x-ms-office365-filtering-correlation-id: 918a3200-5dee-410c-abd8-08df043e9893
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|55112099003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 aZgqeAjl7GTq+dQUZCxWX1lThyPBktjicRBiKSjRH5f41m1lBJhRxs9HToJkBL7dVw8bTzupv7GVcB/w6ZjU/n0ciw2DKIIc4YWf99JtBWsQGI7EkzcUdq4RWCfVKX4zIAZdv2Sxuy8+XkKs67xweIqHkaa5+8uzEa2ADwdSW/5dsWuAOKEdqF9qTEzzAzijdNpeoKlkRG0KkgVqG8ZP/I/aZMHt4pfAwBUmoRqA+Pw2apmFVFbpBhRaUMyjKD8cdDpwpBx5YhDJJYDspBXXwn4MuzAfzTOhOFC/rwQPSj1KsW7Hj7JaQT3VFnKq+zZ/qcweCh8Y7597/1C2FAxHH6v0e7uJFTMzYLqnA1/tJZpAvrTFOva68rI8IEjweyyWGxz3kumJ7OTIKp5hV7y2V69T40HvsstrCCv1YQziIZvq2asgPMdzbHr4d6TFgb37OB4RqkBa03R++cs9gp5635lu87Ba0mZXQrpPCmp/nb7cvQtFv0j0INlSGeOaOniZJzwMUkRseYRJ32o2MlVh1ZC4StCmqiorzhp+JRImZwzT7bwn41Ga4T2Ye/DXAFFozBv6ZLTH5Z51VS7URbKu0OkhFFpzksyo6zKPeeuCmZgvndnYr7DIc+X/wHL3/FpTrfSioW9yUAICyk+4edp4Wa3I4RrfXE+hgMOOgfVWJmQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFhsZ2dUeVp1ZWpNSmFXSlZ3aDVvZjQrMXhkSGhISTJZV3gyNEg1bWNVMVR6?=
 =?utf-8?B?OXhqTzBvdzNvTlRTNmpYMy9BODRRSCtpQTlsUndZNi9GN3dhaTRDSUNXekM1?=
 =?utf-8?B?UFhmdHVpT0tUUmQwVGs4VVcydzFKZHk5RnNrSExmVWVUci8yYWhtOTB5c2xi?=
 =?utf-8?B?NnM0d3hiQUorNkJoYys4UTFYeUhvWlZseVUwMzQzUjJtTTZlMkVmUGVZMElN?=
 =?utf-8?B?VDZSY0U5NGFJWUdzUGNzcXJCbzhBRVJWN2d2My9DTlZrSkN3SmtIazRLN0VW?=
 =?utf-8?B?MVVpWDRCZWl4TVJMWUZGRlgyZEpGMEpDN0NLKzZEUVpQMkRGR1lwRmpDdlBY?=
 =?utf-8?B?UFBjZDdqeENVU05TcUFRdXZVZjhkQmlOY29nTTVTQlRqaGMwYTdxczRzKzJH?=
 =?utf-8?B?YlRNWUpvc3Y5c2ZRVDR5NmppQkVZQXFQUUdzRUthL01vd1NEdk1EbXNKTkly?=
 =?utf-8?B?bUVocXdrcXhuMmIwSzVRa0FEam00MjU0NW1TK2EyYlRkU1MrZTNMNlR3alQ4?=
 =?utf-8?B?MHI1ZXl0WjFmK1JuZmgvZVVrcTJZUnZjSFYrODJxejFtNExqODEwdzNZbk8z?=
 =?utf-8?B?Y2JzeWxOL0JXNmNYYzJYbXBJR0huZ0c0eE9CWjBWMHZYb0pweG8rVUxZcXlX?=
 =?utf-8?B?Und0TjhGTFc1VjNuTjhBd0pEVHV4YWdQeDhDb1E2M0VKSEUvSGRNWUFSbVo1?=
 =?utf-8?B?SWZaTlJuWEt2REFOdDRLVldCcDhxaXBMT0ZyZVJhS1pSVGJ4ZnlmT0tjTnZq?=
 =?utf-8?B?K0NVRSs5NEdaQjJPSHgvY0xVblVEMmI2bGVlWGJSQUV1Z3Avb0lieUtaOWsr?=
 =?utf-8?B?VVQ1WS9SU3oxMXBvN3g2cFBaNjhLY1pqUVNnelJjeloxWGYzTUZ3T0lVYkwx?=
 =?utf-8?B?Y3VOcVprVDlQeUVaVHZ5WVR4dDJpdTBBU2lGL0pnYU9DVnE5b2gvdkZXa3RX?=
 =?utf-8?B?Mm1naEs3bSsrUHovZ2M2WkNIUUF4QUNJZVpBeTAvK00zQ3Y4U0hIbmFIUThs?=
 =?utf-8?B?S1BDUzE2eThYV1MyaHVQSGtRQmk0RmgwRUpnOFBYMmgvQ1BkSVFGRUd1RjEz?=
 =?utf-8?B?VlpGc2pzRWdkbG1neE5pQnNzVnRlTHNwRkRPMkx4cDZTZ1U2akRTdzJCcFlU?=
 =?utf-8?B?ZisrWWF2M2hqVFJDdkQyaG5qN3lEVHNPY3BiSVRQaEJmSnNTNXc3OHVVQ0tE?=
 =?utf-8?B?bklnSndVMStEMGg2Q3NFcW4zUmdtS2FYVm1GVW8ycEFRSjl3elEvRlJHc01R?=
 =?utf-8?B?RHBMV1JjUzNlUG9CMS9XNDE0cDYzamU2dUN5Vzhra3N3Rmh2NWtrMTBpcEpn?=
 =?utf-8?B?Ym5PaXgyaWxqNUgrcThOODJBUTE2b3pRMTVBYkxKZENSWXVCb29YTEpETG1U?=
 =?utf-8?B?SVVGRlB1S0pHWG9BSUorMEJla2sxN2hGMWNoYVJic01hWXR6Q2pDZEtFVFdw?=
 =?utf-8?B?R2M2bS85WnRqQ0lDUGx2a0tWZ2hvTkhxeUl0NGxWeGVyM0NXcU9vQ0Mzdytz?=
 =?utf-8?B?UjV0N3U4UXN6WE9MTG9icFZJT3M5U01md1F1UnpLT3FEbUE4R0hsTFpFM0Rm?=
 =?utf-8?B?Z0xCbWpremRUN2xpTkdYOC9UaVM1MGJ2Z0NFRmNJUnl1ZmQ2d2JXcHJ5TVdH?=
 =?utf-8?B?UjY5TVZ3NjdPWnYwMEpZOC8yT01LVVVPV2xwNWR0VHl4VW8zVSsyNytBcEtx?=
 =?utf-8?B?S1EyelV1aENoVDZxUE51a3NUSG40aCt3SmhQVVZrZ1hWWlpuWitLSWlkTmpp?=
 =?utf-8?B?QnlaYkdGaktiekpabVlvMmhacmtyUHNZWGU0WTU1YzRoKzdBdGlERHpzR25N?=
 =?utf-8?B?QlBNQ2Z2Y0hGVFVNRHFQUEM0aVFjaUUvVGhxbjJCYnFna3AxZWU2a0FERXBz?=
 =?utf-8?B?Yk1EeG1kdnkvOGNIY1RIVit5c0NxR2xwN3BpY3dpVmlLR3B5V0pLS2MyUFBM?=
 =?utf-8?B?ZHU2a2R3YU03ZjNnS0dGT1BMQVRuMDg1RG56MVB4N2x2MjN2ODZ1Qjk5UFh6?=
 =?utf-8?B?MC8zTmxtZ3dNWU9tOE5ySm5JdE9sTlhlbVVxbnp0cUNrOUlJK2ZYYVp5ZDBu?=
 =?utf-8?B?RGNWRDAzWU42THlzUGZtU0UzeXkycGt1OUtlTVNUMitLbEN1UC9KM1d2QmRP?=
 =?utf-8?B?TWhQYTI2dzNtWGtpSEVYa2Q2bUcrR0gxaXRON0I4ai9hejNSWnJxWERGSnJD?=
 =?utf-8?B?WkJlSWRvY3E4cTBoZFN6UFpzM3VZYWNsQXppK25LRDZlRlFwb2x6WXY3T1dL?=
 =?utf-8?B?ZmxQYjVGREdnUWtXeFRFaUU3bkJCQVRZWlFvVzNnTll6elZJaWZXcnZQWTZT?=
 =?utf-8?B?Y0tMa2psYk1zRTI2UFVOenI0N1NqK2QyekZEMEtHU1lFR1FacFVvTmh1Zjln?=
 =?utf-8?Q?moLXXivbvYCQjd/U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B88093A5857683448A1A1B47617E2D61@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 918a3200-5dee-410c-abd8-08df043e9893
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 13:25:00.3621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbjrTlIrYlMYcvBsceEJIckSCRFpLElwiIvML+5e/k0clACzLBcOtXg4KKu0qVgn3dJ9Q4bxHLityhCIDC0b64/Anu0YCLGa124r15hEXf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3146

SGkgTWFya3VzIQ0KDQpPbiBXZWQsIDIwMjYtMDgtMjYgYXQgMTQ6MTMgKzAyMDAsIE1hcmt1cyBC
cmVpdGVuYmVyZ2VyIHdyb3RlOg0KPiBGcm9tOiBNYXJrdXMgQnJlaXRlbmJlcmdlciA8YnJlQGtl
YmEuY29tPg0KPiANCj4gQ29tbWl0IDhhZDYyNDljNTFkMCAoImVlcHJvbTogYXQyNTogY29udmVy
dCB0byBzcGktbWVtIEFQSSIpIHBhc3Nlcw0KPiB0aGUgYXJndW1lbnRzIHRvIHJlYWRfcG9sbF90
aW1lb3V0KCkgaW4gdGhlIHdyb25nIG9yZGVyLiBJdCBzdXBwbGllcyBmYWxzZQ0KPiBhcyBzbGVl
cF91cywgVVNFQ19QRVJfTVNFQyBhcyB0aW1lb3V0X3VzLCBhbmQgVVNFQ19QRVJfTVNFQyAqIEVF
X1RJTUVPVVQNCj4gYXMgc2xlZXBfYmVmb3JlX3JlYWQuDQo+IA0KPiBDb25zZXF1ZW50bHksIGF0
MjVfd2FpdF9yZWFkeSgpIGJ1c3ktcG9sbHMgd2l0aCBhIHRpbWVvdXQgb2Ygb25seSAxIG1zDQo+
IGluc3RlYWQgb2Ygc2xlZXBpbmcgYmV0d2VlbiBwb2xscyBhbmQgdGltaW5nIG91dCBhZnRlciAy
NSBtcy4gRUVQUk9NcyB3aGljaA0KPiBrZWVwIHRoZSB3cml0ZS1pbi1wcm9ncmVzcyBiaXQgc2V0
IGZvciBsb25nZXIgdGhhbiAxIG1zIGFyZSByZXBvcnRlZCBhcw0KPiB0aW1lZCBvdXQsIGFsdGhv
dWdoIHRoZSBwYWdlIG1heSBzdGlsbCBiZSBwcm9ncmFtbWVkIGFmdGVyIHRoZSBkcml2ZXINCj4g
cmV0dXJucy4gQSBtdWx0aS1wYWdlIHdyaXRlIGlzIHRoZW4gYWJvcnRlZCBhZnRlciB0aGUgZmly
c3QgcGFnZSwgbGVhdmluZyBhDQo+IHBhcnRpYWwgd3JpdGUuDQo+IA0KPiBUaGlzIHdhcyByZXBy
b2R1Y2VkIHdpdGggYSAyNUxDMDgwOiBhIDMyLWJ5dGUgd3JpdGUgc3Bhbm5pbmcgdHdvIDE2LWJ5
dGUNCj4gcGFnZXMgcmV0dXJuZWQgLUVUSU1FRE9VVCBhZnRlciBwcm9ncmFtbWluZyBvbmx5IHRo
ZSBmaXJzdCBwYWdlLg0KPiANCj4gUGFzcyB0aGUgcG9sbGluZyBpbnRlcnZhbCwgdGltZW91dCwg
YW5kIHNsZWVwX2JlZm9yZV9yZWFkIGFyZ3VtZW50IGluIHRoZWlyDQo+IHByb3BlciBwb3NpdGlv
bnMuDQo+IA0KPiBGaXhlczogOGFkNjI0OWM1MWQwICgiZWVwcm9tOiBhdDI1OiBjb252ZXJ0IHRv
IHNwaS1tZW0gQVBJIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9m
Zi1ieTogTWFya3VzIEJyZWl0ZW5iZXJnZXIgPGJyZUBrZWJhLmNvbT4NCg0KVGhhbmsgeW91IGZv
ciB0aGUgcGF0Y2ghDQpJJ20gc29ycnksIG15IHBhdGNoIGNhdXNlZCBhIHJlZ3Jlc3Npb24gZm9y
IHlvdSENCg0KWW91ciBjaGFuZ2UgYm90aCBsb29rIGNvcnJlY3QgdG8gbWUgYW5kIGRvZXNuJ3Qg
Y2F1c2UgYSByZWdyZXNzaW9uIGZvcg0KdGhlIEZSQU0gY2hpcHMgSSd2ZSBwZXJmb3JtZWQgdGhl
IGNvbnZlcnNpb24gZm9yOg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4
YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxp
biA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9u
dm1lbS9hdDI1LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lbS9hdDI1LmMg
Yi9kcml2ZXJzL252bWVtL2F0MjUuYw0KPiBpbmRleCBiYzJjZmI3NWQ5YmI0Li45ZTcxYzZhODU5
NDcxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWVtL2F0MjUuYw0KPiArKysgYi9kcml2ZXJz
L252bWVtL2F0MjUuYw0KPiBAQCAtMjI0LDggKzIyNCw4IEBAIHN0YXRpYyBpbnQgYXQyNV93YWl0
X3JlYWR5KHN0cnVjdCBhdDI1X2RhdGEgKmF0MjUpDQo+ICAJCQkJCSAgIFNQSV9NRU1fT1BfREFU
QV9JTigxLCBib3VuY2UsIDEpKTsNCj4gIA0KPiAgCXJlYWRfcG9sbF90aW1lb3V0KHNwaV9tZW1f
ZXhlY19vcCwgc3RhdHVzLA0KPiAtCQkJICBzdGF0dXMgfHwgIShib3VuY2VbMF0gJiBBVDI1X1NS
X25SRFkpLCBmYWxzZSwNCj4gLQkJCSAgVVNFQ19QRVJfTVNFQywgVVNFQ19QRVJfTVNFQyAqIEVF
X1RJTUVPVVQsDQo+ICsJCQkgIHN0YXR1cyB8fCAhKGJvdW5jZVswXSAmIEFUMjVfU1JfblJEWSks
DQo+ICsJCQkgIFVTRUNfUEVSX01TRUMsIFVTRUNfUEVSX01TRUMgKiBFRV9USU1FT1VULCBmYWxz
ZSwNCj4gIAkJCSAgYXQyNS0+c3BpbWVtLCAmb3ApOw0KPiAgCWlmIChzdGF0dXMgPCAwKQ0KPiAg
CQlyZXR1cm4gc3RhdHVzOw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0K
d3d3LnNpZW1lbnMuY29tDQo=
