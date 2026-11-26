Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795666181;
	b=4/KLnC+IhBOdskzhNj4fvaNImn4BGA+OD+kDOlLM6idXwP4itpmjKnPi+04goUfK0lUW
	 iKfJPeTan/CsN3ZULRBfPIZx/65LxWJrqgMEto2CRRqink2nAUmuDUAQ/kIAnIO6QTBjz
	 0td2wiLxhefV4tvq0pWNT9q5ZbSXc0QruP9K66DI7n4GWto6aU9CTVXvsIHawsvyjVUbZ
	 l32xEA9aR4EYApy+ItPMMGlLBpbFOWdP89mjX8XXApODUaHqJNmz0G2nYMetkpGlfE4MK
	 tXv4Qglp3QNhmV5fYsDsptTP5AgRx1AGLtl7uDwkyapfWxjRQ0J6cdE8cAXJuaH3Rqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666181;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-Spam-Score:
	 X-Spam-OrigSender:X-Spam-Bar;
	bh=u2c8qNRsNbmxdojvlVyT1isEg0QzTZdyn4owU2VA3WM=;
	b=s1Pg9UXXW6FZmL6HHJviWTAXoztovQXg4LzhFt4naTG3Lo09/1bkG8atbf+jSxR4pdgQ
	 p7i+PHQRgVjGhAZq3mt4T6fLYCfy2OLRyTSCtqbUX3xNjYLFWKq6qL13h3RBs55QyuYwr
	 FkJDFMjkRnNIp1TdpCEUnoztUWQAiVwf8S7shC6Wz8vSfPTyZXujwiT7g/WsjwDNlhae1
	 SKyyLF/5joJdHVe4VQ0F9AizZgsthRUPIHB5+XtQI9VoXIsqkHOMJ4Tet1fGamDohj3Uz
	 pe1Ii8wgynEMke/K9Fi4TkMZCgTnyV4M2B0xgiBqM/e9CL0jGcXiATbkIWJ4sRhLOOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=illinois.edu;
	spf=pass smtp.mailfrom=illinois.edu;
	dkim=pass header.d=illinois.edu header.i=@illinois.edu header.a=rsa-sha256 header.s=campusrelays header.b=XV2f0t5R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.28
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D686606A31C;
	Thu, 26 Nov 2026 04:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D686606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=illinois.edu header.i=@illinois.edu header.a=rsa-sha256 header.s=campusrelays header.b=XV2f0t5R
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ45B2S2532595;
	Thu, 26 Nov 2026 04:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=u2c8qNRsNbmxdojvlVyT1isEg0QzTZdyn4owU2VA3WM=; b=XV2f0t5Rk4FM
	e1rBmUuGDwiTrRw+iOoO1Fa3X+6ZMFP5QC4FYOeWYxkr1Q+oOHK1AaJ2RBdwUsCB
	KmxcyxA4TjxpMzBDzxWJvS2MWRU98O8yN8H5yqxRfAnAXpPZPX6o78xipCIOHhTR
	kpJ5ZfeYfk5tfVwzPRw/hKQGOy8h5L2aC9Gz7UzWXYCAFLkTCPJQK9gdY8lP/1hx
	3VjuM0f6il87i1aQqn+61FnHGqf3L8wbSUeuNHMk6kypjN1vrn7AscRcYaYHu0Mk
	YhaKHL0RVAt6fV5xMN7qI/7MP5Y/j1Qh9sKC/qP0frzIbEmvsD2ONGvicDevxgRZ
	xdTd2Nq/Vg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020113.outbound.protection.outlook.com [52.101.201.113])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 4j6c2nr8s7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 04:09:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuutqQM7FaDAMyGhxX7TZcoXhuJ7EX1k7ErAl6wxolwM8Y8XVQaei3HUwNuDgqWpuv7yoiHWxNuxaAzGWVWd65ml+hLUGNQMmRbJnIiaNBfZ+NBk+A8YZMAYqwP6Fy5+7A10taL7TNN7/COMiIJZG7xGYJss4075GM5JjEVddAgjtDBBIYtAtFR7emPEnoEDocuHuuYS5/03pxkEnjAfKwR9DcY6pnW+E8tAhHTKakZI22qHdLoyzZFO4Eol60cWrfYua+mkdN3DOfZFb6YuEex2x1honJVP1TE5Md+ZAB2HJFZ3sZ1G0dO8fdqNowzlu5DixKXN3i8Qui2ozz/28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2c8qNRsNbmxdojvlVyT1isEg0QzTZdyn4owU2VA3WM=;
 b=NgCs4JucYBtXl+B9E4WbMdlNnMfNdLnrnBitDOhGvwTE12tXEvx4ag47xBc/lNAhApZAnkSEF1PJDLR2mAMl2oWQSLuSs0R6DFztugcrMQ37KLB9QZIzwZVgz3JsgFE/3SH3ARdY8xmGABZOsj5LU2KUdwix5GnAP5B9YYA7Kb20VJFekjJFyHOW8REL5gMagRuDJqk9NqkjbUax9LULsFJqIzIAiS0MkcaEEOSZcbguCXxjGrbiX1kqBwdOpZbvRWFS4Ex61u5ndZyRmUjSS+ob54LUb6AhE3RWj2rHKpKp1r8x3WbpwUeCqFiaTnWWtMr2HrB+zzcjy3Riapx02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 04:09:25 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 04:09:25 +0000
