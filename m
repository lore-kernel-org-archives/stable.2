Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098394;
	b=I50fyp4EKQq6ser/t0o4V8j03+Wv0et3N+vEWBHm2eoVmFauiW3kN5PEsEaV+2Dz2eX4
	 D+SMmddXTlYyqN4vta9aXgGdYVWSm2cywn5vxxa8kTATE50CIKOZfV6oxBw9POfhhz5J2
	 DAdaoUCKvxQRkBeQ33BTR+CYCO//Tezjq/n5FG31N+VxtZdHtg/8QzTFsj/EpYEn7kg5e
	 ft4P5hDlKU7N2w+/TSm2bu9eq2HkHSKmGVESKFmR/T9bE6NVsYQO5jAlPORCgN4pG/EI8
	 eGU2N0Ml0mMlxHeNGL0yvC7Z6+RfhYl8lKACwksgR1r6V0hjKvButMBd72sdSmbuhYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098394;
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
	bh=kLo195nhj6xrWbL8tyBoGiuCWkNbEQUhJFfP0/ptvxE=;
	b=pj1zcbaCsKlz2ifoI+KZ9n1/Q2sDbtIIaVfJ/yU+Fl7NkOpKDSSqbNGyTyEpsYz0lXT3
	 WEyS6NvFAZ1/QIiSjYznghCW2oDzOXDBVHXelKKpts0j7FFc9xuI8yEi0zqay3olR5RfY
	 mgIR5Vc07fddVfwBcLDRptlQxdIV+QGipUJ7cmUC+EaejrXACw8preA38HGD9iZjQx/j4
	 zxc/G0tr581tID2tPCp3lGhxgCxrMkzsjMDJgpqxX2MTe2rcwUUI9iQGDiL7usYnaJKkJ
	 gSqN611vRRJRGrQS09ME/HHc2EGPXHhWU1K4XFfzvgx3dA0Q6NEyTcofU4J6QmGmPxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dxj24mLm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.55
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFC606A320;
	Thu, 19 Nov 2026 14:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BFC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dxj24mLm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFmzUvZ1MDS2JMuzboq3Q6y1wrdn58eOOgLMXLXp8A+n7cHABAYxyiFlFF/1RvMy1eDZGsZEXDcF+PBmMw9hm/ara5lYJNVX3oFRyoNt5Bxj8BVAuf4shKNvM764k7H5M6htfH+gry0K0ENhQPMfiytTmwgM/gTTYj7cU5K5VORdZoTdWuc5wXOdJPS5uwZ1QvTiw20l83MxKB4fudkOD40pVea5vFCoXC9L82R/G5m/Z4qneZBl2HM53yeoLsd6oSHQRNu4Jy85QGs/22kUzGBE2XJtm1xj2f2601vXAs2HcQK3LuxbSyIakzruJc14PN88lPzRWIpLyegpJ/u6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLo195nhj6xrWbL8tyBoGiuCWkNbEQUhJFfP0/ptvxE=;
 b=ryt9Q6pGTcre7GBagiwEg2sQVqrNzMtjcz57sUK6VJZcU29+cwvMkrpuOcbZJrlUAcKCErKmvpwnjsXwg5DKpKYGHTwxlYcpdSvJ3ESFX5oUU1zYp3Zfhx6m4VLwmA8SjISRTJmBXUpyrqNIKxBuuftkZbYsgk4FrbmonQXZGSb6xRqwgWg4vs0qm7h6+34dNIDRH4Xm5MpfUUjy6mCaQgsTT72JVgdFIUXu7beEtIROHYXg8ojAuZ5GNTVY8CQv8+Qfj0cXIBtyHshJINaXBTE/slnN3m4j+CG02NOQSMv39y8GF5SL5z/osHRFeBvlmt9iePdPzHFnImAPjYjPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLo195nhj6xrWbL8tyBoGiuCWkNbEQUhJFfP0/ptvxE=;
 b=dxj24mLmxvhLZvtpMgeytscyY3hwLAu3mB9v5tc3MyPaGDbwUOrvdpYwt/BinWK9/U691wkg6/NaP14zXlO+4MKEAAOC0jcuibqs74warY3FJIV4Dw45P3MEr0sUsWH5gH7iCg6kcKvbdZJ3vCoDUVw2rvf1+DVhmHLTvnFbLdSk+BDUumi02MkSq3lyKeLIeQjojzfx0sB0l9WlZlEpDdbK7TwOUVWDvfWslQr782jsOrpv/bH5c8NFdaRq89TXivvp8+mKPb03RUlmyT+X+Yo2jmncz0u5tRT3+kKVbjuLKsB9Iwz3WBe7w5UJaorJkwyP4kaZKb+IVOD7Feqn4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:26:31 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 14:26:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Usama Arif <usama.arif@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory: don't map hardware-poisoned pages in
 finish_fault()
