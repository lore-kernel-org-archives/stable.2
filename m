Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88634D599E;
	Wed, 16 Sep 2026 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602895; cv=fail; b=M9hNB1cCCtiLzvXnyODyE5vrxCg37W6Fy4TfDlURmC+6hlVfw9+OkMagAyN+uKtCHcioY4DKBj7kyAJX76ngQtpfiGxHtnq9fIImF8NUhaknd/DulG6o+ADijQyxMqFoxWvAgaTQ6cRBZKmUftGdz/DeT5+PgckWbsjvYcw7E8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602895; c=relaxed/simple;
	bh=Tvi2sE6ZZwWtIFQt73OcCDcjR2YPhRieze+0s9oikGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fe0xNw54YKHyJRdkaBVnJJYuLcgRpdc7HycNrNZiGP/gF2rxbs9xz5ddgs17kXHmMpwJIiWbXj1SlawSptLsus7SX24QJg2dxzL1pDt4KYKajfqumnf8KEjoqJ3CtaLcDH7fyGohRGMFHuZM9mqgyIhnYc/6RSP/PiiFUm09als=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=UTk5hD5n; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="UTk5hD5n"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GLPlqt1754457;
	Wed, 16 Sep 2026 23:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Tv
	i2sE6ZZwWtIFQt73OcCDcjR2YPhRieze+0s9oikGM=; b=UTk5hD5neJDeOoXl8z
	S7rGxIvt5G1QPY0jdGNCL0JwsCwuMRxvFDavfcFDbGvFAGAVx0arZsfBTMD+JviP
	5I5aLcq4fruMNYRG5hw4TtVSKitndiSTza5TIgKROzMJUgax2XopK77WkhHl1+LO
	lFQOUEp+sEpM7KmoA/gutkA+BjjpMFFJzy2XU5YoHAWrc5GWFioETgAN/dcIt+/m
	X0Kffaqe3YFd6vJ3A5HL2Es79E2X4KpGVvfflwnxA+AGcvFfFJoBCvdVbfcFvopa
	IAmXEvC9mSegvYe1Z9j6L3xECvWkbvDhvzaF4owED3LnWrSVCLGWjYxFFc8EhZij
	DaSQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gqwtp67aj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:54:35 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 5DE6CD2DD;
	Wed, 16 Sep 2026 23:54:35 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 11:54:26 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 11:54:26 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 11:54:26 -1200
Received: from CO1PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 23:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUF8RDyNtf0nz7SVL9/VrmjtlibmikJhXdBabxbAmSXS5gEWTjFwXeaeDhBF0umw6jGWGDV+ddVDB/uFO6ypQjkvrqqRMHM+Vd3t1ftcJRYHJLrrP2OJar8150z24teMajU72ZaSbvRNwe7hycXQR5m10zoA0kQ+K9ru2FLu/KV5beN4qd3lBPuldhQhGGnazqqW4Au7XKCG8AA8p2k/zzd6GQHKFus151gWydaANys7BhvZfaCFbRUzUH8uPBzSJPfyDMfwwyO3XzldPlfrWGEf86rRX9xja2jlBfSp5RP3GP9wTmE8ueBg5vTSQDwmZRSPACnFuMe+VHZ4Pc4hdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tvi2sE6ZZwWtIFQt73OcCDcjR2YPhRieze+0s9oikGM=;
 b=yr5F9xVf1KPkEd2pA7z78Mn6F8/d/GAy3Fp3BQeXMJPeLeJjZVgP157ZPpOirp+q+crH6AygFf/Km+QFMOLEwScdzbEK1oRQqUezduWYAhFLlMVwjwBcWHEiDuZ7no3MFPN0AtHbWEKLk3wPmSbF3HsXTeL6vCO57xVuZHLeOBu/w1/8DJIMzik8Ge5OpzS30dFGA8EEw+D39DbYp8LfNLuZceb9LakCx87AKd9nnoWVOYAo1/dfFGtjorh4Cpxg1JgSGHrapWmQQxeVlA+TVlPdtmPf3hH6XCYnf5dyIVukrTbPT5+noxJtKGgSQNxQeJHaD21kBFAwMF17Khyr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW5PR84MB1428.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 23:54:21 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 23:54:21 +0000
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
Subject: [PATCH v2 2/2] hwmon: (pmbus/tps53679) Select page 0 for single-page
 TPS536C7
