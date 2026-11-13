Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794608976;
	b=KqRs4oD6tkv2hqDI/DOWZFYy/msW67UrtXetzXTzQ6RTR5E7HcOP5YkNYtvfaIaOq//s
	 kP+9OYHEgVMWk25pPubaxXfsDPs/EJ/gZTVxFSbpp6LD4Vr+XaVSXWTE3KBeV3MM2+5cf
	 cHPdu8NxPbhXfyyBZbnWKC1eXzCJKTwMzxgN8uq1yCyI/cpCfueWt/ATNJTy+mwa5Hyr4
	 owOTRCVCrxtoOfEa8gRNn9L99yf14W2ck7HVUdowTfgBDL8jnSAkJrzWf9VS9cyra+mhM
	 +hkcNfWJ//g53LvpP6ioAA8D0SSrAAUER7F4ujRqirZC1wsg9Ys5yxgPVMjpDU7qUjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608976;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=jvORmgtlar4uwzXngtnvL5lj/B9H+uZzAb+3mwCvdfE=;
	b=IEGxyzRIQ3zSjSolIJ4UTgxhVGwyn2Tw4XJebIjiY8uOyIhQZhbG+anrTALPbI1p9t3+
	 r2jPJpMQZMMUjMu+iCEKu8fBUpwh89dD0Vl4oeBMIgcHRldF1U0FmcxjVMi9BDeiqOTdK
	 96MYdSo2kYgWsr7dyDdOWQTpaBkCWw34wR27Ek4IxPhSQiiwdjfR9rUHOF+f8Kf7s6XTU
	 GLBzAVtT70gumPKHqlgy/itNhc3TphYw1Q/jUtMznA9VE9nORYEAXXfUO5cTGzoTF+5WF
	 47pchs7qMKLmndg3Kc1aGTXqaV6yf+FdQ8gCipId4HwwOByYI/0HsAEAtwzRcrdtPMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Vr/oJpzg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.14
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BD606A893;
	Fri, 13 Nov 2026 22:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E81BD606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vr/oJpzg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsHd5cBUOL+CpAQqGbF9ImjcqXmezOblJTjVdiAODmhXDi/aF0NUDfmnO0dSRh/jqueHHxC4rxUrh9/MVFmZ2qdKDBgPs4sMYT4r2O6Pv4c2+5G1HZgm+Hhu7t2928XrlMfWnTnXKwMphjWLfpuza2WxMvo62cskSupCvMPzD5ENFOr/6xecGGw/JTc4HWiKiiyLq70r3lfOz3hFbUdlZgqraq2vQNjVd29UqkuDmzkEmS78VyP8WlYBTc+94sgH3OfMxMAD6wLn+v/iSzuorS8feYUAcw+croSEMJhCd2e6nIl8VJgEKYEihIp5UdyWCWibxfocKRbAnz+qiaJGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvORmgtlar4uwzXngtnvL5lj/B9H+uZzAb+3mwCvdfE=;
 b=IGWdrYwk0nwroJKxG2ZjgTka7viuw9Hrqv6CbBUGLM7JaRE0+XJ6LnlrYNtClnv7hrG3L4fJVSA2CXY+0tHBNSvKaKoezqM19r41Pi5g46pnIc4QtyIP0hbnaoH2t7Oxgd/lnxltxkDBG+TvPOL/B41sFRKEX6PPdoZ+V4EMuU6TAUvg71bDqny2z4wAS7tA58mX/bzsAVK/j4LKpmOaRL81JhlvkhjxCK7fAyH//ntI/48tKEBTLHYJD+NDnMLH0GeZzg0rU1ypCr8uytkS8NK3b8uvwKu8gURVsMDyKFFU5yJR+VjAhKwrRYZW/ORcjj7TxNxYMVZa8QsjPlolyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvORmgtlar4uwzXngtnvL5lj/B9H+uZzAb+3mwCvdfE=;
 b=Vr/oJpzgzenuvlvTSme04HWmzVBs2fXlODb2EyUQU0w76D4v3B7MEstg5mGVt/iUqElpfp1rDr6FGxES3cI2YcNlVcdZttIBlHG9a8a1P9fZ/M7QTKzpDT4gIdpk68SnmB56F+GwDR1g93OzwKyIAODJfZ4FFdCZca8YEQGVIpfskKOUVMDTbV2YSGPmAVzZqkrtJa+VlrllcVMR6do6PUAN3pV7WDRXn+zYbifHvJt/0NwgRMfvp/M60kR94k/oflo6vYGqdUCc16IBKccqE0xFB9SclgW9VuO3/OtIPI2XYfiyEUW8oVxScI2s2yW4uCvtrBl0q/ZX3g206T0aVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 22:20:12 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 22:20:12 +0000
