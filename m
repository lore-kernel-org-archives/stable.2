Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60680530DEA;
	Wed, 16 Sep 2026 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602893; cv=fail; b=s1/U1q+AgbuO8lnt0/qWR9zjmq9lATJUY8EIA/wBiuRtA00giy342AqS2mEShS3uD/tOa3DnSOO+GCRt1FHvrAZuxEKo5+1kKrf3wLtE8Z2j4rMHlka8Oo4wlBP378nKNC5tpDhgSNdd8byE4UNskPKK+s7JZJM4AGpGexEGZYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602893; c=relaxed/simple;
	bh=CO0ZiCmaHkjesepab49C5W/k01OVQXYDe4KZXQrF+lQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MUHWfweqHjfvCvZ4oYvt/i4EkdEJd1myg8LrDIqYlYBAl8bbqhPA0e+69CQQ0ewtvXSqLpvNGzKjFfdfXUCFlRvbpLVUQrTeybscTLe7gHkp1cYQLv48vXAk7XNR7M+4ds+QjdCMMvU3aOspjDZBz/5HH4t5kCMXl65jGvouOtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=V64K7beQ; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="V64K7beQ"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN2UCE1613345;
	Wed, 16 Sep 2026 23:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=CO0ZiCmaHkjesepab49C5W/k
	01OVQXYDe4KZXQrF+lQ=; b=V64K7beQEmfGhWq5iK+YGUJLpyrURjIr/LYg6HRY
	EolHKt5SKNC/BO59rYiRiDah42nm/tz+j6FsJ9OIlFq6pfvDZ9FHcEVGqeErtkOp
	KRmF1QL6rTQUCEQZmQ5ZYM2BJVUmNODd8kMym6xcTd52GXkkKbvaDLOjiPAgDCw2
	DrJJHPtsiIkjJ/BPOTzNYrIK16zFl24/ErePivKX4+5XA5Y9l0d8sZCLqu8LmUn/
	f7H7Is7lRknjlGeDlqLLySwJmbBE9mY6RNVnt52fe4xEw60AkkeYRyo6i7AO8tEk
	x+8C6yxv6gWcDO04YQdm5hlla42xqXikTj+Q4fpgaIWJog==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gqy5tw0wg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:54:31 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 32D9CD294;
	Wed, 16 Sep 2026 23:54:31 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 11:54:19 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 11:54:19 -1200
Received: from CO1PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 11:54:19 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7NNty3YtsY/Atp/cymR8XV8iHFStnNJz9hlIOYW8D0SZ7ThzF3Jv0w/GNTFclbUx76z7ex8aQRVkTUiJjn3WkBEIo+6SrHNTEXtc1YL2urn4sg6CQker14EFgZaNGSKlY/bIFcKcKt8PoOHzm+G4TXmW/vOFg3TFiAus1/T1nSJnFJUHidHk0AqIq2QJOgUehaLOefOPGYJqCsFgajnziQ6KsHJ7WX4/9jPEZ/S6XtSA+57opUKuqnRmEJNPx88IRCiMb7MN2qYre4HCefjaWWw5irihxslMXvUoK7fAeRfEedGITtX2Qe9+dKpRopzfaZBWA/+vPG7pFw0XTcEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO0ZiCmaHkjesepab49C5W/k01OVQXYDe4KZXQrF+lQ=;
 b=XB0oKAJ+WP3sCDwdFnFNeV/lmEjLE5h6z5GoeDHaw65dg/p+7a8kr2yKMM8XARCJEqED/GpSoC5mcDnwObNkcGC2GTU/HXfq9S+i3mbDADrxjgFjBZ/IoNEZBfIRU6MuSlr244v5IHOzXBeHrSe79QZ9YVl4yOBwfTuU5gaDcZ3PaWT/f1wihsDTjMKnTLD3J6WgL5L6mOBA7hDQVONefDMPKDH22oii0ulGmgdf8/qTKrU4nGj2B40+Wxb5t8dUXjCM3TJYzZKSad64d8P/rWvdek4G3GMvUIfXbvXWPqky7YxI0spEmxCBQ8cPNVnC27x5oaOkb9Rm57iNV3EGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW5PR84MB1428.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 23:54:12 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 23:54:12 +0000
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
Subject: [PATCH v2 0/2] hwmon: (pmbus/tps53679) Select page 0 for single-page
 parts
