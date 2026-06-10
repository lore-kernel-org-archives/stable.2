Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1A11A5B9D;
	Wed, 10 Jun 2026 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781063145; cv=fail; b=LocR+CrDq73FzG9bPRTPD2EpdzlCygkmlmOZjQe32Xu1SaQIJglHabrx/djhltwu3ThWaPmkTL0c208ajboDPOo0n+f7Tt6Vdmcx6TdS0l9efPqkiSOJ2LxwxaAaSh/Lbab4lrse8wbRldCuWCCWxdUq9p3E6DzrhD+w1TFXESU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781063145; c=relaxed/simple;
	bh=uL5bq685H2xp8Z0bLfLIDZNQtosdZ7b7vBBXsTqtPGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wf473gYS0FbMEN9+/L43RGoFEKla0JXZ1tBpUDiEHyaz/fyPdepV2BsEGlrEtw0cry9ADXYCnqnyFjIFsczgEfrt418r1SpkHptGFOXLaV06UPLc8qP7u2wLcaM5vbTuKp2bpyUDONWsdpWfXz5sRKowX578PK/7lXOHo0+7S68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jD69GRZ5; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jD69GRZ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYTxwaI5w/uD/720azr85urAEHWnU59DLtn20+A7ElF6j51qLabPsEXJfp7aSCjmg4V5fcwdGKhsvQsecU1GToj0XsrUb7hyuSJWTptsKlrkOdPvh1D+iViu2H5ITujxQaokODGOPqwB2LOV/U48g5IDPdui6Y7k0Ano/h5Q06RaX6rPnhAmuTsxjPA3uJTOtQYxsSw0i/W2+INY5FTj6a7BiEQnNZl9rp0W5RoflU1HFwuLRsTJJr3/eq4VdQigVyUvmhQZMBKK5pHiRTMil05sarvLu+2xY0bUvXi3tvbCQ+OlNrz8qSwx8ukPdtsHqnIPLzyZPfy6O7EzNgjrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL5bq685H2xp8Z0bLfLIDZNQtosdZ7b7vBBXsTqtPGE=;
 b=w88d3tXOnLMNk8IeuGT3JMQnmqGkLY0Yby4a7iuXg8OU1ARA2/gxsFdXbWnfvittmIcwgrESXOKLEQs3YKEGka9j2t5MZ4d9eALVCq+SmPa80LUH/VO5yD/iNk6Eh/+/yo3JyGSuNyfNJRsCnMubG1mX1m/hlnR0JxtdijfJSmaFenjDYAx0CXsK+33hIRY8OJdRMBC9a5R0zWhFENpJfCzQEHm8NwEjjLZRrcQDRXXH6MXpoah1OWgyC1IdNtqWGqs7cOEijhG71p48eqLsLbEXu4qT75mbRtP+PuFfCOnpJIpcAFMP2xNofXHDHJIrUUEXkOQj0nLbEuQhh+LoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL5bq685H2xp8Z0bLfLIDZNQtosdZ7b7vBBXsTqtPGE=;
 b=jD69GRZ5T3bTWKSQU1+hE3u1Xz8bI4TIW+r7hpQKc1rqHRMHZUBtEjBsw9sjDbAqyi7a1KKxnsk3XFLs6NK9lCEoU2IoULPAoZYo5e/b/RZGio2D/PXdc+TEjBY41eWamBRlUPgpOxd1rRVXlgeR8bDVNDmbiOhTpDQP7O81eBOPxOm1oGuQoTiGcouKCvuOFpvjhZ35WZtKHb9i7bye5kDY6ySPdKE6UAXDc3tA092FN41IFDHA7z8lIXmUauFO9DD3AXoTMgG9INmSA5VRYEaWLqvdlBObWi7X+cE07G53DldUVMxZzPf0Gr6DnJmy5oUqYCCzH9ZTJgkxjzPpJQ==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU0PR04MB9322.eurprd04.prod.outlook.com (2603:10a6:10:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 03:45:41 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 03:45:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: "G.N. Zhou (OSS)" <guoniu.zhou@oss.nxp.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Ulf Hansson <ulfh@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 0/2] pmdomain: imx93: Fix shared MIPI PHY resource
 management
Thread-Topic: [PATCH 0/2] pmdomain: imx93: Fix shared MIPI PHY resource
 management
