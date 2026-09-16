Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14673456DEF;
	Wed, 16 Sep 2026 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589114; cv=fail; b=UPf62qzfkEeoW8LwuFL/gi0B/PIAR59OckwPNntSryH6q8emv82tZWM02+L/npUN8njOQOmRtVjwFpKFkgwjeKQXAL1gfLNbVqFXVubYBqU2xarph1hoovFZKnWxjtuUDgt74lSbh03vnx5OhqywEugqKCylXb8hRN0VysJnS8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589114; c=relaxed/simple;
	bh=5VAuJHLjhJT/VS478HDJEpxcx5U9rmmS074wws+cLPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D/8Si5vfRPO9EKfhxITFjQ80RKJRYf6S6OFTiq2D+PakUnkWXLynwC1s5YLBsVaZd4xbvC2Lkk/Jt/p2bK1LqA0kX7Vi8v/7OHls5JcFoFaohOJwuIvplVwKBWuUqHm0DzaSwrHurC+9Senr1lNyNnBrp+F6nYDHyLKXUG3CMpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Ij0HtYfU; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Ij0HtYfU"
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GJWFGM2638798;
	Wed, 16 Sep 2026 20:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=5V
	AuJHLjhJT/VS478HDJEpxcx5U9rmmS074wws+cLPU=; b=Ij0HtYfUBp7DbA23Js
	n3q1zSEJ9Otp1i9lJt4keHw+jIsocLnld8ggINRbAj4EcSTLre2oKKwTIve0Wy4w
	7MOZDAtCKEvbS6GqwcD4Zn5/qynYhAFImO6+GdehUYTQEvbQlbKEztEk1ZI6heHo
	Fy1gyorHIYrO/rhcH3o+beaU5AERHryohBfCiRqEZtmjZ2qU1GzKQtnbLb6Ltg3h
	VXj4V+SrVQj9p5E94WaQbrvAM7uVYQ25uGQpMg1m7//kRppOSUwOnFGXWfwMmfxM
	O0rnprqZypAElzh2e03HSB5+eu4Chnl14TYHvZc14LDcfp1Bwn4a86vjzea/kC3P
	dBRA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gqw7g4h6e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 20:04:36 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C4ACF806B29;
	Wed, 16 Sep 2026 20:04:35 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 08:04:13 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 08:04:13 -1200
Received: from BL2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 08:04:13 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCf7yh0Z4sCaG1ED3uPXh9hvCq4H+ZVgnkweHnqOzgO4sVOgv/NwQJFQtgWq5980uGsCqRG9gkktI2eFsLw0572ufv8n6K6Ox91+dDSuoM8eEcstccLpu6r4o+XG1OmRPkENJZ2mzgP28GQi0ALXr+dV0Yvt0GrRnxYWGVRJHQQF6WXn804qa2uudUn1SzAPqWnzRlDuVQblmEtjsYyUIerVdDpy0zcHWQyfF4I0XGqtxlvB4qHL1vNF+Gxe3BNp5L4NG97PwNxmzr4bcppGtORDKdUO62GWvx8YiY/xqNoLjxPjsNe+g0vNwtSWvFgVpbAl/mljLvZPggkGouJH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VAuJHLjhJT/VS478HDJEpxcx5U9rmmS074wws+cLPU=;
 b=Swvllacp63WVWGvWdOh6hOUTejEgkSuf0vS56JlMfL7Zfhe5YJebQZR6lOdbya1AAc+LZ1hx7kHMRmRqdex1GiyXhLDIC5kwpZ3Sv3uIMdp3dy4kXPdjTtCgYxeb3FUjqnrbPogCvdYzbJ+GdqT966tOXwcckYEKGFvP7nvWAXUpVf+kS0+82z52OrUwlTSq6Vf0tWKqE7DD24H5O/VxmdQf4nBrsKz7An1g6BeHaon9/P3UbNUxkFbKAE0y36WDXK88b6/u89xdjTuLWRb9KNq6SJFTZEBU0v3Vcq2UATDsbNbVEOoOqhEWOOzz+W9qijnNuEQcZuO9+fO19lHrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by PH7PR84MB3763.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 20:04:11 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 20:04:11 +0000
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
Subject: [PATCH 2/2] hwmon: (pmbus/tps53679) Select page 0 for single-page
 TPS536C7
