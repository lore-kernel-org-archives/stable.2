Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794601662;
	b=H9ixNnPAzjsJNEtH1MlFPRBnSR6Em5iw6c1iLZOMVV/dg81PogNsAuaPOeoO8UTCCqUw
	 LIow8kOlVK7A0csoot89nourvT+ksRtKx/iI7wY8XjN2BsWDJRItkM71wsUGfqS6oco4V
	 pXcWbmyRWoZZ0awac4p22yDJ8W/i0JQ0c81nhBTZX4omJYyaimigjMqT7Sr0G0cxwOUtX
	 rmtmctc4ARVy6Hwwbn3lWApDeT2lsuxvZWaoko1Kp3Hv8qevOrwDGLQY0Lawtxw99Bnr9
	 NCUYz33QAlLE5vB/pP3gCPU/pIr5g8zaVEH/qH+onzUnhMf0ux/Od06X1ciMdLRkkbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601662;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=aJbNS2m9FwSqPyxfRUNR+6UM/KmeDdGibiAf3sCi5+4=;
	b=vs/HaNjfWoH3tKKE/LH2ZaPZXKb60W462QZ35jyA6TR5RVWYGxH30K1tlC3BfQJ5kd+P
	 F7Y7/pl4SfHR6k9UnVEr5zTGI4V+Fi5hNMHiNCnFWvXKRs5gcXJevJx3dW6hp0Mo8vQSI
	 vsODn5E78isusopNpOBUmZ9eN3D5I3I2EgZ6HqYzD4DuzlZrnKP/Hi/pAmZ4iUBrO2sXC
	 iH5DxptCmUYxO/npMKqXtEhKPMMjmlu03VuyWUIKm26yZ7sjLHSiCAncsK8v+PG/g/YyL
	 nlTUm+voRcVIkuFjnruLI5xQkhxHQ5FEBfZwZdQlvkcuGNWCX022jF6sZq6TvL/SOqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Mn5iPssb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3923606A323;
	Fri, 13 Nov 2026 20:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3923606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Mn5iPssb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAYBL/m1Ms9RDURjJ6RZu0hQzp64hbxlcuw0dLu2qqbeqc6msXsy2GOwEuggLe4aEY0gLzJR6Vq4dzrzNC7cxO3K/wEx2PpwDlFrKnzseBhHqlpE0AEEGkh7Zy1BZv0Jb5WOQYM/YIlknwwHb3wXncx8yKI9x7wauiVtEIYNW0LdSW72tGpTVwM3mIFLj1ESl9JlhLCmqgXcm2MRmrROiwBG7Pr/BOd4U6PhUWeNsuS6fb4SJS+gLHU2BPbrJmDHB9C+E+EExXkUBNXvW5HaoS0D/I8xm2jNxNi3VQnNHXzjhkAq8ylIhD5H+7Xf6AnUcKV2fCuYrS4oQWYJi1QfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJbNS2m9FwSqPyxfRUNR+6UM/KmeDdGibiAf3sCi5+4=;
 b=t6g2LfCZrHh+Z5M5GZQgHOH5SHmWH50hnq9tIWj/7eSJH3x0ibVpLZBOEt9fo2pGTK/PmWpRcbhGcB/ba104ICroyOPNzdEHvs2iwxb75AE+RKe4Cz2+yBQx0O9XCD9WycJu7/sxug1vZl7xYJr2IJ0VIZ8JB7BRor3f+0RCfyfCSrhxeyFuYrTPxZ2fperRq6BgFsbP7knD0sibCwzZkqCdWWtX88EVlr4+LkJD0duoPWvDNiqT0+2hXSLo9hvep8xc+3jS04+LD4tNIwlMrjOWRw58v8LJu9stSZf9mHhuC9ubhFB3oL83SreoHpvJw6Ey1IK6Z8AS6e/XZMexQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJbNS2m9FwSqPyxfRUNR+6UM/KmeDdGibiAf3sCi5+4=;
 b=Mn5iPssbz4UY8RRdLTLj9VX61rsC9J+WlgPwsmC0nAp6zw04JY56Kwjb7Vsv3VAgiSUd/dGrsXSRAys1JbVVUJaPUnfRIKmCNg7CJu4Gc5e5wvqLOetUBz0qFUbJ9+DimpoeFUasOwt0q2kWDVyQyEuYsa251lKL/UURmEkHPEs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by BY5PR12MB4132.namprd12.prod.outlook.com
 (2603:10b6:a03:209::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 20:25:31 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 20:25:30 +0000
Message-ID: <4b9042de-973a-4036-a6a0-2294c65a1ee1@amd.com>
Date: Fri, 13 Nov 2026 15:25:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mm: check permissions and bounds for vm_ops->access
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Matthew Auld <matthew.auld@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Chris Mason <mason@kernel.org>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-5-988a5c470db2@kernel.org>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261112-access_shite-v1-5-988a5c470db2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0304.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::20) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
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
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f10b15c-cb1c-4e21-efcf-08df41c44312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|921020|4143699003|261028144727099003|56012099006|3023799007|261026140227099003|261009223027099003|261021121427099003|261102130727099003|261022105027099003|10067099003|261021123027099003|261026121527099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BmKi6OAuR0IQLOPbyveuoRlDniq9nplfbS7NwDp9vyCUyiYtG/nC8nHlLDZ2BNpG6LP4Ss1ahqu+5OO583RhU04UpFM5bVt0DgPWlszXYrHy3fyCmUFl5hnyYd1fueui7MDKtIgwSWmSKnrmkvggD2+D8iK8hbZaN87Jdbkz5X3IDKtEOoHhmbbicnY7TEe/ExkBL/9TSjkNFT+Yu8txH0nmYidsy9uIniZ2lfEEAsXCNvUSTNRn8+8HPt+ytHbJTkkkbvuVIqHftpQ2VgcliuW6ERx5e67SIEvHlgDdMpGJDB/CjSY+PIOkLFoMzmLhVD3mrAqEKfJAhROsXnnGa9a15UCA29A/HHHmdY0djLupdbJbEf538VwypljSaIKEPp7vAwkpE1Bk/+0EKVAAsLGoK4UbOpZ6sMDSiN+ImkojrSS4mCpyo15IQZILOW/nTUXUBaeLLcLJLCMxqneXWNH6bOHQSKwgOSpMTtuN1TknCWy2expo3193PRlnr1OQjhtoZ9FM0VgPhSaynmWP0xjn26a8U1Ai2FShYZp0aIKdeeUJ6RDNHYNqur25iaMdaVXHqSaot4m7RznYCQQyPOusjSMtNhUeSQGZXqML/I5bLL/+2kcAtK2B7B9DlSUBsduOI8efFo5RXf1EseLGc32tSgBLAQAvJS5NPg3NIFRwlW1oINwzvl1oD7MSxRg+fb/fxIOk8xGOZvLsN0u0dQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(921020)(4143699003)(261028144727099003)(56012099006)(3023799007)(261026140227099003)(261009223027099003)(261021121427099003)(261102130727099003)(261022105027099003)(10067099003)(261021123027099003)(261026121527099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU1TOWUwQ2orNnRBN2R2dHl4cEpFYUZoZFc1N1Bzbkg0UEZDa2YwdUFlS1dI?=
 =?utf-8?B?cEtDTllvS2Z3Q3k4ZUhaL2JsMWY3N3MxNXIyTVhHbW0yZU9BNUVpWjArWEdK?=
 =?utf-8?B?K2lwTTJ0WEZINjFSOWpaeHRqd1BORU9rVFVuNUVsOWVPNUNsbS9NVFdxb1FE?=
 =?utf-8?B?dzRYRm1va2kwbjRRMldRNVF0ZXRBNnltcVRndkxxMFQ1NzRMTkg2QTlSbTFI?=
 =?utf-8?B?QmRFZXk1d1RMUWYydGtJUTJKeHlWSFNpTjUvVjhTVC8wcWxLdERHY01ocVRt?=
 =?utf-8?B?YWdIeG5HckhLaXFMN3NpamxjN3pMWGJmNkhOVVdxWVY2a2xYYzN0MTQrNDNS?=
 =?utf-8?B?clNzVTA5NjhwTHptZFRIdHB3RXMwajZUQkl6ODNNVFpETWpuMWdENjZXVlFM?=
 =?utf-8?B?eStpalkwTUk0N05ZNTBCRW9xUm9EQ01NTnhrRy8zZVpMSUNlVE5uSnlueFZR?=
 =?utf-8?B?M2dIMk01aGZ6bVZJVi9NQXIwZjhWZ21xN2xSVitkM0F5eVdDN3owUndic29o?=
 =?utf-8?B?akZHcDQzVWtsT2dxbFZTb1JJVGNmMXc3WU1zUUsrajhRcGQycXNlZ1JiSkJW?=
 =?utf-8?B?VjVhWmp6UDdtNjJzVTl6ZnRIQjdTNFV4NkZQa3gyNkJjQWtGWGZrVS8wWlJE?=
 =?utf-8?B?Z2FiQjBRTG9TaUhUSTBnWjhHQVJjT09lbi9PSmUxakk2TzdDVnJkWE5vV2d0?=
 =?utf-8?B?WDMvT2F6bEZVcmJLM0FKb2VPMEJOMlo5dys5OVJ6aUJCd09USXlmdmQ4bEtE?=
 =?utf-8?B?b2l5ZGZKM3ZTSVJJVzJwZGdIN0NxV1FZNTU2UDcrekpmWjV1UVlqR1ByZTEx?=
 =?utf-8?B?d1daRmpCRmhZTmNObGlDT0RiRUdxajZTeGVtSzVIMXc0TzlVYlczd0txekpm?=
 =?utf-8?B?U3BYbEVYTGpsMGVSR2hnRzVkbTJ4SmowcTBVRTBoTHpncDVuYjVxZC9acTZs?=
 =?utf-8?B?S05GWmtPSVlzQU9kdEVDMndLRFoydEFRUEpGQ2pCUnAyQmdXenhSY1RDQWZE?=
 =?utf-8?B?RGZ4Z3FST3RkSUYra015MnNNUC8yUmFvZ3ljWXN2RXM0dTd5WUZqSzlFK01m?=
 =?utf-8?B?dk5hMWg3VkxHalNOUWZTM1pQaUtIbEFwRmtXNUxiOVpGNHNvT05UOUV4RlA5?=
 =?utf-8?B?cFhyN3BpWTNLdDc5REdvdEtoMFA2K1JaOWJ5YWVOMHdsSTkyaWRQbElMdGQ1?=
 =?utf-8?B?Y2I3bDNGTUpGMmRmamhORDlIaGhnd0pmSWJmV3JPWm45RllpeFhaWXU1S2NX?=
 =?utf-8?B?TEx5MnNkMU10YXQ3UFVPUjFmUzIrTTIrM3M2OTBqWk5CcklzUFJzNXptOHdK?=
 =?utf-8?B?V21BN2pVZnNMdGlxbWFlQ2hjWk0yOGI0TnVFRExCUmNFdEoyaGJXUDR6bDNK?=
 =?utf-8?B?NU9xOWdETzlDY2lqWmh3bnlFNkJHN1V3YWRiazd6M214aTJPejJESDM1Nlo4?=
 =?utf-8?B?Q0NXdm9xTEs3YnRXSFAvc29RdEx6ZkxxNHhSWWV4aERPamUzUERBbmN0V0gv?=
 =?utf-8?B?TFoyTWE4emhFK3FnWFNVQTh0cG52TW5nSnFydmRINXhjcmdTY29KTW5STDZG?=
 =?utf-8?B?dFpoTW04di9acEhZbzJBa2hOTjVBUlVVSWxaSkxhQmtCRCs1TUNQUThpZGhv?=
 =?utf-8?B?aWhJUGJpME5MOXNZR24yOEhTSE9PQURxZkRYL0xZczRhazBkcHU4ZkNKRlUw?=
 =?utf-8?B?TWRHR09hbzFGNDR5SFZDc1ozWmd3WE5zUjhEZWx5d1IvdVlLQlJjWEJxZ0I4?=
 =?utf-8?B?aDhveVNJZ0pvalg2WEhzdnJreHYwdUNMaXpva2lxTFg5QWpDWjRpQ1BHWWVt?=
 =?utf-8?B?LzdZdE5yODRBVVVlWnF1aE84Z2lPczNlV1orMU1iZ0FsbmF4emVqd1ZrTFh3?=
 =?utf-8?B?MmpCMzNNUG5NNFExa2tKL0Q3Um1FellTcmNYREEybkswQ25tZGxGUUc0Rkcr?=
 =?utf-8?B?Umhkb3Fja3JOWFl4bGo4TWR3RUZCM28rRTBoNkhPYUtpQlRWM016MWtQWnRa?=
 =?utf-8?B?eFpBamFwRUpKTTZyQzBKQ2gwRU9yU0dycWgydkpuOVVjNXEzZHRtaFpaUmpJ?=
 =?utf-8?B?QjVzNng2Q2p3bUk1L2JEby96T1pTYm5JQ2ZLYlpBQndYT28zN3NNaXByUDRR?=
 =?utf-8?B?SnZEak5EQ1A2YzF2dXlzYkJIVjc3SXdmZC8zd0FhRDVYajRxRG9jVFlPMlc2?=
 =?utf-8?B?WHN5SVRkWWNMSmVrS1lWR2lYN092MmhnOUZjR1k5ZHB5RFVoRGtlVGVNZDg0?=
 =?utf-8?B?RURudXZxODhDQmV5Ykx1b29YMk11djlueHhyTUxVSWhoWmI5eGNEKy9rTGdB?=
 =?utf-8?B?cStuYS9EcXM4SnVsT25YUmovUEdyRkFYVVNFcWplOWxyNmJEbTF0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f10b15c-cb1c-4e21-efcf-08df41c44312
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:25:30.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/dUCZhBbr1YS/kAMI3U0/T8UdavHgOxC77Yl2hSLj7fqmqI/9CYjy4ge2RCfZxxUeq1+nzeiFklR6KS5+kxMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132


On 2026-11-12 17:09, David Hildenbrand (Arm) wrote:
> GUP rejects VM_IO and VM_PFNMAP mappings early. __access_remote_vm() then
> falls back to vm_ops->access without checking VMA permissions and without
> limiting the request to the VMA size.
>
> Consequently, /proc/<pid>/mem can bypass protections even without
> FOLL_FORCE, or cross into another mapping without checking its
> permissions.
>
> Check VMA permissions before calling ->access and limit each request to
> the current VMA. Implement similar access permission checks as GUP,
> however:
>   (1) Reject writes to CoW mappings because the callbacks access backing
>       memory directly and cannot handle CoW.
>   (2) Allow forced writes to non-CoW mappings with VM_MAYWRITE.
>
> This intentionally breaks forced writes through legacy amdgpu PROT_NONE,
> MAP_PRIVATE debugger mappings. The workaround in commit fa5239f2af98
> ("drm/amdgpu: workaround failed COW checks for Thunk VMAs") cleared
> VM_MAYWRITE to avoid CoW, but debugger writes still succeeded by
> exploiting the missing access-permission checks fixed here. Reads remain
> supported. Userspace must use MAP_SHARED instead; ROCm 5.5.0, released
> in May 2023, already does so.

Thank you for considering this use case and checking the ROCm history. 
The patch is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


>
> Link: https://github.com/ROCm/ROCT-Thunk-Interface/commit/fea44fab6e84eda52fcf6b419b35600c18f4c022
> Fixes: 272ddc8b3735 ("proc: don't use FOLL_FORCE for reading cmdline and environment")
> Cc: stable@vger.kernel.org
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>   mm/memory.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d4370c1b331c9..9872f289c1e49 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7362,6 +7362,7 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
>   static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>   			      void *buf, int len, unsigned int gup_flags)
>   {
> +	const bool force = gup_flags & FOLL_FORCE;
>   	void *old_buf = buf;
>   	int write = gup_flags & FOLL_WRITE;
>   
> @@ -7401,15 +7402,35 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>   			if (gup_flags & FOLL_ANON)
>   				break;
>   
> +			if (write) {
> +				if (!vma_test(vma, VMA_MAYWRITE_BIT))
> +					break;
> +				if (!vma_test(vma, VMA_WRITE_BIT) && !force)
> +					break;
> +				/*
> +				 * In contrast to GUP, we historically allowed
> +				 * FOLL_FORCE write access to non-CoW mappings.
> +				 * However, we must always reject CoW mappings
> +				 * as we cannot CoW here.
> +				 */
> +				if (vma_is_cow_mapping(vma))
> +					break;
> +			} else if (!vma_test(vma, VMA_READ_BIT)) {
> +				if (!force || !vma_test(vma, VMA_MAYREAD_BIT))
> +					break;
> +			}
> +
>   			/*
>   			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>   			 * we can access using slightly different code.
>   			 */
>   			bytes = 0;
>   #ifdef CONFIG_HAVE_IOREMAP_PROT
> -			if (vma->vm_ops && vma->vm_ops->access)
> +			if (vma->vm_ops && vma->vm_ops->access) {
> +				bytes = min_t(unsigned long, len, vma->vm_end - addr);
>   				bytes = vma->vm_ops->access(vma, addr, buf,
> -							    len, write);
> +							    bytes, write);
> +			}
>   #endif
>   			if (bytes <= 0)
>   				break;
>