Date: Sat, 14 Nov 2026 09:20:07 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 07/13] mm/migrate_device: look up fault folio after a
 split
Message-ID: <aveLSEIfoHAQH5l5@parvat>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-7-50a2ed382b61@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-7-50a2ed382b61@kernel.org>
X-ClientProxiedBy: MEWPR01CA0031.ausprd01.prod.outlook.com
 (2603:10c6:220:1e5::18) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 5514ea44-3c3e-4b8e-13c4-08df41d44922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|261021123027099003|4143699003|11063799006|56012099006|261102123227099003|261022075727099003|261026140227099003|261021135927099003|261022105027099003|261021121427099003|261026121527099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 XKNiy9BmX3mIKkWmAdME40hJWHCgYxvp3dUaGgrQMHf/aDDmf6L4hDiREgMCQCDuVRf//U3Ii/ZUyYhhqEHLBrO5jSuToWArxpgirCSeafZ5B+u7Jv+vyvQzwmOfG7hN9Y6nz+scyR5BJxyo9UcNX2TK4e7U16jPWx1vmrH1lVh9MmqS2DdkgD0E4Cb1IQqmfN1MTl7tKnDDGJuaflLu+J1L5ZWdYVDKzuVZlBtprbK3vzm95/rzFmiFDnooHSLl8IpDwQOyEsa+sQjcZOKiszO4qeuzbvB3L9p49YqFpipHXqUGO0ljE8IIuCq9BcW1/+fnRfRrV7pLJyTpkoKdkDAqEEUxfzB9HfBK0yC4FG/kWZhdLgKU0PpVkJ+kAHUx9z58Bi8anxlaEgxajUAyAtgJcAPcUxiF1rUIBkG3MPAn88Crt0aQF68vtCH/cMF2JM5B8ipdbjot+xHbJTb8kkLkjcMsj2gDOV0j6abwZlJvtiByFiterad1ignow+i0xgqzRE6kr0J3RlKh//Z1hhcYCw2UtpcBBJI530YiGuxOWJpX9rNNsSfaoVNhubOitEQrjBP5bvbAXUDZZa2B1sDDh51BfjLyoW+P/ndmmlRILPQOnI/5YQaQvHL+idvMf6CMXKzq/zIw1xJKoq8QCA1vcpsa0v8Hr5IJXvY9HA8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(261021123027099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261022075727099003)(261026140227099003)(261021135927099003)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Df81hu6TOC4VORwyFVEAzr7rFo/fFNE3jawdysVAYClsR2r4usI+L2nrmL8X?=
 =?us-ascii?Q?eG3FxS4g6y8P9BbNPMhCrjcjQ/+SyflvwX7Tzd2ftH08Osgcr/58cmjtJRRz?=
 =?us-ascii?Q?tRZDiIhpqJbpE+KvRabiMq98tc9/prwEGKKBIJwiQGMyKDbzbBhsdhRJVJaR?=
 =?us-ascii?Q?ZjCqNdPG6GNUfP+0MQlMhlPDMTTK1GenRtaWVe85y50v/OnBI+xYSNjtobyf?=
 =?us-ascii?Q?47aEYbk6zBTYJD34z7JIoFHKl7T5Fvla2SnMugFZ4F8so5jOuHoV+NJVzLgB?=
 =?us-ascii?Q?gYk0RHbV2zcjqztdV/anB4deHe/NuKGzMqAO7vJaRGhE66W48bOSXiXsvlOY?=
 =?us-ascii?Q?W4wxcpOYkkr7mc1CbXKkIOkniPu4HlqTv9YHIlUp26VLBuIVdsirKnFMTkvo?=
 =?us-ascii?Q?sJBZkp100j7Jfs8NSpnqxbvnZaDaqXYQ6w71SXOUzrL2aKCkEcJ5ZbZQnsXQ?=
 =?us-ascii?Q?l+M+h94G1NATsSDfuIhlJIDLooDmCgFEx1jiP/HlQOTqx6aac2lLfLppHD4Y?=
 =?us-ascii?Q?2lfzevXAUULPE3orMagdHJq0GpmU+IIjkumbWN6zy3oaY/h7sKnP4x3l8+FH?=
 =?us-ascii?Q?IW3sw2oUAdjnHKuVEJYPb2c5ovNREE6MpxJOg7HePsWsskjERkChM1tGBuyS?=
 =?us-ascii?Q?xlanubEoYQMqhubD7tdiBrXxFjLbi0mmQk1vMIbXmQa5dIMhChwZUdJXdg1o?=
 =?us-ascii?Q?rV3B0zGn2CbJiK0JqXewFtgJXsz7SknQO/wNkT/zMPisRNVmOfSUxGaZWvea?=
 =?us-ascii?Q?FIgh6RZw5eHVL7APtkAxWGdQSyclQpAHVOTzBgpam3ffiYIQz7XIHhNnnFPJ?=
 =?us-ascii?Q?Hzj5BhL7vpXEQgx3v5G+1p3G2RQe7CijeGtG3ZaZZAgu8APqZspHE3P6VuA0?=
 =?us-ascii?Q?g0+c5Y+6lI66D6Z+Ag75LU2tMHPUZIGVI9KCaZT5tKFwiI/4mZm1yZ+6P5iB?=
 =?us-ascii?Q?AziPRxUjKJMcuz2LkxjAXddUylk2KLzBjNDHl2XeHunMsQhY+VV3AQMJgut6?=
 =?us-ascii?Q?sCQ/gXkLIscJEcssgC9IpFdRcoT6db0O8jEQE7gVRe021MEMMDelVDWtEd3U?=
 =?us-ascii?Q?N6NQ//ej708lXvg9QLq3wVFAYxt614TDK6bS7ADLipVVy+bCD88GBdq+hkl7?=
 =?us-ascii?Q?wJ99Ql56awozLhT8n7PeWgkhmDq1viCj/ruL84AQdxPOGGHpLO/2aAv7mM7o?=
 =?us-ascii?Q?uQ2jgjAKlp8xj/4eLpLoX49lt1MRgxhbfFRRX6BsMRsyTZWVhREEHq8YwgOP?=
 =?us-ascii?Q?/fOajPKtxQiuGfIa0WTZkczI0R3eCrb/zsHdYFznoyABs9CYCY9un8G5pf1f?=
 =?us-ascii?Q?PKvaTMlR+vbRlg1SLe1hn9zXulR6hIQLmiJuE3ThIZVFZ+omgq4dwR0ptoPh?=
 =?us-ascii?Q?ZW+rnpOggXHHQWOzH6ZbVis32Xb8K6YxRUxvBqN3VnDOFGlhywo2ECTLFXSy?=
 =?us-ascii?Q?NUsftCLxTcRzF0l2CpTaMP2ac67DetH22mB+9ByYbWp8G3somlGAjcLBxG4D?=
 =?us-ascii?Q?MF95JXS/O1QD5u3J3orL+m1G1QTWu9BytmPjZ+5MIYlfV12GKez5qy4lJP2I?=
 =?us-ascii?Q?/tlRj44ZCq1wMUg9HqG9jLT8ug2DU9GA84HkbBdvNeOJo+PnOVoEVH/xo5I/?=
 =?us-ascii?Q?tQsid+YFQU96aaQzstXLBi8grTfvg2YoSqWT+IILDb6PQBis7r28L7yLet1i?=
 =?us-ascii?Q?xBh/nihmzrNbD/0o6a4Hfbq7i7MUVrY0+onvECJajqybC1uAJXD2DZ9CkBMH?=
 =?us-ascii?Q?IHDOyiV04Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5514ea44-3c3e-4b8e-13c4-08df41d44922
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 22:20:12.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwuFPrcLtHkQOrwVr6lxIvd8nBhgnAq++F9osSTVEMrAeB3iZN17RbbtMt3+XovgY/ZX3qjUzxlpUxa+NbMU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
X-OriginatorOrg: Nvidia.com

