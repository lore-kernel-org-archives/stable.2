Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794330195;
	b=3wZFAYPYhOlByLbbpCvWCF7NEvPSk0aTGm1JgjCyb7Bx+esomDPgFp9wv/UYHafnCr98
	 BMjtYqzNqjn11PdR6u4I2b5I5B6qSs4o/sMIA/NpRVkZMsxoiEhJZZWG7lf0BRmrHuucL
	 uhLBMWWseIHB51FYrkkrsWi8am0ymoP5qxxgybtMfJAmKgpUNj2LRdzJGRxLT6LHziJeB
	 W0/sv5zo2TOunMsnqUgw/qbQKiTdS3fnl5G73qhl4jLO7yb5gMBErF73QUHmtHGUvRXxo
	 3Xdyc43ewsT16hBIVhIcOZL/o2bpn2drlIDAwxEt3psFco0YGRkbai/n1I/XKD7jXtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330195;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-MS-Reactions:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=uZ9qSLBO/ZEn6ivs16t3Q50Vo+/avnyxRpWVkeUI7Bg=;
	b=L6fTKG3hd9t/ngX2Z9ecMDlW88+sZQtZ3ZU+0hKL2Y6D1DSbMdGfwGQf9yC37lUgLBBX
	 +lRglx+ZA4n50g6G1bsjPO1iIrtD8cEiWPD07UMRtidOPekKezcVt7Tm0Rza9ELDgoqoi
	 tq87G1dtqiihGXGVDFkhK3BaJmRqNKlmk0pSeVN7jlLZcxrNCoh/qSqFQgW6ehWp3kT7c
	 3SVl9vuCcIFctUcglNksI1CDYExNCG0I1mUDHhE/C7STCBoy+39y1NNbccRTU+fXkrYst
	 DE9JthdnRfKvDZEFvxafjF4URXc2ao4R61tdqRwM9Ba9jQwvBckzSZRQ62jF7ZnmSIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="sK/Xmg3a";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.40
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE846606A32E;
	Tue, 10 Nov 2026 17:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE846606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sK/Xmg3a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKRWSB5iT3RXAv6AAGMtL6fVglrvWC5qtDt80yeCuUjad3s3oeMRCay18sFkd1wpf7WbxAmhuEzudewpRd5VjkVcl0eqYp9V8lYnFEzpkpo7v5a6aLO95Qhcj7zKaegNnkJCB6XkbLFHp9rIRsECIN3tL/nKJOOcIKHtklQctYr6B2+vjLUoPF9jp9a9YQVI+qIrLWZQe+e5d8RAcLi48pT1FkCCeOKCO9ufAqHjKg4ICyTS6mumee7odLn5fboeo0j8Ip1ttJnwY3dJr0XgYzczHkj+IaK+y9ZxvttLWulVcFuw7Y726G9lL8GEKoKeR/XH0GeG3yopRPqRtYA/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ9qSLBO/ZEn6ivs16t3Q50Vo+/avnyxRpWVkeUI7Bg=;
 b=mQ3mkqTPO8+36rEHvJ5CoyE/SfriJ88Ck3NobQV/IVWz83P0IsQrtqV99FdRFa6BdBLa/59uU9/e9WOTmlTtu2+d+3pZQ4A9+yQhGWgmkhPb2pjIe282dbIL4u9mWHlHqMIzBfQtXlY2+/Hi5kSCSvB49hBidyfgx4o1KPlBrGP98I5XFJxFdv1lICEOtZibAEWv1KGZFRquZmaS3pcrith3C19NMr2ZEmyChr3BDWZZRNBkn9WsVK22w3EM0YJ2sf4ZPu0kwYOES9++ZwApjZNkijlrQ+q5YedXFueAnEgcBjS8nvZikscGYS2tClPEce2A/T2R3naShJFbbIbrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ9qSLBO/ZEn6ivs16t3Q50Vo+/avnyxRpWVkeUI7Bg=;
 b=sK/Xmg3aS2RTmviQwCO35eZ8x0wIDyBGszML4C9j0B6cJtHYXR2TIVHpB13cK5zD0pWaw+q0vrFYfJ2yTihKoQiU7EVEs3U75LdOxlL4W2azYP5qA6Wu9xyU6IPBqUYz69/lJF0+LnFOPJOmiordg40WSD9aYJHyXy6foHLOTwn1/HkdrY397PQNq33QiM7nMiaGXwX27dKRKRelcMPpPYQIcCFoJkYCJoAoo75X79X65tos8MFXRaf8L1LPkD9qYDnlp7kQ6PVYxizX56sC48EQIfYN2AnuMAV5RhqqaSeMi+l2gCJLlpZ/LmLlb3Zyxp1mcaGxKWpCSeEiC9p6nw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:03:10 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:03:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Date: Tue, 10 Nov 2026 12:03:07 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <1B3B1BC7-7623-4070-ABD7-13A5EE559297@nvidia.com>
