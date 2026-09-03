Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFEF3806B6;
	Thu,  3 Sep 2026 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479101; cv=fail; b=EUo0bJcdwVzixhl7QHmId9cJRjP/yIHXyEuLhUF5XoCxygOLTiWbEeegJhtOIde41SjAoGZg+s73LUXcIroS21BZ8PdZP3agrGRw0ff+HSjhv9sB3bFxji1LY1VxZ2P8Msp5JfQmh9NBibDFdOZfKlavhS7NrPGE1ELvOxi8jpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479101; c=relaxed/simple;
	bh=CLeHnLxYBp/zGWgpFedt84fW7RNKGkg5opeQQw0IVzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Orsx4ApOv/LCv2jj9bTKibHxTLCkrpjFRK0omDdMt0QAehCL6g1qL/nYbZ6QDhZTYohHEaM4upAGGh1a5YNilNOf0Bh5rnH7EGQuyd0GmrOYYpJS2sFVPgbL53hopl+xjndXUOv5Q4V86ZgAVmHOTBjZ3rEOEd9508o1hGm0hBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=OlKwEhDY; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="OlKwEhDY"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683NfwR23836882;
	Thu, 3 Sep 2026 23:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=CL
	eHnLxYBp/zGWgpFedt84fW7RNKGkg5opeQQw0IVzM=; b=OlKwEhDY3eH71SyelP
	ElO9PtHvbizMXJJAs7NfJ/hOcLFa6aXkNCFpB0pb1hZRKSL93pdPxiADtQs+gtNU
	2bRj0dPVTEM6s1l1qM5zxZ9KTlsWyC9f/Lkq9vLgL/xNCMEYonWQ/40eIkpNDJtn
	SgR8++VQAzVNe9tJfUj5Q+N5JjALlEn2m5vdQ5CAs7VsAxkJNgzsGMUsLRrob//x
	tr1dXkYjpSUDUGmiNH/k7ISaHY7Hz51qm1okyXjdMpxGbEHW7LGFyI6q0ZyTOofF
	LE7/s1eu8NhfebrNn787LBWrMHXFwdZioqOVz0JKpW6WjVdhOD3MasP0PNm+pQqS
	I5bQ==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gfe6vkr4t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:44:46 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EC4AE806B14;
	Thu,  3 Sep 2026 23:44:45 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:44:45 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 11:44:45 -1200
Received: from CH4PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 3 Sep
 2026 11:44:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpxpXhcxRUJeo7BSoOdINnSmp49IlOuOBe9QPfImXo+I9scu/6a7noUPpHb4Kxm3T+5YPrjpF04IGTSEOnxpTk6aIcwPbBDJIbRbAjSi0fLBOKKakNihfVYTruxSdjxSTieLCI3UFd4LYTMT7WjSYsVHbaz2O2qm+EJ8o7QFomiqfxaCNTO5I1oWdSIzEws7lwVfBVeSLRg1fghce0cf7p3nc4iXJBMVBin/RlbHA0mcJrxYbPUm0I5W/mZ4CU6WqSPkj3+7fzGgCNNO+6RElIsqpJ1eOUS5HbPgc+2kZJPrkLYUIXhu3HeLgtepbWsJFH3inY1xfRrV+KWIzJ98nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLeHnLxYBp/zGWgpFedt84fW7RNKGkg5opeQQw0IVzM=;
 b=R0cH4MlK47KxBvf3TVNsCO6V0HIeLUmnPKBcd5DkQmTGJg4S6zxDFNLjKPKVhib4zwM8OMcuBO8pwVGFZvn3orz6ZAy0HMyLaN01N/6OTrNzyhX5DK7Aj0s2crRxwexuMVaValFZnfe4R88SGOWOy8s09ADI0SLp8JM4CbGd3wSl09hhQChbFYiF1Z6NNkkuAa1AF5jJpDc/DTWLuLMpmhMqeOlFm/qTIwc3iVpwEoLxAPyejle3WC9udASbWkAx0kiQ2QwUycXcZDBrqjhbvUAfc1TTihq0DKoVsRJdboB9Q+Jwu960dCNqtD1SuK1aYe0MSGebl8pyEmbB8pqLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1684.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 23:44:31 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 23:44:31 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@lysator.liu.se>
