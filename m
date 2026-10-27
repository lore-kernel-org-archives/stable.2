Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793126302;
	b=lG3oXF7U2sXeR+WRvjCsz/r3QrNFZlE3bZHkyuFC5kIxzu5E2fz6JqVyiq2/uV8r+mBx
	 sxKrFLJj7QGXOcpC4oAiNB0ZtT8CupjKDc181x5v/pIMDAWPUI/B0Hw0LhUWiKPmvgbh1
	 1kuu1Wwr1x1B7U2CEfP1HHSOhJWostRVjtkNlwTYHnBIzk8pxD/wHIJE5y6fDMPOi0wvD
	 C9a8HtGdTNbdIwD3+x8T0X/WJGhrR9QbsawAzZIFSsD9uL4FkgYS6Op0k240Ts+aWg8Lu
	 WryJ3PXsKWWzQf7OMS7dTF4NXup1sNeyERXNnR+zb0RSlD+DlHMhuasT+Mzh/abiZMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126302;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GXx1V+0Z/xWF45Xn1gmYCrJZJHTmYCKmzI7TN4eSNeI=;
	b=knP/k0YRs7jbaou98ivuqmMto8Ws3YA7trtNFwI2NVf4jhmUM3LettTU4IdRpiPlf5VG
	 rADLS3c8mCalB4drD0kWCZAuh5kWDQHs9boQiHqgG1clQKAk5QwmwMUVz7TKh2mEgLZpa
	 ZCBYsnQo1jORDBqBpPCtBpL7phjM+XXNK3BSsnJ8uGI7Uga/oHwUok5S9pE/dFuiAb3yM
	 bku4sXGF6x0qI72qGKau19t34TiiDejrftn70lQNUTeRiNK/HBzzQ597DrFyABPAhNy2j
	 G07w3K4IhvuNRhhNb+1ye3e9jOytCsCRJP4NS0LSg1y5cvAWnVC5FPxUHO+DSBd2c8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eqdbWdWK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.54
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEF606A31A;
	Tue, 27 Oct 2026 18:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60CEF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eqdbWdWK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKwF8/Z5Fmzr6j8JjMZIQ7+HD9sle/futhkOYyYS4cEb6/pQQfkPLrwI6e6Wo5MAbKyWJfGoi8vCaUGvKIpcgr5g7Sw+qrvXoG7uMPevEZxJ/yf6Ep2ld1CERwlSTrxtTZbgcR8ZHWf1BJ7jmvnLIoCxHbDyOcsJeIHlmer1UaNHkXRnTHJEcXJ5MDfXAGPKHut/Velw8Dri8QD8C5RbDViooNIA0Ii9bkcmzKDuPK4qY5leEqqdt+66OTgOWx/j3mEYoTYo6D7DqKyCOjuMGfvVjS1+l57/QF1ugR1/PSGtHYKLjdQSXAfmdGE3SnByDxmO8N2zn9tfXK5wxydSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXx1V+0Z/xWF45Xn1gmYCrJZJHTmYCKmzI7TN4eSNeI=;
 b=bgM55dXSsr9Bk2kmmwYIbxNB0jRRTITfidIxK66IOKtjKH3UjO1ncWCc7JAeXUoCkfF9Ord6cNPIn7cj3y8V4ZOU4u2uWHSSXtgmI4BN8Z7nyPVxL2HC8Z6lk8DuYq5ZLPjFCbtsWLkjGgDHniyC72no+0L3pdTZBN9Q16++538chQ331HfIgYOfxapuxmGVBQZPNMgeQnPUsrIIwEnEm7OeueHE0V97dzpaxsTreW6brKbNHJmOtDM4btHNId9YDV59gb/iOCfg3I5q53jowsQeyfvxZKkiTfUWuWr6NG1lBLDkbFfqIGlgFy7Q2F0mp+5LeObnZP9wOX24MUOhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXx1V+0Z/xWF45Xn1gmYCrJZJHTmYCKmzI7TN4eSNeI=;
 b=eqdbWdWKio5liBvxd01Sq5Jm89Fdh+hK0CS/uVvqNnWo3ZxaYrEsDkN7rnYYeTXcbHtXg0+zdpD/5zHfj1kA4zsWjl7shBs6uHqFzZGuTC9BRmFz5mTlcUpg2+EirAbfU9HX5bkXcyaylqFI8jrpWGC8ud4kc2rapaVoIskVBJDe807qcVF4l89n7QKogAS27GruWPYdDEcdZHUpsdWMoA+lM/7J9defgaU/V65/apc3XdMe5Y1ckx3qDLK5jCttLad+S6t75Gp4LVNW+Oatw3N1YEtmUO5xA7tyCY7wO6mQr/7DWvMzguYJo1PY4HpTu3zi12gcSlla9qjdnkpRfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 18:38:19 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 18:38:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/9] mm/page_alloc: clear ->private of deferred free pages
