Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F464D598A;
	Wed, 16 Sep 2026 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584342; cv=fail; b=oA9adVfU0jl/F652KD2esQMqya/ySIfF0xYgCJLUGJW/QDSL5yo7OSfQNhBhv7RHxyPpQ+a8LP1aQdMY+S8Ezzy/bBD++nSJPfn9vE+EododYgr8QG/DZnU33N2iDu2D4IYWZNu2B0NV2CqeZjbPJeGDwewnvyuGz+tS4IVgIXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584342; c=relaxed/simple;
	bh=QHn5McPbra4wvPiDq5P+dY7zQ6yHbMEIi0QMM93hsnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aAU8jSWITgfNPuesacQ2ew+2cIX01rJV3j+nxSWMm+UZEAhBdc+gWMA5s54kD7oXey9y+kl7tc5IqL8yCHOkon0/mI1JiibujOh2XFU7O1urpDliTdqpCyBV8/J9D5cdTCzKOrfRa3T8FE+WDTC+TTXC8esnLkBsgzubeEb3W7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=XyIFmGUr; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="XyIFmGUr"
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFfa9e2045833;
	Wed, 16 Sep 2026 18:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=QH
	n5McPbra4wvPiDq5P+dY7zQ6yHbMEIi0QMM93hsnc=; b=XyIFmGUrsUEk1n0sBu
	iALvCQTLfyDcUYrqsgI1N0G4IuPRSbmfP2r0QMv8S66PTkYxRKesaujFfHCgtWnF
	eWT7t2H4Mtka23f2w58WANPpeTSPV0zjwtGElJ2xciHF119HRbMWIVn4slcQ9/D5
	HysbxxjAlZuvS8rubuSewjJTMLw+PXaPNoW821X0R0SdGF7nLEj3/H0bmzpjjRLy
	aaHuSNOWaPgx1vnbCRZeIsVBsOqpfk8s0RYSmoHv2W+uO5xjecIE7HLGPMZ51Erd
	CrywkNZbUseGBxhhQUkTlbtLD7ZhT/Hi/SbpL/5p1nrryv00vwIKwcmGk7zlOPEj
	RsMQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gqw7g3e1j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 18:45:15 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 00FDE1478C;
	Wed, 16 Sep 2026 18:45:14 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 06:44:52 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 06:44:52 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 06:44:52 -1200
Received: from CO1PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 06:44:52 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnsKlcEJboNJn9OkhoqYgR7/rcVJq7wR3PV6UvbohUnlfB83OsndHtJJkNkwCW5aNhfri4AevRsZbdGhV2UDWTCMHV67brpc3xaTL5QmoHlYcGI+FXZK9jFAYt/JOlieBT0sLcewN+VqhCwpYc6T7V4Q//VGcC+hhKXLkFUqMUhLPUf8k7QUv3NF4cwHOYmFF9cO23RLZ6KflQNuQAXUbWKUv9AzsW+4EOrNJedxuPH4Dj+t3Lr88ueldp6c4d0pkfFC+p3RX2FrT4X290hA/ba4hU4mR9MSJ3A68Ly8NWGo2rRPVNJY+pCap7sFqLEqWessIvDDbUrZaqphaCs/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHn5McPbra4wvPiDq5P+dY7zQ6yHbMEIi0QMM93hsnc=;
 b=s84IOA1EIbO4ZJ3YNXtoD5XiR3PLpqunSRD75KXy39NSZi7TKEBioSpeWhh0438eqH2pC1ynZcxBaaRxoxaPNFGy892ZB3cw6grAkDS3uSW34R6zFxp783tTfLgHuR71nyxyhLEyRTP/D88YZyOT1jIdxcP28j9QmX+j4wYZppzsadocDus/0pB0STqzJ9ZQzmT4PFlIeO0Ow1ZmWNYz5GPwp4HMFSeF0y0GTpNkvxUhZXZ90zYR3ve4HN4rHjkiEHVG1U6DB4GWOWyd9+T4xyGpYwKjljxu5NI1LbCSvaeYCABRBuIuTDxXLTcK+0xeRxzgjSs0Z4INtz9jVAuzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DS2PR84MB4070.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:44:43 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 18:44:43 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page
 decoding
