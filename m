Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793126488;
	b=YZSFWIzn1nzjkshS9S1tKP8pDVIMQyB2dofnA1CKGi/RamPoIZfSZm94/6ai6OnCZF6W
	 fgYyAyA2cu2qcOnDIUPf8ETUEjTtaezEavEn3jpSmrcqeTsKTHcPwtPTuKM97VslnpBFX
	 QvbgIqbdCi0THS6suA9kNGpc/XRCxAjPtuQUqeUQDOe+cYpljrWXidHgfRakqCYMKCRhp
	 fxwx+ujZ/1uTTzSVnVapi2fBYxoMk8PPTotArnwNpfxB/+F9o/5w88jfw4fpJK6FIOw5m
	 05U+3gCs8SAssLJorR3N4WUo5obiC3pfQBW7b3wbfe7XrkOdXhw0uxE+c30yT98Rhbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126488;
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
	bh=J5QWZ8JpMkCYwVzLyl6FHdwstib8XNLk8KEvlpPPclM=;
	b=XwwyFsBX9GIyE/GpuVB86v9ED1MbS5kGX0wGo9pv7NKhjtISzDD6O3RMawS5feYi4SwJ
	 hRixBDpjALthMDWv4QZJ5iGc/xLVQGFpyuy+XHKDgtiPI8CAUh+ZVczSGms/3UZyYJJgE
	 x8Pp9+i0cC6PKjHJ+dUtUmgkchs98w9vCEAA5XUn6T3ktZPSlgAsIBhMywdHzbHWqGIG/
	 qV38B7kCGRJDlxe+hYJ6Dj/hyRUgkaXutskOiM3jFIA1FGKDs5dbLvxtNPLUmeL4t3CKt
	 LX0M7Mb81GUFN0w4YT7UQEh3JjeOTBOyeApYd5aFcGNrvVlymUpHsGFhIisGM2KarCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TkUA3ouZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.67
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B152606A320;
	Tue, 27 Oct 2026 18:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B152606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TkUA3ouZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMZZNT4JJqLvPfLWYREJQSYKCp4EhHBCgEWFychVZOJCVfEhX1wFdgiF/5K4BPeNas5FzSG1UMCLqmmEDX+hhRFDza1cCTKPEnFtAgwGatlGOlDgv0m5+cDNMYnblJwqXX+5LkedFjNohH8AgIHuSobAsbg54idp6/VoVV/D6KUbtDa+eaBdv6KRikIVlS9f9cNRJuDYmzRSHOAbzrC97pigU+PD7SSnc5QIkGMOgi2heVmUDciuB8VmNB/Xt6/qdxdSx5lwRTRjChvzy6MXnaxIfBhgLkRprijR98XQAevZzUic0glizTnkRaJr3LFERrFKwwdYsYxRwLoZwBpH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5QWZ8JpMkCYwVzLyl6FHdwstib8XNLk8KEvlpPPclM=;
 b=hNqUW6C+GILuuqEXYdapPoVvuF9rN3vZMRjx9SRPPwJKqB7foa2LspQ9UqgysuSK7R/aTEVHQTno3ySgXBXQINf1hjdIwuAhxpb/QDYaDUmfZNjxdlXs6LYvf8MWdmQwoJfa8Y/FHHgjxYJ6m7IvmA+c65N8rJf7JQ3ejLinYYN553PA5jG+W+VaEC1IoHLamRHX9IXVy+kjhjCxesGE5W3D9Y0Z4GoioUYcwNNwaU3jgxUsENgMHOoSa4Rm0zw4YsoZaUJG728yE74xgsFez1Gnm/Nxm17Gf+nVDmt05r46OFASvccaMEjteE34zStdS4Y0Dw9GpsZtyrDhgsp7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5QWZ8JpMkCYwVzLyl6FHdwstib8XNLk8KEvlpPPclM=;
 b=TkUA3ouZWiqj6wbIWTtmO7qSOzuHoO/xQKEKYs0e6tpS3DBtr22Zyb4epMnwhqqenGaqSTSF+SwElFSZOLZg3oV6MYbAnJb5TMtQEK2oeDuQJOtqR+hf8FfmOOGVg4AkyHL0rohSkFUOtoF/snLdf3OXiQ7pOVOw4I6HJXLhWXu32psf9OecYuvL4goZAcFwLkqWCG/sfzfAEO/lu+JnsKUCQUm7ExvUGP1vhSPjBVhPOdJHbZpaccEBb4opt5qDWKtIIMEim/QAvMjCB/PtSQhFL5RCWrSCHzjuty7Y6RNwQgQdpFKOqjIM/KxspUpiX54dKPz4ghhDOwv3/3IBlA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 18:39:49 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 18:39:49 +0000
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
Subject: Re: [PATCH 5/9] mm, page_alloc: pass zone pointer to
 trace_reclaim_retry_zone
