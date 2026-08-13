Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB078476697;
	Thu, 13 Aug 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636598; cv=fail; b=PB4MtoRFGjPRN5uqjGAxZCOTJmOwF1j60PdVthhWag5yLv1wDmm3heMut1L/o4rKQ7d8ETppn++G793Gx0p72/Iamp3/tdYmmvi44g5lKGVaTw5qbwB4PtXFiZB9SY7EV1mrEyLgYhcLfuecMGuNAVLpMzoyzLXPxQSEIg8DfW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636598; c=relaxed/simple;
	bh=vtGdiV6er6vhteePX2JioLVryMEvHP+QbY6LKN3MuxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MMBFWDgW5jFLyB/yH8pK9J7yNB5gwbQ8pg63+DNWR4+cZAjx1MnanKRdbSro2uObRdNhxttrvAAOA81nmvbjkle7UoqcCxGzhNeQHLuxtZTM4RKS8HIGU64kxuLgB+OVOW3ytpHC4oLN0oNChTZspeHHn05Z7J5vK6jZd+W/S6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dcZDxxOc; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dcZDxxOc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owaoEK4MJt+m7s24csDuvP3K9kW2OAeHeQIXeqLFyDcdEue16ff+r9M9plI0M3sPYro/byJL6+PpRNjGU6dtl6AWtcc6JpaFJi0c8sCyELx1s/XQvUtG8QZL6KtndqxioZPFPZb8S8VRSInow2wB4+UrHODZYMOLq+XF4D9XrnwXJJSPOnmqcGRb/YZAXeW2mnmp8a/y6HwgzNtfmEnTCuz3Kd6l3GWsvLLz1kQYqa9S3UMQC8RYPfhLk7iruzAmrfEZauS05NDmvc4IS6OgTF9iEC7lHPtaS/GryGvaJesgFrjMF8rDkHzVsRuxp1uCkxudMkNQgb23D3QhxPTG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcAJnCD6LP+1B6DyQFJKAYyE6SGoSnXZJ0g8CFRZTAs=;
 b=G4iY5oxMFDx5KuHjEANXeOgE+D1cjOzmpnKOh+zco9xaLcBS0ODgHQeCMb6t/z8YpNE+nL8MPOyMxVd3DYFWg1UeU5ndbeshXEg713GoH4V0TnzC1sFGLBTIGR+8/qDat39oHAghh7kjD8pz4JAo+tE+BtUtdb39zE3MRMXeEuH3m+PFMX/kxt065+kDe9CGbvtcgXPKbly0nsVG/SkdNfSLfiUJPvY1P53Vev51ygo7Fqpu8tsWTqAyJ+uv4Mwm0XoZOKQudm875EgI/ksP3+K7bxaXz7fdRd91kuZiDr2GQLO4PhZWFxlIbsiBduVtQxcNMhdc2us1S79fMuRJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcAJnCD6LP+1B6DyQFJKAYyE6SGoSnXZJ0g8CFRZTAs=;
 b=dcZDxxOcSobFfBW3+xV+bOT4MochykJh3VpeCbA1Ts/w5p9NJt8YSIC6VmPg9yfPQ6dK4FAE39yjEKC6UTyJvh7Magmr+uuUmn2ifEucxTk7lAzNQ2VmWst7gSQTDyr/5jdxSheC1X29tVzzIIbYHvq+aTnBqBBXM1r4ex/Uzco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 15:56:30 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:56:30 +0000
Date: Thu, 13 Aug 2026 11:56:21 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260813155621.GA1384528@yaz-khff2.amd.com>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-3-jason.andryuk@amd.com>
 <20260810144706.GC57095@yaz-khff2.amd.com>
 <20260812193117.GBanzKBaDLIdI_1Cfa@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812193117.GBanzKBaDLIdI_1Cfa@fat_crate.local>