In-Reply-To: <a3557629-d86d-42f6-b181-bf8540dc1982@kernel.org>
References:
 <20261109-fix-split_folio_to_order-race-v3-1-1cdc509e34be@nvidia.com>
 <5a7bb477-5392-404c-a748-4748cec2c84f@kernel.org>
 <940CBBBB-D564-4D4F-9C8A-A9A272F08064@nvidia.com>
 <a3557629-d86d-42f6-b181-bf8540dc1982@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: YT4PR01CA0456.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::20) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bb5fb8-233f-4501-6da6-08df3f4c7fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|13003099007|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8PePoQk45rOd1ryhMBLut7/Lq6gcl0ISBxQjaPhHSgjDcYHrbKiUDAPTLto6YfyJtBcPqOBMa39kHgTTNj5ACc9nq9uMcA9uz7Or5xWDCFI8zNC/GZcvGkGk3y/abaImZz74h9VG6YdZpAKVm5jK4x7+oHrgPEW+BzNv+uRasZVmLRCNVEHd2mLtrNbBzqj89g5wzcSmtL/fpppKibCXOygknhaNuB4Znbjbg9Crse4/yLCYKxv1dcogKHNoA/Wql00zV81yQNiD6ZzYGdc9jFGuW121UqEnv5lChYrl84bXq7VWher6fYzaJ30v0pNMb/8534NtgBIFXD08rvFUJb5BhYp5gV9Mqcic9ClQeDooZW5RvoiTurNv4DWmobmcJddJqsgc162C0bEeVFcU/xzTnXDQPYYynKTZF4XB8F9mRwQKLLXF+/Fvf+AopflOKzuAm3fsNS78ZBpdeqJCnFoEeJpZ3sNPZx9RQFHo7qvaga2h8bw/IAvH3GFSqfHnG5jUJJ1Vs8ui/if2fo7yyBLgA33NUEEwfJr16eiQ29qRwazUr6cqkNqSavniGkZnSqd47qfBRGjs6GIn83/q7asGzWvxEPIbC6Rh05zqgcPJSpYnJY3MQZwOstn7t5+NY8oBnV0SvdHXkL9SedqlONkf04EWoKlzq30BdHrQIes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(13003099007)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk5wT2paeXBSMm9vZUhRSnpScEE5UGxZaVloOU9WVm4zOFJ2Z3RpbEc2Vit0?=
 =?utf-8?B?azJlQUNPbUc4Y2pSWC8yL0FqR2lFUzUwZHBpdXl1US9vb2ZvQ0t1bU5rTGlx?=
 =?utf-8?B?ZUFoaDBBOVBFaDdwM2Jib1FXczZoT3dqa2xBTVc3UmtuTDlxaG1HR2h0UTRU?=
 =?utf-8?B?UUc1THNUQ1BTVEZvbEZDZk5FUzNlRSsyWVkrV0VkOThLZUpZRkVaSHBIQWov?=
 =?utf-8?B?YVJEL0x1dURkcE9PT29NVEwzM2JCZGE3ZkdZalBkaE1ZK0dPV3N5Z2ROZUVN?=
 =?utf-8?B?bk5EVTBuYkFJWlN5WjRYblBBUGJnZXBVcEZBbG16Z3FiOWEyMWY5bnFSdlZl?=
 =?utf-8?B?eTEwZ3pXREpVZGdaZUVGdFdacnJoaDRkMkFIM0tpTkRQSG9pVG5PV2VwQ2w0?=
 =?utf-8?B?QmFuRkZLQ2IwNHB3QVNwZGF3ejJWNUZuV2Q3UjRqUWxKOHBZNUZNV2F1bE5p?=
 =?utf-8?B?dkh0Sks2ek5rR3MvcW45SmFaWndyaVY0Q1NFSkNrVWlmVVkvc2dDWmpjSnhp?=
 =?utf-8?B?ZlFIa3loeHJHc3F3Nm5lL0NMenBNSFdrbTZuMVlycGtqejI4aVNtRzBBUkd3?=
 =?utf-8?B?V1Vubk82RGduOVVKYmZGVHVsSi82ZVYyVSs1dmVMdU1RQU5PSDhORmllMWdq?=
 =?utf-8?B?QWdIRXR3c0FaYWVVTFZOc29pdzdJcHZVbnUrWE9lUzlVOTVSZCt5UjVIRG1a?=
 =?utf-8?B?TVZvaUVaalBxbjBkUjJTNWNGL2FNenRvbDJCMDdnVURyeGpwOTVnV3paSEpW?=
 =?utf-8?B?SVJlb3hqQk54TlpmTjludXJtYkJ0cVRPRzU5WjE0ME1rMGJqT0tCSmJKdk9K?=
 =?utf-8?B?Z3ZsQzBNWko0aE03OHB3SkpzMzQvUlFzc2Q3aExDYlN5V3llVVlVNFpkVExv?=
 =?utf-8?B?ckZ4ZW9zZGFKdjk1eEhMZ3dXdmtseHpFR1Rlb2RYMjEyRnNVS1l6UHViUkpE?=
 =?utf-8?B?U040WEpBa1RWay9YbkZpTTBwdXVmUGNGdDhtZ3BkSjhLN3I3MG9uN2dPbFJS?=
 =?utf-8?B?WVgrNmVUMzRjejF3a3ZLV2Y4TkcxOG92NXpCMElQQjE5V0N2VkVLRFFGNy9i?=
 =?utf-8?B?T1ZDQkVPN2x3KzVqbmJ4NGJQN20vMENjb3JhcjVFTHhKYWpNOGdzRXRkZzht?=
 =?utf-8?B?SzUyc0hUNnh5bElnT1ltbnVvOTV0WFhncWduQU5XdXVQYVBBQnB0K09rY3Bu?=
 =?utf-8?B?M2lhV2loNS9McEtkVU84TnYxcUFNKy9YdEpyb2hlcWhlcDlNVjhMbEdqNWl4?=
 =?utf-8?B?a1g4U2hQS2JMZ3VkS1BoZ0hyK05ZRTk2LzBBdmh6NEhuUmc5TW1udi83UzJN?=
 =?utf-8?B?WXIrZmJIMjZGN0QxeStaRjlXVHRTbTF3T1R4N0JycFl5VnFUUlVmY1BHbk9D?=
 =?utf-8?B?QTRkZXhpYmJOWE9vNFFSaEZlWXVBVCs1MEEwc01lTlJjc3VOVGhBWXFTMW9R?=
 =?utf-8?B?THpDQ1FSbVFpSHkzS2lTS2hYZzVja3JkczZWZWg4RTNVZXJQb2M5TUZWTWlj?=
 =?utf-8?B?amV0S09qSDZhNWI3SWcrcjZ0MzU4VllycVc1UzhkLzgwcVlqUWZUbnlVenBu?=
 =?utf-8?B?RkZoVWVxZjNIZ3BBSU5NUTNHVng5NFlxaktwSnl3cElOZ0NTSStVVWlsTXdv?=
 =?utf-8?B?ZGlGNUkrbVVqODdoVFBLUTArK2xUU0hGUTB2c3BlaWk1dndRMWsxOWg0Q3la?=
 =?utf-8?B?RVlZL09MK1pxUTBTM0k3R2Y5TzFTYlhmd0Fxa1FDcWgzQnNHbjY5RUJTdEta?=
 =?utf-8?B?RU5BcU10Y0UvNVMxTVlYT1FzQ3dVdHJzSXdmaENESlhQWW9EM3ZLU1JkaEEv?=
 =?utf-8?B?SmI0YkpBejNaUkRFNVhuQXdra3NDdG1vSE81NkJLS0hNbHNQTzQ5VTNORENW?=
 =?utf-8?B?NGNYRk5DY1FxOXR0WnVnTkNZYlJLUTJ5eFBpZW5sSSthVU9CTCtWdUFta2c5?=
 =?utf-8?B?NmFUQldUNnI2NjNrVXRrL3NBNFUyQnBaVVZQWStaZ1NCMy9oL2RlN2lubGJq?=
 =?utf-8?B?ME9qNTZLNENueFV2OEdMaTBqVVduQ2JWbVB1cWZ0Z2lpTThuUkVpTnlPcEtm?=
 =?utf-8?B?YUlYa2l1TGt3Sk54OGFtRUdnZWxNYUl5RjdvNk9hYTk4cG5yckZWTXlzWUlD?=
 =?utf-8?B?Yy9KdExLLzJWZFFPN2lWeDBnbWdXNXIyVWpTQ1l3a2htZ2hDOXdvZjlKUzl4?=
 =?utf-8?B?S1hVU0FaTW1SS2w2TFlFZUpwSFdFVTJjemQyWUVjMXdOU0NBVUtsWVRkZFAr?=
 =?utf-8?B?dFdEdDRCRWxrR2VCY0VIdDZzNHhyMGNtZVR5bjJORnZBcFltdFJITENvc1ZH?=
 =?utf-8?Q?FNRjRaiC5sHDJNo3XK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bb5fb8-233f-4501-6da6-08df3f4c7fd2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:03:10.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yk7oFZ4g3tIqleld/JPBtGtHlZg5a2GOnHHvc32PxPTsfnDi84SfL8GpsE3GpyHq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B