Thread-Topic: [PATCH v2 0/2] hwmon: (pmbus/tps53679) Select page 0 for
 single-page parts
Thread-Index: AQHdRjasIq/UYL751EaguIoLeUME/g==
Date: Wed, 16 Sep 2026 23:54:12 +0000
Message-ID: <20260916235406.681131-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW5PR84MB1428:EE_
x-ms-office365-filtering-correlation-id: 5e554fb4-7bf0-443c-8414-08df144dcef2
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|6133799003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: ZUtL8THU1qOmsrJTbn+OslAJWGp6tA207EfQ3ZHwqIEX0+XViMfd0qIV4Og3xzB6O/z9244NXQTQN0o+qN736kHCEaeMnxx17iHNng2uJQh6baUFD5y2VcW1BgLdqyXU94Ir/mRvvdv5Id4Xfiaav9BAFuYADbj9ifzwqFJFrfjnXVe7GiChjlmgBQEX+eZ1W6NPd55sI7x2vO1OzV2DJ29x6+NH00sD8eynRatTCYm9A3cRC1Clg0eLLZV0HAxwO/p/tDmYpS8bL+bf2arKNGuSBeYG8naBgZfrW4JM1mdt3ycSzcioPs//KLxg8bXQ2B6bAaK7mV6Msdt3gS/2HRK24zApvLR+SaEfyuK60x8K1QwETzC5+pLHU7hle8R7u5ckEPrYJRwqwJg1IA7SJHMqawxf+Fz9SpqbomTYGTnkd/bX4iEcV0wBQZN9WHY0XCIH9jrN9aAm1Fo5jFhNYDQm2uOrnWYmGxt+ZvVnXraUC1Wa/xb7MlYiWluIy/VgYGvMdZ/m1ueTbuxZYn5uv4d5K97NHOva86jGo9z+nTvkNVWw/E9hyKj+KFCJQyouLftbHopY/Aco3Q/WP3wcCRQQTyVN7H6QnQwkjC/wHx1wodM3DZBSqcv6fGis7yqsAA4CtfeUXxd0qj/SNIxYaF2befowgqBsWo/NfIWvLm5UuD1atvd4GQjgzdXvuh/JQ1HF8J9DcF+ehXW1Hk21EjJen/C1j+tM9ps3jTKMv60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(6133799003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2RtbmFGNXBKYTdiSFZxMHlZOTRCa1ZiWXFiWjlwOHg0cFNPQ2xmblFpVjVV?=
 =?utf-8?B?dFM3Qk01N1EzaGZST3Z4YjEvRUxyclM5Z2pnMmpsMGJTN05iVUdRelBnd1Ev?=
 =?utf-8?B?OGVEQWVieTNDNUJvNHpXaGNYMFNwNzVvQ2VFK2x3dkNLMXNIclhLWVBudE9i?=
 =?utf-8?B?L1ZtL0ROTHVFV2IzQllLdzNUemR1V210L0RreG5XdWc1bG9TMDdreGJoZk1z?=
 =?utf-8?B?c05qTXFwMTdJU1J3aFVjSVBuR1hjcU5BMkQ3QWplRmxJQkFycFNZbmZXcWU1?=
 =?utf-8?B?dlhodTdBZnR3Mm5jSTVrbURTUUpUTFJ5MERVZ2F3cUpWbyt0OVNDWGpKOVB1?=
 =?utf-8?B?dmpHd3oxRmlGZUo1U1M0TzRzUHQwemVxRkRDNVFqUHNkaUN3eHhaT2RvYUZM?=
 =?utf-8?B?cXZxQ1BSSU9QdVAwd3d0dkdmTmxOSy9obDR4cTA4angzNUs3bjNEOXg0ZCs0?=
 =?utf-8?B?blcyNGtUUFVSOXRDb05oVnBBRmxoNDJ2OUNnL0QxeDlRdXRwblI3RU9QQ2pv?=
 =?utf-8?B?Unhha2RHaURvTzE1RzIwQXpTRWJYQ2Y4UGNnZ1ZMd1g5ODNxSGR0cHU4M01C?=
 =?utf-8?B?ZlFDc3FBQnBIQkRlTjMrWTdwck5iTmNzOWJudlVia2pwR1dHT29lZFpNQjY0?=
 =?utf-8?B?V3JhcGZUZEtrMnRjUlZZUUF2K210N0pjMUxtMzR6S3RTU0g4cEkrYzIrQTQr?=
 =?utf-8?B?alFxcDdESTQzR1pZL01PVzRFaHJ6NlNwN2d1dnI3bUFBeWVnT25JRmx6QlJs?=
 =?utf-8?B?dmtJMXlxQjlVbUZXUFM5djczTGl5TzFtT1pkU0tEaEZycFFPbm00d0pMdC8v?=
 =?utf-8?B?RFlEYTJnWkJJV3o2WTg3RGxoZkkrR2FzVktXN0s5YTZ4U2gzdUFKZzNOQk1y?=
 =?utf-8?B?Zm1TT1BWUWgwR25QU3h6b3FJeko0OUJyZkZjOWNmRUY0Njg4eVJKYmk1Qjgx?=
 =?utf-8?B?eE52dGh3ci8rVGFiSmlKbDduQlh0eUtwdStkbnMwVkt4dndST2lMaEZkL3B6?=
 =?utf-8?B?QzVsSHlCTVNnRW56RUFPSW4rTnFCQnVFbWwycllvaTVJMXJNK2FSU01yY3JC?=
 =?utf-8?B?VFVocWY4VVJ5ZFdjVXY4SUc0UFpMQnRYaTJMUEkvUzFGcTFJTHpkRE9ENDhK?=
 =?utf-8?B?ZTRFV25sNEppU2Y2MnV3a2E0bW1EWDAvbnZhLzR4MzI1VHBZazhTbGdxU3hn?=
 =?utf-8?B?UEYrMi9vZ3l4U3lUVWROK2ZlTUJwYjFNbkFYdnVaaE9qQ1Y5STFldW1jVVM3?=
 =?utf-8?B?WVcrcTVUc0JWMmptNFZWZ2hxR1pVTllZTlFPYkpHWlROOFN0NHFzR0kxRnRs?=
 =?utf-8?B?bllvTlliYURJcWZQQ3ZvVW1pQm5lZTJwTkpVN1JKeWJqT1pHZ0lnWkFUZDd4?=
 =?utf-8?B?ZWpDL2F1dDJIUm5yTnVEZXpMUi9XSWdDSmN2Y3ZpLzhoVkNCNjVLTTBMZWZK?=
 =?utf-8?B?NEIwR1AwL1NSNDI2SDN5NmNLTTFCSDdjeHBiNGs0VkNMQjl3WkxjMVNGdFVa?=
 =?utf-8?B?TGtTMmo0aWZYQzU2d3lQWWdTUjEzNzBBM2NYQXQ4MUFnbHRuUlI3RlQvdnBa?=
 =?utf-8?B?VTZnZTNISVA2QlRKRytWelE4WHVGRG5kN0k1ZEk4dGhkVkpYcEtZRjBZY0NW?=
 =?utf-8?B?NzIvREJVTHZ1YnE2UU9JcWpPaDgwTkdjMWFhUi80WEdNT0N5YUtnbENOSE9P?=
 =?utf-8?B?alpMSExzdGJNVHhsS0NsbkJONU9BTEh3S1R4OHI0eWRHQXNOUTI2T0hhN1RS?=
 =?utf-8?B?WkNKUXM3ZlpUTzlSemVDOTllK0FubHJ4RTZ0bTZyWlc5bm43VnBuMUtvMzN3?=
 =?utf-8?B?SWdGaW9CWjBBWks2QjJoczFjOE5iT0thQ1VmLzRqeGZNemxYdkJhTy90RGhx?=
 =?utf-8?B?a0Fib0E0Q1djcUw3aTFvKzlCSjZ0VzAwcTU0QUk0TzdLMDlpMjhiUzJ1K3Vp?=
 =?utf-8?B?N25RTHF1UDQwNjEzRk5KeWppNEVhaGs2c1BsSTF0aHpLMXkydXlnN2lzcnRF?=
 =?utf-8?B?NHg0LzZEM3NrbXZhZWF1YnVGK3NqR01ZaCtEcHgyUjZxMHVqUDJ2MzhBazBl?=
 =?utf-8?B?SlNMdWJUZWt0TGp3Smt0eWVNQnpWWFArYXhPUkkxcHl0L05wNWZCZysvWkVN?=
 =?utf-8?B?cE1PVmdya3pUdVEwVGQwb0VuOUVOR3JWYU5sanlPVXFQYStrZmdic0JuaWk3?=
 =?utf-8?B?Vlg0ZVdVVUw2ZTlCaXEwT2ZXZGNHZVdWRStZbTZSZkY2eU9zbUxHdUNCT29N?=
 =?utf-8?B?MC9FbmtrVVFydlBmd2c4ZkE0RmtzcW1qVjBaMGFYZTdwQTI2dFQ3d2VmWG9X?=
 =?utf-8?B?N3gwcUZtRFVUNDBUcmxFbjdicEJkSVc5RjZ0ampHK0kvMXZrUlFjUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HIkkJ62GWhgZogokHeZz55rqRX0yvETe3pjX9uaHOekpkw9Gq8YHuinYznEt7YUKHgNlqxiS1AZkm4PioiYvLkQvQVpVJUIPzzLxpdP/Di28TDu+7ZtxJ+avhlxhR4A/+Pp1h0D9ZqtZg1YLcaSkWBWtwA9Z9LLrIRFDOFLtNi6auLdpAjM58FJYMA3kHQ6PKQ5OPrrBrrRrqQ/uu2KgoKufRblVzkby9xxEznZ3z/Id5fDPBn71Fl2FLyznJUNrRMpOvHyEKkMyxWNS7ovug5wXyPMmJHe4sbPjrID6vGcFIrJYcDv8XQYz6FFTuVUuydXUtL8k1r1+kQvNYTCZdg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e554fb4-7bf0-443c-8414-08df144dcef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 23:54:12.6894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30BcfiygKxlpsHgknDDEXGmDApfgtybxw4iwgtOe/g7SlUe3EIkijn4S+zgaCo9eY1sq5HFk87dov+L6EPPpWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1428
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMzNCBTYWx0ZWRfX23l1Woe3htcP
 F0c0Aii1KDP2dn/bwuPEGtAYVfEMrkFYhuvbKpNmadXhFV1Be7EyYfASDM33wVvVo6nLvFBeIwj
 2wIRz5Hjl536gBQJ1gtGKgge29+boV7Rndcj3gcLbjB3aqxo50EZAdzrUSUIx5PpPhC8+dhHCrq
 pzFlLzwFmlo5hBnfYS3yuz31s6sF23HOtM5SNzEqQmJiKX9qpcHHuzYBRZYq6epTHo/YB3gV9bl
 E2+TRRxcRXHIPqPwKMBYAs/dAvLLyDBqnb3KcNNExYSZ8/MF29pZkiyxEOkEsxeOhBKVz0sqWmu
 u6pNcFwzy5aelm7OYwmAGyf8HelcHipL/OSoE8aunLQY49rQ74gPDbvu5SHTYEh4Y2a2Q5fX3g0
 X1c3dqr4LZPg28CIZ+xTiEZya3DYwrmpan1r8qpLn8CxyhzSDGVFVenjNLE4hUbP/YjZw8zAJU0
 vkq8ppjDY09YW7sOS3w==
