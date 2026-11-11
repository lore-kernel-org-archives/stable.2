Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794367187;
	b=v9i8LWQ6AJftsf4kuYUe7yIMNKCf5vPkYllaBKpj7mNVFXMXQU9x4+e1gXdxcewMCO7q
	 aLBJJ8eY1PRtBpZqgKnwFO4mA3g6ml1S62CkwRq8SBTwJsNxDZY4R8zYE9iUMgun/YbYc
	 aCfHb95Gjut7/jKJWjvbTaLwjGQ7GTW25A6AoSg+WZKsGasCHh7hMJPtClr3OceV9K8UH
	 ZJKBfBjlYHLHdaAzAaOl/bDePbL1XTIADPFDMjF7InljhbIGnzvZuzjAoKESXVsm5RSGB
	 x+7KCMu/gbyjswkAf6oouFTUcnxzIsCmHuujj8FXEMeHWBp1q5qmJak5QG0Be9SdlBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367187;
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
	bh=CqLmui5G5J1YL9y1nGqs7Qttp4NgGrBaRK6kblXuyKY=;
	b=3IPVvvgYxIsn2FLU1gb9KGA8AnhKhXgFbX9ZlxcUcFrhzxObpr7RqHOtCqsI8NyYbyw4
	 3yhmFg3od/I14rngwpCuquqMlhIQORpo9HtklHgNJIRaqbPTzOXZri0FUl5fO+rEfopaZ
	 CWmV05MIppIWBu8KILeOrrpkV5MB4nMhkRE2eiEqw1XPlpb7GiE1ll/jMkJgA3c3lHXYt
	 jCAZ5ek6PvkPQl0auie8sZtCeddCZmJP0g7Tn/ZUCtqFsH8duKTJJYrd343n+pvkqQnDu
	 4U0ynXvwKpdutqD1YhI+yxvq/MOAKCqQ53zPpZSp/jxVq8d4HOShmT2OAj39Nzqqrcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="MSew78O/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.50
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30543606A31C;
	Wed, 11 Nov 2026 03:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30543606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MSew78O/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqQQoUrUToYyTpxYlCj0Mjua8g0q2MDhZdQc0FYT6OTVHIp/J4pW5lMMJswzEn0FHYzifGKjJafnuBVS66BL2GuGLHLEqB5meTfnE3SkUFnSltP9TRf4kDrEUGtdZOMx8kPSByh+RwPFGJA+OkELLaQ3a/fA1tpEVuk/z8tolvJXrF1RzHyTnjb/ge99g2uklzqed6YIDd6xjnWCQVa5eBDJT31/ISrrb5cG2FeThW4HRbrvt4TpJM3pVrs/y/dFK1i8QhhNBAw6W0XZ4JgzDCcb87oBH9gZEp+GIRyNxWfVu7H1p0L39JTXQe3f1l+gmlP+ZdZsAlpzOpDhbnUHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqLmui5G5J1YL9y1nGqs7Qttp4NgGrBaRK6kblXuyKY=;
 b=is2Wel7qfGLrHOwWZfcMv3Cxc/Nsjgbw2fmtfrgkUi2CuE/rC9k0MPSxIHIJrn1nTU9qj9YQt93yyWTnXSI7VCEHGfLgNMFgfWkT0/tFBbBJUoTgyoSfapv6ojFpqQwM4094YyIJR4pBVSsKxI9xFqi2HRq11IH5K04T/Fwd7Onky7Dt7xqf9GqgV7HrwNuDcggfIUNWbDk9Gm/JuCq5J5pFYVhTrWBrtP60bK0hAzdJJt5+9W5ciG3/5yXL6tke2P8PiwFXjtuEYjGWSF8p8LozmI8cZQJMM8CzkjlVjQXNkCCUcAwbJVQQEA2wotCpFkDxURS8RAv2tO+Zddi/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqLmui5G5J1YL9y1nGqs7Qttp4NgGrBaRK6kblXuyKY=;
 b=MSew78O/6Y7HrttuzAYAchHwApExPfEOOJD6Pxcpv68rgV2v3iAue8doZ/GsTaDbGOzh7qdrErT74U+qhlGhKb60jYfKmPA2jyInfYTJUMJqYAkpGuU/saDaprQnjmMeVEhCMukpi9hbpJxdDo8jWAmGWtWJbv12Md8VI0dCpJ5xzH4cF4EkdG+6VL89mP6aCazj3PNhSR+VjGxgh5sYTpbk3KcWlj6qGy4WuS4LLRfsmtagm+6hlEWU7TzOJ1QcuGvF6a9QrPfy4cYElfpHykyQ6AOqIiRUsvKQxKJgdnxf0LuW6GcNHn0N+5y6Itnc+4zKwWRMG9KsrVfItTvJ/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:19:40 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 03:19:40 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 10 Nov 2026 22:19:25 -0500