CC: Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Patrick
 Rudolph <patrick.rudolph@9elements.com>,
        Phil Reid <preid@electromag.com.au>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 2/4] i2c: muxes: pca954x: free parent IRQ before
 dismantling IRQ domain
Thread-Topic: [PATCH v2 2/4] i2c: muxes: pca954x: free parent IRQ before
 dismantling IRQ domain
Thread-Index: AQHdO/4qfnaMlbkitUuhY1BfEUfuGA==
Date: Thu, 3 Sep 2026 23:44:31 +0000
Message-ID: <20260903234410.1896930-3-sanman.pradhan@hpe.com>
References: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1684:EE_
x-ms-office365-filtering-correlation-id: da30f414-f2d9-4d89-fb98-08df0a154d52
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: KGGrMZzGbJXoHGEUa/HvenInSWBJVyL/34jZad9D38ydv3KTjQZKlbQdX5AhjlhNaMhWZzcQsHD+A/o+KsdaWFI2VxNy08SLbN/XgkWrEPaiVgLFC8sd2gF9bbTtLFAEbggAPa/4ahBQOfC2GsD2Oq0HpUEMyNTHien3d7XD4XIhE/b7gWW9j6mqZbMADepOnbHk4EwqOUoLvuomPVjccMqAZTWO9o4jf1vagk6fVky3S+cJ2F1LvZ+nyXHD3vmc9WVBQmsFHjNaPrEzCYYofUP2z/Jf9nLrMeG85zVXEg/1rLUMSwTZFsicUKHCwNkpMmte9dsADpwyyp6yMNq4q11ewq2iHjjtzflQsZRv+OnJ4rWWGIuyc/0RORWGIAkaI4FTy3wZuHuQHUZaPhQ69kqNdsmvnXFFbNXswmYnykPzyaTxCXrmY8Q2ewEnhgQVJwuJVwQvsDh8cRErQTiIlXVT1VSL39b6BgF2OZiOJF6s/V7Zi1Op1HSJXHA9SJ5e2P9ktG56HH9ByyVHN6FpvxYAIr4PCKSv6N5/4/7JKYg1sd/RXxmXwLzV2fDvCsIqXPH2C6nOc5CHl1rBtgPLv3m6UaDeOAYWqzTF5VijRas1NBDut9LVAHkaBUDgLUEMwZWLcOuSupqTTa6cuwMNKEA83DXHU0+y16x+hYROqP2z+Yk9afQQIUA1eQO/yXa5FxzMSplFj2Aq+zKqYucUnaQkHCjP/su3WELEKnAt0BI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blJVZVB3QzRuYzFhVEhoTkhjM3Q2bllRakc4R2tRU1V0YXNyM3FHcGg1Ui9h?=
 =?utf-8?B?eGFnRUR5eUk3NFAyTVhhaFpveG94UTl5RnJUY3BKdjVsZzhWVzRiNE1vZXAx?=
 =?utf-8?B?WEFzaEpWZTYvU2NUcUxMZTYvejB3eE9vS3dLM0xwa0VIeklDYTRaYzgwM0hF?=
 =?utf-8?B?Uld6TzF3dU5XVjJUV1U1ZkxqOVhzRVFmbDM2TTQ0ZGxhZE1USTFtVmtsazFu?=
 =?utf-8?B?U3BlTzBYMUVrQnlGaEFQYjlNdzFvRkRnZGwvdzFjUGo1MHJvaDVheU1wdXpC?=
 =?utf-8?B?Zm9IZ1lQQlZWMExydHE1QkltK0xLU2FTcG1LaUdBZ2x3YWxHQXdiUGVFN2g0?=
 =?utf-8?B?MktnRExJcXJmQ0ZqbFJEclFNeFRXbTdVcWg1NldoTHQwckVkWFliN3FMeWN5?=
 =?utf-8?B?SE9RMlBLbXhGZTA0TUtMWlFlbDZQZ0lWY3JiSG5BY3U1NHBjRnZUN1ZrdnR1?=
 =?utf-8?B?QlVpL1hMSjZydmFzc0o4VkJ1K2Nkc0RqQmtESk1Ja1pOa3g0YmtBRUVJc000?=
 =?utf-8?B?N1pRN29LSnlMeDNZSEZOOEszQ1BobzFQUDJZRTB6UG9NK0QvWGpZZVdYN3hp?=
 =?utf-8?B?THNjTWxKZUcrT3VnVmFFblJOTVZFUWtSaVRuaFdiQlYrZTVEZDNiU0ZjR0hM?=
 =?utf-8?B?U2gzSzNGTVpmNUh1cU5QNzI5Y09ubGdHUzlJR1ZBN3dCN2FLUU00b0V1TDly?=
 =?utf-8?B?SFBobFRzRlVaajZ5cyt3aDZ6Zk5tRHN1TWFYbVVYS2x5T25zQzBXWFJyd1Jl?=
 =?utf-8?B?WW1Qc3hKdmtrZDRrNm5zcjVuaHhIdDMxY2h6YXhxM2xWcmRBR3UydmF5QTQz?=
 =?utf-8?B?bVU3OEFTREpPTFQxL1RBUDNwK21GQ3o5ckJGRXFPYWpiWFU5YXpKU0orVitt?=
 =?utf-8?B?NUg0VEQ0WHg0N0xwTUltbUxVSm40RFl1Vjc5czBDc1lzL3NaWitxSnhESkxB?=
 =?utf-8?B?Rm9tTTg1RmNObElmbmhBM3dqc1ZNdnFTMG90Snc5QUFlMGErRGdxNisvenNq?=
 =?utf-8?B?TEVQdXpGelBmQ3ZMUXphcFJxSVo0V2MrWXRQREw3VUtjMTY4U3kwQjJjSENt?=
 =?utf-8?B?OHF0dHg2bnRCM0FseG5jSHhwS3cxQ3RlNTBuOFBwT2RicEVvb0Y3TVduYnl5?=
 =?utf-8?B?Z2FKUElQUGlJcDJ3SExuc2VIODRxdVhPSWtUbWxKRFI5SHFza1U4U2poN1da?=
 =?utf-8?B?MFVGak8xb1VhdGc3TmhieXZydHJadDVLWHVTRjZZVlRiQnFzU0NBWEljYnNF?=
 =?utf-8?B?eTk3V3VZR2NMV1hPdkp0U2hzanBVcCtmK3R4ZndMekZzTHdhUDZVTFFpZWtF?=
 =?utf-8?B?SkV1UHUyU0EvOTdEQU5ndC91c2ZnUlNKb0FRc1R5dnFVZEJWejZZVkEvelQz?=
 =?utf-8?B?VDdFVVJDMU5EZm5xMFhYZDlMTlJSdURtRGlUZHBDUFpJempjUVN4WE9MaXE3?=
 =?utf-8?B?SlZhTmtIYldWK1VOODB6enJSVzFPYjR2WkNrU0JWSEpxbTZOWkVmNDVNWUlk?=
 =?utf-8?B?WHBxc2owdnlKWEpwTy9McmVwV2RRbGpJVURhVVovWFhwQzJEdWtSY0crWjQw?=
 =?utf-8?B?VkFhL0p5R0l5QzZDcE14Y3UzUUhFcTdHazdreVJmMGwvc0NVTDA2UklmbkZ0?=
 =?utf-8?B?K1pQSVlPZnFnZGhRbVkrYWhBU2pQdnBmU09HRHVJbGZuTExvbzNwdkNZaE5u?=
 =?utf-8?B?akNnOTFPOEt1VDdKZXFXQmNKa3Z5WjFKV05majlPN2Jjck9kTUhXSld6eDNq?=
 =?utf-8?B?NzJCb3lhZ3h0MXlvT2tVL1JLOUY3MzcraTIvSmo0ZkRYU0cyVFlNV0ZBZ0o4?=
 =?utf-8?B?QWpjZTV4YUc2aWRFVzQwdGg5YjB5dVFWQmtRRFJlSmg0VmJPbE1tRDl4TXpB?=
 =?utf-8?B?QnRnMEYwVVR6anFNbUZSOXc2ejZ6ZlpIcVNBY0hyUVhIUlQ2UUtVbjkvMWhV?=
 =?utf-8?B?c2Q3QkkyZlRHbnJoVFNGUTQ0VGNOMzhjdXdxNk9kaE91cklpQ1pQY3g2aVZ2?=
 =?utf-8?B?aGdweXRoSVdJcDQ5NEI1YkVGQUl4Y2hRV0w5M3hlV0xGWkpQVDRsVlF5V2Vm?=
 =?utf-8?B?UkhzVlM3ZlRhT0RlQmFYSndpYTZHVmpMNSsyaHdmTGRLWnRTUElQYVl4K0g3?=
 =?utf-8?B?dFFaQ3dRZkxqYmlXY3EvR1NEblM5VUQ4VkdRNzdFaTRMd1QyT3lxVURUK1Rx?=
 =?utf-8?B?UVY2TDUrUGpZbFY4ZmlROWQ3cFg5OWlLY3VvVk1GK3daVjl0WXhqUGVxekJa?=
 =?utf-8?B?Y1JhaXdhT290MnhpYVpCOCs5YWVOYVJwV2IxUGFUalRaV1RYVjlyeklicWFX?=
 =?utf-8?B?bis4NkJrbDdoSDlXM290eFozamdBVk5Qa3RlU1MvSk9nbTNkZlZXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CCoPyQMFFnAXSLu5vqmt9i1WsFCX2ED56ptrCFCCTcpDWa1/WzQPgT+/dAdzpueHBIxQn7G/RWmgppDO8dVwzceT2UezyZOtoLEVT9HnDVxb6od5L1m98IUZkHfSe6MlFFdL/UP7EzKa+PIW3VDYQsvKrhi3QtiAnck+dwQ4Q9TPrNyDr/C+jnrxe4wA+xgHkcMIh1mhTo3QYNdWAi7W9HzHWqJXWzFQ3EQnqYIFGUkKbtySCDDQUPp7Sfp76YV6+JUvgdzIvNCD62KUisAEyuQNyKxdC29fWOUEyPws76cma4eMRYHVD+CXJYAkoUER4FNVYUcB7Y65r69S3b7NfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: da30f414-f2d9-4d89-fb98-08df0a154d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 23:44:31.7662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0eZOOJkXs+0EqgxZxi8qOWRVWIHomC190DAZpCDLcpQ10giebZ4RI6Mh5VK849Bu88RPO+u5xdCFRxo9FHJNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1684
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0x0padFohN2rRMus_WGqOqCdnqg3wVa5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfX4+313+7NiDFW
 NNpMlwwvS9UOmFKcc9/k6j5fAsqVvCJhXs1gw2LE80RU0CTZd5YIRyx0NpGLbjHdknPGszSfygf
 C18rTMsTWojKdkLkhqGfLCr8F/TlW4w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfX96moFgOeH8Yj
 wykth5AZdEVu5DLQnSSLYfnDGcs+ct/ErBq2CwCyKa7/4P1kyOrwnmGO3h2sGu8f0gUnkOkfCq0
 mnGmvoG+GPvS7NKJsIUwVUb5g1IcN479s4g9m8xFMJ7Igiek1KC75oPi/L9ybmskXzzVhrn7DrZ
 FFnKDG8TvvGImtXG1ED3wdNGyyJltCCcKRKH4gyUcmC4N0BlRzS9Bd3+4NyRtjp6Xx5JE2wwpQg
 p6TeUHJVvXH2QBeJFxHL8QHQTxtkTO8sDW9KSOIkkLhpKnggu8NjB6WpqCbEeNbAqcTXW6u8NbJ
 xnFLpVPU5Ax1Dn7sEMEMmSn7tNeyUYrZc2MKhQ9y5QRLU7mcYfdAsLzCGuvXEm3nAxkrDpS/EJy
 3SOiLkENhodWDMq9M3YwS28NPSFmmAv0KgvNe4Yc+z6B2ylE2xnekhyKkl8AI3zN3i5rQVZ048u
 yq2dn+ljbuAy8KfCVpw==
