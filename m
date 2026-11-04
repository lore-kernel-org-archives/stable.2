Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793782596;
	b=CM6fSjjhcdMKDolEP3wGFWORFqlWsg1gTRTzlXxksbcco3cFA92hVV93d9qeBhv/gjXa
	 y0S3YTLScOqRlLvn18Q+OmyMJwsXOY5BEoYwQfi3I2MQfDn1MpZQyzgy+0478sfMOklc6
	 yf7NOIo7oL1sm6wyeW6DBhr52CiWDAaMhBMZhXB33Zr28vM6Ghms+8JdF8guQZBfV2vrC
	 xpS6y0Iv5PrTOeUiexdfVRjnINiSDR9X/PK2M31q27w1dPfccJg/3Beuabyb2NRbHhyUp
	 7bW+0pSZMwflcd8Q5wqoXZKfB1y5p3kLoSnCnAizDYsFKVA2rj8Qa/mO6uOl5oX1X5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=37BUbC4dVuDuYU1kwDyBQHxK4mKmnBjBuvL/xlt9Jeg=;
	b=bZkhPwIZJPhpwLN7R0z+c2V1MzdIcDQvg3JhXII0qGV12DJU37rJgeGCayRX4Ck2ac42
	 lTtiA6x0LRcIZhDdR6cvsbdz9EcN0nWk2rWkJoKUyMBJ4OBA0uR+Zobt5ifT5hMI6hymE
	 HZUN3kjBgqFbIzd3yPt/koZeTaKQ+FI4f6pBQkCY3ZmTchTwm11meEp2vr7QlE3qnb0j9
	 AK93bso9XcndNcMZ03e7ZhadWR8bntQ2y/G2fq/IyMyQfAVI4tWsHPbDx2aPkXnuEyYVJ
	 HJGpMNWpBxDnH36A3Kquw8X923GaqDt9foSmNBCJopzwg1dWR0DMlrJS/mIDNowQqTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b="JIDxBi/J";
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=AlOSwtxJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB24606A326;
	Wed,  4 Nov 2026 08:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB24606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JIDxBi/J;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=AlOSwtxJ
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48J3kI1287148;
	Wed, 4 Nov 2026 02:56:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=37BUbC4dVuDuYU1kwDyBQHxK4mKmnBjBuvL/xlt9J
	eg=; b=JIDxBi/JUocNjQyKI8qNyR5bHzsPvYKp7wOX4n3ITBCvFTcAi3w14wHFQ
	IJ6VXa7rvxd5cjNcDwtccoBoZZFKcCuuoXdZti8Zrz5sZPRF/Cm3On556eYXQRXO
	pugmbdXMqybq1IXawaGK+nv3mhhkOQrveCI+TGzZ/32ac07R0hj8GHrVhSjqPapA
	RA1HfzLfyOKxcSv+CFGEnBQL3hEdInbpP+KrcnT7bpJhqOx23E5MuSYyNFWBUR2E
	sIWfV5p9YCid9hbee04aT9i0SscltmXjwae1piSOt/oU7rvt3dN6arn8YgLiTgZz
	QD5i541xDsxzLY5ClxUQ5A4Ar2H1Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hquyf1uv3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 02:56:28 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGpt6otQ/DOycD0uReoA7Ga64dLiKz9W2gtxh5u7SQB6/wpy2QxsRH9xBL/fCBT6qtVcURh6+IWm/hhLYxRdZn70YpDwp9KwVa8ZrgH8rE3KKHqeG9soiMk25KQRh8TqCdXHm3GDK26X5zJOu8Ppw4/seCFcQRIvf3+6BQhlmYX5anLyIDru/LV9wM1J5NpBO7eZYnRfW/r+QuuH4Z80CqLZTKprruninG1dKvqG8evooOBHQHm7SxuReVsY4nXaozLrBrWD3fQVVxYl3xNneG9HJkJ16QqJxo116JRsntq+veh1KouX85viqhM9t7kcKlUDhMvdCm9oyIZRknoMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37BUbC4dVuDuYU1kwDyBQHxK4mKmnBjBuvL/xlt9Jeg=;
 b=K4BKAJLiSbE8+ZvzB9zt4lLpK6sy+VY7a68g9n7WNDfU5qrofEuyarvTi9BGOMWX+J03ngxgb1FP+DyQze5g/RvWC8g/j+KjXwYrdHkVCvZ0mc2sib3rdxNB56BPoQG8qw5i+lSLRTVixJDfezb1H98lir5IL0ZWibuW1EYVZEQucs+GUpp1/4+w8O6P/2/N5xSxF7WvYJcQIIZGdKitEO0lcuQGdoMg5VHz0s2ZjPn9ohu7DRo/s/KG3dwRGkmXVmN8RDvJSgsXBEcngmFoNXtzcCie1EbP+HBek5S822KD02XW6sdEsOnkmXLcc0ArV7tYzwOc1NimQS1kMyPpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37BUbC4dVuDuYU1kwDyBQHxK4mKmnBjBuvL/xlt9Jeg=;
 b=AlOSwtxJq84TMNwyHxqCuDSbIw17xktY/+1LdO0KES4vJEjRL57ffuaTU0zIR4z0FLiguJZX5a6yEw4ZLqsacCTRLkUXSOAcK1plLX8l0ekQs9Sh7+cborObX4bKIK4NxIDPh7YyQwVpR+568zdfX+JUfJBRplCzYQLPUafGQWc=
