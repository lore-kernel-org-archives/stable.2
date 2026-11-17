Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938671;
	b=qrQ1dXvWKY/31Q5iXLZOj8SnRmEgFXggAdiSOM6MGs5gTyt9Q07PVpRc3Nu2ewolR7MK
	 lFMVG14Vx+kHKgS5xzgLWefo5TCUhwQUZgUpfZVnNH3R8ajV0qIBAIy5C+jtUoZLQh5qb
	 nQeIulaY8zVzdQZtwg+Xk5iPpEcW/HMxd2lFkoSPTfTivqtBkBNRrezMKUBHOFX83UCmK
	 Tr5xp2bT9fO0Xv/CFJSBUY8sjT/XEOXXqUD/ZZ9rlazc8aS1xrS+smM3nza5eHL6ULco1
	 KHUNICgNYD8OBNfloLknln/BwLLgM24QrGterGFmKEo9ckp+aFx5JLOE74aw7EHK1dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938671;
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
	bh=TQzHtIOxpN3FxMSbJyryyBOk/os0I6AxH0oWlf/G/R8=;
	b=WYnzFe4BvMB2hMwHw+ks3FC1QCAPS3QTLnmhgHP1AsZ0vBqeoRPvJciS+g4Cmnb1mg1n
	 o6HSoT2KdBs5W7Rk1mGBSw/PvHrJ7j8tig7HWbgE8WbciBAcKlXo8mMLRnHB2mBn1LfvM
	 R8Sczh+phCttUUb0JuXmbmjOAkA1k0igSZm1ICXHr1T+stP2BuaT6JWf5S4jA6IDaQEdM
	 3L+HYPNpM6zcwZgm1UynRHMcCoVhnI39KJiUK25nF+PEDzSnbYCw4+YPp4EBoJFkctunJ
	 3evHeuok0zoyh4le0b1A9MHumBFiEUNqAJxdwrg1tgePNwRp+SkFhasruklVM2dbrSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TVlc9rAa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.29
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE33606A31C;
	Tue, 17 Nov 2026 18:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE33606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TVlc9rAa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7k3D7dYubLquBIJYDf9J39ZZfdy43ToDNJSKrbwb+L7D/Smt+kdY0fPiYcMx3Zt9miW8OCHIWx1+MhMah69VSH7MGKv7iAXU+AcL4rr44aWGsTimPUjBZiwXAPSr+P4jZQhFY4Dt+2q26CUPGLdA9CjK/qdu8BPf+DgYAxgitzILOsYkC/RSUSXb9VGdCgezDBpmcMyaSUX/QvCBdVW4PdAlziD1UsVQ1V6KaDF1x61rdQYn/IrwJrEy/BbFIC143At7t7AYqSPwS03jzJXpGp9IobsaJGWfEIOatqEWtGHzrkq5vTULE2kJIT3MEYscZXgPXSk156n5FoCStB/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQzHtIOxpN3FxMSbJyryyBOk/os0I6AxH0oWlf/G/R8=;
 b=Vm9UU9uj4wtV4NooKp22jqABbLa0ClqiIPMx1DqaWVxi1ni75ZsQ0dp9SEExPQgrxRttiYDZOt9fiAFpdH77lYaZhqdMsjJRHmCvxMzgbzOw0GMmGhlSNXnFuORugfs/eqe/MwcyB++aMyVVcKGY3El1NE5c3J+jzwIt1Yv1WlEan4zym1UYD460pGviQHtuLPD92PlFc7fO1hUggxvDba270AiopI1NR/W5aQ8xj/mWEGtwP6DSWr5W4CMvrBZjAxAKZOX7x47uHp6QaBLBG947RhkXuWtj7ai5k9C/uBVAXWMzRPEP0YG9JWo5RQ92CjI/p0rlwveX8tZvkDjwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQzHtIOxpN3FxMSbJyryyBOk/os0I6AxH0oWlf/G/R8=;
 b=TVlc9rAaO9bclCIXdvhzexGS3qA5B45VOWN3Ybjgxdcaf7zmcJR27qDqtZxGfezLL24JLozV5yq3DJdAzznXCvRGseNIWlHCNTwvT/mkjYDtiwy8TZegnEbe0LF0ycOkZXpiNhAHotOXydePcMeETHm3XiXsM+20fnGPI3S10HGLhj6yGwITNCBXaAAynn+RbN83gIhiTFfWy1WPKhH57QLbiAo2RlvpAuTG1UlajcMf2zfZZkKhT45TzvsQb6o0mQBfLha0Lm/5tpmjzDiq+WSBg+xNA4rQQb8tTC5yhD+QaBHYY4qdA429USUSljM9c2t5mWTxH4NIJZ+pJclNoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH4PR12MB026689.namprd12.prod.outlook.com (2603:10b6:610:506::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:04:18 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 18:04:18 +0000
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
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH 2/3] mm/memory: do not report OOM if insert_pfn() races a
 huge fault
