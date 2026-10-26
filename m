Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793042497;
	b=iTODkXdYSa3JwPGxxuuqxRfaVZDCt1M3c+tu5v/J6aKpthld/Wqjui9pMttKYmYbAhH7
	 rHro60PoWg8P2Luifl1tr+e+w2xIJBqv/ikWDzophpMscucOQGt47mME95sR5hEV0a6mb
	 8zjdZQkMqjWNnXTHnztDne0E+eMtaUmcl4V7sf7/Frt+BVEuQI0k7FwnJuHq+D7uKW3/y
	 Ar+IJKLF9eYYSeGK3Bssb0DcshHrMrBXaNJTJCSo0zcVCGKvhL7pM7zfUjMfkSopxNgRa
	 CZttzsCFWnCUTQVVdT4jvxDDQaR++bfIFTii2zrWFIuB5AvtzKD/xF8CiL1L8engtLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042497;
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
	bh=T1ctztWNX482NIjIqYbvV+AasLz2cibtJKVUc8+Ifug=;
	b=fdpmx1X/AZ5GxFOQRuQnLY6RnZ9WWtUNDUfzl1YQ+eQ9xNRbJo0fkOrALOqEZJ2qiujh
	 xgTfAjSk0R/RxMJu0m6riQE+iD0R3NDIVdgEXXk09yS1OXyQeV/wVscaZxCqo5DRgPhWq
	 ALjQ+AiGD3bY8Syppxi+KCRTROvTjtQ5uNxQo+w3NN4ZdSI6d3aLJvLzTym+7wb9jPXcm
	 0viKA2y8yvkWoOpQEL+sUzYES1oPUGTumB6daK4g/bC93+ic7O0oXIKADLTBx0G2tl+7x
	 bw7e5GsVHsHn5j+b7MsO/Elv17IvUCMcAYwOqhYdeHROA27d5Wil0dN8+wNBq4R8RnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RKikyTCu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.50
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576DA606A31E;
	Mon, 26 Oct 2026 19:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576DA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RKikyTCu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPz5LUnri8YL8owt4sEK5jP5Mh6NSrXZNnaz7XBeoZG6LIsh+XCh75qXBrdDr1y5WtniwMwD17HIQ4+KbknENgeb786MZIJ37G4OgKAqUWYmsH+o8KaNnc5sr80Z+E4G7OozrWMP6njYJ7b8QALeTaNkluphctsG+av+u8Fh/d57JXeJyp9CL8uRUmmG1e4N2e/oPPRnbXrUY8tzKp8zhH4P6Illlz30y0vlfObEzRixZIKUpgqnVHLA2hbfAtXhqI52XvuEzuk9gar2TOI3GVkgrWOEDRLmpD1LhCLNo2pR38xKLpoAqLjri8p03cBSj8caO5P7B9niKotHCLsyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1ctztWNX482NIjIqYbvV+AasLz2cibtJKVUc8+Ifug=;
 b=O14HilhGAbqnzrGSnjS69Ktab8VB3VvD3jq61ZA8QJaSk7UmcJC9OCqyIfRuU6Bui1Qv2zC4CVz6WZk50wRRNTJGZQIqVjDnACZKmnZ/X0gvuVl/hwRmN8+MXFGPOzbAnxCHp5LDVrw+SCHL9+AEjn204fBBhELA24R0mBpQ8PW888R9qHjXOzxZaK9MfHwR7Vqssn4gEKurLPzQZZ5rNcO2GSoaph9mTF6N43iNuSmSaK+zq0C4IsqfZQofc5+1syCeW0XWJf83o4MlLLJnZnOtHidMwRsqhPMAiv6KtGJ54dMUBzYCvX40dUT4K5ccmsBDDP2UAA7EbIWmhggNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1ctztWNX482NIjIqYbvV+AasLz2cibtJKVUc8+Ifug=;
 b=RKikyTCuTv0TGyRj3RxzPP6nrDuvNCovU4Gjg5aL13kYTj0UHurh8Qa7XuKTWJFvsFLnEKz1UKkeNNFAzBw4/4jkzBPfZvC4x7OMjPkbZdFeqXusrXWHGdWr8ZOQZaMMtYru4kZ5KAZeiptzuLDgVgCoqovbDauGFMD6FHkorVs5MtAe4S+aIcWUeBs4YVNy3m7khxEqz0I7kPz7MZHsd86inevrPSb0hCXxNcU3FHJM/mpu0OmL1Wbi9wSFE9tO1f+NkOKIIOOJlcFdaTcJ+VMiWd6hbjpLyrjnLzebzJx+w6IpcPNWf0e5dqfV8JG3z8gejljx1VlljonM3IwsyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 19:21:34 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 19:21:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 07/16] mm/shmem: avoid moving the truncation start
 backwards
