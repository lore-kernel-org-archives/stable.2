Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793989745;
	b=Ypx/XblMvEcG+PeRZdezHCXKc1xBHIGaYffbdu9t87fkuCj0wLyoyCHyPDF3Na4UgQww
	 xybKXmCmmmUfnLLXRrjKoU2xtvZ+DPk0Qxe2rkjg5EJn19pX1oNPafdqTmhGKSjDCoHsj
	 erB9J2wdZrDGkPSMT13lf9tcJEh98YDc4PFt5e938bHaFwtSMhxIE/4NMblHPoE8qWBZl
	 vzyhtSCpPcqgPaVmLXgcSCVhEgc+ynFFiPprMCK6Gy3czzraY45Jcrsj2zIEYNQsgnJIj
	 udEZhkEv9sKBCVN8qgVAg2fiJNDFlHvH56Wx6p6n5f2qtHOYtPKzBdRFofi9k9934fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989745;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=36CanDPYgdWhjg9Fli+2flcRQOEfCg9cwerIzOVL6nc=;
	b=DocFhSIgRm0xqAtCZxUxrJEMJ8C3XM3xrcV2FsbSOatoLUvCgU8jdS/bdxlf7H6IXwLy
	 YEoTmWPKFXPD/BVBwB10Yvib/UyNEnhWQKqa3YcJ1xBP/RyDsco1WCkBJpcCveg97HZVg
	 EI0h3ggVGPR58hhj18jzJVjMozOHmIArGjM9NoyxQGwhh9wiYj6hAe1BDk3wwvQncGbc8
	 C0Qg6gAacQNdZIFppqELsXZaSUkN/QeWLy68QmJTjIW2MuU8kcqLQCsWKLgyt2I0XJTPg
	 cahL74ygm9XwXTS0e5AQJuMEjaFB5SiSW2qcEE8+6/NdJhA1mY1m08iX/w2gfHLob0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WtR6kFCB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.3
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBF606A326;
	Fri,  6 Nov 2026 18:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFFBF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WtR6kFCB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9Id2mWYgnTJSH8ALZmlKLr7IB7FJOy1GWR8gMh8HaRuGLA6tlOwkhWay/KA/FyHXCgHpEw24W54K05++foK4ZjIHRTu+aArwFgActvn1uDqzqE8CHPObfaP8XwB2jPfQTukPfHZBH/cwqdhmecs/oLiprfEKSLr7jFz7zEIcqWhv937JCfeiBtf0PsZw+gGYvDmgIU9RXgdfqJN6efFFKZFi25dxke32ba/zgABmOgxtp0vqviFgmqPhhQxYKGt203ZREO5ayedqvviOhuUDG4zvCb4NH7n5FYdAu1lpwJlN0XglLzfnNHRhenTyaU4CiKAnHWMACH4pwfK/SFQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36CanDPYgdWhjg9Fli+2flcRQOEfCg9cwerIzOVL6nc=;
 b=pPipZmrS5WuqmNJ02mQe9vRn4L/9uxUbdXPlI4O9SMPpqDjJGodBJVNjVe1MNXmnonFGUcBuLZcfPA/exTYIHylUrF9rWn0RBVyVTb/FVyaIG0tXEKBcDgViuvJwTTdZfbc6jJsk/CZkYZvGhxh1PiFfmaltGI+yfMO8C6mCiP4NUAqRvmpnVrNH92G6Xl2PGFWgSmbxw7R9ENaJlx9dfkRBIEnOTYzwA2BL29MrSQ085qiT56zISvXZcU9+gzsGDSXJ8WFOWByOo99RdfLG+zpHUKsuBuPqeeNFQrA4b627sN7AeeQQxZvehEQfXoDVZKYLb80UHZFk6puBO8MVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36CanDPYgdWhjg9Fli+2flcRQOEfCg9cwerIzOVL6nc=;
 b=WtR6kFCBpJps+8czvbMPzPetvSl6AsoAjuCQSp7TFWjBlvP2XPUASBOMgjTlZa+imRDQnIrDoVevr96K93TOpkYqUN16DBbkivulCpzX7nybmlDDf16H95WJJAQkyjb9xAIg1p9Um1FhhbnE4imlAZuCblBAfChgoGCWSAvkWgnesrMcmXBgpLKhTqpf7YRhbrbRa6Ixkrlwi4j9iUdvDmulZJGO5NshWnJDtfy5bDToz5BF0WXJZL0budEUhpbOOFV3aHtJLjPuForZ8b631RkfPAquVklayUClQvOc8Daz1bTULQl/W4yzUW/222EqLV1IE1EgURpBAN0C9qe92A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 18:28:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 18:28:54 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 06 Nov 2026 13:28:46 -0500
