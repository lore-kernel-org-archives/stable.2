Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794393559;
	b=IqEdXPXgVrAPTZBVsDa9Hl/knBKtZrvn2du4y8ZsKveF0GarawlbgvTBMQyAWYlWaf1t
	 lk47EuQJginke54UANxwsAh/RxVbVBdziV+i32cX4A33HYwUIh83MSL2e0aqSGQTQXKzS
	 Y50E6ISlQ65X7bbFkxUz9CBv+NaVdu/QrWMu35aoWaBNKwZ7rDh9PSj9hL2HUmRm3e9Kr
	 3ClKYceNl97e/iDPs63tvT5uAkbnAF8DZnOKNczetFFREOauted387aLMOwHmINxq2J5+
	 m68tv3VulFMQ9GdAzf3oiDvQAFP0pMGhk17HgJ5Prr7DbwXSXIA+MZstZu0ljTmUuvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393559;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fmOLhtpUt5v0Frlwo2TlTJuDL0i/hY4zx2d0lYFcyjg=;
	b=ykFuNfqG6BkMXkhE3arUK8jjCGaXwRymoFXEr1PcOSYjUZ+krYanpn4S57w79yEEChK3
	 C0fHY2qUIndIWkGEfygf3wiMMIp+/BoXmdhOG65CbrCP9OAwnVJmYk+tug0SrfeUebd71
	 xConnnY5RACW6Q59X0noISrbgt6spvd70/u0Y2cK0yAmjKWumvkkZhCIiVQO+VTdgty6R
	 9+HO8X5fBaPetzj4yAwQa8McE8dXeqv5EZC6ALWV/rwmPde0x1XVEWE2To3+7I/IdNwFJ
	 Z0UPNnxoJBK919WY6wNw2q+g/VxQVFi3mrg9/xTZ+vpKfWBXtAuSY8W0NCtWwE3kKGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RrsiGydz;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=U+o5r1Zu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F89606A88F;
	Wed, 11 Nov 2026 10:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27F89606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RrsiGydz;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=U+o5r1Zu
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB7MDb9088628;
	Wed, 11 Nov 2026 04:39:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=fmOLhtpUt5v0Frlwo2TlTJuDL0i/hY4zx2d0lYFcy
	jg=; b=RrsiGydz4219VK9LNL9LKXt4iT1anhk91QMVbQfQXFRGAr5NroUb6NH/4
	17W2JLlVDqhewDztHNcr7FwMy5YvoCYFUIiweeDZOGZHT0vxZLlrlxQCC4g9E5yI
	Z7PJN24KLSAKAnzimbkVgER+tomBfzvSUr7/3dgrtMtmGW4IXaCfXAv4Q0pIUoZj
	YwRSqEPmGrIYQSsrdJHQ9Xs85nLqL3zML44FesqFEVCTXP0DR/o3ZNtInTslE7m9
	pYkVyrGnKrW7gGbR/5u9ZJXaVLKiPKY9ajBsHx9tkueTlgMhmnPTpBF00KCH1zTg
	qenB1Wqp0obp+7eeIHABuCRU/QyCA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv9pjv7m4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 04:39:10 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQJXufDtJ/XZBCw3UOMAmlVJJJSx4hD85WSHrKSKpdoDB9Y9lo1/Ux+4fpRKke+JG8hluuBhSPUtg/xuO1rcGlH842fsVL+3wykLq6sciJCqFYkSGNFBFznC9HgrcpKCn0ezCfXMZlZgUr1zleTxmOy650hnpTV7XnoPj6t3eCakYxfyfCCfaeRuA6tX1+JOet24TFaZbAWbtI+ek2jU6PbIgv7Mr60OfE4LIEz6wBWs20ye7paJJku1LUx7PGQ1B+t93m7ZRGYsEWP7IparLUvfjFNnWN33iSNseqynOlwV/ZyPuhxolkxGEs3Tj1dliaZESWnEEqc+xmWcqytDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmOLhtpUt5v0Frlwo2TlTJuDL0i/hY4zx2d0lYFcyjg=;
 b=D9be3bOrjhbrXPkf5sQP6dww8YLBwRAOZBSgaJnEqeXn9PVCUaJE9vSaizQRudyga+2Xyd+Q6LJ78+BvdSN7iF6RYBDJiPrMGYB5SiDdsUmjqmkpYcHpc0YkQnkSBP9ins2jVhDomEoIHnCYWnFW43e1Mg3AWQlKSlS/Dw6nlhDu32Y4XVJ2J7UXPgDSNBgPFp0BgkR9+YDW0jBUbvW7MrWEJKKULdbEvh6vr4nCT0kkDMJY6OygROBdXGVyhi9n2eQNt6G46Wk0lvDOSRERm0zjmlCyLrxqrQHePrxq5/r30oVvh8LsejKe2e+vf4nD2ZrNb4JHWrlverk6muT5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmOLhtpUt5v0Frlwo2TlTJuDL0i/hY4zx2d0lYFcyjg=;
 b=U+o5r1ZuSg4MXY3P9WVnf3pO6dapyA2TYLyWXgrMs2pCB9jY2rImpw7gdD7G7RDW8nGCBNmYFwgihTIacxy2uvMzPhnApiKMUbAht/FXHW+uegz3Ygie6EvKFvZOPR2ju0SplYuC8jfvsB0jr6FZaR0N/NZQ04zLZWCmCcI2i8w=
