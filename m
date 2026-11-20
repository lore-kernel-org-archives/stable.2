Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795172829;
	b=TbOzM+TjCWyaHeWmz957cjs0YmZ+fp932xxpWsJhdwJP4qdW+NxgjWWFITnqxJo3XuAg
	 ZRXwn9rua1xY9Rf/Yh1HfEcbJxFtQRuXKnyYuxkfMwwm0z1nW7JJ/t/18//EXJN0Kd96G
	 RYaMT5nOyJzcajb7fuxhJEyf1qx0KwCfZa29J4DH2mJZil/NsjiLicyeAnAW+JfiuTCnQ
	 LYQTJh8Xe+ySupkH24FKtkd8ED3Tqzdla2ep7O2U1ItP7U92cGurNt+RY3U1SXQXQihhe
	 CQ6b77TGxEjTEZiGL8cm9AfhvmWPv4ZU+obaIVdKv2zQWl2I183eMPaqfOyHJCBosTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172829;
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
	bh=sLifkeMnIp10/gO0G42O8cgqX5MEPqoE19Io7oemOIo=;
	b=N489Zc93bsg7EsWQ+04xfSNq4LsbgO9VS/KccLyTeQOjg5+IPQ1/nba1AwUTxdEu/zHz
	 fSVS9oWMYHYxB+DGGk7jhnpiE4EJLzZ/r4lb9cKT9FvFLyXdE7ffY3zPuhUyBApwHbPhN
	 g6USHKUN/c6nPFrmkI8yJpPU5OxqFy4PegBo2+066kwLjCsdgymGnkvVKRZAklAuwI892
	 QbfTgVswxob0GOxvjmGi6o/OUosz35BZXeimyAQFM07OPrD4+BQK0Eibz13BbNZtUkmij
	 5VdstCzD3+zf2PbTVSZI4MegC6nErkFKcGbM9rr32SAVXHBVmCIF6sjKS3rarpjMdxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=kGRZGNXA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.97
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021097.outbound.protection.outlook.com [52.101.65.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856960A261D;
	Fri, 20 Nov 2026 11:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7856960A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=kGRZGNXA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ebh7X8YZ7kmbuwAhRkzvlyusm7Mgho1QNrBAgv+OFaN5x6OxPQm/VDnmFaKamTgbCqWHUe2xrWRFCQmV5hkJivdiqeafIM+5WMd+cNFNG29H0pTN97Vhj6NXxLd9FmjJZXLjkqjfL/y+DEowsFdjfyS1iG4aQ4s7DWFfjGr626d1cTpJWX0hyhKG36GoNbey+kxflyLO2i4qdFc17unLvsq4fCRPTDSFEjTf3VZa74ELeIn4Wg/uAy2Gx77uivPEFtwts4RbmJGTQpV2ONFxra9CGT2CdpNwinp3M0lA1Nbj6yf+1AYY8bQ3SEZLZpZ2zB+Xg22zrsOJGSDsvE1aCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLifkeMnIp10/gO0G42O8cgqX5MEPqoE19Io7oemOIo=;
 b=TVUoVRsxZP6tCrJSZN4+7WQCDRIXxs4yOlfCB1OmfrQaI1k/NQgOtp82PbPVHC9YLVnzijgb5LyPrbjMGT+KkHmrCUNjtIG+mAWBvOpQKc6Ue6Y0NznBAy0bOAL8eyyzJd9bLLns79RMlj2C0uryzwLNzyejTzlLxfB7pKiu66v8V0xXlt03viNZG5BVq+VjgzG1O33SeZgcg1RorSUOJaZE/EHMGvhUHevgmrbrSyS4+4/Ovy6yDvbzwI1APwcbZ6boYpkLLIcK15tVRWKjgTmfMEHguceBoyWRSvJ1v7nER3icVeY3UYu23m5a+GayMmTLxAHH3khEG7uO5I0ZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLifkeMnIp10/gO0G42O8cgqX5MEPqoE19Io7oemOIo=;
 b=kGRZGNXAQ9nsLeLNma5boaidyDc8dOL9pa9RBxCHuTeF+KEcMbdDOttcXBkBfoXWn61o4kZJ66bWysy+Cg6I4Zm4W4N3k1JDqlK5Rcvf6BaAfFR+v75KSkc1OMe4gydiFAvzkc2P7a30sVMAt+wYXUqsnTL6OgJapf12KLftnWYmMLwsW6+k4jGlG5lZ6tuqUG4o61xBu/PCLjPieDw7NEa6nzlMYcJyM54J+1gh9w7pVFCmOO6ByXTL2IM4ZtxT/7NocW/1JxbazWseF8jleOSYWRz1VAqeKWEW2fui6rk9p/Abc+JxDImkkDuteEfG4HW9nDMbYzhOQpm+5TtBrg==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by MIWPR05MB401878.eurprd05.prod.outlook.com
 (2603:10a6:290:d9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:07:05 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:07:05 +0000
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
Thread-Index: AQHdcakNcmyK0Xj4XE6oHWfwUJ/SSrcu5x8AgAfzqWA=
Date: Fri, 20 Nov 2026 11:07:05 +0000
Message-ID:
 <AS5PR05MB110208F3B0AC6A7EFA9594A6AB9782@AS5PR05MB11020.eurprd05.prod.outlook.com>
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
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|MIWPR05MB401878:EE_
x-ms-office365-filtering-correlation-id: 3687880f-3e54-45ad-6fd9-08df46f66986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|261026140227099003|261102123227099003|261026121527099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info:
 ecLoU4i6QLbS9mQtrvx0lgkuoe9/KvJ/sJAl7jLnj/+lf+7ZbbzINm7iG6QMvX+qBpsbeQhvwxHzS0tuzBbTN5O8QTzeqNZqFAzsoqcCI3p/CPfONBCcU2i+b1vA1vXCz5BHF7h9n0G7CjC8M3LUHXW/hQr6suUDIsLtYKsFUI8HgzcA8z7ciJzwXx127JwWaP8Mm5WE/xih4ojyEEVRqBBo7aO5ZwSHmgKiM50WA1DOY89VWoZD9o/LBeOHbzypMx6oDV4eRxcDU+V5EbMTX4RNuH4yo2VmTiVZNhE0E2KoatIs9B7yTcaC8hKYEbb8czfArCBj8d1o5MTdCEmJUyUqW9HAT3kqOBJvoq7mLWzeRbxkORgOcj/iLD2e5XsyTrl41KDHl1iI5A7ju7xgWwMb1ke6sv9uhBr3Gk4o9PTyc9HLZEOtC4tqLm4HKj4ULBZiCJP/bh18FIJmajOK0is5n6g2VpOXB+6XtnXpn6EZ1fZJoOoRQU4lYw0mTMC6AeT8CX40hy7neQhckZenpiW6+TGV4fizWCpUebEZQLA6vgedPVYOKeQSoM+ACEoYP0Q1itaqP4Cq9jxRDf5AdvYVovurFfwgb82M5PpolFbgW0k5K6OY1iW5NnwORy+RhBBEuu5iuKm6v1unJqtTl61+qSBmCUmZDusFbGkDkB8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(261026140227099003)(261102123227099003)(261026121527099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHFvbXFqdVVhancxOGJ0dTlBYUk0em1SOHdhMHN4b1FUZmhqVTU3RXl2Ung1?=
 =?utf-8?B?NzNsWnQxVnJSV2J2RTlDeHpWbDJxb0xlRUVlc0dLK2RUa2R0UGhyTFNWaWQ4?=
 =?utf-8?B?Tyt0TGVBUjZhSmpXSTdIanZhcXFOSnBOaklxK2o3cGtlamE0dFB2QjVQbklF?=
 =?utf-8?B?bDl4QnVqRUp2TmM0L3pnN055dzBTaUhtcmpuL0NQRlRPYkFZd1Erc3dSVEpU?=
 =?utf-8?B?VjI5VTI0cTdJYUV4T1RYSld4YW9aKzJrOWN4ODJ3WnhMWWtMNllXZWw5Vlpm?=
 =?utf-8?B?M0YwNXVjeU5Rb0lPYXQxWFNSVWNENXh1aVUrL3hPcGhVVVVHTEpoVEtYTFlD?=
 =?utf-8?B?QkZHaU5SZ0xPby9JOHRDSGhTRENibXhhZzZoKzlaRHFybjB2QzE1UGxuSTl4?=
 =?utf-8?B?TDA4bGw1YUdNTWdJL3FtQjJlZFd5VTdxN1NwUXpWRGNjWCtFbHRrbkRXUXZk?=
 =?utf-8?B?eXduclhKdmZpVmsrOHZrVmdOMGZTK29DWnBNeGI3QW5rc1NhekVwZnRQb05p?=
 =?utf-8?B?U0NPSTM1NGZqeWNJUUM3ZHdWRldaajJwREZMWTRxQ3piWVZ2eUgvdnpOYkpq?=
 =?utf-8?B?ejhzYVlSV1h6V0dXNWJ6dm00a2lxU1UzUXFET3BhalZQMU5EQzd3VkpxRW1E?=
 =?utf-8?B?bHNQLy9pTDY5VGtlaUhTd0JWTEdjdXVJU3VlUU5nTWpZMzRnY0UxUm82VjRj?=
 =?utf-8?B?WEowRTdVaXNLTEdRUmp1cko3aUlXY1lkUWNYSGVkNmEyTFN1UmNaUnZwNEVy?=
 =?utf-8?B?YzV4WXZVZGwzR3FQdHZkODFFVk1EbHpHWlNybExEVjFkZVg3MFJjaEdBb0VE?=
 =?utf-8?B?N3VTRW5Yei90a3VERlg3TDU1bG5GTWtTT1hJSmpHT21SWkV0UFRSUDlzeHNi?=
 =?utf-8?B?V2dHMU1MVGFMWWRUaUVWWHQ5TlorcWFiUWd3UWhOZ1hlSGhXTlU1NWxqNEJB?=
 =?utf-8?B?SHJNdTBYclhGc1ZELy9YQ2hvZWRZcXMrWjdJejdJcElBQzdnNW9mb2pFcE8r?=
 =?utf-8?B?eXdQcy9xSG5HdFVDUktPQW1kU3NPbkpxd2pwUXU5U0thZUNyNDMwS01jS24w?=
 =?utf-8?B?OTFlSG5NaHVlVjByM0xBMExYRnZ5ekVBS3Jrd2E1V1BMekdWVDloU0lxNmlh?=
 =?utf-8?B?aVJ4bDBRR3dEYk1BU1J1dXpWcUh2MU1oY0NYekFTV01jSnJzMmhSbW1VRkZp?=
 =?utf-8?B?bEhNTGwyemdmWGhYZHFZMDRFTjZzOGtHN1ZraUk4c2xyQzZSbjhTRHptL1RG?=
 =?utf-8?B?RENLSU1DSGNrME9MTHMrMEo4SE44TzdONzFYWGVmdnZNNFBMbzNZaWJtTUdu?=
 =?utf-8?B?eE9mb1hJdjdKV01FY3pFL2VGekZJNjFQNHMzWUJzK0d5NTE2akUwTlgvNzhE?=
 =?utf-8?B?ZDlXUEFvNWpjMkpQa3MwanZHVjY5cHJ4NXl3blFCbTRmbk92TGRuOWpEc29q?=
 =?utf-8?B?ZW9IU09VazYwN2hORG92cXlhUU0yYmhGL0Vpd1pMMGVRRDlBNTUrMEp2MDgy?=
 =?utf-8?B?TlhNMXNIUmptakpXK2h5Ty8rdmRqc1VEVlJjUURGdll1YWp0QVlhdGVwVzBS?=
 =?utf-8?B?UVI1VjN2YmhGd1N2L1NzQ25EYkowd09RQ3pVaHRPK29EYi9ncWpicE1rZGNM?=
 =?utf-8?B?M0VhTFNqU0RySnRZYW0xR3djYkFndXBnMHNlSVBZRjduVmVVSkF6ZlFwRHBa?=
 =?utf-8?B?QmdQRE1sdzdWSHMwZnFnVWFOUFpmclYwZHZmRTFka3ZNc0dGbVpXckFwVUlH?=
 =?utf-8?B?b3FjN0kycGpmaFpRMmNSSWdnSVBSVmdPVWxmMkt5WFRJaExFZi9XcnlHQlg1?=
 =?utf-8?B?UHRqVEZ5Z2Y5RWxhME1WMXJPdkEwZ0c1NnVPdzVZWFIvanQ5YkpkSXduSWI1?=
 =?utf-8?B?WHBvRzYrc0QvSkZCZFdMQlhjOCtNM1dibmVnbHZTei9aL01vUVY0YTVSdXNU?=
 =?utf-8?B?WkQ5aXVSM1lMdHhZRzRwZ0hKdUhsRzcrbzFUWHEvSDRoYk5SNTdZMDNMMmVl?=
 =?utf-8?B?YWNOdVlwS1ZKRG1yMUk1anNldU0vMnJWRnlETWY4QXZzMU1EN0pTNXh2d1U2?=
 =?utf-8?B?SG9qb2xXMWVRbHYvdnQ2TVpnd2lkR25RamRQWU5pWGpUSURHcWxxNXExajJL?=
 =?utf-8?B?WHRXc3dVVHg0ZzhQZnowR2RwZytOOWFjU2xiRUlFczNEeDFVRW9sVlRWRUt0?=
 =?utf-8?B?SHhzVTNvZENFYThIN2dvODV0OFNFekNHQnJ2eFducjZXcWlzMC9hK3VrQWtk?=
 =?utf-8?B?ZVNTbm1BVVRBY0xOeTFuVDUwbWx1YmRIcVpHeUc1K1d0Zy94OTVXT2lwNUt5?=
 =?utf-8?Q?y2NrjYUdOhbADYKA5v?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3687880f-3e54-45ad-6fd9-08df46f66986
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 11:07:05.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Bl1x1fjj7FsGEWtJEkOFnYvFYqeUabuyokhl1pH8O4u6TH/EzCN8y/SY0SYchb1GDv9lPNCC8GXdu0MUcA5Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR05MB401878

PiAtIFtNZWRpdW1dIGlnYl94ZHBfc2V0dXAoKSBub3cgY2FsbHMgbmV0ZGV2X3VwZGF0ZV9mZWF0
dXJlcyhkZXYpIHdpdGhvdXQNCj4gICBmaXJzdCBjaGVja2luZyB0aGF0IHRoZSBkZXZpY2UgaXMg
cnVubmluZyBvciBhd2FrZS4NCg0KUmlnaHQuIEluIHY3LCBpZ2JfeGRwX3NldHVwKCkgcmVzdW1l
cyBhIHJ1bnRpbWUtc3VzcGVuZGVkIGRldmljZSBiZWZvcmUNCml0IHR1cm5zIHJ4LWFsbCBiYWNr
IG9uLCBhcyBldGh0b29sIGRvZXMgYmVmb3JlIGl0IGNoYW5nZXMgZmVhdHVyZXMsIGFuZA0KbGVh
dmVzIHRoZSBmZWF0dXJlcyBhcyB0aGV5IGFyZSBpZiB0aGUgcmVzdW1lIGZhaWxzLiBUZXN0ZWQg
b24gYW4gSTM1MDoNCndpdGggdGhlIGludGVyZmFjZSBkb3duIGFuZCBydW50aW1lIHN1c3BlbmRl
ZCwgcmVtb3ZpbmcgWERQIHdpdGggcngtYWxsDQpyZXF1ZXN0ZWQgcmVzdW1lcyB0aGUgZGV2aWNl
IGFuZCB0dXJucyByeC1hbGwgb24sIGFuZCB0aGUgbGluayBjb21lcyB1cA0Kbm9ybWFsbHkgYWZ0
ZXJ3YXJkcy4NCg0KPiAtIFtNZWRpdW1dIGlnYl94ZHBfc2V0dXAoKSBpZ25vcmVzIHRoZSByZXR1
cm4gdmFsdWUgb2YgaWdiX29wZW4oKSBhbmQNCj4gICB0aGVuIGNhbGxzIHRoZSBuZXcgbmV0ZGV2
X3VwZGF0ZV9mZWF0dXJlcyhkZXYpIHVuY29uZGl0aW9uYWxseS4NCg0KUmlnaHQuIEluIHY3IHJ4
LWFsbCBpcyBub3QgdHVybmVkIGJhY2sgb24gd2hlbiBpZ2Jfb3BlbigpIGZhaWxlZC4gVGhlDQpy
ZXR1cm4gdmFsdWUgb2YgaWdiX3hkcF9zZXR1cCgpIHN0YXlzIDAgYXMgYmVmb3JlOiB0aGUgcHJv
Z3JhbSBpcw0KYWxyZWFkeSByZW1vdmVkIGF0IHRoYXQgcG9pbnQsIGFuZCByZXR1cm5pbmcgYW4g
ZXJyb3Igd291bGQgbWFrZSB0aGUNCmNvcmUncyBYRFAgc3RhdGUgZGlzYWdyZWUgd2l0aCB0aGUg
ZHJpdmVyJ3M6IGRldl94ZHBfaW5zdGFsbCgpIHdvdWxkDQprZWVwIHRoZSBvbGQgcHJvZ3JhbSBp
biBpdHMgc3RhdGUsIGFuZCBkZXZfeGRwX2RldGFjaF9saW5rKCkgYW5kDQpkZXZfeGRwX3VuaW5z
dGFsbCgpIHdhcm4gb24gYW4gZXJyb3IuDQoNCj4gLSBbSGlnaF0gVGhpcyBwcm9ibGVtIHdhc24n
dCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dA0KPiAgIGlnYl9zZXRfcnhfbW9kZSgpIHJ1
bnMgd2l0aG91dCBuZXRpZl9hZGRyX2xvY2tfYmgoKSBmcm9tIHNldmVyYWwgcGF0aHPigKYNCg0K
VGhhdCBpcyBvbGRlciB0aGFuIHRoaXMgc2VyaWVzLiBUaGlzIHBhdGNoIG9ubHkgc3RvcHMgaWdi
X3NldF9yeF9tb2RlKCkNCmZyb20gd3JpdGluZyB0aGUgcmVjZWl2ZSBsZW5ndGggbGltaXQuIEkg
bGlzdGVkIGl0IGluIHRoZSB2NyBjb3Zlcg0KbGV0dGVyIGFzIGFuIG9sZGVyIGlzc3VlLg0KDQo+
IC0gW0hpZ2hdIFRoaXMgcHJvYmxlbSB3YXNuJ3QgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBi
dXQNCj4gICBpZ2Jfc2V0X3ZmX3JscG1sKCkgdGFrZXMgdGhlIFZGLXN1cHBsaWVkIG1zZ2J1Zlsx
XSAodTMyKSBpbnRvICdpbnTigKYNCg0KRml4ZWQgc2VwYXJhdGVseToNCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI2MTEwNC1pZ2ItdmYtcmxwbWwtdjEtMS03Mjk2MjFiNjBlZWVAYXdl
dGEubmwvDQoNCj4gLSBbSGlnaF0gVGhpcyBwcm9ibGVtIHdhc24ndCBpbnRyb2R1Y2VkIGJ5IHRo
aXMgcGF0Y2gsIGJ1dCBvbiAyIEtpQg0KPiAgIGJ1aWxkX3NrYiBSeCByaW5ncyAoUEFHRV9TSVpF
IDwgODE5MiwgbGVnYWN5LXJ4IG9mZizigKYNCg0KVGhhdCBpcyB0aGUgZmlyc3Qgb2xkZXIgaXNz
dWUgaW4gdGhlIGNvdmVyIGxldHRlci4gSXQgZGF0ZXMgZnJvbSB0aGUNClhEUCBzdXBwb3J0IGFu
ZCBuZWVkcyBhIGNoYW5nZSBvZiB0aGUgYnVpbGRfc2tiIGJ1ZmZlciBsYXlvdXQsIHdoaWNoDQph
ZmZlY3RzIGFsbCBpZ2IgdXNlcnMsIHNvIEkgbGVmdCBpdCBvdXQgb2YgdGhpcyBzZXJpZXMuDQoN
CnB3LWJvdDogY3INCg==