Subject: [PATCH v2] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBREr2L+2pq2ooAr72EIKe2vfIOUtLXRE
 O5uwQu4fMnMm5khoCcMcNnN4DFRIDdmkPsd6F6Nd2RkMoPk8iy4rJmlNwvTQLG1biDXRtc6b9A
 zrzQyXpVKqtp2ttSQHZPHXNj8t+bH4dU9UMdVuiZ6CtH5z3YgiTX371YSTDBVVEddFifRcXMdE
 xlSB+2e0CzL8gU4v5NJ3QAAAA==
X-Change-ID: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: CH5P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::16) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 3188383f-ee34-4fde-8eee-08df3c33d03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|921020|11063799006|56012099006|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IQF7Pe3GCLmSA+WYmY3YNqgzjZ3jEOFM3752yZzFzbHtPyFZQhxB2wkMXnjLmWSRxold+VQ75mMuZ+Ad3VpuT9bG2sFhclHgAAaf2Kuy9gCJprFBasH8xhWnZ46eWWdFbAcNxTQ2L7eYV8XE8tQS0KCuR3cQwkoSwaGX/Z3m62JSj2desgaICzE0BkOYRSFT+IxCaPpfdkbyeCS4n7KQNgNyEoSYWQvXLWZgkLvPvw1TZmoWD9cb4fsY3xVOXHKv9b2R6bccs2QRIGRLBKzrr07lNnCH3+PtsekspHdVg096jbj3Mh+8cf6YEVhr9DLyOt9Zs5TpE7ceaLcktjhV/YvJ1GE3TNqciHYen6dxIzSTy+PuEk8iUy8ZrVA5LttLOs7UkQkvyI4Y2TMbqHaY7jag2dYiDdPlFLu6LeFzBti6WlYAbG6Nwz1VX+Rr/gNJ7nRwggZaXLB5aafTH8qfRZYnbSaWpGY8/P7euKjusywl6GELYxuMgfG3C49RMuKzwDiKgUyrJBRi9WPnCrJsVpAVCs5c03vd+VFKRc5/FeJMjq34cZAQtoiHnizTB55AD+7Nr8mzKTifCWI0Tktw51+nsU9Wtmv9oR/okrBiPKKi/P8TnBnCML91emK2pNF4+9iS9MQ2LKy0fjtAbtHQts/eOx4FanYXkE0mWoKGwmkedbSEGm2Q8PC1KG7/LisLnjz+29Uwq8WaIAr8lyuWlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(921020)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGd5dUhFQUgySXpvKytQa3RFelhMeXpoRnlhVSt2S2svUDZBYytMUkJlUU1P?=
 =?utf-8?B?RWlucHR2UHJiY2N3NDFtQXQyWVJrUFc4a3RKVjR5ZUVWNjYwOTRzYzFPL2tF?=
 =?utf-8?B?ZFdJNUtwUVFjM3RLZ1pjWnl2UG03cCtmNWFpWUkzNUpYblA2b3dZN2paV0l3?=
 =?utf-8?B?Vyt6cGljYW9jUllEY0ZvdnpUNS9DeVdab0p1cGo1L0JvTGZSQ0s3dkw5Znc3?=
 =?utf-8?B?dDhPSjhuYmduUzJ2Ni9aeFlrOW5LSlZmVWswdjcyeDRrSUU4VEFQL212cjRs?=
 =?utf-8?B?cFY5alpRT3B2YVA2amgrMTJYcytYTE5YZ1hnUkphMXVQZ3Z0d0JPOGIxaGtt?=
 =?utf-8?B?b01lS0JlVmo2YlJwSFQ1cEliODhlcm5VbUJJS2VQVzl4Q1h1VVdFa1VyaVFl?=
 =?utf-8?B?K05IWVVnY0VMdHZuZDdZbE5pT29tdzN3WXJVZmNNSllOYVZPL0kvSXZISDM5?=
 =?utf-8?B?TGs1dW1TaWNiYnNKT2xhb0NibUVaeHB4Y29lNjU2R1Q1cXl2RTRQSHp6a3VV?=
 =?utf-8?B?NWllQ200QlF5ekV1QUJWS2E5eGxoVitxRTcvQnVId21GTnNQOGNGc2w3N1hn?=
 =?utf-8?B?Ti9MazhLSmZHb0FUYnRTakJDcnRYQWtrd25NZ0piTHh2K3BlZlhaTm1rRFNh?=
 =?utf-8?B?M0JKWmJuei9KZnFFVzV0QXJXMmVZOEtPWTRJeEtURUpVOVVlVDFPUlV0VFZw?=
 =?utf-8?B?K3FRYVgwSHhaUmpaZDArcjZCc3h3WVl2Y2Y3dUNPcGNjb0pqOVY0RDZrcjh6?=
 =?utf-8?B?MWFCVnJOZzVzL2J5WkVJWWtiazhsemRTT0drYmxGZzBjSitzRWQ4aVNxR3V6?=
 =?utf-8?B?dzRpeW1XS1BLUUZwQ25taTRnelVob1Y3VEJzaFR6RFRNUWZMYkxFbWxDMkNV?=
 =?utf-8?B?aS9lQVY1L2w0bnE3dGZxamtkbUs2ek9WYjUvd1d3QnNjdFBMcjQvYi9Nay9u?=
 =?utf-8?B?ODVVYVYwYUptZkVMUm8yc3RhV1NnbDBkY2hYWlA1NURiRWJtOXJqMFREOWFM?=
 =?utf-8?B?QWhnL1YwamNNUk80TmlRbTcyME80Tkx0QVVkS290RHpsd3RHS1FvN1F6R1RG?=
 =?utf-8?B?dUg4akd6dnJUY0dlTlR5V015NUMwQ0xPOHRnSHREbG9nVFUyRThEQVB4SkJv?=
 =?utf-8?B?VUo3MWhMb2JwdkFFZ20zeTd1N1VpSDBvUTBPRUE4VWhpamlYQzRXSXNoZG01?=
 =?utf-8?B?MElkOXp5Tm9VT2VWWURQbG1Mc3hzazFveTVSeWlhN21ucVhxMmlTQUpWdFgr?=
 =?utf-8?B?UUtwMnpDV0hFS3BVWEhjRFZUMWtsWVY1VmlZN1U0cWJ1d0tHUkF0VzNrOURJ?=
 =?utf-8?B?bGhSTm9jazhhZ2NsWU5URWlBUlE4RUZTZE1ZVWRFK0UxSXhER3owSXVWQ2E5?=
 =?utf-8?B?M0lodVJSdHF1MGxkcW0walB1QTF6dVQzSWhUK3Jjd2VTTVcvY1N5d0xYNHlq?=
 =?utf-8?B?eUNsZ3FVMzQ5cVQxZGVHd0FjNG5oaEduSVJ5QkFZdTRvdWtWUzBlcWJTKzZs?=
 =?utf-8?B?M0Fmenp6NkI5TUgyNEZWRVZWTlpBNTBHd1FBK214Vk9iWDJuTTBDemdrZmZ2?=
 =?utf-8?B?cWR1dVBKZlFLRkFiUUJTWWpYQTkyM3ZzQVZQZkNOYm1peDNTZWtLeHZBaFMw?=
 =?utf-8?B?NDVMTXd5SlFpV1JabGdSdGFGWjBHL3NWMncvNVF5V2YySDdHQWNXMjFvTHFT?=
 =?utf-8?B?bCtNWGxVdmtLaGkxZnlYK2FpS2EvMEFQcE80cmFOY2tYOE1wOWZKT1VNeGdh?=
 =?utf-8?B?Y1FEZGVublM3VDQ4UnJtUVZ1ZHZuZ21aVmZidlRNVW51Y0s0dnNTQVluekZt?=
 =?utf-8?B?Q1lxUzhMb1lSbFptMDN5b2s1MXhqcUhWWkNyeGFDUUkzVWZHNVNpcEVwZDRy?=
 =?utf-8?B?RjFNbmFNd3ZDbE1Ndkh4WVJ5S2lQSHUyWCtLODhuQURkbFdtSm5GWTRieDFV?=
 =?utf-8?B?OXF3R1FTaHorcm5sdTk3UUErU2lmMm8vNkVFVVBtUGNOMTRFUEhuR3VIUGI0?=
 =?utf-8?B?c1JNMEJvNDlPUisyNzEzTnVjYjN0Z1pLWm5oa0N0YTQyMWhXdnhoOE1TbVo0?=
 =?utf-8?B?M21hVEt1aTM4ekFiUHhDYUpEWHViK0RzUUp6WjZVc1p4MzBJdkJ6NHNSR0x5?=
 =?utf-8?B?RHRMc0JaSWNPU3E5bWNPRDIxQXF1U3lhb0pTd0dyekk5VWJVQTZZV1FTZG9w?=
 =?utf-8?B?eXhHNHkweGpDTjFHMGhob3R5RGthU2NmcHR1VVdlMGxkN0RUM3dabk5weHZq?=
 =?utf-8?B?RGg3aVZNNzNEUUtiMHJ3Z0VsSGcrRmQ3R3ZNM3NnVWV1M3B6M05QL2FzUGZ4?=
 =?utf-8?Q?3zvOp6wSYZFUpjNhkE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3188383f-ee34-4fde-8eee-08df3c33d03d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:28:54.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcBaz7wHckTxFOjWKr4gYWNolP3ZPwVfLiZxRrur/s4hXr89w2cL2iQhZJMfwahD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928