Received: from BN8PR10MB3652.namprd10.prod.outlook.com (2603:10b6:408:ba::10)
 by DS0PR10MB6800.namprd10.prod.outlook.com (2603:10b6:8:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 10:39:07 +0000
Received: from BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a]) by BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a%4]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 10:39:03 +0000
From: "Thakkar, Devarsh" <devarsht@ti.com>
To: "Brnich, Brandon" <b-brnich@ti.com>,
        "mchehab@kernel.org"
	<mchehab@kernel.org>,
        "hverkuil@kernel.org" <hverkuil@kernel.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Willis, Kendall" <k-willis@ti.com>,
        "jai.luthra@ideasonboard.com"
	<jai.luthra@ideasonboard.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v8 3/4] media: imagination: e5010: Update
 e5010_init_device Call Sites to Ensure Proper Device State
Thread-Topic: [PATCH v8 3/4] media: imagination: e5010: Update
 e5010_init_device Call Sites to Ensure Proper Device State
Thread-Index: AQHdcTE7sG9epRI/I0qa5ZvjdS2FTLcor1eA
Date: Wed, 11 Nov 2026 10:39:03 +0000
Message-ID: <db8ff212-97a7-4ec6-b0f1-ab1dec916eb7@ti.com>
References: <20261110163247.48712-1-b-brnich@ti.com>
 <20261110163247.48712-4-b-brnich@ti.com>