Subject: [PATCH v4] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OS24CMRAE0Ksgr2Pkz3xZcY8Ijex2O3QEY2RPL
 CI0d48NiyTKgixLqn7VN5YwEia229xYxEyJwlxC87JhcDTzG3JyJTMlVCeFGrmnK0+XEy2TDyc
 K0xKmEB1GHg0gF0NvlBm99T2wYlwiloO7/3p45PRh3xGWitbGkdIS4uf9gSxr779bWXLJTTNo6
 JtWWuH2cyZHZgvhzOpYVt+cFN0zThVO2naErreD8foPp39yT7/TlQMHrRhRNxZ/ceu6fgG6dqe
 DewEAAA==
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
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>, 
 Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: MN0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:52d::14) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: a51d698d-e13d-403c-4444-08df3fa29f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|376014|18002099003|13003099007|921020|56012099006|5023799004|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261102123227099003|261021121427099003|261022075727099003|261021123027099003|11063799006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	qfQ/+aU5MGOtB4rq7rQ2I4LI2NDoEsfqOkXuM7xynqi8VPODxKBPTGUNoR18q5idSMdltMqIGAHN5Hq3jxFJOcCfBlT5T16NQHNB9S0YJLpVMeo7GWT9OYyenwflOjqCzPRzRqRMomcWbG+PjctNjsFduAuviglbx0Um8xU4K/PbjURyLwwpgOVLibmiV45z4lgWb895Npb9ovkyyRMYaCLKJg2Y2rl42/qTHvqlIFukGkwT25vTR4N0qybJfjLZihRRkn5jJ3z5t6QKOAy79WHkkQiXxoMdCw5MkCd8CIDYSnv+1Ga5AQdqg9v8dvagaE/DX0y+7JSOz2bjKPsrMfXuyP5NC5esXrgnY2Tow3sJl8YpXrwdJ8GJ3QmHuoZzeECh2Qr31E/qBzI6POhrslJMc3evT6pUOmJ94BWYIjV3T05bIRh1syhdr/olzIf/bCRBzwIhIkifzth3F/h+qOS7rtV4yZV86KOQsXkpXd54nrhZismDsxxgak8OEqtEnJ/PNAcmiXdj1oBJJ5aT9jJdZK1ATaj5BupKoX4fsDftIBsS4PhAbvDGOqc2BJ7m5xlwocE39qlQXXM47PSKIFgt9QC+W+DKZEFiYtOXYgI6CzvbUfQmGIa7mp7yxyOW50W86TGGPycbyJnDB8NFoHgMyi3eRO3d2QFZzf1uv1Mnx673eDWorUFr/pvnkg/mR1ti2icdcqSk3EgIWmG/IQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(18002099003)(13003099007)(921020)(56012099006)(5023799004)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261102123227099003)(261021121427099003)(261022075727099003)(261021123027099003)(11063799006)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDhRWG1rZStlUDd6UlB6SzJGQmVkcFFNMXRCM0NuUjM3NGlEMVh5dUozUTlw?=
 =?utf-8?B?M3M5RGw5REhDY2F4c204ZWFWU2VmYWhYSHBpdlFYN1J5dUNETmVDK2tPQ3hX?=
 =?utf-8?B?bUZhLzhLQWdxbjdCZFlDK2w4R3R4REFmbitrVlZEamFEb2RPZlppNWdyVXhY?=
 =?utf-8?B?c3k2SjVpRU1yS3AyZXo0dVB2M2JvcW50ZHlJWmsvZXZFYWkzaC8xdjZrY2dP?=
 =?utf-8?B?dTkwRFlzZjN3VllYamFiZnNpL1h5aWtKaWxtQm1uWjJBbzhIZzQwL1FuOVU1?=
 =?utf-8?B?dUlZMEdhMDRUOXBzUkE5OW51ajNzNERXYTlzNi95T2dvb0taTDJVZ01nbkRo?=
 =?utf-8?B?bjFhdG11QWN2OHhmanIrTjNqUWtyWTFnUHVOaUxyWGlwZFFsakgyMG94V1k0?=
 =?utf-8?B?VGx6YmZ0WXVWV3Ywd21scEM1VHQwT1FtdVFQT0hITDBjSU5ZaFEyaEh1YS80?=
 =?utf-8?B?clhsZ2hVTHNOODB5cTdla3hnbHU0SDlPdTZDUVhieVF2czl1SlMwWUtTTVhN?=
 =?utf-8?B?VzlaL2dJYVVwZkpTdnRwUVRhSzBVY296eGY3TklCWGRuNll0bXhuN1hUYzJ5?=
 =?utf-8?B?aE9YbHZaSWluMHAzQmwyblBBbUVzUkN0a1pMRytZa1h3blN4RlBOdEdoSldS?=
 =?utf-8?B?UVZ6d3V0Ly9EbGx0ZE1pREFDOFd2ZjVhZExzcXV4ZWxQa3pnTUxLS3BVQXgr?=
 =?utf-8?B?RUJKc0hHbkhGZU9PUjEzd2Z4QnR4WFIvWHMvdWhEckVnc1VSd1dmTU92b1Ew?=
 =?utf-8?B?SnFKNmtLUWtVWEVMbWF1cko1K0JzQVhMWXNyUHVYOW5sUE83TU9iTWVHMkJK?=
 =?utf-8?B?RE9mZndHN1lYbEQzd2IrMFU3YXFzajFtWmdDbXpGcEpURmRnUkQwVVJjdk12?=
 =?utf-8?B?eXdTcHVid2VFSSt6a0RiemkzY3JVVjZCUlZZUEw3dW52UGxxSTRwNTBzQUhJ?=
 =?utf-8?B?MW52QnU4bUZLVWpSSzU2NHdVUFdUdG1LYy9XUDZGU0JlUm9wSENka2JUbUw0?=
 =?utf-8?B?czhYeUlHQmtkYllUSEh3NlFhM3NGN2Rsc1MrWGpSbDZKNkxkN0Z6YjQ3UjJx?=
 =?utf-8?B?WkRMaGUzTlE0ZTBucU9NbWQ2eFVVNVFVQzNrWHJZaHJocUVpc3RsY3FweGRT?=
 =?utf-8?B?R1dIclBGczMxNjdSRzB2STBUUGFMYXJwOUtsYW9pNHQ5bTRIM0cvK0E5WUJJ?=
 =?utf-8?B?bGlKWDBOckJXaXJHcjNMSlBGT2plUm9LdzhGYnJnTUFQUFBjY1JMalFEL2RM?=
 =?utf-8?B?cmV6cG5vTis0U29zMnNRVVpzYUt3NzduK04ra2NRNDR3dnliNVJZQnJQQ0lT?=
 =?utf-8?B?cXY1bzZzclJOQTJ3VTF3UStGdEIrUUlaRVFURmpERmxmZVRrem9SM1d6MXM1?=
 =?utf-8?B?ZGdaS1prTjNYSnorRGhFWG1rL2x1UDNmUmRwS1luRk8rbDExck5BelMyWTZv?=
 =?utf-8?B?YTVDSnVXODkveXpZY0w3S0Znc2dCUHliSGlweDNHSEU5aWo2cmlsVHdiRzZ0?=
 =?utf-8?B?WU54UjZnTmQ3TXU0d2dHeXlnbDZ4VmVzWlZyK3JTTEJKV0hjaFRJeDNjZFgr?=
 =?utf-8?B?VkhGNWcrdDdWTmlLejl5cVpla3hjOEJGaVVKQjBaWmtRZkhiSHEyYWZOekFl?=
 =?utf-8?B?cmNVSk1QdHlXN2VqT1hUR0ZzSGEwaXJORGs1TElaZ0hOOFRTUE15Y1VCSkJ6?=
 =?utf-8?B?WE5vOG9pOVg3M3JrNkhFQUNNWGxjOEJsU2h0VVNjQXBmMk5ueXRMcTYrNHdU?=
 =?utf-8?B?cENJSVIwTTJTbTR5TDJkTkYxVTdQZkN2cFF4Y2tlMUpWdlExYWhuaDhNUnNN?=
 =?utf-8?B?UFdaOTUxRkhVMzhOREdSQ3NmM1VCSGtldEZrV3R4QWJSMm9RZk1ZeTZEK1k1?=
 =?utf-8?B?OE4wOGxUT0w1amdvL3VpWVBKWEhnck9GZWhmRUFka1NnaTZ4VDc5Q1dTZ2ZG?=
 =?utf-8?B?MEp3UHRJdkJwcnZFRXlacXdHV1p4L29XRjNEMXA0ZEQrTC9iak5aUmt4U2NH?=
 =?utf-8?B?Tmh0eGNpbjg4UnNqZk5JK1NaZk1hcHVXNE9FOUE3V1ZQelljQkxWWlY0THVv?=
 =?utf-8?B?ZnBLdE9sUDN4bEg4ajBqZk5wc0tVQ295UkZ0ZmVnR3J4R1l5cDNVS0IzZHNX?=
 =?utf-8?B?Uk9zSkl1anF0dmtlNk9Jb3Rvby8vd0Y0eFZMYWk4SzVNeFlHZUs0SisrN3Jx?=
 =?utf-8?B?Q2lWUWppZFFMZ3Vrb0JSUXJNNW0zaTgvc05yMUN4RE12cE5kWloyQmJpYXNw?=
 =?utf-8?B?VnN5MjFRTmRIMGxQTHZnZEVmN1ZPZUxrNzNTaDJCSEtsV0lkTVY1NUtUelpq?=
 =?utf-8?Q?bNW+wDDb1+RlpNrDeH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51d698d-e13d-403c-4444-08df3fa29f71
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 03:19:40.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKZecvzedyvz7QSpRmLjeKfBG4FMwRyLHIp3hJOErrdePJRJi0RuXmSHGVQJaz+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685

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

