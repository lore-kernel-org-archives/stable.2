Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FF4F55B6;
	Wed, 16 Sep 2026 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602889; cv=fail; b=XTEI//B5yeVYt/o7w9QcZJyfOQUU9eANhH4kVXsCk/1tvkz2LvUcXe6Xn3FXH12eL1199fwCzIRAYaVLbc2o1GQv/TyhNgk9XeW2YmFpBPIJ7tFFnofOXD2+gJL35ubWIRCbvEc1/U0jHujR5YWVQhs7AaAPAKC8MB3X16QxgCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602889; c=relaxed/simple;
	bh=KLif3wNQwmm1j0rzEdaBidcKkHq29JW64p6TBGe4QGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NmopANsAz5795TRbBlmlW6yyi9Z1k1bsIrRyF640m/nLuH9coQY59nzX2qpTpZeacbQvVv6hjpqxLPI5flJeEc4yurnzzzB8vlCAkz5TQLgJpVvNZOPnSAeoE2FhJYTdofzJqYpdgZlOtV3DGw6nOXv01Fhdg1QHeBwqbIbTJ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=cy7CgAEn; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="cy7CgAEn"
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GLAhuw2784997;
	Wed, 16 Sep 2026 23:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=KL
	if3wNQwmm1j0rzEdaBidcKkHq29JW64p6TBGe4QGY=; b=cy7CgAEnZbtHdbUBuO
	2kO8WslyM0LwhbBlkoFs/UHk9WyWqxKS7srjinC64+/h7xi5xvsQfnaKJwmkEoA6
	meaNe8mf+IKJOC5RChuUdlKtSE10UbohEQKgVLKAneawoUuW28iAjKYlxuuKJCBW
	fgE7N/BTdFv1iBopO8rjJVfdyZOK6qpXisvyxDUR5UNDuURXtUBiUXjd2MgUEin4
	iUGRANMA5d85SV2Ytz+TsOBZee+JRmlxVqoepF/IRedi8p4ndDGw0CPWUhqs6TE3
	w5JiOFxo459L9bIfBXdzRVsEiLrjacRkHOPuzf1R85P3pMfmjzbjwc5PalrNIX34
	Snjg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gr2t41kb0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:54:27 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id AF30FD2DB;
	Wed, 16 Sep 2026 23:54:26 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 11:54:20 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 11:54:20 -1200
Received: from CO1PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 11:54:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d08ldSDaXyMqNGdqd1+j+Qq9koUlxCzbtkC0Bu42+AbU9vqhmxUmlNAAYcVVZqvmxf+umeeCYbe3xDw+r2kW/zh56jxEdufFkD2f9/fpi9M2fisMIH2yGhL2EVVtJwwZahkTWke28kzELDy8i8cp7eh1u3QNcN6d9oGd39MvRnoKR6eFISwz7wwZ2fyzN9QmUgI4CcU7TpADncIqFYLY9+MCLBDgoXA1FtexlbLfQ+QpffeP+q3JIny/PUqYTY1tHREUx7hqCrWXgr65XAxl4uGuhqrb4zRCvYZ+xgtVjtC5BEyvUejT+jNYiX8i9yCLXHtp+DMpiNG1Eypz8m8WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLif3wNQwmm1j0rzEdaBidcKkHq29JW64p6TBGe4QGY=;
 b=Fd7M8KrPgjnvvkMCo0+uakCLdGNZiGkJmwFrm7ZbrMM7wS6g3ilXbTz5fKw5F8JNv9JUdN5YLf0IiKKVQA6At2ZvzmA0Y9477btDMNAbhVhpp8Yqr6Cy9qffZaTVevlmQbUH4HVRsk/HVa/o+jD92f0aumtMqR+5RI6kKJJsp7tJyHFhQIWp45ept5jnxmqX1iChfPCfibvGNjxAiDsiNCFgvz4bz5QkzZPQqLX/YaD6aJOcBJzmu9P28XNLgbWtm/nSpMbt4t3dH6RTByc5KgKflj/G9cAy9dmrEpN0GoqtzEmr4bmEVgLytXTq0/N7sRVDJ8Fr0zdxGa4nwPqIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW5PR84MB1428.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 23:54:17 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 23:54:17 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: [PATCH v2 1/2] hwmon: (pmbus/tps53679) Select page 0 for single-page
 TPS53676