Thread-Topic: [PATCH 2/2] hwmon: (pmbus/tps53679) Select page 0 for
 single-page TPS536C7
Thread-Index: AQHdRhaKDVfVTb4sFku9gEP2cw8r4g==
Date: Wed, 16 Sep 2026 20:04:11 +0000
Message-ID: <20260916200331.664795-3-sanman.pradhan@hpe.com>
References: <20260916200331.664795-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260916200331.664795-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|PH7PR84MB3763:EE_
x-ms-office365-filtering-correlation-id: e27146f9-3b9e-4bb2-8b19-08df142dacae
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|18002099003|22082099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: yMTOK4f6od8johfDfPp70yiclMxNVgHqSuOHkeCzAB1C4OnSb1LH05eSGzdXHIzQvJe8hwZHU+c+3dt3JimlR+e62hhH6oEjNtZK0pHx4crfCgNUbRZVA4YBaBUtCs/AFCUbsZKosUblds6qDdJmwHi3gokGVmPp8V/kid+UKzwoLTb+0ibIkV82aMaduW8QAHej44AcNafOQdAFn2fORNK4bW4+wPUVc1WVGlk+CUgQ8yRJodrJRFM1ysbvg0s0eCP9mOI/0jIA2Oox7mFHvZ6eIAplBm4xR/gRp4L/ZGOxPKeU8qJbV8qt1zIixwNzcXfWkvzqUNHNSZ49i4BMwSTKgxQurt/Y+f3wQ1mkLqyQceMOlGRLn0pRoQY8uaEHKkq7vNPfdwKasm18JHXxWj28Ssi4J5n0E+naLbGrCXtCu0mjQoWdxLVBp5T/JevOlT5grnBWq0uio3op8p5DgP4WJYIzgfBulMLUismxhYlBzC4t0jsoJfvk6MPFlwKAeWJ30GxQkorPtJYlM2DlppMfzy+Q4sZFceOfuRE4WQygZejhEXUBXSH2S+nlQmDCXa7GI6Y1M5zRMlb9RK6NtXFEvHCTjQf9gj5ElfZYH57qN01WWBq1OOCMGFGcccP7j+8toZtJph0CgVk1sZx4Ep4o36I2Uaa3fXlhiy5W1w7RQWb6Sj0dB8W6KzHY93oV6gl1Q+rC91bF3WXfv+1Zv8gj822LD5gYFAoCCVd4jEc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVIdHZwOStBbWpGRzZiM0d5Y3QrMUdITzhmVmRjU05Cc1p4VkFMczBlRng1?=
 =?utf-8?B?dHg3b3YwRVNZN1lNN0ZkRkFrRHFRWnR6VkthZEZlRVNlc1BTSjlUa3p4ZXJB?=
 =?utf-8?B?aTBJSmlCcm42T2g2NUFvNXJhbFl0S1ZyYzhDb3ZQR3pvMEJBcGlrWmkyckxj?=
 =?utf-8?B?ZnlQbWkrWUEySjdFeWg3MEcxY1FZMGVVbjJFZDdOMWdPMzEzUUFvem5Scjh4?=
 =?utf-8?B?RFJkNzB5d3g0bWlNVXMzRFNtU0hXcUlhN1J5ZUVxZURYUlpjcTVwKzkwRXN6?=
 =?utf-8?B?N2MvdUswZi9wZkgwSWxacVlqQUJoSDMyOHFDaEpHbEZqK1E0WmRtMHR5RVl3?=
 =?utf-8?B?SkFkU09mZmRiRGtPZHpOelc5ZFVTMHJTelNwVk54UVBPVGg1bmtTYmZUa0Nq?=
 =?utf-8?B?KzJqNnFyQitNRTVHOFBMZC9hSXFaYTgxNXB1R2Jaa2xmeS9VVFRsUk1hdE45?=
 =?utf-8?B?S251YzlCVDE2VnpLKzhxWUtObHNYRG9BRDdRVVdZYThCbURmdFc0OHRVMkdP?=
 =?utf-8?B?b3U0YmFQVUw1dVdZaVdXRzRkNFAwK2dTcmVLWkFtdGxBU0MybEVCNS92RldY?=
 =?utf-8?B?eTBBWlI3VUVoTHJNcExET2VibHlBV2IzWXFpTzdFY1k0Q3ExYkVyb00yaXp0?=
 =?utf-8?B?YmVLdXdBc29aMzl4dHV4N3ZUZjRYa3MrbDZIc0kzSDhlTk9DK3BoY1ZqMkRv?=
 =?utf-8?B?WDBrZ2Vwa1FJbW9iR3lmUW1VRVNUazJhSjdYdHhhV2IxN09uN0FJMmo1ZzNT?=
 =?utf-8?B?b3NUZ0o4ajFTL2tzUEpLRjVYZmZYVU8yWitlOXozTDJ4bXdFVHdBYktYa3Yx?=
 =?utf-8?B?dXJpNkVFN1NJUkwraGkyVm1lTnlrOUpHTk5lVGt3dnJ0ZWV0QmUyWWtDVkNE?=
 =?utf-8?B?ZnNYR3RFaWdDTmZ0N3BOcERCd2pWeVpncEVOVUwrOE5JQXp1aHdocFI2bzRQ?=
 =?utf-8?B?bENBaUp2UGZodWx2bHBCc251OWZkVFJ0Tmg5eUFHUW0vd25keG56NSs1dTJO?=
 =?utf-8?B?eGkvTXNqSFN1V2VLRFYxUEJ2NmlmVWVZcTJXUUlUb2VpT2RwMFlmTDJMTTFL?=
 =?utf-8?B?QTVYOStmWEs3aFI5MTVwRXpHZW9xaFMyQ3l1WHdraSs5R3l4WEFKV0NNdHB2?=
 =?utf-8?B?WE1sblVQSFY3RUtiNzNxa3loSm1KOHJNYWlJUXUvVmpnLzkvaGNrVm11aTd6?=
 =?utf-8?B?UUxiY3BIc1R5M3NJcVZ1NnJhM0FjczlzVmNjTXoxcDVxWkd6QnJFWTByRjFJ?=
 =?utf-8?B?dEIrbkk3ODJKdnNiMlEwRXRDcWhLdUNnSmp4QXZwZTNYYlZETWc5NG1ZSnZF?=
 =?utf-8?B?YVVVT2pwclRqSHhpdFlIbUdqSStiRFNhazZia0JiRmZ1enNSNE53dHdpZzlD?=
 =?utf-8?B?Vm55NnNCbnVld25oK3pVNEtFOXJQMnoyTUZyRzhpLzN6VEdrRDZ5Mm93VGtp?=
 =?utf-8?B?eDdBOWJ4dWxHK0w1aU81VVZwMEJ5a1l5UUdmc3h1cEl4bm1pUkh4REw4Mkl5?=
 =?utf-8?B?eXhQODUvbHFpUVBtN1RMSzl1RlM3em94RnZDNFJsU2NRM1NrbGRoeVVzTWMw?=
 =?utf-8?B?VFBDejJoOUw1Q2dtRmhFSEdZMGRsVFpLamVtc0RxMWZaSjZTMXB2SEIrRkph?=
 =?utf-8?B?b0VXbWV3Sys0L0N5SUQrcFdTeGRqOW5rS3E1cGFTd1BWWXFFamd0OGdNcmFw?=
 =?utf-8?B?UlBVd1hDcDlrV25EbU5OWUFVblFndkdUbE1FU0M5M0haZVNFL2E2blZHeXdy?=
 =?utf-8?B?d3pYMTI1SkhPQkxWeEtuUk1lVkx6SjhmTFF0d01jV3JMcGJhVDEyaXZQM1B4?=
 =?utf-8?B?a1BFSy9STGNENEVqMzZ1ZG5hMGZJemRjdklKdFRpSm9CM2pHSVZJb2lBVW9K?=
 =?utf-8?B?KzhYRGpSSnQ5aHFDcHh6UDFad0lESTRWc0NxaEhHZmQ3bUJ4S2pnR0F3dHZJ?=
 =?utf-8?B?aU9BK09DYnFodjZxaWE0OU8weGtObmZyRjJBWEJwTWZ1aHNEYUdzTVNIZHl3?=
 =?utf-8?B?U3ArUDNCNlB4dE9Mbll6RlJPeFhNOFdDQWdNR016bUhZMFRIWTd5SW1HNzBy?=
 =?utf-8?B?aGlnWHhtbmUxSzErcjkvRlN0YUJDR3IzdVZrMFI5Yy91Z0oxUjJpRkFLay9p?=
 =?utf-8?B?RTNGZ3RpdWIyNkFzT3ZJUXB1ZVArOS9pZWFRT3pPdlhnMi90eFN2U0ErT1Np?=
 =?utf-8?B?TWZXeUJzeWErMVpudi92d3M1M2FteDQvR2t0K3pBSG4rbjRNSlFrRnMzNVAy?=
 =?utf-8?B?Zmh1YzBTQ0FJVnFyRDNnd3cxN0RFV1N3S1FSMzhhckZjcWFWSnhKZzhjZlFB?=
 =?utf-8?B?Ry91QUhmUlZIbkQxV1l4YmloZTJBakdPMk5peVlMci9CZWxxQ2NFdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sdRpknxVb9rY1CaLuRVIGjEUvqt3ksvDjIMEOwwswVDV1X8VtbvJQP3wLn3EZLdmdxRdgkSVggdotFCXRcpSMorblqsJjNod16wEhGzCXAPCuvRPPky5tEMIG2XTko6rUfPwaKn8KTSJIDSav4Gak7H1GQnIinkMkZlKrA3yxJa3yAzahNrcf0KUR6RJJla7CHvUZUYCyO9wxvkUcZ53FfedxbLTBmExLCr8xs5K/2hzqaGG2eBCCfwk7MBADEl+MKUY6gmCCt0WgcSQtPZYE0+DkWSc8B5GuNFYnpLm6ljJG9wHdNuMZT+U7JjKnvDG7Hop+/atK4yXO9UtIWiQZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e27146f9-3b9e-4bb2-8b19-08df142dacae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 20:04:11.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4naOrMwZ35sT/EaQVsszsyTls4NOJLK0Kp4qjTgTdrtJhivilNFmwEaePnkhO0ITBqAAqWLKQjz+6uP/3hooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3763
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: gKWjriEQzBQRaHm8ISVQc1zKRaiLkIVZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI3NyBTYWx0ZWRfXyo7kkoqNZgUc
 a/+UI9ZPhZaySOD9i+E0QA25fdrEeMYRkWtNb7B448OKhp3LhB5RKfVeMUw3v0GdYp6UWuA/tSu
 EZG5vl6AkLd9Y6DNiP3N2WpO1gGHLwk=