Thread-Topic: [PATCH v2 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page
 decoding
Thread-Index: AQHdRTIMBtc9dKXtJ0KuZ/216AGGBrbRTLKAgAAvWwCAAAPegIAADIgA
Date: Wed, 16 Sep 2026 18:44:43 +0000
Message-ID: <20260916184436.657004-1-sanman.pradhan@hpe.com>
References: <a335dcbc-6bfa-4ef2-9c7d-4cee985fc3d5@roeck-us.net>
In-Reply-To: <a335dcbc-6bfa-4ef2-9c7d-4cee985fc3d5@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DS2PR84MB4070:EE_
x-ms-office365-filtering-correlation-id: c3813bf0-101b-4d08-3edb-08df142292e2
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|38070700021|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: t+HOaANNCkg/H+zyXs69i1T/CAYoIuVkpjdTxsV1TZjHjutrJurFzq2OOl8lVgXBcEiBPYHJnTYxG2b8DC8BriBnNSX7fIeP9+pKqtbf1Qb8RmBdwq8fzcauY+2pkCQ50lNvYnrbRE4nAURvU2bR72Ho0d9JBM+Qe83j+fWs1eYDqlMT2cw0M82QziyL8JAitAWgjiy5BCHSObBYE/vvcwneCI5ILlMPNnUYGsSforZoSftWJl/yApLFFwOE/05vtRCIRuC+hHAO0K7EBjFgANWvqyg/TWSQ440ZbE3NrMS9sixJQHd5dmB8BDGAZIe4nEBYu7n3gXQfp1OxEeCnDo313g8V01L+S4s3SnOLhHzLsnj/tZSj6CE08NZSCvTZce8ZXHXhwJtpa5UOfiETHJVkW3A9BgKtF0CjR5JLJ94Ni6w4T0KjJU/BZFuh8DgALDH4/kK48QEk0/pfDnZOsu2rIfrlYaDdj36+QAuG3fQ7QNZgHha7T68walvW9nhwYGTU+lj9qg3mfFUd+LuUXXbCwv96r7B8byw/xWi+p3JenqylZemgIIyn5W55ir1J56P8hGpKz+iG9dKfY6TscJnYF3XT0cNgoouzdzvV13xV56WLytuJG96ZPYFcDTrQgQI+aOWUvJW2mtD6M6b8k6A3LSQSrFB9xidPtHlB1q6PbZQfB7YzMYBKZMQ+Nz9BROp5eLlkIcxTuHpykL1/XAjQs8LOz3ZIvhZyPPJyuYg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(38070700021)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWF3OEtxWVVscUpTQ2xMVWovM3pRMUZqUytRUktaSVV4WEdCNzh2Ny80QU5m?=
 =?utf-8?B?ZzB0WExjRHQzRzdNN1pCRnVoMWREaXZweHh5akVkTDl6ZElKUUpvbnd1K1RB?=
 =?utf-8?B?R0xVNlpxc25yeFBFR1cvellpT3VRbE1IS0svQldCRGZSWnJsOXdHdVZWQU5O?=
 =?utf-8?B?VEk4K3JFQTBkUHVpSnZWMmsva2gyQ1lJUEpjY21SN3J1U05GQkNpTnltR2hP?=
 =?utf-8?B?TFF5ZDNtR0xYRzVWSlZoWHpkTUxSRjdmN1Q5c0NweG5paVJqV3VGV2JhRzZp?=
 =?utf-8?B?aUdIMmVWb1NKaVNSV2t2SmlQSDJGSzhZQmdIN1c5M2VRRElOQVJ4d2R6Y3lL?=
 =?utf-8?B?R2pud09CWk01aHZGZkt0STBGZDRGeDZyWFdxSGhORG1kSjlleDU2NGFGc3M3?=
 =?utf-8?B?VlMwOEJrR2RjMnJpSnZkVXZMYmlNelVIUTY5a25pbTZpMEdLbm5uTmN4MjFW?=
 =?utf-8?B?UWNpbHMrdEFyWnFZZG5GampyZmNmbFR2aFRrbmxMNHBwbjlFbXdYcVlIQzhz?=
 =?utf-8?B?TGdwN09vZG9XS1NQVnBLdHZPY0VjdDFVNFFER09iSU5EYkJqNHdDNVBRM0xp?=
 =?utf-8?B?UFlVQWp1Wm1rZ0xVQXY1cXppMDREQ29yQnkyNDI2bEdmSzUvNHFkbXV6YW0y?=
 =?utf-8?B?UE1Hd3VYMGlHdjZyLy85VEVHb1ZpZm04cmYyNkQ5eVhMaGJwbnRNK2EwdCtJ?=
 =?utf-8?B?NGJvcm4yazRpRW9jUDRCbm50bjMrbi9JcEZwcUdKOG1mbVZXY1Jyb3VxRVlK?=
 =?utf-8?B?QklPN2YwUXozSkJ3dWl3dmVXRkM3M21tZTE4bm5wbXlQd3pVclYxMVBWUkZl?=
 =?utf-8?B?SkhaTi9pMUF6UWtGVHdYM1hkZHVwOUR1dVBHRUxEUkVPUWxTNGdFYUNPQS9l?=
 =?utf-8?B?QlFOcVZRbDc2Mk8zQmFNU2FBblU4NS9rYnNXUTRtRFI3bXgyMFd6YVlubm1T?=
 =?utf-8?B?UXE3VmFYSGk5ZktkdytiYis2RUgva1NTS0N4RGNBVXVZNHROUklWNUNIRWlQ?=
 =?utf-8?B?QjJlNTh4Y0hya2ZDL2RlazhUTzl1UTR3NzJZM2h3MnF0eWhqYStRakNveGNn?=
 =?utf-8?B?U1FrQ1R5OEZUWGJ2MVNHQVo5WmxpbkJRR2pLMTAydWlkbEVQb09JUkxxeWpV?=
 =?utf-8?B?RGJiTlBaMDh4cDZMUnFMVmp6UlJvUjBOa1A5SkNFUkFsZjFTZk84b01sSjIv?=
 =?utf-8?B?Y2pEUnh3MDMrUW0rWVVsTnVYN05GdWptaXR0dElHR0RTSEVqSEtleVVDRi9p?=
 =?utf-8?B?YkZuR1grV1d6NzRVMlJ6MzR4aW1PWVlkSVdoRjFiaXowRUFTcUxFYUF6NUdG?=
 =?utf-8?B?bHQzVDR4dlhCVFVWT2dDK3AzeHRSQ1kvTCsyUFBxclJpQVNWdkVjQ1lUdU5u?=
 =?utf-8?B?alMwTUtZWDZPWUprVnR0Zll4ZDZORk44Y0ZLb3psZlBxZkFQd25TVzNONDRJ?=
 =?utf-8?B?UXl2MXpSMGNnMTZScUF1YXg0N0kwbTdQanFKdjl3WmNmUHdoK2JzSE91NTAy?=
 =?utf-8?B?SFBrUFcxM1YyMDAvK1dMd1RUZlp2RmcyUENWQUt3cUljaUhvOWYyNzFoSUNL?=
 =?utf-8?B?K2pMbzZBN3AwMEJkbkJrOUhvUXRVaVkwSGZMOHp2NTdTL2ZYZzZjNFRxOEVX?=
 =?utf-8?B?WWZCdnlqdVE4THpLQWpxNEp4NExZUk5lb24vank5dGliRVlXcDNXUm9tMStz?=
 =?utf-8?B?U2dyY3RQVmxJQ2llWDRyYytCZXBrcmc0NUJTSC81YVJQWXoxNGU0Y2FjSDE5?=
 =?utf-8?B?ZGtxeExFRjRQVGFLRDgrY1JCZWlpZHBielU5QmdUUlY4TmxUMGN5VC9BTHNP?=
 =?utf-8?B?SWs2VEVZd21BaE84dkYrcGpjdmpWL3NaTllkK252OHV3VVpKcUVMWUNjaFYx?=
 =?utf-8?B?S3c2M2dja0tzRCtMYXpNUUd3algxc0xQNy9XNDZOc3RaaTlzd3d2WllZNko1?=
 =?utf-8?B?TGtsVzJVOXdFYWxXa1NpcTdNb2o3TVMvQ1M4dUVWZm9HUEZIOWJXQTR0c1lp?=
 =?utf-8?B?MG9QWHd3SGFLMW9yNHA2eHFuWEwvUG9jaUczUDFjWVJYTkQzQUtXUkc0WWdh?=
 =?utf-8?B?OTRZRUtKTGhkNjIwMWNXV1gvcGozc3NJRTJMODM2RkxDYTFqaHJneTJqdTdv?=
 =?utf-8?B?VkdnVkRBM0xtbkpYZkxQMVh5Mk45NHdDcGE0SW1ZNUVSM0IwWEtEUTVWbE1F?=
 =?utf-8?B?dVJqaFNoWUVjZjJBdWdwRytBaFY3UG5PdmtNNHJTd1lsQWEveGRYdEdXd2cx?=
 =?utf-8?B?c1BNMEZRUDh0dmdPYnNvWHVSU2crZzM1NVowU2JxQkY2SXdUZm51U2k3OWFU?=
 =?utf-8?B?dHBQeVM5dDZIUkc4UEVvaHhUbmVHbVg4eXJTSnlMc3FoTHFHKzNLUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UY5xwT/36CkA46XSAMAqZCtJKsnhxk3KGH6o2qgo1dxJYWZEMXR+W5gX09NKYmrEpNG1MgVyo8lIDc2669bdqw64dzlevsP7qg5az4eYLY5JCEoas5SRpLIcr43+UPhzk2LrX4kyxPom9+27WUThoDNMe2v4L7gfQZ5DLAE69U8Vrng18SBzej8dpN+Nwd0W3sbM5q/01gSLbjpivbhjL88cSIeZKHxJS2Ekt1wAcpbdGt9w3ueKzSjhcSREyGKUyj5dvFohJ9H219PWh/btG5jYHe0/nJhOHW5DX/DF65gd0YUjCIwp4wG9xiZW0vWg37/4b/z7GUQ5Msz7rU+qTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3813bf0-101b-4d08-3edb-08df142292e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 18:44:43.5109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vsbNrbukfZwRYze6e4+CY/awW0jRZ7vjQ/zGuCHRqqcVJGvuDGynxCQVFbcWrhGOOMJsJcu77QhoFLqs3z7/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR84MB4070
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: EKRRSjny1GsmEQqChFWOwOLpSNSXWLzO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI1NyBTYWx0ZWRfXxQXspnYC4IZj
 NMJ6H7pLzPmzsLhHmPEdn6YPYA6q5oq3cD6UXoBmtGBIOfybrIqvPs15S4ZNnRl6WRo3OoaBE6V
 PAAHdJy5Sk68FBZGsOgWQJQvA55Za2g=
X-Authority-Analysis: v=2.4 cv=RdUFmFtv c=1 sm=1 tr=0 ts=6aaae3bb cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=_ZmgHqWwjZUDpi_pur5s:22
 a=OUXY8nFuAAAA:8 a=QTfseBCnIOStC3TcKcsA:9 a=QEXdDO2ut3YA:10 a=q5mp2vxMLvQA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: X3lw4eLjRgd4jvcMhI3tFWkaf3sqpTQ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI1NyBTYWx0ZWRfX4X3EahbLgkBF
 dSjNYkuou1/+RW04jN3mXylbTFGM0bpasfQEoH4mFIv4mclbg6f/fKpav3LfqvsIxxeEDQaZ3jH
 AporJaTfFPg8SXWIQCooDqHA5k3cpqdjMN7Ptx/LV9WeGly770+pkwq1lA5byDTezRNbTp10508
 HBMbsogW0D3VNGX3G3L+vuJwAYrwYLm5DXJI09bbb9XeG4KsvdF3SfC5eL1K//3pRnQGiadCNfX
 xGtDVXLQPRUTaC/3CYdTV8SfUYg0ZOSxmdIl6L8sm6DchO1tXrRwr7rJvgLR0eBlIXBbzAhjjfr
 hO5EkBVxtYmx9JqOzu0RT53Qi1QkLTr0gaI3y39FBNgx3oagHK8gdM+FtXrjZ/cDTOwTuyhPMVs
 VgFSw3DX7/V66pMCdePi5lbDeW8Npy405Ytg9+74mKNAm97JrUtm5I2C1YL/0uWBQgG+puVA/QZ
 T8XrpwdqVptY4sJGOpg==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160257

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpTb3VuZHMgZ29vZC4g
V2lsbCBzZW5kIGl0IHNob3J0bHkuCgpUaGFuayB5b3UuCgpSZWdhcmRzLApTYW5tYW4gUHJhZGhh
bgo=
