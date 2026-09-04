Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EC1E7C02;
	Fri,  4 Sep 2026 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482415; cv=fail; b=RqqYQfyUQpfftSOyXn8oKblRRPrXBD7ojWfin5x6gU3eT2DDFyTg3JENVkmp7TbPBsLSlz5NxSmaPEIWQbGX4GTfcDgi3QrLb5OJ8gp4nXE9VwM3bPhwyAUi0kIZ+2PNy2C8cIyTXqwX8A7P+9Mv4qH3MJLlJzZp8cZ3+kYgzfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482415; c=relaxed/simple;
	bh=7m8RhS/SB9O1nCvVgfZ33hR5fHUJG9LL5B3CFi7YeKs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Aj06+YtSMEQXg5rDsfoVlhHFQZNVpt0BKnFfso+nbJg6Rv+M9nKIxwxVybxCXrGXmBjyYzhsswruM7hDr4VxBi1xk2y55kX6VFZltkVPSz4HIPOPjDGp7K3mXG9HeYo3PhxlXW3i+xgokawbJ6/OdfWE63/XCAnExt8EbaUU9l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=UrCyjc0E; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="UrCyjc0E"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683NgDMO4052080;
	Fri, 4 Sep 2026 00:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=7m8RhS/SB9O1nCvVgfZ33hR5
	fHUJG9LL5B3CFi7YeKs=; b=UrCyjc0EXVsOb1IzBFhzQHEfEf4wPChY82B5zXRi
	KSM1crGe2O5mW5lw7L0+Uz6kvlexlnOxoDIdJM902EBUIFZI5zew2LJtRNBLSMtf
	rxYbU4ycfuQE6HymElqbLSPGxS5F8MDzWjFDy8DfNAtphk7ouJ3fOaUEESAYiSCN
	ZntMwP/turG3xMKcA/rY84dYnu7Yjj3HNwDGTuOnlhUQZ0HVjM3IUy3FAARRcJ/h
	d2dclLkBcDeTpf0Ar71ztbrJB4WVcNIEQ2yBmqicwik4vD8r3/B4XutxSZwKSPW+
	dvakfVY87HVvQn9SL1vYWrnarKQkt6PdBqLo2ysiy+dk2g==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gfcgwdvxc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 00:38:59 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C9CDC12B65;
	Fri,  4 Sep 2026 00:38:58 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 12:38:32 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 12:38:32 -1200
Received: from CY3PR08CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 3 Sep
 2026 12:38:23 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRCc8dh9oiqKXaHaQ8HTVQzlO4LuCQjvTK+1+2xKiJj4czkSCUgzyTbCPxD6D9B/q3mybYCyvl+RyGNnAIYZ1M56ASNrlko+2fHNDQU+dJY6EiBpNsoG4OA/qzoj9U9fD3A3BZ7J4w2akQbl6Tv9Qc0kkuQrhbX3wPiMCTDZ45IkrulBhM9Jg1Bw5K0XhSgKAZreyKBGwVClKJMkAMT5l4TtQ8Q+67J+hlPU95Eo/It8ws9RgobqaaVYYaY+Gj4VSWwq0ac/14NyJZGlsQESCfevTVHB5edwsZs3+bWHbYkc7JYH5DcPPLDrgxasZ7BloT++WSKpx4k35V+uO3ZZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m8RhS/SB9O1nCvVgfZ33hR5fHUJG9LL5B3CFi7YeKs=;
 b=a+G5q855B7dM7RAe6vjxgsnJuB/LxpPr+qXOSIrhhYWs9pc4cpe/Ri/Yqn5hWxdW7H4Zla0VMkxw+iLHK6ageHMsiu/RloSe37grPrnnXcvg/Bk9DmpINZCgdOVQQUQzrpSldV/3ZGomsGWcaOrJNJq0GPip+hgt8snWonEfaLYulNMxf08KZG1BOHuDPG+k0uiEFsk75MlK7hgr+2yQ4loyuc9n3KdE6Nbv5raPDLXMh2hb43v3MPXi8nlg6l1Mny5EXGWoDFkJlDml17gV6PPviEx5WnrBgBk9QJa21p2LSBg+5Ej5dr9IQlI8qldDXvB1/4RHfEvwGMSw1vwAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by IA1PR84MB3036.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 00:38:22 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 00:38:22 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Srinivas Kandagatla <srini@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
