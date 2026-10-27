Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135225;
	b=Xq7z9rf1tUNvCk3H2McH38HIw15VqgqueYlegvG0L/uAC0wxLXW7o8zyqxY15kXKWDA4
	 AvbfOOGSMqIOvRHSQP5PKAcchrhPu/QAB/eS5jYb9BAkD1EE7rD8vP4sh7W13B7ISSJ7l
	 pF9kWhQAV1aW6fg/MGpUi/3TsB0xUcNtkftdu7b1fniQAdLJyABQpS6UfMfwIw3xpplSl
	 jAyVm9Zy+dsuH7VR0xjXR9JKc6dGKTdmthdOX7vegL5+Z5YrULZTnR5vYwyBk+mJ3oBiN
	 X8ThBrLxjAMw0InFaWoM0zkyibtarJzjtNZ888DU8A2dbblrWHG709bRVA6EmVDO1ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135225;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=B4HkOEsxsEVxynEZEPOYQXVqD8UBVpbbeERaQ9KtzjU=;
	b=d/j02s/ZT5No1ok23ljq85jZJsnLUyipgQZjcyO4GZw8zwi6YeNKU2rbdR+vRxaB0Hvb
	 S6RPkgNclzXIuB6hjr29L7gqul6n35i0vlOG1dWOXH1YzSTUOIVq/QR3u/VfT4HAU+rf2
	 nosiKDzVH6lZJSt72dt4YwgVJdAzt4RRZw5XHt6gFtv4TFvVq9xNNx6XXlYelLxKI+Noy
	 f7sS8ClD1TK6MYfwV2ZAXYBxZeUM08Ei0EJf1lGGPBBycPMhat6FqFJ8r9+v7pewmv3ZZ
	 N9CHsXyxr6tyvxG8JZCanv0WGAOBLT/xyL38Q2S8+soWlm67uFa9pHZ/iQnYGjAmGhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jjKTwMs0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.25
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAB606A31A;
	Tue, 27 Oct 2026 21:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41DAB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jjKTwMs0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1k7GSBN0QrT3JwxeN4smyScItTkqU37BqkwOhLt6W9KwyDt7nd+BV+lDeh8ZitqW4u/0BQBKguMp5yd5SSTDH2ExcFN4JqFCS4pwDJzpGnZK1ksZxs3WDmUHW9VDwdVgQC5GMXBcJVu0TGkokkK1rEpIIVxkCF9qtSbd1PAcyk5sQe2Gj14B8vdTpyRnjjXRO8XXfeF1k00DKQDfY3/ZInackX/Yn7pF8BQrpnNK3rPLiXy7TwXGvSMMhRfw4D1/GXfywjApVysSIoNRosLryyGT5tNErizSEPqakNALM4k24ilkhcp1QXQ8tfTdtDtU7DnVI/eja3QQnngIkKgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4HkOEsxsEVxynEZEPOYQXVqD8UBVpbbeERaQ9KtzjU=;
 b=B4/cawWPKeQmyFXM2aMcPFlYIYO6ZpKM1UA/FjW1FQiC3Gq049fpzLOaEBtTxLxjyJw+TSf08i3USbtpySqkUF/qDEm4FndsqyjDIPYWu+0OV4E7ztRqVUYDoLXEy9KkJ8iphV3fXAbsRHtKC5JDvZgJJ0HvjJmD2UEdN5O09ELEBUP/gItcKKE5WnoO1Cg4cBkj0ge6+Y4o7dq3R7dS8DZbpp+WPWMQtr9zFyUgc73E8whjB37Rte0b8pUSIfmAEKy6C9arItsnIMd7DIuKvVcU+CgkEPLlLCqsD7tmH0Sx00LSn5K/WXO7ysymCmybjIbcA95i8I76oHsvV2yPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4HkOEsxsEVxynEZEPOYQXVqD8UBVpbbeERaQ9KtzjU=;
 b=jjKTwMs0HgbW8hwgQOHqVx6LrQIRjmevcA1asQneGtT7INp1Ck2BpYjGoFzQcyHOV2UiYEtbx12DzXetGzSiZNrfEcaEqRjsC/qBFHBTRGMdZLKUFArpoqI4EAIUq88wvwhghfXZHpFZ98H3Q1B8e0fvHkKqdG6YYqppOe/eX3kKhzOHiazy0h8t4h+FqsKRp3+TnrBlusI/aT8zH9C2PjkIDoXzpOUSip1WrlcHBoq/LdSAhBXqBAsKn5SRD11yo02F4pzuw1u3PJlyJSdwZVkSbI5iraVVY6l8B7/ro1hO+a/qekZYj0g3yskAtqd+DG9wQL7bpvI7Q0i2rP8eDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA4PR12MB243497.namprd12.prod.outlook.com (2603:10b6:207:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:07:02 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:07:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 17:07:00 -0400
Message-Id: <DMFXDW38IDQ4.CVZOGUDMR8MF@nvidia.com>
Subject: Re: [PATCH v2 09/14] mm/shmem: rescan after nonuniform folio
 splitting
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Gregory Price" <gourry@gourry.net>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Vladimir Davydov" <vdavydov.dev@gmail.com>, "Michal
 Hocko" <mhocko@suse.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Lukas Czerner" <lczerner@redhat.com>,
 "Carlos Maiolino" <cmaiolino@redhat.com>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Daniel Verkamp"
 <dverkamp@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Stevens" <stevensd@chromium.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "William Kucharski" <william.kucharski@oracle.com>,
 "Chris Li" <chrisl@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Nhat
 Pham" <nphamcs@gmail.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
 <20261027-fixes_shmem-v2-9-86a00952acb9@kernel.org>
In-Reply-To: <20261027-fixes_shmem-v2-9-86a00952acb9@kernel.org>
X-ClientProxiedBy: YQZPR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::23) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA4PR12MB243497:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca80da6-9edb-4719-5e61-08df346e3f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|261026121527099003|4143699003|56012099006|11063799006|261021123027099003|261022105027099003|261021121427099003|18002099003|22082099003|6133799003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	KnLWeJ5FfQmYhq9ikTd2GfzqGoRvheE4aJ0tL2+4SKb3SMpiCCj26Uvnu3bdmmChEIAoFAqeGjcYQo5R8cM5HOHh3Qky+faXTPXX6Zv0W3kXz90tmY4Dv15o6xbZ+RNs4OJ3i9HHT424s6qgGf9Ss9I4uTRGIzG35Fcl9FSZF957rEEknDAw7mzsCjz/HKz1ZmsCXpM8zpztswfBJBtiEp562NM3gLJYlYejmWIrMhBw6l0187hpyVMg8abSKxd3JBThfKdw7mBkQh3kIH+NHoddcnon7QasGEppY54yhvCx1NC4DwbtaBBW0HDKPF+zpSClZsa6dJADimfm87+gIgXlEO0cmyEsMqfIgoeVU28EjJDw+s5CoQ2qUDieZCWLIKvCzSM7FglSa+QFsp6MY+V5QuofcUr6vmKoY6GSnCDJh+U2YWKbTNgxX9Gm75OiDOdq3VKgoB9+FOjJ54d2xbwOmxnvcVMIidtciZ3Nng7FZ+ddvOS3slaVS5giBT/0YWN74wTk4x4gGyws1FBfek+zLFU/DRjwAx3noovAejZ03976hvSS+9W9Pa4VLpBaCzKqDoUyZEgJfhQgODN+YRybaHoxgTxGrzhmXoFWJaOOT/e0xvYb+RnvIKSvC49++tmI/aggsW5aGt1qMl0edtjZDNoTx+d4ftYSyg3CEy7TOibdkSyoAoks6yJz/svRoGgjyVC8yptLVCrxXgsI/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(261026121527099003)(4143699003)(56012099006)(11063799006)(261021123027099003)(261022105027099003)(261021121427099003)(18002099003)(22082099003)(6133799003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE5JRElPUkdZQXpTbk1PVWtsWHd3RVN4SThJdmkyMTRCSnczU0UwcGtEblR3?=
 =?utf-8?B?ZWpodHdXb2JsL0F2VlZGUXdXZ01GdlczKzFmZ21teEZnT2RTek5vVndPS1BQ?=
 =?utf-8?B?eFZJTHpRaFNrMzZXRmFZNXJxYkZtSm1aTUxMOVp4aFBCbDQzejRSQVpwS2Ir?=
 =?utf-8?B?TG9oWGVFY1BPSk1Rb0JMeXp4aWdNOThWdkRZNVcwUFVEc2ZYbFo2eXpEU1BC?=
 =?utf-8?B?ZkhYL0lQUU40OHV0VnAyNDZKdENOS2F4Tnd0NGlxV1loUXdIcTBzZFlaMk93?=
 =?utf-8?B?TzdOenc3dHdQcjM1eXZaR3BzbSszemlSdERBQ0wzczdSTmhaTFM4dG1zbTJr?=
 =?utf-8?B?UUNDRHBYTkRrMEhQWXFFVE91anp6NTZlMi9SOXowbTRVU2J5cFp5NjlQUnFJ?=
 =?utf-8?B?VDA4VGUyaHFLMXNuYVFqd01yYnpwTzNROXcvSFJmN0h6cTEvekRyeG9KNU1I?=
 =?utf-8?B?SVJ6ajBWQVoyOHRGbHNNcDJvU3hMTlJkQXBVM1JzSzd4enFIZHdoY2lZL3Z5?=
 =?utf-8?B?ZG05clRxcHdGT2ZqWGtwTlFOQ0gycjRVNjF6OXFuRzRYMk9UM0NNYnRhVWs3?=
 =?utf-8?B?YXVyL0ZNTlQ5L0lwQSsvcU1IbjltamZ5cnAzVGpVTW5jTDd1d2Z5RExQQnhs?=
 =?utf-8?B?NWVGVjV4RExUNGNZOUo4RHdJeTlCRkkvT3F1TThFMGd1Y2pwbzVKaTB3WlRp?=
 =?utf-8?B?aTZaSFhlVnEvenBDZTBJbmhHWHA5ZmIwMEJVSk9ETVJVZ3ZjL3dJQWR3Wm1j?=
 =?utf-8?B?Z0xhaFl5Y1o0YWhMbzAwK1RUd0kyOUFKaFBDUStLLzBpdkxsV0w1Yk5qMHF6?=
 =?utf-8?B?aGVrTS85UkdMM1VjM0lycThCSCsvVGFYbGlNS1VSTU5wMU5GV0ZmSUROSTlt?=
 =?utf-8?B?dHhxYjF0NXZURWZQWHpUOXRZNmc4c2gyY3Q1SVZxQ2E1NDdJSkdXWXNVdkp6?=
 =?utf-8?B?SWJTSUU4ams3c2ZzM0FnYWMrL29vTFJicmxyQkgyeENKVHMvbXZ0aHpNTTZP?=
 =?utf-8?B?VUZJejE4Y0V3Z3h6OXIzTkh6dmpUK2xENERMdldvbnRnTTBacGovV20zSWpL?=
 =?utf-8?B?U295cGYrY3A5UlNHUWdnNUFUR2REQXcyb3BOVUFNZkxpWHhXYWRjdUx3YVEv?=
 =?utf-8?B?ODNNdmVseC9HSjFHalpNQ1E3RHpnS24wVVdJVlBqZWkycTBjZHRuaXQvRU4x?=
 =?utf-8?B?U2hCdlQwMHBFWHBGbXV6cjZzQ3Ixak1sTGdMR2JBN21BT1R1Um1ueXU1RWdN?=
 =?utf-8?B?cUpHeDcrWE8zdDhnUnpvSkRaeFcxVnVRbk5jQno3azlNM3FLYnl3QUhYTmNv?=
 =?utf-8?B?S29jSzV6NmNMOGhLOGxHcHlFVmY5YTkxYVl4cTNYRGJtUWM2dThKZUVxOTdI?=
 =?utf-8?B?NndUbWErcW8wVmtNMXZVaWRienNoakJUclFRZ1hHQ0k5d3lUa2ZvQ3pLWjl2?=
 =?utf-8?B?RkVNOVZNa2d3SzZTSTkvNENMSTRlMDhPbkF0a3lQa25SdUlldHYweWRzWWkv?=
 =?utf-8?B?UHluYVBSUmRjRUNjUzBHRW15b3ltdExlUmsvVURzSitjWDNrREwzUmdKc01T?=
 =?utf-8?B?cDduTjlZWGZCTmNSVFk0VmFEV3ZURWpsdnRZZ0tUcElEM0ttNDZEOUFjcjAz?=
 =?utf-8?B?OXRSQ0p1SHp0c3UrcVBBZ1d5SHR5MFBPQWtzSVY5amJkeS8vck4vMkMyUWYv?=
 =?utf-8?B?RDFRQWxKd3JyY0I2UVJORTExV2lIUnlQRnQxM2VSOEM3Yk9ETkVGeGMyMnN0?=
 =?utf-8?B?Y2FWQXFHb3BHOHN3eUdIWXJBd2Y2ekJJOUpoenAzSGsxWGZjenF6REt0S29l?=
 =?utf-8?B?R2dwK1NrMzZQYlNjUzg4eFRqTGV6YnU4VjNLcG1HMTA0aGhoNmR1aExzT0ty?=
 =?utf-8?B?RjFCbGdxT01FNWtINDlTWmRnOUU0em5FckpQU21iWElWSExXbnloQ05yR1ox?=
 =?utf-8?B?dHNsR0Z1QnhISTRlUjQyeG5rak1Gb0JNYlFPMEdnbVJmSFplc3NtMnNWc0JW?=
 =?utf-8?B?WDdEOTEyTDB0ZmFDZk9Kejd6bjdjbTN6QlAwNzhnbGlYZ0hEQ0RoUGlWaE1i?=
 =?utf-8?B?dHNMamtLMGgwSWdyUWU1MlVabmsyQ3hRci9MZmgrVlkwV2tHVzNsUDhjekhN?=
 =?utf-8?B?R3BXQVVZVWZ2S1ZUcytsT3RvRGh0QStWWEV6OWFZUDE5WEpkNnVPYkFkbXNw?=
 =?utf-8?B?NHVtT3Rqc2NNdHpuRFVKSHBuRFp0eHFXVkliRHJQWjJJK1cxdTdETFFyQUlq?=
 =?utf-8?B?NFcvMnRxWWdFdDFRc1VQVi93T1pTemtDR2luVE5xTzNDYWYzaEVMT09tREFo?=
 =?utf-8?Q?qDm2QYggem30Bgp+0l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca80da6-9edb-4719-5e61-08df346e3f64
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:07:02.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mINI5cPNCapU/rimqEXzKnjWQnUr30CgMof8bpC85MCVmepz33CBf+A68vLb296c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB243497

On Tue Oct 27, 2026 at 9:03 AM EDT, David Hildenbrand (Arm) wrote:
> The final scan in shmem_undo_range() restarts after a successful split
> only if the original folio is no longer large. A nonuniform split can
> leave that folio large, so the scan skips the newly created folios.
> Hole punching then leaves pages within the hole allocated even though
> they could be discarded.
>
> For example, a fault below the hole can allocate a 2 MiB folio after
> boundary handling. Punching a 1 MiB hole at offset 64 KiB splits the
> folio successfully but leaves the original folio at order 4. The scan
> continues past all 512 pages, leaving 2 MiB allocated instead of 1 MiB.
> The hole reads as zero, but the pages and their block charges remain.
>
> Fixes: 7460b470a131 ("mm/truncate: use folio_split() in truncate operatio=
n")
> Cc: stable@vger.kernel.org
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/shmem.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