Thread-Index: AQHc99iQirbmN/B1zkexhX5Lo13qcbY3J2uA
Date: Wed, 10 Jun 2026 03:45:40 +0000
Message-ID:
 <MRWPR04MB123302A067E06A3B7F8A18B57881A2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
In-Reply-To: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|DU0PR04MB9322:EE_
x-ms-office365-filtering-correlation-id: 8b5ed6d8-b652-476d-a65f-08dec6a2be1d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|19092799006|7416014|366016|1800799024|921020|38070700021|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 w/3vcjXw8GmgjKB9y5JXfPdvarNmIS8yCQDksol1S21Ecwz7C9CRQ6cdL6f/SXmqMZjIMk5F3UlBhCAupYc88fhzLrmZ1ldr98Y4CowqSvVhPxrsjcK8iSzMNfDRLoJeG9TzCjlH3k+GCUbyf+af4fQguJlF+fRqjK4eh7t32CLKERgjnO+GpznwKq6oEgQ4hwgYHsRwLO/9/vN9l0HAOJAufFCE9eLsGYQbr1hjv4T2JHJ/0mvwVpWoQTfmhgdv6B/RszwpIokvqloix1rHsn46dhNnwf7qKzHChjCA0//IMwZ4vUx6Gti53d/at1+BzrchgAU2ylo8t65psIDxmhkNWyS+HdVy/oeAhqaViJYF6OON7e+Z2qRI0ob0Okg4e3F1MRFHvjaXpZJfADHMyjeWusw7aWyOmYvk72z+ObTH+TGqe4IMKRuWr9zRTWdouPa1/+aKoOX4aNZsVxB0NGSyv7P8pkykuWylPZRsVcIqv6MuvnMUypK9ITM3pCCZlGV+LwFr5kRxjijY4jm2/5hFD7k/1yNEbMa7ijmUOb4FJT2wIH4UH9UHpyqP0GIkaeq0YS24xuvyLbCW0ft+IjSVwwk+90TprabzBS6DBN2N/WubyABGk7MTS4saKc6AylJWdddRLIi6w2cSkNDSj1VB9MOa5r+PWvPh3myrcX5byqrycPRSiEe2hQ8Pun0VI93cP51R3vk6ia3N6QlIKA6J+6T9X07bGik3xdXujvNYLp8IHsmCwSiaEvWnannlNie21sRxnd/eGU+Gto0HVw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(7416014)(366016)(1800799024)(921020)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDJSQjJ3SWxVZWZOeEtwYnBIbUpCTWM2dFByOStJa2k1ZGhvMGEwbE1FZzl2?=
 =?utf-8?B?NE0yYkUxN2VuQVRDRTYvbWowWW01MEs0TzdYa1g3SUJoVVNMYUE0YXNXTFJL?=
 =?utf-8?B?VHVNRXJGV01iOGhWMG83L3FsVGpZNXZYcTNYd2JPdWpEalU5K1U0TExHenhJ?=
 =?utf-8?B?RUpNZWc1ZFJpRFRYZmdhd1hheFFFQ2x1Rm9MWVpTSGNCUjJiQklNMmZxdWk5?=
 =?utf-8?B?dDA5QlJ1QkRjUDMvaHREb253NXlpVU91STVXQ1htNVFaTHdlZUF0T1YyUVJT?=
 =?utf-8?B?bGV4bzRvaVlPa0lBZllua0loMW5xM1Q4VE9BU2tHeU4zSDhpaC9ZT0lFTG9y?=
 =?utf-8?B?NGtCdmpxODBXbWYrZ0t6dWQ1MytzTkpKeHgvMzBnejJrWjNMZjM1alhrNFFa?=
 =?utf-8?B?YkpLbmV4aEhZY0wzVVNIUm80NzJGUUV0b3BmdytMekNBQWdjdVdOaXYvZ3dj?=
 =?utf-8?B?T3g4VFhVakxBdFlRK0M3ekMreUI1dUlCaS90MkxhTTZmN1hRNUlTcFVXYXdj?=
 =?utf-8?B?WU45NDJPTDZKRnJUbm54OU1MMkU5bkhubUVOQzZNZEt1a2UrbEFwWk5wb3pv?=
 =?utf-8?B?Q29lT0V3U2pJZXg5Y0ZENU9WeDlRT21FT2JDVzVlYnJFWmZYR2UvdUNObEhF?=
 =?utf-8?B?Ni9icG1Nckt3b0hEUWM5Y1R5cEdHelhodEhhVWRlMmt1aTZSQllPUHVFV1Fv?=
 =?utf-8?B?eHFIemN3cGFxV0lsTjVJZnZQb3c1YzlpK0FkQXpLVXJNVGptWWg4V3RwUWsx?=
 =?utf-8?B?YS9GTGhiNmNkVHoyOE1HbndZTmdtNU9qSnFSMm0xZFg1RzB2cFJPa1NuZ2NS?=
 =?utf-8?B?UWQxWWdCcWdqTWVib21pZHRVamtpNGxpemRZaWpsU0pQb2tDdUpjWWl5TUg1?=
 =?utf-8?B?SjE3SnpTVDQvV05wNkUyb1R6T3NTQXpLMGd3M2RWOVh5NDF6djFBalE0ZXE3?=
 =?utf-8?B?eGF1QmNOblc1YWhqdmRIWWtMRStGVzRyNzBsNG9BT085bzNMaFd5NWZUT1FP?=
 =?utf-8?B?MkpWN1BDNVI5SDg2djJTM2MrOElDTEQybDRNb3VhVnI2Wm5XeklBZTJBbWFE?=
 =?utf-8?B?TUJoaGdjcXRwSkJOSzZXYW9McWtna0pBVnhJbUpuMy9zblJONnpMVEZhcyta?=
 =?utf-8?B?alY0cGRyNHlxSlp3WVM0cUFzbEM0cFRyaEg2V2hOSnpNN2grckNIWEEvaGtq?=
 =?utf-8?B?NVFnU2oyeXV6ZkYyYk04cUxRQStuNy9GNXUzRDZFOXdJREJsTVpoVFJrL3Bz?=
 =?utf-8?B?dXJKeStGTThRcWZ4Z0w3bURpZjhHRzlvbUlPL3JYY3BTZDZVdjlEdXd5QU9Q?=
 =?utf-8?B?UzdJUVp3RXU2NkJ1N1pOZEYzSXRJZ3kyRDlQY3NoVEtvdEVoT2RpOGxMWW05?=
 =?utf-8?B?ajFsYkZwYnE1cXE2OWI2T3djSDhrL1ZtMzhFU0FxVzM0d3VVYWZwbVZQSWtO?=
 =?utf-8?B?eDhVK2NCeDRmRkpMTEJXSFNYaDZ3NVRxL1MvQ2x1RkkzUTZLUkZoeGZsT3U5?=
 =?utf-8?B?dkFDOTVINWx0MldxZ2FvWmp5akZxUGtpNmtDL2dXeEd2ZUV4S3M1VDF6Vzc1?=
 =?utf-8?B?NXJleXcvVGJ5c1k1Z2JrNEJGeXlVK3BabVFDY0tYZnIyN2ZSTEtqaWRNY0s4?=
 =?utf-8?B?dEYwSUhhMU91Y1liYWFHZWhrV0NTQjRXWlJuRXZPTXVwZFFJQjJhWWFzNUtn?=
 =?utf-8?B?M01sSW5tU3hTeUd3VVR6MFhvS2xTTzI0dVNzTlA1MzF0WnBOVEh2eUZjcVN4?=
 =?utf-8?B?Q3hQdU1UNU9QLzg5OWhTSWJoTG9KdEI1NnN1eFludWNuWm4zUFE0MW5lRWZs?=
 =?utf-8?B?NWNkVHUrOUg4Y2RYRUF2NzRGZG5UclhnUEY0d0lic1FteHA3eGtIaTAxdEFH?=
 =?utf-8?B?emlVUzcwcHVaZDJvUlM3Q2ZLenNIekFqUDFyL0RpblVrK2lNVjU1YldGNEVi?=
 =?utf-8?B?WHhwOVdSMEk1ZjFoZFMrQUErbmpobzc1TGJMbXMvUzNsRVFUT1RTLzFCNVVs?=
 =?utf-8?B?Rnd5NENTTm5iSUNpYTY2SGZLVkttR2NJQy9oOWJURG1lQlpOdW0vckx1SUp5?=
 =?utf-8?B?eHlsc0FzbXc2OFdFUm5sMUYyNlZwM2w3S3dpSWpUeG8zT2R2RDkxSGU1c3ky?=
 =?utf-8?B?L2JtT244cXQrbGs3YWEvOW9RNm1acUg5ZnlaWWFpQVhjcGJMSEJxNnl2YWE0?=
 =?utf-8?B?UmdRV0p6aFVsdWZ1YlRzeks1RTl6WFhWbTIvVEdOSGRjYnp6RXRGUXFVdFhj?=
 =?utf-8?B?T2pub25aSTJwQkN2OTRPdHd3bUxWandXM1NLdHNqK0M0S29mUnNSa2NhZGxU?=
 =?utf-8?Q?UwIRuHzrbjHPNu2S8y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5ed6d8-b652-476d-a65f-08dec6a2be1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 03:45:40.9396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8Vb1decCgsfd2xmfXhW43Otm8ugmXR3PhUTKpOIfOHitFvBcLfx5EtpWbDwMPQ2107Y769W7ckzoJl1dX/+Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9322