Thread-Topic: [PATCH v2 1/2] hwmon: (pmbus/tps53679) Select page 0 for
 single-page TPS53676
Thread-Index: AQHdRjavTlSbgZ54hkGN30hlXDTXUQ==
Date: Wed, 16 Sep 2026 23:54:17 +0000
Message-ID: <20260916235406.681131-2-sanman.pradhan@hpe.com>
References: <20260916235406.681131-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260916235406.681131-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW5PR84MB1428:EE_
x-ms-office365-filtering-correlation-id: 9114bb0b-d5a6-42bf-9ace-08df144dd1c0
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|6133799003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 74Rjf0dbVn3oggoByZJfTZjt/0/hkyY1bm6nV8yYzqT+/LJSRZzTM00sDLKrm6cu653CI+P1gDCKr/Px5orpm2xI0vGg25XWkt9rguXEF1B7mgMSbBL2EW1G1G9sT6yn1Mad70I8mxHl+VRLOXWKH4YrIMZUHd6vrg3R63wlMZTBgu5omBphRfoi2wtq3RkkTxpt/62/lR+E0XuCl95PTf/L/IBMtD6JEKUiDVMDU0+Xw+jr4z3mp39Tlfw55ANuY4X2EjPhw9pIay258J3O/i+OrgvcLekajb105kDM0YmUNJuF0IqUICy40SaqeO76uFMfd/I1rklVJ2Aqx3ng/+PtArQXatUi0aBRwFb7/KduiiZBGzb5YIRTE6UHcTSYv34ar8ZfzAqwmHLDVXFbB3wZUQalAsxRmzvd7TS6mSewekJsI/Eni3oSIclhMOSSxScV41C7VeqspZhYwG7QYMcBtc97t2R4pXcu9xgRoHR9RncgEJYEBR9pQW4A6TjEyhaAOOvZpBnlNyVaBiYnbO4LBCdyqJeea8OO7GKIQYkeZgkx5xu1DVlhbrlPMaVw8j5xaJezFtd+vZuBOgVVcVgq6TWMJCxo2rPqGzgSZRezTNMXNyEGAtwUhRUcEcQ3pQF9eOX66HzgSfxmlfYr/OTU+SgJYe86YiqalfnbYBS0Zy3N+7HAFE71cZIXNe120oPO5xNGaSdyl/A5iym5Wlhd3giwNFvHHRKbiT/bTgY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEMySDBUYlBzbytRU1p3MEhVcTVhTG0wVFRYOGgzYy9UT1ZLTVFjWUEybE9P?=
 =?utf-8?B?dW5wNC9WYlNabkJlSjBOeVIyTjdZVjhkaG5kVEgzd2xnU0NuNDNZSGE4Y3cy?=
 =?utf-8?B?Rk9KOC94V0RVODJvMWNuNXF0TFlEY21YUW9Eak5Oa0NXZGhXVnZhNGhRYWNH?=
 =?utf-8?B?YjUyRU43NHY3NXM2TEVvaUJ5dWg3am9rQmk1RnJxOWt3eHIxcC8zdGtUWkFa?=
 =?utf-8?B?QTd6VllrZ2JsdHZJSFROM3Z5ZXpKUXNwR096b2NrL0E0cWcxY0xSSTJIVUFR?=
 =?utf-8?B?Y0o5QytnNVlIMjBFRWt1ZVE3NktqUkpqeC9tTkNVK1NzT1laYmR1VXVDa05E?=
 =?utf-8?B?T3dEeTlQd0wzMmtTOUU3QkpPTnQ4N3RaNDNMWm5RTXF4NnQvMUxOT1RDZ0hj?=
 =?utf-8?B?UXA0N01sdjQzM3hSdEpHaDhTSnJHcTlYOVpRNDMxQjA3UDFmS0pJVXdlUDNr?=
 =?utf-8?B?TE9VWXJQb3kvUTlsZzRRM0VKU3RCQWx5Q1Bka0F3OXNheEs1Z0Z5bU1ZMVJ4?=
 =?utf-8?B?NVpLbklEcXVlZzNjWFJlNXVjR1oyRFVCWFAwUGJNT1N5UzVTTFQzSHR3enA3?=
 =?utf-8?B?UUsxU2RGdGtHeGE4MzZzTzFzYVRkUmZZaERqaWhBSTduVFdMSXlhTDZ0VXVr?=
 =?utf-8?B?TjhUb05mTW9UejRyc0daMjEyeHU0YkI5RnBWR0hZNXR5VTlYbHRwRk1hZFNJ?=
 =?utf-8?B?VjNmY2hRUzFSNnNxbmxYUnZGRnFkN2ovSHV3aExsQlVsbWUrQnpjaWwwUVd3?=
 =?utf-8?B?cmdsRWl2Mnc3YWc3OFZNaVZTeHdNZVZQTHpwLzBFZ20zSWp2T1NyeU8xTGow?=
 =?utf-8?B?Sit6OFNraXAreEhEOG1zdkMwbndjOHhzVExlcjRSQm9IVWppSmJRN0w0R3E2?=
 =?utf-8?B?aGZiZjZ6MG9XdFFrZ05xSHVZdXM5aFF5b3NHTzJyNjdUUDNEOHhCOGtSd3B0?=
 =?utf-8?B?eDZhYWtGZXViZkQ4Tm51SDBhWE9YQUlMSEVIbnkzOUJ3enFHL3laU25sMGo2?=
 =?utf-8?B?SkRyNHBGeUdwd3NZc0hoUDM4b2hFL0wydnNFNTFTNG4vMnBONWFFYXU1Mk5T?=
 =?utf-8?B?aW8yTUd0MnRiTnljVnl4ZmpyakZEcm1hdmN3KzA3QkpNTmlaeExkNWNXY2xJ?=
 =?utf-8?B?MnVmMzhZb1M3WXNZQmRqank4VUtZQkhtcHNpdFFZeGs4M2o0elZMSVp1T0hu?=
 =?utf-8?B?eDRIWkNLeHNielFWZmdOdERsN0JROFpRUWFsVWZQOFRBSGZzYVZMNGtEYzBp?=
 =?utf-8?B?eUVmenBpYys2a01USDV4TndqS3I0VFIvZlB2aWg5N1hYUnRwR0pkY0hlQjF3?=
 =?utf-8?B?OFZPd1o1QVFma1UyNmQwZ0FDRGdwVEhMazdLRjVybUFKNitxQitJbjAveUo2?=
 =?utf-8?B?N1JmUGVjNnpUQWdwMFFZKy9JVHl5RlFOanowbElVaU01WUpKRTEzNFVxSnM5?=
 =?utf-8?B?TTIrL0Q4bDdLd1N0cHZ0MVhHL29WTUZveThpckFyVTdBQnpNWUlIZzgrRzFN?=
 =?utf-8?B?akFOUmRGaDZpN2NDdnRxa2tNN05iRzFFaHVNYW9Nd2hwRCtJRm1yOGUreXBG?=
 =?utf-8?B?YW5tckVERTJ1WHBzSEpFY2txendWeWJ4Y3B6c2c4VTJsQ1VoVy9xRkIwTkpJ?=
 =?utf-8?B?MzRnOXR4Skh6YWhiOXdrZEczTitDSEt2REtEMUJNZUU4ZkQ2VFNmMU1OdFBw?=
 =?utf-8?B?b0RTS09MQmFqMkl4am51aFNIVWg1TkFsQzM3NTBRNitwWnhtaTdqd05Oa0lR?=
 =?utf-8?B?c0pZY3RvOTM5TkUyMTZxTmhTQWx3SmdrREk5TzAwSE1KYVlyajV3MmxHUXIz?=
 =?utf-8?B?UjNFN0hEMUs5dGdwdjQ0QmM4UC9ya1ZUS3IxRnNHY2JwZk9yTnFjNTk1czZW?=
 =?utf-8?B?dklCNmI5bm1OdFlIbEdZWThSbWRTUjAzSkNxdGlyckhyODF5UllRMWR5ZkpL?=
 =?utf-8?B?RnYxR3dtbCt5QjZTci9QSEN0LzhLU3dxejJScUtzSnJqQWNDZlQ3VDREZ05R?=
 =?utf-8?B?RTExSFBqcHJxZXhkS0pTQUlSRW9vNjViNy9wV1ErdHVIYUNxTXNzWEpHZ0ZY?=
 =?utf-8?B?WlJwWjlwNW1xMWxSMEFvRTY0bEVqRTJaQkEvQk81WmdVaWpPSFQrL2FXcFJw?=
 =?utf-8?B?ci9WR3ViUjFkcmppUWE4WWJiNzFYT0tFNXFsa1B1Q1huMG1MZXYvK1RpU09F?=
 =?utf-8?B?cnVYd3k0akZaclNWd1c4d2pCdTdLQ1BQTlVGWFh5allVVHczclIvdTAxWFBP?=
 =?utf-8?B?ZTdqaEdkVW9tcDhSNzA5VExPSHloajBmSiswOHRzUlpOR0FmUXgza0FTTzd3?=
 =?utf-8?B?WFNKbnRWbHpUcnUrZ0xTREtudmZsYjlsOE5LOE80SGFmNmFtWVRiUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aFwQ0mSi+zvKRf45NY6rVJAa9pYJFQz58F1QnNC+ihlor7F67WlK6osvUL2FK+p3mtJITeW+IBUUKchPo42CgDWWXAu22x1/ovYBWA6CPzwWbKk+UUqOg6fvN7//+DTN0JoKlLvTOm6LdjIFSQTiYZbwuV+6BDZdMMqcfQ+pkSn7ei1OvVPgmefJ5KRrRwTnZQJyu/RxH4ubbIDO98FXbapII13dN447Y/C/fPNick12tN0Xh+m5Ihsg4cFQhTSQwZLNxcRayU3J9wO89is34urQlV8YhvmS4H+jgvAh5pVCaZc9Tq4yoLy6Fd5o0uQcccWvuKp05sfGe2E5Ub+rhg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9114bb0b-d5a6-42bf-9ace-08df144dd1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 23:54:17.3419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzCq11zmCex4hOGvqXSFFTqK03wBKRl5kl8BiyyzNIdxNsLntg5U5aFv4x5/hDVrBdEtseLanmUvIRERWFaC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1428
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMzNCBTYWx0ZWRfX0krCTKxe6YYh
 MmXSmavKqm1afgFZdb9AN/fxNUh0Dz+52fgESJ90uwcxBV60Kz7akqhnrwezQuILTXDognvUIlt
 qdtkdlU1/0if/rtUMcLARgb9OVnt2KU=
