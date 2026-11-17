Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794939513;
	b=a6AjQW+UbEwoL0OTtZ92m0bL+qhzhZM31d6NtKR2wXcRptlDgH8D4ibPXj+IDmr4Zsen
	 lNad/CyHomW4f/N96kqEeGOczUMEk+WO4xlWRhXQHL54IdwbYgHJV5orYXD0+XTTHGMK5
	 cS9Or3U1zwn7PlFqRxJ4GA7shOv2qYPgs7j1dFUDRNuKGHfxCulFIALlggtuqdhfSj1o2
	 F58PdwkDssaXAXmr1d9tX1LXV8sQ/Qn4pbkcoOjZ3RezIXXWK0NEyeuWoWk60CCe2/h9M
	 iQYxq7SuIzE7kjl5KG2HjTZxcAk0M+tGqrMOd4cggp0IUHz5cogLdXuPNnDMmH4lkFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939513;
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
	bh=WxYddlKLlR7hNTa0YjcjpFyJFrmv2MGCYT9ssW5owmg=;
	b=nHDm4Pop1XlaxCPyILvPq3y9+VEZIqxMNkjUFz9nNStEk+u7Rl0CRGzTC8vBRqxST3md
	 Ri/ZHyOIoX1mK4PD2SccX+NLi+/7/vGfzxpLJAQE0JH7/sMfKWZfqXAKK89f48WWo18QV
	 RYcu6I1Htli2dI6LB44vXVpZI6Iiv2bmLsx4ARy73IJvT1ET4G0AimqOYmvBqAfl3GMKo
	 D6rXrJxbitAmZPff9B3NleHPSxcIMUflAqiLbW9mNN296Dmsw2FS679j0b/lfAgOAYAXh
	 V1iCO28WfVzNm9aTLHu3F1s+Ks2EF/T7mrZWAkNxv6WVj2nigcJ6qbrLXshBHG4Tn+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WFaR7AfV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.53
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41445606A32C;
	Tue, 17 Nov 2026 18:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41445606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WFaR7AfV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R31tpIWy4woDT9Si6HRT61pEj2AQDVqOK+W8M0Wo2xPAHAeV36id7TI0RoNk1lh9xiyhOq/pbdlgjmnf3EuRXjv5Utfbi3pVnJguC44zfv74DPaVQUM9C0E7gmsN8a9v5TAHOsrPck6Ud97UnR5gGNdFZ+JbUn3kvVjkYtkNPqKX0qmMmVozSE5laYHm5Uife19P1rMM5CldcQVsPwBpcmD0F+q9HpGLJu5dS+LBEZ0iiw/a4XLSrmk+ZYKLZbAdPue0zMr3aPwn0TyvJNzfDJ8U892VVN9k0UrpCP+S6LKEjFYQoMkjEXqr+aDJk2AVkLWayyI3sX2SNzdV69s6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxYddlKLlR7hNTa0YjcjpFyJFrmv2MGCYT9ssW5owmg=;
 b=Kg0XJu5yuGJRowKPNqJ/usK4cAH+tETzK2dQcNojospGU0zRRpRzy9AJOGnZWw1WkPELZGtWkI6mk/GdQH1TjoIBJhUZL4hxneVOlxb7hvjOqUaq2lx4cECBYjo1ufPRp1+pl62S3WL1wcMGhKxgccw7OqHpXwWPS4R4rDpYbddpzkpVeECQy38zVSLhsMV0fMTC5aBkK05RzcL6NWys0a/bRYpWQlDRec36qzFBgNjQPuBGuVWD6Zi68pzae9vMIz5okuO+wleeo7xNC0+3lKDuZhZvOj/tVnWAdiaBMwPdQpT6LCQc2qBVs8KuBVMmzvRxo1XFEVVoW2VzRVVMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxYddlKLlR7hNTa0YjcjpFyJFrmv2MGCYT9ssW5owmg=;
 b=WFaR7AfVoX5WWYfezXIEWGx8P6rTwLnqng9+7ijkfbg0pS+03zyjlGhHWTbhqwvt026CrmAUUp//o3LZz0YzbRNYFu/6sOyiQ8fMaOJO4UNMV/F4yScJeyml/iBrRJUMVev9RaYOZ0srEfZWuP1g7e+q4hP/+Oo6I83j+jFc5XUJTO0/Sp/sU+DZtSv/Wg1+kqNXJ3SldnvJ9kzjlrTfC6MrUQ0cvXMB06r12JOLQUedEdf9FaVG7J+0dXiEOKvcOcdOhb611TQgaLtffJk3dW8pEFexNLOhWNt+SAR3hfq8ynzrdN12VFhwLw+GWO1KOkNUJHOHe3wF/iFJbGw9Kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:18:26 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 18:18:25 +0000
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
Subject: Re: [PATCH 3/3] mm/huge_memory: only compare PFNs of huge entries on
 huge fault insert