Received: from PH8PR10MB6645.namprd10.prod.outlook.com (2603:10b6:510:223::19)
 by SJ5PPFD9B14F409.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 08:56:27 +0000
Received: from PH8PR10MB6645.namprd10.prod.outlook.com
 ([fe80::8985:7ede:7087:7bd7]) by PH8PR10MB6645.namprd10.prod.outlook.com
 ([fe80::8985:7ede:7087:7bd7%4]) with mapi id 15.21.0546.025; Wed, 4 Nov 2026
 08:56:26 +0000
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
        Vinod Koul
	<vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        "tony@atomide.com"
	<tony@atomide.com>, Daniel Mack <zonque@gmail.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Panis
	<jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
        "Francis, Sebin"
	<sebin.francis@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] dmaengine: ti: cppi41: Use td_queue to restore
 DMA_TDFDQ
Thread-Topic: [PATCH 1/4] dmaengine: ti: cppi41: Use td_queue to restore
 DMA_TDFDQ
Thread-Index: AQHda8rimvmcT1o2wUKHX0/gYbvJTrcdnSaA
Date: Wed, 4 Nov 2026 08:56:26 +0000
Message-ID: <a5c8dd71-a1bd-497f-9711-e7c1b7d977fe@ti.com>
References:
 <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
 <20261103-v7-3-topic-am335lpm-cppi41-v1-1-d7213446c5f5@baylibre.com>
In-Reply-To:
 <20261103-v7-3-topic-am335lpm-cppi41-v1-1-d7213446c5f5@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR10MB6645:EE_|SJ5PPFD9B14F409:EE_