Thread-Topic: [PATCH v2 2/2] hwmon: (pmbus/tps53679) Select page 0 for
 single-page TPS536C7
Thread-Index: AQHdRjax+b8OJhlfbEWJGyW9haMlUw==
Date: Wed, 16 Sep 2026 23:54:21 +0000
Message-ID: <20260916235406.681131-3-sanman.pradhan@hpe.com>
References: <20260916235406.681131-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260916235406.681131-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW5PR84MB1428:EE_
x-ms-office365-filtering-correlation-id: 99ff88b2-e792-400e-bb94-08df144dd459
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: BY8/xpXP3b0Lr66mGNt6aBIQkfml5bRD/1puWb1SI1PWCC0ccYgGtIbWLDMKKjvJIxApGeqOd4dbi4b5/AGhz5shRkULKLn0IWQNIYqONRegsFm3l0oJ1vgYGnyhNkW/PvNP43JEpwZmkIK8/PebSBg7hviiNFZDb8HLbZxTSHv4k6AFaTdcrlTjwTa2yfK9/RP2XPU04MXlDGoRFQBf2KnCVr8LWMc7+2ekC9e0003WG56rGPE9Es+udu4RDAe3A9JzINMOTE62un+WyEHWC2HQ5XXwEbnCRLb+Pf42zNKI/QBzw6wUWzE8HDLGIhOe0XCMTL+nMTlO4YSWezGVR3jW04GwNYc7z7x5AIgf+p9HI6zkaFcTV3fBegXO38thLoHvn+sRO9W7knd3VvZVj4to2+Kt5uBZD5AstQXV+hCtO0dstcZeV3rCt51OMZZnMglwhtdNgnFz4NPjT2rMyslrkdBc+PxSoulUQpaCnIVkzXsTUb7ySqhInYEp36dkWn6bFqweG1wG7U55J0Ip8QK8LxZmLcSI9XW2yIPG7ZloAZXEcdcEEM4GLUz/oME8EEGJ/UZbk/dK0smWwpHG/e4cxH+6eADThhZHFoayhi5rS4cO1clzd+MRtKzdJUTf20RQ9jIhHym6C9ixwPiJgLZA1zRLycsRgic0wrDAFYPiXL5vjpkls8cKz3rg5IqDwZsFW9e3S3G83D7kwaA8hbunqg6fSrWjFpN5inydOC4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(18002099003)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEVlbUFyOEN6OGFINDN3QWVVUTdxYWYvRVJUOWdFb0ZDRVk1SU95T2pGbDU2?=
 =?utf-8?B?YVU0RytpSVlJMUVSZXRXV2RuMVBWVXJmZ09RNzNSMXUyWVE4TjVJTG8wZ3Zn?=
 =?utf-8?B?b2V1TDBYbGFpTjZ6M2pBSnNTSjlHR0xYKzZ4OXpka2h0T3p3dkF3ZCtiSTRI?=
 =?utf-8?B?QzFJclNnRnE2Z01SMDllNm1tRWJLUUc5bmlsdDltWXVJeWNqNWtoZEczYTVK?=
 =?utf-8?B?bTFIVEJJbWtUaVRwSXJaV2tjV1RESlYwTGJjYnorNGY0YXBBT1ZoVS9RVmdw?=
 =?utf-8?B?dTA3ZGpKRWhqMHJiZlFZSlE4MHk1STUyanpDL05PNGMxcG1zM2dZLytxa1FH?=
 =?utf-8?B?T1BweWtuVlJ0NXJMeEdLUEpSV1BYTVkrUFJQWXRaazJZUzIwZTYvbmVnNXJI?=
 =?utf-8?B?T1pRa0I2Sm9maFhFd1VCb2Q3K2tETDhXNjdjcEJKUGFjZis1YjdTOXU1YjJL?=
 =?utf-8?B?RU1WbkZiYlhXS1hzSkxOWDNhWFd1WnNOd1ZLekduVGRSUkhpMnRtRVlMV0hX?=
 =?utf-8?B?RTRNd1FONVh3aEkyTjJyYlhydXRaK1dEY2FWOGNYamxWSG5WV2JxVFdUUER1?=
 =?utf-8?B?dnFvc0NkV2hCY20vUHhtaWdVckVzcy84VXFXalpNY01sanI3a2RrQWdjVlZp?=
 =?utf-8?B?dVZuTjEzTFE0VFNoQ0pDZGcrRm54Nmw0U2huUUJIVzZzYlU4bXBPRXBrUmZZ?=
 =?utf-8?B?cG1zSXRYUHBaancrZzRVVmZyQ3Q1MkZqa2ZmUUxvclVqTU9IQTNqcTM1Z2Uw?=
 =?utf-8?B?NEc0ai9lTjBTY0hJbXYvbGRGa3RWL3JVNFlsME5wZzFkMlZEclp4MnowdzM3?=
 =?utf-8?B?REJtODRHWmF5M1RFMGNySVdOUXM3MDAxd21nV1ZQeXdISFMzTHY5MVovVHo4?=
 =?utf-8?B?c1lZNDFQQkp3QnZkYVJuV29tWmlwRFNOa2ZoNHl1Y1Vpb29OZnpMSWozU3Nj?=
 =?utf-8?B?OU5Pb1B3cVpRcTFUaitWTFdVK1hxRk9hVE9JaGV4ZUFNcU1FbE00VWlkWUt6?=
 =?utf-8?B?WmlxNTZaeW5GU2U4UjJZVDMzc2RJekNvUjZORzExL1R5QnpYQUVSTDVOUUtF?=
 =?utf-8?B?UjI0ZDR5LzNmb3Q0S1ppWlAwa1B4clk0eFpUTUNJZGxva1lOaER3b1VZZkRw?=
 =?utf-8?B?SmJuRC9VYWp2STQ5MGdialhQbU00VHI4cHVLYTMzZ0dnWnF0a3VncWUxUVJm?=
 =?utf-8?B?VVJmaElZdU1oSDQ3clRyVWk0WW1lYytkMkpUYUE4a1N2WmZUU1dBZHhoMTZx?=
 =?utf-8?B?aTdiWjdkWFZOaGlUa0FrNGZ2ZEtiZ2tSaWxpNDNTTkx2NVdQVzJxaVlwc2Yy?=
 =?utf-8?B?SnVTaTk4NmdpOSsyb1RXcVJyd0Qzb1hpM1lhcDdrejVWVmZzbFhKT2U1Mlgw?=
 =?utf-8?B?eTRzNDltZzYxWmNXRm8zV1hSd1hzNHZtWlpDdWZpR1liWUwxMGtvVXludlMx?=
 =?utf-8?B?WjU3MW5qSE8xS1JHMjRpQ01HdFZWL1BtdzM5NUp6L3NGU1c3c3JIdUdqS0VZ?=
 =?utf-8?B?Qng5anJWMWdOWDRGdnpUSk9zTVRjS3BPYlR1aVNQTlZxbm5qeDNYRWRnNVRu?=
 =?utf-8?B?WlMxYjg3V0tWQkVLTHhJaTRYckFVM21JKzEyZkhWTEw1aCtkN2pNajdUVVY3?=
 =?utf-8?B?RnltZUFmVVByM1MzTWRhb3pvMUxXTmlwVi9ScnIxYTBYNXBUVUw2OHRFSTF6?=
 =?utf-8?B?WUFPcTFtcW1LbGdrTTlmUE5sSzVOVHQzWTdrYXAxUFNBbThtcXZkYWFCYXpB?=
 =?utf-8?B?QnV3VFAzUW5OWTQzUC9JZWUyZDk0UXRWczl1N1Z6UTdsVzRwL1NXa1B1Q000?=
 =?utf-8?B?aFEzSkNPbnJPcDZXcmpFUWRTWHNpWUgvZnZ5L290aHZvWVVFYlJKS0tHU0FH?=
 =?utf-8?B?OWJISGV5ZlM1M0JoeXdDQlZxSmttRGlmd0tzT2Q3bitxdWxFd25mMVRNRVFj?=
 =?utf-8?B?dE1rbllMS09aK1pRczM1c0FMTC9razcrMmNCNWtiWHlILzduUVRzTUszWEh4?=
 =?utf-8?B?YlJJK21XZTNBT1RveStpN3NjS3MxdE1qczNtbWFlMXJiSWV6NUNLMWdpcmkw?=
 =?utf-8?B?c3M0TUxJUjZ1QTk0b1llb21wNmxJYm85a2h3d3ZnTmp2WVVpM0VKQWVMaldj?=
 =?utf-8?B?Wm5IdHZsSHh3aHJJU0RxZnhhVXdDZkhOY1BlMHNHWjNVUDVweTRkd1RhMHZO?=
 =?utf-8?B?S0pudm0vUENlVEU1RlRZa09XMjRJVDM0SzZhcExmZ216ZzNOT0lXNWtDVVVi?=
 =?utf-8?B?cm1QdFprR3B3MnZpUFc1bTJIVDFQNGRIMUo3MkZNV2x1QjUrTXZFU0xYOFZx?=
 =?utf-8?B?UnJxSkoxOStkU3J5VHRMQU9idmxaVVBnR24rZlFGa1A1M2VkVlpEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BV3wrtGBM4Aqbw+5VQ6xEqgGvQZ4R8IqqD1d6ZisaQAhRNDDcsaZVgrJRGXwAA87okU54//d4zbh7KpHHequrzbzbmAK6DByWtwncP92iHITlICLCj1JMhYW/G2Agc8owzlOFGoyFHZ8iiEnRNcNaDvyLlUJoVLUG/4/pB0JyBOxvNqqtSZLmWIOalU8fRfTLwvxa8LzU2gdLr3ACP5sSwwpkkMWcbhnoERYhUHbBt9VvRBPx87KLsckfs80tgbsoPDGBdlvpuJ6GmwVzBA9ejqRy6fLKm2P+YBSA+gWOBE9HC7lFfiIpQHk/r7IZJmR3eUNfWDU+ohOQQ/80dlPzg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ff88b2-e792-400e-bb94-08df144dd459
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 23:54:21.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOYjxiw+NjWXY1dPngU1xCa8MlSxUimdsuAyQNcRdqtX/cGe5CMAYAKA1SsJoBzNcQPNR5n/DjmbMHxK9UMOEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1428
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMzNCBTYWx0ZWRfX5WonhUmiP2N6
 oFNwU5uYzO3r0McoKxrdbFK+mq+2zL/0B+T67GdykNHEAuiU6uI5HXD/HlBViFHrTOUAv36ipEc
 l//6qBAtzf/QtBml+RJvcj9uqCTIYGkmU7bhONPjVaagYGybRqsefTZTs9RYO0gMosyuECqf5YN
 Y+9wbVjL22VZIEraFMoV7Q4uofpQ+rEA43nkNSx8a9kpnpn0U/S091qTxg0pYjFRwqv6QoHBs36
 +6E1YgAkHX1EJZQNqEOJn2PF9sTwxdLzrlQTzHOnzyinihpiMOCbMt4uXwTKz4zL5mW+7xBd2GK
 R2cRe+2E+DQuHHvoWG/qK8ZmM/DX9A56ZwefXLc05P+4LYJC1H+EIGMycCRMIDkc/NEMwq3dj2h
 tPQ561gHID4A8zuxMiPagSYnpxPu2ZzFNi1ST7edOr1I0rMmOeVYCBRmd7bYp1nSsAAjSQeruRk
 SLMXoBLqjVaUYyDhQVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMzNCBTYWx0ZWRfX/joRSh0D5s3V
 nUrfM5QBOS9a1KmYVNSLoFVWT3t02xchLzjTjkzSV8z3NCSAe2AgpLVi9V63265pBd6lqe+RLd2
 9O55BkXJy3dcKIvRCrPLJn3CxCjTh+g=