Date: Tue, 17 Nov 2026 13:04:15 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <C667B998-B009-4E4D-96B4-86DF4F31D152@nvidia.com>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: CH0PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:610:74::26) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH4PR12MB026689:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f3c45d-be7c-40ab-dc23-08df44d532fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|261009223027099003|18002099003|22082099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261022105027099003|56012099006|4143699003|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	Kz+K4DwFxJs6zTu0Uz8Ic9XwWBeo5ad48MMwW3TbtXOlZ4f0TjQS/vihZv78oxCEHLHIidPdtfgZerCguAu/JUDBZ/gwQ0Rl5cim2GyHEhW/KJwsieX5qVjwoKTCx/8GjeENG/LY6soHec+65aahrbzPCg/V4vqlwoed0OQgrpNS50uyLsW6s2mqJfDtZrTC90Jt8722ELTR8KIlClfVOfTE0xm7lzeQzmoRxt3BeTQQHix7d+6wo43IgJe85v//laTUj8g3gC9D8T4gAy6F2L9g64aBjPzdXmRV7uDg12cWKL7gB3cUzoX0QSiY27LmMAm9f8pYeDKbssoR0HY+mmK87PI/I+iPuGvTbD2KzRJb1kuoY4m0YdHqogVUx4KbqiSoyF/GkBq96kkOAceXc/tqveTqprwQqIGinkIRBUS80V7loHoo82USmcvFItOqV4q1TxMLnafWqzcnUiW9s1OzUiqgBhVT0c3rtxAJtiI/3W6reLdZ0HtsSWxdUpTdKcyZcSjAKQrMu3sprMOnWro56oHM1wJgnMozKdOmLkUwm09zmtQtIBknV6LrQcqq7pohdIx332eMKuR51DnjOibfR+HOjkdXCEyGisuXRGH6zzCHSHvifI78LdFWDvpNoGhETp6GCPGOts/65lF/2QmlVvVlpmAkCepWEPcKRqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(56012099006)(4143699003)(10067099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7fjQuxfM3JXuw4kLIaQ2SyTf/8Vj7+TdT/9oCqZvnrYKHPvEZFHowTYkh3d?=
 =?us-ascii?Q?X/rcuYeezxX9fd+hjM7lnOB/BufDkCIcS26eCiSszR+IEO6KEG1cCwCsApEA?=
 =?us-ascii?Q?AjgGPB3vhHwMnhG1+EAKiv8xYRywC5xIvKmmknAJ/gGePwXx+6RdWydDjU/b?=
 =?us-ascii?Q?QWAe9GK4xkCO+ho/Rf1xK8YJlr7RbUIZls/k1dqx5xweXe4BIivZza3JQ9kT?=
 =?us-ascii?Q?57hZCV9j3Xmm5RwmDHyU2vo05wGwkAYo6/QU5fsFAzUSZO25S6yRJB3rbZIP?=
 =?us-ascii?Q?+krFXI3QCdxw4W0FUuhm2xAYqp/kE+hvKCPBy8ZoM0aK/x5l2ahZ3Ybfxtlx?=
 =?us-ascii?Q?9rcWb/krAkV2ZRA2kgWI8Of2jlo4HdbOizKmUeZL0wuDMP2a/kp/hic4AHml?=
 =?us-ascii?Q?X0GQz5oV3niXre0yeCBWBKEGXCggX031iPhn7wcJdB9+03CDR8Co9RQKHv1V?=
 =?us-ascii?Q?DsdK/TAyyAoy5A2aPPOgl73j+7+27W9CumbLoqgMHIgO+ra3tKYW3LgkVwxc?=
 =?us-ascii?Q?hYopq24QAwpuVhBbuWU5z+YlmINBnVvD4sVkI3UaTbO+ti7UsR9SdMlAHvh5?=
 =?us-ascii?Q?HLJBBkUCVFBnAlbso2BHlBXCJV0ma2JGkv/eP2Rr/Sm3bD38kPQsh4fkRmxQ?=
 =?us-ascii?Q?aX/HEmFdHAORSOmqL+0lFJayvvGb53khXjQZZm4HtHs0dzpQJIgEoaWXNTee?=
 =?us-ascii?Q?blZsH5YsdR4ihEwaTWmj4wiYCJhngzkH2QSGR0RZBEmeVRZ/PUlzvxAnRjIa?=
 =?us-ascii?Q?PIl3rc25jkhIXKI/XYUFLDVjDbEZpG0lgv2bzruejWL4/T4qVhqN0S2YLa/l?=
 =?us-ascii?Q?5GcNsl4pwGaR4DGgINzCQgMiKIojX1uzkt9fxLRivPYcKWLPb2xFshAha5rB?=
 =?us-ascii?Q?2JFWg2FMNt3WKyzUwT83mXBfFJ/cIjJLlJm4aF5BYK5GaR7dKya/3I3OaFEk?=
 =?us-ascii?Q?BOsG56dDwAmXr94+37vxeCUDKIFEjNTNylWLKctk5bz4Uu1nUh25B9GQXgOZ?=
 =?us-ascii?Q?Pnhr+pdcsDdSel4GA4Ajpogvdt0XsJfCl6zbnPLz7bdRaQelNy5X5Qj0MNVg?=
 =?us-ascii?Q?HG564ixYnXMIBprNgrwBOTnQUeM9Sm4RE5dYR7se5Pn6nJHbdnKCGDWxG9WZ?=
 =?us-ascii?Q?HiLi9aYKNsPjrstirfF+ifJJqsIdWah5eNVpCR3eSKf7YIeuOlYud+W0wp34?=
 =?us-ascii?Q?xZNQGafO1Kq4or4/uxffERR4pr9m7/rmvSLOnq8C5fi3eOujpxBbHd134w03?=
 =?us-ascii?Q?4d5GgxtU4K8CPwTVWxjXB2llUhhlFcWFe7vLgsflnPQIpxzbeQQ2IQ+iMuZS?=
 =?us-ascii?Q?PL1Yyh1wpG5ut5Iu2xq95TUEX/uER7SEvQg4/jr91Mvtq3VH9x84KnIcCDP6?=
 =?us-ascii?Q?iy1BSP+05Ri3t1Ki8JtTTXtlwCTDF9LrPLFuzCNR1VappKEsQdmXQy/knkuI?=
 =?us-ascii?Q?CtKi/8y3rsc8TG4XCLB7LLctvE8+hfXosY6HwT2ZRzy4UmBGqVsnwlT5qpUd?=
 =?us-ascii?Q?i3GRfHuial2bdE8NSiT1+Rzk9cdEnsewd81LhXvdDS7Mz1OZ+f1Q7LAqbDeP?=
 =?us-ascii?Q?syFuw9V3s4xqrU/Wg1hOv3NiaJxouoARSXVfxD5KoJlDaST2jj6FSpJCZLn2?=
 =?us-ascii?Q?L1l10NGe3MRuazIU71JT8lQSlue5KMmHXzDLHeJg2YflrD7yOEa9pTFBTe/y?=
 =?us-ascii?Q?R3kdj70foqeJoXqHE/XIMTiOJWsDTEd/9badYyaXD+1thtI0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f3c45d-be7c-40ab-dc23-08df44d532fb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:04:18.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcxK76+uX+nDksQ2yX6/GHSZQC18hwLB6Miles00+aFtvWzJj2jAReLeyhYSXbN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB026689