x-ms-office365-filtering-correlation-id: e2e604c5-1a13-422b-fc90-08df3a5182a1
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|261102123227099003|22082099003|56012099006|38070700021|4143699003|261021121427099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003;
x-microsoft-antispam-message-info:
 Ic3/twoXaHGq772/29sbDKwOfN94QZrA4c8jVtP3Qc/LjNG/ruOgb2tbO0HRqgrPFmg41yQIQLtBOmpO7U9M/xL9NQWnq/Ng3ENoMxeI2R8PCMd2SwYHLe2N3IUZpcDv7cOd1TyKzBq0pbyqhLPKX9Q5P10S4V2tX2QHOw1tY45KR3KmdUiEs4hkGQI8XJnapKt2vy1F5BXdtE1YETHolD9HKJIGMwmWh+Y0l1AsL1nCtAtWVerYsNckbXsfGKbFcl8qxUz+bhAX2+iuqrEs7l7DUqZYUws4sc4PUaeFTHx5Q+cO0KojGlMbHljk9/3S3x/XSdZL1LQqEDcZLATIMhPWFjFvrG8gfnKQUJBJ/dfkSJa1Rd8GyBBQpOZ6ZTvvNIBivhjSWznpKnj1zKaZyyoe44OcZ0ankPHnt3f+48YTl8zMUIg5GgWE2TPZ/fqYM/QFUWDchzeJY4SpOTg2eQ1IQKwk5UsM5XzTj30oJ2/olqe8cQf+zlhu2HQvoWHAYgH0+XvIKbmezrA5e5wDposOh+Of5rnO13y4r7tAw8WZYCal+o9HrYdo2wTebnXHdLhVuiCXYzYyKbSVxX5jnPm3hJKaKgdbWSv+gLXeTHvlj+lVmwDMbBDt5O0rgm5iRtBCH0MtDkCPFIVyq2uinCYSf1ZKNDCeapi4lSS9ZmnmyVjNXrcLUEq5ZpY1s8G08h0PJ1TLAFkmpB9tImD4lgV+3wJLw3oRie9tHj7ccJQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6645.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(38070700021)(4143699003)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wi9xVm1OOEM3MFljVG5ER3lMcHdGNkgyVjlSME5KeFBGbnNzclRldlppV3dN?=
 =?utf-8?B?bjlScVdaKzhNRzR6ZGJST0RUUVM3Y3lxNE51M1BweGs2QkRiRUNwM2VPK2cv?=
 =?utf-8?B?aFE0cVplREl4Sit2NkNGMVdHMlRneUc5eDRzTmlVWmlDSk5iRFJ3UHRtTEV4?=
 =?utf-8?B?a3RFRFNYaDRMUzNuWit3OEcxektCZW4yNzBaSVJrNkFyTURxS3lEaHZJYU1V?=
 =?utf-8?B?MEF0SXEyL2tNYWc3aSs4a2VwdVFaU296dVJvL3NHR3dqNW93SEtlc3JmQzdO?=
 =?utf-8?B?b2pCZVhKb1JlNGFjYWtPdlZwbFo1UktHb3dYOGFTczFGYzVSemNRUWw2R205?=
 =?utf-8?B?SS9iWENKU0RrZ1dYWTJRZFdDY3ZnZzgvU2RRRk9YL3A3N3Z3ZGs2T05qM2VZ?=
 =?utf-8?B?WEsxaHRveGs0cGttWXhIUmdPTHNEOXhrNXpKdkVpWUU4bGtka1QxMVE3RWdz?=
 =?utf-8?B?bXp0d0J5Unh4bjJPU0VpUUFYeEVtZXhRSE9hNjBWWVl0Rjh3WEhvUlkwK2Fq?=
 =?utf-8?B?eUJacnNjS1AzOEQrSTZvZTc1V2ZLV2dRSHJnbEZDZzgzSW9tZHVHd0NudjNP?=
 =?utf-8?B?T3dzd0JpN2EvbWZxVmZhZUsxZjVMYzFrRkNvVlBmQitGOGx3bW1ibjN3bGhS?=
 =?utf-8?B?Wnc5ZjZnVkRtOHRaRGJIdVJCaUhFZUFSZkxTWVZCN0ZrcVBMNENUbCtmb3BR?=
 =?utf-8?B?QVdldnNpa2hIcG02QWhCUkZGNFllZitDdjBrQUZIV2VlQ2t4L3NDWTh1VDlO?=
 =?utf-8?B?ZG9RMFltSHYrWnNmM09PajYvOHBLeCtnM0tTS1pZcHFxRjBUOWM2MFVqU1Jt?=
 =?utf-8?B?UTNSalloankwQ25BMlF3UEszOStNNWVJSzVZNkZyYS9uM3pBQTBSc21BMUE5?=
 =?utf-8?B?bllEZW9ZWkh5YW1CWUkrV1U3T3FJU1hMM3Z6VHVxc1lIdVErU2Ztc0c2cWhC?=
 =?utf-8?B?czdZYU5DT05DOGZOUEtxeVZVYTBYME1rZm5sZWpNdURMK3BGWTFQbFpPQmxa?=
 =?utf-8?B?RHJvL3YySUk4VWhRUkQ3ZHRjQVlQcU9Ob2hMRmF3NWhUZG9BT1FJbTgrUXJG?=
 =?utf-8?B?U280WjJ2c0Y4QXFia1pNN0tVVVJXd2phOTZQVFQ1bkI0VDNmVU9RaXJFaFha?=
 =?utf-8?B?V0FqUnl1Si9vNTQ2NWNJMEVGT2RrM0t0K0Uzdm9HdFZmU01MMldiZWdWNWh0?=
 =?utf-8?B?UnJINlpTaForQThGOXBsYTFTYzJuTHgyQXI2MkdwL2FQLy9GUm5UdStqalRV?=
 =?utf-8?B?WWpLUFZFWE5STHgvaUptUzlxK2VSNGxRcTU3anhnUEF3VzY3Mk11Q0JMZWRy?=
 =?utf-8?B?Q3hGSmppTFRySFAvOFBENnJ1ZjdFZWN5ekJBUTkrM3NqSkd3ZEJlZUxoZWlM?=
 =?utf-8?B?ZzBCNlFWaEF1MlJDYlNLL1hnakpKWmNWaEZDMWJkRjliSjBXVW5WOWtoUUZh?=
 =?utf-8?B?Ymt3YVZQWGVscmlydmxDUmtHQmNzbHNwVGk3SFhNT3VSbUUxUmU2MHFicG15?=
 =?utf-8?B?S2tNV0FyVGo4TFliQ2kyZ0pKWDNkTmRPZVdQcUhXYU52VFJSdWRZTWVLb0VT?=
 =?utf-8?B?TExiaEFKM1lEbTdzM1lYSTdiYmcrSXlJR2NnMm9YZ05uRERrVFA4VHczZC9o?=
 =?utf-8?B?enFyS0d2b2hqY0JsWWpJMFlKWTFhc2RPa3I3WXhEcHNtTUNRV0xyYnJEU3pF?=
 =?utf-8?B?Z051YlhNVzNueE1sbXgvdkZzZ09Fai9RUXRGbVF2MWF6K3o3cmRmWDQydG1m?=
 =?utf-8?B?a1Y4WUdyK3pmZHJZTzNDRVpwNVcwRU52QWlqcVJLcHMyQWVZbFNvb0o5VC9x?=
 =?utf-8?B?SG1ldGNob1NjM2UvOElRTTZPVzNzYUhEUk1sRzBoUE9YbUx3M0U1MFVEK1JZ?=
 =?utf-8?B?enI2aVp2QUZ3b3l4L2o5ZG04bmd1VXc2aFlFUUZXSWNObzFNRU5WWGhBWk9h?=
 =?utf-8?B?bTEvT29sVzBaMGk5QXdYOU80VTd1MHhsMDhRL291UmVVTFBJZWdPRzJGcTV6?=
 =?utf-8?B?UU9iV2JyMDd3RSswU1hxeWxaZUdSQnprSUdEM1B5YjhDZGNkZHJtMmtwZFlr?=
 =?utf-8?B?M083WlYza0NzMG1pNU9PZDN3NFVueXdxL1lZanpCRUZNeUxKTjBjZExjUk1O?=
 =?utf-8?B?Q0syc0J6d3BGb29yalk3SThsYU81MXpNdytxalQrOW9tN0NPeGxKcEVyVFRD?=
 =?utf-8?B?R0VOTE5sSUZEMW5wMXZKSVZuUlNveHUyS1VBTFEvVm5QaGd4cnZLTS93RmdI?=
 =?utf-8?B?NUNQZXhZRjZzUXhiemFreXFCalB2TEpYSEJBWkU3d1ZrN01pL29hbkxaWm16?=
 =?utf-8?Q?OdkCqyfVofgr4o2mnQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F539CC59A3EEC14584A9C446B0FA7D02@namprd10.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked:
	S0X8o0Xt23+/RqL1xGn8POVQJzbhUBZ11SbT9/m6ok2CKaCUjbK6ORqOfE6X2MSAbiugysaQek/aj9/DkHeaudFaxlfP/LLUZ6bmYl736HiEWifcL7PUT49TOcwzKHRwjnB7bleNLqkBQZc2FOYgzrKrF7lfxwZcNGgJxpl3T8acnL6MgttLZpFfZMWwco/zbyd1KlLN0FSIPqKNGUwYRbozAIkVsYS9KbCwnMddNsIsbBvtTftqftdrZ8yv07E9qQgRY8+PmLO0LIQs+fBAa2yDl5KNgWr7bazmFdYVoH/jH7lwiUawABCSTR7sB93SWKquwCu+ywDjclgrePl2eQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6645.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e604c5-1a13-422b-fc90-08df3a5182a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 08:56:26.2955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thjYpTMkP3QVxZZcoWeX7Op6XASUWdMf2SeFQ0DZd6MWqiTZXL4Ao3ifUVt1aEWL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD9B14F409
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNSBTYWx0ZWRfX31mivNeYnWms
 nd9sGcRyh76Oyx1fmZVAEDidE27QX70TE+achAliKOybDLJ2lhKR8yAkocwfKUnNwhBS1AurRcV
 6j60xULq7qg10+SQ9gOfvaeU1d33erW+/+n0g1gvG18rzu4lYrSE6e6O37KX3sfvWlWuAneiVAs
 R9wsqpraRPSoIgw/CbnoFYZqdIC+y0he/iAzzohp8WtYm5VufAVDTi2UYuaUPwg8y16j46mTTT4
 4RCyf+Byg2iIc/ND0vXYgPB6GfFJ9e9GgoQ59Y25blfpuOBCJrldOkLFHypc1comuaxYfGXttp2
 Lv1Ig9h035Wswt/bJgid4zzPCtkTGHou9Jmz9nnKc7L47sphm3b1WoUEuSThRyv1LEzCD/SocL8
 kexmWQuSQSe5CrylfFDc3NTihdEYsGn77lDi8HhDVkcfdRZon7GNfQ8HaHw2eTbPWfLIfpylzHP
 ePR4ppWMjcEQSrOxYcA==