Fix it by setting PG_head along with other flags in new_folio->flags before
smp_wmb() and clear_compound_head(). The remaining compound page metadata
is set after clear_compound_head(). In that way, after
clear_compound_head() makes new_folio visible, nothing overwrites the
PG_waiters from softleaf_entry_wait_on_locked() by modifying
new_folio->flags non-atomically.

While at it, use data_race() to suppress the KCSAN issue reported by Ye
Liu's patch (the second Closes) on reading folio->flags in
__split_folio_to_order().

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: David Hildenbrand <david@kernel.org>
Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com/
Reported-by: Ye Liu <ye.liu@linux.dev>
Closes: https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages")
Cc: stable@vger.kernel.org
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: use
READ_ONCE() when cloning folio flags during split" [1]. This patch also
supersedes Ye Liu's patch.

[1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
---
Changes in v4:
- removed the data_race() on new_folio->flags read, since there is no data
  race on it.
- rephrased the comment above data_race() to avoid confusion.
- rephrased the comment on setting PG_head to clarify why it needs to be
  set before smp_wmb() and why no plain RMW is allowed after
  clear_compound_head().
- adjusted the comment on __prep_compound_page() about PG_head.
- Link to v3: https://patch.msgid.link/20261109-fix-split_folio_to_order-race-v3-1-1cdc509e34be@nvidia.com

Changes in v3:
- set PG_head before smp_wmb() like Kiryl suggested instead of
  prep_compound_page_atomic().
- used data_race() to suppress KCSAN reports while at it.
- dropped Lorenzo's ack, since the patch is changed.
- Link to v2: https://patch.msgid.link/20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com

Changes in v2:
- renamed __prep_compound_head_and_tail() to __prep_compound_page().
- added comments to prep_compound_page() and __prep_compound_page().
- Link to v1: https://patch.msgid.link/20261029-fix-split_folio_to_order-race-v1-1-a483c7451b0d@nvidia.com
---
 mm/huge_memory.c | 32 ++++++++++++++++++++++++++++----
 mm/internal.h    |  2 ++
 mm/page_alloc.c  | 17 +++++++++++++++--
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e86845..76c57d845269e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3714,6 +3714,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 * Don't pass it around before clear_compound_head().
 		 */
 		struct folio *new_folio = (struct folio *)new_head;
+		memdesc_flags_t new_flags;
 
 		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) != -1, new_head);
 