__split_folio_to_order() calls prep_compound_page() on each new head page
to create a compound page after clear_compound_head(). prep_compound_page()
uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
and frozen and no one else is supposed to modify the folio's flags.

However, code calling migration_entry_wait() can reach the folio by PFN,
then access its flags. It is because softleaf_entry_wait_on_locked() used
by migration_entry_wait() sets PG_waiters concurrently without taking a
reference and the frozen refcount during split cannot block it. Meanwhile,
__SetPageHead() does a plain read and write, so PG_waiters atomically set
by softleaf_entry_wait_on_locked() will be lost if the set happens after
__SetPageHead()'s read and before its write.

One example code interleaving:

CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()

1. clear_compound_head(new_head)
   new_head->compound_info = 0
   (page_folio(new_head) == new_head now)

                                           2. migration_entry_wait()
                                             softleaf_to_folio(entry)
                                             page_folio() -> new_head
                                             (not the old head any more)

3. prep_compound_page(new_head, new_order)
     __SetPageHead(new_head)
       tmp = new_head->flags.f  <-- load; PG_waiters == 0 in tmp

                                           4. folio_set_waiters(new_head)
                                             set_bit(PG_waiters, &flags.f)
                                             enqueue on waitqueue, sleep

5.     new_head->flags.f = tmp | (1UL << PG_head)
       <-- store; overwrites step 4, PG_waiters == 0 again

Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bit(),
and CPU1 can remain blocked indefinitely.