PiBTdWJqZWN0OiBbUEFUQ0ggMC8yXSBwbWRvbWFpbjogaW14OTM6IEZpeCBzaGFyZWQgTUlQSSBQ
SFkgcmVzb3VyY2UNCj4gbWFuYWdlbWVudA0KPiANCj4gVGhlIGkuTVg5MyBNSVBJIERTSSBhbmQg
Q1NJIGRvbWFpbnMgc2hhcmUgY29udHJvbCBiaXRzIGZvciBjbG9jayBhbmQNCj4gcmVzZXQgaW4g
dGhlIG1lZGlhIGJsb2NrIGNvbnRyb2xsZXIuIFRoaXMgY3JlYXRlcyBhIHJlc291cmNlIGNvbmZs
aWN0DQo+IHdoZXJlIG9uZSBkb21haW4gY2FuIGluYWR2ZXJ0ZW50bHkgZGlzYWJsZSBzaGFyZWQg
cmVzb3VyY2VzIHdoaWxlDQo+IHRoZSBvdGhlciBkb21haW4gaXMgc3RpbGwgYWN0aXZlLCBsZWFk
aW5nIHRvIHN5c3RlbSBpbnN0YWJpbGl0eS4NCj4gDQo+IFRoaXMgc2VyaWVzIGZpeGVzIHRoZSBp
c3N1ZSBieSBpbnRyb2R1Y2luZyBhIGRlZGljYXRlZCBNSVBJIFBIWSBwb3dlcg0KPiBkb21haW4g
dGhhdCBvd25zIHRoZSBzaGFyZWQgY2xvY2sgYW5kIHJlc2V0IGNvbnRyb2wgYml0cy4gVGhlIERT
SSBhbmQNCj4gQ1NJIGRvbWFpbnMgYXJlIHRoZW4gbWFkZSBzdWJkb21haW5zIG9mIHRoaXMgUEhZ
IGRvbWFpbiwgZW5zdXJpbmcNCj4gcHJvcGVyIHJlZmVyZW5jZSBjb3VudGluZyBhbmQgcHJldmVu
dGluZyBwcmVtYXR1cmUgcmVzb3VyY2UNCj4gc2h1dGRvd24uDQo+IA0KPiBUZXN0ZWQgb24gaS5N
WDkzIEVWSyB3aXRoIGNvbmN1cnJlbnQgRFNJIGFuZCBDU0kgb3BlcmF0aW9ucy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEd1b25pdSBaaG91IDxndW9uaXUuemhvdUBvc3MubnhwLmNvbT4NCj4gLS0t
DQo+IEd1b25pdSBaaG91ICgyKToNCj4gICAgICAgZHQtYmluZGluZ3M6IHBvd2VyOiBpbXg5Mzog
QWRkIE1JUEkgUEhZIHBvd2VyIGRvbWFpbg0KPiAgICAgICBwbWRvbWFpbjogaW14OTMtYmxrLWN0
cmw6IEV4dHJhY3QgUEhZIGFzIHNoYXJlZCBkb21haW4gZm9yDQo+IERTSS9DU0kNCg0KUmV2aWV3
ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