X-Authority-Analysis: v=2.4 cv=D9HSufRj c=1 sm=1 tr=0 ts=6aab2c3c cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=OUXY8nFuAAAA:8 a=IXYR-GUreU6iUHAiHlIA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: V7G0zFkWMjVcB4E-d6JrhzjVadytuJ-D
X-Proofpoint-ORIG-GUID: y1JSGXW24v9bVe-qbSxx-0QapP60yWWM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160334

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Cgp0cHM1MzZjN19pZGVu
dGlmeSgpIHNldHMgaW5mby0+cGFnZXMgdG8gMSBmb3IgYSBzaW5nbGUtY2hhbm5lbCBwYXJ0IGFu
ZAp0aGVuIGFjY2Vzc2VzIHBhZ2UgMCAod3JpdGluZyBQTUJVU19QSEFTRSkgd2l0aG91dCBlbnN1
cmluZyBQQUdFIGlzCmFjdHVhbGx5IDAuIHBtYnVzX3NldF9wYWdlKCkgZG9lcyBub3QgdXBkYXRl
IHRoZSBQQUdFIHJlZ2lzdGVyIHdoZW4KaW5mby0+cGFnZXMgaXMgMSwgc28gaWYgYm9vdCBmaXJt
d2FyZSBsZWZ0IFBBR0Ugc2V0IHRvIGFub3RoZXIgdmFsdWUgdGhlClBIQVNFIHdyaXRlcyBhbmQg
c3Vic2VxdWVudCB0ZWxlbWV0cnkgbWF5IHRhcmdldCB0aGUgd3JvbmcgcGFnZS4KClNlbGVjdCBw
YWdlIDAgZXhwbGljaXRseSBiZWZvcmUgY29uZmlndXJpbmcgUEhBU0UuCgpTaWduZWQtb2ZmLWJ5
OiBTYW5tYW4gUHJhZGhhbiA8cHNhbm1hbkBqdW5pcGVyLm5ldD4KLS0tCiBkcml2ZXJzL2h3bW9u
L3BtYnVzL3RwczUzNjc5LmMgfCAxMSArKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMg
Yi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMKaW5kZXggNGY5MWIwYTQzYWQwLi5kZjIx
YmM1YWExMjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vcG1idXMvdHBzNTM2NzkuYworKysg
Yi9kcml2ZXJzL2h3bW9uL3BtYnVzL3RwczUzNjc5LmMKQEAgLTI4NCw2ICsyODQsMTcgQEAgc3Rh
dGljIGludCB0cHM1MzZjN19pZGVudGlmeShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LAogCSAq
LwogCWluZm8tPnBhZ2VzID0gcGhhc2VzX2IgPyAyIDogMTsKIAorCS8qCisJICogcG1idXNfc2V0
X3BhZ2UoKSBkb2VzIG5vdCB1cGRhdGUgdGhlIFBBR0UgcmVnaXN0ZXIgb24gc2luZ2xlLXBhZ2UK
KwkgKiBkZXZpY2VzLCBzbyBzZWxlY3QgcGFnZSAwIGV4cGxpY2l0bHkgaW4gY2FzZSB0aGUgYm9v
dCBmaXJtd2FyZQorCSAqIGxlZnQgdGhlIGRldmljZSBvbiBhbm90aGVyIHBhZ2UuCisJICovCisJ
aWYgKGluZm8tPnBhZ2VzID09IDEpIHsKKwkJcmV0ID0gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0
YShjbGllbnQsIFBNQlVTX1BBR0UsIDApOworCQlpZiAocmV0IDwgMCkKKwkJCXJldHVybiByZXQ7
CisJfQorCiAJLyoKIAkgKiBXaXRoIGluZm8tPnBoYXNlc1tdIGxlZnQgdW5zZXQgdGhlIFBNQnVz
IGNvcmUgbmV2ZXIgcHJvZ3JhbXMgdGhlCiAJICogUEhBU0Ugc2VsZWN0b3IsIHNvIG1ha2Ugc3Vy
ZSBlYWNoIHBhZ2UgcmVwb3J0cyB0aGUgYWdncmVnYXRlCi0tIAoyLjM0LjEKCg==