From: "Wang, Weidong" <weidongw@illinois.edu>
To: Helge Deller <deller@gmx.de>
CC: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Zhao, Zijie"
	<zijie4@illinois.edu>
Subject: Re: [PATCH] fbdev: cirrusfb: Fix overflow in the video memory check
Thread-Topic: [PATCH] fbdev: cirrusfb: Fix overflow in the video memory check
Thread-Index: AQHdcnBLEqdaxD54DkOIMEMFPiEJzbc0NgEAgAucRsM=
Date: Thu, 26 Nov 2026 04:09:25 +0000
Message-ID:
 <LV3PR11MB8508547ABEA0E04C8229A216B5422@LV3PR11MB8508.namprd11.prod.outlook.com>
References: <20261112-c4-n053-v1-1-1e45ef75304c@illinois.edu>
 <4f2af4ab-2fd7-4564-9d71-638a8a991de2@gmx.de>
In-Reply-To: <4f2af4ab-2fd7-4564-9d71-638a8a991de2@gmx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=illinois.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8508:EE_|DS0PR11MB7444:EE_
x-ms-office365-filtering-correlation-id: b267dfcd-5eca-44c4-f36a-08df4b730ef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|261022075727099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|38070700021|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info:
 yAhV5jQsK64eFbVs0lDwZk+/dZbVItpstgAl3ufE4jlQRCAh+0IchYO2uEjCp/Lak6JGkwonYHhxhmt9Fg3nLd864wlTF5omxFnFBj5yvWVCnQdpWdXF0Lz+Edx2bzbxtgpNyz8J7+TVYpumhyAVxgVbgiWWQ9EqG5x394FK0WNjQWefb/zUCn5PfmKzF6Bo9NA0Cjm6ZPdWlXHMWEmpAb923gyAFMjckvCmodgg1HWXSGRHF0I6msRohfD9jP57yYdIA/e9ZuD5Kmdc4cb85B6HG/k78au/9cldRrYaGQNPGplGtSnHjiExcr3txUoJMYRxgRPuHmGcuEvOih100jgAs79aDAOOLEw4WqbzTbMixYdq3Mm0p+02PgkiGxt27AlI6TotfqRhGsQS4Mdoz2Tc9mBsoV42uck/mJKGtCOJCnYhDgLp+PagkTYRasqU+B3SiVHVH8VzOIxdfNYAyIc2+vCuHwIThyMPyPqpyi7ZhHlBD6tXOJmjYFY38nLJZKlzAqt+DBoHfryXpYFG2HZSitM6Juv11YN/WEJJr9nSzzBbfUo7q+AUfdqZq9XcQRY3z9mMASLrWblnQxkQnG1o2wGW9U3Qcj9VGjsb4/bPXNyeLKQDTWIbxeI7P6z2A7vjXtHuLhYkyrLauO2XTb8+ct4wOUpW5N0YeqpR97YHQRlSTaEGVsnlttXMEZ6ows3uwFz9oYAwgKw5ygeO6OKCwzkExS/7KFvGaRTxcGM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(261022075727099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(38070700021)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OFBrd2ZGdU1TUzh6WjhKQVdaenIreGZ2dERYZy9QYWpBN2ZaeTNYaHJHbnhs?=
 =?gb2312?B?eFFVTldiOXliT3UvcjNKUm9QY1FzdW82bUVXTlBKZzZqWGpRUmNSTEN0ekVV?=
 =?gb2312?B?OCt1cjJTUHR6VS9ydzcxV1hJeW51TG54dTdRbm5iVEQ0eDlteGNNRTE1UGdr?=
 =?gb2312?B?UUUwSURBbng3TDlJM0lNK2pBcGt0aDRKWEs1aGEvanUzTGczaGZ1L0thazFl?=
 =?gb2312?B?bWZ0MGorV1FHL0x3MGZyYWdPaU9HN29iaUNaZW96cUxiQWF2T1h0SlZ2bzAw?=
 =?gb2312?B?U0U0L3NVNjl2THVCU2RxQnpMUzErRlpVWVROMkwzMk02S1gyZTF2aSttQmFN?=
 =?gb2312?B?NUI0STVhN1pHNFp2aFZmYnpld1NETENUOTN0QWNpb3R2UWdjZEIyZGdFQ1R0?=
 =?gb2312?B?c1MvUy9ISUVpZllCUG5tVzk2UWhzemI1Z2dlWENnZCtRVW5iZzJyMktEcWFj?=
 =?gb2312?B?bG5BcFdZSGhXK3MrSmVqUTFZazIrWHNFZ0pjazhxUmZITTR1N2lGbFpMMjcx?=
 =?gb2312?B?VW5uaC9DdkMzZTRJbE5tNGZueGlCSHRQdzJNN2FGRUFiZkp1VnQ2ZkN2dU10?=
 =?gb2312?B?d3VtcGpqalhESHlkcjdqRTAxVlNXcmRXQlV4WlVHdmd6cDRMTnBlQ3JURk5U?=
 =?gb2312?B?RUxMQjNVM3cxTk1jL2ZIcGtoRzBzUWNxdFVkQ2N2QjEvaUNlOHFoOEZsS1N5?=
 =?gb2312?B?UThnTUxOQldOeVRHTDNoQ242UWZIVE1LY0RJL3pQVFkyOStvRWRjcHFpTGgv?=
 =?gb2312?B?THplWGsrajQ2QmxOSXl3RFJaQlZJSkRnaGZucjhlcm9rKzZwSGplN0M4SFFN?=
 =?gb2312?B?bmtaL2ZXTlVHTUlybTBXdDZuTmZOSkRuT3EzTFZQbEttYjlhTkI0TWhMQUE0?=
 =?gb2312?B?NkIza25ZaDRGQUlnR2VqUGFEQkJjbEQ1ajJRcUxrSkhTditXVXRrRVN2MU82?=
 =?gb2312?B?V0pnZ1pFM3BPSFk4bld1Tk1lQjFmcUQrSWpNL1FLcU9kOW5DcHFacXNqVW43?=
 =?gb2312?B?ejhWd0xQL0tETmhuMVZQQldwNVJpbkdSYU0zeUxNenpRQ2k5b3dFWGZUQ2tJ?=
 =?gb2312?B?MmNTM2lmQ0c0UHhHOG5sdmluQnJRT2lVUlJ2TExEZ1d1cE9hVmVyL0FseDlC?=
 =?gb2312?B?SGV1bjBYTTdnc2Flb1d6WTl3bHRlUWcvMm1EVWZIclNIUUVZN2oySVN3NEJT?=
 =?gb2312?B?NkNBVGl5NEZ0S0lxbmlLa3pKdGIydWl2d0JzV1haZExiakRIaGxvSDJWNTMr?=
 =?gb2312?B?ZVlVclVWNWdUMVZhODMzKzZYZU1ISU5pSWc4NzJLdXcyN0dHMEx3cjJRVmFj?=
 =?gb2312?B?WjVaN091S1pjYXZFeDNXcFArSENoam9WUlpUd055VG01cnBPNGo4UFQ2aTZ6?=
 =?gb2312?B?YUtJaGtQbDJ5Tkl5bGwzT1o0c3JqSUwvNGJxbGtUd3AweTBUbEZ5VmVVMTZv?=
 =?gb2312?B?YzJUUDlMeEhra2JGRHgvVHNoQU9wM0lIWlkzUk5rUlE2cnREWGoxT3ZNbHh4?=
 =?gb2312?B?Tm5xUW1OTnpyZU1VYTVnMHFGMWJtV3NjTFZMNktGWWJ1cjdoakdVejBEOStu?=
 =?gb2312?B?L0srbVJJanM4VU9NVmlnMEZPTFdwTVFQcmR1ZmxQZVJyNUtkQzJIT2lVNzFM?=
 =?gb2312?B?RGhIOVR0L1N4THlaRWRtVWo2d29Lb3ZrQVpzOUNyalovUlRFeWtJZ1BmNkha?=
 =?gb2312?B?UkcyVS8wMDcvN1JaclRmK05aL3pjcEs5MnVTUHd4UEUyR3dZanBQVHJ2cHpo?=
 =?gb2312?B?aWR5VUJTblFNb2wxbGs1b3owZjVoU1NJaXh3bmVjME5iSmZnSUZOdno2cWo3?=
 =?gb2312?B?cUZtL3JqMmNzV3JNb0JSWjdLNi9adlBMd2I1Y2RzcUwvZVYySjlnQkNkVWFw?=
 =?gb2312?B?VXlTUDBMc3FZdmFtMmJpQ0p6R0g1NEdxYXRlWEU3dlRZTEdDSlpkTStQSGxh?=
 =?gb2312?B?R1MyK2xrSXpUNkJhWDlza2JxSTk4TDJBYzNsanNOTjN2dkM3a0hZVldxOFht?=
 =?gb2312?B?eGVydWdOaU5jMkFlMmtSREVpNTAxUFNVcWVOdWlFTXZJQyt3VXZYd1p3ai8z?=
 =?gb2312?B?SWljOWQra01xMXBieVR5S0lYWWZpbExFUGRVaHdSbmREVVRhUXZXL1ZmejVJ?=
 =?gb2312?B?M045TTA5YmxZMVVBbGY3TS9QbXdYT0JDSDdMOWJuOHhsL2NBSkFkQjF3d0RZ?=
 =?gb2312?B?OTdvMUpvZTRlZHdES0xIZXh6RUoyZTNKU0lGMlpBN1hJckhGVHpOa3A1MGYx?=
 =?gb2312?B?L1kzUnFGVC9CWEdHcVVCc29SL2wwUEY2K3JES0tpQ0Y0MEVkRGJJdlN6c2do?=
 =?gb2312?B?STZhRFcvcmZ3UjROVXc0M2pJSndDZjBwY29GekV3M3VSM0JaYnh0UT09?=
Content-Type: text/plain; charset="gb2312"
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
	l1kyiwL5Kky2k9454F/OCMGOtvNZ1InlgJJiDCiKjKcZncNFHPdTwt0Dojf08RXvQBKiw1RnDTQdUs3WqdEn81P29VA3qrmSCJiH4+aZber9sSopcWlsjRgy9e0jcLuyLYS7cFFjJUUPVFKSB7XfcfQXIZHt5fHyKuQqEVKtWH+c3Ar0klbbUvq2ul2HkIR1oF1M7VK7/SxdbhSSSZbmoYjWlJ4Q7e8qB50JSzElkcbTGh7Ndag/uc+Vq2GryOHIgy3cio7v4byXV6udVeYnRXZbr2aOnWVL9oEigbVm4mfL4D2B8+dcriNkq5PYrkCySJpHiq28C8R+eVEoJnc5kg==
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b267dfcd-5eca-44c4-f36a-08df4b730ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 04:09:25.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAY/96KWkItr5+8nmR/XW0d7RgI2ArOwXfSrj1vGEzsl0HQkhOPY5bDvz1RY/J6dFUqQtbbyg9T265uKcptkuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAxNSBTYWx0ZWRfX2J0tETSYiJHL
 l1z/6GgS4DS/dBpa8DR07wTM5Ya4ibqVqfGp1trw1gWGYe1UrjDPV8fEEfxJqtzNPYMkg2tbln6
 SGg0SufI+86d26ObgTttTbvQ/sO9H0A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAxNSBTYWx0ZWRfX7Q6c24DxBnnr
 NRDIg/krjjSo4DMQlGlKgM+URrLQVh5ol5ctTfCXefeZa27gBS+ONr50w55+PElNFSMnIbFVDxO
 g8t0eguOYZHAPHGK9BXvCP7Ry/dg1wHEqCYtUnfQMxyJlw3ubhBnYrXmDF8Lh18uDJPQnrcmmmh
 eo349S2koFnD060XOFCUdCRX9s+yfvlm9TyGOyxtUH1Unh4dy5HZBz/Z4aHQLJ9RJ3ggXjYPhMN
 EDEeovhABQmIk76WwduGHCdVjR/rA2aXESweOnDK27wjjh2ebD+W7rE9k2GDDo8Gs6zcsS/8YxY
 m4GIDnmHDKFCRqMtV+v4iGhFyZEyzwrdBT5rOz/HlA2hWVeZwPQ68vjIG3HwgFdWSyDM8L+1CeJ
 0n8eGOc5n9u6JzuPioJv5mnth8rRQud8gXHFhk8+ISYqeYgMpqhTgCaoqf+C364dJNqTm8XfpYS
 DxegIWv/76wau4jFPzw==
X-Proofpoint-ORIG-GUID: nV2_IJfPrzxetgNXnrbVsWk2C28qooXK
X-Proofpoint-GUID: nV2_IJfPrzxetgNXnrbVsWk2C28qooXK
X-Authority-Analysis: v=2.4 cv=MKH1C8Zl c=1 sm=1 tr=0 ts=6b07b0f8 cx=c_pps
 a=ecT/4VdmJWkC/4d2ldM4Bg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=_l4uJm6h9gAA:10
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=r4lgQ_5M6CoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1SIdTzcqDbZ_m666SYFU:22 a=EtCdu6vMTdqUPTFAGz2x:22
 a=-JcVdM5yFHxdF0YEGzsA:9 a=mFyHDrcPJccA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260015
X-Spam-Score: 0
X-Spam-OrigSender: weidongw@illinois.edu
X-Spam-Bar: 

T24gMTEvMTgvMjYgMTk6NDgsIEhlbGdlIERlbGxlciB3cm90ZToKPiBjYW4ndCB5b3Ugc2ltcGx5
IGNoZWNrIHhyZXNfdmlydHVhbCBhbmQgeXJlc192aXJ0dWFsIHZhbHVlcwo+IGFnYWluc3Qgc2Fu
ZSB2YWx1ZXMsIGUuZy4gYmFpbCBvdXQgaWYgZWFjaCBvZiB0aGVtIGlzIGJpZ2dlciB0aGFuCj4g
ZS5nLiAxNjM4NCBwaXhlbHMgPwoKWWVzLCB0aGF0IGlzIHNpbXBsZXIsIGFuZCBib3VuZGluZyBi
b3RoIHZhbHVlcyBrZWVwcyB0aGUgMzItYml0CnByb2R1Y3QgZnJvbSB3cmFwcGluZy4gSSB3aWxs
IHNlbmQgYSB2MiB0aGF0IGRvZXMgdGhpcy4KCk9uZSBhZGp1c3RtZW50IGZvciB5cmVzX3ZpcnR1
YWw6IGF0IDEgYnBwIGEgNCBNaUIgY2FyZCBob2xkcyA1MjQyOApsaW5lcyBvZiA2NDAgcGl4ZWxz
LCBhbmQgdGhlIGRyaXZlciBwaWNrcyB0aGF0IHZhbHVlIGl0c2VsZiB3aGVuCnlyZXNfdmlydHVh
bCBpcyAtMSAoInVzZSBoaWdoZXN0IHBvc3NpYmxlIHZpcnR1YWwgcmVzb2x1dGlvbiIpLCBzbwph
IDE2Mzg0IGxpbWl0IHdvdWxkIHJlamVjdCBhIG1vZGUgdGhhdCB3b3JrcyB0b2RheS4gdjIgd291
bGQgcmVqZWN0CnhyZXNfdmlydHVhbCA+IDE2Mzg0IGFuZCB5cmVzX3ZpcnR1YWwgPiA2NTUzNiAo
dGhlIHByb2R1Y3QgdGhlbgpzdGF5cyBiZWxvdyAyXjMwKSwgYW5kIGNhcCB0aGUgdmFsdWUgdGhl
IGRyaXZlciBjb21wdXRlcyBmb3IKeXJlc192aXJ0dWFsID09IC0xIGF0IHRoZSBzYW1lIGxpbWl0
LiBEb2VzIHRoYXQgd29yayBmb3IgeW91PwoKdjIgd2lsbCBhbHNvIGNvcnJlY3QgdGhlIEZpeGVz
IHRhZyB0byAwOWEyOTEwZTU0NjQgKCJjaXJydXNmYjoKY2hlY2tfcGFyIGZpeGVzIiksIHdoaWNo
IGFkZGVkIHRoaXMgY2hlY2ssIGFzIHRoZSBzYXNoaWtvIHJldmlldwpwb2ludGVkIG91dC4KClRo
YW5rcywKV2VpZG9uZw==