In-Reply-To: <20261110163247.48712-4-b-brnich@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR10MB3652:EE_|DS0PR10MB6800:EE_
x-ms-office365-filtering-correlation-id: aa0368f8-1500-4dc8-05d1-08df3fe00143
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|4143699003|56012099006|261021121427099003|261021123027099003|261021135927099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261022115727099003|261022105027099003|261022075727099003|261028144727099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 bx7Ost8roAVAkT+x4JmtOGicHUI5/yTPMd5FRqjLQo0sikbj6kc3T9kn/3XyWxtHn+0YMFvY+u2v/WA30KW9J+8lTIGPLvF/yVVoWcXrhgsHpsB+AUXuVxqyA2K4aOy8nzljfX0atqgDp2N2691PUFHitva9P4x0UU2HZDoiGmr5YEEGq8G8YVyTP65lXk7pbv5wgDxIg9DTQW5RTKS7rcrwTnB8b6+g4/B86RM2HOdyCoMCk7DdH7x+iHJljj321je0zduxS0iuCbpL/dZwxjUgwGjLpADF3Nb1slxTUfRhkZFcfy4ZKx3ERHidMNu6z3zxu3y4/yw0AG/oyG4gXkJePY5Oojj+kSeI7nGvwJ55r4T1bw7jLxsiFrKeTgKmLPk3gljYFy10xLzPFB+bkZpPDpwVovH8OS5drHK2e0g92tzlhL+OjZ1z7s8/l+3+IW1J8GnjoXEYh52SU06vS90zEbKEkgg/cJDXBbrIwsKrKiBmFSZLjtvJqKBA6wp7Lgl0/8fHfCSZWM6kpe3fcgcRHd3V9Nh9Vl/dErvg7HhkIBaXnwyV7PibPQQ5sbAlcIqfEhvxFH4Kv4/KazJdPTqw7ifwtkYh9PkrMVxFn/qctSnNit6tEZM0GYduJUQzINkkfw8LRBX5DUbuzyRXdkkxYk1xaaHa8Xvt4twsrjWEZ+K9GDlm5IZ12tcHdnz/iLNY9r42rG7s/5SxaiiR5LZ9bJ3K2nX69WuGTA+pMlg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3652.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261021135927099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022115727099003)(261022105027099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkQ4UGZkL0p4ZTdhbVR1NndQTHFsQ1lDYUtmV1BJQ0NQZ3pXVG5neEJiWnR0?=
 =?utf-8?B?dWUrdUhpRkJROEFpQlR3YklZUGdBUm9IemlLWVY3aDdOWmxzRXdmRlh0OVdo?=
 =?utf-8?B?WGdFYkVubzVmQ1JLKysyM3RPUUZJK21ZdG5rU25TWVZxM05nVXBFQjFZSUwx?=
 =?utf-8?B?UHlhL2NBSWRXTXoxSHZyZ2t0UTJBQzVzelpBa3VsSk1Hd2VSVHdqU2NIMjNB?=
 =?utf-8?B?VmdYMVlOYjBwbCt3cVo5NVZSN0J1YWxGbWZCc2dnWWg5TW9PTU0vRHRqWkQ3?=
 =?utf-8?B?eCtIY1hodytKYUc1ZDJQMzBZMTVNcjVvNk54Ukh5SXlzSmo5MUFnQWc5Z2o5?=
 =?utf-8?B?MlBrbHVuZXExTk1tOEwxSWRHVWk5b1BVajRtR2owcitScXI5YWE1clFDUEls?=
 =?utf-8?B?Q2lkQVZoWkhqN0JVVFhYV1FNbGJ3RkRXSUYvcGhqOEMzaFdFZWpWeTlrWHcy?=
 =?utf-8?B?dUhCclQ3Vy82RWFtc0t2UzA3b3IrYzNPb3RoTDIrMkVhRlp6azJYUGFmV0Ir?=
 =?utf-8?B?MFFvNzd6bkdiYjlJQ3ppclNqb0EwRmJFelF6TFV6Z2RxQldMeVZnbGlITUY1?=
 =?utf-8?B?TVRBNEpuRUxQaGV2WkFRUGlIZGloV3dUcjRReEJidFV0YjE3SHlpWmdXM2JT?=
 =?utf-8?B?UjRYQWNIdFV5UG9yS3puNTJoMnhTalRSZlVUSDlVSHRpMXZUSDdDTU0xSUNM?=
 =?utf-8?B?ZDh1TFh1Q1pqZnlOTm1aZW9QWWlsdy8yNERCY1JnSEpucXlXblpGL0RIRTRs?=
 =?utf-8?B?dWg2WHVkamI4SytLR3M3QVZnNHZQdUVZVld1WlFDMUY1cFlUbHRWY0RsUmc2?=
 =?utf-8?B?YytQTk5BcEUvZHZXbko1NHFFN01SUFVoeTlvM3lhS1F6V3pUbHBUOEZlTzBW?=
 =?utf-8?B?c1JxZUdENi9KYmJQQ3UxaVpBQ0tvY0pzYXJDNFV1TUtObjluN0JwTDJ1Zktz?=
 =?utf-8?B?SFJwcW43eGM5U0dZN0VKdjJHV2oyanA1OEZsUlgwRXBmVFNxcHdXbTNVOFQr?=
 =?utf-8?B?Qzk2RGxuTEZycUVkaU9YSTkvcExqT3c3NlZ3dEFQbU1UQkdnMEIwVEQ1QmRX?=
 =?utf-8?B?Mm9HNC9TZDY4dXcyNmhBVzhOT29DNGtjbEhJT3RWMHhwanhMMGJaSzVFUUx2?=
 =?utf-8?B?NTlZUUlTclRzYkhyQ3lRSUZSbFVPVUEvdjh3NjFoLzM1SVk0TGhiOENoZVBH?=
 =?utf-8?B?dzJKQ1p3ZGU3eVYwbFpXSi9pSGJRNDJXeGNuaTk3anNOTW5zbUppbFNQZXhp?=
 =?utf-8?B?elcvMjJrd211OHFTQmRYdkpwYmNDZzNnWE0yOWN3TDdKSDk0dk5ma2V6Q3FZ?=
 =?utf-8?B?TzN4U2hVbkRTU1V2Q2NJV014aGErQnBEVnNoTW5SckRVRWVDSTB6WTA3R29n?=
 =?utf-8?B?Yjkrb2NPdlhwMDZ4MDljZ0MwNUFZMktUWDhDdmJuUVdKdGRBZ3paNWx0My9r?=
 =?utf-8?B?Wks1SHNFdm5ldERBUnVQUDNSa3Q1LzhXVXI5aWpaMzFwbyttSVpKdUNyNGFl?=
 =?utf-8?B?eHE1d1pMeDYrNWc2TXZvTzNtYWdpeHhHSngydmw4TmZDcEZNdlR1ZFdITWRs?=
 =?utf-8?B?NUFWemIxTG54WGtRMXdUWWkvYWgrdHZJV0hWZVliZlE4QUZFemZVNmEyS0tn?=
 =?utf-8?B?OXlMUllBOEtkZ0djTTVCMWxadnRPbG1rb09nbE5TVVVvcGg0K3YyQWlpWE1Z?=
 =?utf-8?B?L3l4NDZBQitPWWlwa3pXV0I4d2QvL1RFb3FEdTgvd0UyMExvdmxCZDJzMGRN?=
 =?utf-8?B?bS84M0pDanRsWWNId283czZaS29kbWNVUVRFNWQ1Tm1DSUM2cXpkZHBOSlBG?=
 =?utf-8?B?b0Jjd09yMDJ0ZURlVTU1d0ZhMzgyRkY2bUN6RU9zMTMrajA5RVh1OGpob2VM?=
 =?utf-8?B?c1BLZVBpb2tObTFSeHFHZ214SUU0WHpaVWQxaEpYS0RGWE9EbU9vWEs3RFl1?=
 =?utf-8?B?V3JvZGNEMnNJdDZQWTI1dlA5L1JFWVNJcnJ5SDhObGVmT1hwL29xeWRjU2VK?=
 =?utf-8?B?SE1ZSit3UjgyTUNHWWtqRTJwaTRrZWQyNUsyUktXK1F6Vm12L3hTK1EyQ2tQ?=
 =?utf-8?B?WWR0bk9QN29jV3JQL0FXaE5xOGViQUZWL255OFJVenloTFYzNUFmWDFPeVI4?=
 =?utf-8?B?eGE5SWpUcTc3aG5FaWxmK0l4RFpMbDZFMmcyZlRCL3c5bnBwN0ZNVzVlMnY4?=
 =?utf-8?B?dkFlbjltUEJMcy9qUTZpczdnVjF2Q1VHRXhkYTNzb0swb1FkQlBUckdERVZh?=
 =?utf-8?B?aUdOQ3k5NWpLTnFHc0JCREN1ZmVFMlBnTzl3RjFUeUg5R2VLZkR6RkNPMW5S?=
 =?utf-8?Q?6+kWvfhctzP68pIpqj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D99147C59ACD494E936CCFF807D4A19D@namprd10.prod.outlook.com>
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
	rU7Rcp+kHdUHCet0UcSMwPoeAO9Jr2413l+bNjfAbwsAgk8dZJf4a/Ik/n3aSomI9ruaJcbexc3gqQKYNkC8dOuuqFw8DpkD0ccZRPIpgs1Dg2FVpM77owfsfKuZnvM6yOSJQtvSjO+SlzA3O29mLZKwI00/Ko7K0k8S1BNE4mpYjVMlHujzrAYbmhqamHAZwQh3pH+PjK+PLG3tGehO1z/IKCUbSeF+OKRI5+DP8pxPAmkYFciDAUllh0uJVl/G5kay9IV3UErWD7g8HD8koT26t/lwK3DmeyB5LlPkM8OBCUVrknMqmmfXsymDGzQrkWBR0asoxMIobB/18X4NfA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3652.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0368f8-1500-4dc8-05d1-08df3fe00143
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 10:39:03.5945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yH3GCKYioJHE+XK1uNnp/eP0KjRaa1tsqB+PNf0dF75JNqgznZq/i5LJeew/9odG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6800
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfX1qUxYwSktlyM
 Pjb2jb8NfHnw66GOEaa2sCtjjHIXiJnBiGhRgxt/Ym15/eN/mZPs6iXBUJeeBHWnjwu/a0DlWKq
 h6yoYdUqNdiSkK4v65pMcma2PGXiqpjXmQuoFF6Q7WC3LYJMZfPnRv/eA2ScFOqnbU630RjPw7f
 tI8DYatoUexMk9GD5KHdfAy4pCZ2LYY3KfWRbWZUCg7ZefW3+jchEwN40u+xmbdnaPikPJTF+/u
 GXZNDjWACMV722S62EkW8apaLFZVAitoIl7ZspC5vlRI43VHEndyKHNZrcOC9YqFj8eHo+s5Omo
 uYtlzA0yNM7ZJIaVP/H5XbP0DCYeqiRyVmOE9X7xZcrCUwaL9Kx25+bN/HatOG4AZ2FNd4tyewM
 Si7n6goSY9w3zbFhME6sbj2JdwmejHMqVOgaHV8K03bRPvXpwQDX7/cJJPWbTxM6k0PotaJ8GHH
 zbht1e3SqI/omndiRPg==
X-Proofpoint-GUID: yf7aNLnbyfIx-tURmerRFv_EwoW5xGyG
X-Authority-Analysis: v=2.4 cv=ebOo7LEH c=1 sm=1 tr=0 ts=6af445ce cx=c_pps
 a=cXHsTeABgwIgPhuKzetQTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=tiM-kIHm-4S82qFA0dEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yf7aNLnbyfIx-tURmerRFv_EwoW5xGyG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfXxNMGNPNhUrOy
 ekrVTkFrA3DvJI7nmgm6i/l5r6qUrCzfDI1Cl/GPRMPOuBhGYFQ5di/y4N9Ce84uI6X5cc6Roqv
 SlwkNUoaLQr/UGVFK4bujz4/3/6lLO8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110042

T24gMTEvMTAvMjAyNiAxMDowMiBQTSwgQnJuaWNoLCBCcmFuZG9uIHdyb3RlOg0KPiBUaGUgUE0g
ZnJhbWV3b3JrIHNraXBzIHRoZSBydW50aW1lIHJlc3VtZSBob29rIGlmIHRoZSBkZXZpY2Ugd2Fz
IG5ldmVyIG9uDQo+IGluIHRoZSBmaXJzdCBwbGFjZS4gVGhpcyByZXN1bHRzIGluIGEgY3Jhc2gg
aW4gdGhlIHN5c3RlbSByZXN1bWUgaG9vayB3aGVuDQo+IGEgY2FsbCB0byBlNTAxMF9pbml0X2Rl
dmljZSBhdHRlbXB0cyBhIHdyaXRlIHRvIGEgcG93ZXJlZCBkb3duIGRldmljZS4NCj4gDQo+IE1v
dmUgZTUwMTBfaW5pdF9kZXZpY2UgdG8gdGhlIHJlc3VtZSBob29rIHRvIGVuc3VyZSByZWdpc3Rl
ciB3cml0ZSBvbmx5DQo+IG9jY3VycyB3aGVuIGRldmljZSBpcyBwcm9wZXJseSBwb3dlcmVkIG9u
Lg0KPiANCj4gZTUwMTBfaW5pdF9kZXZpY2UgbmVlZHMgdG8gYmUgY2FsbGVkIGFmdGVyIGU1MDEw
X3Jlc2V0IGZvciBuZXh0DQo+IGRldmljZV9ydW4gdG8gaGF2ZSBhbGwgcmVnaXN0ZXJzIHByb3Bl
cmx5IHJlc2V0LiBXaXRob3V0IHRoaXMgY2FsbCwNCj4gcmVnaXN0ZXIgdmFsdWVzIGFyZSBzdGFs
ZS4NCg0KTm90IHN0YWxlIGJ1dCBjYXJyeWluZyBkZWZhdWx0IHVuLXByb2dyYW1tZWQgcmVzZXQt
bGV2ZWwgdmFsdWVzLg0KDQogU2ltaWxhcmx5LCBlNTAxMF9sYXN0X2NvbnRleHRfcnVuIHNob3Vs
ZCBiZQ0KDQpUaGVyZSBpcyBubyB2YXIgYXMgZTUwMTBfbGFzdF9jb250ZXh0X3J1bi4NCg0KPiBz
ZXQgdG8gTlVMTCBpbiBlNTAxMF9pbml0X2RldmljZSBzbyB0aGUgbmV4dCBkZXZpY2VfcnVuIGNh
bGwgZG9lcyBub3QNCj4gdXNlIHN0YWxlIFFQIHZhbHVlcy4NCg0KTWF5YmUgZ29vZCB0byByZXdv
cmQgYWJvdmUgcGFyYSBhcyBiZWxvdzoNCmU1MDEwX3Jlc2V0KCkgcmVzZXRzIHRoZSB3aG9sZSBJ
UCwgd2hpY2ggcmV2ZXJ0cyBhbGwgcmVnaXN0ZXJzLA0KaW5jbHVkaW5nIHRoZSBpbnRlcnJ1cHQg
ZW5hYmxlcywgaW5wdXQgc291cmNlIGFuZCBxdWFudGl6YXRpb24NCnRhYmxlcywgdG8gdGhlaXIg
cmVzZXQgZGVmYXVsdHMuIENhbGwgZTUwMTBfaW5pdF9kZXZpY2UoKSBhZnRlciB0aGUNCnJlc2V0
IHNvIHRoZSBuZXh0IGRldmljZV9ydW4oKSBzdGFydHMgZnJvbSBhIHByb3Blcmx5IHByb2dyYW1t
ZWQNCmRldmljZS4gQWxzbyBjbGVhciBlNTAxMC0+bGFzdF9jb250ZXh0X3J1biBpbiBlNTAxMF9p
bml0X2RldmljZSgpLCBzbw0KdGhhdCB0aGUgbmV4dCBkZXZpY2VfcnVuKCkgcmVsb2FkcyB0aGUg
dXNlci1jb25maWd1cmVkIFFQIHRhYmxlcw0KaW5zdGVhZCBvZiBlbmNvZGluZyB3aXRoIHRoZSBk
ZWZhdWx0IG9uZXMuDQoNCldpdGggYWJvdmUgc3VnZ2VzdGlvbnMsDQpSZXZpZXdlZC1ieTogRGV2
YXJzaCBUaGFra2FyIDxkZXZhcnNodEB0aS5jb20+DQoNClJlZ2FyZHMNCkRldmFyc2gNCg0KPiAN
Cj4gRml4ZXM6IGExZTI5NDA0NTg4NSAoIm1lZGlhOiBpbWFnaW5hdGlvbjogQWRkIEU1MDEwIEpQ
RUcgRW5jb2RlciBkcml2ZXIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCcmFuZG9uIEJybmljaCA8Yi1icm5pY2hAdGkuY29tPg0KPiAtLS0NCj4gIC4u
Li9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9lNTAxMC1qcGVnLWVuYy5jICAgICB8IDE5ICsrKysrKysr
KysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vaW1hZ2lu
YXRpb24vZTUwMTAtanBlZy1lbmMuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vaW1hZ2luYXRp
b24vZTUwMTAtanBlZy1lbmMuYw0KPiBpbmRleCAxN2VhNjE2ZmYxNzk1Li40ZTc3MTEyYjU5MTk3
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2ltYWdpbmF0aW9uL2U1MDEw
LWpwZWctZW5jLmMNCj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9pbWFnaW5hdGlvbi9l
NTAxMC1qcGVnLWVuYy5jDQo+IEBAIC05ODYsNiArOTg2LDggQEAgc3RhdGljIGludCBlNTAxMF9p
bml0X2RldmljZShzdHJ1Y3QgZTUwMTBfZGV2ICplNTAxMCkNCj4gIHsNCj4gIAlpbnQgcmV0ID0g
MDsNCj4gIA0KPiArCWU1MDEwLT5sYXN0X2NvbnRleHRfcnVuID0gTlVMTDsNCj4gKw0KPiAgCS8q
VE9ETzogU2V0IE1NVSBpbiBieXBhc3MgbW9kZSB1bnRpbCBzdXBwb3J0IGZvciB0aGUgc2FtZSBp
cyBhZGRlZCBpbiBkcml2ZXIqLw0KPiAgCWU1MDEwX2h3X2J5cGFzc19tbXUoZTUwMTAtPm1tdV9i
YXNlLCAxKTsNCj4gIA0KPiBAQCAtMTQ4OCw3ICsxNDkwLDkgQEAgc3RhdGljIHZvaWQgZTUwMTBf
ZGV2aWNlX3J1bih2b2lkICpwcml2KQ0KPiAgDQo+ICBkZXZpY2VfYnVzeV9lcnI6DQo+ICAJZTUw
MTBfcmVzZXQoZTUwMTAtPmRldiwgZTUwMTAtPmNvcmVfYmFzZSwgZTUwMTAtPm1tdV9iYXNlKTsN
Cj4gLQ0KPiArCXJldCA9IGU1MDEwX2luaXRfZGV2aWNlKGU1MDEwKTsNCj4gKwlpZiAocmV0KQ0K
PiArCQl2NGwyX2VycigmZTUwMTAtPnY0bDJfZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxpemUgZGV2
aWNlIGFmdGVyIHJlc2V0XG4iKTsNCj4gIG5vX3JlYWR5X2J1Zl9lcnI6DQo+ICAJaWYgKHNfdmIp
IHsNCj4gIAkJdjRsMl9tMm1fc3JjX2J1Zl9yZW1vdmVfYnlfYnVmKGN0eC0+ZmgubTJtX2N0eCwg
c192Yik7DQo+IEBAIC0xNTE3LDYgKzE1MjEsMTMgQEAgc3RhdGljIGludCBlNTAxMF9ydW50aW1l
X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAg
DQo+ICsJcmV0ID0gZTUwMTBfaW5pdF9kZXZpY2UoZTUwMTApOw0KPiArCWlmIChyZXQpIHsNCj4g
KwkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmUtZW5hYmxlIGU1MDEwIGRldmljZVxuIik7DQo+
ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShlNTAxMC0+Y2xrKTsNCj4gKwkJcmV0dXJuIHJldDsN
Cj4gKwl9DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiBAQCAtMTU0OSwxMiArMTU2
MCw2IEBAIHN0YXRpYyBpbnQgZTUwMTBfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlp
ZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCXJldCA9IGU1MDEwX2luaXRf
ZGV2aWNlKGU1MDEwKTsNCj4gLQlpZiAocmV0KSB7DQo+IC0JCWRldl9lcnIoZGV2LCAiRmFpbGVk
IHRvIHJlLWVuYWJsZSBlNTAxMCBkZXZpY2VcbiIpOw0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAtCX0N
Cj4gLQ0KPiAgCXY0bDJfbTJtX3Jlc3VtZShlNTAxMC0+bTJtX2Rldik7DQo+ICANCj4gIAlyZXR1
cm4gcmV0Ow0KDQo=