Date: Thu, 19 Nov 2026 09:26:28 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <60EB5A48-93F8-47DC-85C5-C83A60A72083@nvidia.com>
In-Reply-To: <20261119134236.3745231-1-kas@kernel.org>
References: <20261119134236.3745231-1-kas@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0496.namprd03.prod.outlook.com
 (2603:10b6:408:130::21) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: d0542311-7f5c-45c9-1e1a-08df46491ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261102123227099003|261026140227099003|261026121527099003|261028144727099003|11063799006|261022075727099003|261021121427099003|261022105027099003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RF8PySqMdsCCEMvi9ltvs0XWl8/7FCQrKBaMLdeH9NLtGctKTQW0mQkGo9hrn95e0oPF7F4qVl837CE/j89yAm6BloRoGXX73dQj9+rQHH9q4rGnX+H0AODJt5Ri96jTf4l//HVqMy3ElEbcybQiRC6hmHnjl9gcYqPAqa0EdCFFOY0IpDWif5pQq+dyqlqTN2SmQho71iNkT6tNe/Izk0aMnYMOitpAR4TrZGh+K193y6HFERKusmhk68j5ecQ9xhVTFDP6DePwQ/veLo2njRigic+J/MfT6USy0DbelrsRagjduITrgfuec0KpnhKw8bkI9rfQreUSF02JpxKNta9+wVqtadYCXeSkIh6miril+W6J5Yl6quQv6iCr0TdaKpPY59ZWbY8SjIlN8QuItjgAhmFQedAVxIQtASZaYqic5klq5fXPscUQ2wiotM21gAgXuhzzGUMXkO2r32XYn1TVnyu7WV1xtX2epAbx3vdOLB1eElRi/HwwJ6lqUWPN6f7a+l4wUNkbJxbIQMOw33dsRHVESGG1+l9HzWMtqhgASo9b7k3nkVLlpI66vOZAD0P60hZFl1UI5Rud9Fn9Kya/GaxFSrD5W37cJXtXiLDbqhNh9YX+hQLkXzTcGk0O0pGPeEULtDf2g1TmAX3D5n6mVuQl0hF6HgAM/0EKEVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(261022075727099003)(261021121427099003)(261022105027099003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+JgTXwG5LHNvVH2B+H1f3xquloowLINbrH33L+9t7xhJ3XFkTAqdYdjaSnz?=
 =?us-ascii?Q?/RIAdbsM7Uhg6LRYag6SMnDrTNhn3ShrvADmixgorsAmIp0IGemmqok4zYT7?=
 =?us-ascii?Q?o7eBxF7Pn3Og4MNkWL3raCD5RLuUgFBpbnVfBkaHhGwlSuLce8s5fiXSh8zH?=
 =?us-ascii?Q?9wuEuEf3nqwRCtfaDdTmvirAZozvur+iXgxQH2vT6hx2u3YcymP4rORjVWhi?=
 =?us-ascii?Q?x/Q9/lyLJACuw6d3G7cM9jeiVZjabYM2f45+5jpwDxfg9l5+xgtD9xVV5fxz?=
 =?us-ascii?Q?NMblPHmyPSq3HgmrcsxEPVA0SH+Ep2KlqwD37TDoe5/DjY9WOzUY+dxLc5bd?=
 =?us-ascii?Q?g0C6wlKTeR7hW9jynykau80eo09rQrRnOt+OkeH8qJgVJV1ULexTWqtHQHis?=
 =?us-ascii?Q?2xcUMKZANTLlVu2LErwae/S88uJ5rkBSTpWp2qlAcqXFZocXpJAdNE5YQlZI?=
 =?us-ascii?Q?RK32ZgyH1O8uaP9BEFtDWP3rPP5GtyZ+YHsB1cs83Z/CtJ+ZkxAWe+zsTDfn?=
 =?us-ascii?Q?lGA02t32ySJkXL1kyQ+3qfeqagFqsBcvYYyj9p219LQFe2/HeDV5apWkhxSH?=
 =?us-ascii?Q?b/NYqgm0e/YxhhyUbSaK412gOyMQY2JYXR+dlu8G3cq4VRnd4HRFe/tozr7l?=
 =?us-ascii?Q?FYoBC3/Ow9w+QmFUosII61NBeP8vFi/lNdZ86KUiyctAdCyM+yguTrRGbFAL?=
 =?us-ascii?Q?YewvDln8xcHZg70Y+xMwDhPMPrsgCyiz92xmYeUQXIQCghKuFOmvt1myYsuZ?=
 =?us-ascii?Q?l7nCyjaZSGJrQxdi1CjQroTKE88ca+ckjtqJa82qXpASiraF/CRxwanS+JYa?=
 =?us-ascii?Q?ojGCk8gbGQFE5AToYOy19dDyIL2NBZt/zwaGg5+Gu/F1ixWCBhMvnHSkIlzt?=
 =?us-ascii?Q?I+ob8+auVQIbF5rNAiD3V37/0rvjaPuQYfZCfv2g+vCtFaWF5SZrTfRsWq+0?=
 =?us-ascii?Q?eailiW+OMHzdcl8loGzbbUFEfu0Tss/77ezn/CSFFJaq+hv5TFqT75jISIVU?=
 =?us-ascii?Q?VtMPmPGZmotGUbBt1ct3KQJFdD89nYsppdYKlJYhIksYJBBcolzYkxEDjOsV?=
 =?us-ascii?Q?49lfnym+5BiB9n64K/JGZuOoByrwfmsuzw9P0a9FRXhVscef//m0g0NculOX?=
 =?us-ascii?Q?nCzOi33qPNhxBgtaCAmXGJa7DUy3CT6hvlY/G1JKrx+2nrahs0HvfhMACICJ?=
 =?us-ascii?Q?C7c9grenFU1XC5MU/LobuQ2oNlHQ/RrKwY2RphJU2gh/Ha4Grs4n0vNOW03O?=
 =?us-ascii?Q?rGcU5h3VCOVk1EH6Z3/DgYWbw7Lm02AxU+JvvF06d/GhEhSBCaNUbf/ReAdU?=
 =?us-ascii?Q?6qgkShmucfbZdYxLIbGjCJG+Y520w0u6KEjo6gS+Bi0ew5TqKYD9O70ymaPW?=
 =?us-ascii?Q?JSrC5angWUO2ATlLqQNTE2itewrzX3tTKCBLdwpEXFKRWzpoU+NUzPlig+A7?=
 =?us-ascii?Q?5xIO+j32HhJ1JbKJlqI/DzfvSyfnE22Y3d7H5Ov/bh4M1fRmBPnS28TA5Dl1?=
 =?us-ascii?Q?8W2he8FdqtfmGxHqTWva0/ZWCQMzPwKSv5lcLJMAEMX+nUQ5N0JhJfXwHCq4?=
 =?us-ascii?Q?yIrj2VC6WspDwIaRC5mmSXwX7P54fSI3Wy5jCDxo0PLbrjfd+pV/lAaoBVHb?=
 =?us-ascii?Q?Tr7WCm1LZNgs6Fjr6BVZ/axrlDBFK/VwVyKLgZPj7jNq11KDj5TunBWcJJI1?=
 =?us-ascii?Q?KjLSge5sz1xC6k/ekOLMblrTl7F+zYH+vzavEOwHE9fXfVFr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0542311-7f5c-45c9-1e1a-08df46491ae9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:26:30.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyE4O1225+oEbh1XwhhC5EKfM8ktGWUcntWlCl0VG2vr1S302UrB7SADPQzYbH6/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156