CC: Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Freeman Liu <freeman.liu@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] nvmem: sprd: fix out-of-bounds read in sprd_efuse_read()
Thread-Topic: [PATCH] nvmem: sprd: fix out-of-bounds read in sprd_efuse_read()
Thread-Index: AQHdPAWwnXDlJpXBukm6b2+ZdfqpGw==
Date: Fri, 4 Sep 2026 00:38:21 +0000
Message-ID: <20260904003815.462352-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|IA1PR84MB3036:EE_
x-ms-office365-filtering-correlation-id: 6d37485e-be4f-4065-739b-08df0a1cd2a8
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|6133799003|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info: Vb/vgEnfWD4MvuBRvA84uH9t+rmHZ7WC6mZhpWyMC8lUP9xM0rwVuaW41YRkzRaSwZdG48OK5jD8L1XVGEDmDbtloMlOCd2p1H7WIA1/J1S2tMcoREQHWUU8QSgbL4ukq5u/Xqhv6r4UlZI1qKkQWSh3DuF+39O4OJFOduZWoNpbHiXblJDKXCRfmvUkc8P9q73TWz7V7y2Ue/Rk2YoekgSQQZPWGv8fTQkB2WX1yWlfPAr1QTnxrXzO90g34wi2QOTQRMKNRZuWsApZtDEjq1NRB+bHCmqiwerQ4PKM2f+VdcJXhuAH1OTPoqx/RLDbdafQLWuF1QopPau3EnL1TFTXCUjwBkO2Wx9sJQeFY9R3UvbNJ90dEyaH04WzJo5bpJ8tH66wViLN6i67gXp+PcgEJpIcyMTHLBqMuhQiiJ7mgw+/EGZKIOSXsp9OdGelfSy+qu+JoLL9BpaJMu9qrB3pX6YPoVg9adSV5ASgiurX5Ppfa3yxl6is4RbQRjYdyv6b4yCDpkrWhW2opuB6yDOPNfEvyeR9xF2MFkjwWyQOUEx8ye50z1SttQ9Z75jHJqd/1aSRiKYqbVGV0hipo0N1rWS6YcruVRQlLKjwXHWXRxpxsQac3syAxJhbYO6b8kuK/bCmMqyCiAARwLkjGqOfETzuaesar3ysgM6q+9w+rqGuDWhcbf3RUwwEjNw2F60NyblMPgepH6d6zETXBYsczvkg1pXma0ITNranLe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0dMcEIrbDFCQUdSRkhuL3laVk9JY0JKaTdIQ2hmUy9sWHZ2UFBnTXg2UnhP?=
 =?utf-8?B?UEZ6cjE5SDZ1UlphU2NlbStEaEQyMnQwMTNlLzlrMzlHb0NTTTJRQTE4MDhy?=
 =?utf-8?B?TjlLeXh1dlhwNDZHcUNNNnVXQmpzVGZvWEpTYWhBQXRMNW1iYXJIZVZTSjIr?=
 =?utf-8?B?TmtUSm01d2NlMzRva3JGaVd2VklzZHZhbDU0b2lhb0NjV3NRY05jZS9FdmhR?=
 =?utf-8?B?WnkrbC9DSkFqOVkzb3dyc2Z3anhlT2NsME1hQkwyMUV2ZXgwbFZUVGw3RHVD?=
 =?utf-8?B?UDJqcjJXbVNGenY2UEFVdk5VU1JYYlgwOVM2d1RPd25aSy9CSU40OFZkenJ0?=
 =?utf-8?B?V3VxdzVJSDlGWnNlamZxL3FsdVFCd1pXOHc1d2dwN05OVE80NnpNVVM4S0tX?=
 =?utf-8?B?MUJjZ2FxZDlkdjJiaXZjQitOdjhIM2FBeEdWcEVYeEI5NDl4TmVQZDg1Tldj?=
 =?utf-8?B?SnlKZGk3cndtc0JxNllUVVR0c1hsV21Pc0ZUZmxrMDJzTU1FRmMwb2wzUFJK?=
 =?utf-8?B?ZVU0UkNkYXNZTUJYbGZlc1BpVlN4L25IdWFsSEVCNnFPcFpFNG5iTWJHWGlo?=
 =?utf-8?B?TDE2QmRnZXg1RXZVT0hyZ0VCczNCcnFyMWFJNStIdnZSdWtlZFNNQnNjNHlR?=
 =?utf-8?B?QlVhdTVjblF3U0pTc2ZSRzNQTkphQnA3RndhRFovR25nYVplbjUwZWtoaWZp?=
 =?utf-8?B?VlhvTjdycjZQdkw2WTQzYjFUZVduSEwxWUxOYUtVTUc3OUUzWWNkNWlwZG45?=
 =?utf-8?B?NVlKUEdTaTZXZEFIbnQ5VmxjbVNzVzQ2VG8zOWtyc0RBUGdDMnRxRDBYTXlT?=
 =?utf-8?B?YWF4cUJlUi9xcE5lb1N1ekE2RlpVV1gzTUpJbWt4anhkVkdIT0VTZkwwQXVa?=
 =?utf-8?B?emVoeFp6VExJcU9EV0RkUHpuc29xUXZJRHd1aTEzWDFRY1Zpb0ZRdFFYdTN0?=
 =?utf-8?B?Rnd2Sk56NlRpSjhlaUdZdkk4ZzNLd3kvMWxOaW5QU1pObUxtN2M4L05HajA5?=
 =?utf-8?B?WXY3ZWxsMXVtU2ZPY3NDc3U4YktXKzZTZmg0dnpXTW9hK2FYOWVEcFgwWit2?=
 =?utf-8?B?TlB0UEtqd3k4ZGZRTmhPbGd6SWRMY21kQXcveDBJV2RVbkMvMi9VYlN4UUVI?=
 =?utf-8?B?K2ROQnZtNHA1YTErbkxJKzg3K1UvSzdFN0tuZmhXZGNIRmV0SFVPUU1DRzR3?=
 =?utf-8?B?TXh2V2VMT2U3YThCeFc0dXFKVWdYNThDSld0RExERmtPdFFVUHo1b1RCRS9C?=
 =?utf-8?B?ZmppL2RpdlAra3MweUF2Qy9yeThiZE9QQWZkeE9vZjBjWnB1bEliMHNOWWZS?=
 =?utf-8?B?UUhZcnlReXMyV01ncGZoby8rUy9Zb3BUZXJWeUJjZ0pTMmNrbTBzVGJVTTh1?=
 =?utf-8?B?RUJ3NmhCRUhiK2lVY2ppNXRaMSt2eUExa3RLeXNtZUptTW9TMWpVMSs5RE9C?=
 =?utf-8?B?YmhNSFg4SXNLa0tHSU9hdUt3MVgxREt6K3kxK2hQc1l1K2kvM3dVbVN5aE96?=
 =?utf-8?B?dllRUUNLU1g0UnB4YlhYdElhcTRBTkZpRDFxNWI5ZkczaW1qV0NnUHgwVjEz?=
 =?utf-8?B?UmkyTisrcXlxYnU3UmxVM1hMbi9CUjZkNmgzWXNBTGx3aWlzY2tLemcwbVQ5?=
 =?utf-8?B?NE96OE1wa0ZVYWUyZE5ZdjY3WndyWWpEaDlEUHNKQVYyVUpZVU03NFQvSTdH?=
 =?utf-8?B?UFcxa0QyUTZkaG5iL2lhSmlMN0NuU0NWZnZWYXR6MDRNMDZZL0phUS9JTEw3?=
 =?utf-8?B?dy9yd05kd0huNWVodXhvcEJiV3dBdWsycitXTEgvSVl0OXJwaDBvY3NBUlg0?=
 =?utf-8?B?MFJuYTNFZGNHL3lzZmR0TXZSMTQvMWc2L0FsOHh2VFJaTmVneml3VUorUE44?=
 =?utf-8?B?QnVZbUpybGp1YUhEcmNWbVhKQUc0eWNBbUxFMGNhU3Z2eU8yaFNseEF2NVhY?=
 =?utf-8?B?QTRUemVDL0J1Q1J6MHF3VGw3SlgzZUR1R3JJbmQrd2NNUWtBSE5ESWxEYzRU?=
 =?utf-8?B?TXR5c0hTb2xZVTIzSUcwcGdoWFNmdStYblpPT3I0N2xONG1EaktyTEpKZG1r?=
 =?utf-8?B?NDI1MXJBRGNSRTZHNFM1RW94cHJiNGhDQkZvYVBFZkROeHJ5N2ZrelQ4L3lW?=
 =?utf-8?B?UktCdm1XNE8wVVVyMjlvZGpNUjI1cjk5M2daaGJrRnhRZ3VnTEFIMm1JTEkr?=
 =?utf-8?B?NjkyMnRhQjdSNkg0VFk0NUtXZjAvQjdmalF0NGxOTTYxWEVaN3F4WjRJemlx?=
 =?utf-8?B?MyswNnhjRUFDN1lUTCtTaTJUdnMrVXNqWTNsUHF1Z2tsUHZZeVl4TElGN0Q3?=
 =?utf-8?Q?uYSJXpADPwaPeqqpaI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bGuMTyZRYDq1CzdyF4UVxjTxOCLSG2mXI3+IsxM3uFsNI2VVEXQObvbD3NUaqwNSQnAcRQzEXabJjdXE8lW7TuI/J2LmLkHD2BHKRoLh/pomjiI9cs7dUf+ZVASJ3FnP4v2zV9RIe/0/ubDuQa/AlE/OUKuod5nYV8THjS17mHR9f2Ith7DJHX+lNXaLSNubB9xAaOW148dhOVt1QEq/CGyVqidDyfmZrUTJ1zpecmJoIs8xFGQchbW37PPI/kQUSEhuFVYZxGCmoq3i9VzsZnIuvxcglsZkaNuzNLgdkqJT0GJ3phwkU9eoNwH16C6Iban4EAcAFF8Pu/3t+rIFkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d37485e-be4f-4065-739b-08df0a1cd2a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 00:38:21.9205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKtBQ4nIp00T+6YuxTb3uFanP3BPT9A1v1aYYKAIBmxGD7uJJ84sQRqoO+4fx8RMRE9MYN/TGxP137ByB0awmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3036
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FQztHqyoWCbgI0QIPenlgebqFuffflgQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAwMyBTYWx0ZWRfXynVZKg6cezZg
 6YItImviY0xnCKdRBabsgSVYbkHXAMp9VBtiUl5puINYSF8pBwpdWJUGhDwcfckUWLZjCFPqtTp
 egnC6qJRFi1droPY+k+Bca0h/ETjKhU=
