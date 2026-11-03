Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793711777;
	b=CAon6jFWkG4F5z5L1REaeWnURLh6W+dHCFCig4TQOKXNDbR1vA8A79A6/d0mDsD0vxVt
	 QqXQjYw6tAh/uF/ppvZ+QDR69Pw891Pgh5oyMjCsy/inpxPniHxQTz19qrEjcT407wXcE
	 Ol2RqnPqGhjVWubBHYdqwynVImGsvUWsdunsCcenKf0f0IZhByphwNh/19P9C3A3vvfmD
	 V8x909UZSafRTtRCEELdW26Qn6aKgRKURjxeEnQ47aPmbyR2JtyNVMcG9gH3WmQvSjIrW
	 EvjkfHkoPrKUGLNXEL7H6oabgZeMvJH9j3TAlJHl9pFvmduIzpoSXEWCbIaGifh/AwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711777;
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
	bh=LTZeSPilcr0VvsQN9O3n90i8cH3CfRT79/HqaFWbnZU=;
	b=21Sc7vyxCVKTrOkDLxIBqPZiCmmPfoHAvusOTTwTxwfjl0+lWFm5rkkQ7YR+YYeDGnA1
	 l3nzEumMQ/vJjU1z6atBOFjwETmajlIeMBavtf5VY50+C9Weq4Ej6+zeb+OHoRSVQNJMX
	 FWquI04I/Etd3uVQ6w18LBqMf8m1kEbF9RD2gtPDWv3yQRYvmrAhWH9vYfWrrfvOzt84h
	 F6m0VjUEWjiufeCVGWkz+g22+vDv8DWfjRdUUtzLiVlkzYkHDFNx/Ww3DlTnx/QjeK/El
	 t8XVR5aVgKR4mAsg3uhNPJXHeOEYrdR5jPtIpim7MtDJmU1zNOnBR3LsLsiABHA4SOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=I8f79xff;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.123
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023123.outbound.protection.outlook.com [52.101.72.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53765606A324;
	Tue,  3 Nov 2026 13:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53765606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=I8f79xff
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN7ebemShMrjTCopTQstG/I7AL5lq9yx/yxJ10DJJTg7r4pF/wtV9ZGEYgc9TH9Qdn0AAgSlV4rSCICJWFXsCB7DHwaMmF+vjRT86/jjUVSkdC6pneq7A//WTeRLffuTBIsr4y5LUySxGTiN8UdbNTTD1gqN7zKzqevMHEciTFi8guVg54FqbG9hMlMXuKGYMKW0ppJE5+9S0ZbCTADNl68pkmu8+xKh+iQujc2bm8RdnnjpF8y0NDo++YRn2cCN3kkXz6/X0tzg6AlOLlc/QgRM6xzvZrKBUZPzLsIYfusi5+wRKaKO0QEknJa4nf66lXnWaHBZoZOZeJV4QO+H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTZeSPilcr0VvsQN9O3n90i8cH3CfRT79/HqaFWbnZU=;
 b=A6w871EbLyvqVSdMLNjLiuju4rjK59PWRR5zW2571LRJ/yEAq8bM0dgyjE9KtNs8IaEdTvU80J27K0BYpHXFUWZP8WwLHsTKDLoXwjRfx91rozgY1HGvapceq//AZoJOa5EP5DnyCDwlrYk+BoZEAlRVxTDqvxq/SG7HA0f3PRGtBTkmQ73JH+ZIc3OEt6JFIojgXPt12HanAw82QwlciBbXn/eIV4ekYWqtGr8gvVJk8znrEZEXhFcMW6IMt9KFJKTCZr0z2iqBaVV/cNVU2zjYt956q8JYigUYV2gSaM7bGOX2fjUt3X5Hs1aM8Ei1svl57B+AJ0Z18Rneo/6bhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTZeSPilcr0VvsQN9O3n90i8cH3CfRT79/HqaFWbnZU=;
 b=I8f79xffVZgiI6gxDdWeC0hWsLqjyh9DFNV6LBOn6nriNQSZNCfHZrRGPcPiHFGl0gOtUCcQtyIlJ4FYCrgfSRDHxD3Gba6/PBbEao4r5A3ecW35LayWmfN61A6EnbaQzOxuBSxvR+Htp9Qo8kTpn+JtGlHN1EZu2XgRgBrOpvfYAB2qsatdcFjZ+Tz8jITyb+svrEtGbbfy2Qw7D9+h4W4pp2sybl5ob/BIZeXzIFQbwXeIO4kwcFjpRE31R9Yy6zEj2joWysMXY3I4yo5UW4FrbMXvAl8OdjQjQyY5iTsFfUSv5NjNp1vGGs9hnMv/xHS/4Wl99+GJIH6w6ASoWQ==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by PAXPR05MB8907.eurprd05.prod.outlook.com
 (2603:10a6:102:2bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:16:03 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 13:16:03 +0000
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
	<kurt@linutronix.de>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>, "p@1g4.org"
	<p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"piotr.kwapulinski@intel.com" <piotr.kwapulinski@intel.com>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
	"alexander.nowlin@intel.com" <alexander.nowlin@intel.com>
Subject: RE: [PATCH net v4 1/2] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Topic: [PATCH net v4 1/2] igb: do not let XDP frames span more than one
 Rx buffer
Thread-Index: AQHdarejzpT57/RavUmAT0FgGXupo7ccNBKAgAAhW7A=
Date: Tue, 3 Nov 2026 13:16:03 +0000
Message-ID:
 <AS5PR05MB11020C461985A30820EE5BF5EB9692@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
 <179370458190.488856.17697539789438631896@kernel.org>
In-Reply-To: <179370458190.488856.17697539789438631896@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|PAXPR05MB8907:EE_
x-ms-office365-filtering-correlation-id: 4808b2e6-0518-4da9-c726-08df39ac9c8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|56012099006|38070700021|4143699003;
x-microsoft-antispam-message-info:
 Yrf2mR7KVW2A3BnUhCv+omUcMeDhTq77hsUpoVEKNNxhvsXwWyRg4b8N/fKHs4+pErwvx3cTF+umuAMpQCpJaU0OG1srjaIUTv51jIA5fP258zPsEHFH53LIGStZURVMRRoHvnCcwYUm2TG7ChKGaMKV+fOMc9XT5WKD1tnK1/tkksjjhx3ejfCKNu73YMB1YQ40kd14nTH+i/SM+nD/r+kfrV0/4+yhfpE3a50RWjFfekPxVB4GjtbSbb8WUL1jqiDMVPyJ6XED4jgvNcodfo41xfsRvR/Lg9jTDuzL/VyhVJLVy8DMl9AyfzMB9MGwp05wWb1G8CUpug0OdmbM0zEtyktCwU5C/mlkSo60Fa9QPwXzYaeUTd2Lpxibu/6B8OLjRzh1mSGgGljPLf2seddoAR1rxqmF2bT+iOiaIrcayrfo2q6Be1usbflmGifbPJCuT3UkvhoA7JbFgx38rNn3xTm+JXYYfXZJkndU9ypz4Sv3qojSkxKfbrcBWqGGf/DxuByGX7oPssS4yqXFlAQP8G+gg8rYebCDoRtHCAjuE2rKdUK4x6gNZQ0gxzWqbj9DVtNvJpMbQq7eo8EprpECk2/chRnzDWBaJr8FZ9Rzk82vQ89pwUqtDA5i0Sgkd7pPij4Sn5vF9JdOYW+Y8C1q1EU8y+OKBzginNmxLT1TSFrM3TJ+FcCDFPFw5l+drOghglGfTg1HAHkf/0e86MuYDxvLXuNXFT+VFOobOYA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(38070700021)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QS9rQkZFRVJlS1NoY1l4bjN6RUNoMFFqV1MyM3J1MjBpbHRZZm1rbG9SaHN1?=
 =?utf-8?B?aFZCaTg1eDdKb0VpeklJVDFKdzFjZjNsTTVUMExrR0laRGkyRnVodjNmamty?=
 =?utf-8?B?VWlsTDVZQWF1Yml4b2tlSzVLOFJWanZEdTIrdXl1RGU5STEyOFNJMVRFT2Nh?=
 =?utf-8?B?UmZJZFArOVIzRFlON0pSS1RQckcwdWF6Z3JUd1lzMkprR21yOEJNcVpMWVZN?=
 =?utf-8?B?NE9TcVdYZWpuR005RFZTMW9QZUFadkJCNktaS2JYd01VNzJTOGFjamxGR2Jm?=
 =?utf-8?B?MHFHdjcrQ21ieHJHZzBEVXJBQXVTS1RuSDBSeFQzbFZjdUtwMEkzYWd3Q0ZG?=
 =?utf-8?B?K3U1MHBQV1ZyaWNnOWtPTnh6cEtXMnhlcWhXWkRGQmlDalYvTnVEZWZ2NGZL?=
 =?utf-8?B?NE0ra25GbDhMcUM2RXZEZmNUZ2xBTSt1NVpYRFhoRG9qRXBsd3ZPMjZIelZD?=
 =?utf-8?B?VnNVRHUvZkZiSVVXekRNY1F4SkQ3VmZKTzBCR2hCU1h2TVVlOE9NU1ordmM1?=
 =?utf-8?B?alFIU1N0YkR2UG9SNjZtWHdXRVR5c25qbjdTeDFWS2FLMWhkamk3cjdlTE1y?=
 =?utf-8?B?Y0h1OHdlTVpKbjlBRzdrWmgxdDM0akZpR3psbG8zUmJidnBNVCtqZHhaUmh2?=
 =?utf-8?B?NGEvdVIrZzFrbHFrVFJHSmhVbVdMOW1vYTRwazE5dkZIUzFHcUxpSXFqaGRV?=
 =?utf-8?B?UTExMmRJYi9yUWVhWHJ2R0pqVjhyaWE4K3QwVkdNM05XbEJOZE5iNWZqelNn?=
 =?utf-8?B?V2dDYm1Ha1FOaTdJTlhzY3ZoWVNjOVA1YmN1Lzk3QVNoam5IY2RvRmJxekp6?=
 =?utf-8?B?MXV2aHR0WHBSdWEySTBodnRVcndpT0dkalpzazcvWXd0RnFBWXc0NUxwd0dP?=
 =?utf-8?B?V2NYb2xPN3YxQzIwd0JiTWtsdTBkMGhDNWRwQVJLVXJxQWx0dHZxWmZBTEth?=
 =?utf-8?B?SWFtWlpqS0dyNkZKV2J3OVlGOU9XNVdoemIzTTZ6Ui8valA2dE5GazlvMVU1?=
 =?utf-8?B?ZVBkc2hyVkxkNUJSZUhqeW05dWw0UU41TXBqSDRJeUVqczFQRkVlNFYyelN6?=
 =?utf-8?B?MHRXcGlNWWZCamdTeUJGdlQ3SUlLVVNzNU4vM0tvc1JSRlFFejNFMjJsODFH?=
 =?utf-8?B?NEhOSno4WjE4a1Rjby9raFd6emtzc3lNUzg5a1VtNGFVdnJFVVlBTSsycEFx?=
 =?utf-8?B?QWFsZ2R0VnM1V01ydmJiN1NUSlVCRTl2N2MvU0gydkJUcmNPbGlENGRYZFdZ?=
 =?utf-8?B?NG5hRjN5dFcxSzJTcmhUWnhTNXp4L3FQbW5pRXVpSjFMZzAyNXR2ak1GRHRz?=
 =?utf-8?B?WE9LRDNBT2lXVjJVWnQ0R2ZQY3JpWitCS3dQK204aGNPOXd3b1NIOHU3dndm?=
 =?utf-8?B?dlpvRXp3cXlEVHVKVnFYMGlCMGltSWNhS2VuTUlsaTFpMTJhYk1HS3lLMEg2?=
 =?utf-8?B?cTV2Z3F5RUdtbzVSS0prVXk0MVNrbExXWFlDMHNUV285TGZuMHRINWdYMkV3?=
 =?utf-8?B?Wk5mOUlaSGNrcGh3ZkhST2l6Y3lNQms4aFlMWWVrNWJ0ZmxCZStrTXlWUnZx?=
 =?utf-8?B?d1BjR09GOHl6V0dRMUJTWEZRcndMeEQxL1ZPZGtpYU9GNHZWUC9kY24vSDd1?=
 =?utf-8?B?QjBGK2JYKzZFamhzRFlMeTY0RGNXWUlWdTlJVG5UMjhvQzBhTkJZT3JwUjlV?=
 =?utf-8?B?dm5Rd2JBOWYrOEk1YXQvVVZpaUpzaUhRK1pKKzdGanV5b3licElmaTNwT0lz?=
 =?utf-8?B?ZU0wdjNsYzhiaHkzZHVnRloybWpXc2tOZUNtV09DMXZEZFYxSEVONVZYYWU3?=
 =?utf-8?B?VEd5ZU4raXZrOTJsQzVWN3dOSzVENVVzVkZ6eHJyaGRmTnhPOVZyZTZvVmpx?=
 =?utf-8?B?S3JCUzgxdldCeDlUWTBJVVQ5NTd6RkRSdzgydHd2amZ1UWF5ZFNQcHZSVU1P?=
 =?utf-8?B?U25mOW5jNllTQmprcXBuL0d1T0JTOWQ2S1E2RnliblprNEdtYzJlM1J6ZWhx?=
 =?utf-8?B?dlAyMnBXTXhINE13dTdNc1BxOHlDNTcxbmVJcDgxdTlkcGxEbUJuYVpKN0ZI?=
 =?utf-8?B?STc5RUlsSHZsbVhSVGtNUkhTbHNOaUh4ZTVBOEN4dmk5OThyZGoyamg0RDIv?=
 =?utf-8?B?NlM1dFN5T1F2c3NiVVRBTW5qKzFpUVFFRWE5dk9TeVU3a3MzY0pXc005WUox?=
 =?utf-8?B?ZFBVS1plN2M2aVdzUnhYd29ndVo2OHl4cDVPZGx0S2JiQkFpOEJoUStocmln?=
 =?utf-8?B?aytOTTJscGR6WXNBMmtZcnIxME82RnRxUkoyb3FpVTVycnlFc3d0TmR3NkZy?=
 =?utf-8?Q?Eawo3BYI/spA+SSdMP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4808b2e6-0518-4da9-c726-08df39ac9c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 13:16:03.3295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4Sr5UMb4p7xHqmIsIYBV3hA0msKCSyJW2wdG31ttdreuUPSa1ejWuBWLA29AgiVumApuThRj3hQpQa+3reA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8907

VGhhbmtzIGZvciB0aGUgcmV2aWV3LiB2NSB3aWxsIGFkZHJlc3MgdGhlIGlzc3VlcyBpbiB0aGVz
ZSBwYXRjaGVzOg0KDQotIFhEUCBhdHRhY2ggYW5kIGRldGFjaCBhdCBNVFUgMTUwMCwgYW5kIHRo
ZSBNVFUgY2hlY2tzLCBub3cgdXNlIHRoZQ0KICBidWZmZXIgc2l6ZSB0aGUgcmluZ3Mgd2lsbCBn
ZXQ7DQotIEFGX1hEUCB6ZXJvLWNvcHkgcmluZ3MgZ2V0IGZ1bGwtc2l6ZSBidWZmZXJzLCBhbmQg
c3BsaXQgemVyby1jb3B5DQogIGZyYW1lcyBhcmUgZHJvcHBlZCAodHdvIG5ldyBwYXRjaGVzKTsN
Ci0gWERQIGlzIHJlZnVzZWQgd2l0aCByeC1hbGwsIGxlZ2FjeS1yeCBjYW5ub3QgY2hhbmdlIHdo
aWxlIFhEUCBpcw0KICBhdHRhY2hlZDsNCi0gdGhlIHJlY2VpdmUgbGVuZ3RoIGxpbWl0IGlzIHBy
b2dyYW1tZWQgZnJvbSBpZ2JfY29uZmlndXJlKCkgaW5zdGVhZA0KICBvZiBpZ2Jfc2V0X3J4X21v
ZGUoKTsNCi0gcGF0Y2ggMidzIGNvbW1pdCBtZXNzYWdlIGlzIGNvcnJlY3RlZCAoaWdjLCBtaWQt
ZnJhbWUgbG9zcywgc2l6ZQ0KICB3cmFwKS4NCg0KT2YgdGhlIHR3byBwcmUtZXhpc3RpbmcgaXNz
dWVzLCB0aGUgVkYgZnJhbWUgc2l6ZSBpbiBpZ2Jfc2V0X3ZmX3JscG1sKCkNCmdldHMgYSBzZXBh
cmF0ZSBmaXgsIGFuZCB0aGUgYnVpbGRfc2tiIGxheW91dCBvdmVybGFwIGlzIGRlc2NyaWJlZCBp
bg0KdGhlIHY1IGNvdmVyIGxldHRlci4NCg0KcHctYm90OiBjcg0K