On 19 Nov 2026, at 8:42, Kiryl Shutsemau (Meta) wrote:

> When memory_failure() cannot split a large file folio, the folio stays in
> the page cache with the poisoned page in it. do_set_pmd() refuses to map
> such a folio with a PMD, so that the poisoned page gets its own fault and
> SIGBUS. finish_fault() then falls back to PTEs, but maps the whole folio:
>
>     do_shared_fault()
>       __do_fault()
>         PageHWPoison(vmf->page)
>           // the faulting page only
>       finish_fault()
>         do_set_pmd()
>           // backs off on has_hwpoisoned
>         set_pte_range(vmf, folio, &folio->page, folio_nr_pages(folio), ...)
>           // maps the poisoned page as well
>
> A process that touches the poisoned page takes a machine check instead
> of SIGBUS from the fault.
>
> Map a folio with a poisoned page one page at a time. The poisoned page
> then takes its own fault, which __do_fault() turns into SIGBUS.
>
> Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
> Found while reviewing Usama's fix for the swap-in side:
> https://patch.msgid.link/20261116063624.1382944-3-usama.arif@linux.dev
>
> Reproduced on a huge=always tmpfs, with a THP that vmsplice() keeps
> memory_failure() from splitting. A write fault on a good page of the
> folio maps all 512 PTEs, the poisoned page included. With the patch it
> maps the faulting page only.
>
>  mm/memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