X-Proofpoint-GUID: xrDXiQDdFTgj6IVfmi2zEhqON3YtyYzI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAwMyBTYWx0ZWRfX8tMx3aLs/sGM
 9Byu2oS4pDv97/hpnuAQ23F1t26bKE3XxGX3ofWqE/viomjUadNQTyP0MWlLrocm8klD9St/fAr
 GNepZw3iL7DbdArzQf4inuknw920+MMvWGSCFsPCYRw3PE7HY9XBcmQ5fIjFA0Diiisf4vgmIeC
 Kel8dLxOZT5Bc4cabtvtBqf8EJM58fsquMlqNoNo5O9BkBf3nZ3jJi1PKTAZxWyRtVA0WPH5JKF
 Ly38lZ3b09IpGSjmCuycxyqMOqrSQAy3XM1oCirUVmSFm7EpFs7mvcL/Jgp7MpTWyu6DSsJeD6I
 EaE3vB9tzte1oE45AB+GZ4mSQA6lI+LZsHX4Z7djWG+qPPOpDwLEXgQTjtrlD1Llta7VgxC2DTA
 bQVTmhcfNhHzri2UCMEwGwHTdrIsTrqofjt4m8kybA+V/LnatBlcn6FvrAuEy0YU1/YGHit0KeS
 UW2uAMaKt0bcJk+MWpQ==
