Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794672874;
	b=1eyrbQ7vEOQKFz8QEANfimGhDDk9jDjUB0TRR7JuzW50Ii7XfkpI42ADV4dNLMjLYOsT
	 icwKivDO1cCjwF0kbjV9V3Nrs779975gkbv7LRkFTbyuhxkS4OwaVpoRdreLT+niI/4PK
	 EvaONi04nrbjmT5mObXxQu7mNUHtFuEE8m0Mveb1Lp7CxoVJVznr01i1oZpIiX9OMQ6O8
	 tddGnSIsq9eQrf2aBdj2zhhMmodm3nkKXhBbtDLpTfUot4gWyv2Su4rnZ6tIPI1tsVBbl
	 jRVNr+pU/OY/5eVERCaD+UKEnBw4+n6s3KG6SuRPtCqAkg8/G6v9KRrWuTl+QeurF5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672874;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pIeupB9TXzCdrqDDLHna0aBTgQbYVWB9gde8iOkSIt8=;
	b=3cts8pXusHxR00Xf4pgnGBWbluiDntUJjBMmKQuAb9EG/cFox4HCVsCSJbSIZt7OrTXV
	 qApmjt1Tcyr5GpotM63zGZh4traVxOid0zPaoiSaWwILMwYpCI5PR9FN+/Tc6Z6e7r6De
	 uQ5P4v3HJFvfvUTYO4OekAfECdLZ8XsZgTm+i7wNfBPxVHkpXaX7ezl0yminjyHPh+hEh
	 9kdKYouu76CD2LmBjIKclCJVXGfsH14GU6MV458nBRk/HGr+OlAb6w1Zm8n4Pak1NcYJ+
	 9yzZP5BpceNWebC2vz67dCKwMgAqMzkmqShSTQKPCVYmNVQg+NCqJ6lFf3RoyZ5xHSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XWe9qpYc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.16
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010016.outbound.protection.outlook.com [52.103.23.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28087606A327;
	Sat, 14 Nov 2026 16:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28087606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XWe9qpYc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PANIcmWMsnygernhTRdt6Q/TnHaXmL297QOsxsLym0P3EmKKGGuejph8pUQybtFdk3GdV76qNzE5eqg2yncrFFmu1RgA3b9+q6Wyv6atN/tq7TWeuOlYJZNwYBPOUsl8JINsq7FVy8/mZKem24ueMyqAsuHksQlUwwLaSUnvdl2jCZLOrjbOwhOo960E+3WhWR7BdawvgfpLkN96pVWjykS7UOpd9KxIxGyBMHWbB3vNiKBBFGtIzC9BSZlsFXdthgqMLIfPGS2ZRuZJzbDiENqRXew2gCl/jGeYToonLLDJvGKDwQNvEwV/y/yPfrU6giFUzxcK6oZbGuNYYIYBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=pIeupB9TXzCdrqDDLHna0aBTgQbYVWB9gde8iOkSIt8=;
 b=wEY6V3bWaf8XG+BiHR0mNGy8wSxPMfqMkJMz+lPxVFFRvo0Kg8iWxU0S8ZrvZeQhH2/b3gbcgvYh+jFOiTL0MkzCYQvssDWQUr6qhijPqyYy3M4OhdaUkSyS7m21kFDUtuDDBkUCHpTtCBn2WXU1p3Eo0Vyd3u8tl0WXCz+nOW3+OoQbleJTvzXUONxRg29CQj9FSx+CKUvAGAUIV5lnHFIzfBwlxdWMA14vPFSR2/nUNDKxFwHU3LI63y+ljNplwtnckJYEpGVX0GozJ2ziemjI+s6rBdyuxFsefwYVKh1WxpiVLizrgVX4oi/qzb90yS6gzYybPSCIOu2gSd++ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIeupB9TXzCdrqDDLHna0aBTgQbYVWB9gde8iOkSIt8=;
 b=XWe9qpYc9z/1+wdCv5UL+BBhFE+N/w2IS10Ia50W7AKpG8VwClRuJK8qV8kaPmZH7ocxky7lG/mkzBYHOqhn4wLg9SYrM4cz3e2o/yO/O6UStHJItJ2QBCmvYUsjL8FbR4b+NZZ97bxBmmmOL+4UFijZL9e9w49ZwWkN6JQPysog4PCLIpZo0sbchczAEumQPVm+7BSu1oblu6hzKjtRB5XL1bofXeNtB+c2wS16QPs3jyeJpdvlW01Oc2Zcd4KgOuzcK5rGAd7njFWLwsiC3g3LNlrxrxjIPae8N0BvNVJElcN6qGFqX+6o6KnQ/f0T5iI9Euko3J6IbZmXfeS0bg==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by CY5PR05MB999471.namprd05.prod.outlook.com
 (2603:10b6:930:128::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 16:12:33 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 16:12:33 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "gang.yan@linux.dev" <gang.yan@linux.dev>,
	"kuniyu@google.com" <kuniyu@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "matttbe@kernel.org" <matttbe@kernel.org>,
	"martineau@kernel.org" <martineau@kernel.org>, "geliang@kernel.org"
	<geliang@kernel.org>, "ycheng@google.com" <ycheng@google.com>,
	"weiwan@google.com" <weiwan@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net v2 1/2] tcp: avoid wrapping Fast Open blackhole timeout
Thread-Topic: [PATCH net v2 1/2] tcp: avoid wrapping Fast Open blackhole
 timeout
Thread-Index: AQHddFL0PPYcgQXf8EWck8vZ2Cgsyg==
Date: Sat, 14 Nov 2026 16:12:33 +0000
Message-ID:
 <072048c5616098a20126342372d66697c728881d.1794672619.git.x-professor@outlook.com>
References: <cover.1794672619.git.x-professor@outlook.com>
In-Reply-To: <cover.1794672619.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|CY5PR05MB999471:EE_
x-ms-office365-filtering-correlation-id: 0fe5f0c7-e0bf-4cd9-aa55-08df426a176e
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|38102599003|51005399006|8060799015|8062599012|19110799012|24021099003|31061999003|25010399006|24121999003|4140399003|15080799012|22091999003|40105399003|102099032|30101999006|440099028|3412199025|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWtIbWwrVWlXbzFtclI1Q2JNRXRFZWQxcnkvY3FYV1ZVSHI1S1RJMVQ0eG0r?=
 =?utf-8?B?cklXbkdxTURvNnIwSldhUmFhZEJmbU5rY1FheThNYjJFaTZ1QXcvM09OMkg1?=
 =?utf-8?B?NTFwc1VsTHFZQS9oWlpnWlpaajFCUDUzdHNZZUVhUzlPamdyWW51L1A5MHpo?=
 =?utf-8?B?Qm5ZY1BrWHlwck1NbXRnOFBYQjN5TjFFdzJlSGV6TCtqZHUxZjhmNGxKOENi?=
 =?utf-8?B?b0tpc3RFS1lpUkRSOFZqMURWNXdCdGp0Y0ZiZFFNc2VqalFZNHBBTVJoVUhh?=
 =?utf-8?B?alpmTGIxdWYyYmhxY01Hamk4QWZveU94aW1mYlpVSW1lN0RqekJIUGkrWmFi?=
 =?utf-8?B?aDVlQ0M1M0hzQmpoVSs0V2dvUkdKOEFoOGxpM3JqcHJqWUpBenQrSmt5NERE?=
 =?utf-8?B?MjZ5RCtjczU3Y2FhNEtXMGE3UmlrNk5scmRrSTRHTVRhQytBd3F0eEx1ckV5?=
 =?utf-8?B?QVkvbitWUXBCK3dQc2dzQVBxQWFFSXN0NVphaEJTU2IyZGRCMk51cDYzKzlV?=
 =?utf-8?B?dzlNUnJWN0d5WlExZDQ5bkF1L1YydWJEb3cvbUJpNnM2ZjdRbmhQZmpES3c0?=
 =?utf-8?B?OGNhZ3Z6R0h0SnZtSDJ2Wld3dEZZeWlDZW94bmFWYzQrVjJrd1NqRHQ4MVQ4?=
 =?utf-8?B?QmhoaUpucnZVYzNsSXNKM0N2d1l0c3FZeDlFQ2pDT0h4a1JtZEJ5b1hPbmJa?=
 =?utf-8?B?SXIrSGdVWnorT3p6S2pKRUI4SFVLZmY5aTVsZlFGMHRORCswOHpTWG02UDFq?=
 =?utf-8?B?VlFxRXF5ZlU0b0tsRGlaNkFra0t3TkNOcmtUUU9jVTMzSnptYWplYXpmODBn?=
 =?utf-8?B?cjBDMUtocGFwNm5nWjJzb0VudjJadzY5TzhlZGdxK010ZTBCTzYva3RQMEw3?=
 =?utf-8?B?RENWUlZWVWRibFByRGVmazlDM2YrVTUrb2RKZ1EzcldKQUR6VVpWMkM5Q2tX?=
 =?utf-8?B?NjJSa0hnajVjOGNCMzVVVnVXV1JzQ1kyVlVVb2p3QUROR1J3NXpmSHRydGpB?=
 =?utf-8?B?bHl3VjVLdmh6SW5UM1pmN29HZkt1SDFDYXd2Unl5QnlvanpMMUNnaVBGSFNW?=
 =?utf-8?B?bXlLYTVpWlU5Z2pNY1Jub2tyV2FRMHJEOG4xVGc3aG5aOSsyRXZZajBCcGU1?=
 =?utf-8?B?ZU1XeWZBbVRRUlJWQW5BU2Uxa2NzM2tFNjhpakpmS0k4QmxKb24xYW94dWYz?=
 =?utf-8?B?eEZzYzk2ME5NVkJzOVRtUVZZdndyd0VLWGtvOW8xNVdncm9pTVdUV0FOd3o0?=
 =?utf-8?B?UzNLQ1g0ZkpGRVJaMHlnK1JCQnBMWUpLS3NUZzhhZFZOcHFQZyt5UnlKeUJo?=
 =?utf-8?B?Z3FCQWxoUGExOE9WS3ZPMUVZVzJoNGlZTVdkcWwrWHBib0NGTTBrVTBNc2VR?=
 =?utf-8?B?eXRVVFVZazRNMGMzNlNsTzkrOWsrUDMwOTI5SWpmVVd1cG5GVXB4OFlVRjho?=
 =?utf-8?B?cU11T3oyZHNKZTZCWG5hR0ZCNzkvbDk4MnlyTUJMalNhdlZlbllVR1pUT3Fy?=
 =?utf-8?Q?RN6amEB0myj20ZmoTETP0lCLSZZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckdVS2VReHdFVElnMTdZdU90Z3BnaW52bjNVTVpOekNIV1ZwTkdiYmVnTVQv?=
 =?utf-8?B?MWU3cmNPZkFrL1RkTFVPRVY2QlpQUFNnR1h5WVBwZ2FXUVNKL2dqUkNLQm1o?=
 =?utf-8?B?WGJvTDUzMkdiUUQrNUhDWkMzSVNQSVlmWVNvR21wa2tTZG4rM1dlQnB1QWFw?=
 =?utf-8?B?WGFRbXJuZ0pqUStGRG5scU51ZHR1Q0JCcjhYZk1zQlZYWjE1TGNxenQ0WnEz?=
 =?utf-8?B?d2RCVkhKZXpvcm9QdHQwaHJEK1pQMmhBWE1kTEtyKzNoMXlHMXpKNzEzblR2?=
 =?utf-8?B?dFRjLy9nQlBhcmp3L2JocXFFQUp4QnQ5QUdjMWVpM3Yra2xKWEVVQ0IyUXU5?=
 =?utf-8?B?NU8wTDlKTlFNUVZrUnFXK3pFbjRKYVVCanI0bWVwbVlGR2o2L1dTUUFrMFlW?=
 =?utf-8?B?WVNhQUZ1cjA0bHVnbXVyMXY4RDg1Q2ozZXhsdlMxSjNSZzIyWmZZTlRqVFRX?=
 =?utf-8?B?WE93RlBraDQ4V21POXFhbE9oaXJCZTRlR2FqY2c3NUxFcDJyMnBHQjBheHBM?=
 =?utf-8?B?bWxvVC9LWDg5bG1TdDRVTEY2NkxjSjFWZ3dCOVVmZlc3Tkc5L0E1ZkpjcDhB?=
 =?utf-8?B?d3lxZ1huMThoQ2owLzRZalBNcHN4MEtwcFFRTGVMQS90U05xMmo5QnBnczdi?=
 =?utf-8?B?d3RpVVVKQkhkV0EvNnR0alVlR1F2aEZTN1FOcmdZcVdXbjZoNXE1ZU91c28y?=
 =?utf-8?B?M0hQVXcvemszVERPeXZJb1VVNzhzQWxnaUsvZmdwUG5tcVZyekpaNXNiTEFk?=
 =?utf-8?B?NXlKUE95Q0d3SHBLcklMWnJ1ay9qemNtWElhbVloeE5HcjA2Q0piamE0SDdU?=
 =?utf-8?B?WlgxOTh0c0FCTlREcFlXU1R4VDNxV21kUFAwN1VFdktNeTlLWkJnNllKUWIv?=
 =?utf-8?B?Qkk3TEVPNjAyeExGNzI3TnUzbVdpcFJGMlFCSDVRL1l2dkRNSHVTeXg2ajN4?=
 =?utf-8?B?TmtvbmtuS21lMUlNSGJoN0xGVGFvS2dNTm1XMzB6ZkhBOXk5NUlXOUJMclhs?=
 =?utf-8?B?UTFENVczcnp6U2gzUTkzOTZQay81OG93ZGpvZ1Q0aTEzdUxkTjcwSTlpYUNj?=
 =?utf-8?B?bDB3Zk04eFNsYjRONk9qczAvbDVTNWVHcGlGZ0RMMzVrVUVRalZ6STdUTkdZ?=
 =?utf-8?B?Q0NJMGxNVXdJUVhoYmlEN2FHWkRaREZYTzgwN2RQSVFpWHhZQ3k3dUN0MCtn?=
 =?utf-8?B?SnZCbE1RTFQxWnNtWHN3dGVCYi9XZCtONWF1R1JwOUprajN2WmtlZ2VBQ0VH?=
 =?utf-8?B?UDVzSUFxbVBmdTdSMHFRMmhKV3MyeGFZcG1DaUU2SkFObWFtdFArTzZuV0ty?=
 =?utf-8?B?aDl6aXdoZmFOY3FIakhNMG5YclE0Wm9WSHBGRlpnSEVTK0FOdzhkKzhtQWRJ?=
 =?utf-8?B?Qm0zRVZQSjUzZ2R2Tm9wa3BrUWh4ZjBvaXE1Y3NSUTZnRWs3VDJadW1xMU9m?=
 =?utf-8?B?SEZxcXlrb0pGb1NyRTZFWVc2K3FuQ0pwZnNvOXJoN2QzdFRvU2RXYzV3amZv?=
 =?utf-8?B?Zks0dTVJMWdTdE1abUd4cy9KLzl3TmNVMldXeThRVkVJa3NlY3hnODk1bS9L?=
 =?utf-8?B?NXBSSVBJUXFvdWtDNzdtaHEvMDFuSjF3dzNaLzJ4ZlRZaEpSZ3lzbWxtVHQy?=
 =?utf-8?B?alFkSlQ2bXpWRmFGYWV4ZC9mUEFkckJ2QlFLajlNYjVOUDNtWWV3cUc0dW10?=
 =?utf-8?B?bm5SRTBwdXM4Wko2VEFrcjh3MDJISDAzV3dBKzlaZk10QWtrb3A3M2NNcFNw?=
 =?utf-8?B?azJXQ2dnOElYLzAzVzZFSHpXQmZzQWJqL1ZJODIya3NTa29MU0NjMFVGZFpp?=
 =?utf-8?B?TTVFWTg0cjBacWtZMGFkZVlhS2lwU1VYbnF6NlM4RkFaK01DL2dkaDBkOGZ2?=
 =?utf-8?Q?/r6s3bp/9G6yO?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe5f0c7-e0bf-4cd9-aa55-08df426a176e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2026 16:12:33.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR05MB999471

dGNwX2Zhc3RvcGVuX2FjdGl2ZV9zaG91bGRfZGlzYWJsZSgpIGNhbGN1bGF0ZXMgdGhlIGFjdGl2
ZS1kaXNhYmxlCmludGVydmFsIGFzIG11bHRpcGxpZXIgKiB0Zm9fYmhfdGltZW91dCAqIEhaLiBT
aW5jZSBhbGwgb3BlcmFuZHMgYXJlCjMyLWJpdCwgYSBsYXJnZSB0Y3BfZmFzdG9wZW5fYmxhY2to
b2xlX3RpbWVvdXRfc2VjIGNhbiB3cmFwIHRoZSBkZWxheQpldmVuIG9uIDY0LWJpdCBrZXJuZWxz
IGFuZCByZS1lbmFibGUgYWN0aXZlIEZhc3QgT3BlbiB0b28gc29vbi4KCkZvciBleGFtcGxlLCB3
aXRoIEhaPTEwMDAsIGEgdGltZW91dCBvZiA2OTEyMjEzIHNlY29uZHMgYW5kIHRoZSBtYXhpbXVt
Cm11bHRpcGxpZXIgb2YgNjQgc2hvdWxkIHByb2R1Y2UgNDQyLDM4MSw2MzIsMDAwIGppZmZpZXMs
IGJ1dCB0aGUgY3VycmVudApjYWxjdWxhdGlvbiB0cnVuY2F0ZXMgaXQgdG8gNTEyIGppZmZpZXMu
CgpUaGlzIGlzc3VlIHdhcyBmb3VuZCB1c2luZyBhIHN0YXRpYyBhbmFseXNpcyB0b29sLiBBIGxv
b3BiYWNrIHJlcHJvZHVjZXIKaW5kdWNlZCAxMiBGYXN0IE9wZW4gYmxhY2tob2xlcyBhbmQgd2Fp
dGVkIDEuMiBzZWNvbmRzIGJlZm9yZSBvcGVuaW5nCmFub3RoZXIgY29ubmVjdGlvbi4gSW4gdGhl
IHYxIGFyaXRobWV0aWMtb25seSB0ZXN0LCB0aGUgdW5wYXRjaGVkIGtlcm5lbApyZXRyaWVkIGFj
dGl2ZSBGYXN0IE9wZW4sIHdoaWxlIHRoZSBmaXhlZCBrZXJuZWwgdXNlZCBhIHJlZ3VsYXIgVENQ
CmhhbmRzaGFrZS4gVGhlIHJlcHJvZHVjZXIgcmVxdWlyZWQgbmVpdGhlciBrZXJuZWwgbW9kaWZp
Y2F0aW9ucyBub3IKZmF1bHQgaW5qZWN0aW9uLiBUaGUgaW5wdXQgbGltaXQgYWRkZWQgaGVyZSBy
ZWplY3RzIHRoYXQgbGFyZ2Ugc2V0dGluZy4KCkNvbXB1dGUgdGhlIGludGVydmFsIGluIHU2NCBh
bmQgY2FwIGl0IGF0IE1BWF9KSUZGWV9PRkZTRVQgYmVmb3JlIGFkZGluZwppdCB0byB0aGUgc2F2
ZWQgdGltZXN0YW1wLiBBbHNvIGxpbWl0IHRoZSB3cml0YWJsZSBpbml0aWFsIHRpbWVvdXQgdG8g
b25lCmRheSwgc28gdGhlIGV4cG9uZW50aWFsIGJhY2tvZmYgZG9lcyBub3Qgc3RhcnQgZnJvbSBh
biBpbXByYWN0aWNhbGx5IGxvbmcKcGVyaW9kLiBFdmVuIGF0IHRoaXMgbGltaXQsIGEgNjQtZm9s
ZCBiYWNrb2ZmIHdpdGggSFo9MTAwMCBleGNlZWRzIHRoZQozMi1iaXQgcmFuZ2UsIHNvIHRoZSB3
aWRlciBjYWxjdWxhdGlvbiBhbmQgamlmZmllcyBjYXAgYXJlIHN0aWxsIG5lZWRlZC4KCk9uIHRo
ZSB2MiBrZXJuZWwsIHRoZSBzeXNjdGwgYWNjZXB0cyA4NjQwMCBzZWNvbmRzIGFuZCByZWplY3Rz
IDg2NDAxLApsZWF2aW5nIHRoZSBwcmV2aW91cyB2YWx1ZSB1bmNoYW5nZWQuCgpGaXhlczogY2Yx
ZWYzZjA3MTliICgibmV0L3RjcF9mYXN0b3BlbjogRGlzYWJsZSBhY3RpdmUgc2lkZSBURk8gaW4g
Y2VydGFpbiBzY2VuYXJpb3MiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2Zm
LWJ5OiBZaW5namllIFdhbmcgPHgtcHJvZmVzc29yQG91dGxvb2suY29tPgotLS0KIERvY3VtZW50
YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0IHwgIDEgKwogbmV0L2lwdjQvc3lzY3RsX25l
dF9pcHY0LmMgICAgICAgICAgICAgfCAgMSArCiBuZXQvaXB2NC90Y3BfZmFzdG9wZW4uYyAgICAg
ICAgICAgICAgICB8IDEyICsrKysrKysrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbmV0d29y
a2luZy9pcC1zeXNjdGwucnN0IGIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2lwLXN5c2N0bC5y
c3QKaW5kZXggZDM1MjNjOTA2NGEyLi5kMWU2NmZlYjAxNTMgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50
YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0CisrKyBiL0RvY3VtZW50YXRpb24vbmV0d29y
a2luZy9pcC1zeXNjdGwucnN0CkBAIC0xMDU1LDYgKzEwNTUsNyBAQCB0Y3BfZmFzdG9wZW5fYmxh
Y2tob2xlX3RpbWVvdXRfc2VjIC0gSU5URUdFUgogCWdldCBkZXRlY3RlZCByaWdodCBhZnRlciBG
YXN0b3BlbiBpcyByZS1lbmFibGVkIGFuZCB3aWxsIHJlc2V0IHRvCiAJaW5pdGlhbCB2YWx1ZSB3
aGVuIHRoZSBibGFja2hvbGUgaXNzdWUgZ29lcyBhd2F5LgogCTAgdG8gZGlzYWJsZSB0aGUgYmxh
Y2tob2xlIGRldGVjdGlvbi4KKwlUaGUgbWF4aW11bSB2YWx1ZSBpcyBvbmUgZGF5ICg4NjQwMCBz
ZWNvbmRzKS4KIAogCUJ5IGRlZmF1bHQsIGl0IGlzIHNldCB0byAwIChmZWF0dXJlIGlzIGRpc2Fi
bGVkKS4KIApkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMgYi9uZXQvaXB2
NC9zeXNjdGxfbmV0X2lwdjQuYwppbmRleCBiZjE5M2U3ZWM1MTYuLjViYzM1N2UxODliZCAxMDA2
NDQKLS0tIGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMKKysrIGIvbmV0L2lwdjQvc3lzY3Rs
X25ldF9pcHY0LmMKQEAgLTExNTIsNiArMTE1Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY3Rs
X3RhYmxlIGlwdjRfbmV0X3RhYmxlW10gPSB7CiAJCS5tb2RlCQk9IDA2NDQsCiAJCS5wcm9jX2hh
bmRsZXIJPSBwcm9jX3Rmb19ibGFja2hvbGVfZGV0ZWN0X3RpbWVvdXQsCiAJCS5leHRyYTEJCT0g
U1lTQ1RMX1pFUk8sCisJCS5leHRyYTIJCT0gJm9uZV9kYXlfc2VjcywKIAl9LAogI2lmZGVmIENP
TkZJR19JUF9ST1VURV9NVUxUSVBBVEgKIAl7CmRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3BfZmFz
dG9wZW4uYyBiL25ldC9pcHY0L3RjcF9mYXN0b3Blbi5jCmluZGV4IDdmN2ViM2NjMWMwNC4uODgz
ZjBmMWU3ZTA3IDEwMDY0NAotLS0gYS9uZXQvaXB2NC90Y3BfZmFzdG9wZW4uYworKysgYi9uZXQv
aXB2NC90Y3BfZmFzdG9wZW4uYwpAQCAtNjEzLDYgKzYxMyw3IEBAIGJvb2wgdGNwX2Zhc3RvcGVu
X2FjdGl2ZV9zaG91bGRfZGlzYWJsZShzdHJ1Y3Qgc29jayAqc2spCiAJdW5zaWduZWQgbG9uZyB0
aW1lb3V0OwogCWludCB0Zm9fZGFfdGltZXM7CiAJaW50IG11bHRpcGxpZXI7CisJdTY0IGRlbGF5
OwogCiAJaWYgKCF0Zm9fYmhfdGltZW91dCkKIAkJcmV0dXJuIGZhbHNlOwpAQCAtNjI0LDEyICs2
MjUsMTcgQEAgYm9vbCB0Y3BfZmFzdG9wZW5fYWN0aXZlX3Nob3VsZF9kaXNhYmxlKHN0cnVjdCBz
b2NrICpzaykKIAkvKiBQYWlyZWQgd2l0aCBzbXBfbWJfX2JlZm9yZV9hdG9taWMoKSBpbiB0Y3Bf
ZmFzdG9wZW5fYWN0aXZlX2Rpc2FibGUoKSAqLwogCXNtcF9ybWIoKTsKIAotCS8qIExpbWl0IHRp
bWVvdXQgdG8gbWF4OiAyXjYgKiBpbml0aWFsIHRpbWVvdXQgKi8KKwkvKiBMaW1pdCB0aGUgYmFj
a29mZiBtdWx0aXBsaWVyIHRvIDY0LiAqLwogCW11bHRpcGxpZXIgPSAxIDw8IG1pbih0Zm9fZGFf
dGltZXMgLSAxLCA2KTsKKwlkZWxheSA9ICh1NjQpbXVsdGlwbGllciAqIHRmb19iaF90aW1lb3V0
ICogSFo7CiAKLQkvKiBQYWlyZWQgd2l0aCB0aGUgV1JJVEVfT05DRSgpIGluIHRjcF9mYXN0b3Bl
bl9hY3RpdmVfZGlzYWJsZSgpLiAqLworCS8qCisJICogQ2FwIHRoZSBkZWxheSBmb3Igc2FmZSBq
aWZmaWVzIGNvbXBhcmlzb25zIG9uIDMyLWJpdCBzeXN0ZW1zLgorCSAqIFRoZSB0aW1lc3RhbXAg
cmVhZCBpcyBwYWlyZWQgd2l0aCBXUklURV9PTkNFKCkgaW4KKwkgKiB0Y3BfZmFzdG9wZW5fYWN0
aXZlX2Rpc2FibGUoKS4KKwkgKi8KIAl0aW1lb3V0ID0gUkVBRF9PTkNFKHNvY2tfbmV0KHNrKS0+
aXB2NC50Zm9fYWN0aXZlX2Rpc2FibGVfc3RhbXApICsKLQkJICBtdWx0aXBsaWVyICogdGZvX2Jo
X3RpbWVvdXQgKiBIWjsKKwkJICBtaW4oZGVsYXksIE1BWF9KSUZGWV9PRkZTRVQpOwogCWlmICh0
aW1lX2JlZm9yZShqaWZmaWVzLCB0aW1lb3V0KSkKIAkJcmV0dXJuIHRydWU7CiAKLS0gCjIuNDMu
MAoK