On 10 Nov 2026, at 6:31, David Hildenbrand (Arm) wrote:

> On 11/9/26 22:05, Zi Yan wrote:
>> On 9 Nov 2026, at 15:21, David Hildenbrand (Arm) wrote:
>>
>>> On 11/9/26 20:32, Zi Yan wrote:
>>>> __split_folio_to_order() calls prep_compound_page() on each new head p=
age
>>>> to create a compound page after clear_compound_head(). prep_compound_p=
age()
>>>> uses non atomic __SetPageHead(). It is mostly OK, since the folio is l=
ocked
>>>> and frozen and no one else is supposed to modify the folio's flags.
>>>>
>>>> However, code calling migration_entry_wait() can reach the folio by PF=
N,
>>>> then access its flags. It is because softleaf_entry_wait_on_locked() u=
sed
>>>> by migration_entry_wait() sets PG_waiters concurrently without taking =
a
>>>> reference and the frozen refcount during split cannot block it. Meanwh=
ile,
>>>> __SetPageHead() does a plain read and write, so PG_waiters atomically =
set
>>>> by softleaf_entry_wait_on_locked() will be lost if the set happens aft=
er
>>>> __SetPageHead()'s read and before its write.
>>>>
>>>> One example code interleaving:
>>>>
>>>> CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()
>>>>
>>>> 1. clear_compound_head(new_head)
>>>>    new_head->compound_info =3D 0
>>>>    (page_folio(new_head) =3D=3D new_head now)
>>>>
>>>>                                            2. migration_entry_wait()
>>>>                                              softleaf_to_folio(entry)
>>>>                                              page_folio() -> new_head
>>>>                                              (not the old head any mor=
e)
>>>>
>>>> 3. prep_compound_page(new_head, new_order)
>>>>      __SetPageHead(new_head)
>>>>        tmp =3D new_head->flags.f  <-- load; PG_waiters =3D=3D 0 in tmp
>>>>
>>>>                                            4. folio_set_waiters(new_he=
ad)
>>>>                                              set_bit(PG_waiters, &flag=
s.f)
>>>>                                              enqueue on waitqueue, sle=
ep
>>>>
>>>> 5.     new_head->flags.f =3D tmp | (1UL << PG_head)
>>>>        <-- store; overwrites step 4, PG_waiters =3D=3D 0 again
>>>>
>>>> Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bi=
t(),
>>>> and CPU1 can remain blocked indefinitely.
>>>>
>>>> Fix it by setting PG_head along with other flags in new_folio->flags b=
efore
>>>> smp_wmb() and clear_compound_head(). The remaining compound page metad=
ata
>>>> is set after clear_compound_head(). In that way, after
>>>> clear_compound_head() makes new_folio visible, nothing overwrites the
>>>> PG_waiters from softleaf_entry_wait_on_locked() by modifying
>>>> new_folio->flags non-atomically.
>>>>
>>>> While at it, use data_race() to suppress the KCSAN issue reported by Y=
e
>>>> Liu's patch (the second Closes) on reading ->flags during a folio spli=
t.
>>>>
>>>> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
>>>> Reported-by: David Hildenbrand <david@kernel.org>
>>>> Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.=
com/
>>>> Reported-by: Ye Liu <ye.liu@linux.dev>
>>>> Closes: https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-1=
12e331291c1@linux.dev/
>>>> Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pag=
es")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>> The issue was raised by David when reviewing Ye Liu's "mm/huge_memory:=
 use
