Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793499337;
	b=RTKcS6XgayuRkH+EookyNC61EJKWqfe0YyGyff870h3Li2ilt9QvkFD+fNQfs0XvjLQf
	 9FsoE3z25rnyYgnT1HvCPKsBOnXsesSU99v2tcfEs9o7Pr4pvXSYtKb8bxEgCbilmZtEC
	 xviqxXlQOi11hdfm21pnoSra3tbNS3ZMPSPq/rIKKmYivH9E8QpaJbglmG8ItUxjg/KB/
	 5Mn7Wnr+zIPXCjeC+0S3oBTF6uzq6OfrOuxkgavDY1SCxxIlfVpFC2AVBvmqpSDRAL8Tv
	 bdlmhJn+PxyoXKUzcTN/ieevHbzzLZha8c0nax9U3Czovs58ZyxjWQCoEQ5O8gqKK5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499337;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:Subject:
	 Cc:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=Df8Au/baxQ3s+/rD1+7OE87Z9/kvV7Yk95TbKzYoZiQ=;
	b=KAMK4KLUzZdhsx1/Pf9c1UJpEnV9wL+Akw1m0j+SQzI8b63Y/0+cItaW53HAwUiw6r4x
	 xcA1oAcH23rYniqspLIbjiVLLRN1RVp1Z76D+1w8MQfSF9yo1M6VvH/Wq0zS2twWQu6NR
	 UBn2wOxgdQaijHOzLKlYMgAxESd6J3bkmZLYWF649AU+Ur2fRmSNvIEFh+HFXzvaNsi62
	 /eLNMKKumuMkWz79ux7satTfcgWW37dzSDc1ex+AntPqnUTKJo7T5njZsisbTi03g6IMb
	 PBONXNIrGowpZ/FGbA985HgVhFb+iimvwB5oqURruSA0lo8vMBp/RspOR3OduCgQdYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dvu304yl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.59
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12989606A33A;
	Sun,  1 Nov 2026 02:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12989606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dvu304yl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6VixSR5ETgWWiDstb578s+UtYtORYFAxqYZVOcyCdYDecB3Y3TOEG2ZyBTDWL9QwfijeO+19wmesF916tK6uDeMGl8f2CTk03OWyvqjGvv/uKYxAeLLxflzpH1DNeCMP0TN+SbWWXG4TorTfe3n/cqEIaUgrNAXtRq4dgZ0QjFLO2o84R0IQTu4PmK3slQldAzYda91+WG6i1HUrABnar9IXa2mIGRqPgVaOK0yxKxzfE3ALBlVnPjxBk3dJFvSf7y38p/cssX1xTypE8diVdQYw+zBcymHguvcNr+a8kfVDCZ4Mzfok7h/5UHwirQj4+AH2ifHJsxJg+Ivr+LCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df8Au/baxQ3s+/rD1+7OE87Z9/kvV7Yk95TbKzYoZiQ=;
 b=v9dVTXtnwaQELngqr5ZjdAFi3DlRlYjLCzM8g/Ba0NjIQhhk8Rve3KBkdnNogCOo2eRoXJrDPKfqQzFn6kMlUEHD7blYmAvdv5RloOZxg25mILO4x3fDjtfl3z1SWM0/LIId+EcC2620f9lbzb35aGBR3VAGE4kmbu2xatoDweW3ohAEUR1c1qXT0EsYlaZUc8nGbBkhD4maB8VUIqNRjgPjnpir0TL52yPybcqIp52aree8++Mbfcmc6hJCPwIribEEMABX/Qfgt2qzgTLKQVS/kecHMlow2SwbQ9chWsFRm8URcqMm+MnR9cHf0pKg8v7rGEYz9Pmmym7UvLwGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df8Au/baxQ3s+/rD1+7OE87Z9/kvV7Yk95TbKzYoZiQ=;
 b=dvu304ylsRiRdkbnVwwBcmpBC1iAokbprhfXVy4RYGyhGKSRmQaQVb1ThaZuK4q5nwq+7H+tTgDndrfoB2MIneM8SeTs7MlpVqFQU3OugCcYnfzdTFDK2G53Uhg8qylOEyFzCCxfYYvBuxwz/FN7UvHVNwwM1YmH7ifV6YacMWUxDE4Uqruj7+2g5kIzK0RkC6madNlOkHy1xLSt6r6Lc1TU27aGK7zkFARAQFW65axDopvi5gD6sdBecBbvoJbvfdIHF0g75ZpQ+kEPSzI51gxoo+pTvW0FLEWin5okBc6CWl0NjcZwOXiHRNyjK+2C9hsG6iz77aCudsp2oDocLA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sun, 1 Nov
 2026 02:15:33 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.010; Sun, 1 Nov 2026
 02:15:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 22:15:30 -0400