@@ -3730,8 +3731,15 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 * unreferenced sub-pages of an anonymous THP: we can simply drop
 		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
 		 */
-		new_folio->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
-		new_folio->flags.f |= (folio->flags.f &
+		new_flags.f = new_folio->flags.f & ~PAGE_FLAGS_CHECK_AT_PREP;
+		/*
+		 * data_race() is used because folio->flags is only read here,
+		 * but a reference-less writer can still write to it, e.g.,
+		 * PG_waiters update from softleaf_entry_wait_on_locked().
+		 * The flag is not transferred to new_flags as it is
+		 * folio specific, so it is not lost.
+		 */
+		new_flags.f |= data_race(folio->flags.f) &
 				((1L << PG_referenced) |
 				 (1L << PG_swapbacked) |
 				 (1L << PG_swapcache) |
@@ -3749,7 +3757,19 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 #endif
 				 (1L << PG_dirty) |
 				 (1L << PG_dropbehind) |
-				 LRU_GEN_MASK | LRU_REFS_MASK));
+				 LRU_GEN_MASK | LRU_REFS_MASK);
+
+		/*
+		 * Set PG_head before smp_wmb() and clear_compound_head().
+		 * After clear_compound_head() marks new_head as a folio of its
+		 * own, new_head->flags must not be modified by plain RMWs.
+		 * A plain RMW can cause a loss of atomic PG_* updates from
+		 * a reference-less writer, e.g., setting PG_waiters via
+		 * softleaf_entry_wait_on_locked().
+		 */
+		if (new_order)
+			new_flags.f |= 1L << PG_head;
+		WRITE_ONCE(new_folio->flags.f, new_flags.f);
 
 		new_folio->mapping = folio->mapping;
 		new_folio->index = folio->index + i;
@@ -3779,7 +3799,11 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 */
 		clear_compound_head(new_head);
 		if (new_order) {
-			prep_compound_page(new_head, new_order);
+			/*
+			 * PG_head is set above, so only set up the remaining
+			 * metadata on head page and tail pages.
+			 */
+			__prep_compound_page(new_head, new_order);
 			folio_set_large_rmappable(new_folio);
 		}
 
diff --git a/mm/internal.h b/mm/internal.h
index aeebb3e49ed11..4ce67ce2f3fba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page *tail,
 	VM_WARN_ON_ONCE(tail->private);
 }
 
+void __prep_compound_page(struct page *page, unsigned int order);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 143776e671abb..5f03f3725dd2e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -682,18 +682,31 @@ static inline bool pcp_allowed_order(unsigned int order)
  * This usage means that zero-order pages may not be compound.
  */
 
-void prep_compound_page(struct page *page, unsigned int order)
+/*
+ * Set up the metadata on head page and tail pages.
+ * Caller must set PG_head before this.
+ */
+void __prep_compound_page(struct page *page, unsigned int order)
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
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);

---
base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
change-id: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c

Best regards,
--  
Yan, Zi