X-ClientProxiedBy: SA9PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:806:a7::10) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0c2845-bbd1-4d7e-906f-08def9537046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A/TQdvtUQ2YSsMne5soQc1U8Htu2DaGbSubmr9v+U5OsDLjoDibXqJfQsl4hbCkSSmp4oMTKS20f4Sd4cHwngQRHuJdSykYvaw8q0MJHOKIO4QmXQ1+nPoy4/+/gJ8iW43VxvI6Jddp9Bt+K4bO9GMdLUbI81As7rrQjb9WJ6pH6P6zbTkRj6kARGJEJCUq4Lntqt48hbXUN3G0gr/aUH7DPJKiY+i3yEZq2+fBuCUuYljZOkGr3ArsMJSdNeVOOZAsf9IXwFmfMZ1Ms64z9UOG2PV3lG7OP9XWfmFiGACLKSwrKiBpp03qNjobU2+GPD41QaeS1tsf2I1VbLl5xfHSaEHgvl6u+Go4xN3ZjHHFzkGWtpSmjK40Qx2Dcq0b0wz2wLhu3KCPNQgs3H4CsPFZ9EsR4nl+30wqmWV5ZjEExtoOJhOgHRLJydYz5H7YEeKC8k7HdMLds42OpIJkNoK7MCh2AQCVViZzhxFUFp/Czvwdo5W4TQVosEJzvoVCJC4boI2sVTsVzOIvAchgcjVx+Bu5Yw5YykqLrOdtkVgi+XCd5/6ZZNyEgY7OKjfQMQXsFfIKVpcjjy4MV7gylOazncbOIt6JqZse5ST0+L0pZtg6l/Qst395/PVwGMxbKoB0ulnIJZN6ULppQRsxJJS4pU8Z49P531BqIyPpTkaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UEg6K/1+R7WMVFohWgLOPRfoxup/dVKhq0m6LNM6xNkSAfJBC7+Gmea0OVwW?=
 =?us-ascii?Q?ut+VynsJ4q7UkkM+2J6UncdcY3jNOwpanWf37ESq7gFaJgBAxHqD74U9WZc3?=
 =?us-ascii?Q?uq8mmrBAu68zbM/cTI5uxYX9xJhlRdwcqEs8gWbrzKjebr8AG2b7ueO3MOTY?=
 =?us-ascii?Q?Jz99HRbxGo2rzJbp/4qJJRjHdXzyG4mlbGqjUk8Z5txlLeskao/U/niKQkwW?=
 =?us-ascii?Q?9HmDhqFrFmM9UkQSCgsWQ1vaeGzl+1dn/ceqb62CjyewkRLdhpyq/t7y2mxx?=
 =?us-ascii?Q?qZfB/Lr1oCuRzR00EhcOmtp1VoZuj4j4u2VbdTmGke5v4RzzjTqzED4HkwDt?=
 =?us-ascii?Q?ptb4FQVWF6GM4AvyMD5/MRvrknVgVdjQE7l4KdRFGDCnm17BrLum3BGkj4NW?=
 =?us-ascii?Q?KbrT2KdZT/W0BC40khxuo94MINtxIE4J37uFY2ZzrYLD93uutjbz5f+yqeiC?=
 =?us-ascii?Q?ql20B/5fJapMc/hQBI1I3oLlGCdCoQbndgSWWuVG3rAuoUjwdlJtOOBenqmr?=
 =?us-ascii?Q?X8tb1o7fhcDsQpmYKN9WyOvjXpjWHFc4f+P2ScjDTJGfj2tPj6+6qZC2Zchg?=
 =?us-ascii?Q?WSBzAqHOpqhHI+kZ+Y9ulmFr/6Z5xnqE0tC4oW1rhj0dKnQAdYDnnDUnNFmN?=
 =?us-ascii?Q?BDvEsGSWraIzyUbXp7SprRbb8Hfv/V5Dop7oIvOQAP3fsElp9kRX/RvqV2Wj?=
 =?us-ascii?Q?mT0BtWF3iW2EKpfABKYKvo+EGJ7nODG6Q3Bh03I4+pLFoH3UmZwJXo9OQABH?=
 =?us-ascii?Q?gAYHvPW5/+D+ha4RJmuD36z9DAuXgLAgk//uC0Hua4wG9ECoEyDVN6w2n2UQ?=
 =?us-ascii?Q?vc2p+MuIFiJhZddVBySvuIjQoQjvS0G6aOUXHnjI1gRfNXA/oGXHnIeEHlVF?=
 =?us-ascii?Q?X/m/69ELzrVNe0w0X8vUpitY3uqGm5ow52COgydKvf8DpeV/8isyA21myEEh?=
 =?us-ascii?Q?QJffLBP1Z714SV71AevG2IO4ax5XuBRY7MQrZQprW5Kf4rZkkIeqf3a0RwiV?=
 =?us-ascii?Q?Ygv5YQwVsyfuG8JHaO4A+HxOTANUbzBOnCKxT/IahfFYz2W1+mWbB2xRZOaw?=
 =?us-ascii?Q?kHGvMe+OwNcD1SP9hoAU/MALfsDcP9E5Nr4w5AFbF/bE83uX3GCNrctipci8?=
 =?us-ascii?Q?9/nqFMxeuteLQprmjxzhCDLfBLuRle5TmrduflsamEOHDe/lGFybI6AuGCA9?=
 =?us-ascii?Q?CMshH4ckmHR0LPYpL8Nku6Orcp725v5apSjkQosgfKTw1l7MM0VT0QZMdUV8?=
 =?us-ascii?Q?Vb5kD51V9bRn6/KMuqRx1cZfuX7Ysr8DhYe2I7IS2WsGSbM7oc4fa0r+kAPu?=
 =?us-ascii?Q?tb9F+ICa/00yReEGsjgyMarHKBgmIUJRgzGXpFzGm3TPO7LjcopSoEV9pVgf?=
 =?us-ascii?Q?kMk8RUb8YUNKX/IA1bC82jhANHyfe5a41p+1SfBlVJ6iwf35nC9craGKprWW?=
 =?us-ascii?Q?iHnl60z1kcLiozE7XDms7+xFza7oWuhhjeS6VBhj+8+BahgKbRww3jJsPvBM?=
 =?us-ascii?Q?ajm1piiw29Et8+0eIa1t053khjn9gOFOXOm9czg/WeSd+75W4JZ3eplFtrL7?=
 =?us-ascii?Q?lwoGwxrm0EPwUuGUa+qw1XoOwDHXQWtgIoj/a3yBhuDzYAwd6+7gUJwbkayM?=
 =?us-ascii?Q?jB6Y248y1Lg6mD1WYvTnwguj3OoB7McVDYd1/p6IeyUcU0SFM/fly+sMQX3U?=
 =?us-ascii?Q?XaLO+cA4OLXXDyXn6wj5183PZIAZA/lTRUugdXMd7v+i5r9q6kf3LL15TTV8?=
 =?us-ascii?Q?mVEybqtMaw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c2845-bbd1-4d7e-906f-08def9537046
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:56:29.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6shPuOxrb+WHHS8jf4NlgerZ+GDgH/BrsYMroIVFWe4NQE2rkt7BUqX3uo2jduoq4mUfp1JhtnsUTWm91JUPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

On Wed, Aug 12, 2026 at 12:31:17PM -0700, Borislav Petkov wrote:
> On Mon, Aug 10, 2026 at 10:47:06AM -0400, Yazen Ghannam wrote:
> > I don't think this is necessarily a Firmware bug.
> 
> What else can it be if we're running on baremetal?
> 

Could be the hardware convention changed. Unlikely, but could happen.

Thanks,
Yazen
