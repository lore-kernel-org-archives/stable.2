Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795770675;
	b=ZRqqlJVfwfT8ILsdf5Pxwiu8X52gRKWTcsdnzVt6m2uYPtr18xx7sFBulnPKg29Z0HDN
	 OyeshxspcmgJ1EBFYhjeNrEL8dcy83QURshn8XNMSl1TQuW0bzk160GpkB8fQregfzgKL
	 x2gKF8HJ2+2QV/P1AUkBaLvjIXu0ufjE8qUIp/9ITycGtsmOPo7tODKpz4MvmdcyOnG0d
	 jrjQoJkrUiB6LZrH8LWHfWjO897BwrcxD/75XMPACWQqq4chk6Qujyq6MTznykfu8taJu
	 pwsg/r0/MtAc6Z0JHuJHhBSb5/QxanO0WqCSa1Te1KmcdxNvFPmQugO7jpSmaxSes/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770675;
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
	bh=LjAlYwYi7B7kKqWVkdE7SlsmuDPsMv5rQC3tuStj3l8=;
	b=DhMq3AmxRvm+h4w8jQqM/dSccPPooWq0nzkEH0CLea7HLax4lTcfUFbKvMJcWAgf19i/
	 UfaeIx17RkxXzpBSh9VI/KyLJVl6/7nAl4rwLK8ytjmAMSvofZYAwPWgOZmGdITVS8IHD
	 abFSBsYOr11q+DDDZWCnHkkv7T2NCE7TEH+3bH6vFtBA6sr6FmHMWBwGfI8mMdz5SuoU4
	 t0naZycZFwQD+x5vcCaxumKHnjHl8oMODRaKR7UuSaAohsg5K0ggoQHSWd+6dB/OfaPyj
	 xTqrFNH1wKe2mBms6w36dtI9W/V+H0ERCBMKLH5QYfUoWkMIYGhzffkn2org+52BX9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b="UtoE/mMU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.128
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021128.outbound.protection.outlook.com [40.107.42.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA26606A31C;
	Fri, 27 Nov 2026 09:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBA26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=UtoE/mMU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyTkocFjmHkowpAEhmcPIZ9RoRZOmwelsXHyXSMQFv16QSWL2ipfkGDMSV9Afrb2dTFyD38xLWmlvGGmr8p1bvUNQMYvECLidngGklIBh8zAijjF95HD8ai2SZQtv1dqRPX0UizorYQtftPXE9ssp91y+dQgfoy0f6H4YUqDpmhKq1QGie8pkNaSSgSqnY17W/MHeWrybHaxZzmhjZsTPqZqFZplx7+Bxn0Pk945ckbDhO46rguw8IOivfrnHRxv9W/gj3pl9RRG3+7Triyu9dlORYuKIl7trO9jXTPz+ONYXMOkGDC2CNO5yJuvUXcUKwLm3z/ZnZcXucX+fa0jzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjAlYwYi7B7kKqWVkdE7SlsmuDPsMv5rQC3tuStj3l8=;
 b=JDzlqcURYFpPnZifZHY8RcpqsMIpRLNgDkWuauRN4EuCbBeQ8f4PEYyM4wSpRKCt5El2Hb7dHhQMhcdE4rASg+BwrwHYBwkK3pNk0YCcdZosVg8qny6pSz4kv1p7zB36+7sfH05Xhu4yCH5hK47h0b18jyy4hLvNZ9nMk+1UI60O/iHbNZop2+6xlO3JqtxzYYb1m3Bkf3xmR9L1BLep90vdjS6BhKj1BWtqrl1Oj0k5Ea3G9mON0We8WyDLENGJNT+fmatZ9azzTuKHHcZ7ElBgw2VyhOZPQquxwmsv6KW6JEWm7A3uE7aJ10U4PTAsedLUUaY3sm6kp6tztgAlrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjAlYwYi7B7kKqWVkdE7SlsmuDPsMv5rQC3tuStj3l8=;
 b=UtoE/mMUpnxYcmkby2JcungEC5ARA0B3syfyWUk7v19xT+4dN0J6wqcVDkC/Hcund9hwyk6wKdbOIz8moQD7ntv600aTd2oZ+xTCIF1OCyoFdpCY2vXhrjdxEWs1FBK2DTzLTee+mx593KAtY/Aa73vV6+dhKDIG0r69P0eDPtktaQ527TmtBUT8HelX1u+8kUWjXel6rYhr78XRwIRv15olXFsxYdf+UcJYffAKahLFwXdn3fHltgQRF85vFhANDhnLli4ZvvD2l+BJc6t+zDZZXX+HCcl6d/dgtGxC9PtIEF7Gwcxyt8EwJ7YuyCqVioDOLmaGj3w9g2KdhgpcaA==
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 SE5P216MB3160.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2fc::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 09:11:10 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 09:11:10 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"bob.beckett@collabora.com" <bob.beckett@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lafley.kim"
	<lafley.kim@chipsnmedia.com>, "b-brnich@ti.com" <b-brnich@ti.com>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, Nas Chung
	<nas.chung@chipsnmedia.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 5/9] media: chips-media: wave5: finish a job only once