Date: Tue, 17 Nov 2026 13:18:23 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <69AC0B53-F34B-4FE7-99CF-6AA36A689116@nvidia.com>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BN0PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:408:ed::35) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ac32bf-876a-4672-1f8b-08df44d72ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|11063799006|56012099006|5023799004|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HEUdeI3SSYgSdVFOxPWOHcpDaUiuJm3AXNYnrkdjg1p5yCEFHi0JIkdJj6hr+W+h7GDqvN/IfN9XRGydde3hCOLV6cmVDlgbEIm8ylu3qNMc2Av0YqZGBW/TpMUvy9HFkp9Jee04hWQebuack3lLtTdcFmMbihQTkex/O/BR+VUBzOxA3Vcw7qfGIml247Meu96+cVHexzZ4rF56ycwrCuUW5TV6DAg124OC+YXeQJFdbxKlGMbeuMEXtKCT+IzZ4sza8sTNfo0+9j6Mgb4hCDrwk8QspYlEUbAwAQAnE1MKv2ofet9IHdUffUO+Z248KPkiWtn3WgCGNA9jmaNfmYNhqyvmcyv1bKWz2f8SXvEiD7TLvdaR+7qeUQvXcywbaqoY5Nb46b38cy6WAZeTNVYs8vER+lH9spdfM6OGjbH8d31c4CMf4pr7aiOlJCfMj9vkX4u7l6X31GpAUl71AYXrgqMTtQsmIUrUss0tmg6pgYvMFHyILoDKqcFWbqf0lNFHQk+pJ2MrZj9lFVZiqlOZTlD64SXDYlsMyEYZdxco8YNjmzEOHcChD9LPfKHUA5PdgY7UoOO0NFQYv0zwqY0ROaEYMNBIq5ltuEOWdAH0mAedqDOagJRjnCoVcP1JdaaHfB9Vd+DjLQPB3jiXPS31nJn2b1pCq/5y5NX4bBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L7BIS3Xq9vpKNoM2j8fuoj2y5PAAK0gTfT/dkSVqDNLGbL/OXy3UDOjs+Vr4?=
 =?us-ascii?Q?xO3+vd6SKf8MJxTdQor13Ye0hiJcNNsSiYKIDg3A+u01pmz7oSMS92dZCwI+?=
 =?us-ascii?Q?JtQLTq3qWWyzzpuIN27o21uJY8pm5yjInPx+yMzhTnXnxNyiGbwt0P35MwTn?=
 =?us-ascii?Q?GVWKZPfcGP97xXcDx7BTRLky7sz1D5irtC8VFPQC3EEBZlgWKe4EnokRipGm?=
 =?us-ascii?Q?ZEoHaaYG+C4DD/rWHvd9QHbu+aEYkdmgSCZGWemYF59axROuBAYH8DBjbrkU?=
 =?us-ascii?Q?fGd6rfVSioWZZRwycNIOS04PcTote9xBA/OIXIEX0Kt6OaeuR/tdj6weHr2j?=
 =?us-ascii?Q?yweAzD68XxOUJnALf0DgGlnvKWuJjVGjMSbYnwB2meOFpetNjJWO/rqTTaD+?=
 =?us-ascii?Q?sWFc6U0+ijbCtqNDCz7sApjQJ5Oe+Mb8o3mDo1UZUU31WhoXgpYsLEh+70g4?=
 =?us-ascii?Q?O6NhtSor2o36ZyX3EVnPI3+LtiIS5LlpNDAlvfdnfMSvl7T8jdozQ1njrDSQ?=
 =?us-ascii?Q?gFeNqq+fW6j69P/WTFmmbl4x1B8dy7JyxH33DUfBjcrpIU3mP950Ns+Bet8k?=
 =?us-ascii?Q?4Mr/EpUjdsFmla9oFF/cWw6Qvg6U6mS3dQBTJKcf0q2J4HMCoY/SvYqKDt7w?=
 =?us-ascii?Q?sjHQ9T/64kf/U6u6I/HyypwT4oG6yNGAiWEm+/F5OZxfcpsY8MgZDhSYCitz?=
 =?us-ascii?Q?N29vPjGR28hrLqVFzt5GPdyIqPpCV145JVEwAFx8gxZMU29uODhMvILpUkN4?=
 =?us-ascii?Q?utQ+DDp/w1mYoGjNS3vtXs172Ny/I4fR2fJQxZxLM3hhzLf5YfyH1XxZOB97?=
 =?us-ascii?Q?lZwlubvpIBEDmGJvqqCv9CBDOp0oj+raYIs7KMdnU7cMKMCh189NMj5kqixq?=
 =?us-ascii?Q?ffcCBhbXEihYf/gOzczstcJ/FjBrgTKOdXiBKVzc0+7xUcycsiaHc7nqgdZc?=
 =?us-ascii?Q?e1xwjbg2IMwreqWnwtx/xkbjIe80X4+RSeHNjNCw1DHWxRiEoKg5u0hyZopE?=
 =?us-ascii?Q?aMZwI8l6X2U0+0nssMKXn4+EGuSMPJx4+5DptjR2rAT90xjlXQn4jl5DG6p0?=
 =?us-ascii?Q?OJGYq5VFAPW55xqjJ+0A770ovV6V1/E05z7+F2w3uIpO/YAPt1g8LKNk9WaA?=
 =?us-ascii?Q?s2FHdoufo7LKhSAM1dBOclcFlQ9lrBc7G3Ogb/dqowZekhZENKvZbsJGvAmQ?=
 =?us-ascii?Q?gPN/bo0dIVfKKGEAfFX+lbQU/4fvertw7pZO4N5Pg/1GUnEEpWaXvdBXcN15?=
 =?us-ascii?Q?ckIPCWDRImO7W4Xi1iLcjQlFW2Eyh3qQO2vVAZYMHjUHkHrkLNgf0G2aKi1R?=
 =?us-ascii?Q?If84wsxr1UnHnTVgHgAut4EqWjTL9+p0AgfYI/U+oS2CibEt6qbc1StpBU0f?=
 =?us-ascii?Q?QSC6nhoOPVVWWJlA4f6W0qxQwkfXNR2VQXMOGLABlRvVXWGTCkb5fOtUarJa?=
 =?us-ascii?Q?lQwck+cVq4Uniyky3+7qIOfB9vBFdKVf6qXbraxMkWst2e8O1qPw28KFAhEE?=
 =?us-ascii?Q?NR7iaiuYGPkkU21193EQyByFaSzu3iZgnoQC2/CLHf2k7SyaR0IHCUyIlYHZ?=
 =?us-ascii?Q?w8Qb3eBeCHrn8jIwvThl4jDQAoy6qTVi+V4W0yLF63Z3qClkkCzloY3ipDQM?=
 =?us-ascii?Q?WlHHMKv2B2IF1ZxxeWcNMOGMDmJD+zHWW9O5OZUscKLfHnQrvot1PP2B7Vwc?=
 =?us-ascii?Q?lKdgF6IlelWcItkZmRVeEaGmntTDCCl9Uz/yo9eoxUw71lRi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ac32bf-876a-4672-1f8b-08df44d72ba4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:18:25.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXnhqeYRraGOzfjDa7m6rXYMjuxydMtJ0xUn4EETWKM/iU4fOfwQt86AvlLO/JZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

On 15 Nov 2026, at 15:58, Lorenzo Stoakes (ARM) wrote:

> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.

It is always a race.

>
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
>
> insert_pmd() and insert_pud() have issues with this as they both assume
> that, if the page table entry being populated is not empty, it must a
> present huge entry.
>
> This is problematic as if it is a write fault, it compares its PFN against
> the one being inserted, warning if they differ, on the assumption that the
> entry is a huge leaf.
>
> Since the entry may be a page table, this is invalid and can result in
> spurious warnings.
>
> Equally, the entry might be non-present. Nothing can install such an entry
> in the VMAs that reach this code today, but there is no reason to rely upon
> that.
>
> Therefore only examine the PFN if the entry is both present and huge, and
> otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handled
> at the appropriate level.
>
> This is what already happens for a read fault, for which the existing entry
> is not examined at all.
>
> Target the commit which introduced the first driver which both mixes fault
> orders and passes the write flag for the fix (since this commit, both
> drm_gem_shmem and panthor are prey to this issue).
>
> Reported-by: Eliav Farber <farbere@amazon.com>
> Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon.com/
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/huge_memory.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