X-Proofpoint-GUID: t1TzvfxegdXlppNvOU2ZVJVvVId9OQfG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMzNCBTYWx0ZWRfX3Azcx6BdgUaB
 mGDyzv/93JYHoDvDEap7BImrcxJez4ln3mtn8gPzjmARQhF2Gme+mCdK/rHRdKni4VDLz692SS/
 ESHPa61AvcWhMSdhvtga1B4WS8b4luk=
X-Proofpoint-ORIG-GUID: ziXE_gb9HZKoc4UhzOsBdU-QSKUko-Th
X-Authority-Analysis: v=2.4 cv=QsPLTlyd c=1 sm=1 tr=0 ts=6aab2c38 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22
 a=OUXY8nFuAAAA:8 a=cHlYMzFDwILvckZdWFUA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160334

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpGb3Igc2luZ2xlLXBh
Z2UgVFBTNTM2NzYgYW5kIFRQUzUzNkM3IGNvbmZpZ3VyYXRpb25zIHRoZSBQQUdFIHJlZ2lzdGVy
IGlzCm5ldmVyIG5vcm1hbGlzZWQ6IHBtYnVzX3NldF9wYWdlKCkgb25seSB3cml0ZXMgUEFHRSB3
aGVuIGluZm8tPnBhZ2VzID4gMSwKc28gYSBwYWdlIGxlZnQgc2VsZWN0ZWQgYnkgdGhlIGJvb3Qg
ZmlybXdhcmUgcGVyc2lzdHMgYW5kIHRlbGVtZXRyeSBpcwpyZWFkIGZyb20gdGhlIHdyb25nIHBh
Z2UuIFNlbGVjdCBwYWdlIDAgZXhwbGljaXRseSBpbiB0aGUgdHdvIGlkZW50aWZ5CnJvdXRpbmVz
LgoKUGF0Y2ggMSBmaXhlcyB0aGUgcHJlLWV4aXN0aW5nIFRQUzUzNjc2IGlzc3VlIGFuZCBjYXJy
aWVzIEZpeGVzL3N0YWJsZQp0YWdzLiBQYXRjaCAyIGZpeGVzIHRoZSBuZXdseSBhZGRlZCBUUFM1
MzZDNyBzdXBwb3J0OyB0aGUgVFBTNTM2Qzcgc2VyaWVzCmhhcyBhbHJlYWR5IGJlZW4gYXBwbGll
ZCBieSB0aGUgaHdtb24gbWFpbnRhaW5lciBidXQgaXMgbm90IHlldCBpbiBhCnJlbGVhc2VkIGtl
cm5lbCwgc28gcGF0Y2ggMiBjYXJyaWVzIG5vIHN0YWJsZSB0YWcuCgpUaGVzZSBwYXRjaGVzIGFy
ZSBiYXNlZCBvbiB0b3Agb2YgdGhlIHByZXZpb3VzbHkgc3VibWl0dGVkIFRQUzUzNkM3CnNlcmll
cy4KCkNoYW5nZXMgaW4gdjI6Ci0gRHJvcCB0aGUgUEFHRSByZWFkLWJhY2svdmVyaWZ5OyBqdXN0
IHdyaXRlIFBBR0UgPSAwLgoKU2FubWFuIFByYWRoYW4gKDIpOgogIGh3bW9uOiAocG1idXMvdHBz
NTM2NzkpIFNlbGVjdCBwYWdlIDAgZm9yIHNpbmdsZS1wYWdlIFRQUzUzNjc2CiAgaHdtb246IChw
bWJ1cy90cHM1MzY3OSkgU2VsZWN0IHBhZ2UgMCBmb3Igc2luZ2xlLXBhZ2UgVFBTNTM2QzcKCiBk
cml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMgfCAyMCArKysrKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykKCi0tIAoyLjM0LjEKCg==