Fix it by adding the atomic version SetPageHead() and
prep_compound_page_atomic() using it. __split_folio_to_order() uses
prep_compound_page_atomic() to avoid the issue without adding an atomic ops
to other prep_compound_page() users.

Reported-by: David Hildenbrand <david@kernel.org>
Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com/
Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: use
READ_ONCE() when cloning folio flags during split" [1].

[1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
---
Changes in v2:
- renamed __prep_compound_head_and_tail() to __prep_compound_page().
- added comments to prep_compound_page() and __prep_compound_page().
- Link to v1: https://patch.msgid.link/20261029-fix-split_folio_to_order-race-v1-1-a483c7451b0d@nvidia.com
---
 include/linux/page-flags.h |  1 +
 mm/huge_memory.c           | 10 +++++++++-
 mm/internal.h              |  2 ++
 mm/page_alloc.c            | 25 +++++++++++++++++++++++--
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b0ddc652e76cc..08492ab3da895 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -854,6 +854,7 @@ static __always_inline int PageHead(const struct page *page)
 	return test_bit(PG_head, &page->flags.f);
 }
 
+SETPAGEFLAG(Head, head, PF_ANY)
 __SETPAGEFLAG(Head, head, PF_ANY)
 __CLEARPAGEFLAG(Head, head, PF_ANY)
 CLEARPAGEFLAG(Head, head, PF_ANY)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e86845..319b038eba89d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3779,7 +3779,15 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 */
 		clear_compound_head(new_head);
 		if (new_order) {
-			prep_compound_page(new_head, new_order);
+			/*
+			 * new_head is recognized as a folio after
+			 * clear_compound_head().
+			 * softleaf_entry_wait_on_locked() can set PG_waiters
+			 * on it without taking a reference, so its frozen state
+			 * cannot prevent it. Use the atomic version to avoid
+			 * losing a concurrently set PG_waiters.
+			 */
+			prep_compound_page_atomic(new_head, new_order);
 			folio_set_large_rmappable(new_folio);
 		}
 