Date: Mon, 26 Oct 2026 15:21:30 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <2E377C76-D62C-4A2A-94E3-ABC40C6FCDD2@nvidia.com>
In-Reply-To: <20261026-fixes_shmem-v1-7-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-7-703206d5fa0c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0892.namprd03.prod.outlook.com
 (2603:10b6:408:13c::27) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b4ce4e-d6f9-4d34-eeaa-08df33965907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|261026121527099003|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|261021121427099003|10067099003|261021123027099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	J6n6AHmOZyoIcgd2VKZifHWDFd6cwrS4MNchjxGsoV2TjQQbeTIVmbY9uTq2iUVglJi2NB6zFftPpv0RO+8nnuUUiRipIZFuof7TmfwO1hyuTnFvdFq1J7aiwM2ebGumhrTVa4qLotgrnTTzRdLrSwTSjTbZQxF2E5C93qAw+WYnWglyGZb7E74KUqG7FNYnSSvyHh3NSQNtaj6Mn2W6zzZYaf1yaarBNX5llIZAKYrbQTs1N4Zp9qBP0Gh8YHepY7rbVxPmSTF97HKY2CpJkU3x8yEXIYVQt0st2YGgK8msWauMYRtxV6bhE22sRv0nmKbYalCYhn2gET6yKsdPuRnPULj+d916SAyJMV5UAvynwAtlTKtvNkWxgAAY52xTyMqImRaDR2RdWNLVI0MGfLwVwnqdv/rj3LKukt8rpSZXQTvVXG+qS/Z3ic27xwWCbX0OwnHZ7VC9ZoauTdMt7tFVvpq/4DZF+4A2JpcLV7l9nvN+ce4BLBYrHnh1rV7CHCufpbfjrao+FML545QFc1EC1cQgSb0PKDGnltSAWjzYNz8iw5i+d1KuhZMSqx8O/VL4tIoF2ZtrWR5GTSi5T1XLrF9ZDM8bw0t3mxZl0opl2BjhvDpQkwxUw3KYxgotEg/VghC6pDYA+dV3f+MpOJkfpIbvSvSVkonDRScsn54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(261026121527099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(261021123027099003)(22082099003)(18002099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MENrelJwUkNqSU9lTHh1dHB4ZFNvbTl5N0tVN0tCcS80YnE5YnVMTHYxdEh4?=
 =?utf-8?B?MWdGK0gzTmZCMFlJTVg4RTdKNmlQSXFGKzc4MFEvdWFySk9Xc25LakRYOUxX?=
 =?utf-8?B?bGpvbDk5YVZ4cjZwSkQzaWRLL2UxZ09mNDU4K25VSXJDWlQ3OHRvZFV0bUZN?=
 =?utf-8?B?YU95amhxMHA0SlZyRGZnTG9rTkh5SGFEaFVON09DR1IzNyt4UVJDREJqTTFQ?=
 =?utf-8?B?dUlpb0F4R2ZqSFIrcVhYNFhsbHRMVXc3UlJuT0IxVnIzbnpqc2NHQjhUL1BU?=
 =?utf-8?B?dDYrMVZvTEs2TU9kUjYrVEhDQUJsS3FLdDlxMEhuRkhlVHFyZ3ZBWi9kOExh?=
 =?utf-8?B?dnNsWjF4dlduTS9QWWw4SHNrVmlxRzlFQTdRNXZmWEs4N25KYUlsVnRzQUps?=
 =?utf-8?B?aDRxaWwvT0pWZ3liQ2xITURBWjRuNFEvN2hyQnRDSWhMRlFraFI5WEVFektP?=
 =?utf-8?B?RmJKM000RVBnQnI5TFRxRUkzTXdZT3l0MEtIYWJKWFFGN0lPRmY4a29kN2Rv?=
 =?utf-8?B?ZWNEZlFCNklOUGMvSk4yM3RxMk53dk15bU5Ca0JEeHcrNU1HTXlWcTBNdVRE?=
 =?utf-8?B?Wk10QXp1WWdjeVJ5cXd3QTdyVGw3S2l3V0JFbWxFSVRRNTUxY3ovbDNFaGF0?=
 =?utf-8?B?Y3ROaUtOMHBBY1o4dTBTcWtnRHBETDMzdG5ZUDVoSEtFTXpRdHE5bm5kaDlk?=
 =?utf-8?B?dS9zUGV3d2gzYXZQZE04SHhnN055RjFnSFpRYUdCZ083RVpLd1Q2S0pBR3JY?=
 =?utf-8?B?SVBYNUc4OUFyTkpieWwyYnF4SHplckpjTkV6OVdOS1YyNzB2R0VsbU9DTDVB?=
 =?utf-8?B?a2t0SzdWRkVkZ2lzY1p6OERMcUwvM0tFUElBV2RPbHEyaXI5c0tIN0RKZ1ZM?=
 =?utf-8?B?UkNjZHJvazZBQjJURHh1UGJpL1YxNWtoTGQ0SG5FWUVscmxMN0RWbEEyQS81?=
 =?utf-8?B?aDFDWERDdjNFbHl0aTRpWGcwdnBGcTRnc2Fwa2NRelQxTXE3Z1FUU1hGdFJr?=
 =?utf-8?B?S05EOTlLZW03b2ZyK0ZPd1hnVG0yeml0dnV1dmF5UWVNSndXdFIzeGIzK0Fr?=
 =?utf-8?B?TFpHVi9pdjYyQzdaY25ac2xnYkpxa1dGODlGUHVRK3B2b1FQaVIvRk5kQnQy?=
 =?utf-8?B?TXN1cmRjWS9ndHZqYVJNeUlaNEhPbXZuNGFvTU1LTm5ORlkwVkwxU1NXWG9E?=
 =?utf-8?B?dndNSmNaOWZ4cmxyYnNaNmx0OEUvUDJIRnlFcG9tSFgrYzVLTUR3UGdleFhv?=
 =?utf-8?B?R0c0M3pmWXErYTkzcVBsNThZMkVJS1oxdUJ2YTl3RXlKT0U5dGRoSEw2bFgz?=
 =?utf-8?B?RWc5ZWFMeUZKK05yb0hOQk80dzNETzhMUzJ1RVpsYnFJWHpkM3Vna2NMQWlj?=
 =?utf-8?B?VVJkZWRxS0g0TFlSbXBkMTIxUWtadVRoTmFvbW5GbC9UMk0wajlxZ1FoZ081?=
 =?utf-8?B?a3BzRjVndGtzNkZsbFJob01SNnBvZXlhWmhIZ21hYjFBLzlIQ1ZYVDZHMU1u?=
 =?utf-8?B?NU5JU0xxNFA4V1hXSFdZNUxxT2ZtUXdvVldBT2R4ZlRrVHZ2bUI4MUNlMkZt?=
 =?utf-8?B?VDlsSzBid25abDNTL2hXRnFkZHZlMk1VQjl0VTBoVlBJd1hXZ0dqUXJjbGN2?=
 =?utf-8?B?ZGI2Wjk3OUF0R1hDUkVsek5sczBoVXVmOGtXQ3ZiaDBubHBPeFJXUWtlM2Nt?=
 =?utf-8?B?SDg4MGlMRktRdjhRM2U5SkpEN2Vrdks3Y00wNTdWdUltRGU5dkw4ZzR0WE51?=
 =?utf-8?B?RjZ0d2NtQy95N1l1RUpIbm16bEpQQ0Vhc3BxTWZQNm9IdURmWERuMVlvVUhD?=
 =?utf-8?B?RnRiMGt2N2Z2b1d4YmxNc1dEQkJVd1RmQWtaK2taRXlROTg3U1pnMFNxZmlk?=
 =?utf-8?B?Tmdmck9NVTZYQk1aNWVVZmdLdjE1M1k3cXdFVHpiTmQ3am9WYjkwZTk0eU8w?=
 =?utf-8?B?ZUx3ejlLYllONnB5eC9tZ1Z1a1h2U2E1VFNOR1RwQXBYcHdOM2FVbFZ3UCtq?=
 =?utf-8?B?UVlVMVdsT3l3NlY2YkQyanpkNU1kdDlnL2svWi85V25qcFl4aDRnNGl1d0Mw?=
 =?utf-8?B?MnhabjFXTWVwMjA4Q0RWMjVrVHRxNnE4UkF2ZEFiUmhxNnVLVEM1RGFsL3J0?=
 =?utf-8?B?dmVIaU1JSDlLVXRwMmVpZDRscllYTS96ajMzSlJOazNJSk1jMHNiTlFqSlY0?=
 =?utf-8?B?R2cwaWorSmI2ZUlKT0hUbHo3enNkcVdrYlJ1WStSSXlJYjV6blBIUUdyOHhG?=
 =?utf-8?B?TFI1Y3gzSkdkc3Q1NExuSmFhRmNtUXNmSDVYb0srMWxiaVNUOWt0bXQwQ3VT?=
 =?utf-8?Q?dBZ2c1fDn0F59g92OP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b4ce4e-d6f9-4d34-eeaa-08df33965907
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 19:21:34.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yb9dV+1uBU5neY5oLETyJrabFI3IKNc2INvdlmYIUnD8SGqfyIVKLZ5X+8FloTAG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753

On 26 Oct 2026, at 5:40, David Hildenbrand (Arm) wrote:

> From: Chris Mason <mason@kernel.org>
>
> A nonuniform folio split can fail with -ENOMEM after splitting off some
> smaller folios. shmem_undo_range() then sets start to the end of the
> original folio, which may now lie before the truncation boundary.
>
> The final scan can consequently discard data below the new EOF, or
> keep retrying a large folio whose split point lies outside it.
>
> Keep start at least at its original value when skipping a folio after
> a failed split. The part in the truncated range has already been zeroed.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate operati=
on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: split fixes, simplify descriptions, adjust comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/shmem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>

This is fixed by Zhang Yi=E2=80=99s truncate_inode_partial_folio() fix[1].
I think the commit is ad27479793682 ("mm/truncate: fix data loss
when splitting straddling large folios fails") in mm-stable but
not upstream yet.

[1] https://lore.kernel.org/all/20260928120833.3440834-4-yi.zhang@huaweiclo=
ud.com/

Best Regards,
Yan, Zi