On Fri, Nov 13, 2026 at 09:45:25PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> migrate_vma_collect_pmd() looks up the folio of migrate->fault_page once,
> when it is entered, at which point the folio is locked.
> 
> The fault folio is assumed not to change after this, however if
> migrate_vma_split_folio() splits a PTE-mapped large folio which contains
> the fault page, the fault page ends up in a different folio.
> 
> Resolve the issue by looking up fault_folio again after each restart of the
> walk.
> 
> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: pared down commit message ]
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/migrate_device.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index ae795fdf36f4..45e571dbfb4c 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -233,11 +233,14 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long addr = start, unmapped = 0;
>  	spinlock_t *ptl;
> -	struct folio *fault_folio = migrate->fault_page ?
> -		page_folio(migrate->fault_page) : NULL;
> +	struct folio *fault_folio;
>  	pte_t *ptep;
>  
>  again:
> +	/* The fault page is in another folio once its folio has been split */
> +	fault_folio = migrate->fault_page ?
> +		page_folio(migrate->fault_page) : NULL;
> +
>  	/* [start, addr) is collected if we get here after splitting a folio */
>  	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
>  		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);
>

migrate_vma_split_folio(), already computes the new_fault_folio and gets
the right references and lock, but does not communicate it back

Reviewed-by: Balbir Singh <balbirs@nvidia.com>