X-Authority-Analysis: v=2.4 cv=FdoHAp+6 c=1 sm=1 tr=0 ts=6a9a066e cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=lPBuCpg2XIx9y5CwavgA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: _Do8DHut05Znu7A1SleN-wXuOlxN528S
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030207

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpXaGVuIHRoZSBjaGlw
IGhhcyBhbiBpbnRlcnJ1cHQsIHRoZSBwYXJlbnQgSVJRIHRocmVhZGVkIGhhbmRsZXIgcmVhZHMg
dGhlCm11eCBzdGF0dXMgcmVnaXN0ZXIgYW5kIGRpc3BhdGNoZXMgbmVzdGVkIGNoaWxkIElSUXMg
dmlhCmhhbmRsZV9uZXN0ZWRfaXJxKGlycV9maW5kX21hcHBpbmcoZGF0YS0+aXJxLCAuLi4pKS4g
IFRoZSBwYXJlbnQgSVJRIGlzCnJlcXVlc3RlZCB3aXRoIGRldm1fcmVxdWVzdF90aHJlYWRlZF9p
cnEoKSwgc28gd2l0aG91dCBhbiBleHBsaWNpdCBmcmVlCml0IGlzIG9ubHkgcmVsZWFzZWQgYWZ0
ZXIgcGNhOTU0eF9yZW1vdmUoKSByZXR1cm5zLCBpLmUuIGFmdGVyIHRoZSBJUlEKZG9tYWluIGhh
cyBhbHJlYWR5IGJlZW4gcmVtb3ZlZCBpbiBwY2E5NTR4X2NsZWFudXAoKS4gIEEgcGFyZW50IGlu
dGVycnVwdAphcnJpdmluZyBpbiB0aGF0IHdpbmRvdyB3b3VsZCBsb29rIHVwIGEgbWFwcGluZyBp
biBhIGRvbWFpbiB0aGF0IG5vCmxvbmdlciBleGlzdHMuCgpUcmFjayB3aGV0aGVyIHRoZSBwYXJl
bnQgSVJRIHdhcyByZXF1ZXN0ZWQgYW5kIGZyZWUgaXQgaW4KcGNhOTU0eF9jbGVhbnVwKCkgYmVm
b3JlIHRoZSBJUlEgZG9tYWluIGlzIHRvcm4gZG93bi4gIFRoZSBwYXJlbnQgSVJRIGlzCnJlcXVl
c3RlZCB3aXRoIElSUUZfU0hBUkVELCBzbyBmcmVlIGl0IG9ubHkgYWZ0ZXIgdGhlIGNoaWxkIGFk
YXB0ZXJzIGhhdmUKYmVlbiByZW1vdmVkOiB0aGlzIGxldHMgdGhlIGNoaWxkIGRyaXZlcnMgcXVp
ZXNjZSB0aGVpciBvd24gaW50ZXJydXB0CnNvdXJjZXMgZmlyc3QgYW5kIGF2b2lkcyBsZWF2aW5n
IHRoZSBzaGFyZWQgbGluZSBhc3NlcnRlZCB3aXRoIG5vIGhhbmRsZXIKd2hpbGUgY2hpbGRyZW4g
c3RpbGwgZXhpc3QuICBUaGlzIGtlZXBzIHRoZSBvcmRlcmluZyBhczogcmVtb3ZlIGNoaWxkCmFk
YXB0ZXJzLCBmcmVlIHRoZSBwYXJlbnQgSVJRLCBkaXNwb3NlIHRoZSBjaGlsZCBtYXBwaW5ncyBh
bmQgcmVtb3ZlIHRoZQpkb21haW4sIHRoZW4gZGlzYWJsZSB0aGUgcmVndWxhdG9yLgoKVGhlIGZs
YWcgYWxzbyBrZWVwcyB0aGUgcHJvYmUgZXJyb3ItdW53aW5kIHBhdGggY29ycmVjdCwgc2luY2UK
cGNhOTU0eF9jbGVhbnVwKCkgaXMgcmV1c2VkIHRoZXJlIGFuZCB0aGUgcGFyZW50IElSUSBtYXkg
bm90IGhhdmUgYmVlbgpyZXF1ZXN0ZWQgeWV0LgoKRml4ZXM6IGYyMTE0Nzk1ZjcyMSAoImkyYzog
bXV4OiBwY2E5NTR4OiBBZGQgaW50ZXJydXB0IGNvbnRyb2xsZXIgc3VwcG9ydCIpCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFNhbm1hbiBQcmFkaGFuIDxwc2FubWFu
QGp1bmlwZXIubmV0PgotLS0KIGRyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtcGNhOTU0eC5jIHwg
NyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC1wY2E5NTR4LmMgYi9kcml2ZXJzL2kyYy9tdXhlcy9p
MmMtbXV4LXBjYTk1NHguYwppbmRleCBmMGI4ODc5YWU1ZmEzLi4zZGE1NGQ1ZjMzMDA4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LXBjYTk1NHguYworKysgYi9kcml2ZXJz
L2kyYy9tdXhlcy9pMmMtbXV4LXBjYTk1NHguYwpAQCAtMTE2LDYgKzExNiw3IEBAIHN0cnVjdCBw
Y2E5NTR4IHsKIAlzdHJ1Y3QgaXJxX2RvbWFpbiAqaXJxOwogCXVuc2lnbmVkIGludCBpcnFfbWFz
azsKIAlyYXdfc3BpbmxvY2tfdCBsb2NrOworCWJvb2wgaXJxX3JlcXVlc3RlZDsKIAlzdHJ1Y3Qg
cmVndWxhdG9yICpzdXBwbHk7CiAKIAlzdHJ1Y3QgZ3Bpb19kZXNjICpyZXNldF9ncGlvOwpAQCAt
NDY4LDYgKzQ2OSwxMSBAQCBzdGF0aWMgdm9pZCBwY2E5NTR4X2NsZWFudXAoc3RydWN0IGkyY19t
dXhfY29yZSAqbXV4YykKIAogCWkyY19tdXhfZGVsX2FkYXB0ZXJzKG11eGMpOwogCisJaWYgKGRh
dGEtPmlycV9yZXF1ZXN0ZWQpIHsKKwkJZGV2bV9mcmVlX2lycSgmZGF0YS0+Y2xpZW50LT5kZXYs
IGRhdGEtPmNsaWVudC0+aXJxLCBkYXRhKTsKKwkJZGF0YS0+aXJxX3JlcXVlc3RlZCA9IGZhbHNl
OworCX0KKwogCWlmIChkYXRhLT5pcnEpIHsKIAkJZm9yIChjID0gMDsgYyA8IGRhdGEtPmNoaXAt
Pm5jaGFuczsgYysrKSB7CiAJCQlpcnEgPSBpcnFfZmluZF9tYXBwaW5nKGRhdGEtPmlycSwgYyk7
CkBAIC02NTYsNiArNjYyLDcgQEAgc3RhdGljIGludCBwY2E5NTR4X3Byb2JlKHN0cnVjdCBpMmNf
Y2xpZW50ICpjbGllbnQpCiAJCQkJCQkicGNhOTU0eCIsIGRhdGEpOwogCQlpZiAocmV0KQogCQkJ
Z290byBmYWlsX2NsZWFudXA7CisJCWRhdGEtPmlycV9yZXF1ZXN0ZWQgPSB0cnVlOwogCX0KIAog
CS8qCi0tIAoyLjM0LjEKCg==