Date: Tue, 27 Oct 2026 14:39:46 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <491924AB-6BCF-4F4B-AEBC-502B92AF528A@nvidia.com>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-5-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
 <20261027-pgalloc-ai-hotfixes-v1-5-9c7d1aca801e@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY1PR12MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: e22e1549-63ca-442f-03d6-08df3459ae37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261021123027099003|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	bx82Cw61sbBgcMQsS32pfEU3pnBf0RkDac3lT5Caz+UxqPBzTaZaaxkX2ivmdqEt+S0qweOkYYCCbLFozPLrPqNvDCACemDZqAR2YEKWkAcJlkUYNLfdQOd96lrywRNfhzApUmvneeeOvlgXmoN+lXsstIILD8pXom4hOS44Gba7DaOWq6/5BuEiHxdimxtjCaVB6hp2ZZRsGNnf1GNyztJAfgNBno+hqjWm+l+g6M//itaHdGEuxKBjm/5IT66H+FMAn/nszcRxKH/1G5W21QB0BR4zrGzUq/aP8v7YZtYQdZK+LfNvP5h8D+4+tn/lP1IQnKEoFU3MQIJyIOFY4gbNo6jhJXwRw+f7uyEJ4FH/nx17xIEuhfaLGqTMI4HchqT+yiJf5yH/07DLo+lgrlwk0SR+pqUpFIisnsS/MyXKm3IWX+a4t5WAxAZPgDEHCLOUGOoQjNZp7X+jNRFjwB/QZJl4Z18/qO09y4BC0//CVmt1X9mRMOTleWIjdOq/knJT59vA4VPLXmdV2c2jc7mYMr/o1jfdDz/3GMw+L+UWNcA65f4JOWxn949FOocBO2wyN2+O2jhT6sy9PDmLhQlBZKMT12zEIlDYJ7y5eiHf87RxP7FfroBIRIV6C3UGe72JFxeTPiFuvDs6Yw34l21xoyafp/bY+cSzkz7NLQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261021123027099003)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eDKGhNLNJ+FftO5ROtyouyMUsz/fL3930zG60tgJjuD3pyDJHCneXBHuMZeU?=
 =?us-ascii?Q?209Nie7+UiWdFiAZtUMWNFkHu0symfAoBkXMM0P4woa0gjOP9K1DJUV6Wcp7?=
 =?us-ascii?Q?EVPhYR1fs2GlzoY+JkJcIzZ+OS9o6CMdApCRXmSnuWG7609FtxzIqdsRsXX+?=
 =?us-ascii?Q?+XTwDnr/I7gj3AqCHHaNwpY3Byh/86YmaBMpaP2uZbqYl4gNGGymjGrJl4St?=
 =?us-ascii?Q?MMXgfdKVKnoQT+mG1WghO78XPz8f2h8jGVJU2rB70AF1jQmRdjEtw6Fuz4kD?=
 =?us-ascii?Q?GzqWdvKudC095REuPatwXOi/KNmtfn0iRtnvTIfIC/gfAU8XFbhwDGKzFdHz?=
 =?us-ascii?Q?7nAHCn7ligS/nFTSh+p9OKFJE9sjWZ1BCoJ6/SgKueopYQdQ40dRZgeKlYhx?=
 =?us-ascii?Q?Z+0pJNSqyskOO7JlhamrDccHM9SVx99i9McSOGw1ynQzdjdN+Jt/Bv4kRT3o?=
 =?us-ascii?Q?fwc9gocijc+Wlkku46Lpm5Uaqm6ehm7mXiL8sr5dTW+f4l8HSUHhNLNa9qHQ?=
 =?us-ascii?Q?eoF0xyRniFNXz7/tp4TXlIHTGzfifENKSoGZtHAAmCca7E/v5Q/FG7vKHBg9?=
 =?us-ascii?Q?VmVrX0vdZQy19JNYxH+PXrWqlKx8ztUmgIfOMqYhZmL62lgdBCHf18kl5r3I?=
 =?us-ascii?Q?S0GER4yXirlyqf5h0PUyp+SIixFT1vBCqpJOU1SUMwJhVqkKZeNCLYhb0lxh?=
 =?us-ascii?Q?lEphg6y292ztSLJncSZY9I6bfTjBKWpRPMge872rL0Q+33FWKhUgmCID4Ncj?=
 =?us-ascii?Q?BcdmwJAL7rv8GdxUi1UjGyk2MdIZJJ2+vgu5DlamNSvsnCcOVDZ/x1i6DgDV?=
 =?us-ascii?Q?MP2tzeZOPolLtG2HNG1bc7RmKdbdL1F2WxAdXxvFEeZtt9W3VKGwAAUWJzGI?=
 =?us-ascii?Q?nSLiMCdpa6IEcRRsgINLRRjfUK4PvOr0KfiArxyvZIiid/ssrbkUMY80UqQ3?=
 =?us-ascii?Q?GuCKmZ5cdoheHVWhwnPTelzLRj6YrVmrCwM3XcLwXNkrPTzOXfTy45yJSwRO?=
 =?us-ascii?Q?rWf0gTmiV77wCNmwsPYMR4ipizIPXP9xRFHDGOHnbnDg+IxVQvsmBMkC0Kak?=
 =?us-ascii?Q?ifteIZ/eddz8CGUL3S2XptTlLK5H91XeYVO3pUGhGUyXbd+NLLFwhs3qZhf2?=
 =?us-ascii?Q?urxcUuPsKhZp2em55rBXnvof8w1xKS86pfPfi4VB9TdTejmFVNaAdchOdgNx?=
 =?us-ascii?Q?/NvrmcPaC4Vhko0hOVMblqBD+0Yy/Phtpp3Tq2J6jWr5W+SAuclDIgBuQ+lB?=
 =?us-ascii?Q?lIkF69s42lhJW4nM+ODB9ZTDi+K2yanKnGYyxsPS5Qht1wJzCmaiVDxbNxLm?=
 =?us-ascii?Q?35tlml8TOoWEwXsYB501jm7EnoRAEbSrKzbEJ5xsf8ShCMFSLrkk7ayzPLKW?=
 =?us-ascii?Q?HzGmnwhjW0JPtC6eHykL8OoEXSjkcKa8Y61u+jgfL44pvuSzHUF3LHaoMLJ8?=
 =?us-ascii?Q?iXdKoJKNvJ6/xPN7MawWDU5DGULVIIJy29id8fd5szBCAcml6Lc97nAfXfqf?=
 =?us-ascii?Q?gRTAie2c0BXxruaUoaREr5qDl94hujesjQvsnDeaghlLlbHiXDcaHb9aNDeW?=
 =?us-ascii?Q?+aJIMZ4l+VCWxkgAzj7Cb+XuK3c3qk0gugzM0yo0ZAdv1HCcYk3VLH0mqOwb?=
 =?us-ascii?Q?GAeIO0vUvYwgyc6eMbXCEmUPk8B7jyZXMKQJGBhaV4zCD0hknVtlunTTlz5E?=
 =?us-ascii?Q?mEf/C6jm5hjh5BJqwuHVhtnqaKi6ZgTsC3RHfeX7UXmNHV787RYwnGYzq5s0?=
 =?us-ascii?Q?ZA8NasW08w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22e1549-63ca-442f-03d6-08df3459ae37
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 18:39:49.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdzuy9tjsHO17AcER+j+0okhEHNWNAkSWrM0g60dIVDacq6u/LJaEPM86J35iC8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9559

On 27 Oct 2026, at 11:46, Vlastimil Babka (SUSE) wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>
> should_reclaim_retry() walks a zonelist and passes the zoneref pointer
> to the reclaim_retry_zone tracepoint, which loads the zone from the
> entry again to find the node.
>
> Memory hotplug rebuilds the zonelists in place while allocations are
> under way. When a zone in front of the zoneref entry has become empty,
> the entries move up, and this one can be the end marker by the time the
> tracepoint looks at it. zonelist_node_idx() then dereferences a NULL
> zone. Short of that, the event can name another zone than the one its
> numbers belong to.
>
> Pass the zone pointer instead of the zoneref pointer.
>
> Fixes: d379f01de095 ("oom, trace: add oom detection tracepoints")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  include/trace/events/oom.h | 8 ++++----
>  mm/page_alloc.c            | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
Makes sense to me.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
