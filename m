Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79C45D5E4;
	Wed, 16 Sep 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589085; cv=fail; b=FlB4LsiZgYbEFt+twmDmpRrZRiAaIyXg6GVCXha572fpBavTgHvo1yDZ+VxPTNR/Tjavs0iKnIuiF1p4MKU22q96YloPUjhiBbdj7elFNK9xP+kJMNpuefY76SK065IjOVrMTKd1zeQ2CNOvH7HGI4s8RW0z4VqOkWB7B0P4kPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589085; c=relaxed/simple;
	bh=r1cRCZ/NIktwqxp4fuVkPNXSBdIYfiCddMVvq64PXcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YZSIGdfZLUvin+sYN8S4+ROvdwi/DAB5feFN89vY0S4uqOGRl8b8wxf3P2H6qy440gMFJXFfhTEe96o/uTsBpNnozXSiC90Pr+3XcSiQ9QoJfcyR6hWDKj7mGs6aUwJQcv320KqLWAECfEHQ9ilbssEIRGPpPWfXSzD7N59WDwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=nfpS3JSE; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="nfpS3JSE"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFfb8o1754525;
	Wed, 16 Sep 2026 20:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=r1
	cRCZ/NIktwqxp4fuVkPNXSBdIYfiCddMVvq64PXcA=; b=nfpS3JSEL+x5H0HqG7
	pB+WYHpf9lutn2Y2FHgXvwwcPNa3uCZXsDAgIq6jGsXy4qjs0k4gBbe4rt0Wqsq1
	6N7E/3m4e3qJVAGNolX/0cBiGtbFkWAwLqiz9ilNOyx4niPqaOOuc0WynuutoW2f
	lyK2wIMf04cjf5kstjjpToYQfWpqesrbx6hghZwtnwKLKaxU6lMnl+pM3uHaY40f
	j+KP5oanWJtFqJFg0TL9lGad04PSZ6A0YbSXbZK+bXZ+Ocp8QoNcxgpqnzmpuBsY
	N2S9KKf91Udn0HWrxfYxqdpg8Rahl0qP0znkv0qO4COngWNmkaC8GxMF+H4x2Ycz
	TYEQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gqwtp3sdn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 20:04:11 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 93BDBD2ED;
	Wed, 16 Sep 2026 20:04:10 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 08:04:09 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 08:04:09 -1200
Received: from BL2PR08CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 08:04:08 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L37fh29sISwE2jhXqrpBR7m3uL4T/VQAkjm4X7IpAC3YgBbHIpqQnIogJg3NAEe7tryjRO0fDO163qLbvA5Gs0V96/vpfIuUlF2owSbPri8YM22ZNuWjEjt7OA6rle20SxsaUnZ0US7eG26/DwTrjMI0Vx3kYRxVegSSsbcm1bNV7R4W2KpnWQoc4QIFEMZMnBy3xWxBnYr2uCtOA4J12olYMvcNMA4Drt7ZbnWguRDjYW4Z29HcrLaUwxgxXhgzBJLtKWoVTYv/ZJlIE2SRklmGomfOU3QPUuGNXDGcF5Kd42uDLZexr8lfRo9oIBiVw6v0fockTOOe9IUAWYSGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1cRCZ/NIktwqxp4fuVkPNXSBdIYfiCddMVvq64PXcA=;
 b=VAMMOmH7/2UQmsnMga6iNj0i94Xnz4JIm/VioY8mQVQS/+9KAPsJnRluLUxw+6zB9SHW7aQyo8B7RWItZF+QwoI/d08pNCgohQ2EyYwyqZpml09W2yjnZmQWObsRyimXKyqB++apENYdoW/BtqWQ37lbQnM1eknv5rM4BNYYHrEboYmztXHote+VjTlAWdSsx2HNnctQEPrZHRG6Jk9RnrUQjZ6dDlggSrTK3oF++gK2Za/bIl34+Zw3YECON67YdAR9O064HXEfQ741Pmq77tS7X7ALPu8L8B6xOJzWBmJRpPWOoQtw/sWt6uSnk1HX3Bu4nOrBs8HgpgHJO+ujLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by PH7PR84MB3763.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 20:04:07 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 20:04:07 +0000
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
Subject: [PATCH 1/2] hwmon: (pmbus/tps53679) Select page 0 for single-page
 TPS53676