>>>> READ_ONCE() when cloning folio flags during split" [1]. This patch als=
o
>>>> supersedes Ye Liu's patch.
>>>>
>>>> [1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e3=
31291c1@linux.dev/
>>>> ---
>>>> Changes in v3:
>>>> - set PG_head before smp_wmb() like Kiryl suggested instead of
>>>>   prep_compound_page_atomic().
>>>> - used data_race() to suppress KCSAN reports while at it.
>>>> - dropped Lorenzo's ack, since the patch is changed.
>>>> - Link to v2: https://patch.msgid.link/20261106-fix-split_folio_to_ord=
er-race-v2-1-1b59c67b8af3@nvidia.com
>>>>
>>>> Changes in v2:
>>>> - renamed __prep_compound_head_and_tail() to __prep_compound_page().
>>>> - added comments to prep_compound_page() and __prep_compound_page().
>>>> - Link to v1: https://patch.msgid.link/20261029-fix-split_folio_to_ord=
er-race-v1-1-a483c7451b0d@nvidia.com
>>>> ---
>>>>  mm/huge_memory.c | 32 ++++++++++++++++++++++++++++----
>>>>  mm/internal.h    |  2 ++
>>>>  mm/page_alloc.c  | 17 +++++++++++++++--
>>>>  3 files changed, 45 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index bd44d58e86845..99b48d7c988db 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3714,6 +3714,7 @@ static void __split_folio_to_order(struct folio =
*folio, int old_order,
>>>>  		 * Don't pass it around before clear_compound_head().
>>>>  		 */
>>>>  		struct folio *new_folio =3D (struct folio *)new_head;
>>>> +		memdesc_flags_t new_flags;
>>>>
>>>>  		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) !=3D -1, new_head=
);
>>>>
>>>> @@ -3730,8 +3731,16 @@ static void __split_folio_to_order(struct folio=
 *folio, int old_order,
>>>>  		 * unreferenced sub-pages of an anonymous THP: we can simply drop
>>>>  		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>>>>  		 */
>>>> -		new_folio->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>>>> -		new_folio->flags.f |=3D (folio->flags.f &
>>>> +		/*
>>>> +		 * ->flags are stable since the folio is locked and frozen.
>>>> +		 * data_race() is used because reference-less writers,
>>>> +		 * 1. PG_waiters from softleaf_entry_wait_on_locked() and
>>>
>>> Hm? I thought that case would be handled by your patch? How can they st=
ill write
>>> to the page?
>>
>> This is V3 of the patch. Instead of using prep_compound_page_atomic(),
>> PG_head is written before clear_compound_page(), after which new_head
>> is visible to the reference-less writers.
>
> I'm confused, how is it then valid to have PG_waiters set concurrently wh=
ile we
> read new_folio->flags.f? Because that's what your comment states.
>
>>
>>>
>>>> +		 * 2. PG_hwpoison from memory_failure(),
>>>> +		 * can still write to it.
>>>
>>> We lose PG_hwpoison left and right when racing with non-atomic updates.=
 It needs
>>> a fundamental fix. Is this really something we should take care of in t=
his series?
>>
>> IMHO, memory_failure()=E2=80=99s reference-less access violates the froz=
en
>> page contract and should be fixed.
>
> Exactly.
>
>> But I do not think it needs to go
>> along with this patch. We discussed HWPoison flag race with
>> Michael S. Tsirkin and Miaohe before [1]:
>>
>> 1. Miaohe proposed to reset HWPoison in memory_failure() as a best effor=
t,
>> 2. mst used RCU for all non-atomic flag accesses,
>> 3. you also proposed to move HWPoison out of ->flags.
>>
>> So memory_failure() needs a separate and proper fix series after
>> we decide the right solution.
>>
>
> Vlasta raised the idea to set hwpoison only after we actually managed to
> isolate/grab the page. Which might be the proper fix.

I was bouncing the same idea with LLM yesterday, but it does not solve
all cases:

1. normal page: taking a ref just prevents it from going to be a free page,
   but atomically set PG_hwpoison can still be lost when another one uses
   a plain write, __folio_set/clear_*().
2. free page: isolating works if the free page on its free list, but it
   could be on pcplist and we then need to drain all pcplists. That could
   hurt performance.
3. we cannot take a ref on slab page and other frozen pages, then we will
   need a case by case handling for them.

Anyway, this probably belongs a separate discussion on hwpoison.

Best Regards,
Yan, Zi