X-Authority-Analysis: v=2.4 cv=RdUFmFtv c=1 sm=1 tr=0 ts=6aaaf655 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=_ZmgHqWwjZUDpi_pur5s:22
 a=OUXY8nFuAAAA:8 a=IXYR-GUreU6iUHAiHlIA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: fNrzKufa5Xa026nhvM4lxHLZzAfv4CyB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI3NyBTYWx0ZWRfX+9hthsAZQSz3
 P11ynaNEio4eFemd/LLTvGnhHbWMYSi6rObMagGISlvbhz3mGNCKPI8sl0lrImx9TRrKoq5fDk5
 9cQimP2wGR5HVZ/4shOpK+tfMnixdqP5k4567Ao5TQRTqgkO80yb/LB7eCXXl/+GRSoZ4ifM6ib
 rV5vtLj2nEg7TSLIdsZFR5jUxUpSGnb8LpOTqUOkK2j8g8w9H8DQsrWsgs/G2AAWHA+oARJL5R8
 X3G/jcDlPq9xhYYcKSN5zYxf7GtXImjjAENzL2Y1MmWIJu+WZZV5z5KTQ6Dez87l/xGb6diEbEx
 a/cyUpgAPYf6XEbA0LMwnl4ApoA/8uCtSmTmSZ5kQQUtSgCEgtcQOVR13ZE3DUK90Z0MxPCNoms
 OETREKUIxiRvo/Xppqk3h08leqERuwNLKW2gKGMnmm9gk/HHnv2QtJe2BWDANh0GmyJDyR+uJEM
 NrG1zafJFo60JUBbqEw==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160277

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Cgp0cHM1MzZjN19pZGVu
dGlmeSgpIHNldHMgaW5mby0+cGFnZXMgdG8gMSBmb3IgYSBzaW5nbGUtY2hhbm5lbCBwYXJ0IGFu
ZAp0aGVuIGFjY2Vzc2VzIHBhZ2UgMCAod3JpdGluZyBQTUJVU19QSEFTRSkgd2l0aG91dCBlbnN1
cmluZyBQQUdFIGlzCmFjdHVhbGx5IDAuIHBtYnVzX3NldF9wYWdlKCkgZG9lcyBub3QgdXBkYXRl
IHRoZSBQQUdFIHJlZ2lzdGVyIHdoZW4KaW5mby0+cGFnZXMgaXMgMSwgc28gaWYgYm9vdCBmaXJt
d2FyZSBsZWZ0IFBBR0Ugc2V0IHRvIGFub3RoZXIgdmFsdWUgdGhlClBIQVNFIHdyaXRlcyBhbmQg
c3Vic2VxdWVudCB0ZWxlbWV0cnkgbWF5IHRhcmdldCB0aGUgd3JvbmcgcGFnZS4KClNlbGVjdCBw
YWdlIDAgZXhwbGljaXRseSBhbmQgdmVyaWZ5IGl0IGJlZm9yZSBjb25maWd1cmluZyBQSEFTRS4K
ClNpZ25lZC1vZmYtYnk6IFNhbm1hbiBQcmFkaGFuIDxwc2FubWFuQGp1bmlwZXIubmV0PgotLS0K
IGRyaXZlcnMvaHdtb24vcG1idXMvdHBzNTM2NzkuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5
LmMKaW5kZXggZjM4YzE5YjhjYzQzLi5iNjgzMTM0ODU1MTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
aHdtb24vcG1idXMvdHBzNTM2NzkuYworKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5
LmMKQEAgLTI5OSw2ICsyOTksMzAgQEAgc3RhdGljIGludCB0cHM1MzZjN19pZGVudGlmeShzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50LAogCSAqLwogCWluZm8tPnBhZ2VzID0gcGhhc2VzX2IgPyAy
IDogMTsKIAorCS8qCisJICogcG1idXNfc2V0X3BhZ2UoKSBkb2VzIG5vdCB1cGRhdGUgdGhlIFBB
R0UgcmVnaXN0ZXIgb24gc2luZ2xlLXBhZ2UKKwkgKiBkZXZpY2VzLCBzbyBzZWxlY3QgcGFnZSAw
IGV4cGxpY2l0bHkgYW5kIHZlcmlmeSBpdCBpbiBjYXNlIHRoZQorCSAqIGJvb3QgZmlybXdhcmUg
bGVmdCB0aGUgZGV2aWNlIG9uIGFub3RoZXIgcGFnZS4KKwkgKi8KKwlpZiAoaW5mby0+cGFnZXMg
PT0gMSkgeworCQlyZXQgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LCBQTUJVU19Q
QUdFKTsKKwkJaWYgKHJldCA8IDApCisJCQlyZXR1cm4gcmV0OworCQlpZiAocmV0ICE9IDApIHsK
KwkJCXJldCA9IGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoY2xpZW50LCBQTUJVU19QQUdFLCAw
KTsKKwkJCWlmIChyZXQgPCAwKQorCQkJCXJldHVybiByZXQ7CisJCQlyZXQgPSBpMmNfc21idXNf
cmVhZF9ieXRlX2RhdGEoY2xpZW50LCBQTUJVU19QQUdFKTsKKwkJCWlmIChyZXQgPCAwKQorCQkJ
CXJldHVybiByZXQ7CisJCQlpZiAocmV0ICE9IDApIHsKKwkJCQlkZXZfZXJyKCZjbGllbnQtPmRl
diwKKwkJCQkJImZhaWxlZCB0byBzZWxlY3QgcGFnZSAwXG4iKTsKKwkJCQlyZXR1cm4gLUVJTzsK
KwkJCX0KKwkJfQorCX0KKwogCS8qCiAJICogV2l0aCBpbmZvLT5waGFzZXNbXSBsZWZ0IHVuc2V0
IHRoZSBQTUJ1cyBjb3JlIG5ldmVyIHByb2dyYW1zIHRoZQogCSAqIFBIQVNFIHNlbGVjdG9yLCBz
byBtYWtlIHN1cmUgZWFjaCBwYWdlIHJlcG9ydHMgdGhlIGFnZ3JlZ2F0ZQotLSAKMi4zNC4xCgo=