Thread-Topic: [PATCH 1/2] hwmon: (pmbus/tps53679) Select page 0 for
 single-page TPS53676
Thread-Index: AQHdRhaHbswEx7nqh0iFEPfe68X9Eg==
Date: Wed, 16 Sep 2026 20:04:06 +0000
Message-ID: <20260916200331.664795-2-sanman.pradhan@hpe.com>
References: <20260916200331.664795-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260916200331.664795-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|PH7PR84MB3763:EE_
x-ms-office365-filtering-correlation-id: b7a3bf43-7ff1-4eff-9287-08df142daa16
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: d230xyP0fwIXUwVqDfyQXK9/3RxPl4Xxkgoin7FEHDo8EhB+KQtQ2ByBJgQh8y4kcb+lIou1ECRqdM1SzsOly2Ll10+ngmz6KWl/kgX5AtD1gP2i02uUNYSUJhqkt8W7nUfJ6EYXnuM7AkbQdVoutkq81NE9bRZ/nm1WF0hRjIFGKG8AdXve0n+FnMknSLwymvyvq1VwORdzKGohAx6c7SOpiAjaUO0Z8I77P9vMSJHUJFsO+mTcENb1lmj9Vl0fWVy3YFvJRaB5uBXzYaMHXrDLsBde1B0UIyr0Eyt00fxMhqklwZea4Zee2MwI3Kr0Aac7wh3DbpRXjv7DS4bc73dbznlm2TR08dYWn1HCoq2kR3hK7twdC/uZY9ID2Wt+FrZxskjYv9dMBNqXUtQU/fOBsf6MQ3PkFZ9HPrTzZfaqruJynpbiKv4yH3FamxQvlVbSw5N+6wNrXoqzyRVditwHLB/z2BJ2mDxtzp94Wgc3iQzgiDN+4izvdfq9g3dFJ8jUllk0l33MlBG1hDY7L49IyRQfeUtk+EEnPUnjnW0t0t1Fn6y7S1nj6ZFc/yooS89c3ZzqVjJjIyEukqjWH++5gMMalZ1SIB/R8pIl0oc+UyDJL13vlwVQLppY/288lCVxLphR8e6AOhjQ4O3tZ7dI0tlVfeFOAhgCzBHjg2VaUBiXdPVTLlMdM9RO6O8h98KO9ToVPqoPbJVJFMOirbkEoGWyUZwaOxdxAjBvdis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2cwQmZmNEVqMDFBLzM5Y1dIVVZsYjZTTVBRMDhsczd6RTl6TC9KZGQ5NkM1?=
 =?utf-8?B?Z0pZYjM3b051UHZCTk5QckFCZWF5M2FaL0tsZ2p5aFI0bktraUVsRCt1azZy?=
 =?utf-8?B?UmVieEo5MTBDLzR5U3BKWFJqR0I2RDhZL3JlU0pVT2dldDFlaVJUT2xWNFJa?=
 =?utf-8?B?T1ljaVcrbVY4bXFKOUlOaFlFV2RTcXZ6cE9BTCt3aFdac0c3NXpicVdFV2Nr?=
 =?utf-8?B?QWtyNCtGWVFFZjNEaVlKblBPam4xQ2pUVlRhUnZ0QnBFSnZJaXYvcjRyaGg2?=
 =?utf-8?B?WmZmMlY3dS9DQWxXc2NHMG44ak5COFZ1OUZzeXVMSm95UE8wNTE2US9TNzFD?=
 =?utf-8?B?VC81bm5xc3M3eURXSWoxeHVLYmdmRzJPSHczK1IwTVhqNVBFRG4wTDc1V1Yw?=
 =?utf-8?B?aGFPbEJPeDh1K1U4QUhFbVRLWW11QVVkTW9lWk14OEEyMkhtaXFrby83emty?=
 =?utf-8?B?cnoyZlA5bHROZEJhTXpCMFYrZE1EQlBwZGxYZTliNzRwQVRwSHhtdWdYWjdG?=
 =?utf-8?B?cWpEbXJrd2lpZXFPbFBFbjQyY0JvQXYreTdUV0o2Zy9ScHZ0QkhHWHBRUnlQ?=
 =?utf-8?B?R0cyZm52Y0tBdUFEUXZoTHNPNVZsZEpWUGpzb05WdHhpZUNiZTJTR0JldU9M?=
 =?utf-8?B?ZDVxVnJwS3F0ZHdwaXFwaTFwSUJMeFJ5cGQwNDNYNEE2YlpPckdDcjkrUWJK?=
 =?utf-8?B?NmlOenlCejVTYjR1cXNrei9hbTJhTEVFK2UvamNFbkVtTWFxYlBBbFdzdWpl?=
 =?utf-8?B?NUUzYTJ5TXdTeUxSOW1yTmhzV1U1bWZ0cytySWUwVnBlWlczZUNTcnRTRGcz?=
 =?utf-8?B?Z25WNDB4c2NTOUJRNW9zdVdkdUJLdlBCalJXWXRnMXhLb0hqeHFCRDA0RkhN?=
 =?utf-8?B?RXI3Mm51aTZqNGF5dTZ5czgxK3AyRmprQmxhSnRaWEtuWVJzUmJtb1g4Q1Bh?=
 =?utf-8?B?VkQ1M1Y5dkZVZkZIbmtZbXI3Y3hucmtCSWRVY3dkVWo4SzdZUFE1UWNJK0xE?=
 =?utf-8?B?bmZpZUx0bkthNjA4cG11aEowV1B3MERqcnhEQjd2MlZnNVQ1TTk3NHNiSFBs?=
 =?utf-8?B?bXlRdnJSVUVWVVkyZWRvSVVhVFJsT3NFL0lwU1FtbE9mTFFiM2htQ2RETlBR?=
 =?utf-8?B?c3UybmpCZGNEK0RhbGlsRmMzVG5naHhIWU85MzZVcjNtMHBEendXdE05Wkdh?=
 =?utf-8?B?TUxtK0w0bEFaY3BxaDVGdWNVTkJhc2JiRkZ4VTUwM2YzUXJSdStJeTRQcmRh?=
 =?utf-8?B?WitXVGtLcnBxUHZoM3dsOXJSVFp3QWNQaGp2NlBwbVIvb2xjVHRybmJoaDNO?=
 =?utf-8?B?bmhSTHhUYURKdW1KTzdrTG9peVVpeVZKek5jZHd5WmVrbDdJa0dHS01SYWhi?=
 =?utf-8?B?UWNpZnFYSG5iZy83NE5jVUpGUFhzVkcrOXZTTXBpOE9mTXVsdzFHZ0UyOHlz?=
 =?utf-8?B?QVBMZHQxRVBuNTdjbnJXdHprVUdmUnhKdmpkRHhtOWlmbktsenVmTjVsOW9z?=
 =?utf-8?B?Q09sOG5hT0tQNnk1K3FBZGRjaFpLVG92T0hkSFBhek91SlpVbzMwVmFkWlJl?=
 =?utf-8?B?ekVRK3BrUTRSTFRsWERXSjNNak4wQkhXb21SN2hRQ3NJVU5yKys5L1RMQ2dq?=
 =?utf-8?B?eWlDTVBzaVduZE9odndhbkp3U0NhUC9oYlNNNUg5dUx6ZS9yV0Rycko2Mk0z?=
 =?utf-8?B?M1JuekR2MkVveWlVR25kVWtmWmJSdXMxMnN0angrMkRORDBNc1VXY2JrQ0Nw?=
 =?utf-8?B?M213ZENKVTU4bUFmeXhwZEdWYzJYTHNkZlU1YXZSM0dlN1Y2a1hHdVRiY2pt?=
 =?utf-8?B?OTM1L3UwTEhQNi96a0Vvb1loN1A1TjlaWFFaQTdxc0UyY0VjZ1RLVUo4YldK?=
 =?utf-8?B?bDNWTmZPelpsVGRYbmlCSFRPekdEZDQxMTZTV2pwd2pVZC8rcjFGUEpEakNV?=
 =?utf-8?B?Um5TdkgzdFVTbkxneUJldVBtWGFVUys1L2ludE5RSWtyL05aOFFtUCtMbzM3?=
 =?utf-8?B?OWJNZ3d0bzUxK2JYRnNqSzhRZzRuQXR5Qkc4K05mazFyNE5oMlRrWmt4clA4?=
 =?utf-8?B?cWxQM1VFZzZzdllZRThrSHpadGI3c0I0ZW5LL2d4ZUdDSzFjUTlpWlF2Ull6?=
 =?utf-8?B?S0RHdWpwMEZEY2pMalpqVDVaUStwZWlaUmRGUVFaU0JqRE5ZbFg3TUsxazNn?=
 =?utf-8?B?NGJqdGxFaG9LYWpZYy83Mlo3RXFHVUFQbi9xWjM2WkE3UWQrb01BMVF2ZlRN?=
 =?utf-8?B?NkFTd2xIVWFpL2ZHZ1RaT09KWXVEd2VtRi9vTk1GT2tKcExlVWd4Ky9LMXRS?=
 =?utf-8?B?RFhkME9palVnVXhzQUczd2RyU25VZ1hmVnBLdGxucXpzRVdlU2gzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4sw2LCZwZNfifoGlT2eTKcBJhNSLt6+L0rkMB/YXnXPOs7HN6t0/9EYQh111VFx9krJxGl4k8lWw1VetpFgDGHd4B+DQBBasp5Ht0ffedyba228+x7de+cCtH43ciNEu9RyvZ8RxY/R0DkMrIW6nvK87YGUXTUhRKdofz6lSIfU7sKrU+Pd9PD8RGNe7zWz+xg+NSPHPr+FfL0Y/h7l5Dh+3chbxtBv6kgf11dtIp1GaQZ+VY8GIvZvoGXPaHKNyzlU6bLRqaToDr/83D7wbvKMF1nTw2f9b55lIehK44wW+4cm5OasLL9mdP/967y2sIUscVg3f1ShIGU8SrltcXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a3bf43-7ff1-4eff-9287-08df142daa16
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 20:04:06.9127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8n5ujT/fTndUage7OPiMyXllWXFxI3wA2ow5UrZZ9Bq6cUKtMAo5XJwRAAEAeavPTT2AldXISHD1Ma++a3e4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3763
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI3NyBTYWx0ZWRfX7JC1/NJGC62T
 ZoQZoxMQNrHya0zbXWctupUHbVC75dbeP+gzx18DwmVZ6Q9tOz/jt2GDRhJnrfcWnmiRu7eeqBK
 SVNsyoQknC2OPz10YYb8mg8e/RlVpn99UTFwFppbZoOCPLP1KpDRiaRF6ojGm4N4zUF/ooE6PP5
 PsdJtSHKFGOMaoi98uO/eRbwP04vrvghnc54sF6NLqQ54RcXnbNonZ/cuwofOfxbmOmM7K+3hiP
 OEvmwTTM6IoSIvy/BBrkLGPT65cNxKTvyO2UWuaZMcaI3DMtP/wwXLVjsjLAZm9tN9eXCeOMn/y
 3UZHTKOkLIdx8GRDukQlxnrRXMI5M7zwRfUeF/RbZ4rGu2RT1og9qSLMfk9mYNrKsQXFq+tAHh9
 X72Ubb64158MvWRHESqQYbf5ge3G6+OqNygo7HIQPDn+7fi0E5uUEdt+lcEPFUkHby53MvM6UR9
 oXquWsTP6swK2CQzpIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI3NyBTYWx0ZWRfXxkRofeecV5ts
 LVg/8R8uQVNQSMmc1MUJH9oudQCnk38h7lI96lE+64gRvw7AwYSLFdK86AAAM9cWUaRD/VfX1TJ
 TUbyE5P/2lQn3nt0SlRjxUe3E0lHe3c=