Message-Id: <DMJIGA3R5FXI.PMOOLFYAKZRF@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v3 13/47] mm/huge_memory: fix truncate racing with PMD
 zapping
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Chris Mason"
 <mason@kernel.org>, <stable@vger.kernel.org>, "Muhammad Usama Anjum"
 <usama.anjum@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>,
 "Shakeel Butt" <shakeel.butt@linux.dev>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Barry Song"
 <baohua@kernel.org>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Baoquan He"
 <baoquan.he@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Kees
 Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Hugh
 Dickins" <hughd@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "Lance Yang"
 <lance.yang@linux.dev>, "Rik van Riel" <riel@surriel.com>, "Harry Yoo"
 <harry@kernel.org>, "Alistair Popple" <apopple@nvidia.com>, "Nico Pache"
 <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain"
 <dev.jain@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl Shutsemau"
 <kas@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Nick
 Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Minchan
 Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Xu Xin"
 <xu.xin@linux.dev>, "Chengming Zhou" <chengming.zhou@linux.dev>, "Chris Li"
 <chrisl@kernel.org>, "Kemeng Shi" <shikemeng@huaweicloud.com>, "Nhat Pham"
 <nphamcs@gmail.com>, "Youngjun Park" <youngjun.park@lge.com>, "Gregory
 Price" <gourry@gourry.net>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie
 Kim" <rakie.kim@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.22.0
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
 <20261031-fixes_core-v3-13-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-13-d6437171ecc3@kernel.org>