On 15 Nov 2026, at 15:58, Lorenzo Stoakes (ARM) wrote:

> From: Eliav Farber <farbere@amazon.com>
>
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
>
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
>
> This is not currently safely handled by insert_pfn(), however, which
> obtains its PTE entry via get_locked_pte(), and treats a NULL return value
> as an allocation failure, returning VM_FAULT_OOM.
>
> The issue is that get_locked_pte() also returns NULL if the PMD entry is
> not a page table which can happen if a concurrent huge fault installs a
> huge PMD entry between __handle_mm_fault() observing the PMD entry to be
> empty and insert_pfn() being invoked.
>
> This can result in VM_FAULT_OOM being reported incorrectly.
>
> Address this by proactively checking whether a page table allocation
> actually failed, and returning VM_FAULT_NOPAGE if the NULL indicates that
> we were raced instead.
>
> The same assumption is made in insert_page(), however only DAX implements
> ->huge_fault and can reach it, and it serialises faults of different orders
> with its own mapping entry lock, so it does not require a change.
>
> Target the commit introducing the first driver able to do this.
>
> Link: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> [ ljs: rewrote commit message, trimmed comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/memory.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
Makes sense.

Reivewed-by: Zi Yan <ziy@nvidia.com>


Related to get_locked_pte(), there are other callers, like __text_poke()
from arch/x86/kernel/alternative.c, assuming get_locked_pte() will never
encounter a PMD leaf (especially with the VM_BUG_ON() removed in patch 1).
I was worried about removing VM_BUG_ON() would also remove a check
for these callers. But LLM managed to convince me that the removed
VM_BUG_ON() is already weak and not present when DEBUG_VM is off
or THP is off. So all good.

Best Regards,
Yan, Zi
