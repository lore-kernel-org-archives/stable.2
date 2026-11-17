Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794936972;
	b=ubn0NX2RYfImNLDY26UPcqX6RGMp2M7eVjlykZWpbZgOZAOAHYrMOzDzLdUWpapgFYNr
	 LsLcfSQsWvcQOUs7gMO7CIuN/1wR9y8TXYsrCk5Yddw23ieAr1hdbtY7uS/H4Pwl3f27i
	 e/ax+Sss35SzCtaTAuA4dJT/KyCgrQGf3tB6qxikCGH1GNkd0XdX4wjhz9gFvn2eSBGvP
	 HYVaiblQ8yIJ4hOFNMMtOmGvn7fH8OIQVtdYou2zmNIgOq0ex2b/GXNHADmionIyGN+25
	 KmMCamnspmUyf9oEc1fnJJPd97nGqNyfuNMBbAVHssbWbEXrj4R7YBekQi1t8RObD3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936972;
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
	bh=acFQAvj5oowsvPYTuJm9/E4VuOuVQQXZLKjxZBQzLp8=;
	b=qBJQMKFyVayA1AhkUYyUc1nBCuDOp/ia3JSdArA3Dfix1u/hzufcUGN46XGv7bb6U3z8
	 KlDOaD9zMkcWfFATBwDJ+OB8kKtsyLNSnlyxdYgiQXcz0FD6T7VZTbq7zNoifDvEBO8wA
	 xBIVvxp0FFC9IPf9r/YurIRpxex0JeiAONtUN8QavwRMN5dJO6+uHNsR1iBLgYzka5mjX
	 015Y3y1yvRU2feuZm35KkNNtL9OH8jDPU7IEv7P8ZSnVCn7GWYdF4cjwRuCz+dghv2BVC
	 xJBq0w1E/+6HVk+G2q/A+Ey7ksig2hfj421z0t2Y8taEhU/NSAM2KRS8BVPaTnk9Z1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aAOnNxxr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.27
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E47606A32A;
	Tue, 17 Nov 2026 17:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3E47606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aAOnNxxr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aI0tL9avWkoTWCkKD1qfqMEKg+rxoIyrziHA5rN+ZmZD5ozeHxU7Rg2UfsoDllSbFEoihwqR8EDn9kM0ovLjguZpMlS6Gz/6PhcbbBPvekAK+L4suk3KpxFqtp1IBSyzIYAs9OjT+c7Pa4T3qllybmZUX9zT7ouq4GOftzYJumddtYXWajoPlP9dkrIv+tZXWLn2D1tjgFDg7Mk5FL633cKDWrfgcykhfaTAghh5Muy4xxhyFybovsUZmhoXyfSMR8Ot/XB1qD9tB2yWrxvmWHvXXckS4s7pePvtfjlvSDUFzjlINR3EGcp9uWHVN92qivp6uH6LEN9+CbqXbzcx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acFQAvj5oowsvPYTuJm9/E4VuOuVQQXZLKjxZBQzLp8=;
 b=WLbgMdNFNbC3NwE0LF0yoayWtPm+jkJRQ7tCai3roVhITRO51coU5kny5MsVaeyzU70At7DiINORV27Gm9dr9GJXLfU9+BO3fJJD1QD4BnFsV1RKLC/ALW35WQZv/GlwTB7MJxa5EL6MFWi0KvDcZYw7YvfHrxsxAahtFpL2l1Jk5mRouTfGUsv6S3UOcN++/n/wnt3M6sNQYVL4aYr1TsttEbihs4OhDqaepchfPI11JxyF4Tcn/hGhS97YJdRTTAabFBDse3BDvfA3UcxCbbPDbPMKp8EyPt436c5qNbBqWnQC6djr+RqMlYXMOXuFavjLVKHu7K4VqnbYM8b+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acFQAvj5oowsvPYTuJm9/E4VuOuVQQXZLKjxZBQzLp8=;
 b=aAOnNxxrc6U0/hMpH2zD9RmKuu3QIY6Wq2xw0tuHVQeskfjhMUhO5+U1PJF5mmhvovzxDzbtsXs81N01WiemzJAazI7nPTXCjdKchwzTV1Zuac/aNoseTEHRVZgSYwQR/35SBHDxFWfwTYgxynU8NTYiJPjRIwxpWLGJEksJ0YfOwB6emOijbpFIeEwBZq/RuUogLAdoHHqw/f5jrV6xRV/rdkqM7M8vwjmK9ddGqltIJ1ZPP3PubYkxG9asXls8jMN51KX/kjUwHk2nxsmzrkhYZBXQnEZasso5bBTYZqESh35hd/6fECNmDGouRwNsZqEd7pI7GV4jTyEihNmv8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SAVPR12MB999121.namprd12.prod.outlook.com (2603:10b6:806:4e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:36:07 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 17:36:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/memory: remove racy huge PMD assertion from
 walk_to_pmd()
Date: Tue, 17 Nov 2026 12:36:05 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <BDCBFC48-EE2F-4D4F-8C0E-C28311907102@nvidia.com>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: IA4P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::7) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SAVPR12MB999121:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2fe2c9-7ae3-4392-a655-08df44d14318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006|5023799004|261102123227099003|261026121527099003|261021121427099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	7jPIWFmHEs17sRhmSnXIz6iZUscZC0LoDxIVcN9Cn6WXPSbj1Aw8O1UWw5qryXhKqLyR7aUBEl4KeWZbINclj+KKNI81AHE9SmPHU8VD9HNWCzUfo2atHCLmlme1lgvIUbjCNFESWLENgyYA8n20SOCrcIe4n9jZeeEyq6IhxhizfClGq4qoEL9AA9PNuAQNYkknEu3xSh7j0eM5JgtPkDJPvoQ+QAaN1XhVhXe9ADxrwsmKxow3IYXY03PF8l6w/AbPKOttuL+DUYt+78LNJniur1Zv2T5i6rP/5zVDDuqA9ghr19LuxcJZLQPmhIUbhwuQB8B/JdbTZ4Q4fq6FLGTjizkDWEj4Q5ZGBWNeSq3y51/kCLDeuAZa38LxQV2Ty9tvsKAsq+ku9XZQmzWAtZ48mI3+e76TVmRH6cjGZaaJvO0bDjsMpgenmftrwEGr8+nLTGOxUE1E/wi+kwY4dv+4d5t9dexG416XrcMLvnOs7wIma31Bw8tVL0YAXik2uNCrFsXklO4sZwULOKGL24rA6rmy4pRbFLBo5vPWzQqHW/XTbX35bF1TrSvsv8DpH4SD/SkWdguIaZLkMEbcnCyPT58WTSSELYLtQErB+xTDHOqPSJGuy4lXgRbNaKdkH7cgXREpf+9dp+LdTJJJx0BYZXxLN0ER3vUOqqpuOmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006)(5023799004)(261102123227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rOV21GbPaMBG089fde6qJaEMBSnhOiMWIgdD1iC5lB62xQAnukxHS3wkRwO+?=
 =?us-ascii?Q?mbL7FfYky17Hszd3G65ddhC25GtkOqO6f+qD9EvRlD8KSw+eGBDV6C/fuUZA?=
 =?us-ascii?Q?Nb2bjeo18IUUhJ+W1ZScbgXypqVUv36Cv2Oe0m4lEg+v/RYKf9jI0+P/0tyP?=
 =?us-ascii?Q?F5hVk6kA+UqP4hmAPno3NqDg4OxoIZiDmP/IE85CcBhyOHGKt3s7D+iTofHV?=
 =?us-ascii?Q?7vd/+RMeT6RzSTophA3OZ7U6PzvshKPtPArElrAE+fmnulas+sjoCDpeX5Ib?=
 =?us-ascii?Q?ZVJtwUZ9hdAjbSC3JCYPlzD1vjKAEicdOgn+vdqAA9BUURNtmbZD4SbFC5d7?=
 =?us-ascii?Q?5VwufaS6uflC6m1w/EQhP5l/HDYWG0NlV5vpSkPNSdFkKfHnrUSUE+B5Z7QZ?=
 =?us-ascii?Q?OLW15uA9NqnIBb+k1ZLpoiHUnGpK95IqJ6YphNdHij04IInSDrBx71aesz29?=
 =?us-ascii?Q?qIUiDZbvf/2NkUhwK8+U44cULRUWR4ubT0UAZaeDqx2Gl8El9tRW7HgRVkqu?=
 =?us-ascii?Q?usn1oB1zav2+TA/B20BmMGRBCTu5VO/gvST50kEUV+nPHWVhgYC6ANL8z1Cl?=
 =?us-ascii?Q?oVHCdu/bmuJj+Lw3ZkihENthl+nrsbeVDtOqyh5ZWWFLo751Inj3hDqedNqO?=
 =?us-ascii?Q?F9ydQUZhRIR5bpLnD+wxTOPuQDXvp0rJcN0ua+gE/zy1mAxQnB/SVlCEX6Yy?=
 =?us-ascii?Q?5fN0MuNvXvgRQoXr3e4XJlZOizbPR0qSdnxJyiX/p2dnLDovLh8WxW3SgZDo?=
 =?us-ascii?Q?yTHtVjHnSucMaMwwXVnEVN3LvPicwQnFhJnCJTqQDv66v2ekx++8BD9Co2Jd?=
 =?us-ascii?Q?xJNCKqeJcmLdut+lh6Qki09wjoSq3LR2kwcMYjmvi4Sem7tddgpOOgZeM5Zj?=
 =?us-ascii?Q?wILS6IwZdkQVZvR91FJwPLiOi+iImwYH6lmZMEKXlBE5Lds3OpumdiwOcLPD?=
 =?us-ascii?Q?7aJkPS+jbKPEbMAiYDYp6W09komgQK2WZ6eoMwvCH5Icf0CnwYReUUDoV3XA?=
 =?us-ascii?Q?NBuJ+Ry2UESqUYRJgY6YR1bbiXem+RQgY9cMW+9v4Oc/e/vyLS6e7KEfYRi+?=
 =?us-ascii?Q?r2MpWx36NTLLW7PR6uvVHDDJ8nRKltQwx17vkT+jmmsnKpMfCfLi3eJ3zNgM?=
 =?us-ascii?Q?drU4kCplRDcuEqJPmtt+L6M+kxFvGFr62CmYEHfZ+8Nuen71uofS36so7V0P?=
 =?us-ascii?Q?uxG/COAhEBlJ5V3ym2H/FFzp+KDrJmkLRhY10Jwq9nO5mq9C3s+b782LifGm?=
 =?us-ascii?Q?jgUEQGNMAo8fB9+MO4roGfOk395x9jUiitt2RqDR5pf/QJ5i8Nb8Fn1amPbv?=
 =?us-ascii?Q?7uyq12DqiZoK7vDix9SHVfUFbho3DkLfRm9EMt/SdJWO27+FxwRfZ04EZuOa?=
 =?us-ascii?Q?im5+haBlmXBR2HVESzI0kvJOi/qOoLwoUa0eFAd35DLl+OEHUpP/j2R/oB1+?=
 =?us-ascii?Q?c/ZJNKEUa2jzzbc1JfCHuzLtJV5YgBKF9uAYsSWva6jr58t9P29REyvWXibw?=
 =?us-ascii?Q?vkAML6t+Yh3TNYvHEYrRe4w+Y7Nv+PyMkpzSFyk6az5Gi2PjNa4WY96fcjof?=
 =?us-ascii?Q?AGP09NGAdn/1WBepODE1j6drufxS/lOKMDO9wvMT3lxfg4utGwHn98+2ShFe?=
 =?us-ascii?Q?HUpbDq6AyAhPA2XNfeGPMlXxxwzXs6o7b2Fd1wDBEfnbirdjj/VIl8eQTf6r?=
 =?us-ascii?Q?dAnzO7TqAlmAdEHI7qtq35cOgKo8BJ2ybeV7Sytqu9m0H3tj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2fe2c9-7ae3-4392-a655-08df44d14318
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:36:07.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7g7w7NgUTVGHC2Y+D1UO0ugDgnj8Tq4Xgp+u1lfFRsbHQd+t4ixdycgsZKWzncz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999121

On 15 Nov 2026, at 15:58, Lorenzo Stoakes (ARM) wrote:

> From: Eliav Farber <farbere@amazon.com>
>
> walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
> so without holding the PMD lock, so the assertion is only valid if nothing
> can concurrently install a huge PMD entry in the range.
>
> This is not the case for a VMA whose driver implements both ->fault and
> ->huge_fault and which invokes vmf_insert_pfn() from the former.
>
> The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it only
> takes the mmap write lock and faults taken under the VMA lock are
> unaffected by this.
>
> This can result in two concurrent threads faulting the same thing
> disagreeing as to whether to attempt a huge fault and thus ->fault and
> ->huge_fault running at the same time and triggering this assertion.
>
> So just remove the assert.
>
> Target the commit which introduced the first driver able to do this for the
> fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
> them using its own mapping entry lock.
>
> Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> [ ljs: rewrote commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/memory.c | 1 -
>  1 file changed, 1 deletion(-)
>
Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