diff --git a/mm/internal.h b/mm/internal.h
index aeebb3e49ed11..9b8864a8540aa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page *tail,
 	VM_WARN_ON_ONCE(tail->private);
 }
 
+void prep_compound_page_atomic(struct page *page, unsigned int order);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 143776e671abb..fbbb0cfd9f9c4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -682,18 +682,39 @@ static inline bool pcp_allowed_order(unsigned int order)
  * This usage means that zero-order pages may not be compound.
  */
 
-void prep_compound_page(struct page *page, unsigned int order)
+/* Set up the metadata on head page and tail pages. */
+static void __prep_compound_page(struct page *page, unsigned int order)
 {
 	int i;
 	int nr_pages = 1 << order;
 
-	__SetPageHead(page);
 	for (i = 1; i < nr_pages; i++)
 		prep_compound_tail(page + i, page, order);
 
 	prep_compound_head(page, order);
 }
 
+/*
+ * PG_head is set non-atomically. It should be used when no one else can modify
+ * @page's flags.
+ */
+void prep_compound_page(struct page *page, unsigned int order)
+{
+	__SetPageHead(page);
+	__prep_compound_page(page, order);
+}
+
+/*
+ * PG_head is set atomically whereas the other metadata is set with plain
+ * stores. It should be used when @page's flags can be modified concurrently,
+ * e.g., in __split_folio_to_order().
+ */
+void prep_compound_page_atomic(struct page *page, unsigned int order)
+{
+	SetPageHead(page);
+	__prep_compound_page(page, order);
+}
+
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);

---
base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
change-id: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c

Best regards,
--  
Yan, Zi