X-Authority-Analysis: v=2.4 cv=D9HSufRj c=1 sm=1 tr=0 ts=6aaaf63b cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=NpaDjho0xlP3Wk9DByEA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: uNvKphubkWw3sFMoXavx4e7J5OQVQKqi
X-Proofpoint-ORIG-GUID: h4-PYC0kDQDl1m9p1ftd7ZZW9iknEZ8N
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160277

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Cgp0cHM1MzY3Nl9pZGVu
dGlmeSgpIGRlcml2ZXMgdGhlIG51bWJlciBvZiBQTUJ1cyBwYWdlcyBidXQgZG9lcyBub3QKZW5z
dXJlIHRoYXQgcGFnZSAwIGlzIHNlbGVjdGVkIGZvciBzaW5nbGUtcGFnZSBjb25maWd1cmF0aW9u
cy4KcG1idXNfc2V0X3BhZ2UoKSBkb2VzIG5vdCB1cGRhdGUgdGhlIFBBR0UgcmVnaXN0ZXIgd2hl
biBpbmZvLT5wYWdlcyBpcwoxLCBzbyBpZiBib290IGZpcm13YXJlIGxlYXZlcyBQQUdFIHNldCB0
byBhbm90aGVyIHZhbHVlIHN1YnNlcXVlbnQKcmVnaXN0ZXIgYWNjZXNzZXMgbWF5IHRhcmdldCB0
aGUgd3JvbmcgcGFnZS4KCkZvciBzaW5nbGUtcGFnZSBkZXZpY2VzLCBzZWxlY3QgcGFnZSAwIGV4
cGxpY2l0bHkgYW5kIHZlcmlmeSB0aGF0IHRoZQpQQUdFIHJlZ2lzdGVyIHdhcyB1cGRhdGVkLgoK
Rml4ZXM6IGNiM2QzN2I1OTAxMiAoImh3bW9uOiAocG1idXMvdHBzNTM2NzkpIEFkZCBzdXBwb3J0
IGZvciBUSSBUUFM1MzY3NiIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYt
Ynk6IFNhbm1hbiBQcmFkaGFuIDxwc2FubWFuQGp1bmlwZXIubmV0PgotLS0KIGRyaXZlcnMvaHdt
b24vcG1idXMvdHBzNTM2NzkuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL3Bt
YnVzL3RwczUzNjc5LmMgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMKaW5kZXggZGNk
NDI1MGI2NzlkLi5mMzhjMTliOGNjNDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vcG1idXMv
dHBzNTM2NzkuYworKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMKQEAgLTI0OCw2
ICsyNDgsMzAgQEAgc3RhdGljIGludCB0cHM1MzY3Nl9pZGVudGlmeShzdHJ1Y3QgaTJjX2NsaWVu
dCAqY2xpZW50LAogCQlpbmZvLT5waGFzZXNbMV0gPSBwaGFzZXNfYjsKIAl9CiAKKwkvKgorCSAq
IHBtYnVzX3NldF9wYWdlKCkgZG9lcyBub3QgdXBkYXRlIHRoZSBQQUdFIHJlZ2lzdGVyIG9uIHNp
bmdsZS1wYWdlCisJICogZGV2aWNlcywgc28gc2VsZWN0IHBhZ2UgMCBleHBsaWNpdGx5IGFuZCB2
ZXJpZnkgaXQgaW4gY2FzZSB0aGUKKwkgKiBib290IGZpcm13YXJlIGxlZnQgdGhlIGRldmljZSBv
biBhbm90aGVyIHBhZ2UuCisJICovCisJaWYgKGluZm8tPnBhZ2VzID09IDEpIHsKKwkJcmV0ID0g
aTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwgUE1CVVNfUEFHRSk7CisJCWlmIChyZXQg
PCAwKQorCQkJcmV0dXJuIHJldDsKKwkJaWYgKHJldCAhPSAwKSB7CisJCQlyZXQgPSBpMmNfc21i
dXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWVudCwgUE1CVVNfUEFHRSwgMCk7CisJCQlpZiAocmV0IDwg
MCkKKwkJCQlyZXR1cm4gcmV0OworCQkJcmV0ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNs
aWVudCwgUE1CVVNfUEFHRSk7CisJCQlpZiAocmV0IDwgMCkKKwkJCQlyZXR1cm4gcmV0OworCQkJ
aWYgKHJldCAhPSAwKSB7CisJCQkJZGV2X2VycigmY2xpZW50LT5kZXYsCisJCQkJCSJmYWlsZWQg
dG8gc2VsZWN0IHBhZ2UgMFxuIik7CisJCQkJcmV0dXJuIC1FSU87CisJCQl9CisJCX0KKwl9CisK
IAlyZXR1cm4gMDsKIH0KIAotLSAKMi4zNC4xCgo=