X-ClientProxiedBy: BN9PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:408:f4::22) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd22eac-9da6-49a8-464d-08df37be0235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|921020|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	je7p+uqpjYpJgIWmjzcDQrFOeEaNrKOnd+KMaawO7aeXmyez307BsRgGO2fXq1Z/mLGeJbFCbBKUOWpH3kseuSpsrk42KfPcyc+k0nO4s61K2exZUaQzuknkbcZE2maFy53IZ5YhOadVzbDj+K+Q9FshIuSa2CZojT8K2SjcSy8Jg7vG5pf+3UA0Hsj++DW2BGxSiycDCQHPvbdH2jkywf8RipH8r+BVsv8DzjfoSzQZ6eLBngVS1h6ISW0TyNM1V7yF3WCHVrPnMsXlUKpl2OEDglfh6xqlBySNkKV2V6ON4GF1avlGj86O0hM8akPmvlU3OxzLZqSZ3l4g8NDJgMrIlLV18+WX9aSaSdfpgvdaDXdB9hrO0bNp76oISXDxvO4RM8k6tJ6j34hhoNaeTPndHIO2ng4lGBGF+j3FBMgML5WsYGn+BGlw8SWROlGgLD1hrpEBbEv9VP+7mGb5MZ8WgVJo8IjlaXzm9YLO1SGxRiVmfLPE171pQs34AdLHgcXllhyA/kUVTn1j/mWWO51xNxkk29HVbR5uXtTaknEtu+3PIM5xFYR7e/28lMYqNfhCnAhrvrvRpN+NFtdxTLB80FlG0HDAJ75e0V06MiISM+NDr+0nP7CGPhq1sLUQGBVFkdtfQBPWOILjFb63CqTqf5z9E3s0W44NIgXf48DthlYnKsFNm390LWzvgt71IG6Yk2KBpjDq2g0P0PdAWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkFlQ3pmSHdJbDA0em5xVUtVWDVRM1BGUWd2ZEt2dDdRRWJUdnVmRHBPOStw?=
 =?utf-8?B?OFUrdndDdTFreVl5ZHYrWWlyRE9PRkppLysxbVhYbFh0dVlOaWtKdSs1T3pZ?=
 =?utf-8?B?UDVKR0dzWFlXcVJZOXNXeXRab3YzL0IyUUlLeHBuM1VTbEZkanFFMGZWSUFp?=
 =?utf-8?B?L0ZRNHJ4bnlVUTJkcVptYnlwTUV0WXQvQi9NZkZrVWlPV0p1NTQzeVZ6RFoz?=
 =?utf-8?B?NGtyMTNTWHJ4T0thc1puQ1NSaGdiTW45R21OU25xOEhlYVdnRmVCTFo3TStV?=
 =?utf-8?B?UWxXcTJid2tuK1JKZ0pNdVZkSWhsc3cwdmNha2R5aFd5UjRNaWhQc0VvbUow?=
 =?utf-8?B?Zk50SEh2RWtZelVCZmZEYU4zY0l3UGtxaThIZGJ1eFlBL2J3bWdodHpQYzk1?=
 =?utf-8?B?d2t0M0lsZ0ZJd2IxM1ZCZHhjODBhNCtNRG1IcjhLWEFRa0lxbnBMbnBsZDNM?=
 =?utf-8?B?V2NJTEpwRkJqR0M5TThPYTlJWWdtM0hGdkdicXdxUkE0cnhDSXg5eEJqLzFC?=
 =?utf-8?B?dWNLRURtQm9pQUp0dmphVGowRlNiTnVjYVQyYlpPL0lhMnpWc2hHNDNnMGQ1?=
 =?utf-8?B?RHdhREp2UmNaVEl4ZGpjcktjZy9oajMzenkzdFpsRG1GejIwbGNJeGh4bEZ5?=
 =?utf-8?B?TEN3TCtHVFNKS3NjMSt4dm16MXNHSDFVS3RUMG1leG1SY0hCZlF1QWJlbi80?=
 =?utf-8?B?bnl0aVBQODNnS2YzTlpqOGZtMkthQmV0dTlTdXZ4ZkMyYU1Vc3M3UmZCcmVp?=
 =?utf-8?B?Zkh5TklMR1BDbDh5S1I4ZWZnQkhlNHBHNTNvU0lWUHM3SHQzSzlJbFpJMGo1?=
 =?utf-8?B?OHM5NGgxNmNsWVliZnhSekFhLzVXYWJybkIrcDZ3VWw3OVhYWUZHbitGY2Np?=
 =?utf-8?B?ekdoVTNGRU1raXhjYks2QVVTWG0yOFc4enZtdnIwQlk1WXN3aEt1cnUrdW5n?=
 =?utf-8?B?emhHbW5KcFE1QmQ1VUdxeXFmRjh2RXRqL21aNWdBclh2anMrd0FYZ0ZGcEFY?=
 =?utf-8?B?TXhCanFEVFNMd0J5Y0FYTVB4eVhYT3NkRW40TWsvY05TVmFKVjhjQy9halRH?=
 =?utf-8?B?VmJJYUthWXlRdzVPUzdEVGxrTjA2MmpBU3BoOWpwWkdrOEEzUFVXRndFK1Zk?=
 =?utf-8?B?U1pncDFIUm9ERlpsMXU4bFp6aXpxNWRSM3hjWmZTSjhPZkVkeUdrRlNXTGs1?=
 =?utf-8?B?WUliTm9JSklCRXFlZTFoTVFtYVJlMUlXTlJMSGJoRC9SeEw1emZBV1JBM1p1?=
 =?utf-8?B?cVRhdm1tei9WNmpaRjZ3b3M1N1NyMWptV0UrcUJ3dTNhNkE4YXJmRlFCQ25o?=
 =?utf-8?B?NzFCRFh3c1p1ZmJIczc4OHhGQVlXYVVyMzZFQU9FaXgrcUFySFZYZEVyaVVF?=
 =?utf-8?B?QmwzRnlRdEN5d00wUXhVK2FTZ0tOczZ0SjI2WlZ0VDNaclA1am9TTGVGMUxB?=
 =?utf-8?B?aTFxcUdqWjdYQlUrR3JqNDFNczhJazBrWGpTWDlOSUhnV2xVY1BSdk94TjYy?=
 =?utf-8?B?N0ZMdXpPMm1CalozWi9BSHk5ZmFwR2g5Vk92L1lUQ2ppOGdudzFremlWeW00?=
 =?utf-8?B?TjQ2WUtEMXJOTktrUjBWVEhHeFlIeUhrMUJkVUEyS3F5dE01OHptS1FURVRR?=
 =?utf-8?B?S0hNN3ExTk1ldUNJSFlyYjlkM0ltNGVJRW9vUXh1RmlGRDRyWjVMYk1qWnFr?=
 =?utf-8?B?ZmtVWmVVNy84UzRXcHRROUtMZ2tZWms3bDdrVUxDNnZTTHlxY0tUekVlVzlQ?=
 =?utf-8?B?bXhsbUhLclRpTk9Hd25ZZVZYbDJDTUZnb3JtT0lDVHY0UTNQMWg4OVloalpJ?=
 =?utf-8?B?Z0w5czU3RDRoM3VacExMakZxVytEbG1JL3oyWVpMNWZINXF3R1RvK2o2dm8w?=
 =?utf-8?B?b3ZNTXBCc0FDWHRiczdSY2Nad3JxcFNEL0FKOTlkVkJHdlMxUnJ5eXhyb3h0?=
 =?utf-8?B?eWxsUnYrQTdNU2tNN1lqQUg2NnpYRUJMcFFycEs5dFBPb1RISFN6M0dvVWxx?=
 =?utf-8?B?MllxRjZJSEJwck9Qc1JKU0p0YnZCZUgyUjNpdko3d2pKSFZNTm9kUWQyRGRR?=
 =?utf-8?B?bXJwRUo3d1F1KzdPTUJ1VE9YdzlmQ1hRTkUvQW9ER2k3Z0ZiSmJNa1lxQWpH?=
 =?utf-8?B?cEVWNVRGZ0VIcFVOY0dzS2VuNWI4c2xnSHNpNXJDRVlzczkwNWZTSUY3bGJS?=
 =?utf-8?B?SWMxUFlLTW5BTjUxVDNRSzc2UTY3UGdJMEoyVHJhWS9tM2VnRERnS3JRTWNJ?=
 =?utf-8?B?QTUvcE1pMVlwWkY0V0JZVi9HMGNZc3hwQ1lCT3JLZFdUYnRUMnQwVTV6S3px?=
 =?utf-8?Q?j+RYmCEF232pg8770l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd22eac-9da6-49a8-464d-08df37be0235
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 02:15:33.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPvrg/nMLWn0+SbINUqEguB7Xls5/9MbNV2ehxog2+pk915LxQ4IYY9t33sZybna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760

On Sat Oct 31, 2026 at 5:39 AM EDT, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
> If this was the last mapping, truncation can skip unmapping the folio
> and proceed without waiting for the PMD lock, racing with dirtying.
>
> ifs_set_range_dirty() can oops if MADV_DONTNEED races with
> ftruncate() on XFS, when we get the folio set dirty after it was found
> to not be mapped anymore.
>
> Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
> matching the PTE zap path. This keeps the folio mapped while updating
> its state, so truncation must wait for the page table lock.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the f=
olio on zap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comment and description ]
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/huge_memory.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