Date: Tue, 27 Oct 2026 14:38:16 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <CB9339BF-0D18-4F8C-995B-E2912C3BD758@nvidia.com>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-2-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
 <20261027-pgalloc-ai-hotfixes-v1-2-9c7d1aca801e@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BN0PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:408:ee::28) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f00ee21-b494-49d3-ae52-08df34597884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|18002099003|22082099003|261026121527099003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261022075727099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	5VEoKlulZdveSQdck+Qgm9awBZBodo9d/1u8mtAO1P0qZuc7oZTJ1zj8Ima3ImuRT3HjwZlUnlKjwikSka/uh7EGBZ8xOpZnJKy6jCOkcuHLp3hNYq/P05Clw1dAaZnTyOkVsDlxTGlj4r+4BkcGUCEYlV2hPEtkjzm5DzO9XrDOm0yTqCKwEXosgty6PNhx7+bAQ4w/doXrFVMhulxceMLL3TC7GWUNSyvpmTj6s0OpFKBaOWJmm9eicTWoWTksjdlfq9aT7DCQNeSHOLweG1+p0d0+xtXoxK6dXMSKl8MwrNu7sSVZIYi78pEXdgWRd8RbxkkmNJx6KPsgKY32fXz1pyykf29dJctkZIfDKhdPvXnTp8YdThGsWMNoE+Qo6jBH4YIYhjopB3F018M3ct2g7tA/e9DKo1LBzeRK/+xbtFCE8tmEawJLUwv6a0OdUF/81BZIiEa8c4qHwXJD8lrZGHRb/niQcUWFriUrZiMsD3GnzC4Epet0MUKAh9e2MhGXklcf6nc5y3m8fdypABZB+w9jJgAbF5vvw02PIxncUvc3KXLZ9i901SoJi8WprZ5I8HidTlYeAO6DrP8j/hnDakEdTB8SD01WKkIWiGuZreT2n0fFBPI59+GTkVAfbBDssmT/RMSv4u+E/LWKDbdFnXMaQl/lG6Blyuj3RCU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(261026121527099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuFT3Vs04UC3Kv64DQrT/4VUUdow36lPgujvrHpWZ2ib1xwQ+Ry3Xii5xIE7?=
 =?us-ascii?Q?zVTxSo0Yk8oiSAAOuBI2ptzfxCkNWsPaoUpuV9eNpN9ROpHf0pJcKkoUSny5?=
 =?us-ascii?Q?lnXrTnEqDKjuYKZdsIY0NPjyrn83LXVY1MDftL62CBdXQFR9A4zrXHAX59eQ?=
 =?us-ascii?Q?Xz0P9SGFAEWv5EcawIMWzjnBqH3+bgx3AsYni8VvXnq5HxGDGUminC4LH288?=
 =?us-ascii?Q?MpyxTPyCJfFQ20CxNDaTKXEipQDXVgK5k0PdWCQ8gAg3YqN0k/raES+um/5O?=
 =?us-ascii?Q?BZqHEkrKgezehucfeeTWEHIc/DWvzubqmKWwXLThizaz/vNUut0TNStncMyL?=
 =?us-ascii?Q?i+w+MRtN6P+c7jCqvHGDGPLJq0Yt+8Ck59pBfJEGw7g4UgMNi17B3HCvedvS?=
 =?us-ascii?Q?angX8wJcWejgI9k3b2WQ3bNsAVQ6HegDiMmD1hwn6EgTahrfjcI3QmLs1TxW?=
 =?us-ascii?Q?H7TS09rw8vDr/wfDpmQu5NRfY9ztUaVipu4vYKJYi83JXG4euYSDpLaCshhR?=
 =?us-ascii?Q?hvZRIgu5VDvQjzLmkk5+2qRflAxJHvDvGPlNS31TzvgPaEuqGWt42dkwSu7+?=
 =?us-ascii?Q?R/WE7rSGJI24hNG6es3T9b/LcLXMv+3eivwe6ILltlBChIgMVnFzmDi7Khnx?=
 =?us-ascii?Q?VxNixVRGiOvn5OXXM5au0jaZSdA68sWQy0E/vNCZw/qI/XLvKsTpBPKh44Vf?=
 =?us-ascii?Q?fdYS2KYU4BY8CeiiffVYJamGcBcf2/iB6FNt9qfeKK//CMin2QtdV8j9INc/?=
 =?us-ascii?Q?Kv3bLwlxh7b6z+5VqZ9Gyb0VcfF9ZaTJHu3RXGCxporeLg0vkVoKw7yje0eu?=
 =?us-ascii?Q?Y/+hEkm466rofUXBQ3jhWlIBgJD7ha4n7eWyd5iKi8DMwJ88/2ldYMr0rYE5?=
 =?us-ascii?Q?r/H74C75b+YNGC32IuPNETF+VReRPd58REu1VuNwJaB3D3sW/iJPHXyydobV?=
 =?us-ascii?Q?n0bJKG1tVFvRQln6kFmfO8LbMqQX3ZHaIM/OrStGdxHsazUGvQDRsgjNRSyt?=
 =?us-ascii?Q?9WFSjEnTV26NaPUj+VHzOs6xm6HYWzR5Q9caoC6VHSeUaF0ivxToTsiuHCRs?=
 =?us-ascii?Q?j+Z4/bfSMzztNNSfl8jynsKcwvwAwWesqonQ60VW4mI00ddaqq0vhLpDUPrc?=
 =?us-ascii?Q?mfpApAXnYltqO2NpSvtxoeNwXf8CwsVFnwCeQlUD7H/QObwQmFGYTKa9Qj9d?=
 =?us-ascii?Q?VrODLvFIRB4sIT+RTTnHUj2O8qqkM1zLISMvs9S0lwpnUpa42WLP6nVf20+z?=
 =?us-ascii?Q?NViC9V2Hj0PSIJKFqTeb7ebO7//sm6vAerMzVDGdJSYpD8rrqe+NIykpgroi?=
 =?us-ascii?Q?3sf7+lL08+MsQ4xQ7N4gDFtqD2FTyrnuMFoWc8oKvXSQOafWuvIgByOba7YN?=
 =?us-ascii?Q?eQDAcB4OhlLLnkgihVVXkUHfRE1NlJlyiIKzHdzPxIM9TdmCgRAPi26gjQXX?=
 =?us-ascii?Q?EhC1vxVjwyGgtgZYZWJFXRiGcAUPj5AONJ5Dejg4DXx0N4xvG8k6sbbvMmRj?=
 =?us-ascii?Q?j3oZFTmI+pzqNslIraDC94QL99r/LH3dole1Cs1FbbQxbeTy61zx/HKxvUfq?=
 =?us-ascii?Q?eIq1SNwKBrTTxUR9qv1+1SICOkaS9pKfLa37aLl/4WrAtgVzrsfL0nlEeVYp?=
 =?us-ascii?Q?Pszh69PmKIhR2CWaQx6Lbm/foGWzFzi8hQXpGckkLLYJzyqjW1on2r9En4jO?=
 =?us-ascii?Q?1T/Y1OSY53ppl/PpcbXE7PelNq1svq2ZDVuzKMNCvky10WsXf9o2oz94KpHu?=
 =?us-ascii?Q?EPaVp+WB7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f00ee21-b494-49d3-ae52-08df34597884
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 18:38:19.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJxf06Y63HrdcD+RLJSRMEoVTEDlwZQD0O2LWpRjZJXvZZFoukZokDANAr6fuB/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498

On 27 Oct 2026, at 11:46, Vlastimil Babka (SUSE) wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>
> free_pages_nolock() and free_frozen_pages_nolock() put the page on
> zone->trylock_free_pages if they get neither the pcp lock nor zone->lock.
> add_page_to_zone_llist() keeps the order of the page in page->private.
> The next free_one_page() which does get zone->lock passes these pages to
> split_large_buddy() with ->private still set.
>
> __free_one_page() writes ->private of the head of the resulting free page
> only. If the deferred page is merged with its lower buddy, it becomes a
> tail of that free page and keeps the order in ->private.
>
> All other free pages which are not the head of a buddy have a ->private
> of zero, and since commit 819bfbd47e49 ("mm/page_alloc: remove
> set_page_private() in prep_compound_tail()") the allocator relies on it.
> When the stale page is allocated again as a tail of a larger page:
>
>  - prep_compound_tail() hits VM_WARN_ON_ONCE(tail->private);
>  - with the page checks enabled, __free_pages_prepare() reports
>    "BUG: Bad page state", "nonzero private", and leaks the whole page;
>  - without them the value is seen by whoever uses that page next, e.g. as
>    folio->private of a folio which is split off a large folio.
>
> Only pages of an order above zero are affected. Those can be freed
> through _nolock() by the stack depot (order 2) and by SLUB (a new slab
> which cannot be added to the partial list by kmalloc_nolock()).
>
> Clear ->private when the page is taken off the list.
>
> Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