Thread-Topic: [PATCH v2 5/9] media: chips-media: wave5: finish a job only once
Thread-Index: AQHdcAs8g9f2aQxc8kindy0oxPf/Y7dBOb0AgACEemA=
Date: Fri, 27 Nov 2026 09:11:10 +0000
Message-ID:
 <SLXP216MB1148C28B27443A92A5BBAFC2ED412@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
	 <20261109052853.110-6-jackson.lee@chipsnmedia.com>
 <44f3c5e0117b9a3242bf247102df5000d009b721.camel@collabora.com>
In-Reply-To: <44f3c5e0117b9a3242bf247102df5000d009b721.camel@collabora.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB1148:EE_|SE5P216MB3160:EE_
x-ms-office365-filtering-correlation-id: f0709dc0-de33-4dd4-8101-08df4c6660dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|18002099003|22082099003|10067099003|56012099006|261021135927099003|261021123027099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info:
 4Yp3S158tf548FU2XjkfPbC2J7kSLb/7wZucvuJqRHBR2jEheNLjoEzgS1OlA+qaOiggwKYkyNvBm4lvQX1AzVzgXyHi+IWSeG0xTm0Qa1pOolJSi70OjsLW/4xrg1+13bFwY6GPjYM49iWFBRlFLlhya9MS4Rp5k7W/kpmRKPlMWX0RZJs8Y1bCWmCpgn8lAfR8pirtVHSvt15Ur93u97fVytHbKLM5yzd5xrV2SZGX/mnrWrz7LH/StYAvccdHtiIS/tKQSoG4Cogr5KLFEUfNTfDVgrIylSH6AzFzTgAdiSfgrFBYQSEvbiSKmTfX9965bFKHD90uHO4uZYiP69mUj2RWuqUHa3snh+KVu2yQlACjwNBM7so+4NAVJTrUDvRZLqV4oN3V2Ixrogj8J879pwjWRsI0CZt79RSN2mkUzy1YtoCKz5tG48f90RanzFj0cLV5NvazECCj2WJJvSUuH9k/MdJSicm9SiZogrG3zgmE183O35ZIf4vUoEPApDMn+ADskVIuwyePzdb3NqsySStuyLGvraSWTY/EHebOrqFLRleaqfsC7ZKSjtLFMZJearXuTVG7mPuNpMach/S+SxkpEjMprRfvaCXRi8AM3SlANidDft8Gxw/77FD+CrS0vuMrtB22AUBJCdLzrgKeNPmVaQ2S6GSZpG8BQhdWpwk5TYua+9PP86HwWllpiFaMFmJ3Pw5qhEZiTEvcikouLo1u5/B/GwxtZ8lwxHQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(18002099003)(22082099003)(10067099003)(56012099006)(261021135927099003)(261021123027099003)(261026121527099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1Ywa3ZqYUlzTEEwcHJXTWhLQnpCdDQ5Z1lHL0pvMTliQWFBM3kzLzBwYWV4?=
 =?utf-8?B?c0dRRDh1TTQ5S1NRQzZqMlU5a1ZXMGJGcEFsYWsrZVVHejdpOTN6NDdEWjht?=
 =?utf-8?B?VzVlTFl1YkNML0NheENrV3BEaTExT2IyWUJremJDTWhQUzBWQWJPZDdZc0t4?=
 =?utf-8?B?ZzhaTTZmSlZsY05mRzNNOFhmYnRJS2toaDh2czBYUG5YRTJ5d29yUWR6SDBV?=
 =?utf-8?B?U1hLYjVTRC9Fa2tzU2Rzd01EZGF6a3A3Snl3NkdmZm91cjVxaXpCbFFDWFRK?=
 =?utf-8?B?SGppeUE5K0pFZWRrUDQrZWEyUFErVC9ySkhpb0xRRzJlUFNyWVVvc3ovTGd5?=
 =?utf-8?B?b0RYY0cwclErWWZCdStRMWYxZEJOckFMZUVDQ0VQWGZJeG5HVkVheUJ5OHRn?=
 =?utf-8?B?cXhpV1MvRFB6Z2VjaFdQSWswWEpTQk4wZE16MmZva041NjVPL1VYQ21lZWwy?=
 =?utf-8?B?S2hPUjZyS01yd3g1aFJ6TW5WZW1UTSt6QW9BVVNaYk1BaXdtRXFOWUNvc0gr?=
 =?utf-8?B?UUhqSm51SVpsVzRrM0NSblVvOVprSW84di9pYndTQ2JnaTlaRmI4N2F2dk9a?=
 =?utf-8?B?STJvT1pCU1MxZ3hoaEtxWklSZHZ6cG5yejBiUVR0S0lDWjJNQmtpZHVVeWNs?=
 =?utf-8?B?MkpHWlJ1M3JaeitmTTdmMmExQlplVmhuVWU0TjM1NStRUjdlNURoaHd6UzB0?=
 =?utf-8?B?c2RoeFJTZ0JFOXFIRTQxeVdGQVVYRXQxWFJMNkJqN1dLODk1bUZoc1AzY2lo?=
 =?utf-8?B?ZWxESkNNcjMvT1ltZ1dNREZnVk5FSWRFdnExc1V0ai81V1lsbDhwKzc1cE9G?=
 =?utf-8?B?VmJzemxsc3FOTVA1Q0oyL2ZCT2EzL0g3R24xVVE4aGxZcFQxYk1xUzhFak1C?=
 =?utf-8?B?OGZWTGI1dnN4SzVmZndNWWhxUGVjczNpeXdmVndVcnR5MSsrUE4xd0s1amZV?=
 =?utf-8?B?NjQ1S2VYM0VBU3k3d0ZVV1VrWnlnL2FYMlVsKytWSDEvQ0JQMzQ1Q1NBSzgx?=
 =?utf-8?B?d0ZKYWlteDlzN1ViUHdhcjVocTZwUDJBcFB2cWQyei9YSU1ZQWlXeVVDVmxV?=
 =?utf-8?B?U0U4SGQzZ2JjTzN4ZWlvNjN0Q2daeU94dDRRcWt4Mk5WRUF1TnBnN29wWU85?=
 =?utf-8?B?OHZEOCtGbGE1VklSSllBZEFwbXFycmNkWUFOb096UTZsbnZkWkt2RHVOd3h3?=
 =?utf-8?B?em00VjZraXJRQWFzeEVGb0RZNW5kQm12ZTBLTU92OFFhdGJ0WS9ORy92ZDZB?=
 =?utf-8?B?ekZHVXZqQkVKSjErWUF2T0Z6LzFkQjJ2OXFFRkp1amZFeXNnTjB1b0tSQzR3?=
 =?utf-8?B?VWlleUNxWm5KWWliLzh4cklISnRxdnErbDJRTEVwTnBiem1qcFhiSUhtV2Zt?=
 =?utf-8?B?VCtUNmdwVmlibVlaQzBnRXVTenR0QzhpTThQVHJ3ZCt3bm56MWZEODdBYUFP?=
 =?utf-8?B?aUhRUGpnN2tQZmpERVFCeHFKaE1kMjFBQlNKSmxxYndsSThhSjhqL0d0cksx?=
 =?utf-8?B?MzRnZzQ4MlhDUWkycXdROFBsSG40Y0U3c25JeFNqOXo5bTJMREVSTkdBZzQ2?=
 =?utf-8?B?b3haQkE5SDlSdjNLU0Q3djRIN3p1ZHI1ZVpjSmMrRE5CeUJzTDBna0Ixb2th?=
 =?utf-8?B?NjVBWFgrZW1QaGFiMG03VG54S3krTHIxSHpBZzNvdDhubGVIZEpydkpuR0ZP?=
 =?utf-8?B?MEdRUEZaK0J2cVlSQmZOandRMmRBbTc2Tjk5b1p3WTRydmtHamxSek5mN2ZH?=
 =?utf-8?B?eUg4amQxdmJjWC82WUMwanRZanhPbEw1Y1J6MEYydDJiQmRrTG9qZUk1ajBL?=
 =?utf-8?B?NUUzUm9hMWpzb0RXY2RmbzhGcHM2elZzNEtMbENJenhOT0NYMFNQV2pyZSt0?=
 =?utf-8?B?QjR2R2RRL3RDMkt3bWZ3VXB3N2JKMGtKNHZPV2dFemtsMUxEaG94cVY3SFZI?=
 =?utf-8?B?QmlVcHZPWHNSZ29KZkl6TEIwSHRORmNibEVncDFFK1BQNWFOUWhhU0d3cmh1?=
 =?utf-8?B?cittVTZjRFZSODVwd1l0N2taa0t3dmdjVTZSTFFrU3ZIbStlRlpRTzNnYTYr?=
 =?utf-8?B?NHV6TTV1R1F4VGF1NTY4eWpOak5KQWJlTnM0bFRwUVl0WDhhNnloV2ZDR3RT?=
 =?utf-8?B?bDhOTWo4UWJBVUdpSitMaFJHTW9CWW03Ung3KzUvenNuWVRuWlhCMi9tc1E4?=
 =?utf-8?B?bk8zT1EwMUNJeWNQeG84dGdyR2lscGZyS0hwcjJFSjlTYVlmbmgwcXZXWU93?=
 =?utf-8?B?TlF2bVNTL3dLMjJVWlNQVkd4TXJmdGNGc0k1VDJ1NzUyT2doZDR1QlY0OTRC?=
 =?utf-8?B?L05UK0E2MndlL1NQS0hJa1NtSDg3aEhsV1czRFhpaG9wNzRyUFU3Zz09?=
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
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f0709dc0-de33-4dd4-8101-08df4c6660dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 09:11:10.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6B7MwsWlS7kGg9t3FQ2Q1Zu+jJ/Gf9kxIu3Fz6pH3ASpcKsw/vygsTG2gr+/DSg3TvVavRC2vPO9LCueobXUSVbloTngM1JHJ2+ptZMTpgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB3160

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+ID4gK3N0YXRpYyB2b2lk
IHdhdmU1X2RlY19maW5pc2hfam9iKHN0cnVjdCB2cHVfaW5zdGFuY2UgKmluc3QpDQo+ID4gK3sN
Cj4gPiArCWlmICghdGVzdF9hbmRfY2xlYXJfYml0KFdBVkU1X0pPQl9SVU5OSU5HLCAmaW5zdC0+
am9iX2ZsYWdzKSkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJdjRsMl9tMm1fam9iX2Zp
bmlzaChpbnN0LT52NGwyX20ybV9kZXYsIGluc3QtPnY0bDJfZmgubTJtX2N0eCk7DQo+ID4gK30N
Cj4NCj4gVG8gbWUsIHRoZSBjb21wbGV4aXR5IGlzIGEgc2lkZSBlZmZlY3Qgb2YgaG93IHRoZSBw
ZXJmb3JtYW5jZSBpc3N1ZSB3YXMNCj4gYWRkcmVzc2VkIHdpdGhvdXQgZG9pbmcgYSByZWRlc2ln
bi4gSSdtIGZpbmUgbGV0dGluZyB0aGlzIGdvLCBidXQgaXQgd2lsbA0KPiBnZXQgaGFyZGVyIGFu
ZCBoYXJkZXIgd2l0aG91dCBhIHByb3BlciBjbGVhbnVwIGFuZCByZWRlc2lnbi4NCg0KQWdyZWVk
LCBhbmQgdGhhbmtzIGZvciBsZXR0aW5nIGl0IGdvLiBPbmNlIHRoaXMgc2VyaWVzIGlzIHNldHRs
ZWQsIHdlDQp3aWxsIGxvb2sgYXQgcmV3b3JraW5nIHRoZSBkZWNvZGVyIGpvYiBmbG93IHNvIHRo
YXQgZWFjaCBqb2IgaGFzIGENCnNpbmdsZSwgY2xlYXIgb3duZXIgaW5zdGVhZCBvZiBndWFyZGlu
ZyBldmVyeSBwbGFjZSB0aGF0IGZpbmlzaGVzIGl0Lg0KDQo+ID4gKwlzdHJ1Y3QgZGVsYXllZF93
b3JrIHVuc3RhbGxfd29yazsgLyogcmVsZWFzZXMgYSBzdGFsZSBlbXB0eV9xdWV1ZSBwYXJrICov
DQo+DQo+IFRoaXMgbWlnaHQgYmVsb25nIHRvIHBhdGNoIDYuDQoNCllvdSBhcmUgcmlnaHQuIHVu
c3RhbGxfd29yayBpcyBvbmx5IHVzZWQgZnJvbSBwYXRjaCA2OyBpdCBlbmRlZCB1cCBoZXJlDQp3
aGVuIHRoZSBwYXRjaGVzIHdlcmUgc3BsaXQuIEkgd2lsbCBtb3ZlIGl0IHRvIHBhdGNoIDYgaW4g
djMuDQoNCkJlc3QgcmVnYXJkcywNCkphY2tzb24NCg==