X-Authority-Analysis: v=2.4 cv=Yu8/gYYX c=1 sm=1 tr=0 ts=6a9a1324 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=soih30ZNhZFvilD2-5QA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040003

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpzcHJkX2VmdXNlX3Jl
YWQoKSByZWFkcyBhIHNpbmdsZSBmb3VyLWJ5dGUgYmxvY2sgaW50byB0aGUgc3RhY2sKdmFyaWFi
bGUgImRhdGEiIGFuZCB0aGVuIGNvcGllcyB0aGUgY2FsbGVyJ3MgZnVsbCAiYnl0ZXMiIGxlbmd0
aCBmcm9tCml0LiBUaGUgTlZNRU0gY29yZSBkb2VzIG5vdCBzcGxpdCB0aGUgcmVxdWVzdDogd29y
ZF9zaXplIGFuZCBzdHJpZGUgYXJlCmJvdGggMSwgc28gYmluX2F0dHJfbnZtZW1fcmVhZCgpIHBh
c3NlcyB0aGUgbGVuZ3RoIHRocm91Z2ggdW5jaGFuZ2VkLCBhbmQKX19udm1lbV9jZWxsX3JlYWQo
KSByZWFkcyBjZWxsLT5yYXdfbGVuIGluIG9uZSBjYWxsLgoKUmVhZGluZyB0aGUgd2hvbGUgZGV2
aWNlICg5NiBieXRlcyBmb3IgdW1zMzEyX2RhdGEpIHRoZXJlZm9yZSBpc3N1ZXMgYQpzaW5nbGUg
OTYtYnl0ZSBtZW1jcHkoKSBmcm9tIGEgMzItYml0IHN0YWNrIG9iamVjdCwgY29weWluZyA5MiBi
eXRlcyBvZgphZGphY2VudCBzdGFjayBtZW1vcnkgaW50byB0aGUgYnVmZmVyIHJldHVybmVkIHRv
IHRoZSByZWFkZXIuIFRoZSBzeXNmcwpudm1lbSBmaWxlIGlzIHdvcmxkLXJlYWRhYmxlLCBzbyBh
biB1bnByaXZpbGVnZWQgcmVhZCBpcyBlbm91Z2ggdG8KdHJpZ2dlciBpdDsgdGhlIHNhbWUgb3Zl
ci1yZWFkIGlzIHJlYWNoYWJsZSB0aHJvdWdoIGFueSBEVCBjZWxsIHdpZGVyCnRoYW4gZm91ciBi
eXRlcy4gT25seSB0aGUgZmlyc3QgYmxvY2sgaXMgZXZlciByZWFkLCBzbyB0aGUgcmV0dXJuZWQg
ZGF0YQppcyB3cm9uZyBhcyB3ZWxsOiBibG9ja3MgMS4uTiBhcmUgbmV2ZXIgZmV0Y2hlZC4KClJl
YWQgYW5kIGNvcHkgb25lIGJsb2NrIGF0IGEgdGltZSwgY2FwcGluZyBlYWNoIGNvcHkgdG8gdGhl
IGJ5dGVzIGxlZnQKaW4gdGhlIGJsb2NrIHNvIGl0IGNhbiBuZXZlciBleGNlZWQgc2l6ZW9mKGRh
dGEpLCBhbmQgYWNjb3VudCBmb3IgYW4KdW5hbGlnbmVkIHN0YXJ0aW5nIG9mZnNldC4gVGhlIE5W
TUVNIGNvcmUgZG9lcyBub3QgdmFsaWRhdGUKb2Zmc2V0ICsgYnl0ZXMgYWdhaW5zdCB0aGUgZGV2
aWNlIHNpemUsIHNvIGFsc28gcmVqZWN0IHJhbmdlcyBvdXRzaWRlIHRoZQpub3JtYWwgZUZ1c2Ug
YXJlYSBiZWZvcmUgaXNzdWluZyBhbnkgTU1JTyByZWFkLgoKRml4ZXM6IDA5NjAzMGU3ZjQ0OSAo
Im52bWVtOiBzcHJkOiBBZGQgU3ByZWFkdHJ1bSBTb0NzIGVGdXNlIHN1cHBvcnQiKQpDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBTYW5tYW4gUHJhZGhhbiA8cHNhbm1h
bkBqdW5pcGVyLm5ldD4KLS0tCgpDb21waWxlLXRlc3RlZCBvbmx5IChOVk1FTV9TUFJEX0VGVVNF
LCBBUkNIX1NQUkQgfHwgQ09NUElMRV9URVNUKTsgbm8KU3ByZWFkdHJ1bSBlRnVzZSBoYXJkd2Fy
ZSBhdmFpbGFibGUgZm9yIHJ1bnRpbWUgdGVzdGluZy4KCiBkcml2ZXJzL252bWVtL3NwcmQtZWZ1
c2UuYyB8IDIxICsrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lbS9zcHJk
LWVmdXNlLmMgYi9kcml2ZXJzL252bWVtL3NwcmQtZWZ1c2UuYwppbmRleCAxYTdlNGU1ZDhiODZj
Li4wYWQ5NDI0NTA5NGIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWVtL3NwcmQtZWZ1c2UuYwor
KysgYi9kcml2ZXJzL252bWVtL3NwcmQtZWZ1c2UuYwpAQCAtNSw2ICs1LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4L2h3c3BpbmxvY2suaD4KICNpbmNsdWRl
IDxsaW51eC9pby5oPgorI2luY2x1ZGUgPGxpbnV4L21pbm1heC5oPgogI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L252bWVtLXByb3ZpZGVyLmg+CiAjaW5jbHVkZSA8
bGludXgvb2YuaD4KQEAgLTI5Nyw5ICsyOTgsMTQgQEAgc3RhdGljIGludCBzcHJkX2VmdXNlX3Jl
YWQodm9pZCAqY29udGV4dCwgdTMyIG9mZnNldCwgdm9pZCAqdmFsLCBzaXplX3QgYnl0ZXMpCiAJ
Ym9vbCBibGtfZG91YmxlID0gZWZ1c2UtPmRhdGEtPmJsa19kb3VibGU7CiAJdTMyIGluZGV4ID0g
b2Zmc2V0IC8gU1BSRF9FRlVTRV9CTE9DS19XSURUSCArIGVmdXNlLT5kYXRhLT5ibGtfb2Zmc2V0
OwogCXUzMiBibGtfb2Zmc2V0ID0gKG9mZnNldCAlIFNQUkRfRUZVU0VfQkxPQ0tfV0lEVEgpICog
QklUU19QRVJfQllURTsKKwl1OCAqYnVmID0gdmFsOwogCXUzMiBkYXRhOworCXNpemVfdCBzaXpl
ID0gKHNpemVfdCllZnVzZS0+ZGF0YS0+YmxrX251bXMgKiBTUFJEX0VGVVNFX0JMT0NLX1dJRFRI
OwogCWludCByZXQ7CiAKKwlpZiAob2Zmc2V0ID4gc2l6ZSB8fCBieXRlcyA+IHNpemUgLSBvZmZz
ZXQpCisJCXJldHVybiAtRUlOVkFMOworCiAJcmV0ID0gc3ByZF9lZnVzZV9sb2NrKGVmdXNlKTsK
IAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwpAQCAtMzA4LDEwICszMTQsMTkgQEAgc3RhdGljIGlu
dCBzcHJkX2VmdXNlX3JlYWQodm9pZCAqY29udGV4dCwgdTMyIG9mZnNldCwgdm9pZCAqdmFsLCBz
aXplX3QgYnl0ZXMpCiAJaWYgKHJldCkKIAkJZ290byB1bmxvY2s7CiAKLQlyZXQgPSBzcHJkX2Vm
dXNlX3Jhd19yZWFkKGVmdXNlLCBpbmRleCwgJmRhdGEsIGJsa19kb3VibGUpOwotCWlmICghcmV0
KSB7CisJd2hpbGUgKGJ5dGVzKSB7CisJCXNpemVfdCBhdmFpbCA9IFNQUkRfRUZVU0VfQkxPQ0tf
V0lEVEggLSBibGtfb2Zmc2V0IC8gQklUU19QRVJfQllURTsKKwkJc2l6ZV90IGNvdW50ID0gbWlu
X3Qoc2l6ZV90LCBieXRlcywgYXZhaWwpOworCisJCXJldCA9IHNwcmRfZWZ1c2VfcmF3X3JlYWQo
ZWZ1c2UsIGluZGV4KyssICZkYXRhLCBibGtfZG91YmxlKTsKKwkJaWYgKHJldCkKKwkJCWJyZWFr
OworCiAJCWRhdGEgPj49IGJsa19vZmZzZXQ7Ci0JCW1lbWNweSh2YWwsICZkYXRhLCBieXRlcyk7
CisJCW1lbWNweShidWYsICZkYXRhLCBjb3VudCk7CisJCWJ1ZiArPSBjb3VudDsKKwkJYnl0ZXMg
LT0gY291bnQ7CisJCWJsa19vZmZzZXQgPSAwOwogCX0KIAogCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShlZnVzZS0+Y2xrKTsKCmJhc2UtY29tbWl0OiBjZWU5Mzk1YWNkODA0M2JlMDY0NGIyNWMzNGJm
YTg2NjIzZjJiOTM1Ci0tIAoyLjM0LjEKCg==