X-Proofpoint-GUID: xLsK01MCdmiNx1q0ReJ97QW-ydaFAese
X-Proofpoint-ORIG-GUID: xLsK01MCdmiNx1q0ReJ97QW-ydaFAese
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6aeaf33c cx=c_pps
 a=6KAf8mVNDH8Ped3ZwZ6wqA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8 a=aGiK9FGqiIc_kEH1XGcA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNSBTYWx0ZWRfX9jtM23+RKnqG
 otI4wvSWQBhjCJkSws6jutsF1VrTk44SjnitZ8RvBVOiRwRMfD355+Issq/WU/4BaY9NHVE1DQU
 Bqc7pZvHUm8q9lu8ELF0XNjCpgnHmKQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040035

T24gMDQvMTEvMjYgMDE6MDcsIE1hcmt1cyBTY2huZWlkZXItUGFyZ21hbm4gKFRJKSB3cm90ZToN
Cj4gSW4gaW5pdF9jcHBpNDEoKSB0ZF9xdWV1ZS5zdWJtaXQgaXMgdXNlZCB0byBzZXR1cCBETUFf
VERGRFEuIEluDQo+IHN1c3BlbmQvcmVzdW1lIHRoZSBzYW1lIHZhbHVlIGlzIHJlYWQsIHN0b3Jl
ZCBhbmQgcmVzdG9yZWQuDQo+DQo+IFRvIGdldCByaWQgb2YgdGhlIHN1c3BlbmQgcmVnaXN0ZXIg
YWNjZXNzLCB1c2UgdGRfcXVldWUuc3VibWl0IGluIHJlc3VtZQ0KPiBhcyB3ZWxsIHRvIHJlc3Rv
cmUgdGhlIHZhbHVlLg0KPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQt
b2ZmLWJ5OiBNYXJrdXMgU2NobmVpZGVyLVBhcmdtYW5uIChUSSkgPG1zcEBiYXlsaWJyZS5jb20+
DQpSZXZpZXdlZC1ieTogU2FpIFNyZWUgS2FydGhlZWsgQWRpdmkgPHMtYWRpdmlAdGkuY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL2RtYS90aS9jcHBpNDEuYyB8IDYgKy0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9kbWEvdGkvY3BwaTQxLmMgYi9kcml2ZXJzL2RtYS90aS9jcHBpNDEuYw0KPiBp
bmRleCA4ODc1NmRjY2Q2MmMuLjQ1OGQyMGIxMjQ2MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9k
bWEvdGkvY3BwaTQxLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvdGkvY3BwaTQxLmMNCj4gQEAgLTE0
Niw5ICsxNDYsNiBAQCBzdHJ1Y3QgY3BwaTQxX2RkIHsNCj4gICAJc3RydWN0IGxpc3RfaGVhZCBw
ZW5kaW5nOwkvKiBQZW5kaW5nIHF1ZXVlZCB0cmFuc2ZlcnMgKi8NCj4gICAJc3BpbmxvY2tfdCBs
b2NrOwkJLyogTG9jayBmb3IgcGVuZGluZyBsaXN0ICovDQo+ICAgDQo+IC0JLyogY29udGV4dCBm
b3Igc3VzcGVuZC9yZXN1bWUgKi8NCj4gLQl1bnNpZ25lZCBpbnQgZG1hX3RkZmRxOw0KPiAtDQo+
ICAgCWJvb2wgaXNfc3VzcGVuZGVkOw0KPiAgIH07DQo+ICAgDQo+IEBAIC0xMTc0LDcgKzExNzEs
NiBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGNwcGk0MV9zdXNwZW5kKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gICB7DQo+ICAgCXN0cnVjdCBjcHBpNDFfZGQgKmNkZCA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiAgIA0KPiAtCWNkZC0+ZG1hX3RkZmRxID0gY3BwaV9yZWFkbChjZGQtPmN0
cmxfbWVtICsgRE1BX1RERkRRKTsNCj4gICAJZGlzYWJsZV9zY2hlZChjZGQpOw0KPiAgIA0KPiAg
IAlyZXR1cm4gMDsNCj4gQEAgLTExOTUsNyArMTE5MSw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91
bnVzZWQgY3BwaTQxX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgDQo+ICAgCWluaXRf
c2NoZWQoY2RkKTsNCj4gICANCj4gLQljcHBpX3dyaXRlbChjZGQtPmRtYV90ZGZkcSwgY2RkLT5j
dHJsX21lbSArIERNQV9UREZEUSk7DQo+ICsJY3BwaV93cml0ZWwoY2RkLT50ZF9xdWV1ZS5zdWJt
aXQsIGNkZC0+Y3RybF9tZW0gKyBETUFfVERGRFEpOw0KPiAgIAljcHBpX3dyaXRlbChjZGQtPnNj
cmF0Y2hfcGh5cywgY2RkLT5xbWdyX21lbSArIFFNR1JfTFJBTTBfQkFTRSk7DQo+ICAgCWNwcGlf
d3JpdGVsKFFNR1JfU0NSQVRDSF9TSVpFLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9MUkFNX1NJWkUp
Ow0KPiAgIAljcHBpX3dyaXRlbCgwLCBjZGQtPnFtZ3JfbWVtICsgUU1HUl9MUkFNMV9CQVNFKTsN
Cj4NCg0K