X-Proofpoint-GUID: jBl4rxNmffTNbbi0Ic-fJV8BXuazrBf3
X-Proofpoint-ORIG-GUID: NHUe4nNWn3dwH1SK512VEJUn3yqIMN0G
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6aab2c33 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=eKh9dBiVBwyTP-iLVP4A:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMzNCBTYWx0ZWRfX/O2sKw39usE2
 j6Eh48/7NU1TPFJ4pO83CAyiB22yzx+94VpaieSoukx+BIzdCO0525pEl6r2zZujB8lrTCcexxS
 wccD8ps0p098JZAGaHYObGQA7dY7S/BtcyFqeydKf1M1ZEYJwh4VMdAr+OMd/w6t/AIukfbAoUv
 tyUL4uAdQNR5Un8MCoAGcVCz2YHXeZS8mEZ4WYW7hq6lfmFVoDgaq4cDRdz0hlVN5syL6tkE85B
 ZyguT/9Itqs91bKSZPn3aRdHyhH86W93K1RTYPOFbf4CernUrq0Tm9pOueiJ9ZgHbChcow0l0yb
 fmmAyUssjheg5jVkO/nEThDnpr9PX8dPiRhxTiPPbC8B55gUJqfY7QuGUUHSemrw6PAt22L9mt3
 TWgzdXrgh9ClA7DZHNB2C78zqKM6znGFkLuHURCtFntbC4Ux7S5AHFWNA2p15VQiD7Dbejihu0K
 uIxayAsgJX4M8nIKLyQ==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160334

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Cgp0cHM1MzY3Nl9pZGVu
dGlmeSgpIGRlcml2ZXMgdGhlIG51bWJlciBvZiBQTUJ1cyBwYWdlcyBidXQgZG9lcyBub3QKZW5z
dXJlIHRoYXQgcGFnZSAwIGlzIHNlbGVjdGVkIGZvciBzaW5nbGUtcGFnZSBjb25maWd1cmF0aW9u
cy4KcG1idXNfc2V0X3BhZ2UoKSBkb2VzIG5vdCB1cGRhdGUgdGhlIFBBR0UgcmVnaXN0ZXIgd2hl
biBpbmZvLT5wYWdlcyBpcwoxLCBzbyBpZiBib290IGZpcm13YXJlIGxlYXZlcyBQQUdFIHNldCB0
byBhbm90aGVyIHZhbHVlIHN1YnNlcXVlbnQKcmVnaXN0ZXIgYWNjZXNzZXMgbWF5IHRhcmdldCB0
aGUgd3JvbmcgcGFnZS4KCkZvciBzaW5nbGUtcGFnZSBkZXZpY2VzLCBzZWxlY3QgcGFnZSAwIGV4
cGxpY2l0bHkuCgpGaXhlczogY2IzZDM3YjU5MDEyICgiaHdtb246IChwbWJ1cy90cHM1MzY3OSkg
QWRkIHN1cHBvcnQgZm9yIFRJIFRQUzUzNjc2IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcK
U2lnbmVkLW9mZi1ieTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Ci0tLQog
ZHJpdmVycy9od21vbi9wbWJ1cy90cHM1MzY3OS5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL3BtYnVzL3Rw
czUzNjc5LmMgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMKaW5kZXggZGNkNDI1MGI2
NzlkLi40ZjkxYjBhNDNhZDAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vcG1idXMvdHBzNTM2
NzkuYworKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMKQEAgLTI0Niw2ICsyNDYs
MTUgQEAgc3RhdGljIGludCB0cHM1MzY3Nl9pZGVudGlmeShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xp
ZW50LAogCWlmIChwaGFzZXNfYiA+IDApIHsKIAkJaW5mby0+cGFnZXMgPSAyOwogCQlpbmZvLT5w
aGFzZXNbMV0gPSBwaGFzZXNfYjsKKwl9IGVsc2UgeworCQkvKgorCQkgKiBwbWJ1c19zZXRfcGFn
ZSgpIGRvZXMgbm90IHVwZGF0ZSB0aGUgUEFHRSByZWdpc3RlciBvbgorCQkgKiBzaW5nbGUtcGFn
ZSBkZXZpY2VzLCBzbyBzZWxlY3QgcGFnZSAwIGV4cGxpY2l0bHkgaW4gY2FzZQorCQkgKiB0aGUg
Ym9vdCBmaXJtd2FyZSBsZWZ0IHRoZSBkZXZpY2Ugb24gYW5vdGhlciBwYWdlLgorCQkgKi8KKwkJ
cmV0ID0gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShjbGllbnQsIFBNQlVTX1BBR0UsIDApOwor
CQlpZiAocmV0IDwgMCkKKwkJCXJldHVybiByZXQ7CiAJfQogCiAJcmV0dXJuIDA7Ci0tIAoyLjM0
LjEKCg==
